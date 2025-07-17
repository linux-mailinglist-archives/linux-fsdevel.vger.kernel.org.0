Return-Path: <linux-fsdevel+bounces-55288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5812B094D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 21:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C931B18879ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5D2FEE15;
	Thu, 17 Jul 2025 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y1x4MR+U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m5ttrchq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F42135B8;
	Thu, 17 Jul 2025 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779915; cv=fail; b=WwV8ShIRO8sn5SL2i+OVw2E+7/IBzKkINZt9XWViV5nlOm/pscFszXBfWOUZ3paSsrUbiF6R+bK/UBn1vbYJa7HuAwiBoegTRHjp0G6PU9rVWWahLzrMzsb49Aoust9aFckC+xhfgcE2DrPU/dlXPIYDIq1RfXlsQ+j4gsHpsEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779915; c=relaxed/simple;
	bh=S730uWnUgRrTqtw+eQUje0TRiRn5otg3hG6oNJ0Ak1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ui1Aov+PQzLAS9AhjzwBJw0/ak1j9N9ifp5pNtfYx5GrUCosDkBWWdflD4aFyysa74SVKrAQDA/RNhNgB8nx1BcEJhXzwqEg4NILfAds9BvwE3/swPhRhc9UxEgujyTUIwgv6/8Wmz3PX7DHkf3enOloVdA3fRS6wZUws2nxUlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y1x4MR+U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m5ttrchq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HItsGh006181;
	Thu, 17 Jul 2025 19:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MY4NuNLCzdZSiiawmc
	a7oQI6sqTq0ssuSMaDFunktKU=; b=Y1x4MR+U3TZK5F/pmLB5LPOeaKUchg10i6
	FM4GXV5h5kGGnGHNikzNq0zDLpo1xq7LK0SGEH5kXt0s6iCiDgUHL9LdseCoPgP/
	9tSdJQ2C/Y7XmArbUkZ8dNZxCIYtbe8MYuk6+Tzp4ArsuCZ/vG9ox2XmT1S8fIsN
	G/XdmJY0pLIFHhC0sNXnZ74CLJqaQucz8SFn6EvbQ19HY9DbsN5+BwaJl1YoD3If
	iGH96s76kKiyQ2sqGhaUtLgYsFB3QjUNAzxf/Di8zbYo3lEO1fr2qVegWK1toTRT
	difJ/IdhJVuHtEmcBIWTzOhVRUQFdAgGzqIxj/ep5aT6FRmfjHEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqvm3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 19:17:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HIpUjl039577;
	Thu, 17 Jul 2025 19:17:52 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d73d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 19:17:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCTknKUv/U7oi3SF/574Kf8Fg06aHhTvKr0cYruRDVr0g6InkzmlDgOJEYLqYg3i9PNFXVd7GFHhOumJJjnTPfIros9/smmdMARFHGAF7+eMfCF78iGd39XgwTtlOLLZzQO3Duf92SZ7DizRjoJfBMsc7xi4wpQdWZqSI0IFYMDh6zOJjhDYhvSRhnPfKH6y0VgeClCg4mLVXCxO7NrWEAhFDl3SHzVqlIWGFvsdzXGwnffvXGMAtNY6gLmyQ8FhSLdOeY4hGu4Q/yRqIFpyKlMnmhJbEGUeY8lE+i4Und0BRgGRQjjfVck0JeuTijb6+U9ovBdU496LVfYRjXdqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY4NuNLCzdZSiiawmca7oQI6sqTq0ssuSMaDFunktKU=;
 b=Ru4uH16A3w8hyJWPQOoRL/d/LAeY9jhaiou1zl9NBMdEOc1cTC29BskZmRlEKj9zs0fk/8lghxjLm4/1AQph5ib5Cm6trppu3HUPHyVYZ+iendZz3C30ZftP4XN+VoZVXxS1un5JAlNXhIuKOVB6TrZB4sNWcXVln6tJDePUOlQTSGDKJIf2N6e2gRdUm4p5vLg9ZEZ8/5E6u1ZGtRZRXKJNI2zDLv+W4geFlnQfM656JVm05JtVd8iaRFrBgy85t5pXpFMvMjhWoJh8nc7ZRHZ+AclrCI4zxUu8tBwNSdXOVWki/K3op1ThIY3FhDKVlc20QQVlsAe8nBXZafF12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY4NuNLCzdZSiiawmca7oQI6sqTq0ssuSMaDFunktKU=;
 b=m5ttrchqrA5+cDa3JQTi0EQ9xaK+Vh4P2PPVjJLQ722AOqykKUQBooSnJxpJPssDAFVrptu0uCg51ELuw8ApdpdMLIpzIpeeiiwCVS5L0exg79o5RREMOvUy0EsKMsBVm/URQ508SEkLrfMm4gJvfs8NiunXJvGGKDhRnxAxZiI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5154.namprd10.prod.outlook.com (2603:10b6:208:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 19:17:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 19:17:48 +0000
Date: Thu, 17 Jul 2025 20:17:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 6/9] mm/memory: convert print_bad_pte() to
 print_bad_page_map()
