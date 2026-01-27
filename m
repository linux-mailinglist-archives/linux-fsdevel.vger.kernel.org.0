Return-Path: <linux-fsdevel+bounces-75612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKDZMdDReGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:55:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0AE9616D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B518430FBF6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3B35FF57;
	Tue, 27 Jan 2026 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AkcqH/Po";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R9d8XC//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95635CBAC;
	Tue, 27 Jan 2026 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524886; cv=fail; b=YSZ3bKnLIKQBq1HBRdtj5944ec4Behb9Jp2+06v2YEXd0RaLBwp+p+ZWCYwRiy2S3ytqV9oASr0Cxderk6KQCEVD138A+LHM2gukyVf6teGYL7EERYgje/bR7luREzkJtvN1F8/EZhCVcGb8FuVDhmadeqMQm/pSzM0PziYddy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524886; c=relaxed/simple;
	bh=FSbHEjI/H0d2Aqc/SoCiXXdu9fI7zA3eRT12fr6O9sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HmqN3HpDErVlpB8STZVV68wByRlRfuKAY4mTqyV9jrhwImzVPN5u/G1zPcQiW4mcu1wd3mvi2EcHF0KsrMOeadddd22CV30L3qGKVUsXkyQrtxijG9D5F3cwRgQDVKo5LpFpxl4mdK1+2gvekcaeDltgCSeMjKZCawdvgvzPmh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AkcqH/Po; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R9d8XC//; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBHiNt3544802;
	Tue, 27 Jan 2026 14:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hxAbCl6xauJtwWwZJd
	aNuV0GnbN6uV159d3n0RkObHM=; b=AkcqH/PoCEr8P2eLR4Y676TdbCzbwCSYnb
	xAC5jPgWSObVWGBXtnQ+hxMf4WZd8ATVAnZVvguwbnpnGhfpPy/gI2GY6xMPqfcm
	N4wDTRoGHf8HKq5URGdHrjyJo1UKy6z2TkKdP+kd1fqQeefSQV889TX0WfQMBUum
	y0F1V2RnG+k7FgiMyXN3SqfqWxpNr9n3ZS5RJlpiOqR6695884FqzXt7Ggr+FfQe
	ULNfBA+Znj1tT0jH3TkEHuHQs7X2BCA2ddjIXME5u1lBYScHbx11zVw7jPWqHoi3
	sRmkPc71TT5ec1djXWaF5WV3oWfF56qbwynBVM7l+oM0z2fPsw4w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvn09m4ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:40:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDVk2N010011;
	Tue, 27 Jan 2026 14:40:14 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9gswe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiTUkMVIolbmgkTqFp5+ZiTwI0T6C+ct5y86MuIKsyl4BTcHdsVuveiqsf5GViZdhRWy0rft86zxL5L/PRVEU8KN4GFeGaYjrWluZRciRmn8M+HaVNXhD7MDS8zsG5OeqmgqM8fQWh+SOM9tiRphrehFQftcwIA2Hbb5bb/VefbyoU2vDp2ebEkKuRYA3oneB0jEP9MX25dSpViqa8nNL4Updm8fSsAcnsSLVCigO1nu9486p7G0ZHNehLfWwUsstH84J7dW0QKSjO94qRZNAm4X9rj3iwEQPBIejjHcV2IQQMum/su/7ewlY/CfxfOBsycdkB+YkUGt911VSpQcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxAbCl6xauJtwWwZJdaNuV0GnbN6uV159d3n0RkObHM=;
 b=c3r9tXitaTBRR1nqPesBqrpg4pF8BPuPkuVc7VD92RW6rOzkcIygvkIKzOnPWWxMCkJWhHxQDJMaHZf1hFpwSSLZKpz8mUcZ10TbkAVcvhzKnC0/cMoOBCJmFAXrolWvlWW6whWNxa7UuZh2kw67t7FGvn+6YSYqaM3ps23UrC35CbpHKRORbatslq0qNSaFSou4hjoEOh8fI7Yaclm39VPRbTHVam9ppHpHqCjmHrjCCoQuCNXM59TbTIuAWlf1w1YhNlvk68Cm3FENOE4dByOaEN1wOszhNYHubWc7p5ngTogQcQSIxsvCLXdzQgQ/C/G4Av6epOsr5oTTutC3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxAbCl6xauJtwWwZJdaNuV0GnbN6uV159d3n0RkObHM=;
 b=R9d8XC//IbCWe1/wbSlDyX8Z7l4uMivgrzxO9zWziim1prsBRKPjF7yUbHvHzoCklhzWhUMp4VsoyvxfuLcE8ImEvrjT1lTcj18NqHWBGg0pqVgQ/1O/yenTIV+3f1H5ZYJuyx+yN7/YsuSMFwvjaF6bMRN2TggLVDgP8uCS9js=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM3PR10MB7911.namprd10.prod.outlook.com (2603:10b6:0:1e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 14:40:05 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Tue, 27 Jan 2026
 14:40:05 +0000
