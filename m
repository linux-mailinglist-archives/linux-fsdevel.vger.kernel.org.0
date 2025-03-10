Return-Path: <linux-fsdevel+bounces-43657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF50FA5A332
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEEE3AA495
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BA9236433;
	Mon, 10 Mar 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g+ELWOX5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CedgQn8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDB2356D7;
	Mon, 10 Mar 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632012; cv=fail; b=elnzpCCKtlWcdWoVgXSImw8x1q16mZ8xkH2XS26SgZNny9ZchavQ1h73uw2GK+YUYWvR22sSzV27VZC/WLfcQJnIzkwclbmG579DE1JqOTj/uPZcodRUocmMEkjvUe4uflmQiCSO6zeToSwRg7b2+pNxEVylXPc6Pv2A9Y8vRBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632012; c=relaxed/simple;
	bh=nn8qitHbga4k261iB5T76zWCw0giEEr3cirFIPmJKX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tDRN+GM6esmHPg9Iqb3g9NqjewK20hj9rKVPeGTY3S+uI/H5ceYSftTVz8OxkNmiKmO/xc6i/FaXP9dRH/OZeEFmR+MsAavxgiDDiILuUdPFDdA1Ln61kvQs8rt6tnIFAAbxXUNWOif7v8F8k+81LEIb09MIPPkiYo/mb5sY6WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g+ELWOX5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CedgQn8M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfrGY004185;
	Mon, 10 Mar 2025 18:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vseEcLa6h4CJDUzBpXHMTylGhZvGn5HT/2rWaaZWFak=; b=
	g+ELWOX5Qzg0YZTNMwbiog72/JcS72hki65ShYsS0a2f0rKK/xrOaXkTaZotkd82
	XUtC4U5z9ePFdECf9H45L20OoN+3JwGHe75lX95fWrrt73NHOUZ98cMmlEQO3cKU
	E+j54mQdfFOfCejZjZwHYHDwgj7ZRSRkxHV5wANPJweGN1ON5Nt1Uq4L/e9I2NA8
	dwxos9rNgDux6E0ojlJr7cR6d7hLIRhFXOMpzlHBDVfXrpM32gofJ7MpDJd3aSSN
	r7Th/A5q26zR5fWvdKPAYfB5S3l4GN7IceoI5Plvze3GdzQCeFsdCoH5tDGgvUTo
	R8YrCriDawol/kErRb6DHA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb3c63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AH4vLc015023;
	Mon, 10 Mar 2025 18:40:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbe8yky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzTXuqwPfg0fkz6876mq4YR4EPtI0UTcbW3/aKv5ExmO5D13YlOYFY/MkeUieM9SyZnDHpC7EfzRnBnirxHSpeALgH9vQuT7aJBcZinsQ8OtchKAhM+6Ot/bFKihbksjN1FB5cuqmAVpMkza9fi3g1U7feLNAdNCtyIe7i1qF8S5dSFH8upNqSbCL0pN3HLgQnCAMsoZzze3FUxwYyd6AaIW644cGSc6b6Ogy5iTPAdi4DFFYVbL3o0tTKNG+czVhos+pNc8d2ycybdkJeQ/C33ubMqVLBwSPudcR5DPlBuxhQj5sKOz62ih6wS3gtbKsgrH2VY1C73jhXJJ7TInFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vseEcLa6h4CJDUzBpXHMTylGhZvGn5HT/2rWaaZWFak=;
 b=BFSmSsmZmJ08O/u0RPUmfPnpxpgHx+S2yIiS9+RH7X0H/1jwNsx6r+oEUynd9bNyTSd7YGflisEb24TZeS/awviXet+MPzpsSmkuEQktRv4gHTflvGXSc+4NSUGDxrxrh24cPxTSWLUQWOZFj4EG+8aVG+y5vwhHMyX68wRnQ8U7NNeEQZeqpEohxxmaBvFMsDsosO4/OPyeDexm3VHBgAx/IG6zBRja8+xhDu6y8oeRVzRMfyEmrpKhOrUoS9d/NSj/RbACmqlSecMpGhyQSqsn493EqLznucqQifi9E7QoAC/B9GyRlxbQHEMqqQg3+rdvzFeme1DvaxIriknJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vseEcLa6h4CJDUzBpXHMTylGhZvGn5HT/2rWaaZWFak=;
 b=CedgQn8MFr+EYM2APdfMi8Qkhrjpw0z41z3zRJA1yPX28fQ2ish3S5FiMTgDYRjz4eN3JxR0Cmsrp2VO4tiJXe5y0yeMuqDKtUYpnmqPSv+38mhC+ENitWRqmDYo8driqOrXnHOYTow14rBoeh/et/rq3n0ccuord91Og+fD9yI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5561.namprd10.prod.outlook.com (2603:10b6:510:f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:40:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:40:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 01/10] xfs: Pass flags to xfs_reflink_allocate_cow()
