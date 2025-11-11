Return-Path: <linux-fsdevel+bounces-67892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 799DBC4CF13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27A434FD724
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E033343207;
	Tue, 11 Nov 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QgUjDPjV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OmBl0oCE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A12155389;
	Tue, 11 Nov 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855531; cv=fail; b=eFqGw36G8xpVCTv5IZ7GlvBhaEevNxu88LIhZfk67zwMzWT1+PXrn8XNthApaQ7wGpvUXmWPgFh2O8fg0OdruA+jKnvbZI2IbMVZN2ezppypLYp/ClY8DXSSvG6RQWkoIYwQ/++8HxUIDvMP9fyaLC0yiGGOEiA5vG8WCzdX3JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855531; c=relaxed/simple;
	bh=Rdt7cjfYalkQki9JmAxyYivEnzs2w1pi099Nh+kzTA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fg8wI25lK62SKgkTQctB3pPSsNzICVBpgB1YX+ehNwPQQTDZ1MVNEZu9UjUa1Km7EC9tKSZLeALC99gVvkRbJCi5MrAHNsjOyuCFQ8Uv5QcE9UjyafFJmF2kWPOmdSfgocDVpQdaSy3B/HVc9+E2oQ4iqGu1Em/2XZzTryWRxyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QgUjDPjV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OmBl0oCE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9ulAD000941;
	Tue, 11 Nov 2025 10:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2ApjexKXL3fdw330miU1beeOnsbPmr/5vqY93SSf7RI=; b=
	QgUjDPjVDpGhhym1xEffWo2tBM385wf1B1wKltsmypQO+iIXC9wz5X0Qfq0UgAWf
	SARZNs9NQXYyHMsPmLG1n/rJ94tVh7l2OCE6q0F8rmctiN8ZtJL22TZa1R35uw7d
	XVXzJHWP/GnfnAzR1/g9YmeLTIJ1GVEFzpfKZ8o8720DN1TPfuO2fZ1io44oasgu
	Ddde61756hTNA9KbAW/1pt+bRE+ImXlle2itce1oW8yFSjrU8zt2pUOVLxH0T0P0
	S9OGDmlaxRR7/qYRxAG5z4dm3oOltYSkxv+b3alMKRGzP768YxNjZLXCI4Y6xeH4
	wnuwRqofTSwYqGavZ3yGkQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac2xbr0t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 10:03:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9SI3B009978;
	Tue, 11 Nov 2025 10:03:42 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vak2xcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 10:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abNlm9pZ3hY75U4RkQi9utnkpe+J6wCt8TotlB1bB4xjfCF6dkNv5f/a+m38ym6VajH4gPo8ibS7G4pHGU0432VbNQ7s1uGNECpyONOGLlP3ji2ZsMshsoiDtxICnrG/BItibFWGQ/Opw44VEsmjXmR3Ks/3GlsL3NarvUFR3yhy1mr7MeCCwRpA0bn+3S3ukg82QMY6zrWFxXNWqK/didaLKD4lOnRNoJvYaLxzKxHvUMHiAc7IDdD4X/aPXprHCPg+mi4fUSTkUB/08W+GhtI+sF6QIGxSPgbU065VaO2EHE3c37PKNOJRbu9lm43Bw04MCYcy4KglTLKytI3Uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ApjexKXL3fdw330miU1beeOnsbPmr/5vqY93SSf7RI=;
 b=aAOtMW2CZlJrAvioEp3kV0iNakNviW7dKPA0OQuMpPdft3FMDMdSKotMDC00N8EXvctcmOc3VCd4xusO4T409g5KK70+OID/feC3bbwe1NjaqlgTRBXZjnI1fdzdEmpyqxmffvjEzV6z7uf9aPyfy7ICmwsh64CmuFhjtOlBgOKUfi8NN3EeS4GqZ+ZY2+97kaS9ogCy3qLA0Pcm/gt5/t40uRuURPMpVPYup54wdLXSBvLOrcrKd2eGjLRSjtAFd/K+qhpEzXjuKiTjq4Y4Ch96G0Di4S9+iDKFGpXK2qE6Jt9+jauYK+1iu59+CgGsUMq5Wd9NpoRReDImRooO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ApjexKXL3fdw330miU1beeOnsbPmr/5vqY93SSf7RI=;
 b=OmBl0oCEsEcTV+uxvasninUT4q71+OttvsAtnz0EkgdU3f+Y5cP0cOAf47Y772sI7tYFU/FdiAM/dS9HOZN++G/e700/kmXqu+J0IDZlZo+s0eV+8OllEuLITAA0cKyU/lCoZiIYmNn5gmoYzMx4RvJEd00MQ8aY1GOd0pVq98w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB8048.namprd10.prod.outlook.com (2603:10b6:208:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 10:03:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 10:03:38 +0000
Date: Tue, 11 Nov 2025 10:03:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, SeongJae Park <sj@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <0468f101-1350-4879-8a85-22e181bf8aea@lucifer.local>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com>
 <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local>
 <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
 <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
 <CACePvbUHCrNNy38G4fZP92sdMY7k5pRQkcfo=iPp0=10T5oCEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbUHCrNNy38G4fZP92sdMY7k5pRQkcfo=iPp0=10T5oCEw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0300.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::17) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 1741cc9d-0a41-4e16-34e2-08de21099527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUtOTjU4TXJYbGRNb0FEdFRKRnROeWk3bTE5aHZLbTRCTmxpWFVYNnQ1T3lw?=
 =?utf-8?B?T094ZDlmaXJ1bFM3VXZnNzFwSjFWS3VVT3o2M21rSmhBNEEydmFGVnd0MHNB?=
 =?utf-8?B?MVlYcEprTnhIRXJOSXk4aTBqQWFhZXI0VnRVWTdoVGIrVlArMGpJZVc0c2pp?=
 =?utf-8?B?TnpMNzgvei9ScjIxWjdZMG43Vyt4N2FuN3ZVd2FkalN4VmhLZlVpbUFPWm9E?=
 =?utf-8?B?N2VYTTRaR3o4ZmxQNWRnOElFT2RDRGF2dkpJc2JqZHVlU1hLV0N6RkdpenBl?=
 =?utf-8?B?QkwweWJvRmNGRHRSVG9LZGVXRDRydUpSWUpNc1Ztb01WTkZIS1VRcFUraGNW?=
 =?utf-8?B?SGFva1FnbFE4UmdDMDg5RWxiRWd6dDhZbmFiVUdxanVlZVlCRHY2anFWcnJB?=
 =?utf-8?B?dGQ5WFhpdnZDdTVzVFNHV0duUlJKRXZhdHZsRUI2VXpKbVZaS2lOZTdhZE1Y?=
 =?utf-8?B?a3R3N1RzdFB3Tm8wOVRJc05MTzBGY1pta2x4YitLWGc2bEpMdGdQY1dSbFZW?=
 =?utf-8?B?MGhqdVVGTVdpOEdEamhLNWliTERZOVhZNDQvdDRZcDhkcUxKL0Mzem9XVnRS?=
 =?utf-8?B?TlZVTmZMQm14MnRpcittR2YwaWcrajR1cU5HWHpyT2JaWTVMNmpIV0VvMXMw?=
 =?utf-8?B?SWpnREd1NG5XUHQ2MVBUQmplY09wbGlRaHRoUjU0UndZcUh1TlA3R2k4TDk4?=
 =?utf-8?B?QUtLYnlMeE5Kc01uTmZpbVY5V285a1RzRHJrYmd6enZyY1IxSWZEbVFLV0Ft?=
 =?utf-8?B?b3BsLzFKeVdoK0h6QXZzR3lEQ0N2ZkI1c01oU1Y0dXppMXc1U0pDYW5OOHFm?=
 =?utf-8?B?TjdlN2p6YnVxc3FNKzhhWnplMVF5T3dJYnNiYUxia3RWcnNvVGxVVWRDS0d0?=
 =?utf-8?B?cFpSY0xxUGsrNVRhNDNKTHIwOVFrU082clk0YjJvTVFvZHJyZ21pV2dVMDRj?=
 =?utf-8?B?bXVqOXF5N1B3cFVzOHZmcVRyMDhvWG9yWEcvNlBnRWpBR05iV1hJK1RoV0VB?=
 =?utf-8?B?K0xzWkswSFIySlZHM2xqZVZac004OEtwWlZzK0ZoVVRWR3Z0bGRjMEdhTDRT?=
 =?utf-8?B?VmE5eXgxNTl0dEd6SmNKbStPWGxHZHpSOGJoaDBOWUxYVWtDZFVqM2NZN0M1?=
 =?utf-8?B?dzBYT1NsejJLMTBrUG9RUWo5ajdYQVdEUmxJVWlnME85UDlFeUx1WjlRT3dM?=
 =?utf-8?B?c0EzUGtVbldpdlNuWEFzN0t1WWNaNWxjd1NQaUVRK1lDR3A0QWxTMDZIc2lF?=
 =?utf-8?B?Z3BGejJORFM2eWF2Smk5SXlBdEs4R252a1BlZ1EzajVKdEdNaGpJT1Q0a2Jm?=
 =?utf-8?B?WXcwTXJnbFl1ZUhCbzIydmxJbzV0alFqeXJZKzRzV1Y3YzRSYkVJeFdYMVdY?=
 =?utf-8?B?ZWV2YXRGdFErZHpWMGZsNGRoUC84TUcybzhMdmJZNXI2K1dSUFozMnJkaWJP?=
 =?utf-8?B?UUpTa0s2Mmtsa1V3Z3ZnbVlkZ01pbExIK1g0K2hKc1RnVmhpU1dyQWFRRnlK?=
 =?utf-8?B?MGJ5OHB2KzNxcjZ5RStEYUFVdXV4Rk5vamJ2QWllK01LdmJmTlVYTmpGaStO?=
 =?utf-8?B?VENNV3BOQkduck9LMUJKYzR4MlF0b0ZFaHhNZmdTQ1lxVWRjclVVUDhDQTl5?=
 =?utf-8?B?MGxwSGhxL3dJTmRpTnZOMzRFeUFnYjI0VkUxbWZXdDlydDBVMzJMUHNqRlJt?=
 =?utf-8?B?TXVCMjQ1RWZaNWVSaGNXdFZwejZhTnk3RmQ1RDYrTE10RDdYLzhpalVuSFhB?=
 =?utf-8?B?cGkxMjB4QmJtTUV3V0IwL1o2Sk9weW1qaFVVVitialRiY3NXMXNMOGtmaENM?=
 =?utf-8?B?YzRmNStPb0JOU2txcm5NTlh2d0Zvd0xndkZZRU1QcmUxdzUraU9sZFpzUGFT?=
 =?utf-8?B?VXA3eTYzdnhpKzJkZWVFYS9SSng2MGREeThLOXhiWXhDYmlrK0xyQ0w3L0tr?=
 =?utf-8?Q?fPjCaRe72SiSOyZpy+0+OBX03M2UUACP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDFabi8rY1hxTDA4ZXRISVJBYUUzUXNsRkVFTUk0c25NSDdwMktDSUhMVFVl?=
 =?utf-8?B?TlRaSnBUeXVRMDN2U1Rtcnk3OXcwNjB5RklxdlFqU1JTY3NGVnlTTnpZWTVF?=
 =?utf-8?B?Tm5zak5Fem5wd3JrVVNVWGEvdTJaSGprUVJseDJUenJDM2NzR3VLMmNUVnNy?=
 =?utf-8?B?aG1HZnBKRlRtOWhLSjhoS0xCYVVYWTgwcjZYaFc5SDFYNTl4ODdkUC8zdXlm?=
 =?utf-8?B?UkdRVXI5VUhmOTdrcUV0aXgxVVpLbWhxa3JiSUZ5QnNBMXJxL3R6b1BSdUpm?=
 =?utf-8?B?bVlmcVNjWitYbUJxVVd5b1ZVaEV1YU5Tdjc1WmRPMXhsbE4xNkxwblMvSUF0?=
 =?utf-8?B?UFpEekkyMTMybFo3dkxpVmxBbUtyVE8yTTFsOHBZK1pSUDY4dmxvRzYzd1Fa?=
 =?utf-8?B?d215YjVDdEI3S0pPY1dCQ0RWYTNWMW5UMmNKbmNIb29KckZjQlRmV2ludnFW?=
 =?utf-8?B?bDdqZXg3WGh3M3ZmRThjZjZGTkdZQVhYbk82aGk5QzB6MnZDdEtnajIweHRo?=
 =?utf-8?B?V2hvSzlMaVBMbjdPVEgzT3FEYjIzYWdJdHhEVWRqbU1leDVMMGFMSXNhbHI3?=
 =?utf-8?B?b0IvRHdnaXFGTm5JN2MyWEJRd2xncGZKc05CSmdiUnhUakQ1aWxqMENvVkpt?=
 =?utf-8?B?R253WEM2dUhTSU9YR2xTdC9vT3hWM2Y4cWREWWprdk5Ha3VqeHFiTXlLUUtD?=
 =?utf-8?B?N0MvYzhqUmp6WDNrREtsTnR1d2VpUXpSR1J3cmIwUzA0bDF2QmdNTUVKdE1Q?=
 =?utf-8?B?TzVHT2pXekxaSmhPd3A2RlpCaUxIdWJvbmxiRHJic3dEVUp4dUdrblBoQThE?=
 =?utf-8?B?azRUS0dpdzJ1ZXpyZVVRYm9FRkczR3dSNEVpU01yVDdBaGQ1UTkrTXV6QjVZ?=
 =?utf-8?B?VGZ3aTVOOTYwUWg0KzEzekhscnZNV2FyNmo3aExWOHBPQXVFWWJEbzZVdUpj?=
 =?utf-8?B?RnlzWUdxNmpQd0gvY2M4Y28wV1hBeGJGekU4M2JyZVU4cm84Z0pVeU1oeVNy?=
 =?utf-8?B?SGFvYlZiVndMUUxEcEZvK2dNK3hKTkRvYTVlSkdBZ01jOFRjdmJBU2d2UVNH?=
 =?utf-8?B?enY3OTI2a1VkZ3N0cXo2YjJBR2h3bS9pUDNWR3dtWldLbStqZW0xRUZTMXp2?=
 =?utf-8?B?UVR4bUh0K2hZN2I0cndnalUycjRsWTFJL2F0NDhCT0VNM212Q2pXblJZd0Vq?=
 =?utf-8?B?NncwQ0t5cC9VTHhJR3VEM3RxWWRabXVjUTk2RGdpdXF2Z2x3QUR3MmNRcEFD?=
 =?utf-8?B?ci90Vk5razdXZzJYUUlKbkRzMnZlTWF1L0s5eDh5c3Z2UTZuQjNjSmRVMWlh?=
 =?utf-8?B?MHNaeDF6alk2RXg0a0JqZFZLNWRDaE1xdWZtTk9NVEs4V1pTNzJKczhlWUZQ?=
 =?utf-8?B?eTZCY2FzelZ4eHMxSVhjY2FsOGFhbVdMcVVybWFncXY3dlZVdWtCenhtNzBh?=
 =?utf-8?B?UTRIckZxNW5qZngwZXludm5BNU5TNS9GaU0vcmg3eEFQVnNoMTNZUU01RjJz?=
 =?utf-8?B?OWQ1RVN4a2J4UWQ2d0dyc2pIVG5ZL0VlR1I1ZjRlbGQ2ZVp3VzdUYlNZMlVm?=
 =?utf-8?B?bHQxbFo0RzBORytjSVR5NFo4MmVPbjJyd05lSUR4bTh6LzRPbXI4UDhsaUJ1?=
 =?utf-8?B?dHgzdTlUMWNYejBwMGl3ajFmMzA1d0hwNTJXR1J5TGpFd0VCTW1UVFFrTENi?=
 =?utf-8?B?eU4yVDEyQkd6YmNUR3JvUFNHcDVyNS9NMHlOWHgyNzJvaTBKNFV0MWxIQmEr?=
 =?utf-8?B?dGdseU84bFJ0Y3BmVTBXTG5WeFFIaVFXTnowYjdxSXpOak1oQUErT2ZpTnBO?=
 =?utf-8?B?YlMwZE12MnpQQkN0YzZtcUpERTRoa0NZaS9qYWpPUmU1Y3RQbXI4ajFOMXdV?=
 =?utf-8?B?VVZXMlhjZ2hBaW9HMFA1dXpnVmpJUG5uL2s2dmkyc1VGTzhaeE5Kblh2SjdF?=
 =?utf-8?B?VENQTmllTGgzc3J6Mkx5SVZUN0NwbkxHeVRPajc5clV3ZmM4WUx6YTVCa0xk?=
 =?utf-8?B?VzZyZnFoRHQyQmFPbFdwV0VCL1d1UERsY1I1RDJkUnRBeGNna1hndTlGTEMz?=
 =?utf-8?B?K2xRMVZteXVrQkhZS2JhUm5aQW9xTEVBT2dGMHJhYWtoSXYzY1dWUEpxU3Zu?=
 =?utf-8?B?bktCMDAzZS9aUTE0bDBhVHpiRG4ySjZqMm13TXgweFZwdWdDbWlPMDI0NGVs?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UpQ3uWeAYPtgy09/pyEwmc+Yf48nDiFyF3htA3s2QNIyxJJ5jAP4n4w3A6N5c2gYUbnVtL/3sfxem+4CEtKJ5Co8/zFXUc++7qVdxivb5Tk5LSpU2qYe/DSwErgeWWc+dxpkUi8S2h/vF/GVGCDhU0TWuwT5XtwGd1eL7yeeBNoAazW3wFnvGcSvq3GlyiWqZUpT5BtLIQC4M6BRjRK0GSgjcQwt5ygWSPASLE8YfGmTCrho+2clDoljkzn074NmS/NdZtbmQ7XCmPS50atJC3A7/FB1vVG5wYogZJ5/6mQQLudQ7H2F4RmFgyF32GLbTIBwlnljILF2o7LN+2rgTyJJdJQhCP6/TFkDQu0792op1RACyf4u43TJJVEiuf0YeEtrytFDoB0hgn1gidVm6Qzu2F2jVXmrY9ekbovs6KZBo3LQy3Deq6xSPqkWSbJj4zmR0j48Muue694tN8W1Akw4dO51bL4Incg3niVpN/1k/hotLYkhA31CNLdGSCT6ML9XC2AZ0oJNvgaTuhJcVz/baGWxacDuzKAHMKeECjfLpNZogRMXVpZ9bzF/h70DhGikkNy+LL1cemOqyW4OYA+/aa2OWlnkju5CkfnubiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1741cc9d-0a41-4e16-34e2-08de21099527
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:03:38.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA+iXecam0mThvMPI82/SqfwZAbWkR6L4lnDMSddHoFOWz5o187+2V9GM7HYXP6VQIcL8Cl6Ytw48CCqBq/wAfrXVTVBfttL6hFPt/Ngb7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110079
X-Authority-Analysis: v=2.4 cv=ApvjHe9P c=1 sm=1 tr=0 ts=691309fe b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=KcGyZ3GnvE1oL6Ba1eIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12100
X-Proofpoint-ORIG-GUID: DK2DXP8C8yZ7cms9xFp3-4Ea_tlmh0yl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA3OCBTYWx0ZWRfX3CEIWdY+2tCI
 H/JROERai5cjXWYjsFz9KINKUGqoLv2rrm4QNoj2SQ3grwyJxRDngPpmpbHPClq6LmMUDMtpop+
 zgWAfS+3O+uQEIUcBB4NGX3hW7EFnpJSFlA0rrRHkuL168RRdFME29squNjMMBMur3xEYVRq+XQ
 xESI2t8vjp85Uzj8+dK3ivDR9vgE9OGuscInnTXnc4VDJpIf4I6xEl6L/89wW4xSLDKp3XCmqfY
 I2VR4hJoMjXFpMwG70weCItgueP3ytiOmOA+I971tEJ9B9mFxllNPyncSBxsrK2E8rIMGXt6xQ7
 BLnL7/Pea83LyFWIxkiESr0zJvEaCin6tNsnIj9ujGaA56wHEfWP6wGb8x7h2RhlE8uO24lMEA9
 /BNJZGgfz1HvWKY3MXvYZsZxD6aTzAK4v1XGlgNQQElzH7HxvCY=
