Return-Path: <linux-fsdevel+bounces-64493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1975DBE8A44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 14:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023893B4E14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E670330316;
	Fri, 17 Oct 2025 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qw9hJogi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xqpcYlCD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA021B9F5;
	Fri, 17 Oct 2025 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705232; cv=fail; b=faJRbv3rzCiC5VRQxMZa8tDCOtk1RxyA+TfM5GelOBFT3wCnpTTtZEqN4cIrTklcor/SL4imoxQ0GPSCVCQixb57C4gkGwo7k0Ofd3kz0nb0091U26X0U3hPWvLVe+3UQkhkikYfmX+nDYDyNLiwGYYwPGCFPM71B1Tj/OqJIlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705232; c=relaxed/simple;
	bh=BmD3O2BrtxmMR6d/luJKWL/zwNk4SQXq//hEN42v+kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TfyObs7xd8cfn0wBCVpiMMo6aF6X+qgnYH0M5YW446zjeXhMJ8SG6aX0mrpqNebIiBv78KxBNGMh5o1wXxZVXbtN13bjwiYv5oCgOgaL4Rvk0j+G4x2oZ9jb+oNJC7eA87syWKoTM01pWaQEwteP7dFiMXz7ENJFoWb7h7B5tNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qw9hJogi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xqpcYlCD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCdZYZ019395;
	Fri, 17 Oct 2025 12:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=oI061dAy8vsrxlC0Z0
	wPC3REZJnjXCHWEy6h0Lna4zs=; b=qw9hJogiVM1OosFztlA3vcIeDwG6RnStxB
	aljILJD609euUKdCS5YwmXPe8tGrGeCcmJ3FM2Y2Q7Q/h2FIAtNj+Wc/UIQQe0xM
	reR0+3yTic9rmGb4RzGptXD+9cpyH2imJa9RxrRSmsXHxwSVclg8mWUdNx7IDSjc
	W89hQRUPzJOxcxz5RsrF/nfqskCFH0fQVPtVBfZUG9m7Iq2/XT2habbPOaqjkRRI
	uRy+VwJPy3aMub9uqI28QnkSCjn7yWwMj7qnOeHIk1BCq3IbpwmYve4Hn4koge1L
	GkE3y8FEyPlKo/7TPr3SkHrYFAbtzhn4e7cuhuU9dwspwvxuEwuQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59jwaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 12:46:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCag8r000649;
	Fri, 17 Oct 2025 12:46:27 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpd1ftt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 12:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6yHbbY6DLxJVTAmOaPL0lSsud6KNTmo/dqjmGuKwwVHDkFpmzhyCcn5qdbcvY/5mB8SLePCCt3OmGq7bO7z0UsfevnBG17ikhZfZub2wJuV/vivDWzkqEo5af5r4ZRiFNuMoKwv3B6jgxqS+ipZeBHgq5qw7xp2bLAzRMX9MeIcGRlO+1D70mIV+BY0wp/GA9ch0LqAV1let/jhUGXYymWCAqwKge62PUXEtLsODIuCUKMuqfxZNS/4HL41NBZF83rod3GFPgJWFm1N5wTAU4h9edD+5YGhuY/diJGKkfgvnDYBzrH0BJnO3lanVklgF/UeAXtlpwMmfmiS94Fgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oI061dAy8vsrxlC0Z0wPC3REZJnjXCHWEy6h0Lna4zs=;
 b=NVnzlgvhrfGnEXlKYsNtLUQE/+YhIUtjEjilzFTH1lW7RWtzIeADq69PzCIqfRVZt8Qlc31DvPe/pEkzLranU9K3kuPuMqzYD4W6KVHZr4KyTJG4HrWJtr4YgCRmQTHWflh5O0pJJCqxLAMci5iMWgnvYjOLqs3TRV94eP8e08GL/0ow14Aqp6JfvwU/GJhc0idE6TrsiA/CQDSnNYUkE2aLQ7sx7n3ReDRdewe2wYVMKH6eVTq/DD2PZ19VfGxDhRInGrm0JNrHEtd9R59WfRcigiLYooQBnznWs4gLYdnCNQE0aW/pshrfzhqEM8ISidjB9LLhfLAioSGS/igorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI061dAy8vsrxlC0Z0wPC3REZJnjXCHWEy6h0Lna4zs=;
 b=xqpcYlCDf5uv4AYt1N2vs6fqyBjljB1J+oO+B3TuxJGy12oHkCV/GvsSeQDM0AdEZDH3DdFtFDTGsOU8/v2Vf2f5y9GiMhfUTVJeDRD7Tu8qCdnp4FH3J6NLmx66Mr3+f2McyjYqeTsIPyb/BUmO7krCbylzkbGhZetll1jkygc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYYPR10MB7627.namprd10.prod.outlook.com (2603:10b6:930:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 12:46:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 12:46:23 +0000
Date: Fri, 17 Oct 2025 13:46:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
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
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 11/14] mm/hugetlbfs: update hugetlbfs to use
 mmap_prepare
