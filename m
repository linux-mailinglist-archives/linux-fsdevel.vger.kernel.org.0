Return-Path: <linux-fsdevel+bounces-72239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDAECE93AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 10:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F24E13003840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE4A29A326;
	Tue, 30 Dec 2025 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="oGdsz/EE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5125B305;
	Tue, 30 Dec 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087467; cv=fail; b=P3z1d87ZvTV3iCRNeubNV4Y8Gsy0eL7C7IsTxXdZe8h2KQ6UXGegZfBXJqThmI9tWBGtkxrQNrR6gznh19hBrkgmfS6PfDCQfI8wMBRFs/crDID/Xxmthb3+zfC/uy3yrJU+xrCfQLZ3GB7ibjQOSxffmnZs+ZXQlr68EvYUIaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087467; c=relaxed/simple;
	bh=c6mQRfvTxNsyUYFD7L+D98UNy2xQRN2b4mXVkhgqaoc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XwN7Ooi3G5lQcZdJSZWiXcCFuIiBQAf6nDZOeO7YZRjQsLJgApxrQV/srW/MP0MyEaSCjU6zmuEWgPXWlKDz52TATUX0w+736bwsne65ocMv0pwOtmNLk4RLxIUbu0Xy47bi612oUIsNo74eI+NrUfkMnUyf1sGDxsuJV70tTLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=oGdsz/EE; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU8XeYF029616;
	Tue, 30 Dec 2025 09:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=Ll49Ganwoekew1i5j1PozVRhEO86z
	3EO0yxOZqGK5xM=; b=oGdsz/EEtvQWvx5iX6i8//apc4ahVv2vDn6bs+X24sAGa
	ppWmenUlwh9kMbaG5+mLmVdTWSbl9QXRGonZMx7HCR2NkNZDo6xQ3bUTfSyJwu85
	W6YCF1GTFM0buQ3J/g0uq5zhSPC3/UmkH1sRuDjg0+u2/heeGca+SHlbWi60w7lI
	dvWTxrM7f7OxrRv3dcXbxS3ZKLf2sK1af6ffOJ72qe438TtYvZp27nLDeJdmdkAs
	HONtB5gwWQfxVRa4s1cZiLvIm6DDS/OABodpuTzAEouLPFhxiEOCKXUtnrEVBEF5
	88bwv9OyH16afhxHyD3+ITGLUGsrhayR3JUawv6iA==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013056.outbound.protection.outlook.com [40.107.44.56])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4ba4pub4ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 09:06:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THiOUS4BA/P/79PtxkYjbw6DVYvlBrNSaQHRjIoSZaZsSkFJKT7WUnXNg0fd6JXewhyYhtHO2IV3ZXP+UgOXz+OFpnPkcjDux0WSykAvy4VuCiUjh+gyI2wEiTfaYQbgHfl70ZuYxnVCIfXNz6vggsN7g1HAWMWxUKohp01zqpsgC6OrjY+MR7h4+Kuz0/Of/Zy4ZjRTn5v+ZaZ3aRnkuK7dXi+wOoOMk4pIUSIWLcy8EHLypf0Kj/yTyoto/HKOI4t0Mn/b/1F21CvylujCa2ITMqfnamtL7W4QJhANfkehkxrzBXqBG0ACuSoWUOZaj0GOse2cWP8wY8JmcasBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ll49Ganwoekew1i5j1PozVRhEO86z3EO0yxOZqGK5xM=;
 b=JtOaZambbu5LHsWEr5ly38PWX+ZdghgB8KktzQmZqSiu70sgcmmIeqQhh+l8VXjeT6uRHk5a5YzsMXvqgNHQTndIHbxQKGVUzpAhmW6n+G4KXlPLC8H2pXHvUI0++DXw7iBoQl6P9ck2sqYz1e/U5xUEnsgTZfSbLMnU6AItvsz+6Bh74VoEOZ84fB/nZSuweGuPYcYW0L/VjFfUTaq5R5yD80rhlLsy0TyQe6HeNaNDkR/oBrLp22fdpIalg2LzADGX8OqEVZeRrKosjIzy+xW1G89u5qSGJMTS2Cg7hKXIGThwAscKC7T0Tn9fTqMdmuJ7Ln7xQFdHa3YnU90i0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7450.apcprd04.prod.outlook.com (2603:1096:101:1d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 09:06:06 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 09:06:06 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "chizhiling@163.com" <chizhiling@163.com>
CC: "brauner@kernel.org" <brauner@kernel.org>,
        "chizhiling@kylinos.cn"
	<chizhiling@kylinos.cn>,
        "jack@suse.cz" <jack@suse.cz>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v1 8/9] exfat: support multi-cluster for exfat_map_cluster
