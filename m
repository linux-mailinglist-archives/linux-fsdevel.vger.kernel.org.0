Return-Path: <linux-fsdevel+bounces-53631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 781F4AF14AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0088A1C41E1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C7026F44F;
	Wed,  2 Jul 2025 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ojiknCmK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X7hjiADG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325CA26C3B8;
	Wed,  2 Jul 2025 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457360; cv=fail; b=n+77HIt8sjMMbZy42U1B45g5i88IyicE8O0T7oyx284VqxwbCv3YcPLWrhsoRSUqVREHKnKHArzZwJT9QtmPKaKo0ugbObbNLhZdDOLoS3BpqD57bEhp3py77Scq0WLODB+htqbzLiHQVQCg8OFeX0dyeRBXAOBv88GnWpPi2gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457360; c=relaxed/simple;
	bh=0d6FnX61kRTA6ujKoxR/b6cNWSKPOR3P6EhHieQWfko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QYBqWrO6ZbIgy3gYhr6geimfcLhjSi0uaAHByYcGp52N9L/D37944u6fR389mS9gRFQjgdW0omYGB4V6ubOmBJfLOOOq0Y47nXeQvyNEcEri3gtOxgQ/JjboJp3XnVx0YOTATGbHPCDMAcBs/hBIp/4a/YbZpL7CSpSkHUXt3Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ojiknCmK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X7hjiADG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BiSOr003478;
	Wed, 2 Jul 2025 11:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mg+q+bGezWvrbDdyuV
	x9GpP6t7gMTKzdWPW/9lrEKVQ=; b=ojiknCmKgpPySwSIX5sZr9CzHbRIIml626
	KEX0vPkbSViImyWIoRsTVExjaY4FsXqYPSFJlxY/v46j7i+EnhWc/lLCfzqErnRr
	m79OqAfops10M47xu7UNBQRV4Lk6N9igB0WAGq8abE0+rvVl/5VQSz4bwIy7w3c0
	khHC0hOmIjbwE/YCqw2gR5qVcqusSulDJYZekBbsLbPhNolIOghdoWPLhzW25oZN
	4oSmcPfMI7aiLctUVudHLssTAuWZNEKq3vRjey8G7Xv/eDOjY1i/pAdwHDRBqL1y
	ENC09rbcMiffjC4HKIQlPKkqMkBo/SGNUYLkb75H4UgH0mIgBkPw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af6rkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 11:54:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562ANb57019367;
	Wed, 2 Jul 2025 11:54:32 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1fvd32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 11:54:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B16oxkBKG/bxtTz7ZYGsZHAlhEk5/0t5I5fuiEnf0TqnBTBlVXM8Trgj8oyIOq/VBNKsQ2eg0meOTou2C8Av3gB9SNii8dKIRCJmQtrQMM19KM7pFXUbKYu2k2qesEesbx9xwSUGxqMi/0Sq/KuPdiamIYZZG8hepausGqSHa/dWwkuceZ2oIPXAhdegBD80jMmoK5t1kPV8YCQw+R21dylT8xb2iwRjSPNiGySkLVh3ZnXI0cltYYwBYlSglYvSwuL6skrCTmvOiAf+Ouuy2oIFjGApWrsmFsDt4N16yXoGJPoQUFzVAeXkq3Gpqojzzr15deVcQPEx+VZNRWgQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg+q+bGezWvrbDdyuVx9GpP6t7gMTKzdWPW/9lrEKVQ=;
 b=PNu9ewnu8U6tzQkBIeAXZTkg9LsSIhIagOvhYy8x0p4k4eEJhSRKIs9RRZ7VQbud2XbABAP2ijlbygNlVUbGCHgp/Xyy0MT76J0yA57AjhE3cW2Su5bNDWEVPyGMw9ZhpuNpwThnEdJCwoTxTuRlhxz/WlvSzx0T9Kti1GYcqDYs+hVFzXTpYdj3GnCm0mh90AcBLyK6zYB7Xto4Dd5VC/bzlrkl/GJlV69kFZHtzjMTvM7WCthAakdytHNBStRWyECzD2ajWqWsC+8MAs4JCpIHoN9yPd7CYkk4EM0TLTmj5BJ4JSSTRMs6PfcXwGmXSNCNQmKUtszU+9jpBdlq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg+q+bGezWvrbDdyuVx9GpP6t7gMTKzdWPW/9lrEKVQ=;
 b=X7hjiADGtvWHQWRLHtERwOBQSkoFWSeZLE9i/XYUu8SM6kFC8ljRCAj40q3D+BnkArAyBv8u7Fpepsz3J/7EFs4cNYb/MCW4mowafZ2YmAxXU6V+VYIZKa7v38Qgt1vaIp5Xp6kP1Ao+O4a6d6lFHMv/XIEDz2f10rRRyGfE+0s=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5033.namprd10.prod.outlook.com (2603:10b6:610:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 11:54:27 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 11:54:27 +0000
Date: Wed, 2 Jul 2025 20:54:07 +0900
From: Harry Yoo <harry.yoo@oracle.com>
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
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 20/29] mm: convert "movable" flag in page->mapping to
 a page flag
