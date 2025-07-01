Return-Path: <linux-fsdevel+bounces-53455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2777AEF268
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4534A2F0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFAC26C38E;
	Tue,  1 Jul 2025 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXav9aXE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aCulqfep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EEA26B77F;
	Tue,  1 Jul 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360626; cv=fail; b=HIamebOsWwtJhv24YeMFW3QcKy9CYQxflqVL1fXnlvkowYCLTNIxrWfX03ufrmX2YtYUOd6QvZ+x+f+REyz43t2dPKYEQNMHu56h9xiAMSLHN3nr9SJnTG3e1ka5D42IZn1gaCOLkL+H75tI6ADiQjnw/5TNRYvVLPHb9EscpXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360626; c=relaxed/simple;
	bh=oTVFu1X7YglIdBybfTvKsvDvqin1ii1ZDW/x8/TjM3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hYrr3coRohlnmv4Mxu2m6h65od0Rl2z3ycrRwG1rG952xglvwypj4np6bjbnd9xJed/ERqhEPvAbRZjHLqDi9n9IYCubweFLE48ar5DcHQ86C1yGMer1r+iGWR1liSNS/J5kGqkx2LeQ9UKLfGnENrGEQyv7Qu+6IO9GO/jyVpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TXav9aXE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aCulqfep; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611Mwdq008527;
	Tue, 1 Jul 2025 09:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FoQ2aLYBja0Vjo39mj
	E13MGX3mPx9DU2ghID3c9esg8=; b=TXav9aXErk7+xWPXuNjOZfKzvHCggywPYo
	0RYMaPacPafZjFGXb/JoKdZaC9z2tTf1JdeWVMHnayxBqhQmfcfk1X76YUVKAzHz
	9C1XtJTSExVpVu0JQo8KlUkDy8oEtgECQlSqD6A/MZMvd+6E8l4qNX67eEZvWWXf
	gqBLffkjM7hRg5bOYmLw4DCIC/WA9PF47Tob8ORK+HbqZqzWw8rzAjEoQQwOgOnT
	sNwblAe88Ne1X49thcECMyjw9RbCYDEGzL0JY/23R7H8r8Gy6dmTcHBo1XllEmt2
	X2bhLaBIoM6BEIOh4QWfB79xSHnHneY/HQce5Tglczym+nhxESuA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766cb8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 09:01:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5617FTRu005783;
	Tue, 1 Jul 2025 09:01:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ugqq51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 09:01:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r18RbbyrgBCspBHITZ4V0g+bQfVhxdpAy1NwOGV4WxMuoCxai/4c66tqFZqZYsyd38W62AQigaKGZb7YW8v7W/86EFAkTS4V+kNc2WzUz/3eS+hWQTnpIWyi6nmQc1QFYPlmHBk0IuDctf47Csd3xh40c+2Ix8KHX3iC57W2uFsXe1ZZOeUrVl5Fy81qC9bYDNK+QH9zriNbLmBexp506K8oVEneGfkKE8TgXTqEIcbY7vu/dUlFZu+jTeS/F6JHT3y5SsDVG2mxPUvyCrz6630kKe7+pNRph7EEMFdjykKwmj8w6sqkCa9653Ct/tqL0XC2PQL3Qd8c9BY48HIwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoQ2aLYBja0Vjo39mjE13MGX3mPx9DU2ghID3c9esg8=;
 b=uKWg/L5RKbaQ7sAy3Vb+DMXUqMWApFFZf8YlfpuAKbpEcH+rDvCmBC+06bnDd0iBfTo6aYfV7n3jPiZ+2aIk23BebiTskX12w9XEBioatXzPPhu4VLq3BiMRo4SRAUbqRXgOWm3Gd/cGDlzTqKR+vWiqiMSDy+mtAUHbZXgpmV/50QZLmwpjeFnB1onAoXMXmQDEkWlj8/Qe3EFGZL97BWAaJJJfgYS3L/ARyKNbSlWPqhbTnUHholLrpX857Jeb8nlTfNkBGMwMmuJrZpri4LTzbqdeYw0AAVQQbVtxFwMY9fguf3xx8p1X7KWiEsrbklxajafepCpmRKgKWLwJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoQ2aLYBja0Vjo39mjE13MGX3mPx9DU2ghID3c9esg8=;
 b=aCulqfepYwrCxaF7W3tsy8oixO/mxnarO5IbFMxjfPc2ATRcfpuRom7bqdtvv5+4XHFOsy8IKMOnsitsY7i/C92ZqMq0sbSkX0cTZm0NBiENAVm01PgC7N2uk6+2Ah/AbrpAFb1NALnLblJsg401Oj0MOPaF7lVcOsf70snyZJ8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5720.namprd10.prod.outlook.com (2603:10b6:a03:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 1 Jul
 2025 09:01:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 09:01:08 +0000
Date: Tue, 1 Jul 2025 10:01:06 +0100
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
Subject: Re: [PATCH v1 02/29] mm/balloon_compaction: convert
 balloon_page_delete() to balloon_page_finalize()
Message-ID: <7b8a62f1-3e81-4012-8b44-219498f37152@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-3-david@redhat.com>
 <f9cb1865-aa9d-409f-bce5-7051480c1a71@lucifer.local>
 <277e094d-b159-411f-940d-13b62493f6c5@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277e094d-b159-411f-940d-13b62493f6c5@redhat.com>
X-ClientProxiedBy: LO6P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bc15be-f13e-4e6a-aaa6-08ddb87dd15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q8Ctwm8I4BYMenW82DT2zu9oHrvvFJYrsEjRPhTQU7TnXj/eIYfdXP4kULBr?=
 =?us-ascii?Q?bH6HrnOZzhatN4k9enjSnqUUyUmyM0+tuhbHuBrotZ8nx/MKCeAOLYWrPyEz?=
 =?us-ascii?Q?Mwm7zKQ4ZCR1Fj21Dax4m7uhES2+VyGT4P6ECuKq9fs0rgASoK2AnWH8R/Hz?=
 =?us-ascii?Q?imYfsjVzDGPpyLm/dEvUxcq5GzIXYMsjeRO3+jNNfcuqQINOS/KdRh8TaVr5?=
 =?us-ascii?Q?dF6KygEec/kpGQJ1QyGIvzLb8A3qeTAUHH8/9bSs3U9CL+iN9c64lWeuxvyE?=
 =?us-ascii?Q?t6NvKPw2fe+1F5ln8wnyYE9A7epOwqX4Ll36m0CqoCT9RB5Vp7+bymvsmCHB?=
 =?us-ascii?Q?0SKznxiwP8F/EqFUzdMbraKqTTA2qmZGeC38QQFhN1rBtabqUNvAaDRfhChd?=
 =?us-ascii?Q?dONzQHL1vTmbAHUDgCqTNu7qZubppmDf11DplGW8koHs/T7DW+uwqJbGEqNC?=
 =?us-ascii?Q?kCg0LvwykFgkWVEWHtH9A7cGQWavqRQ5pJ+7JbUk59joKQJl0YHZzSGZ8LbA?=
 =?us-ascii?Q?+rJfYfO1KnGCUkfQG2gHWH57zsIezzqjb/Lh0UwrL7Q7bhOPculP1/iZMHaT?=
 =?us-ascii?Q?h+nwmJPR8ZlB+m5+/0vsjazKVqFOwt9NVFEsbXuOcPW6JQT2CCZi21J/yAh1?=
 =?us-ascii?Q?xeKcn/Ve7Rs5pV1lRzb5pMy40bhie0uRNnaAnWt7D1suKmdCdMKzjMUoYyZv?=
 =?us-ascii?Q?t4pPqBjQyLTNB4jRUG22rly7csUG0b/QzW2RMfkDKKbONDzxAM+dJGVQemI/?=
 =?us-ascii?Q?2M80IuvnCta3dYMhWUSotAn8LmUyvS8X8T32gnsLLleg2TsuIszoVz2AuoKM?=
 =?us-ascii?Q?CfoKeDMNGzR0PiHKsAE3LKO/FnYaREnL8WFKw9taNFj+wcS+4gm2xrymy+Vt?=
 =?us-ascii?Q?FqGueGlQ/ei3v0isDf5Bf5rJUtk/nt6cjb33x2DdKy+qOzJVCxiCZH179UFf?=
 =?us-ascii?Q?qECVFKokAKsHj1C1gVscMokD++NV+1pjgnmTURlZQkAVOE/uNBoVF/XWmMzF?=
 =?us-ascii?Q?sAfo1zvOQZTMWaQ16/iF6vRWh1T3YgxgvTmoUigiO7KE08fJu7t2peKLlxcr?=
 =?us-ascii?Q?h2zPEBCGtq6RelsXQWUAKrhGjm7Qy1rDkcfqFt7pL4LrckZ2pNlkV5n0WFE2?=
 =?us-ascii?Q?WcLpzugC/KeMtg5VAW0BKK4ig+lmd60EHiScAaEutT4Tt08ydNGN1BBF2QIl?=
 =?us-ascii?Q?qpMUmhyXsyfwm2Ix9D6jNqV9mGIgKDQNVU0aWwqxifEbGL1FdZiyLaQnGasL?=
 =?us-ascii?Q?JeZ5n9Q45UAc29GCqpMrmA1s+uh/LAK7YD+AnxM1EAaLre8/JgUsTMucqTWi?=
 =?us-ascii?Q?y4DBE9JRgq9F34coMc1h+J6hgHgoLJNP+KLZKMlD9dgjMZ3WWrNj69p0Acbq?=
 =?us-ascii?Q?4xM8jSidJqtuy1d79B3nXRlR0glR7DB6Vn7zoER8Xf5eL/tR6oxDEOGv2i7B?=
 =?us-ascii?Q?Etwd7UqyoHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VG5lg0ayNHGOqpHfdfrkhAmte7sNxVGWHqrX6dm5nJu6SpmtYrvRB8aYkO4P?=
 =?us-ascii?Q?Z1Nzeev13Tw8gB9Xtfrgztc3mB8jCx56t93GtqT+gt9BJzXIOpLBtPyUxjZP?=
 =?us-ascii?Q?KpW6JDi+OAUtLd0APki/egE7grsYKVDyRiJHrv3VMZ6ll+wbtU3xB/adCU1p?=
 =?us-ascii?Q?wDhuknZZ+QIFgBUxKAEW20mL55Y1gRX1QSUj765tR2P2lU3O9N5xpPOpYcwZ?=
 =?us-ascii?Q?jjgORzgQwWqMlLz1LTRx5Vwon8RsT8bzybYfIWgei8KV7+DmBlL7g9Zt39NS?=
 =?us-ascii?Q?BttnMWZcVLVg3lSUrPLKpOm+1d4lJp+BimqBFvwvZ4EWvUiwzogUS0g8nIwo?=
 =?us-ascii?Q?4bl8mqmxhcKqg0+PAY+OW9tTqAu4yJcu6DjvbIuevJsCw7PTWXnaMrJVJr6o?=
 =?us-ascii?Q?4OBz1+wHU+1/nHJkKzDdpqHZN6rXMEpsoC2IThIKotVM7/1JdXfcVHPQwMnX?=
 =?us-ascii?Q?T82BoOFggd+tgefjv0Q2TWdOj/nGg0tSmEo3B3WHEKA/VjlkH/kgeGemzojU?=
 =?us-ascii?Q?2bvKUM3ajAt9R/6Vxrvv02HJEUhVBiZ/51Rurn3wzGo+la06HxyX9qtDRGo2?=
 =?us-ascii?Q?oE75wcmr08MdydILkOc3nYkHYUjRRWHM/ln8etpXPYX6BFYC/Wl2fKoB5BC1?=
 =?us-ascii?Q?KHyskaNwRnSHi9a4kM4s/hcGON4JawF6TzsQSavhBh+rDnIvZI0n1e4poHGY?=
 =?us-ascii?Q?uTfAMK1aS1yeWinIfNYAJ5QRFuXoSE+/PbUBMJy5igraP8QwuAjzF22FraIk?=
 =?us-ascii?Q?Dly+wsX1yKdQxuKwQhUyTqpFDAj3JRQMNUE7CVMtfYCAU2Ff20izEYixlEyz?=
 =?us-ascii?Q?HxjAZjQ/0cFMNK2JKmMlEucCvxkowORgb/fOsGMcprxr323Pl0zZfXQhJwkc?=
 =?us-ascii?Q?fQTulPTsGbkSooiy0gjEe3Wozk+kQMbLrFpW5KMFtDqlBHGS7gWs23g28dO0?=
 =?us-ascii?Q?cREC6IeVhcvfw8tk9GiDtUpxZXJqIdCTHPxHPa3iTupIq13dKew4UG3J5GDd?=
 =?us-ascii?Q?uSyxWjBPd7yooHl5Yw0WKzTtvz/uwHt2ddpuJO8beOfV1UGB8NaupY3qv/8F?=
 =?us-ascii?Q?37hOmzCeaklkBzxadX40VNN8R0PnIb8wS54lnvcQHXiho1oKe8EGfTfjCK80?=
 =?us-ascii?Q?NaQ98p62E37962mx3JKMiRTn3AWGPLSPFka/8jXFnG2mDod82pPKkiqhJM56?=
 =?us-ascii?Q?L2eILej7+T59XHK8CTuJdJS6Wn9YhbrJPNdTpv+oGHr14h4Nr2RY3DJH7TMi?=
 =?us-ascii?Q?rRhmU7Im4ArNmrls7J1QD9jV06PNMmOMqXGChz5xt6m1UDizWGflGGRmSVBF?=
 =?us-ascii?Q?Mo2Mnui6dnMP5Le0nQL3VN+HTuyLaXWMDHQu/UJbiCOJAZ+Wvldx8V9jwfFx?=
 =?us-ascii?Q?wPV58Fg5myg1vi304fDcz7bw3xh007LaYCpkdBWsBhnZWit2p8aZ4zC+K8Ui?=
 =?us-ascii?Q?BXrUl/+KHMYcEtLFc60sbeTudv62TveWjiH33s0yyoXH/erO7Uf/p4nVx7vH?=
 =?us-ascii?Q?P0mGKvBO9n//OeH5WZELCv+LhzG0y7OJkxcM0C0+VxouERpxOf5BoUb0c2Tk?=
 =?us-ascii?Q?KtS80YP95YpZhUwSJLjjD0xaS7ilUBybXVmCvn1owjxiymDWV5UlwD6phqEY?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uUk3QQJfXTZUjCNaL2U3WMvrwfYvMb5X6+Sukq9vjKYI91gx5XMIHR7E4o4ltJyZvXZ0gnqxHTdKciv5jvCWreDmVYfEf0n4Qofmzzomjqy3fEqdktWloozIuF2KJ8r2doTVNt0AscdZoEDxvKB93vJlBi3ii453yHhaWKOdWTahrNc/htLL+ZYtGXwCucxTn6O2+IBS9/lupwMRDgIrWZfliZAJoxhWGx3n7GpWXLgd21VgCzCa6URfwhG7zgNMO3rAqvsNIESshBUhsm33rdJf6SBKf7Rhbh9FhxuztsDoz8XrqnoMSZ9fvb/77Qb6NUt0Ry4bMRw2rC7Q7wUTtCSEl5Kf1YfBSHa+czDlXDu5AFVOS3+Bjk7DEIssPF+zO6hF4Ny3V3344P0Gw0DfOseP83G5ztNLKamef/1Ds81IY/VNqqN3vEfunmfTe/6eR6KglM5vFCnNvODsfcWalqpywiWLpulIMQw0frdK/FiupvZoPi1Lpuv7dT4inYrjEvSn6HWiK/eNmisf4D7SxghmYIrlnj1zEVsFIIKj/oLHhclf8EJnanxWzVIA94Hn5VrSj9MevOz6akoGSJNN6ngFKrWvJ6JVvVYK4/Jo9t0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bc15be-f13e-4e6a-aaa6-08ddb87dd15f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 09:01:08.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jNvYeKK0fd0y24wQRCpUxtUMMs3rqnf4qOOgJn3ypQ9OWpyHUo7AWb0pHOeEZ7wENIr3e2qZXaJ360aW2PlT+PozKkbhpvE0AypnNmiF1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010052
X-Proofpoint-GUID: w_j8vXpVEzlj7oQZmXuMmq4WS_4h93mg
X-Proofpoint-ORIG-GUID: w_j8vXpVEzlj7oQZmXuMmq4WS_4h93mg
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6863a3d8 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=yyffBvel1Gi8w3360QYA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1MyBTYWx0ZWRfXxgISnpAIuZhz 96sFVz5WHOwPbdYcEl0XMHd3/1/mXTFd9DbfUPnEHS6wzmilrGtmyewCPV7yIqXJOGiDKtJSsm0 4jbcm0Jb15R3IuJ9usG/xNof1uxpA3SdQOnxWYS+dJam+XQlCtP7TLwlzcPpEDzMnfF0Lrt22N1
 bTXr5DNKWcAGCXfABK5F5me0PjDpDqYHptt8TmYJlHFh2LzNtSC0L5276DKb1Cex7rvamGsLXw+ 1HJN6JV3w/9owawlCDlXgp60hyg4ggowUcLO2jBm/Vl2BcGxZcKkUmUdOHWdmLZR133bv/t/KdW 5Wax4+6MWie8U7Ulw3gGO3ej+FX75LtIBPp7R5T5naW/3I3OdSuRWV9ksKTfVU2Pl/HY2BE7n1s
 fNQuRMd51J/v2qTgjFY3KD0T5wN362mwvqGV9dgnldJyzickur9Ykc+TIFr87nPSWU5VSvfM

On Tue, Jul 01, 2025 at 09:58:09AM +0200, David Hildenbrand wrote:
> On 30.06.25 17:15, Lorenzo Stoakes wrote:
> > On Mon, Jun 30, 2025 at 02:59:43PM +0200, David Hildenbrand wrote:
> > > Let's move the removal of the page from the balloon list into the single
> > > caller, to remove the dependency on the PG_isolated flag and clarify
> > > locking requirements.
> > >
> > > We'll shuffle the operations a bit such that they logically make more sense
> > > (e.g., remove from the list before clearing flags).
> > >
> > > In balloon migration functions we can now move the balloon_page_finalize()
> > > out of the balloon lock and perform the finalization just before dropping
> > > the balloon reference.
> > >
> > > Document that the page lock is currently required when modifying the
> > > movability aspects of a page; hopefully we can soon decouple this from the
> > > page lock.
> > >
> > > Signed-off-by: David Hildenbrand <david@redhat.com>

Based on below this LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> > > ---
> > >   arch/powerpc/platforms/pseries/cmm.c |  2 +-
> > >   drivers/misc/vmw_balloon.c           |  3 +-
> > >   drivers/virtio/virtio_balloon.c      |  4 +--
> > >   include/linux/balloon_compaction.h   | 43 +++++++++++-----------------
> > >   mm/balloon_compaction.c              |  3 +-
> > >   5 files changed, 21 insertions(+), 34 deletions(-)
> > >
> > > diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> > > index 5f4037c1d7fe8..5e0a718d1be7b 100644
> > > --- a/arch/powerpc/platforms/pseries/cmm.c
> > > +++ b/arch/powerpc/platforms/pseries/cmm.c
> > > @@ -532,7 +532,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
> > >
> > >   	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> > >   	balloon_page_insert(b_dev_info, newpage);
> > > -	balloon_page_delete(page);
> >
>
> Hi Lorenzo,
>
> as always, thanks for the detailed review!

You're welcome :>)

>
> > We seem to just be removing this and not replacing with finalize, is this right?
>
> See below.
>
> >
> > >   	b_dev_info->isolated_pages--;
> > >   	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> > >
> > > @@ -542,6 +541,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
> > >   	 */
> > >   	plpar_page_set_active(page);
> > >
> > > +	balloon_page_finalize(page);
>
> ^ here it is, next to the put_page() just like for the other cases.

OK so it's just moved to a different place for consistency.

>
> Or did you mean something else?

No this is what I meant :)

