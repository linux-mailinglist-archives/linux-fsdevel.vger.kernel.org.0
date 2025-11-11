Return-Path: <linux-fsdevel+bounces-67852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A344C4C059
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DEA18C0E62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12E434C155;
	Tue, 11 Nov 2025 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CeGOKRB5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v4ntsIjo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782434BA4C;
	Tue, 11 Nov 2025 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844259; cv=fail; b=KDFxcPXoSNaxzS7fX3RDVZL0je9PUJ8hwq5PF8qsK3+p7Vs36HomP+KCZPjD82GqYZQmX9la9kP2uetU7B1sW2iio3Hu2bE6SeEoCRgFcUihdTgAKjCMCRs25yRRTi3CgfqcLI2NBHqd/2XcrEpIdnUD95s04iKxyx/7l0s7BSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844259; c=relaxed/simple;
	bh=0Ulmm2vysEQqSmGigJEuILnr0bbibURIoMbSmm7dlvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pOSTVhiXRHKiF9ajhMIO0xJdu4JabakHLL7tX/jnEZ9nY9pE1+PUVrA8T032q31mRs9P21Yvn9PEokzM0T65vtgG113S8gOg+HhCWpK4U0lA/PsEUXZQPhcmZN4KODAWfOhdtOG/6pgSzA8YEK6aaqIbNThJDKJobEp6mCR4f7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CeGOKRB5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v4ntsIjo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6bfDp012861;
	Tue, 11 Nov 2025 06:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yuQcnOzcZJMxbeYdOQ
	xwJyuF8YqG1ECabVmeipVG3Rw=; b=CeGOKRB5B2lj5s7ixjQoqw+39532FwrKAG
	ztpJkpE9lUOa7uOUqiPuFn5CV9jafTTF/5eZMakVOwOwajXJcs5lv5U25GvBLhG7
	1IBCoPvvlbRrRwQGIHvLjB+sTDiqgMCozKKDyz7nC7NUb0zEO44MAWCnwv8J92vS
	wKoz0/FtE0dU7+3P2We+Tly8zUnieoG7P4aeaCavqn3QLDQ7nUVFmUerWmyJAkCU
	Jl1N2NvJ1linwZcdA0sAb9MvIHLGt4MXNvTt5WP6Cw7UzQk7S63Yn01TSbOpN02i
	SgTapxPzJONvpJccZm4HTeBkANIB23AUOMtFfY9Yx3jULTw1K5vQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abxrt83x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 06:51:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB4saro001045;
	Tue, 11 Nov 2025 06:51:27 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vad5guj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 06:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VB/m5GCVBQBES1qKWsWaEjtodM7T/+blKjkCF/mFWfWUHO406Vp7l1OT4G+NbAgXOsSYHhox/vFCCbNw8uhr7tekfmwVEzSznyvhRxs2dBwUevnqD9xw762blnlGgAD/JEST1bQOcggSMgSLcp6AziIQ8A+TTbq/nnKlQo8JbC/SXU6xRVKPV6bQ5LwB3gVrUn64vGuL/MSDq3mslk9Q9Nv1IEyFFpQM0D7oJ5XXdhNU31xXv+DOhnhXbIM3CUykh++r4xYqXNFZVTgUVdwiehQL31E5cR6hovuG8dESeoGXfZYIP27L4lowaTgnCGa11nnrjzZfUNcMTVVGJspwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuQcnOzcZJMxbeYdOQxwJyuF8YqG1ECabVmeipVG3Rw=;
 b=QO1f85Xuzxde0NiXR5wNcgyrlRpqqCCtb0w/h/1Jcn42zaVw3pSifcdreJXk5e7RTiGbYEDdldWHThNFewGMinqx2jmp7OzgVAAMQYeTf4tKgLH7hQnbGlQOclaJY0F9obOEfOlboh5oOp7y2JYrf3AFDaUn4vZEidjC482D50Do6+k6QnJLSrCmpmbdugYLVcDt5xkaZgQK5lpqiT2M8AgOrOcVvHG4Z/2PHs31uGkX1AqFR/0y+DvgvdOsizCg3M2I9EnUOyOyS0Xh3oCEaPr33LuEhM0vfLnSQTPvIrHyDnuhuJL4gBxgRuIglQ88LCbjBNCcUsAQwiCkxQLW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuQcnOzcZJMxbeYdOQxwJyuF8YqG1ECabVmeipVG3Rw=;
 b=v4ntsIjop52N6rPEyt1EP4K7h4x3AI1Ufc1+Qs2V+3klxdtoMqqrYRwC+xVD/vRpylpyjG0g3XfLWyLGR5/gsQQxytB4SsUz2u0Uy7Ksf7lAOl2OEsH4PblTuBvU/EK1JSG4V0rmKLCCspwIr9RsUEhgKomgmOej/WvHion0h6A=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH8PR10MB6528.namprd10.prod.outlook.com (2603:10b6:510:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Tue, 11 Nov
 2025 06:51:22 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:51:22 +0000
Date: Tue, 11 Nov 2025 06:51:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, SeongJae Park <sj@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <55b50b8a-818b-4304-aea4-42d549deca36@lucifer.local>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com>
 <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local>
 <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
 <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
 <c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com>
 <20251110162313.baee36f4815b3aeb3f12921e@linux-foundation.org>
 <ba5d8603-4140-1678-b2d5-d49ab1a40fe0@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba5d8603-4140-1678-b2d5-d49ab1a40fe0@google.com>
X-ClientProxiedBy: LO2P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::29) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH8PR10MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: f449063b-4098-4a76-2448-08de20eeb99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ltb12i/HICxy/ljPsiee7RSHpKy0NMseHipZnxB5JNzdT9Y960yna14Q7kuj?=
 =?us-ascii?Q?g5JfyiMpaPJVHkWDKQPH9CpLUKE+WCKS7dcMIe3xYs6p+NLG76KznsPLjvVF?=
 =?us-ascii?Q?aTYtmkLiaMW87gkgXOB/rjYcoc4U+GiBbqKtlGqSQAkmEMCNmfs8VdWVXcWk?=
 =?us-ascii?Q?xAfIUjCofcZDcwSDoiBa6IsXIJNEyMnrdvQYpdq9DSAoLe9aMlMNX2l070e4?=
 =?us-ascii?Q?SpBjrnMdBlLgDY2Exj+KKNsFjI88kpgc1jq4qPgLjrWMJYL4PhHVPguhSZw7?=
 =?us-ascii?Q?vRUXZHj7Iiu3PAF6FpmvRuQ77v2h1n66ACRPUhzGB5fuKyMDZ5EOnkgdzfZu?=
 =?us-ascii?Q?aNVpABd8uI7N4X4alECBtKXmAyTTSNSjSvmm+8Ekmipsvb+ZnMWfSaPIBCyh?=
 =?us-ascii?Q?6flV3YS/89s2UPlC/CoMJUq1zEyJPmPS5sC/zbfe5KOMgiH3y08s4GfR2s/U?=
 =?us-ascii?Q?54rrDOw0n+mDtaAKtciY9Vs6zSOd8OebRlf6jYzgo7d7qPSZHFb1kfeYwbje?=
 =?us-ascii?Q?FSkzAcYt/m34544l7KnJFs6bUc/1+K2+StHW74bPECKfGyDcRxs3wbFfOcjm?=
 =?us-ascii?Q?iQCza8MAc6Lqvj4hlhBbyrcomthUDfoH/f//+s4ahrtXx2Y8/cryGRAMWad6?=
 =?us-ascii?Q?1MFwmr+ypaP6LxQD87OtdZFt2uemgMCrPJ3QAfljq4GKFVTmh2M49HieARG3?=
 =?us-ascii?Q?Vu9v3PNXhO9Z+7IO5aa9jc9hSC8OtNiG6FZkJwJqF/3xa9Qr0g8gkREW6xPz?=
 =?us-ascii?Q?XJjJOrup9v8oTnxOF9E+RvBBzx0pXmfP+Rwz1JWroJ+SP7NpGe0uOV6KQddM?=
 =?us-ascii?Q?LUYpL5KMdNQkOQkRHBvP8230tKsA/W/NtjgGdI660kUV+aohte5Fc4y5Cpt1?=
 =?us-ascii?Q?LFWPwbtY+hgZt6YC3gEF3GI/YBn/+RE0nfshOVtaEpqFEnaQR4XEfm2VBb2F?=
 =?us-ascii?Q?lV8m5jPOV7dQ8x7aMKdZ2bUf+SdOac6LwfRb1XYY4zayS3vFNdctudbffKZr?=
 =?us-ascii?Q?+TTClOc3KTcilfhEzuOdojQxrmKc8NDBnzAHzojNxNmka6rqlnf4qkG6Ab03?=
 =?us-ascii?Q?ZIsGJLXCSPP4nAlAYgGy6xiPjXAV3bJiYT8h/WIET6G+yRNEA175O/csLDwh?=
 =?us-ascii?Q?8rjmRr0JqxoRTE8vI5O8Vx/MWu5CbDF/kIy7O8z4V5QErFKvP8fEZ/EO9GLE?=
 =?us-ascii?Q?aSmj30d0NqFBvkD7g3Ya+JEPhL9/pqJX0OmMv5bheY2V0lrh8AsWY4QbJyUc?=
 =?us-ascii?Q?Xm/r08Mff6n5mR8wFBDI068cggaGKjsJlS86iPyJzmTWYAzvLudhkuutGklE?=
 =?us-ascii?Q?P+H5W7nCb+wft6kTpmImBj/jPTVjrUaddo4HtagSKNDOjZ8Xu+cYBK3lMh6x?=
 =?us-ascii?Q?EsKOWKr2oE8gSs3x78EtQ2+oGGT7TdCAnP8Gknq3Bsgdy5ne2zCH7xrH9V77?=
 =?us-ascii?Q?GJbFH/GbQE+oYwOZ6gBI59tz2t7yVTu3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5SomZpuS+/xPRusksUtS5DSFCrVHiG3OCuvw433LhWeO9QF5A5OxX5P5sVN?=
 =?us-ascii?Q?1scNbyApQIou4cGoT+ltpBr/pfSTZ+9VALwRA6Ktxa+FAP+anj/vpTeJTwuf?=
 =?us-ascii?Q?Pg88GwQlsFwczmS5mJGwUNyV5TTRb+NOG2gQ4jSvmmqPFYF77eDufK4404Sz?=
 =?us-ascii?Q?nMnlzSKgX43k5oHIa0huCfnwG91aCPDTEv04k3f8l+WtXcg5a0mUCCV8s/uA?=
 =?us-ascii?Q?wPqep12IUHKxNvH92BsKuOnlQTEUH2sggzy7K26OzgB5mxvnBGM5J0Rf4etO?=
 =?us-ascii?Q?6ArpmngjB0LKUh9daLBAUvScGdsye4KJvyoYM8j6+5n2UeTl2EmSb0qrYO0N?=
 =?us-ascii?Q?G3Pgb8fw4CXtXnPjcUGJJk4o9EqFlqemxLjlvvphWBp6Gc+3YlEkBDR3Lueu?=
 =?us-ascii?Q?LHYIUqsU8K0uKhneHWtGOtALziWj8nG+oEmRF1rSL8Kf6+YkxKv3CvQJ/RTx?=
 =?us-ascii?Q?+ML6vtMvFLcDoqS5Ek3ZsPGv0tHrm2ubTPIZ+zO34A9PcrwycSBM7MPm8Wd6?=
 =?us-ascii?Q?3r4LTbBpzX73TRRkfSlVfkNw5i5TDnHIqgVVbZIw0/4da8MEwPEAGzexiTK3?=
 =?us-ascii?Q?6TCRhzMQlfhwFJC2iPCXQoMtOlUnKTUwuNyxSSZGJ+k8RS9amCf936uDMC5Z?=
 =?us-ascii?Q?62xWq/yavMV4XxcHfRXizZlg1co77N1CNuyCcACiF9RDHP3R2LAFhSL++rmo?=
 =?us-ascii?Q?mC9qwBVvpPk9x3YcEO2GuN4lzELMFaFbYyTAueOI7NoKLNLbTZcGxQ8AsqIh?=
 =?us-ascii?Q?oon1XcvhjTQKnudN30bfIaqszPHZ1s42s+4BhnuGkKEvm6Hc6g8tMOkmXdTE?=
 =?us-ascii?Q?VkPW6y4PK8DtTYcBB0fG/P1EFJO0BpJN65VZ3NIEBSIHXifsrQq2eyItvdUg?=
 =?us-ascii?Q?TlIXQl0NU9y6+1dAuZz30Aun5StV/1ZLaYSi7pliZ3uXKpE8wetTWulbyInQ?=
 =?us-ascii?Q?A0BzsN0OyUWTVfyX/aGCxEZ3KoUimJ04MMUg+wjyN2KFlIobechz0KEvXHgd?=
 =?us-ascii?Q?6O+N41fLerGsG4t6ZgPAyxrKeB3eBxJy1zaetTSZS2eYkWsm4AiRCj1geTA1?=
 =?us-ascii?Q?YJ3fmVYrrhRZMD/pcl41AmZ5IT64NubCvZFukCxCd5Bvu1vFHg9mcC1UCX3s?=
 =?us-ascii?Q?DNZRyDUTPexLbwF4N0sNzk+W5F6KE15XLfVAd7+Fv2couah7YcnmrXD6M+yJ?=
 =?us-ascii?Q?QIVG20eME6YkkbN5QFOBW0axjZlHgf9ilLnOAHcxp0vawKGR8tKrr769fmSQ?=
 =?us-ascii?Q?J7LzHVXDd1BV9fHNihGdO6XQAetoIls1f4ZBlDbgBuPLrGGkc7bLOAxn29qL?=
 =?us-ascii?Q?N/xXUlluMzAz1gYrMU9OJTtasmK+M/RilD1MmNgEHWTbLYKZ0iMDcp8dcVec?=
 =?us-ascii?Q?jU8yQtILBFJ7JIHqxt+CnHQoQgJKEEGPXhXfOBSmbUXZfXznTMjkZnctvrL0?=
 =?us-ascii?Q?U9NnJIrM3EZhlvVGs46NPaGAQXkgP+QhC0sFaIrqXEaTSZdHWegaZRPTJFi8?=
 =?us-ascii?Q?fxgSKwcOgCoLGFNChY79soyHkZZn//EBOi6O4+tf1VVQdzsLNvSwqC4r/LJE?=
 =?us-ascii?Q?7/Z6zmw6AkxBruen610Onqk6YVMXpBy0mf+wgczn5HfgghYmCM0Rno7LPSoG?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EfufIKE69uiF0WnhEjnsLwykyq6SB3eufI5pN0Cl9ehV44YN26qvp/OfA4xe1XbYH3hodBW13u/Rhd73XlaFrnVRXvvPBQAV6eHOEgC8GiZ/zq2d68vurSIfDM44QX95FYY1daiSuF4WOum74bG1+yq/D5pTTJWL41OxdOS8E48p3xS+rEUJ0b+xJMHlcjs2IpksKlc/IPLfFxylKRgpQhcECNn02TAzADnjbfFicZaHZu3RXsMRPG4rO2PjYZBy9Me69+u8tMSpD7I+KXzkwrFbTn7y+x1UxQa7G5KeOCRYLNv0TdZD4BtoSUK9vBrxSpYJhyJdD5nIihdufVbfXhBgqs7jQQDL6GZWlUSEkplUbjvk4iIkrP0/nILKHWTMYOSv8joLFsKKuYAmj5k3d3xijxaucyA2uMoLm7iE8RHp4jSP5StSHanq68BrbZcoM79MyrQdRa8po3/afqh7JNVgFj2gUyHbKuKn2sTtf4rw1WHCKvfd90QjnsA9/zizHiZvOdQ5/2o3wpf2r+WsnhSCyi7r+v8Km77mFm679M1TqkI68r6lwnVhfK9YICRrj7vryQhQU087HWJ6C6BSoPaElftVb/Vl5XzUfaSWiug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f449063b-4098-4a76-2448-08de20eeb99a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:51:22.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsZdtgARCZP/d54qOmJDAvmwByJjM8ah1OpQKMQSwLsDtNu7A+Prv1fvM22pnn9MjK/eUp6+nLk1Fg9TuqIwaUcLE5nSTXhCOAlAWVl1SCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511110051
