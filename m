Return-Path: <linux-fsdevel+bounces-60845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D0B5221E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD3117D2BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DFB3081C8;
	Wed, 10 Sep 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GWhEfzxe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TtX+yOi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB82F8BDA;
	Wed, 10 Sep 2025 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535847; cv=fail; b=YWdYRIWil1GHzvftrNM398Pb8QEXz3g5wAtDwtCFLlMExci6+nnlz/jX+efwxymZHdT22PwaTBD9XS64qUCCl6QDqd6rvywdwSF2njsiPh8IsZGhscjGXyNEq5IShaICadMxe1IcMJ1kba/LOOFP9dHcSWE15G8fa+w8kelsTxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535847; c=relaxed/simple;
	bh=DkBC4YjCSU/GtBuBbvJx6RbAuluecmISfrbUssiNJxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cx12ApXuzT2vmbqNtAMZZg8sLdyaEQ1O4At0LpYsECJdu7zsDDXBYyDesfCqD/MaIaCKMTykg8jnN4naqHJyzHWJHed9KFDM1NTquGy37JXwLYJ7XhFfp4TUfW1y1osetLVqip2IZ4oNt+T+hOBzpDg0KZ03C9KvOzZAt2bW0Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GWhEfzxe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TtX+yOi3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGficK009688;
	Wed, 10 Sep 2025 20:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B7O3kJ3lGqMWds2QK8kGSK9NSQyYQsnjI88W6YN5E5E=; b=
	GWhEfzxe2MgF8GSjcnIhvwrs8t/+/UZ4MVHLVqtwVnfXLA6MtWD4SoJJVTPC+z+A
	zXETeMUvYiKaTAmJoPUvwAYsiFjbazyg0MnVE4fq5tymPMfMRwLYzsoM6UnhRist
	qEZKMGFDRL/NKzJVEUFETlaNdlDh2VgUt72970pbDX6CpUEMDZPAbdSLo9mCsgbu
	FlR5txTofeFxtvDq3QbsQ11oCG4g7L+9TuKxZuS4HtQDLx2Ldll5FnXMZUUfJU2B
	evGqh0FWEIdpw3ChagQxyQ7Gc31dSRWHu5hGhQujg/L8R/3Y6brEmNXj24Pk61Vh
	KC4RsFhWrNA8FYvwHoFDvQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgvy4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AJfi4S002816;
	Wed, 10 Sep 2025 20:23:29 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdj1cg6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7ovt0aeJ673R+0Z+kLrydDVrbw4WWTcT2zaheLhQTIvqCwYIgZ0c1U2A62ILqgQutuGovGAsWEzt5tODEH3SDPVf7RZDSicAoBjkzjuU//I8pFC2CeDibRvTV97OjSWIrZYH1OeHfEb4dbCVxMskmJCHiWq8Z+ABXZNXcR/ynrDtEWqIeE0Un5JfHBezoQpXqJqyIimlngX5xzDIsc5vY5lISGtCtUzORUgMze1/zVPAB9+g5ecTmEtvlh9JyhOPpcS0Hz6HEoSnymC7+oMhfMsryG0NZyfKsWsbTQ1Od7Kgf5nm64fET0+b919Pt63lR9hUhPXUWqVSwQNDqVbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7O3kJ3lGqMWds2QK8kGSK9NSQyYQsnjI88W6YN5E5E=;
 b=LO/BQ3YZRlcUdoWK02Pf/i3T1ggevgXfofZqUspljn58Xm6f9eliVXJgNn8RfpUvHAFE99bhgM7vmi2xYTah0SV7+cQFE3QyjGyrA51gtC7oG6sxpYS46yaDQoFHwPgT4pkAG+sjqTDAqmjE1Myzg3/kUChW9PrFzdTetk6RB95dnrhbnUoyM51u6twKJngTDxso3J9Vr++exNZzHgUBCORp0/mV6ojZAWGbTdIsuN53MpkQa+JEN4a+0sI0TXCtXUR/IJtMZh82dgrSdwGtDY+TWCZZIhvIo8T+en8gj1Xmqm5p5roczygerjXzaaeIRyGYuG0iSKhsovlzir1zbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7O3kJ3lGqMWds2QK8kGSK9NSQyYQsnjI88W6YN5E5E=;
 b=TtX+yOi3UQgmOU4FG3Pi/C7BB5UYgKMZIyoG3G8XSZKqmM8mQIQvjrEY0qR58HK85jPLMb9LeDmljUgmE1PjdLsPgn57J4KWZiyaykyv+N5/PMwMKiudeUQB5NYpql0GPy3QpHoEQ1c8avTxwO0sTcxNHmLjw8lCfTapcE0zMks=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 20:23:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:23:08 +0000
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
Subject: [PATCH v2 14/16] fs/proc: add the proc_mmap_prepare hook for procfs
Date: Wed, 10 Sep 2025 21:22:09 +0100
Message-ID: <832f0563f133b62853f900cf9b5e934b3ee73a7c.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 5139e266-a01f-4ead-a596-08ddf0a7dadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s7mriCOOVHwbvMTruYsuEHiHSCHHTjAUJdyUeC3Vz9Zs99AlQKx2SosF3CoY?=
 =?us-ascii?Q?ZLStkOk4LyFtYVncVj01AU5Uji8RFRaP8Sp3axFueuDX2NPwmbCCxQ78dRRj?=
 =?us-ascii?Q?9ulZch8KHWe0EwuUlXqxIlLu6YzGAbiw7ASfAYTqj8TY9NKO2Xl4/a+UPpIw?=
 =?us-ascii?Q?VjqHBnGCF7LwQW7qa2K9PFTBnhC2mxGRKrjzFRrWilIvWxTnAGsF7mdaqsgE?=
 =?us-ascii?Q?HnslpNddGwI3uFVV2T5t63px+uOkJdS+3BjqN2UApdBXjYibiRZtYCjYxYxW?=
 =?us-ascii?Q?QaEtDRsHSMdWXfvTVuVyv9byQR0hStZDNuduCu/WGcaUoTCX0ETEpuZnLIKS?=
 =?us-ascii?Q?0MaMp4hNGM3LmWZzwBXSLcQGlUTrq0o6CkvERV4jHJLK1Zn+ayVnXFbwLqLH?=
 =?us-ascii?Q?qwG9r/d3L0H4ASCwrs87tKhF2+f7YxEjrU2l2jy9M+d4jNweWOJnySCRe2Bd?=
 =?us-ascii?Q?COaZM8lWcL8K6ZcGTyhlU2+plOQy3r18lHpMCG3WT8UtNa1yEe/+ad3qTR9h?=
 =?us-ascii?Q?Ux4ALgaglxdiYapIJ+uNuYD3LEVur7Ve13YgqPAscq0v5IBJJ5fci94WiNzy?=
 =?us-ascii?Q?xLKUrJDlZssvtwH4FBPWWnLXCCmk2QtWCUWNpPo/NPq9So72oDcSpSZfcFRM?=
 =?us-ascii?Q?qWJ2HjEMzC55/YeqgBlCoRvc8CUYEJLrRc3soew+y5i5cGYyjIMNOVa5eKgc?=
 =?us-ascii?Q?sl0QuPuzI4D6vpOT0ygpRAjDdEkyuPFYk5dz/EPxOGnD0N+T9M+u+Dq9yFrt?=
 =?us-ascii?Q?Ab21pBnDoSY1hFvFA/DbYzB5dMERitojvwkY7Ig4Fa+tYJabGBYjDej0sld+?=
 =?us-ascii?Q?EP5Dtpiu6U+rZiooPg3x/EnWVA6P+mC3Chn+4kJUdg+CWKqyd4tArD+cbY2b?=
 =?us-ascii?Q?NCMuHXUv+byw23Y7iP6fXhlH2G98iT2K8Tyq/aQp88HGnzedZN0wUxBjOgEA?=
 =?us-ascii?Q?KcGXE9sZ/vj5IlKt7tF1M+pzq+GPGRslGXiafDq2IuszuscEdVV7ee0+nAfO?=
 =?us-ascii?Q?6m7+P2OEBmEkbvLo3FyH0VFQBn6YumA3AME0PFR4T+PJiXodyYXjFHjc0tEi?=
 =?us-ascii?Q?6oy0kvOeoh1Hsv84EZfbAewjPjfWjNQKrjCvPlCyJ4bcz9pxnisdfXz5rSda?=
 =?us-ascii?Q?Kpvw1eaClqBEAAgsHriGKcLRwFHpfAD0mTrNppkeNLwSgP0nUGQIMqmZ7XpB?=
 =?us-ascii?Q?IuHzMcQgjxFUMdpuAtaXJNbdDIAzcfazuidJoB1vFuElyuqsYe4kzWMMuytb?=
 =?us-ascii?Q?9iwShDzRrAO2Kk2NCHM8GhRs0yktvVFBZ1xyEgdWITlGdBhKW6mnm41nOUAK?=
 =?us-ascii?Q?aLIguKNk+mP63KpBeh23EiH781XVQcsbFp2vowP7BDQOQ6uyYXZUhVvG0Kkg?=
 =?us-ascii?Q?KoRqOJ70sRs88yhQb2Ygv0FrxFclHZiiI/DkfFScZ2k/0EmwxBEnY/vwyIe1?=
 =?us-ascii?Q?UW2ZYFpVwWo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A9AomaLKTyZEIBeD8/8vS1EBILtbexcuudnZZ2GLSTmxAxZ2Cy0m7MSruKe9?=
 =?us-ascii?Q?dHoRHc9+p/sSlNfSm9uIzrWpYwUOUmDxAw4ELtpHHn7yywKGgfuLzO4U028x?=
 =?us-ascii?Q?7JkjkhOkLG6dT5hMMglhVoYSZpmbx3Z6GHe0Ye/bg6VKvcTtJ8DW+5BXVK0w?=
 =?us-ascii?Q?aFRWMsELWCsfzgjW7YwYBS/nw0iTomCdTlJhUnQJn6DUmtXL+SnCGIr50KEW?=
 =?us-ascii?Q?Cx0N3whuT/U0CNWSzmqxBsQhq/9G8DQXXtgCHFBpzF9IZn5QVw738kW2QtE4?=
 =?us-ascii?Q?XbSqnVkfKTYeIA93DpRcm40MNmD79PH9dIya+HjhH8BnmQsf/IpxOrA//4Hb?=
 =?us-ascii?Q?Qw5824sFSKaMidJxVZQt4EXZh5w0vzVNGRRp81jmuTkGK1hzq0B8Pi72P29O?=
 =?us-ascii?Q?VKi2sp2XDeLAgv6Ac0dTuKDZmggUyKVHgkKupMwc47OntxMM6c43B0q+Vtmk?=
 =?us-ascii?Q?oVP/G6rCPuNlz2XH/+kB/MILCX2jSplNRix+rQGu9KfOsjQMKb/0ckz7KF/h?=
 =?us-ascii?Q?QzsNoHwx0aziv2zT9BvW9HUNCL4VdQt98v0H9qAS+oSDZxHLTZ6CxIFUd2/2?=
 =?us-ascii?Q?8KWRlUgGK/8Bephwz7J/nFDr/vFv//7HD3SrImZoX3zJ/c4AJ/qF37YN66hq?=
 =?us-ascii?Q?eIniJVZkdHj4OiEoLvkN6LYp7ccjbAzZcVZwYJnoPTd7hK/7VXS96HIGldm5?=
 =?us-ascii?Q?6KVObn9jE9033ot/3zT9dUakXRseB/ZdrbE6Ci19vUkkZ4e+cuklGKQlgzuI?=
 =?us-ascii?Q?lX2no8J60q+gtdOswOVgI3MCcKsI4BT8TDFnWPk3XvF8Sst5iOw8YCeFmmgt?=
 =?us-ascii?Q?ax+eJT5SRWgTk6bRzxZtc8whD0nrJQsKwiYLMGwio5NVpgdYlHzkRBI413rU?=
 =?us-ascii?Q?ejF0zh/j79Rmc4eTgi0oIosGoVryX7Dj5W8aLKblHJiOFnkMfEJK74dt7LyS?=
 =?us-ascii?Q?MHfaSOoD8Fg1LN9USbyb7XCNHEAPCHXDBXoThjsbxDAoIKUe4M+36yM+iPWL?=
 =?us-ascii?Q?lyYGvClugcGnFNKPs+s0E50n+kXZgAoiUAwJYw7AG1pVANuVrXr3thdXyJvr?=
 =?us-ascii?Q?ZsJRimvCNh2rc+Z5CNVH49gj1MZA+a/NwRRUPKRCGL5187aH6Xsq8ejnDjHP?=
 =?us-ascii?Q?3TDSl125Vx+Ctwq1Cy3cVU2VzbsuAr1N0gL/qMcFPbhzDOCVpjP7HD33Z1ki?=
 =?us-ascii?Q?JXMClegIVYgvlvsXiLpPz0D6eQx0q7wSa3J14ee8aGh28g7njtwh72PzfU3r?=
 =?us-ascii?Q?TeqAO7lJxOUZ0z6+ZxQhkLw2UOSDO96h8GvlhaoPBgBXeRVzX+HvCWPSnmCR?=
 =?us-ascii?Q?WBDSKr1KsBBHfvBk/JSfFPIzee+5MFu7CkEHtMpSGa7tiWM4bC9s6wDE1/Dx?=
 =?us-ascii?Q?6l10BIkygRjsSl5+MrFNsp0V12DXOZum71WeNmyiyc2APLDae3Gua89PQNzC?=
 =?us-ascii?Q?3IatL14a4lVkRM6uIWVMZ5c0fmQR/R+5Y6MqXKITWv7HfNL5RnT4PznBSdiL?=
 =?us-ascii?Q?REH3MzN2Zyn9Jy66pkPYF9tbDWIxMCEyXZ98LPdMDGo3BtRa26Ah1nxoKuIY?=
 =?us-ascii?Q?ydnISA7hW8NwDH9i+smGIAUOkobwNFLMDgd6GH5CNbv0EWAyiVYrRZ9LktrP?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZK//pix0pRX/afxnjhR211ELWMFXye2n05+jt/140xlp5VY8Bi0QRBBes/ne/UpP5eU1a1MODwOX08Kt8QZWdm0u1CF1y+ibMsdv1GpYx+b16k3L1fSKbVmIoEkvAJtDfvvUd+FXXFqJwMs+jdVx2fIVGn1i1y0hxGIuWbIhz7EoLNu4hoF6K7UPvNic9/GjMDfEEqc9UWCwmB71WnU28wLK36w077kh0k985YD6c/mrHGJqhq8Np98k0DYwZ9B50+sG4juAbFybJIP5Ycy+YdOAC/qykpIXHw0bYeI0dTk0U8AHP5sKgYGi8ScCCEuiI2Qft4WA5gu1bMICbL4zdkw9P3eVP9/C4OQ01teV3UTFd74iB4bIhciS/WRAAVqWQWksFeckPReytftySFhDGnAY4GPpeYxhLU1mOoIztJG/8LADD+89njCnA3v2XX1wJES93rV3RTk1CQX+b/QfvLzEEnxVCgc7ZWDrX1qhsDa70uPwzpXVeRM+G5cx1xY0+c3eJycZDxnIWiaTWR/pl1aJaHUGNcVaPrDgbcaMxi4v2pvdjYAeYTY9mZESLU1U5DF6IRMyZgyElqxXrd16qjpYmyjv4iLKX+i6+Yn8l0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5139e266-a01f-4ead-a596-08ddf0a7dadc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:23:08.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0TOhJhZEwgK3Z7COj3w8BiSFGuc3L5S+fLPgMrOxVy0SdTKbdQiovNZiSYjg405zieMwaOxVp6+Mh0Qbf6CbM03M+9ilrErLjnIy66k9/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100190
