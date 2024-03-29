Return-Path: <linux-fsdevel+bounces-15669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39758916EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 11:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248CB1F2183F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866569DFA;
	Fri, 29 Mar 2024 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="b6jzHbO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703CE1E886;
	Fri, 29 Mar 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708601; cv=fail; b=aoOksBC2pXtqubl1fKz+enw0F+loYHrFuOCn/7RCBGK6CIe/5ua5gRMemLFvSQjjWIMAFy5S+AcyjhLAIF2TVQtYFseHMFFNAfAVCAkkYNoM7D2I73pjssLRmEVlqA3c/qlAWJI5v7mN12+MeJZqjKthIullvZ7Lc1VkviVU6sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708601; c=relaxed/simple;
	bh=1EXTiBO25WmVacItAUizYT7zJbOHA2wG3KsIobbKJgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UsAtMrKC0sqA1INTbnJwLwpjaAcDfcUh9urfmEPUgTv29xJQyYRMyZOdg3nRMXmfjFo+Bg/h49wV4wLq9SwVY06E1T3x1GuastexcYH6f6cudl6er49UcDcDI6DMoaKMjNO+tPft7j8wh5GlqHdyTYRCwJlgM+gIfgnsfwP3g0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=b6jzHbO8; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T5ssE3001797;
	Fri, 29 Mar 2024 03:34:59 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x5qw8rry4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 03:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT19G7AFXyT4VprZ6ojmlHCrTA9OofYu0foSsAXwi3Qikb76sEkxCmo/yCywFt0xMZCoXdWha7hM+O+VmNxHMTH+nuneR7g/7ASf8t4jVojNCUTt5JaT+n7HgsHB0QBVEi5Ijdu4Xss+5tPh0MNHD7ZG+O7dcH6znla7GChJnALip/H7kbsFUH8dW1TXbPOLKkCg4W+sXHmMbOCq9vQKE0PepMhdp5iJPMWmHVsmDE8HrU3gzlzIQ8gO3mqmBTlofWLYRZbUy5aD8UhQ2bIwPsvSGgb2YtymMvypQn+pkDGrjpPclNtFJU/nPj9nHZ1epP70+B8MSO/nz8y7QcB9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhLd3b1nar4yU1S6MJpzmY88OWmjjNqgAeaf+zoThac=;
 b=Krrcj7mjbJgaINknjq1G0h4jTyNCl+5PftBZ6I1iLc67JZoS98v7XC/eyTjctANfQYSmoufYxUepV8qgzcohYJpTHmNiUVV0Ii42tJq3xKNowgGvwJAiclcUQM7MxeWx0gsI5hLHD105ZlaqenSdHPEHKhib3njjOjjXN3n+7KgNS2MlaPtwG43/T5VRq+GHYdiVgMQLtbqcr+ASiRFgcFsJAQOAps8vBE8rXjX2C5t0+MFz3ESfcdRVDBIbuE5dy/g2Dmbjzw8BqgOgz1V+P58GTuwXdT24e22jj4v+Cr+cvB0W5a+cxpDW4OirB0rU6UfGqQWkDIZ56uxDpv/qRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhLd3b1nar4yU1S6MJpzmY88OWmjjNqgAeaf+zoThac=;
 b=b6jzHbO8CkpnGS6TDIFmscJMpYrGrJA7wWYaxeEGjSfDx7+lKDEEfaPjxlpO0O6jK9EAugx43uBcRFHREglSyGzPI0oUacIzia5VotRfOlIYcV/Mh2awEtWS9eQb0s/KorN2VGhJDEsaJG/W0uFtHYp9hnK+Mnf9d7mKxSsoTHY=
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com (2603:10b6:a03:55a::21)
 by SN7PR18MB3840.namprd18.prod.outlook.com (2603:10b6:806:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Fri, 29 Mar
 2024 10:34:54 +0000
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::317:8d8c:2585:2f58]) by SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::317:8d8c:2585:2f58%3]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 10:34:53 +0000
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: David Howells <dhowells@redhat.com>,
        Christian Brauner
	<christian@brauner.io>,
        Jeff Layton <jlayton@kernel.org>,
        Gao Xiang
	<hsiangkao@linux.alibaba.com>,
        Dominique Martinet <asmadeus@codewreck.org>
CC: Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Eric Van
 Hensbergen <ericvh@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
        "linux-cachefs@redhat.com"
	<linux-cachefs@redhat.com>,
        "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: RE: [PATCH 19/26] netfs: New writeback implementation
Thread-Topic: [PATCH 19/26] netfs: New writeback implementation
Thread-Index: AQHagcS8VsppOmVt4E2Nv+mgINMeMg==
Date: Fri, 29 Mar 2024 10:34:53 +0000
Message-ID: 
 <SJ2PR18MB5635A86C024316BC5E57B79EA23A2@SJ2PR18MB5635.namprd18.prod.outlook.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
 <20240328163424.2781320-20-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-20-dhowells@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR18MB5635:EE_|SN7PR18MB3840:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kd4uTWZQp4qT/5KA/pWLt/dfWzm+SeipRIDu3+WHs+VjfZaY0/j76tFatFvcAYmh5nIaZPzedNfAEk84UKZ1kraHE2EKciaWhNDGMVLI/1LHRY2YzqQNu2gFXQCGmaGNewXtcdgpgjqxZ/rCK/B4rpOEOQIT1/dsXnSniFdEWyuCd1Ya2ipxNHcsLAh54NahNzRSawbnhcVFo2urkMBIxvNDa2eytw2wgqT6bjG1GaWze4tXY2tAjcRdF1+quMoTEfbO9y0iRoqdnC75jZm47HPbPigBg+QyBnyDCSddW4NnuP6Ap7OXAkTNiADyz5ktJI5UsvQFOFxynjkr1R6Dj5VsTG7I3lTXH/JC3K5jS9v5oH4K5H7QclpkCRb7hGlqlSwzQ0KbAXz6/c7UzXgp4WjLVmiz7LYDRzoAzxo5NVUSu/AfevEbzUOvmdXDLcY38+waCY9BDw/HXFYSL7/atJy8g6tXioNKewNB3vsAT1uVUWj3EjwXVY6j/X0nC5fIe8Ibps74LgPM68NVfs02AVw2pUdA/vNO3wKU3B9xaQfhnHhcGsTxPLfQta1hCmCdbUVN6Q9TFlVOcfkMMZHMliAmuCHFNOW09IOCQXwDGlbOXHiS3OfvBVDmpSv8Bq18uUyrXus9sLdbC+2GShXAbhEo8STeBgFRZmWuxTm1+i8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR18MB5635.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?1WffTNxTBwCSa2b/mYUmRLJdXgwkfzUSaP/xk/Z3FBix1MSkylWyWuAisH5H?=
 =?us-ascii?Q?Bnp7vbc9Ao8XozaiZyI+n+ULCltzeeZ8e/s8G1sKgwq8o9x+ZlTuiBtzgj31?=
 =?us-ascii?Q?tW2zp2cWCnye3a+ccMI7XMKBb/SygjNeRIWJ1UMi1hTzHFGaWDe3djAX1POm?=
 =?us-ascii?Q?Zlr1IYy/8CbyOdggjuIuQ1ACyKFwr+Q2fLXbSxWVxKXuE6QyfBWxePGP+Z2b?=
 =?us-ascii?Q?MadMGS8lSITdGZ/zGMowXOSZF0ydIzJ/mJ7ee3aajwCbVTLllGkh3gTgygtT?=
 =?us-ascii?Q?xb7dx4A4K/RdA1CuA0pnAVVXUyRB8OW6ZuP2dXJu0X1FBlnF8pGk4UTLHUZc?=
 =?us-ascii?Q?PTA5o5OIMEjVc9vEVs4OMs2RTNzN2fFBGGxWrsSI/5XNo1nRkJ0TVKgdqYcp?=
 =?us-ascii?Q?ECtquiy5KBTYibOelTbJvQmibaJNmoW/QsSgYdMYBtySEtbETVs7iWyP/Chm?=
 =?us-ascii?Q?QyYwRwVoE2ssgaVc4JRV/X2o/sgudDvBLokHd8Pt11HjqtnZjcquwqppt7Q7?=
 =?us-ascii?Q?EkFuq/r4tttfQcm8sd/YTfOF4HEDHh/3c9wwtuVBE8Ds2DhsnKNTKT057LOO?=
 =?us-ascii?Q?0uXypZHdIhJzQySS/N89unEh16Xa0yQU1Tg/EvyrXkx9boTrB463Fxk7EBHO?=
 =?us-ascii?Q?rcwSymYx5iBY/SRBeo61rJhxUc5zs36R7+yxEfa+GE+aW84jBMIgj6LS0ABh?=
 =?us-ascii?Q?00KF/J+T1faIZwDqy7+z6DXF4AqBWToB01hgcENRkiPhgDQpvyU+TUb4KODW?=
 =?us-ascii?Q?8sR2U89MSiRwNODBaqepj6PNgiuNZ2MtzIJu1F16m4Zdj63nHkBHS8lYN0C2?=
 =?us-ascii?Q?GU9hr18Q2t/qjD32eCC97WPoLdgRmH9uwpAoKniuEbhe6dcGVWlMh0AWN0ct?=
 =?us-ascii?Q?+7UGQB2bqsWAixEdNL5W+kcwfy5AP2dvRrMfm7tc3dlh0tyiVqZcqf2lF3/W?=
 =?us-ascii?Q?lQquAczwiqcHVemXbK40AdD0T9tZGsFktbNIeEb34aU+8Ax88YieSzuryB5Y?=
 =?us-ascii?Q?9Q7lNdR7P7kdmXFoEFchVDfxS4H9PyJLQ6pslxxdAjgnvPW2HKWNU7SFZnX5?=
 =?us-ascii?Q?tUwFpyGNU9Jzs7M2+aCctDX/XHmkTAdLDEgoWPc22oPbdXquIieSqL+uvYzV?=
 =?us-ascii?Q?/j/WFgzKaVuDi3eKAno3Ym0UtmPOIQJjHDS5c4jfXKZePvDv33vfAR5HWMLH?=
 =?us-ascii?Q?Nr32WTrOZ4aM6pHUX159rHJozhbVLyq97ho4v2cxG8QKKbniF7CJs72lDzVi?=
 =?us-ascii?Q?oRkXzBEr41hBnwesiIu/YH7qeAlPkcoZCpk25Z5yLbphp13U2oHbPB5qKn/L?=
 =?us-ascii?Q?5Kn6jX/trfX3/mURkmBP6iH+QmceLzR08IsAgM8xx1HdruLWguzDdCkYSa6i?=
 =?us-ascii?Q?WHlMnC9iDQ8tlR/R49YtB7U3Mn6kkv6hTYf8iGYEiCWdjFaPy2ONMF+FNEgd?=
 =?us-ascii?Q?fAswz9OGFZ6g1nq44mW7F5mYYJOJkaoToShXDU5CU7fpDXcrrso8uvRGlm3y?=
 =?us-ascii?Q?LSRSUg7PF/2g5jw2NGMnsEtvrc1di3/IvfAIocS+S+pfj9h7eH9BrrZNGqep?=
 =?us-ascii?Q?QILVFTK89+6JbEYDvHOev89rm8iRiyDu1tHUGKig?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR18MB5635.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ae4c06-04b0-4075-50fd-08dc4fdbdf0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 10:34:53.7892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFdQIc8HDvUxzlVZ+uHwvkIT9uCAmgcfKcNERhymlb1v93wJPm/5hl7vfWRxG+4oSjjF0FXTUTrAwQLJJuFBiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3840
X-Proofpoint-ORIG-GUID: 5WezCvtI0xlagm0T3OX0bOa21O9uwxal
X-Proofpoint-GUID: 5WezCvtI0xlagm0T3OX0bOa21O9uwxal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_09,2024-03-28_01,2023-05-22_02

