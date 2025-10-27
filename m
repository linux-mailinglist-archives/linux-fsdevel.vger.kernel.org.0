Return-Path: <linux-fsdevel+bounces-65740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D7C0F614
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAC7534F7EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B230314D0C;
	Mon, 27 Oct 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TGcYMb/8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FDMl5K2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9DF313E21;
	Mon, 27 Oct 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583169; cv=fail; b=TMU3jaDxJcgYme+ohMc6pFE3ZDP15TVvqNH+bohUpp3F2/AcUZSae5atP4ILIl+/ILIcoF9vx+SNmfJH5aRRstqloZIPtFnCvqofU0l3+Yg+/prlIBv7VaR7n/KgjXzET5guS0hdrfX0TATr2eKnqxFsU85JaUjkwhUJeQDuSTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583169; c=relaxed/simple;
	bh=ZPw82iiOiBtXLlCtbRtiX3c0nDd50+JH+kOXVu4lLAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJj4hrprONOt1/pIAl6WB8jKDoG8sfTaVT3au+lwsIHoWfFfE9sQeDddt6GhRorTEjyyT8LtkhxDUwB5WQuMTo2f4piB+9th5e+b+5E8RixOfWgI62VbZCJzUDRoOJQymTzSmTltPIfRR9ZgGZLh5lqt6tNTPxKHq2I0nP8dYHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TGcYMb/8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FDMl5K2O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDYDTq025026;
	Mon, 27 Oct 2025 16:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NhwBzD+kvdB3ndaCmg
	yXp7TN2pOylbM7kDjOuEsfP9E=; b=TGcYMb/8RBGa+clseYfbIhNSr5l3e7mzsL
	xyg+lDdXoV8CG913IZiu9rYXYBtAjKVk2MyWrlCLKvPrnUZIO6l1kmsAEuPSdljR
	+nd2+p0aqGsnpcCDDguifN37XZWqw6nHwWnkHW8mfLcUaqVdFUCzGE4AJ0QoUWqo
	BRwFOY3ryAJURUiCiOHmDEnJRW5COK6CS2n8+5Dh4OIZrdsfbw7026RQKmtwCQda
	5i/fLjoY+QIdT2aJXdVepji9E+51nMOz4jyts3Onc7Rq2z2uBudfc9ouFfoM5CEL
	J13inN2CMkPK2djb9EhTiaXBpbhUNApXQILrFkbLq0baZl6qkzxA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a2357hck0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 16:38:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RGFPkW037515;
	Mon, 27 Oct 2025 16:38:31 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n071f1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 16:38:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWvzUCHGpPal7bL2LxT+pMgrY7bEpu8+gpN8zPjqlZYdnKieGt6y/PFAhppXBHWCWLrh5GRoqMuWudj18dfnkt3kBX6KghoC+tKyiF8EkFB6JyOC8rZkvcplVCpY17+Xl1fmSUI4+qjjvazP7GF2iQNzDOcg+s6qL2fwYNEUX20dz/rTil+KzwcgR5ItWAm6XxwBiNarjqGOf9iAj9pBjRohFilazJzUYWQXAN5bSoFECcT5510K0spRkvmYRpSzUblc5Ec/UwXPmML2/svMagQO9bAHk3u+3wr3MbX4qrXJx2vWHS7kwCVcxeOcIDTFPtFvFgcIa41vu5MdCqaNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhwBzD+kvdB3ndaCmgyXp7TN2pOylbM7kDjOuEsfP9E=;
 b=ACxyLv0QFYymBTq8qsYaU8o3Y1c4KwKulzLcHsqAfFUFB9Q4TedDiKDhOJhikWdtcM5XRhJFDHn2Tvt9eQbybOJ1Gbyz7udTcx4tEKEGKL9JUjmpzADiJf+l6012UAxOqBT8eLxRhQY2WTnZvQvFtpJnsaYd4zxACfK9T9ZR3Q5cDiGBVImksODbKPxyo8IW3u+JQOFVxTjcctfjQcvwsMWEEks0h4w5M8eEaJShDwGDJH5aJ5y5G+O0esQNflwrrL90NY9IHruSUStJWD2sc2yPfXeFEVlUy3dMI1uzFp41aLvq/W3URf59r0BQu4z4sYnlx+7SSaqAgjjtZulKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhwBzD+kvdB3ndaCmgyXp7TN2pOylbM7kDjOuEsfP9E=;
 b=FDMl5K2OVpoV0XIXuYO3hpu5krGwFwYLuNn57xkAPUjcDpaIL4ZffgJAjakAgIZzeh3M3V92NcKJ44NDHcKfJrG8VJDu1Cr2M7gAz1ICTPMmTgAVXkeaOnIMAQ+Eh+hksZQH304ZrWE3sdHwORXCKlyx4wEa5bw1kV7UQKOxtQ8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPFA7DBF91DC.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 16:38:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 16:38:07 +0000
