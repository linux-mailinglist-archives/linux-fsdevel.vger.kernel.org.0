Return-Path: <linux-fsdevel+bounces-61754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C703CB59956
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4349C521B18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1403352096;
	Tue, 16 Sep 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MNobhwNm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XNtSzKD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7132A822;
	Tue, 16 Sep 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032010; cv=fail; b=fg+KQPnDhEAOHzCC9L5oSs0oYHPlbazU2iwYLxx+jhYr2CCvNl2UUZpMNKi41fTmCRl037HZe/+UwJGyELdoe6z/R5fkHsBzIMPgAjkcZBiQo1B+NdjtmqomcJ4Zd9I32sQCpnHsJIhQnzFV9+OMAYmLDt2wxQ/pQrIlvwbP97s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032010; c=relaxed/simple;
	bh=igpHTC7xvGmlJdaneDGae9LHm3+FMCLqoj69H9lepc0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KTRUC+rDElsYXvfLZDejnk1aEbvG1Nkc4FrNfAvtVxBMrekT94EsAMSm+/jbM7Qz9g13VdtgXeygxU10LEyQJ7lxXBjZl5aZyJdZ3FacFdo5xk4vBQ5yMljBCRaL29vSOaQ2Z6a9hzA1yrOpYiyAu7amgMEL4aMbxOLppTanACk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MNobhwNm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XNtSzKD1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GD50pH013998;
	Tue, 16 Sep 2025 14:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=e+IYTEnnBesGsRls
	om2skKQjADEfqhS3OBkjm1DyrEU=; b=MNobhwNmhVFw4J1wpaLuwpzmqDixIZdO
	+pTNwxeeq7ge099WGxvuWqHGTEKkfECSKrg5VWgRIjz/tmkhesjQyxe5bNEmyGjc
	zATGV6lNffZwwQmdfM7wl3s5ucOfluPL++v+blZefC42wYxgY4vsfP41gSpnbEFn
	3VSEjDQ7EWr4YbyLnsY6qKI14bofkBlfoOVn35EMmcuWI4EnCCuJ//H34g2rwRv4
	ivV2OF+2wuKQrCswLcoMhWGneJek7saaQiCk8iLGzUrpa/0/+PN8OPCTYfbAre/K
	JjfiP69dD+jNOBBee52VqHsbyTMT1IacTlCJ01hKE/hiBAUrnpfEFQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yhd4sqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:12:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDiCAY033752;
	Tue, 16 Sep 2025 14:12:31 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cecth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:12:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGAVPPnEyIeL2tQxumCcVSfXAU79owr3HTZBZe6J3Mh/r53oKRjGEF0u+GgXzVRQ1SLzI0XKYCwmnzsb595SsQwJRKrPz4DIJknJIlvKvRlnnManBV2z42T0O2b3qpsRHHxSroDO7LkZa71IxmxFdg3zLyXqMLvfvfreQU4cwJRTuomhiBm0WPpc3tmxriUhq9q+4cmiQFpT1Glhs1UAYaVYT7U8m7wYEECvKrQdR0T1/YPv20EHtcNhd1dG2MWkHVcZFLlYnj9ok2Pn6Zld3zePiArhUtHOwLrCFektvzrJ/dzJXddy4Ut7pYM0mqByhbRHz9pzM8DDNS57fsx91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+IYTEnnBesGsRlsom2skKQjADEfqhS3OBkjm1DyrEU=;
 b=aZWrRZ9M3atam0FsizLEezIUO/KRJ4w2tC1fUp3rflXxF9xskhBJlZXjeJNUKOKmfZ9CMvc3aGZepZ0O6ovEWiYC8u0WODTTEBuGm6rcm4hhIiy6/UDwB4ATiQhQyte1ieaqeguCGEkdxnQmiwyJh9/XcWBgL+36YQfCMs5YZ3Knms8i92f4ndVzsne7BrpJoauV3Awsun+y2DwHyld4UaFDIPp4oUNaXR2qh6NEJ61GrVjZDGQTm7ZcffZcmZohTo4oiuyThDy532Rc40TJDUJOCuUXZ0ji7KcNtsWBUGuXJ6r3aX5vSGZp3zRFGBqBkhG/rQ6Xvvgxd0LHGzkHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+IYTEnnBesGsRlsom2skKQjADEfqhS3OBkjm1DyrEU=;
 b=XNtSzKD1XHfw17wFA2S7YBCdviF6gr7vP8VSn8w3ER4ySvAZNQSo9CBXpIrDb76KFL3wSK77MaaqlQe2GW7Etkx5+G9UwaqtVyRfl72zkWExOK7wvu7bvAzdLp7I0EY2riK8YXDvixw1mZuT9nHKT03UERxpuCeD/Jsm59vl9jA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:12:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:12:26 +0000
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
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 00/13] expand mmap_prepare functionality, port more users
Date: Tue, 16 Sep 2025 15:11:46 +0100
Message-ID: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c5f9d8-f6df-4c57-7d49-08ddf52b1060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XXBerjjp4fBOBh6mSBuyCt116bIw61q7clwU4/LBGleuL4LTMoF+np5nWLu1?=
 =?us-ascii?Q?HclexjMa6NLjGvIUWFeOsLDMOevemCtZG26RDSOa2z1p4KONDT5MvjFE6jwX?=
 =?us-ascii?Q?HzhZSi4H4qGBzwY7QhSic1ug9cpz4PxpoO0v1flNRl32WklVmXhytgYpWalc?=
 =?us-ascii?Q?F5dpARwTG6h6wqWzpqhQ70vkZ/6wCccFEUiI9Ohjk9ebn9oy27qoXBYLL9za?=
 =?us-ascii?Q?7J/+Tite3Ebr19kJCg4AnA64/jHP+plgV8vYCxUlfYH19qudUN6m14K9tnsd?=
 =?us-ascii?Q?acY0yJQYMx9x7j0khChhLZKkkK3ZFSoLspP3oaM8Yp+z1wcxD7JEUF+i1t9b?=
 =?us-ascii?Q?uh13N2Vn4dxZWCOKsAN8UcxLj4VXAkuy0GjLY1vJ9TQM/ZTFNfZzN+bZvdqj?=
 =?us-ascii?Q?MghAKNgyoH0wt3mtjgYujTsraZc1IqkgCp19XWNWJKjbNKGQHP3N+C6Qz0UJ?=
 =?us-ascii?Q?Buom4mPAnVSHUhHf9kY+O43JySTAKuy+9hQAkuJK/D7juafFun4LAwsKDaLG?=
 =?us-ascii?Q?6Oe8keqf05tkcBOxjrs8up2kAJGywjqAk85q5K4zqAQwjFRM1TOzvjKDbMYU?=
 =?us-ascii?Q?bN3C2uoaFSvblGWoUQhpWYf1PhSArbwMRk3xIjayD8BUp1A7RFYhP0rCBQlu?=
 =?us-ascii?Q?pmEDD/7KZn0K9Wei+02XNX9AyaGTpj7jSj3srZhIvxrAEBkLnA2VNPfxmnbK?=
 =?us-ascii?Q?5v6E62/zF6z/ttGVu/T9NGwzg5CrOEYG1Vf4tmJkZ8JLljeGIVQHbJaXYWoJ?=
 =?us-ascii?Q?YEzKiJIcyVJqVO16UHawQqO4skkAA7ktdOPrbZCILoxhtO2AW6wCDRAjg2ke?=
 =?us-ascii?Q?5Kp8LWJ/PDEt+Pq0hYfOLWuY9ZsT2adzS0NvJRDYnu5umhubjA9ijSfFg/Kz?=
 =?us-ascii?Q?+6Ba0shwYqcFf9sy2IObwgYmbiWoLcc3MhUT3aiNk5OCBuOy7xv8wFiuA+nv?=
 =?us-ascii?Q?tqVuML0273FnekuznDYoY4xkx40MK58+J68qq+PmkPJnbjof5f4JfLW58Ylt?=
 =?us-ascii?Q?Dq1QGuKrBk6XISldBHw/KIEos7nzeQlsiAzs2re4Lry0D8XR46GQPJ3Nkg3N?=
 =?us-ascii?Q?WEFgVMSZJAyTCOeTrBVYig2hZO/a0wGpdT1y3WyYP2COBuAPlEyjav9arthC?=
 =?us-ascii?Q?A/dGVCvcZUREOiMrISD/sh4q8brunXYz74GEEOD3gAp8+vZXeBojJJ9iohik?=
 =?us-ascii?Q?n38Ozn6LchVflt8gwKYzv+8V9ZOPaZmLqYNOReKgxPgy6NnMGmOxvVPpmyx4?=
 =?us-ascii?Q?y6NBFglqyN4d5x/59+BLSyiXUPuaAi7nZp1lWGHpA79mgwqK0xo47SprZIWF?=
 =?us-ascii?Q?IE/vlayYsQ5e9CCMwbsgTsg7+94Rt+uZwmJR8ewLDHcnXSEKDbJMVZ5AiBqy?=
 =?us-ascii?Q?uFJyR+k4gs2tQn1pig2OD36Y1vBZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f24E75xqKtnMvBquh/k7Y8RnZPMFN9tAes130GljJ5aVmLUrtXK7q05lzX8g?=
 =?us-ascii?Q?n0nBZHB3tx95z8tkadTcnMDJ7ypP9aPfXoye/OO5URnunD/9ZJ5fRW/93VRr?=
 =?us-ascii?Q?diIirlKh9xP84Ku4GJUbo1dYWT7cOCPhaitrEt+a9XRZovJQITC9E68uNS03?=
 =?us-ascii?Q?h17Zi7MdWF+5aaq0Gdf6PBQhGsCzR8yIITj7mmuWo7Iid6oM7IgCEmv6CMcK?=
 =?us-ascii?Q?0B4iIeEcONcgafCbtN6B8JzlsF4XAoFSTH+1xATu1uqizyBrkv8seb8ArZq9?=
 =?us-ascii?Q?FMb6O6lG8F4pWFNW4zui+JbSwIODGRW/sM0CXmsyQaDJk40QntNy8g39hYua?=
 =?us-ascii?Q?GG0Rz2sH/LBdhD3PO4tOSL8O5G+ruLKcDjVgH1pM96J56GzSYA6HcvqZiVXa?=
 =?us-ascii?Q?TT0CJQZazKJQ88vDR7T59n8mS6Q99PfzCyHhKhoUVmxxXXVzMeUtWirdvLsD?=
 =?us-ascii?Q?yMYDswwVfRnYUVksczIBCKcwHU2fc7o/cll2B0C9mpK5DuxRYeAdmg5uh6g5?=
 =?us-ascii?Q?FyxEMMpoEmswOq7gEJmb7nbwMHXyvWmUI0xvzaDO/JyQdALHTSXOzFmAfBrE?=
 =?us-ascii?Q?rQu3U9/I8LuwF9Hv1l392BdH/CHVbXpSpopUAxr6fev8+ZMVlWHii2/niHU4?=
 =?us-ascii?Q?KPbngS34l/jXXQwpaTaTdgden8tpN+raHP9f2L0TVTVmYnYUWw+yg+PIDN31?=
 =?us-ascii?Q?iZsZmRtE3FMek+F+4HPBnYWNXZ68YwlIBOvLHmN80GV9JjH3kAeKekrheFH7?=
 =?us-ascii?Q?dKDTiaxAnhEitW0+PiM/NyIZ0s40epsRffqUnZ9Z9RO9EXLhgryRlYRsvM5L?=
 =?us-ascii?Q?IsOruXms2172+iSyAZCB51VEHsPgrYaqHny6NYxYIm4VROZnOWu61kCUUbl7?=
 =?us-ascii?Q?3HFze2+QuU9Q0hr4VTKSaNU5mcF1WnsxUhCPM1OVJaO0L+eFlI5aVKxxYPjd?=
 =?us-ascii?Q?L3APYo2Dgt8VETXNMWwKqVDhmH0heTU/xXwczKQsWyUrsM25Fn1scMwFtzt2?=
 =?us-ascii?Q?Sz/EepbCaH3/zxfcdFuE1CgjihuJR7dmvuQtWLti5BwQrxf3K9aNorP4Aamx?=
 =?us-ascii?Q?u6Xu/20VxropkRDm8mKt14iDySywNm+W1LTYdvF2EHewe2/PJruWf5pb3xzd?=
 =?us-ascii?Q?s9PY6QV3GNP2bl87195CFKdJtG1abMW0HA3D8RiFisaUSo9b0ObmM/PnhDR7?=
 =?us-ascii?Q?ly+QZAh17VoPm1M5LL9IzQT6wncviIFnVoDwKvLY89WgsWSDI0GcdIJag6+w?=
 =?us-ascii?Q?Oaswtqd8kmZodO2u11IPMEKq64bbnFNHcQ5ZnaJQkNAyiICpAi1MoEetMU5S?=
 =?us-ascii?Q?/7uElpqjUjuNWoxXESYJrVxJLXTwGXtJIpOJqVqxpPbTpwXLtcokVD280ikk?=
 =?us-ascii?Q?VLFpWs6Cy4FcjowboCdateyEqBdjmmd42f/LBY7rqh6USW5j12h533X+42rg?=
 =?us-ascii?Q?/aEJtjn+d+qCNHE/CzaV+K1M7IcHVblzG7xMDWFfIjUIpDZkjQbtESgbjRiL?=
 =?us-ascii?Q?ApqWoccg9GjzWfVwFRewLK+h2yiByYMnCEg7Gy0Pz1SLRekIvB2cGPPUrtAm?=
 =?us-ascii?Q?IsAZg8QF/J3LfM6c/hTy+sJ4EFVJFRGeTtYOOR6GO1pO8Y8eBlS2yu6IdzQ9?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X46nxAwThVxXE5E7zbL/mUZV8HEZoezk4qC7msfRJPDqUgVEhbMOMyc+OB+0QlJbU0kx2TNsN2LfA3zhMpDLoEjqKwpzJPkQg1SxKPF3MX3sjeHoFoy/+9lA5XUvetRIRbxx0K6h1r94v1qPKOcDx9y2w3ZQbnOvPr3z6ucC+8dBsrCcHfcTN1k09zXueXwycWHo8zAg6VSzCHpifbZrbpbPD0xgAN5BZl6vZ5VKRIj/auC2fDmIKiSrJJvqa1SH6XBiTFN6x+SmtTz+t8SkzG0L97PxdZvsYea7RpUJZ6PzDAEjkM57brGLRfI9pMUXE7R6V+UWRiqi/U+Ogij8WS55p4BpXwTRLJd/fdhiDoaDjJL/B9WxUpiuskh6TQq29fC12kEWaWzcS0x/1JRlXdJqsciR9oKZQffRNamVaNUH2lSUVqUoyy937IpsJ7ztlkex6ktMD2gDvfVs36KJgVbM5VslSjey6ef8c58Tpr4jHrWe/fXeBsCMFYoNgPqFN9MxBH/jdDS8fO0SXgfeCuvJBOiBrorI+9frebmNWnHYoam0t78zwcBiEopWOwEQPwQbeOIkKVCboPr2f5dH8uwvGbqLjAgaVKT5zf0zk+A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c5f9d8-f6df-4c57-7d49-08ddf52b1060
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:26.5371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +snSCk+ZJaayz6FLbqA/3VAPWxWrbyfuU7uWsV/sdMcLXI+175uX6ZAe47m8V8a07WqyD+fFDknQ/oE2D3etRhbNc3yqA/LTzp+wj+utnf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOCBTYWx0ZWRfXz59tMZlOyJkD
 uRQEh+Rshb+B5g5bDUWRH0Ctd/EAGCZnAto9XEzB5sjrAlGNVNk0l875pCv/paTGA+xkleDTlQ6
 +xPAIWPD1wtAd6SUonOAhO68044AMVje1Kpv1w6J3h+REn0E+k1cBLX65MHNBab5IrHJ0EA+qhK
 TnOtFfFhWLQr3gKA0CT+9Cjb4x02Jjpw1hS4z53RargUTZNdDjqckKXdo759PbgkmjqLAZ4dZsf
 WCg+InUNHriY6K34A6CtfFni2pdYu1WtnKS6dpVvLNGeJH4PGxXGAft9JnwiGRg5yU+omK8cWi2
 Po8I2BLd0XiOesM0BuAZ4rAfn4EvrRANmzO+/1lOibuF8CyXBDuNUGGVrf0/ZsEulNjqBH2sNvF
 BUsoYA/f
