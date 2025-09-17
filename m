Return-Path: <linux-fsdevel+bounces-61932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F90B7F4F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A621C25DEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1DC2C029B;
	Wed, 17 Sep 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T20YU7Oa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hGGIMrY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F221C5D72;
	Wed, 17 Sep 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115508; cv=fail; b=M+XURj51nSAaKRIfOa4+JEYg7t6q4VbaGdGeRKnOwAi7SZcu6sjDScO1hR/jGMVZdJliySWwtNbZu2e4ZE0ggSLYQ2bMQ76DhPbjDvq2REH7ieWi0+oIohDjz5He/783D0jFJRQ6ihEKPiQbkU7uoQ95K00UeJdWpDAk669qiiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115508; c=relaxed/simple;
	bh=tnWNJ5A8uxxwmUPIhR5I47AjYBPlklLXCz7wO4JIi5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ibmQEE6iTyhqwyywb8VbLgQsTiRsqUubaUOFkI1L6et/DV2m582FT685eNedfwodqWk5KVovzKK3iA/SvH7bg5ZVEw7drWmO4BpINgYiVDwfE56YdQ4ngXNS7Szlem3xe0Un/UzruXy454kAD5M7Q31lQOlZ35bzlbPPuk9kXyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T20YU7Oa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hGGIMrY7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HARDdO014890;
	Wed, 17 Sep 2025 13:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tnWNJ5A8uxxwmUPIhR
	5I47AjYBPlklLXCz7wO4JIi5A=; b=T20YU7Oacjy1V+vrEpoePv0mzs0eWOls0b
	nseCVmpztCPMdyrluX9gzpJctWJkFZ1/0spfEJ7t7wzkcyz0OiqgJCoqgs5W2/28
	+FAJEVotbTBO66TiFARW/56M+615TiCoP3fghFENDVYqEqjvM/nEGKhC5CoiMbA6
	adadOO7s8DDqZOQCqzcnGvsoq39h+kG0GX8KdhLJedEYDTXSqzk7ny5IjQvTMuTx
	mJoWD9W+8KjZuM6ZHrrFWjwG09JDkCFmLxEVhfy7CbC05CgXUvz85oy7Rm2SwV1u
	muBbgstE7A7Rgm1cLsiucr7eijmPWFcu/2GbnppfE4IWCqgVuDRw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9s7ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:24:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDIvBu036979;
	Wed, 17 Sep 2025 13:24:22 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dsngd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:24:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psHj8mQyjRkGINRF+EXdESdLou4UjW7XzBuZaHwhImROBu9yb7SxthmfWNs5GQiF/JBTkDmW/6/yf1gyFjQrYqb0Q9A88UM6zscKMXIY/6cM0hZZyLv6WJCbMZG7Sk6wWKuk/cWfYUA0sogQza9q7I7wDXxVQyfjqMLUAMFyQ5Rk2F9L+6UGAQU1utZUSdGQy7j6lxkZ86zQvzFJVKYsV1YtLUdifCpVgrD7TSCXwyFG4agdRV68i5HDGOeDC/Bah3+J9BK09m3R2zndl3OJDPYLeqqJQIANNpcLGCJhLFnkeDlD90+fJSkPOAq5l+ecq0ZMjDCUMcdWZyxsqkxsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnWNJ5A8uxxwmUPIhR5I47AjYBPlklLXCz7wO4JIi5A=;
 b=wevFiDLfXsrd171mTd+5YEshah2hpmD6pT5R9J4oHytKpJ9MFKE8trrTDVW46odCYTsLBulet69bNL0+6Qz+hGsNSupWZuql2TOXE9fhxlG3l15H3wbKID7zahPyycwmh9G0UXSsv8ftZKDswR15TQYNEMmyMKxDozFs9JH2Ga9O8Hb8AnoVmFcRkOLzWsj7zisHfnk/VjsZ2n/bUh/afVUZyDOz69aPx6hhycJ8bcxaD/3bCyUmKDQ7oBCI1D+bo96nyhMe5d6vmORmW6mR951DLwZvw2KMOWwWuu5CDUztAfBmIxT3NHgeqAvcM6orfQa5x5RZDOvZ3cbOM+oeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnWNJ5A8uxxwmUPIhR5I47AjYBPlklLXCz7wO4JIi5A=;
 b=hGGIMrY7j6ZIW0Taz7xJyyTxKoCEHf9MVTQekSLYDrU/BOQNMJ8LL5N8T/y/vm1EeZNna/h8So5Jp1ED24vT6dDNjmZ4F0nwnQvC73YagNekysnIBAyHUJTYwoBhYP/rgS4gaOnUIaVdZ1NYP0dVvSbnBhYj/j+YG8ZFtKY60CE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA3PR10MB8467.namprd10.prod.outlook.com (2603:10b6:208:582::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 13:24:18 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 13:24:18 +0000
Date: Wed, 17 Sep 2025 14:24:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        kexec@lists.infradead.org, kasan-dev@googlegroups.com,
        Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 05/13] mm/vma: rename __mmap_prepare() function to
 avoid confusion