X-Proofpoint-GUID: DK2DXP8C8yZ7cms9xFp3-4Ea_tlmh0yl

On Tue, Nov 11, 2025 at 01:19:37AM -0800, Chris Li wrote:
> On Mon, Nov 10, 2025 at 3:28 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > > > > I kind of wish the swap system could still use swp_entry_t. At least I
> > > > > don't see any complete reason to massively rename all the swap system
> > > > > code if we already know the entry is the limited meaning of swap entry
> > > > > (device + offset).
> > > >
> > > > Well the reason would be because we are trying to keep things consistent
> > > > and viewing a swap entry as merely being one of the modes of a softleaf.
> > >
> > > Your reason applies to the multi-personality non-present pte entries.
> > > I am fine with those as softleaf. However the reasoning does not apply
> > > to the swap entry where we already know it is for actual swap. The
> > > multi-personality does not apply there. I see no conflict with the
> > > swp_entry type there. I argue that it is even cleaner that the swap
> > > codes only refer to those as swp_entry rather than softleaf because
> > > there is no possibility that the swap entry has multi-personality.
> >
> > Swap is one of the 'personalities', very explicitly. Having it this way hugely
> > cleans up the code.
> >
> > I'm not sure I really understand your objection given the type will be
> > bit-by-bit compatible.
>
> Just to clarify. I only object to the blanket replacing all the
> swp_entry_t to softleaf_t.
> It seems you are not going to change the swp_entry_t for actual swap
> usage, we are in alignment then.

