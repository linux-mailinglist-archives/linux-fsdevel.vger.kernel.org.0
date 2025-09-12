Return-Path: <linux-fsdevel+bounces-61029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC7DB54983
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B644C17B4D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C912EA499;
	Fri, 12 Sep 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qmDf+BUN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uKAuzopr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960B136672;
	Fri, 12 Sep 2025 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672383; cv=fail; b=YYyOzryWAj7h53B2BklvTEf+6/ak7AzGYSB6gKbjK7CTeU+r9j5eIQlihJK0t2pazpHWLib+5iw6oVPl6VTuY7Tep5M5/juB39Bix/IdTPkjpkqCJTONPwQIkAyPplQ/8ghISzD3goXAlJvUE/CZMJNp2oBP6Lw0EvXbvpYS8EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672383; c=relaxed/simple;
	bh=vtRbT1CTdQaKqWspNgAOg9kNOzDgW/YoGnGsMpQAP1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EtQmm8nw4shapAA04dLCfRaMMRT9HX4rNtaTxhUgIpu+0OW0ZU/D7dlWYIt+IyQcFjJBUhXJ3037isvyhbpERdPaURp4zp8G2QKe9DpXmtMSgTShYGK2jKssHJTKJSlhiZCwdq0WtQsdn0A47xfhPmsXw5h8Yo2xV1JoKouA1a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qmDf+BUN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uKAuzopr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1tsMn017338;
	Fri, 12 Sep 2025 10:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jX6r33sMvr0LNF82P6
	5KSYJbjNMhMhSygE7yQ2LKK6w=; b=qmDf+BUNRKU+92ZYFbmmEyNXDKVIshni8M
	vleZUGcgocKF9jg01vYQ8A/xEZaVihamkzttSMi+rxRrvxbhnctD6pHy0Hj/OObB
	zapmj0GoPWZ7/mcmeagKoAsKr9ocumD8OzeOytdWanTucinRmIZkgZYLovMD9cKd
	JrQZqb8F6Bb5kYWfg35s5ZraD06qjEyMMdIyTL77l2+Vla1xa/lnvA4HjBHlnHad
	iVaBBruGh6XCWs8AXrS1PyZEDTrUyVuPemQzeuwlGeDmW8qc1zkkytxbwSii3n1P
	IIaeKLDpV7ugqiyNhQm8IrcKosbxI0HO1u8Sc6rIj6SIa1ykIwfw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226syyeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:18:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CA25vg030667;
	Fri, 12 Sep 2025 10:18:49 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddmt6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQbxx0jiU9H6DNmeHTsDZCGH8KU4JDcAUmIn5vr2YqL9bjyR2xGfYl+dm13HJu1qdNIR+JTpXqnYKu4ISjHVjVcGz6GPR1NyLkBNbXGTfWw66BR/umO/X8E4jcF9rRV7U3qda0aLO8aG9966CiGPXa6CJIfPVfrCdkXO+BqX9UTEwfAgwp0bziZoa+eHcOW87ypfyhMU+1S0MEQ1rebQ3tA3f/DiTjqdTagzg2kNDJp2ESfYfn1h67B2ajDWX4pdJ/H5e2QyJjeF0pFHRopaaQ8gE1029lJEg8cSVboxKl8zTzyjSw2QD6cP60sKmQaYHvRfpUlNNrU2rLLBc0BgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jX6r33sMvr0LNF82P65KSYJbjNMhMhSygE7yQ2LKK6w=;
 b=JLYTWC8gyk9ekwwokx+SmRfP6BQHHeUJB1eFLgfsUAzj73hNoO9B55xdiTcvFTXvoNPlxsA42s8eEa3AgnpuLM7sGVbbYQXzKvNC8x5d+bVZZAV7h4D0cIeZI+1FGXs2ioIt6wKf+p2ufN/jFSvPSyzRAuEPD7aJubfipPBYe0MBrJLYSwXIMcre9zV6n+EhDO17h/YaIe6JpR0ANPwXtz9ZFUJv4PtBDyV5deCN9DQt3op4AGzv9CySofnPj/HWxn+JqOR951xB5qngy4UiDJ7sn0YC1jfjXqtI4Z7uzOJ3xUYHkrrAwuVDUloO/D4T92DKt4tevLQvUbHDXtbqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX6r33sMvr0LNF82P65KSYJbjNMhMhSygE7yQ2LKK6w=;
 b=uKAuzopropCClY/e8q91Tqb5fh80Dtt2x+WyBwPeg9LBJhsLQAmmxUwFvqt309MMF9fki6tdoxi1xwUIOGtJldvKcH1hSubKurKFiibLqciU17vi4rccuFniA1HOw0ABFeH4Zw5wTSNCQuE7e7kjek6YWfp5lCc8ftX5MyBsdz4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:18:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 10:18:45 +0000
