Return-Path: <linux-fsdevel+bounces-49850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97437AC4179
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2964A188B4EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D6210198;
	Mon, 26 May 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NTxulDic";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FtkUYs4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B261EF36C;
	Mon, 26 May 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269931; cv=fail; b=k4BYUO0Fr8SRHghm08u5qodoYGOYbZacs5Rx57Biya0ExSX3bCZDBa9jxyewY7UBnV2LzxPzh6hf4fC66dfZ00bSqOnhyVu0xnl2a0hbeQsUs7nB7zq9JGvppB7eLyPvTIteQ3YUf6DGGuiLl/mIjw847bO7O5x1QSewiEzwjYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269931; c=relaxed/simple;
	bh=5R7eO0auG4HC8jmNIa+tOhLe9gYygEo8H9RCsZSuDzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o5d0T0keNwyx5OnTViurizR4C6ehO1516XIiBDk1gLs7mXW6U21QY27rhU5FlD943iQxD91QhqMMvtcKbpGcaM8pXtoF5+aK/aGW92rninfKhNFFAsQsqi8LSgwjh1aoigMxgsOY0oCZcxLZTGJIQYZpnbYiJD0JAqii/SL/K+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NTxulDic; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FtkUYs4o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q8tv7N000348;
	Mon, 26 May 2025 14:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tnWjVMyh06SM5aPf4q
	aqkVkxKmTcRQUEPp1Txu0PvkY=; b=NTxulDicmgA2XUrq+I0Na1DrvLcmxt+pfP
	ACzCmdphuxzR5kXYDtGBCqiLiIbJgeB4G3R2xxa+feJJa7FNzM/3TocXCOSQu1jx
	Z9YCTwko06XMq/hiWzXYxBo7lx4B15KU03FJcOpDmKVVTJ5/ZGquz77hfY4UWeTl
	eQsMrzAZONQfVrix8ua6io8vsaMQ314AKJ/YHHZIaWNZELpqLIdQdX94YL9Hy/qO
	3PcnsN81Ew12qTOVHfZAFU44rCLcy8vgYimc9p8nrQwPcgDUKIXq39rRq8w29Onm
	pIVXjO9ahZk4klhK7xxEYBM6YS5VoLOHgvV1OQdH3rKWZ8aI5pDw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g29k8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:31:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54QDkBdB023179;
	Mon, 26 May 2025 14:31:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j7uu00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6LTKqI/tOi4pt2Rs+ga97uK/GX0gK0e2dH61ykfddLD/HBOkgEZ5NlZT/zMKb4G0OH9AtZcIO6T7smVDbfwQ5sXvk6hAhkfxwpQyvSPfVok2UjP4sY2HwGQLZ+peS9RFa/S2t6SJ3de9HW2BsAMwM+aK2TvT8KJOkxIjmkU1urllFFiEAVmeIijDTUSRVHGAOTx6JSpZ2zBewkkPvoHN43ydOv5t7QPxnhnAKmZA/WGbS51rOVEfC0TH/owK8zRmPFllL6W1yZddghYhydNL03KZAWatfEQU7NkhdADsrXKxSjRv9nO96bOjsk6BqEvn89E2e+oa7IsPejStWxaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnWjVMyh06SM5aPf4qaqkVkxKmTcRQUEPp1Txu0PvkY=;
 b=bPQ3dGZgKkq8DO5UfMEI7Tu0e7AirbVXD2aq506822Y9v5yGC6TGn1Rzm8aO/77AHEyBlX1lb4fTRUB/9pNS45DlAJrO4buXK2pZIblbqplqGfgO+pgaRTtzOyd6VYL1+SodArnAtwVHcEFeFfAeHW20u3StIlYr3KY24T7gGtauE3k5d5PSxiCMfgNMJHBEAY0sbz1wOqOJCN08EJRwCNh9Heq1lGBt7xD7iwkFNMLcqLuU/ihFe7LM6Q5MBwe1ainqDxEC/5tB87lz32TjTjDmbqWvNKcIGa3ZWgG9QMhC8j6R69b7NeiN/2vjl94ZVUP9m+4fAXo3snlkXvKw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnWjVMyh06SM5aPf4qaqkVkxKmTcRQUEPp1Txu0PvkY=;
 b=FtkUYs4oLQ77phrO9JD2tPlqR3S/8AsyxrBnnvREDWNAMEcF2LP9VHgJnDeM5YRqyPErR2cJINP0susWCG4QORbTGhgAM16lxuEW1jdpAP1cW8thUxhPbLg/5lL4zZoMPcnC9EzG7zu1aLcXLz2g7CCk3uGZ1bPqrbhQU7tCvuI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB4985.namprd10.prod.outlook.com (2603:10b6:610:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Mon, 26 May
 2025 14:31:34 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 14:31:34 +0000
Date: Mon, 26 May 2025 10:31:30 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: Re: [PATCH v2 2/4] mm: ksm: refer to special VMAs via VM_SPECIAL in
 ksm_compatible()
Message-ID: <iekjqr3hb2kshtsq5jvn3xtsgwnvxycfuybl6tp32ciwsb7wfx@mpqqd5vzxvmm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Stefan Roesch <shr@devkernel.io>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
 <e22d9582b0b334a1161ffa150708da370bffb537.1747844463.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22d9582b0b334a1161ffa150708da370bffb537.1747844463.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0433.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: f5231651-2014-408c-d37b-08dd9c6203ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HUqPFJJhAUabrY34ph5ltGZJ1ISNVeoJFbeq2ZWu9flwQ3PCUIxkew/IUdH6?=
 =?us-ascii?Q?v5SBu5AaFBK8fczKbosriojBK3rsni+ZKYeg4kQmrikOZo8urXCCrKivcspa?=
 =?us-ascii?Q?yhH2LGimp745AO78Lge3PDeKX6tC7reAOrLVNl1VXamMcd1SD2jv5n8n/ERF?=
 =?us-ascii?Q?QLF8sSvxDiafsRQsBrUnHMmXxieHw47FEifc2cYdta1Eu03zXabCSsJ9f52I?=
 =?us-ascii?Q?Vd6TtOGiwDdCpMRR38bbSJ/izu5Nap+L1dX2oU0TDeoWYpcLCj/OBKYjpyGp?=
 =?us-ascii?Q?gRjI+s1rCS9RZx6tL7ngCQWz9mo44Mvg29QZxkw3IC8f3pKvUd5HvNCGdNEU?=
 =?us-ascii?Q?PxDkcfOHTvAjlDKatTG66SjP1vE4QOWWW1U2yrXmJTJXWazqZ0dkgl2gF4Rz?=
 =?us-ascii?Q?FB6WQAguldWy9LFcDjlkq7HkJ3wETbRGS+/8XYi/FmHApicus9SNKgOcd8Ny?=
 =?us-ascii?Q?+NYcXEY4LbnptPgckVhYvn1Xq+efIxs28+xp1zFFGT8agN8W4SfXN0gZUDRx?=
 =?us-ascii?Q?+tEXqEvIjqQO/gjb/TmnNyQunYtJkRoWTVAZ+vt5QLS7vP+j1aDIUTeH13yf?=
 =?us-ascii?Q?9J1UTPfHgSOghKiqYxrVx6ypu8aztDcY3EfdWNFpZgKzH6WJmcvq4yMBjnmX?=
 =?us-ascii?Q?S4W/qleRPcgVBJ7gQbeNTTBbiT4jGSZq+rD2e5e3qeaZF2u3iONyW507seja?=
 =?us-ascii?Q?hcw7HvoWfWZr+NZZYxGHR6PKDwRYqlj5Hww/5237eZDa1Ux5pZONc49lXvmL?=
 =?us-ascii?Q?9eiZ9AFIoXleZ+d/0rjf82FUTjq5M5kqGpz4/UO2WwVcW9pWtHDo9622iN1o?=
 =?us-ascii?Q?1/7pi2GQZiuzxB9I/YFJT2Q+jk7t0cFBI1jLr8XaQ8tsN/Dnl3VM6xNl3yKU?=
 =?us-ascii?Q?GjSjlOGDOpRUnYDG26GSqQicWpOkvix79dz44U4h5Oe8482YLnjBb2SBrJ6z?=
 =?us-ascii?Q?FRmnBzCRsgKLz1e6Wdq4HH07v3iM1KODnU9kOjSamEx14gHLXjURpI0/01mW?=
 =?us-ascii?Q?2gQj606uL9u+yNOfU11tmV8IbQY0jLz7ydUfb2Ht1s3mlEQ8eNst9hMpIwr2?=
 =?us-ascii?Q?6scLplSkfza8YBN3Ks8uZ+/cq1xCbC/cbAtlJf4UPSjxbC0bb2MIq9MyXfMG?=
 =?us-ascii?Q?mjFKxMYDRe94/QukoN/MZmqwT5/+8Jue3sSuNAGmQF9JDmPmGmVyUqTt2BWZ?=
 =?us-ascii?Q?VRaQujBcv3Azazaf6KxiICpjVtg+obBh650g9J8tapYTNUvRBjRc1OUztgUF?=
 =?us-ascii?Q?RqeF3pscSb5JpaTwY+OVxvF+Ny5S6E1pd6uaNrAF6na7FG27W0T5UGL4OFK3?=
 =?us-ascii?Q?csJ4qcXqKgnfmLMv7pD9GR/1uxoWz5IRSuOQbtK8VFM2UQJPxOQrhgM/+C+l?=
 =?us-ascii?Q?a3HYshgYmCJba8nwwnnFT+lxyxJpPFPZ6Ftih7XJeYulxBsIZZGPnTUQ5dMI?=
 =?us-ascii?Q?EAqTzLxABcw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VPAHSF7N8llQNJ1PLdTbv/gOpOSBElTEejviSOk+fuhHtBiblSrzFNWcioxe?=
 =?us-ascii?Q?rKX+V2P5smZOpOqwagAinrZ0dn55NkvLi79yS/9t0BPUrEa0ogNyv3RYy0zv?=
 =?us-ascii?Q?uXwd86F2/l9gXiYkzylaXaECPcMNHnBsbns3y5KJqWsbNm0xbYduqETODWhe?=
 =?us-ascii?Q?aCnthkNpCRhEheDmVDdBTDvkpaNp4rHKL5f97zIMd0h+jAyodenoymcN2AFb?=
 =?us-ascii?Q?DQ8kh22XpyKqWOgkkLJ8IOpUOHeG3cfXsXpDUFXAlyrBA5slCPnH8upLUVic?=
 =?us-ascii?Q?zWgWQ0ueHXptF8mdRLws1uyPO9WuHo74rUmYgzAzzj+IO1O0Q/bO2n1e9lcu?=
 =?us-ascii?Q?dKx7EdQ3ZBN7+CjDLszgyfwKQCrBR6VtfR/VUgqI2gZXf2wRKIgV4BymPS9j?=
 =?us-ascii?Q?fqCSZIwN/HGe1512LJnRpUNi4P5P+XUbWKkLm3GQrUMX9Jfaffc9pF8+skty?=
 =?us-ascii?Q?lyFNQYH+rbgDC6B3SmhqnxvnMCzEtc1fufZhPwKEIyrW2rEe7MSxQJuywo+l?=
 =?us-ascii?Q?1W6NPxkcesnJHHTwz6iYpCrZuiGOPfEtsImx8xHFOAN26g3VZuWbnIfv42F2?=
 =?us-ascii?Q?uXEPW0sdHSEOcmKp23XzBlS4fsowxaIDnhFVxIURgQrkTjxYfDxlN0TDzy3h?=
 =?us-ascii?Q?VfN5+68c7tMJd7DrE+uB4i1rBFoA1rQ0iuAShZ0VnyA4i04efTwGQ70k1iXn?=
 =?us-ascii?Q?RGdG4h/NvMEt1D13G52FqpB5rmKafwu2PxXevhNy/5dV1VidzuXZB0c3L5P+?=
 =?us-ascii?Q?E41RNy/XcUQGFcbIaszGpnz4n8wZ9C4gyfuX3D1SP3fhVmBEWp9IighbJlMH?=
 =?us-ascii?Q?FtVCQF78Jn0ilOEDtf3UH3mfqhgcH3MmfOvZVpWFDYTAI+U8h0l30mPZTMaO?=
 =?us-ascii?Q?/2ujZgZgFYcJ2LDMk5c4M+hISQTeFrqiMOkuoioSyIsF4RQF9loRmGbdIt2e?=
 =?us-ascii?Q?qK7wA9iXtGUdAOUBIzUIst6JIsWr33wsEkoO7VGNqNcp6aHyfgV59IwxNycI?=
 =?us-ascii?Q?/OtIPT/8tXLTRCavKRn/wB89tyEFJNww2wDgV1Sg3elEDBzICHaa8QKYYas0?=
 =?us-ascii?Q?Wlc+1r3gnr90GudthZUKwM8xczzaYgrQU4HolV0gZYFAAep5RyTNCdJCB6ww?=
 =?us-ascii?Q?+1TX1YF0Z/YZMvwVnzKjtE2s/xf6TQTZvQaeCZ3ZNeME+RHXL/mEzP5Hgm4m?=
 =?us-ascii?Q?MmqcXG9WKbmcBcNqBwhyVVD5FmKbklotJ8Nu31WeV30JR1FZbw/dSIrlGtnS?=
 =?us-ascii?Q?xC58oIWwC0lgQqVURTKxSB+8PxCBl1QXZKGaOjkM1hkQf0591dhjevVvbBI8?=
 =?us-ascii?Q?+TloJfXVJDKcQcz0ngPQ3Unl29SuGYr8vdgro5DXYRW/B+U+JuMLYRBNtppd?=
 =?us-ascii?Q?A3/ZBi3yCS+1mi++0JqCJ5JxB3e1iIC0y9lkT1t26qJpT8wZCmsq+IZuhlTb?=
 =?us-ascii?Q?cl0Z0S0rn1LLYWDqcgsop/D/j1bZvdX1Gem57fDlHpXXsaX2Q97l5egrPEQO?=
 =?us-ascii?Q?KZN68TdD+pgS0VVVqZVWe1UBWffXAyYeraTMPakWoAqfY9MHPzH57R31cK+8?=
 =?us-ascii?Q?NqrSVz7rdtWVZFkOkVrmC0BsVniMAjYxAFlmgJIj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nen1T7xA01XIlZFpl8AG6YuRO5dbaP+IcVHUvJXGA5FmeOZkd0kmBHb/MPdS6EURTiHS2xkE8YHTKqjF2zr2a7VrrTe6pY9eSnFldHFAmmgHNprSlXGH16ysTuyjO5+61nVqpOg++KX6PhveM676kFOOIIg5HN3gibtGKPn5bS0uvkCk4SA7z2MFWSzV2FF1u2i2yby+FmamorPHuBuqbJnwwY+ID0+HCqE/U72z571d7VwRUJmyXhRJzWrzJIy/Fm3k2UzcwcewD8EXYetll0uhqH3d6Lonq9GlSwnIndmqcZbsrihDP4flh7FXBPWAhF0/yDgPthjo245cip/12LGB/0BUfxWNyLEeaAsUA6d0oAsFPkmCgRZHEQ4t/g/TYiAaJbjm88U/E8Tjm7mI5mUgP9v9wjiOrh/KOAToN6OBQLvd6JXA5SAd7mMhO93cJNxUEGQTFCvJ0ZML2QGlg0H3rzgiUfoeHEbK07dV5C1cxQV1puPAz81cB2Jhqh9/ArxViT5aw/iMvs1EyLMsnyzcq22tKRbsyZeGcA5JDzOUDOnw1x0R/V1jXgN7T4pKXdRVqyPhja8vp2mNv6mAdbSIg+45RDxT4AHaide27qo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5231651-2014-408c-d37b-08dd9c6203ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 14:31:34.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wmr+kc8NNtojLfItkrXBUEL2/MOb0NmJV7fFjzLSQQcFtTsLIzs1LjubJS4p06W0NgKd4sdBjnLjp2Ma8SaaXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505260123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEyMyBTYWx0ZWRfX9X8FExQm+Fpr jNznDoLDgxSobrTX9AvRPK3nI33qdW173km1A867Kfndu/sgWP7TdyClX0PsjYnHim7XENEHsxB 1HUh9YskmDhehq6y3x4M4Spf07UPavrF/8msJ4NF3C7/eE2XpIhEXJd1DleXAj/RpjnbfPm4yE7
 M/AgKRyByyOCeuk6B8NBPe2fnyE7MAzyUIz3FX8hdkGVgclWloZofUPXUFFOgelXm3qz6tqBlaK zMhlfWGPoPPBEkmWWOso4nLtYn54i/lyMvzmheonQTaM1CmIcstir6f5Qkep3dq8jpmCmpTxSCZ Xp131p5AC/ln3GHr1oKouLZU1xzl90oiSqIX8vmF3fM2cdHmWYsIcDB1RFQOHeknuuOM7WBt5Po
 lF/Va8QTcpu6D60Z0YW2fua/aB1RNQ4bCLGZR53v7l0g75PQzGQ2hSDlAZgDRfi4KrpS4+fa
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=68347b49 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=YJo-uvEAg8uD3fn09q0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: 1FPzijDEMRDl_f_RjqVTcelAurx2CDF2
X-Proofpoint-GUID: 1FPzijDEMRDl_f_RjqVTcelAurx2CDF2

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250521 14:20]:
> There's no need to spell out all the special cases, also doing it this way
> makes it absolutely clear that we preclude unmergeable VMAs in general, and
> puts the other excluded flags in stark and clear contrast.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/ksm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 08d486f188ff..d0c763abd499 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -679,9 +679,8 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
>  
>  static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
>  {
> -	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
> -			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
> -			VM_MIXEDMAP | VM_DROPPABLE))
> +	if (vm_flags & (VM_SHARED  | VM_MAYSHARE | VM_SPECIAL |
> +			VM_HUGETLB | VM_DROPPABLE))
>  		return false;		/* just ignore the advice */
>  
>  	if (file_is_dax(file))
> -- 
> 2.49.0
> 

