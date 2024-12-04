Return-Path: <linux-fsdevel+bounces-36429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3549E39D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65990B284F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25841B6CE4;
	Wed,  4 Dec 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h7GONBhC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="haAY2sYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340541ADFF1;
	Wed,  4 Dec 2024 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314137; cv=fail; b=t1eCTuW9xRqKBWIYjJhz8BXE78SDMhyZLrRWFjULJg6Fo7qMV/7KLkWgzmKLzSkdL09iT9ns4OoFDKOG/cTEMmqdat1GwXnB3z+JDTBsJ9F6uZNlbk+c00Qo3D9tkv4a9NwixAMCieYsEdQFYOAhuPQjb/wFMyX+Vl3frAHsje0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314137; c=relaxed/simple;
	bh=yGmJrWSHZylY6kr+X0gqtDdPqENTz4a7g+lYP1fW5IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RZc3UPeZLpmnOXs+m0WXvhLHHFhwi6utmz/BMrvx8oKBnolo5aoblkCCCiONTWJs+0xuWNsKNEVMNMiUOzFgN1/E0JQTLxd4Qo1VaTCp2xFFlZtXZB17LI7/QuDBVxr3GKJK58cvTGUVGHmy5r3hw6s4FKDnOvMXXhc1bc2KF60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h7GONBhC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=haAY2sYx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4Ag3XG001076;
	Wed, 4 Dec 2024 12:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=yGmJrWSHZylY6kr+X0
	gqtDdPqENTz4a7g+lYP1fW5IE=; b=h7GONBhCrKfXsA5o4/bvW2lGIX0yWhJv/v
	Z9qJy3o8UqgzeaSq0pgTgY0Zj+uRbroG+xf0YaGiZjYadBf+bSELYdGaifUU5Y6P
	f8vSzLtOeomEcpzzKkNUSggYg+/YbaTeXVhcMjklMiqOW7TIcsatkE0ZMPFBqlPU
	kRKEeJatU6p/l0y6SM61Oe/mdWws8m+RK5J+mnya5XoNd19lnZmMBPFFmpVo9FC1
	NPAOp+upsRThMoXuyv9KVEbzSeH0IsRPtmCoNE5qJaq//tnEybfjr3hvoNff6ErY
	A3ITOqQpHMJwvepNy4a0EwtaI9Qr9FEwiQG65sspbi8UP3hnro8A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbrdsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 12:08:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4Aoskf031179;
	Wed, 4 Dec 2024 12:08:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjdy777-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 12:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3SzA3FMvvS/ZoU1gMdlYUsFabDay2VOxzEmeSb67FFpQzUYaQ5qmhpfo5sEuul8DE9lDEayIKCkStEbpDYUnI2ZUrCfjhsCo/6yFt6lAg094nJPvJRd0v7YhCE1Hf/+i6pQoa7zQcv5D/aXINI4SpL6W/cnxjz9bwOxePA6fxNYEzuZCGYDeDQrWc+nIGECKU32r6BjgRdpDf0u0bxLJGYg3966K4x4GdFelYHvtgY/KLG3+nCG5ZrWmTQaXCyhnCzY4NvlafzK7mNOyvGxbbJYB4GVgwMduwW1wAcz9ZG4LyzEa5g+mXWY2+wzjf6VKr6ValjTCRbMEeb+Rql5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGmJrWSHZylY6kr+X0gqtDdPqENTz4a7g+lYP1fW5IE=;
 b=Vuuy1KOuUs8erf0jsdarZm41A8xnbmbILWfdyOQZsa00p73KjRfsI3uLLqepNMUNV5NzOf0oe//aB2/yHWLAho8LTnF0KEB5duQbZnWC2JKDZAzOOlmTJm8CkfBCWN2aVYZWcyUTcObX0tDrYmNefepVRkI7n87VOUAmgaktbF6KSnytTjxTrkhEpZgSUeytbufHPyTe5lY2Gbfs5wZkSukL44xu9hFc+NxUE4wkRyIEwUeL9/aCVV9IwNMKtzgOI+DWxTnqtLt6rlGt6uymfNqkm8C3MTbSZ1rtLkNVwvoV1DzXoLLJ4O39Ts6nl5SWXIOmJifwVRakjsgYFbXqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGmJrWSHZylY6kr+X0gqtDdPqENTz4a7g+lYP1fW5IE=;
 b=haAY2sYxDTybtJjUA+B63SWlD13o/WGwOno3GbVD0QQROZDCv/QzjNiqBCw3HjEM1gyzlLxoHKSF0AuwkI1TiLMoaSi85YSfv5Gnr61LSs/XpIqGDYsmXC4kNbh1ufNMI4Zr1GM5n5Z58nmLtaLBchdrw1DLSDZvowhDY8l5Dxo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5720.namprd10.prod.outlook.com (2603:10b6:a03:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 12:08:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 12:08:40 +0000
Date: Wed, 4 Dec 2024 12:08:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm/vma: move brk() internals to mm/vma.c
Message-ID: <2a717265-985f-45eb-9257-8b2857088ed4@lucifer.local>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
 <3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 03746066-fa41-423f-e1f1-08dd145c63c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OGxlQwRIX0zbUrNy7JhgsJXASXo6OpQcrky3fh1JomOYN8z5Bau4D/DlYrDS?=
 =?us-ascii?Q?dvFwogzNuHKuV4VAxam5glK/4P4VzUFYl23KUmiYZ0pBneKYAQBX17FuqT9M?=
 =?us-ascii?Q?Pnrdb2MS+2fYWYCmrZMuewXc132eOVitHKOh/XEvZ8ngWhUtuppDYULaLj+e?=
 =?us-ascii?Q?+rekyWOliHU3E71yft2+Yd+02A9ujwaZIQQaM6kdT+cnluyZBNg/3vNhR/ib?=
 =?us-ascii?Q?K05q9UZNpLLLEyzvGjxJhYyvd9HW9wU6E5Qq99wB/1oZHSr9bfBMTDYcXw74?=
 =?us-ascii?Q?6NrJpTjmlwQh9P/g1HqISYaop9I1hDFsJGPnGoMe0sHb2k+ntfmYViqLuY+c?=
 =?us-ascii?Q?B03qnExHD9nKj05Lpy+wDB0J6xoTFJmjFy2oq56EpwBMOeJk51TQsx50Isf+?=
 =?us-ascii?Q?fvfOYJwAl8zHkzXmO9z56Fcl2OY1zJ1s74JTRfql0fVQnwk771OLZOPaIijG?=
 =?us-ascii?Q?2UV9nB+Cq8vqxvuvSO01FB3Yck9cztH0AbEP4PDS9wQcJkKocS3FiOqEKxTx?=
 =?us-ascii?Q?QFFjVnxiZnCpJkjMECxUYxINWr2PzJWmEDoJ5tOwMmbnn/nRA5Ny2sXdVebM?=
 =?us-ascii?Q?LZDAVF1n3ageLRETEkkJWi205l7MNxRBaocRls5RvW3cRIT5br6aXJl+BsYZ?=
 =?us-ascii?Q?1kyZKcbEHZXbQx57T4y99mU/muJo+Jv0EU++1Yuue7Z+KN/KGclkjqHubxGG?=
 =?us-ascii?Q?/Lq2A3m2S8RVSbvbFEKf/9UasgFTL+W2webJKXjtH57cWRCfO/O+o9wzZRo2?=
 =?us-ascii?Q?B0k2KhSwjiU3TDD+3mPM809Myhpp0XcgAkvdkl49nHQd/pX9d2nCbUVQNe1G?=
 =?us-ascii?Q?lHW3oUW02sZRcYO7DOny+bTQ6B5jFoCNDkRdB1sfc+8/xD6Cbpo4QAEF8OSy?=
 =?us-ascii?Q?44Ip4ag+2AfsyAsN72SPJBQ3OeJVa1IEfdpF8rJ67mQC8R/7YovlTJHh8BPn?=
 =?us-ascii?Q?5s8tXtGysLb4vTOj6s0w03ljQpeYdR4P+Lcs2yCvKR4KgcFin39u2JYp7Lvz?=
 =?us-ascii?Q?5JdGbqMMimtmRKZM/H/v3jh7C8deMozwBeuvjrEZ6V5bWc97rp+jFkGYIy/9?=
 =?us-ascii?Q?1gfXYYRfezsVUi60f4+wul+smPQocdtm1fryacnE3cnb5+Q/qrkSoTxuE2HM?=
 =?us-ascii?Q?41fg+Ujnji/++4fWQqqgqgthlbwaS3TfqNHMD2WB9MgVKETrKsci6kl2kAw5?=
 =?us-ascii?Q?GGdJ1yZCV/c/Pcmrq4iaz00NYh4jwbfNO3wRhVjeOfXkI3+1za6uMI0jl2AD?=
 =?us-ascii?Q?K2A1gTbIKFHlNrIZgqInmK8NK090MW4uehMoZCG6dEYBsjG75nZ6ceCXEFSD?=
 =?us-ascii?Q?1eRcJa67ruV+A59CrT3DJ3xOKWeRUVa174vp1M93bN4Lzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GkeAMRZ+8+TYmujeUSmPYFMgE0wuTh47ayYUtc8nCkilQhF2W5xuBulm/wZ6?=
 =?us-ascii?Q?++tPfQdZqWyYtXbNpA4CWFlxQpcjpXFlBg9Qb9TnyZzFaiY+SqYAtrxMxe6w?=
 =?us-ascii?Q?unsN7Oi0Ynm9xFS6OdVCWclwzpXYWAvgsXSHlq6xS0zj+Q2ObJCP61t6lm+c?=
 =?us-ascii?Q?rWYg2TjJPbL8nEh0C5aSI+pvjHMn6f/eitEBSbnvHJmRiSx/Ol2M7DdR2SSE?=
 =?us-ascii?Q?rLOkfJU6nkcDUNPHiDXMkJkadbk3B9NOWBPmLFBMl/xtHhHO5oTFJvpeDRVV?=
 =?us-ascii?Q?lPyc0Q2fYLPZC5C98aFYR8PUCAt+OMpv0IP85Zn3mOOvG84QA/0G6JW4H3Z8?=
 =?us-ascii?Q?3vTBEYPAXhrEsRvxYijfTKTLJiQ6iEiE253PyFxrTWLb6/mYXUdV+oufLIyB?=
 =?us-ascii?Q?8y+gZhvBZs5jGeJO5pxmIDgZ0Fd3HD54wBB20Jxry/QnZcrQKKHNzL66Om5v?=
 =?us-ascii?Q?Zf6/PTEJRtOHQOiH+h5yDM0RNK2+4jiIy7GlAS9xO/dm61FQ2/qPzjL2v3b7?=
 =?us-ascii?Q?BmiVYVBH6ZMtxxpxg7KSmEx16/zISMd/IlXwuIUDvvQiXWM/iyC3SB3QoItm?=
 =?us-ascii?Q?Y86ZgAOJghnahlTEN3Na4u9Tt0uQB31Qd/n9BBlQ5vckHQa7wHYugPN9JSDF?=
 =?us-ascii?Q?gLt40O7IJ4e8T0lmLqxOmnfKKJtyKtVVhbYsKreXIXNTnL66UXFVBRg1PnY6?=
 =?us-ascii?Q?hooxdTWmBKT6axLfyjenxePe31qhpFu/UeGROp0LuaXCGpzDOI0hWCiwrh4+?=
 =?us-ascii?Q?nDOCHCJmczkv1HQJHO6f0bIDrpQ+Uk1AUQ4NvLF21ub9lZbzru4YZq/rIG24?=
 =?us-ascii?Q?EI9o/Mx1KBbwDVvS/ptUSCVQ9AZZs7EcS2O1wqR6ZcyPjvaQwMkW0p18EK44?=
 =?us-ascii?Q?oMzZoLvH7xjdcWKDqrxO7JtOtA+fz6BaGZfqsa+dZp2178YxHm7A/bmoCFFC?=
 =?us-ascii?Q?d2HuEvfu01DuuB05ymCPsH1cO8O5qWGeugjtW0BuCoeKdf1n9q1rMOM1bw2A?=
 =?us-ascii?Q?gMKtPEb0AZkxWe3qIBpWtk+H2Z6dl4BE/8dg9lwlZDBFOw4pbuNyLL0zMorq?=
 =?us-ascii?Q?n1BeZZhpIA1uVYfP5YkELVOCzBXr6D1s8rouf4IhXDDJ5JS/ZQ3A3H8rkx4w?=
 =?us-ascii?Q?GQ5JWKA3SGEvlyVhAqOB5neR50r8pU2R72zC3BYLRvPMInPr7d4ZNEfcdCKB?=
 =?us-ascii?Q?/zQrdtuUOsRtP6JMzy0v3i/U6SIfHNkuzamP2FPZIfqFBYkp0+F5nwf/dmFO?=
 =?us-ascii?Q?5K1TQz2ECBMWHEx6P7U1CJDGD1PFStp8g9SfpyZGRDnb3IBpBB9JS0TvTEbB?=
 =?us-ascii?Q?0Isx7k9qg44na03Nj+6+bxb/pKZGB1uJ+mhCkZbUoYDQ+r7FwZiRJBn2gJOl?=
 =?us-ascii?Q?WYCqbLGesw/cjdM5UwzPsN259FNyS+lM6MBUtMV8S0sdv84ZyN1GkNpvMemp?=
 =?us-ascii?Q?RzVJrr1upFGsFUcWwWz358lmTliQiHb5hNAS39tvPclFVfdJwTX6sWpTJLHB?=
 =?us-ascii?Q?VAYsIqZVAgnuFfTA4XWXNt0pckIDievQIAkGTg4nFo/YtkOiEZIm4eKe3mmF?=
 =?us-ascii?Q?JZ55NY+uEUxWR4Nf+fgH91dvKNYHm9gQOtWPAssjsb1RcwG1X2/O3hL13Kxd?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iaJ5BqikSXp8RJrtJG675Jy8lhYj6MlOfy6kBUZklM+1tclohxEkXr4gAarQMfbvp8zkptLtlWQcRz2ZsogEQct02tqMZc3fV5sVmOez2DF4GZU+MP/WAT5ADFhQSGfpfamrwnCOLEwMzqYX2NyDrd1bCxd6OKm4Weo3V2J5fJk3Yx84/D9z4U2+WfIbBT75sgD903jaOHLnZlr+ZJVR2fatJ2zKIq239uUz0GP+aXciJrHMwcSm24e4szjK1H/5O+FWl6QpdrMoJVEGtAm0ZgDnIb+2/sRybaGFsaWawNGLy4qSOjbYj1RDGt7fNjb+BxgjThZYeC43+TZYJ/afsDJAqmesVgKkabybgnjFGD7mo5emR/H4oQCXj923ZEnlIW8QGkCbA8vivVIR/OnDIkDSd3JmzndX177D9tYAV3bsAe8wCK6//2GJNQdoPgXYl/ZGmAfYJxRopD1OHgzS9yhvF04X2w4YuQsz77dz8y4GO85b87TDCcvqlyNe9Xu+D5UEV+Lh9fJBSjspap4WeAnmckiS3WZeY7CzBL4x9GiodInkAhswq+ogYvUv2YhWTOv8FixY7mYtw62v5eE7OI2KOZrkecFh7obiQ4D0Jak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03746066-fa41-423f-e1f1-08dd145c63c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 12:08:40.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oJ/1f4zh5zlt+9efwhHSquSi0Iz2RBlOtg8oXJYu1QeReNtlkIaB5uQAFEbomwP/rQrzfb8rb4TQ/q8fXCiFx8rMbB5OLfN6pznZhVu+To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_09,2024-12-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412040095
X-Proofpoint-GUID: OyCfIjCp2co8KvJMdj9YQBTSOyaOsYcL
X-Proofpoint-ORIG-GUID: OyCfIjCp2co8KvJMdj9YQBTSOyaOsYcL

On Tue, Dec 03, 2024 at 06:05:08PM +0000, Lorenzo Stoakes wrote:
> Now we have moved mmap_region() internals to mm/vma.c, making it available
> to userland testing, it makes sense to do the same with brk().
>
> This continues the pattern of VMA heavy lifting being done in mm/vma.c in
> an environment where it can be subject to straightforward unit and
> regression testing, with other VMA-adjacent files becoming wrappers around
> this functionality.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Hi Andrew,

Could you apply the below fix-patch? It seems we have another one of those
thorny header dependency things going on here.

Thanks,

Lorenzo

----8<----
From 0c61e8fe9f9ffe9fd7ac8e1fde6e8cad8bac2b30 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 4 Dec 2024 12:00:35 +0000
Subject: [PATCH] mm/vma: add missing personality header import

Some architectures have different header dependency chains, we incorrectly
failed to important linux/personality.h which broke MIPS. Fix this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma_internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index fc5f172a36bd..2f05735ff190 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -35,6 +35,7 @@
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/perf_event.h>
+#include <linux/personality.h>
 #include <linux/pfn.h>
 #include <linux/rcupdate.h>
 #include <linux/rmap.h>
--
2.47.1