> -----Original Message-----
> From: David Howells <dhowells@redhat.com>
> Sent: Thursday, March 28, 2024 10:04 PM
> To: Christian Brauner <christian@brauner.io>; Jeff Layton <jlayton@kernel=
.org>;
> Gao Xiang <hsiangkao@linux.alibaba.com>; Dominique Martinet
> <asmadeus@codewreck.org>
> Cc: David Howells <dhowells@redhat.com>; Matthew Wilcox
> <willy@infradead.org>; Steve French <smfrench@gmail.com>; Marc Dionne
> <marc.dionne@auristor.com>; Paulo Alcantara <pc@manguebit.com>; Shyam
> Prasad N <sprasad@microsoft.com>; Tom Talpey <tom@talpey.com>; Eric Van
> Hensbergen <ericvh@kernel.org>; Ilya Dryomov <idryomov@gmail.com>;
> netfs@lists.linux.dev; linux-cachefs@redhat.com; linux-afs@lists.infradea=
d.org;
> linux-cifs@vger.kernel.org; linux-nfs@vger.kernel.org; ceph-
> devel@vger.kernel.org; v9fs@lists.linux.dev; linux-erofs@lists.ozlabs.org=
; linux-
> fsdevel@vger.kernel.org; linux-mm@kvack.org; netdev@vger.kernel.org; linu=
x-
> kernel@vger.kernel.org; Latchesar Ionkov <lucho@ionkov.net>; Christian
> Schoenebeck <linux_oss@crudebyte.com>
> Subject: [PATCH 19/26] netfs: New writeback implementation
>=20
> The current netfslib writeback implementation creates writeback requests =
of
> contiguous folio data and then separately tiles subrequests over the spac=
e
> twice, once for the server and once for the cache.  This creates a few
> issues:
>=20
>  (1) Every time there's a discontiguity or a change between writing to on=
ly
>      one destination or writing to both, it must create a new request.
>      This makes it harder to do vectored writes.
>=20
>  (2) The folios don't have the writeback mark removed until the end of th=
e
>      request - and a request could be hundreds of megabytes.
>=20
>  (3) In future, I want to support a larger cache granularity, which will
>      require aggregation of some folios that contain unmodified data (whi=
ch
>      only need to go to the cache) and some which contain modifications
>      (which need to be uploaded and stored to the cache) - but, currently=
,
>      these are treated as discontiguous.
>=20
> There's also a move to get everyone to use writeback_iter() to extract
> writable folios from the pagecache.  That said, currently writeback_iter(=
)
> has some issues that make it less than ideal:
>=20
>  (1) there's no way to cancel the iteration, even if you find a "temporar=
y"
>      error that means the current folio and all subsequent folios are goi=
ng
>      to fail;
>=20
>  (2) there's no way to filter the folios being written back - something
>      that will impact Ceph with it's ordered snap system;
>=20
>  (3) and if you get a folio you can't immediately deal with (say you need
>      to flush the preceding writes), you are left with a folio hanging in
>      the locked state for the duration, when really we should unlock it a=
nd
>      relock it later.
>=20
> In this new implementation, I use writeback_iter() to pump folios,
> progressively creating two parallel, but separate streams and cleaning up
> the finished folios as the subrequests complete.  Either or both streams
> can contain gaps, and the subrequests in each stream can be of variable
> size, don't need to align with each other and don't need to align with th=
e
> folios.
>=20
> Indeed, subrequests can cross folio boundaries, may cover several folios =
or
> a folio may be spanned by multiple folios, e.g.:
>=20
>          +---+---+-----+-----+---+----------+
> Folios:  |   |   |     |     |   |          |
>          +---+---+-----+-----+---+----------+
>=20
>            +------+------+     +----+----+
> Upload:    |      |      |.....|    |    |
>            +------+------+     +----+----+
>=20
>          +------+------+------+------+------+
> Cache:   |      |      |      |      |      |
>          +------+------+------+------+------+
>=20
> The progressive subrequest construction permits the algorithm to be
> preparing both the next upload to the server and the next write to the
> cache whilst the previous ones are already in progress.  Throttling can b=
e
> applied to control the rate of production of subrequests - and, in any
> case, we probably want to write them to the server in ascending order,
> particularly if the file will be extended.
>=20
> Content crypto can also be prepared at the same time as the subrequests a=
nd
> run asynchronously, with the prepped requests being stalled until the
> crypto catches up with them.  This might also be useful for transport
> crypto, but that happens at a lower layer, so probably would be harder to
> pull off.
>=20
> The algorithm is split into three parts:
>=20
>  (1) The issuer.  This walks through the data, packaging it up, encryptin=
g
>      it and creating subrequests.  The part of this that generates
>      subrequests only deals with file positions and spans and so is usabl=
e
>      for DIO/unbuffered writes as well as buffered writes.
>=20
>  (2) The collector. This asynchronously collects completed subrequests,
>      unlocks folios, frees crypto buffers and performs any retries.  This
>      runs in a work queue so that the issuer can return to the caller for
>      writeback (so that the VM can have its kswapd thread back) or async
>      writes.
>=20
>  (3) The retryer.  This pauses the issuer, waits for all outstanding
>      subrequests to complete and then goes through the failed subrequests
>      to reissue them.  This may involve reprepping them (with cifs, the
>      credits must be renegotiated, and a subrequest may need splitting),
>      and doing RMW for content crypto if there's a conflicting change on
>      the server.
>=20
> [!] Note that some of the functions are prefixed with "new_" to avoid
> clashes with existing functions.  These will be renamed in a later patch
> that cuts over to the new algorithm.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: v9fs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/Makefile            |   4 +-
>  fs/netfs/buffered_write.c    |   4 -
>  fs/netfs/internal.h          |  27 ++
>  fs/netfs/objects.c           |  17 +
>  fs/netfs/write_collect.c     | 808 +++++++++++++++++++++++++++++++++++
>  fs/netfs/write_issue.c       | 673 +++++++++++++++++++++++++++++
>  include/linux/netfs.h        |  68 ++-
>  include/trace/events/netfs.h | 232 +++++++++-
>  8 files changed, 1824 insertions(+), 9 deletions(-)
>  create mode 100644 fs/netfs/write_collect.c
>  create mode 100644 fs/netfs/write_issue.c
>=20
> diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
> index d4d1d799819e..1eb86e34b5a9 100644
> --- a/fs/netfs/Makefile
> +++ b/fs/netfs/Makefile
> @@ -11,7 +11,9 @@ netfs-y :=3D \
>  	main.o \
>  	misc.o \
>  	objects.o \
> -	output.o
> +	output.o \
> +	write_collect.o \
> +	write_issue.o
>=20
>  netfs-$(CONFIG_NETFS_STATS) +=3D stats.o
>=20
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index 244d67a43972..621532dacef5 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -74,16 +74,12 @@ static enum netfs_how_to_modify
> netfs_how_to_modify(struct netfs_inode *ctx,
>=20
>  	if (file->f_mode & FMODE_READ)
>  		goto no_write_streaming;
> -	if (test_bit(NETFS_ICTX_NO_WRITE_STREAMING, &ctx->flags))
> -		goto no_write_streaming;
>=20
>  	if (netfs_is_cache_enabled(ctx)) {
>  		/* We don't want to get a streaming write on a file that loses
>  		 * caching service temporarily because the backing store got
>  		 * culled.
>  		 */
> -		if (!test_bit(NETFS_ICTX_NO_WRITE_STREAMING, &ctx-
> >flags))
> -			set_bit(NETFS_ICTX_NO_WRITE_STREAMING, &ctx-
> >flags);
>  		goto no_write_streaming;
>  	}
>=20
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index 58289cc65e25..5d3f74a70fa7 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -153,6 +153,33 @@ static inline void netfs_stat_d(atomic_t *stat)
>  #define netfs_stat_d(x) do {} while(0)
>  #endif
>=20
> +/*
> + * write_collect.c
> + */
> +int netfs_folio_written_back(struct folio *folio);
> +void netfs_write_collection_worker(struct work_struct *work);
> +void netfs_wake_write_collector(struct netfs_io_request *wreq, bool
> was_async);
> +
> +/*
> + * write_issue.c
> + */
> +struct netfs_io_request *netfs_create_write_req(struct address_space *ma=
pping,
> +						struct file *file,
> +						loff_t start,
> +						enum netfs_io_origin origin);
> +void netfs_reissue_write(struct netfs_io_stream *stream,
> +			 struct netfs_io_subrequest *subreq);
> +int netfs_advance_write(struct netfs_io_request *wreq,
> +			struct netfs_io_stream *stream,
> +			loff_t start, size_t len, bool to_eof);
> +struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *iocb=
, size_t
> len);
> +int new_netfs_advance_writethrough(struct netfs_io_request *wreq, struct
> writeback_control *wbc,
> +				   struct folio *folio, size_t copied, bool
> to_page_end,
> +				   struct folio **writethrough_cache);
> +int new_netfs_end_writethrough(struct netfs_io_request *wreq, struct
> writeback_control *wbc,
> +			       struct folio *writethrough_cache);
> +int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait,=
 size_t