X-Proofpoint-ORIG-GUID: pP6iju_n-67JRb9epdsYGx9k-TyoEekU
X-Authority-Analysis: v=2.4 cv=YKafyQGx c=1 sm=1 tr=0 ts=68c97050 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8
 a=1PknxEJ185HeLLv6iRwA:9
X-Proofpoint-GUID: pP6iju_n-67JRb9epdsYGx9k-TyoEekU

Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
callback"), The f_op->mmap hook has been deprecated in favour of
f_op->mmap_prepare.

This was introduced in order to make it possible for us to eventually
eliminate the f_op->mmap hook which is highly problematic as it allows
drivers and filesystems raw access to a VMA which is not yet correctly
initialised.

This hook also introduced complexity for the memory mapping operation, as
we must correctly unwind what we do should an error arises.

Overall this interface being so open has caused significant problems for
us, including security issues, it is important for us to simply eliminate
this as a source of problems.

Therefore this series continues what was established by extending the
functionality further to permit more drivers and filesystems to use
mmap_prepare.

We start by udpating some existing users who can use the mmap_prepare
functionality as-is.

We then introduce the concept of an mmap 'action', which a user, on
mmap_prepare, can request to be performed upon the VMA:

* Nothing - default, we're done
* Remap PFN - perform PFN remap with specified parameters
* I/O remap PFN - perform I/O PFN remap with specified parameters

