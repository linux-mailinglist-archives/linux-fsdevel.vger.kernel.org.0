Return-Path: <linux-fsdevel+bounces-60839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C4FB521E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F410F7BAD49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29902FE58C;
	Wed, 10 Sep 2025 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DJg4eRCM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ASaT0Qlz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0E2FB633;
	Wed, 10 Sep 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535804; cv=fail; b=V2ZuBjZlFq1U99fUbfRjHVfHRBtfjI7NaeOHqnsuiK3yJNnJXwC9AnfAVjD/xAWyO8nMQK2Ji9V8MLlWRon1DPnXQx9x+C+Vwpl+W3a6PFgg5fyPRiOzXvKRaCZBHTCU59P7N/5nFUqmQIvHV+CLG4b+ZhKZGQzzKEFm3zUMaPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535804; c=relaxed/simple;
	bh=p8SWiLSqRYUUS/tzzEdlclpVNIvDTSSMePa3PlsKnx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZbRMHtXDqZpdmRCeIeuNezh8gISBiOEhrcTHRCGE39HhesnDR99BwVHQeEy98fghCPena7yr1g9WH4Ayq52fOx02aWwsrLNUMDAPVgcFtaqVQgFxwooIOrY3BuxGv4UOa0KxwDx4Hoxg1nrF8yDSVfm+iJGeH1kGy9E5/os0O5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DJg4eRCM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ASaT0Qlz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfjnb031746;
	Wed, 10 Sep 2025 20:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W30YNRG8/lpU89Law2KHsxlhvmZdHGHDHObMYfthywc=; b=
	DJg4eRCMPY6pGUJ4fHqzq3iljOpLGaGPyu/27yjzLeN18uMtSYn594n20rkDLoBv
	uH1XtQchoFHjSXQNiaSRP918fS51twSNTFhiPnqTjHMnRnuysbzpH2dnSOmHL8WM
	JhG9a+nugPj9ZbE/2fmv+REIQ8pdgb/R0oE/GB8ak+v7XXGREydpGYjW1ojixnEX
	VmJGbUfdJqT4LXpIVN8jFyLI8t3V65ysaKYb8nrN4dXCa+0Nnn9QqpRvJAClQK7V
	3TjZF+a0SYU5SvKN8dC7AAD8j89vIuVjBr2QJKqRsvWbECznNxB9PdxVkc7qYwxm
	1R2OkA+So0xbKZsughqiyw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2vyxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AJImr6032819;
	Wed, 10 Sep 2025 20:22:43 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcg0rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqGyrFr/pyZ4H9GyQBoYEEQTTWhz5iFxge9FYAKeKCsG24vhhAenUnpV15Ks26aqV+fUDpkpSNS8e2cBMH6HN8Z8iFUcCeESbFZkBjIEwAv2YzO5SAOdKN4XXjoOhVOPvPj16FVJwiyKDPhgIMMTFhMitT2K6fzVlQDNZEohYRGo1krC6UHMFVz8mC7gIrQZZRuaIVFeZUu71D4yVnd4UQOG5JNC8jfueq2Wo2FLzqaAgbQu0JBYgpRHEl/4xi6wpyIDai91vWVhcjOeXe98H6RSMmSadPrQLrL10vP0R4+Ge/T2LzjnQQqPDLYmlM3ejTAf59JxMhMMcFVXtpnDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W30YNRG8/lpU89Law2KHsxlhvmZdHGHDHObMYfthywc=;
 b=oGEjy3DVRMUn1GJs3ICLdBKbvMcQPypm5Fr1/TXiXwdYMB8Ncqc7fSQcg1KYZGs1WWFG9RF7/BU3aVusX3aM8tAWlMmQH7IeAT9cS+zAmVz/GJ7+S16wyl76mkHKGVtPIbTf6DFqEG2tivXrI9g4fttFdwq8DArJOIp0yweakzRqA9j4lEbqhP2/krSczxfwhbLxs47ch9ThPG3idPA6dEFy4KgZ4tCeKCoByEbMqGog+5Nh5jmBlIQ85fGOPNwnbtSpgBeGBPlnZr6WnzzQC/mQrmNeGpH4jclyrCbDGKlWxbwjzPlGpUbgdbstJGcR7TiuKdem5w2RhttnshpY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W30YNRG8/lpU89Law2KHsxlhvmZdHGHDHObMYfthywc=;
 b=ASaT0QlzwxWm9dpFIM5juPyoyZtjF/YW4ir7MD3edW/amfz+kzhxkQ4Yf26ezmZuMXHEzY964VzJK2LQsDM6gR1TFHwGd4o+xnR8ru5c7fpdP4080nuutYyBzTMtyZj/N1GugANp6GfZdjatR4oZHndaHm4+0Dw4DDdISBHwWVg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 20:22:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:22:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
        Reinette Chatre <reinette.chatre@intel.com>,
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
Subject: [PATCH v2 04/16] relay: update relay to use mmap_prepare
Date: Wed, 10 Sep 2025 21:21:59 +0100
Message-ID: <3e34bb15a386d64e308c897ea1125e5e24fc6fa4.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00007A8A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::61a) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: f64202fd-bfc3-404d-1ee3-08ddf0a7c96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?98UnBXIMqNmQoYxI3TuWXMe6V3nZPkXP0hRmJRz+aXEYypEnMLgvyAPPhAqx?=
 =?us-ascii?Q?vV9kf8WMYM608xQiXk/NJDzpFI+BRHQu3ocyyRkyAGGxQ9rxwDaStTpHImnL?=
 =?us-ascii?Q?bME8Dl9qtYJFkWy1HOu0Ilj+AFx1VwRW7X1nr87g6TZvl3fvT+yU0+KpWA1Q?=
 =?us-ascii?Q?GTgvn6BAjzWYJvU9tvFaB/HqQXdmUC8f5NQ64CataiBT+leInJ7+KRJ0q8Yt?=
 =?us-ascii?Q?rgEMorVwA0wdUygM0PxUx7KQ8Con1YzsoJZ9FAqTEEKDTlYkNHPT36qTdLo0?=
 =?us-ascii?Q?U5hR454HUc3wECFzvDQiHjjivisJ45lZVfxO1tVN5EWv1au+zSUllPJhC8pl?=
 =?us-ascii?Q?8iPcK2vO4kECXpPoxry89Uwq+oMSJeIb1WVcLCAylPwk1UHgyEPLY/HapuLN?=
 =?us-ascii?Q?QzgBCKScykpjyYhoj6Yj0HwgKqyJcECARxs6hKc4C0Z7z/Nlt6G9Ag9c9WDy?=
 =?us-ascii?Q?rLjLQOpbr9MfssUH6oSPfWBJ7K8z1rJnjYSD5uD5C6WeWmu1mg5UQbgi0vo9?=
 =?us-ascii?Q?Xc8+d7pm5/xzl6saYqg4ddYzirjvtScu2NyyfQnuNzv4Fv/Vj17pxWLAkzvR?=
 =?us-ascii?Q?Tsp7qap8sTIk4VomyTCvVJd8IWiuN5mK+C7bceycdogFAOYjdoA3c29T2hRT?=
 =?us-ascii?Q?E7s/Yf3vwo6ZzDm0dApVoBM1D7vSjMtrb4QVQYTjlOr0a91NN1XUfJ0sdEgS?=
 =?us-ascii?Q?B09g855UIIuhp8dbqa9ub9QjrQay0lv/iImLr0mzkFILnPx4XcFoaxB3XUCt?=
 =?us-ascii?Q?kJk3seOIacpRTDXjvENuxdqbA3/GZ0CxoAWwX2dp9DVuNxfn62Tms10hoB6V?=
 =?us-ascii?Q?a7LljsshoK9jV2T3GnWw5BRUF3C4FjnvpAaa3sNkmYLiPWVwCzfpaCtejPep?=
 =?us-ascii?Q?bM0pE7NOQTTk5NE1ib+3uTzWG2f3DzOLUuoLrC2BccThsBRboSV7YKnri3ZL?=
 =?us-ascii?Q?DGw2SmObDZNnUm//oaJqV9D5W2Lsipwn8rMD4SPIwKaqKU0lPPFKRerj12rx?=
 =?us-ascii?Q?cko/yY1FFMISbLkgNexLi3zw7bhAj/LSk8H8owaQFiUROuZp1WwPdyOqH+U8?=
 =?us-ascii?Q?YnmDukUAD+e1KmjTppkZtOUCClrQYS7rt7H9a/HS3T1wg1BLNbAPIxNGTzO9?=
 =?us-ascii?Q?MdD4hala6yy4YXuBhreK7KlPmEHMH2dlQjsHUrxAp3qEqblonGaLYXFY0QPd?=
 =?us-ascii?Q?J3HmxHL/nNh8VcWTxTdkCyoocvB0EIWH2g3rD9HomExP3KPmRDQsLcW1rS9B?=
 =?us-ascii?Q?WWBLCTPFdSGW3zBrpZfWrHhhfR1fZJUzjyNFT/iCb/hfPRaeGzDV1ez30d8c?=
 =?us-ascii?Q?DoSlIVCVqJPddXyWgAMplJSa4vcNYBdvGvqWinmHxF0RhTkxa+6Uwziza1xr?=
 =?us-ascii?Q?JOnO5GpHHauhV3QpMaaj4npzGLc2Km/p6f5MCygSiZEuhPz3XWFNA0PBVgr0?=
 =?us-ascii?Q?Si3qC5hCwJE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9twudHJF1wu6JZNbBELsSlsFsutrph4JeiqCToSIKmDf6yYXpcKSYAxrNdC?=
 =?us-ascii?Q?XW0mX7odiZTUTUG53uXgMgJdhk585ZfkRUSpD5MSwEvaZE5cIfVq54OMN8Po?=
 =?us-ascii?Q?nbzYMEIsaf7Axv1YQjD8x5WeBkOAldLCjwWuTpxVmTf7D+OKF+nHoFbBgz88?=
 =?us-ascii?Q?wJPHyBVHpIfVYOwY3eLQAGyYPq+xjINtsM341tPxc5Huc4Rtk63LtHUls86N?=
 =?us-ascii?Q?Ug4KxLosbUrZvx8d+0e411AG4u1gYEgQUU80kFfKfrtsilTSoJwEsROzVI8a?=
 =?us-ascii?Q?GEHGu/qNfUaWlasAeuMWiMdxlM83CVgW6UBux83oLV95p/0Gh79oUutov416?=
 =?us-ascii?Q?TtZ1FyujOEkHGpOddIc8zOLbQe2DW8RZp3dRr3JSHkCeICH32t/04ITsFTRb?=
 =?us-ascii?Q?cCuALorm+fNM5UtHwhBNvRZnH56sZzqFe3Azn+VlH9YJpwLLLa/u7LfQVCGK?=
 =?us-ascii?Q?1RaAdOXZPZP/cIlvRz4ftYRBGcjOSBl6DvEECPSqo2MDBQpuntPt0wanoHjE?=
 =?us-ascii?Q?fz6ZBTrrR9x5LlT0LPnWeVgltpACOH1FNQjyB/o37nPNYoOq4adEVU+gTAPv?=
 =?us-ascii?Q?ySs/PLp3AABwinYkdC7uPVywfhpgkVIZ/AnySXtRoNb2V1bKRuRVFahxdO8y?=
 =?us-ascii?Q?9clEqUrsMw+4zZoJlRmmH8XwsAKVA/RcSY0PAlmpPPYokAF33yhUX+eyiPGf?=
 =?us-ascii?Q?nWmoztH3SM3mzlXzhAhzSQ7nVjP3xDGmbkBLG7z+PYX2jV4s0RRuEbhlvpL6?=
 =?us-ascii?Q?cUQjyzutFSEb1wt5V9gdzfN0ZKiYQC4GyEb0Gqf33Fk+NkaUZgIRmCcTNIUK?=
 =?us-ascii?Q?DNvZ1oHV83z93c+vVqAuD0V1oDovFY88vP7yLZhdPKzW1BtSQRGpcC93yXNO?=
 =?us-ascii?Q?GgPZZP3casKYbLOZBLuCch5XxXuhx7llTP5JsiC5yj8fe3JwYZwl5D+Exi4U?=
 =?us-ascii?Q?nihTFlUFeDJ3DZZEeTQcr3QlPhwwdjfLfcprcGhTVQ4ZHLQ3EYS4UUPNgDoY?=
 =?us-ascii?Q?5dKTMILEvV+uCkKgf/O6du22KUzDpYAWThh/SnDbyZ/OPvKaR7VpkRAvp8HH?=
 =?us-ascii?Q?MOvq4dNSyqq75T2XoO0h6pcMxbH7lfL+Z/bGOJI1IopSF71EIRuD2P5H6UCO?=
 =?us-ascii?Q?K1O6IMCMsFIKdHUz+X6I1SjQYPdNIqmX8gwRr48Yz6GJ8LoSX1BRcpKjKA0C?=
 =?us-ascii?Q?fBExyrjH8f/Q0HclrhYcPVZ2Y2uJyjSM8Sihg375BTG4RIDEnISWaeyooeVd?=
 =?us-ascii?Q?8hZ+305VihoZxZXGLFp8YPxgtpVpyYHp47BaNdGaa7Nsx94wuet7qZK2d3ln?=
 =?us-ascii?Q?Xp56OlW7vIbVWg/IKuqDHGblmszHBcJkApRmBbJoAikVI+T6bsqeLriuRHXH?=
 =?us-ascii?Q?AuBNWnVAxIN2EG6IQvR4+dgVPJRr0vIpOruZ032hmH7q1gvAuKBdgRiFaYzu?=
 =?us-ascii?Q?pUj6SWD/f0bdQFxTL4kLTHf+Q4oPKQoZPBGckCrSypLaA0ugi0+LSEV8rFdw?=
 =?us-ascii?Q?+9FBny+z1z7uzNs1lGo6Rb+7nxsRGlr/YlL4bzpuUMJV9q5U9ay8ZFKsjaww?=
 =?us-ascii?Q?hT95/XYHh/bMQBm2K+/9LgbBhjMBxr7gL/S1cnC8jA6LvfIEOEYJI6slx0Sa?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jVcb4CMjz6PpIDipLEHqrW3Dbopufj65mM7tXrY6M/TFIqbEqheynQd5wk2uDY9T+GOzCRe0DIv5C1HuJWicCcnfHBwPO3VSIhFl2ILiId4jQTdXhr6rUIgL93T6WEjg1vZq62f8QQ1w97552Ykpig6voC/CNLxsne+YiMSwHRavmAdG5KpuEr3MOg5oVjGpAs1RNP9XE44ivhIMKvWusJFQStWXuEDgF13DFwoZyuWKW7lJyL1UqLvjhfQMUDiiiCOzhZ2TVRj35e0dU0XYzbJ+moS45hKjVRIjFAVrPmor7QX/DZNXpoe8wRy03iBM17eIRSOdRzkxbL1AVOwGTFd4plOofMcC+L4B1uObul8ckafbOmp3hdWLotJL0TnIE1Wod0621VV1VJUYHEjtOOt0Iw7E1eX7WptRT4CLl5SRcWertxmkcRndYNQYNBo7lP1iwga4Vc5RZXMmtaNFrjIu/bvvVrTpI2Z3iQp60x4xobyzdaG9G8NDPUEgpNyXvETwEr7IRguDIgwCY2q5dtKvQK2py2dsMNj2vrY2thOdOQmKWSHEQ2g3oKyHr/djNW7oO39LvKhy/SAaA71jI4PRUE7VP3CD5jAzwsUP+FU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64202fd-bfc3-404d-1ee3-08ddf0a7c96e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:22:38.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ons/cXvo/Xys+KEJKwiWjZA5KeS/YdF1RdDmBpmU3ExUAJu1czFlln9XKyMkvqhqqgaVz95nv/nKIXme3zNX+CFqP/Lsp2NqXkitAWuucA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100189
