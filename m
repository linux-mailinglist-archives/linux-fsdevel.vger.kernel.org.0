Return-Path: <linux-fsdevel+bounces-53373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C472EAEE2AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5347A720C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812328F942;
	Mon, 30 Jun 2025 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GL8/doBk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z5eMZfl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4928D85E;
	Mon, 30 Jun 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297673; cv=fail; b=afAEK/9v+Z0jWvDSiFeSf4wgWVpgSG5v0OfBLaKvNeDT4UGAFAleka1jnVPnzSbBP0FnNyeMIC59nTU/oCzTIdKImn7PRtuSJ50BfKYlQr6HDbr9L4Kvpw0FYN5YFf0GMXQYkux1vmUwF/n/HmdyktpRAIaWazPweBPaTbzbhb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297673; c=relaxed/simple;
	bh=KThNdlU1IUttDsVwfm2YEG2Ch6tfHvKGWcsHSMxDFPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CgPSaNWXfZLvYHY++DAZMAjrQOuDX0sQ6GhdygjDP2z+ZcDIyBhgNzx40j56xwoG9CXJsjbBbdCBubS+JaD+D4PPhAIVtiG7rCSF7vpBl5+FYMNPrX7fTpEGJQ1snsxzou1eQu/8XDK8y03+lbvVpIfbnES+tX52zZnvDMZY+Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GL8/doBk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z5eMZfl8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEkx37029588;
	Mon, 30 Jun 2025 15:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vqNEqgUgC2/3QpmRVW
	Tz/E8mcZ7i1PVeCTdRd5yfplE=; b=GL8/doBkJ9Sx4eeN1zH/83wbDLeEbyefDB
	mEHMWGPf5VTEEZVtzSL3OvjaJiAVNSozJ9j7k60o2sVcsk/TVQx9UpWGWg07TOoX
	d3mb9vNe4yQ6mM85G8ATn1+iie7mlXr7I12Cd2HVJKiD05NmmlQ0JhpTlZesUnmJ
	SnIfQiM8pjW0FX+1z85hfKT79ZCthbZSwQXhE2yCsJ29CjipbbMENI3BjuJ0Y71o
	2xrLD+fFlq6mbV/iw7Qh2PUqFRNDJunrtvSGfjOu4sQa8tF6uzzmWjLeAeCDp+xa
	yb7jWTdcvgDBYRg/9ba0H77f6adz5bME9DOmKnmhTjwRZWtmqe6A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef2teu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 15:27:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UE3ILN005735;
	Mon, 30 Jun 2025 15:27:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ufquyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 15:27:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+wRc4imDpBARQd6Y8/q0zfORoztjDKRGlR7t4rVDgrpON7ZIF1DlwjQXaXa+LRecjoKRqLYtMQOjXmagAARl//DQnpsEO0HKUHgs7lUmoUIgHWF8i4ez+nHusVfciYkRBSM3W8zbfJYLY8AmQd1+GCDzRNLlQp8OJ0/LKDk//Xr/9ymUI1A8ag+HflfYBJ7cu2CQ9dIHX2Vd0If/O2E1cb3ezL2FYt2/ng0ggKouXUP3lVAVLo0nShB1wqvntUeGuY7VR2viKN4xYDvlSD2GnONI8uOgivZcustjG8uuPBrQal5VtJQs/MebTn0dCcbjq18AbW+xIFWSYcHKnDNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqNEqgUgC2/3QpmRVWTz/E8mcZ7i1PVeCTdRd5yfplE=;
 b=V32jRLxaCefgu1tVZu9gLR0ZX+AEMJA+xclYtusyU7XuiB2YZrX+ptrILP0f+k3oCnPLADArlTskaiBTimNK1AhGpdRio9xMLgd1INpV+RsjauD9HqnrXklVJI2Z6ANhJaPYxLVTj9gLNAp2cidiSrRWwHeLJ3WKob7sCg+aw/Lhws48PJ+GcwKCoHO5rOzelWTcFaVmTpdl6xFo6Ol43UbXAlb3dgrtQKHPyl3mTODh3rwdcC9sFQn9Wd0djVPJgQhpn6bJAEj7LHLuQoyGGcX8NNj3e8aspxHtc7kKr+gOeUbtbxNWTD/VfPwPsh4aPGCfJ6GPzJ621Gt5QN1X+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqNEqgUgC2/3QpmRVWTz/E8mcZ7i1PVeCTdRd5yfplE=;
 b=z5eMZfl8iTXVE7dhiNrN/YTj+9JP7jqqHEeuI3KjJiyfzEqokbBCHlpTf3qODTKXI/0hA+lPHLHMT3leAXolaoNvVCKtCwBHb3UXddBpDxXXMgOy+1RDS5XCCGy9F/wHJC+BMaEywlHSmZFi6xi1tdMqEtnSdJJ2WMZjDkn+v+g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF83BEC1808.namprd10.prod.outlook.com (2603:10b6:f:fc00::c33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 15:27:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 15:27:50 +0000
Date: Mon, 30 Jun 2025 16:27:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 04/29] mm/page_alloc: let page freeing clear any set
 page type