Message-ID: <aGUd34v-4S7eXojo@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-21-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-21-david@redhat.com>
X-ClientProxiedBy: SL2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::23) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 561088c7-7c57-489f-ce19-08ddb95f321b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jY9yp3an0fDKg7QDkvriSHFFlrpOdVV/g7jHSP71IaSCugR0pZ2mnk63Ccfw?=
 =?us-ascii?Q?/wc37x6UnV/YPiyQaVJjEb75yZogD6kxVjnuu4eYDjNxSOVI6VKIcv32EHKb?=
 =?us-ascii?Q?TgDx00MUO91YMz9QYk2XWd521VEPFMVXp3Pl7uSyqzf5sxhMiPp/h2CNYXTK?=
 =?us-ascii?Q?x2+SKSqNZQMdPP3ugH3BM/UjDPGevDlnKDqD5dOeBzTRRckOGUtsQBKR3q1T?=
 =?us-ascii?Q?DZG4uzI4pLoW8ATpCr4rgPyTztDaUO8NwU9Qw8Wn8+MIRjCHDxkx6XWsfXgY?=
 =?us-ascii?Q?BCF+NnqpxRUoyMG/b42giVFAr77HUX3Lr65l3plrqVohurnVkvlf53z1c2/a?=
 =?us-ascii?Q?66jJOO0ZSwu9H2w7GaLSIDSua5Ph6hMGuSxJYVgWMGkpV8wmryRKskVTKSKm?=
 =?us-ascii?Q?zG4J0YilKxW2Cym3XFmernEAyFQQe01iNc9dpJ5Jg5qbwjQ76dk7220WCQq4?=
 =?us-ascii?Q?CUplFiPYntb3atHTrDhWkM3CnlAIx4LhPyHd1sjrzTa607ZUQ506Ksf0iuaz?=
 =?us-ascii?Q?h8MzF/NUFn4UmLBI6ZVGybJHvp94pwfCQsfCl4Thmc0Bj4Op4oqIOSduMTWT?=
 =?us-ascii?Q?lpMLsSpwGAcfN08xDSO0xB0quL3xDzWSxMbfaHwY33nB45fWRsnHte/coixl?=
 =?us-ascii?Q?SllSCPfjbljk096IvVaf6Yg8t/b0sYGvRCGDYEGbJE81mIOUY/++uFd4cRS1?=
 =?us-ascii?Q?0KYvrrvxJTnuHS/PgO7xuQCCKDdzWXCmU409PYN9mlSwPxVmUK7oC1agppPo?=
 =?us-ascii?Q?TMQsUZFusXHV3/2nlqWUCF3D+s3DzTLI56Rqv+Eq9dIYZwtbjPfbxphon/0L?=
 =?us-ascii?Q?XKgArN5ywlN3BWt24ddz9azN1Oyg9x5dkJGMiH/nx9h/Q3uGCffw1AOUS91P?=
 =?us-ascii?Q?zsx4Dn9XZ236GW1TPy1TgVyti+qCHDI9cIITU56/JzsiuIZGYKgbIxyS/kv7?=
 =?us-ascii?Q?cw9uRgkmSuVDbpyPUWVk9rH5LrsbpvRG3aAzRSwj8+2uM/qVOCEhwM2uYf31?=
 =?us-ascii?Q?kfCAfsf/K8MgTG+jX8x6/kHu1Ien+0u6gj/R45LKWZGmjpLIt5MUZeuotpbd?=
 =?us-ascii?Q?w9yLBXmcaBDfgliaLvyU8hWaFxavaQ25B6n2rgdphrDUsNRRPpO25mQXx3b/?=
 =?us-ascii?Q?c/CnbNX10fsuqG+eaGpSPF7qK45sAWddvidTbWsYfa/v44YJ9WsHKHa2E6DJ?=
 =?us-ascii?Q?9+Dg54v0lqGT5bMr8nG2MqtBMt5u+bCNI1+9JjOhEtWRzag00GeO2Ron0d08?=
 =?us-ascii?Q?0rUIPW+rUdmrqa3wsWTOaZo4s+aBRbLcYuR1p35WcaIBygHK/vUjBJ4Dz8LY?=
 =?us-ascii?Q?t6qqvdJxT7G4ZJ6VO7Mu1BL6cnwswsVdhMT1sANVrUC8lZV9/IK/933IRiTx?=
 =?us-ascii?Q?o1IGmtRBdOYjrSR9USbH+v9Si0JKkYRkhZOnHMlkAAnG/Tm5uX00i7KcDHy1?=
 =?us-ascii?Q?Kv11lWMxi50=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XFJMjucaIWFwRRxW5dze9bIt6NIkygrviGlSmVPUmsCoiRf0HpEdDprbLntx?=
 =?us-ascii?Q?A3378wQamC1Uw70CAGgBzy3GJ4QsUfXxv2IkkjsPqP0AFYXGx1j2qy8FrGQg?=
 =?us-ascii?Q?1sIxj5HYA8Tpdpw2tORNrnKwPOheqsiL+Ur1uIwwwL51iAmDwLfKUW17eTfz?=
 =?us-ascii?Q?mwYW4m8y17EPhYNdMXAGfeMYmMsv4rqajfPrewGN9L5JFiVtOhYFfUdTyMS/?=
 =?us-ascii?Q?qvYHaHlTMwKWivVxEgr1u1XfDWRJVZwv0RNDUSI33hi6qyPTCGqvm2qd+o0p?=
 =?us-ascii?Q?+JZFnZZHkUZnDTMejyxSM8TlDQnlxycPi36lImeMyOYjGg8R/ftkb1v3DKZ5?=
 =?us-ascii?Q?rgFB5BAtd1v5BEe8IPX49nImgcdGH7pYLDkkBrpXc1/rN2DId8+Og+ObtCJ7?=
 =?us-ascii?Q?jwa5c5bf4DiaNoP8qLDT0et2aDonn/uK9G5rd2kDs8UdBiAZHpj9ryL9j+0U?=
 =?us-ascii?Q?YlBFHLo/n0vWaZe+Yn60eYq0RRFSqwsiLJoYVfJ/YKzaA1asN4+sE+Z1MWvn?=
 =?us-ascii?Q?veuN3aPs4e8kKN/rDvXLSi9kqT3YYbbeurc16vOWpdXaRWNXJFwn0Pbh7WZx?=
 =?us-ascii?Q?wpTgDdNnefwlLKQQTau1ynEPlaV1pdZUzmouhlszRhcHIpPVVJawlDg7NJpj?=
 =?us-ascii?Q?pNgxWSwlEnraSldu3nHU8oClPZ7yrl3rkNdD22hsdylY2+zL0Mk0nLMnsCQc?=
 =?us-ascii?Q?yFjO5ZTk4zROjJ+Da+2zIoCDUtwHrHt3DAMSceiJVhoTYeC12I/YhT4Pi/7g?=
 =?us-ascii?Q?hWmA6tmo21QrXPBnSjFwjhLwTuMmSMLCe+/IbCLy5HrxYBXWB0D6DaFVVVYV?=
 =?us-ascii?Q?aVtL0cmK3wW15p5kzG/O0VZyXvk5P/6JGHt7D4t6HamDgm4PRRKWlRE15UCk?=
 =?us-ascii?Q?EAy6l5ehkCclAgUu1buM2LzYArv7+BopS+ZfGPdrOcZlR2D2eEn8vRAA05P4?=
 =?us-ascii?Q?tSy/RNADnzwwT2KEh7dfrhmWQhz56nD7MriIhsaFHQ3COKXbsfF9oY9GMAyQ?=
 =?us-ascii?Q?wifGTPPocHoch/OyVDtEiiYWC6RokuYrKvndloUwp4IPlw69PB53fM6uIj/k?=
 =?us-ascii?Q?246OqCiKoDIaljqIHOLHish1+I7nfXkWLXjxbvTgJPhXeBA/HRQPrMQaSmpK?=
 =?us-ascii?Q?DG+B7tH86npnDmyWdwtF3L6aJxImRPysXJfXtAvUoD5yRZ9PM1BO9LJCvfYa?=
 =?us-ascii?Q?K7hO8RVkKDOLlpQFT3PDrHk4sOW+tr9bO1oI5x9ddqw+SVEiQoQpyOVoinbK?=
 =?us-ascii?Q?a0oSUxm5NYFabGLsO0d1048wHxb29uyej5cnhumQIyYHIWx2VoSw/qBxEwDv?=
 =?us-ascii?Q?8wFz6LkSW10iq3/F/96S4EInAm0XbBWs590I+OgFivdmNJkkzF5Db6dn9i2o?=
 =?us-ascii?Q?xyyH4TedKCNCC2L0yA7QReGOwHnS3ViDu+Rh4KVBAxSTJtVVZS9YVg2aaLKN?=
 =?us-ascii?Q?EWnfyWkWMz/UNw/USLlASZRzyEVbJ5CiOhmVkh4hZbOfAQ8K7IydByOc0REE?=
 =?us-ascii?Q?0ljHwR/croYzudHfQ9BzXmX/27k61oQb3XOzeu7no7+96cbroxLqUUdOh/XG?=
 =?us-ascii?Q?ugBRKK0qfk62Wku2rqdQzdtBgSlXL4AU/TtuBNds?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KTNnOf+LSH2wB0ct3h4EsMjn8nygQOvAzeRJ1WPxryYh7hKMJuZCJ9icT9DV4ZnQ57+x9JSGNDLfhgR4W/RlXiQqZ01JNSvWbnG++Sp7j8runchWxATSnJC5Hg9nXZa8TRyWHs8hHeOm3bGc6r1dgSx13GN+Fna2LbMk+JthNjgQnz+heAWyFgXcdCNhcFzzdUGjR6964HToU78YweDzzpnEPObaOjHoSGbOQJxQ7BGYN2y3Q4DGsSySKZmnBE4prwna8DG61gIUz0zl+MxnJe6B1kscrOCFxT83uNzhqbL/KWKzEerasrF7MAWBvOobG5PXPKAQli5T79SdZHvd7nf4YGhZNQNe3Ps2eDrWeqA0YAwz1QQC2IyfUqFlu89mU/qw9zpgZvNdE7axzzrEJO4Dw/isXX35Z9iAXeL0ERf0PKGcUyoZqOPnvpDObXRGP5Z2RDtXXUFt7isz74qwiO1gUTg5iAWKkuZLzXvGWZzr1PZOu+m8CqiJ4zTvoAoP6VTJJ7m0Ms2Hzfr2DldwwRDI8LctHKwMNhNk9o9QysFHN/4Vah+sLKL18vYNrECAkZaV1agdlDVaKBnDSEfpSNpJIwLq3FGZRc0LpgmrgPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561088c7-7c57-489f-ce19-08ddb95f321b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 11:54:27.2873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HR12Ug1M/jEEYh/T1N6rT55SJ6eElJftJUEeB0jo6UdenYl70kfxlSnUV5lzkDJDRsxEWJE3xOKFA6lA6bkMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020096
