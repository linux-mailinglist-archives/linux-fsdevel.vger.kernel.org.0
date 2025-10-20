Return-Path: <linux-fsdevel+bounces-64692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0DBF1188
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F613A2638
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A359320CD1;
	Mon, 20 Oct 2025 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/K6j4lR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qbR/xHxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585031984C;
	Mon, 20 Oct 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962393; cv=fail; b=bBe5hTWCUIFtOsfCqSXLsODijL3mQYOjmEZDQr62WWpyoEANatwYFhvYPQuFQ/mdrhSKD/txxqaethLaVq1X3m/+WibTh13cG/ejsNZY/rXqHhuCjwV40xupnSmK6v8UXeBsgtbF+YdAcu2w7SUgW3TXDK39DtuEaro1JK1B4XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962393; c=relaxed/simple;
	bh=dTJoFES5esgPQQEhc0GCRG2E2fKKDMal8ES8yJg0KJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RBqyhNFRfdugYx93Z3mofi5KB7Vh5kTX00OP2UTB8hRDbBrmXDWzqkMC1YylzfemtfhYO+WQxQe+CpglNdfCG31k4umdhlKbJHoFBjfiQtPffzPIrT7MpnRS7Zg72z+DpaiDF5VBspseK+j30qOsFM8GkfJkdE7HC8rTW1vJ+8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I/K6j4lR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qbR/xHxw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8Rl2V025507;
	Mon, 20 Oct 2025 12:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UmwwB34Cfl4q8IYPPXnlikGAudVZFC89KME5ssrJlVU=; b=
	I/K6j4lRhJHVau+n3OxnZjGwVDOG9s5HJC1i2CPG1DnqecD8atB7S+xKKlHmnlSO
	p3yOPYgpQt4YIcS0WMdGQnxE707DtUcBhZzG4PILDvljUfH4v81cZVANvRqy5x6e
	aGizfo3VPcYv73mCZKFTqag5GeK6Cfw+4ceYEbDUk1O/OGZ9At1WyYu55D7sn7SF
	7Z9QDV2Pajrd5IFRlSxnwJPz6tmyhghhmDbg37XEGvLuIhzGDqfkYv6rj6iqwiHg
	sr89eZIimW1LpNDxDQU5nJZJaHV1ii/xBUx8Jer/c7YsznLaXR7u6y6kWdc32rgY
	gnVek0//NqlgfQt2IimOFQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3esj3g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59K95vYt032333;
	Mon, 20 Oct 2025 12:11:54 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbmf8c-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Miv5vZhUqkr2AqKF25zrT+0Mb4z3/2wgdlSahEgEjWnTrUR9LjfMXoyWmBWtVUKMYxkXUK00SGK+rUQnLjhmztnFAxgHQlK5mvKI824PKmy+R4X26/QLwvTqUC3UAoU9nR0HhAX7F/oFfXmar4UHr30GHvk6IZP872A+BfKUv5INvwfWxLfLH329EdSYRV9zzDLGg3uzMRxc64yq9FA/XGxRu02hvUBLBjOb4VrMZATC0b8L4fggtNzAHnKTVuWppGKd5+yQmBJsIhFOBSxPsCRW9VECJQVlWz7egzK6ENQKVkQXbCRnle0shcfLfK1/6ghrohtl05lWrcZK9Xz4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmwwB34Cfl4q8IYPPXnlikGAudVZFC89KME5ssrJlVU=;
 b=HjT1OgB+39da8lM4B60YgKHsKMr8CyqLpEv56eaS3k6RbD+OPHxJxp8BmMpu1x1E9XktXlw3Q9m/j/heTKdj/bZ75Rs4LLBUDG+4PV+bokHRaKMjXHb2vlkAoPLHTlzPMr/+6TmbjsmQC2bKdpD4JttXRj78q0iBfM1mnFiLNwFiGu763MHx0T9M9DAFNwxhedjSUGk/jNY+PQwGUKnUVNtJ/qdwU+cvagKAeJ5xmZyDD4zcJC8oGf1zDsF9y8fvXSmbeBTX39aOsQGMMI4fabXc85TZmiAbGM+ODY6APnQrL7xeJPBi4TqOEoA7SWXyNZeu+8yeJhoBLJAFR3z2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmwwB34Cfl4q8IYPPXnlikGAudVZFC89KME5ssrJlVU=;
 b=qbR/xHxwC4XgYz9xPJo0gHHGKVS8ZQekmQdwFTs6WjhwpgjAN+TFmzyvwK2Cf3OpI3q4IndqVQer3w2+ZS+peIDFNHSe01Mija0yiTFf46GmkKLaOBV4qlCdG3mL2fnOl3xLUy1jBYG2kiyhHv96zsp9+kXywKB6HQZd2sZLX30=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:11:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:11:50 +0000
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
Subject: [PATCH v5 06/15] mm/vma: rename __mmap_prepare() function to avoid confusion
Date: Mon, 20 Oct 2025 13:11:23 +0100
Message-ID: <d25a22c60ca0f04091697ef9cda0d72ce0cf8af3.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0671.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 1350f77d-6fd7-4c94-a48d-08de0fd1d9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iF8aAYvJbhWpiLMauTvhaxzbNr6I7cJLtkE9xvSt+ieCOWLbqWRwAueZoEzm?=
 =?us-ascii?Q?egzKpSpt24NCdlUjrjdPtyzNhKD/Qm4qIQTsw1gZexRxLiNRsLpi7QatuTyU?=
 =?us-ascii?Q?NDy4HpUOFsj5nwYLJyuECJQci+EyXCM+cNUleBLsQTHhjqcdy7ncebhYMZ6E?=
 =?us-ascii?Q?GQMwQ55zkDV7z4hMWN7rq+TOtvwshKwgirLG2cQJNzjGL56m9sbsvAgexJn0?=
 =?us-ascii?Q?UOMCSE8KOQOffxlVcJq0gGpnYLHh83lnYeAmA0z+fmzfSA8kChk+kHObQTkJ?=
 =?us-ascii?Q?ZwaXffGoMKBZkYb4S5gdNYa8KhS/5/94nwqQjHBSb4iJsvmq3G5Vl0kxPtI4?=
 =?us-ascii?Q?trEuDSMLtz0ja/UpJrtz7nkQkDHNGqGCzvOdxMfDVyQaKC55RodenEINlo7+?=
 =?us-ascii?Q?RmPYrHCR/gJ+7jYBuc6AjDX4DAlOKpqiDJuuLGMApWGbs2s17ZSELdTVK8bL?=
 =?us-ascii?Q?Vv/22pauvBbIF6dBWaVqScl/Zp6/ttaAmX0E0iUCB+q/H7riaGfqQrZxuhQb?=
 =?us-ascii?Q?C5bUBsrtfw5uHTvjJ4dKP8WOUf99OpURvP5ZUXDMuMX2uhVG9fRy5gzdMMMI?=
 =?us-ascii?Q?/g698rngR61KcNyaiKYHC1he79TcYGFvSET5QOyTd/yEv7Pjv97otzErv42M?=
 =?us-ascii?Q?IlMGtpa0dfvdZB7LaEazPytKs/qNzvFqtQuVT2GcJRh9uRTbIaq4wPq0d19w?=
 =?us-ascii?Q?ZZu5ihLaWQhNJnfEg7dBGSkfxADPV9FFIqGauQ7helj9rikY8GnjviROl9WV?=
 =?us-ascii?Q?BRDMuwOTg4I6vqPn5ZI4j69EmFFJ2muxZvnBhocvIIoN9ZWQ6qb8xbyBaN05?=
 =?us-ascii?Q?hGH20CkTNy0TCAXPZFfFX35cuPuHZvUlOVJzGGUi0i3KFgrK1Q8uy5ljQvdo?=
 =?us-ascii?Q?43s2VG4JzVYtGJ1pmqC4VvG/zCNsnBYc4WHx/8Hn5hZEJ1Sd+6jegnbd3wzs?=
 =?us-ascii?Q?ui0th3TJGS4Mivxwk/9dpoj3GZ9DaUE8CNxfLwojFWKsFCj+p96qSRHWPGAo?=
 =?us-ascii?Q?JK+Jqp00dySbW1T4mwtOOeYmaxUrvVxSHBfyj1zpHv+cOpAPEuuA7OxQr23l?=
 =?us-ascii?Q?hqs95K9kZMJYF89B3SvOdXxNPC62QPpJCledAkW4TXsaGSseUKQ2WiL2EqMv?=
 =?us-ascii?Q?aquiiCPTI0NFbpAJpYIokxI86APzqmpzCBM/enanp0YVuE+s/sjwyY655LuN?=
 =?us-ascii?Q?Rbzq+RvwN/r+YbLZYp9qkPwidKPx7g+cfJRYA5DVnvMSkU/JLxCupLaxsZw8?=
 =?us-ascii?Q?3bDWDAU805bk0oNGBBWffJkkV/LC+4d2hvIp0cIbHsmfyJOaSfaskd3aWfa6?=
 =?us-ascii?Q?GYJ4QY2UyEDyippUegneVnd0PyKacMnuspGa4z9pROtGQaRHN4xNmQh0WWXp?=
 =?us-ascii?Q?RaM7jm3mAZs4kDCVk12rizeidL+Y+lL92S91gyToavDEwIDTJd4puHZr2ueZ?=
 =?us-ascii?Q?cc77mqJYfAgstwu1mEZzQsZhqMFmXeVa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBJA4GYrkduPW8IB4Kl897U2+OO4g9L8FiVPanMz/1jE5T3PD7yBJ0S8+3IK?=
 =?us-ascii?Q?VoYuBEgDdxJHr66sJtFSqXSzco4mnS8U1AGffIjG31h9Ht5Yuzmv1AsTE7Xa?=
 =?us-ascii?Q?21tCAmenBVyMVndZk8enjXSUJCn1diT8DjQQPZKuZh9o67uoyjMU6QY91HU3?=
 =?us-ascii?Q?hlgMfFpGYNxfrqjOJatd2+H5bCReWN6TyeUk3bo/n29VWfdw6eKKHiwgjYra?=
 =?us-ascii?Q?cgCNBSRuBS/iNtCBSnuQ63ksIGLH+PUtcphVZqKHbi8exakBKNyKMwDtjR/o?=
 =?us-ascii?Q?E7iobi4iVpZBxWJxoeYJODcAjudsf8LjAMe2hpMvFGVCpsbZTaRn5ckq0h8I?=
 =?us-ascii?Q?QT+u1rFtJt+2FfxLWXdYHfXCFsvOsVpSZuNR/z3EdLgSVkU8t9tfvooqjIik?=
 =?us-ascii?Q?xb59ftSqFwqn0cVAQ2PCpFFJ/Q0st9kGxcIL0/Xdr0vYmGlgN8pS4CwCj/C2?=
 =?us-ascii?Q?o2SnwBYZctCL8NUY9B7zYRSr0m7i7dtXgL1moJwtwqD6L1DSgC5pyQ8HFq6t?=
 =?us-ascii?Q?fuE57qFnO333Y/nAEORE2KnUnfLvlZu1lMoXRNd/1YiKeLhhpugjKBf0K2ld?=
 =?us-ascii?Q?XyPP4/vR45AtRhhGBTpt9a+X535AIb4nlYskl4xuWmVLBmPTPvwzakEj5mJS?=
 =?us-ascii?Q?CWwx4qNHSwgWrhmu5m5ARgTLQ2Uce+NIJKOxkp9H0OVzxhVDNnEnrnXp20XF?=
 =?us-ascii?Q?Zzv1F2qD88fQlEWqjoGu4h37ANfod4dQ2nTEEdqGtvccGpKO8kaGSnrUxVnc?=
 =?us-ascii?Q?mPE+vF4q/A0buj2TuA0gKIzp5G0Oxxx2huEno+SdWWrjFclJQ1GJSZHZHdQg?=
 =?us-ascii?Q?YOSBVWrO/APpZh2IhJ4Vv+BrwknaqQjRRD1kbOoPvSsWXVAbh4F/1wp70Itx?=
 =?us-ascii?Q?qRavdH/Cd6qsfwTq+TzAmzNbgDS3RtUsXcF61hJYY477btNG9bqjLbveA+YY?=
 =?us-ascii?Q?mW20Vvitq9FGXeFEX/HGPgr7JRa+vd5Vz68YR2QB+UTZNtzIyZw4PEe2gkUb?=
 =?us-ascii?Q?zr0hMwIY3oBtW91UXdXmC/9/k02zAVGTJM7et9m8X7fh4/pgel0ZfnLVRHXj?=
 =?us-ascii?Q?Z1xM4QYjftolbzOhmVGxxHm53O/gGdkbsXxeKP/MzDhFisY3ynTCCPD4WVOd?=
 =?us-ascii?Q?CA8okGjj1OacZ9uuOzGdeTrxly77pUR1rJjO81eAyr8XmLNfUsDTybxHnr7L?=
 =?us-ascii?Q?1s3R/eLae5XNQgDDlzvPhQ9V5Fs2EMQreoNW+ffTCoOjDamDiixCGjwnpnGJ?=
 =?us-ascii?Q?21mrAtexXGjrIIkHgh1/JmmM1LhwNCQmYdqZSLKrkvp9r0yAXQ+BHDASGPMT?=
 =?us-ascii?Q?VRgPK20s9oXyEWdX04v05jvNyRAdxiLENUT/bFmqULzNa7i93QLtTeQohPfO?=
 =?us-ascii?Q?zfvwMEiskNr8pbhdCQE8uvOc98fHcIaVw4Yrzp/nUKUU6jERjr7/Mzk/CsY5?=
 =?us-ascii?Q?AAw3FZzXZ61QYTjV5hFqeUDG8F9++FM705GkT2nhxiVtgQZzRAATyiV74a+u?=
 =?us-ascii?Q?KvkSKEU22FTYmz/skT8Hy7FZ3QYw6GB0IjQV/JfwAMjWQK7kLUe1AKqSOqNl?=
 =?us-ascii?Q?JRIXIusx+wk7CB4LS0OSa30DGDlZWzqakkCkHxjELAkW1BsfiaBDyB3SOPI+?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JgQitrBeXUM60c9uW+KuWq+qC3UsuDsaXPkRNJEV0zMYdloe43EOeOxoN8pIworUJkJmbPRiTMmhLX4AwAsIMTFalzaRtrKTjKFiwzrUIytHjXePwYhW6CSXQcP7Jx/I6G5DnHwJ9FKDeIFsAGonzC5kaG5rJAb4wdtq62hBJ2vJHtwQd7VIrybTOdGwM0lKLc48g/2G+1iOWBYl0nK0ZnLJYwEF84KJFrsaq02s2s7DwFmegHdOKZ4cyVQLrpkowpZYtvri1MFpE6L/4FbA+dQW3NB/dtsaDrt8/bTM03drds9CDri1LOxI84HXF+SOMcVkTucD/JQWBDFXdXc0dOxCq+u1SOSOJCKDSgoJOe/S4Eb8Xxyh22feAUKGoa7HDyluymfoLir+vB8eStbu0NnG1sZlFmdHmNZgCUkZsD/IRBW1qxR1b1frdlAX71xH/4x0vnO1WqnARkNHbjkU7zhEZuJYAzrbkspSjJe9rL/e49+aEanb/unhSyq468fcj1FXA61I0/shNICF8Fc67yT4kH2kXxnuHESsnZ1hB4OI39wpFgi5Ra9BF+8fCwNKIltTwX2tnYLZUak1cLETx0e32mpKZ9946s61iRgeSRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1350f77d-6fd7-4c94-a48d-08de0fd1d9af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:50.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTh3RtQc91+hBMfdKnUQ/a4KBvcd9Yk6MeNcxW07ysZhRPbdhO8mmHzhtzPkwCbcoddjYphNVMy1/TwU/uZ5Qp83pe07q88+T3ERvnNhVd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Authority-Analysis: v=2.4 cv=N8Mk1m9B c=1 sm=1 tr=0 ts=68f6270b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=69g8Iwx80a-1R0TaFSkA:9 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: 0feDPgv78MvtMg_wLrHFAk7lxA2Wbl7K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfX5bNuAqKL/toc
 8Opbjsw5K1oNPhbgNxmh1icS5fq0Pr5mwKtVMXbXydhyfltj9x29Gaz6X8I3zO0cy3M97C7eJwH
 akRKgXK8BGljtTDgP8f+wuOo8Y/H+9eXPAz5YohwPkV6jHjh1VTuT+KgX5LyNp2LEyEQN0dKjBc
 SFeVNCCJsTz0esXT++/onZf1gd0/g2XvjTX/VCwxnJh/etCqD/QrsgaMoAFk/Dm0tng6K4ON4ss
 05+GRraVssYc2mBdvEWiYVzVG5Kn8cYMCyIOnDjNiqOuxcVUORKiFbRwDpG28niYcDwnoC73nKe
 EeJAVen4yIwBq5cWhn//mQJxbWYAX82+gAaTniJTEIjf9vuhEAtJwqcqBwoRMrDmLNYvv9GtYTS
 boxO2nH241llS8bjyfI15wIaaPt9K5p+cTcLT6cNEACa3rsFeaU=
