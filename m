Return-Path: <linux-fsdevel+bounces-60536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D189B490A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6C51647A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD930E0C5;
	Mon,  8 Sep 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J0HH0w7B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rkzqUBF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E430CD94;
	Mon,  8 Sep 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340187; cv=fail; b=mDUEJ8TbFcDpiiFsfwI51uAZ5i5Bphwh4boLVH40vhvOvgv4isBzV+tYvwhMIPe5k/avByDXuLTtka71hbZF26KySQVV8OIYcSiyqD6NFyeYbCHHhiQ6jeozCpW0DqRkn6yHRRRDtTACBNvmFJPEKlb+FcUv88wEL84RtL25UG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340187; c=relaxed/simple;
	bh=rlby7aD63S0caPP4V4d46x+MTq1HBtzdrijinvJS2cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WoBglAoU488Mp46CxeEJyN6VK5sKPTcCQZQ8I76ts3gMq+o3Mhe+9AbmRRQXbW8gWVaILqayT2tqUaG91zoTPyw6qypg75Ij/kbeti3yHuwosp0A7dYHRvQAMPha0s84yM5h4CXUGyfdJo69GSdzKnThUNag0jszi+remKGKiuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J0HH0w7B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rkzqUBF/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588E1tQe031637;
	Mon, 8 Sep 2025 14:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hEwpjCk8X+M4hg1ihX
	gCYpBWZbmwMzJfPUOG0ULc7Sg=; b=J0HH0w7BfkCH5PM1Bww512QeGxmvcwaBVW
	HTGj1imIPUdo9uTKM5+vdbwZjC2w3/o5M/ayTvPIVEtotqqaqaZubwevRb1COt3a
	A/bm6wFw/S/5FX4elyWuUC6gupqozHYVL9bQyKaOmCAdf8Cx5Pwz3ftI94qBJQaO
	UGrms82ejQQ+khpLJj2UdEbSezALxJkisyiC4x632U29IAkHw1yzVu85lpadjbD5
	HYJT53GWtyB9+Mf4E950qWn/9P3b+3ZDTn+6Ltd2Muv7hn9pfQ4pNqHIEiBCUxyO
	ozR20SyJStmqMhmgh7VZfDTqfmZDvtR1zOJKmsF8r2/dbrFbNnUQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491y92r5ju-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:01:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588DZELx012872;
	Mon, 8 Sep 2025 13:40:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8ejvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 13:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgeBfdg4p1l+SGVvVYVI7qC3CUkHpZLU2M36RzW07D8sno8ej6JXndoM5C3ZLb1F3rZ+AiLY2krp6i+faNYIckdxfGVi7DFjoIeRYGMyxqlbiN8mlIzjIcJO8xBmRTxV5WLruMfxT1G6OYAQ1do0Mcgj+AInPE6TNsiJsVz0I7ZjgCgMlRppYTTVvbfwhamP1//efe8HfSnJJhDo4NZhIBvKZC/rqExHLINORgxyoA1azWeHsuXx1dQLdLMt/d70b+RgRZWQUNeSOnz/r4eFZ4OvlEIu1B43eoFA22PSg59pm5ZN8yBmGWEyNTcDj7S8np3QuY2aAb3N1dJl+Dllww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEwpjCk8X+M4hg1ihXgCYpBWZbmwMzJfPUOG0ULc7Sg=;
 b=kjI+IDdhlNfaIYG39s5O2uOJwI01Bw/vl/Vqp/Xy36k8bRQr0gT2plBwV5cWEevNZmSUb/N0ZP2lwyX3RF8nDGKu90rLmn3cAsCzOvcFCjVV5Dc4DvkFvImmv8kozVUNK+L7aeg6yjbpVwRNHFUV/Nsrffjh1S3tqLbqqpYhVC0sMRvyb8dai+Ic3GpkbRwKaKldLzQ/TYOfNCZxjoNp3hGpNRYRqDUtILJnZxt6qUXuVmjqI/H2oap5iYtnvyqniSYIDDNLjJzS9NjMTT8tPglunXtVc+iowVGk8jb39472DrDZn6YrAq6kwZ/n6KUc5afZeVrmUz0Nz5/YdOgQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEwpjCk8X+M4hg1ihXgCYpBWZbmwMzJfPUOG0ULc7Sg=;
 b=rkzqUBF/HfzZ18olMGa3EcqSDlWE9L3JFNfhbSS6d94FR1EDnwHqx6seJ4blj9H9xoYRHhDt60DHv32zN2H7eAhRRTwtb3xJt873MIPSglaSyzp8Swoyd7y6bdB16LbYD/HaixwUsbePXw7eNz3PrBWaGxiVj5SYqw28HTptZ5s=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 13:40:23 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 13:40:23 +0000
