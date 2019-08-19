<?php
class MainController
{
    
    public function magic()
    {
        if(get_magic_quotes_gpc()) {
    	if($_GET) $_GET = array_map('stripslashes', $_GET);  
	    if($_POST) $_POST = array_map('stripslashes', $_POST);  
	    if($_COOKIE) $_COOKIE = array_map('stripslashes', $_COOKIE);
        }
    }
    
    //echo "<pre>";
    // var_dump($data);
    // echo "</pre>";
    
    
   public function simple_json_object($table, $get_id){
     $this->magic();
     $telephone = new ApiInterface($table);
     if(isset($get_id)){
     
         $data = (array) $telephone->get($get_id);
         return json_encode($data);
     }
     else{
    
         $data = (array) $telephone->get('1');
         return json_encode($data);
     }
   }
   
   public function simple_json_list($table,$get_list, $get_maxcount){
    $telephone = new ApiInterface($table);
    if(isset($get_list) && isset($get_maxcount))
    {
        $data = (array) $telephone->get_list($get_list,$get_maxcount);
        return(json_encode($data));
    }
    else if(isset($get_list)){
    
        $data = (array) $telephone->get_list($get_list);
        return(json_encode($data));
    }
    else{
        $data = (array) $telephone->get_list("1");
        return(json_encode($data));
    }
   }
   
   public function telephone(){
     $this->magic();
     echo $this->simple_json_object("view_Telephone",$_GET["id"]);
   }
   
   public function telephones(){
     $this->magic();
     echo $this->simple_json_list("view_Telephone",$_GET["list"],$GET["maxcount"]);
   
   }
   
   public function structurs(){
       $this->magic();
       echo $this->simple_json_list("view_Structur",$_GET["list"],$GET["maxcount"]);
   }
   
   public function structur(){
     $this->magic();
     echo $this->simple_json_object("view_Structur",$_GET["id"]);
   }
   
   public function substructur(){
     
     $this->magic();
     $telephone = new ApiInterface("view_Substructur");
     
     
     
     if(isset($_GET["id"])){
     
         $data = (array) $telephone->get($_GET["id"]);
     }
     else{
    
         $data = (array) $telephone->get('1');
     }
     
     $data["output"]["number"] = json_decode($data["output"]["number"]);
     echo json_encode($data);
    
   }
   
   
   
   public function substructurs(){
     $this->magic();
     $telephone = new ApiInterface("view_Substructur");
     
     $data = (array) $telephone->find(array("id_structur = ?",$_GET["id"]));
     
     foreach ($data["output"] as $key => $value)
     {
        $data["output"][$key]["number"] = json_decode($value["number"]);
     }
     
     echo json_encode($data);
   }
   
   public function search_telephone(){
     $this->magic();
     $telephone = new ApiInterface("view_Telephone");
     
     $data = $telephone->proc("search_telephone",array($_GET["query"]));
     echo json_encode($data);
   }
   
   public function search_structur(){
     $this->magic();
     $telephone = new ApiInterface("view_Structur");
     
     $data = $telephone->proc("search_structur",array($_GET["query"]));
     echo json_encode($data);
   }
   
   
   
   public function places(){
     $this->magic();
     $places = new ApiInterface("Place");
     $data = $places->find(array("endpoint = ?",1));
     echo json_encode($data);
   }
   
   public function post_structur(){
       global $f3;
     
    
    $telephone = new ApiInterface("Structur");
    
    $data=array("error"=>true,"output"=>"not method");
    if($_POST['method'] == "add"){
     $data = $telephone->insert(array(
             "id_place"=>$_POST['id_place'],
             "name"=>$_POST['name'],
             "adress"=>$_POST['adress']
         ));
    }
    
    else if($_POST['method'] == "delete"){
        $data = $telephone->remove(array("id=?",$_POST['id']));
    }
    
     echo json_encode($data);
   }
   
   public function post_telephone(){
       global $f3;
        $telephone = new ApiInterface("Telephone");
        $data=array("error"=>true,"output"=>"not method");
        
        if($_POST['method'] == "add"){
             $data = $telephone->insert(array(
                 "id_place"=>$_POST['id_place'],
                 "surname"=>$_POST['surname'],
                 "name"=>$_POST['name'],
                 "middle_name"=>$_POST['middle_name'],
                 "address"=>$_POST['address'],
                 "number_telephone"=>$_POST['number_telephone'],
             ));
        }
        else if($_POST['method'] == "delete"){
            $data = $telephone->remove(array("id=?",$_POST['id']));
        }
     
     echo json_encode($data);
   }
   
   public function post_substructur(){
        global $f3;
     
    
        $telephone = new ApiInterface("Substructur");
        $data=array("error"=>true,"output"=>"not method");
        
        if($_POST['method'] == "add"){
            $data = $telephone->insert(array(
                 "id_structur"=>$_POST['id_structur'],
                 "name"=>$_POST['name'],
                 "type"=>$_POST['type'],
                 "adress"=>$_POST['adress'],
             ));
        }
        else if($_POST['method'] == "delete"){
            $data = $telephone->remove(array("id=?",$_POST['id']));
        }
        echo json_encode($data);
   }
   
   public function post_substructur_telephone(){
        global $f3;
     
    
        $telephone = new ApiInterface("Official_telephone");
        $data=array("error"=>true,"output"=>"not method");
        
        if($_POST['method'] == "add"){
            $data = $telephone->insert(array(
                 "id_substructr"=>$_POST['id_substructr'],
                 "type"=>$_POST['type'],
                 "number"=>$_POST['number'],
             ));
        }
        else if($_POST['method'] == "delete"){
            $data = $telephone->remove(array("number=? and type=? and id_substructr=?",$_POST['number'],$_POST['type'],$_POST['id_substructr']));
        }
        echo json_encode($data);
   }
   
   
   
   
    
    
}
?>