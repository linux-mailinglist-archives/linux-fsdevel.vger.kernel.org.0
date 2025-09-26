Return-Path: <linux-fsdevel+bounces-62850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71058BA259F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 05:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245F94C49CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 03:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54526CE2C;
	Fri, 26 Sep 2025 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="hE271fNf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD272633
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758858718; cv=fail; b=fHohq2F5IKODwz/oOM8XiTqFP1Ps5Dh9x0NM0MU4KO9yqT2mouaTBR0urj7NxYtDOAwK9yb+DxKtvcS+7ZJd4tUyU420RQ5i6kD4YBlM7OMHolM1dkbE9SgCiz5I11FL3T+zyrWJZOK29bPE8zsDjnAZOjySWKe/hZrvQHjSr6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758858718; c=relaxed/simple;
	bh=XaFVy6J0+5ym+3ThjYHqz1euWWpp4cOhHxv5OO3hiLc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MnGCcYZhV65og2qK/RIaW+tDlC4qzatV/lc51Qe2hyHUtafSXAluEkI/lfQcsnFR9Rgve987AtYuGGCElv9FFqf+Kt3fkLRcTcvCapJqeq5UGJ36gbUGkeqNXNm/BU8a+olp7n02OBO0TnsmXsZIkK82PVoGR3jAd66e00DEihA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=hE271fNf; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PMmSKq012061;
	Fri, 26 Sep 2025 03:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=XWmhpQw0iip3GRU8klbFGulRom0zz
	HcctiRJW82wC1k=; b=hE271fNfKpeKpM0RTjdMbOjp95ALl8TxTOTY/sX+F9jLm
	Jdkt/T31KCMbnbS5IHjtjCRekMyMiPfkdEtXIFmpvNCQvtpFsBVBih9EQIk8HQML
	UjVgwOvqzULUL1gebXeW9x6nqamHpWTxAUVW9A+JC2EPgYxvlvhxfVfmfU41siTw
	U31zkq89IGn2nvWZ6DLb2xlPX8+9oowTMtr7QO7MAKAvpXUdndSzQ98+ERAivkZV
	hfY4wQ/t26bkr8DWMeT6efxnxCFSPjvs10KWQ0VUzznLmllVNl29SRmqlCSPFb6q
	sZybovxz0QGtbQSBZlr+MQoucpSO0rgF3YRNiTxNg==
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012062.outbound.protection.outlook.com [52.101.126.62])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 49daw70g3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 03:40:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSUhWX2hJOdmfnrDIbswYaCnkTbPVXF3RxOcJlRcqboyYZCwf4HPsgLme3kbnkCmaYze4PzSPJjyAIKpPvlXalrcNlPFcy53xb75FAoGErQ/HFglTWAwoNSY53HitT84Nzesg/JxTUmySzXhomMmKkq3Zf+2JhKXlnQfKr29zEzthEhJtNZi+KZOnrlDcNjXDbBjBx8gbO5j4Bgv1HUOj8S5+EHxvgD7tM2dHEvM3ygrwBqFDunOYup810ohB5qX/jJc7QewLVHVOpJYSpW1AuYOE0wFatLDrizttNVgQgQuQvqkLYbNmERSGd8M5bYAnENMSU31EScOuCpfdgH4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWmhpQw0iip3GRU8klbFGulRom0zzHcctiRJW82wC1k=;
 b=y5aDLvyckNPQhbmvJ6PXOHelLzOX70gDSfHpzUixVFf8RGShrF6WWf01fHojEXPUfc/zpcfADNsoOL4UV8EzCbFlQNOElx27d5dku7cbgivLL98QbYKu1QS5lV4EB6T4cv3SXO5va8w8/YVqWRy7ACNbaz2Np/i/5h9bQgMW2MukJxJ/knZCto8kRX2dMh8v+DN8uEMZDHbdZlfEUTPl6F3+fx402V94a34YEaubGDt/i+MH+T8AkViHW65cwUmng3m6h/Yags9zG2Dm2frraQvor3VapOdYhKtmH9RfdbWYtdVmIhe+DdHPF4bI4B7UIiGHp4h6BeTt1xk+8eysCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB6587.apcprd04.prod.outlook.com (2603:1096:820:b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 03:40:49 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%7]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 03:40:48 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "ekffu200098@gmail.com" <ekffu200098@gmail.com>
CC: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Subject: Re: [PATCH] exfat: move utf8 mount option setup to
 exfat_parse_param()