By setting the action in mmap_prepare, this allows us to dynamically decide
what to do next, so if a driver/filesystem needs to determine whether to
e.g. remap or use a mixed map, it can do so then change which is done.

This significantly expands the capabilities of the mmap_prepare hook, while
maintaining as much control as possible in the mm logic.

We split [io_]remap_pfn_range*() functions which allow for PFN remap (a
typical mapping prepopulation operation) split between a prepare/complete
step, as well as io_mremap_pfn_range_prepare, complete for a similar
purpose.

From there we update various mm-adjacent logic to use this functionality as
a first set of changes.

We also add success and error hooks for post-action processing for
e.g. output debug log on success and filtering error codes.


v3:
* Squashed fix patches.
* Propagated tags (thanks everyone!)
* Dropped kcov as per Jason.
* Dropped vmcore as per Jason.
* Dropped procfs patch as per Jason.
* Dropped cramfs patch as per Jason.
* Dropped mmap_action_mixedmap() as per Jason.
* Dropped mmap_action_mixedmap_pages() as per Jason.
* Dropped all remaining mixedmap logic as per Jason.
* Dropped custom action as per Jason.
* Parameterise helpers by vm_area_desc * rather than mmap_action * as per
  discussion with Jason.
* Renamed addr to start for remap action as per discussion with Jason.
* Added kernel documentation tags for mmap_action_remap() as per Jason.
* Added mmap_action_remap_full() as per Jason.
* Removed pgprot parameter from mmap_action_remap() to tighten up the
  interface as per discussion with Jason.