Ack yes :)

>
> BTW, about the name "softleaf_t", it does not reflect the nature of
> this type is a not presented pte. If you have someone new to guess
> what does  "softleaf_t" mean, I bet none of them would have guessed it
> is a PTE  related value. I have considered  "idlepte_t", something
> given to the reader by the idea that it is not a valid PTE entry. Just
> some food for thought.

It's not a PTE value, it's an abstracted representation of a leaf entry,
hence leaf, and as relevant to the software interpretation of leaf entries,
hence soft :)

We also encode PMD entries so that'd be totally wrong.

We do make sure any PTE/PMD related stuff is prefixed appropriately
e.g. pte_xxx(), pmd_xxx().

>
> > I'll deal with this when I come to this follow-up series.
> >
> > As I said before I'm empathetic to conflicts, but also - this is something we
> > all have to live with. I have had to deal with numerous conflict fixups. They're
> > really not all that bad to fix up.
> >
> > And again I'm happy to do it for you if it's too egregious.
> >
> > BUT I'm pretty sure we can just keep using swp_entry_t. In fact unless there's
> > an absolutely compelling reason not to - this is exactly what I"ll do :)
>
> Good.
>
> > > > So this series will proceed as it is.
> > >
> > > Please clarify the "proceed as it is" regarding the actual swap code.
> > > I hope you mean you are continuing your series, maybe with
> > > modifications also consider my feedback. After all, you just say " But
> > > I did think perhaps we could maintain this type explicitly for the
> > > _actual_ swap code."
> >
> > I mean keeping this series as-is, of course modulo changes in response to review
> > feedback.
> >
> > To be clear - I have no plans whatsoever to change the actual swap code _in this
> > series_ beyond what is already here.
> >
> > And in the follow-up that will do more on this - I will most likely keep the
> > swp_entry_t as-is in core swap code or at least absolutely minimal changes
> > there.
>
> Ack
>
> > And that series you will be cc'd on and welcome of course to push back on
> > anything you have an issue with :)
> >
> > >
> > > > However I'm more than happy to help resolve conflicts - if you want to send
> > > > me any of these series off list etc. I can rebase to mm-new myself if
> > > > that'd be helpful?
> > >
> > > As I said above, leaving the actual swap code alone is more helpful
> > > and I consider it cleaner as well. We can also look into incremental
> > > change on your V2 to crave out the swap code.
> >
> > Well I welcome review feedback.
> >
> > I don't think I really touched anything particularly swap-specific that is
> > problematic, but obviously feel free to review and will absolutely try to
> > accommodate any reasonable requests!
> >
> > >
> > > >
> > > > >
> > > > > Does this renaming have any behavior change in the produced machine code?
> > > >
> > > > It shouldn't result in any meaningful change no.
> > >
> > > That is actually the reason to give the swap table change more
> > > priority. Just saying.
> >
> > I'm sorry but this is not a reasonable request. I am being as empathetic and
> > kind as I can be here, but this series is proceeding without arbitrary delay.
> >
> > I will do everything I can to accommodate any concerns or issues you may have
> > here _within reason_ :)
>
> I did not expect you to delay this. It is just expressing the
> viewpoint that this is internal clean up for benefit the developers
> rather than the end users.