Date: Mon, 10 Mar 2025 18:39:37 +0000
Message-Id: <20250310183946.932054-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250310183946.932054-1-john.g.garry@oracle.com>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc33538-d701-40de-208c-08dd6002f7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QFYjLinyBA+c+PjTC6mTQEqIqjukFx/u2TWUiFsLiQdMx5UHUF9EAG9uIuhF?=
 =?us-ascii?Q?rpOSAqYDTtzG0ZDThjXzzcawBXno4UyOg6EGq/Sdlo/p2Ai6cz/huhxOpMWZ?=
 =?us-ascii?Q?yWfRsKB9oBnAwAuJDfeJgrLY4Opm6RujBHwzs1sjbSVpQA+/MN3+g+LZ5ak8?=
 =?us-ascii?Q?WRqHiLoLTV1mvyEbfVSaMGoNxEXpsMsclJvcL1No33jiIZNxrJ5oQylJkr5G?=
 =?us-ascii?Q?/b4DOq3zZ1ygvfJd8OcHwEyIdJhd1B+p8Wi15sUZJ208vUPoktO93rEfhaOh?=
 =?us-ascii?Q?Ua/j5XEuHvi6RFWn90x4Wme4Nf0vDhum2uTz3Ko0K+VliDN5lAO6xVTI1CEs?=
 =?us-ascii?Q?U//mgiEAuH535T2Q+8VQPPa1bJOK0KHxzh8TI83gLx4QXH7pWEfNNr1j+eXs?=
 =?us-ascii?Q?2O00Fp/1WbIHMHMCsPcFCUuers4jmLnPpoQrzB2nYlAVqLx0kQ+vlyw6z7P4?=
 =?us-ascii?Q?xAdF9mly0FtNiwvee5dVqHVnv1BzzrAJo+cpVawqgXdOOkP9Q+siXyGlDlyO?=
 =?us-ascii?Q?DVb4I10JWPE+DYvc+hxB2if9IoO02pZemlW8wAde4+q1xOeWHHv3ttqAjRAA?=
 =?us-ascii?Q?iAoqob1BtLgadmc6d4hXj5r3CU616/PywyKzZmTDGaE+s2cNYZER8wZcjerJ?=
 =?us-ascii?Q?hMuYUusWeR/xPrRLlx/zto0Ii7ZaeNKVTa7ZzeSnPOsYY71ltwN4FsKW3KN6?=
 =?us-ascii?Q?cw80LmTEqs+EYRw8uEuTa2mz6KqFkPaJhWZYHUYjmohjFDp8hFxz23RLKRTG?=
 =?us-ascii?Q?CszKLFPzy0C7aF0V86nlGiwSaR14vN3jANmGnHdIA8jyLaUWLWJMflWlEqMN?=
 =?us-ascii?Q?v68hq8Z58SmATEPqytk/0augTfxZ4fgGDqKAqQzKftgxPab+g0f9ZVjzv9Ax?=
 =?us-ascii?Q?44wNr4UUzMeTVuap6BQuyaWRYloWj1m7gfaPhFYih7C42GGQWoAMi24CJ6sK?=
 =?us-ascii?Q?z6ZLHsco8cGgLe42T+TZBY4+cH56QJzES83egyVYYdIuX1xMWqh7P2Ny2MbA?=
 =?us-ascii?Q?+rCoEwcbu61jXIT8dYWrqf7SDt0MuC0T6cV5c5vkUjfSz208VCQYxhIzbtfZ?=
 =?us-ascii?Q?s+bceNggI5b5Zn+7NIOC0olroaLMUiTNKPHDvrT0UtbCce+TF4a2bZSHPab+?=
 =?us-ascii?Q?q/F/B00sfV+XxTm3nHQHFhrFdNC4ofOrts/vtv7EhVWfxL4+B8Ak7SYKBcb5?=
 =?us-ascii?Q?c8zRbiSXAC9J+NChUoq03a8D4oZiVX88CG7BlCQOd0duWllGggBRGrQOesCP?=
 =?us-ascii?Q?Rbo3Gk59NXrUsdqEdTmfkS2MayIIzOZCMAOfOsMPWKEFfk70Wvs5tcvvJ46N?=
 =?us-ascii?Q?epBb3qPD9PtXWEQx12eXcnqqux6/kJKlpGkERJ5iqqgwwEZgaeifVZYXo153?=
 =?us-ascii?Q?ukrVHekX+Jmfq7gmAcHTpierc/3U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0iikyoZTF/CMEr6ZaQrxhw8URZM/KiJA5aTmOdgf++7UuDhsnacDFcMswFx?=
 =?us-ascii?Q?ND6NLvQB30/OKqviVZemLfhGZWgBqXwabuYpH7fLX7ZP7yQKVp9HkuRMqdBg?=
 =?us-ascii?Q?2GUuhr7D0ZY3rg8fXDsfhSCAtQsLflV3z++3P+7sNPU50Tf7j4+IhkbomYBf?=
 =?us-ascii?Q?bi2yfzJbhmig3ZtjyqMtftF1DNPLXsWlbEc1IsBO/IGdIgCqIDf3couxIzRR?=
 =?us-ascii?Q?ACixASvTWjwHz6CgGxIi9nbWs56vtFqHTOX7iYTBuz8RtIk8XBde/4FAm5t+?=
 =?us-ascii?Q?0PyNygRreGFEkZLqjLnuheSiD+uOFidLuFDVLtT/YDrn66H7S3wk/Jjh9RBG?=
 =?us-ascii?Q?R+efTz/TaHAMa3xq0K/C/RMLlLz1RLEMyiYOey1OZA0zSCJp3TcMD8bbGwWs?=
 =?us-ascii?Q?BUA1wv3EIRAOBmP4ADUlJlXdr0N/0zAZBJCh3IekS9I5EwBitTzOoGtIUoRu?=
 =?us-ascii?Q?Cyq/GzBvePQRQvLQmVxQzzeCgrI1iOedBDSUcejzxTLLSnYuTW/fa0xDQ0JU?=
 =?us-ascii?Q?yzfAyY/JHzwpSUfyZNX1G0tcnuch+J7C+7LtecCzfia6qccVhb5zFzC/mGme?=
 =?us-ascii?Q?S782ux6tcWrAGAHk47kGC36gC2+VkNKoXh+j/eqd1v6OVhLGeH42P6s1z8HW?=
 =?us-ascii?Q?A1RXhmL4DZ/uWe7BVvtgb4+3C1GjlgFIH1E54skmtnXpN12zex7jwQnNrGn3?=
 =?us-ascii?Q?Y9Gy9i3WX7HaeTVzfVwXonhC+7pEV8lNKcIbtYIAMXKRuPOS7XBe/G5SHlzD?=
 =?us-ascii?Q?bwRMxfsqc/XKQ048oFV/lM0n1CKuWjahLbAWBoFiec5FqqxaeZO89JYjYQ2S?=
 =?us-ascii?Q?S1xgnlnJOEENctIZjnbkjej6UzpFiKq57UDP2OfVwk/UsZZqZThag5Iauf8m?=
 =?us-ascii?Q?LPPM8/WQC8dddFRl23ANPb0lga6JTbuII8GTMy09jzdi2uqLWJMf84PuQ1z+?=
 =?us-ascii?Q?8OkpkikkKqWXnsMl1379RZF2eu1TLOaUzQnGomuTtg6U2p+T0DDarQ5NEOK7?=
 =?us-ascii?Q?H9JsFk2ImMPWEKb4XFCT+Vu/PK1AvyTJOAoigRVLommmz+Btt9orcFSa1QDL?=
 =?us-ascii?Q?3GYdE9dhGhWeH5pT1g8AamZ7c3+oRGqX/56n4Aemgo3V/0pZieHNeQ+iWzdp?=
 =?us-ascii?Q?9uJ72dNvBxE0raX6iMKvuCC2jn2T59egZsomLtvrjsdY5yAITud/MqSVYSB+?=
 =?us-ascii?Q?kL9vPQoEu4nhWnpkCykgonOCbQDm18Y6RkLOTPlP7f0+2Ly/s4qFrVOuTGiw?=
 =?us-ascii?Q?jL1rickRHGapiC7euI2r1BmnTqpTq85JGfJjaY9D5B7h0exaeR8lJSbqK75L?=
 =?us-ascii?Q?M80VSZbHHqPgxiR5GVCxi1uTbfoUJhtq08e9PGDxKONK6oXObNUXIU8DixBk?=
 =?us-ascii?Q?KLISyEMPTO6EJ37wuP2nNKQSiwnrUix4AxOWo3xJVvEfhybj5oi0840/4j4R?=
 =?us-ascii?Q?a9qmP4bWXVnkAoDVpALbUQI7u6uZ5XGGpydKPnrw12sqxHcdJ4a2JnMJVUSD?=
 =?us-ascii?Q?Z9hOD8f2s/Efo2Sm5HPjQa89mjaNckX6pv2ZQGqv2RoUZBL0/nrpDFpwvlPa?=
 =?us-ascii?Q?5wBUAGNFoZkiESJYB3QDuim6IpzSQesXITeQEMaBtnqNvszjDKB5KEkk11LM?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7S2i69raq0JYZlgSKX4WjUkGP21l5SVFFQ1x+MqOR6C/rTqF7clzMEuLsnvQ8UY+SokKtEoOSIfCMMtzPBoJ8O/F2iTY4dT5CJMR9goJ7DqhlAbdjQiZ+JyPxbHTS+wEMQaHvlrzat6rPs2Ri1qCiNYh1ZBQB60VflTPFA2jBBB0dkYaTcw5v1JJbUKKphm9+oMBMYlXWDIB2AYgX++Jx1Amo5EbUHktqdOzttHN591ZvubIjfiybWno9eYp5T67kpLY0ZF7tTFYFpHxZIO4LGt19mk8wkmXErd8H05hnggvF6f7q6AH2FSJ90h3qNtzWVFBaU2avwPTk49GDzWXMWwS+tFKM5Etga0Ir9RXWJ09xVfXtwUUNP+U4s62m5JTRUHCKjwIVDhGvW0hcHGqoPa9n7otoJ1p868Y4PhfZbDrIbxQQY60GS8fOF2leoa8Q/StIpbjzQkds9gqaFHI79mjxbj7JBaSPAvuM23g6dw2fImAVKlbj33SjFf34+yiLnLoaZjP1t42sKassqgSZ0oeTWKELN6Ub7bnXqQD4/f15NEFd+9/P0Zqc1Da9SVFQeJ/s1GNe87MtTF0J2rfMcXAp30tE1DEe8QXz/CFWaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc33538-d701-40de-208c-08dd6002f7fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:40:02.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc0MEbKpP1Ul8FUGR1DLwNURlQrIlSwXi4MlDRpxM5crQVDKVbVzb1E3YUorc+Ff1zei8TTnApIK68Zs3ovUQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100145
