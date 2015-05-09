<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>jQuery UI Autocomplete functionality</title>
	<link href="css/jquery-ui.css" rel="stylesheet">
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui.js"></script>

	<script>
	$(function() {
		$( "#nameToFind" ).autocomplete({
			minLength: 2,
			source: function(request, response) 
			{
				var suggestions = [];
				var uriElasticsearch = "http://localhost:9200/people/person/_search";
				uriElasticsearch += "?q=name:*"+request.term+"*";
				uriElasticsearch += "&fields=_id,name,location";
				
                $.ajax({
					url: uriElasticsearch,
					dataType: 'jsonp',
					success:function(data)
					{
						var result = $.map(data, function(jsonpData) { return jsonpData; });
						var persons = result[3].hits;
						persons.forEach(function(entry) {
						    suggestions.push({
						    	"id": entry._id, 
						    	"value": entry.fields.name + "(" + entry.fields.location + ")"
						    });
						});
						response(suggestions);
					},
					error:function(jqXHR,textStatus,errorThrown)
					{
						alert("You can not send Cross Domain AJAX requests: "+errorThrown);
					}
				});
            },
            select : function(event, ui){
		        alert( ui.item.id );
		    }
		});
	});
	</script>
</head>
<body>
	<!-- HTML --> 
	<div class="ui-widget">
		<p>Who ?</p>
		<label for="nameToFind">Tags: </label>
		<input id="nameToFind" size="50">
	</div>
</body>
</html>