Thread-Topic: [PATCH v1 8/9] exfat: support multi-cluster for
 exfat_map_cluster
Thread-Index: AQHceWFREz7WrF9QuE+obcPy1x2xAg==
Date: Tue, 30 Dec 2025 09:06:06 +0000
Message-ID:
 <PUZPR04MB6316AEB35F215CCA9BB0895181BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7450:EE_
x-ms-office365-filtering-correlation-id: 0e8b171f-0217-4e1d-6d11-08de4782aa47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?oistG7cErasfXcgNS5sp7Hak9sJ5gbOZGQ6iMVk5iT+7cR3cRTYUMTFEpC?=
 =?iso-8859-1?Q?kcwGtJ4r7pjBC4gnIZevcItvEvIyPla8+BWvdfyGbkIzsz/jlCQTpPz6Y6?=
 =?iso-8859-1?Q?p0PSaIeL4T0l2yjZ2y1beEYSu9m7siI3ltfQWXGzrbfEqJ/HyUNw2VMElT?=
 =?iso-8859-1?Q?pj/ojkR16CbW0WC/+CEM5TLNqrMmjJ/4sAlcg/RjDOiXqzCkTddkxo1anX?=
 =?iso-8859-1?Q?AlQMKw/vsDA4BqLBihSI36crk2Qak3SzhMB7qIN2QYsL4KkyVONxuIdU61?=
 =?iso-8859-1?Q?MIGNsE35WdZ1fXaDpiSxaprLo5BNKJY+81iEJrX3kVsIAaD+kTDm7Lpzd2?=
 =?iso-8859-1?Q?TwFnWbd9h6zEzEs/jw9xlxQxBu0bxZLjl52Y91YXllSU+eRAuE5gTxOthI?=
 =?iso-8859-1?Q?Ift21osokNKDI+8pJJXEGcHWjYJKcFrYK6l5oxXT/BNkrkRHWYU95PF5LO?=
 =?iso-8859-1?Q?Vnb2ukx9WxnOJd/B4+dN4qf2Y/IQvLYGoq7mcL+m6A0FcunLdX0w1265nr?=
 =?iso-8859-1?Q?Px1oW2MCsVbuy3Q5ZNevHQXI2n9lw/edFnEAkh8TmdKqcyQcDgxsb8KP8U?=
 =?iso-8859-1?Q?egwbuHAcMTs1eGO4FFUCcnVabHEo0VKg2odkL5ZnPiLZsSafsmaVr9VzmO?=
 =?iso-8859-1?Q?j5pcqkFpWHOQeF5nqmc10xKzfak0qut3otCm2566oTIGe9n1kIrDpEj4SH?=
 =?iso-8859-1?Q?lBMDFLzZJahnq1L3uDmkiDw8zvhehT0Tkz6xFcYTSa82YCjrh49wD7QE/J?=
 =?iso-8859-1?Q?IXGP7aLMgX00PtHuixHh/RmcFr9HnTARfcxxcT7SyBhEb0Wgo84F3LC5WB?=
 =?iso-8859-1?Q?gHmUjguXMATltK243xQ8ikuMscnZ9u8Vu41srYCTVwVnOfkVlD5NBwteda?=
 =?iso-8859-1?Q?GmGtVf8/Vbrudhwgz94h0QyHJJKfeeGW8/FzxTiyYDvYetlsgeh2pV5eBc?=
 =?iso-8859-1?Q?KLAqi1nYlQ0WPZlB7liXVUFWvWAqDdXG8e0k7OpO5hQPELDJRTsYohPZHa?=
 =?iso-8859-1?Q?oeuMHBnpoSgSgutYD0hD7AXRJksQB7f7FlJi8R+ERCeCY/0OKeQ3jL098i?=
 =?iso-8859-1?Q?8XWvPnsoLWoN6TeIno6ZAM+SdN4deK83GJh2sjrA394pvJgTOVsmVMit5g?=
 =?iso-8859-1?Q?IhUY9juSU3SSyPeFgi99Z9WD9QrGMpvYvXDjhOnVwq2SBrwTBhaIwXNk5Y?=
 =?iso-8859-1?Q?H8TEmb0HC3crrd+Ox4bf59WbhS9jW5BH8nhFtVH51qqNOBUHijlv4mjpf1?=
 =?iso-8859-1?Q?gS/GbvMpLVVNfaxcTtVJux2K7Vtx2V4fpbFUY5zhYIkPyaZ/2prL9kHHeB?=
 =?iso-8859-1?Q?jP2g5OTk0ySUjBuDqzb7ZjR7Hcp7jhzwZmfdY2IuJ7M8DpNfSmXJyBMN19?=
 =?iso-8859-1?Q?b5TKfFrsC7RF01MBKzKxoav/gtZ/NAyMW1iRaIVinmB3rcmOeh15nLtpaN?=
 =?iso-8859-1?Q?SEil20VLvzet77ZvBlphDO2bYbO3grEc4QnTcCfK8a+SS0eaCHBuK1jFUz?=
 =?iso-8859-1?Q?nZGl4pypCd/8oV9ma9VJFKO5SU6U0O58MhA1gsp3AIBFEXyPa6jnRi7obo?=
 =?iso-8859-1?Q?7BWopxUPnQSaEt1U7yyc+f2ISuPg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8+HvNjiWFpQOea6fmbSvnLfRKw1SU23BnjUlyXOijCYcM2Fk/B1JdOAkLm?=
 =?iso-8859-1?Q?xCYwMPQMbKipt9Kz3pBLva7/xqxdmqRVQ7akn3eh9OV2+jPKCWA0HvwdgI?=
 =?iso-8859-1?Q?IRtOlBtbUVjDERB1iJndd48CXyGhOYhwAYsMxTYgE3MmjREj/smksOLfcN?=
 =?iso-8859-1?Q?MuWS5rcy64nR8ByIll7OelHXDcyUuxittP+EEJJMhVh2RaLy7xWiKVeST3?=
 =?iso-8859-1?Q?LRuKMCEV1lPEoOWljZyAkAI2qN+tSgvb4NX5KXQl17aptQlw033OTAH84n?=
 =?iso-8859-1?Q?S0wMmoHQaNhMljzbyXfY2hFSGTaIdMt4uUdGRxEtKbHNqHMNEbWtdi9Cj0?=
 =?iso-8859-1?Q?mPOgZJmNLGAy/KA6RB7VEUJM89sCmq5IGFbvyjcMYBB/sSG2svmcZ3w9L7?=
 =?iso-8859-1?Q?C81UebBWeIq31hhA0aKCEwbP34U3ZNGTz1bXXIg7cQx0bDkxKxuT9eLUuI?=
 =?iso-8859-1?Q?bZNRNtNA7FvIVIesPbgk8Mfy3y1wgSSuRDGnvK+fOab9mEjVFBXrDiqdFc?=
 =?iso-8859-1?Q?6NDtrl2dUGHzQgAWuhBcL104dnfScZAGE/nBzE0jz6erPIvQ3yHbaQobe3?=
 =?iso-8859-1?Q?WCyUiKf4Ch1mgW/guCwSnq7Q8iUenZHFZU5XZpkocVgzAvPS2EKYhVbm0A?=
 =?iso-8859-1?Q?0TfaVl6sivCJ5VLUsJZl9jyX84hHVO7JKrLtwLi7qixRvjNXDRRqy+syJ0?=
 =?iso-8859-1?Q?eLTT3tPCVZX3KYV1Ud9OjbMkg1ViAjn1uUFeWziZDZdFEw3oykLhuqMja9?=
 =?iso-8859-1?Q?/5JDM0JvlkU7E+TW7/HAAZ7U4rdWI6ffyCEid2Cia6NBgn47Gk4gdDu8Ow?=
 =?iso-8859-1?Q?Iug65P7I2j5ngiuyLq+253QjR0KWs47YUS16Oq61mJFJWUo5v7TsxcoCay?=
 =?iso-8859-1?Q?6XUcHMQRWG5g5Oupp4fkK0mFDrupKZiVm2VF3oiAyLrHzuL00R1NvOnqGw?=
 =?iso-8859-1?Q?q0cksQtqijYGa46RajP1Lsg+0eUKC9eBlnYmy9vwfeobVehkPtf8FBln59?=
 =?iso-8859-1?Q?hEEimi6KTR8060B3KaBo1VnkBc3gsSPCD1wupKFBf1EAdYHw8xcTngItGJ?=
 =?iso-8859-1?Q?yEFlpGTAqjxhnWs8HO8A/YrOtWXUzDxJLJDja7EOkzJUN1sEuuEAqXIQ/0?=
 =?iso-8859-1?Q?2LUUENy+ORZr+yegh5YEjSoohPTKiXwyImq8XK3XVy2tgwbCNaYx5uXn0e?=
 =?iso-8859-1?Q?pi4pU6t8kfSt8oIN0f2bq8KYPqWO+MpSEtgFoGFT0TZAgty8ZHThxKukjE?=
 =?iso-8859-1?Q?VOHQOkn1/iQbl5O6TlihEHAqaFRJ4OSu/E/KwBLIXHUE1XXvu+sO5uTj4J?=
 =?iso-8859-1?Q?YFOgzDStHx/4Yuh7ByErBdqkzfTV6zhF3y6LeNeXq0291GNbmW28h3ASFF?=
 =?iso-8859-1?Q?gvw3R1fudj3aJabWNUfFkv/r7SHDUSxoBsIXnuPQuUk1BsNLjEzume/CfA?=
 =?iso-8859-1?Q?A/IF3xr4vrxreXtbda+5ugEbezld/+owPVBrHA0olQaM69yzIU8rnZ81ll?=
 =?iso-8859-1?Q?dDvCBYD8BXoVHKQWsalsLIzJER9ILQhOdl8OvUF2QOfxfDckE5gC6vmAgl?=
 =?iso-8859-1?Q?t+MGNrE36I2cBL/oH29Eax7wGw9nz87oWLuWKTgUENhu781LGNybDv9SDF?=
 =?iso-8859-1?Q?t4zKpHLFzLTcJjEq+vYx8TcowkBzObXLURPBXw0M/MWqWSKq7+zOdhYWI0?=
 =?iso-8859-1?Q?OTbMyiNLyL31c5i+ZFsxvihm33gpPYK13xlrp/n1S66nGfu7mpsSNfMETd?=
 =?iso-8859-1?Q?PXbPOqMLSfoWrkuFtH8YXoKdUdz7pVqueHmpXIIvWJTkIpdLSZlGL5WJct?=
 =?iso-8859-1?Q?Q3//5w0mDQ=3D=3D?=
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
	f2Q+N7tIbJCjUY2sis1Vf98uSXRFuV/UAOriRVwArFipGTVieDVZgaBErYrh10vzQ5Am682GtnbK3eh8ap+xXFC8yNMmRerZY/1CMlLhboP23Y8lJnqfHxuvsAPY5DXo7H8TA+5zBeGBxIOKgXQM8vOKTGwKlN9JWdXCsvdhGJnsZ8BD9hGiKlUMIWIMXE3zZnizqPATtfes7GtGFKh4Qw8svndgtz+/PAZQNUc+E4JGmc57XaCvC8ymkbyYdve3NFP62tlTBQExbhBWwzcR3/+n+KLrCQ5l3nIlcDiSBj0VX6zilEDpGViSKA9Hpcy6cC3RrrL6YyJG8K0Cg0xJ9mdx2LkXmXsPl2tfO+RkDE8RawQMYSrZIg2zh10vmc+NiZuawNjWbpLQc2IHDfbL8mIeIGB+CFWVaAh1z4SroGAEsjef5jwBI4ESurZughe5mMWuGwLNsgtGBc81QF4oGzqN8JpakaTn3ArOhumFH2ixO1tGTQRY/zYrKWH4K9x28+7dOJK49S+n+v9CykNcfml70PDKwS31iT0Egbq5quk+cG87M7IqG5/GGXKOaqLOGoOYukAb+HuCHXcd8kDxV6LeQWdBiOIXhOX9ZiOXLB/O+JG3SvikFhaT4lsqp2CK
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8b171f-0217-4e1d-6d11-08de4782aa47
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 09:06:06.0785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50TtrZWmGvnejpsHOQiUN+h+w+Ux7pSZxVBCEDPAwGNamVQG05OQgPAJ1q/r9Dy/2IXOwwsX1EBUmit9t2e6vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7450
X-Proofpoint-GUID: 5bKSLmPGmoUtuqqAaqyIefzp0EJpwOh5
X-Proofpoint-ORIG-GUID: 5bKSLmPGmoUtuqqAaqyIefzp0EJpwOh5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA4MSBTYWx0ZWRfXxLeD7NmjMZuc diAFI2ZWySbijpXDOzOYeqwE6bf6rO5qe0JTsZzWLVtLySWGu2bBgi57Ujcy7NXTrVFFivMWP53 yfPMOJ2eOB6Rj1ZyT2BYUIHhA6OpAPqgu7MGGL5F1TsMp8ne81pduO1ZOkXci0GbH1b6fYXZ7z+
 79aGTwk+jg4wC06sWrm2pQEq8Ox3h7MkLvwZHWL+aJNYO+6PvmD58BGD16Grqviazsdu/hrmWKY Uy5oG44L2hRt0+T0eVOgIyyHxncKEddAiY5bFqoqhwYB7AgFx1AVFM9pXWG5AHrQLY65X6afvnz eaZzns4yWHx7nAj5JOCtUD/iB7M+1ASNvHjzVH2zZTAHTkWMd1hiwxhqCK6PW+L/K5RElf6cPNv
 ZYLhuTlhHmXTeq/XIQaEWsaQktAnpQe7M9zdvdExfp7sTZXNS7CGg+mlKsMhUf8/ktAVOZQsgoq BekgvVd4NVlTzGkpa2A==
X-Authority-Analysis: v=2.4 cv=VOrQXtPX c=1 sm=1 tr=0 ts=69539603 cx=c_pps a=kREF/9fVw4pIOCO+4zMS5w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=wP3pNCr1ah4A:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=E3I31LahleCXfo7OjuAA:9 a=wPNLvfGTeEIA:10 a=1X5wc7JOKCAA:10
X-Sony-Outbound-GUID: 5bKSLmPGmoUtuqqAaqyIefzp0EJpwOh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01

> @@ -293,12 +298,14 @@ static int exfat_get_block(struct inode *inode, sec=
tor_t iblock,=0A=
> =0A=
>  	if (cluster =3D=3D EXFAT_EOF_CLUSTER)=0A=
>  		goto done;=0A=
> +	if (WARN_ON_ONCE(!count))=0A=
> +		count =3D 1;=0A=
=0A=
The count is 0 only if cluster is EXFAT_EOF_CLUSTER.=0A=
So this warning never occur, right? If yes, please remove it.=0A=

