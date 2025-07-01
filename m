Return-Path: <linux-fsdevel+bounces-53521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBDDAEFA68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83756441EA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF0275872;
	Tue,  1 Jul 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BhlP66Nj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hniu34Dd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072827584C;
	Tue,  1 Jul 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376126; cv=fail; b=supdaVEupqabqLfsiGKQsDgC4omPfrPhqPHWsO8Qz7QPp1SIfJL8PyGPEuby3IB7yljHX9XIi/W7IR5764sJ0i6QURqI2ApjMsc/bc3TB1VrqQHfg6x4f89EADCdFM4aUDwQPvlQqamsG+Z+Jo6jZYuuyv+Wku9W/xsa/x+O8U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376126; c=relaxed/simple;
	bh=w8NvSP91tmrfrTsJxunXl5NgB5X2XfojDZsCegBtkmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qrWos865h/91mv1ycmdNoGjO5wHpHb+T3lFS65Nq8U9nAqIiT6N3RDCuNdJb7qkcl42Hn1JHc90amG3nHdYsTdGpYSibcryBAPYathKNXGyrtjXOAMOKSvk7OJXkQe3El9t6vY4frqYu7fCWUWfajSZXCdSSpKjoDQWOPLAp5ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BhlP66Nj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hniu34Dd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9TCX031342;
	Tue, 1 Jul 2025 13:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cBUhqDH/Ol+mQnXP10
	e/l5BlIhszjfYhCAxoBV5Bu78=; b=BhlP66NjPqoTIh17imWU/hjbnujJ6pmnqf
	69vD9yBDJ9S2M6hGlvNPkA8DmJta7aK/74Q5yuNC2as5rHXhjbfERaD+wd01rkYy
	Cw8PC4qCi8Z6tPtil5BAh9ahEzkkBIuRyci8WuPjPmgUnG85NWfg3QSGDjNKt90i
	t2bAcRcDQK/N9CgfjWVypQfTjgWevBAQcGKYF51pftwNJYHVieM6M0Zv/a2YAdGa
	m0o0F8d9x/KRTbtlongTMkJsqJCSuahRzTeNWaLbD08HJWYSFas7lOTztKPi9qQp
	YWgmGrMtzXcgiHim2VueJpFLe+h4vbd/N5qvoAKJ09fAiJdK3EgQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af4re4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:20:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561Ccgrr009053;
	Tue, 1 Jul 2025 13:20:18 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9sjpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:20:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXFtN5XdXEuYy9E9UF1EgD4etoHSCU0bnyJt8qwL5FbLjW8X9sJ1eZgB0Y+VQG0cgIlN4SXymrR3MNSGawOUb3Xem4EnPlKsla2WDQw8mXGRvriBvPybdRGjT88P6guOIyxrJExh3UVP/vjTO5C5SC+b5dCSlHSCLIZpmEZ+wVFEA3adtZMuf7Z3JdfV1f0ITAKoeXIaeE2y6OYrxQUDeOqLIHi+tLFhyM6/pjExjzVzw06jLeJdetaPbEXn/vIV1azjM7D815xxB6G3vyH7omm/ncNWBwlgR1XLsxmjh59Uyz+inNbU4xYSIBonZ8aDNlhjZoFZJUobkNiiReaoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBUhqDH/Ol+mQnXP10e/l5BlIhszjfYhCAxoBV5Bu78=;
 b=Vahgew8fChW2ufIfWWN3YWA2Jv8LzSfJkTV/eNvIg5IhF+5K5zMxWL26Er5tlDznUrn39Xqcb5X4s/pQepNRB9syUMfR/w+KB2revmZrbQ8BZ/UzGc891S4zs+c3zc2RjtIHvEWzBbE+thQ1m/E3MNmjjUvC9olTF34PYAN9sBqiivCQ3o9+kK8hSCYp+jAasn2ZQ+Q8IJ8a5GQWsxctajyPoZUJdZKJStM6LBha+hmXANIQF2XcY0zkn4XjjUUETgtc0TFxNd2asNO2ltItQvn/0LidJjLlIX02wRQT8tpmDqO/cYJkzsgmNS0kBBPjvvU35v2iknAgX6hyL38qmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBUhqDH/Ol+mQnXP10e/l5BlIhszjfYhCAxoBV5Bu78=;
 b=hniu34DdLfGwXrWQ8X3Rx8nppyKLKTjIH+jGGF1sGwNDS2prLOt/IZDvuMXno70NExJoYf6jDOonor2ZE4MlxVJ+vQ5IWx4H47vWRm0gLUeC8Qdtdbrr6Fp5Q10NuJairGDu6O/htgA/OP5IdOy73nVGblworMZZ4hcZ0yVnrzU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4503.namprd10.prod.outlook.com (2603:10b6:510:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 13:20:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 13:20:14 +0000
Date: Tue, 1 Jul 2025 14:20:11 +0100
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
Subject: Re: [PATCH v1 28/29] mm/balloon_compaction: "movable_ops" doc updates
Message-ID: <081a3224-10ba-4724-9fce-241cd9caf9d7@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-29-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-29-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0471.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4503:EE_
X-MS-Office365-Filtering-Correlation-Id: 33005198-db7b-4e9a-b5c1-08ddb8a203e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tpYKuGwPP1V5LM8DfsRl+KH9K/PRgrWR25SjXYLWKfbN5kNFSQ0GVt1qrOqX?=
 =?us-ascii?Q?tdo/fvKMM34NS/FjOxON0nAudMubTs8rf7d81NwjJgCRbRdp9Tt4B0PqBdL5?=
 =?us-ascii?Q?ZSsxhz3AykhUqGz9Wl4f9CI9w/0CUYUA0g/2u7/TxBjhvoNrmSI7KeYrdwYt?=
 =?us-ascii?Q?FC07SoDmLOiQABBFfMw8dAjZFvqrLC/wsUOf10bnanTOYSwg5PGZVK0Tnmb+?=
 =?us-ascii?Q?kMcNXuIclbdgqlvZkdRUt1rjeHvMnJDWM2YY0B06Il3qDmXojnRS/NDyHfzS?=
 =?us-ascii?Q?1bRLueK3SBRsqB4UEDR7PgEHy7Y5Hd9gNovV5gYmxMd9dTpANfH03nm5j3aJ?=
 =?us-ascii?Q?Kl0ZFQryKzlEXC+ojMByeAv0rsyrOpdH0Pz4dpNgMNpqtUQfdSMqzqvYdfST?=
 =?us-ascii?Q?FND4lkqXOaKseRfRxlH23N0GmYidsswWwwIim3gPue+7uutUr4Flx/uUSmmh?=
 =?us-ascii?Q?bSOWKmCxsjKDytyIiOtbEoL0n7jBpXMDH4b3JIxC7vqE0n/sFUi7GJwAixW/?=
 =?us-ascii?Q?7ITjeKkUHUqzGyUdzg8a8aHK05nXUpDpk0HSLFa0IHQiWPV+jO4ZaakZ3Lwc?=
 =?us-ascii?Q?miImFHQBdOeL4y64aWMmDR1mOju41xdJvdqRcgEiJJNsZ7K7UKrBa10eLo5D?=
 =?us-ascii?Q?lVthL650/Xqq0mrvwYY5k6kZTPWrv4lRnwAF25yfnX+SYJoUhey3pAM8i7Ww?=
 =?us-ascii?Q?0wD8eYWKygOIzrxzY0lkkn2CfDD8imLqyjcz63SV7AYm90QBhkWzD5oLU5DB?=
 =?us-ascii?Q?2Xs6jM4Tju/AqgFecjmE44JSEwkOOmuZ4L7miGMWCBfiZcbhqJI+8VOb+AeC?=
 =?us-ascii?Q?vUJrvAcd76isSx2Y0uy+PnHvaX7iAEIgMgFujl/770GYNyNvc9wlgMVX+Bae?=
 =?us-ascii?Q?peb0ZCQUV9r8XkjAc/derr4oOlOdKw1PmY8TgtpmAUgpswDsYMdhJPyD7KiA?=
 =?us-ascii?Q?Tlmrb4nSRhtvyECQke0MbJlZ2AqfMRSOIRZk4DGshpJSHnirUICZ399c7eSk?=
 =?us-ascii?Q?sBakaGawY1rDOudGJdvyAJ46GaLkMu3jWYlxIQihz/NtYxTtre1jhULcx8T2?=
 =?us-ascii?Q?sCcunAToyrUgTH5brxg9CobeQ1FAkbHpq5kI7b4KzUym8uzPv2PAEswYUy8i?=
 =?us-ascii?Q?PorkZfxAv8SmHU3qh3rUy/FZRctocvdUUubaVSmVGwlizRWVjZfjljAk29w8?=
 =?us-ascii?Q?pys8Jbg17PXAZqY735xkEyV4vD4ZDmMp6Kw1TK0fv6KKbm2yKYlRj4XW2458?=
 =?us-ascii?Q?cTB9VfVmBw4bzA2AqAt+9yZw65X2g274GyNum/ALIFy4LsTZHlBLuMfD6K+j?=
 =?us-ascii?Q?G+6l96C0ZhS4Nvp/F4/RLWF5oHuhMdD4Wz5u4bRUIKpKb3FLhcO2U1JfuEPQ?=
 =?us-ascii?Q?73KWhYaC1HsRFcTA07YjN9WwDZmOQ8F2Hg9209QJ/F++YUFuQqqbufu7jFpD?=
 =?us-ascii?Q?2WY/SN4qqVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WsdcLf+aOov5N3zlos8DtyGRexzT2uxwfybI4U7FMBotg+c2JHUZMOLi4Wlj?=
 =?us-ascii?Q?+QdhI+vKCFuXP2uxxu04QvK3K9WXVMw+8ovDmcrsWFwS4KAE1E3O7dWT8CVw?=
 =?us-ascii?Q?kK8QMrnr5Xu4e+Zqu68frLPnMHGUyRw4cU+b4eh1GB1N0lipdY1diM9dm3S7?=
 =?us-ascii?Q?c769q703ugAUilb/oe2CzxF8hARUYapkA9FjmSuvnYUcFD6b4TOqJLFd95S2?=
 =?us-ascii?Q?btNddNQuHWWWZKHvtYv0AgKGYgvlwzaeX3bgwAJKY/2pqEX2iT+y7r0ShZEw?=
 =?us-ascii?Q?M/8b59e3gcvDFQECpiXLTT26KNy/fXmMxV64qx1QcW9VFCAHpBmZsPEd+sHp?=
 =?us-ascii?Q?ReFaupt59KGNRgBl+B4Ux/g9JA1VZ6Btrq4Sb+G/z28lCdeRD+rQczdabFr+?=
 =?us-ascii?Q?h2XAuhBQPKgNaZ+Qgdma0SfuzzHdydbXz/pewKU2qqtlY/GuoK5jEMpxdtV0?=
 =?us-ascii?Q?mVr0/oMpOaqb6ruD0z6Iv9qB77iAjkcTswOcNK0Yl2AAZm3DdGOA/mYeSxfZ?=
 =?us-ascii?Q?bo3+lnVFnvxhChmT9BEpqDnyFqa6SWW6a8nvSET+fNiyp9sYVWMS9mgGjVun?=
 =?us-ascii?Q?iYUxgGfKRIWs+w5IVFEw+VOhROgSqJRSTsJafMxxma1M2RxXJceLXNGwtJXw?=
 =?us-ascii?Q?T/4e8DSQMEjYEOVqNN4PVHRZtDb2VIu3dogn+KTjuKXimf3gVE4VrqIoA1HX?=
 =?us-ascii?Q?uPy6CduK4iC1tCn9eUNsn5PndrYIGfAWnXzCMFMxEqOGmtOgDjAY35c/Y5XR?=
 =?us-ascii?Q?ON/sR0CMb7rm+QgLNvBhkZLKWQ1d0dt8Wr2LN62dmtpYSAu3WMGSmNruFr4C?=
 =?us-ascii?Q?x6Ga2XLbBnBB1PEXjb24qa/YZXwfl9e3puwx+Potb8EahZK6r/1cJfvsZgqa?=
 =?us-ascii?Q?MgBIxDIl8HmrsKySzhwVjTVi5Jlsxm/5rF9+umn4UtWz8xqnwTkU0VLxzQuW?=
 =?us-ascii?Q?XBLYojk1gQJblXL/Hb1QqDqh0e/7ZrEwEgXz+TfM/IiG0T2DFL+ZzxT4BFYw?=
 =?us-ascii?Q?kVsYn8gVO1uElDXNXENW/gFT9210S0EUByTQMxG44yrYy8KsS7BlgozJJinm?=
 =?us-ascii?Q?0vQWp/GHnUeevURbhuoYa+Z9ilUHi6Dfe/NxqOn9I2ldX3uOs4QrgE56yE60?=
 =?us-ascii?Q?nzTDjfq2IXpgaFGbJAuw9MWvUu2uIeqMYD9kYck5D3DcBZTJTA81fVZ4Cp3t?=
 =?us-ascii?Q?UieZC2x92NazRwLKjgU3W8xAElb6VUToJCuubKl2ujPda6UBl0ZRlAdO6Mho?=
 =?us-ascii?Q?RdaIqXzNaTo2F0BkX6U2S+kb9MAGKSwyaG2T9DznMr/AwFiyCGG6Gi6i+6fA?=
 =?us-ascii?Q?RSgfcVqDKjA7+bVAc1ltZAoVb7L+QTdQ+K6kyVxhGXzMgheTHBxTwJCHlaxS?=
 =?us-ascii?Q?wXH9XQuE0Xxi9QqkEbEmyvJzm/SAKGmw2CeixHugqOMsXLgSDpdlI3xv/08K?=
 =?us-ascii?Q?eYuhFrHkQ8FY0US4gIh1cJsjkYuw1CBHMFzqSYiC+PY6WayXAlIKhheYaPKj?=
 =?us-ascii?Q?+Z16AQ8b1yGrW9xmF8F/aPxxfqn8PciXSQV0CjiqnZwpwmlIIcAYvKoCG6VR?=
 =?us-ascii?Q?3HhBxTZ1v+9VNTIEeONoY7LjX2D/0Jhm+gDLkXwdbI9x1q5WO2vkFSHaenis?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nj5CnrxAn0DWTPyRq0OWThJLTGCyxtJjOezbNRlmYEHyIZh1wmJQJv/KCD6a3/9L8rcYIDfIEimjcxA2coupsQ/1M0rdsZ2+atekFcmJaIg6sRhGkRaj3y7HQ9iIRFaJeJxuHFju4Ys6AWPo8zgU6UVAnzcAoQF5TH1Oxe69FX7zxadr6cFgvd1tO+nj/xjvWzFR8nElLmwsoDO2MKabunug81LIk/iF2MeJa3Psgra4YstEMt8u4hUn7afcIlNZnl2mKu4uJqiXLwa+PycFzsNGlWdLESSwPcW3DWklZWhj0mtA2KAgl1s59+z4dFxyLR/XIJ+DsCnVdp7uDyZKItbJqgon6sk4SI3Hu/sPb7pjpozXAec/cSmmE0RBCi7roedOIdb+tQDc2PLgSoPBEi+Ow0CI1zLwq1ZqtPTHFZvN1K9xC2++aTj2JvT8o6J4GgkaHueZuCiKQl0NbUbu34mNxCmbB/7IqIkyKY0vQw2orkFVyMagDlosJ3Fa8yqmhGrOWA/P2nBzIScoXCX7yhAWT6bOxv/WLKHi28TgjUCYOAAO/ahFZ3YUq6Rj8CRC/gucEU9zMcLY11hgcec5rKsUf4HDPo74fasgwWgjOb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33005198-db7b-4e9a-b5c1-08ddb8a203e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:20:14.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPNEgjTmMqSfQJNG1weZR5QyA5YYZaGlOM2q++f7hRNmgUNIj7n5EqVa6vNmad8Kgc5k0FmFJTsWk31k9a8Ak042xUNLDQA0cfqwW4fLuEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010085
X-Proofpoint-ORIG-GUID: -910kkpZjgdssxdTEFn-NhLMWOhHZHFl
X-Proofpoint-GUID: -910kkpZjgdssxdTEFn-NhLMWOhHZHFl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4NSBTYWx0ZWRfX+ebcIxa0JidT DFjO3mtgsYyXeH+13bUMCRt+0JuBmkw/FWzuI+XDnwtv98SDyAS4oW5IGQe0l2A7XVriMalLE7B DIH9Md9KzhTGMryNCveQERsr3WE9zd8ozpoisyvLlZJxn4KePx2f4WuU8AVv6SEf7ZW1672zU32
 oKIvap4mQmU8+g0khfBkQxdel1jYMlt6j6eptEwFB3eW0aixJ3UZuBGtZak66zurbky9kPxtZ2N V9FIixg3TqDT/ONBxUviwZ3EiW2583dNThGX77I0hgtoaXMFvMPrjz9ZRehfHFewxI/DCuKFGMy Xam3oK4BiIq2ef8n0qAXbPdU3YimVzLjLdzsdyCGxsROjGEbDJLMvZkxVBGaa7w470AQowNZWkk
 1M5wMl8H8h9TCxyEDz4zp5r3hdZSB8N5yr0mHNUn9PZb436DFRXmekZtslDuR/kWxAWcvCWW
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6863e094 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=d4wigfJbxjXV7BH2aqEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723

On Mon, Jun 30, 2025 at 03:00:09PM +0200, David Hildenbrand wrote:
> Let's bring the docs up-to-date. Setting PG_movable_ops + page->private
> very likely still requires to be performed under documented locks:
> it's complicated.
>
> We will rework this in the future, as we will try avoiding using the
> page lock.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/balloon_compaction.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index b222b0737c466..2fecfead91d26 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -4,12 +4,13 @@
>   *
>   * Common interface definitions for making balloon pages movable by compaction.
>   *
> - * Balloon page migration makes use of the general non-lru movable page
> + * Balloon page migration makes use of the general "movable_ops page migration"
>   * feature.
>   *
>   * page->private is used to reference the responsible balloon device.
> - * page->mapping is used in context of non-lru page migration to reference
> - * the address space operations for page isolation/migration/compaction.
> + * That these pages have movable_ops, and which movable_ops apply,
> + * is derived from the page type (PageOffline()) combined with the
> + * PG_movable_ops flag (PageMovableOps()).
>   *
>   * As the page isolation scanning step a compaction thread does is a lockless
>   * procedure (from a page standpoint), it might bring some racy situations while
> @@ -17,12 +18,10 @@
>   * and safely perform balloon's page compaction and migration we must, always,
>   * ensure following these simple rules:
>   *
> - *   i. when updating a balloon's page ->mapping element, strictly do it under
> - *      the following lock order, independently of the far superior
> - *      locking scheme (lru_lock, balloon_lock):
> + *   i. Setting the PG_movable_ops flag and page->private with the following
> + *	lock order
>   *	    +-page_lock(page);
>   *	      +--spin_lock_irq(&b_dev_info->pages_lock);
> - *	            ... page->mapping updates here ...
>   *
>   *  ii. isolation or dequeueing procedure must remove the page from balloon
>   *      device page list under b_dev_info->pages_lock.
> --
> 2.49.0
>