Message-ID: <73702a7c-d0a9-4028-8c82-226602eb3286@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-7-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-7-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0214.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 999117c9-2ea9-4b0e-7111-08ddc5669dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K34Pk8X3UJ88ofyn++qdYYVSp/P+yZkjpyt/1prIZmcdH8tOqDP65hjpP/Uw?=
 =?us-ascii?Q?GOQb38iVtDfwIOO+MjBdRvPLo17/4GRD1hXiGNlLL9qjURz0Flp3//ijWquK?=
 =?us-ascii?Q?TRGu3zeL8yCZxC+qSxMzRNeIPuyKbmLsnQKe9gnqq8ntyTZmCW3Ggu62RmTB?=
 =?us-ascii?Q?T8Cv2aL1Af32UwkoyH4Dc5fgWi94h+7lXT/tWYXGieUKwvx1Oz2A6fFPjR35?=
 =?us-ascii?Q?B2pjajxAr0jHC/g/vNlgo78VNrW3TRYzT4dnQltGO+on1N30DoLQjleJpMi4?=
 =?us-ascii?Q?SfW1ipZb1HhFNSByolPuCM5eU1lugj1CKgZNXceoIeDqhZVQ7Squf2UIgmRO?=
 =?us-ascii?Q?C4q5Kup/iJLUdXZv6JMdmKgwNfCAi3+kgIoqy7bqYNJOZ/5YSI93Mgj6gSCn?=
 =?us-ascii?Q?+XjnQpA7kBQyjvBUt4GFxI2pBcqDvmRmGcxOU3zTrmTPP7qZu7IqLTJfs3or?=
 =?us-ascii?Q?WtpaWCfUseNFWUEbhPCiw5Qg6bBazVo60zAwK/ChhnQS4vV+W46KGR8o4N3R?=
 =?us-ascii?Q?/nrGQKF2dmxPCD4WBasZGdV17XDBg9RJ9yTaZv7IDE+U4Cd52mcAET0/fAh0?=
 =?us-ascii?Q?M/PvgxeGukynwojrQofyOgjxm4N8CZ/1sU/YhrcOj3BogcDBKzPB9MsXVLa1?=
 =?us-ascii?Q?JGB1p2hSysypVdtFB4fnVFaPXpeJdL6Tp9WDbLX7JZ3itd8SWlhc0k0nYE6r?=
 =?us-ascii?Q?aON8V61eYCyIADGD9FPpVWRTgAmE1vDvIEXVxym2mxbmbNm+GZxNkbYm6ah+?=
 =?us-ascii?Q?THc+RJYPx3obsLsnmd2LiVJv2SXMWmU8Cfwm44QgrhcuuL8Tljhqb1bU+UrU?=
 =?us-ascii?Q?9BGNSs/ZIiYQF2PzsqmjIPEmnq0Q0tlaZDpSiyvvH/Eh1F9jwZWYJy9xASWb?=
 =?us-ascii?Q?mWZUII8/nqLMPdV0krsi9Efjv0GnIM25LCpyd1nN9xi+2+ryZRHIzBB4PKe9?=
 =?us-ascii?Q?qr+0XJ2u3sQWLJoG/wPCbzIXCPV76wDBxhK6TuoMeFYB2jeabMWhq88Dg6qq?=
 =?us-ascii?Q?83NVevev+tR2dq9tb1te8uYG9ZOhsNt4fZQZYyHsBAQ6izP5OZPy0Eytf34A?=
 =?us-ascii?Q?nwuIpHUmVhRFyad8aMUstH8APAVooHr41cZ/Bkgbq5bXtQpHpAb9tcodGXpJ?=
 =?us-ascii?Q?S1mtn+zk9SU7B61Rh3exl7vWtBoXkufMjmc9PvGBPQ3lluyemkvU2Zos+Heg?=
 =?us-ascii?Q?HZN9F3Bb0sAbBAvB2bvm877VkCsc0PpJh+KqHbTPdzsaxX7VgsRj2KyAxIBE?=
 =?us-ascii?Q?QDp9evrfG7nzGQ4vb63x9sgF5l/cDsBEsGr0GfFttYmdUh3DL91Gtmn2ygJ1?=
 =?us-ascii?Q?UjScmb6KYKAHuwbPcKOUHMxHl/gBV9PCxfuWzaVriJUbKKeU2pSZ8ysvYo4T?=
 =?us-ascii?Q?ZULGEmGdJJs4/iV663gpp7P4Fd6D6P8EqcipNtcPIlU8s0fBab8trf7fuzeZ?=
 =?us-ascii?Q?0Ga5Zykem1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S+T8pSTFo7aH9H7JUIR0UOyDGS5AhxZ7D+S0WbBpfjlJkebEzq+xX4VRAJDs?=
 =?us-ascii?Q?h0KtMn8dnD0EVSAE/jg/TImvDX5OPnBrJeWnHDoEUr6SMNsN/m0nQGjRQXaB?=
 =?us-ascii?Q?B+edDMppTbldQE/+rxLInrQMzhkzDTM+Nx04nEiaqtbrZiLWl4nUo4DbM2uA?=
 =?us-ascii?Q?MGOq+RvBvIsiK/JJoOdF6RHJPq8f0v31yuFH8w4wjAfJNKLwNUV8pb5iM+U9?=
 =?us-ascii?Q?OSdUfwGniFPAVv+NQkqlbO7GD+j83r9kq7YDXSOc1xhEzEVmAiDlPSRo9QOc?=
 =?us-ascii?Q?bPZIYFC9t80dGpBwNqZdUYXgInUfXMiTQSe0ajK37cjt9zWpk0IFqZC+ZWa7?=
 =?us-ascii?Q?jjOmkLrLRiiu+hTXJm+jGU3Oc4hjTSNOC+n6bkQOpA9rjTZ18zTcxxbzLVWz?=
 =?us-ascii?Q?HtqFEOUoynIj55rVQXPeS0kIP52hFESuDMnYqSKUQx8GrrYQCXhZJL9w1KO3?=
 =?us-ascii?Q?WeSuEIDzq2sK9WnXjUYFA5MAYQXXq8SoLTqz4AGWQMCQcjGLn5KiS9hN88aP?=
 =?us-ascii?Q?0Wn+MMfGvHLdbQ+ux5D30Z7yiH5twoOJBN/vfkVjxUOgg1QkDRqsm4f4C3vi?=
 =?us-ascii?Q?bTCfYjhXElH3GymWoobM/JoHU2Ki1iXCWjyOti7UTVnKRgwRg+nAyIe2ZbX9?=
 =?us-ascii?Q?jgfznJsIXXmHBbU0VZ12HdPXXjAQgbeNcO9h4ENFjm8C6YHPjXoFYkdhR42B?=
 =?us-ascii?Q?qSKqICR/r4oxXSGCucaZDB1VT/weuQq5XymFKN+I771mqYhh0CbF+roBf18+?=
 =?us-ascii?Q?8Jh966bJjMxznXCW1zMGPYoCAwfO8ZbU5sPaCvnEZ8xsSW3B9dKBcLW4fr61?=
 =?us-ascii?Q?ZQJDi476eRLthNoUCP4nhali+Q6PjlLfiucGyHLXbEr5LlBpDcbcWASEPdCi?=
 =?us-ascii?Q?Rs96dDI6GbdWJKcc74/qzH4YcxqOAFH6nDwnufOoNEUfzdHFnoad4K/v7PAo?=
 =?us-ascii?Q?NfSVOwfYZiSDp3M/PYoaO+vPt+1nfAh1+kmVtgv696ZpVz1LzN4fq8fdCKZ9?=
 =?us-ascii?Q?braCBL1PB+arrfEt4RZ/KE/DP5VmveKy3XqUGsXD1Dnq3ZBKTkSZ5NoJ8+zi?=
 =?us-ascii?Q?AMO+saTJVMd68NpTtsn586U55wY8ZEuKnfbYbyvqsOZ8l5Ut1C6wHspV9Y3r?=
 =?us-ascii?Q?imWuXQ16PdE7ihYtpWF31oS43J50iKcZeOD5DJI1fzJW1bIu45QYU7MHupfj?=
 =?us-ascii?Q?mn0fUDs981Bc5B009w8J2ytKQfZZ/DtqkmZ+sTbTkciJaVKYXRfpUjsfz1WE?=
 =?us-ascii?Q?fhy/NcMgXyDQNwwKXcN+37oWoFi5QH5vY8cz0mI9ZYmiLg6BHGnhTexXYVsh?=
 =?us-ascii?Q?Nz5EcIScipGn2gdhoThHJeaOcvYsszqnwi0wyJmw1yiC4ZgTpm6RP2w5GlfF?=
 =?us-ascii?Q?CR+3Y52ntrptiokIUVmusGpgPoU53DBJdDmdc4rhznzJzWT2EYpq4nDIq/4U?=
 =?us-ascii?Q?faq7r/P+OWmSSZFGgqQAOTrJHtCU0jlCFyXYuBp9pFCO1sX2N3ZFoh7jgeLD?=
 =?us-ascii?Q?7pQOpJLC11QrGIEAwil9NFQ+EL8Pgl4xxsn9TNIm3+hYQ9XzbZTbr3dPF4BU?=
 =?us-ascii?Q?8PZSYR+UqcpKRnp48Eul/rOrxrQIa70AmbwYx9as9KZm/J6LNEeoU2R5PGNp?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sVtpaSmGTs1WXgIcujrBX/GZRTLDHf30wSM/bJnso5OGHYKPPX/AzULgNvgAoUWKZt0zS0V+gq0cQGdrYcwBrqf/d0njLpirJ2VOQy4ygpvYqZWgg3C81DK4RDEeuKUIGk5+naXxvXJaBxUf1e54kv0vzWc62OA5cT0W3aVOuyF5jTs3xiNHKdWY5lI/7T09X1NmNQLS6pERnAZXE+NwuM0e0GKtE1o9nAYRru/NJP+9K9jGxWKhxLhk5ngA0/ze/IH3vCzS+AZsII22vYdBKBdH8EPwzLV8IT8K1kd7Cc4+pPajFr87v3BOMQWntPxqh95ozNY1y1N87wNS9oIORpsaVJi+xF2GOV5k4czvRJF2SBhh+pXQHuewdbNAQU5O3R4wJB37U+Q4fM2A+Mwq1FatW7EB9TrTHuhSeQgRoHylOUWffuDE5e7Cl6PxHB51oEZfTwSGkYEmFZhAYWbgoBfVUXNjAP7zgMh2GfUlGicthURGNjbFWu5cEr7fPMrxB1WgJf6zdTyNErEXj5kXRws5nCUqhjKQZuk8aoK/gDLgA8jsMx4pVB/Dy8Kz7C3UqI8wEygg4fy8RXtX7akVhWUzY5LRSGtiwVS7B+IzZwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999117c9-2ea9-4b0e-7111-08ddc5669dc6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:17:48.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/raU9e+wYMYIEnIRo3bHtfU/fN5m1acCJeVA9e/e8XcKes8lmK+kraW58H1/hudasPIAnkYxXjmWx4pUtiQTQEDOPYpizWPcQyfEroLB1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170170
