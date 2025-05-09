Return-Path: <linux-fsdevel+bounces-48567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0899CAB10E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D001C03BE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6728EA67;
	Fri,  9 May 2025 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PHLZDetH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HBewLQiU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612028ECDA;
	Fri,  9 May 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787149; cv=fail; b=V9+9IAQnyh9ls1u50a1fhYnCcXD5mRmoWprVACQizVir6n8UA5S7unilH1u77DZPYk+fuIHfh4kf9MvdNstnCj/CCQfix+iXb5+FoAfqfXGng8LMsazYxbFvkersJ5o94mOZy0Bh/ngQxaYmq6AskM/JL6oiAor90L9yCDlJKpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787149; c=relaxed/simple;
	bh=xyEIM/EeV7bh+1WTxRLbACzjMc0YU43izsmgXypsxnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZEYNjKKVmwObAvwvoOph1K9RY4WWkk/37BQDEGzzngJVHCBfjBwvaoK4Kfznd2Cguvd5dd5FffuqF2cG8WkVYz+aFi67vwV3m4iDWD8LP0dBhp8id6k+NAX+YMuUrokAxHGThWHQrzS7UAn+SpwgE+e6Av+yocLT9zKuzgoAwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PHLZDetH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HBewLQiU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549ANGVH012557;
	Fri, 9 May 2025 10:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DCUrgkNBiawBJCkydL
	K6ZCqSDoi9E0eSnOwfAwqoQQU=; b=PHLZDetH8/7JOuEZ8OOVBQ+xv4hC2s4gTk
	hvdjHcW3RVC7J4ubUP94MBNSuNm0DOJSD5XZ499ARbdvxOzYTzGII70wG+oRZwJ5
	FB+c3UYTA3+rz+29+gKcxA2JF/lIXoxP0IG6KXTBQpGv9ebJfUAaFzXzggcHbtVt
	6g3jzvXZOQdvpAgBk7SV8JCIzPmNtnFL621pzkuIL9pDyAmNi3VYTg4OPJKKHa5z
	KnCZkf0QjRgUv1qTJiZz+rBQ2zgBg6qz+loOV2XyjIYiEfWdf+ZfLreh10sw25EF
	v7wD8uHVArUpuv9+gg7WwgCkV9Onjt+pFg5IDG+5kALhsDcUxCRg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hfvw013v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 10:38:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549AKJfU036209;
	Fri, 9 May 2025 10:38:49 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011025.outbound.protection.outlook.com [40.93.12.25])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kdkc31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 10:38:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGttBMi3UehVOHMrQgIYDAw/ry073tkyO6+w+Vtj/lo/1e9e/+6n6nqVfeWn9/YaSoH2VEBZ5oumSXMoGzz8YyTcXU49oKald/ZAEgH33S2THjRl1hf+q45yu4Zu8Dxeb2INL75TzWFOFTj+xBgGthIkUp9j6AzAzvQDbd9JAN8fPqcSqx335E+0o0IrZQNKIi3VTb2IAAg6CKfq623kLI2E4LnSHo7t+ossi6ow5WdI4wnJ770yOtdFaqZ4PC/7vf9YW89tzsLhaEn5JucDuxjerx04CTbek7KxXsZRLGRolfwoBf0qDfbJZDI15fLoXBLHdzgVJgy7Z3ECECr3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCUrgkNBiawBJCkydLK6ZCqSDoi9E0eSnOwfAwqoQQU=;
 b=wygIJv3i9phOXskc0RVvVYv86s+I3KI6pZxbkAZ6hAqkFJVTIFLulA3BGa9Zwvl5CLprQy/tlfw1abboKQKATgBqnbwKb7/oE7qrgLqHw7gSKji3mfAA5yJuHvma8UkR528sbIV4jyKkk2wXzGjsMBP9nvJtaXmEI0/R4wjf1zdENpAWBnZ5w7OTnLIzniMprdhvLY0NRI8dWHpXxWhOtCURroZBfSf4e8sNdbDCn8upEJixPBUnl3Y7IM8ZWIdOY8yMuaNdyi168UnqU3pSrPCW/C9+OWhNyuTqr2iQPHm8mZrfanOKzzb9rBwRztTW9EYyHVvP38mey5yQNRXI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCUrgkNBiawBJCkydLK6ZCqSDoi9E0eSnOwfAwqoQQU=;
 b=HBewLQiUqGT1gr2VLM2JFd0ESOEgNBDxZwlfFKIM+sDvqrgY6K2mrsC76oZq4DhH44UGNFC5++4+KAUccbiV5uL85gqCnUkQ85QDQKl7EhkD9AYYMpHd/bkn0Lfu4REk9JRsOlT1+vp2NB8+uonA0EI+bYV8ZKMTSkarHnIelKE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF6ABE13187.namprd10.prod.outlook.com (2603:10b6:f:fc00::d24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.36; Fri, 9 May
 2025 10:38:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 10:38:46 +0000
Date: Fri, 9 May 2025 11:38:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/3] mm: secretmem: convert to .mmap_prepare() hook
Message-ID: <dcf6fec6-a4ee-4ac9-9796-c5fd89e51228@lucifer.local>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
 <a196a08a52039ee159c8333d0c6547e78112acb7.1746615512.git.lorenzo.stoakes@oracle.com>
 <708b6b1b-54a0-43b8-b6ec-a2dbb089d432@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <708b6b1b-54a0-43b8-b6ec-a2dbb089d432@redhat.com>
