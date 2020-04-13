Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B891A64C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgDMJnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 05:43:20 -0400
Received: from mx05.melco.co.jp ([192.218.140.145]:44831 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgDMJnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:43:20 -0400
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 43C223A41B2;
        Mon, 13 Apr 2020 18:43:17 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 4913Zs1Nj0zRkCc;
        Mon, 13 Apr 2020 18:43:17 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr05.melco.co.jp (Postfix) with ESMTP id 4913Zs14R8zRkB1;
        Mon, 13 Apr 2020 18:43:17 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 4913Zs0qm8zRk8h;
        Mon, 13 Apr 2020 18:43:17 +0900 (JST)
Received: from JPN01-OS2-obe.outbound.protection.outlook.com (unknown [104.47.92.54])
        by mf03.melco.co.jp (Postfix) with ESMTP id 4913Zs0Q9pzRjQG;
        Mon, 13 Apr 2020 18:43:17 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHa6KfzfvM+RMjUrytfSDMJi0GyZsT0LDuqX9y/hyc4UqvnEFUNXiVeo3DqnLvYynledzDIdc/4fYnhtC7rOixiZLCEm7iXDsnNNsFx1lxn6mSkX6HKaWquq33C+LqVDLKQQp/bTWXFY7WYeEJ0Q7tdXMb5J1riYkkDcjdYVvIiqxg2HYrPO1bRb7GmexmR0WULUpoK+8iL0zEGYZlzTyq4CKM+A4BX+Ei4BosmK8kTVBtai1lq4EbdArE/rww1Fyn4qOn1kYq1Yvy8NGbz4xvWszIl9mb1an5xf1g8V26LnhsaLHzv4jmZo5ryR962Jr4KZCv3OL5dphTFAKUfpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgnmufpCnzJ/I6SF/doJLgd5ZXOX4DEJoXWiwSYORsc=;
 b=P398//Uwk5LTQWmgSxiNvXXzHtP2iNlvwLuz8vsHSTeJbuAvShhohpIjIPWLWdnmiY0mQ6VyGrGUe5N8dQpy1njel3eY8yx1Y0LYvwu28t41ZzcNjBL0UUNuwAaJfmr2irOvDcNcgRvXcBQamy6UmnAc8l1ACaHfiKBI0IRMj3pNFvz5qQKeG7OMZR8oYF0nohzc5RuAPZwtjzHYv95gTKpB31B5N96lDWknNbAz3eyYK7lh5fMelkUFIM2NpV9Gskip3qu2WoT8h9R55RtcEG4X4XYJBR3ktoByRtkjzEcLYy2PzsQivVz9NNq0AAHVFwkpshO/B5+62//JIt5KwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgnmufpCnzJ/I6SF/doJLgd5ZXOX4DEJoXWiwSYORsc=;
 b=UTM0Fn2tO50bN11TdFMEZwDasTXHv7uEW3Y3ghgEsEohYslsSO+2oBrmzgiI7kX5GrvqDG0Z94qKB7QKqJElyvp8hZ6oR5kksC82+d/eOUifFhTrV2Bmdeajzfn+hjXAeBy1Cr2yPDY64HiSMNUJBrHDGcgHqviVAz73evTBNRs=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (52.133.161.22) by
 TY1PR01MB1852.jpnprd01.prod.outlook.com (52.133.164.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.19; Mon, 13 Apr 2020 09:43:16 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96%3]) with mapi id 15.20.2878.022; Mon, 13 Apr 2020
 09:43:16 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] exfat: replace 'time_ms' with 'time_10ms'
