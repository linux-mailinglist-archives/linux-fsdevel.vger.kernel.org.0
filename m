Return-Path: <linux-fsdevel+bounces-55419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A14AB0A10A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 12:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DCA17BD1F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8302BE047;
	Fri, 18 Jul 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="of3uvtYZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CkRijSbj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33E1B21BD;
	Fri, 18 Jul 2025 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835692; cv=fail; b=mlkOjCkT5q48nNLf+2OmCIdvrtJmHkJ6jiyHYb2VZZ+223VD2dIXhw7b7N8OeDNpET9FaVLgT6Nac8fDSlmRc9PBS7668e5J8sNuoPYAHhskVpUmJKXJLizksbjlAIhcY6tj5WCeEc6Vz70wPGhaGcOie+ClkiwmePbNMgkp6H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835692; c=relaxed/simple;
	bh=bwXcW/thTiG3JX7MT1dV9jjpzO932RIl/NjAnfgWrM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UECphR+ioaim9ggs4TuO2bvnXH88TjW8YOyS8eTxGlXABvOtRqU/6s9EPtLISzViEoK+81EWcmGAlbpvZSUdyKMdZinjy4BiOkpewnCdyZwSEIUq+G0BUpGEbm21IiH09Etc+6TlLnk1nvDHXzY2bLub/HnBLxM7+fmK6Mg+eDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=of3uvtYZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CkRijSbj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8fjeD032170;
	Fri, 18 Jul 2025 10:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bwXcW/thTiG3JX7MT1
	dV9jjpzO932RIl/NjAnfgWrM0=; b=of3uvtYZxwhklTxnFX9IAcAI4AuGG7Q4nX
	HpwNnXgUYlOM+qOO6BFMjpdd7rX7tkwmAhzyo+Nt6Oy2tZlcGOhemL0cvgfPNN9u
	t5qAq4SaGh4XL2VDxiAwgi6EvHK4N7t+zx/9yT3k+lGU/tTaJIvzBlozbnoxKhvR
	DggU1nWI4I7A0pmHcUFaw+blwr9+u4SX6QK2SzkblaPU2olrOvDD7d/yJQAMDjEN
	qfswAjGME1Z57B/4N8spupOaK4elFEz4yxQmkqLhYVKsrlbujrUabwJCJwzW+mAX
	29VxcGmfYxoKvWy1gfdIqRv/zOTU2RmZ2WIPQQxuXhEBBUqLE7kw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqwms8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 10:47:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IAAXOu023936;
	Fri, 18 Jul 2025 10:47:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dvc7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 10:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2mJbB+POgajZDttIEPQ4XhdnF/z5UNhJqQULdIHg5UaifTD9ApDRhYCCBxiJDQ253ysfwHItvyTEqsTjfvew4iu7VSgEPRxHmUZTG+7iLohg3Lo00iY7jc/8WX8Sqom1XFMp3iSh70DmWL/foE9ENttYCQU4tqr7pPLtUm2CtizsJyD/ic9KbvbfwwIWOIx5hPRZsVVKIGVvcMrbiR3KjIJr7ieJnDMyua1w+SNOGUBrSor9sj4AzWKgPMa6HFkOikTf2MQbWEGdw4B4yHOzrCaMSR+R57nQS+8LRsvqO9eHxgsgFryfdECLu/ikJ/X9lA2BxXfJRCJBz4m+Yjq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwXcW/thTiG3JX7MT1dV9jjpzO932RIl/NjAnfgWrM0=;
 b=anoI7pkUoE+2OG/3GUpgl1fmuhPy+usXQmUUAbpF9liAAa+r9wXAhukSfRyBEN8bB73MioJjGyfhNtIvWZQuATeaRLm9m+neOS1KbO9hBYkCpWPpIL/qKaw+MpuDzww4xlFxi/Me3mvUPRsh68fOR3UIBwrl3lhp4vn72/m2sMGQWF/jZ4yNMWXKtE0VDrK/PhEntJy9HqPYY/noi6vJeirDQ5Oyyv/laCqbwAIkXSIqEolxeVzpUm+DgN2yJ1ZQDVzcjFL6sv3pjOLa846LE8Vd7YXXDwZi7MK2547xlO1VjwL3BuFQCyyJw0gb1M/1A3GtgEw5HZ8BqUKAWDq9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwXcW/thTiG3JX7MT1dV9jjpzO932RIl/NjAnfgWrM0=;
 b=CkRijSbj93g0NCzXxvFZbK49FYrgyVvv0rvmj02KjepMXzMHTC6x0oy8Y9y/8xwxhH/Y6xAJqpWOMfhQkoe+VWp8AgqqKNbUOlC8rP1kLVpVpd/k2hGHxG2qd/G3YQrjmh0sH9c+rsJo76jsPUY9aertbnkstoerQfHx7d6J+R4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 10:47:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 10:47:29 +0000