> len);
> +
>  /*
>   * Miscellaneous functions.
>   */
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 1a4e2ce735ce..c90d482b1650 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -47,6 +47,10 @@ struct netfs_io_request *netfs_alloc_request(struct
> address_space *mapping,
>  	rreq->inode	=3D inode;
>  	rreq->i_size	=3D i_size_read(inode);
>  	rreq->debug_id	=3D atomic_inc_return(&debug_ids);
> +	rreq->wsize	=3D INT_MAX;
> +	spin_lock_init(&rreq->lock);
> +	INIT_LIST_HEAD(&rreq->io_streams[0].subrequests);
> +	INIT_LIST_HEAD(&rreq->io_streams[1].subrequests);
>  	INIT_LIST_HEAD(&rreq->subrequests);
>  	INIT_WORK(&rreq->work, NULL);
>  	refcount_set(&rreq->ref, 1);
> @@ -85,6 +89,8 @@ void netfs_get_request(struct netfs_io_request *rreq, e=
num
> netfs_rreq_ref_trace
>  void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_asy=
nc)
>  {
>  	struct netfs_io_subrequest *subreq;
> +	struct netfs_io_stream *stream;
> +	int s;
>=20
>  	while (!list_empty(&rreq->subrequests)) {
>  		subreq =3D list_first_entry(&rreq->subrequests,
> @@ -93,6 +99,17 @@ void netfs_clear_subrequests(struct netfs_io_request
> *rreq, bool was_async)
>  		netfs_put_subrequest(subreq, was_async,
>  				     netfs_sreq_trace_put_clear);
>  	}
> +
> +	for (s =3D 0; s < ARRAY_SIZE(rreq->io_streams); s++) {
> +		stream =3D &rreq->io_streams[s];
> +		while (!list_empty(&stream->subrequests)) {
> +			subreq =3D list_first_entry(&stream->subrequests,
> +						  struct netfs_io_subrequest,
> rreq_link);
> +			list_del(&subreq->rreq_link);
> +			netfs_put_subrequest(subreq, was_async,
> +					     netfs_sreq_trace_put_clear);
> +		}
> +	}
>  }
>=20
>  static void netfs_free_request_rcu(struct rcu_head *rcu)
> diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
> new file mode 100644
> index 000000000000..5e2ca8b25af0
> --- /dev/null
> +++ b/fs/netfs/write_collect.c
> @@ -0,0 +1,808 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Network filesystem write subrequest result collection, assessment
> + * and retrying.
> + *
> + * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/export.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/pagemap.h>
> +#include <linux/slab.h>
> +#include "internal.h"
> +
> +/* Notes made in the collector */
> +#define HIT_PENDING		0x01	/* A front op was still pending */
> +#define SOME_EMPTY		0x02	/* One of more streams are empty
> */
> +#define ALL_EMPTY		0x04	/* All streams are empty */
> +#define MAYBE_DISCONTIG		0x08	/* A front op may be
> discontiguous (rounded to PAGE_SIZE) */
> +#define NEED_REASSESS		0x10	/* Need to loop round and
> reassess */
> +#define REASSESS_DISCONTIG	0x20	/* Reassess discontiguity if
> contiguity advances */
> +#define MADE_PROGRESS		0x40	/* Made progress cleaning up a
> stream or the folio set */
> +#define BUFFERED		0x80	/* The pagecache needs cleaning up */
> +#define NEED_RETRY		0x100	/* A front op requests retrying */
> +#define SAW_FAILURE		0x200	/* One stream or hit a permanent
> failure */
> +
> +/*
> + * Successful completion of write of a folio to the server and/or cache.=
  Note
> + * that we are not allowed to lock the folio here on pain of deadlocking=
 with
> + * truncate.
> + */
> +int netfs_folio_written_back(struct folio *folio)
> +{
> +	enum netfs_folio_trace why =3D netfs_folio_trace_clear;
> +	struct netfs_folio *finfo;
> +	struct netfs_group *group =3D NULL;
> +	int gcount =3D 0;

Reverse xmas tree order missing in multiple functions.

> +
> +	if ((finfo =3D netfs_folio_info(folio))) {
> +		/* Streaming writes cannot be redirtied whilst under writeback,
> +		 * so discard the streaming record.
> +		 */
> +		folio_detach_private(folio);
> +		group =3D finfo->netfs_group;
> +		gcount++;
> +		kfree(finfo);
> +		why =3D netfs_folio_trace_clear_s;
> +		goto end_wb;
> +	}
> +
> +	if ((group =3D netfs_folio_group(folio))) {
> +		if (group =3D=3D NETFS_FOLIO_COPY_TO_CACHE) {
> +			why =3D netfs_folio_trace_clear_cc;
> +			if (group =3D=3D NETFS_FOLIO_COPY_TO_CACHE)
> +				folio_detach_private(folio);
> +			else
> +				why =3D netfs_folio_trace_redirtied;
> +			goto end_wb;
> +		}
> +
> +		/* Need to detach the group pointer if the page didn't get
> +		 * redirtied.  If it has been redirtied, then it must be within
> +		 * the same group.
> +		 */
> +		why =3D netfs_folio_trace_redirtied;
> +		if (!folio_test_dirty(folio)) {
> +			if (!folio_test_dirty(folio)) {
> +				folio_detach_private(folio);
> +				gcount++;
> +				why =3D netfs_folio_trace_clear_g;
> +			}
> +		}
> +	}
> +
> +end_wb:
> +	trace_netfs_folio(folio, why);
> +	folio_end_writeback(folio);
> +	return gcount;
> +}
> +
> +/*
> + * Get hold of a folio we have under writeback.  We don't want to get th=
e
> + * refcount on it.
> + */
> +static struct folio *netfs_writeback_lookup_folio(struct netfs_io_reques=
t *wreq,
> loff_t pos)
> +{
> +	XA_STATE(xas, &wreq->mapping->i_pages, pos / PAGE_SIZE);
> +	struct folio *folio;
> +
> +	rcu_read_lock();
> +
> +	for (;;) {
> +		xas_reset(&xas);
> +		folio =3D xas_load(&xas);
> +		if (xas_retry(&xas, folio))
> +			continue;
> +
> +		if (!folio || xa_is_value(folio))
> +			kdebug("R=3D%08x: folio %lx (%llx) not present",
> +			       wreq->debug_id, xas.xa_index, pos / PAGE_SIZE);
> +		BUG_ON(!folio || xa_is_value(folio));
> +
> +		if (folio =3D=3D xas_reload(&xas))
> +			break;
> +	}
> +
> +	rcu_read_unlock();
> +
> +	if (WARN_ONCE(!folio_test_writeback(folio),
> +		      "R=3D%08x: folio %lx is not under writeback\n",
> +		      wreq->debug_id, folio->index)) {
> +		trace_netfs_folio(folio, netfs_folio_trace_not_under_wback);
> +	}
> +	return folio;
> +}
> +
> +/*
> + * Unlock any folios we've finished with.
> + */
> +static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
> +					  unsigned long long collected_to,
> +					  unsigned int *notes)
> +{
> +	for (;;) {
> +		struct folio *folio;
> +		struct netfs_folio *finfo;
> +		unsigned long long fpos, fend;
> +		size_t fsize, flen;
> +
> +		folio =3D netfs_writeback_lookup_folio(wreq, wreq->cleaned_to);
> +
> +		fpos =3D folio_pos(folio);
> +		fsize =3D folio_size(folio);
> +		finfo =3D netfs_folio_info(folio);
> +		flen =3D finfo ? finfo->dirty_offset + finfo->dirty_len : fsize;
> +
> +		fend =3D min_t(unsigned long long, fpos + flen, wreq->i_size);
> +
> +		trace_netfs_collect_folio(wreq, folio, fend, collected_to);
> +
> +		if (fpos + fsize > wreq->contiguity) {
> +			trace_netfs_collect_contig(wreq, fpos + fsize,
> +						   netfs_contig_trace_unlock);
> +			wreq->contiguity =3D fpos + fsize;
> +		}
> +
> +		/* Unlock any folio we've transferred all of. */
> +		if (collected_to < fend)
> +			break;
> +
> +		wreq->nr_group_rel +=3D netfs_folio_written_back(folio);
> +		wreq->cleaned_to =3D fpos + fsize;
> +		*notes |=3D MADE_PROGRESS;
> +
> +		if (fpos + fsize >=3D collected_to)
> +			break;
> +	}
> +}
> +
> +/*
> + * Perform retries on the streams that need it.
> + */
> +static void netfs_retry_write_stream(struct netfs_io_request *wreq,
> +				     struct netfs_io_stream *stream)
> +{
> +	struct list_head *next;
> +
> +	_enter("R=3D%x[%x:]", wreq->debug_id, stream->stream_nr);
> +
> +	if (unlikely(stream->failed))
> +		return;
> +
> +	/* If there's no renegotiation to do, just resend each failed subreq. *=
/
> +	if (!stream->prepare_write) {
> +		struct netfs_io_subrequest *subreq;
> +
> +		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
> +			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
> +				break;
> +			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY,
> &subreq->flags)) {
> +				__set_bit(NETFS_SREQ_RETRYING, &subreq-
> >flags);
> +				netfs_get_subrequest(subreq,
> netfs_sreq_trace_get_resubmit);
> +				netfs_reissue_write(stream, subreq);
> +			}
> +		}
> +		return;
> +	}
> +
> +	if (list_empty(&stream->subrequests))
> +		return;
> +	next =3D stream->subrequests.next;
> +
> +	do {
> +		struct netfs_io_subrequest *subreq =3D NULL, *from, *to, *tmp;
> +		unsigned long long start, len;
> +		size_t part;
> +		bool boundary =3D false;
> +
> +		/* Go through the stream and find the next span of contiguous
> +		 * data that we then rejig (cifs, for example, needs the wsize
> +		 * renegotiating) and reissue.
> +		 */
> +		from =3D list_entry(next, struct netfs_io_subrequest, rreq_link);
> +		to =3D from;
> +		start =3D from->start + from->transferred;
> +		len   =3D from->len   - from->transferred;
> +
> +		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
> +		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
> +			return;
> +
> +		list_for_each_continue(next, &stream->subrequests) {
> +			subreq =3D list_entry(next, struct netfs_io_subrequest,
> rreq_link);
> +			if (subreq->start + subreq->transferred !=3D start + len ||
> +			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags)
> ||
> +			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq-
> >flags))
> +				break;
> +			to =3D subreq;
> +			len +=3D to->len;
> +		}
> +
> +		/* Work through the sublist. */
> +		subreq =3D from;
> +		list_for_each_entry_from(subreq, &stream->subrequests,
> rreq_link) {
> +			if (!len)
> +				break;
> +			/* Renegotiate max_len (wsize) */
> +			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
> +			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq-
> >flags);
> +			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> +			stream->prepare_write(subreq);
> +
> +			part =3D min(len, subreq->max_len);
> +			subreq->len =3D part;
> +			subreq->start =3D start;
> +			subreq->transferred =3D 0;
> +			len -=3D part;
> +			start +=3D part;
> +			if (len && subreq =3D=3D to &&
> +			    __test_and_clear_bit(NETFS_SREQ_BOUNDARY, &to-
> >flags))
> +				boundary =3D true;
> +
> +			netfs_get_subrequest(subreq,
> netfs_sreq_trace_get_resubmit);
> +			netfs_reissue_write(stream, subreq);
> +			if (subreq =3D=3D to)
> +				break;
> +		}
> +
> +		/* If we managed to use fewer subreqs, we can discard the
> +		 * excess; if we used the same number, then we're done.
> +		 */
> +		if (!len) {
> +			if (subreq =3D=3D to)
> +				continue;
> +			list_for_each_entry_safe_from(subreq, tmp,
> +						      &stream->subrequests,
> rreq_link) {
> +				trace_netfs_sreq(subreq,
> netfs_sreq_trace_discard);
> +				list_del(&subreq->rreq_link);
> +				netfs_put_subrequest(subreq, false,
> netfs_sreq_trace_put_done);
> +				if (subreq =3D=3D to)
> +					break;
> +			}
> +			continue;
> +		}
> +
> +		/* We ran out of subrequests, so we need to allocate some more
> +		 * and insert them after.
> +		 */
> +		do {
> +			subreq =3D netfs_alloc_subrequest(wreq);
> +			subreq->source		=3D to->source;
> +			subreq->start		=3D start;
> +			subreq->max_len		=3D len;
> +			subreq->max_nr_segs	=3D INT_MAX;
> +			subreq->debug_index	=3D atomic_inc_return(&wreq-
> >subreq_counter);
> +			subreq->stream_nr	=3D to->stream_nr;
> +			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> +
> +			trace_netfs_sreq_ref(wreq->debug_id, subreq-
> >debug_index,
> +					     refcount_read(&subreq->ref),
> +					     netfs_sreq_trace_new);
> +			netfs_get_subrequest(subreq,
> netfs_sreq_trace_get_resubmit);
> +
> +			list_add(&subreq->rreq_link, &to->rreq_link);
> +			to =3D list_next_entry(to, rreq_link);
> +			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
> +
> +			switch (stream->source) {
> +			case NETFS_UPLOAD_TO_SERVER:
> +				netfs_stat(&netfs_n_wh_upload);
> +				subreq->max_len =3D min(len, wreq->wsize);
> +				break;
> +			case NETFS_WRITE_TO_CACHE:
> +				netfs_stat(&netfs_n_wh_write);
> +				break;
> +			default:
> +				WARN_ON_ONCE(1);
> +			}
> +
> +			stream->prepare_write(subreq);
> +
> +			part =3D min(len, subreq->max_len);
> +			subreq->len =3D subreq->transferred + part;
> +			len -=3D part;
> +			start +=3D part;
> +			if (!len && boundary) {
> +				__set_bit(NETFS_SREQ_BOUNDARY, &to-
> >flags);
> +				boundary =3D false;
> +			}
> +
> +			netfs_reissue_write(stream, subreq);
> +			if (!len)
> +				break;
> +
> +		} while (len);
> +
> +	} while (!list_is_head(next, &stream->subrequests));
> +}
> +
> +/*
> + * Perform retries on the streams that need it.  If we're doing content
> + * encryption and the server copy changed due to a third-party write, we=
 may
> + * need to do an RMW cycle and also rewrite the data to the cache.
> + */
> +static void netfs_retry_writes(struct netfs_io_request *wreq)
> +{
> +	struct netfs_io_subrequest *subreq;
> +	struct netfs_io_stream *stream;
> +	int s;
> +
> +	/* Wait for all outstanding I/O to quiesce before performing retries as
> +	 * we may need to renegotiate the I/O sizes.
> +	 */
> +	for (s =3D 0; s < NR_IO_STREAMS; s++) {
> +		stream =3D &wreq->io_streams[s];
> +		if (!stream->active)
> +			continue;
> +
> +		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
> +			wait_on_bit(&subreq->flags,
> NETFS_SREQ_IN_PROGRESS,
> +				    TASK_UNINTERRUPTIBLE);
> +		}
> +	}
> +
> +	// TODO: Enc: Fetch changed partial pages
> +	// TODO: Enc: Reencrypt content if needed.
> +	// TODO: Enc: Wind back transferred point.
> +	// TODO: Enc: Mark cache pages for retry.
> +
> +	for (s =3D 0; s < NR_IO_STREAMS; s++) {
> +		stream =3D &wreq->io_streams[s];
> +		if (stream->need_retry) {
> +			stream->need_retry =3D false;
> +			netfs_retry_write_stream(wreq, stream);
> +		}
> +	}
> +}
> +
> +/*
> + * Collect and assess the results of various write subrequests.  We may =
need to
> + * retry some of the results - or even do an RMW cycle for content crypt=
o.
> + *
> + * Note that we have a number of parallel, overlapping lists of subreque=
sts,
> + * one to the server and one to the local cache for example, which may n=
ot be
> + * the same size or starting position and may not even correspond in bou=
ndary
> + * alignment.
> + */
> +static void netfs_collect_write_results(struct netfs_io_request *wreq)
> +{
> +	struct netfs_io_subrequest *front, *remove;
> +	struct netfs_io_stream *stream;
> +	unsigned long long collected_to;
> +	unsigned int notes;
> +	int s;
> +
> +	_enter("%llx-%llx", wreq->start, wreq->start + wreq->len);
> +	trace_netfs_collect(wreq);
> +	trace_netfs_rreq(wreq, netfs_rreq_trace_collect);
> +
> +reassess_streams:
> +	smp_rmb();
> +	collected_to =3D ULLONG_MAX;
> +	if (wreq->origin =3D=3D NETFS_WRITEBACK)
> +		notes =3D ALL_EMPTY | BUFFERED | MAYBE_DISCONTIG;
> +	else if (wreq->origin =3D=3D NETFS_WRITETHROUGH)
> +		notes =3D ALL_EMPTY | BUFFERED;
> +	else
> +		notes =3D ALL_EMPTY;
> +
> +	/* Remove completed subrequests from the front of the streams and
> +	 * advance the completion point on each stream.  We stop when we hit
> +	 * something that's in progress.  The issuer thread may be adding stuff
> +	 * to the tail whilst we're doing this.
> +	 *
> +	 * We must not, however, merge in discontiguities that span whole
> +	 * folios that aren't under writeback.  This is made more complicated
> +	 * by the folios in the gap being of unpredictable sizes - if they even
> +	 * exist - but we don't want to look them up.
> +	 */
> +	for (s =3D 0; s < NR_IO_STREAMS; s++) {
> +		loff_t rstart, rend;
> +
> +		stream =3D &wreq->io_streams[s];
> +		/* Read active flag before list pointers */
> +		if (!smp_load_acquire(&stream->active))
> +			continue;
> +
> +		front =3D stream->front;
> +		while (front) {
> +			trace_netfs_collect_sreq(wreq, front);
> +			//_debug("sreq [%x] %llx %zx/%zx",
> +			//       front->debug_index, front->start, front->transferred,
> front->len);
> +
> +			/* Stall if there may be a discontinuity. */
> +			rstart =3D round_down(front->start, PAGE_SIZE);
> +			if (rstart > wreq->contiguity) {
> +				if (wreq->contiguity > stream->collected_to) {
> +					trace_netfs_collect_gap(wreq, stream,
> +								wreq->contiguity,
> 'D');
> +					stream->collected_to =3D wreq->contiguity;
> +				}
> +				notes |=3D REASSESS_DISCONTIG;
> +				break;
> +			}
> +			rend =3D round_up(front->start + front->len, PAGE_SIZE);
> +			if (rend > wreq->contiguity) {
> +				trace_netfs_collect_contig(wreq, rend,
> +
> netfs_contig_trace_collect);
> +				wreq->contiguity =3D rend;
> +				if (notes & REASSESS_DISCONTIG)
> +					notes |=3D NEED_REASSESS;
> +			}
> +			notes &=3D ~MAYBE_DISCONTIG;
> +
> +			/* Stall if the front is still undergoing I/O. */
> +			if (test_bit(NETFS_SREQ_IN_PROGRESS, &front-
> >flags)) {
> +				notes |=3D HIT_PENDING;
> +				break;
> +			}
> +			smp_rmb(); /* Read counters after I-P flag. */
> +
> +			if (stream->failed) {
> +				stream->collected_to =3D front->start + front->len;
> +				notes |=3D MADE_PROGRESS | SAW_FAILURE;
> +				goto cancel;
> +			}
> +			if (front->start + front->transferred > stream-
> >collected_to) {
> +				stream->collected_to =3D front->start + front-
> >transferred;
> +				stream->transferred =3D stream->collected_to -
> wreq->start;
> +				notes |=3D MADE_PROGRESS;
> +			}
> +			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
> +				stream->failed =3D true;
> +				stream->error =3D front->error;
> +				if (stream->source =3D=3D
> NETFS_UPLOAD_TO_SERVER)
> +					mapping_set_error(wreq->mapping, front-
> >error);
> +				notes |=3D NEED_REASSESS | SAW_FAILURE;
> +				break;
> +			}
> +			if (front->transferred < front->len) {
> +				stream->need_retry =3D true;
> +				notes |=3D NEED_RETRY | MADE_PROGRESS;
> +				break;
> +			}
> +
> +		cancel:
> +			/* Remove if completely consumed. */
> +			spin_lock(&wreq->lock);
> +
> +			remove =3D front;
> +			list_del_init(&front->rreq_link);
> +			front =3D list_first_entry_or_null(&stream->subrequests,
> +							 struct
> netfs_io_subrequest, rreq_link);
> +			stream->front =3D front;
> +			if (!front) {
> +				unsigned long long jump_to =3D
> atomic64_read(&wreq->issued_to);
> +
> +				if (stream->collected_to < jump_to) {
> +					trace_netfs_collect_gap(wreq, stream,
> jump_to, 'A');
> +					stream->collected_to =3D jump_to;
> +				}
> +			}
> +
> +			spin_unlock(&wreq->lock);
> +			netfs_put_subrequest(remove, false,
> +					     notes & SAW_FAILURE ?
> +					     netfs_sreq_trace_put_cancel :
> +					     netfs_sreq_trace_put_done);
> +		}
> +
> +		if (front)
> +			notes &=3D ~ALL_EMPTY;
> +		else
> +			notes |=3D SOME_EMPTY;
> +
> +		if (stream->collected_to < collected_to)
> +			collected_to =3D stream->collected_to;
> +	}
> +
> +	if (collected_to !=3D ULLONG_MAX && collected_to > wreq->collected_to)
> +		wreq->collected_to =3D collected_to;
> +
> +	/* If we have an empty stream, we need to jump it forward over any gap
> +	 * otherwise the collection point will never advance.
> +	 *
> +	 * Note that the issuer always adds to the stream with the lowest
> +	 * so-far submitted start, so if we see two consecutive subreqs in one
> +	 * stream with nothing between then in another stream, then the second
> +	 * stream has a gap that can be jumped.
> +	 */
> +	if (notes & SOME_EMPTY) {
> +		unsigned long long jump_to =3D wreq->start + wreq->len;
> +
> +		for (s =3D 0; s < NR_IO_STREAMS; s++) {
> +			stream =3D &wreq->io_streams[s];
> +			if (stream->active &&
> +			    stream->front &&
> +			    stream->front->start < jump_to)
> +				jump_to =3D stream->front->start;
> +		}
> +
> +		for (s =3D 0; s < NR_IO_STREAMS; s++) {
> +			stream =3D &wreq->io_streams[s];
> +			if (stream->active &&
> +			    !stream->front &&
> +			    stream->collected_to < jump_to) {
> +				trace_netfs_collect_gap(wreq, stream, jump_to,
> 'B');
> +				stream->collected_to =3D jump_to;
> +			}
> +		}
> +	}
> +
> +	for (s =3D 0; s < NR_IO_STREAMS; s++) {
> +		stream =3D &wreq->io_streams[s];
> +		if (stream->active)
> +			trace_netfs_collect_stream(wreq, stream);
> +	}
> +
> +	trace_netfs_collect_state(wreq, wreq->collected_to, notes);
> +
> +	/* Unlock any folios that we have now finished with. */
> +	if (notes & BUFFERED) {
> +		unsigned long long clean_to =3D min(wreq->collected_to, wreq-
> >contiguity);
> +
> +		if (wreq->cleaned_to < clean_to)
> +			netfs_writeback_unlock_folios(wreq, clean_to, &notes);
> +	} else {
> +		wreq->cleaned_to =3D wreq->collected_to;
> +	}
> +
> +	// TODO: Discard encryption buffers
> +
> +	/* If all streams are discontiguous with the last folio we cleared, we
> +	 * may need to skip a set of folios.
> +	 */
> +	if ((notes & (MAYBE_DISCONTIG | ALL_EMPTY)) =3D=3D
> MAYBE_DISCONTIG) {
> +		unsigned long long jump_to =3D ULLONG_MAX;
> +
> +		for (s =3D 0; s < NR_IO_STREAMS; s++) {
> +			stream =3D &wreq->io_streams[s];
> +			if (stream->active && stream->front &&
> +			    stream->front->start < jump_to)
> +				jump_to =3D stream->front->start;
> +		}
> +
> +		trace_netfs_collect_contig(wreq, jump_to,
> netfs_contig_trace_jump);
> +		wreq->contiguity =3D jump_to;
> +		wreq->cleaned_to =3D jump_to;
> +		wreq->collected_to =3D jump_to;
> +		for (s =3D 0; s < NR_IO_STREAMS; s++) {
> +			stream =3D &wreq->io_streams[s];
> +			if (stream->collected_to < jump_to)
> +				stream->collected_to =3D jump_to;
> +		}
> +		//cond_resched();
> +		notes |=3D MADE_PROGRESS;
> +		goto reassess_streams;
> +	}
> +
> +	if (notes & NEED_RETRY)
> +		goto need_retry;
> +	if ((notes & MADE_PROGRESS) && test_bit(NETFS_RREQ_PAUSE,
> &wreq->flags)) {
> +		trace_netfs_rreq(wreq, netfs_rreq_trace_unpause);
> +		clear_bit_unlock(NETFS_RREQ_PAUSE, &wreq->flags);
> +		wake_up_bit(&wreq->flags, NETFS_RREQ_PAUSE);
> +	}
> +
> +	if (notes & NEED_REASSESS) {
> +		//cond_resched();
> +		goto reassess_streams;
> +	}
> +	if (notes & MADE_PROGRESS) {
> +		//cond_resched();
> +		goto reassess_streams;
> +	}
> +
> +out:
> +	netfs_put_group_many(wreq->group, wreq->nr_group_rel);
> +	wreq->nr_group_rel =3D 0;
> +	_leave(" =3D %x", notes);
> +	return;
> +
> +need_retry:
> +	/* Okay...  We're going to have to retry one or both streams.  Note
> +	 * that any partially completed op will have had any wholly transferred
> +	 * folios removed from it.
> +	 */
> +	_debug("retry");
> +	netfs_retry_writes(wreq);
> +	goto out;
> +}
> +
> +/*
> + * Perform the collection of subrequests, folios and encryption buffers.
> + */
> +void netfs_write_collection_worker(struct work_struct *work)
> +{
> +	struct netfs_io_request *wreq =3D container_of(work, struct
> netfs_io_request, work);
> +	struct netfs_inode *ictx =3D netfs_inode(wreq->inode);
> +	size_t transferred;
> +	int s;
> +
> +	_enter("R=3D%x", wreq->debug_id);
> +
> +	netfs_see_request(wreq, netfs_rreq_trace_see_work);
> +	if (!test_bit(NETFS_RREQ_IN_PROGRESS, &wreq->flags)) {
> +		netfs_put_request(wreq, false, netfs_rreq_trace_put_work);
> +		return;
> +	}
> +
> +	netfs_collect_write_results(wreq);
> +
> +	/* We're done when the app thread has finished posting subreqs and all
> +	 * the queues in all the streams are empty.
> +	 */
> +	if (!test_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags)) {
> +		netfs_put_request(wreq, false, netfs_rreq_trace_put_work);
> +		return;
> +	}
> +	smp_rmb(); /* Read ALL_QUEUED before lists. */
> +
> +	transferred =3D LONG_MAX;
> +	for (s =3D 0; s < NR_IO_STREAMS; s++) {
> +		struct netfs_io_stream *stream =3D &wreq->io_streams[s];
> +		if (!stream->active)
> +			continue;
> +		if (!list_empty(&stream->subrequests)) {
> +			netfs_put_request(wreq, false,
> netfs_rreq_trace_put_work);
> +			return;
> +		}
> +		if (stream->transferred < transferred)
> +			transferred =3D stream->transferred;
> +	}
> +
> +	/* Okay, declare that all I/O is complete. */
> +	wreq->transferred =3D transferred;
> +	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
> +
> +	if (wreq->io_streams[1].active &&
> +	    wreq->io_streams[1].failed) {
> +		/* Cache write failure doesn't prevent writeback completion
> +		 * unless we're in disconnected mode.
> +		 */
> +		ictx->ops->invalidate_cache(wreq);
> +	}
> +
> +	if (wreq->cleanup)
> +		wreq->cleanup(wreq);
> +
> +	if (wreq->origin =3D=3D NETFS_DIO_WRITE &&
> +	    wreq->mapping->nrpages) {
> +		/* mmap may have got underfoot and we may now have folios
> +		 * locally covering the region we just wrote.  Attempt to
> +		 * discard the folios, but leave in place any modified locally.
> +		 * ->write_iter() is prevented from interfering by the DIO
> +		 * counter.
> +		 */
> +		pgoff_t first =3D wreq->start >> PAGE_SHIFT;
> +		pgoff_t last =3D (wreq->start + wreq->transferred - 1) >>
> PAGE_SHIFT;
> +		invalidate_inode_pages2_range(wreq->mapping, first, last);
> +	}
> +
> +	if (wreq->origin =3D=3D NETFS_DIO_WRITE)
> +		inode_dio_end(wreq->inode);
> +
> +	_debug("finished");
> +	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
> +	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
> +	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
> +
> +	if (wreq->iocb) {
> +		wreq->iocb->ki_pos +=3D wreq->transferred;
> +		if (wreq->iocb->ki_complete)
> +			wreq->iocb->ki_complete(
> +				wreq->iocb, wreq->error ? wreq->error : wreq-
> >transferred);
> +		wreq->iocb =3D VFS_PTR_POISON;
> +	}
> +
> +	netfs_clear_subrequests(wreq, false);
> +	netfs_put_request(wreq, false, netfs_rreq_trace_put_work_complete);
> +}
> +
> +/*
> + * Wake the collection work item.
> + */
> +void netfs_wake_write_collector(struct netfs_io_request *wreq, bool was_=
async)
> +{
> +	if (!work_pending(&wreq->work)) {
> +		netfs_get_request(wreq, netfs_rreq_trace_get_work);
> +		if (!queue_work(system_unbound_wq, &wreq->work))
> +			netfs_put_request(wreq, was_async,
> netfs_rreq_trace_put_work_nq);
> +	}
> +}
> +
> +/**
> + * new_netfs_write_subrequest_terminated - Note the termination of a wri=
te
> operation.
> + * @_op: The I/O request that has terminated.
> + * @transferred_or_error: The amount of data transferred or an error cod=
e.
> + * @was_async: The termination was asynchronous
> + *
> + * This tells the library that a contributory write I/O operation has
> + * terminated, one way or another, and that it should collect the result=
s.
> + *
> + * The caller indicates in @transferred_or_error the outcome of the oper=
ation,
> + * supplying a positive value to indicate the number of bytes transferre=
d or a
> + * negative error code.  The library will look after reissuing I/O opera=
tions
> + * as appropriate and writing downloaded data to the cache.
> + *
> + * If @was_async is true, the caller might be running in softirq or inte=
rrupt
> + * context and we can't sleep.
> + *
> + * When this is called, ownership of the subrequest is transferred back =
to the
> + * library, along with a ref.
> + *
> + * Note that %_op is a void* so that the function can be passed to
> + * kiocb::term_func without the need for a casting wrapper.
> + */
> +void new_netfs_write_subrequest_terminated(void *_op, ssize_t
> transferred_or_error,
> +					   bool was_async)
> +{
> +	struct netfs_io_subrequest *subreq =3D _op;
> +	struct netfs_io_request *wreq =3D subreq->rreq;
> +	struct netfs_io_stream *stream =3D &wreq->io_streams[subreq-
> >stream_nr];
> +
> +	_enter("%x[%x] %zd", wreq->debug_id, subreq->debug_index,
> transferred_or_error);
> +
> +	switch (subreq->source) {
> +	case NETFS_UPLOAD_TO_SERVER:
> +		netfs_stat(&netfs_n_wh_upload_done);
> +		break;
> +	case NETFS_WRITE_TO_CACHE:
> +		netfs_stat(&netfs_n_wh_write_done);
> +		break;
> +	case NETFS_INVALID_WRITE:
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	if (IS_ERR_VALUE(transferred_or_error)) {
> +		subreq->error =3D transferred_or_error;
> +		if (subreq->error =3D=3D -EAGAIN)
> +			set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> +		else
> +			set_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +		trace_netfs_failure(wreq, subreq, transferred_or_error,
> netfs_fail_write);
> +
> +		switch (subreq->source) {
> +		case NETFS_WRITE_TO_CACHE:
> +			netfs_stat(&netfs_n_wh_write_failed);
> +			break;
> +		case NETFS_UPLOAD_TO_SERVER:
> +			netfs_stat(&netfs_n_wh_upload_failed);
> +			break;
> +		default:
> +			break;
> +		}
> +		trace_netfs_rreq(wreq, netfs_rreq_trace_set_pause);
> +		set_bit(NETFS_RREQ_PAUSE, &wreq->flags);
> +	} else {
> +		if (WARN(transferred_or_error > subreq->len - subreq-
> >transferred,
> +			 "Subreq excess write: R=3D%x[%x] %zd > %zu - %zu",
> +			 wreq->debug_id, subreq->debug_index,
> +			 transferred_or_error, subreq->len, subreq->transferred))
> +			transferred_or_error =3D subreq->len - subreq->transferred;
> +
> +		subreq->error =3D 0;
> +		subreq->transferred +=3D transferred_or_error;
> +
> +		if (subreq->transferred < subreq->len)
> +			set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> +	}
> +
> +	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
> +
> +	clear_bit_unlock(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
> +	wake_up_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS);
> +
> +	/* If we are at the head of the queue, wake up the collector,
> +	 * transferring a ref to it if we were the ones to do so.
> +	 */
> +	if (list_is_first(&subreq->rreq_link, &stream->subrequests))
> +		netfs_wake_write_collector(wreq, was_async);
> +
> +	netfs_put_subrequest(subreq, was_async,
> netfs_sreq_trace_put_terminated);
> +}
> +EXPORT_SYMBOL(new_netfs_write_subrequest_terminated);
> diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> new file mode 100644
> index 000000000000..e0fb472898f5
> --- /dev/null
> +++ b/fs/netfs/write_issue.c
> @@ -0,0 +1,673 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Network filesystem high-level (buffered) writeback.
> + *
> + * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + *
> + * To support network filesystems with local caching, we manage a situat=
ion
> + * that can be envisioned like the following:
> + *
> + *               +---+---+-----+-----+---+----------+
> + *    Folios:    |   |   |     |     |   |          |
> + *               +---+---+-----+-----+---+----------+
> + *
> + *                 +------+------+     +----+----+
> + *    Upload:      |      |      |.....|    |    |
> + *  (Stream 0)     +------+------+     +----+----+
> + *
> + *               +------+------+------+------+------+
> + *    Cache:     |      |      |      |      |      |
> + *  (Stream 1)   +------+------+------+------+------+
> + *
> + * Where we have a sequence of folios of varying sizes that we need to o=
verlay
> + * with multiple parallel streams of I/O requests, where the I/O request=
s in a
> + * stream may also be of various sizes (in cifs, for example, the sizes =
are
> + * negotiated with the server; in something like ceph, they may represen=
t the
> + * sizes of storage objects).
> + *
> + * The sequence in each stream may contain gaps and noncontiguous
> subrequests
> + * may be glued together into single vectored write RPCs.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/pagemap.h>
> +#include "internal.h"
> +
> +/*
> + * Kill all dirty folios in the event of an unrecoverable error, startin=
g with
> + * a locked folio we've already obtained from writeback_iter().
> + */
> +static void netfs_kill_dirty_pages(struct address_space *mapping,
> +				   struct writeback_control *wbc,
> +				   struct folio *folio)
> +{
> +	int error =3D 0;
> +
> +	do {
> +		enum netfs_folio_trace why =3D netfs_folio_trace_kill;
> +		struct netfs_group *group =3D NULL;
> +		struct netfs_folio *finfo =3D NULL;
> +		void *priv;
> +
> +		priv =3D folio_detach_private(folio);
> +		if (priv) {
> +			finfo =3D __netfs_folio_info(priv);
> +			if (finfo) {
> +				/* Kill folio from streaming write. */
> +				group =3D finfo->netfs_group;
> +				why =3D netfs_folio_trace_kill_s;
> +			} else {
> +				group =3D priv;
> +				if (group =3D=3D NETFS_FOLIO_COPY_TO_CACHE)
> {
> +					/* Kill copy-to-cache folio */
> +					why =3D netfs_folio_trace_kill_cc;
> +					group =3D NULL;
> +				} else {
> +					/* Kill folio with group */
> +					why =3D netfs_folio_trace_kill_g;
> +				}
> +			}
> +		}
> +
> +		trace_netfs_folio(folio, why);
> +
> +		folio_start_writeback(folio);
> +		folio_unlock(folio);
> +		folio_end_writeback(folio);
> +
> +		netfs_put_group(group);
> +		kfree(finfo);
> +
> +	} while ((folio =3D writeback_iter(mapping, wbc, folio, &error)));
> +}
> +
> +/*
> + * Create a write request and set it up appropriately for the origin typ=
e.
> + */
> +struct netfs_io_request *netfs_create_write_req(struct address_space *ma=
pping,
> +						struct file *file,
> +						loff_t start,
> +						enum netfs_io_origin origin)
> +{
> +	struct netfs_io_request *wreq;
> +	struct netfs_inode *ictx;
> +
> +	wreq =3D netfs_alloc_request(mapping, file, start, 0, origin);
> +	if (IS_ERR(wreq))
> +		return wreq;
> +
> +	_enter("R=3D%x", wreq->debug_id);
> +
> +	ictx =3D netfs_inode(wreq->inode);
> +	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags))
> +		fscache_begin_write_operation(&wreq->cache_resources,
> netfs_i_cookie(ictx));
> +
> +	wreq->contiguity =3D wreq->start;
> +	wreq->cleaned_to =3D wreq->start;
> +	INIT_WORK(&wreq->work, netfs_write_collection_worker);
> +
> +	wreq->io_streams[0].stream_nr		=3D 0;
> +	wreq->io_streams[0].source		=3D
> NETFS_UPLOAD_TO_SERVER;
> +	wreq->io_streams[0].prepare_write	=3D ictx->ops->prepare_write;
> +	wreq->io_streams[0].issue_write		=3D ictx->ops->issue_write;
> +	wreq->io_streams[0].collected_to	=3D start;
> +	wreq->io_streams[0].transferred		=3D LONG_MAX;
> +
> +	wreq->io_streams[1].stream_nr		=3D 1;
> +	wreq->io_streams[1].source		=3D NETFS_WRITE_TO_CACHE;
> +	wreq->io_streams[1].collected_to	=3D start;
> +	wreq->io_streams[1].transferred		=3D LONG_MAX;
> +	if (fscache_resources_valid(&wreq->cache_resources)) {
> +		wreq->io_streams[1].avail	=3D true;
> +		wreq->io_streams[1].prepare_write =3D wreq-
> >cache_resources.ops->prepare_write_subreq;
> +		wreq->io_streams[1].issue_write =3D wreq->cache_resources.ops-
> >issue_write;
> +	}
> +
> +	return wreq;
> +}
> +
> +/**
> + * netfs_prepare_write_failed - Note write preparation failed
> + * @subreq: The subrequest to mark
> + *
> + * Mark a subrequest to note that preparation for write failed.
> + */
> +void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq)
> +{
> +	__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +	trace_netfs_sreq(subreq, netfs_sreq_trace_prep_failed);
> +}
> +EXPORT_SYMBOL(netfs_prepare_write_failed);
> +
> +/*
> + * Prepare a write subrequest.  We need to allocate a new subrequest
> + * if we don't have one.
> + */
> +static void netfs_prepare_write(struct netfs_io_request *wreq,
> +				struct netfs_io_stream *stream,
> +				loff_t start)
> +{
> +	struct netfs_io_subrequest *subreq;
> +
> +	subreq =3D netfs_alloc_subrequest(wreq);
> +	subreq->source		=3D stream->source;
> +	subreq->start		=3D start;
> +	subreq->max_len		=3D ULONG_MAX;
> +	subreq->max_nr_segs	=3D INT_MAX;
> +	subreq->stream_nr	=3D stream->stream_nr;
> +
> +	_enter("R=3D%x[%x]", wreq->debug_id, subreq->debug_index);
> +
> +	trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
> +			     refcount_read(&subreq->ref),
> +			     netfs_sreq_trace_new);
> +
> +	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
> +
> +	switch (stream->source) {
> +	case NETFS_UPLOAD_TO_SERVER:
> +		netfs_stat(&netfs_n_wh_upload);
> +		subreq->max_len =3D wreq->wsize;
> +		break;
> +	case NETFS_WRITE_TO_CACHE:
> +		netfs_stat(&netfs_n_wh_write);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +
> +	if (stream->prepare_write)
> +		stream->prepare_write(subreq);
> +
> +	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
> +
> +	/* We add to the end of the list whilst the collector may be walking
> +	 * the list.  The collector only goes nextwards and uses the lock to
> +	 * remove entries off of the front.
> +	 */
> +	spin_lock(&wreq->lock);
> +	list_add_tail(&subreq->rreq_link, &stream->subrequests);
> +	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
> +		stream->front =3D subreq;
> +		if (!stream->active) {
> +			stream->collected_to =3D stream->front->start;
> +			/* Write list pointers before active flag */
> +			smp_store_release(&stream->active, true);
> +		}
> +	}
> +
> +	spin_unlock(&wreq->lock);
> +
> +	stream->construct =3D subreq;
> +}
> +
> +/*
> + * Set the I/O iterator for the filesystem/cache to use and dispatch the=
 I/O
> + * operation.  The operation may be asynchronous and should call
> + * netfs_write_subrequest_terminated() when complete.
> + */
> +static void netfs_do_issue_write(struct netfs_io_stream *stream,
> +				 struct netfs_io_subrequest *subreq)
> +{
> +	struct netfs_io_request *wreq =3D subreq->rreq;
> +
> +	_enter("R=3D%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq-
> >len);
> +
> +	if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
> +		return netfs_write_subrequest_terminated(subreq, subreq->error,
> false);
> +
> +	// TODO: Use encrypted buffer
> +	if (test_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags)) {
> +		subreq->io_iter =3D wreq->io_iter;
> +		iov_iter_advance(&subreq->io_iter,
> +				 subreq->start + subreq->transferred - wreq-
> >start);
> +		iov_iter_truncate(&subreq->io_iter,
> +				 subreq->len - subreq->transferred);
> +	} else {
> +		iov_iter_xarray(&subreq->io_iter, ITER_SOURCE, &wreq-
> >mapping->i_pages,
> +				subreq->start + subreq->transferred,
> +				subreq->len   - subreq->transferred);
> +	}
> +
> +	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
> +	stream->issue_write(subreq);
> +}
> +
> +void netfs_reissue_write(struct netfs_io_stream *stream,
> +			 struct netfs_io_subrequest *subreq)
> +{
> +	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
> +	netfs_do_issue_write(stream, subreq);
> +}
> +
> +static void netfs_issue_write(struct netfs_io_request *wreq,
> +			      struct netfs_io_stream *stream)
> +{
> +	struct netfs_io_subrequest *subreq =3D stream->construct;
> +
> +	if (!subreq)
> +		return;
> +	stream->construct =3D NULL;
> +
> +	if (subreq->start + subreq->len > wreq->start + wreq->submitted)
> +		wreq->len =3D wreq->submitted =3D subreq->start + subreq->len -
> wreq->start;
> +	netfs_do_issue_write(stream, subreq);
> +}
> +
> +/*
> + * Add data to the write subrequest, dispatching each as we fill it up o=
r if it
> + * is discontiguous with the previous.  We only fill one part at a time =
so that
> + * we can avoid overrunning the credits obtained (cifs) and try to paral=
lelise
> + * content-crypto preparation with network writes.
> + */
> +int netfs_advance_write(struct netfs_io_request *wreq,
> +			struct netfs_io_stream *stream,
> +			loff_t start, size_t len, bool to_eof)
> +{
> +	struct netfs_io_subrequest *subreq =3D stream->construct;
> +	size_t part;
> +
> +	if (!stream->avail) {
> +		_leave("no write");
> +		return len;
> +	}
> +
> +	_enter("R=3D%x[%x]", wreq->debug_id, subreq ? subreq->debug_index : 0);
> +
> +	if (subreq && start !=3D subreq->start + subreq->len) {
> +		netfs_issue_write(wreq, stream);
> +		subreq =3D NULL;
> +	}
> +
> +	if (!stream->construct)
> +		netfs_prepare_write(wreq, stream, start);
> +	subreq =3D stream->construct;
> +
> +	part =3D min(subreq->max_len - subreq->len, len);
> +	_debug("part %zx/%zx %zx/%zx", subreq->len, subreq->max_len, part,
> len);
> +	subreq->len +=3D part;
> +	subreq->nr_segs++;
> +
> +	if (subreq->len >=3D subreq->max_len ||
> +	    subreq->nr_segs >=3D subreq->max_nr_segs ||
> +	    to_eof) {
> +		netfs_issue_write(wreq, stream);
> +		subreq =3D NULL;
> +	}
> +
> +	return part;
> +}
> +
> +/*
> + * Write some of a pending folio data back to the server.
> + */
> +static int netfs_write_folio(struct netfs_io_request *wreq,
> +			     struct writeback_control *wbc,
> +			     struct folio *folio)
> +{
> +	struct netfs_io_stream *upload =3D &wreq->io_streams[0];
> +	struct netfs_io_stream *cache  =3D &wreq->io_streams[1];
> +	struct netfs_io_stream *stream;
> +	struct netfs_group *fgroup; /* TODO: Use this with ceph */
> +	struct netfs_folio *finfo;
> +	size_t fsize =3D folio_size(folio), flen =3D fsize, foff =3D 0;
> +	loff_t fpos =3D folio_pos(folio);
> +	bool to_eof =3D false, streamw =3D false;
> +	bool debug =3D false;
> +
> +	_enter("");
> +
> +	if (fpos >=3D wreq->i_size) {
> +		/* mmap beyond eof. */
> +		_debug("beyond eof");
> +		folio_start_writeback(folio);
> +		folio_unlock(folio);
> +		wreq->nr_group_rel +=3D netfs_folio_written_back(folio);
> +		netfs_put_group_many(wreq->group, wreq->nr_group_rel);
> +		wreq->nr_group_rel =3D 0;
> +		return 0;
> +	}
> +
> +	fgroup =3D netfs_folio_group(folio);
> +	finfo =3D netfs_folio_info(folio);
> +	if (finfo) {
> +		foff =3D finfo->dirty_offset;
> +		flen =3D foff + finfo->dirty_len;
> +		streamw =3D true;
> +	}
> +
> +	if (wreq->origin =3D=3D NETFS_WRITETHROUGH) {
> +		to_eof =3D false;
> +		if (flen > wreq->i_size - fpos)
> +			flen =3D wreq->i_size - fpos;
> +	} else if (flen > wreq->i_size - fpos) {
> +		flen =3D wreq->i_size - fpos;
> +		if (!streamw)
> +			folio_zero_segment(folio, flen, fsize);
> +		to_eof =3D true;
> +	} else if (flen =3D=3D wreq->i_size - fpos) {
> +		to_eof =3D true;
> +	}
> +	flen -=3D foff;
> +
> +	_debug("folio %zx %zx %zx", foff, flen, fsize);
> +
> +	/* Deal with discontinuities in the stream of dirty pages.  These can
> +	 * arise from a number of sources:
> +	 *
> +	 * (1) Intervening non-dirty pages from random-access writes, multiple
> +	 *     flushers writing back different parts simultaneously and manual
> +	 *     syncing.
> +	 *
> +	 * (2) Partially-written pages from write-streaming.
> +	 *
> +	 * (3) Pages that belong to a different write-back group (eg.  Ceph
> +	 *     snapshots).
> +	 *
> +	 * (4) Actually-clean pages that were marked for write to the cache
> +	 *     when they were read.  Note that these appear as a special
> +	 *     write-back group.
> +	 */
> +	if (fgroup =3D=3D NETFS_FOLIO_COPY_TO_CACHE) {
> +		netfs_issue_write(wreq, upload);
> +	} else if (fgroup !=3D wreq->group) {
> +		/* We can't write this page to the server yet. */
> +		kdebug("wrong group");
> +		folio_redirty_for_writepage(wbc, folio);
> +		folio_unlock(folio);
> +		netfs_issue_write(wreq, upload);
> +		netfs_issue_write(wreq, cache);
> +		return 0;
> +	}
> +
> +	if (foff > 0)
> +		netfs_issue_write(wreq, upload);
> +	if (streamw)
> +		netfs_issue_write(wreq, cache);
> +
> +	/* Flip the page to the writeback state and unlock.  If we're called
> +	 * from write-through, then the page has already been put into the wb
> +	 * state.
> +	 */
> +	if (wreq->origin =3D=3D NETFS_WRITEBACK)
> +		folio_start_writeback(folio);
> +	folio_unlock(folio);
> +
> +	if (fgroup =3D=3D NETFS_FOLIO_COPY_TO_CACHE) {
> +		if (!fscache_resources_valid(&wreq->cache_resources)) {
> +			trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
> +			netfs_issue_write(wreq, upload);
> +			netfs_folio_written_back(folio);
> +			return 0;
> +		}
> +		trace_netfs_folio(folio, netfs_folio_trace_store_copy);
> +	} else if (!upload->construct) {
> +		trace_netfs_folio(folio, netfs_folio_trace_store);
> +	} else {
> +		trace_netfs_folio(folio, netfs_folio_trace_store_plus);
> +	}
> +
> +	/* Move the submission point forward to allow for write-streaming data
> +	 * not starting at the front of the page.  We don't do write-streaming
> +	 * with the cache as the cache requires DIO alignment.
> +	 *
> +	 * Also skip uploading for data that's been read and just needs copying
> +	 * to the cache.
> +	 */
> +	for (int s =3D 0; s < NR_IO_STREAMS; s++) {
> +		stream =3D &wreq->io_streams[s];
> +		stream->submit_max_len =3D fsize;
> +		stream->submit_off =3D foff;
> +		stream->submit_len =3D flen;
> +		if ((stream->source =3D=3D NETFS_WRITE_TO_CACHE && streamw)
> ||
> +		    (stream->source =3D=3D NETFS_UPLOAD_TO_SERVER &&
> +		     fgroup =3D=3D NETFS_FOLIO_COPY_TO_CACHE)) {
> +			stream->submit_off =3D UINT_MAX;
> +			stream->submit_len =3D 0;
> +			stream->submit_max_len =3D 0;
> +		}
> +	}
> +
> +	/* Attach the folio to one or more subrequests.  For a big folio, we
> +	 * could end up with thousands of subrequests if the wsize is small -
> +	 * but we might need to wait during the creation of subrequests for
> +	 * network resources (eg. SMB credits).
> +	 */
> +	for (;;) {
> +		ssize_t part;
> +		size_t lowest_off =3D ULONG_MAX;
> +		int choose_s =3D -1;
> +
> +		/* Always add to the lowest-submitted stream first. */
> +		for (int s =3D 0; s < NR_IO_STREAMS; s++) {
> +			stream =3D &wreq->io_streams[s];
> +			if (stream->submit_len > 0 &&
> +			    stream->submit_off < lowest_off) {
> +				lowest_off =3D stream->submit_off;
> +				choose_s =3D s;
> +			}
> +		}
> +
> +		if (choose_s < 0)
> +			break;
> +		stream =3D &wreq->io_streams[choose_s];
> +
> +		part =3D netfs_advance_write(wreq, stream, fpos + stream-
> >submit_off,
> +					   stream->submit_len, to_eof);
> +		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
> +		stream->submit_off +=3D part;
> +		stream->submit_max_len -=3D part;
> +		if (part > stream->submit_len)
> +			stream->submit_len =3D 0;
> +		else
> +			stream->submit_len -=3D part;
> +		if (part > 0)
> +			debug =3D true;
> +	}
> +
> +	atomic64_set(&wreq->issued_to, fpos + fsize);
> +
> +	if (!debug)
> +		kdebug("R=3D%x: No submit", wreq->debug_id);
> +
> +	if (flen < fsize)
> +		for (int s =3D 0; s < NR_IO_STREAMS; s++)
> +			netfs_issue_write(wreq, &wreq->io_streams[s]);
> +
> +	_leave(" =3D 0");
> +	return 0;
> +}
> +
> +/*
> + * Write some of the pending data back to the server
> + */
> +int new_netfs_writepages(struct address_space *mapping,
> +			 struct writeback_control *wbc)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(mapping->host);
> +	struct netfs_io_request *wreq =3D NULL;
> +	struct folio *folio;
> +	int error =3D 0;
> +
> +	if (wbc->sync_mode =3D=3D WB_SYNC_ALL)
> +		mutex_lock(&ictx->wb_lock);
> +	else if (!mutex_trylock(&ictx->wb_lock))
> +		return 0;
> +
> +	/* Need the first folio to be able to set up the op. */
> +	folio =3D writeback_iter(mapping, wbc, NULL, &error);
> +	if (!folio)
> +		goto out;
> +
> +	wreq =3D netfs_create_write_req(mapping, NULL, folio_pos(folio),
> NETFS_WRITEBACK);
> +	if (IS_ERR(wreq)) {
> +		error =3D PTR_ERR(wreq);
> +		goto couldnt_start;
> +	}
> +
> +	trace_netfs_write(wreq, netfs_write_trace_writeback);
> +	netfs_stat(&netfs_n_wh_writepages);
> +
> +	do {
> +		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq-
> >submitted);
> +
> +		/* It appears we don't have to handle cyclic writeback wrapping. */
> +		WARN_ON_ONCE(wreq && folio_pos(folio) < wreq->start + wreq-
> >submitted);
> +
> +		if (netfs_folio_group(folio) !=3D NETFS_FOLIO_COPY_TO_CACHE
> &&
> +		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER,
> &wreq->flags))) {
> +			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq-
> >flags);
> +			wreq->netfs_ops->begin_writeback(wreq);
> +		}
> +
> +		error =3D netfs_write_folio(wreq, wbc, folio);
> +		if (error < 0)
> +			break;
> +	} while ((folio =3D writeback_iter(mapping, wbc, folio, &error)));
> +
> +	for (int s =3D 0; s < NR_IO_STREAMS; s++)
> +		netfs_issue_write(wreq, &wreq->io_streams[s]);
> +	smp_wmb(); /* Write lists before ALL_QUEUED. */
> +	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
> +
> +	mutex_unlock(&ictx->wb_lock);
> +
> +	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
> +	_leave(" =3D %d", error);
> +	return error;
> +
> +couldnt_start:
> +	netfs_kill_dirty_pages(mapping, wbc, folio);
> +out:
> +	mutex_unlock(&ictx->wb_lock);
> +	_leave(" =3D %d", error);
> +	return error;
> +}
> +EXPORT_SYMBOL(new_netfs_writepages);
> +
> +/*
> + * Begin a write operation for writing through the pagecache.
> + */
> +struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *iocb=
, size_t
> len)
> +{
> +	struct netfs_io_request *wreq =3D NULL;
> +	struct netfs_inode *ictx =3D netfs_inode(file_inode(iocb->ki_filp));
> +
> +	mutex_lock(&ictx->wb_lock);
> +
> +	wreq =3D netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp=
,
> +				      iocb->ki_pos, NETFS_WRITETHROUGH);
> +	if (IS_ERR(wreq))
> +		mutex_unlock(&ictx->wb_lock);
> +
> +	wreq->io_streams[0].avail =3D true;
> +	trace_netfs_write(wreq, netfs_write_trace_writethrough);

