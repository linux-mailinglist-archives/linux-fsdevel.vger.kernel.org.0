Return-Path: <linux-fsdevel+bounces-47709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D4DAA46DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 11:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB40E188AA69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 09:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA2A220689;
	Wed, 30 Apr 2025 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FN5ugScX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OYhOe9Kx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BFA2B9A8;
	Wed, 30 Apr 2025 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004854; cv=fail; b=JKYJpywwHpzpKXnA5Wn8MJhwTcqpR6FX4PWNX03p8Givpxs64AND+1vnPYSCZyFR3L+M76ukqHaUtp7S83AyalzaqYgbMYY28rXeUeW9J+tj6EuE2FShsubTcLFHmh10wmzpeOzK1AhONS3dGe8H5IeiLaaYwbbgkCeHnipiHgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004854; c=relaxed/simple;
	bh=CA9bYkoiMHMV346gNfs1z/b1X1M0zxWKi7Q4h+xJdag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=srxtg4shx2PJEaMlWSfWJc0zuGuFn3YvMZVoAhsBMqEFHjDnXFyVcCad6xsMi70Tl9UIJgKetqePszhZbXKcgHR8eKE5WBDbILv4lqxc+0y/UuwPvrAKOkzlbPxujcar1c7CG9kB4DxJsT5CtDhcwGtdu7T/axhfSZNlWKc8yoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FN5ugScX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OYhOe9Kx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53U6QoHB015983;
	Wed, 30 Apr 2025 09:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=CA9bYkoiMHMV346gNf
	s1z/b1X1M0zxWKi7Q4h+xJdag=; b=FN5ugScXs2rqsMZ+u+BLDprH8mCs3kF9Dd
	Qj536t7/Op75Df9ffA+t8ySCmp9Ly70iGtqsX7CtAZREb6ErfFa1vInE9wTD6XdX
	/oc5ZDWIZALOKnkztTUpZ2fkEOHNyGESIMUVnkHyekCZOSEZU3dnlj2H0yQ6fiye
	8P7AJA/Y19YcgdAMmqS3mTlkt+A4M2kKscRSjD7w/TK+PRImFXYXyUpUur2prXWa
	kdIT4rZzXaeJ0ZvNOy+FbVttTDbbCaTjygOA9dUPU3PwFF71W8lJ3+13ireb2aHN
	Bu4lRKo3IVc4D4k12hIzeUd6brwIRxtV3sjraFibO9o2enRrtenA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ucgsam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 09:20:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53U8fJ2M014048;
	Wed, 30 Apr 2025 09:20:25 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxb2txk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 09:20:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV8a43gvAtIfcqkDSDfZZwzKy2oqh9lWr4V4wrMQRXRzzgOYslXwZC+cgGuTqqeoa/VH/OKLM3a8xaA6AMEjIvWibkM1Cd2QN+/Z0pMLajxlKuNYt4pRUz0dgAXM2szWBFOAPANLZ3DWVID8R02uLwCqGTE5y+VNvkDqWUeb6k57if2d1XDMaPJAxQWDKrKej70foC2fLkRs75bepvL6w7XENRZqunkxf0K15hasxSw0d+Ea6EQEOogvFX08k1ZCgQQPEoMuvHUf1Vxh8YSycep4KCOyCleZI00GE/jJV8YwRNJprtzVXzhcpAKRy9KiIZfXA61usxB8YMtQlMIF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA9bYkoiMHMV346gNfs1z/b1X1M0zxWKi7Q4h+xJdag=;
 b=VoG2dFtvBeZ6UV52sM3EG2uFsSfnkF00UOAnu8af2zO9mc+zvG4Cm0F3wqBuXQwLVB9u4GD9DFdAOOvddDQgF5UbuSoKrjgHzDkqJ/P5dz6WFXDWWH5dqddBN2nfS0Tz6SzUHhEXG9EavIbik8pMCuErfq+XlaFbWHsZP1akXDb2Z00HQxi9I8owM5gnqmk04lxQCu0m8/dbs5CUNk+8Giqst+AfK67EeeIeXuRYFE0Wgb+nq2+225SnNB0DNjM9ZigDJfWhew8OvdHod3ETqqnkxZHrwQP3MDfIE6VLdUVweqDWXtwfXfA1rimwzUqYvJ7Z3LVvxQHG9VrXvbKftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA9bYkoiMHMV346gNfs1z/b1X1M0zxWKi7Q4h+xJdag=;
 b=OYhOe9KxZOa3fdPVlZofCwUelZ7fZiB8qlnRsJhokRAPgsPcUcPVqktPXzikQGyDf1mXSDrGMoTZIX4yYWgd6ln6PlETkBq5deLExDFZD/ZobSuSD0lfCe5ulSrmbWuiFtvynpapLzaHFyOG7zOF1311PQnSBPN6AtNOFzYFpuk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4189.namprd10.prod.outlook.com (2603:10b6:208:1de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 09:20:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 09:20:16 +0000
Date: Wed, 30 Apr 2025 10:20:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
Message-ID: <5edc96cf-4f48-447f-b5a3-7e38679fa3f0@lucifer.local>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
 <c1acc2a7-5950-4c56-8429-6dc1c918e367@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1acc2a7-5950-4c56-8429-6dc1c918e367@suse.cz>
X-ClientProxiedBy: LO2P265CA0494.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f101f6-12e5-4a6a-72cf-08dd87c83866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JywqiTF8yNk7ciqEv9lWlx1I6FRY2Owj+ygHPGs0VVElEQ87o0XfutRnRqd1?=
 =?us-ascii?Q?2Rss8Ufsrz3X8DJHK388NbN30438t1iOcUdHOi96BuoGwDptW1i7XEllJ78z?=
 =?us-ascii?Q?0qJyDxWRjD1av/z87rU+44bYRAa93Nu8tuC3mPEUd5urY9+K2kNjvrS3F4QV?=
 =?us-ascii?Q?JTZN/VrBLdKLU7Rh2dc3wXPV8c76pZu7DzN1BziWysdz4iJ0zl3+rT9nJNoy?=
 =?us-ascii?Q?CWjFWDD5aWSIJ6AjnzRldFP2Ze6WbZmzGkwjyxOXsW87C7NnW6dlqjNyMaeP?=
 =?us-ascii?Q?Ly5cylPAlhE2Ch5gEq4V5RID0ORHbeKYTpkQiEylU03j8t/q1WUAUKsF79eT?=
 =?us-ascii?Q?oQm7r6dsLY30ph/HIaoZNyjJ5PCK4EMRIPdN4E8LrpmqxRwwhHp+vsd5JQvh?=
 =?us-ascii?Q?SaVkPvD7D4Tm9HyeDH2djbND20orrjCMx18Kf1tyX1n0i+R/nk2Va976A42M?=
 =?us-ascii?Q?KrqZdxcAmqrTMJ6LPZhxg+Cd1OJGn1Bh5zCwe3Wnw8gGgdRvCjxzLAm01uoZ?=
 =?us-ascii?Q?G+yDZnu+Rm665TQmMSCfEQDDlRX0Vlx8gvuAFoG4G97HKDNmmr/cgUTKQvAV?=
 =?us-ascii?Q?Ipr1elF063D0U/PicPC3yrMjzhkyd981WjWCaCdZeIvgpOD914tpVsZveWuy?=
 =?us-ascii?Q?1X035BumdcJrGPOx1kJdSbxDDyKPrVLpGUusIeZKMqRKeCw9hWrnB0P74+X8?=
 =?us-ascii?Q?/gpl67Fu/ubDBbU3QsOMsTZOrkg49DHG/iTObe6PDz4svSJ2Hg8IH1o1yfdB?=
 =?us-ascii?Q?GsAZNiEqBOl+i7lt78H9DYMbhM0dTale4Dz991sbiQ3avskiCgOi8ewHjV85?=
 =?us-ascii?Q?j7g0lvD+Uq3T8yrIoBJpNXWPP37YE/1Rn2h8iEEAWRcTQJug5N0kHToRantl?=
 =?us-ascii?Q?bxBQyxsgAbc53GFw2b7CLwLa2L1LMN0Qk/X62vIW0b9KckSkiHwFSr/6uj2h?=
 =?us-ascii?Q?FXcwGoF+QsHgXXEO2rhD8xL915KB/b4br4D6DFDfNNI5eHqqy54b0tnByMyd?=
 =?us-ascii?Q?RHQYeCAf6ucNLLZCbxbCPOzgjGAnpWtHMKssOztCLd21UX0MsCaDBsz6Kv2Y?=
 =?us-ascii?Q?hZfhCaYCfxihqDJkbcyCSH+ZUmYxmpbeccM4zzpKJSHj9nyAIR/NSMG2cwRX?=
 =?us-ascii?Q?OOESPivv/gUwQCqQuAka96ViUs1HGqAWxpclvmrlYR9esuVOvUDzUs3/xwEc?=
 =?us-ascii?Q?3uHBK4gRdSqqJLx4nRHxeZYxVzf/onQekCPnV9FVNEQzrrIKDhY7hOVtHtGP?=
 =?us-ascii?Q?zJMYWK8BrE1jiS58rmesyMpyNukkoolVgf9NDTBzh/fVtCG888M7AiSOszHz?=
 =?us-ascii?Q?5hwh2p0inGGGkYPJUaW11yzPwH4pfGX8kxod3Z2ukIReLl//M4wXMSzHvDXi?=
 =?us-ascii?Q?zmfu7594cfdu21lJjH+hIMkYR0O+9dstHwXaFLg8RR8BXADc+0ngf2pgYoRS?=
 =?us-ascii?Q?h/kqUY6zMOo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6bDKJCGvXv1e1Yxgkafwxuk7ZV0M3EOdSyaT1znkKdKliPz8dnx1GLPaAqf8?=
 =?us-ascii?Q?MgIhp7c6cMP7mO4DIEfv8WnIirFNgq+oe+h+qZXrNOh2+ARpHV6D/1SuDysB?=
 =?us-ascii?Q?6gM2i+3b7fQLdSA8TihpG1I3dEKBUB/oyL/xZZ7PXaWymSV6adhFuta/ey/x?=
 =?us-ascii?Q?Yp7JmPIBTXNRbvHBQ3mwruL91JYOsfWCmqNoSSjVf/Y1Xii8Ayzgi/FOccng?=
 =?us-ascii?Q?VLMZXia+IdIHQi419+kzdzoeZIqBYPdt+9kLYAmH5kPdBGxvvUYlyAcFNA57?=
 =?us-ascii?Q?yrl4x+ZE/M9Q8LijmkWyEYOPZ3qnCNiuXGTF6rLpUCa/8OAK5nZXi2m+4j9G?=
 =?us-ascii?Q?AGSMIOKGfPcNMWC1NOcvurhrn+SLS/Dqu8EI6KTe9qo5idsPXpwRBcl2DKpE?=
 =?us-ascii?Q?k771nD7F9j+zOjnh9j3IjRr7vtJdRTv3Ctu+UN5ulK4+5A9DvFyzKrKXapUP?=
 =?us-ascii?Q?utVIewdMZ00wK44QjRGv1S2wW8AVpZZCeMonaNGvAubKqHXphENvQz8os0hL?=
 =?us-ascii?Q?G5S6WCKH1GalYVt9W8PMz5IRLlBwgYScS5g3hJGHHeExGleTLeWkQdJn8my9?=
 =?us-ascii?Q?M8ywqYKkuPWs8k54n8WQmJv0TdvbFArZcAGBfQPEXMK/kTnjRi4kUqRNRrvz?=
 =?us-ascii?Q?H+m3rbUZiN4pOToKu3utaxuQPj1P2pDwkIjXIbLlHEoKaf3AOaTTRYAp9BJF?=
 =?us-ascii?Q?xR7wDC+dFGZLDht9zdbRbmN4tzUoED8fieQ65Gk0qJVKnnAHgnjqlL663vxC?=
 =?us-ascii?Q?l+jePv1DRlZbCHhXils99pxdWzFtK15W9exXLNNeV6IJI4KibyzIp2DLMxNF?=
 =?us-ascii?Q?2XnlKoVTulKnszRdFTBUP3sxQHbzVAC300moePiPziMCm80aL6eub99Wmc4t?=
 =?us-ascii?Q?LZe2rCEuw2A/qGMQ8v0TTWY7pDjU70RiAWmZw5nATND/CwnqoQmy86h2oOss?=
 =?us-ascii?Q?reyIFSdBw4U1SBt1DWarI9NjfqKXqsVreOScKpUg60p0jvSXVjwUlwdP5YIi?=
 =?us-ascii?Q?/18g02u4U4tjwKaUmQHg9ggkilhD7kE1ffXA2ux9aKSMMg4bOAVMw54EIL3U?=
 =?us-ascii?Q?8czq77m8FVwuV6fXC2usAfg42496FecDpXvhy9WGnX8fHJH0V4TnmxcdLDP7?=
 =?us-ascii?Q?yrue+pBXHH72OKcHBbMCo9t3BuO/DWsrW0vRCPVdM1m5obP/NYuF59zzZg1R?=
 =?us-ascii?Q?9feoWJyQs03JYkaqT4NWb1jd+QdsBTvPeC5Xy2KyBdW6fvy8fUGeQo4/UZSg?=
 =?us-ascii?Q?Ah3Y2L0FgCNmnOPnRUOhxAXPol5yFHWuUuM0wOQfRhcLaxEaOcbb8hUPaLDX?=
 =?us-ascii?Q?okha2G8Ci78Swj/b2XzKrhknIekiFoKgwLMHBEuvUMLAQIy4ree6FN7zd1Sa?=
 =?us-ascii?Q?Tl3MucwhTNZ7/UaRTRhjhb63E2WQsUQLDg2XJVpfRjRNIzyDv26khyOYCPF4?=
 =?us-ascii?Q?eEmF1B9RCe0GEqI4RssdFRqf3G9sMaUezt4HBj3azi6IAtga4zbRZAaj13Sb?=
 =?us-ascii?Q?6bK0eRqcWuzukILwcEz3+7r2fIni0NgyB/ej2RhdOZkmjIa9F2coKIRNbd2c?=
 =?us-ascii?Q?TVWZg8kDeWXw4zQy6dWi9jUi2U6nDaD9ObMmTN+rwA/IGmD8j86IlgJHUzUm?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dEIimBqzma3Dh1uwfV9ta1DfbSTUfqRxEVYnayBC18FaLz3ub05te7/NHBXExbJO+j7Ovvi1XwkBNd9t7MLe3Bd5p0gYvHA8WuMtJHuqWoMWDMW4oVFx6oYab+adRGlx4if04yr5JqFgGT/25AUiUxjRPo6n9M5n34fBcK6hFqD4C7FyccJoVrjRmRNKM9JnTW14bndF90CPTtNVlsAmMbb9vFOicigUHE+/yQfcm5XEU67/ugwEDooVkhr9zbhR8SeKQC411F4fO4tsuXe9nuEE8i+7qM3wvCmii9CX3AB9+y0q3rR4wZdu3Ao6Up8TMV8euSkp+oCB7QtDQtZYj2lIUFLs0xxsVo4NoSjp9qyuHxBjt3X8HqvA8X5080JwwuOfQgtBi/75wMLoe5Vm/7/KZEEkD26kmSMIx8aHDXbM6S0olt/VvIvnDYVEMQ4qBO1ZI5DW5zBJgtdOSuarsFmkFUw7mNGtD/fgDsBmR1inHYPAJzbvqGC4JgnO6JZqBai1e+ajD7FA64XpN4PVgy3UhCJqARkbn2ReaQrPo/G+RUcSkR6vu1WXln8pl9a03wrBX5tZZ4J7kkH3TpxToCNjcg+08TnH4bB4RxxC1bk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f101f6-12e5-4a6a-72cf-08dd87c83866
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 09:20:16.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPJJA2esQPZnWXTeTZUAIYd6sCyVbyPO2vFMKCuEdH2vqOHyrrA0GOGehUu9z6hz5Sl7ulAc2k3kcfqXLksFky/ad260pJp3LFgzsysgnyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300065
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=6811eb5a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=ytXJE8WU2rHRTY2HBGMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 9Fdj2IUa1CGnM0IcVDFEPxfFGIMwx1mi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA2NSBTYWx0ZWRfX7Cn94TvKqlqh 7KnWg5Yluw4VkiAlffHQ5ki62Sx8tC2j5GSjZJecwiYcj4SmcxSYJUneQ3SxbFiwk0eNmGrHrzH nqo7OYyKrMyUYV/9jaAxQfmx04fAOB6IqGyrV4612K84VDOqSV9ozy2bpIyt46wwKQ2fqLkRYXz
 TrebkSTjl9jWJMz3LWYGqi8D0vxv3RqNOkoyezd9dEh8vupsx+pry/s1vvb8pNW1rGbldpz3+oL micfqHdQgMVGzdtIkZbADCYW3BrUlpdnolMWN0vtVD5ypbl4gADrW24pL2K5lth2gyBKbgIRdeO D9+4ul5N0lTlOyVmYSYs+9kOI9qFzmTrMzvnEpiPkRq0gmJrue/3c0nlU9OUiJ5moNbM5culZKi
 t5cc216R9biAGPNH6bJ5a25egto7SsSUhSJvfGXV8XPuylc+k+OzsNNGB9UQB3acIxq3rYwT
X-Proofpoint-GUID: 9Fdj2IUa1CGnM0IcVDFEPxfFGIMwx1mi

On Tue, Apr 29, 2025 at 09:22:59AM +0200, Vlastimil Babka wrote:
> On 4/28/25 17:28, Lorenzo Stoakes wrote:
> > Right now these are performed in kernel/fork.c which is odd and a violation
> > of separation of concerns, as well as preventing us from integrating this
> > and related logic into userland VMA testing going forward, and perhaps more
> > importantly - enabling us to, in a subsequent commit, make VMA
> > allocation/freeing a purely internal mm operation.
>
> I wonder if the last part is from an earlier version and now obsolete
> because there's not subsequent commit in this series and the placement of
> alloc/freeing in vma_init.c seems making those purely internal mm operations
> already? Or do you mean some further plans?
>

Sorry, missed this!

Andrew - could we delete the last part of this sentence so it reads:

Right now these are performed in kernel/fork.c which is odd and a violation
of separation of concerns, as well as preventing us from integrating this
and related logic into userland VMA testing going forward.

Thanks!