Date: Mon, 8 Sep 2025 14:40:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 12/16] mm: update resctl to use mmap_prepare,
 mmap_complete, mmap_abort
Message-ID: <fb9ce6c6-913e-491a-99c6-0bb38f0d1d37@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d9e9407d2ee4119c83a704a80763e5344afb42f5.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908132447.GB616306@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908132447.GB616306@nvidia.com>
X-ClientProxiedBy: LO4P123CA0224.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::13) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA2PR10MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: eaffc3d2-9606-4648-2427-08ddeedd42a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hAk5M8kzEl825tahAmnfzLzOzl/ENMo/4UXxyGO1H8N5xwKN9kD7wHq2YCq1?=
 =?us-ascii?Q?xswJddZb5rtg5ymElD0+ioWQbtOK8DPT1vjaYHLROTnPvlJ5BoRHzNHZ4Mqa?=
 =?us-ascii?Q?5U0uhjJ0gwc038fGXFSx1FymK9U2rIu8TvGmTQ8Di2BWtYaG4HRWzg7w5pAd?=
 =?us-ascii?Q?HI6ME/SIfEJuzBNw5IozmDjGs+FIK/BPXAl51dh9w2nqeHf2KfYuIpTdfzCQ?=
 =?us-ascii?Q?b4xr9ASWwrD0vfE+mCRdG6R8tNTqciJzVOzyq0skgMsPnFnQo5kTPhHNy1yA?=
 =?us-ascii?Q?R44JM9dyzJ+UvwETPSfntcCX0U83EdWZBuOX3WQu3Pw58C5m1TP6IKK9vtvW?=
 =?us-ascii?Q?EjT0K2tUlM5RtdZ1nbAtc+xF/PRNsPIsd6ZgCmApQXoubDbT+P0fSVa/DdoS?=
 =?us-ascii?Q?IHjQ4jFVtgjDSgeYakCKuYW70z8A+H2nQHUjS8ZMkCH7AYShKmQJY55tv+nW?=
 =?us-ascii?Q?IE03p1lApvyzLXSUMr26dFiqpkTFvZzfnxEvlAcvZa4shlQjDi4x2+KJz18b?=
 =?us-ascii?Q?gAhNlKyXkiPHVCNcsLiHOlC1BDnVpILaloA6PymXdLrPICitDouYiWTeenUV?=
 =?us-ascii?Q?s3OBUMwTjUKItpRlflT1sxXo9bP3nghVEJ5nDKiPSNhD5HHsO1z5KI0ycI6Z?=
 =?us-ascii?Q?bKCo0Jj3Hul6zTk9yzA6JbJujrvBklxOdB2OlsHXh2VzrSgU7/1MBlhGWxna?=
 =?us-ascii?Q?tFpqG7dmRKMrzXT64XZRxExQ7EtTm56moYg/Qr40wu+gH6zs6UkRIewhIrTz?=
 =?us-ascii?Q?i+/Yxoq10ATqdP9+J8blJliqbxtrVbux0yGnlfZXhODkm7mVMTAk74IuES5p?=
 =?us-ascii?Q?vp+svf5JXYEtJBRC5bTP8tfdpRqFnJb/1BkWqfHQ15Uu7U4J6wpM/5NrOdct?=
 =?us-ascii?Q?eCgbTewwA43dubTreISJCUPwdiTMrQbbbEkOUniRLzW5EvPJqZUP3f+mzpBG?=
 =?us-ascii?Q?AlZR0Ck/zDNW2i9rRH6YXAl+5TU1mZ2znfJuiG4G08mzKKM5pPS9IsaMLn0E?=
 =?us-ascii?Q?cQf7xa0mj4UgtYduitasDSaF1IGxZ62Kj5hsGFw5QEr076jroiIxUj4z6GkO?=
 =?us-ascii?Q?Xp5uljVhqYpD+9Ixrw/RmnSRluDRkITwdFGz5naCQUGJaGScML4no1+CmTON?=
 =?us-ascii?Q?/q6BGnO9J5RQr8Wx4sYECbTrgFA8/K99iVU7Za+L/yYb47GHzOdxEQzv4UUx?=
 =?us-ascii?Q?CmTrb66vzloyBIXDzSDuBpgkN/RhMMMmJokVqTuumrZMypitVHGL+sj0E9ye?=
 =?us-ascii?Q?ji4AlMeyXTVHrIy9SDMZp1Dwj0f4TNVcSzd73xTnPpBGQ9CyKqCjqVmJYoDy?=
 =?us-ascii?Q?iQRxfopC88tuGgEn1lHEdaxoafHrlc42o4+B+jUAj0dF8MNA6SZ6gyUD9m2j?=
 =?us-ascii?Q?j5lL/nl2DGySzlMpuIpDpAapDGmhJcjjFjMPBF1q2oDllwa5XOsD6lUAw++g?=
 =?us-ascii?Q?I0zBlQZ46ac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NPVEs0bs79yxZVQkzGQ9Grwsd3F3qhUoRONHOPvCUNndsZHzyS/mwy8j3cxF?=
 =?us-ascii?Q?n2PffKfQLOC9DVgvJF3W36kQT2voihDl/AnDi7BsGKUGAgopRDAScWnkjCjH?=
 =?us-ascii?Q?d/98S5AAi5w8ysjqd+dBQhXj0alihjGalm5POyd4rdNxR5PAy4gur76ovvvX?=
 =?us-ascii?Q?IGisORAKGF0153e56V8iOIfEojkLNU1Kdh6snvIEbT4y8BxUtG9GGeHosXvr?=
 =?us-ascii?Q?gPuDsrz9ytVpkrAsNuCxhOFsiHEBwrXNyC2ELyUZYCNEju27zNe4AiewFmkZ?=
 =?us-ascii?Q?eEJt1YzpKW9XjPIQ/qDOf0/d/IurZR3M9eF6Dx5r/4BN/w/4qq1vthUqEGgQ?=
 =?us-ascii?Q?NQ+xGnJoucycrA/cZEhfQOFqrKydBjkRXf47/RFEkW23C/SoqTUXrOl8OqAf?=
 =?us-ascii?Q?rLbdjLb9srDFtCpjZYb+ieYL3GNa9lSv5NCHJMpWKVSZ8v2DqPTBQ5QRJ7Mw?=
 =?us-ascii?Q?tkZqpg4QPEv7lFj4g6jGusT5GTzw67XqVG1pa6T1gKRVxQvmq3TRvqttPaST?=
 =?us-ascii?Q?KHPJhItiIiv2tF3f9NvrcR/scbxCg6+65W8H9rszDyDqZqm/9BNW5ew4OJRP?=
 =?us-ascii?Q?hguaUo580aN4DxIsAD4EFyhBE96f43RUTY0KB7M5ApY/pcO54xDwsnz2UK2G?=
 =?us-ascii?Q?o5Z2KgpvNx/tAx8BlehscwKOV50hfA+IdI/U7XST+9ICVZMgcw+lPGdmVZYG?=
 =?us-ascii?Q?aig9DCfu0vyOKRJ1G2kZlH+QvB1sZTTKyRwlG5fenopTjt309N+3t4m9AFcv?=
 =?us-ascii?Q?qtY3rQTJeC8NiN2EmYrdE5OCsLTl7W3e8rIHq+GrPLoEoyRrwbCki0yLYpO2?=
 =?us-ascii?Q?Fn+4kT846hDVRzvSp+lEgtUqsBUh37pptjN3qFxztBWOv2ggckcAHQ4hrDYG?=
 =?us-ascii?Q?nGChLSqNo6168vxxQBwngZwc5fcoSf5D10op5iqQkAEu7zSovFln7pp2+arP?=
 =?us-ascii?Q?xep3dWDbnDtTO01dBFo67KSjSZ6D63m0CzPas0ULtcP8+EKFszpY8TiPgkkD?=
 =?us-ascii?Q?QPLqQSnXRLg1YgpeBvMGRA59BJR1agphUItH8ak24MLNrYb5chrtyKYpOcLM?=
 =?us-ascii?Q?tDLS/8sKbMNitgqe8G3BiKAlJgH0RDvYO35Ea1b3fU1OzBh6AaGVx+1lcePi?=
 =?us-ascii?Q?dq9GH9i4kow1WrhZs2PDe1dKhaU54SjZ79V0CHLNNIX3iZOdMLYaVOurS8//?=
 =?us-ascii?Q?eb7Qqb5O8i0Za1obo+H+3HySUL+bqJQ+o1NI4uO/4nQLko51POcZYPEO/yy4?=
 =?us-ascii?Q?1FhhL/wO2WurMjcwtr6OqlaZE4b8BRCKNLM+euSXv3LrO+GuNjqwxqpLlyEf?=
 =?us-ascii?Q?k427WHTOk2ve6AgVexnQaY26Jsr55iSNMbjz0t4c5LVK5d8VkPxCoz15qU+s?=
 =?us-ascii?Q?OkaTcqSC7kNyxw73xn9NrxniRuWNnIi8D7l891X4h494kHRmDeLokpAaLxtq?=
 =?us-ascii?Q?nHqT3NRVZ2woQisRuSye7gRZzGeMPKL9Gjeesg5cHqwTFbpWJTKl32cYhU8a?=
 =?us-ascii?Q?S8+UOMwnfcTsuWG/b7sgdTh/W5OkSrxwE3EeyDUgGg9WhTph3BjzJNMw4XvH?=
 =?us-ascii?Q?qRuBj8T1orwZa+hM/ZIvNKWq2Ei0hnajcqbVXV7EKYdsHDl26m6mgsDy/jTQ?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oy49ATi7D+qTd4C1J7BNRHMvbIZT85rYpStjs5/S7nnz0/pYl7AciOfeP69JHUCYUIRrCXp5I3qeZP+u+sF44uqE+fVi7CqRn0ClUfucg2gRimslKNN0XuVnEAzpdYJuxolKXk2rGFKcmG7zX02Lc7zReh3GdbIijPKG/ZE8nk7nOEWGipwArsifg0b6UnaMSTBDKEQBmKz10mIjxRpF0+u5SJxpLqkFXWgRSp65LPweh9clmHL4p8xvqcHQJdnF+pBgy8dSjDnprZiSPucziq6a5ADf4I5mhWdQlaCAQQr8+h4OnXx19CuFZcbgaeCJ67hMZRDNS9Q4bFTMf387NOdujH/7xDsUaxJ5KtR5eGodzSYSOpySIqOg2AG+AFHhlitmwOzIMN9hVjR3lcAifszdY02Nt3T8oss0IG21iG6A1yhloBE+jFpk2NHSNoZ9qTZ7vWXDjrVwhcFdDz058MHbDMAaYroO333wpvo3W9zkW0T7yx1CSKRzMGSQ66kcDWW0qrLzd43TBuheTY08p2aLGYS+GRjlURmtNkh6qFCzBkxNOhGQ+q0qfmJpHlCYdoeHuqTYk5dAL6IsLzon4VjSfHiaGy+UG7aVDgaNEtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaffc3d2-9606-4648-2427-08ddeedd42a9
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:40:23.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kx4ZrZ+e3vGt14NeACSoF/gv/EkbwGBVRfGy11hFRC3JmHGEnAh2f0WLWpMdwKJaM0Nv9mZaZAnnZp6g1oSSlVkHKqLLhbCKYlPNcnmudTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=745 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080137
X-Proofpoint-ORIG-GUID: DdHEZiwxkkxgpqUOcTHqxv5B3QliQdM_
X-Proofpoint-GUID: DdHEZiwxkkxgpqUOcTHqxv5B3QliQdM_
X-Authority-Analysis: v=2.4 cv=K7MiHzWI c=1 sm=1 tr=0 ts=68bee1d7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=ICP7pnYWALyfmkZL0EoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEyNCBTYWx0ZWRfX4VKHrJ/5AfrN
 QareNcCnyNYIGXarVG7G2TB+nAODbWPNOFvCn7GRifBvNhS2aG75M3ubmerokDgGmicsf71Ixe8
 78a7/8KAHzKGs5slsZt7o5SHovdCM45CgldVufvjcA9IkuUaTfHSXeY4rNeZ2HHZ5hBt7m+3zG/
 2yN5fYSrqu/MlonxpYBYfHNM7/tFUKxMijwkmYlPe+yNEtVUTjOfREBWz/R4AlGF+UM0R+YhJgj
 Cwvu0q3co0SUcEgwIMeWMdZ4WH9Zp4cnerrjtMoLtO8YVPtbv+MiLhnHXvM328wcD2i9AHOI/yC
 Y2Yx29duD83oyfW4U/e9df7Mn1GOMeqE0bwnxQ6v7UQyinDzAR6we/rj66DqiJtvyWegZ7Or9qH
 1zgiuHOw