Message-ID: <c64e017a-5219-4382-bba9-d24310ad2c21@lucifer.local>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
 <e5532a0aff1991a1b5435dcb358b7d35abc80f3b.1758135681.git.lorenzo.stoakes@oracle.com>
 <aNKJ6b7kmT_u0A4c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <20250923141704.90fba5bdf8c790e0496e6ac1@linux-foundation.org>
 <aPI2SZ5rFgZVT-I8@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPI2SZ5rFgZVT-I8@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-ClientProxiedBy: LO2P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYYPR10MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e644385-67e4-40c3-db52-08de0d7b2dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QPLeEIcJ/w59HVFnCTEmNLMUIwdU5nhIfjMZH7IyCC464BQ2EmzZ8h6HCZwx?=
 =?us-ascii?Q?ZQcPhNWDSvIWr0uuVwnO6YN3XGzmYuAbtSyakg0SfsyMM8erwgTYCqCHUu2g?=
 =?us-ascii?Q?E0wwjZXVRU6KhguU/Bm2hEvYDx7OsLqfOhqeq3igTcG1oLBOVBQY2Shq/1XA?=
 =?us-ascii?Q?6OcZKPWI17ch7uTlRjull11omF/iw3L/dit8gduJY/+fPDIrHWBKhaWJMQSP?=
 =?us-ascii?Q?fS8lUAbf1pM5VtQQf58gZW9DV5YReEGrpy/aH60WlLeTggBCzILJrWeA/k4Y?=
 =?us-ascii?Q?vRh+O7rxb7YMvKa3LfhjdyLFNNfWHHuqXexjDS4lZvRPsPzAiIOebGa5utVz?=
 =?us-ascii?Q?nssfIcpZUbday1FH2MPn22zJk5xDkx7C254i58QP1tzNsAU+c1DNckIiDHBR?=
 =?us-ascii?Q?Mt3oQl6pT1JpSQBZWhcAn1gj4tcFBG7b1ZtFgICII0HMyjDHMUB40YTgI+9Y?=
 =?us-ascii?Q?wczQusQwwUNGg8UdgLy1qAqCCgQVlBQlKmAi/V2VATGgzFSPfeKB5SDg66J7?=
 =?us-ascii?Q?tm/6Yx6MgcMWwqT0gT2Irip05m5rkLX9mkyflGuR7kaT0gbR4rb9lxquGToX?=
 =?us-ascii?Q?GSddsciv2cCf0i9iLfwP2/2wuSwDIV7uXA8+ivK2DLmMIexIkeKh/BiI3bZl?=
 =?us-ascii?Q?UWTvO1GBg8zXR3mUL9OW9/MOIiFX11I72eKqr2Xtk8np8Cl4mGeqV8x/0wpb?=
 =?us-ascii?Q?2UC3+8gvTuXjt1G1Jx6nCptXV4d1BnsWZzEGaYQETRJqfwxJYSy1Ky0M5dbA?=
 =?us-ascii?Q?rExdemD5X39GaNyEoPsga+q8UIZHmDCA+tGdMJEijg/EXQLnLbxjSTHzT4ZJ?=
 =?us-ascii?Q?+svYIh3HJ35mgpTB1yJVI23qEMDy3GxXnuKEWnQuYMofnB9c+q3N9eQFnr/6?=
 =?us-ascii?Q?3le56jFz9vHACRMyOMfRUE7sSt3ede0JxaGDYSqYGCA3YxdouTbYmybVzSGQ?=
 =?us-ascii?Q?aOHaN/LsyJx5BzXu8LVhWxPJMxWEiOP4c8zsvUbCMX0L76neXyy0VWDDWEYN?=
 =?us-ascii?Q?S0IaTZwvREmzfLP1YOMDCvgGlAIV50fM+csbz7uTmpwGGprb8X//2DwQU5Yf?=
 =?us-ascii?Q?kha6rxm6wtjfQpYQhccjT4RDMQhrlyzeGk3M1DoiUe5/DKMLn83Rv+PY2j65?=
 =?us-ascii?Q?2z0Ek62D1/RqOISu+jsofJfzXbnZr01fOhDbjjS6Fp1c27WTTZh9sBhFibf7?=
 =?us-ascii?Q?Sx13g62oEbaa+Xzb2SGxN82SAYhZiJlN26BQa2dpcHxpeIK/dqTSPDDNsYSj?=
 =?us-ascii?Q?1jCWeb91N9N+8d6JD3MB5gaIuNq4LCYw6/XXXpLg0nASqow+unX4hwoZGrn+?=
 =?us-ascii?Q?E7TtSfNJj/hiGpxJlxKEs74MR5slhPy5+UWc2OEuWEBPQ7FTs8GsXGyOgpWd?=
 =?us-ascii?Q?aiGOcdtcbM6bUSFhpS9HPdE7uk6KkPLcFDhUUcRmZObUR7BOiAUzL6WPm9G9?=
 =?us-ascii?Q?YIyWlog8HPnpjn3ZFFp0qKAKzzmTK0VQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/w3MGCmG8RFh9h2aXw4RCdESHRsDE8VGfOXPQjXlTC12qyM1V/hxm19kzNJ?=
 =?us-ascii?Q?GxMTBeYtKgYLWntC2C217SIhs4gZYXRbyyU3uDt8FxMbXT+vTalloCnEdY3B?=
 =?us-ascii?Q?nQ+sENoUSn/FCHRQWszFO9m8NwUjxiVC+lKo5+Rftw6i1FqMBjsrcAx3eoKe?=
 =?us-ascii?Q?+qJCZISuVbKMsBahtAM+zbPwZOonGAiLgwgDNMiZgHi47FjNm0dC0+MSumEY?=
 =?us-ascii?Q?uPBLyv1tSqEjkpyOVxGhPUVRSsxGLirpOg2bUA9ooGmGyiC8p1D1q0TDadAi?=
 =?us-ascii?Q?fvfBS3yjjVxU2NAV78eye4cMtp/LlLnVnL4x5LzqTytBMwPVLRQuThb5La8S?=
 =?us-ascii?Q?BZzpyL5nCPElpa4FQ0GPblMcFT4zcmeTV1wB/Chxe5T680xbPo2O3cp4GZ6n?=
 =?us-ascii?Q?Mvq3F1yjNNAuz3GuxeYFQPURbEfKCGw6JaCv1H2wRlmSHREPKgtcFQ0apx16?=
 =?us-ascii?Q?5LwVIhcWr8IfPut0ozAQ+VqLVPuCp1ZmvAMTbU4R+kccBuE4wuBqEEDIpAP8?=
 =?us-ascii?Q?U4ADcRbYoDZdWDywSKZ+S6OcfRLPQK4H0OrvrxpfWQXWh0DDb3kIUs05RtgI?=
 =?us-ascii?Q?H+3IIIPqcRnIt2EGNqF0TIlWsfxf0EygecyZuYr8DVZn01b3g28p4Y0K3LAl?=
 =?us-ascii?Q?BROYvFsh4/phke9jv0b5tuwpZFMEFAlGDwD2W5kGGZ8XIQri9s2BG5ysOBO4?=
 =?us-ascii?Q?8TuX/wnonYcBF5cHnuwDJszMF7U00VMjGF9SWL04hWyBTOxNA22PhdqAvTGO?=
 =?us-ascii?Q?bkMlp9s+Hgugs5xYuEHx3gR83K62Y1hPC8g4spGWFSzmNwd2EYQMkcEz8J3e?=
 =?us-ascii?Q?mBs4Z5oIiXJr3jbHCBBPSwpDvta4WGQuS0rn3PVfdQiGePse2pGvdr1jQMoV?=
 =?us-ascii?Q?LPjMe5LmECVJ8YnSiljzVhX4Hk0QaYbznI7iSD7lkT+FpEjM6MJa11MbNBuR?=
 =?us-ascii?Q?VJSYfqT5M3hEae8K8X1loQREmOWrksd9WYdbW1HzMpVGF5leUsKnd0CuS7EM?=
 =?us-ascii?Q?JSwz/PPDGLGxhSjJBexCOsYPx+vF1Z+kGgJ/MowCdPf3ppFPS8PFpvmZjETv?=
 =?us-ascii?Q?4aUqyV+JcMFZn3+zPpnsS1DUriDvazcLPgJBoDEzLYil/hfCdHUbZDP5GCZ7?=
 =?us-ascii?Q?vJHstp8h7iyoE34S5eVJ7hbNM9yXozVM37Gs4Fu8wl5O2X/PpPX6wKfQvIPs?=
 =?us-ascii?Q?IWlOHiLh+V4JRc3SGG+ZZ+EA/61TDIvKi79I3lWGJLJjq8OkEgZeJXqVLD/i?=
 =?us-ascii?Q?K0NA+l7Y8qDNIMFaC6SUy4Bo1kQ3r52fTJ07YjCk6OIjCErBbG7FJWxvcVU/?=
 =?us-ascii?Q?TdCWP5sHm4B5Pm2XALHSB3Yj6nlI3ChiMsgPZn+4lgB+x6G6p7ox7/mwEU2g?=
 =?us-ascii?Q?LsCqpSkS6HR5C0NFxDbiZuLbgTFz8+bOgD8jqUFr6V1c7/OtWm7X7LOLvbZG?=
 =?us-ascii?Q?xeyZ6y7j76d11fuGOnP23pmGKtURg4PmLzGWDiYILZkpLiRhlguq8XbZu5BK?=
 =?us-ascii?Q?Eq6XgSULp5CZd3R6yGG+/Fq5xJtva6VeLI2DawW8KTQWr+dQpn7gI7hqblb+?=
 =?us-ascii?Q?WAXOgRUzRIxyAxycHXX66KNdu3GBZ6zR1JoYGRzJmj0J8zXqRWCnFtQOfJ5r?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NCUDsCptfdl6NVzE+XRmAcfVB0TCO0kpXJIYms8adXUf22J0h7WZM4IIQd7nCVa1F70dSW1XQFFS4AAYF54RDH2F3aMWjcjcbahwaWKuOFaVO8N7AOo1W42VJaLM2K91sbRYV3Fl2Dke+PSfHAprFZF6wV98Mzuzz4mfzWBzFEPf5q1elBX9i4rYazjn1LsdPZYYPIdtpaA8/CxEK4qd9tgoNwxROINZji6a6T1obs7ArnN3seeZFVn65KgjLsWr/UGmKhr3M+R0smOhWExz+U24dH+tTsyew5TQ1vV50pCgs6MozIUgk+BcbH2jEACMHOX9ndzsi6ss27MIP44Mgw5LuIAtO1o0WlOo6f515vUCKwai+nz6QDrQT8RsiVmy5ZM1ebqHY3hYrXuTmOKIdP8124X0FpBYoXA8ASV/uoEuLithP7pJw5x8aujv2gOcrRUs7zETEwsOdhqBNvHJmiHUSHjJBwQPjxfYxpp3Gk+MczXRLdHqBCcrnUA/YjIBEr2DYazVyWKousL4/raMwtgmxhibM3sZoZwoprBgx2j/7ZjdfqhYUOktLnSqjqgWkt523qYg5SMtL8feCFCd+qG+y5F4cOZmlJNfc3SPG9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e644385-67e4-40c3-db52-08de0d7b2dab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 12:46:23.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyLZpbdgkkaBS3MV9WFDbMuMpa0JedZDiK/jFohQfYTWt+VxXKJUsZBh2gIbhpo1iV3p4pNO+fQcbUE206exI9rSpTuPe9vvF3+pqNs1fXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX3CdVs5SExetr
 yYo6EN3KDVrGoeTEdYk5fuIcEIIn0CT6zD1IeIJhsnYZGyqOnxxbkOqcpu40PCqlO2a1oYhrpmp
 x+n53pSct9KOct8ZXC2VMx4n4NZUKpkQdrZSBAcTkXPN7nH9H4lXTt15raRoMUF1eNpCY692sr4
 JMMc34YULLv0Zh1J+HBTbZfh8qB1EbDkN7JtDOObIHRFaS3DuQZKtjRZ/ff0bgaRN4ZbtkzNdfM
 ZTnY3s4sxeeL8UsBO04vvO0aTNFT7qT/51swibZ//2a2O1pAtLzIPeoDWPvoHnKZ5NNav+Sem7s
 YEyc2mfgbHWRTULBj4vAvk21A0iVSAymDW8TQfyFIrKrBZ0fRc940Gw5b1MbCXb3YurPx4vsK13
 9GzrxUE6CRJORmob6d8Kijfw9C+W3A==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68f23aa3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=eWYn1dIeHkTF74O058IA:9 a=CjuIK1q_8ugA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: 0ATmMJrwdHoEuzfB9kMIKut0xlYxjzQs
