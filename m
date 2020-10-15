Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D990E28EC7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 06:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgJOE5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 00:57:01 -0400
Received: from mx04.melco.co.jp ([192.218.140.144]:43028 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOE5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:57:01 -0400
X-Greylist: delayed 791 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 00:56:59 EDT
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 467DF3A48E0;
        Thu, 15 Oct 2020 13:43:48 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 4CBc9w1XMhzRkCP;
        Thu, 15 Oct 2020 13:43:48 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr04.melco.co.jp (Postfix) with ESMTP id 4CBc9w1CsszRjPn;
        Thu, 15 Oct 2020 13:43:48 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 4CBc9w1L6CzRkCm;
        Thu, 15 Oct 2020 13:43:48 +0900 (JST)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (unknown [104.47.93.54])
        by mf03.melco.co.jp (Postfix) with ESMTP id 4CBc9w11xQzRkBb;
        Thu, 15 Oct 2020 13:43:48 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhY+kt0GMm4MrDr9R1rmlFxStCNImrKJ4cHQyxIh9U81p6C1LRR2jkPWooSdRMq6voW8f+YmGK4aOO4+n9bLLiK8DfjHXIEVVzUSSgaWXT5gu/0nCup1gWWpCNzhoeZU574e1iQvqLNqh8GsCkuxvex6czdtkkrJQ1H6VVR5cbgzY7t157Cd+hxfWPF6uh9ElFuz4K3fuT/IsPtXgetelGJRzse7Rw1F8erCLkBb0+P8zQdyLUcuPdt0Ckfj/tr1SX3v6p+bmVaohGUouSUAHp5aguuP9AttOovyIyMXbunkZkC1+HXB4cuq8gyXfvxlN3rcLNFKmT3QJxdufwRStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbM2IrJPZam3Blb+qma3HDIyfwr1elx1q7c8cDcQAGA=;
 b=dyoQqUgQrfFQkMqsNjDuyJyDf+HhlZGfeEfeAIdgaWGrRHO7QQrr0e+IjPHaAqZro81lLHjKAumBaT9D3v+GU6vWCZy1Zi/om0wwjOU0J8iuaoRWi06eZS7JatfG7UFeT4bjuDuWB28glC57hloSRSr3UGnX/1yHHhyfdaDN9jbrwa4BpLXA3ZCggkgFVjqrDhCUtF7GYlakQ8b7Nd4ZKhGFdb3A8bT8dEePNa7ntKm8vTKgOXbTyMZYr0QP70schNeu3ljBAWC7ApLNn5pVRE04IzDGWZiSuqaBD/h+aNleJOrcB2fCWgGuDMnBK6heeUSFcKlHdQCVVq7HTMPlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbM2IrJPZam3Blb+qma3HDIyfwr1elx1q7c8cDcQAGA=;
 b=lAOQmCuILSm9H4Nlyx7FUQGhZIDn/YwL79fv96TFZNtZErM4H3tiSfmUkBQpJlGcl+Xc1OUV0OzkVuWcAmzg2ssZ2UAg2g8sMQebdCBlFHMu0W3fTlunjz3LPlrqqhHMuAHVPMTo/ADxE8o9HaBFfbjtJBHObmqMS0Br/Z4C07w=
Received: from OSBPR01MB4535.jpnprd01.prod.outlook.com (2603:1096:604:76::20)
 by OSAPR01MB4994.jpnprd01.prod.outlook.com (2603:1096:604:6f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 15 Oct
 2020 04:43:47 +0000
Received: from OSBPR01MB4535.jpnprd01.prod.outlook.com
 ([fe80::b4c1:62ac:d4ad:524e]) by OSBPR01MB4535.jpnprd01.prod.outlook.com
 ([fe80::b4c1:62ac:d4ad:524e%6]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 04:43:47 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "'kohada.t2@gmail.com'" <kohada.t2@gmail.com>
Subject: Fw: RE: [PATCH 2/3] exfat: remove useless check in exfat_move_file()
Thread-Topic: RE: [PATCH 2/3] exfat: remove useless check in exfat_move_file()
Thread-Index: AQHWoq3FaqG7VkdXm0aKU7c4KGM9uA==
Date:   Thu, 15 Oct 2020 04:43:47 +0000
Message-ID: <OSBPR01MB45353B90D542C1F91093F00B90020@OSBPR01MB4535.jpnprd01.prod.outlook.com>
References: <019b01d69d43$9dd0ba00$d9722e00$@samsung.com>,<7cdb93aa-902e-9b2a-7b42-47d2ec7af685@gmail.com>
In-Reply-To: <7cdb93aa-902e-9b2a-7b42-47d2ec7af685@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none
 header.from=dc.MitsubishiElectric.co.jp;
x-originating-ip: [121.80.0.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cb38ac8-4a30-4af2-a9ff-08d870c4e795
x-ms-traffictypediagnostic: OSAPR01MB4994:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB49942F7F231A5A869278155B90020@OSAPR01MB4994.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b98PCqEMWBZlwHnr/FopNnSDcUt9AC2AHKlXjj5BGi1hwMCo//qp9yH7XJLwh2A1RLzk0ZJ5UghA3kg/K36waXngJZN+rCPWcyc/2T6xyX5yeKUl2QZkuiIMkQapO1YzSQVd0bwp1WZbJcfn8D8Bt/qEx1tEBut+NcFz4XkDRiaKWKsn4gzCPlQ+nkeCPUWOBnw9yoNKG0PQiAG3laCrP0C6YUCZGZdrYzoFwlNyUwBPF1p7SX6Gj7Ols3i7SRj+cKiDz9iqYJeIp315D7ZrQeuQcP0anKlJhB+Mun+3ac4j8LpF1JKOCQVzKmrdRt6jrPyrgjU4vilzVQ2vNyuagBwmMEez3pcEHa2l6wtTpinpkRqqfhoD7S2lhdEujQAfE1icHLBqFocAmi3eYP38kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4535.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39860400002)(366004)(316002)(8676002)(4326008)(71200400001)(5660300002)(478600001)(2906002)(55016002)(110136005)(54906003)(8936002)(186003)(66946007)(76116006)(33656002)(6506007)(64756008)(86362001)(9686003)(83380400001)(52536014)(66446008)(66476007)(7696005)(66556008)(26005)(491001)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: S5hK1DO8E+6COWW59/tA1g9bMnaP1xS649ZasxTRIeQzfQ7rI3EF3lGeReK1WeJbci5RD230D9Rdw7E9VpUF1iU1ovfGsGSUxemjdtfU09Mmhj4erKyJyTWFP2ViyfPMF7aBIEurkDwcvgPBpWvpcDxo3H0zlchHoBafBhJdgcGVlwUauOaPcjXYcPprnyaaHUMLgRRFcGUSVnn2+Ze3qGJQDkpO7DWE9SRWag4g3/9HId1Une5i6dKwzKzpTD2Cr4OtPv3plym6UZ0VAZ1C1x8NOm+GGbg5vPxPWT2LI1RSi07QV9LTnnGU0IoUccHohYnFlhBQgooysOEgkt/tjFcMttdd4xwNbRMAluY38wtZ4fA96fnQVyF22CFDTDfc99uVl5jIFw/qmsIgEyrsbGsrIPh96CAr408miazOzFcJifnSu2O2Tb2H+bj/lFf5UFISnpRyRgRMUOzNrlpNCyWPaL7piF9PCIClXL6u3dQ2hX3DKxxkLDUvwTn8MI2Au4Fmq9XLO28WeosVWo72qIhjDPrtgP+1VgRrbf97jKZVtqrw1EfWXrLPPgffz7DIx1uHRDFNrk91IV6vAzsYWHM3lnLd+B+0OHubNUGd76EJhJGnIU0Bmfvn8i0kkzfHYh4dPjRnd9WKRRNm1g9g/A==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4535.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb38ac8-4a30-4af2-a9ff-08d870c4e795
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 04:43:47.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQ5uDoT9UD9qJCF7v7hC39Mm853lTlbGimV7FXKweJuzqQy9VKxvct83B3mJduKi53nNjIaDkHYuD6fZDBEy0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4994
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for continuing the discussion.=0A=
The reply was delayed to summarize the arguing points.=0A=
=0A=
> I already gave my comment on previous thread, and I prefer de array handl=
ing I sent instead of only two entries.=0A=
We haven't discussed enough yet and I have some questions.=0A=
I still don't understand what's technically problem.=0A=
=0A=
> It will avoid repetitive loops to get entries from cache buffer.=0A=
Is that loop the first verification and name extraction?=0A=
I don't understand why you can avoid the repetitive loop by using arrays.=
=0A=
I think getting from an array is equivalent to getting it via a function.=
=0A=
   A =3D obj->array[idx];=0A=
   B =3D get(obj, idx);=0A=
For using, what's the difference between A and B?=0A=
=0A=
> I think it is also suitable for function definition and union type  entry=
 structure.=0A=
I, too, think the combination is not bad.=0A=
However, it has no advantage compared to other methods.=0A=
(Can you give me any example?)=0A=
Also, as I said in my previous mail, union has the problem of too flexible =
for type.=0A=
(Especially file-de and stream-de are easy to confuse)=0A=
So I want to avoid to access union directly from the upper function, as pos=
sible.=0A=
=0A=
> If you send the patches included this change again, I will actively look =
into your patches.=0A=
It will take some time as I haven't come up with a good idea yet.=0A=
=0A=
We have discussed it so far, but there are still some unclear points.=0A=
First, I would like to clarify them.=0A=
=0A=
1. About the need for TYPE_NAME-validation in exfat_get_dentry_set().=0A=
My opinion is=0A=
> It is possible to correctly determine that=0A=
> "Immediately follow the Stream Extension directory entry as a consecutive=
 series"=0A=
> whether the TYPE_NAME check is implemented exfat_get_uniname_from_ext_ent=
ry() or=0A=
> exfat_get_dentry_set().=0A=
> It's functionally same, so it is also right to validate in either.=0A=
=0A=
Your opinion is=0A=
> We have not checked the problem when it is removed because it was impleme=
nted=0A=
> according to the specification from the beginning.=0A=
=0A=
I understand that you haven't thought about it yet.=0A=
What happens if I don't check here?=0A=
Please imagine if you can.=0A=
=0A=
=0A=
2. About TYPE_NAME-validation in exfat_get_uniname_from_ext_entry()=0A=
Below are the changes in '[PATCH v4 1/5] exfat: integrates dir-entry gettin=
g and validation'=0A=
> -     for (i =3D 2; i < es->num_entries; i++) {=0A=
> -             struct exfat_dentry *ep =3D exfat_get_dentry_cached(es, i);=
=0A=
> -=0A=
> -             /* end of name entry */=0A=
> -             if (exfat_get_entry_type(ep) !=3D TYPE_EXTEND)=0A=
> -                     break;=0A=
>=0A=
> +     i =3D ES_INDEX_NAME;=0A=
> +     while ((ep =3D exfat_get_validated_dentry(es, i++, TYPE_NAME))) {=
=0A=
>               exfat_extract_uni_name(ep, uniname);=0A=
>               uniname +=3D EXFAT_FILE_NAME_LEN;=0A=
>       }=0A=
=0A=
Your request for this change is=0A=
> Please find the way to access name entries like ep_file, ep_stream=0A=
> without calling exfat_get_validated_dentry().=0A=
=0A=
What is the reason(or rationale) for such a request?=0A=
Please explain what the problem is with this change, if you can.=0A=
=0A=
As I explained before, the reason for validating TYPE_NAME here is=0A=
> name-length and type validation and name-extraction should not be separat=
ed.=0A=
> These are closely related, so these should be placed physically and tempo=
rally close.=0A=
=0A=
Please explain why you shouldn't validate TYPE_NAME here.=0A=
=0A=
=0A=
3. About using exfat_get_validated_dentry() in exfat_update_dir_chksum_with=
_entry_set()=0A=
Below are the changes in '[PATCH v4 1/5] exfat: integrates dir-entry gettin=
g and validation'=0A=
>       for (i =3D 0; i < es->num_entries; i++) {=0A=
> -             ep =3D exfat_get_dentry_cached(es, i);=0A=
> +             ep =3D exfat_get_validated_dentry(es, i, TYPE_ALL);=0A=
>               chksum =3D exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,=0A=
>                                            chksum_type);=0A=
=0A=
Your request for this change is=0A=
> Ditto, You do not need to repeatedly call exfat_get_validated_dentry() fo=
r the entries=0A=
> which got from exfat_get_dentry_set().=0A=
=0A=
Even if the entry was got from exfat_get_dentry_set(), we need to get the e=
p again to calculate the checksum.=0A=
exfat_get_validated_dentry() with TYPE_ALL is the same as exfat_get_dentry_=
cached() because it allows all TYPEs.=0A=
Please elaborate on what the problem is.=0A=
=0A=
=0A=
4. About double-checking name entries as TYPE_SECONDARY and TYPE_NAME.=0A=
You said in 'RE: [PATCH v3] exfat: integrates dir-entry getting and validat=
ion'.=0A=
> your v3 patch are=0A=
> already checking the name entries as TYPE_SECONDARY. And it check them wi=
th=0A=
> TYPE_NAME again in exfat_get_uniname_from_ext_entry(). If you check TYPE_=
NAME=0A=
> with stream->name_len, We don't need to perform the loop for extracting=
=0A=
> filename from the name entries if stream->name_len or name entry is inval=
id.=0A=
=0A=
It is rare case that stream->name_len or name-entry are invalid.=0A=
Perform the loop to extract filename when stream->name_len or name-entry is=
 invalid has little effect.=0A=
What is the probrem with perform the loop for extract filename when stream-=
>name_len or name-entry are invalid?=0A=
=0A=
=0A=
5. About validate flags as argument of exfat_get_dentry_set().=0A=
You suggested=0A=
> You can add a validate flags as argument of exfat_get_dentry_set(), e.g. =
none, basic and strict.=0A=
> So as I suggested earlier, You can make it with an argument flags so that=
 we skip the validation.=0A=
=0A=
What are the advantages of skipping validation with this flag?=0A=
I don't think there's any advantage worth the complexity of the code.=0A=
=0A=
=0A=
This discussion may take some time, but I hope you continue the discussion.=
=0A=
=0A=
BR=0A=
---=0A=
Tetsuhiro Kohada <kohada.t2@gmail.com>=0A=
=0A=