Thread-Topic: [PATCH] exfat: move utf8 mount option setup to
 exfat_parse_param()
Thread-Index: AQHcLpc7P634kEkOY0iGrMX887YZqQ==
Date: Fri, 26 Sep 2025 03:40:48 +0000
Message-ID:
 <PUZPR04MB631693B0709951113DC1B8DB811EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB6587:EE_
x-ms-office365-filtering-correlation-id: d588eb6e-0073-4d59-e951-08ddfcae7baf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?EwayJzX23zNmv9eeg4XsegsAo57hoHpZWCdvakxzBUbn//tlB3SdIN/er5?=
 =?iso-8859-1?Q?Yyp7u3diybolLk7jJaCk39nBxWVEAjQYH6gnmQ2HeVN4XShe3+d790GlGC?=
 =?iso-8859-1?Q?SUhq4p3sE7BkoT7AJLdVCFpHmmu10WBh0waWjYfvBqeST2htT8WVBUDqFa?=
 =?iso-8859-1?Q?QqH3YOPZLfIu3ONiJ659xpQ16L0N15RVIOWf6PNAJ7FCdlSL3jOotp7lTZ?=
 =?iso-8859-1?Q?vxBUrXQt2jpcMbOd8aYAstzL97bI5wiqPstKWTQl7XiI8rLD9EN8RfG7Pz?=
 =?iso-8859-1?Q?++cvh4u3+ofX3yEXdiX2tTRxdgiVf2fba2LD6K5PRijlC5344zVJeu/3E3?=
 =?iso-8859-1?Q?mBVNa4T7ce451VaEH47VTv/C+4DmJReq+ahfBOjEtRKijySpAjKxABRm27?=
 =?iso-8859-1?Q?uBIXETzw4HAElNAYge/J6AqaUfPR07iSsQM4n4g417WDZixB/WHabPFi/4?=
 =?iso-8859-1?Q?kw4dJ3jK5Tsp0JuBDO/WLpheMfFNFHocmNCt6LesDDXxXja+xXMxqT6n+B?=
 =?iso-8859-1?Q?tzIEE68D4nM6tvdfzwK5YA4SgNaToKvBlIZ9aOgKXPp7up9wr+B1YpR51N?=
 =?iso-8859-1?Q?LP34LCyb3p8mKKsq/nfHRWvjJlgfPBXraGNN4v/UMQj4d717dKVqpfPb4w?=
 =?iso-8859-1?Q?b9YSm2H6bIr0jJiBk1qxa1ZJjv4bXWjeEUqNkCW6SoSuEvW4nobJSc5hy1?=
 =?iso-8859-1?Q?0sxotdtijtcHKx23uk4ysAswB6b4yYgS5UuwJ2zUqv5DrCgK/YbYP39WB6?=
 =?iso-8859-1?Q?CLTmZatQeCzfhqX5i6pCZHvSqG3iNSD1S+R/uIKgwdxeK5J2irh3UMUNR1?=
 =?iso-8859-1?Q?ci7DY9Y26IT9Q9qFjia1AHCRohmropgCS4+yTKJw0w74fcJ3laI23qVohN?=
 =?iso-8859-1?Q?lgUnMD5Tc++zFUqlU63Uu/G0sno2ifXrquWoc628GTqyQmOkN6g6tHUsdH?=
 =?iso-8859-1?Q?nGnHfoUYpXM6r2WTjZGYSwrKPtJKji+rp4h+xwxQ7tbeqxvaK+ni4MqsaR?=
 =?iso-8859-1?Q?qS8CuETEGGByHQO0qYeRkKeVXw8i9EduuhJtcwnXalD7Vu6zW2nwjPt7r5?=
 =?iso-8859-1?Q?U69db5YcBgT2DjByGu2KQ2vnxlHHNrX33hP0ddtS+c5Ner/oIHuDfGNoLO?=
 =?iso-8859-1?Q?uNjHOi4Yn9Pe3q+zeGs9oNzNLGMV9J9ePuuOG+3VIv2wIqIWhre6Z9h3Ec?=
 =?iso-8859-1?Q?O/ad2sHUq26In5dXte4qA5krbfALF/ntGlz6n0WensL0XAz42XKPzCcD/l?=
 =?iso-8859-1?Q?vLQBTyCs9gM4haAmUbhviSh75e8F7wM+N40pnCNokeWrWTX05ZIEIhhFP/?=
 =?iso-8859-1?Q?zEJpJoRlvHH6OYNR3UtTlNEHjXk8Pcx9EGAn0r/8R1FV+QH44K0AL09m/1?=
 =?iso-8859-1?Q?YqfiJj/lrRNH+DHgunvPi+8tHp96u9bWmEn2ZTKNg4HHX0VklsN3O1OgEF?=
 =?iso-8859-1?Q?QV2Pml8xkKbzBvRnb5EmSRwDq3WHZYn1HXfvOk4Uxj5NL6A/WE2qYU92MD?=
 =?iso-8859-1?Q?Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GGza3WnPb5wFK0GBmY/5emV8ri6JFUJ2gOeoAZASgpUV3LApMopx/OF/Z4?=
 =?iso-8859-1?Q?HinUV0p2DDGyDdwnQOLA0rOhW+R5Jznzz1MO8q6p7a2db8VsBV/NtirOnB?=
 =?iso-8859-1?Q?mFMxdzSusgS1m5mmh5pzGdczUCTOHDfHtwHQixXG09VCBIR0SGx/S5Tg+N?=
 =?iso-8859-1?Q?DrV2fWVmOF/6UFCSJzn8x7ex3x41qpzGLhgybCYiqUKfQs0eMHxeb0tlh+?=
 =?iso-8859-1?Q?AOOgAG06bkeuepHHPHaqQIF7QdJ/dxler7M7hNiqjcxIM35QqsO57cU3+e?=
 =?iso-8859-1?Q?aWS9v2FzC8l8mkAox5Kcukm4sEYBa+s44PwCgG3u77tHAZLzoutNqrEc1m?=
 =?iso-8859-1?Q?+uISf+1zqWDAe3R1q2sj//40kCvqC6+MEPPKyn8R5hdB/vJ6e3K5DxC7ZT?=
 =?iso-8859-1?Q?e43UOtpgx2IIgPuwob5LLuDkQQ8NJFRX5d748kQJO79vOHIyrU2rSz7lRW?=
 =?iso-8859-1?Q?RdIsgbcpzL24BxoPcTWNs3p8RVs055LBkXuUIAMqAanXv+SrIPqLdeoZcy?=
 =?iso-8859-1?Q?v1x4JIg0xe1iZ7fyAWrhF+NngYZk8NstY166w0Xs/lnJUP26+KUuMNfqs3?=
 =?iso-8859-1?Q?joeVrveky7BNQez4+wPvwzvCdeEIztudNAgISw1sH0/4E3wheojbq4ng3F?=
 =?iso-8859-1?Q?gYp60Apz92N7s6muNNyyqaHP5nwxgKoxmzuiXMjxabEI7EOxlY7bkI7Wbg?=
 =?iso-8859-1?Q?20BCVWgjT8UwO42RZkHZ3kRvgtKZL5bw1aNYUwfabJFCwxGoeTFAu13LDE?=
 =?iso-8859-1?Q?Aa6Xg6mzET3sex/dBTDpkUwMXgEFGJaP84VMaS7XzxKhk7w43QEYn3aaNG?=
 =?iso-8859-1?Q?LDTw2PbR3ytztvvj4KWA69KdaV40ypi3UhSqN1o+BoJ1q/+jpvCVombUtb?=
 =?iso-8859-1?Q?TInLqFU8ol/xYvFFDyIxJ0vD93cddhtyWDxmv78QlyGOZ/3m1Xw3woIE9T?=
 =?iso-8859-1?Q?X0mUlw7s2w1pGVl9mOXTl7rJWj+6t87375bei+U9kd6gnomzlVNGwRV0hZ?=
 =?iso-8859-1?Q?vNZ+jleK6xvHqVHrxxNxYweZoNuvMaWZ2hxLjgvisAb5tN1inEkXg7Ld24?=
 =?iso-8859-1?Q?mcnO8h/zycakHzqmiGzB0BlrAYim5Vlkyg0AUmBlBhcutGjSeExOVMwYzV?=
 =?iso-8859-1?Q?KfOXbfzcR6JpB/6Cb/CKQ6StmExUlWih9ACrLnxKPGuturd21fosIaTsTy?=
 =?iso-8859-1?Q?rglcS6oEbxJnx+AkjyPhXG8nQj37A+lgs8xGJTCiT6EXoQ5uTg8f7fKgym?=
 =?iso-8859-1?Q?NU+4RsxRqWXnzOWepFF066oA5pi8JMZmMpJsbfPfGQawts9YvFHBRu2gxD?=
 =?iso-8859-1?Q?Y3cdwqUl6UZ47GwdhjqUxn44b2fRMkXj32FgLqiCrPdDTuNS7Y+YNgvVLr?=
 =?iso-8859-1?Q?Tw/WxVpK39gxbRasld9ebpOW7iVunyYjl+q1oRh6S6YOOSSknvjbJMXUgN?=
 =?iso-8859-1?Q?v0LW5cY5O9Zx+q3fDr0ddn0uKhb7yYbdxLC58DEZ+75CDgwPZjfEqsw5yr?=
 =?iso-8859-1?Q?0EXxeiks/vTsIyKhgYMNthBjT2BwGQon63aM5889o3YMvIbVNB2CKWctzh?=
 =?iso-8859-1?Q?KUwrGCzecCEd1fAwCB1kbqZS4EIZvZnKOaqmpjKfaf8S+jnY0/ngNPwIUH?=
 =?iso-8859-1?Q?IcCORc4cTFPpLWQOxVxBT7fq0a1iy5JTz5hw8+7hQKlAAZjC1ZmZK3Yg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eIy/r3tJ3+jE/Z6K6AQ2NNhA86SbOQgegvrNNLSe+rHqBtx5gGk6fxmiSmxOPqiG4ZSJDxy1pc1IQwVM4s942V8BATWNRfPrOFQGYlNmkO8fqqeBJMWadHatkXq8ARVuzvTDJ+39+/vx1nxdZNrTJUfFaHKFCNtWyCYH2K5GgciwT5XgXykpfn2jv+LTv/MbiQ7prUun1EICy3UQQevbOwHl4Q6wpFwagI+jYiF3CoHBBMwP19ADzfMJvEb3k0CjN5V6hpcsgUv2CzZuYQlBk1C7yOrugDEH0ZwFYL5cF47ztchOE2oKgMjcIYJJFjTw+b+8qwQi6Xxb9ETEZJxJItHmc4xjqL/bbe4S9H2k66HOOvo+I09CDwXVhzE1XY39omiBb1I8qo/ncd0v4QqQIUpYGcouR+OHBqVY4Dj70gawwL3wyrk7Gp+hzCl0QX+MSm9zO2e9yaOd96Z7fTN6PxEKq1u9fhYN7VB0+wQB00/dkhXFz+a1FY7SyCUWr9rEMhNPBh00ujpyt8RViZJrW9Ee+CLJJ614znVR2jjxu01ur9Cpd/i+kfiie0Oks6NaVSz3fLkjtPj1ngdRPEKE4h30MjwMYOUTLPbuzeQpt7dNlzw8fnaH8sklpDgw8gFu
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d588eb6e-0073-4d59-e951-08ddfcae7baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 03:40:48.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZq9uisb69kclo3cf0l56YY8AyBXXmvHW4Ov3Opg5zK99JnRpiJ7rkAlkB1lOgZAFZ1SAtUMOSSkUUhRE2S+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6587
X-Proofpoint-GUID: O1Z2-cySSZAVAtEh3L8tUGlvwV4rkWqk
X-Authority-Analysis: v=2.4 cv=dYONHHXe c=1 sm=1 tr=0 ts=68d60b48 cx=c_pps a=Qj2SXdm9e47dEnvLI+3zSQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=8xTHmjjxzrKjsBCNXdoA:9 a=wPNLvfGTeEIA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MCBTYWx0ZWRfX9OOMF32KsBiE OTv0Qjalue/XsZhSAiXwjRU4oqrNphYxZ+2w8wtTKM5cGN/clB1ZLJQ4jIEzIe0FFFja59Zhe1o o90vffhGrLjBj6wrALmjFaDMml4OVjNzxY0p4Yk9UGCWJ6YXnhSVUvAqEuSREl2bzU2c2WPQFrf
 GXk0quta1HBqCyayaI+xngjgTX5AA6HgnF6oT7zxY4CKefSUVRyVfprBhIgHKGrru5Sb/5QI2+R k7FspgoA07QbiSQ8zG9OOYDvgrHsZKNrgNO1/ffptW0izEE9liVu3h/PZivU0m1OnD2KOooMxT3 AqnxfB1uUkzys5/KL/Bg4NcvdnXkSvh0X8D3M96YTPpy1YG/XTiPquvX74O2RYhYQ3bEFbIWECr
 /wzgtUYAp/nLxoS7IWwwOX0CgVUM2w==
