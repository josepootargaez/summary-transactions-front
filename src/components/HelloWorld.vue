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
        <button type="submit" class="mt-20 submit">Subir</button>
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
      errActive:false
    }
  },
  methods:{
    onSubmit(e){
      e.preventDefault()
      
     if(this.file && this.file.name){
       let extension= this.file.name.split(".");
       if(extension[1] == "csv"){
        this.sendCsv()
       }else{
         this.errActive=true;
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
    sendCsv(){
      const formData = new FormData();
      formData.append('file', this.file);
      axios
      .post(`http://localhost:8000/transaction?correo=${this.email}`,formData,{headers: { "Content-Type": "multipart/form-data" }})
      .then(response =>{
        console.log(response);
        this.errActive=false;
        this.message="Archivo subido exitosamente";
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
<style scoped>
h3 {
  margin: 40px 0 0;
}
.file-select {
  position: relative;
  display: inline-block;
}

.file-select::before {
  background-color: #5678EF;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 3px;
  content: 'Seleccionar'; /* testo por defecto */
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
}

.file-select input[type="file"] {
  opacity: 0;
  width: 200px;
  height: 32px;
  display: inline-block;
  cursor: pointer !important;
}

#src-file1::before {
  content: 'Seleccionar CSV';
  cursor:pointer;
}

.mt-10{
  margin-top: 10px;
}

.mt-20{
  margin-top: 20px;
}
*{box-sizing:border-box;}

form{
	width:350px;
	padding:16px;
	border-radius:10px;
	margin:auto;
	background-color:#ccc;
}

form label{
	width:72px;
	font-weight:bold;
	display:inline-block;
}

form input[type="text"],
form input[type="email"]{
	width:180px;
	padding:3px 10px;
	border:1px solid #f6f6f6;
	border-radius:3px;
	background-color:#f6f6f6;
	margin:8px 0;
	display:inline-block;
}


form input[type="submit"]:hover{
	cursor:pointer;
}


.error{
  color: red;
}
.success{
  color: #108310;
  font-weight: bold;
}

.submit{
  padding: 8px;
  width: 135px;
  background: #00FF00;
  border: none;
  cursor: pointer;
}
</style>