On Mon, Sep 08, 2025 at 10:24:47AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 12:10:43PM +0100, Lorenzo Stoakes wrote:
> > resctl uses remap_pfn_range(), but holds a mutex over the
> > operation. Therefore, establish the mutex in mmap_prepare(), release it in
> > mmap_complete() and release it in mmap_abort() should the operation fail.
>
> The mutex can't do anything relative to remap_pfn, no reason to hold it.
>
> > @@ -1053,15 +1087,11 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
> >  		return -ENOSPC;
> >  	}
> >
> > -	memset(plr->kmem + off, 0, vsize);
> > +	/* No CoW allowed so don't need to specify pfn. */
> > +	remap_pfn_range_prepare(desc, 0);
>
> This would be a good place to make a more generic helper..
>
>  ret = remap_pfn_no_cow(desc, phys);

Ha, funny I suggested a _no_cow() thing earlier :) seems we are agreed on that
then!

Presumably you mean remap_pfn_no_cow_prepare()?

>
> And it can consistently check for !shared internally.
>
> Store phys in the desc and use common code to trigger the PTE population
> during complete.

We can use mmap_context for this, I guess it's not a terrible idea to set .pfn
but I just don't want to add any confusion as to what doing that means in
the non-generic mmap_complete case.

>
> Jason

Cheers, Lorenzo

