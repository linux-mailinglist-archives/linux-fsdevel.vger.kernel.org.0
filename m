Return-Path: <linux-fsdevel+bounces-33801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1086B9BF095
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A3FB2347E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15D201244;
	Wed,  6 Nov 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BlvZIM+C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mKWXY5r8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE882746C;
	Wed,  6 Nov 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904339; cv=fail; b=DQKVFI+qznkLCII4woSEev+q3HaqYj3yyWQIwG6yAUDW/X3EviV4pHtYU7oZSAujgbDCoLPZm6HxRtwOS4E5YZxS0KIFlPSL3i8N8ZwzV0VCWYd7WSnrkY4MpLHSwcWJBas7EozgAzwhNkSEwYus/dsenKYgSumWwRZBw94JRiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904339; c=relaxed/simple;
	bh=5TqYzRYS9BGY+VztLupG/DXRIB/C//YdxGFS+DYgna0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p1ZW/9pZsrELBmYUHUVal6zQGG6jfsp/WVGX/syUnFKZalHCziANNvYnHA7WbN6iNUJuo8eUjd5tDE4ajLSUfdIfW0744YbNglO8hWYyebwhJgeeInbZKrUEu+4a6BYVsAxc6KopyYDsPTT/MKxha2KtDAQZ2zV884UbLEhES7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BlvZIM+C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mKWXY5r8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Ci5bf012886;
	Wed, 6 Nov 2024 14:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+TYNeMqNGE41V/78Vq
	q/lj6E+1ZFAZ11f+peGL+AJBQ=; b=BlvZIM+CkYZo5KwZyzJysJYAFe0Z6E5rGH
	oNFA531U5bwEuYH6twjMSdz09KAMy9/BC5n564/7KKzeEAyovE+XGAcgdJ13VZSp
	91ZMQABts8bxA7Cuh+4zcU5LlnPdoI9PfFUaoynwJVgEV2BCqgE+RkUbEBg3A85N
	SBeI3RyxzyeoVSznsvfUfWzTWSGM62UFmc1Y5dujF40Q9qxp5GQ4YgOXZ6x2gZWQ
	HbM7mrB53QQ+1DGC6tAD7nKiVGKheG5CgCFuRq57KVEKE2xhOpTKKIJmwUcYYMFe
	9rXk/QmfYwsZ8m8bs531zENhN3J6KYh+i0QJho72h6P/g0UGP52A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nav282s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 14:44:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6EMFai031477;
	Wed, 6 Nov 2024 14:44:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah8bbs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 14:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feHohO9z0lMSOdtHUgD5JYzkNQkG8+0idSLBtoqkGYkTm17TWByBHnJRT2VQfAR8JCQxkjspFM+oP+s4eu3wc3y/H/SwDz2FOnpCFwr83dA0x7tIC4sQ9ZckYbASDaFESw7H8+HfkM+bcRbZxw+Bjr1X+kZfEFggXDMEciNbrxlOAOfQlDAq9jVSPbmeRnEHBRPblKVcdFJtQd90z0VMnlg/fypGvY8635kzFSkIC54oO03qSa0/5qjaprdSX5908E0tVl3iSJcSNvmfkSWRLglqd7ktSE4RcLxZLLS4BTyyyf/ikIN6sIaLYvyh3Bu96bIcjerGpovKpBF/HDayPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TYNeMqNGE41V/78Vqq/lj6E+1ZFAZ11f+peGL+AJBQ=;
 b=dafaKhgSdkKRFgUvfsU3ozLDh9ajQYNGKHccVFu2ryVFVDw298izWafy1ACI1rwabpQQ3BrertwzVRpqHPgiVaoeuVPGvjMzKir3d7ZRZWs3G4/heRQ9zQa2Fb0FJhlYV9i8msQq+1NODNxNpxC2D3CE2hu55NwgAb4+7ZOawatRu2GpQPH+tNpPcECrDTUlPTQVMu/C+N3Obf4p1gP3Kwc8nh50+9Lv+kxO4DWQZ77uKcAmtSWjtvi4HOBmLr9OfOyBVfjZKXSANOilrkf4ZEPaKIMDr/fJFy058brOYs6fHclEEU1zHj5GqgkfIwWN3OQNFgY6sPVDGZafMrT07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TYNeMqNGE41V/78Vqq/lj6E+1ZFAZ11f+peGL+AJBQ=;
 b=mKWXY5r8Bl4/1XhOlJ6i5EPs6h0pkPJ1MKL68+0wfeiZ50fqSeuGgUIVTkYJnsMH8xmBdGj7SoIYiOMFVzru/gDhOaYgNZRCF0Etfuqevjt/20Wxqgk6k3jNXGD7b8YHDTNpnkk3RiJhaT/Aqyezwaw3BpfKhWSdl90kaYyQahM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.33; Wed, 6 Nov
 2024 14:44:32 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 14:44:32 +0000