X-Proofpoint-GUID: 0feDPgv78MvtMg_wLrHFAk7lxA2Wbl7K

Now we have the f_op->mmap_prepare() hook, having a static function called
__mmap_prepare() that has nothing to do with it is confusing, so rename
the function to __mmap_setup().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 mm/vma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 004958a085cb..eb2f711c03a1 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2312,7 +2312,7 @@ static void update_ksm_flags(struct mmap_state *map)
 }
 
 /*
- * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
+ * __mmap_setup() - Prepare to gather any overlapping VMAs that need to be
  * unmapped once the map operation is completed, check limits, account mapping
  * and clean up any pre-existing VMAs.
  *
@@ -2321,7 +2321,7 @@ static void update_ksm_flags(struct mmap_state *map)
  *
  * Returns: 0 on success, error code otherwise.
  */
-static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
+static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
 {
 	int error;
 	struct vma_iterator *vmi = map->vmi;
@@ -2632,7 +2632,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
-	error = __mmap_prepare(&map, uf);
+	error = __mmap_setup(&map, uf);
 	if (!error && have_mmap_prepare)
 		error = call_mmap_prepare(&map);
 	if (error)
@@ -2662,7 +2662,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
-	/* Accounting was done by __mmap_prepare(). */
+	/* Accounting was done by __mmap_setup(). */
 unacct_error:
 	if (map.charged)
 		vm_unacct_memory(map.charged);
-- 
2.51.0