X-Proofpoint-GUID: tAJTQQMvmeyWHxCzvi3ufsmK6me-MXpf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX3wFGBULK5EL7
 kf+Dylq7JJtiqmb/UG2p/ikaB+LvjuuL3QeW9SSVA//P0/l76YgHXcZvdUIP852TrBljb0rktl0
 Iuf5viOB9wRf/Ip6cg0gpc4UfTRsys3nGXIXj3E3pxvprcdaMu6xtwBxefNERGnd8HMlosTdt14
 oAGk2afd1PD31CHbvN52xG8zTwvsEuW6JI+sa4lFbbs+5vYHGg0B5s1mMsbRoNi9hOqvdCgoDwY
 LFPjOphcC0zOWZerqNMCTauFPHOeFm6Vl0qC/E7MYJznN1J9GRcORUUatXcgVyfsbFZ2KTdHzv1
 wacers/AMKjoGYqs8zSZfa6DjYAhdxxnNuMM4J/lOBzxKXn6eQulkMSSSH1/jqDtCMtAKg4abTR
 Y/L5Qzq9
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c1de14 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=kVp6y68UWkg0hX7IE8kA:9
X-Proofpoint-ORIG-GUID: tAJTQQMvmeyWHxCzvi3ufsmK6me-MXpf