Date: Mon, 27 Oct 2025 16:38:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Gregory Price <gourry@gourry.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Leon Romanovsky <leon@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
Message-ID: <a813aa51-cc5c-4375-9146-31699b4be4ca@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
 <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
 <20251027161146.GG760669@ziepe.ca>
 <27a5ea4e-155c-40d1-87d7-e27e98b4871d@lucifer.local>
 <dac763e0-3912-439d-a9c3-6e54bf3329c6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dac763e0-3912-439d-a9c3-6e54bf3329c6@redhat.com>
X-ClientProxiedBy: LO4P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPFA7DBF91DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2f5c26-bef9-4bbb-d95f-08de15773590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VDRJ6YeixEiO8BHmWRMjwYytDlsyfyfJJ1sSFmuU6YIgAxB2sXElNZSJ8oGJ?=
 =?us-ascii?Q?SeFTH357SsIEOn5qSaVzRnE2kfl4a/cicumezvMzbdyKqdnUcfzXIMzS0tZW?=
 =?us-ascii?Q?HttHr0Koq59OzaZgkxkHHAtx7/WRy4uFooosryUxfWN5EFmHUXn3AH7ZXRFM?=
 =?us-ascii?Q?XZAy8IC1Eoyu6RxE/kkeGMMRJTmbBPy0neDymX0cMo3RN1ZSckpCuqsCnRYk?=
 =?us-ascii?Q?EFLIcgWs1X/HUUz3zXBOpwwAjrYL2QC+jBBrGTh3k2m3DOJnpuJpgxgcVRGJ?=
 =?us-ascii?Q?iBZwSYpEspHka09MKGUCUUR8RbpfKxCh/BQsuCYvGhUqeCeHsgMD4588SnDa?=
 =?us-ascii?Q?W9xHjXHSzbTs3qLI+ltXew7a+uT3SaAJ26FYdULFXlKzDnXdf8dJbCv6LW2g?=
 =?us-ascii?Q?LmcTTuoPjaV6qi0lfr20nXEbPqViLAyiazjyQoTyu54GIZI/r2v9972VdnzS?=
 =?us-ascii?Q?V8EZzSq3a8BC7UBOAxPNMo4uzbpPdEmmQxaMTTZgoDFoJBzUrbB9CffAXKPr?=
 =?us-ascii?Q?lPR8MdVGwz9heUd5BsFOJ6saS1PhAa/5aW0rpqTXnHPDNcyWg5PjZ53vSAGj?=
 =?us-ascii?Q?pnKXcIBs+/zkENonF6EPphLzRhngdkxozpfY3xox3eetK+DEYUq9+4/QxW8b?=
 =?us-ascii?Q?9jJITqFXAxZD5WrFo/4s89k2AEfvavH6vpLcMIzKZZwOqpwZpt2vrEXO7sJu?=
 =?us-ascii?Q?I4RhU56NLiDehuV0BocPyOvCSuturY8TBxkwXRE7cIB5JV2CXcHQvvsKhb1q?=
 =?us-ascii?Q?rvFbDJTJDajaG5JJAZS1tBDiQPGWqZBasX4sYygUaWv3lKaTa+AXh7gAW2M5?=
 =?us-ascii?Q?TD6vhYBUPt/D7Qp9elH1foULox6Ys6+FW1vAq3brASUWw9QPNyx9M6JgUQLr?=
 =?us-ascii?Q?GM0ELJucVp2wn8ARM8TkwtfFYcTe6FovnuNIqLEbCT6U8rfQ0c2zOeDVajva?=
 =?us-ascii?Q?mrFuReUfnZB2IsxBvLt8kdM0PvtMrLxNHV5i63XVLcn44Iedq9oE5CBWihVB?=
 =?us-ascii?Q?ZKMW8dgoE+tn9rVbynOpMpjij84+TCylMfwciCfzdMtjbg90vouJYzQIjMgJ?=
 =?us-ascii?Q?gOQhqv/A1ZQsyjFUygQvT3QnKG/JmVcVG4y9CXWHyjjowKbZx0r4kP7jNoKO?=
 =?us-ascii?Q?TzIeGcd0TLchSvqdax1GIbu3J70T3B7ydku5/lyXwqWHrfE1DnfAJCI0oFTc?=
 =?us-ascii?Q?wL5LVqCL8VXrHmNOIFWUckVdMUSjfO/CUgR0DXmdLMYvJUZVrAlFeKxhv/fH?=
 =?us-ascii?Q?GHE1jv8fVXfg3i+LkWlQjsEyONaN4/WpOfegoTEGJBkoRU17IVuH4L1GJwkq?=
 =?us-ascii?Q?Mtx1GaM4De5tMJwwmD2PN4zp51ZZQuORoZJDfOxVZehWr271l5OXCO8UlQB5?=
 =?us-ascii?Q?h4gQFMx1iqQ6x64cUCAdTWAmtway6e6KvNT0nCMqfY38w96XVFipRgIgFtgZ?=
 =?us-ascii?Q?jrKB7Mx9erx83UIknD90/NqezkNE+QNZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7kjAXDFfTwtYqEN3QZrC6lSsQ9hgEY+JxAGSqhrDsu3d4XzI9jaEGCLAKrfi?=
 =?us-ascii?Q?yBLfAiulXnpHph11jKCpTu/BJm4sWwvJ5WzYdLB6DYDfcny/sOY1QN+iUABv?=
 =?us-ascii?Q?sGu2HCbvXXzpNUygCCWDOy+nM0qQky8dGCHfkb+vQFJ9/K+cUte8Jr6dX0V6?=
 =?us-ascii?Q?lM4dcSjdGC2b453vSo2eFB3j0tMVWgyV0sTRAWkI6qF0nC7UFRxF/LeQjiiK?=
 =?us-ascii?Q?mCBEGz6IHeyJTfZmmygt+7CnmJff28JdHy0fuiOPpAuKJqKMQOpECQoe9WiA?=
 =?us-ascii?Q?YN7rftIOBRGJPhhttbSC+no8zDdAhJgFjoWV3CQdadfqrmykn8St2p3w6/pi?=
 =?us-ascii?Q?oZmrEWPuuDC49RZhw1Z8zy+xZTSAUJ6+Agksh3eR6bG8zA3mj7OpzrUcjCY8?=
 =?us-ascii?Q?tE1wbZNkwL9bofDTZnb099CaLCkKpr80iOl/HUpxxivQgZholSYAfQJcw0zX?=
 =?us-ascii?Q?p2DZRtBDGlInT9OsEtEvIWi6Rm2ljgXeZVzwzAPMhutab5Lr/TTRAx/wfe6U?=
 =?us-ascii?Q?nelsFL2xQxzFVjih78jcRqdO7PPp2sGglDKMX4zpK3QEKdZGzIc5SuhcaToV?=
 =?us-ascii?Q?gmVLUeUnf0Nakq9SEmHtNpsiVZqcbitJhLD06CY5j4GMMK3dKUUksc/uZAD0?=
 =?us-ascii?Q?Sl7dOO/78YFzWgNPkK4PV/P5fjP0NEcCEiE2FsDzTmxDvhQ6kTTNt1U6FN3c?=
 =?us-ascii?Q?jEDz3nrs5u6A1szitc6gWS0Fj0ZTGULX94eVaXApgbm/+RuEnvYlpJJdVDK0?=
 =?us-ascii?Q?CQZcYYX5mzFmf7CfO60hmrSRqN8vzQ5oHaf6+u6CNPp6I8L5Fcb8rfpT7CnG?=
 =?us-ascii?Q?hfJ6HfHXERyQowG2zLngcdfIGh4NdeWuvTbaIuzJeABYJbGdpquoxzo3ct4o?=
 =?us-ascii?Q?cbjxoTyCpdFpELIVfC2OAmhCgimhJArTnY+0oYfQjm+tPp89YVMIV8TFssLt?=
 =?us-ascii?Q?slQyCypC9VaQOlV+IaC9ew4ja35J54zseXkYwvcIL9X0TocY6un1F7rbIYdN?=
 =?us-ascii?Q?Cz+e+ftWpe8nDYlxCbypyuQP8L1VjzdrUctitan0DPurKKOAKshERf9oOvZi?=
 =?us-ascii?Q?IJpk3hB+jRVFQt1mgkZc9XibhOBFGTrvbcG/NTXb/kzLYPHJ05aGX+HdeAz6?=
 =?us-ascii?Q?nTRUnsHu43Oa7TF9rh+Ky1GJdP2JfTpIqJ1nwwp4rSfM6zaUPTsRUE8/9CLC?=
 =?us-ascii?Q?s4VGyLuGhEh8lZKIaDDlCuFA/YJ1xBMlBwuI580DUpEJ/wvUWU5uNBcuUQw3?=
 =?us-ascii?Q?jmvRJGuF+NTbfd+YIJ3/nK2xCzj001aD6TFpEeZsK0oAcdn+p8U/ODaqimFp?=
 =?us-ascii?Q?nOCkmkWuicuYU8XefDICp0mVF7fS6awMkTrdhLREhQq3h5T5CS1d41pygRFt?=
 =?us-ascii?Q?14hYT30c2+wDu1zQE4HbAfoBXqLXaUZ14QsxR8F40sPwUCgiGFLKwKaxGNe6?=
 =?us-ascii?Q?kmoiQnmDCl++NNeqzvXeeuzkRb907Rx2tAB6CXJV0qVeMbAYhSKIl2y0Lj9C?=
 =?us-ascii?Q?D7UPcZ8gujyd86i3nagsMz8ffef8Hq41KkIGbnCkcQo5e7uc3SphOwusLt8q?=
 =?us-ascii?Q?xOtFzYbbQLJo9mDuYQJZQHXaxhLlJMN1KZZO98ejgpIKfQG8ricS8ANeO5fY?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xr7G7wBy99CNGPzyz3LYghngRlCxcjo+eVraur0UmfOsTZ8TmsXTVkL/Fs42XeM/ezhSvEoGERHDlNXLWLXGJ3OyUImB4Z3X4OBEF/dItqj6hg2Yz4FLixY3q00v51rkJlCRzt8xDzZ8wCp0F/svmFZNa7Q3K28KwfdG2+Txzj6kKb7pOBmh1niwT1ffHKlkfSQTY55T5q/YjDZO3683wmVLWD5HBnw0IfyWVbNx91Uzp1ijLqx4JY9jMAKccUoC7AX2qmIXVhCZSldPBOoGLsKQqie0SbRZ1j7LH5LgQeguqtjx6MmQkdIjcftiDgyeVmIXtDBJcbeoSxFSheTlL7bVqYjCnDPaaQIGa3Yq1vJ7NRgvebk/BaDcBf9UWzJb+SL5+eLRmS6EscERRjNwMC5dd1zaSGb8y58al9OBr6Fua89z4vNSt6UyMgLzV8fcQDnZi2mUS8fNntnGCTK+F1auaCPm4aJBcTjHHjl8iT6Ug9qvhT0IM6RDR2ZZwzSsKQXvo//zG+dU3MsNCY8J+ljmL7eC7j0VxQAXPg0Ut4nNBb85QsISAdg7rtnv3bTtxUjhgDTFVdjR/Pg3PDrrk6m9pyn0l3aYnNHOBRVA0Oc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2f5c26-bef9-4bbb-d95f-08de15773590
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:38:07.7880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmgetgtzOTlidogVY37lNdtVOnrwHciWq1vnLB8YGGUXyEo95fUWdyAno21OYpmoN95KsWO5gDvZKD7jOJzm85lv36UesqS/9P/yqaMOEVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA7DBF91DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270155
X-Authority-Analysis: v=2.4 cv=Bt2QAIX5 c=1 sm=1 tr=0 ts=68ffa008 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=syEy2my4Z5X9YVObMbUA:9 a=CjuIK1q_8ugA:10 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: iBZJ2RaZJMSP0eW7_fdvL-PHssMEoys1
X-Proofpoint-ORIG-GUID: iBZJ2RaZJMSP0eW7_fdvL-PHssMEoys1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1NCBTYWx0ZWRfX1JwgRMwBIFMv
 2A63hkyvJXgKTrzQOJ6ipAsFfrjAoC99ECJsYDjMj51Saiv436iCp/2NBquLbR/MrspPFOM9A1t
 FBk6PAQU4tIe63+jtAYIFn+fb7BAwQlTZLzpBDcy+uVYMS04zk4eXsQJJh/0RpXniuPcH1aDyEp
 e37WwSE7T9TzaH0YGUQjeRo0ZIKWTm+eGBO68nwEm5XO5v/lxAeir3uag+9OrW5d2i+JhjHslSJ
 ZmTanrIwqEdd4EnTM3ar7GAiRDCWUD4/T8CWUtxnuIFb62/q7+UjYpRltIGtg81TiMf4h/4k+E/
 +ZKgFei/VuXSP0w/t6vfa+Q7Wtzh8CWKDnWhn3tZvnVuRBa1YrHl48/p82tnsdT3ClUYXaG8IEt
 yeKZrj4jojW7I9iHHL4a3Kd9lRESHw==