X-Proofpoint-GUID: btb92Bti8ahDHRVsxJ9c4F6VDCvh54E3
X-Proofpoint-ORIG-GUID: btb92Bti8ahDHRVsxJ9c4F6VDCvh54E3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3MSBTYWx0ZWRfX4JoR5PAgSynn bZdEtTS/MeHt+M0JXXQkDZlNHvo2HGreNZ/QiSHHN4XfEnB497aW5iPYRfaDrsdz4tcPqtwR+as OR7LGpz8VTMMCLnyW2yIYMbWxvnCHKlpCsxNzvrkYjRM+zM8dptR1UJM0+y4sRuneh0WH32K4M5
 qJDmzKRuldinjOMLg+RjynkJ+L6DbNHasYIZrXpioT8yoGhSCnAl6CxggpB7ZDCE2pI8Oi110Ge Gff+15AVhCmRQUxHD4oUXv6eNQWdAixHxydVcpOIk9bSzoiW1lmL/qn9Pc6qkD8rlGExea5sLGG Eyu3lxnd+y5bCuoIInnLpIe/XwgXHmTI1YynVvIDj09m7kEPQ9jC8xYH9KKUwesdbSbpHi3vr/T
 4UdSwlLmGeQ+vzpS3F4M2pcozQHhD5fXL2PfYVQUlCX6Z1z6XR/kzNfFpuI3CzFKVX5OP/sg
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=68794c61 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=3Y0cYmz_b2OhmTdAttoA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