It is relatively trivial to update this code to use the f_op->mmap_prepare
hook in favour of the deprecated f_op->mmap hook, so do so.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/relay.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 8d915fe98198..e36f6b926f7f 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -72,17 +72,18 @@ static void relay_free_page_array(struct page **array)
 }
 
 /**
- *	relay_mmap_buf: - mmap channel buffer to process address space
- *	@buf: relay channel buffer
- *	@vma: vm_area_struct describing memory to be mapped
+ *	relay_mmap_prepare_buf: - mmap channel buffer to process address space
+ *	@buf: the relay channel buffer
+ *	@desc: describing what to map
  *
  *	Returns 0 if ok, negative on error
  *
  *	Caller should already have grabbed mmap_lock.
  */
-static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
+static int relay_mmap_prepare_buf(struct rchan_buf *buf,
+				  struct vm_area_desc *desc)
 {
-	unsigned long length = vma->vm_end - vma->vm_start;
+	unsigned long length = vma_desc_size(desc);
 
 	if (!buf)
 		return -EBADF;
@@ -90,9 +91,9 @@ static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
 	if (length != (unsigned long)buf->chan->alloc_size)
 		return -EINVAL;
 
-	vma->vm_ops = &relay_file_mmap_ops;
-	vm_flags_set(vma, VM_DONTEXPAND);
-	vma->vm_private_data = buf;
+	desc->vm_ops = &relay_file_mmap_ops;
+	desc->vm_flags |= VM_DONTEXPAND;
+	desc->private_data = buf;
 
 	return 0;
 }
