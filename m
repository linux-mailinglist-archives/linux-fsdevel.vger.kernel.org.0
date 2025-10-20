Return-Path: <linux-fsdevel+bounces-64675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C76BF0B3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9982D3B2D24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257525A2C6;
	Mon, 20 Oct 2025 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BDSGg3f7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vfW3hsuI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F2246783;
	Mon, 20 Oct 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957992; cv=fail; b=qQda4POf/azeGd8apbK2P8uRUZXiviUljqxOBR5SI8WaQ+vuJuPIP1D0Y2UfIbB9uIKC7+QE9OAoOY/KF5bIWm6FwTFGdWLWg5WxHux9v375IJBbI/nVuY4VSZMpz8wf1ouO+SQ5+umAMMMncLwn+ji0j52Ppgf210Jw3SP7BcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957992; c=relaxed/simple;
	bh=Hstoaq1tzn3BqQ53qHefcYObjh/k6IkXf5TE1ksndCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YRggeq1+DnKCxUpcrQACPnxMFDeRWmu6Dr4C767wjBTscAk7WWVBZoB3BzX66soOm16YypJL7mUjFZ3wgxA0yeRORHVQcKVLZin3d2cINv0Xvui6aVkUAdcqXJDqiIxdXepJEGWEFr2fpVSc6SM/iuI3E2T2OQ5qezkVy2mgzl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BDSGg3f7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vfW3hsuI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SGpq001292;
	Mon, 20 Oct 2025 10:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6DeOj5B3hqVtP8eDz9
	b4PIGraAXwACunXvQ1wQN5n/o=; b=BDSGg3f7dlNvdJAkmMlz58CIVg2eDwubC3
	9u9UCZkQYx5XbwhKRpDhgbLmD0hAvnyhM9ow7quYGAT69xX0BAydSdUMOiRPSl8z
	dqzv/zgPevXi+z61H4Q5onn7M6FRW8ytlE8F7G/aoHHSNlm/5eGccaWYqRdjoEOj
	UlYZJ5bSrNGKaf9zoPw5aWepIZg4u2xpLvW581lTEfk+eHdNl+z5HaFqun9P68tz
	dqZN12r8zlOTrepNV3VtZK+vOQv7EChsY5j5BfUx1n7R1Do7i7N6Ke4Ke4k0rdIO
	JvICI7vNWDJ7egGrXj/SXbX4l5Xob1LLPe+ckmE4ooc4htkAQpBA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v30720mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 10:58:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59K814Xf025454;
	Mon, 20 Oct 2025 10:58:39 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bajn10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 10:58:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig+FUkrr+8m/Gxp/3uAlx2mXF7tM53TatAdaQii00n3QnT1c/g//o0jqdd52+jMGFSeP3IRhqDc6+E+8Uv2nJGXwOSLCUMjl7nGYQ7l7+uqSM2Hv2dU7yLOvbQvhQ/g/34NwUMm8rry0eu4XLqkAVUtPtHlYaMILVZWlxsFCFYiPa3HXDMPlxhmPEWfVKmS83wT9XYNn4PfAA3+e3Iz8gFjgRrbF0mA5npOUSMwRzVVOE1/mwGrq3iAKN5hrQpGF+N5sy/vNcowiLX+mp7w2fAGlODUAP2JA4HEa33HyUXBGFNNhhM51bhbZ4+TjnmEQIGvsLw1YfJfocff1Vy7GUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DeOj5B3hqVtP8eDz9b4PIGraAXwACunXvQ1wQN5n/o=;
 b=s1c2FRt2JkkLY7tit9eoZoDVL8ZNN4e2rPMSrVqWqQ78pbdjWwDBtB1p2moZC8nNrKkRRlGg6JZ96oIh3Jb5Y83Ad3q5kQolN9Q5hr3L4SBzBpRtvS09Fef5LfSbKIJgM1x9rs0TpPJnqQhp01diLx9A+vGZJL+eTr8dum4hb4b1Atu3ZaEzQABlHEHk9427pHHOX2KHnpeogzCdUjlwT1hjn2qCDnTFBvd66pFiD+AQukTaXDTDHxRAUxUkmo8z150af7sqBSHB9DyOpSDieWbKyMbiSfSu0ZKI6TezzVBG8sNegzE/sLXDlScbFctvZmLmntlGTXxSG+wFIW2Txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DeOj5B3hqVtP8eDz9b4PIGraAXwACunXvQ1wQN5n/o=;
 b=vfW3hsuI5bJwVWmMI4PnbJAutdJmvUNPIXHrVTJnyM8pR5UgQaPI8GVodvJNWpuTFeW9RAiuyRr56e4yeh8f2Qo5wjMMYNDGmq7z/yXdhm9XWqen8Caz3qMgAYrgy57IvJLaGIX2zCzlDA8I/E0GRAkX+XuLt/MDiORioxpi8ZI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6309.namprd10.prod.outlook.com (2603:10b6:510:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 10:58:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 10:58:29 +0000
Date: Mon, 20 Oct 2025 11:58:25 +0100
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
Message-ID: <2e65cc96-5fb8-4197-b4c2-188c4378c417@lucifer.local>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
 <e5532a0aff1991a1b5435dcb358b7d35abc80f3b.1758135681.git.lorenzo.stoakes@oracle.com>
 <aNKJ6b7kmT_u0A4c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNKJ6b7kmT_u0A4c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-ClientProxiedBy: LO4P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 0241265f-b17c-4ace-9c98-08de0fc79a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HQurt4UF2aIWJaNVGFvqs2SpSsbwJiWpVGOJnQXEeErG/k2y0BlFqKdYvBdw?=
 =?us-ascii?Q?5zZmynjUY6h7UfEDvDpcMTZJAHhah+lqrtTwLekdA2eRfaKveaV7Nc/e0/kC?=
 =?us-ascii?Q?/USeHaFwx7gXl6qACU/OVgL434aKQkF+tCdtlCb+AiA1vm3Ev5J8o6u36tpC?=
 =?us-ascii?Q?HvtC7IOJ+bq4ms0106HJmTMg9X5mY8kbJdvRUAm5A52cAd4xlynxjFmjIT39?=
 =?us-ascii?Q?CEMLJWJmoncF6tpFM3bgxeeLsTnwWnu/GPsxZdgZB82NRSFOkt6/hQvnt8nq?=
 =?us-ascii?Q?o5OI0KfDiLZweL2b6NvuC3kkI6XtEy3Z6hJHGNu8M/R7Iz2dB2PLbjrImrVq?=
 =?us-ascii?Q?K1G7LKNkHfAhC5Ro1bP6KgRbPUjs93H7d5jCZSllRar/8W0qXSMOJWEWLfrY?=
 =?us-ascii?Q?ScqsCItkDytWGdHxjDZmwho5VzmbgM7+1d8iXns1qQJq+OADTdyTNYwLBBb/?=
 =?us-ascii?Q?chEeaj+2hQH6jE8LXuc2mri75Ic+MeBMlG1zhs5orj+R9vYIrb9cI68CtqY+?=
 =?us-ascii?Q?+c4pdYKPnJTVs6OMNc/pHTSsMSZlDEq2RzcTCGc4gx0i+/k5dVIRS9awcMRZ?=
 =?us-ascii?Q?wAYAvcak7rPjY0wMHIl+6kJtNJO/LWrvhC6hGywsfZ/XXJhRyjVW5g9biExk?=
 =?us-ascii?Q?nnsEWduhHAPmi0LvDFCMSkLgVGX+HC/bTUffw2wDsu+xP4kZwEXj/awdXjtp?=
 =?us-ascii?Q?KeOAIPDXfmN6lBV6jDymNcAifZ1xxjoATLCcJE7pJa969Nyt4Pv2zef06mWf?=
 =?us-ascii?Q?bnrl0lBinqjx30rWgsL1KuxczOuj+Ou87ZBRBgggdSFP+lI1OFMQPIz7Fbry?=
 =?us-ascii?Q?FeqNYmON0cg70cs0hNKOGbL2fh0Vg/KYRAwFYgRwRoJsobljuJF22pOR5jww?=
 =?us-ascii?Q?od5YWdZYpezQkeefv5ISqf+wRo2ZaUC7tIJbKBC9s6xMDyKbvmTW1nC4GOTw?=
 =?us-ascii?Q?Z/NIi8bljuvCf2t6xZz2km5dIyWTKwW4iJAKMsiRKXVXxU9WO69ntmFBauQa?=
 =?us-ascii?Q?pjF+7RVYIuObAnw4igPZbcrTilGyKidyIBsOa0D5cuKsbtZ8q7C6OEPynUaO?=
 =?us-ascii?Q?0MgEdx7wiYU0GtgkRbZPMQWK/DWB8R+eFTVpJpBkFsQbpcgHt3CkbN2ebBwN?=
 =?us-ascii?Q?0TVjGM53QUqSUKaWXCUuh1pjjeQazzZt5e20nsqDPDKOITr7v/AfkPZsZvx+?=
 =?us-ascii?Q?G1viR03SvyazWnNAoeE97bbOFQveQozqgg0vnuiMt0LjDWhUb23blMvCo/Q3?=
 =?us-ascii?Q?oDNKpM6cRqsPo+nPAOnou922oUKmAGYpHDLqRvbhg9hwKuxwicpF7OJ7AYy7?=
 =?us-ascii?Q?LRM8h/aTPNhQcE3LIC90W1GSuKIekRJvnOzzUe52UA0M8xVCZhItPww+ZMDl?=
 =?us-ascii?Q?LjQmpPHsQ+MXCPHiBR7ZK9Ieh8AScdfIJnTEWjhSgV9wND6grzmWjmh/Yrhi?=
 =?us-ascii?Q?e3qd1E+UuyJsbl7FIcLy1jQa5p31Kev3IpWnDjc+v+MBH3HKugX98A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zo//R/AnIwfxZir8TqmV/s+8ra/Wz+EfZasteBUse9QYixIPdoSoLuiMkaZl?=
 =?us-ascii?Q?FfwP23tovYpXI/g1gytsVhqnxT5R41IVjbVTFF/AnEIiyuW8ABU17MlFAtFI?=
 =?us-ascii?Q?Sx9/jJ3ERMuscEEegfwZMBH5R5S2wcZdOoy9Bb7htbp1xtHfr/wotSbRunwy?=
 =?us-ascii?Q?YwYk2OYJAbYUcLs4vvsaWGthDoemvEUGyLlJBpqo822frq0akDgcA6/g/qrl?=
 =?us-ascii?Q?YRGXY9E1W9rkVwGZaNKb2vZaaBQ8SBn4y8DcvdpLXD163zj4tfb0h3kaiI/u?=
 =?us-ascii?Q?+WzkYQ7TDMNw8kkclRGTWHvuUztT/vqAiaJXJ+Q+a4QVoTbCeomnxHdcFJjK?=
 =?us-ascii?Q?ryuFpz6471uR0nJFAkz/KWXoLsSb/yT91U5fM3IdSKwOlWexp6Xx99gfpiKa?=
 =?us-ascii?Q?iDr1GSthOxUOaAqO6YBrObrX+MNEliRDNs7y6VSLvUVD4P14UjK5hYfFDUdN?=
 =?us-ascii?Q?M/vRTN+C7o9/+PREEyRviUKgzLkQoh8WW7fKYcZCarAL2MDzybkPwrTlWMfB?=
 =?us-ascii?Q?sjBqnBb00CrFVu3pH/VMW2hxOmyd7LXpHFsE7EC7i5yhNDoqp07Dh9SAV/qr?=
 =?us-ascii?Q?AU3Xko1kdx7JekXPpfLDCgDHU21ZseZwYk+tIBAPAAwn7P+H9NLvNsMY+nTu?=
 =?us-ascii?Q?go+YKHABILgQussLXiqjJcQIHFPqNAWyGi7aZ5l/7qsldzbNend+9R0BvAFY?=
 =?us-ascii?Q?XMP+PwTj4BV8151zCNn0khQxTgT7nHtuF0clXi7yEW5BOsALDobZCnWAyBNV?=
 =?us-ascii?Q?YEHOQl2laK/ZxAGokXa7HEf4Gaqz9SoqcojVDNSYjx55hQ2ZkYLokaG6273E?=
 =?us-ascii?Q?UnScLOPBseBw0PVrt7VHKCJOgi4n4guB5XvWWa5G6rYkx6JZGEYI/jdcVCoB?=
 =?us-ascii?Q?LKi5X3yWhuaZYsfPBGxH/9Qd1uKUSb6vV12XfYL9lWDcbkEUEk56+VFBqxc2?=
 =?us-ascii?Q?44GJNekdj44+DG9v22E12jh0PhNnOJ4oUNT+duze7vwWSLTY0qENw8I2p9KV?=
 =?us-ascii?Q?Vgs4VBeFZCEHWMR448ltbt9AhQ+Hvmqb1BcFJ5fOI/wR5mPlolvqSDDILOtr?=
 =?us-ascii?Q?HQWIWFW1jrblXEqv1GNR3kDYdDvSInx7JwDeJN42hy7mz0MwUthi6XHDgMuk?=
 =?us-ascii?Q?DHhtdopyhQdd21TYaUvFtT7088tqSwLvEjPD0KxbZM8cMjmki0jyFbLIIejz?=
 =?us-ascii?Q?GSGUVTm3wJhsn5i+6IVt2V/fFfGa0uxLAFQ+fVX3SU96hybr9QWKV+AAXrdo?=
 =?us-ascii?Q?lRZlyUzj3u5MYNTuTLFqLVNJVaShe46xfYxoKymbTSfil12lm/twIHbuPpJS?=
 =?us-ascii?Q?8hEZWJxSrEhsxZKcI9E8g02iZ6xV8mpS1gQHsKrvBXP6TvkCklWG+KGuAU34?=
 =?us-ascii?Q?SLts3B3HMUDqqz8eNHrNhY3DBgSqPRQ31fy8IxU4PAatM/Tnq38pXI5PRuxD?=
 =?us-ascii?Q?dVlN4Kfs788IRxMn/g9vSnLBTG6D1G6gzahz6qjJ3Q9beKXrSmv31sDHnmGh?=
 =?us-ascii?Q?lSAWXst0TaHNfiK67B/cm04V5CZ2U4yCfACA+xABRt6/Y/0adDvfvxIIn304?=
 =?us-ascii?Q?t0XWQMVBqDEInm9FMn5ECY37Sld3Fwq7Vs4TYiaxuEqqWLZLgiePqwqXAQw5?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SLkgNDVThStqekoXvuQqPteLAnYJeqGWZ5m3R+Ka0yQgOPOvN+1QVpikCdgR8BFImiarvCtwhaau6qLEg40GBt7vwqbPl8smZ9QKxvsIJ1jMk8RJkcz390AeVK6qk23JfCw1HK3sLLIPJnXYRtkin3kkkfLUSM0hrx4v8LYGiAmV+2Suvrp9j/FxN2kgujhxP1tttxyTBXiUStYMkeYkQJ4/88YYV8CTr5cBJIlDcPzgONK28SGwLC4ema9aHGFK/JnzvNEtnv5R3ierkEqYXK9GrAK0HWqbIe/KChX6Lm1lGx3SMtYvx6iyXJHe7RCIzlIcF9i0DN63lQjSi+suidHEId7YnK/tljAqAMy+LtPnOOl4oS9KhJWzPMT9g4SJg7D8ewz6TOop/VlhN83UD400e0yN7fRVOUu+onQXQNmJBs+ywTyQDGe2CtfK7SXQp3xnwNBNXV2CWTXPXcWK4RC0eDxHyokZ9MaAc8tgZDQ876+Ja6QdTR4IosswuyKPOddrO6ujdNdnzfVcB4xa7uUpfMNGgjKlUeIBH/PTDTh/GUIWqh7f0hNIiZnKT2V22CWm01gcOUpV57/+fVZGNs9Is/6svbgmhfAi8nqqv8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0241265f-b17c-4ace-9c98-08de0fc79a22
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 10:58:29.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amTDnaYqfpZIL+7zDPfX0Z6CpTe7kRSL3RLg+E/Z8nsL9WfIsGU9K3z/BgHDa3SgaYc2yeapzcOlsc/mYgMvFeZEvun16pGakhvckoN+tg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510200090
X-Proofpoint-ORIG-GUID: Kpcu5MVePK-Pq5pmBKNtwZ1to7mJX6iG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX/LngaFjWEreo
 5HfQ1vqokBUioRyQwjm4diV2gyy6AqaBZ9xloSZwQD4Pg9d4s5+3fRpCsx71oAJD9G3Bgkrz1/u
 2rOOwABRDT6YYekgAMr078/P+XVxgGhbYsxP8HXu5p1ImYqYzyPP/EWn4xBN/zLD0AOrgzQtjMy
 dxl0qR+8rmm8Bg13NumdhtVv9IQVnTaScojviMQCWkDXKiTW1OzbuV+DLvfwpeXoM7Xxi+hE0mu
 GToUKhmtCkyCU4jdxIC+JWuXr/tgmtZTaGF25/Ulxu0Rf+KLIgGgXm/Tambb6vSSC21FJHEvfL+
 EUAXRImVXCsocmMH0cAC2yhdtjP9hCTnbR0FpCfUOsuTKGmp4+H44xFGQ/PoQFm95h9OESmWLOW
 ZInahqGr2kJoHopijSPx35zEmc0Z8Q==
X-Proofpoint-GUID: Kpcu5MVePK-Pq5pmBKNtwZ1to7mJX6iG
X-Authority-Analysis: v=2.4 cv=csaWUl4i c=1 sm=1 tr=0 ts=68f615e0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=8vbGaJumKrr2nQpYZncA:9 a=CjuIK1q_8ugA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

On Tue, Sep 23, 2025 at 01:52:09PM +0200, Sumanth Korikkar wrote:
> Hi Lorenzo,
>
> The following tests causes the kernel to enter a blocked state,
> suggesting an issue related to locking order. I was able to reproduce
> this behavior in certain test runs.
>
> Test case:
> git clone https://github.com/libhugetlbfs/libhugetlbfs.git
> cd libhugetlbfs ; ./configure
> make -j32
> cd tests
> echo 100 > /proc/sys/vm/nr_hugepages
> mkdir -p /test-hugepages && mount -t hugetlbfs nodev /test-hugepages
> ./run_tests.py <in a loop>
> ...
> shm-fork 10 100 (1024K: 64):    PASS
> set shmmax limit to 104857600
> shm-getraw 100 /dev/full (1024K: 32):
> shm-getraw 100 /dev/full (1024K: 64):   PASS
> fallocate_stress.sh (1024K: 64):  <blocked>
>
> Blocked task state below:
>
> task:fallocate_stres state:D stack:0     pid:5106  tgid:5106  ppid:5103
> task_flags:0x400000 flags:0x00000001
> Call Trace:
>  [<00000255adc646f0>] __schedule+0x370/0x7f0
>  [<00000255adc64bb0>] schedule+0x40/0xc0
>  [<00000255adc64d32>] schedule_preempt_disabled+0x22/0x30
>  [<00000255adc68492>] rwsem_down_write_slowpath+0x232/0x610
>  [<00000255adc68922>] down_write_killable+0x52/0x80
>  [<00000255ad12c980>] vm_mmap_pgoff+0xc0/0x1f0
>  [<00000255ad164bbe>] ksys_mmap_pgoff+0x17e/0x220
>  [<00000255ad164d3c>] __s390x_sys_old_mmap+0x7c/0xa0
>  [<00000255adc60e4e>] __do_syscall+0x12e/0x350
>  [<00000255adc6cfee>] system_call+0x6e/0x90
> task:fallocate_stres state:D stack:0     pid:5109  tgid:5106  ppid:5103
> task_flags:0x400040 flags:0x00000001
> Call Trace:
>  [<00000255adc646f0>] __schedule+0x370/0x7f0
>  [<00000255adc64bb0>] schedule+0x40/0xc0
>  [<00000255adc64d32>] schedule_preempt_disabled+0x22/0x30
>  [<00000255adc68492>] rwsem_down_write_slowpath+0x232/0x610
>  [<00000255adc688be>] down_write+0x4e/0x60
>  [<00000255ad1c11ec>] __hugetlb_zap_begin+0x3c/0x70
>  [<00000255ad158b9c>] unmap_vmas+0x10c/0x1a0
>  [<00000255ad180844>] vms_complete_munmap_vmas+0x134/0x2e0
>  [<00000255ad1811be>] do_vmi_align_munmap+0x13e/0x170
>  [<00000255ad1812ae>] do_vmi_munmap+0xbe/0x140
>  [<00000255ad183f86>] __vm_munmap+0xe6/0x190
>  [<00000255ad166832>] __s390x_sys_munmap+0x32/0x40
>  [<00000255adc60e4e>] __do_syscall+0x12e/0x350
>  [<00000255adc6cfee>] system_call+0x6e/0x90
>
>
> Thanks,
> Sumanth

(been on holiday for a couple weeks and last week was a catch-up! :)

So having looked into this, the issue is that hugetlbfs exposes a per-VMA
hugetlbfs lock which can be taken via the rmap.

So, while faults are disallowed until the VMA is fully setup, the rmap is not,
and therefore there's a race between setting up the hugetlbfs lock and the rmap
trying to take/release it.

It's a real edge case as it's kind of unusual to have this requirement during
initial custom mmap, but to account for this and for any other users which might
require it, I have resolved this by introducing the ability to hold on to the
rmap lock until the VMA is fully set up.

The window is very very small, but obviously it's one we have to account for :)

This is the most correct solution I think, as it prevents any confusion as to
the state of the lock, rmap users simply cannot access the VMA until it is
established.

I am putting the finishing touches to a respin with this fix included, will cc
you on it.

Cheers, Lorenzo