X-ClientProxiedBy: LO2P265CA0167.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF6ABE13187:EE_
X-MS-Office365-Filtering-Correlation-Id: 648b4b73-e83b-438c-432a-08dd8ee5ad23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qXvFS/qhlXUIHstc8OWRKJw5xA7uWBUfBv9hyNk9cGmo95/2Awfew0d3/ipa?=
 =?us-ascii?Q?SPvUqRqrdoPCXoiT5tQktIlMP3ToI1Ay21o5JtbWBVoHa8I1cMo6UaiSrDNK?=
 =?us-ascii?Q?UFXBkoqUgFRC3Se/d4jajnS2gvbpEyGO6Nl6d2xHjTCgoQc15aP1lbS8yEZ2?=
 =?us-ascii?Q?99IteB3fykOR4+Vk3Pdz7lX0IrwwEEcybDIcEpZym4PaJ+RW7oqSeYT9xdVq?=
 =?us-ascii?Q?JZHnyBa5KCQ7vo/2fBqaA/3QvFX1MTzwuggj76oZnDYlhlhfopSBfqXheKpS?=
 =?us-ascii?Q?TOSbxJnGik04wdD/jyWtca90KLMsq+R4kQsIlsgNdoW1gBYp7ZJp1gJTLKR0?=
 =?us-ascii?Q?wth5XrBM6Cfm0ZBJTvf7va0sbBXHhqTrsLOuqsO2/75gENXi9ZCVuc15qIsg?=
 =?us-ascii?Q?Am3Dhju7KX1bV9uJIK30wLgvoE9lSsuKOEfd/vksY9gjX7n3y6aIDX/KYSF9?=
 =?us-ascii?Q?YZVZEBcoLL4efG6oVrO8+G9L5Bp/jB5kVmqnGKiYi1mcoUw+7lL9D6WKbBxn?=
 =?us-ascii?Q?0IjW/bCcIRwpsBcEVZzGd3y1zi9tYoAod1GHwTbHOmAoTDNo5pFyrvneQB9Q?=
 =?us-ascii?Q?ni2vK1GTXC149AobALlRwe3S4Hd4VQu1XoEvsJodhiNdL2kCbwu7F9L5A9iQ?=
 =?us-ascii?Q?NliWWq61pa78ojx2Fos9S1hoVLpeesFYMOBvQHIaewL74OzR6xLFVTZD6xFr?=
 =?us-ascii?Q?8nmHOg3iYtkXjrfkWvS8b2ngtUkgiZ5J48sj5xjKXBafK6tL+k4NagEsHnz+?=
 =?us-ascii?Q?tGIFv0NCJw7ox1Qt0z8o1tsyXE9tnvAf229kRt9x/4i8PZKb5m9wECWoNXAw?=
 =?us-ascii?Q?ElzgfLe7gs1jznJOpy6we58ql2W+dBfRvARSxRLKSKeA6Toq8yLGFUGmQVrY?=
 =?us-ascii?Q?JlzE5CNuJnq5hWsdJkFLjQilJAQe3TGwFvfStL11yyvc22vpvMT3fqeHSZ4k?=
 =?us-ascii?Q?V5TUSHbJtOorcCUQCFrXbAq1Twt91OrEOiKnWNRBe6KBvskJeNHKenj0FNNB?=
 =?us-ascii?Q?3UNQ7jwLpbI90APYTsMNHU1pyyLhM1/13IWyio6yP7J3XG9cdkMEDOXIyvIV?=
 =?us-ascii?Q?HV2+qZQPvSpjwaBoKUvu4Aie6dPG19w6O9IhZXQd4vsgb/x2NznUgF0n3Nqq?=
 =?us-ascii?Q?ORKfYOGIaKMahOra7nhjm8UiEE4XnaWbTMc9Hexnym0UNPTCMYxoLD1q1kIi?=
 =?us-ascii?Q?W85CiJ5VxtrvzQDBsvjiQJga3mnT0k8S72zw85rxKMip5Be3pa3yiQ5WEjKT?=
 =?us-ascii?Q?NJHhnptJXBg4hPkkvNXptx5uPIXU0aBdnbhx/9UqP1lUyUJymkr6i4IUvexf?=
 =?us-ascii?Q?2p31ZQpfLxLl5SkOKObOo9K05pfYLOlrW0GatVxyl0cWCd302vG3lZqEZANi?=
 =?us-ascii?Q?lHfKnlJ3FleEBmV5RON1AZj0MiV1brHghAhB7ZKJqKnjr7sHCP+7W/IAIfO5?=
 =?us-ascii?Q?25CvceoTvW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P0lsNxNKX6BVn0KVgXTIS8/TpcisRzgzqUXZJfumQfpED70c5uOjbdl2XLxI?=
 =?us-ascii?Q?uRwV13nK3uv2vlcAimwk4ZT2kcDWQDIhJdcDuPtBIVUDpLu7A3pAL0vdRKuy?=
 =?us-ascii?Q?25dLE2zt2Q6NzYuWUdgnWnNMQMIzYcFZYeS0UUQtDbivsVVLubYAy98nspWA?=
 =?us-ascii?Q?DVT2Wr3MFOzYyUbikVubHHkyTub51/FwZpgDm/iJC49JA3Um+Mmo/p9IwotQ?=
 =?us-ascii?Q?UEDPbA5lYuPA2xI9bR/vdzMDdQ/ORCdYPhLM4eRzqeCyFxDgu+J60ci0ugKa?=
 =?us-ascii?Q?celSCRp/CnfkgNEz6GBwkU8CEPpaJCGMFCIBGvrRLYAU41rIWg4WxYixKmaS?=
 =?us-ascii?Q?WfI6hSVJktkov7Y6oyILA/2ObBCB8b4t8Al4YFpUbOcNEtocFlZ7U/L0zfwl?=
 =?us-ascii?Q?A8Eivca+8ajaTEq5m9BPIHaA7ls94ca0KGzVD2pQ2HRCzJ5gpj64r7AsV5GA?=
 =?us-ascii?Q?X3oelnj8roE1PvXUfTSoAkjnCVAhiuCYUPuInwWVLOWqO9LjtMbhu2wknAKI?=
 =?us-ascii?Q?N0hWWDkggFIJka/kuY1BeSdeMbNYsAcAwsLBUpCIjUQbRemNINlVCcmpeuSc?=
 =?us-ascii?Q?3ZCFtdhKfCg1cTXEAT/Ksn/dASutfu56/Q9Ft/bEfdnGYAMHAKFuxP+s4dwd?=
 =?us-ascii?Q?1kkeiRZSZwIutTnjlknn7ds1kIAqIeLhEBnXVEa7U2fm8fY9KuOfUvukKabc?=
 =?us-ascii?Q?i+hCCZVovt2JXRSxoGoiW0HVi/1tB3QivS9Ja6yWB0judgGK0+3EJUN2QY1y?=
 =?us-ascii?Q?kdkDfKYaIMTlNRk0A6ECDP2IEtysNjUNMHyz1OfKWu3IIf6QG8KdP9A5EFHh?=
 =?us-ascii?Q?EMkwj+SvRJRg2jTHjkIx8YJ86bKWIraX4jdmE0MetBqkbjM/sWSDkiYZ9s6k?=
 =?us-ascii?Q?QN2GvX8bsGkf2Wf93fo53NJTrBJbsVLjkKI9HVSgCbIa57aVvFSbpK3WPhBc?=
 =?us-ascii?Q?zBseNfdV7iJC9xNRxdT6s4bmPLC7OMZRcMFI4Mcq0pMDevPvps3cR/jN9xzX?=
 =?us-ascii?Q?2psNnWU/rNl/sA3PNESpzQbV4wNfPpisUVuAYIFG0l8NJdNDYk4kQ+QSxM4J?=
 =?us-ascii?Q?HPfUNrhR86IlqC8ROII3VRaWiPc4kyp+OOfSZoLJGk0eyHypkSxeZjwszqEx?=
 =?us-ascii?Q?3MJMDE6r4wrwoj98+2TjS9yabudfyVM03sb7rddJUKkkp6kwZyNdAAFMOn8D?=
 =?us-ascii?Q?e3RIwcQpY/J4YHdqAeRqo3UP7ilSiOBPKpg4nheChC/ZhsIrYLVNv/ksixfk?=
 =?us-ascii?Q?LrM8p/Nz0l4FCIlwGkkgmnJ7eqNEb3nL5QdruKsRTdFUh48jE11vqRKX4Blv?=
 =?us-ascii?Q?ux+Achgno0IPYcRincu/SMgMCfdanIFlw/W9/I8or3YUwK/E4v/OLfcA2FPS?=
 =?us-ascii?Q?+D5gRe2hOwbxurT/efe/jBXiwEFlquX/y8gtHOCMbv01DxvsHB4NLtt3+zkc?=
 =?us-ascii?Q?Y/1/qaJwraB4091FMCXYD9vESM6L4r6j7lZO1te6xBS78ptw1doEQgHA1CvR?=
 =?us-ascii?Q?emI/bhf+1tG4tSf+gvR0CeNs8gNasP0DJt9UXoLjrUpk2X1ZOAYj/KxHoj4R?=
 =?us-ascii?Q?i3xVN0cwvYf/2v8lOEUCfyUkvlp6dZj1ZR+Ud1Yid/t3Js9SdfuR/7akR0Fn?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z9yOIitzmfpgu1dS4+0bwdcNhm26aDjQqOU0ECJ256M46eAA8WG0nq0BBF8Gj3+9sB82MmUkbS2GIy9IBvpN8yp+Ch/s3j+pBRtYYYQYIHTDSMXT2zlIsntD0iyy68m45Qx1Q/T5fXC/WOENDaY4t/EdoC5wR9fn7pw71T/wlZmqQZRrphKr0s2rCYwer3g03VqP61gs2/G1XX1pt+gy7ugnl+Dd7Btl3UXHXh+KBT5nz5hheR7ayo55FSan0302+CGrUuQbi7W36cQaOB7poLVLKNEqzXs60ht7+fUJG9iMXABOnZ8v69yH/qiLCXcTjVxfGy9IsNnN0Yv3F3YSOKwTn1i36CK6QmP8tCqDUtB0jFSaUolOaqliWdUirxdM1QctaO3II3RVF6KffljQ/DzlUlzrjgR+6ZPnnhtFDi6RTRTD+64fVrSOMewqllcY8lrv/jwWHqhztFCZdYwndsuWmiKdMRr6MqyzYslg75OER0xgkHvbhGYwkqLUzc08bm9UnpO9fQFmfhAn06KYtTash58qjMVHB3HD8tjm0gHAho3odo9AgQc56HmXaaVpT0aJT2UNTJpsvrRKqMC48XX2FLDktRZGIZlNad/NDlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648b4b73-e83b-438c-432a-08dd8ee5ad23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:38:46.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aH0FSx9Flld2kEgEvqHrbpgHW97ah5wQA5nYIlsM54+micK7uUG544znOGiIE2HNPEbf4JeP4w21iBbsIEkkrY77IGlTujRYH5wk0ZM4bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6ABE13187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwMSBTYWx0ZWRfX/deiIXN11xzD npEQ5hy0hyM9nouDWP+cpmDuHYMrEwNEA/eYLhooAoCJBBR4kGBJmQ1zZf2N0xwQAbws8o7EOQ1 ptQsoYJwCxvM7NGIVvtUljQV5A3o+s3Wm1cFL/8AKbKU3kdcv48K6GIpApJR+IA82UQAoS/ungT
 kd1bagazYD7YNoMn6fqDtrD1JWwBRuRvTHYxlW0gJw5s0YIQkZjBNU9Vb+mOGy0SyKMuHSLKwxk UgAr6Mg+OP+mgfWvS+nQ4RaAb368fa1ZvqtXlMMwiv2xJtZAZAXnjEdfJYdTq0HLxcMlx/3Ctic 82TjNHLJGAwGn6LsXA2Q71Cy3tEte2/U+WBOJRaJ/W5+V91b/NLBJm4M/wEZUSMLGMoy67FWdz+
 sM2VHBKlIjOZ93DJhIhzUbF0yFAw7Vn4xW2yR1wEp87CzALlfYXiReVsdin79IvJjAWTKodj
