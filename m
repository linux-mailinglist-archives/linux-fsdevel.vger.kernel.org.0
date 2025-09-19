Return-Path: <linux-fsdevel+bounces-62199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B04BB87E7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 07:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364E8567549
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 05:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655027A108;
	Fri, 19 Sep 2025 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kTSevWLB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RE8y0jIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41FC14A60C;
	Fri, 19 Sep 2025 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758258874; cv=fail; b=o+4pdIhLUpJ+vLcUE+B7nL1ig8RinCgWh5AlGkaAvIrH64LvnzOae9YK/adnsJ+cSqeTbiUQiowsiCM+Dq4QsGutq83SYTmUOdCSMiZbDxxTVKj83GNCrD7fdcQFewMOuBCuDCsKM8FF2DRpXrdNnTy20Q1gIS3sVeOzIyjMkbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758258874; c=relaxed/simple;
	bh=JVBcy6jsh/2CVN++eJIpyokspK9WrfgdXyZ86buUE5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u3fsMlQCus1OoqhvNwt/mskHwxN+W14g99KjyfUHmIN6BnRNPAEUHfE592rsRIZ4SoU51aIMtyQ68iRfUmOWTNr35XF+SHegf6S0LHxxx1VbYKyDL4qSKs69hr32h6fPFKmNjrRJlVUI367WQkOXsSUnnBiur8QjtF6QFX/ezWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kTSevWLB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RE8y0jIt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J2PgrK007729;
	Fri, 19 Sep 2025 05:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RsPW/lUpIaxBi5FDB6
	AAGFOOaJB0zPU1eIgoJDQ209g=; b=kTSevWLBLtRnG/MNmQQjcLY4kqSz5GU75S
	USaMn09AbdBnl3f6oCvu28Uc19s3DfAKedXGwefC3tAaGptDqRwFda8zzqIi+Dv7
	opqsk920IRCemx/ErPexw8/dORE4+TJkddGkZVUvfpk/sivL4fIB+LpRqEyYMQXL
	yF1hgkJIotcHkdZ4HVuXJHvz1qVfFh9RpQ6pABbwo/s8oHtqXWBT1+3/dgSElas0
	jnt8r77lynj+f/KsVZ6V8v6hihAjEdWLUCqb8Zz9v8LF3Qs+8LtZPxhm93b5vhER
	annKyLcJIiw5LuaMQjaVxXtDBg+YWWGEbzOlhEDItDWvZ4Zvt/9A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbvv9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 05:13:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58J2VA4I028734;
	Fri, 19 Sep 2025 05:13:40 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2g37rh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 05:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phOsldpuSJirTwczY26hCgbG5GZ+MVsvEBdU5+c1j5e8ABBsuA/Jd2nNZ9eEyyO4L0bjMZm6BjG63iAcWTyic6j9Y8Nt+3ymQ57OzcZMZNg1fx5sw24fBdGP04VeoYsRCiFRlvqWo65LqA1JsTsuoHZh5TwaRgHQYs5w4Ftxj5vYjCqoXkDvMN9Tw2QoSr9u43NXUMJQCqnqf4OVRHv8W9yIE6BxO3PLweaOUM5PFHqNWDwP2BkdUoSuM5mTtRCbn8aA0Ic6hAD3lOqFpkd93bh4O/UGi+TYFAvuJBTG87EaxdHlFjnwz0vn+OOoiTYnfiWQ40uBsnwvzE3a0i1kXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsPW/lUpIaxBi5FDB6AAGFOOaJB0zPU1eIgoJDQ209g=;
 b=upv+Fpa3Rk0EBZDFwteljw6Ec+H5h59RFdkN/31yityH3ofC1n7KvXMsbZsnBMTeuAXXYqjpJ/hVKd6/0fK/7OVvkCGDCkMbYIlMwQTIDTQv3p9q+uhucwj9Z4T7PJmv7ukOE+iZLMQfAVTooV+8ZOuBEyxeIXiaHJWvnmkiqM7zWj7QUP+qXtUQF1OVC1DGT8vV5kLI+Su1l9eUGKQdoo41+3+T0OEI1aBGBaC2B4wfFfgEJFNUWD75IAgH2JD7B/VsJ3LW8dv/1YLrp4WqIHl2Z2aU9vn6fatlhQ+M2uWlzC4ZUN3iPJq7L3eVi8cYosnHEDDmG/RXwU/idj3fhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsPW/lUpIaxBi5FDB6AAGFOOaJB0zPU1eIgoJDQ209g=;
 b=RE8y0jItqzl9IjSwOJIrUMIqwEVlFS71ddbGt8Uzm0MDRdFBg0COh3lgiKvhFwp2pMVzoJKxsy9mUap2fmB3zNh4HFpCNR0RLNgJzFlqvkwKLdAFqjsNTlQE4OymAq9As+0/RixdXzOdezwlDKpsdwqX0OXiHpOReLbV2A6DCYU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6417.namprd10.prod.outlook.com (2603:10b6:303:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 05:13:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 05:13:35 +0000
Date: Fri, 19 Sep 2025 06:13:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Mason <clm@meta.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
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
Subject: Re: [PATCH v2 11/16] mm: update mem char driver to use mmap_prepare
Message-ID: <c3084d49-3b32-465f-8410-da189924450e@lucifer.local>
References: <aeee6a4896304d6dc7515e79d74f8bc5ec424415.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250918191119.3622358-1-clm@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918191119.3622358-1-clm@meta.com>
X-ClientProxiedBy: LO4P123CA0694.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 655b89f2-d88d-4345-68c6-08ddf73b490b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?5AACMRncCH2yZ+lgdIVZsb1m8CXlVrCVMyxBsxUvuHsOPRg8c9yae2jwNjn2?=
 =?us-ascii?Q?rCvzAnsZKHwCyTy7D3s43twaptUkm6XmWSK+CVoo1bSSewE4zxQAQVXUzuKW?=
 =?us-ascii?Q?8A+kbTEmvI8Mp9rKja2ocX4W/BV48eqaFjPqme6mzJGBJy0MXZRbBEOgvcNy?=
 =?us-ascii?Q?YWZ0L05k9qlCqPy10voxy28y9lRvJNhDOxbDS/RUe/c3DWxuD5RXRnOtiPNQ?=
 =?us-ascii?Q?7a0qRhqiynnAmR8CGuwYff7AziPS9ngpUjmnCDvdOgZw/UFpL69LI8I2AS6l?=
 =?us-ascii?Q?eJb+7Sogvj3AmH5oS3InKK/yREZSVLvA8bjg6G5R2X8v74FXQ5G/83hu4JOQ?=
 =?us-ascii?Q?N+Iq0j5ZnRT9+Y4c7gnocaaH/rbfpK6TmnzuNhgUj9iZ/aZakhASue90GQzu?=
 =?us-ascii?Q?U0XtSVSoUbhZOD3GGKNMlvDrsXnHWEZJ8FRQsf/YohUHHiZ0KBZBqCa/YaIm?=
 =?us-ascii?Q?hO4Obu26uB5czfBJNbGCBZ70s6793IUYUcMQQEIBHUkl9wyL/hY3FAhgpdyH?=
 =?us-ascii?Q?WSvj9FNXvx53eYi+CYikR/jcPltueaff7FQV0oTCeN95ttTBQ+RZZ+ERu5JK?=
 =?us-ascii?Q?J+F5VsmbTr5eoJHiI7733eRwKfUGCNzvo0uvizpl8ascfNwuKx++/5fZu4x/?=
 =?us-ascii?Q?BBg5Bo/G90aYMI1uY1bVD3OSTrCY0mSJn0B5hWQ7u1sfhRc1Sc4q52JkopMy?=
 =?us-ascii?Q?Ql8YpkxBORbX0ypIqpxp1EyoNWTOzVtBQkU8ko84vIAMIDYzqgIfhnZBf0aD?=
 =?us-ascii?Q?hK/KQbL0p81EIl8fKAn3I9DA/xEk2FXJOoe8Dh3cLS5diSf6l6rimidjSnSg?=
 =?us-ascii?Q?7ywHnm3nKLk14mUTSrEWgwjEcNIHVzkG0C6+EFtvcIqX4UrkaXCzG3b/dTRJ?=
 =?us-ascii?Q?8uqK2VZdLsAXBriD/H+W0vNc/Cd3mVM+DgaIUwEyNvn8xoRZPpNCeeeL81/Y?=
 =?us-ascii?Q?D5SYjkQ9hYZ0fwVPYOfovt6bzVfd4tyYtH8q4rVDpWUyTlo7l3MI5YgCoDtM?=
 =?us-ascii?Q?3YJyjcw5C8qZ0wfjpB4ZGpZoDWoK4o96mOu9gfAa8ZR76vTnT3TYIftOSPgl?=
 =?us-ascii?Q?R736HyGa9cttocN+htSVwR8JuX9iDJ4gpwAlVX2DofDqwEWGX9UIJYLaUgKz?=
 =?us-ascii?Q?it+RHkKCjQ5f6evI/OLBpoJJBbHdrqJ5mtVY3iZMLIpvoFbIh+VGL/as+tCN?=
 =?us-ascii?Q?NutWEHPXiWrxcjtkNYXhIVrB8LpQoUqh6jD+rIBRw3EfIaNdmFBmJ/iQ2ZVD?=
 =?us-ascii?Q?EZZm7rzRCvz9sRu8HBX1eUCNMxenJRIrsMbPslsQRWRyxM73EUn+yBJIJzKu?=
 =?us-ascii?Q?LBxVzC6SnCqlBWx10o/lShjUKamw92iVZ83Im94jSqFqrNaavucL1N+F6POz?=
 =?us-ascii?Q?kK4rhW73kS88C+5X3BC79s6WJNLpYyfd7YiIoWAnhq3IQYj0whH6Ki7nG2lf?=
 =?us-ascii?Q?7aIVXOXIiT0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Pws7+79ppR1XIFhBXlaTmsq5F3ZkqtZURFVnike2ykj761lNuXS0NX0sGvOl?=
 =?us-ascii?Q?ec46MI9y2Jgt9EzZS0WBa/n+XcB6uaA5h1Sk2GP5Jh3kMUitSwvty1znFHGF?=
 =?us-ascii?Q?WIQxXYYhye5ZgsW14WsnQPX9NQmq7Gj5a2KXbfvDpYzwbtDGT2kz7I76MeXt?=
 =?us-ascii?Q?oUXRy0n/rUz/XsF7JjwPJGY6qTKPBfHcspo/KZ0/9LZpnaVlAtGjYfST9NqB?=
 =?us-ascii?Q?hbnWRr5JMPbgjqA24yKxyMxfINO0lcHl434Xka2bjQaYKMZcX0Sqx96+bv3A?=
 =?us-ascii?Q?fvrsbSReBtxY1D53N3AO/UrrhpSXNuYkWsGhqIUEvRw6UhikrjvKcDF+80Rg?=
 =?us-ascii?Q?/QnQBRk+QC8Aepz8cwJ7dlybYs2y1FGIrwRNyv+gbIPPb2FDZpXKF26TXjNR?=
 =?us-ascii?Q?ETDUjU7R75tIA/PuBcGNK3OWOUVZ5N6lCcauBZtMjuhJuAHWBpv6zRAfCChd?=
 =?us-ascii?Q?9uWp3hRUDcCmEjvrawhsLyCGw7nq5zjOzutgPquZkSaWekzQyl6mTrulqs0X?=
 =?us-ascii?Q?aWd+J+abY67Os/TtPvszd4uy1oTiMeAi1l20pRHHN5U9pRkL80oyWpYfJEIf?=
 =?us-ascii?Q?VBbZN5Oi0oq+MKh3EqRwyn6rM10T5S/ias81mFr/9ObiSMrDEDF9DLi+35IC?=
 =?us-ascii?Q?Y0NTl7ZOgCjzrlx680q1HxjMfgdCG/+GHu14uVfq/UWaxEmhfPQdfSn96ZxT?=
 =?us-ascii?Q?LLGjFXY/Ij2p48Ekm416yhWfup30415PwfiDfBJTgkegawpZhHIRnQ3xxlLT?=
 =?us-ascii?Q?nIcJy2DQIkq6E+9dgpxFdV19jOefcc72m0u3FAtcx+lbRRoO4TLt1DH308ei?=
 =?us-ascii?Q?Yfy/eoYz7SQeNfigqpdgFCqnC6boEzk5Vbgh4+9W/sPw+wzFPdMKcqxtmlgJ?=
 =?us-ascii?Q?+U2FP4L9S4ITgp1aDbVRqqUoG9G3uq/T/O4qoJrBfuvqlS7i71JynPZ2PYcX?=
 =?us-ascii?Q?QQMUZ6b+G4EikWxcV6Knqz1sMBBKIVS7icdvp7gVcH+fss4zWfNrXmHYoK9a?=
 =?us-ascii?Q?qFBeQLOGIERzB5IqxE2JXbN02IvQulA4emLhtnN2/C2ZDPOWK3+RJPDlnE96?=
 =?us-ascii?Q?Jlzbg2EfA7y6M9tCRD8xOZxel6UGArCfbQoBao90ptfsSU8BBu6bM0Tdms2n?=
 =?us-ascii?Q?POZQsgmGVXTPLnEVtpGDFEOLQyrc0544T9niU4/roTzxypIgRn0t6aIeqpft?=
 =?us-ascii?Q?j/Q12EQPLSjN2wxFKIE4D/q3sD+YV+1ArFaKbKWyKuHe9xMzt6w8ZqfmI2MC?=
 =?us-ascii?Q?n5LLAGMohRXCHqadz4A5FUS2K4V/ZPzIYIbAqYtx9dsiK+fUZK73wQD9mQEr?=
 =?us-ascii?Q?BZ/0UKPavszP1/Gmdtz3zcw184x9pJcU2S6qydCXcvF8KQFMx35NsKm0HACk?=
 =?us-ascii?Q?SpfYpfFW5Z30xsnCLzGTF+YgRaopiyH32KmIFpz86MdyhjpBbLN/cVyElrk7?=
 =?us-ascii?Q?BtJTipPhJgHRyxBRhcltKdslqeBTu3it4vR+O0Hkf+JNHQEW52M3xO1j/yKi?=
 =?us-ascii?Q?FqD0lvgLG3U17lRJz1lCL1n1Lc6Ohg4W/LuD4XmKKvJ/MZJto/oCr47yN9em?=
 =?us-ascii?Q?vwtu3pi0ABU6Wqjzvdkt2yuqronLjY6GuiSHPivOStTfELFA0Nw52IHIMpQL?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+TlHDFWbjxh9iUNyTnTRC01Zm1IRYKp4bnnMj0r/+rXvcTMlC99g/gUbgPGgqwAgCdPiriEXnFl3+PFGpU5gD7fARgg3JDBVDbLf6Ik+I46PXXw0q5NVPZ2AkcyV4ETu/57o3UXlZrsd5oGjOwqWEW3OHEYpCFhq+ASO4xWzgoxJ4LO7b3eLsLp9eUSwtGkwIGjf4vKAEXgjqzksUybfVqtR1Z6hMpkCJ8MAUkGSFax/olMsn4eU/8lP+V75HaRDnAMIz6cxlehkUpPPkdAAvbQhtkpr77aUklq9TDy9iNg1IgNI3BDH9PLw4kxtupnK3N4z5EhuuNOfoYizw5uUjGeJeQoNQs+geM7V0edu8HihCVDkG9XSEmeboe0hgzU9hMfedSJWt8OmO41e3hftQaGXHd5M8COkY7C9fI6n8zqPhoh8pt4+5NQQGu3vicZjHYmc66b82MkvuyARThb2/foAOZOfrIJyjV5pl9xiFbHUToyDnGuRriYndD4e1HfuXxxfK5NvWeoQsUOKsfLulR3xCAk7KvqSt1aW9Tc3IyQE0dN+YY5FgfD+cDsuQQQ49b9G554kxfp/GOWY0s7yuyq2E7GtA3iSYGlhClL5p0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655b89f2-d88d-4345-68c6-08ddf73b490b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 05:13:35.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7/AChBa4VWM+9l+1zj8985xEje6a/gSdjwWZNeX49arn09f6U9g0nnUwBgP7XkX02wtsd+owmdKAZTape5CVoZPQGAn8A2Lq77pUaBOtxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190043
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0g6dKesw+DHv
 pXVh3Z2qbYeJGaWEqJT2n9oh9RgvmbwNE8Ulcj05q5ofSAq5dvncvUuqQ56c95RImrMuHxjHhhB
 9bxh+TOO9eNRN3pnkFHei/R5hGaMC3TwYC3cUj/GFUYIEbGrnr4LUlaSDr6IEbxkk6HvL9pA7ui
 rUH6fKu7+hjUgSP/ipLgzj4vV+AkID54s93oYKa+ondMDFNxmXc6qMsFhhg9bJfQaSzELNa2dmS
 n6A3NfMRs2KoIvwqLJkF8iRTi0Ei5Jh2vi0lT7OirGz3v6RN/EXQZax7cqLun38Lfo1KqiPv8uv
 QLYSTuJPZNO7JfIjgGLfxyaiwdZqpl6h3wjHfc1RZjGtNZ/aTj4RAVs5mXjZtSLm12GFcdfScSm
 jXS4JeZo
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cce685 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=O5LGcXlZSdwNU2Kkwi4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: nq9BHfM2iCLjY6ERgyrhS4nWBUyz-knY
X-Proofpoint-ORIG-GUID: nq9BHfM2iCLjY6ERgyrhS4nWBUyz-knY

On Thu, Sep 18, 2025 at 12:11:05PM -0700, Chris Mason wrote:
> On Wed, 10 Sep 2025 21:22:06 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Update the mem char driver (backing /dev/mem and /dev/zero) to use
> > f_op->mmap_prepare hook rather than the deprecated f_op->mmap.
> >
> > The /dev/zero implementation has a very unique and rather concerning
> > characteristic in that it converts MAP_PRIVATE mmap() mappings anonymous
> > when they are, in fact, not.
> >
> > The new f_op->mmap_prepare() can support this, but rather than introducing
> > a helper function to perform this hack (and risk introducing other users),
> > simply set desc->vm_op to NULL here and add a comment describing what's
> > going on.
> >
> > We also introduce shmem_zero_setup_desc() to allow for the shared mapping
> > case via an f_op->mmap_prepare() hook, and generalise the code between this
> > and shmem_zero_setup().
> >
> > We also use the desc->action_error_hook to filter the remap error to
> > -EAGAIN to keep behaviour consistent.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  drivers/char/mem.c       | 75 ++++++++++++++++++++++------------------
> >  include/linux/shmem_fs.h |  3 +-
> >  mm/shmem.c               | 40 ++++++++++++++++-----
> >  3 files changed, 76 insertions(+), 42 deletions(-)
> >
>
> [ ... ]
>
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 990e33c6a776..cb6ff00eb4cb 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
>
> [ ... ]
>
> > @@ -5920,6 +5925,25 @@ int shmem_zero_setup(struct vm_area_struct *vma)
> >  	return 0;
> >  }
> >
> > +/**
> > + * shmem_zero_setup_desc - same as shmem_zero_setup, but determined by VMA
> > + * descriptor for convenience.
> > + * @desc: Describes VMA
> > + * Returns: 0 on success, or error
> > + */
> > +int shmem_zero_setup_desc(struct vm_area_desc *desc)
> > +{
> > +	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
> > +
> > +	if (IS_ERR(file))
> > +		return PTR_ERR(file);
> > +
> > +	desc->vm_file = file;
> > +	desc->vm_ops = &shmem_anon_vm_ops;
> > +
> > +	return 0;
> > +}
> > +
>
> Hi Lorenzo,
>
> shmem_zero_setup() does a if (vma->vm_file) fput(vma->vm_file) dance.
>
> It looks like we need one here too?

No we don't, it's intentionally designed to avoid this because mmap_prepare is
done at a time prior to the file pointer having had been pinned like this.

This is necessary in mmap() but not in mmap_prepare(), equally you can just
assign VMA flags or any other field without any need for special helpers or
lock/refcount dances etc.

>
> -chris

Cheers, Lorenzo

