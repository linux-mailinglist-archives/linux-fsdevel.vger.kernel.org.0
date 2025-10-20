Return-Path: <linux-fsdevel+bounces-64693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA6BF115D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E432218A45CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AA4321448;
	Mon, 20 Oct 2025 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F3mLBv/5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UXy1KdbP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758F1319851;
	Mon, 20 Oct 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962394; cv=fail; b=T6sJQfmpMesP1ssFNjiZQtv26XSvzj0e69CO7/k0VOoUwrLI3BNPocOfyGcklRTuoxApLwmsodboqHL2M2qKMyIGc/XO/H9wpYTPXuSdc1KwqAZCPXM/ruCgUwvFTujzbAfgcDb5wsqjCe+SppQkUm6t3gyeGGHlulhVzz2xdXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962394; c=relaxed/simple;
	bh=xwLRWltXWiselfT4wruIXkhuxYI3XFdgnOEYTwNh8ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSgIPlDUHZ9MirzsmlvwhOxbqJAi3runTX2atRv5IEe+AuNDd7RikP/wG056V+MjzL3JksikYnOYthmT1xifo4vD2BvXz5OdowTmXGKV7HW/JQdcFT9LhlyWHwCV2d39ECYCIxQpFhw+KUQM8fM3j3Jo3WqobRMokLyEmv/wi2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F3mLBv/5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UXy1KdbP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SGSh001297;
	Mon, 20 Oct 2025 12:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0xcIb388qPEM1/X0hYwvL0uL9TtDownOzBym+N+W8xQ=; b=
	F3mLBv/5pu3XMLF9bFGreUpy4/O0Rdyh73lp4CCSb5abVHQMdMJ5rNPa8r39JWKY
	cb32o+OTznsSkrmDZmhUwPIli3IVu7gp6iX5khB1n01nc6GDWNThn7GxJAXvUuhM
	6ZR/Lvb3+AeEPfm3F3EsY8zJPjAtSylznqpz4ZAC7TFD1dIGN0q6hD8zgLUlFJ8C
	dRAd4dT+cB6v7h1dF4IAymsnKvk/rl9DoY5gf224ZaK72ak7VbxGNYN+GpA53FlF
	g9dhne3lG96wTwfVZjWkUrJ4GOpegqh61AyiaAETzaZq72/eGg8LNecVLLMjqzvm
	a21Hp21ZmepXw9jdm+B8Zw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v30723gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBb0J6025395;
	Mon, 20 Oct 2025 12:11:48 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bammup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql1xta0Ao9UbDWsHLA0SMBzFjE3TnoQwOIvelMzH97Rhv7yV9abbssENQU2zXROVzMbSyNsUVjF6yOHMyv7q+giDG+DljzPrPHi1r48jtk8n7Ym/JXypwJMWZrlmVguX/+26+T5vfYc3A/u0Yw/pv8fpim4gZXi/Oje5NrLRfCTTHm0M2DO6iS/CwXUoYqfXIDSE0FnlTGqNgknDmhNpmByDCULpXTKImxqL83Wrnb/iPKMyJKlAof58fyf4UPsqdgh5lIPVeIgQvDPAi3mh1yk9ZKDNYlhl4qRpiRHeQZjDBslVyEX2aRar30uwbpFv31lGp2cS738tGotPtBbHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xcIb388qPEM1/X0hYwvL0uL9TtDownOzBym+N+W8xQ=;
 b=f/28vS19y7xdo3IB4Xs8fbsdF92gLVpMJTH1oZG+uwjmN2HlYnlro8eGsgGGxkh09cZ4MpF1wkUrCJf7Sl00cvdNwtydWzJ7vqPc9QdLffm3lmWlCNfUVSAVwcd4/r2oShkEhedRtPGN23fZelEkUbFYPh+pLNKFFEP5nAjsb0v+S53HmyCEvv4j9bqSp9T6cSniUTDIcLSMnE48nEl/5EH4Pqv8PUURDVCoXWTxUcX/wzzUo8ybCBjm8o/dkq76y4+L0FofwU/XwtP+0xRHGplCXzeRtSFpFeTBxM3VGTwNF8eQlOmn7fBMY5JfW9TZF3dzW8njf9Nh2MdGlGbpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xcIb388qPEM1/X0hYwvL0uL9TtDownOzBym+N+W8xQ=;
 b=UXy1KdbPWoyRGgKMKcvu9Nzg9LFadtF8eotW7c1brm73C9DmZBNeNkE1kxyPrVHIDi3md/j/MtmnTv1+H/lANoa2IC9laINAITuqDZk3eKkQoguWhbpWbJteaKuK+bZoHkrvS8IKW4j2cNeeKVsX2+VC5JL0e8KI/YtLFLsVBqI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:11:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:11:44 +0000
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
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v5 03/15] mm/vma: remove unused function, make internal functions static
Date: Mon, 20 Oct 2025 13:11:20 +0100
Message-ID: <f2ab9ea051225a02e6d1d45a7608f4e149220117.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0361.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c242d1-44b5-4878-6220-08de0fd1d5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E1UYPyz4QmXIMm8paJ6Em+f+9ZWmOO/14Ek9JNtCMsp2ypJEg0CJKhW1rrrf?=
 =?us-ascii?Q?6gM4I1P4nFiD/qQ6HJOEUfiYZGsRqA3lv3yNP3fOy3BK/2HN+OTituAiB+ua?=
 =?us-ascii?Q?dYkK8mwQt8JmFW/rfzBy0bM6ergcXeHIs8cCgylwscGvPb8XYazdCRfFsNRT?=
 =?us-ascii?Q?XVkyJd4hPc+FVjMskbMDbO+0NtsU9JfBba/hRLDURth8+dtCHxqh2Bn90e/n?=
 =?us-ascii?Q?0j/R/yXtyM+OyvqKDOPq/SO3PrCye+DcrzzRe9xqTu/tqi8f6J7nbET4DP5K?=
 =?us-ascii?Q?y9vGlDrL50lces8l65JwJlzF3HmaLDHHKA8y5jC9dgEzUpTA+NhqkhfUg6cI?=
 =?us-ascii?Q?GXn6QWRQ8c1yoHqQLozRLR4HV5iuzvOWZIBS1Tjx2pf5HJiVsx1Y+D8SSKSU?=
 =?us-ascii?Q?XSHEN9rIvuIXgRFqFrgIqMbiYGyaQNLLbUiyf14ysf9mhWr8tbbk1krKOt1s?=
 =?us-ascii?Q?mcCyIwpSNcnFTUChZIFqJa5pgA430weqkW5nXlqZONu+OENgdiN3O58OKq66?=
 =?us-ascii?Q?+Q0b+pgRF0iPnXoe5Y028eVStCFJhQVnbIQk2ogtjsWEg5hg3OqO6uk8FmTh?=
 =?us-ascii?Q?Ew8fq8istdZcC6Mhf9lb+nmMB0IfbSyI2gDX4+F1B9+zJhKJfQacsQ9biLa6?=
 =?us-ascii?Q?3sCRl0t3x7HXgOTlJO84oJiHXNPKihJZEC3jGiaApO3Qq+jeWP1kXNR+zjiA?=
 =?us-ascii?Q?ew6Vpsn3HqL+FLYyA/edvRRcQmRPG4VcCWy2vi1gbpfBrkpatgvrY/ICNHc/?=
 =?us-ascii?Q?DjhI9jQHzb1nypZVBOQFvFxaaOjlXEsTAjrya6Z/JL2Wg5ve6J3bhraiEA00?=
 =?us-ascii?Q?Z09M3MwfqZcSGDr1brhMhDX9yGHI/XJLZz2/AWPnmAzFQXuGsGoxTEWZgHHQ?=
 =?us-ascii?Q?DATo2ovyuxxOmFEMGpWFcsoIrlXHstdAEhJB5W6JSaiE9euOF0tEK+blcA5O?=
 =?us-ascii?Q?TYikLPHpK5SFmg8LkMmQYBbCAosBEyLvvWRVVK5Wc8jTv4ceARa6nUKdTU1t?=
 =?us-ascii?Q?RYWNf8VArFiweS3vpMwXrQ22aMxqhYjHqZhbUkZrULmfEEtNgKZATjQcv8gO?=
 =?us-ascii?Q?ZKtNEWJcIQXSK+0EO06MkuO7dCvN3wMJhSSPzcAULO7/BgEabuvJZWEEaXT9?=
 =?us-ascii?Q?TzAmszL20ZLzJYdO8BGhTf1rM8AKJo/klXkbTFXv0juItKoe/Y4DIWd/+yxH?=
 =?us-ascii?Q?62H+GCh1uT7TB0OmzVl5sbTgEMpXzNbh/8YyhF87LQ+3ezW1ckwimLJgZna0?=
 =?us-ascii?Q?XHLT4N2LtbOwNuqzx6Ip/qhJpOiwS0CqF78uXy2UI0XWWnlj5JY2U0D4V3uC?=
 =?us-ascii?Q?RPxCdScBYRydNJqX0HZxL4lv+7oS8qqszs/LipLmWJPG9q9R1b7ZVVoqtfb6?=
 =?us-ascii?Q?hxzHT3zDK+BxxWFsTBxVoX9v7vwADj/hxyTlv6+XucO0x2W/JaS+JkriuEjd?=
 =?us-ascii?Q?7y8kcRHx9hixUYIoh1NCf3bS/pDhw3gO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iXSRpPjk4QTvTaTW5lNJD33s1ye35O82QYkjGpkHNRsy4X+FaYMC5AF19WOI?=
 =?us-ascii?Q?Yq1W/wA3+Emg8JXgce7vzbR6wTwPRtIBXxPcbdKD1ZgfTWy+rPiZHLQVBz04?=
 =?us-ascii?Q?Ccqb9+Z7vhKqVulPl8DphbSJuzeKZD8oC5C7+cPu3L9D6px6NDlDVAcxVBBj?=
 =?us-ascii?Q?Eugtfs98a4Ny/u6UTqDq3cCREZwegZ8aTm7VNLndeg6Z0Yn0tkk868CTgjn3?=
 =?us-ascii?Q?xFJxXHYle/MpVMswsKpay3K/BQ0aIV1L9msKPafOWl5I/zUDiAi4ljmL4iuC?=
 =?us-ascii?Q?StZlEtLPaMH7vaYUqwvLfJg83rZpGtvqvLkZUb1MmhkvxS3voAbz8d44FCnp?=
 =?us-ascii?Q?hHVMn2+Y9TMFlwKY1niG0YlGT4uFPIBFIbTwGmO6MKpW1wei6Y7CHOuv+atv?=
 =?us-ascii?Q?DOF3nAXBBeQyUPd9K0A60PuxGAu3htNVdoKNkKl8zV1I4PwtZ8rDjJF1CQDm?=
 =?us-ascii?Q?4zRUnGsVnT7qE4qXLAo28AndkDIY394xUgD7bqKQJNk+6PeMJYFy55LzSgSB?=
 =?us-ascii?Q?K8nLiMjjTj+vbJnchQEI1FeoV8vYPwUNdxgEGAqkMjRyxd+1wnzSHmeE5yYO?=
 =?us-ascii?Q?R/XfAK7GwRzlnQogSugS7YaTAMdOyd0vsW25M5uZjaUrZ59DQVBjwQ84V71O?=
 =?us-ascii?Q?FqHkXCP36UzmcGZ/09BjNDeVFkwnT2ymo2Ar6E0yMzTXj8GvL4N65UEtU/Ud?=
 =?us-ascii?Q?m2TOoB7GcwPj14MHiDsCLEfKvolAqYEpEoteN2N9ldn23yclVSINvk7Yjlx/?=
 =?us-ascii?Q?G5XrFhxRehGCGW+Oi4UmI+bV1gLsZZlxwBFFp4piHBgJ6SA+dEg8KNIpltzC?=
 =?us-ascii?Q?fp2wI/14ko7qfJb+ntKik/LhXqHAJxO9YI5jVoValfHgzmhPYbX2zmWb3ghP?=
 =?us-ascii?Q?zKh4R55tP0imqxeb163JZoBjp1HABTkdYoqsfPYTBQAlbWhBIaxFDEAPBwzw?=
 =?us-ascii?Q?dl57LsRGOJt7/Y+pDrw86E2vpO7fdxVixY3Y3I+jT3MXmPQd6kU6FjYCQVOK?=
 =?us-ascii?Q?DeRRKPTdwqPJtk9PVhVF1OjQoTQmfol4Clfeh8qQb1fnv7HLvyUEr8+ScrFo?=
 =?us-ascii?Q?gAFT+PhDqdZrZuj3jLpXjkn7CdErcjvcuNpvVrAaCXalxwbLHUlGYzobeACB?=
 =?us-ascii?Q?DdYJFLGVDqwPLnVHP5JDtohp/MP1AUfPoqS0NJ/xQfIOXUwz9pp6SqA92cLq?=
 =?us-ascii?Q?oHH90f3+FK1/2KGH9lcmXP9dJDo1OX+GnxRiz0w2ypTarSVWmpGOLgbEJbUw?=
 =?us-ascii?Q?WAaLqrY4h9SVpFdZvG5SftNICyeJEvP7P4lNhaGy1Ql6gAHk9sHaImRrd1+K?=
 =?us-ascii?Q?LH3DiIeI4itVNMEDuZ39hX4VfoyDCoc27+wy59aV3Ov8cklBjGPLSKMnwLnw?=
 =?us-ascii?Q?dxMgz35GwU83kWPAAzuZ4YCRAZgqRpK2oaLfPvBRAmD20yl9idjgalGeb5Mu?=
 =?us-ascii?Q?8mRpzHpOpYNye9bTio+eu21kUqYXomRw7S9x3qr6F7YHzFr0HT7g9NDE6Mve?=
 =?us-ascii?Q?F+SxHRz4g/mOxF0yP8JSvjGr9h84nDKgFuT9NEJCMFw1zSELemZd9yX4/qXa?=
 =?us-ascii?Q?mboJLKXTloJNnxiR/WhPP/FupC31iTeR2xPgNHMPrCY0X5xjxoB9WLyZcJcc?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gdASe1C3+AdAS+val2brnM0d66M1ggoJhYggYPjUmxDbUJ1eyFW9ylAucGoMKbTt+2zR5CORZS/1WE/EKN2BNck3YNuIpMVobsjMh3ha1Te25TURJ0cHRyeV0yUZaGm3c5zo8nF/d4TzVcieEPMLN/Y/BpaRPabYu0S4XuRWxYxyT8Xwl3DCFLBKQehYoLKpa95Kq0zsxnBxKiRlfUBFQt9DAsXimEcINUtbZpMDYT9LFiFbzXLvq0g319uAnJqTQyd2hBuxe20Y8zTWsCVdQrmSz8BUpHOoQ/BeIWV6ZBtAsicQVqqbhAT64b+W40QK7WE7uajmrXKcEmvY9MZL1Ri1R5N0UHDVhJEKSG8u/OrjggiiwmGDC82j6hsHs7JyN8QQ3Z9aVoWqBK+MrsOvMzL4ODStdOntBndNixgMAUXo1tUYGT5k5exdmKTJMnoy/a5k8YDXJKaVhdY5O+JhHlnatdhxcFwob61CxWtYqln0HJDEkksqRNm/VFNPh1ciLtuKINOaKYuDOl9zcsU1YfJWwQwnQD/Zg3mt14tNoJdyeQbJufeImRoNWy384w4CUz5D22js00qGV0JaRwkYx37Hid3rqeSMUxePPDWjPHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c242d1-44b5-4878-6220-08de0fd1d5f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:44.7365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCwNwjfHFE38ETXE0IlHi1QAWiYkBSJ900mjabSLeb5dQjNnJtcD0hWar+Qx4+68HOeMBgRe0RTU+7CvXY3LXCSZsTOeuY/ViR2r7hSdPkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510200099