X-Proofpoint-ORIG-GUID: m1x4HoCxgxoZYwShs71lE1G32xf-azZv
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=681ddb3a cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=Zs-hLHfSk9aoTcn_HQoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: m1x4HoCxgxoZYwShs71lE1G32xf-azZv

On Fri, May 09, 2025 at 11:45:16AM +0200, David Hildenbrand wrote:
> On 07.05.25 13:03, Lorenzo Stoakes wrote:
> > Secretmem has a simple .mmap() hook which is easily converted to the new
> > .mmap_prepare() callback.
> >
> > Importantly, it's a rare instance of an driver that manipulates a VMA which
> > is mergeable (that is, not a VM_SPECIAL mapping) while also adjusting VMA
> > flags which may adjust mergeability, meaning the retry merge logic might
> > impact whether or not the VMA is merged.
> >
> > By using .mmap_prepare() there's no longer any need to retry the merge
> > later as we can simply set the correct flags from the start.
> >
> > This change therefore allows us to remove the retry merge logic in a
> > subsequent commit.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >   mm/secretmem.c | 14 +++++++-------
> >   1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index 1b0a214ee558..f98cf3654974 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -120,18 +120,18 @@ static int secretmem_release(struct inode *inode, struct file *file)
> >   	return 0;
> >   }
> > -static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
> > +static int secretmem_mmap_prepare(struct vm_area_desc *desc)
> >   {
> > -	unsigned long len = vma->vm_end - vma->vm_start;
> > +	unsigned long len = desc->end - desc->start;
>
> I'd have marked that const while touching it.

Will fix up on respin.

>
> > -	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> > +	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> >   		return -EINVAL;
> > -	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
> > +	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
> >   		return -EAGAIN;
> > -	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
> > -	vma->vm_ops = &secretmem_vm_ops;
> > +	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
> > +	desc->vm_ops = &secretmem_vm_ops;
>
> Yeah, that looks much better.
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