X-Proofpoint-ORIG-GUID: Fh_m90enFP2q3noB9XJSVmr_ORbIBSW9
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c1de42 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=9jVcBwQ3IVUZEcKrhkYA:9 cc=ntf
 awl=host:12084
X-Proofpoint-GUID: Fh_m90enFP2q3noB9XJSVmr_ORbIBSW9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX4w0rO+y+vBug
 dFUZhDrd2OKdtnYbOr6spZJcxgggOClYB2q6wiLUBTYNCRK0VylAmHLa4O1x3bmfkjRdKIqor8i
 yKb5EQRxAjKBCUKjUAG1nUTDqA/wKTnpSU9KZCCYk2j1ceC2Ka/hX1jBqm8EoAzvlVrbsribAsD
 ymKwKn3w9Wh1iLg/xJPxFz2hzABPi7p1IV4ciqyyAyiR14SM/3MhVSOIkoBeQR9SJA8Ma3Smo1V
 PpHXygrdg4JMQpWXP/19S7et7d8TX7a5He4CUTfXzahHktFjTX4euad52nElyz2onsm7+6BnSle
 3f0U1qUSnMwvl3sH33Hq1E0WAj3tKL2cn7VY8hEHK/UwJthKS/YgxkwyiViWfhTWuyRDRpVo+jp
 NDLnTPLuvTHU1dCUczwsFWBIJyxydw==

