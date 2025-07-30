<#
.SYNOPSIS
   The goal of this script is to Upgrade an MVC framework to dotner core app
.DESCRIPTION
   For debug details, run with: -verbose
   Parameters:
      server: 127.0.0.1
      database: DB_Local
      username: <sqlUser>
      password: <sqlpassword>
.EXAMPLE
   just run the code
#>
Clear

function Replace-Text {
    param ( $src, $dest )
    Write-Output "$src => $dest"
	$configFiles = Get-ChildItem $path *.cs* -recurse
	foreach ($file in $configFiles)
	{
		(Get-Content $file.PSPath) |
		Foreach-Object { $_ -replace $src, $dest } |
		Set-Content $file.PSPath
	}
}
function Remove-Text {
    param ( $src )
    Write-Output "$src => $dest"
	$configFiles = Get-ChildItem $path *.cs* -recurse
	foreach ($file in $configFiles)
	{
		(Get-Content $file.PSPath) |
		Foreach-Object { $_ -replace $src, $dest } |
		Set-Content $file.PSPath
	}
}

# --------------------------------------- Controllers ---------------------------------------

write-host "`n# --------------------------------------- Controllers ---------------------------------------`n"

$path = "C:\Workspace\CMS\Controllers"

Replace-Text -src "using System.Web.Mvc;" -dest "using Microsoft.AspNetCore.Mvc;`nusing Microsoft.AspNetCore.Authorization;"

Replace-Text -src "public ActionResult" -dest "public IActionResult"

Replace-Text -src "return new HttpStatusCodeResult\(200\);" -dest "return Ok();"
Replace-Text -src "return new HttpStatusCodeResult\(System.Net.HttpStatusCode.OK, msg\)" -dest "return Ok(msg);"

Replace-Text -src "HttpPostedFileBase" -dest "IFormFile"
Replace-Text -src "file.ContentLength" -dest "file.Length"

Replace-Text -src "file.InputStream" -dest "file.OpenReadStream()"
Replace-Text -src "file.SaveAs\(serverPath\);" -dest "using (var stream = new FileStream(serverPath, FileMode.Create)) { file.CopyTo(stream); };"

Replace-Text -src "Request.Cookies\[Const.USER_LOGIN_COOKIE_NAME\].Values\[0\]" -dest "User.Identity?.Name"

Replace-Text -src "return HttpNotFound" -dest "return NotFound"

Replace-Text -src "using System.Data.Entity;" -dest "using Microsoft.EntityFrameworkCore;"

# add "using Microsoft.AspNetCore.Mvc.Rendering;" for SelectListItem
Replace-Text -src "//# using" -dest "using"

# remove
Remove-Text -src "^\s+\[ValidateInput\(false\)\]"
Remove-Text -src "HtmlHelper.ClientValidationEnabled = false;"
Remove-Text -src ", JsonRequestBehavior.AllowGet"
Remove-Text -src "^\s+var unobtrusiveJavaScriptEnabled = HtmlHelper.UnobtrusiveJavaScriptEnabled;"


# insert using Microsoft.AspNetCore.Mvc.Rendering;
# C:\Workspace\CMS\Classes\ExportTypeHelper.cs
# C:\Workspace\CMS\Classes\ListConverter.cs
# C:\Workspace\CMS\Classes\ListConverter.cs


# --------------------------------------- Views ---------------------------------------
write-host "`n# --------------------------------------- Views ---------------------------------------`n"

$path = "C:\Workspace\CMS\Views"

# Remove-Text -src "@using Microsoft.Ajax.Utilities"

Replace-Text -src "@Html.Partial\(" -dest "@await Html.PartialAsync("

Replace-Text -src '@Styles.Render\("~/Content/bootstrap-styles"\)' '@await RenderSectionAsync("pageStyles", required: false)'

Remove-Text -src "^@using Microsoft.Ajax.Utilities"

# later we need to find a way to get the URL
Replace-Text -src "HttpContext.Current.Request.Url" -dest "@ViewBag.url"

Remove-Text -src "var unobtrusiveJavaScriptEnabled = HtmlHelper.UnobtrusiveJavaScriptEnabled;"
Remove-Text -src "^\s+HtmlHelper.UnobtrusiveJavaScriptEnabled = unobtrusiveJavaScriptEnabled;"