Date: Fri, 18 Jul 2025 11:47:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 8/9] mm: introduce and use vm_normal_page_pud()
Message-ID: <15adb09d-4cdb-435d-927d-0c648d8239dc@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-9-david@redhat.com>
 <4750f39e-279b-4806-9eee-73f9fcc58187@lucifer.local>
 <fdc7f162-e027-493c-bfa1-3e3905930c24@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc7f162-e027-493c-bfa1-3e3905930c24@redhat.com>
X-ClientProxiedBy: LO4P123CA0199.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c4106b-1410-4103-3908-08ddc5e87de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0x3nFuKLmexe1Jzqa6gy1C2nKFsq5UsJ2umOoIRqGKvThL2bVZQMYbkpNhxW?=
 =?us-ascii?Q?DpuPAv2D6K+f54pFmv1fHeEowfty+MASIBX8ROyxqkxmEZXKHiF1m0yHJjhF?=
 =?us-ascii?Q?4vSkDlCoQY/z9JaTJL+5db1vG0S/A8TobBB4gKrpHoE+KVKlrtdgKQgKF1TW?=
 =?us-ascii?Q?klXOhFUT2G0hrGlT6USyhBmcVZZ53Jn+1hwBXrHeGNmbSo4FhD+yQz0Jh/Zm?=
 =?us-ascii?Q?8eatlI07WYzrfwOujjnds1DRZvBApn+/cNVHX4lXVGopBxEddbTOLM3ZJdLV?=
 =?us-ascii?Q?IFJMhDDLkhjd/yZMe1qL1XgeJDUIFgqamnHi7xjCboKnDkvYd+MezHBMm1CN?=
 =?us-ascii?Q?vLkTUvgppTa6WEC0d23jIeRrPy+vbzBaqxFuDTvLxsqGIs5923JYmPgWYJ1j?=
 =?us-ascii?Q?5NLgnC+rghEkewHp3hctn2WhnQMoz89EOAhVcsCPPQ/bokonkB28DTA9Yq61?=
 =?us-ascii?Q?hTjcp670tqHPZBbJLEYn4TOiGCGvW5Huw+2f0pPhrtX6WVtWP6PB02OzRy6V?=
 =?us-ascii?Q?L+gogLlXhhDdjKKLhm6+e2GSmD1DpZa/iGZwMORzWQJmOa5AkvJjrENg/GzR?=
 =?us-ascii?Q?X5Pz1EapwkoUcALT2LfPe0S2yWqAwH/fTwzbE7sgZG48+9GfoVoE+sg2e7eL?=
 =?us-ascii?Q?iimNBt+7xfJjDg+NRUzdipNVJ5u23qSukjY+p1QlJIgtRlp1ica4uQDj7tcv?=
 =?us-ascii?Q?FMKg395R13TFKMWuI/Wnh/EPKKRIHgZ7nIfeivLg99269DVXDyKXOdsFB+y9?=
 =?us-ascii?Q?O3ZYkgOGWV34Cc4nZ4ZSOcqDg9TnnwkaVrJePxUDmDkPvfZv0gtqGTSOqes8?=
 =?us-ascii?Q?IwZ3fsaYCDCVuGJadX0hKCVCcSNfUjAvQqMaTa/qYPmgZl/ZUOT/MzhnsVZt?=
 =?us-ascii?Q?4Gu6vN7haO+maMd0CGBXJQ/vtUqCiTYgFKUA83IDeCslr4a3WdzHNTTfD/IT?=
 =?us-ascii?Q?6omLXgfg1E3kRK5gOGEQlyheTgEtMCzRpaIgx439m9bukaUEWlkor0XQDm5S?=
 =?us-ascii?Q?AaxgzTLR3Ry26krfG9rH53RWL3e+wZKf1AM6iP8H3Jx3Wx8M65ARYmRMhR7t?=
 =?us-ascii?Q?LnvT79xoA7b4URmyvHSDbFnbb0v4u6OvUz7j6hCM2XhcNtmIxBvWkAOjfZv+?=
 =?us-ascii?Q?c54k9LTbe1AXUb0FHPguqrfsVrsa1E4ogc4AN45ZZkZXdnZ0FywyIH/6YgL6?=
 =?us-ascii?Q?JOxt67JNj8Rpd43C02N1qISF3cpjSZFOnXgdqV3fRk4zjy3fXw4HwNQ6+Jtt?=
 =?us-ascii?Q?P5YOMMBJDXroAchL7lHi6s60aXvZEZC3eqcxVlPSmveknW8fvSettNX9YTFg?=
 =?us-ascii?Q?dtOzK+YXNI9kNxvTAJmkYE9hTfMrlhf2yzqIHPDkyoRgwEDmAhQ99wfrKtU7?=
 =?us-ascii?Q?PNevtKIcied2E+7LAfSJZz72Wk/uWHSzY69BUFLNmTwA6QQFnz8+mKCJCLTD?=
 =?us-ascii?Q?svX74LmVdh4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aueuc3JxSmyZJw4Q3KTTy4PyzgiwUI1fLkEAaRnqGOTXbnH3gCHSMZ3rhtQ9?=
 =?us-ascii?Q?h7JuLnVSZCfPuNgJOL4w54kT1qzQTqA5QZ6pq6L5ms9kFKH5z8r3HwSegxZe?=
 =?us-ascii?Q?l76iGcipYu2nEBTM4lseX3JAOlEoyauzHpNeIbciwXt1xCTGBFXthDCjuHgN?=
 =?us-ascii?Q?koMUazLyKPdkzZQh67atbvO0Hpm4gctlJ4tzszPceUyHI+JR44JjNLGNlLwK?=
 =?us-ascii?Q?3s7uMYRtnVg+3FfMRU52cmCqIeiUkZwTai7HDdflp0yH/6aixUfZFoAW3oKi?=
 =?us-ascii?Q?LEvAtO1upK98UQ+063BPQ0gSgw2yjFwifSeNC6wwqWEnXEJ8sOrH9JCRpNsq?=
 =?us-ascii?Q?kuuNFQGSqWJJYVS7KSt5YcToLdvfAbXwtdkK1tVS4KwLA3cwyB4w92w7v6UD?=
 =?us-ascii?Q?4UTHqZZCsDLs3wzOdBOE0kD9d3GqqbHFvyXf0AfEAxeYG14wDNRLwQjRUxgI?=
 =?us-ascii?Q?fuMUvG8IrVX43jWNf2A7QgFrvOLpbgAYybCzjOsfh5dKt7lYWVyxWXr+4nHP?=
 =?us-ascii?Q?6jYRcTrAYwBcT0QAM771aH+IlbZRP11zxzsekLLE6ToERrq4x/Wg/kfL/G97?=
 =?us-ascii?Q?jRIX/XeFtpXE1iQkTxtcf/c3n4w8vKSwPZ6jQtPhs6/U0yLHrlcOUfLaU86/?=
 =?us-ascii?Q?gx2+g+shp3hEqi7bUqvw04cfNt8b82Mr3jIqNETkgLc5Ax+0L/246KbRl5CQ?=
 =?us-ascii?Q?HGnNRraWyXTPvcJTW9036uMhO8IXuYkVR5VTTQ2rOF/VvoHO8MRtZIwi3YMY?=
 =?us-ascii?Q?r32Bx4m0SLc8LpAxzlD2hdFiU/qGE+lQJ6LkgQcTJrw7DUV9N64BolUCne2q?=
 =?us-ascii?Q?9MHIMXvHvGCShhWjPkFfknDi1THNeK1Pw8ebBujqhf117B5SCrx9TkFtAH/x?=
 =?us-ascii?Q?Lkc/JE2TO1NK8zkkvAfSAg/r0aSABmTBT4xPsRQLq9KFzJjK34QuThMxyGCC?=
 =?us-ascii?Q?mfOVPzjnmYxmhAGRCb9NvVOjsXoU6YDeMJn5/fmbVoXlijvI//Z26jZrEoeo?=
 =?us-ascii?Q?PnqR2o9hl3g92O19x9t7pJNPQzCDiVykvdt55BoylPAKgYTE2pG8g8wqYVGh?=
 =?us-ascii?Q?MuTdAyuFM0EVahSHcWMsAkXtDsF79f3hFwmFBVb574gW9i8DiMRQAJSaznsG?=
 =?us-ascii?Q?qC0MRCKIzi8Jxs9OR8/FHCFjenm7YEAcxm1x5ckKYeXOS5iu/62T68AAka3m?=
 =?us-ascii?Q?ocrhuiyCrafApwa/Qfedsi3dBKRXqy0xngglvZCUlXdhQtSsiWoDbOJ68Bwi?=
 =?us-ascii?Q?EVQ2sgTSZR+2CgyTYvHrQpB4HBUC8zz0nTrm22YaXXZwKFZiBjuUbOaiQB+N?=
 =?us-ascii?Q?kjiVsBeyS3Y8/20k0oPiz9qTDdhnITmgecl4Kfspj6O/shh2A8ApM7dg0dz2?=
 =?us-ascii?Q?FijSBHg7CWQgwGJT3vVkQFJNWAgccEhiy8J8Kqf41lhkY1H2VdPRb9OE94V5?=
 =?us-ascii?Q?YTKNHGn31BWl+bm1MjbvyIhabqJGDVP6SkEeM0VVkWsTtlvObTL7QSyehkvv?=
 =?us-ascii?Q?oJEs9KnfNdY0P36GVMONQFTUdaHT1MuTvzvgUAhesNnkiOJE04mCMcXvUpCH?=
 =?us-ascii?Q?40kgU1r8Py56PcN9LA+swbIvYMmfkFwrygYcp47Rk/AGPb6p+n514NnW/p0p?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+bsd7fq/NzMOD816COLTBWB29mgUWOuw/2sExQ2+aLGuRaxLNettVCOJ1UmziMfzL7Jvzxfwn5jocSe1uVA0+/kAfaaDlxAxRqAUPu9tz6GvFf1iNPV3mOgIo3osFz5t3fdwAR5pPzE0/Qfd+ftjmTFin8L8fhxGbQ0sBosvH+t5XJ4vsSyRJSHqHFKUOepG8zUwlllNPZpw6Du9HAz0zqBAq8whfrrWSa7qMu7tdlW7/hPWdte4rXfJap/L6H2c1/oAa9N56Payn3ouG0/Jm/e6CsOMXD1I7F+LJKDBTqhconnwGvS/yo5eOyYsahINTMQHQ+zkyQPjvF3V1Io9BlYE2jR5SYxSZy+TJK/smQKmwHxE7hyQcEUyaNvkXbZ8RP4UDdE5U9A3frRQy4hZSsLXRlrc33nViaBuRKBdIqPxSwhke4ALpuY7Zm99eWvuIAT2KRq3eHoIQ+cxdb5Aou2BX4Sm19o+4u00xDFBzxLGjTSDkDeagmgBgnnQ4ZjCjyZSGMlZEN1GlcgR9mVguNyhSfLy035AxOEoHXMwIN0gZqRdYlgI0Br/1H8Yd/oWBWVlQBpNzG3XBGIaOhlxOwNZlmSNrRnZrjun4N9ohiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c4106b-1410-4103-3908-08ddc5e87de0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:47:29.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nx2GRfTu70Vz7PYir8bLZqZxKIstLw+g5NkIsC/DIdEx6PYjClz7JZQym3JiKpDoFJdogXwWgTOV5FHJOpgb2/CWbunkTb98gz+AS8Kbsp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180084