Thread-Topic: [PATCH v2] exfat: replace 'time_ms' with 'time_10ms'
Thread-Index: AQHWDXnb7kFzLdIDe0GisWVV38Nr1KhvFNoAgAenMeA=
Date:   Mon, 13 Apr 2020 09:41:22 +0000
Deferred-Delivery: Mon, 13 Apr 2020 09:43:00 +0000
Message-ID: <TY1PR01MB157894A971A781BE900C5A7590DD0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <20200408074610.35591-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200408112152.GP21484@bombadil.infradead.org>
In-Reply-To: <20200408112152.GP21484@bombadil.infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1139211b-162b-4bc6-6c27-08d7df8f1784
x-ms-traffictypediagnostic: TY1PR01MB1852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB1852A3B0D56E133AD400A46D90DD0@TY1PR01MB1852.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(136003)(366004)(396003)(376002)(4326008)(66446008)(5660300002)(86362001)(71200400001)(52536014)(64756008)(66556008)(66476007)(66946007)(109986005)(316002)(55016002)(54906003)(9686003)(76116006)(4744005)(6666004)(2906002)(478600001)(6506007)(7696005)(33656002)(8676002)(81156014)(26005)(8936002)(186003)(95630200002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8EM0RZ+Y5q2gWFmvNrbgFL+uTFi7QjxiER1VKNVG+AUUtdatzWCRchX2I+kh+u7+Z831Q1Tddm54hqP4BBHFDRjq73Z1z4Hmkl2T6ngEEjr5qGQMY/1XQ4jvPhNFsHeHKEDi8O2M53Fu40TQX0OHBIT/SELQcEp02Bvm7cMpPhFYG1l8UWEvqf4/E2ZCSlBstnHlRL0s0AEEWJWIGhVWpZjqqnJAJ2C7krtNwU0p96SQbi2qa0kvvIieGoA2o3Axt7AaKLXiE+jmu3A/Qqp+df6Z7t4gX+FOnBQ7LyNlKxvIl0RfG6EmOpFQEBVyiOY8iVmkOP/FdtiBM+Dh3r87tknikPUqiNnBKiMkM3QCSfcTrPBh4IjzyuDjKwb/p6heT/2ZSXYlSPGjKPJDwlnqUWeA4SbF8nePOirIXjIULDoxPPpp9OPfHyPwi5Lpok3A/UyArKLVwx1I8rZ7HNIpqbS9fi6T1c8Lb1SfotrmusnFy3YXZWD0X22cEu9Zi34
x-ms-exchange-antispam-messagedata: UpX2Iv3ndNO+qmcHwVt9P+yv/FnHTyQDU3eo/igacvixlw20g0K6SYjLoRsOtWbXg+Jf6oaj6MeDmChzVb11sCRY4mGpFLpJmJKEX+O94mx4OXCc9eSuKoB9rZbSq5i0mLdXADKhJZKcyuzrlBMT7A==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1139211b-162b-4bc6-6c27-08d7df8f1784
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 09:43:16.3486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YW5qVCCdY1Kx6D7mMWVh+F9X4EHPUHL6x1ZQFp0/MsIuqd8hjZhW31xPTmphOovxtzuEejIbbaMjCnrkZKQZBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1852
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Please leave at least 24 hours between sending new versions so that
> you can collect all feedback relating to your change, and we don't see
> discussion fragment between different threads.

Thanks for good advice!

> > +		ts->tv_sec +=3D (time_10ms * 10) / 1000;
> > +		ts->tv_nsec =3D (time_10ms * 10) % 1000 * NSEC_PER_MSEC;
>=20
> I find this more confusing than the original.

The parentheses were intended to group conversions into milliseconds,=20
but were not necessary from an "operator precedence" perspective.


>=20
> 		ts->tv_sec +=3D time_10ms / 100;
> 		ts->tv_nsec =3D (time_10ms % 100) * 10 * NSEC_PER_MSEC;
>=20
> is easier to understand for me, not least because I don't need to worry
> about the operator precedence between % and *.

If I use '100' for the divisor of '10ms', I find it difficult to understand=
=20
the meaning of the operation.

When using '100' for the divisor, I think cs (centi-sec) is easier to under=
stand than 10ms.
Which do you prefer, time_10ms or time_cs?


BR
---
Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