Date: Tue, 27 Jan 2026 14:40:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 00/13] mm: add bitmap VMA flag helpers and convert all
 mmap_prepare to use them
Message-ID: <5f764622-fd45-4c49-8ecb-7dc4d1fa48d6@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <aXjDaN4pwEyyBy-I@yury>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXjDaN4pwEyyBy-I@yury>
X-ClientProxiedBy: LO4P123CA0357.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::20) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM3PR10MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: f4828e7f-6b73-4f34-fc4f-08de5db1f60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/tRkUjMvZxbwUaEm+rmh6mnApZK1cKSDDFgFgNTafwSJSOV64aElfLVBV8ni?=
 =?us-ascii?Q?3Tmig+J6c3khynrZXF6V0exDV15mIe/WPwfI9jQjFbsCiyy/wB4iXUbf4U5g?=
 =?us-ascii?Q?t9J8qOsdEq34o0zjuQQL098Du07GNpwWWrK6uPosv4edqvFw017KpwXt6FQH?=
 =?us-ascii?Q?iZPSx0MPLZuHBsYtyr4jIXI2lup5Vs38pWe/MM4fEKOy1QuO28C5qeJNc/Y0?=
 =?us-ascii?Q?yX8TRZvcmfH6/80tFrI/5bngRer300c1EZrhyLLcPqFtufIpILV2pinm7Pjo?=
 =?us-ascii?Q?iPBmpQvf5FNfMz0M+15ni0QsO6IOonERosVWzvX9GH91wffElpn1KevlPzLH?=
 =?us-ascii?Q?7r8OWiXpAPVQGslxVG7xIIvsWxYvCjlJjgAQMQCbeKDTTRvwd/2ropdJq0nM?=
 =?us-ascii?Q?nbrtX4Z2QhGTgIOSorAx97ff4Vpgi59o1dImUAtJlhy8evaM2ksDamw4erCD?=
 =?us-ascii?Q?7ORR5HIlWRJyvhm6o+YGq0JkWI+lbJ2+GL+RCLGGdscqCRSaKMAWzcje5s+w?=
 =?us-ascii?Q?x/Y8bLLVB0xwXpkaRIlGi70njJ8SZVYdSi2VL+fL5kV7HB8ZaadHlWetOs7j?=
 =?us-ascii?Q?nc3WFaXEkHCsisPjJkU0tASVcwzf0V1oibfRvHW0mk8xXwyeD+EAX2Etinv/?=
 =?us-ascii?Q?Jsoh1nyaM2I9DFM/QnBG/IW+u6MKGfLqcyn+LgFEkEm/SEM8Ty0cBSwgYrO5?=
 =?us-ascii?Q?syIw62fEXH+MYvJbv1q36gC1cfwSKnWR5npPdCeNbUuuX7flnGW3wNxHZHgv?=
 =?us-ascii?Q?NyxqecNK9ZRSNd7VPqMnAT0JiTPlM7mKLt4cyMV+lYsanUQOzYfZ/jcY+gjT?=
 =?us-ascii?Q?eOOBuuSOOEcNtk8fRYrCQ5vDdVwASAdThDpVGqlWHxzFsx4GlJGCDUmpO8As?=
 =?us-ascii?Q?kR2Fx+ScNVG0xT0UCTK14Xo1HvkuPFUUm0yqPr94yDPJzMug1Kccmjav8+Me?=
 =?us-ascii?Q?0US7j5I1CgZsljjLUhc+3HG8dJ/tvplDaVMAnCgmquO2nnA/Y4Hj2SU8pJUX?=
 =?us-ascii?Q?dUDEzuhcL6TuUFyScElBPdgm2y3gNhYwZFTH9EaduYM2qaMfYeyVa4FEoK1G?=
 =?us-ascii?Q?Fg3KaRnbEgqe1nyUZuKOWPnRjwt8NdB/jp51b8YHPsWwlWtyxbvXif1fVj7Y?=
 =?us-ascii?Q?4qrKrZfr9jbcmicBXcB/pcPmlCHrcwgne3mIjxTO6dcUedT/aFoef/aG5lpW?=
 =?us-ascii?Q?qGol5xDOdcvYEU5qFxy4yLkFgrBt5xe/Z7QjuhufZsoMHpmKRfuoP7klmolo?=
 =?us-ascii?Q?GXRMxtdtl56wzZf69tLgS2it/0c5c7IIk4/st1MN2WWxsMb1e0DBFuamfdP/?=
 =?us-ascii?Q?nNMlNa7w/4if6gtQ5uEhxY4orlf/dMynUBmrXuKEQ1fAmqKFXbXqhTZ9jNF4?=
 =?us-ascii?Q?eh0dnPnMcI3XBog0j9mXAHXjoAcoYpgjZPODVKX7Agj+l4ykJbOmKsZNW23F?=
 =?us-ascii?Q?6T4ZO9SszWyMsPQstcQ6pJ8Z5dlTjN3aSTbH49n+CTdQv6YSSQdOi2iWZ2Hw?=
 =?us-ascii?Q?Vjb3YuoPWIAfgLh7mbIWHm1Rp+yvk/3Xjv91bs6ufZwd5g2mtq5IBXB9gxv9?=
 =?us-ascii?Q?sKlxKentor5zck15Uzg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lw6ozjDBRQ+SvOz5T/oG5SQUTY1VdcUuuUhoxNfIesJvRn2thrueJ9obnXmm?=
 =?us-ascii?Q?PyptrPce56d22Kbmjl/yXQmX1ML810unHT0ARcD0Mj6S153Rmkn5rO0xCqTV?=
 =?us-ascii?Q?F+0+1I4MyBI6X+BBUxZSwqH+3lm3CfZ9DNkMXoTMt0fi3WwbpCEQw7wz3oE8?=
 =?us-ascii?Q?ynJAqRhdo0+1AP+4njm9jvrFsjXAOvRJZZtqTKT16a5Jrnzyg3BjiR37pOv8?=
 =?us-ascii?Q?fAJ+pjzGGTbtaTjBxzv42socSoGwh8WxfJvpGQ/IY5QIOyoyHx7+jGVnvU29?=
 =?us-ascii?Q?4Zd0S2+S4/CydLzXVV0WzqDmQkJDy/cmm0r/1frWxVHpF1sewDnIM/L2JgUX?=
 =?us-ascii?Q?cxWvisc85XImJevYDyIz/IeHMFwrCwoZEs4HeRcUkQWIx1tqxR+3KIvs/PNm?=
 =?us-ascii?Q?dFd+bawFzhTp11dBfQ8M7FA45JbZpwi1nQ8pHuHCJHbDdePR2MjBWbWop1K0?=
 =?us-ascii?Q?ugN4/jJv9fnl2Q1afIDxMYjyOeFrum9QNMrVv35e0V0oX9WCSkZ5Ra3hsOzK?=
 =?us-ascii?Q?ML+6dIObx5Fd2PX+c8gLityQ1pYYoLPEtWpLVlUhKoyyZihOKfJAcq+iLY/T?=
 =?us-ascii?Q?5zkSF8iFQjQasjgcafbjhEjhd7HKWGLVUDe+bTqM9GvZuy2u1OsOwe/Ofxlq?=
 =?us-ascii?Q?GrstFEU+TucuFCpUwfPSFXBj0oSG44I6IbdX4idfNHtrn2ajkMFMg6mX8w9n?=
 =?us-ascii?Q?hcuDFKqhI2rI7YfkJ1FQhM6Q7z8HFI2NuYV7dYKsZZTyFP/hViwMl3R/Ukcn?=
 =?us-ascii?Q?QjLj0Oz5ws8rhWMAxLHYPCfo/7zHwU78TtTT3ZqQZx97IZRYLKeFcqKrZyR7?=
 =?us-ascii?Q?fNhiLNaiMscyMbo5zezC8gd0fgZ4xK6y+esocXerfo4UfhSs9sbLOgpiih5L?=
 =?us-ascii?Q?G6zkbjHQEgby7MkO1sy/HnvhA8PO2fM541YqnAa/6tDtiGmnsbc0aykw4hJ3?=
 =?us-ascii?Q?3p9uEvnKpuHsg5fOLXPfxXR4U6gY/cHJqbMFfbOvR27CcDQYglyCiT1SQ5Pr?=
 =?us-ascii?Q?/8XXQFOkjxccEUAxJuT0eRCXjBwE5u9jroAKn3Yw4uLut0mdO/8OcRt8Pbuv?=
 =?us-ascii?Q?AKqnzIw9LHmMpuuwZlFpqj069UO6wABYfhu8kWNCeaoXz60JPd1qfQQN4+VT?=
 =?us-ascii?Q?0i7E9gopkApY6ppdkiRVWnMK42U2IU0qz0GyiHkSTFNsm6Te47grU1sDS/lP?=
 =?us-ascii?Q?y2xWUrLYyCmgpl5IlrVBgUoWtbNh5e+HOQB0KSLOCFbkq1GU9jIHj5sQ7JT8?=
 =?us-ascii?Q?2ZKbZHR2zX5SMP0FkQBiL78aljq1uIzmEo8YnYzjzpw3roAeQnDtkPXQRz/R?=
 =?us-ascii?Q?fft7sq4w3GLomWbqXTQotw5G3gHnV6zpRib2aJb9cKzo6AZy0tu7Kcn6YbHT?=
 =?us-ascii?Q?Lct6CVSPlJ9xkxNGfQevT9Tzi/4UrrDkXLP9R6iJaQ5dm5Aa4aMLnfw19Shn?=
 =?us-ascii?Q?jwfBrhwBMlirdA0rDbS1xdhKnFXMLNYWDMJT512ju9sV6rHGQcHoRt+nVLWb?=
 =?us-ascii?Q?aR4NVOqW7lJdDdZiVMiXriCTaGcWAGYG4ddPmPEtnbbf6IIACJGIvDLQN0QN?=
 =?us-ascii?Q?PlPAH2Mrxj5koqshy3LxUI03NQ5EsxrnYiMZBl85JHwEeLG890OBP5MgIbQc?=
 =?us-ascii?Q?MDYAiK9vSGyGAbWb+PlUcAAuyLbGQRuRyC0zYQ/1gVdjDoxx/OzNyqI1cKHC?=
 =?us-ascii?Q?Tre34ZYS03TH1Xif3CeWctBGYlUe2dLxtOfgpChrYHdmCOig8siZkG/tX0Oj?=
 =?us-ascii?Q?dyEB5HvHvOvOgvBv/72eiHfpokUtaNI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QoEnN4NoK8UeHTvoGqZE9/IiYHscQ3t8Z9LEcr9R6m+gaof/LnX0M3cy5miyh+m1bxJkaWF9OYHf6U8fX/zOYJCMACwuoDTmWexEgs5gInzZgnLk1Kyakhv5fNzfN52DUvv2xUhE+UnO24oc4+69lG+u75Q0C2cvuOlmUQ9v4haGE5wE2bwHH7xm6mOnSFoSx/QH7qAKcfoK79f0wX9QC2F3g31D2+2kId24YTAwwVKDvTBxacf4c7SXgwUrVJm0cYaSuumqLcvcajSKMo3h5xsMd10k63FVULQp0eLu4tB4o6GOUqKM6IPzEuNXuSoi4ymRGKPOF0TrvMk14fo+vwaFZB+PDujrfrMguhC0lYfGLIhQNlxaeRY7kwRSFEDbc/9oj/rxVIuQD+sBSc7lLwdMj43i3daVOjjP1CRem8PGf9KiioNNPBf1f0az+NoL0B8uTyBiXfEs4lKQ9mPwRp7lydv3FEvwxmil/Mxuz5UOoUyNAwEqq9URJ0nHOz9I+KFemQtpiZker9U6ElF80UaV+iYP+P34KOOVMJxCQpREEg/Mcw1260bQiMM4+g4jd7IFxRQ7ihyqcBKQbyyNEtlwqfSuovSsra613T+6Lew=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4828e7f-6b73-4f34-fc4f-08de5db1f60a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:40:05.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yttVmXUtonGy5m3xzj0ETDNzFzRqiA9CdD4pYBLk8xeny1lCCyGOcPw8Yi1AXHlYvlihPMvy5wwz4cgagHTVhS8VMei4M4007U4uooXy16U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMCBTYWx0ZWRfX8VvU3rITTJ4I
 RvCvto83FyV1dBObQGUPZsm3CqG2toUCiPC0dZY/voDIwdCXBWr+cmTH6o1e7sib0F3mhd70pBm
 6yrkLZy5F6iJdtS7ro9zSj7P1fyJrl5mPOKOeT2VdozehCAJZZRvViwe90coeI63vbG5tApCVe9
 VX42pILfo+h+XR1lEVGWgbyreA08ETT0alzb9d2AkUT3gUL9y+eZo8SKpMRwgZjYo3YGwROoTcU
 3CZv7CWeImIA/6jLIGVsvp3YMk75qtXL+eYSR8ptrjx214NmgydwPZuSY+rh+VJ7ileZ8vUHdaF
 RbBBbWbWmqz4FJk+lgFhcxVR59KmBUazmwQgXHoQm9GVd5EYLfxF8ILc6+OhTseeD+uqI1OCCEa
 VzSVaexapSmqu2/dXbhyyqoKRYgeUSSPI+6jSHhI0QWbGSYRMXbqHWpAhpDzcg9TusgF8CVt5s/
 V8i9lHg5X1LFxE978HA==
