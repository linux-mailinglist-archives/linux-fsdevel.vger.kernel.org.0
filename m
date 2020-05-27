Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62551E3B2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 10:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgE0IAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 04:00:47 -0400
Received: from mx05.melco.co.jp ([192.218.140.145]:42642 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgE0IAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 04:00:45 -0400
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 41A093A36E3;
        Wed, 27 May 2020 17:00:43 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 49X3DC1cTDzRjj5;
        Wed, 27 May 2020 17:00:43 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr05.melco.co.jp (Postfix) with ESMTP id 49X3DC1JQwzRjc2;
        Wed, 27 May 2020 17:00:43 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 49X3DC1Ls3zRjgb;
        Wed, 27 May 2020 17:00:43 +0900 (JST)
Received: from JPN01-OS2-obe.outbound.protection.outlook.com (unknown [104.47.92.54])
        by mf04.melco.co.jp (Postfix) with ESMTP id 49X3DC0tR2zRjgC;
        Wed, 27 May 2020 17:00:43 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJItMsmHfCUkR4VU6zZdOIiJYULIcMntiOJqfJKc1qHBmOnvgN/EbtgOpRrh4F5HdfKxW3ZewAARaCRCGWXDQ4ZNis+5pxz6x7icNzwJ8fpTLFgnWKn8b+/aveo/KpATu8jtbNrTLquNg/YNZgZb87MemJVMwAayfF8DMPcCUW+CkTsCPKv/9hlPSvXG0PaCxLP+0y3Kib/EA9jrBQNxFMzwsEp9o6YX+jnxPBWkIFPE4Hiw67QD1vdywWLS6Qm6jMavdbr1xq8u6wcWKLCUDgMXjie5xBz9GWw54lfy1aQbOgtdAhg75jVPUlc9kpenmmXkP8RiKN/ZuaQenyZ7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fh1E16n69S8mOdmJiQaSjQ3Vuk8MkDHAeJtZ90lLkw=;
 b=VMr90LJJEWPCU8+PdvIC5+FRhnm7jb/c/tcOWded+PDNJRiRJsy7XdmR6eLiRDKQVRkPHTwSi/noxk4Yqm3KExwQps98EjiFlVxWH5Yp5c5XevpAHcZY/LSrrRJ/5E8urJs4Lzhscvykvdr6X6cHBAMjf4zWxLUHt+1WGDCmeKomz4+ewgKr64uKxJymdMltmewolcfWOwR8uX7wm0m3nAzleBJyn3L15kBlGQ7PRfx+iELz6+Qc9y+Apmo4ZaSTOl9kL6AsEJamXkbq3H0YDshSxWil2O1nolSBE1f7r4wsxKUOFoJ4cFa26EL2Q2P1WBpQOLxNNrMDUsq6iiDZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fh1E16n69S8mOdmJiQaSjQ3Vuk8MkDHAeJtZ90lLkw=;
 b=LiAWo4wsY5aYliJaUbP9Hady7iXG0Yzw8GHshdaeRBLPKFGlPM9TG3+njrB62y5rQ48zRPFiR67xMppm3IQpCPN4CKGsk2sIkCLqqVfYuemGPi5hlcuqSBOL57Fw2DxxZy2mNkdeoA+m9ta+F8QsOsBj53t4798TJeIfrj6HJpo=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by TY1PR01MB1706.jpnprd01.prod.outlook.com (2603:1096:403:1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 08:00:40 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::1d6f:af96:18c1:ebe5]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::1d6f:af96:18c1:ebe5%5]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 08:00:40 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Sungjong Seo <sj1557.seo@samsung.com>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'kohada.t2@gmail.com'" <kohada.t2@gmail.com>
Subject: Re: [PATCH] exfat: optimize dir-cache
Thread-Topic: [PATCH] exfat: optimize dir-cache
Thread-Index: AQHWLnxBxF+oxKbhEk+7qJPOsurCbai5sAsAgAHreCI=
Date:   Wed, 27 May 2020 08:00:40 +0000
Message-ID: <TY1PR01MB15784E70CEACDA05F688AE6790B10@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <CGME20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61@epcas1p2.samsung.com>
        <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,<055a01d63306$82b13440$88139cc0$@samsung.com>
In-Reply-To: <055a01d63306$82b13440$88139cc0$@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none
 header.from=dc.MitsubishiElectric.co.jp;