By adding this hook we enable procfs implementations to be able to use the
.mmap_prepare hook rather than the deprecated .mmap one.

We treat this as if it were any other nested mmap hook and utilise the
.mmap_prepare compatibility layer if necessary.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/inode.c         | 12 +++++++++---
 include/linux/proc_fs.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 129490151be1..609abbc84bf4 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -414,9 +414,15 @@ static long proc_reg_compat_ioctl(struct file *file, unsigned int cmd, unsigned
 
 static int pde_mmap(struct proc_dir_entry *pde, struct file *file, struct vm_area_struct *vma)
 {
-	__auto_type mmap = pde->proc_ops->proc_mmap;
-	if (mmap)
-		return mmap(file, vma);
+	const struct file_operations f_op = {
+		.mmap = pde->proc_ops->proc_mmap,
+		.mmap_prepare = pde->proc_ops->proc_mmap_prepare,
+	};
+
+	if (f_op.mmap)
+		return f_op.mmap(file, vma);
+	else if (f_op.mmap_prepare)
+		return __compat_vma_mmap_prepare(&f_op, file, vma);
 	return -EIO;
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index f139377f4b31..e5f65ebd62b8 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -47,6 +47,7 @@ struct proc_ops {
 	long	(*proc_compat_ioctl)(struct file *, unsigned int, unsigned long);
 #endif
 	int	(*proc_mmap)(struct file *, struct vm_area_struct *);
+	int	(*proc_mmap_prepare)(struct vm_area_desc *);
 	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 } __randomize_layout;
 
-- 
2.51.0