@@ -749,16 +750,16 @@ static int relay_file_open(struct inode *inode, struct file *filp)
 }
 
 /**
- *	relay_file_mmap - mmap file op for relay files
- *	@filp: the file
- *	@vma: the vma describing what to map
+ *	relay_file_mmap_prepare - mmap file op for relay files
+ *	@desc: describing what to map
  *
- *	Calls upon relay_mmap_buf() to map the file into user space.
+ *	Calls upon relay_mmap_prepare_buf() to map the file into user space.
  */
-static int relay_file_mmap(struct file *filp, struct vm_area_struct *vma)
+static int relay_file_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct rchan_buf *buf = filp->private_data;
-	return relay_mmap_buf(buf, vma);
+	struct rchan_buf *buf = desc->file->private_data;
+
+	return relay_mmap_prepare_buf(buf, desc);
 }
 
 /**
@@ -1006,7 +1007,7 @@ static ssize_t relay_file_read(struct file *filp,
 const struct file_operations relay_file_operations = {
 	.open		= relay_file_open,
 	.poll		= relay_file_poll,
-	.mmap		= relay_file_mmap,
+	.mmap_prepare	= relay_file_mmap_prepare,
 	.read		= relay_file_read,
 	.release	= relay_file_release,
 };
-- 
2.51.0