* Added a warning if the caller tries to remap past the end or before the
  start of a VMA.
* const-ified vma_desc_size() and vma_desc_pages() as per David.
* Added a comment describing mmap_action.
* Updated char mm driver patch to utilise mmap_action_remap_full().
* Updated resctl patch to utilise mmap_action_remap_full().
* Fixed typo in mmap_action->success_hook comment as per Reinette.
* Const-ify VMA in success_hook so drivers which do odd things with the VMA
  at this point stand out.
* Fixed mistake in mmap_action_complete() not returning error on success
  hook failure.
* Fixed up comments for mmap_action_type enum values.
* Added ability to invoke I/O remap.
* Added mmap_action_ioremap() and mmap_action_ioremap_full() helpers for
  this.
* Added iommufd I/O remap implementation.

v2:
* Propagated tags, thanks everyone! :)
* Refactored resctl patch to avoid assigned-but-not-used variable.
* Updated resctl change to not use .mmap_abort as discussed with Jason.
* Removed .mmap_abort as discussed with Jason.
* Removed references to .mmap_abort from documentation.
* Fixed silly VM_WARN_ON_ONCE() mistake (asserting opposite of what we mean
  to) as per report from Alexander.
* Fixed relay kerneldoc error.
* Renamed __mmap_prelude to __mmap_setup, keep __mmap_complete the same as
  per David.