X-Authority-Analysis: v=2.4 cv=c7+mgB9l c=1 sm=1 tr=0 ts=6912dcf0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=zwa8OM-7MrPvge9kbwQA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13634
X-Proofpoint-GUID: f0VuoopIzwJ2hus2mUZ-yEVTSrnV3gi1
X-Proofpoint-ORIG-GUID: f0VuoopIzwJ2hus2mUZ-yEVTSrnV3gi1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAzNyBTYWx0ZWRfX9emDQ9TSVE18
 G0S6fhq9kSYr4AXkDAgO7D/bz2dFCSfeIrSsazdM1EhTQzMC5xf5xy7pTvvjBrkrKdSLxkLriEB
 iCzoATBuhAmvzK0oSZcSIn7kx+TB+wvr5XDaVRplAb0GEx9Y1xt4Kls7vtYrbU8C6A1VSjHI8E+
 /c44RhYYsmRUfyl2r2m7sjequ1A0ZpOjph55g/a/JP2d1vAcgnuGO6am+uXcPB70e7jUKoVd+pT
 pHoRkN3uOf9/vndw4L4fc8o97WmOqW83NppLhXFAhEUk+NztHJKEV2pPWP4tm+Dq50NBwKkL9VP
 hziPT8eGtEy7oThz63iTXJ9HZSLPa6aCO7/8EzDDobZwVj7zDQVIA4AMBRNg1dAz8q3AA9WeA5R
 TjhM6H3G3D/zoKxe0knATKBHP89w8GZLX1XnEYXgZ+quUPmAHKM=

