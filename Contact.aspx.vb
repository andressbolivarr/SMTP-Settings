Imports System.Diagnostics

Partial Class Contact
    Inherits System.Web.UI.Page

    Protected Sub BtnSend_Click(sender As Object, e As EventArgs) Handles BtnSend.Click
        'Check if user has already sent an email
        If Session("Sent") = "1" Or Not Request.Cookies.Get("SentCookie") Is Nothing Then
            'Already sent
            LblStatus.Text = "You have already sent us an email. Please allow up to 2 working days for a response. Thank you."
            LblStatus.Visible = True
            FrmEveveContact.Visible = False
            Exit Sub
        End If
        Dim Subject As String = "Eveve - Website Contact Form"
        Dim RecipientEmail As String = "tim.ryan@eveve.com;michael@eveve.com;david.manson@eveve.com"
        'Dim RecipientEmail As String = "david.manson@eveve.com"
        Dim FromEmail As String = "no-reply@eveve.com"
        Dim FromName As String = "Eveve - Website Contact Form"

        Dim Name As String = DirectCast(FrmEveveContact.FindControl("TxtName"), HtmlInputText).Value
        Dim RestName As String = DirectCast(FrmEveveContact.FindControl("TxtRestName"), HtmlInputText).Value
        Dim Email As String = DirectCast(FrmEveveContact.FindControl("TxtEmail"), HtmlInputText).Value
        Dim Phone As String = DirectCast(FrmEveveContact.FindControl("TxtPhone"), HtmlInputText).Value
        Dim Country As String = DirectCast(FrmEveveContact.FindControl("DDLCountries"), HtmlSelect).Value
        Dim FormSubject As String = DirectCast(FrmEveveContact.FindControl("TxtSubject"), HtmlInputText).Value
        Dim FormMessage As String = DirectCast(FrmEveveContact.FindControl("TxtMessage"), HtmlTextArea).Value.Replace(vbCrLf, "<br />")


        If ValidateControls(Name, RestName, Email, Phone, Country, FormSubject, FormMessage) = 1 Then
            Dim ClientMessage As String = "Details of the message:" & "<br />" & "<br />" & "Name: " & Name & "<br />" & "Restaurant Name: " & RestName & "<br />" & "Email: " & Email & "<br />" & "Phone number: " & Phone & "<br />" & "Country: " & Country & "<br />" & "Subject: " & FormSubject & "<br />" & "Message: " & FormMessage
            Dim Result As Integer = DeliverMail(Subject, RecipientEmail, FromEmail, FromName, ClientMessage)
            LblStatus.Visible = True
            FrmEveveContact.Visible = False
            If Result = 1 Then
                LblStatus.Text = "Your message has been sent!"
                Session("Sent") = "1"
                Dim SentCookie As New HttpCookie("SentCookie")
                SentCookie.Values.Add("Sent", "1")
                SentCookie.Expires = DateTime.Now.AddHours(12)
                Response.Cookies.Add(SentCookie)
            Else
                LblStatus.Text = "There was a problem sending your message, please call us or email support@eveve.com"
                Session.Remove("Sent")
                Response.Cookies.Remove("Sent")
            End If
        Else
            Exit Sub
        End If
    End Sub
    Protected Function ValidateControls(ByVal Name As String, ByVal RestName As String, ByVal Email As String, ByVal Phone As String, ByVal Country As String, ByVal Subject As String, ByVal FormMessage As String) As Integer
        If Name = "" Then
            DirectCast(FrmEveveContact.FindControl("TxtName"), HtmlInputText).Attributes("style") = "border: 1px solid red"
            Return -1
        Else
            DirectCast(FrmEveveContact.FindControl("TxtName"), HtmlInputText).Attributes("style") = ""
        End If
        If RestName = "" Then
            DirectCast(FrmEveveContact.FindControl("TxtRestName"), HtmlInputText).Attributes("style") = "border: 1px solid red"
            Return -1
        Else
            DirectCast(FrmEveveContact.FindControl("TxtRestName"), HtmlInputText).Attributes("style") = ""
        End If
        If Email = "" Then
            DirectCast(FrmEveveContact.FindControl("TxtEmail"), HtmlInputText).Attributes("style") = "border: 1px solid red"
            Return -1
        Else
            DirectCast(FrmEveveContact.FindControl("TxtEmail"), HtmlInputText).Attributes("style") = ""
        End If
        If Phone = "" Then
            DirectCast(FrmEveveContact.FindControl("TxtPhone"), HtmlInputText).Attributes("style") = "border: 1px solid red"
            Return -1
        Else
            DirectCast(FrmEveveContact.FindControl("TxtPhone"), HtmlInputText).Attributes("style") = ""
        End If
        If Country = "" Then
            DirectCast(FrmEveveContact.FindControl("DDLCountries"), HtmlSelect).Attributes("style") = "border: 1px solid red"
            Return -1
        Else
            DirectCast(FrmEveveContact.FindControl("DDLCountries"), HtmlSelect).Attributes("style") = ""
        End If
        If Subject = "" Then
            DirectCast(FrmEveveContact.FindControl("TxtSubject"), HtmlInputText).Attributes("style") = "border: 1px solid red"
            Return -1
        Else
            DirectCast(FrmEveveContact.FindControl("TxtSubject"), HtmlInputText).Attributes("style") = ""
        End If
        If FormMessage = "" Then
            DirectCast(FrmEveveContact.FindControl("TxtMessage"), HtmlTextArea).Attributes("style") = "border: 1px solid red"
            Return -1
        Else
            DirectCast(FrmEveveContact.FindControl("TxtMessage"), HtmlTextArea).Attributes("style") = ""
        End If
        Return 1
    End Function
    Protected Function DeliverMail(ByVal Subject As String, ByVal RecipientEmail As String, ByVal FromEmail As String, ByVal FromName As String, ByVal ClientMessage As String) As Integer
        Try
            'Define SMTP settings
            Dim SMTPServer As String = ""
            Dim SMTPUsername As String = ""
            Dim SMTPPassword As String = ""
            Dim Port As Integer = 465
            Dim SSL As Boolean = True

            'Construct email

            ClientMessage = ClientMessage.Replace("á", "&#225;")
            ClientMessage = ClientMessage.Replace("é", "&#233;")
            ClientMessage = ClientMessage.Replace("í", "&#237;")
            ClientMessage = ClientMessage.Replace("ó", "&#243;")
            ClientMessage = ClientMessage.Replace("ú", "&#250;")
            ClientMessage = ClientMessage.Replace("ñ", "&#241;")
            ClientMessage = ClientMessage.Replace("Ñ", "&#209;")
            ClientMessage = ClientMessage.Replace("Á", "&#193;")
            ClientMessage = ClientMessage.Replace("É", "&#201;")
            ClientMessage = ClientMessage.Replace("Í", "&#205;")
            ClientMessage = ClientMessage.Replace("Ó", "&#211;")
            ClientMessage = ClientMessage.Replace("Ú", "&#218;")
            ClientMessage = ClientMessage.Replace("¿", "&#191;")
            ClientMessage = ClientMessage.Replace("¡", "&#161;")
            ClientMessage = ClientMessage.Replace("£", "&#163;")
            ClientMessage = ClientMessage.Replace("€", "&#128;")
            'Set SMTP info
            SMTPServer = "email-smtp.eu-west-1.amazonaws.com"
            FromName = FromName
            SMTPUsername = "AKIAVP3OXN7IOQJVRTWK"
            SMTPPassword = "BPGHiw86IO73GUAFlKvSKuuaodz1JAuMCGq7Y9ODPE28"
            Port = 25
            SSL = True

            Dim message As New CDO.Message()
            Dim configuration As CDO.IConfiguration = message.Configuration
            Dim fields As ADODB.Fields = configuration.Fields

            Dim field As ADODB.Field = fields("http://schemas.microsoft.com/cdo/configuration/smtpserver")
            field.Value = SMTPServer

            field = fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport")
            field.Value = Port

            field = fields("http://schemas.microsoft.com/cdo/configuration/sendusing")
            field.Value = CDO.CdoSendUsing.cdoSendUsingPort

            field = fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")
            field.Value = CDO.CdoProtocolsAuthentication.cdoBasic

            field = fields("http://schemas.microsoft.com/cdo/configuration/sendusername")
            field.Value = SMTPUsername

            field = fields("http://schemas.microsoft.com/cdo/configuration/sendpassword")
            field.Value = SMTPPassword

            field = fields("http://schemas.microsoft.com/cdo/configuration/smtpusessl")
            field.Value = SSL.ToString()

            fields.Update()

	    If SMTPUsername = "AKIAVP3OXN7IOQJVRTWK" Then
                message.From = """" & FromName & """ <confirmations@worldwide-dining.com>"    'For AWS SES
            Else
                message.From = """" & FromName & """ <" & Trim(FromEmail) & ">"
            End If
            message.Sender = FromName
            message.[To] = RecipientEmail
            message.Subject = Subject

            message.HTMLBody = ClientMessage

            'Send email
            Try
                message.Send()
            Catch ex As Exception
                Try
                    'Attempt to resend email after 2 seconds
                    Dim Watch As New Stopwatch
                    Dim cntr As Integer = 0
                    Watch.Start()
                    Do Until Watch.ElapsedMilliseconds > 2000
                        cntr = cntr + 1
                    Loop
                    Watch.Stop()
                    message.Send()
                Catch exc As Exception
                    Return -2
                End Try
            End Try
        Catch ex As Exception
            Return -5
        End Try
        Return 1
    End Function
End Class