Date: Wed, 6 Nov 2024 09:44:29 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, stable@vger.kernel.org,
        harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, brauner@kernel.org, akpm@linux-foundation.org,
        hughd@google.com, willy@infradead.org, sashal@kernel.org,
        srinivasan.shanmugam@amd.com, chiahsuan.chung@amd.com,
        mingo@kernel.org, mgorman@techsingularity.net, yukuai3@huawei.com,
        chengming.zhou@linux.dev, zhangpeng.00@bytedance.com,
        chuck.lever@oracle.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, yi.zhang@huawei.com, yangerkun@huawei.com,
        "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH 6.6 00/28] fix CVE-2024-46701
Message-ID: <f2uywvmtresyoxthvygqzox6lk2jc6blma35n2bbvejfbv7th7@4dzvhbxaxnjc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Yu Kuai <yukuai1@huaweicloud.com>, stable@vger.kernel.org, 
	harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	daniel@ffwll.ch, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, sashal@kernel.org, 
	srinivasan.shanmugam@amd.com, chiahsuan.chung@amd.com, mingo@kernel.org, 
	mgorman@techsingularity.net, yukuai3@huawei.com, chengming.zhou@linux.dev, 
	zhangpeng.00@bytedance.com, chuck.lever@oracle.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <2024110625-earwig-deport-d050@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024110625-earwig-deport-d050@gregkh>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0215.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da28dc4-ff58-4e68-2fef-08dcfe7186c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?47IPag8p4x3o9JZl6ymAd1MfccxD2IeR0YbXzAU4FJnlsLJpK6NFoxRuMCeH?=
 =?us-ascii?Q?gZtYrRPjbRB0JWQLBTNtxSYFuawAOgHtD0qwH+xTNWFQ2a1koJOehypA3tDx?=
 =?us-ascii?Q?RHpVtrL57NFQ404TyPExElwAcHhytk5jnJ02qwImYQH7fPWJqD89oD5RPxq6?=
 =?us-ascii?Q?1p1qnIt4NFIMx3QL34VI9obpH7dQ+WVh+Mjnbftrzhi09MVHJXkmoSmARr5+?=
 =?us-ascii?Q?WhSm0QvqahGACEu1Z/jP2jDM59fQd2YaQsJYJ3o/pofJ4QOy/nG2iiGA5V6o?=
 =?us-ascii?Q?RFn94wWJZ1XmsJwIjwDN4Q8G43okySjBZYyyoHm51PllHQ3IOfT5H5Takt6Q?=
 =?us-ascii?Q?k358vlByd68LzhBHSQB/jOVgLw4QYxnYq3ROpTTzOQiVmo5IOSrqIrqWLKsL?=
 =?us-ascii?Q?uVWkCfZBnr3r157e42HDXs/6dcO0xh5gF1wD1DpzWeJcxVvvkIBffHjeqUfC?=
 =?us-ascii?Q?XyLkXGwp5VbrsuERFvwLA0fYfv5zguKopRU7mZ+e8MYRoqGrXfP+Lg9F8MqA?=
 =?us-ascii?Q?6ysEk+VJAR7h33DypaJx6gKEZGcYit+o17qSqkt2mkxjKQN3VDUQDc1RIYhF?=
 =?us-ascii?Q?DcIB709DqPWE0mCCGZGFlz0Y4rzCkAbpQXdBBBUwzRgh5F+lxMJf0/wWO+j2?=
 =?us-ascii?Q?VTfQRyEP9ICh+/n3hqhczgEcZxBWnSe4oTASm6+s6f8OdGmafLTZS5jic46E?=
 =?us-ascii?Q?dPQnj6s835sBOboMe/tECz99HSknR23cOj+zdYUlfzwIdRkqPv1LpmrxpBN6?=
 =?us-ascii?Q?tBXegkCyiU4Cw/EOxzK+i5LrCYztMWts5Dsb1ZnS2feEbKFvv0R3sXV2HUTP?=
 =?us-ascii?Q?Eb7wAkVZDAX/z4fNRiWdRJw+N8m0Zc24TANgCbRcXtecUJrcN9D8oriQ4J+s?=
 =?us-ascii?Q?OPNSQH37+/z/R4Uz/cTr7yj/+Ht+UPS2FJR1b7ropS1RG0docJad5wGs3yV2?=
 =?us-ascii?Q?rBuMfcPotQ9nvXYPn0bwCu7CLnb9q3ynRqD5t003Px9kbb/esJKOUcn0tt3O?=
 =?us-ascii?Q?pVp8O9tx/E/yyMF4arlxiI2jVwZuUBvn9m0OVvquTQld5qX9snABPdynmQl2?=
 =?us-ascii?Q?7LuirowvNIL13LiDxPr/B6f5XdzMiEi5cB4ppjwbkRL8UKHW2QLgl2OZ4zZ6?=
 =?us-ascii?Q?YIvTgqEbly99+YRpHc3zmrT7JtX/yF9SRmnNACWBK8djo946Tb1qT7okXoD2?=
 =?us-ascii?Q?SqkL0MVtFAjc2mEuqrxaK+k5pNhUEqhRnHX7+2dmWpxFQvmo5YmrCCUCeEIR?=
 =?us-ascii?Q?uwJLCdAmGxItA2zH/LztJxE5r62MDPVPGz075fLF/q4W+Tcj2ZIuVoTVX6OY?=
 =?us-ascii?Q?O93IkxZOE5l5q4AoT+bfyMj3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n/+FOop2nEE7ko6w9S6DMSFw4e3Sp4Xc0D36p/ufQXjDekj4Tyq2dVkec/jr?=
 =?us-ascii?Q?hAYyQqD2Cm3l6MHelfGHnbn3ubYFlpKu+LB6Tj4JdZ87vQz3VgVZ/VRVcuhV?=
 =?us-ascii?Q?8+1voShC6FBwi95kSxR+0SnD7cvUShIbA43zAf0Rmg8QCTPuquohLsJl2isD?=
 =?us-ascii?Q?7phv5+YE5ew9x9JK5r/JpFQocMIzJvS7O11qSHoaIOvVZoBzVCjsRqDskOLX?=
 =?us-ascii?Q?xINKTtOZ6jhKlJaLvqFYElh57WSzqIGqrRPAkMM0cBm01hpxB4uar12QWDlA?=
 =?us-ascii?Q?gQvnUN3lql+wcwqNlGI5qkmNDvDoo036ZTjRrbj3gxtJERr0Ry4s5qAxzxX2?=
 =?us-ascii?Q?iLJVxkBMc7Erg3ob20953woB7sw7dgCiyvnrEF3v0ccfFD7UBRyA/8n6Gl8U?=
 =?us-ascii?Q?kDr0xeyO0JbBNS32A+8l/iK9mcaUBaiTEgq1VD2GrvDr6R3O74RByUp5N1FX?=
 =?us-ascii?Q?bHzswXoV1FzFNy7kfrLemQs7CY+fTGahvE4O1Ru3whH0sjXbT7Qj1Y+BKNn+?=
 =?us-ascii?Q?dE9XGTHOOKvtt0H7l3adY3mVgRbdnwESxx1UalJoPjL+yJ08El+nHbXna1Kb?=
 =?us-ascii?Q?wPurr/UXGlidCYi3li2MJozXwo/DStcbj9FbzRHaNC9Pm4c6INxXU7NVUn4a?=
 =?us-ascii?Q?Tqz866QeVqgMzm7YCG9SlsXRpbBK0BUGmWgmX5F/ivf2s/sl6U9C3+HQdxe1?=
 =?us-ascii?Q?SO4yAcTkHW4n9mFK5CNKYbtwvrlsc22gkeP5ba2Kg1IbN5b6HvSF3RKMaLFl?=
 =?us-ascii?Q?VaGp2GWyJMfyYBVy6fzmNCUDkQ8VMKg9b4mqE506cGdp431hUlltRIIbcAZu?=
 =?us-ascii?Q?/DyeiIkjpy0Ca+eX8rIjHkjelA8AaMiVP5Dz6Tvmd1jjcI4vMji2MIKTBrRo?=
 =?us-ascii?Q?JtFdQ1NmOYTJ3KXZVvr/O3/9+f37m0CLEqwzNs9A5JfLIf1rtpH0V1uLpls7?=
 =?us-ascii?Q?5sMGU9fLsLeweaknaL8LolL6vKIksY8sBOLEw9bpG6LS3ROH6Z8XHiOFCk6e?=
 =?us-ascii?Q?o6sXzDD9x8ZQro41fIlVKSMb3IAmZw9dLtnmMCRFMMV0UFJjEDlEI/Kry7Eo?=
 =?us-ascii?Q?d/vk5ajD5ln3dugh6wopdFA0ucTMTZ0mjYpPgj/UQHkPhs40vxmSwOd/rCir?=
 =?us-ascii?Q?MxRfzcGly3mR7TMnPrbKZumkyxkvqa5+hvElC8bRrLHN/S1+FXIChWn6aHDt?=
 =?us-ascii?Q?bJUCGE25ePcUTbHfVLFgsW4atGQgXILa7p/Pj9XkMNKSFlg9Guf+brfLOELx?=
 =?us-ascii?Q?DL/KALTkyO5Y2e9rWQw63QJvqb+jY5xBlJS8kVPezGPzm7udV+nzOvI+TKza?=
 =?us-ascii?Q?kAaWb/iCfzMvYM39k7C9AL0AgVNOEM17k4/4jGxMlcFUbzU2bBEpiAs5qJcP?=
 =?us-ascii?Q?yJ8mOHJEdKAm2j7XGAd5hnvT1884ReTluG/muRGqBNlgaXOWdntecue4xNd5?=
 =?us-ascii?Q?It0WBdhYT2M2B91x8/lMV0IBG0jFW47qiMqurfOcEWO8y5ZXxRaEX8bzBiw6?=
 =?us-ascii?Q?E6Qes1cnA76aHfoPs+ORvNcFMw6xRIBwMNZbBJrvdN+49FwG9OHNmm2kITli?=
 =?us-ascii?Q?Mcsu861k4y9frxRoSeoW51L+1bwbop4aigs0zB5G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZXL8DQsim/XLoyTIsHni9bwKSlcpnRrZMf5B3y4uZfYOhXoE2h0v8F7/64PUcPgEMO96V3r/IQ0ws8r5ROo21TAatXybSOKzBnQB2K21xfDc1BywuiWb+9uOBD/YOGdsKI9phXyrqh7syA4/Nj6cKd9jI9eeH6e1ThMX8Csr8sY2WAIsRTpelHJ6CivSCrs+WLSycrikC3TDeErU5COrF2ALH4gI+53jdO2PkxZgr434cxK1ITSORlG4DPhKtzYh3h1GnFpQgfRB9qnlHkzxsV0Ddh7bMCQsCaTppw81EQzkSbQzGfFsuv/3gNNRKpaJMETezQoFSmCZ5EOPDsfbBrLgl/IJla3QmoXUQZLjMDxbEIOhy5Ii3LwIzWx/g329O7ZPopfY2rxjkmNH1zeX2ficxoSNX0AAKNivVMmf7ciRyqAfez37HhlPpcEHPhbXJIYw3tlS1gE5RGmjuHGuMN8HSvcehExcvytj/fBZ8skHkunWPE6jQZHmG4Spo/wQ6f2q5sGaNGd3ILyftRI1IbfYejTh+on9xBlLXKxPHtavKGRUlJ3dUZ+c29JlZ3TQE73g8fUkWm3sX+xqXgeAIIoGak7AJtiDVXFiUR0YTEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da28dc4-ff58-4e68-2fef-08dcfe7186c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 14:44:32.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtNoxHfYJRF38z4uUkRXoIj/oyxAWZwOzyTFTPvAnx9z7cygtdBZh05ndZ/7+fE7S2PrOZd506BK597BaHinmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_08,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060115