Andrew - in light of the below can we put this back in mm-unstable please?
I'd like the bots to be on this and obviously hoping for inclusion in 6.19
:)

On Mon, Nov 10, 2025 at 08:07:34PM -0800, Hugh Dickins wrote:
> On Mon, 10 Nov 2025, Andrew Morton wrote:
> > On Mon, 10 Nov 2025 15:38:55 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
> >
> > > > I'm sorry but this is not a reasonable request. I am being as empathetic and
> > > > kind as I can be here, but this series is proceeding without arbitrary delay.
> > > >
> > > > I will do everything I can to accommodate any concerns or issues you may have
> > > > here _within reason_ :)
> > >
> > > But Lorenzo, have you even tested your series properly yet, with
> > > swapping and folio migration and huge pages and tmpfs under load?
> > > Please do.

I did a whole bunch of testing, of course it's never enough in practice :)

> > >
> > > I haven't had time to bisect yet, maybe there's nothing more needed
> > > than a one-liner fix somewhere; but from my experience it is not yet
> > > ready for inclusion in mm and next - it stops testing other folks' work.
> > >
> > > I haven't tried today's v3, but from the cover letter of differences,
> > > it didn't look like much of importance is fixed since v2: which
> > > (after a profusion of "Bad swap offet entry 3ffffffffffff" messages,
> > > not seen with v1, and probably not really serious) soon hits an Oops
> > > or a BUG or something (as v1 did) - I don't have any logs or notes
> > > to give yet, just forewarning before pursuing later in the day.
> > >
> > > If you think v3 has fixed real crashes under load, please say so:
> > > otherwise, I doubt it's worth Andrew hurrying to replace v2 by v3.
> >
> > Oh.  Thanks.  I'll move the v3 series into mm-new for now.
>
> Lorenzo, I can happily apologize: the v3 series in mm-everything-
> 2025-11-11-01-20 is a big improvement over v2 and v1, it is showing
> none of the bad behaviours I saw with those.  I've not searched or
> compared for what actually fixed those symptoms (though have now
> spotted mails from Shivank and Kairui regarding 3ffffffffffff),
> I'm content now to move on to unrelated work...

Thanks yeah there were a couple oversights, one due to shenanigans around
how zero swap entries are represented, and another due to some frankly
insane code in the swap implementation.

I feel this change is very necessary for us to a. have clearer
understanding of this logic, and b. to be able to build upon it sensibly in
future.

This change is selfish also in that I intend to add huge guard markers in
future, and a previous attempt building upon the mass of confusion and
horror that was 'non-swap swap' felt borderline unworkable :)

>
> Thanks,
> Hugh

Cheers, Lorenzo