Message-ID: <8c5392d6-372c-4d5d-8446-6af48fba4548@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-5-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-5-david@redhat.com>
X-ClientProxiedBy: LO3P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF83BEC1808:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4a0a2a-b21e-4c82-d857-08ddb7eaacbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j90YMRfoqu9vAPSIGZg1r8T0KmC9U60nOwCaoI3/mvmbPrDAdO+6YxdU6ssm?=
 =?us-ascii?Q?GKgKOQ1jfd1ebvFtc2CnSFUoe3B7mXSj5m853BnNtoRLpPWDfLpfyWVHkud4?=
 =?us-ascii?Q?4rnXhYZWBKJfqLR23x/pE2wWEqabAVm72WPSDQKsXHZdAEwGTNT3k7ScXLBn?=
 =?us-ascii?Q?AyCckgJRQhMUS9v20Sw9imoofgXPJmYMiVpatMUPxPOHxM0LYinXVl+IkvM3?=
 =?us-ascii?Q?lRf+qpIicDoOWTAguE7c5ku7ZAewGFnkIw3UV4u5nDvFCovLMFNEXuBiF48S?=
 =?us-ascii?Q?kTpFV8vwLjvlK9ubcVNxpqUL8gJrR6NXLA/tJuvvTeshujg0A719yrRutRnC?=
 =?us-ascii?Q?B28t3/xCWmMWbMf+UXAqS6RA6YaK78JV1dCgTW3sgQw3iScaaDKgs+ZgJod6?=
 =?us-ascii?Q?C9YXw2KmgKToCxN/3PrRdGGzJB1mbyExVxFYfSnWfx3vsBlptklgbYAI8mOS?=
 =?us-ascii?Q?qI2UMcmyaWCXinbuTk3RST2otpcQ0HBt7Sz/X9Ldx2Iv/mgZxHbirdjW4h/D?=
 =?us-ascii?Q?OnHJXIb34BuNamZza1NpLoKrPg9D5dxioIe3UmhT/Qk+4Ak/fVnkQcqCLFWC?=
 =?us-ascii?Q?VGiHli4ti9RwdmxqxSqj6TI0PfiDpaILRbf2+zonssWRmRlo5cbagLa0QoYr?=
 =?us-ascii?Q?2364cBiEwDj7BCFaBCXcg0zB7h5rfnHmqE8sSAnAGlXQjVXM7vRz/lbctlat?=
 =?us-ascii?Q?mA5cQBdSr6bIJ6K4lGHSCWqvscpC1YTxOkG+b9WQdZibLcB7eMfuz3+v4knb?=
 =?us-ascii?Q?uMy136EOP2mqWb4oANORayRTjcJlctMrtbD34vV4rnf76OjAFZzsHOz4gpJO?=
 =?us-ascii?Q?81zE2ih6770HqnkvIegXRVo0Y+VSTu7Pr2NOxcal41G4Z+gnJc47a4AyEbuj?=
 =?us-ascii?Q?teLhbM6nGY0G8Cw0nONA7BQLrgdTqo3avA6pWrNh3AvIPKxwCfgygXOrF3Uo?=
 =?us-ascii?Q?GMvB3nv5KDxyNB1PVyGu+B23NtbIsU8Ou5wPlzV6Nq6G4Uo/CZkeod44Tsrw?=
 =?us-ascii?Q?cH3ZL/WIrFG/FkfbFXYtLgAsbxQJfrsxmgWYOaMIH0/JUZMOcb76vZ4AwVsu?=
 =?us-ascii?Q?GYZ+JDGfb74XfheuayKD4T9mVOu0aJVjq6znjIhz+aND31oxdO9He8kV5WYR?=
 =?us-ascii?Q?R9soABeu+ica+G0B+YjV1HTcmOh98ald69HEX9MbCE9cj53RiDdO6uLqT0nb?=
 =?us-ascii?Q?4svqwz6Lo/6NrckYz7Qg0sXAKAPAs2jp3JNRNtTM3RstSnK8OBmbP6pIaU2B?=
 =?us-ascii?Q?B4WGfJKvoFgDt3oF7FicE3Wet3B3MQsFl6j7xFA/9sJtLkA5/4POALKXUO7F?=
 =?us-ascii?Q?gl7uI2TkJmgw/nkHh6XU0egbMhyPJ7bkH8l2EhweorV5ZB2IBhZg64DHVTTv?=
 =?us-ascii?Q?eV3ncMN0oQPDjLI/qGrHdUxLx9fSKFzw/Th+9Nwhiu9OHeYVBOzYFDIPfwA5?=
 =?us-ascii?Q?rwRAMckuPvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yj5g/Qxafy5k3z6gJXAL4kqPHJ62bZyj5sxvD09zLAhHjeNm9yUot7YHZ1eC?=
 =?us-ascii?Q?ctmhkjnGwEHXlpZC6Yg3Y9zBU+HKGFM0f4lxxJtMLPIi9iN8wDGpcC9bSJ+x?=
 =?us-ascii?Q?EES/+W80WAXsNHfbqVQ4w6VPUPLWsYqesZ7jtMK3K9rE7FLHs2cQYi00NC5W?=
 =?us-ascii?Q?l8ZO4fBL9+KrYSB7OZIj7FMtEABLjeSs3tzuH2dA4ros00LXde96YIfttvxI?=
 =?us-ascii?Q?jQ6Tr0Dveg5OSlHEfVd+Eqrz/wel8iIyocsY9qurh3x2J6koJ1v9xm40Xef3?=
 =?us-ascii?Q?o8KnTw7pGRtQba8GvKNQ44ASzBPDnE5wi3e3DAkChhZgfzr6LvIKAsWn/S0h?=
 =?us-ascii?Q?fJqXL17G4PtW/zhByJWK7pL96teDZGqWwrmzJM+CVcTL5QmJh2/a/sLoYTmQ?=
 =?us-ascii?Q?YlIL+iXUJjTPBtv5k3Jr7KWaSayEincG5zlVamqbQx0bVyerGQWztw/UqSEP?=
 =?us-ascii?Q?LQ77342SZJVzvXIEmbpOP6/gxJQqyksf+cGLUhg1ICcP8jkiCOtI8mmH4NAt?=
 =?us-ascii?Q?or+ItFZGSMwRWsuH2uYdkk4XiCPblNgU6pjbe/dKLnNBNMNM0geRRqIojYsl?=
 =?us-ascii?Q?fbhDmrk0WKNdAlDRP83m0HZRrUvos3Q3R/GQR4MxaR4RTaw6Nmi6iLyJ+24f?=
 =?us-ascii?Q?fGr0L6faoUUyhAXN0c38CUzUuHPRtZaWhtaOl5TXBkgAbqqBFVdeJwqBM7SJ?=
 =?us-ascii?Q?nLpA8SdamV2gcHXZhhr/GD7gCUhw3ptYNeBAggteEyzxByen4BRRK/e2Jdc7?=
 =?us-ascii?Q?vUTx+EYR4Brl3d7EYmSo6gFA8dhcukxmJDtSTs7ZXhmyBOKUKLQdJcm2yjvp?=
 =?us-ascii?Q?DShxNIaKuzCHzrYRizH7e0q5WmBCng3wIdOKRRlZ2JtaiaVAQ400JeI+ypxc?=
 =?us-ascii?Q?4Hi+ECm4GFMp8aLUIaVnE74pH1+HOB2un/LaShuPTkdSwf2jwUjcJJpErjbd?=
 =?us-ascii?Q?Z1ZNMCKN2C+Z/G1OjqVnVHI9p3sS3ID6DpywIuHo6H8Otli7rKITNpSm3sc8?=
 =?us-ascii?Q?MXlkNmrL5XTvp1S7iWIxsYIvRMV+cB2NkE3IdSItgluWAWQ3bjoPtYZhfWZn?=
 =?us-ascii?Q?LrpsCEGCsrgbYK4SX50eSlhC4RXGhL/35ijLrOXx/FTckGqZ6pfoWxmnp4h5?=
 =?us-ascii?Q?94QzeDWvFPGy4WPA3HWRkhTz9J/x3iiWoLHRJi/rS07fn40M0jpb9nd0BsFL?=
 =?us-ascii?Q?CkJSQb6N/fyo+UXWul3ceQyWV1dVaFbw0V04o65X4oiaGcyWu1c1yQv6e5JN?=
 =?us-ascii?Q?wGRg1f24Ge0E5V/cuKaWtpc3vq/LzwcSLk+/nSQWPlfRPM3cGBj7SZEH+ikW?=
 =?us-ascii?Q?1ZQB7ds0aiev+Fc1zOmt2lybAXh22B90qH3CRHbGuyoCYx10PCtUEo6bS08f?=
 =?us-ascii?Q?Ts3Eb8ut0JSixQ/9gLa1SV6TsfwSJSY6inv9XT0ha9HGVnjuX9cRW3irVUZG?=
 =?us-ascii?Q?V7xNkC8VSefpM10RbBEG6BZHgCfqDHvSU/nnbGCG28nYu1hrcbKE13uoYZ5A?=
 =?us-ascii?Q?xhV4j7oBA8ANQVw+9aVXQBdfmXt+ujXNUF11ZvJFqMqclkCkPBGadtUd0KUN?=
 =?us-ascii?Q?bxyP87kBBOIrQKc3Gbolt9n980zCRuRdiG2JW7djhJRZ5BWaKmFAxQo3FnVv?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mbR6F1puAd9AeMMg4rw1dHxf692rPBAfMQTX5BTihMl+Qa8htIbnGUkyx7kAS3EPY2N8dRPoh8dImwU8Bg3jEflU3RQNpCpIwzjkYARp8lOHNmxYWCtZ3j2BfFeGGmVPAkN83dLpW4tdhfFJXkNBiMv57e9odA2JGcrk/E64y2mzFJ7dxvMC0bOf5gE7zg4rVxJZHXlWQc0oq8mjqB956AAKyMPq7q7qiq8XxjJswvVBsplxB6HvZ4KIAU1dD8w6W6Z5dcumHvBbg/W/mHMMDBr+oOOGMssH0qUMFBp0DtOMk6Ri9Ofm8H9WCLuzzBWIUm4EChlkBKDE64WUnkDjKISp3S9ITPRLQOyxTg1IIIszMkaMrFKf9DoeieB8Yx0WhtdQ+tC4FrgKtdshzTafvsHjisekbdokSJcTVMvz5wm3/stqBgyDRqBimpZVvPSLaD3T8+7FTKJLjwoibdICpTYAL+YsYzHbVns3FIzx7L+cszhGhYTbV6XJ8Tv7/ccyQJQww72XhWS4EUSz3GCGU5sBi6lArLp/H2+8tFABCbB82UnBmOXz01c5UDFXMlnYEzDI+rDPn/XecGvtYv0ce9abD6b6mZTkCHuUg8STw3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4a0a2a-b21e-4c82-d857-08ddb7eaacbc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:27:50.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ie0IMo/xrCYRYM+LJPpx8ptUG9EvJlKZSuKpvIUHK3ekuR2ht6BbfSxjPiZ4uZUP16uwmAdG8erFODdkyC87yiB007DLCCAL6ltrHZGRTrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF83BEC1808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300126
