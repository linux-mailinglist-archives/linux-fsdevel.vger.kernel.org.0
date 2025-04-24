Return-Path: <linux-fsdevel+bounces-47299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD38A9B9BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB59468233
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E827C28F951;
	Thu, 24 Apr 2025 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TQwBvg3O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LRF+6UMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F428D850;
	Thu, 24 Apr 2025 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529369; cv=fail; b=hZlfxiHF/n4lQR86rJrphUIJv5oPF0HIfwSzVrFghaXQvit2JLZZgYD5lvTK0EBZNmDEs9xx7gsHVhMRkwrHPgbpJ/YLhds1AmH6Sq+/MwQ8n1ikletVL1b1iy0RLW6mFgTPf+uEyyk7SecC592CPYxfZWQL06gUwGRDldz6Hs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529369; c=relaxed/simple;
	bh=foki663qi9ihuyciolzzihuPRgNxLl8dCa5F8CjO8Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTHjnikWFsca68eKCBidxCirL9B1H/RQEh+KGh9v7+Nr/+pnOfQRfZ6qfjC84JvX+LL3rnU31Bm8tAydmdFsoB8OleAlGhIWFGJrFgVpKUE+u/QfwAtEhTKkADyZnAFE10+T0BT8cZvyfQJ9OBekY/OkPOsywxKtdM4CizMKl/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TQwBvg3O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LRF+6UMp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OKl165013425;
	Thu, 24 Apr 2025 21:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IEiaYndK23eOuuImiTFANnKez1X3qLslCdnygODfcPc=; b=
	TQwBvg3Om/WXbCeCfz3AZlrng+Yf2yXVdyU/lDgf1mMLpAhXjHDEIuuyMBSmRrDg
	L8wxnrSk1m/63eXqSlCPO4fWi3KQ9IHVf0WbgABxBHCWkJ+GYZj52fDpVHzvZ/dx
	D4yGNI5DpE1EMHQsncVAoBkyQWhoCcfXFG19K+6T3+2YRrC/OKHMOdj7cDvL3W//
	CjdjrTnN+fbpK+1CwBTZubFOLj/ffquMfqb5ZzMk779AC8XE4rUtkj5U2hzUSH7E
	z9oCMldvlUqwei813DPQJEVDwZarkzVagq6q/03ycNZ6GNiahha1Ay6mjmtzwLQT
	pPTTnTUzjf92n9uFb2MTsQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467vmur1v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 21:15:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OKrY4t031643;
	Thu, 24 Apr 2025 21:15:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfrxs0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 21:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tF6wNk4P+iRF+QHP10U/4F0TslzD5fD1ZUG9/Edoi9O2OEEpDfBRqQcCXbLUt/DyPt2Ik5Jx9HIIwtr7goYCUOLBf7dSIR4f9Tui+2Fq2Wt0M/Gj3UrPseG0UagG3g5ADIALfcUs6fOxc3e7K/uDTReVZWim1jZuxahg9MXoDVJMAVc1gqdicLn1IdzV2Dk0ajBLVdN6trnUKXPRpN8cFjo9VP7H+eN+G/3Pc/RQ9As4JAW1wFaui46z218KoR/Tsj9mgpFYbwWM5URT1nF1W7R7szklheaooeEZ2pGjvkikxngwu8amwwVQTB63UyYA4Wh3HEbBdKsAmgc4E/SyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEiaYndK23eOuuImiTFANnKez1X3qLslCdnygODfcPc=;
 b=bJyo8lrLZjf9uTg//P9fy4qNJ0XSMHrmvXaqVkwYapNHOt77m2bwYjhJcR/x9LFE/Ap0nFPswghUlnuu7aDHTBLSfPxxVKbU+Qpt/M+w1MnDIiNSjYl6xHwOHzk/lhPvLonIsCKauoro44Tssk/nVyH5CKB6P6GOevyC1BCWy9bpEw//MZqWE/93et0SH0ZdHK5NffEobo2BdK+yeMQDyrDg1zadrPCCS7IdOgk1dgzWMXTDCJbCbZhbjBwoKYOCVkuHUoMW02abfww1yk7AIAVFanmZ1EdRXyyddrpou9w7+BM3MTjxyypE/Lv52LW1WPV4R4jY1c75XMJDIlSKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEiaYndK23eOuuImiTFANnKez1X3qLslCdnygODfcPc=;
 b=LRF+6UMpMfAv7H5ZWaGQZ8vGu+McjQknA96acBPtyYiQxHURBWJ8JaS4nfW2/UxE0jLa7djomiT8WUBbrVUXzmDikl/Is9jIrvNsfeeBeP6Zp2jjYHKfpzqgNjdISB2ZkXk76qxrve8MGrxUA2C20rCJczqt7RFetkqSVhAwOFQ=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH7PR10MB6225.namprd10.prod.outlook.com (2603:10b6:510:1f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Thu, 24 Apr
 2025 21:15:47 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 21:15:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm: move vm_area_alloc,dup,free() functions to vma.c
Date: Thu, 24 Apr 2025 22:15:29 +0100
Message-ID: <2c0036a3678d9cf55045cd215e9959aa92e32cfc.1745528282.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0323.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::23) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH7PR10MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f966e34-42f6-45e7-d7c0-08dd83752e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZA07GfagvkVb8dF4oVndZ/ZFlnX/EsmleiBsUuSzUBpOUt35TGE1pmH4Pdu?=
 =?us-ascii?Q?PXVglUhkersoqSt9mKTbHhYRqvqMKJxtcMrfyBeOG1Y/4FnzIp5YrW0NscnJ?=
 =?us-ascii?Q?Q35j7fSzm9VY52ROfv11QLerIkVVvanOV8ip7FA2G6xiAcV/fkhbZaQgizDB?=
 =?us-ascii?Q?iwrM3LC7GwREep/y2AMPgCMG6jzDBGCClzYb6fMumFBGvab0GT8xT287Acfo?=
 =?us-ascii?Q?baVzjO0SPzdgJTlDltVl9cDj0oOCvefSUIQFhqVNxiFxvczuWW8cTCdMCiuG?=
 =?us-ascii?Q?dbu+jqAO1r+o4fGCH9/r92OZlUZPlRaPfcsc4szTO0ndPbvOBBpmuwJgPf3I?=
 =?us-ascii?Q?MRkndpItBFzso+4BUPhcgsxA7lnUjsYPPZToPB3XKmyz227aszm2jV0HXgoQ?=
 =?us-ascii?Q?RBPm25k8ppn6jcTBqNwKRCYsVnSYZn2coOgVzNquHwKnIAzRNHMv1rZyVfwv?=
 =?us-ascii?Q?cDStJtPEn4809vtTskid4YBUhyT9Cx3RPeS1CMnzX4vhApovd9FFbgxYb9hE?=
 =?us-ascii?Q?qhhHQmpgBUdV9bOZnsAul6T33Nv1GpSD5E7qQ+7bXgOTq1Xdw8KeQ8Kh99f2?=
 =?us-ascii?Q?MOUWIyVBB4dijuIyze5LSy12VPYJJDd797wHmmAtZeJNtrPmf4+wFS0wOZ38?=
 =?us-ascii?Q?u7wrYfs+qzF5LSW1k/cXc1Bhr7rAMhUUuLH6/BmYUXGybDILHnFes97m7Oef?=
 =?us-ascii?Q?LvN0U8uYIWlAJnxVRydSgxOsa6LzhmM6M10SAJ0gY8fqaCQ4yec5BTTN0c6K?=
 =?us-ascii?Q?KwUqCCb0xEp6X6GVHqQQ+alQDw9AwOg1jolnoKB0slGOQfROhUnXL4dLhWV5?=
 =?us-ascii?Q?UcPcZMdL1ddBMU8dFaWQRN9iaqEaH5PnpQYvd75nCI6vVNg7pEh0OFoqnqd7?=
 =?us-ascii?Q?tSrb0q4ysROO46KO/YbI4/0RFdtcX66unJPnrMqZFWGq0QRjY0lcSYtIOG2t?=
 =?us-ascii?Q?vnL3b54rrEdy+uBdK8Ta6kFxm0g9PdhfofdTiVuwYQ7FRDqdHM8+NQ19qagB?=
 =?us-ascii?Q?mB1JoIgr/uKhviNp4LBFdrZ6cJjmGNxi6B+xPc7fRbRB3VZLg4/FxoeOme0D?=
 =?us-ascii?Q?AY+kBAeDBSQolucOg5DSI3qYqyO0tKKN0OXOboDWofUZBvvpVwo29Z8H0kVq?=
 =?us-ascii?Q?rhgqVLH6vaAmzTBgJP4qIDa7uIalvPiLgtNXl2EmzZbTM6lOOCuK0w3E5SJq?=
 =?us-ascii?Q?TvIqFbfoJ4iDC+RqY8J3d5aFaHvUUIU+TpY2tYzkiCkCryfj6Ql2+64b99JI?=
 =?us-ascii?Q?O/DTZVbW52PaO2X9LW4+aCctZi8uGllIdryhVRoM/zsvi+oYkacad6cSVI7T?=
 =?us-ascii?Q?WZLrtVEVaE52GUe4757XGxvS9ngyjqQMr5foQHp56pk5IuyBD7vb9t1aVQ0n?=
 =?us-ascii?Q?ol86xXcLHdM1T+tarhu3oIYGhQxTUxXBNNiUAlZeQ0I6N4O+TMRHaAv15Ksc?=
 =?us-ascii?Q?OfYldKtCM+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HHkSjx1vDrxN5oqWR5x4NObE0LgyZ562QXC849RhXauWOvQ9NDvnXcUk9vqa?=
 =?us-ascii?Q?SLR1JFExJ8BaBLdZ38k2clAauBn1aGjkuXhOeLNkPHqMxP8xuNThCvwMaaZr?=
 =?us-ascii?Q?u6b6evBLJrEn3njRH00VqFJPcoaEyXn9IjWXIbkI+2kLYRATgESMpY8yeroH?=
 =?us-ascii?Q?zdCN/nvAhsgiYa5JxZAswYdmh7UkWa/7huc5M4vb4gQGZl9z3qsRMd8cydsm?=
 =?us-ascii?Q?SvftKAKPAqxcXNhqRTxTP5qZLYi9XpzKXu+XLbav8ZwX34wqh4I6L7JBQ1VF?=
 =?us-ascii?Q?nRC3shP2CoB7IJ2gYtDICanXDDau/e7ktRLO13s6Db2ZCucyMijexxke11Oe?=
 =?us-ascii?Q?ayZiaxChsIEPbQtrgCraJqhuJcqeGUdnOH3bEMnQ2tHNV5lBu0OFvPHUgY/T?=
 =?us-ascii?Q?N+FU9FxFam30ToYs57gVdBl5zSr+IPl7eWDWQEVnCplWgo/BufeJgnfeLffd?=
 =?us-ascii?Q?jvVZ6DpPMdqxCtEh0HqKfwJLoYaauIn8MOe0llotyO0gOy1dJ5+vfg/1AUtd?=
 =?us-ascii?Q?0PF+L4jkmcyfgZEGHrrnlEDxuCBekyv8pSuB/fPf77E9cfYtwHaIxLG1txaD?=
 =?us-ascii?Q?qkzTxFiUzYI1TxwT1uKt1C/3PeBFvGF4HuGRKx8jREaFdsJiV+1GqDLEh+B6?=
 =?us-ascii?Q?YD7uQ7f7xmWH2j64A7P1N9ddYINn62fgJ+yS5wQpb2uO9C3cgLguFAMBFGgB?=
 =?us-ascii?Q?HTHKsBUiiNARVpb03rJSxmbw4InnSIMKn8R2WEojT9za9jvxr28wme02qZJC?=
 =?us-ascii?Q?CtmE+hmROn1ZotDnNIfpAp40vE6G71tPEoIQq3ntM/DsjTp6v/JlOwHLZLy9?=
 =?us-ascii?Q?cTK40kupkEKE1lVDNEsWb/A4DxBCPMLzJgE9WwShVy0R1YY3k0hnNhM3BRmB?=
 =?us-ascii?Q?v3UAd4GBBTfONbswO2W31ISdl3AbklTdsbVeS18dRjISmnaidgizZvtNy9KY?=
 =?us-ascii?Q?IW2TrT1z1QN75QtKT+OF9aAwYhgR7yMUhvIp3zkOuW2iCDIFhT9pw6oH74l4?=
 =?us-ascii?Q?eUmSBpoE/yGjHb5AUUGT+/dTATiP0eal1yG2L/U1Jt4O3iclz2ofyOo9mbQd?=
 =?us-ascii?Q?h3dxoO13+iU36w7xJ95I0fKu4hcrOZB8It6ude8fF/R203icK4yZs0SrDAXM?=
 =?us-ascii?Q?30GR5bRaIGnQKUqMD2PLM9M2YQLmlk+QWP8jQ+j3ExMVuMeKmB5GEI76vLCg?=
 =?us-ascii?Q?b8XHUMJQHyQUPCK6W2YaF41dJusG0RWGYkgEJ3Rj1Mk+y8w9tV+B2bx2+ILJ?=
 =?us-ascii?Q?Gc5IZl1N5RbjSfj1SA/7SLhM6zNZ84T6W947dE/+hgRBlvD8fX68kFNq9+v9?=
 =?us-ascii?Q?BtW1VdNda4lQnmRRWmWS9fwtG1kmsXzlnRjsztNv4aQAY5rQfxEtNtbxWuV7?=
 =?us-ascii?Q?Q7HrdSkTY/5rJs5ttDPt1tnYV8iHUJd746xJzjF3IEpBVY86NJuu7Mj+800g?=
 =?us-ascii?Q?3Q6iD0ykJJkm+ET0HsBmIH2XcjTaj5GFCxX6/g8K5bRCF4DQKQrjduWcyzsz?=
 =?us-ascii?Q?oSH4cIGeKzwjud6hkHq5OopbUIumn0Mi5Po+5h1E7y7BxzfaI7628uARi4U8?=
 =?us-ascii?Q?Rm9im9LzlsJP/3St/G1CgGUIQR/iMc6iHu7U91NPUuVhladbqUEH6H8JwLqx?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z6RhjWI5FuNLYdUYvF3tmoPndAyEoOwcluhrKjFbOrD/OJI3LzP9/xlHy98FVQLJmyVStBZzU+95rKNocMZIucUi4OSrUAtsvMPEnNxLmda9X3jy8uUaJXHJ5HKNeJedl4cuwVuqReREjrmXtWitPwbnECFIf25AAvqgabjwFA0nWfzW6fW3qc3vb+/oBBHfJMuxo/V2ZoPKxVCClp17t7E7hqB5QiXOEBseQHM0/fpC42jJM0qkTeJe+M/8hfDuZSae10EwI5IHry3hbvH7lmVL9IPat+2Rdm5rArAxop8QalFSZTQ3tCC6pKci0nf2kSG6kVKb1vGdCzeDutTDt558wxTFJxMLZUWXKnM1uMR46rg7rCuClcyKvwI9LRXUo2mcgJClMJU94KYryEHuE+I1HvemHvk/73lGgKigDFx0hAHio1Jfr7sfP2hIVWMafLhKDjROGd12eEeWXFJTq6A38AXZdoDsM+mgQGFeMvSvw0ixrvU++8auz4IC30rnodcNYwlrjOUd5Gu2Qn9D19Q0ZmuNbJnv4Gys2I98mrCBdqSCyPPtdWV0vA93ZjTNeUkkISJnR9lfo2DEhkDihvt1kppC0/DRTds5mI7NzSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f966e34-42f6-45e7-d7c0-08dd83752e7b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 21:15:47.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4GsYYy4+tqtdNc7tXL12thsE7RTkciCnWM5/7SxU98M77dejZNGrpEHNuNwrm6a1zRSYS1qOSDk1j61nbjUazYnjB4Quc1KVeIT83MpGH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE0OSBTYWx0ZWRfX+/wB73BgG4jr L6yIErx8x5/TcJcXVaCxpx6l5nnwh1CieCrsbQfXDUxU0U2+Duj0GfWy+J3HwOmxyq0X6auVldg 7jLU0Zj7Wbm1Lj1Ow/A4mR9SUIYfDkcQm62pPxeV3KgSAGZ8Jxbct3r7miCuAzA7ptbS0JMuHgj
 vBv+OCRqad7wBKBKXk3YyCPVY/QvDwFYVENOHIxXT4yI43/0C/Tw6dh2S3qs9UzlBF7gfP6SFb7 hcJiwvTvL4yB/iHuml+Z99tU1GgW8L5KLmy+LY+Dz+WbfA5JlA/Gx7zjF17nfgQtV0NXJx/R0d0 e4DsS0YynRA3uu8TdUfhHtPs70jLybDH3Lyx9MV8LrhUXVQhhMuvc10jj3Uhyzp7R3BqVqktg70 pD8M46xB
