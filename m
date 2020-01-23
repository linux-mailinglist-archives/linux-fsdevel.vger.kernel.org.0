Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA29E146218
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 07:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgAWGoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 01:44:06 -0500
Received: from mx05.melco.co.jp ([192.218.140.145]:42667 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAWGoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 01:44:05 -0500
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 00AFB3A4289;
        Thu, 23 Jan 2020 15:44:03 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 483CRQ6LkrzRk1F;
        Thu, 23 Jan 2020 15:44:02 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr05.melco.co.jp (Postfix) with ESMTP id 483CRQ62QHzRk0m;
        Thu, 23 Jan 2020 15:44:02 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 483CRQ66zCzRk3x;
        Thu, 23 Jan 2020 15:44:02 +0900 (JST)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (unknown [104.47.93.56])
        by mf03.melco.co.jp (Postfix) with ESMTP id 483CRQ5nPwzRk3C;
        Thu, 23 Jan 2020 15:44:02 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGT0GrIOazlkvahbhhSjX13gi/KKqiq9ojgvv5eIZ8dUfgD2ibGw34mlaLD4YszSHrkkKOsME6KLvGtq+iOZGoXMtVaSGGqCdSRqlnxKFShpAc9RweXOk8Rq5DFLcb/QqT/vIGY7xQ1bG9TWm93vZ3ATV0ZQQrfFCgBXNes0PGhw/mVNQ0smboruHl6WQv07tj0wf+1HRkdBCZwdfeKOlXX3gnAEISpRhfhBttkpCLw+NbVFowAOV/5I+wly6tcLladOze5xgcpwKksviYzmHoaOKMUnCEOc+8zExUcydUsKlV97jiMhXm1S9R5vEp9VC1dq8Ug8D43pAUAKOOZkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22vIouoSaJD1XurebmWnctMZsH2Yy9nbsZ+t+Vwq61M=;
 b=jf1h8VtDCf8Uit0vR8JuECGY2wLXgnRJjzBkJknadJlDh38TEdrNE1IVz7jvRg3buUZf3ViHZwQmkrHWnDI+9R74O6Fum+SksqCGgHPgM8lMJvi4TXVAoRlywshsSelvQ0A4yxGhXuH2+6p3C0h1a5lJvb/+dMNrc43/6yUl1QkJrc56RSc6R1b4wHjanGkkCFtmiG/X6bqOJI3Y5Cq5WfrnTu579J7SkLmj7r8H9FhLjTX5HqKNr1hG22Jix0D8Z84BlNqLVmf6h4zv+QFK/lgLeFxhOWw8zfLxwcGxUdG3eMrNte5rPrmGo8yVzCtze1WZWGsB5zGLSxUEqv00gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22vIouoSaJD1XurebmWnctMZsH2Yy9nbsZ+t+Vwq61M=;
 b=KRpnWVEau7xJAkgdpLwM1JlyL0wmMQ5ZY4YUTx38jiG80H4RecExodLWd9EYwFlRiBals9byZyBkaWqxGzScWAVpDP5jicbVJAr94u7EKIV3iwFW9Chr/09ZO5lKfzPuYBKH+SRmE8q2uSn0O7dY3/npktoXLO9k8reqUcMN83Q=
Received: from OSAPR01MB1569.jpnprd01.prod.outlook.com (52.134.230.138) by
 OSAPR01MB3858.jpnprd01.prod.outlook.com (20.178.103.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 06:44:02 +0000
Received: from OSAPR01MB1569.jpnprd01.prod.outlook.com
 ([fe80::bc6c:d572:daca:8f1b]) by OSAPR01MB1569.jpnprd01.prod.outlook.com
 ([fe80::bc6c:d572:daca:8f1b%6]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 06:44:02 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        'Valdis Kletnieks' <valdis.kletnieks@vt.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] staging: exfat: remove fs_func struct.
Thread-Topic: [PATCH] staging: exfat: remove fs_func struct.
Thread-Index: AQHVzP7IYX4lyHjFbkaPkfH+o2iOrqf2af+AgAFosWA=
Date:   Thu, 23 Jan 2020 06:38:53 +0000
Deferred-Delivery: Thu, 23 Jan 2020 06:43:52 +0000
Message-ID: <OSAPR01MB1569F24512678DEA1C175504900F0@OSAPR01MB1569.jpnprd01.prod.outlook.com>
References: <20200117062046.20491-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200122085737.GA2511011@kroah.com>
In-Reply-To: <20200122085737.GA2511011@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3af2b68d-4140-4a27-0b06-08d79fcfa215
x-ms-traffictypediagnostic: OSAPR01MB3858:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB3858EFEF096D31441328A5C2900F0@OSAPR01MB3858.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(39860400002)(376002)(199004)(189003)(8676002)(52536014)(66556008)(66476007)(86362001)(66946007)(64756008)(2906002)(76116006)(33656002)(81156014)(4744005)(5660300002)(66446008)(316002)(81166006)(478600001)(6506007)(6916009)(9686003)(8936002)(55016002)(71200400001)(186003)(26005)(7696005)(4326008)(6666004)(54906003)(95630200002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB3858;H:OSAPR01MB1569.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChgAaa1tmqzYzDSVPdHieFWHdH1Pic/lkno75dFicEWPsSIbdGvh2OCimnGDVM3d+z7UQ+uDYj/aZDXxc+wsKxr+HjGAnvHMlJ/5u728az4SCNneSNxxsq4hwsfstslzDJ30Q5WAh7qe8bNM0410ZZ5ocPacJP//3pX1Na8U5QRChkXB33f4yRAuKB2y0V5Sce/lp/y1Sh1ax4ns4WoSa0VCIZ7g18Lh9J/Hv7PT1hszpDdLvYMJ5Do+cr3FBKoijhjvvNtVeJPkclIdTGttqbsG4tQ6Ok54G0I4te3HpTFU96CJP3uFvwW0o9eECrs9yBZuGb09/CN00LH6vzg0jU7Ukv7eMrnlxBrONUKTKdeF7A0PRoFJsYOktakM29rzLoAl+qoJxGu4INJz2y19hgQh6kt/J8xzkRNTuZMVcMdQgePTcfc2jFkylnoEgRHZTOdQ3uWt7ZohRHoFT3sf5TFZbuxL6u360XqprmDR+8Q0Gk71vTKd0iJCWKwypXDMGWy0e1E1FxiX7xKOweZyznZwBHyPSse2hPhUKCk92V4=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af2b68d-4140-4a27-0b06-08d79fcfa215
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 06:44:02.1579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /crYYsOCiKu4JpkITeWkLkOc85INIiJHdSLNKNa3id+PpQNLgDboXxvTJ/D9PHPo/eA/t+uaoaqDvVyFS1jK6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3858
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Greg.

Thank you for the quick reply.

> Also the patch does not apply to the linux-next tree at all, so I can't t=
ake it.
The patch I sent was based on the master branch of =1B$B!H=1B(Bhttps://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/=1B$B!I=1B(B
and its tag was v5.5-rc6.

> Also the patch does not apply to the linux-next tree at all, so I can't t=
ake it.  Please rebase and resend.
I will send a new patch based on the latest master branch of =1B$B!H=1B(Bht=
tps://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=1B$B!I=1B=
(B.


By the way, could you answer below questions for my sending patches in futu=
re?
1. Which repository and branch should be based when creating a new patch?
2. How do I inform you about a base on which I create a patch?

--
Best regards,
Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