X-Proofpoint-ORIG-GUID: O1Z2-cySSZAVAtEh3L8tUGlvwV4rkWqk
X-Sony-Outbound-GUID: O1Z2-cySSZAVAtEh3L8tUGlvwV4rkWqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_01,2025-09-25_01,2025-03-28_01

On 2025/9/26 2:40, Sang-Heon Jeon wrote:=0A=
> Currently, exfat utf8 mount option depends on the iocharset option=0A=
> value. After exfat remount, utf8 option may become inconsistent with=0A=
> iocharset option.=0A=
> =0A=
> If the options are inconsistent; (specifically, iocharset=3Dutf8 but=0A=
> utf8=3D0) readdir may reference uninitalized NLS, leading to a null=0A=
> pointer dereference.=0A=
> =0A=
> Move utf8 option setup logic from exfat_fill_super() to=0A=
> exfat_parse_param() to prevent utf8/iocharset option inconsistency=0A=
> after remount.=0A=
> =0A=
> Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com=0A=
> Closes: https://syzkaller.appspot.com/bug?extid=3D3e9cb93e3c5f90d28e19=0A=
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>=0A=
> Fixes: acab02ffcd6b ("exfat: support modifying mount options via remount"=
)=0A=
> Tested-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com=0A=
> ---=0A=
> Instead of moving `utf8` mount option (also, can resolve this problem)=0A=
> setup to exfat_parse_param(), we can re-setup `utf8` mount option on=0A=
> exfat_reconfigure(). IMHO, it's better to move setup logic to parse=0A=
> section in terms of consistency.=0A=
> =0A=
> If my analysis is wrong or If there is better approach, please let me=0A=
> know. Thanks for your consideration.=0A=
=0A=
It makes sense to put settings utf8 and iocharset together.=0A=
=0A=
If so, utf8 is also needed to set in exfat_init_fs_context(), otherwise=0A=
utf8 will not be initialized if mounted without specifying iocharset.=0A=
=0A=
> ---=0A=
>  fs/exfat/super.c | 16 +++++++++-------=0A=
>  1 file changed, 9 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c=0A=
> index e1cffa46eb73..3b07b2a5502d 100644=0A=
> --- a/fs/exfat/super.c=0A=
> +++ b/fs/exfat/super.c=0A=
> @@ -293,6 +293,12 @@ static int exfat_parse_param(struct fs_context *fc, =
struct fs_parameter *param)=0A=
>  	case Opt_charset:=0A=
>  		exfat_free_iocharset(sbi);=0A=
>  		opts->iocharset =3D param->string;=0A=
> +=0A=
> +		if (!strcmp(opts->iocharset, "utf8"))=0A=
> +			opts->utf8 =3D 1;=0A=
> +		else=0A=
> +			opts->utf8 =3D 0;=0A=
> +=0A=
>  		param->string =3D NULL;=0A=
>  		break;=0A=
>  	case Opt_errors:=0A=
> @@ -664,8 +670,8 @@ static int exfat_fill_super(struct super_block *sb, s=
truct fs_context *fc)=0A=
>  	/* set up enough so that it can read an inode */=0A=
>  	exfat_hash_init(sb);=0A=
>  =0A=
> -	if (!strcmp(sbi->options.iocharset, "utf8"))=0A=
> -		opts->utf8 =3D 1;=0A=
> +	if (sbi->options.utf8)=0A=
> +		set_default_d_op(sb, &exfat_utf8_dentry_ops);=0A=
>  	else {=0A=
>  		sbi->nls_io =3D load_nls(sbi->options.iocharset);=0A=
>  		if (!sbi->nls_io) {=0A=
> @@ -674,12 +680,8 @@ static int exfat_fill_super(struct super_block *sb, =
struct fs_context *fc)=0A=
>  			err =3D -EINVAL;=0A=
>  			goto free_table;=0A=
>  		}=0A=
> -	}=0A=
> -=0A=
> -	if (sbi->options.utf8)=0A=
> -		set_default_d_op(sb, &exfat_utf8_dentry_ops);=0A=
> -	else=0A=
>  		set_default_d_op(sb, &exfat_dentry_ops);=0A=
> +	}=0A=
>  =0A=
>  	root_inode =3D new_inode(sb);=0A=
>  	if (!root_inode) {=0A=
=0A=