X-Proofpoint-ORIG-GUID: U4xk9mF44__mX5b04UXWwsfpRyyAGGpP
X-Proofpoint-GUID: U4xk9mF44__mX5b04UXWwsfpRyyAGGpP

Place the core VMA allocation, duplication, and freeing functions in vma.c
where we can isolate them to mm only providing proper encapsulation, and
add have the ability to integrate userland tests.

The only users of these functions are now either in mmap.c, vma.c or
nommu.c, the former two not being compiled for nommu so we need not make
any changes for nommu here.

Update the tools/testing/vma/* testing code appropriately to keep the tests
passing.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               |  13 ---
 mm/debug_vm_pgtable.c            |   2 +
 mm/mmap.c                        |  86 +-----------------
 mm/nommu.c                       |   2 +-
 mm/vma.c                         |  89 ++++++++++++++++++
 mm/vma.h                         |   8 ++
 tools/testing/vma/vma.c          |   1 +
 tools/testing/vma/vma_internal.h | 151 ++++++++++++++++++++++++-------
 8 files changed, 221 insertions(+), 131 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fa84e59a99bb..683df06e4a18 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -222,19 +222,6 @@ static inline struct folio *lru_to_folio(struct list_head *head)
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk);
 
-/*
- * Linux kernel virtual memory manager primitives.
- * The idea being to have a "virtual" mm in the same way
- * we have a virtual fs - giving a cleaner interface to the
- * mm details, and allowing different kinds of memory mappings
- * (from shared memory to executable loading to arbitrary
- * mmap() functions).
- */
-
-struct vm_area_struct *vm_area_alloc(struct mm_struct *);
-struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
-void vm_area_free(struct vm_area_struct *);
-
 #ifndef CONFIG_MMU
 extern struct rb_root nommu_region_tree;
 extern struct rw_semaphore nommu_region_sem;
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 7731b238b534..556c3f204d1b 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -36,6 +36,8 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
+#include "vma.h"
+
 /*
  * Please refer Documentation/mm/arch_pgtable_helpers.rst for the semantics
  * expectations that are being validated here. All future changes in here
diff --git a/mm/mmap.c b/mm/mmap.c
index 31d2aa690fcc..0059a791cb7d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -77,82 +77,6 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
-/* SLAB cache for vm_area_struct structures */
-static struct kmem_cache *vm_area_cachep;
-
-struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma;
-
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-	if (!vma)
-		return NULL;
-
-	vma_init(vma, mm);
-
-	return vma;
-}
-
-static void vm_area_init_from(const struct vm_area_struct *src,
-			      struct vm_area_struct *dest)
-{
-	dest->vm_mm = src->vm_mm;
-	dest->vm_ops = src->vm_ops;
-	dest->vm_start = src->vm_start;
-	dest->vm_end = src->vm_end;
-	dest->anon_vma = src->anon_vma;
-	dest->vm_pgoff = src->vm_pgoff;
-	dest->vm_file = src->vm_file;
-	dest->vm_private_data = src->vm_private_data;
-	vm_flags_init(dest, src->vm_flags);
-	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
-	       sizeof(dest->vm_page_prot));
-	/*
-	 * src->shared.rb may be modified concurrently when called from
-	 * dup_mmap(), but the clone will reinitialize it.
-	 */
-	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
-	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
-	       sizeof(dest->vm_userfaultfd_ctx));
-#ifdef CONFIG_ANON_VMA_NAME
-	dest->anon_name = src->anon_name;
-#endif
-#ifdef CONFIG_SWAP
-	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
-	       sizeof(dest->swap_readahead_info));
-#endif
-#ifdef CONFIG_NUMA
-	dest->vm_policy = src->vm_policy;
-#endif
-}
-
-struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
-{
-	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-
-	if (!new)
-		return NULL;
-
-	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
-	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
-	vm_area_init_from(orig, new);
-	vma_lock_init(new, true);
-	INIT_LIST_HEAD(&new->anon_vma_chain);
-	vma_numab_state_init(new);
-	dup_anon_vma_name(orig, new);
-
-	return new;
-}
-
-void vm_area_free(struct vm_area_struct *vma)
-{
-	/* The vma should be detached while being destroyed. */
-	vma_assert_detached(vma);
-	vma_numab_state_free(vma);
-	free_anon_vma_name(vma);
-	kmem_cache_free(vm_area_cachep, vma);
-}
-
 /* Update vma->vm_page_prot to reflect vma->vm_flags. */
 void vma_set_page_prot(struct vm_area_struct *vma)
 {
@@ -1677,17 +1601,11 @@ static const struct ctl_table mmap_table[] = {
 void __init mmap_init(void)
 {
 	int ret;
-	struct kmem_cache_args args = {
-		.use_freeptr_offset = true,
-		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
-	};
 
 	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
 	VM_BUG_ON(ret);
-	vm_area_cachep = kmem_cache_create("vm_area_struct",
-			sizeof(struct vm_area_struct), &args,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
-			SLAB_ACCOUNT);
+
+	vma_state_init();
 #ifdef CONFIG_SYSCTL
 	register_sysctl_init("vm", mmap_table);
 #endif
diff --git a/mm/nommu.c b/mm/nommu.c
index 79a6b0460622..7d1ced10e08b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -97,7 +97,7 @@ static void vm_area_init_from(const struct vm_area_struct *src,
 	dest->vm_region = src->vm_region;
 }
 
-struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+static struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 {
 	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 
diff --git a/mm/vma.c b/mm/vma.c
index 8a6c5e835759..65507f12b8d3 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -57,6 +57,9 @@ struct mmap_state {
 		.state = VMA_MERGE_START,				\
 	}
 
+/* SLAB cache for vm_area_struct structures */
+static struct kmem_cache *vm_area_cachep;
+
 /*
  * If, at any point, the VMA had unCoW'd mappings from parents, it will maintain
  * more than one anon_vma_chain connecting it to more than one anon_vma. A merge
@@ -3052,3 +3055,89 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	userfaultfd_unmap_complete(mm, &uf);
 	return ret;
 }
+
+struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	if (!vma)
+		return NULL;
+
+	vma_init(vma, mm);
+
+	return vma;
+}
+
+static void vm_area_init_from(const struct vm_area_struct *src,
+			      struct vm_area_struct *dest)
+{
+	dest->vm_mm = src->vm_mm;
+	dest->vm_ops = src->vm_ops;
+	dest->vm_start = src->vm_start;
+	dest->vm_end = src->vm_end;
+	dest->anon_vma = src->anon_vma;
+	dest->vm_pgoff = src->vm_pgoff;
+	dest->vm_file = src->vm_file;
+	dest->vm_private_data = src->vm_private_data;
+	vm_flags_init(dest, src->vm_flags);
+	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
+	       sizeof(dest->vm_page_prot));
+	/*
+	 * src->shared.rb may be modified concurrently when called from
+	 * dup_mmap(), but the clone will reinitialize it.
+	 */
+	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
+	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
+	       sizeof(dest->vm_userfaultfd_ctx));
+#ifdef CONFIG_ANON_VMA_NAME
+	dest->anon_name = src->anon_name;
+#endif
+#ifdef CONFIG_SWAP
+	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
+	       sizeof(dest->swap_readahead_info));
+#endif
+#ifdef CONFIG_NUMA
+	dest->vm_policy = src->vm_policy;
+#endif
+}
+
+struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+{
+	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+
+	if (!new)
+		return NULL;
+
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
+	vm_area_init_from(orig, new);
+	vma_lock_init(new, true);
+	INIT_LIST_HEAD(&new->anon_vma_chain);
+	vma_numab_state_init(new);
+	dup_anon_vma_name(orig, new);
+
+	return new;
+}
+
+void vm_area_free(struct vm_area_struct *vma)
+{
+	/* The vma should be detached while being destroyed. */
+	vma_assert_detached(vma);
+	vma_numab_state_free(vma);
+	free_anon_vma_name(vma);
+	kmem_cache_free(vm_area_cachep, vma);
+}
+
+void __init vma_state_init(void)
+{
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+	};
+
+	vm_area_cachep = kmem_cache_create("vm_area_struct",
+			sizeof(struct vm_area_struct), &args,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
+			SLAB_ACCOUNT);
+}
diff --git a/mm/vma.h b/mm/vma.h
index 149926e8a6d1..be8597a85b07 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -548,4 +548,12 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address);
 
 int __vm_munmap(unsigned long start, size_t len, bool unlock);
 