X-Proofpoint-ORIG-GUID: _lNPEuI5Ff0R5xDX9bfHSXQjt2_XN1Ma
X-Authority-Analysis: v=2.4 cv=Rp7I7SmK c=1 sm=1 tr=0 ts=6978ce4f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=apGOHuohqZo4d8umOQEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: _lNPEuI5Ff0R5xDX9bfHSXQjt2_XN1Ma
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lucifer.local:mid,oracle.onmicrosoft.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75612-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[94];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7F0AE9616D
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 08:53:44AM -0500, Yury Norov wrote:
> On Thu, Jan 22, 2026 at 04:06:09PM +0000, Lorenzo Stoakes wrote:
> > We introduced the bitmap VMA type vma_flags_t in the aptly named commit
> > 9ea35a25d51b ("mm: introduce VMA flags bitmap type") in order to permit
> > future growth in VMA flags and to prevent the asinine requirement that VMA
> > flags be available to 64-bit kernels only if they happened to use a bit
> > number about 32-bits.
> >
> > This is a long-term project as there are very many users of VMA flags
> > within the kernel that need to be updated in order to utilise this new
> > type.
> >
> > In order to further this aim, this series adds a number of helper functions
> > to enable ordinary interactions with VMA flags - that is testing, setting
> > and clearing them.
> >
> > In order to make working with VMA bit numbers less cumbersome this series
> > introduces the mk_vma_flags() helper macro which generates a vma_flags_t
> > from a variadic parameter list, e.g.:
> >
> > 	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
> > 					 VMA_EXEC_BIT);
>
> This should go on the bitmaps level. There's at least one another
> possible client for this function - mm_flags_t. Maybe another generic
> header bitmap_flags.h?