* Fixed docs typo in mmap_complete description + formatted bold rather than
  capitalised as per Randy.
* Eliminated mmap_complete and rework into actions specified in
  mmap_prepare (via vm_area_desc) which therefore eliminates the driver's
  ability to do anything crazy and allows us to control generic logic.
* Added helper functions for these -  vma_desc_set_remap(),
  vma_desc_set_mixedmap().
* However unfortunately had to add post action hooks to vm_area_desc, as
  already hugetlbfs for instance needs to access the VMA to function
  correctly. It is at least the smallest possible means of doing this.
* Updated VMA test logic, the stacked filesystem compatibility layer and
  documentation to reflect this.
* Updated hugetlbfs implementation to use new approach, and refactored to
  accept desc where at all possible and to do as much as possible in
  .mmap_prepare, and the minimum required in the new post_hook callback.
* Updated /dev/mem and /dev/zero mmap logic to use the new mechanism.
* Updated cramfs, resctl to use the new mechanism.
* Updated proc_mmap hooks to only have proc_mmap_prepare.
* Updated the vmcore implementation to use the new hooks.
* Updated kcov to use the new hooks.
* Added hooks for success/failure for post-action handling.
* Added custom action hook for truly custom cases.
* Abstracted actions to separate type so we can use generic custom actions
  in custom handlers when necessary.