X-Proofpoint-GUID: I5_-wLi5kyiXIz-pOJuGDzBvL1ALswcH
X-Proofpoint-ORIG-GUID: I5_-wLi5kyiXIz-pOJuGDzBvL1ALswcH

In future we will want more boolean options for xfs_reflink_allocate_cow(),
so just prepare for this by passing a flags arg for @convert_now.

Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c   |  7 +++++--
 fs/xfs/xfs_reflink.c | 10 ++++++----
 fs/xfs/xfs_reflink.h |  7 ++++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 30e257f683bb..f3a6ec2d3a40 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -813,6 +813,7 @@ xfs_direct_write_iomap_begin(
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
 	int			nimaps = 1, error = 0;
+	unsigned int		reflink_flags = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
 	unsigned int		lockmode;
@@ -823,6 +824,9 @@ xfs_direct_write_iomap_begin(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	if (flags & IOMAP_DIRECT || IS_DAX(inode))
+		reflink_flags |= XFS_REFLINK_CONVERT;
+
 	/*
 	 * Writes that span EOF might trigger an IO size update on completion,
 	 * so consider them to be dirty for the purposes of O_DSYNC even if
@@ -867,8 +871,7 @@ xfs_direct_write_iomap_begin(
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode,
-				(flags & IOMAP_DIRECT) || IS_DAX(inode));
+				&lockmode, reflink_flags);
 		if (error)
 			goto out_unlock;
 		if (shared)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cc3b4df88110..e9791e567bdf 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -435,7 +435,7 @@ xfs_reflink_fill_cow_hole(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	unsigned int		flags)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -488,7 +488,8 @@ xfs_reflink_fill_cow_hole(
 		return error;
 
 convert:
-	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
+	return xfs_reflink_convert_unwritten(ip, imap, cmap,
+			flags & XFS_REFLINK_CONVERT);
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
@@ -566,10 +567,11 @@ xfs_reflink_allocate_cow(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	unsigned int		flags)
 {
 	int			error;
 	bool			found;
+	bool			convert_now = flags & XFS_REFLINK_CONVERT;
 
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (!ip->i_cowfp) {
@@ -592,7 +594,7 @@ xfs_reflink_allocate_cow(
 	 */
 	if (cmap->br_startoff > imap->br_startoff)
 		return xfs_reflink_fill_cow_hole(ip, imap, cmap, shared,
-				lockmode, convert_now);
+				lockmode, flags);
 
 	/*
 	 * CoW fork has a delalloc reservation. Replace it with a real extent.
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..cdbd73d58822 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -6,6 +6,11 @@
 #ifndef __XFS_REFLINK_H
 #define __XFS_REFLINK_H 1
 
+/*
+ * Flags for xfs_reflink_allocate_cow()
+ */
+#define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */
+
 /*
  * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
  * to do so when an inode has dirty cache or I/O in-flight, even if no shared
@@ -32,7 +37,7 @@ int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 
 int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		struct xfs_bmbt_irec *cmap, bool *shared, uint *lockmode,
-		bool convert_now);
+		unsigned int flags);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
 
-- 
2.31.1