X-Proofpoint-GUID: GXrdAsw82l3peRQTryC1IHSIt-aPrnus
X-Proofpoint-ORIG-GUID: GXrdAsw82l3peRQTryC1IHSIt-aPrnus
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEyNyBTYWx0ZWRfX0mB0I6pV+wen mQ/65FbnYdB0q3WRoghkqeABgC0FzTRFoA0+MT4hTc/8oOuIzWuyKovpW/feKXUqaZENyFxr9ZX c7OBSCcgbVV2X/SI9etysv8E1AVxKI8hg6tEokyaADFwI5kNWOcNQKIrR18WFCQxbPkyT+uz708
 ZHqQ4X+ZEFZiUIqGFl4hbWVVfmW1CPSvUxtjNlRT3cxcZ27OA3f+qQIHva34kjQsQB/Xh1xgDev dTp/4W4O7sdVIsVVODhr0Xx8+5ooQ1xJIDrkd4j+qC89/Wdz/MGRG1HIYO5VwbS+OFoRKAX8lmD aKv+iOAqicowJTKlioKMa90U1cOWRfiAtZeOe8FJaw8x/utnbv3MUz7F0EIXn9HDoe/KjvqQMCh
 PNeyEDwkLhORcVLUCMGRD/JDuCKMBINfczKEVNvGrA+WP19fCfSePeimAudePmToRJSVpATh
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6862acfc b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=uSDXPVL54JeD_mbsrSsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215

On Mon, Jun 30, 2025 at 02:59:45PM +0200, David Hildenbrand wrote:
> Currently, any user of page types must clear that type before freeing
> a page back to the buddy, otherwise we'll run into mapcount related
> sanity checks (because the page type currently overlays the page
> mapcount).
>
> Let's allow for not clearing the page type by page type users by letting
> the buddy handle it instead.
>
> We'll focus on having a page type set on the first page of a larger
> allocation only.
>
> With this change, we can reliably identify typed folios even though
> they might be in the process of getting freed, which will come in handy
> in migration code (at least in the transition phase).
>
> In the future we might want to warn on some page types. Instead of
> having an "allow list", let's rather wait until we know about once that
> should go on such a "disallow list".

Is the idea here to get this to show up on folio dumps or?

>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 858bc17653af9..44e56d31cfeb1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
>  			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>  		page->mapping = NULL;
>  	}
> +	if (unlikely(page_has_type(page)))
> +		page->page_type = UINT_MAX;

Feels like this could do with a comment!

> +
>  	if (is_check_pages_enabled()) {
>  		if (free_page_is_bad(page))
>  			bad++;
> --
> 2.49.0
>