Missing mutex_unlock() before return.

Thanks,
Naveen

> +	return wreq;
> +}
> +
> +/*
> + * Advance the state of the write operation used when writing through th=
e
> + * pagecache.  Data has been copied into the pagecache that we need to a=
ppend
> + * to the request.  If we've added more than wsize then we need to creat=
e a new
> + * subrequest.
> + */
> +int new_netfs_advance_writethrough(struct netfs_io_request *wreq, struct
> writeback_control *wbc,
> +				   struct folio *folio, size_t copied, bool
> to_page_end,
> +				   struct folio **writethrough_cache)
> +{
> +	_enter("R=3D%x ic=3D%zu ws=3D%u cp=3D%zu tp=3D%u",
> +	       wreq->debug_id, wreq->iter.count, wreq->wsize, copied,
> to_page_end);
> +
> +	if (!*writethrough_cache) {
> +		if (folio_test_dirty(folio))
> +			/* Sigh.  mmap. */
> +			folio_clear_dirty_for_io(folio);
> +
> +		/* We can make multiple writes to the folio... */
> +		folio_start_writeback(folio);
> +		if (wreq->len =3D=3D 0)
> +			trace_netfs_folio(folio, netfs_folio_trace_wthru);
> +		else
> +			trace_netfs_folio(folio, netfs_folio_trace_wthru_plus);
> +		*writethrough_cache =3D folio;
> +	}
> +
> +	wreq->len +=3D copied;
> +	if (!to_page_end)
> +		return 0;
> +
> +	*writethrough_cache =3D NULL;
> +	return netfs_write_folio(wreq, wbc, folio);
> +}
> +
> +/*
> + * End a write operation used when writing through the pagecache.
> + */
> +int new_netfs_end_writethrough(struct netfs_io_request *wreq, struct
> writeback_control *wbc,
> +			       struct folio *writethrough_cache)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(wreq->inode);
> +	int ret;
> +
> +	_enter("R=3D%x", wreq->debug_id);
> +
> +	if (writethrough_cache)
> +		netfs_write_folio(wreq, wbc, writethrough_cache);
> +
> +	netfs_issue_write(wreq, &wreq->io_streams[0]);
> +	netfs_issue_write(wreq, &wreq->io_streams[1]);
> +	smp_wmb(); /* Write lists before ALL_QUEUED. */
> +	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
> +
> +	mutex_unlock(&ictx->wb_lock);
> +
> +	ret =3D wreq->error;
> +	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
> +	return ret;
> +}
> +
> +/*
> + * Write data to the server without going through the pagecache and with=
out
> + * writing it to the local cache.
> + */
> +int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait,=
 size_t
