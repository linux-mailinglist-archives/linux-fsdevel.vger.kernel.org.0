Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FEEB3B12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbfIPNPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 09:15:05 -0400
Received: from correo.registraduria.gov.co ([201.232.123.13]:59532 "EHLO
        registraduria.gov.co" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728042AbfIPNPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:15:05 -0400
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 09:15:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=registraduria.gov.co; s=registraduria.gov.co; c=relaxed/simple;
        q=dns/txt; i=@registraduria.gov.co; t=1568638632; x=1571230632;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KvFaQjy6O7n1myS076/dDSqoTFY5YkAG9QOAmI7oOqE=;
        b=BqgtUcCxcOoqoUlJKopVIxMPRlXyvuJmyVEeClYOG7GJmq++0JNwOazopUvLS52D
        seCEMamIz14LX2fgQqVm04+5OPx/FUyqfQXY7hF1sZgQmJbUbA4BBCNh8p2uycOk
        bbMvYoR3JIRjC0EzvAWNrXUdh/phYorFgqreGNjIUsQ=;
X-AuditID: c0a8e818-52fff7000001bab9-53-5d7f86a8cbee
Received: from RNEC-MSG-00.registraduria.gov.co (Unknown_Domain [172.20.60.177])
        by registraduria.gov.co (Symantec Messaging Gateway) with SMTP id 64.37.47801.8A68F7D5; Mon, 16 Sep 2019 07:57:12 -0500 (-05)
Received: from RNEC-MSG-00.registraduria.gov.co (172.20.60.177) by
 RNEC-MSG-00.registraduria.gov.co (172.20.60.177) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 16 Sep 2019 07:58:31 -0500
Received: from RNEC-MSG-00.registraduria.gov.co ([fe80::2c92:7fcd:a2d3:3ac5])
 by RNEC-MSG-00.registraduria.gov.co ([fe80::2c92:7fcd:a2d3:3ac5%20]) with
 mapi id 15.00.1395.000; Mon, 16 Sep 2019 07:58:31 -0500
From:   Registraduria Municipal Caramanta - Antioquia 
        <CaramantaAntioquia@registraduria.gov.co>
To:     "NO-REPLY@MICROSOFT.NET" <NO-REPLY@MICROSOFT.NET>
Subject: =?iso-8859-1?Q?Se_non_verifichi_il_tuo_account_entro_le_prossime_24_ore,_?=
 =?iso-8859-1?Q?il_tuo_account_verr=E0_sospeso.?=
Thread-Topic: =?iso-8859-1?Q?Se_non_verifichi_il_tuo_account_entro_le_prossime_24_ore,_?=
 =?iso-8859-1?Q?il_tuo_account_verr=E0_sospeso.?=
Thread-Index: AQHVbIxGwrV5varixU6kFz/B17jUgg==
Date:   Mon, 16 Sep 2019 12:58:30 +0000
Message-ID: <1568667559759.4076@registraduria.gov.co>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.5.43]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: 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
        EF0HAAA=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
























































































































































































































































































































































































Aggiorna il tuo account

Il nostro record indica che il tuo account non =E8 stato aggiornato, il che=
 potrebbe comportare la chiusura del tuo account. Se non aggiorni il tuo ac=
count, non sarai pi=F9 in grado di inviare e ricevere e-mail e ti verr=E0 n=
egato l'accesso a molte delle nostre ultime conversazioni, contatti e alleg=
ati migliorati.

Prenditi un minuto per aggiornare il tuo account per un'esperienza di maili=
ng pi=F9 rapida e completa.

Fai cl<http://hfnfgewf.000webhostapp.com/>ic qui per aggiornare il tuo <htt=
p://jhgewads.000webhostapp.com/> account?

Nota: il mancato aggiornamento della propria casella di posta comporter=E0 =
la cancellazione permanente del proprio account.

Grazie molto,
Il team di sicurezza

Copyright =A9 2019 Webmail .Inc. Tutti i diritti riservati.

















































?



Confidencialidad: La informaci=F3n contenida en este mensaje de e-mail y su=
s anexos, es confidencial y est=E1 reservada para el destinatario =FAnicame=
nte. Si usted no es el destinatario o un empleado o agente responsable de e=
nviar este mensaje al destinatario final, se le notifica que no est=E1 auto=
rizado para revisar, retransmitir, imprimir, copiar, usar o distribuir este=
 e-mail o sus anexos. Si usted ha recibido este e-mail por error, por favor=
 comun=EDquelo inmediatamente v=EDa e-mail al remitente y tenga la amabilid=
ad de borrarlo de su computadora o cualquier otro banco de datos. Muchas gr=
acias.

Confidentiality Notice: The information contained in this email message, in=
cluding any attachment, is confidential and is intended only for the person=
 or entity to which it is addressed. If you are neither the intended recipi=
ent nor the employee or agent responsible for delivering this message to th=
e intended recipient, you are hereby notified that you may not review, retr=
ansmit, convert to hard copy, copy, use or distribute this email message or=
 any attachments to it. If you have received this email in error, please co=
ntact the sender immediately and delete this message from any computer or o=
ther data bank. Thank you.