X-Proofpoint-ORIG-GUID: cFKaYyJtOSZOrO1Jjnii35utASlZ11tn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX7zvjSNqTVcDw
 S+3Z8RZnj/dZ9L+2CyP3Q1UERWCbdrud22iZ6oyWnZ+gxWzvLo5z0/LRGYVdAOm1U7loYBu/ulf
 F1/JMCdnQ/3me5SGI1BB9ucq52DTsW20hXH1A4sPZtciEa+7ivM6K82py8XkKteARRX01aivHGG
 V4CrLoEevpSaTVZpmm3V40FnpdZinvFueYQVqHgrHsOingqK1E0FwfLApLUsAkKKzOOpqvBklis
 0eL3vn3J8lfgCVN4DtCLOw0Ko6esA32y7ZrxK7jNB1IbycnS5fFKDAuTMUpKC0V1O8thiXW6zFC
 ed+NLlZwNa76zk8OFiahyhTgrsMvj3JCrWFsYF02YOtjSMT4TRLmvxUbcDztFSJ5mL0nEI0Ca5Y
 nLfX82pdzvb1Z26JrKS9CkxVjLaY8w==
X-Proofpoint-GUID: cFKaYyJtOSZOrO1Jjnii35utASlZ11tn
X-Authority-Analysis: v=2.4 cv=csaWUl4i c=1 sm=1 tr=0 ts=68f62705 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=3Kn3S-nDrHPywecsLO4A:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22