> len)
> +{
> +	struct netfs_io_stream *upload =3D &wreq->io_streams[0];
> +	ssize_t part;
> +	loff_t start =3D wreq->start;
> +	int error =3D 0;
> +
> +	_enter("%zx", len);
> +
> +	if (wreq->origin =3D=3D NETFS_DIO_WRITE)
> +		inode_dio_begin(wreq->inode);
> +
> +	while (len) {
> +		// TODO: Prepare content encryption
> +
> +		_debug("unbuffered %zx", len);
> +		part =3D netfs_advance_write(wreq, upload, start, len, false);
> +		start +=3D part;
> +		len -=3D part;
> +		if (test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
> +			trace_netfs_rreq(wreq, netfs_rreq_trace_wait_pause);
> +			wait_on_bit(&wreq->flags, NETFS_RREQ_PAUSE,
> TASK_UNINTERRUPTIBLE);
> +		}
> +		if (test_bit(NETFS_RREQ_FAILED, &wreq->flags))
> +			break;
> +	}
> +
> +	netfs_issue_write(wreq, upload);
> +
> +	smp_wmb(); /* Write lists before ALL_QUEUED. */
> +	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
> +	if (list_empty(&upload->subrequests))
> +		netfs_wake_write_collector(wreq, false);
> +
> +	_leave(" =3D %d", error);
> +	return error;
> +}
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 88269681d4fc..42dba05a428b 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -64,6 +64,7 @@ struct netfs_inode {
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	struct fscache_cookie	*cache;
>  #endif
> +	struct mutex		wb_lock;	/* Writeback serialisation */
>  	loff_t			remote_i_size;	/* Size of the remote file */
>  	loff_t			zero_point;	/* Size after which we assume
> there's no data
>  						 * on the server */
> @@ -71,7 +72,6 @@ struct netfs_inode {
>  #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in
> progress */
>  #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the
> pagecache */
>  #define NETFS_ICTX_WRITETHROUGH	2		/* Write-through
> caching */
> -#define NETFS_ICTX_NO_WRITE_STREAMING	3	/* Don't engage in
> write-streaming */
>  #define NETFS_ICTX_USE_PGPRIV2	31		/* [DEPRECATED] Use
> PG_private_2 to mark
>  						 * write to cache on read */
>  };
> @@ -126,6 +126,33 @@ static inline struct netfs_group *netfs_folio_group(=
struct
> folio *folio)
>  	return priv;
>  }
>=20
> +/*
> + * Stream of I/O subrequests going to a particular destination, such as =
the
> + * server or the local cache.  This is mainly intended for writing where=
 we may
> + * have to write to multiple destinations concurrently.
> + */
> +struct netfs_io_stream {
> +	/* Submission tracking */
> +	struct netfs_io_subrequest *construct;	/* Op being constructed */
> +	unsigned int		submit_off;	/* Folio offset we're submitting
> from */
> +	unsigned int		submit_len;	/* Amount of data left to submit */
> +	unsigned int		submit_max_len;	/* Amount I/O can be
> rounded up to */
> +	void (*prepare_write)(struct netfs_io_subrequest *subreq);
> +	void (*issue_write)(struct netfs_io_subrequest *subreq);
> +	/* Collection tracking */
> +	struct list_head	subrequests;	/* Contributory I/O operations */
> +	struct netfs_io_subrequest *front;	/* Op being collected */
> +	unsigned long long	collected_to;	/* Position we've collected results
> to */
> +	size_t			transferred;	/* The amount transferred from
> this stream */
> +	enum netfs_io_source	source;		/* Where to read from/write to */
> +	unsigned short		error;		/* Aggregate error for the stream
> */
> +	unsigned char		stream_nr;	/* Index of stream in parent table
> */
> +	bool			avail;		/* T if stream is available */
> +	bool			active;		/* T if stream is active */
> +	bool			need_retry;	/* T if this stream needs retrying
> */
> +	bool			failed;		/* T if this stream failed */
> +};
> +
>  /*
>   * Resources required to do operations on a cache.
>   */
> @@ -150,13 +177,16 @@ struct netfs_io_subrequest {
>  	struct list_head	rreq_link;	/* Link in rreq->subrequests */
>  	struct iov_iter		io_iter;	/* Iterator for this subrequest */
>  	unsigned long long	start;		/* Where to start the I/O */
> +	size_t			max_len;	/* Maximum size of the I/O */
>  	size_t			len;		/* Size of the I/O */
>  	size_t			transferred;	/* Amount of data transferred */
>  	refcount_t		ref;
>  	short			error;		/* 0 or error that occurred */
>  	unsigned short		debug_index;	/* Index in list (for debugging
> output) */
> +	unsigned int		nr_segs;	/* Number of segs in io_iter */
>  	unsigned int		max_nr_segs;	/* 0 or max number of segments
> in an iterator */
>  	enum netfs_io_source	source;		/* Where to read from/write to */
> +	unsigned char		stream_nr;	/* I/O stream this belongs to */
>  	unsigned long		flags;
>  #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the
> data to the cache */
>  #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the
> read should be cleared */
> @@ -164,6 +194,11 @@ struct netfs_io_subrequest {
>  #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should
> SEEK_DATA first */
>  #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't
> manage to read any data */
>  #define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-
> demand read mode */
> +#define NETFS_SREQ_BOUNDARY		6	/* Set if ends on hard
> boundary (eg. ceph object) */
> +#define NETFS_SREQ_IN_PROGRESS		8	/* Unlocked when
> the subrequest completes */
> +#define NETFS_SREQ_NEED_RETRY		9	/* Set if the
> filesystem requests a retry */
> +#define NETFS_SREQ_RETRYING		10	/* Set if we're retrying */
> +#define NETFS_SREQ_FAILED		11	/* Set if the subreq failed
> unretryably */
>  };
>=20
>  enum netfs_io_origin {
> @@ -194,6 +229,9 @@ struct netfs_io_request {
>  	struct netfs_cache_resources cache_resources;
>  	struct list_head	proc_link;	/* Link in netfs_iorequests */
>  	struct list_head	subrequests;	/* Contributory I/O operations */
> +	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O
> operations */
> +#define NR_IO_STREAMS 2 //wreq->nr_io_streams
> +	struct netfs_group	*group;		/* Writeback group being written
> back */
>  	struct iov_iter		iter;		/* Unencrypted-side iterator */
>  	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
>  	void			*netfs_priv;	/* Private data for the netfs */
> @@ -203,6 +241,8 @@ struct netfs_io_request {
>  	unsigned int		rsize;		/* Maximum read size (0 for none)
> */
>  	unsigned int		wsize;		/* Maximum write size (0 for
> none) */
>  	atomic_t		subreq_counter;	/* Next subreq-
> >debug_index */
> +	unsigned int		nr_group_rel;	/* Number of refs to release on -
> >group */
> +	spinlock_t		lock;		/* Lock for queuing subreqs */
>  	atomic_t		nr_outstanding;	/* Number of ops in progress */
>  	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in
> progress */
>  	size_t			upper_len;	/* Length can be extended to here
> */
> @@ -214,6 +254,10 @@ struct netfs_io_request {
>  	bool			direct_bv_unpin; /* T if direct_bv[] must be
> unpinned */
>  	unsigned long long	i_size;		/* Size of the file */
>  	unsigned long long	start;		/* Start position */
> +	atomic64_t		issued_to;	/* Write issuer folio cursor */
> +	unsigned long long	contiguity;	/* Tracking for gaps in the
> writeback sequence */
> +	unsigned long long	collected_to;	/* Point we've collected to */
> +	unsigned long long	cleaned_to;	/* Position we've cleaned folios to
> */
>  	pgoff_t			no_unlock_folio; /* Don't unlock this folio after
> read */
>  	refcount_t		ref;
>  	unsigned long		flags;
> @@ -227,6 +271,9 @@ struct netfs_io_request {
>  #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to
> the server */
>  #define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible
> (O_NONBLOCK) */
>  #define NETFS_RREQ_BLOCKED		10	/* We blocked */
> +#define NETFS_RREQ_PAUSE		11	/* Pause subrequest
> generation */
> +#define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter
> rather than ->i_pages */
> +#define NETFS_RREQ_ALL_QUEUED		13	/* All subreqs are
> now queued */
>  #define NETFS_RREQ_USE_PGPRIV2		31	/*
> [DEPRECATED] Use PG_private_2 to mark
>  						 * write to cache on read */
>  	const struct netfs_request_ops *netfs_ops;
> @@ -258,6 +305,9 @@ struct netfs_request_ops {
>  	/* Write request handling */
>  	void (*create_write_requests)(struct netfs_io_request *wreq,
>  				      loff_t start, size_t len);
> +	void (*begin_writeback)(struct netfs_io_request *wreq);
> +	void (*prepare_write)(struct netfs_io_subrequest *subreq);
> +	void (*issue_write)(struct netfs_io_subrequest *subreq);
>  	void (*invalidate_cache)(struct netfs_io_request *wreq);
>  };
>=20
> @@ -292,6 +342,9 @@ struct netfs_cache_ops {
>  		     netfs_io_terminated_t term_func,
>  		     void *term_func_priv);
>=20
> +	/* Write data to the cache from a netfs subrequest. */
> +	void (*issue_write)(struct netfs_io_subrequest *subreq);
> +
>  	/* Expand readahead request */
>  	void (*expand_readahead)(struct netfs_cache_resources *cres,
>  				 unsigned long long *_start,
> @@ -304,6 +357,13 @@ struct netfs_cache_ops {
>  	enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest
> *subreq,
>  					     unsigned long long i_size);
>=20
> +	/* Prepare a write subrequest, working out if we're allowed to do it
> +	 * and finding out the maximum amount of data to gather before
> +	 * attempting to submit.  If we're not permitted to do it, the
> +	 * subrequest should be marked failed.
> +	 */
> +	void (*prepare_write_subreq)(struct netfs_io_subrequest *subreq);
> +
>  	/* Prepare a write operation, working out what part of the write we can
>  	 * actually do.
>  	 */
> @@ -349,6 +409,8 @@ int netfs_write_begin(struct netfs_inode *, struct fi=
le *,
>  		      struct folio **, void **fsdata);
>  int netfs_writepages(struct address_space *mapping,
>  		     struct writeback_control *wbc);
> +int new_netfs_writepages(struct address_space *mapping,
> +			struct writeback_control *wbc);
>  bool netfs_dirty_folio(struct address_space *mapping, struct folio *foli=
o);
>  int netfs_unpin_writeback(struct inode *inode, struct writeback_control =
*wbc);
>  void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
> @@ -372,8 +434,11 @@ size_t netfs_limit_iter(const struct iov_iter *iter,=
 size_t
> start_offset,
>  struct netfs_io_subrequest *netfs_create_write_request(
>  	struct netfs_io_request *wreq, enum netfs_io_source dest,
>  	loff_t start, size_t len, work_func_t worker);
> +void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq);
>  void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or=
_error,
>  				       bool was_async);
> +void new_netfs_write_subrequest_terminated(void *_op, ssize_t
> transferred_or_error,
> +					   bool was_async);
>  void netfs_queue_write_request(struct netfs_io_subrequest *subreq);
>=20
>  int netfs_start_io_read(struct inode *inode);
> @@ -415,6 +480,7 @@ static inline void netfs_inode_init(struct netfs_inod=
e *ctx,
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	ctx->cache =3D NULL;
>  #endif
> +	mutex_init(&ctx->wb_lock);
>  	/* ->releasepage() drives zero_point */
>  	if (use_zero_point) {
>  		ctx->zero_point =3D ctx->remote_i_size;
> diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
> index 7126d2ea459c..e7700172ae7e 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -44,14 +44,18 @@
>  #define netfs_rreq_traces					\
>  	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
>  	EM(netfs_rreq_trace_copy,		"COPY   ")	\
> +	EM(netfs_rreq_trace_collect,		"COLLECT")	\
>  	EM(netfs_rreq_trace_done,		"DONE   ")	\
>  	EM(netfs_rreq_trace_free,		"FREE   ")	\
>  	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
>  	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
> +	EM(netfs_rreq_trace_set_pause,		"PAUSE  ")	\
>  	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
>  	EM(netfs_rreq_trace_unmark,		"UNMARK ")	\
>  	EM(netfs_rreq_trace_wait_ip,		"WAIT-IP")	\
> +	EM(netfs_rreq_trace_wait_pause,		"WT-PAUS")	\
>  	EM(netfs_rreq_trace_wake_ip,		"WAKE-IP")	\
> +	EM(netfs_rreq_trace_unpause,		"UNPAUSE")	\
>  	E_(netfs_rreq_trace_write_done,		"WR-DONE")
>=20
>  #define netfs_sreq_sources					\
> @@ -64,11 +68,15 @@
>  	E_(NETFS_INVALID_WRITE,			"INVL")
>=20
>  #define netfs_sreq_traces					\
> +	EM(netfs_sreq_trace_discard,		"DSCRD")	\
>  	EM(netfs_sreq_trace_download_instead,	"RDOWN")	\
> +	EM(netfs_sreq_trace_fail,		"FAIL ")	\
>  	EM(netfs_sreq_trace_free,		"FREE ")	\
>  	EM(netfs_sreq_trace_limited,		"LIMIT")	\
>  	EM(netfs_sreq_trace_prepare,		"PREP ")	\
> +	EM(netfs_sreq_trace_prep_failed,	"PRPFL")	\
>  	EM(netfs_sreq_trace_resubmit_short,	"SHORT")	\
> +	EM(netfs_sreq_trace_retry,		"RETRY")	\
>  	EM(netfs_sreq_trace_submit,		"SUBMT")	\
>  	EM(netfs_sreq_trace_terminated,		"TERM ")	\
>  	EM(netfs_sreq_trace_write,		"WRITE")	\
> @@ -88,6 +96,7 @@
>  #define netfs_rreq_ref_traces					\
>  	EM(netfs_rreq_trace_get_for_outstanding,"GET OUTSTND")	\
>  	EM(netfs_rreq_trace_get_subreq,		"GET SUBREQ ")	\
> +	EM(netfs_rreq_trace_get_work,		"GET WORK   ")	\
>  	EM(netfs_rreq_trace_put_complete,	"PUT COMPLT ")	\
>  	EM(netfs_rreq_trace_put_discard,	"PUT DISCARD")	\
>  	EM(netfs_rreq_trace_put_failed,		"PUT FAILED ")	\
> @@ -95,6 +104,8 @@
>  	EM(netfs_rreq_trace_put_return,		"PUT RETURN ")	\
>  	EM(netfs_rreq_trace_put_subreq,		"PUT SUBREQ ")	\
>  	EM(netfs_rreq_trace_put_work,		"PUT WORK   ")	\
> +	EM(netfs_rreq_trace_put_work_complete,	"PUT WORK CP")	\
> +	EM(netfs_rreq_trace_put_work_nq,	"PUT WORK NQ")	\
>  	EM(netfs_rreq_trace_see_work,		"SEE WORK   ")	\
>  	E_(netfs_rreq_trace_new,		"NEW        ")
>=20
> @@ -103,11 +114,14 @@
>  	EM(netfs_sreq_trace_get_resubmit,	"GET RESUBMIT")	\
>  	EM(netfs_sreq_trace_get_short_read,	"GET SHORTRD")	\
>  	EM(netfs_sreq_trace_new,		"NEW        ")	\
> +	EM(netfs_sreq_trace_put_cancel,		"PUT CANCEL ")	\
>  	EM(netfs_sreq_trace_put_clear,		"PUT CLEAR  ")	\
>  	EM(netfs_sreq_trace_put_discard,	"PUT DISCARD")	\
> +	EM(netfs_sreq_trace_put_done,		"PUT DONE   ")	\
>  	EM(netfs_sreq_trace_put_failed,		"PUT FAILED ")	\
>  	EM(netfs_sreq_trace_put_merged,		"PUT MERGED ")	\
>  	EM(netfs_sreq_trace_put_no_copy,	"PUT NO COPY")	\
> +	EM(netfs_sreq_trace_put_oom,		"PUT OOM    ")	\
>  	EM(netfs_sreq_trace_put_wip,		"PUT WIP    ")	\
>  	EM(netfs_sreq_trace_put_work,		"PUT WORK   ")	\
>  	E_(netfs_sreq_trace_put_terminated,	"PUT TERM   ")
> @@ -124,7 +138,9 @@
>  	EM(netfs_streaming_filled_page,		"mod-streamw-f") \
>  	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
>  	/* The rest are for writeback */			\
> +	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
>  	EM(netfs_folio_trace_clear,		"clear")	\
> +	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
>  	EM(netfs_folio_trace_clear_s,		"clear-s")	\
>  	EM(netfs_folio_trace_clear_g,		"clear-g")	\
>  	EM(netfs_folio_trace_copy,		"copy")		\
> @@ -133,16 +149,26 @@
>  	EM(netfs_folio_trace_end_copy,		"end-copy")	\
>  	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
>  	EM(netfs_folio_trace_kill,		"kill")		\
> +	EM(netfs_folio_trace_kill_cc,		"kill-cc")	\
> +	EM(netfs_folio_trace_kill_g,		"kill-g")	\
> +	EM(netfs_folio_trace_kill_s,		"kill-s")	\
>  	EM(netfs_folio_trace_mkwrite,		"mkwrite")	\
>  	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
> +	EM(netfs_folio_trace_not_under_wback,	"!wback")	\
>  	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\
>  	EM(netfs_folio_trace_redirty,		"redirty")	\
>  	EM(netfs_folio_trace_redirtied,		"redirtied")	\
>  	EM(netfs_folio_trace_store,		"store")	\
> +	EM(netfs_folio_trace_store_copy,	"store-copy")	\
>  	EM(netfs_folio_trace_store_plus,	"store+")	\
>  	EM(netfs_folio_trace_wthru,		"wthru")	\
>  	E_(netfs_folio_trace_wthru_plus,	"wthru+")
>=20
> +#define netfs_collect_contig_traces				\
> +	EM(netfs_contig_trace_collect,		"Collect")	\
> +	EM(netfs_contig_trace_jump,		"-->JUMP-->")	\
> +	E_(netfs_contig_trace_unlock,		"Unlock")
> +
>  #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
>  #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
>=20
> @@ -159,6 +185,7 @@ enum netfs_failure { netfs_failures } __mode(byte);
>  enum netfs_rreq_ref_trace { netfs_rreq_ref_traces } __mode(byte);
>  enum netfs_sreq_ref_trace { netfs_sreq_ref_traces } __mode(byte);
>  enum netfs_folio_trace { netfs_folio_traces } __mode(byte);
> +enum netfs_collect_contig_trace { netfs_collect_contig_traces } __mode(b=
yte);
>=20
>  #endif
>=20
> @@ -180,6 +207,7 @@ netfs_failures;
>  netfs_rreq_ref_traces;
>  netfs_sreq_ref_traces;
>  netfs_folio_traces;
> +netfs_collect_contig_traces;
>=20
>  /*
>   * Now redefine the EM() and E_() macros to map the enums to the strings=
 that
> @@ -413,16 +441,18 @@ TRACE_EVENT(netfs_write_iter,
>  		    __field(unsigned long long,		start		)
>  		    __field(size_t,			len		)
>  		    __field(unsigned int,		flags		)
> +		    __field(unsigned int,		ino		)
>  			     ),
>=20
>  	    TP_fast_assign(
>  		    __entry->start	=3D iocb->ki_pos;
>  		    __entry->len	=3D iov_iter_count(from);
> +		    __entry->ino	=3D iocb->ki_filp->f_inode->i_ino;
>  		    __entry->flags	=3D iocb->ki_flags;
>  			   ),
>=20
> -	    TP_printk("WRITE-ITER s=3D%llx l=3D%zx f=3D%x",
> -		      __entry->start, __entry->len, __entry->flags)
> +	    TP_printk("WRITE-ITER i=3D%x s=3D%llx l=3D%zx f=3D%x",
> +		      __entry->ino, __entry->start, __entry->len, __entry->flags)
>  	    );
>=20
>  TRACE_EVENT(netfs_write,
> @@ -434,6 +464,7 @@ TRACE_EVENT(netfs_write,
>  	    TP_STRUCT__entry(
>  		    __field(unsigned int,		wreq		)
>  		    __field(unsigned int,		cookie		)
> +		    __field(unsigned int,		ino		)
>  		    __field(enum netfs_write_trace,	what		)
>  		    __field(unsigned long long,		start		)
>  		    __field(unsigned long long,		len		)
> @@ -444,18 +475,213 @@ TRACE_EVENT(netfs_write,
>  		    struct fscache_cookie *__cookie =3D netfs_i_cookie(__ctx);
>  		    __entry->wreq	=3D wreq->debug_id;
>  		    __entry->cookie	=3D __cookie ? __cookie->debug_id : 0;
> +		    __entry->ino	=3D wreq->inode->i_ino;
>  		    __entry->what	=3D what;
>  		    __entry->start	=3D wreq->start;
>  		    __entry->len	=3D wreq->len;
>  			   ),
>=20
> -	    TP_printk("R=3D%08x %s c=3D%08x by=3D%llx-%llx",
> +	    TP_printk("R=3D%08x %s c=3D%08x i=3D%x by=3D%llx-%llx",
>  		      __entry->wreq,
>  		      __print_symbolic(__entry->what, netfs_write_traces),
>  		      __entry->cookie,
> +		      __entry->ino,
>  		      __entry->start, __entry->start + __entry->len - 1)
>  	    );
>=20
> +TRACE_EVENT(netfs_collect,
> +	    TP_PROTO(const struct netfs_io_request *wreq),
> +
> +	    TP_ARGS(wreq),
> +
> +	    TP_STRUCT__entry(
> +		    __field(unsigned int,		wreq		)
> +		    __field(unsigned int,		len		)
> +		    __field(unsigned long long,		transferred	)
> +		    __field(unsigned long long,		start		)
> +			     ),
> +
> +	    TP_fast_assign(
> +		    __entry->wreq	=3D wreq->debug_id;
> +		    __entry->start	=3D wreq->start;
> +		    __entry->len	=3D wreq->len;
> +		    __entry->transferred =3D wreq->transferred;
> +			   ),
> +
> +	    TP_printk("R=3D%08x s=3D%llx-%llx",
> +		      __entry->wreq,
> +		      __entry->start + __entry->transferred,
> +		      __entry->start + __entry->len)
> +	    );
> +
> +TRACE_EVENT(netfs_collect_contig,
> +	    TP_PROTO(const struct netfs_io_request *wreq, unsigned long long
> to,
> +		     enum netfs_collect_contig_trace type),
> +
> +	    TP_ARGS(wreq, to, type),
> +
> +	    TP_STRUCT__entry(
> +		    __field(unsigned int,		wreq)
> +		    __field(enum netfs_collect_contig_trace, type)
> +		    __field(unsigned long long,		contiguity)
> +		    __field(unsigned long long,		to)
> +			     ),
> +
> +	    TP_fast_assign(
> +		    __entry->wreq	=3D wreq->debug_id;
> +		    __entry->type	=3D type;
> +		    __entry->contiguity	=3D wreq->contiguity;
> +		    __entry->to		=3D to;
> +			   ),
> +
> +	    TP_printk("R=3D%08x %llx -> %llx %s",
> +		      __entry->wreq,
> +		      __entry->contiguity,
> +		      __entry->to,
> +		      __print_symbolic(__entry->type, netfs_collect_contig_traces))
> +	    );
> +
> +TRACE_EVENT(netfs_collect_sreq,
> +	    TP_PROTO(const struct netfs_io_request *wreq,
> +		     const struct netfs_io_subrequest *subreq),
> +
> +	    TP_ARGS(wreq, subreq),
> +
> +	    TP_STRUCT__entry(
> +		    __field(unsigned int,		wreq		)
> +		    __field(unsigned int,		subreq		)
> +		    __field(unsigned int,		stream		)
> +		    __field(unsigned int,		len		)
> +		    __field(unsigned int,		transferred	)
> +		    __field(unsigned long long,		start		)
> +			     ),
> +
> +	    TP_fast_assign(
> +		    __entry->wreq	=3D wreq->debug_id;
> +		    __entry->subreq	=3D subreq->debug_index;
> +		    __entry->stream	=3D subreq->stream_nr;
> +		    __entry->start	=3D subreq->start;
> +		    __entry->len	=3D subreq->len;
> +		    __entry->transferred =3D subreq->transferred;
> +			   ),
> +
> +	    TP_printk("R=3D%08x[%u:%02x] s=3D%llx t=3D%x/%x",
> +		      __entry->wreq, __entry->stream, __entry->subreq,
> +		      __entry->start, __entry->transferred, __entry->len)
> +	    );
> +
> +TRACE_EVENT(netfs_collect_folio,
> +	    TP_PROTO(const struct netfs_io_request *wreq,
> +		     const struct folio *folio,
> +		     unsigned long long fend,
> +		     unsigned long long collected_to),
> +
> +	    TP_ARGS(wreq, folio, fend, collected_to),
> +
> +	    TP_STRUCT__entry(
> +		    __field(unsigned int,	wreq		)
> +		    __field(unsigned long,	index		)
> +		    __field(unsigned long long,	fend		)
> +		    __field(unsigned long long,	cleaned_to	)
> +		    __field(unsigned long long,	collected_to	)
> +			     ),
> +
> +	    TP_fast_assign(
> +		    __entry->wreq	=3D wreq->debug_id;
> +		    __entry->index	=3D folio->index;
> +		    __entry->fend	=3D fend;
> +		    __entry->cleaned_to	=3D wreq->cleaned_to;
> +		    __entry->collected_to =3D collected_to;
> +			   ),
> +
> +	    TP_printk("R=3D%08x ix=3D%05lx r=3D%llx-%llx t=3D%llx/%llx",
> +		      __entry->wreq, __entry->index,
> +		      (unsigned long long)__entry->index * PAGE_SIZE, __entry-
> >fend,
> +		      __entry->cleaned_to, __entry->collected_to)
> +	    );
> +
> +TRACE_EVENT(netfs_collect_state,
> +	    TP_PROTO(const struct netfs_io_request *wreq,
> +		     unsigned long long collected_to,
> +		     unsigned int notes),
> +
> +	    TP_ARGS(wreq, collected_to, notes),
> +
> +	    TP_STRUCT__entry(
> +		    __field(unsigned int,	wreq		)
> +		    __field(unsigned int,	notes		)
> +		    __field(unsigned long long,	collected_to	)
> +		    __field(unsigned long long,	cleaned_to	)
> +		    __field(unsigned long long,	contiguity	)
> +			     ),
> +
> +	    TP_fast_assign(
> +		    __entry->wreq	=3D wreq->debug_id;
> +		    __entry->notes	=3D notes;
> +		    __entry->collected_to =3D collected_to;
> +		    __entry->cleaned_to	=3D wreq->cleaned_to;
> +		    __entry->contiguity =3D wreq->contiguity;
> +			   ),
> +
> +	    TP_printk("R=3D%08x cto=3D%llx fto=3D%llx ctg=3D%llx n=3D%x",
> +		      __entry->wreq, __entry->collected_to,
> +		      __entry->cleaned_to, __entry->contiguity,
> +		      __entry->notes)
> +	    );
> +
> +TRACE_EVENT(netfs_collect_gap,
> +	    TP_PROTO(const struct netfs_io_request *wreq,
> +		     const struct netfs_io_stream *stream,
> +		     unsigned long long jump_to, char type),
> +
> +	    TP_ARGS(wreq, stream, jump_to, type),
> +
> +	    TP_STRUCT__entry(
> +		    __field(unsigned int,	wreq)
> +		    __field(unsigned char,	stream)
> +		    __field(unsigned char,	type)
> +		    __field(unsigned long long,	from)
> +		    __field(unsigned long long,	to)
> +			     ),
> +
> +	    TP_fast_assign(
> +		    __entry->wreq	=3D wreq->debug_id;
> +		    __entry->stream	=3D stream->stream_nr;
> +		    __entry->from	=3D stream->collected_to;
> +		    __entry->to		=3D jump_to;
> +		    __entry->type	=3D type;
> +			   ),
> +
> +	    TP_printk("R=3D%08x[%x:] %llx->%llx %c",
> +		      __entry->wreq, __entry->stream,
> +		      __entry->from, __entry->to, __entry->type)
> +	    );
> +
> +TRACE_EVENT(netfs_collect_stream,
> +	    TP_PROTO(const struct netfs_io_request *wreq,
> +		     const struct netfs_io_stream *stream),
> +
> +	    TP_ARGS(wreq, stream),
> +
> +	    TP_STRUCT__entry(
> +		    __field(unsigned int,	wreq)
> +		    __field(unsigned char,	stream)
> +		    __field(unsigned long long,	collected_to)
> +		    __field(unsigned long long,	front)
> +			     ),
> +
> +	    TP_fast_assign(
> +		    __entry->wreq	=3D wreq->debug_id;
> +		    __entry->stream	=3D stream->stream_nr;
> +		    __entry->collected_to =3D stream->collected_to;
> +		    __entry->front	=3D stream->front ? stream->front->start :
> UINT_MAX;
> +			   ),
> +
> +	    TP_printk("R=3D%08x[%x:] cto=3D%llx frn=3D%llx",
> +		      __entry->wreq, __entry->stream,
> +		      __entry->collected_to, __entry->front)
> +	    );
> +
>  #undef EM
>  #undef E_
>  #endif /* _TRACE_NETFS_H */
>=20


