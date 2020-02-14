Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAEA15D0B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 04:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgBNDqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 22:46:32 -0500
Received: from mx05.melco.co.jp ([192.218.140.145]:48485 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgBNDqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:46:32 -0500
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id D09053A40CE;
        Fri, 14 Feb 2020 12:46:29 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 48JfSP5NR6zRk0n;
        Fri, 14 Feb 2020 12:46:29 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr05.melco.co.jp (Postfix) with ESMTP id 48JfSP54CdzRjnP;
        Fri, 14 Feb 2020 12:46:29 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 48JfSP4nv9zRk7m;
        Fri, 14 Feb 2020 12:46:29 +0900 (JST)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (unknown [104.47.93.54])
        by mf03.melco.co.jp (Postfix) with ESMTP id 48JfSP4T5JzRk7k;
        Fri, 14 Feb 2020 12:46:29 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vwi7IoGVopFr9I7L6hLPJmPKDdxQfvZPnxjh06p0SXxsmhq3vyjYOmX+KfKrV60WsIaRiqWkH6WE7VDx4t3C0vmKt1jxPaz0vP9qGSFjQ9UON4/1TjbmnpRsmSL9xjtrmquf6MNGkPlUpnYA/AQBe+KdIiy7QzXBySx59x8gm5Sveh/7td0J/7JxL7O9lpIVHZbB+kQA8E3Z2VGoeKnG8zm054ZJsypou3ysNXAFoNA58IMF5MAj9Q+jkm1fzrHkr4TbJZ0ubA/l1yHmXztMT7q+VpSjo+qcJDSa2n1PZ+mdTGSEiqJXJfjWaGDUI4b4sr6Yu0nOaHoDNOP21SpOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+deLld9dKlsVmWuJZBwllpUgINlW9EIDYGavbM4QHQ=;
 b=YwmXETKue+AQdr2rGYaMf/roTuZLAXAnDNHZQ2ywva+vE/MXf4FzJSN1uricE2VP7AgcPVuOoZXYX3uY8heyiRrVgsgqCngkW9ZwKVeiub1y6JRyIkwayA70TXfOd+cNOruziWaFbtZD/bfXL9XR4T9oekSIz3B9uuI4sMewJGh1ISI+5Qt1jK69olNoLB7Gnqvb2j0pgK3ToKcwLfBIERYIwG0gkZS/ijUQ0uVPIaGNX4YwEbkWxbA6AFa6kf40g6Py+111JzzeKHi9DvHCHrzUqccCvPysdHqYD0GnGwnEWITzBSAoqC61vp1rSDSeTUzMpeA8ALkIGa2dhYFA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+deLld9dKlsVmWuJZBwllpUgINlW9EIDYGavbM4QHQ=;
 b=B595uorOcft7r3YXa6NOBZnAf1thS9WwVQDwdHOZGxAPA7Qfg4j5YenLV+FOqEcAODFBOYIDRWfTHfjbDKYwnbwyAFvbsbGHsS0l4Mn7Z9pyjhzc75dLeAibemNOf9bxn2EQyFfOjUm//wSWmjZpz3smj5UV3a0yVPCcadzziYM=
Received: from OSAPR01MB1569.jpnprd01.prod.outlook.com (52.134.230.138) by
 OSAPR01MB2770.jpnprd01.prod.outlook.com (52.134.249.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 14 Feb 2020 03:46:27 +0000
Received: from OSAPR01MB1569.jpnprd01.prod.outlook.com
 ([fe80::bc6c:d572:daca:8f1b]) by OSAPR01MB1569.jpnprd01.prod.outlook.com
 ([fe80::bc6c:d572:daca:8f1b%6]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 03:46:27 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH v2] staging: exfat: remove 'vol_type' variable.
Thread-Topic: [PATCH v2] staging: exfat: remove 'vol_type' variable.
Thread-Index: AQHV1zvwbjXKe/w93UiTyU574kgrv6gPh3YAgAqZUmA=
Date:   Fri, 14 Feb 2020 03:44:59 +0000
Deferred-Delivery: Fri, 14 Feb 2020 03:45:59 +0000
Message-ID: <OSAPR01MB15691A38EB1AD276507733D290150@OSAPR01MB1569.jpnprd01.prod.outlook.com>
References: <20200130070614.11999-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200207094252.GA537561@kroah.com>
In-Reply-To: <20200207094252.GA537561@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75d4ab6b-3f10-4c69-3546-08d7b100787b
x-ms-traffictypediagnostic: OSAPR01MB2770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB27706C95792A7AF02B176B2790150@OSAPR01MB2770.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(186003)(558084003)(86362001)(55016002)(81166006)(8676002)(81156014)(9686003)(8936002)(5660300002)(316002)(4326008)(66446008)(64756008)(52536014)(66946007)(54906003)(76116006)(7696005)(478600001)(6506007)(2906002)(6916009)(33656002)(26005)(71200400001)(66476007)(6666004)(66556008)(95630200002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB2770;H:OSAPR01MB1569.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PTxTxag8ys2nNrZEbFlg6Bn5Pl6uIq0ClhH+Ii0fXZX9B0R9HM24V0RwbCU1mQVlAJBuBC25O9iYQuznWbm8P4paUkaunWeH/XF1wdTnhMHX8WbEr3Mu0MEAc6brfDWPVD8eZHB3tciKYEtLwZkgiRs02xg8hT4i7YsXYOHGPLs87hhumymW/ApX52HVVefGvIvvvbglKOLKxC/zk8ARztc6OlE9wY1eWFjg4AGJOa/GkfD+NDWqdIdwM7Pa+f/+ImvZ82Lbdq1pZ9b4v04jje6Z6TpLXXGBilzC3rGkGtH19iO5EUf9ewhhnOZJDACVglanXgxLaevbu3gDKyXe5CZBFninuiQZO7r91tgwgthXp7A2BNQpUI2lCuVyISBhRwIt0MUOFfxXFtFaWgQyIhotvfShr+rtZGgtRhaMR0leKojv7lhPMInX9+Tul7onkMVuoOKR8w5P0VhML5fqpXUQHRNzCkUqRJdveY/BGoOSMBcyFgipDOoUDbCMJRDU
x-ms-exchange-antispam-messagedata: 3vhgTCtbiWYeNtsnz2uMEIXSz3AbhohsGVoYUhqhnaSMRZhaaeOmYph2Ja6IjIBmJDioawMSOYR2rb/xH2I/0KcdXrHXy7DJewLDWfnkvVFW4kAi3dEqQ2kZ8r1GILEAlMYrDz5xV/rbhkcMZy0JLQ==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d4ab6b-3f10-4c69-3546-08d7b100787b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 03:46:27.4362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10lUdhMJLxotAFv0ltyAFDnYpwzKdLcFf9AbShLIwMgHcaIfQn2rhq4iF6yWaNst9/r+vc+Ob6FCc7PNebuHxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2770
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Always run checkpatch on your patches :(
Oops. It is a mistake when changing to v2.
Next time I will be careful.

> I've fixed this trailing whitespace up on my own...
Thanks for fixing.
--
Best regards,
Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
