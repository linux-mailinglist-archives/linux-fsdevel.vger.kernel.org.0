Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C3A1607E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 02:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgBQBzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 20:55:24 -0500
Received: from mx05.melco.co.jp ([192.218.140.145]:59186 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBQBzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:55:24 -0500
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 85F303A2B08;
        Mon, 17 Feb 2020 10:55:22 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 48LRrp2xZyzRkBj;
        Mon, 17 Feb 2020 10:55:22 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr05.melco.co.jp (Postfix) with ESMTP id 48LRrp2dVzzRk3D;
        Mon, 17 Feb 2020 10:55:22 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 48LRrp2fpRzRk9w;
        Mon, 17 Feb 2020 10:55:22 +0900 (JST)
Received: from JPN01-OS2-obe.outbound.protection.outlook.com (unknown [104.47.92.50])
        by mf04.melco.co.jp (Postfix) with ESMTP id 48LRrp29fnzRkBK;
        Mon, 17 Feb 2020 10:55:22 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6w0cP+WRCzMVna60X2e3r71uQjtLr7O4gbEp8ldaWIKxve6ANOVGpcOzFWmjWFCatvAFnOzzvxZSnnn36vZtPEGRzwogQmcqvA/3ugxKdDjmOHprFvGP25N0L29zzc0sFCBibDZtlmmLAk6DegrlQYB7kyikz5wFeIfvqRO0ZjNOgN0QNuYL0Bp/3E/y06fXy4D3aoSkA8G41qaMogRQs/AD/QKny27VGmpBHhuy5IWF7IuVt4eYqqbkNaSLzjaGdx5G4LWAZlVpwRHoLVfeOCrssDJKpboiGA4RyiaGQLLlDvgKrVZNWc8xSmZiuwHC2z0cf0GIxwdyVQWn6AfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/0Va6Y5vbElOQECQb5B9Kh1bpbXR4t682vZZKVvXoc=;
 b=khabfELbbcOR4Q8g7MQlBT3Juv+Po01LTurc2A9PfXDKqH+QA69XCfL2pyZOQNmNEi0bLqcg+6nMBRNy1DEsI46hHY8nBloKiJn0nYoB3oCWU/ytYX7GQTUsvUIt5Db9OKjyOrNzRejNAX20uf5fmhWbzGBUSe4V4fowXW4uDJvAkBWQ+bthDSUzQt8OwRJEL+Pqc27l5XceHpzuEyycJX1pPyhnMJRVuC/LWNDXxGFxtONJAfJxS0SmaQpe5enQVryJIYqTnAW0jgwY6+R7PGxKQeInWw+wuH9Lu75X/YsMA0iVjitmvJGvPBFIcYDVO2h1l5gP2N4QzLVU5HnX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/0Va6Y5vbElOQECQb5B9Kh1bpbXR4t682vZZKVvXoc=;
 b=K0OvCWnpSIJJJo8zmX4VphT+ehuiSvypurtNtUSLBg1Z4Tj1YxnhzFbwU08YeExmQHJpVCxiBn/3XCpUo2nEqyfXrdRyq7rMH30H91tImrj55DPKeuxz8F/XH3qG1iw3mBH2e8r5cZffcaQ2IawriBN1rzCv1r5aZwZQMdGHruE=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (52.133.161.22) by
 TY1PR01MB1595.jpnprd01.prod.outlook.com (52.133.162.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Mon, 17 Feb 2020 01:55:21 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::1cea:e753:3a3b:8e1b]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::1cea:e753:3a3b:8e1b%7]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 01:55:21 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>
Subject: RE: [PATCH v2 1/2] staging: exfat: remove DOSNAMEs.
Thread-Topic: [PATCH v2 1/2] staging: exfat: remove DOSNAMEs.
Thread-Index: AQHV4udJFqNx/CzTgECwKnDOEdxsgqga3uMAgAPDczA=
Date:   Mon, 17 Feb 2020 01:54:07 +0000
Deferred-Delivery: Mon, 17 Feb 2020 01:55:06 +0000
Message-ID: <TY1PR01MB1578EA0B95FE3C29D0F9A64190160@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <20200214033140.72339-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200214161810.GA3964830@kroah.com>
In-Reply-To: <20200214161810.GA3964830@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65551ed3-38f0-421d-ea56-08d7b34c72a4
x-ms-traffictypediagnostic: TY1PR01MB1595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB15957267285B79678107B54E90160@TY1PR01MB1595.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(64756008)(66476007)(66556008)(7696005)(8676002)(66446008)(558084003)(478600001)(33656002)(8936002)(54906003)(5660300002)(186003)(76116006)(81156014)(81166006)(66946007)(52536014)(316002)(4326008)(6506007)(9686003)(6916009)(2906002)(71200400001)(55016002)(26005)(6666004)(86362001)(107886003)(95630200002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1595;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEFhtxwV4ouI5PI00pVDpdYiM0b2S2CGHSm1VXAxZlPVZ9KDnHCIHB/BF4H0SOLs2sNhJ8bDzYrs3N9DaNIgLr54NZycAcRJmE4TD4PbUFIXCyJKkOzsERQ6vJ3MZUGuxJVAKs3cxY7pkJ8oKSDJ8ROEhoeFXrNyJ2xJAmpUw7mslVZKtL2aWpRmwt50nrmI5ETYRtxPNpXGI6G0/tQwsD4WRVxtXJFWMjPhDC8BK95assrtA2zp6XjxT5x0RrZ7mqhQOSIVH4WZ+BoS0HGxX/HuGFiwwrqjyaiChv0HSFkZKmPj35We35t/7lMd+N1IQsgIQzSFmyzZv1XBI6smEQgtuAyl36tJwKXyTA9fCdCyyYiJeGpHjpZThLa+Hkx+yD0u2L+PKu7gdQw7Igs1wCKETpeqXaShvyLWN6Fe3ovnFH2g/CQSrPmZMaI7vs2ycOS7ZVfzGLUCqMBaObKhC5nHBW7uW3+yXD7XnRlIb+QSQcYM9AR3dX2JtugSj2DG
x-ms-exchange-antispam-messagedata: AX9PGy5Wo65VUV/ps4mZab59qaYaomhWsgPFS9Ebj2zV/Hhdt0dWryOL8X+SKk3o0oZ6edhFGytAOHx+eFQm3xi66VnWbKvJQGKKMNcQg4pMyIDL1d6LbVFZ6MGNPkLKRf6DluoPjA3NKFgG6+TGHw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 65551ed3-38f0-421d-ea56-08d7b34c72a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 01:55:21.7741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vpXUzu30QOxEfbXz3EZqTLSFUccsV7c3uSKvXIusmE4eaWQQj9gXO35OZa1fGDIflSL5ZAXAtcrmP5a1o77nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1595
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I think you might need to rebase again, this patch doesn't apply at all t=
o my tree :(

Thanks for your comments.
I'll try to rebase with 'staging-next' branch.
Is this correct?

--
Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