On Thu, Jul 17, 2025 at 01:52:09PM +0200, David Hildenbrand wrote:
> print_bad_pte() looks like something that should actually be a WARN
> or similar, but historically it apparently has proven to be useful to
> detect corruption of page tables even on production systems -- report
> the issue and keep the system running to make it easier to actually detect
> what is going wrong (e.g., multiple such messages might shed a light).
>
> As we want to unify vm_normal_page_*() handling for PTE/PMD/PUD, we'll have
> to take care of print_bad_pte() as well.
>
> Let's prepare for using print_bad_pte() also for non-PTEs by adjusting the
> implementation and renaming the function -- we'll rename it to what
> we actually print: bad (page) mappings. Maybe it should be called
> "print_bad_table_entry()"? We'll just call it "print_bad_page_map()"
> because the assumption is that we are dealing with some (previously)
> present page table entry that got corrupted in weird ways.
>
> Whether it is a PTE or something else will usually become obvious from the
> page table dump or from the dumped stack. If ever required in the future,
> we could pass the entry level type similar to "enum rmap_level". For now,
> let's keep it simple.
>
> To make the function a bit more readable, factor out the ratelimit check
> into is_bad_page_map_ratelimited() and place the dumping of page
> table content into __dump_bad_page_map_pgtable(). We'll now dump
> information from each level in a single line, and just stop the table
> walk once we hit something that is not a present page table.
>
> Use print_bad_page_map() in vm_normal_page_pmd() similar to how we do it
> for vm_normal_page(), now that we have a function that can handle it.
>
> The report will now look something like (dumping pgd to pmd values):
>
> [   77.943408] BUG: Bad page map in process XXX  entry:80000001233f5867
> [   77.944077] addr:00007fd84bb1c000 vm_flags:08100071 anon_vma: ...
> [   77.945186] pgd:10a89f067 p4d:10a89f067 pud:10e5a2067 pmd:105327067
>
> Not using pgdp_get(), because that does not work properly on some arm
> configs where pgd_t is an array. Note that we are dumping all levels
> even when levels are folded for simplicity.