* Added callout re: lock issue raised in
  https://lore.kernel.org/linux-mm/20250801162930.GB184255@nvidia.com/ as
  per discussion with Jason.
https://lore.kernel.org/all/cover.1757534913.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (13):
  mm/shmem: update shmem to use mmap_prepare
  device/dax: update devdax to use mmap_prepare
  mm: add vma_desc_size(), vma_desc_pages() helpers
  relay: update relay to use mmap_prepare
  mm/vma: rename __mmap_prepare() function to avoid confusion
  mm: add remap_pfn_range_prepare(), remap_pfn_range_complete()
  mm: introduce io_remap_pfn_range_[prepare, complete]()
  mm: add ability to take further action in vm_area_desc
  doc: update porting, vfs documentation for mmap_prepare actions
  mm/hugetlbfs: update hugetlbfs to use mmap_prepare
  mm: update mem char driver to use mmap_prepare
  mm: update resctl to use mmap_prepare
  iommufd: update to use mmap_prepare

 Documentation/filesystems/porting.rst |   5 +
 Documentation/filesystems/vfs.rst     |   4 +
 arch/csky/include/asm/pgtable.h       |   5 +
 arch/mips/alchemy/common/setup.c      |  28 ++++-
 arch/mips/include/asm/pgtable.h       |  10 ++
 arch/sparc/include/asm/pgtable_32.h   |  32 +++++-
 arch/sparc/include/asm/pgtable_64.h   |  32 +++++-
 drivers/char/mem.c                    |  76 ++++++++------
 drivers/dax/device.c                  |  32 ++++--
 drivers/iommu/iommufd/main.c          |  47 +++++----
 fs/hugetlbfs/inode.c                  |  36 ++++---
 fs/ntfs3/file.c                       |   2 +-
 fs/resctrl/pseudo_lock.c              |  20 ++--
 include/linux/hugetlb.h               |   9 +-
 include/linux/hugetlb_inline.h        |  15 ++-
 include/linux/mm.h                    | 127 +++++++++++++++++++++-
 include/linux/mm_types.h              |  46 ++++++++
 include/linux/shmem_fs.h              |   3 +-
 kernel/relay.c                        |  33 +++---
 mm/hugetlb.c                          |  77 ++++++++------
 mm/memory.c                           | 128 ++++++++++++++---------
 mm/secretmem.c                        |   2 +-
 mm/shmem.c                            |  49 ++++++---
 mm/util.c                             | 145 +++++++++++++++++++++++++-
 mm/vma.c                              |  74 ++++++++-----
 tools/testing/vma/vma_internal.h      |  83 ++++++++++++++-
 26 files changed, 868 insertions(+), 252 deletions(-)

--
2.51.0