X-Proofpoint-GUID: JE6hzPJeBxn7ChYuaWgsB2iCYQ8x3zc4
X-Proofpoint-ORIG-GUID: JE6hzPJeBxn7ChYuaWgsB2iCYQ8x3zc4

* Greg KH <gregkh@linuxfoundation.org> [241106 01:16]:
> On Thu, Oct 24, 2024 at 09:19:41PM +0800, Yu Kuai wrote:
> > From: Yu Kuai <yukuai3@huawei.com>
> > 
> > Fix patch is patch 27, relied patches are from:
> > 
> >  - patches from set [1] to add helpers to maple_tree, the last patch to
> > improve fork() performance is not backported;
> 
> So things slowed down?

Fork got faster in modern kernels.  The backport contains helpers as
they are dependencies for later patches.

> 
> >  - patches from set [2] to change maple_tree, and follow up fixes;
> >  - patches from set [3] to convert offset_ctx from xarray to maple_tree;
> > 
> > Please notice that I'm not an expert in this area, and I'm afraid to
> > make manual changes. That's why patch 16 revert the commit that is
> > different from mainline and will cause conflict backporting new patches.
> > patch 28 pick the original mainline patch again.

You reverted and forward ported a patch but didn't Cc the author of the
patch you changed.  That is probably one of the most important Cc's to
have on this list.

