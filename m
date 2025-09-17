Return-Path: <linux-fsdevel+bounces-61990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966A6B817CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190F94A64D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6334332A5E;
	Wed, 17 Sep 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gQGikju5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B9PI/8Pg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC932127D;
	Wed, 17 Sep 2025 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136342; cv=fail; b=fVMRovU23TR5e8577TTNFrjJSBynmiEhjcKGVrswgEAEIAg8necsnHvX54OcnV38OsciTsPgfLhiUl0tH75Mk/bpdgZaAtGyFc04nRWT9/wRa0IammynUqXohdltXhQ58K73gtkOgqHfSizELjYZTODY3jI5GcwgrZ0ZnXA+C0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136342; c=relaxed/simple;
	bh=ytR6yf2SyHa6bIc5ncjNOcjxB21gx3i48EiD6AmT76o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IgteHZQIXcrp7CnrNuPk4NNxPuvkuXOBQyh3ZG1Am3Dya1gxxHPMAsZ1YiN5Y49rCoKHQkYxr9ynJYy36yeMsq40GA8so1qK1ShXXOB0APl79cRmbzYcz1WhIRvO9xdx8NPO1waXa3dYnkPYGgKpMuIqrtdWp4MmF5jPfGa7nwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gQGikju5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B9PI/8Pg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIWYC014420;
	Wed, 17 Sep 2025 19:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pF2eY4Gltm75j9utnrjI+OtFdlruUnTM+YMpT/p1noA=; b=
	gQGikju5bkeCq0UYl+tX3Rm5bSha8vzmR8O0z1HBwXz1toczPMoMnUyNxc459mH/
	qh/FFS3j7PWJpLJ7VcYOXBwzWIa7KKWpvzo+nSx3BUxxiduTwtah2PCBc50cpsU6
	zzdgsAE5qpl2aSWzH+pKyhNVm4bf/SzIL6eRWATP7Lu+5+C2b6EQYNjBlyY/yMM7
	V9HyAgqZwhWKg/10tvEqerxoD5hoKVubgT0BwjLBtCVmtbgX4nCEuSvNKdMfgMlK
	RC7JbCaO0/9l7MgA22uLWK54r3s6yf2gJquPV17yFFn86J2HHcSTsdkP+/Awakeg
	invSY9gdxuQO7OilqPYivQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbt1q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIf5xt036751;
	Wed, 17 Sep 2025 19:11:29 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2e76fp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDpaXKdZEVS0GaKbF/s5DbX2t/CiC2aIEBqXDJgbKpmQNug7+e+AHHiEEIhCcTKtdJVH8p9Fvgh0W+UcEc+doMByl7xYaNRaF79Y2asAzHxF64IxjXcs3S5eMnupdoreHtyyQP7pbwa/4tIT1ieTRMAV5etQgCTre40TyIoUxPtquh81ku6tKMkSvniaTIRApRPTz958ijfffLS3WnSDjpdjWnfaVZfByA4POvxCVJyzvg88x8ItgUemf3dV7ex9wTPvtYyuT2xTSBdO33+68ZCSszxvGb7NL5HUGP/Nhq+hUZuBiuTu8wV7oP6rPxO+K1zq28RcBCjtt/jO4B5S0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF2eY4Gltm75j9utnrjI+OtFdlruUnTM+YMpT/p1noA=;
 b=HMttLy2mrLJcapM2ymjQpHmxC/1xj095s/A6KsnaDdenOAom9t82LO2YSXakpT73EvqeL6lHanNH1uCzqcKR8gyehJPo1hY8KOc+w5fxDMRrRwvLQE17c8aRKKj3CuxRULfPKNI/7mmTYBw33YxaKavO1wfnQbkGp+sPDb14mhoU0nKyq1RdLVU7Yg93CTTMHhGOm8/uNBOkTkUUx7knjy/qgS/ewwGdW3+PiiwMoZK9Gwkj4oYBM1uqBGPllQaqo7x8lve6cSttnv1URo/cbaki1PHItXoFTvdPMwsLKaEUzGr5Wus3LtHo9X8WDe19zsWxlOCf2BkZbsRHBENNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF2eY4Gltm75j9utnrjI+OtFdlruUnTM+YMpT/p1noA=;
 b=B9PI/8PgrH4TzB56oRiiaZwioZFvOu9uJTtHzCYEGVY52aC43kJe6ls+kALLJJbr+mNW5EBw94BHvQoGquzvc3BSmUT/80ysfYd4xLrn4eCS639ZnwpXGkSNNh7sf5F7i+SBHOL5Juc97KWOkzTQscTQ9lLa/qTvxriIRC5ES8c=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by LV8PR10MB7774.namprd10.prod.outlook.com (2603:10b6:408:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 19:11:24 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:24 +0000
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
Subject: [PATCH v4 01/14] mm/shmem: update shmem to use mmap_prepare
Date: Wed, 17 Sep 2025 20:11:03 +0100
Message-ID: <86029a4f59733826c8419e48f6ad4000932a6d08.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|LV8PR10MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbca183-4227-470c-2b8b-08ddf61dfe86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?52iC5q+vzCPEfxIT12GjpRo2oqRaxiRq4s3nUfPcMViluo5+REfhab/+tJeT?=
 =?us-ascii?Q?fh2r+dQKM1nGm9BdZxDcRaMmntlUHkHqHnRMhU94eEfTptz9ri4i4nkIuLik?=
 =?us-ascii?Q?AoTa76kAXBt+BvnQ3oh2ZipLt2QkklZsHnNE3cSNMETShcyRUDxiq98AWsdn?=
 =?us-ascii?Q?Ig2HBFEXxpy2ZHxbdi1itDCRHqtdruchW9wWCloKPoTHJMIxK/aCsZe3HC33?=
 =?us-ascii?Q?tX53R9QE8uqKU0XIgozC5ZVI5tUsoDmVTwNuWMPpfeTb7AYrM4puol8fUvcE?=
 =?us-ascii?Q?bGdtOKV+lQbErIf3NaD9I61Zh5QQMrHQN5lvvz3p15qN1l9LtFOaOUOTGJ0X?=
 =?us-ascii?Q?OZL+bu/c2w5c1XVCbRJ3EdqAK+Plwoc1w/fd6wPdA8et+yzIa53BWKBEKtk6?=
 =?us-ascii?Q?m5IDW27SFOcTWeZdlPi0oRmY4VFTsnDPG15zWLKSYS+B7sE99IK4U+PVgI+f?=
 =?us-ascii?Q?O6DuTmL9byTut+RwF6gMGhJRN1M9Kgn7SWH0izjKOkY49+/MDJjBPk7Pblfd?=
 =?us-ascii?Q?P3vfws2XvbJyCwYN+xudU4IKN2NF96Xkrk0sSGWNtWIusvUyi5aistf8LB2C?=
 =?us-ascii?Q?zoz4nTwc0a48rsiXq2kv/7vI88V8Ia6JDzU1DfwYXXwi4CjNyMIOmIbaLubL?=
 =?us-ascii?Q?lVT1GED55zKWp0ycEjB4CtMiShQgnbwhGGdaU/xQPSuvU56egrDrSCGVu+tm?=
 =?us-ascii?Q?mS6EZNEGuXzotJkE1Tmgo2uIcKvO68G3An+DxGff7ECestftl4chzsbMYL2U?=
 =?us-ascii?Q?N4Kg+wm4oozY65h0ml1SJYeq/ZV9AKqujLYL3nqvMR/ADGsHLSuoBu4GI1IM?=
 =?us-ascii?Q?GhalAJaXPg8uBXEzlQyAUmI3N+kWZy64vKnmc1TtUoS7HIb5M46cFWqPelMQ?=
 =?us-ascii?Q?iUk8xKj2+zpb6YPyTayZ3WSwJCabFttYYdk4BaYQgpjA/MYHF4QGLE/ovRw6?=
 =?us-ascii?Q?xyCAd77lrby5ZsrzRX4fexXRyBXEd+yBga7Rae3ecPfv1wXoLOhmzTlZsucd?=
 =?us-ascii?Q?SvCpBYmp63eYNUtv5NhYKgSa1Q93I9oksHuqnDoX83pHDXn+9W6XT8mfdkSA?=
 =?us-ascii?Q?Fs0xcSZe+4+lhGjfS4WP66V3rHH12FSjnpGIfbvQCPZ0kE45U5WQnJepoOkE?=
 =?us-ascii?Q?m/hmE2ECzT3uz3R0eaIw/h1Lye+xCOoOL6c9zuSoiRewSE/RX08UClKUWIIr?=
 =?us-ascii?Q?olJc9Sw/663hGvUYfwob9sSa2rFgiRvXVYGRCuiROl37bDqpgROrM2H7r2rt?=
 =?us-ascii?Q?+OGaXFq+kXuJjPac8kXzRenYY69i+6KkLmLjrQdWnDuwzzxr1jHTl3WUlhxW?=
 =?us-ascii?Q?Umez2RPZHPk63WrYs+K1JSdvkXJlkSfARdgAVDnaoDkbbt3zFWLfzJx6PTe/?=
 =?us-ascii?Q?oZYFfQOTARhc5KbiEFjQcnJVscSz1gH659+gBcFlDI0sbB2WGtCLNgxq8kIp?=
 =?us-ascii?Q?hLLARLmc5EQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DvhsD9l26t6Og2y+ryUflNsgMAol/PBpuRkpGrjyI/ZmNV+Arx8AEMTFyE5U?=
 =?us-ascii?Q?CB9vTAoTTRsOygnhv8LEPweN6BQMGvipxY5eHUsyuxLJCX4fmYnicQkwv51Y?=
 =?us-ascii?Q?E8IOpXzqAIVpNcb0ufF8T8+28Ttf8hkfQI5AIuu4AoAe+JzgLeu2mZGO3ISv?=
 =?us-ascii?Q?vBBjdaCThX+NpMJ1280oJzhmk8nk3UBASH5fmEMlQsaGSEqddybH8d0zmA7H?=
 =?us-ascii?Q?HSjklxpbRGoBoa+cfzWD2ZqFfDE5YrQoCKaQRXJpJgXrrRGI5D8fgdT/38oO?=
 =?us-ascii?Q?2EYdpvkQWowREMy5wuT5FsOOF98hLlnXOyYAwRjm0cuNlQRHdfMIhTe8w9ng?=
 =?us-ascii?Q?WTljD3XACjShoZOK80SuJgTRjAbDh9AjzPXoPwbZZkSPfkj+OaGYNsKGdzE7?=
 =?us-ascii?Q?YarzG5gOxOHkXMlO9fLy+mLP7BBLGR/KZ4gnGmD5Nid6E+XQ/+ZBsRp33HY3?=
 =?us-ascii?Q?bt/fyXHRcik45Qwec7z6Ajeid+Nn8PLcdLHSRFGwrhoMeOrBk+ZG9kB2EVjX?=
 =?us-ascii?Q?PQ4D2Fx+8bF/H/AbG5pRY1a23tUV1Y3dl9w9xWu1t+sc7qjs1min+kHI87+d?=
 =?us-ascii?Q?igezvw3WsWTuMcsfhzNfx+Y6kYWUwy1ji12LuGoteqK/VZeRJBOH/A0d0pn6?=
 =?us-ascii?Q?yVoGTFCEaIxMM/sBnh5Rx/NwMubWv1RlS3iSSojobVIYQ+3ys4HJhOyAFDad?=
 =?us-ascii?Q?s2fu+MRA1TiW+3mSM1299UNG9+29R9xgjwwIvp5IXcnduGuW/ZZnrOgStNaZ?=
 =?us-ascii?Q?W2ptIy4+FFYSGHl8A5kt5ViQ7lW0M++oV0b88AuYjS32MYTbhqlll+7QlLQ5?=
 =?us-ascii?Q?add24DtkQKqhRs4WYglNkUe/UnRMA2sRN6pmNp9sHHDfYLpfBUBJTnLrJLuU?=
 =?us-ascii?Q?PShSJc0EgiHS8664Ge1niOh7gCqUmZl8bZQTGoNZWJXHMsPtDxzGZrareQpb?=
 =?us-ascii?Q?q5gvvdhXTbKtMiFXLlwJGSENwabFuV1WeejlxGetgt0cyRiUjOvstujZJ6x9?=
 =?us-ascii?Q?RQOkbacPxY6fwZOMjF58/jdsYvEtXn2FU+jZtLoSZQBiebgsn9cyy4OVJlKa?=
 =?us-ascii?Q?QJ6Wr2k3PCA0H7tmV8u4RssalfWo3wC3q+CmhU6g9hmhodF61BOPtPYwzXRP?=
 =?us-ascii?Q?f0v1BA+io63aOnIIAbkc9QUVYAtwj3rwKIYthBp04y0N0Mfwv2FhFMrpPiEc?=
 =?us-ascii?Q?ZanOXP9FDdALw31qBNEU2R7z30C/kRNeeHyQvsvq6viBefayF7KgKISWcfH9?=
 =?us-ascii?Q?GwPMKn3j3nlZz07EwiC/DQh9oYT5/gIV/SPBZkB28I5Rh2pV/dDMd18sqKSP?=
 =?us-ascii?Q?WFEXjYR5CSuYDUiVVCbLuCY1eGVuQDbrXCfYULq9N7wXLDk/Id98TEAFxvSi?=
 =?us-ascii?Q?FtR+TavIJHhcW1/VcX5DMaCk7yKfvUnPKQLZ/I6kXpmFsjbTOt3YJ/Sw5zSQ?=
 =?us-ascii?Q?LC2QqtyArJohy+Ape0zS8IWJnVUva+hiGSB6zA7FcSNU9KK8Zn2WaOq0N2Rc?=
 =?us-ascii?Q?GuHjPsLkqCx/Mq00b7vezY+hYcgF0JeTtVA09gRdLupkHDYrEeICDWu97r0p?=
 =?us-ascii?Q?kqdNlcIF2a+M8vSRdmLwwfJPPgI81HvnYiHnOgSLWjbUWhIA2FQw2gq36G0L?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9ZoLRbCgba+SxrqaDB6ykuDUpK5K52hyksmettEcNGE0VyfnJmUU8LrfKgQSLlXhaVhOA6Cy7Jxg1ilbN1Zxir+23bCKOTRw1MJsliM4xMxHptNFKZ971xiMU7bbKcM9lFmWFAniagSl6UK5xtZQ7kjF2IVZIiJsfy5BPGB5weYMveEeuZFMetUSbfjaJ4/Obk+bs1xhUtq6LuR/IrNmbLcrVle3TCsxKalRLVuwwtU5UP1VVuk37gU509HJv1iEVJTzdQvUqigsF7FKuENhhf7E+/YHGKrJBLvOrqbyZpdj2p+MlHhhRySVzrYq9JWyHWBY0YQI+hGHKe1NcFgOtel4ha3E+Ka63G6ey+BmkE4mDd2qX292aySAKYi2qbnDsFhT20dtZkZNbs/okxSnPJGl4tgqCvWu8bEELsVQIzCaNq1NNwq3A1IiXTv29MAHPV/XWtDlIBSJnt2nld2tZnxwX3MDmdcPUS0yX+29MICDp7sBvs6x830Z6btZ5yKYUczDz1Q5PcgF4fwP426K8MkJeN42l1tX2XEwguu8e6dZweUi2SysjulakBJM5XQ65yKmfKo4IO2Au8M3vYSC9Mn9HWEcTdCFGHjf7qAWRb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbca183-4227-470c-2b8b-08ddf61dfe86
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:24.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCBuJVFn0lRpqNIfvmCN7HfLqJwDQZ7L7XDeu///hQZU+5U39nLwfGT24/GhGHcqfHq5wkhzGHIpmotqd6tDl4w1x5TjOiCSqomlQy/3OLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/H671OResUYu
 bHhHLYKqGTfsXZaiIkQLayVtc6zOSRPvwBRn12AiyzsOppclp5rHeSeU1QR8UOij8m9SkP+MIFO
 IIwKhuhoG4mPjAs90vzsH6R4TcJSo/pagjVOy8qIdqtmgSn0bUMv2J80KKrCCNZ7jxJvsno+BNv
 2lkZGsNYQrsAW0vfmS8EJ6dfsg8cnhrSkSHcW8wbbnyPASqB13fQ7rtxhdPAZkdnVVMLZXyroLk
 UMtiTMPWxaw+UoWlUUhCKF3ZX9WyTfiQe9o3ws0XJ43TOEZy67IlBNtXrcRdrVP6w4hq7g2xFS1
 zBb92s/M7J0Xu9nGKrHV+r1tde+PytmhI20Ik6NZ3ga1rSGT/8NZPH2nO3g2/BFxA537p31SAzZ
 sh58SdFkw7jprABuJBDioqZeamq6cQ==
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cb07e3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=SRrdq9N9AAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=prdUi6YERRC1zlzC8DUA:9 cc=ntf awl=host:12084
X-Proofpoint-GUID: DpfuqrhSl1RETCC_OIcvTeb-ojwLfBNE
X-Proofpoint-ORIG-GUID: DpfuqrhSl1RETCC_OIcvTeb-ojwLfBNE

This simply assigns the vm_ops so is easily updated - do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 mm/shmem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 87005c086d5a..df02a2e0ebbb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2938,16 +2938,17 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 	return retval;
 }
 
-static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int shmem_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)
-		vma->vm_ops = &shmem_vm_ops;
+		desc->vm_ops = &shmem_vm_ops;
 	else
-		vma->vm_ops = &shmem_anon_vm_ops;
+		desc->vm_ops = &shmem_anon_vm_ops;
 	return 0;
 }
 
@@ -5217,7 +5218,7 @@ static const struct address_space_operations shmem_aops = {
 };
 
 static const struct file_operations shmem_file_operations = {
-	.mmap		= shmem_mmap,
+	.mmap_prepare	= shmem_mmap_prepare,
 	.open		= shmem_file_open,
 	.get_unmapped_area = shmem_get_unmapped_area,
 #ifdef CONFIG_TMPFS
-- 
2.51.0