>
> > >   	/* balloon page list reference */
> > >   	put_page(page);
> > >
> > > diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> > > index c817d8c216413..6653fc53c951c 100644
> > > --- a/drivers/misc/vmw_balloon.c
> > > +++ b/drivers/misc/vmw_balloon.c
> > > @@ -1778,8 +1778,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
> > >   	 * @pages_lock . We keep holding @comm_lock since we will need it in a
> > >   	 * second.
> > >   	 */
> > > -	balloon_page_delete(page);
> > > -
> > > +	balloon_page_finalize(page);
> > >   	put_page(page);
> > >
>
>
> [...]
>
> > > -/*
> > > - * balloon_page_delete - delete a page from balloon's page list and clear
> > > - *			 the page->private assignement accordingly.
> > > - * @page    : page to be released from balloon's page list
> > > - *
> > > - * Caller must ensure the page is locked and the spin_lock protecting balloon
> > > - * pages list is held before deleting a page from the balloon device.
> > > - */
> > > -static inline void balloon_page_delete(struct page *page)
> > > -{
> > > -	__ClearPageOffline(page);
> > > -	__ClearPageMovable(page);
> > > -	set_page_private(page, 0);
> > > -	/*
> > > -	 * No touch page.lru field once @page has been isolated
> > > -	 * because VM is using the field.
> > > -	 */
> > > -	if (!PageIsolated(page))
> > > -		list_del(&page->lru);
> >
> > I don't see this check elsewhere, is it because, as per the 1/xx of this series,
> > because by the time we do the finalize
>
> balloon_page_delete() was used on two paths
>
> 1) Removing a page from the balloon for deflation through
> balloon_page_list_dequeue()
>
> 2) Removing an isolated page from the balloon for migration in the
> per-driver migration handlers. Isolated pages were already removed from the
> balloon list during ... isolation.
>
> With this change, 1) does the list_del(&page->lru) manually and 2) only
> calls balloon_page_finalize().
>
> During 1) the same reasoning as in 1/xx applies: isolated pages cannot be in
> the balloon list.

