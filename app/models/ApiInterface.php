<?php
class ApiInterface
{
    public $name_table;
    
    public function __construct($name_table) {
        $this->name_table = $name_table;
    }
    
    function get($id)
    {
        global $f3, $db;
        $data = new DB\SQL\Mapper($db, $this->name_table);
        $data = (array) $data->load('id='.$id);
        $data = array_values($data)[5];
        
        $values = array();
        
        foreach($data as $key => $value){
            $values[$key] = $value["value"];
        }
        
        return array(
            'output'=>$values,
            'input'=> array('id'=>$id),
            'error'=> false
            );
        
    }
    
    function get_list($list, $maxcount = 100){
        global $f3, $db;
        $data = new DB\SQL\Mapper($db, $this->name_table);
        

        $data = $data->load();
        
        $result = $data->paginate($list,$maxcount);
        //$result = array_values($result);
        $mas = array();
        foreach($result["subset"] as $key =>$value){
            $mas[$key] = array_values((array) $value)[5];
        }
        
        $values = array();
        
        for($i = 0; $i < count($mas); ++$i) {
            foreach($mas[$i] as $key=>$value){
                $values[$i][$key] =  $value["value"];
            }
        }
        return array(
            'output'=>$values,
            'input'=> array('list'=>$list,'maxcount'=>$maxcount),
            'error'=> false
            );
        
    }
    
    function find($where){
        global $f3, $db;
        $data = new DB\SQL\Mapper($db, $this->name_table);
        
        $data = $data->load();
        $result = $data->find($where);
        
        $mas = array();
        foreach($result as $key =>$value){
            $mas[$key] = array_values((array) $value)[5];
        }
        
        $values = array();
        
        for($i = 0; $i < count($mas); ++$i) {
            foreach($mas[$i] as $key=>$value){
                $values[$i][$key] =  $value["value"];
            }
        }
        
        return array(
            'output'=>$values,
            'input'=> array('where'=>$where),
            'error'=> false
            );
    }
    
    function insert($input){
        global $f3, $db;
        $data = new DB\SQL\Mapper($db, $this->name_table);
        
        foreach($input as $key=>$val){
            $data[$key]=$val;
        }
        
        $result = $data->insert();
        
        return array(
            'output'=>$result->cast(),
            'input'=> array('input'=>$input),
            'error'=> false
            );
    }
    
    function remove($where){
        global $f3, $db;
        $data = new DB\SQL\Mapper($db, $this->name_table);
        $result = $data->erase($where);
        return array(
            'output'=>"cool delete",
            'input'=> array('where'=>$where),
            'error'=> false
            );
    }
    
    function proc($name_proc, $arr_proc){
        global $f3, $db;
        
        try
        {
             $query="CALL ".$name_proc."('".join("','",$arr_proc)."');";
             $rows = $db->exec($query);
        }
        catch(\PDOException $e)
        {
            return array(
                'input'=> array('name_proc'=>$name_proc, 'arr_proc'=>$arr_proc),
                'error'=>true,
                'output'=>$e->errorInfo,
                'query'=>$query
            );
        }
        
        return array(
                'input'=> array('name_proc'=>$name_proc, 'arr_proc'=>$arr_proc),
                'error'=>false,
                'output'=>$rows,
                'query'=>$query
            );
    }
    
    
    
    
    
    
}
?>