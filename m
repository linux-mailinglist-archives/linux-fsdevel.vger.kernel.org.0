Return-Path: <linux-fsdevel+bounces-13496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF623870844
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719A7282800
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC56612E6;
	Mon,  4 Mar 2024 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZYVI/IEa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q2Ik0Ea4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E91FA4;
	Mon,  4 Mar 2024 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573376; cv=fail; b=otLsEzrEMXcHq5tiCPB3bxLljLLNwXRwkRueklE68kBFYHvhoUXPUjzpRDxhAB5OKV1kMELANlr6EuK9iAuKS7sxjuSsvig808OO/fsy2HfiT5Xwq39PHLizqMbkDgteSrfxTO0fsv7DI+sNJ3OnvxpsqGSQ72gAlqu7GPndYIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573376; c=relaxed/simple;
	bh=EObUYnJWtOexBXZuq9bPfCqu5UlGAjOTryH3jIuUkgo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PGs+L2v1+tMcmpuqIcpsWs/mSJ/mek4K78YO1lEMANK9I+dozHcWsYnVusHm85keGKl+wa2gJqEMUE3JWns5INbqRnnrxgrXZugfa34KCbcmsYBzBMDXDPjTEb06fwO86CR+7RziFg98fiMEOh51/9v8jaeqmgslMngdZ/2enxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZYVI/IEa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q2Ik0Ea4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424GXxCB003022;
	Mon, 4 Mar 2024 17:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XvyIt8cTQpyBG9mjWfRtWvN8zBuxnpwEJnpyIovuHsk=;
 b=ZYVI/IEaPzqgup8nuDFjavk2jDYrXl0XH5p5NxGQ9OABduGxk7YndMOAWBo1MxX+Q0DZ
 PtuHNY01jS5Bnq6VUm1gEyAOz9H1/jjZLyOMM6AdnuRiDj86YvV7OAQiuJd2xA4HMiph
 iYjmNN5aLExVfLIjRPX796p/W7+7zdl6/B4GXlVQ4aigQ8C7hBqdeMvnTfWGaFxVVIVq
 2srN75iHHxYmvdz+XrvnouQMIIRbx3M2vOt26pLqIa+652+Ee4kATWDlCQcXP4dN36hW
 A6nUr3NiXBOVEnhk8bmIe7TphfkS7uliKeElpPrEf7FBlAscAMvl2yNv5Qso6VKBpldL wA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthecbjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 17:29:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424HCuqm017606;
	Mon, 4 Mar 2024 17:29:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjc4fdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 17:29:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/F7Z2b9yKuA1wInwUOdJEJPV7Tzpx5vTY5duRs02sDL06ZfhkN63ncUXkiZ5D3jBPTZ/CCSbMEJBeFwfiOsVZ4QgjfV8jiG+27n1Pi0qQ3BEkkBWpRPaG+u5txzX4nBaUBFYZI9z1a04LwprHRh+ahPDVxzM2+om3HyoYN0s4EC7CYeF6bEjGLRpHAJoK1sn6x5y/XvRnGLEKW7KZpo30BTgKyj5ris1ox5fIojrskrqNZ9fserwhzXIYq7JOcNWwfKGiogtd8BiWeBn+bW13qs/iuY5QOg3XpSw2Jt2HVMp4MnetJ9/nkw+phhFWwF+OCANsYc3a9tM9ArlhW3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvyIt8cTQpyBG9mjWfRtWvN8zBuxnpwEJnpyIovuHsk=;
 b=O+E/tjzflb6yqmqj0bYQx5MFw7rvGOP6QKha7Gn/FpDoN+HCe1oxwM+fMB40NlaRMSledTmXIzQZodthujWHUsODxpf5tMKMzk7DmESpgMEFHK6KHqXLqZqYo9oPdUI7GbLSPLo+IcE1nh+SPOksHkGETm+nOPMu5qQks6r1r8gwsDag5c2WZLlxbLu8lJ1JMCwnBPGbH4p26HVwSp0e7nhVj9Qn8SYihAtHciYmUQPuLGoyXNP19dD49tMnkEjMweWkhkuTZLAjiGE86NXotm3g4uQCbaRrhUSP+4PC4Bl8s/LaJLzyMq6OpT3uAp/wVfsutPOCUKuCC0LAQ79brQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvyIt8cTQpyBG9mjWfRtWvN8zBuxnpwEJnpyIovuHsk=;
 b=q2Ik0Ea45EJTFMwhd1nis7REQnLoCYtepSQiV/jZnJSXZR30iCp46vGiX+OikG4BSoE1baUxoZR0IBPTcoVVP7W+KNIyTXHgV8/avspQgglNyud9J0qrAqEFudvp1etfkTOe0gaCsT53sYqbSIMEMnehlmWkV+/RUpZt+6dSaO8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7142.namprd10.prod.outlook.com (2603:10b6:208:3f4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 17:29:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 17:29:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov
	<lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "kdevops@lists.linux.dev"
	<kdevops@lists.linux.dev>
Subject: 9p KASAN splat
Thread-Topic: 9p KASAN splat
Thread-Index: AQHablmApndEWlkNPE+f8mEZOY/LAg==
Date: Mon, 4 Mar 2024 17:29:24 +0000
Message-ID: <D56DE98B-F6F1-4B38-A736-20B7E8B247FE@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7142:EE_
x-ms-office365-filtering-correlation-id: b96fc707-c4f9-4212-f319-08dc3c70a310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 VTzNVe7piRwUbsrniXVHhJ1f9yWnxgY9knNWe7HjiU86gS40YvCqEakTuYaPrOnvAvr8t5heNjMDatMuxQ+9+t2Teo95MHKboysyOCJYhmFJwBMMALlLBNR8OyGuplmABXObPr0asKYrN6dNQIN3XFeS+xUB52k5HiygYjzbXJn2kafv8wbRbvGYKgmLwdqVVyKyttBpc/oISOkYtoNDQ59jMjZ+LimnQcZC2/XgTcDLRbIBDMegJowe0xem/e3GiJF8twm9es4dJ++LAfVxjFnBncPsEJzw/PkIzVZn+qO1ObsYWEqPh4oCvNLaHfH8Sra1SjOK3EIQyq7yiy6k+6PiC2+kXYuikek8hIog60A474lf9df3xbiHcqsUI+9nXEYslPLjDaUEqtxYPl3FlFZXb6Br71f2llutjr5yEYYBh8EQuwoZKL5aL1C4V19tINyQMwvt20yyR/F15H7iqmuMoQRPwNw7D+N8xtqnORZgiTtp1GcvNr7IqjNU6K+MVA/VK35sLrcSsZ80Bp39zEPg4S2K5sdSaUWRLivfxTbh4RpPsIoEsUfW+vZ4PwopVXGaFQ1GUaMUZstZG3UTj50LmbM8y9+WxnJiPEIVtnh/tD/+JXT+CvEsxos9D5biz0Bcb9JNghRj1JwEMdiGYvzVFJymuWFbrshvJAqVbJJ6hgNxRym5qzgIbYbXYuI/BGYT5V4u1d1ysr/KtSmQSeDwk7HQHJhDqT9O/IZHGZw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0PzwqM5EJuU/7l890c+48fKf1n64hd2mYP4Wnn3xtzKInE+ags8nhjDM0X/y?=
 =?us-ascii?Q?6C6BfcdO+WS/Xmw4P1VZecpNBrvQJwDJ67z86I5X+mPrn8r/wTBPt6M/04hW?=
 =?us-ascii?Q?FROK+zcw6IVriSAUJ/4fRQdc6IBIm+MC5xtf2qxFFdHnCGNFOvVqoNSy1But?=
 =?us-ascii?Q?74LvQ0KQF+9r/jUgK3ur3aW1eY3CDihpVS6SgJNZFhLFh5c0dDVGjvPyP61K?=
 =?us-ascii?Q?b3IkLlTiUsFgnDKMqqzDNYNVl958uAUQgLLhD8bijuajiGaCXsoB8suZPrAW?=
 =?us-ascii?Q?oYCaknuQPR00is7IRtqm533w4DZsdPKt8jj76iYyh8uEYUsnYXGxYC9hyJbd?=
 =?us-ascii?Q?/vmetXpnsAxDpULtOJfmQbjOZGAF2LeJJ6nNOkjfYHeglwgT0kC/LwFTC/JM?=
 =?us-ascii?Q?aRj0ZswkA2UYmlsxNOsqqKzt9fvu4UNKsSGPvVEm+E2ZjXOL/XmYh4Diuj4k?=
 =?us-ascii?Q?I0j4kcajR7FiXETMuHiz44ve6wXFugBH9u4YMIi5YSY8JXDfm8qtjJYhkTjQ?=
 =?us-ascii?Q?bhRFKdMMA6B0+L9Yl0NA5tpG8E3tL6FJnKkUxm4eDMv13s5GyMrt1UXpL+rZ?=
 =?us-ascii?Q?A4x8iFTBhHEIEzGbHBJGJD8RBJeSVS7pZ+jp8Blia5+PtXMezAJyFOIlNH7f?=
 =?us-ascii?Q?uhnKR00/1dZ59qOKVhkgaZtT9AtNERjxbVY/0UDCShRW+5i2PQgkoExU8dCd?=
 =?us-ascii?Q?6r9oac4YNsZxub2EyrhXHnJAKXQPhzJcpiLJfSa07nfA2+to1YDbSdoBB7V3?=
 =?us-ascii?Q?+TVIRIKFn4+g6FsUwYcLPc5GfL1CJEv38LoYNJ3w52/Si5Vdk5MiTPW153lN?=
 =?us-ascii?Q?FrXPxh0zBbdT/EA87JTRcazK6my0WDFG0q6ZW1h71ewGnbigkhZk6hBT+ZKB?=
 =?us-ascii?Q?+2N0ofl9MDOCe/ktQh5Ttg1o0aRrN9d2P/s1NmdCz3Kdkfu2NAT0mXvgnjni?=
 =?us-ascii?Q?um5cTabxWwsWC9iNKQT732s95YKqYel3K0RaTXKSmUVt05+TOCp82lIf+Riy?=
 =?us-ascii?Q?WzY6r2YCtct25a52tB2rUPppVFRw2NiGkX11xZS0B28522Yv64fvT+7MPK9a?=
 =?us-ascii?Q?mFAL+gjf/kWw1jYYSSbdoXQh8EbwUm70U+BAVGgM0snv+4jvgGdeRHz+5IdH?=
 =?us-ascii?Q?emT0v68fwZgpd9igvpbDnzdUlAwb1LtW57chxMCgQnBjvEwMWDdswb4Neavq?=
 =?us-ascii?Q?HY3NCn3f9ZhDB/X8+AZLXPkh6NDWS6tV7pahAfh47/1Ofl0zDX3HCcm82G6g?=
 =?us-ascii?Q?J/h4D88JWJ29l8Vk8alBLgRaasS318gvF0K35TLPMq8duU1igObgut5rdgCh?=
 =?us-ascii?Q?6EhbROzAMx+WDRgCjcUmKXqO1W+7rZ3vZLXxspJBxfrt/oS9GRiYTs8aiCYu?=
 =?us-ascii?Q?eKiOASxutxRAvNJDaFjk9b43bHOWvb1xqvqtSQ7kXySj5T4F1icE2swqLBe9?=
 =?us-ascii?Q?vWQgAPgZu6YOKjv+gOdhSixIiMpvAm4bNYVHW2QnWXTwaP3l2TqtJfHzOsV+?=
 =?us-ascii?Q?Ad9Sk0/znB7HqpW8q1jKcaIE1rj9cF7ye1AiEKisM1ekEV1vPCG645tsZsh+?=
 =?us-ascii?Q?2pezIDvVDdPNYOdOwF+c8h7DAG6xM27oHpbnGor45EYq2yA99wt5qIn7OwIQ?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0E5E6A3A92D6146A3FB700F79848C3E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hEmsRAVk2s2qH0vha4gWPJYxy9bn1lmd04tL3+KOL0C1CEgVk01NI6hgw5CROfFHLr45hQoVsvpU4ymNUMtuvNCkuR3VirnEqioUklZdalfmJ4xMyD94Q5LcyuUGBysWdaAiETcAQahrx5s2xDAjBltu5FzF7EoEohmu8ZEZAlq6fK7tEXcLF8zBpKLS6nQ/GXzjlr6vFQNvpMEEqZi/OUcOWpzCgm5KNUk2YWEnBzHloRLWZ/fxG1dtAcSYa3zi9BEwuq9Z7UIKwULQJJFFpIN3lbQSnGGGVprNFZKwsCpQ93+9jGfvA2SEEvOA+6K67Wp4QjF3EjfzMA5LHvpl1R5kmtVJFiKgfNEatMnDYpfPXod9Twax2Z5HT0T2B/vW/76QsufmkaL8COzNmyJ7m3eXmtZ81nfmDzV5VLJ/fdHQxMmKuARfSIoKZcXWg1yp2m74PnVnaL01wB5iJC0YQtK07h591GJCE4SQU8D+JzU59Y7qVGTeQKzK6Wl/tpZFgsrOyhZ92zu1h8B2At4FZT7LLxGZD/bMjI2TJEjUNWvq4DKDawfPrg14PfHC9ZfXzEhcp4q6usNWMVkrgwHU2/YjWUPGePOrWp+gkqm8gv8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96fc707-c4f9-4212-f319-08dc3c70a310
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 17:29:24.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AB0v6KFqwQlrTFkD9eS/2pNRb2Up6kVT7x68LUT26F3jXx/FxBBNGbHgtoVgIzBEyTKfN1/mUm2Ar/KNHTcNoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_13,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040134
X-Proofpoint-ORIG-GUID: jXlNYlsnoNxN0V5kHvBkm_zwoVqeNuje
X-Proofpoint-GUID: jXlNYlsnoNxN0V5kHvBkm_zwoVqeNuje

While testing linux-next (20240304) under kdevops, I see
this KASAN splat, seems 100% reproducible:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in v9fs_stat2inode_dotl+0x1f/0x3b0 [9p]
Read of size 8 at addr ffff888119369600 by task mount/666

CPU: 0 PID: 666 Comm: mount Not tainted 6.8.0-rc7-next-20240304 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/0=
1/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x73/0xb0
 print_report+0xc4/0x620
 ? preempt_count_sub+0x14/0xc0
 ? __virt_addr_valid+0x144/0x2f0
 kasan_report+0xbd/0xf0
 ? v9fs_stat2inode_dotl+0x1f/0x3b0 [9p]
 ? v9fs_stat2inode_dotl+0x1f/0x3b0 [9p]
 v9fs_stat2inode_dotl+0x1f/0x3b0 [9p]
 v9fs_fid_iget_dotl+0x112/0x160 [9p]
 v9fs_mount+0x27c/0x4c0 [9p]
 ? __pfx_v9fs_mount+0x10/0x10 [9p]
 ? vfs_parse_fs_string+0xd4/0x120
 ? __pfx_vfs_parse_fs_string+0x10/0x10
 ? __pfx_v9fs_mount+0x10/0x10 [9p]
 legacy_get_tree+0x83/0xd0
 vfs_get_tree+0x49/0x180
 path_mount+0x61c/0xf90
 ? __pfx_path_mount+0x10/0x10
 ? user_path_at_empty+0x40/0x50
 ? kmem_cache_free+0x189/0x470
 __x64_sys_mount+0x194/0x1d0
 ? __pfx___x64_sys_mount+0x10/0x10
 ? ktime_get_coarse_real_ts64+0x5c/0x80
 do_syscall_64+0x6f/0x150
 entry_SYSCALL_64_after_hwframe+0x6c/0x74
RIP: 0033:0x7fd2124e1b9e
Code: 48 8b 0d 6d 02 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d 3a 02 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd198cf698 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000055a9ad2149c0 RCX: 00007fd2124e1b9e
RDX: 000055a9ad214d00 RSI: 000055a9ad214d40 RDI: 000055a9ad214d20
RBP: 00007ffd198cf7c0 R08: 000055a9ad214c80 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 000055a9ad214d20 R14: 000055a9ad214d00 R15: 00007fd212611076
 </TASK>

Allocated by task 666:
 kasan_save_stack+0x1c/0x40
 kasan_save_track+0x10/0x30
 __kasan_kmalloc+0x8b/0x90
 p9_client_getattr_dotl+0x3b/0x1d0
 v9fs_fid_iget_dotl+0x7d/0x160 [9p]
 v9fs_mount+0x27c/0x4c0 [9p]
 legacy_get_tree+0x83/0xd0
 vfs_get_tree+0x49/0x180
 path_mount+0x61c/0xf90
 __x64_sys_mount+0x194/0x1d0
 do_syscall_64+0x6f/0x150
 entry_SYSCALL_64_after_hwframe+0x6c/0x74

Freed by task 666:
 kasan_save_stack+0x1c/0x40
 kasan_save_track+0x10/0x30
 kasan_save_free_info+0x37/0x60
 poison_slab_object+0x103/0x180
 __kasan_slab_free+0x10/0x30
 kfree+0x107/0x390
 v9fs_fid_iget_dotl+0xe5/0x160 [9p]
 v9fs_mount+0x27c/0x4c0 [9p]
 legacy_get_tree+0x83/0xd0
 vfs_get_tree+0x49/0x180
 path_mount+0x61c/0xf90
 __x64_sys_mount+0x194/0x1d0
 do_syscall_64+0x6f/0x150
 entry_SYSCALL_64_after_hwframe+0x6c/0x74

The buggy address belongs to the object at ffff888119369600
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 freed 192-byte region [ffff888119369600, ffff8881193696c0)

The buggy address belongs to the physical page:
page does not match folio
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x119369
ksm flags: 0x17fffe000000800(slab|node=3D0|zone=3D2|lastcpupid=3D0x3ffff)
page_type: 0xffffffff()
raw: 017fffe000000800 ffff888100042a00 ffffea0004735d80 dead000000000003
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888119369500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888119369580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888119369600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888119369680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888119369700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


fs/9p/vfs_inode_dotl.c:569

--
Chuck Lever