Oh god. I reviewed this below. BUT OH GOD. What. Why???

>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 120 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 94 insertions(+), 26 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 173eb6267e0ac..08d16ed7b4cc7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -473,22 +473,8 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
>  			add_mm_counter(mm, i, rss[i]);
>  }
>
> -/*
> - * This function is called to print an error when a bad pte
> - * is found. For example, we might have a PFN-mapped pte in
> - * a region that doesn't allow it.
> - *
> - * The calling function must still handle the error.
> - */
> -static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> -			  pte_t pte, struct page *page)
> +static bool is_bad_page_map_ratelimited(void)
>  {
> -	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
> -	p4d_t *p4d = p4d_offset(pgd, addr);
> -	pud_t *pud = pud_offset(p4d, addr);
> -	pmd_t *pmd = pmd_offset(pud, addr);
> -	struct address_space *mapping;
> -	pgoff_t index;
>  	static unsigned long resume;
>  	static unsigned long nr_shown;
>  	static unsigned long nr_unshown;
> @@ -500,7 +486,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  	if (nr_shown == 60) {
>  		if (time_before(jiffies, resume)) {
>  			nr_unshown++;
> -			return;
> +			return true;
>  		}
>  		if (nr_unshown) {
>  			pr_alert("BUG: Bad page map: %lu messages suppressed\n",
> @@ -511,15 +497,87 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  	}
>  	if (nr_shown++ == 0)
>  		resume = jiffies + 60 * HZ;
> +	return false;
> +}
> +
> +static void __dump_bad_page_map_pgtable(struct mm_struct *mm, unsigned long addr)
> +{
> +	unsigned long long pgdv, p4dv, pudv, pmdv;

> +	p4d_t p4d, *p4dp;
> +	pud_t pud, *pudp;
> +	pmd_t pmd, *pmdp;
> +	pgd_t *pgdp;
> +
> +	/*
> +	 * This looks like a fully lockless walk, however, the caller is
> +	 * expected to hold the leaf page table lock in addition to other
> +	 * rmap/mm/vma locks. So this is just a re-walk to dump page table
> +	 * content while any concurrent modifications should be completely
> +	 * prevented.
> +	 */

Hmmm :)

Why aren't we trying to lock at leaf level?

We need to:

- Keep VMA stable which prevents unmap page table teardown and khugepaged
  collapse.
- (not relevant as we don't traverse PTE table but) RCU lock for PTE
  entries to avoid MADV_DONTNEED page table withdrawal.

Buuut if we're not locking at leaf level, we leave ourselves open to racing
faults, zaps, etc. etc.

So perhaps this why you require such strict conditions...

But can you truly be sure of these existing? And we should then assert them
here no? For rmap though we'd need the folio/vma.

> +	pgdp = pgd_offset(mm, addr);
> +	pgdv = pgd_val(*pgdp);

Before I went and looked again at the commit msg I said:

	"Shoudln't we strictly speaking use pgdp_get()? I see you use this
	 helper for other levels."

But obviously yeah. You explained the insane reason why not.

> +
> +	if (!pgd_present(*pgdp) || pgd_leaf(*pgdp)) {
> +		pr_alert("pgd:%08llx\n", pgdv);
> +		return;
> +	}
> +
> +	p4dp = p4d_offset(pgdp, addr);
> +	p4d = p4dp_get(p4dp);
> +	p4dv = p4d_val(p4d);
> +
> +	if (!p4d_present(p4d) || p4d_leaf(p4d)) {
> +		pr_alert("pgd:%08llx p4d:%08llx\n", pgdv, p4dv);
> +		return;
> +	}
> +
> +	pudp = pud_offset(p4dp, addr);
> +	pud = pudp_get(pudp);
> +	pudv = pud_val(pud);
> +
> +	if (!pud_present(pud) || pud_leaf(pud)) {
> +		pr_alert("pgd:%08llx p4d:%08llx pud:%08llx\n", pgdv, p4dv, pudv);
> +		return;
> +	}
> +
> +	pmdp = pmd_offset(pudp, addr);
> +	pmd = pmdp_get(pmdp);
> +	pmdv = pmd_val(pmd);
> +
> +	/*
> +	 * Dumping the PTE would be nice, but it's tricky with CONFIG_HIGHPTE,
> +	 * because the table should already be mapped by the caller and
> +	 * doing another map would be bad. print_bad_page_map() should
> +	 * already take care of printing the PTE.
> +	 */

I hate 32-bit kernels.

> +	pr_alert("pgd:%08llx p4d:%08llx pud:%08llx pmd:%08llx\n", pgdv,
> +		 p4dv, pudv, pmdv);
> +}
> +
> +/*
> + * This function is called to print an error when a bad page table entry (e.g.,
> + * corrupted page table entry) is found. For example, we might have a
> + * PFN-mapped pte in a region that doesn't allow it.
> + *
> + * The calling function must still handle the error.
> + */

We have extremely strict locking conditions for the page table traversal... but
no mention of them here?

> +static void print_bad_page_map(struct vm_area_struct *vma,
> +		unsigned long addr, unsigned long long entry, struct page *page)
> +{
> +	struct address_space *mapping;
> +	pgoff_t index;
> +
> +	if (is_bad_page_map_ratelimited())
> +		return;
>
>  	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
>  	index = linear_page_index(vma, addr);
>
> -	pr_alert("BUG: Bad page map in process %s  pte:%08llx pmd:%08llx\n",
> -		 current->comm,
> -		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
> +	pr_alert("BUG: Bad page map in process %s  entry:%08llx", current->comm, entry);

Sort of wonder if this is even useful if you don't know what the 'entry'
is? But I guess the dump below will tell you.

Though maybe actually useful to see flags etc. in case some horrid
corruption happened and maybe dump isn't valid? But then the dump assumes
strict conditions to work so... can that happen?

> +	__dump_bad_page_map_pgtable(vma->vm_mm, addr);
>  	if (page)
> -		dump_page(page, "bad pte");
> +		dump_page(page, "bad page map");
>  	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
>  		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
>  	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
> @@ -597,7 +655,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  		if (is_zero_pfn(pfn))
>  			return NULL;
>
> -		print_bad_pte(vma, addr, pte, NULL);
> +		print_bad_page_map(vma, addr, pte_val(pte), NULL);
>  		return NULL;
>  	}
>
> @@ -625,7 +683,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>
>  check_pfn:
>  	if (unlikely(pfn > highest_memmap_pfn)) {
> -		print_bad_pte(vma, addr, pte, NULL);
> +		print_bad_page_map(vma, addr, pte_val(pte), NULL);

This is unrelated to your series, but I guess this is for cases where
you're e.g. iomapping or such? So it's not something in the memmap but it's
a PFN that might reference io memory or such?

>  		return NULL;
>  	}
>
> @@ -654,8 +712,15 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  {
>  	unsigned long pfn = pmd_pfn(pmd);
>
> -	if (unlikely(pmd_special(pmd)))
> +	if (unlikely(pmd_special(pmd))) {
> +		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> +			return NULL;

I guess we'll bring this altogether in a later patch with vm_normal_page()
as getting a little duplicative :P

Makes me think that VM_SPECIAL is kind of badly named (other than fact
'special' is nebulous and overloaded in general) in that it contains stuff
that is -VMA-special but only VM_PFNMAP | VM_MIXEDMAP really indicates
specialness wrt to underlying folio.

Then we have VM_IO, which strictly must not have an associated page right?
Which is the odd one out and I wonder if redundant somehow.

Anyway stuff to think about...

> +		if (is_huge_zero_pfn(pfn))
> +			return NULL;
> +
> +		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
>  		return NULL;
> +	}
>
>  	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
>  		if (vma->vm_flags & VM_MIXEDMAP) {
> @@ -674,8 +739,10 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>
>  	if (is_huge_zero_pfn(pfn))
>  		return NULL;
> -	if (unlikely(pfn > highest_memmap_pfn))
> +	if (unlikely(pfn > highest_memmap_pfn)) {
> +		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
>  		return NULL;
> +	}
>
>  	/*
>  	 * NOTE! We still have PageReserved() pages in the page tables.
> @@ -1509,7 +1576,7 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
>  		folio_remove_rmap_ptes(folio, page, nr, vma);
>
>  		if (unlikely(folio_mapcount(folio) < 0))
> -			print_bad_pte(vma, addr, ptent, page);
> +			print_bad_page_map(vma, addr, pte_val(ptent), page);
>  	}
>  	if (unlikely(__tlb_remove_folio_pages(tlb, page, nr, delay_rmap))) {
>  		*force_flush = true;
> @@ -4507,7 +4574,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		} else if (is_pte_marker_entry(entry)) {
>  			ret = handle_pte_marker(vmf);
>  		} else {
> -			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
> +			print_bad_page_map(vma, vmf->address,
> +					   pte_val(vmf->orig_pte), NULL);
>  			ret = VM_FAULT_SIGBUS;
>  		}
>  		goto out;
> --
> 2.50.1
>