Message-ID: <5a00d4ba-dcab-416c-97e8-10e47433ef05@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <3063484588ffc8a74cca35e1f0c16f6f3d458259.1758031792.git.lorenzo.stoakes@oracle.com>
 <jokgdkyv4ca4sb7nl2wjkzxclhzhaee4p4luwj546tsdbylfei@laplfpugf3of>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jokgdkyv4ca4sb7nl2wjkzxclhzhaee4p4luwj546tsdbylfei@laplfpugf3of>
X-ClientProxiedBy: LO3P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::10) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA3PR10MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b47494a-d7d9-4ee3-6b89-08ddf5ed811e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nsHsTX32njx/1sEumfgv+jsgeRfUWD6Wr0xUyaGzLT7P0IR68pLma56rAkrN?=
 =?us-ascii?Q?pX+sKPV5B7mNS2MWhGmq0CBbQlureCbercmxro8o00x0MmQ9PXanthY5114b?=
 =?us-ascii?Q?muYyNDTA1gZScpy79dhuWf5Ar87y2h2xiF5rNo/W/U341MISJeme4QPkAIXj?=
 =?us-ascii?Q?pQyuY8n+ZholI5dWA4U9lWH0Kt9yJl6BcSGoFN1C3BOAytuE7C2YFaZD4JF8?=
 =?us-ascii?Q?hbPhiHu9jBSJykoR3CirxRDgQ1oFfivqs4OoeEJ63Ny652U2bnxE5OqaxUsS?=
 =?us-ascii?Q?BSgfDjscYKB1h/jCpCdDsUHxVbV1+hOaX7u7IQW+Afy+na8YXpTCbHni7v0z?=
 =?us-ascii?Q?Ch31I56heCCBRdXQ1zxSmTDBZ+6kVC4w3h+XVCfVJc/FLQtrOut0tHAue06M?=
 =?us-ascii?Q?7p/rS8GGGsH+eA3aVjRzvD9AXpChJmq4ju+zp+frk1t35sWYYP2FbhZZZO3X?=
 =?us-ascii?Q?nVPjY3tllIpKD2B8pOmujVKXd6m3fDW1LfViM26gUJJJdkXVX5r4/1k/hBhw?=
 =?us-ascii?Q?BjGWv4MJgGuOOWIVGQfM7y9LCC8cBIXyX9tk3/llA7P4lH8jOH+LtYQvKwxm?=
 =?us-ascii?Q?eNEJCnjavZQIGTlpX4iY2MBEwjDZBz0uOk5q2tqHllNk0FH0eq80Whb3/m7C?=
 =?us-ascii?Q?xfmXBFRJlyKvLlLGUQTXZ2kjAbpfdqByXkDHpeP8ylniSWW2t7RuzvpmAF3y?=
 =?us-ascii?Q?yhxGcROwe2aFnf9rTrGnpChMGxodB81rG4KE8rbvIJmAHs4Fs6C01F7j6ixT?=
 =?us-ascii?Q?YC37MgpRIh70TbMbeFIgAnSHB5VQQ+CzDzuH81WZRevsIS0XLuGXm+cYuD+T?=
 =?us-ascii?Q?phzkkYvsvl0/QcLMHAd/5krlItDWY1KipyotoKz3HsDC7vyXkaMVSfE4FSsB?=
 =?us-ascii?Q?8kTnuxvPLAcT09ZRBb7nMEUyjeWClfELbFKNU/+HZSofBj83hBdvMFckq6bH?=
 =?us-ascii?Q?JUdl/z4wpCCH6qgXlA+m8V9z+fG7dzc6Xm6GprQTHerccosrxcU2aDglQQ2S?=
 =?us-ascii?Q?rxaft/QbPOpjsB8ID4FzDtkWeRTty+/0j2MuZZ6mpNRLVG2TztpjjEIQQdPT?=
 =?us-ascii?Q?heuVoSp4NjzTHSLWslWemNJ9zQH6u2pmFEAmpKR5cy+W+i+1nFAXPzxZG76C?=
 =?us-ascii?Q?SEWbjR9NIYUaZweUQ0QXXQk/QiZe4INJL0rhvYQtlxmNaw/fmLuOFhHjdDXu?=
 =?us-ascii?Q?2fVfJi8qkw30Hple7ScSN8zzVjOpicB5v6hlCpJRURPyffazSkEoDeoCpdmH?=
 =?us-ascii?Q?OsB95e/sCGAC5sbZWCToJOIv98xeP2cur3bGiuYIkhRtlcao0ZiSQfe4U16t?=
 =?us-ascii?Q?00Ta9v8KeQNx6g1ZgFtsHxlfHt84wsYwldWldydBWs7iY/ErhuwwgaRC8EZi?=
 =?us-ascii?Q?yZoiiaDx1yKwZY8RjHBkusBFTmlWfJtFJB0U+DnD4aaIHtnV/EzLI9LHadBM?=
 =?us-ascii?Q?6JaSCsvu9dk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ikmw4KCFP3mjztGCH3/qiC4+FPYujvzuphLpyCB9StsRWVl0A9JkfOKzenSU?=
 =?us-ascii?Q?M5g4kqzb/1GriRPam7pmKOEzI0osBz9p5fvBt68ZDkeuLZ62xhDVQiMMQ2Pq?=
 =?us-ascii?Q?OUjDTUyCGiG6HzDdXSQ9sfJjUbgN8a90aKsfR8ecfxjgjuozlW5qGc0zP9up?=
 =?us-ascii?Q?MvZOoehvYJpc1OnaR696IgSlVZ8LTDG4QUGOGqtc2S95mbnGCMnYJ3xgFh57?=
 =?us-ascii?Q?l5A9RYIpOoXid5oG3POgzwBYF6Avo5QteUdxriPgZxRT5oqY1V85YbJ30mVO?=
 =?us-ascii?Q?lYvpeu3oN/2JIWAmI8iekHAOPERXlMv2+7VFEbSEBW+oaqHR/gF6XxXy4Rm5?=
 =?us-ascii?Q?kLSF3P7Z26ZwFyWxkWeFGUbRGRLmaERqag8wfsD1cXGjBBEPOoFUuR1r0I04?=
 =?us-ascii?Q?SCPD6EG36YeKXUCVTBPW9c4A/kPr0ytEu4FTVxkZ5KmNKhxYuJI3gcib2Q+g?=
 =?us-ascii?Q?FhsF5+CuyVNNNVAb9bdLAyI4NiuxSTaLXWE7wr5P7rKOBpyA0gYH9iziLHNE?=
 =?us-ascii?Q?utJkRkagT8ngcHgqYy46J9/WTTqh7tUryf8Yx977G/dtHv1lOWsoMo/2GhV/?=
 =?us-ascii?Q?qIGv7rZneXa4t2UOmapS0d1wxLUjd/60JbRQqv8zn8tozUv8lyiEyMDD652Z?=
 =?us-ascii?Q?vxAOihMZ2FDo1pcp2e0XQRWCwHddz9/jfJDrqvT3xSXESF/8LXYIW1OeJlDt?=
 =?us-ascii?Q?coyF3RLsNh+5tEyieKOPVQpC9X/lRTjs4fR3hvmdPlqa5r8MVKEBzpEAHckJ?=
 =?us-ascii?Q?r7ArfynJ9HOVTOoi4/AnJfy+mG0TnNI0sU3o5GqriRiF+OJvv7sZHR0zIyxz?=
 =?us-ascii?Q?HWjNLpQuvdP/HFcVJIGYqiDFQk0JyKJ9P6jiH7tNe3nN9VRMTjns4ep1OoDP?=
 =?us-ascii?Q?ohGTaGMjl7wDWexHlSgJbNo5VXgvsG+OMPt+3h4ttPO6LY0VNFnjlKOTfTWt?=
 =?us-ascii?Q?7q9B5k1erULA/uxtUK4kgfH5nDJhBeNxhY+LwdIG0KfuOzdTWFRA4L2l5A6z?=
 =?us-ascii?Q?EBURPS4Gqzx8d5BcVPIltWpoaYJFNWYTSacAq6L/Tj0ZwyqfAEJTaeWeTFrf?=
 =?us-ascii?Q?4Jmme8LGRcKGCc6ArxW6876Nee1T4ehJxtH/0FAMdPvEUbHkIdQ3qdA4iAXH?=
 =?us-ascii?Q?/xWo3xSIVFXnBFBuTWtm4o/MUSO+hrgTzPmLqVHKoTyxVmgTrRRspcp2ZyWS?=
 =?us-ascii?Q?eN2s32Sm2hCrKcWx6glui0TNONbqVHzx+2wB68RhnXIGRV16wFSH1MTF3AoG?=
 =?us-ascii?Q?wJQeOo659M1KAoWwaTFrQHIw17agpoIT2uY+hcwXYq8nYIaRHHu0dT2xfiC/?=
 =?us-ascii?Q?3lqkdJPZYpZyZC8KPsyBqS6PaOYC0lWITRKwPSEnxNtQVQAG7+Hm06F7rB99?=
 =?us-ascii?Q?U8teNVhcPTL8mqKHo0xTwquF2jzAoxFffvhnzGvBpfBW+YN1vxVdzUpJEgHc?=
 =?us-ascii?Q?o0tUezW8zzVLA0P9nb8CxUohVwzKlPqVmgqYBDCKXdQfUitM8IuhJ0h6QESF?=
 =?us-ascii?Q?kkOQrn6+XnmFJtym16/A1YqhO+ii4vzc16FJvyJYOMMbzw18V5FDsDVDeB8T?=
 =?us-ascii?Q?YnFICyMRKP7aC8OHBOnWpTOV5mkxnuq+BBlGfPThJZzxSFQbSu95RWiXTF8q?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nz4375TeHRu41DhKdvwgVhpxmbigMMhBb06rY55anpFacUq7G2gMn14/SsRY+DC8mICTIvSjBmWM9PVXTLjqd+o2UXpDOMKamfeULDmgyacnj3h49BGDrlFdX0yyHD6Kx/BBMIkni1kvXN8gXSyqeYH1EieBS9o6j61eh2HWvB/MV1s1m8E+Rar6litTcax2YFb6qIvwLfe473XVXqPgptvCWltfcG93ksCRA0aaJT7z0QmsUpN4s2TSCXSzbo4GvlMTCFNEb28j8snGfhULuzCO7oW2++R18n7RRUhHL1fDJq0pIIQm8ssKbghlj79a5UbgGUEKwgaikEjILUWvcDIoEd2C6HJYT09ICsgZyhWEY90wwKHZaNMuUT3iuP4+rZWYnMkSzp8DQegf7u+NFrla8LRt9DZipFeIc+1KEWfpBi6hggEe+RDH51l4Yzhlj8gltdM/b2RXY/HhJz+CURCKNouKoR9qm/akcO2JVd0SO2MYIdFS+pbmpO67okI4eIT9PRaY+WsRSY2FqCF93cvXlsUUKPAo0SBgKfihps72dVJyN5SQmp95/gxOmhsD0q/SiTdjSbzFk5I4Gw1BMzSnYwNtndnO7/60THoo2Fs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b47494a-d7d9-4ee3-6b89-08ddf5ed811e
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:24:17.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n30/FogE3LYa7P4u8YrN/KQtLaSG6Z4GgtcGKHEd7N5qU3kE9BGQ9JB0YNeEFJRIOf5JjBuYietbZNTCYfF3/LpyaG+2Vl78hcw3Yk7RU+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8467
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=998 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170131
X-Proofpoint-ORIG-GUID: x2PXV00BhCyzfMCR9LWlBXwQoADPeXCh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwAqOg2o5nNke
 68o9Sgtbs1qzFcfeY5cnrlZHziR3l/N7Gqt8B6ZeK2y6qUnEf9p6KgDpegez1PoXB1pbN38E0FE
 fWvxfAhKhLiJeIm/TWbFRoIoRIdIh2pF0863xa4TmynIczU6JGCh2fie6eBHayIZ5sOcLzngw1b
 /DGMkL+CANkwRIShGzqWxAoJYRNfsahE7aus0RVoZmaq7SsbXgkuDG6tUpg2cmhx/Ni1lla0pmI
 N8VYPepHvgcFiv/QdMqxXdKuJ4MRAA7XjfkIgVRW1cFTu4kQ9+RZ0XJv3971Nz3e6hWmjn/5Yhv
 KNft7B/t/YqHmYsEAyWYwaeHNCg5pFtDZbalZVNac4E0pXNxjZgpLtT7CHYtPF+qQkq3nT08pLT
 rtddOh2CVqvrcOIu9SsmM5gALbx7vw==
X-Proofpoint-GUID: x2PXV00BhCyzfMCR9LWlBXwQoADPeXCh
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cab688 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=G8iao3qqSICFMDEECUkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084

On Wed, Sep 17, 2025 at 11:49:18AM +0100, Pedro Falcato wrote:
> On Tue, Sep 16, 2025 at 03:11:51PM +0100, Lorenzo Stoakes wrote:
> > Now we have the f_op->mmap_prepare() hook, having a static function called
> > __mmap_prepare() that has nothing to do with it is confusing, so rename
> > the function to __mmap_setup().
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
>
> I would love to bikeshed on the new name (maybe something more descriptive?),
> but I don't really mind.

Lol thanks, I think let's get this in :P

>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Cheers!

>
> --
> Pedro