X-Proofpoint-GUID: 0ATmMJrwdHoEuzfB9kMIKut0xlYxjzQs

On Fri, Oct 17, 2025 at 02:27:53PM +0200, Sumanth Korikkar wrote:
> On Tue, Sep 23, 2025 at 02:17:04PM -0700, Andrew Morton wrote:
> > On Tue, 23 Sep 2025 13:52:09 +0200 Sumanth Korikkar <sumanthk@linux.ibm.com> wrote:
> >
> > > > --- a/fs/hugetlbfs/inode.c
> > > > +++ b/fs/hugetlbfs/inode.c
> > > > @@ -96,8 +96,15 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
> > > >  #define PGOFF_LOFFT_MAX \
> > > >  	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
> > > >
> > > > -static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> > > > +static int hugetlb_file_mmap_prepare_success(const struct vm_area_struct *vma)
> > > >  {
> > > > +	/* Unfortunate we have to reassign vma->vm_private_data. */
> > > > +	return hugetlb_vma_lock_alloc((struct vm_area_struct *)vma);
> > > > +}
> > >
> > > Hi Lorenzo,
> > >
> > > The following tests causes the kernel to enter a blocked state,
> > > suggesting an issue related to locking order. I was able to reproduce
> > > this behavior in certain test runs.
> >
> > Thanks.  I pulled this series out of mm.git's mm-stable branch, put it
> > back into mm-unstable.
>
> Hi all,
>
> The issue is reproducible again in linux-next with the following commit:
> 5fdb155933fa ("mm/hugetlbfs: update hugetlbfs to use mmap_prepare")

Andrew - I see this series in mm-unstable, not sure what it's doing there
as I need to rework this (when I get a chance, back from a 2 week vacation
and this week has been - difficult :)

Can we please drop this until I have a chance to respin?

Thanks, Lorenzo

