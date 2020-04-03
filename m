Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7019CE93
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 04:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbgDCCUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 22:20:08 -0400
Received: from mx05.melco.co.jp ([192.218.140.145]:33920 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbgDCCUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 22:20:08 -0400
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 2C99D3A4299;
        Fri,  3 Apr 2020 11:20:05 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 48tkD50hkvzRjNJ;
        Fri,  3 Apr 2020 11:20:05 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr05.melco.co.jp (Postfix) with ESMTP id 48tkD50LSMzRkD1;
        Fri,  3 Apr 2020 11:20:05 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 48tkD46sLBzRkCp;
        Fri,  3 Apr 2020 11:20:04 +0900 (JST)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (unknown [104.47.93.53])
        by mf03.melco.co.jp (Postfix) with ESMTP id 48tkD46ZwTzRjLW;
        Fri,  3 Apr 2020 11:20:04 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXgoj0asHBLZr9sgVsN08NS9EnRXP3PQcAbBz9xbiWCU1FpBHBVB6McH6n6SKrIDeU6mT/2/p7blLFiHCTZexWPA6EmWg+qMZ9/HjWjxZ3HOvqFejvS3aSMJzs9d29TOkBiwamlKqezkZW918R5W3x0E9AMXMtiHPUBzuecHSCfAmky18T1uXEQNnhiT81wPSJG5xXmfIPZwjycReg2yi0iZ4FRVSDkw750KQv0dnE5uREqJokDTwANNVpOqbG9o2CwhVytAVt1qQPEVNNNyb7e96EqJDi0z0l6qA1oW/jdJZBZ4emfrEfBpRHhJJ9EAblf84mgxpwWRn9IN6hXLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mLdwScS+B+bnBWlSugNwQsC31R25QzafZeaKwwEugI=;
 b=dkO+8ufG+zIcxvLIdstNrxRjSKhLvLcpD2eJuA4ZifCi5wZwUkyT0S+cTBvK2SVvJ51C6mSWLI44O/eeufQVozNHMig44lTZk8UVp+hxIIdIoQC/bci6d0yIm2QZpcKoeFdWTeQdTw8EGK23Z5LdhjMzi+ZtlScuRxyOAAc4ktB+C4DYxxzW0x7aq6mjBZKntZgyiW9eRDgHEuvt6XgInBqLHdLkuEIQNz9d/2mpAcgQ5ZbxzgpQZVrWo8wRPJloo199OSZ3dk2Jc/XETqiaUTdTFsWgVDgMlbJ4pG/kPwsj8n8ddL2HBUX/I3HcfJw07ZHYrnCWBB2fzsxeYN6Nhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mLdwScS+B+bnBWlSugNwQsC31R25QzafZeaKwwEugI=;
 b=ouYH1KjBg2GBoRprXjT4ClP0KBKKvkbb0lZ39UR+vJvDNc6zWuce6uxSrVUTft6V4sDDtRrGmWvOKZ+rktc6Okjtsfm6QKo/OFHVYHZPAjq7cI0YzSyeEGUlvELUo6B52Vc5CujQLeWWobFzoF+l334eNAXfjlIotvFP+ZzEh3U=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (52.133.161.22) by
 TY1PR01MB1803.jpnprd01.prod.outlook.com (52.133.163.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Fri, 3 Apr 2020 02:20:04 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96%3]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 02:20:04 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     "'pali@kernel.org'" <pali@kernel.org>
CC:     "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>,
        "'viro@zeniv.linux.org.uk'" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Topic: Re: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code
 points above U+FFFF
Thread-Index: AdYIzEE7tog7Qd/oTOqznEiEoChCSg==
Date:   Fri, 3 Apr 2020 02:18:15 +0000
Deferred-Delivery: Fri, 3 Apr 2020 02:20:00 +0000
Message-ID: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b8c56d9-f8af-4914-eb51-08d7d775855f
x-ms-traffictypediagnostic: TY1PR01MB1803:
x-microsoft-antispam-prvs: <TY1PR01MB180324DE235CF63556302BB790C70@TY1PR01MB1803.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(52536014)(478600001)(33656002)(8936002)(64756008)(6506007)(76116006)(2906002)(66946007)(66446008)(66476007)(26005)(66556008)(71200400001)(186003)(5660300002)(55016002)(9686003)(6916009)(54906003)(81156014)(86362001)(4744005)(8676002)(81166006)(4326008)(6666004)(7696005)(316002)(491001)(95630200002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWiV697NWfKT0Q2wApaSdN7rCngE7/ptgK4LQlp4tVgcO/yb5bO6gRCugwFVIL/moW5EUpbgab9oQUnyoyhhjCMrcpXhFFEk2Fvc+56ivLERAejlEcjZfE0pLuuQwhgdSdGb4Mo6pz8L5h4IEVI+JExc6TBX+WCr5ECVmqiXNJIlTIcZhwalyvJdvCTjM9+RkBXpuZmpo2DtndhqfC4XjSRdk5htWSsQgRS1xmyURxNkq5lug8jxaVSbFaJkJVDaqTlxDh+o3rw8YsiK/CtMhMk6/eTVZXpxFXRI8p/HwgMzXJ+/q5+znlHVIP4UPhoOBEXltyIVyuLVVHNtqJ4IfOm8ENcIlhU22Lo9r+SSxg3D2NFaoy2oEP/2Oo3PzAvnMXqZOX+fwhnvXqTsmG1WFEL1rBcyaYs1MJYd4+9ORb950AOLYTGDMtaIv153tn4SOmzQMi/0P4VRx7xlZmDclUtU8piEZcdzfMprro4f/9pz44FBM4CKeadCQq5eTwa7fQwx353d9r2377kBaZgN3Q==
x-ms-exchange-antispam-messagedata: SNBDyTF8qeBhLsY4Xrc2qK+v1SzjTzD5AJB1mI9BGpFm8ws4KBC3BWn56Iq1+0KaGO37ZbcpwJ9h388FgwwkPDiQmcoCFasBBAoE2uKgwzmmUE/iIYEPAm4Xc6ciFVIawzmU4YJgBsOdRmRMr3FPRQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8c56d9-f8af-4914-eb51-08d7d775855f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 02:20:04.4126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozX27wkIqJx6KPc/W0FwruhuZ/aPPN6qVF4o+plgsxwjTowJrg6wWKpLNaVLOWdp5gOWd1hcsNMbFiRGBPoyyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1803
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> I guess it was designed for 8bit types, not for long (64bit types) and
> I'm not sure how effective it is even for 16bit types for which it is
> already used.

In partial_name_hash (), when 8bit value or 16bit value is specified,=20
upper 8-12bits tend to be 0.

> So question is, what should we do for either 21bit number (one Unicode
> code point =3D equivalent of UTF-32) or for sequence of 16bit numbers
> (UTF-16)?

If you want to get an unbiased hash value by specifying an 8 or 16-bit valu=
e,
the hash32() function is a good choice.
ex1: Prepare by hash32 () function.
   hash =3D partial_name_hash (hash32 (val16,32), hash);
ex2: Use the hash32() function directly.
   hash + =3D hash32 (val16,32);

> partial_name_hash(unsigned long c, unsigned long prevhash)
> {
>	return (prevhash + (c << 4) + (c >> 4)) * 11;
> }

Another way may replace partial_name_hash().

	return prevhash + hash32(c,32)