Well as the implementor of mm_flags_t I'm aware of this case :P

mm flags doesn't really need it as users were already using set_bit(),
clear_bit(), etc. and don't often set multiple flags.

I also would rather not make this too generic at this point, I explicitly want
an opaque type for describing VMA flags for type safety even if underneath it's
a bitmap.

>
> > It turns out that the compiler optimises this very well to the point that
> > this is just as efficient as using VM_xxx pre-computed bitmap values.
>
> It turns out, it's not a compiler - it's people writing code well. :)
> Can you please mention the test_bitmap_const_eval() here and also
> discuss configurations that break compile-time evaluation, like
> KASAN+GCOV?

Ah I wasn't even aware of this... :) so thanks for the heads up and thanks to
everybody who worked to make sure this was the case :)

That's useful information re:kasan,gcov. And I see you addressed this in the
test there in commit 2356d198d2b4 :)

If it makes sense to you I'll update it if I do a respin, since the Link: to
this discussion should provide this very additional background :) But I have
noted it down to change if/when any respin of this happens, if that's ok with
you?

In terms of impact, well users who are using KASAN/GCOV are already asking for
performance impact so it isn't too egregious.

>
> > This series then introduces the following functions:
> >
> > 	bool vma_flags_test_mask(vma_flags_t flags, vma_flags_t to_test);
> > 	bool vma_flags_test_all_mask(vma_flags_t flags, vma_flags_t to_test);
> > 	void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set);
> > 	void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear);
> >
> > Providing means of testing any flag, testing all flags, setting, and clearing a
> > specific vma_flags_t mask.
> >
> > For convenience, helper macros are provided - vma_flags_test(),
> > vma_flags_set() and vma_flags_clear(), each of which utilise mk_vma_flags()
> > to make these operations easier, as well as an EMPTY_VMA_FLAGS macro to
> > make initialisation of an empty vma_flags_t value easier, e.g.:
> >
> > 	vma_flags_t flags = EMPTY_VMA_FLAGS;
> >
> > 	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> > 	...
> > 	if (vma_flags_test(flags, VMA_READ_BIT)) {
> > 		...
> > 	}
> > 	...
> > 	if (vma_flags_test_all_mask(flags, VMA_REMAP_FLAGS)) {
> > 		...
> > 	}
> > 	...
> > 	vma_flags_clear(&flags, VMA_READ_BIT);
> >
> > Since callers are often dealing with a vm_area_struct (VMA) or vm_area_desc
> > (VMA descriptor as used in .mmap_prepare) object, this series further
> > provides helpers for these - firstly vma_set_flags_mask() and vma_set_flags() for a
> > VMA:
> >
> > 	vma_flags_t flags = EMPTY_VMA_FLAGS:
> >
> > 	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> > 	...
> > 	vma_set_flags_mask(&vma, flags);
> > 	...
> > 	vma_set_flags(&vma, VMA_DONTDUMP_BIT);
>
> Having both vma_set_flags() and vma_flags_set() looks confusing...