By the way, that fix is already in 6.6

> > 
> > (And this is what we did to fix the CVE in downstream kernels).
> > 
> > [1] https://lore.kernel.org/all/20231027033845.90608-1-zhangpeng.00@bytedance.com/
> > [2] https://lore.kernel.org/all/20231101171629.3612299-2-Liam.Howlett@oracle.com/T/
> > [3] https://lore.kernel.org/all/170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net/
> 
> This series looks rough.  I want to have the maintainers of these
> files/subsystems to ack this before being able to take them.

The entire backporting of all of this to fix an issue is extreme, and
although it will solve the issue, you end up running something very
different than 6.6 for a single fix.

Looking at the details of the cve, it seems very odd.  This is an issue
in libfs and the affected kernel is 6.6 to 6.10.7.  It then goes into
details of how the maple tree allows this - but 6.6 doesn't use the
maple tree in libfs so either the patch needs to be backported to an
older stable (6.6) or the CVE is wrong.

Almost all of these patches are to backport using the maple tree in
libfs and that should not be done.

I don't know if the CVE is incorrectly labeled or if the patch wasn't
backported far enough because I was not involved in the discussion of
this CVE - which seems like an oversight if this is specifically caused
by the maple tree?

The patch in question is 64a7ce76fb90 ("libfs: fix infinite directory
reads for offset dir").  I think we just need the one?

To be clear:
 - Do not take this serioes
 - Someone in libfs land should respond stating if the fix above needs
   to be backported.

Thanks,
Liam