Date: Fri, 12 Sep 2025 11:18:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <c7ae6643-f9bf-446f-a046-72ae2c8ff87c@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
 <dce30be7-90d3-4a6a-9b26-44d76c3190a0@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce30be7-90d3-4a6a-9b26-44d76c3190a0@intel.com>
X-ClientProxiedBy: LO4P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 710d88a8-aff1-4ce9-54b0-08ddf1e5c1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dv6OCLaursfV2aDnQekuj0OjnNgUmjXiAIDW3fZv3mbszm8W46FrXVPrzVn+?=
 =?us-ascii?Q?pY4OZa6oU1AgGOucRCVklFfwx4CIsDP47sP4bVMA3UItAVnlPaLVZHY1azKM?=
 =?us-ascii?Q?CO992dYOTPPH1deCT66ILcfVUDRPgO0iG0XTHr6ZU69rC2WDq9YCyZfNiycT?=
 =?us-ascii?Q?eGgLkqI/RMdCfI5CuQ6VCxvnOkbuTI9/FNqluIlJHPKEnogKyvOQb3tTKDj9?=
 =?us-ascii?Q?aAb+uBS8eCNXLY6Xu8cM2mQfZyM0MTqFuhJrC2gHLhxpM4uJ5zM4FM5nvqWJ?=
 =?us-ascii?Q?XEc6Udj4dCgUhDS6KIV1SXojvmQI4vTiisyKuFz94oYjsv/Ly/4neZ6hBeZZ?=
 =?us-ascii?Q?HVs8aoXgJlr8m2U4lz2j753Y2Fig47fW8mpZOF6iNUoHjlshtjiPZRGe51DU?=
 =?us-ascii?Q?uGc7am1QwTksWotZwxYHDKpON2OKr/fY8qwxMGl6IOSZt2cxXjNnPMmJwhmw?=
 =?us-ascii?Q?DIYgY7f19etYJ4j4JR6t3t4sOhLNl0WC7uazu8o7YzExFgLvxWgsQr9k4mmy?=
 =?us-ascii?Q?1zWZDPxU6PoGLlQeIuPmUdV8LhtE/GYGyGGjjI7klXEXADXZE2xsGQiKlPW7?=
 =?us-ascii?Q?YsF9j/fSfKyxrJN1QlrZJQQ/XC8M9Z6vYrUs2Rh9qaHwx0BkLPUxEHTprhT/?=
 =?us-ascii?Q?661ogTS3VOKRpQ7tniemc2cuZLsx2G+CmNbvSf52Zzw0Wr2w664bXWB2+eFD?=
 =?us-ascii?Q?Q652SIreWB4Sl1hv3S5O+TG7G62PS88dZZVrHFsWhIAajWh10F7/qyf5SKrs?=
 =?us-ascii?Q?gR9apjZMDDisTlTvQ3HYJi9U2We41zGhVf5zKN8sjSnWHOKQkHK+D85rA6jI?=
 =?us-ascii?Q?k7q/1fX1hz8AFEmJHbdGioXDQDbD+eTV/tIjfwXdrwBitSE1xsl1Xjt/rxOG?=
 =?us-ascii?Q?38xBj8LU9wYAw9PBVIim5ggnhTcweWj8l1bPZyS4cmogk0cGhHK3uUs82rrX?=
 =?us-ascii?Q?yyes1aSYmr9X7YsGjcYKlY0aiNRi3ZR5Yv8hGw8sm54jl28DuV0ZOnPfBA9n?=
 =?us-ascii?Q?CvHHWg9PRpOprKm1Koauy9D/Y8muuxleU7XCDD4VYXfpeeyVT0eycljTLuyK?=
 =?us-ascii?Q?VlrJesAacnxLowyJc7gfvsza+jB926mLp/qNgR57y8NMEbCLXp7NEwvkEktL?=
 =?us-ascii?Q?2UMfhYrAdR5rz6tQgLV+qtTSK64ObzoacBYug+CN8tLWJjDOufjZBdeGQmmm?=
 =?us-ascii?Q?ZYwlTlmmAAxBMJhKJB9I45kG1S6gh5u60QQx7axNGX3Kln8QCArCHHRyLBUI?=
 =?us-ascii?Q?mIJUdG+yYz9BtI8CQoXFPBb+txndvl1GHrts9ZsdOPOoMztVW+Y7rzKTIOIn?=
 =?us-ascii?Q?XbaEkd8F0AO+Lzu24b+xVnn7kYMbVENV4aPlLT6xmKvQXizW4OS1eJ4amPNR?=
 =?us-ascii?Q?eWQbi2jDLdezrjugzR06AqutJbR5rsA5c5ZDUahWTBaaWqbA8gVZbMnc7cyk?=
 =?us-ascii?Q?DaogV3b6z8k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4sjjFU1rUKliLZSITRpnmAyunO4K2DmiuXpGC1sdvyD/UcYKm8XK2D0a5oGf?=
 =?us-ascii?Q?LXu4G0DAjFiE++6upwWDvGcqxA7eO5vTTa5KFzMwI3Ze7miNubxVcFIWllLI?=
 =?us-ascii?Q?i65oCmBaYbQhiesuyvsWFHsNg1gZ6MKIW1R2jSDe76w+6ViAHJF9aoyjqtQC?=
 =?us-ascii?Q?37rsiV5ftChaNpGnXZ0oVUrPlDOMOenD8ber4NrnuxJPwt+BClh5REBmpK6t?=
 =?us-ascii?Q?aqARQeJTN/+gQkDhV3OsFCXPE45WbC8Nkx7xzReE51S3Wjm2O876kSURuu+Q?=
 =?us-ascii?Q?xVCikgxYfRTjm3Rb18siTsU7w7vkJ/N1wkdm+Pt8DMCJqrdox2QdQ7rzQhRC?=
 =?us-ascii?Q?wusELEn6F4ccCN849hXzkxUdQTz1BXH135a9J5zAarsMD0yLk+qDKF/rn98E?=
 =?us-ascii?Q?vFMi3aFSAMiUyiwukWjHFFpFbEKxQM44n6754yadL9WOfTalkOmj1J1V+ZiF?=
 =?us-ascii?Q?m5eTThNa2wPYnjCU6CisEqTG3cRaxBuO6OE88CI6qeAd6JHavR8ydEHU7Sqx?=
 =?us-ascii?Q?sHYnODf8TyYwm40luelOxvfHzSobWzwaReIYvuSOX4WYKroiDS8J3JU/Gq+p?=
 =?us-ascii?Q?Gvb9EkOt0OyyPIwOzIYMPrYxYcsM+LH3XfFqF4GFdVEzPgMlshjmdwmR1gV6?=
 =?us-ascii?Q?TV3RGtLyfjCNZKry2GOc1k6QruZ/skO4GdVFAQlBiRqLEu0OK00BfS/tcCLI?=
 =?us-ascii?Q?e9KqHQRdZSKqSLRcG5d622VziI2gxmMAPOGFPJthy7Mp4rZXDzzZwyRethWy?=
 =?us-ascii?Q?Wzix/DnKwXyV5596fn5E5qixrYnq9eYbbpV3btrbcYLKQRiOdjCB413jMSwV?=
 =?us-ascii?Q?ijH55HRI+ynfbBbQjBgqtSaMXsqHr6youZI6zLrnIkU6gQTaYhymRfozkrAV?=
 =?us-ascii?Q?Uo5dFGLTr5lkEhAtlgseuMldGo30x4UmVSwS6LP7hYUg/dDF+lq7b+K4ZfzY?=
 =?us-ascii?Q?y038iFN1DvQHYdS/XQ0PQRB3WTbPaxiXSnfb14Qgt8RVVDCLRZi54gvSgaRd?=
 =?us-ascii?Q?r9I4h8L8E64ZeoOHqZUWdd1CFNCC2Ne+FzsINSaQ3QlAFrUaHsdCGHy28iOW?=
 =?us-ascii?Q?5hIRu2mQulEW2d8fAxAC/3hEGAKOmyARj2+s918SGnuYKK/UMTDR8eqIW8YD?=
 =?us-ascii?Q?7bPPGW90R2MjM2gEi7K3j4v28Hw2GOVen6R7k2UCDFTzpb2NCbA5iZsysVK9?=
 =?us-ascii?Q?9AClrr4Yc72ArMnkzYsYo9rQeZHXoYwYtPJFNXnYjKcqKWMfThPJSBaHagDt?=
 =?us-ascii?Q?RTtnFY3rGp+HMHzB8ZZm3k11Jg/e41oQ3fb58zvLp9qqLhJmuHO6VEAvIMZp?=
 =?us-ascii?Q?9PklpWh0izVjKnIMKvhNiKIq4EYHebfCDWbLHRzA5+2KDcFJBbz79Yp2vtt6?=
 =?us-ascii?Q?m0Fbujs9kNzmRBkefnkSOXwLGyQoKc16NUjrAX6bQthwc0j1lf7XtvfAoNjz?=
 =?us-ascii?Q?hhQQLE9lr9Hoz5O9kOVVwgpH2EOoH+7IagTnmS6YJ/yYXgkpdG3TASdUiisI?=
 =?us-ascii?Q?inmJlaOj/biqCDs8L1ikq07i9jKlpXxKEgrT5riDUj1YOq6VO1vE7mhOdQDs?=
 =?us-ascii?Q?7wrQ+emt7JaCyK62H+nEoF+hlrHoBJsBGZc6LTYUrOAlvTs4ZTXtyUoKxkIz?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gTKnYhHwrhBODx9kJJOINYNklqpQZqRZ3UcjmLa+mfdIA2sYb5p3abBIil9oPy9Op8Hel620yNXQ7ztHWMcIgo7zws56EZ6n89kpJHDpWwXYRqToyaM0Pfd1VIyoB8U1LL21g1Hu7RzSzR9o9EAJ3PhAgEf23GYf3HxkmjpG2Gs35/fu8rUM3gOqOiru7vMbE9/pVMrj+MsiuL9UY2MWypFxdKTsxdv5FCsqlM2CK6LexszEpkjimd6jbhMn2noNFILU1xYJiyRBhGUWMQmUSdBxOdWczbTPIAnZB0IOINpLm0Z33WO/3NTiZFlDW2Wpo6t+rVXCvPRvmvUIPtqjXz5+FOfxwtTzOFJKNHHmxMw3sUnqANMS4NycFscqZ3IAxqx+Ye+iPrqtlYgH4AJ7TDN2nNYkzFAKbj/C3DubX2ufet2Sc5WyP67i9yYF4cWFpJTgik8w+UjUSDS4lCrQlhY/zk5VS0043AlBwmrZH8cv3auNLHv80EPSUbTkUiRLEQKd3N50iqGfajl7bcR5kHBzHBawkHnNHCYUDa2wijMhTs9KeNiTkbNAX4kZVRQ7tkFHNJ1HRkCWkNzGngbDUsFmngDWOxOfyCfN/Fkp5kM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710d88a8-aff1-4ce9-54b0-08ddf1e5c1c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:18:45.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDqWsPDrgXDZES69G8RAzM41r+AkOxKuhkpbVP+jehq7Rk2YxNhFh9LyNXYKjQkO5pJEuWwrV74B1hKcJ7rjo5N1+cgdxzEcYX5fot8qk+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509120097
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c3f38e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=r6C59EgA_q0__gwBQGgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Fr4T8mX-YdnNip1VBCbEcHuwtDR0nR6E
X-Proofpoint-GUID: Fr4T8mX-YdnNip1VBCbEcHuwtDR0nR6E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX5evfhbt/WB48
 Zqb1s4sepCZflMFo4VO6p87IFkbXkILKRUJdS3i0tA1H5YzByiVSCqH63+D49Bo4Q4hXI+jrHbK
 wNhV6dg/m1Gx9gY4BTM8QLzYSC1sh2ChQrnpb6RJAQI+Z0ldygyiT0gSeC32HBjNM8E/tWIMXIp
 BSJ1WWWwVb95fhuY4gh1mdw64BYjKeSh7GWyvVXY+9GEZfYR6FjEfMAwQt5eE5kEUTtP4cYwqcH
 /c0LhvhjouzDLosGhZDfvXPuiaWiyVa8mr/hJ0QXWQXKQ+9vzBjjxDPeOP7G1oZo8DatfSLa+iY
 s7Q3mqKVDsYD/mToW4NOQDd28jNhaENCsh1z8Yv83u7fF8uyWOT+cKh8M9z8yR5fD79TVmzSwWD
 zrG6BmGj