It's a trade-off against readability. I don't want these helpers to be too long.

Yes it's possibly confusing, but I keep a
consistent convention of [thing we are doing action on]_[action]_flags() and when
dealing with pure vma flags - vma_flags_[action]().

You're not going to run into issues with accidentally choosing the wrong one -
as it's strongly typed (well as strongly typed as C gets anyway) so the compiler
will catch mistakes.

So I think it's not too bad this way.

>
> > Note that these do NOT ensure appropriate locks are taken and assume the
> > callers takes care of this.
> >
> > For VMA descriptors this series adds vma_desc_[test, set,
> > clear]_flags_mask() and vma_desc_[test, set, clear]_flags() for a VMA
> > descriptor, e.g.:
> >
> > 	static int foo_mmap_prepare(struct vm_area_desc *desc)
> > 	{
> > 		...
> > 		vma_desc_set_flags(desc, VMA_SEQ_READ_BIT);
> > 		vma_desc_clear_flags(desc, VMA_RAND_READ_BIT);
> > 		...
> > 		if (vma_desc_test_flags(desc, VMA_SHARED_BIT) {
> > 			...
> > 		}
> > 		...
> > 	}
> >
> > With these helpers introduced, this series then updates all mmap_prepare
> > users to make use of the vma_flags_t vm_area_desc->vma_flags field rather
> > than the legacy vm_flags_t vm_area_desc->vm_flags field.
> >
> > In order to do so, several other related functions need to be updated, with
> > separate patches for larger changes in hugetlbfs, secretmem and shmem
> > before finally removing vm_area_desc->vm_flags altogether.
> >
> > This lays the foundations for future elimination of vm_flags_t and
> > associated defines and functionality altogether in the long run, and
> > elimination of the use of vm_flags_t in f_op->mmap() hooks in the near term
> > as mmap_prepare replaces these.
> >
> > There is a useful synergy between the VMA flags and mmap_prepare work here
> > as with this change in place, converting f_op->mmap() to f_op->mmap_prepare
> > naturally also converts use of vm_flags_t to vma_flags_t in all drivers
> > which declare mmap handlers.
> >
> > This accounts for the majority of the users of the legacy vm_flags_*()
> > helpers and thus a large number of drivers which need to interact with VMA
> > flags in general.
> >
> > This series also updates the userland VMA tests to account for the change,
> > and adds unit tests for these helper functions to assert that they behave
> > as expected.
> >
> > In order to faciliate this change in a sensible way, the series also
> > separates out the VMA unit tests into - code that is duplicated from the
> > kernel that should be kept in sync, code that is customised for test
> > purposes and code that is stubbed out.
> >
> > We also separate out the VMA userland tests into separate files to make it
> > easier to manage and to provide a sensible baseline for adding the userland
> > tests for these helpers.
> >
> >
> > REVIEWS NOTE: I rebased this on
> > https://lore.kernel.org/linux-mm/cover.1769086312.git.lorenzo.stoakes@oracle.com/
> > in order to make life easier with conflict resolutions.
>
> Before I deep into implementation details, can you share more background?

I'm surprised the above isn't enough but the background is that we currently
cannot implement certain features for all kernels because for 32-bit kernels we
have run out of VMA flags.

We are utilising new VMA flags for new features which make them 64-bit only with
annoying checks added everywhere to account for this, and there are a finite
number avaialble.

To future-proof the kernel we want to be able to adjust this as we please in
future.

>
> It seems you're implementing an arbitrary-length flags for VMAs, but the
> length that you actually set is unconditionally 64. So why just not use
> u64 for this?

It's not unconditionaly 64 (yet), it's currently equal to the system word size
so we can union this with the existing legacy VMA flags:

#define NUM_VMA_FLAG_BITS BITS_PER_LONG

I'll answer the 'why not u64' below.

>
> Even if you expect adding more flags, u128 would double your capacity,
> and people will still be able to use language-supported operation on
> the bits in flag. Which looks simpler to me...

u128 isn't supported on all architectures, VMA flags have to have absolutely
universal support.

We want to be able to arbitrarily extend this as we please in the future. So
using u64 wouldn't buy us _anything_ except getting the 32-bit kernels in line.

Using an integral value doesn't give us any kind of type safety, nor does it
give us as easy a means to track what users are doing with flags - both
additional benefits of this change.

>
> Thanks,
> Yury

Cheers, Lorenzo

