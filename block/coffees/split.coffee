$(document).ready () ->

    $("input[name^='shell_name_']").keyup () ->
        value = $(this).val()
        id = $(this).attr "name"

        $("#" + id).text value
        $("input[name='" + id + "_hidden']").val value

    $("a[href^='shell_']").click () ->
        id = $(this).attr("href").split("_")[1]

        name = $("input[name='shell_name_"+id+"']")

        display = $(name).css "display"

        if display is "none"
            $(name).css "display", "block"
            $(name).focus()
            $(name).select()
        else
            $(name).css "display", "none"

        false

    selected = () ->
        $(":checked").attr "value"

    available = $("select[name^='before']")

    bucket = () ->
        $("select[name^='shell_"+ selected() + "']")

    changed = () ->
        id = selected()
        values = $("input[name='shell_values_"+id+"']")

        toValue = (i, child) -> $(child).val()
        compressed = $(bucket()).children().map toValue

        values.val $(compressed).toArray().join ","

    move_selected = (from, to) ->
        children = $(from).children(":selected")
        $(to).append children
        changed()

    move_to_bucket = () ->
        move_selected available, bucket()

    move_to_available = () ->
        move_selected bucket(), available

    $("input[name='move_right']").click move_to_bucket

    $("input[name='move_left']").click move_to_available

    $("#id_save").click () ->
        if available and $(available).children().length > 0
            $("#split_error").text "You must split all sections."
            false
        else if available
            value = true
            $("select[name^='shell_']").each (index, select) ->
                value = value and $(select).children().length >= 1
            value
        else
            true