On Thu, Sep 11, 2025 at 03:07:21PM -0700, Reinette Chatre wrote:
> Hi Lorenzo,
>
> On 9/10/25 1:22 PM, Lorenzo Stoakes wrote:
>
> ...
>
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 4a441f78340d..ae6c7a0a18a7 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -770,6 +770,64 @@ struct pfnmap_track_ctx {
> >  };
> >  #endif
> >
> > +/* What action should be taken after an .mmap_prepare call is complete? */
> > +enum mmap_action_type {
> > +	MMAP_NOTHING,		 /* Mapping is complete, no further action. */
> > +	MMAP_REMAP_PFN,		 /* Remap PFN range based on desc->remap. */
> > +	MMAP_INSERT_MIXED,	 /* Mixed map based on desc->mixedmap. */
> > +	MMAP_INSERT_MIXED_PAGES, /* Mixed map based on desc->mixedmap_pages. */
> > +	MMAP_CUSTOM_ACTION,	 /* User-provided hook. */
> > +};
> > +
> > +struct mmap_action {
> > +	union {
> > +		/* Remap range. */
> > +		struct {
> > +			unsigned long addr;
> > +			unsigned long pfn;
> > +			unsigned long size;
> > +			pgprot_t pgprot;
> > +		} remap;
> > +		/* Insert mixed map. */
> > +		struct {
> > +			unsigned long addr;
> > +			unsigned long pfn;
> > +			unsigned long num_pages;
> > +		} mixedmap;
> > +		/* Insert specific mixed map pages. */
> > +		struct {
> > +			unsigned long addr;
> > +			struct page **pages;
> > +			unsigned long num_pages;
> > +			/* kfree pages on completion? */
> > +			bool kfree_pages :1;
> > +		} mixedmap_pages;
> > +		struct {
> > +			int (*action_hook)(struct vm_area_struct *vma);
> > +		} custom;
> > +	};
> > +	enum mmap_action_type type;
> > +
> > +	/*
> > +	 * If specified, this hook is invoked after the selected action has been
> > +	 * successfully completed. Not that the VMA write lock still held.
>
> A typo that may trip tired eyes: Not -> Note ? (perhaps also "is still held"?)
> (also in the duplicate changes to tools/testing/vma/vma_internal.h)

Yeah good catch! Will fix if respin :)

Cheers, Lorenzo