unlink_file_vma() is not used by anything, so remove it.

vma_link() and vma_link_file() are only used within mm/vma.c, so make them
static.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 21 ++-------------------
 mm/vma.h |  6 ------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 9127eaeea93f..004958a085cb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1754,24 +1754,7 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
 		unlink_file_vma_batch_process(vb);
 }
 
-/*
- * Unlink a file-based vm structure from its interval tree, to hide
- * vma from rmap and vmtruncate before freeing its page tables.
- */
-void unlink_file_vma(struct vm_area_struct *vma)
-{
-	struct file *file = vma->vm_file;
-
-	if (file) {
-		struct address_space *mapping = file->f_mapping;
-
-		i_mmap_lock_write(mapping);
-		__remove_shared_vm_struct(vma, mapping);
-		i_mmap_unlock_write(mapping);
-	}
-}
-
-void vma_link_file(struct vm_area_struct *vma)
+static void vma_link_file(struct vm_area_struct *vma)
 {
 	struct file *file = vma->vm_file;
 	struct address_space *mapping;
@@ -1784,7 +1767,7 @@ void vma_link_file(struct vm_area_struct *vma)
 	}
 }
 
-int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
+static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, mm, 0);
 
diff --git a/mm/vma.h b/mm/vma.h
index 9183fe549009..e912d42c428a 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -312,12 +312,6 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb);
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
 			       struct vm_area_struct *vma);
 
-void unlink_file_vma(struct vm_area_struct *vma);
-
-void vma_link_file(struct vm_area_struct *vma);
-
-int vma_link(struct mm_struct *mm, struct vm_area_struct *vma);
-
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
-- 
2.51.0