x-originating-ip: [125.196.131.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04d5cf0d-2674-4d08-3b66-08d802140ca8
x-ms-traffictypediagnostic: TY1PR01MB1706:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB1706FE32035F37D9808831A590B10@TY1PR01MB1706.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0WaahiTBWxTj3oBHGmzFZJU6Y3x8NVyzbMf3kQzzX9ZoSTnN+OWY1PKTscqC1FUjVhx4aFOaLyTUpxhf78zZRDWFkqNvuNcK8ywEG2OaXVJcQQFfAgUddc5dSWqJHqA5lvO9liddmm2H/mjaCFf4kJNPJZrBu9QsHYU2TSMXxW7A6Ak42WMhpuXKP+Pphv8O2FZAJMTeIGZgTQsEZ2/oQIu4JRWJCHeByXyVtu9/+QJ8O5yNg8FH785Dr/mRnf1MRaVTuNCaJ/cz1wTnNxRSlhBFu97q8PPpWGjLD52wGWpO1B3tK2EAXZcjtfsn/XIOhuf4No+mmbo5i0xm8AnXzXet0y9gLhgcw5odXWqmkQ2gQfuTKEAz/v0r9RBU9Yf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(366004)(396003)(39860400002)(346002)(9686003)(66556008)(66446008)(478600001)(6506007)(2906002)(54906003)(64756008)(66476007)(86362001)(8936002)(52536014)(4326008)(66946007)(76116006)(186003)(91956017)(6916009)(55016002)(5660300002)(71200400001)(316002)(33656002)(8676002)(26005)(83380400001)(7696005)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zAM82FCnRgIqKOFY4ISVeivGiVCMqKe7Ps0GG04Dl4bm8OyNePhhm7ag23jcRlRQm3oixyEeTVVwUjZo4gblMUfciB4uKLf36IBrmRDzqWv//7CAq+t4GYBBemWZ8VkG/KL+H+/Y516xsgQb/JUwddIEDebDQKUK+grKmjj4xfTWebulKxJjk7LFZ3gwUqsyl8Efk+waVPvH6GgHsGSQhm88r6U0xIA4/YAmCzMdNKNoVsl7oBFXH72XBt8oXlzlSSYyglcchnkZmC4FXhfrVGIvII0ENQfG+sBa0U/P9YFczFm0RTJDQ9KVfE2uZZVnmz2rzL3N8G/ulEj/inMHSj+hdJAWx/uecztUov0hHBqfmU/ftZWAFYF9NaO80fycKqlP+hhMCIQTVN7eE7golO0vloHuh1iG+Z92GmZ/Yjxs/TaoENrCIZcnY/6TYO7VCvnDZPpo8S3E6WRbN7HxI3nrCGPmhqQeo+6+g9dan0tMygM+4kzZ19+N4/z+SiqB
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d5cf0d-2674-4d08-3b66-08d802140ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 08:00:40.6819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPnLxbzWWy97W3uMEymJMOHr/wauVJzBjMsIB+GaBjQWzncknXQwboHiRh/mDRQ7H8ndnbXLGKogMIpaNwOj8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1706
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for your comment.=0A=
=0A=
 >> +    for (i =3D 0; i < es->num_bh; i++) {=0A=
 >> +            if (es->modified)=0A=
 >> +                    exfat_update_bh(es->sb, es->bh[i], sync);=0A=
 >=0A=
 > Overall, it looks good to me.=0A=
 > However, if "sync" is set, it looks better to return the result of exfat=
_update_bh().=0A=
 > Of course, a tiny modification for exfat_update_bh() is also required.=
=0A=
=0A=
 I thought the same, while creating this patch.=0A=
 However this patch has changed a lot and I didn't add any new error checki=
ng.=0A=
 (So, the same behavior will occur even if an error occurs)=0A=
=0A=
 >> +struct exfat_dentry *exfat_get_dentry_cached(=0A=
 >> +    struct exfat_entry_set_cache *es, int num) {=0A=
 >> +    int off =3D es->start_off + num * DENTRY_SIZE;=0A=
 >> +    struct buffer_head *bh =3D es->bh[EXFAT_B_TO_BLK(off, es->sb)];=0A=
 >> +    char *p =3D bh->b_data + EXFAT_BLK_OFFSET(off, es->sb);=0A=
 >=0A=
 > In order to prevent illegal accesses to bh and dentries, it would be bet=
ter to check validation for num and bh.=0A=
=0A=
 There is no new error checking for same reason as above.=0A=
=0A=
 I'll try to add error checking to this v2 patch.=0A=
 Or is it better to add error checking in another patch?=0A=
=0A=
BR=0A=
---=0A=
Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>=