On Mon, Oct 27, 2025 at 05:31:54PM +0100, David Hildenbrand wrote:
> >
> > I don't love the union.
> >
> > How would we determine what type it is, we'd have to have some
> > generic_leaf_entry_t type or something to contain the swap type field and then
> > cast and... is it worth it?
> >
> > Intent of non-present was to refer to not-swap swapentry. It's already a
> > convention that exists, e.g. is_pmd_non_present_folio_entry().
>
> Just noting that this was a recent addition (still not upstream) that
> essentially says "there is a folio here, but it's not in an ordinary present
> page table entry.
>
> So we could change that to something better.

Yeah but leaf_entry_t encapsulates BOTH swap and non-swap entries.

So that's nice.

What do you propose calling non-swap leaf entries? It starts spiralling down a
bit there.

And it's really common to have logic asserting it's actually a swap entry
vs. not etc.

I think we need to separate out what's practical for this series and what's
ideal going forwards.

Right now it's a complete mess, I don't want this to turn into a talking shop
that bogs things down so we don't move forward because it doesn't address
everything all at once.

What we have here already improves things dramatically IMO.

So what I propose is:

1. we keep the non-present terminology as a better way of referring to non-swap
   entries.

2. When I come to do the leaf_entry_t series, we can generalise and no longer
   differentiate between swap + non-swap.

We can then resume the discussion re: type there.

>
> --
> Cheers
>
> David / dhildenb
>

THanks, Lorenzo

