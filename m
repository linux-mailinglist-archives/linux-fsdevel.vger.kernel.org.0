Return-Path: <linux-fsdevel+bounces-75611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J7gD2XMeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:32:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02595BEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C335A300E5F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6644A35B63F;
	Tue, 27 Jan 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bFR+sqQ/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aWxGQk0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C029E114;
	Tue, 27 Jan 2026 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524167; cv=fail; b=t/noQbtR7/ylPD5f5GtntRG5E9tLaQPJoQ8LUn+v5jb0cchsIgkoygMtbyNxReHfqyPZDi2VvpY31PPvdRaWzltczlaABAMyqLRMCm4loC6cUwhT9xtfyGQ+45XyXZ/r1HfvWfYL86Z2QUj94c3493gnooz88cqSWZD9H0608hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524167; c=relaxed/simple;
	bh=gQaeX2oP5VlYSBC8cbD8ng3cKsZMlD3irb8eNlQs4G0=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=HyemUGLwgxzwMxIs87M2atMSgsOb7JY9ZPaE5uZp9GKbE3F7vREQpFOl2DW85VfYxEBOfsWC0/sBKCfYgP2toW0bAYi2u0dq1iqjxWpNsxv3nP3c1MF+9Q/4PEDs0FM6gqYG5pCnp5bECD6q2/cK+7fE/Q7uKIKDMJ5ap5WT0iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bFR+sqQ/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aWxGQk0M; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RD8uqW4016066;
	Tue, 27 Jan 2026 14:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TGszpbEDbeyA2tUwSj
	DgAY/xPb/yKOTOvC61Y8ROdTY=; b=bFR+sqQ/jkfcJifafLvnlZEnQm0yEKnqXx
	JlPoyy18HjBcevhp6FnvNk4agRdAdNJhmXiv2FCt9W5yXDZIQ6R0ifG9OFDbXZ9i
	Xi0qYQcORblEwlxFSn5aoy1i8Qm+ktN1kMftd5G+GoogxvGve/hK8igRx/72SBod
	XPJIhzh4BMbo7lJcnBJ4FX7P//yAIEbBlhgkegV5ojgdmc1VArclLWaD0Cz+L/wS
	P1flrTsTPCLCHkrHBA7nyTqNfKUCI7cdyYExfppQim04fI5BTpxcCQfNABrVCdfS
	p+LdL0DLq9HOH7SXRlGsmTKliC0L3UT8rTNZEMBNiGopD/NM4Ttg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bxx09g4aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:29:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDVEKC033320;
	Tue, 27 Jan 2026 14:29:13 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9ffrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:29:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEoZSaWrBJyahhyyx/j0dWiB+dY8YfcuW1j5W7tS89CzAyePEQKB8fnS/8qQ2b5lKUoJ0WwlQBWnrFvSHqQfaoruOzxPwJeUrmlh1tzpvC+lWZkwJSoH2ursEYkBAPQRmwd6fsXs1mWw+kB2YVUVi73S9PE5Mn+EcUmQmTySr7PvYgiWEx35zV4aRssu+GTssEz1Jhkz9pxjN64f/dtu/PBHCVjK6+MsRF/OEvtexbCxj/zReMvkNI2Uu3pRiIUw8fBjRKGgzweSYyIdDqF7njVKoj8b/3fckJXJ14hj3EVtvYs7rNsGFmoksObkvjvw2s23v5dedRcz6z7GQ3czQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGszpbEDbeyA2tUwSjDgAY/xPb/yKOTOvC61Y8ROdTY=;
 b=BvN1qYSUb5Bo7Y2tlwYXCu2M+1qZQ58ielKFq9+odSPS7yK2yuN6NHcWl6zfVX7Ll++WdprKIHwjQ/wwgxufHdtEeeh+SRJBGkT5N0PkbDnk/1tX78tckxKsWFXqrSLKVydT2JowpkimsNlExWCes34LlJK5UaCPmyX934IVUdD1PKQE7GKmextTNWEBFPVSLBEVCpoROUuyajMEUkECyQprdwZn6arv35+iMceTBrmaFKugr1I5QiIILUyVZfKau1u60qkvxgb1N7YyK2IJfpRc4xhHpeicUGbi5fXA/pUbZEKGGO/J3tXxbDK+hXD3emCR2xN+/qcGHAnDaSBNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGszpbEDbeyA2tUwSjDgAY/xPb/yKOTOvC61Y8ROdTY=;
 b=aWxGQk0MfzgeAN2bBxtNXbmlyS6xtFhTKChl6rZyrRm6vqbLren2Zvokbhjm5YlLaQ+I7tCIgKfAnqEHaYrIeH8i1EfhAnTqSflfEKFpuxIcnveUu7Dw3Somh6BBwoPapc8on9SnrsBw/WuGPdKvCgJdtUbdguxr9wlWkuR50JM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS4PR10MB997670.namprd10.prod.outlook.com (2603:10b6:8:31f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 14:29:07 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:29:07 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anuj Gupta
 <anuj20.g@samsung.com>
Subject: Re: [PATCH 06/15] block: add helpers to bounce buffer an iov_iter
 into bios
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260126055406.1421026-7-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 26 Jan 2026 06:53:37 +0100")
Organization: Oracle Corporation
Message-ID: <yq1h5s7t9i1.fsf@ca-mkp.ca.oracle.com>
References: <20260126055406.1421026-1-hch@lst.de>
	<20260126055406.1421026-7-hch@lst.de>
Date: Tue, 27 Jan 2026 09:29:05 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::24) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS4PR10MB997670:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c405381-3e5b-4228-4977-08de5db06db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KrdCiRf2Os+mdGO9UIGFH0upib6RBY3FcfBuvp7oi9+brpwmRdzW2Wzkwo3y?=
 =?us-ascii?Q?avw0dv/Flj61Bk4ZDbE/6qt9a7Oxz3MJLwoLadqPDomhbJ3Xitsv2CqZ/Yzw?=
 =?us-ascii?Q?ve7tIf6z+V9qlJyPQhCtmmCbutnONtrR1qCc9VWryeMbgKTsfJyyyI2w3QkR?=
 =?us-ascii?Q?lvBKltTESRPvBximDZflPxUdO2J5Y5OBrD/yaPB/C8LuREMVNo8hlU8hoVxC?=
 =?us-ascii?Q?8gPh1j7zvLy/+Ctn7qZjN7iPYd1LwqQH0/qNfS509HS2dsA1ugVNC53LfQzb?=
 =?us-ascii?Q?golSuwmw4Naxui9ASu0fBn0mAOa/iNVCQyqA3naepT0LfKg885rpoYcfMK2Z?=
 =?us-ascii?Q?8j1bqjgeDULr/Vc84rofDuXP6P8Sd0D+x1stY+iTYa3PRSAErXagzcvdxcBG?=
 =?us-ascii?Q?UusV0ZVxVF/uamAR0ETILJ7gJJ5Sc45ZFgh4xTyB6PkxkF/qZLwoJN0Szzhh?=
 =?us-ascii?Q?edDf6S4ACV9RS3C5sQTd6vye2ZDkJxl57vfmYjst3YUW//njeeMLKigO0EZL?=
 =?us-ascii?Q?HElasIX70E7Z1QWRPzsKe2q+O5wDJspAqe3Pqrsu63TXj7+Sw3tqRlxutANu?=
 =?us-ascii?Q?fjpX73rAmvSSDZnX98AmPAyuLONZNWHz6ILcnsNHdR+PeWWjyijoTqfHHJ6W?=
 =?us-ascii?Q?l4XZEwRYvF4aRY+3KCo4RZgSCWhAZdhzWf1jyooXmbZHtVjuEwKnnLRR1LKN?=
 =?us-ascii?Q?QnE9D+BzF5KB09syFKshZwk7ULLKV5MB4qSA/dr+h1EEjpXgvLYmQTbhE7jE?=
 =?us-ascii?Q?LuYszq7MB2HAlT+E2oLPkaTeL1oJPp1AyWOHLd+1HX+ZEd9JEE4dQjjArQCN?=
 =?us-ascii?Q?8z7nAJwWHwBBAvEoSFbtmEwvFFau0zvXJo7aFBtSheekpGdiSY7BUmyMv2nN?=
 =?us-ascii?Q?+vqWoMioranLqs+RxTCFJ756E4Lcc8zR0+Bmf2ev0kBsxgcDThS5vQA74g8v?=
 =?us-ascii?Q?RPJWZOYk/n7MjB8/4s6s5BGkGq3K8YchpDKHJd2S88bUkdO6jw5zWEs7BoEB?=
 =?us-ascii?Q?sy/uyfuQdePaXHBkyDte/xtenxeEmaDPG8LYZs+Rl41Dcr4GiAt9pQ6CcSJm?=
 =?us-ascii?Q?SOrA+Tq+O8h9+En5Gnm+dLw3eSnu9zeeuT7T6bOw6JWpRUc+gq/FTfkYpYWo?=
 =?us-ascii?Q?xXeADAJ8LOpfaBSTuvWvAQEIx5bHwfYUZdpEPyxdcKzeARMRhHKNLPZItol8?=
 =?us-ascii?Q?hM91uk5BiRakoymsEf7d1F942/U1FcOIIWhFWx4H0cds+IENPT/Quek3i9RK?=
 =?us-ascii?Q?11PX//wrQYCwFUgJzcouskBXpPCW/XGXiNch07xRZCCOzRCH9uNoFYHMguev?=
 =?us-ascii?Q?pwVzveZ1/FL4BYhy52+DAbWyNT/pI+yXaq2qDBvOU6Qm2frUOzRpdCeWhJYl?=
 =?us-ascii?Q?z02jOD5plaxKgwKIJvvluC8SbVtK/DUW34xW1oxv3mG7EG7DvfX+9j9jm920?=
 =?us-ascii?Q?zEJBhRMl5cnBKW6bqNEi9FKz3bjqqdm5grfRaAKHUkPStAQCEmBLz3Md3g+9?=
 =?us-ascii?Q?ufGXhskXG9s5vJ3yzKKEmC/n2ousOqAlV6GfdvYpSar1iq01UWLWYXEy2O79?=
 =?us-ascii?Q?bj7/aRBAgZW3R6iAcbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UqTSSKf/7g5R2uUy5//A3ttZyEY4b/ws11in56UIsAv4YuuiFAAPxngyC2Fe?=
 =?us-ascii?Q?ZX7rV8pfW++XCdUwtgKX+TR5pKxkunkn4TXsLWxc6tYBinPdj3aPU5h0sToi?=
 =?us-ascii?Q?b0i3Ke453AoB1WA7df649Rg/HGVdUWfNzNG6QMijXrreQqfRQFDNeKlZra+x?=
 =?us-ascii?Q?6M4iaMIIzV1WK0IvG+ePeCNC+LfEodpSVPBG4+kNAegjLfxYGUU8fmY5tr4y?=
 =?us-ascii?Q?/JDy9gsvuOqqdhwBOa+Ng0sXqCP0ZS8YqGgrQ3nKJi2YZvRMMBlw2Uqwnadx?=
 =?us-ascii?Q?wYaTbAoDJpRmSsrNHE0KDAKa97zhypOGRnTcQkFAUR+Heu5IqwzHj3KEGnpk?=
 =?us-ascii?Q?iF0pRUUqF4T4xlqfCqwrOn3QHO6X86e17xpW85bXmRT9wN+lVHim9zDlt3Fm?=
 =?us-ascii?Q?+yDobe9ImC4kqmis01nzJmGeT1Kh/VwtSW7zyjFJa3NyveePlrxyA1bzx6E9?=
 =?us-ascii?Q?5oBRS1xwfl4updjqsRI1VKVvFYyr3Zyn/sSU4cMuKotJ8jt4s89uvh/sDLn7?=
 =?us-ascii?Q?sRwfDEnzgQhnVsfhzQR5Y72SBg/afdmgFWxtYVIlePWE+lp7uyLSpWMxqLgf?=
 =?us-ascii?Q?U3ecvujFz+n8juTUS+CMQovCxhrQ3SUzM8KxYAAoX2S0hqZfSKbkxJxS+KGq?=
 =?us-ascii?Q?YQFQYqjuzrzPKfTywbAOPDgmlsdwBAkB69TR+Oki67xg7aSuaRh2aCd10GI2?=
 =?us-ascii?Q?o+b4Kf0YLGESdcekFi+pR3MiWPsqMI9+uAeQkmFKxfksZ7ZXVT3VngszGVJz?=
 =?us-ascii?Q?VXkQb70GYQVxLk2pgW0q+uvVDW0tvK0yT2KJEdysuioeHF8VCDkeDZjn72/I?=
 =?us-ascii?Q?wye+QcFwS3AnOtKoRcBbdtYMMYKsL0r/9ISDVz6NyRmZQjOqIF2PXrN5ilfX?=
 =?us-ascii?Q?A4B39NOjnTlEgVmdLZh61gKFoGIQsZP+G1ZyVsfb4XmCiPfhpZS+s1fRKbef?=
 =?us-ascii?Q?Yt7QUc/Pmg8aZB1KDP189TyA5PSPx4me/cUiqBZ7p3YTFWFcdgvCGtUsXkzA?=
 =?us-ascii?Q?5MP3Ni04JuAFdRJjWcFPK7sfxwF/ENPtT70QNq4sLLntE4mtRli7+Wpq9EFY?=
 =?us-ascii?Q?o5YhBqoHmV/06jcpf43HFjquZcJ4aS92tOS/zDvIiBI3A+Jf+DGVx/4sLM+x?=
 =?us-ascii?Q?ePHLw7siwOJmDJuBhYRMl2YqDIbrwjWeFDUbtOOIMMaLrE4Xn2DoJKRK7sgJ?=
 =?us-ascii?Q?9/N+p5KK7G/lgBIAp85avtYgX7lDXpd1mT/Ez3hHh/zfP7i7Epd09Gv5rrrJ?=
 =?us-ascii?Q?FyCO7WL5Sf8hBGPwjbE2smyOsjhDXdfmRGdG+7m/vmI1UlmJtIFKtLAmrTSH?=
 =?us-ascii?Q?yeKX+OQb2ap+GdDTMpftd+TmBwx4XQirg1uEtmEyfrw73hgVvoNltbQAk5A3?=
 =?us-ascii?Q?DJcLLScIfU4iF/sxIzc82G+7jZKcePTh7eA9bg8yOdhZvB8z9fqaHXy2kAw2?=
 =?us-ascii?Q?3YuDQs4ZHdhlfV3qoXoOaWExoI7isfO4BrQKpRvy3ZjDywDDlLv/FGovVlXa?=
 =?us-ascii?Q?u7t2ku9fEorTpL07rG5ENAOzTL9EHcreJnowy9gtVfyO7g3lbt0l609U8Op9?=
 =?us-ascii?Q?lZg2Bc4WwK/wfoxKITgaIMpV1bKJRXczCpFUzTxpszMiel5AvLIKUVzb3rky?=
 =?us-ascii?Q?VRV2c/uPgemMYwOLC+1y9Nj5vnfzGwbp9FevrJOm5RyPKnBkw5K72p7zMi6v?=
 =?us-ascii?Q?KQmlOXSjzjSGn42fSQC2o19WY5mkCnKAQdZ1IREC8CrEz8fILG6wF/GmBdke?=
 =?us-ascii?Q?7c7ni0BMIkUnLw6ltYoP7Ofi30rHku4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n6PoxDoWCmPqAWP8oD6J5U1ek/efBIF1+cHaG3mUMZmweBMvWBorEools7XRTHKXBCMMhm2R0Cgqy+averujvU+HT1I8NpwqeiUxQRNU32dqa5hszcSwU8iPIIp1zpBR8HtjsY1yZ4z8Sq5xDtx3R8cS2wgUnxmqtkUeonJSqkFJOShSTyBLzuBQVTmN/A3iM2G2Ce3mhVyj4qTj6Jh4X5AuQVR3VOt3vTyZfiwqJ4c4le4c9xCevriUiQj/a4e0OWwnydIApbO1IH1EQAVEWRgB2m+AI51dJrpqCWgZScVQprHztGCaGycaouZ6PgleQrWwBfZW6rXf1I3BDefIsZ91bgVzUaS52bcllEWmhV0vGRQrWDZHWjUwgxa8SOE7Kv8leh4mt/BDyWzZJC4miqRwmGt4KF+Mak8FUBfMpBmk0oub2rkz5jvEd+GhQs70lSe40uxnnB2zzTa5sEgxNlY4f8byatafrxlquwj/MDTDgWuDKPo03TkGYub1Crb+eKj2E1Zg/aZUsSWuJNWssq9PwZ0Px7I/5j3z447VNjRrvjCcrwzZHqv2kwpu7RU27t5Fzd86CWv+bdufdrLot7DqzpZbs7Dr2dU4X+shz6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c405381-3e5b-4228-4977-08de5db06db1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:29:07.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+PHsEcRGcoaky4KL92JVXnad8MCXlwL73WNuDKCks3g6GeDNTx5DLvcTHnrTQVj9Qn/9f5dd0LKmGOB0UDA8sBGXWb7QFPmjpqMq/y5t+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=929
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270118
X-Proofpoint-ORIG-GUID: 7PgeuCfHW5wMo0ZT1UGhE7Qy3-U6WKiW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExOCBTYWx0ZWRfXw8JueAUZIAE2
 3Kt1AHv8Nn1Re61C54OlaCt64mew/5O0AdBmT1tzukIhF/MfQOJdBBxmPhOE76iqfxm3esrhNpF
 J+tBUne17nuuAPBhrwTYMDtkrK2+RnaVcRxPVq1sU2sPecnlEIpNw0g/anAoy1IUUgDUTUIjg3d
 icCivyyGuSuw5iRtHi3dQAG6R0Hf8rr16GCpa3xyZx+65X0dsfGm0VphI0hHbv6i58sTM72eFuY
 QfuS9YGiXH/rLHIpE7uDI4e96r/13UUHb+iXr8wvE9xRoyinur50qNEqFUsH66PowpPWcNLfbxR
 gXVsy4wrm4U4sf/pUd01V5JKmsyQ1mTOiby5QNzpjHNOlrZfmNnJAWVlSy26Ak/zAhFlvA919l0
 Xrfx/1iEUiIB9JFMCVfayQZU0kbjazCMX+wCP3EgQhOvwre3VC3dYTW8HT1ZG6kTzk7BEDgN1Je
 JJbsCCkcEVnZTSkHF9g==
X-Authority-Analysis: v=2.4 cv=Qe5rf8bv c=1 sm=1 tr=0 ts=6978cbba b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=tZYNIdBUlepU-uXKpZUA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 7PgeuCfHW5wMo0ZT1UGhE7Qy3-U6WKiW
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75611-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,ca-mkp.ca.oracle.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5F02595BEF
X-Rspamd-Action: no action


Christoph,

> Add helpers to implement bounce buffering of data into a bio to
> implement direct I/O for cases where direct user access is not
> possible because stable in-flight data is required. These are intended
> to be used as easily as bio_iov_iter_get_pages for the zero-copy path.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