I don't agree with this interpretation - this directly benefits everybody,
I've seen LOTS of bugs and issues that have arisen from misunderstanding of
internal kernel components or because somebody understandably missed
open-coded stuff or 'implicit' assumptions.

In fact it's an ongoing theme of (understandable) kernel developer
confusion resulting in bugs, instability, performance regressions and the
inability to extend or improve functionality.

I've repeatedly seen very significant negative impact in every measurable
metric from poorly structured and implemented code throughout my career,
and the exact opposite for the opposite.

So running counter to this, this series directly improves things for the
end user AS WELL as improving internal kernel developer happiness :)

For instance - the mmap 'cleanup' literally resolved a zero-day securiy
flaw.

I think it's very unfortunate that we overload the term 'cleanup' to both
describe 'fundamentally changing how parts of a subsystem operation' and
'typo fixes'. But anyway. I shall stop going on ;)

>
> Keep the existing swp_entry_t for the actual core swap usage is within
> reasonable request. We already align on that.

Yup, but within reason. I'm not going to duplicate pte_to_swp_entry() just
to satisfy this, and the swap code touches some softleaf stuff (e.g. not
processing non-swap stuff), but the idea is to keep it to a sensible
minimum.

Everything will be bit-for-bit compatible and have zero impact on the swap
implemenetation.

But yes intent is the _vast majority_ of the swap code stays exactly as it
is.

Future changes are really going to be focused on actually softleaf stuff
generally.

I hope to stop having leafops.h include swapops.h and then have swap stuff
include both and have the types be different _from C type safety
perspective_ but still bit-for-bit compatible so we just have a
satisfy-the-compiler conversion funtion that'll be a nop in generated
binary.

But all that's for future series :)

>
> Chris

Thanks, Lorenzo