Right yeah this is what I thought, thanks!

>
> >
> > > -}
> > > -
> > >   /*
> > >    * balloon_page_device - get the b_dev_info descriptor for the balloon device
> > >    *			 that enqueues the given page.
> > > @@ -141,12 +120,6 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
> > >   	list_add(&page->lru, &balloon->pages);
> > >   }
> > >
> > > -static inline void balloon_page_delete(struct page *page)
> > > -{
> > > -	__ClearPageOffline(page);
> > > -	list_del(&page->lru);
> > > -}
> > > -
> > >   static inline gfp_t balloon_mapping_gfp_mask(void)
> > >   {
> > >   	return GFP_HIGHUSER;
> > > @@ -154,6 +127,22 @@ static inline gfp_t balloon_mapping_gfp_mask(void)
> > >
> > >   #endif /* CONFIG_BALLOON_COMPACTION */
> > >
> > > +/*
> > > + * balloon_page_finalize - prepare a balloon page that was removed from the
> > > + *			   balloon list for release to the page allocator
> > > + * @page: page to be released to the page allocator
> > > + *
> > > + * Caller must ensure that the page is locked.
> >
> > Can we assert this?
>
> We could, but I'm planning on removing the page lock next (see patch
> description), so not too keen to create more code around that.
>
> Maybe mention that the balloon lock should not be held?
>
> Not a limitation. It could be called with it, just not a requirement today.
>
> I suspect that once we remove the page lock, that we might use the balloon
> lock and rework balloon_page_migrate() to take the lock. TBD.

OK fair enough!

>
> > >> + */
> > > +static inline void balloon_page_finalize(struct page *page)
> > > +{
> > > +	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
> > > +		__ClearPageMovable(page);
> > > +		set_page_private(page, 0);
> > > +	}
> >
> > Why do we check this? Is this function called from anywhere where that config won't be set?
>
> Sure. balloon_page_list_dequeue() is called from balloon_page_dequeue(),
> which resides outside the CONFIG_BALLOON_COMPACTION ifdef in
> mm/balloon_compaction.c.
>
> At some point (not in this series) we should probably rename
>
> balloon_compaction.c -> balloon.c
>
> To match CONFIG_MEMORY_BALLOON.
>
> Because the compaction part is just one extra bit in there. (an important
> one, but still, you can use the balloon infrastructure without
> compaction/page migration)

Yeah this would be nice!

