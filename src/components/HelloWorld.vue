<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
      <form @submit="onSubmit" >
       <label for="name">Formulario</label>
        <div>
          <div class="mt-10">
            <label for="name">Correo:</label>
            <input type="email" name="name" id="name" v-model="email" required>
        </div>
          <br>
        <div class="file-select" id="src-file1" >
          <input type="file" name="src-file1" aria-label="Archivo" id="file-selector" required>
        </div>
        </div>
        <button type="submit"  v-bind:class="{'loading-buttuon mt-20' : loading, 'submit mt-20': !loading}" >Subir</button>
        <p v-if="message !=''" v-bind:class="{'error' : errActive, 'success': !errActive}" >{{message}}</p>
      </form>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  data(){
    return {
      email:'',
      file:'',
      message:'',
      errActive:false,
      loading:false
    }
  },
  methods:{
    onSubmit(e){
      e.preventDefault()
      this.loading=true;
     if(this.file && this.file.name){
       let extension= this.file.name.split(".");
       if(extension[1] == "csv"){
        this.sendCsv()
       }else{
         this.errActive=true;
         this.loading=false;
         this.message="Fomato de archivo invalido";
       }
     }
    },
    async getFile(){
      const fileSelector = document.getElementById('file-selector');
      fileSelector.addEventListener('change', (event) => {
      const fileList = event.target.files;
       let file = fileList[0];
        this.file=file;
    
      });
    },
    clearForm(){
      this.email="";
      this.file="";
    },
    sendCsv(){
      const formData = new FormData();
      formData.append('file', this.file);
      axios
      .post(`http://localhost:8000/transaction?correo=${this.email}`,formData,{headers: { "Content-Type": "multipart/form-data" }})
      .then(response =>{
        if(response && response.data && response.data.success){
        this.errActive=false;
        this.message="Archivo subido exitosamente";
        this.clearForm();
        this.loading=false;
        }
      }).catch( res=>{
        this.errActive=true;
        if(res.response && res.response.status==422 && res.response.statusText){
          this.message=res.response.statusText;
        }
        this.loading=false;
      })
    }
  },
  mounted() {
      let vm=this
      vm.getFile();
    }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style  >
@import '../assets/style.css';
</style>