X-Proofpoint-ORIG-GUID: Y9aRLt-NS7Wz1W22_1iQ9F93KExKh-T8
X-Proofpoint-GUID: Y9aRLt-NS7Wz1W22_1iQ9F93KExKh-T8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5NiBTYWx0ZWRfX5sFvYJs8atOx Ynl7hvpse67zM6Ru7dYz1qw3Vuo5ZKuWrLIM37JJYQT1KMz0Wwk/9Dno+p73Hji49dmerbrcg8v I2QWlq/rVrdyA4IZdHySEVtcgXU6EyVxipBLoUQyKwo3YdBSbNZyJvFVKuBQZd59GsORhU0YmDl
 Xf6BGCSe/T+DOR6+S7OpQP7NUSTYctfN5b5T8hZxtUhDIadcWza8Qk49/emOpPyC3GS4XHNS3rX a2oYlzzY8rKXbTMJ57cVUseNuHTGnsPp4XsebfMiZMvEQTSMBvf2cGyUzrd8aocqwk9M6+rm/yM Zq2HgT0UL6g3VYHATzW0iq/53PBFTBTyPe9KdMEmZGr0yvsP8xkJ6s4Mk7r50WjFiJKwKdxVY82
 0L+jQZsgKv7tDo1SROePLp2S7dmvY3s0MTtsiRtvY4zTYsz+QWqxt8V0OXeePIc04nhnfSDi
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=68651dfa b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=VIiMzlZ2Hg5jsPdX__QA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216

On Mon, Jun 30, 2025 at 03:00:01PM +0200, David Hildenbrand wrote:
> Instead, let's use a page flag. As the page flag can result in
> false-positives, glue it to the page types for which we
> support/implement movable_ops page migration.
> 
> The flag reused by PageMovableOps() might be sued by other pages, so
> warning in case it is set in page_has_movable_ops() might result in
> false-positive warnings.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

LGTM,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

With a question: is there any reason to change the page flag
operations to use atomic bit ops? (.e.g, using SetPageMovableOps instead
of __SetPageMovableOps)

-- 
Cheers,
Harry / Hyeonggon