X-Proofpoint-GUID: OXzbhYY1PrtUXaTXj8e4DA0vaomk2wW2
X-Proofpoint-ORIG-GUID: OXzbhYY1PrtUXaTXj8e4DA0vaomk2wW2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA4NCBTYWx0ZWRfX7r5pF8ipk4kL JOy1hJfESLh4cUxlo89BLtBYFJ0mz86n2yYnx7WaSoRI8tBVd8vunvTtVwXDZT9mlcs6tA/5Ag0 GWhnNzYcu6AWnZJ81yo2qcE5A6RJrgwV8SiRW80keDJwIEqDNHohl2dHcNOAQm6w2n8bhgddo3Q
 U8Mlgl2z74JORyb8yCaujQDC9jaOxO3jcXRYYlCq76gGera0/54YAHG7E87MiJlVw+tJCJaiaZS oWpZtGAU48TZYgVN4UWwIyAU/2n2k9CXW77HZwTm2BhX8nNkAZlB3aEiNZgkpaQfA3nkSas1FON qroxcGqrQs6zcGsmDWK/afZ3fuQOnKJ5OKdmMmUJd5Me2XW0JjD1+2WLxSmzoUiFbUfLENb/VWZ
 ajSfU6LSCtdsdwaHTu1YZKs6BGLEGHwHmskUJ8ESIYGLi4IxukcsiXy4ZfUW7dF5vgCY0fJe
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=687a2645 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Whg3FAmIcToyTrHMrrAA:9 a=CjuIK1q_8ugA:10

On Thu, Jul 17, 2025 at 10:14:33PM +0200, David Hildenbrand wrote:
> On 17.07.25 22:03, Lorenzo Stoakes wrote:
> > On Thu, Jul 17, 2025 at 01:52:11PM +0200, David Hildenbrand wrote:
> > > Let's introduce vm_normal_page_pud(), which ends up being fairly simple
> > > because of our new common helpers and there not being a PUD-sized zero
> > > folio.
> > >
> > > Use vm_normal_page_pud() in folio_walk_start() to resolve a TODO,
> > > structuring the code like the other (pmd/pte) cases. Defer
> > > introducing vm_normal_folio_pud() until really used.
> >
> > I mean fine :P but does anybody really use this?
>
> This is a unified PFN walker (!hugetlb + hugetlb), so you can easily run
> into hugetlb PUDs, DAX PUDs and huge pfnmap (vfio) PUDs :)

Ahhh ok. I hate hugetlb so very very much.

Oscar is doing the Lord's work improving things but the trauma is still
there... :P

Also yeah DAX ahem.

I'm not familiar with huge pfnmap PUDs, could you give me a hint on this? :>)

>
> --
> Cheers,
>
> David / dhildenb
>

