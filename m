Return-Path: <linux-fsdevel+bounces-64711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5180DBF1C6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3AFE4F6791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B8321457;
	Mon, 20 Oct 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PmY4CW7M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VoP00omB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AD1C84C0;
	Mon, 20 Oct 2025 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969686; cv=fail; b=M3YbsnGMCMoAsjRpCIFHeePKOL3y5klHaGOQorMzn+YjsPHi8j41o5jrsKunmNUVNzzeVh1AV2Z0IyEmopLwjV8pxXIIfoyj+OEYK9fAGX5gdcu7jJhUbs9DqxbxN6xMqa0pmdW1V1D+op4086SPnqs024mmdy+jC11c/I5Ykho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969686; c=relaxed/simple;
	bh=RqJP5LSlTyqWEKn83Vhqv5Rb1/W3bmdqnsXgdwjN7Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FM89Fuw7/Z0Nx4WihA1Z9Lld5sDc2HUUpRTOlT2upbHmuyp4+SZWFX9av+5NDP51fFyf5Dpo92BTA4gKKLBJbf0VaLjlX2keFpCEXlacWTM39sn+mt0d0xJG9icPCtIfQHwmadbGViUTeGsA1fDFWfdR3ZpOGzjAc7nn7WOy7m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PmY4CW7M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VoP00omB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SIqP028347;
	Mon, 20 Oct 2025 14:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RqJP5LSlTyqWEKn83V
	hqv5Rb1/W3bmdqnsXgdwjN7Dg=; b=PmY4CW7MOKTmceYi6Zu7tKlOHFc9Rjosdf
	M/ljHpkD9D/gfZH/EC8TNG38gKB9Zhu1IGzD7fzL8EjWFu4PEAE9yi5h0x1RTRNI
	sc7EGhPh6+YJlWEAwbT0uaKLtKYjxc8onr+0qy4bjieHC1/TWaaaACVie3cZLPel
	q7hYwu5/E6RgWj+9H+FzHgpNyrmIjuUXQurAnp1aY44HUqtBbxsoha+loANm6zgo
	i5xz4T5HY/WbqaSuh2fNd9tgsDWS1t6ErTg15dMwr2QF4q/3wfLYQxNlmnPSuGDX
	QblFtQoYhGQx8pEWFRNcaizgnmhdvqWZ00stV475hCR3IyJr3YDw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2yptb92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 14:13:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KE4qG5013125;
	Mon, 20 Oct 2025 14:13:38 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1baqk36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 14:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9VC2pClXQ5rb/VXJN9N7U+xeEVNpDF4n5v2EAFmGZQBeAC2+ZDThH9xyRC2HpfMTsUlRoX9PVt6eA9ZZJH3N3lt443sDTEeamzsZZ5HwYiDT20XF/vUSfplGtrep+UcUa5akz4ouxkMAwPQEqCRzElIEfE0eoFzB4tgciVB+fsrVglwXKzB2YgPZYF3iNUhHUna6Y+F/0Mzn6quT1rnPHLjxsNqdXHJnKfC1VwCl6/R2nUNTx26bTEBS9GFjwJL1NubKSkIp18fy6ZGkXThxgDEoncc8Dj/EAP1wEaKcXIUiPXj1dcXVnznMQ8W9G+ILMMrii/MQezYHoMdpzafXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqJP5LSlTyqWEKn83Vhqv5Rb1/W3bmdqnsXgdwjN7Dg=;
 b=J2p7CUONsC0oCsLb4ZNSGz24fa8W9LlpVshi4dOfym/rIiVMHdAJtQaoC9JREddrv6TiRYO3+Sk0zLVryUs30t+G+FWHvwiW7rOXR7w5HXjVMG7FdmXl2YCKZU0mtQuJv8okB0BuZqPny13a9r5TK4UHp+VS4tvQVHof7lu+iFAUV1jc5/j/iXAzg8HRyarkt3s/Cke+fQ0KyGh1cjqhsaHoVKfLjykBXolvKP7Mhzyjjon5dU2cQgB5oanM59ThnMtAN99V0aw3OKWkVNv3AC8K1PorVdLYEB3HwAmD/aQxU224HignqdWZYykVLzu5TibvNDcDk/DQ0DaCIR5xOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqJP5LSlTyqWEKn83Vhqv5Rb1/W3bmdqnsXgdwjN7Dg=;
 b=VoP00omBlJiUAGHqDp+N0KMykcZJDClFTkMoFwsaz+smiAdpYUklNmLiMXz04xS6i+QAxwBFSAy7+V8xBTvqA+xUjDe3sOqjL8GKko/xFBwsvwLWRPiMAj3L3W+VPKpUO6SBnAd02jpCSGyJyLPwA8hsJ0c/FbAZbhYDsaZxhcI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7669.namprd10.prod.outlook.com (2603:10b6:a03:542::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 14:13:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 14:13:33 +0000
Date: Mon, 20 Oct 2025 15:13:30 +0100
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
Subject: Re: [PATCH v5 12/15] mm/hugetlbfs: update hugetlbfs to use
 mmap_prepare
Message-ID: <270738c1-e2e5-4e23-83d9-7709601e2e40@lucifer.local>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
 <b1afa16d3cfa585a03df9ae215ae9f905b3f0ed7.1760959442.git.lorenzo.stoakes@oracle.com>
 <aPY7eQec0bB9847x@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPY7eQec0bB9847x@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-ClientProxiedBy: LO4P265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db3c880-40dd-4012-195b-08de0fe2da91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mHRSZkotvQpWpzKPJGyiMxEW4vWHE0CFIOGfv1lwdVjQ2nnpaTKMli5N93bj?=
 =?us-ascii?Q?qcjvQjGJ9UR1LHc2Gq5Yc/0lh3AqrKpnTrmDOTZp26o0vlqeJWw6kHSKa6r3?=
 =?us-ascii?Q?0hgeprbnYe9wvJNgsnUW4bdVN/icn+a2pCzfAT/PKBzcdyyySQlVTUp1i8g4?=
 =?us-ascii?Q?8IsmCswzd7IAvurzzhrQIXIWsyjKpufEhUZy5nJTNG5xTByMFiYyex18vDLd?=
 =?us-ascii?Q?upiCQ7Esab/zH1gO/lQr5494KxLw/OnzZsTcp3VMunCOKczUljoKRgH8xLdk?=
 =?us-ascii?Q?GM1biSN08Kov9yDugfnSAqz5FbE5mSs2FT/CCNEFsvqobowCygx1bNQO73ed?=
 =?us-ascii?Q?IJPI6z0X6NA3vXY+7BCi3LKTosrmq8TBhSDNdR5CcI0Rs+cGqPA2N9AZr6kd?=
 =?us-ascii?Q?kRJ1TMoUM5fTIpFDY4lsmH0Bt+C4YVNsHBw75K9/SmxG6KS4GP94zGS1fEPl?=
 =?us-ascii?Q?9mhetllstg+7nCaRkM4xKOg4lZxWo04MQtiZHRZq6BUCr0yJnCyv71IDyhFz?=
 =?us-ascii?Q?gYGOI4mQve4YhYhX6YUuC0lZp243nxoEnLMVZtfBj2UmiCUFVre9Cy7RByuH?=
 =?us-ascii?Q?CxMZo2H/Nwss+fhjiy5/0XBXKKQ7RfGFSftueG9xKYwrqW9pclgrbwzEdwui?=
 =?us-ascii?Q?KzS4t3c+zo1yDGuI+jU7B1sepol5vo4SpAMO0Ekmk4jFqsvhW/2dBBqPmrAG?=
 =?us-ascii?Q?inE340TroKE9n1b7izuMkmYezz8SrhAv2UZiihrhZzCZ4bhVW+JKk4nS97Wk?=
 =?us-ascii?Q?v8x5kZGgCPbnAbXYMWjr5Ms7I+41H3E7VIwKaNPmXE38SIv2tO5+iK8YsZRH?=
 =?us-ascii?Q?J8hC26JA9kaThb9hpe8cLGTUmPJD3giq6EQAVtzh86WED2HYbZimlG9CTsuG?=
 =?us-ascii?Q?wsKTVPiMHhOIac7BMCALT00T2r8ibCJf7z+6k8uv2+WS0fOxzgg6DncD0rJB?=
 =?us-ascii?Q?Zi550ulHhNLiXc90tQk6m/LOeATUr8w1DOkGP6M1oaLxK/M692Fs7EvpN1nn?=
 =?us-ascii?Q?CGLxJBszVK8wXs43XG+a7j/5N/NwP/xvScpbxFGsxSMV24i9+KCUX/uZZggt?=
 =?us-ascii?Q?/qfpEt5h3Dx20T9TGnxPmAxHOIOf5wiPCtus9prywilxm3F/0TiOdjTBmqWH?=
 =?us-ascii?Q?j8QWtt9iJyTHFrdS0cQPLMHwix3Db3uIEm2M4kMLaxVhK54mAorijno934Ui?=
 =?us-ascii?Q?1BRcXALOSZSOeJt7B+vAGbBun52zUZCvG7INc+Y6W9jIzmfCORv3mq53mgWF?=
 =?us-ascii?Q?02lMnWTMcZtELIQ2F5xNoWfzFnUWICB8C99CNHsZVwdTbGl6LfSDsCqUcK0u?=
 =?us-ascii?Q?Gj/P8qmwcNsq3hVq7IfCckz/d3OHTyJ7voUZMYY22HQozyBX7j2IGjxSATIv?=
 =?us-ascii?Q?5BPmWvxJuOxEOSr64J/woxn9tVtZm3QI7iCKJF3r9J9SlaJ5wok7TyrJe4Ca?=
 =?us-ascii?Q?XIZVlHtIbDTkYTFcnR+JQSDM4hMr7y3j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1l69Ii4h73OVG+aq9YKj+syhqEQStHaBNWsPyhSFmrr/Il/ay4fTun2iLDp?=
 =?us-ascii?Q?EkhEtFgKSdI6VQ7RNx9rgQhCRYxteS+o6WBCd2sXyr0I6WuP2y1McypdFDYZ?=
 =?us-ascii?Q?q/1gKtrr/UBpIqVE6j0JKBqyTuJ3Z5BXOu4TVYCJRFFKul0eVih8qGbPbO3d?=
 =?us-ascii?Q?932bMS7ut7jng+nSQKizj5mC/SI/3xi24ACLyhIAQ9B0q23r1vn2yFr0rzs7?=
 =?us-ascii?Q?Ph6fN9Cl0LcgJAA15/biN+3hDrGrsGtxdq1p32SAU2pJ9pLhjsi7h9LWnCSn?=
 =?us-ascii?Q?EcqXGqeaJtAUbKT7taHEnnCGk2P//F6lPBLvwkvfJdf9EryBZrRTu9A6rupU?=
 =?us-ascii?Q?5/e3qZWUg1sfThZj/IK2rcMw0KWRvOYdkqq6SVEmHSYO+2SHtHDkq/M/hcAT?=
 =?us-ascii?Q?YfEBKBpMRKRNVcacPYWe+01hceyHIEQ7ZSQ7V7IjH544Lszcp/+HzqfT20Yy?=
 =?us-ascii?Q?oQms1xsLxvV5Tlb3BK2QbsHzCXINrP/q2tweBWdQksE9BwzdTyZFGW2ponas?=
 =?us-ascii?Q?zfsBcKqSvOHRKxOssxYN13JlqvichnjiVDlmEmdsVP1R+E/haYT5W6w8u3aP?=
 =?us-ascii?Q?CzASjsB3TIvElX4t7IDxY88+C2xGe9OUSdjeHZaoN5xD6x/3IbCa+yhZ/1l7?=
 =?us-ascii?Q?hUJQa1jiAauya9PQ8yWVNsOfl863GBHH9fgaP6MSysMxya6RgLe5DM2bfL+M?=
 =?us-ascii?Q?moqFQCaoFAxJ8SaMVul1fhUmcdR9XfDNTwi3UOCAcfDTgFpEgvOuUE9EiVNh?=
 =?us-ascii?Q?PbxRK5DlpvQ1HCdVGq8W1f4yGX/csUQs6iXHOsIjcKJS7eO50c2GJABI+5Rq?=
 =?us-ascii?Q?hbAj3xg5gePGKSe1HeX2tIkxQKnw5ieIp6jlnfBB6jyr/kh6C3G/WxzyKENZ?=
 =?us-ascii?Q?cRgyl9k1xoU8s2te1Y/CE6/RisEWcuPu5hkL31NFKHoddeXG6PLvcMQw/wSL?=
 =?us-ascii?Q?w+PGg1HiqtIRB7OqTxqrKva069baK6LToAElrSA4BFP4EtVLF/PKjgIPKWyl?=
 =?us-ascii?Q?jEswUOYv7r9cbUxSC9WD0z0Tpb67DIJqlmH3faLtKVpVfapI/Z0RiFEaLyef?=
 =?us-ascii?Q?r4Oj261b149unMDXGAsIuKnx4ZcgH46lnFumpV1IhXMEAEl5WS8Qxk1Ngd2u?=
 =?us-ascii?Q?BEitIdGgHpLHOSSpl/Gkr3vxN/7Bj4XVhbYk5o34Qojvae6IsfaCCM71Qpfg?=
 =?us-ascii?Q?uN28BLUA7gBOcNMe90M2xTAqCAsHCr9dN/0f3dnaHOCbPMIOMrkaO7ns5CR+?=
 =?us-ascii?Q?7quRXQKrwWiA/ZTvyFBXc5CjBlwzTeMMYHp3oZB4jZNTV/jUGeMw8J2BBAnW?=
 =?us-ascii?Q?49f2Na4I+56FPvvstfHStubUxT3d/ZlNSpgJD29gio716M4A//Nqoddyn3E6?=
 =?us-ascii?Q?ezGCVAA2v49HTicib9IBqMS5xxLPLJhBX8BTKtn0ViPKeAX5BTCLtFfEGd6S?=
 =?us-ascii?Q?35W6nOA1CwWy4WCuLy7YDeIgyB4UKGu3qEbzMVuNjXw7hEVlMfyk9L7sNSJy?=
 =?us-ascii?Q?490Pkv4o9DPGzgRNdPqoOkIzUlBXx7svndsKq1w2WDoNUHfYp8muNMNjE5iD?=
 =?us-ascii?Q?V5PHg6SDUeBS+vw5XPumn/cjz3yNIADtdUSD6aaPyM4bSY/9ulXwGF4g3aWQ?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9OrfgLaeo4e7nQv1QSqz9WYZSb+tvBLr+2GdNhEyopKaScu+82/8k9M/bFCXlGrq9WkIUuKiRlLAk0RYBtc4vXK08jPTABIwVYSAnKMpRcS7atV8XYj1wuY4sLLBFpoDSVMjURcQqHYezK1IDdJ/VD34xqUh/SUVnXs07s+jJNopaSVWSDQrIoM4T8RS5G/9GYBVsmbosSG0ROMNZ2kRMHEsINTcC8fm1QxMAgZwdm72VSzwaDvwVlDybT+wxmIHSmBSq72RHdtc2JMab2kIJShzo5avPNbbhfJD+1VMIgd12vAA8jjU8sPu/OBFY4guwlDnGxmM2O8HUvpF466Lf6Qfw+Et/UP4EmwZlCos75XmeHCwrzXcsv0BrLzQyKJrPyTnbCeIIfoWk9nO46OBpTjI63/zrV+QDgaWgzea8LfhZnUWDHMU9LcjyBbLklvQGbhVqxxJ1tHY/Y4T7pRkrJ9/GmYatOLaK/868VRiiW37PuV8kWXgYRFZB6KpfN2Dn+h9LZuum3EungvZlkuxLlihLzYFty0OPbK3DdfJTEJF9yrx3uxgZXMpGog0O/hqBub5uujFR4JUHDC+I+7t0S3maSaU19O3EPpE0yoZLq8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db3c880-40dd-4012-195b-08de0fe2da91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:13:33.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HblqPGAzpES/8gt70k9aBo4q+2hrJGbyv/ETRLlQnMzN7VYV16SA8G9THs4iBz7iWC3d42dcjXZ4vmUUVyw9MtWbVzSreBbiyCYU9Cf5ghg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX8nyhQpg6YVWW
 xikZyxVmIUJGKK+HUa5GlhOl+B0F/QvURzab3589+9+diScp6v1HcTNUVpeV0t/rByxWjsM49x+
 Y/EPCVIovhtlWooi732XkIvrlYu9Gt7xn7f/0Y3bu7ETqquWf62bqORiBwOq3lLTo/7u/VE1slA
 iR4129GQPIooYNBg98GujvFveIzPTjema3kr8EE/O7J3rmnRdVSoYhqjplpQIboD7cNjRSr/fjf
 IJjYFSiCh9wuNtJ3GcznfIfT6qanOtRAZMjU1FAzQBYofMTNEdGGUgFCp4mgU0j17SvocSWOe87
 wbVVwzEOQ1cxmTulVqdLwdgiSqaAT1iIKMFJOOxt9ueRliqaT1FrH1xf8yT2La2PEFVEbpAgap5
 sFuaI4mpi9aC6tIvmPV6PUevuElt+g==
X-Proofpoint-GUID: kdkqV7_Qjde75NJU4d95VnZyxM6-vws5
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f64393 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=seDGfn6Nqulq7RY4adYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: kdkqV7_Qjde75NJU4d95VnZyxM6-vws5

On Mon, Oct 20, 2025 at 03:39:05PM +0200, Sumanth Korikkar wrote:
> On Mon, Oct 20, 2025 at 01:11:29PM +0100, Lorenzo Stoakes wrote:
> > Since we can now perform actions after the VMA is established via
> > mmap_prepare, use desc->action_success_hook to set up the hugetlb lock
> > once the VMA is setup.
> >
> > We also make changes throughout hugetlbfs to make this possible.
> >
> > Note that we must hide newly established hugetlb VMAs from the rmap until
> > the operation is entirely complete as we establish a hugetlb lock during
> > VMA setup that can be raced by rmap users.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Hi Lorenzo,
>
> Tested this patch with libhugetlbfs tests. No locking issues anymore.
>
> Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
>
> Thank you

Thanks! I managed to repro very consistently locally so was able to also confirm
on my end, nice to get external confirmation also! :)

Cheers, Lorenzo