+#ifdef CONFIG_MMU
+struct vm_area_struct *vm_area_alloc(struct mm_struct *);
+void vm_area_free(struct vm_area_struct *);
+struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig);
+#endif
+
+extern void __init vma_state_init(void);
+
 #endif	/* __MM_VMA_H */
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 7cfd6e31db10..9932ceb2e4b9 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -1667,6 +1667,7 @@ int main(void)
 	int num_tests = 0, num_fail = 0;
 
 	maple_tree_init();
+	vma_state_init();
 
 #define TEST(name)							\
 	do {								\
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 572ab2cea763..fbd0412571fb 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -135,6 +135,10 @@ typedef __bitwise unsigned int vm_fault_t;
  */
 #define pr_warn_once pr_err
 
+#define data_race(expr) expr
+
+#define ASSERT_EXCLUSIVE_WRITER(x)
+
 struct kref {
 	refcount_t refcount;
 };
@@ -235,6 +239,8 @@ struct file {
 
 #define VMA_LOCK_OFFSET	0x40000000
 
+typedef struct { unsigned long v; } freeptr_t;
+
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
@@ -244,9 +250,7 @@ struct vm_area_struct {
 			unsigned long vm_start;
 			unsigned long vm_end;
 		};
-#ifdef CONFIG_PER_VMA_LOCK
-		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
-#endif
+		freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY_RCU */
 	};
 
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
@@ -421,6 +425,65 @@ struct vm_unmapped_area_info {
 	unsigned long start_gap;
 };
 
+struct kmem_cache_args {
+	/**
+	 * @align: The required alignment for the objects.
+	 *
+	 * %0 means no specific alignment is requested.
+	 */
+	unsigned int align;
+	/**
+	 * @useroffset: Usercopy region offset.
+	 *
+	 * %0 is a valid offset, when @usersize is non-%0
+	 */
+	unsigned int useroffset;
+	/**
+	 * @usersize: Usercopy region size.
+	 *
+	 * %0 means no usercopy region is specified.
+	 */
+	unsigned int usersize;
+	/**
+	 * @freeptr_offset: Custom offset for the free pointer
+	 * in &SLAB_TYPESAFE_BY_RCU caches
+	 *
+	 * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
+	 * outside of the object. This might cause the object to grow in size.
+	 * Cache creators that have a reason to avoid this can specify a custom
+	 * free pointer offset in their struct where the free pointer will be
+	 * placed.
+	 *
+	 * Note that placing the free pointer inside the object requires the
+	 * caller to ensure that no fields are invalidated that are required to
+	 * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
+	 * details).
+	 *
+	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
+	 * is specified, %use_freeptr_offset must be set %true.
+	 *
+	 * Note that @ctor currently isn't supported with custom free pointers
+	 * as a @ctor requires an external free pointer.
+	 */
+	unsigned int freeptr_offset;
+	/**
+	 * @use_freeptr_offset: Whether a @freeptr_offset is used.
+	 */
+	bool use_freeptr_offset;
+	/**
+	 * @ctor: A constructor for the objects.
+	 *
+	 * The constructor is invoked for each object in a newly allocated slab
+	 * page. It is the cache user's responsibility to free object in the
+	 * same state as after calling the constructor, or deal appropriately
+	 * with any differences between a freshly constructed and a reallocated
+	 * object.
+	 *
+	 * %NULL means no constructor.
+	 */
+	void (*ctor)(void *);
+};
+
 static inline void vma_iter_invalidate(struct vma_iterator *vmi)
 {
 	mas_pause(&vmi->mas);
@@ -496,40 +559,39 @@ extern const struct vm_operations_struct vma_dummy_vm_ops;
 
 extern unsigned long rlimit(unsigned int limit);
 
-static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
-{
-	memset(vma, 0, sizeof(*vma));
-	vma->vm_mm = mm;
-	vma->vm_ops = &vma_dummy_vm_ops;
-	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma->vm_lock_seq = UINT_MAX;
-}
 
-static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma = calloc(1, sizeof(struct vm_area_struct));
+struct kmem_cache {
+	const char *name;
+	size_t object_size;
+	struct kmem_cache_args *args;
+};
 
-	if (!vma)
-		return NULL;
+static inline struct kmem_cache *__kmem_cache_create(const char *name,
+						     size_t object_size,
+						     struct kmem_cache_args *args)
+{
+	struct kmem_cache *ret = malloc(sizeof(struct kmem_cache));
 
-	vma_init(vma, mm);
+	ret->name = name;
+	ret->object_size = object_size;
+	ret->args = args;
 
-	return vma;
+	return ret;
 }
 
-static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
-{
-	struct vm_area_struct *new = calloc(1, sizeof(struct vm_area_struct));
+#define kmem_cache_create(__name, __object_size, __args, ...)           \
+	__kmem_cache_create((__name), (__object_size), (__args))
 
-	if (!new)
-		return NULL;
+static inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
+{
+	(void)gfpflags;
 
-	memcpy(new, orig, sizeof(*new));
-	refcount_set(&new->vm_refcnt, 0);
-	new->vm_lock_seq = UINT_MAX;
-	INIT_LIST_HEAD(&new->anon_vma_chain);
+	return calloc(s->object_size, 1);
+}
 
-	return new;
+static inline void kmem_cache_free(struct kmem_cache *s, void *x)
+{
+	free(x);
 }
 
 /*
@@ -696,11 +758,6 @@ static inline void mpol_put(struct mempolicy *)
 {
 }
 
-static inline void vm_area_free(struct vm_area_struct *vma)
-{
-	free(vma);
-}
-
 static inline void lru_add_drain(void)
 {
 }
@@ -1240,4 +1297,32 @@ static inline int mapping_map_writable(struct address_space *mapping)
 	return 0;
 }
 
+static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
+{
+	(void)vma;
+	(void)reset_refcnt;
+}
+
+static inline void vma_numab_state_init(struct vm_area_struct *vma)
+{
+	(void)vma;
+}
+
+static inline void vma_numab_state_free(struct vm_area_struct *vma)
+{
+	(void)vma;
+}
+
+static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
+				     struct vm_area_struct *new_vma)
+{
+	(void)orig_vma;
+	(void)new_vma;
+}
+
+static inline void free_anon_vma_name(struct vm_area_struct *vma)
+{
+	(void)vma;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


