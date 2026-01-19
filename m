Return-Path: <linux-fsdevel+bounces-74542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE1FD3B9A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01C173047916
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C1F2FE56E;
	Mon, 19 Jan 2026 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RxlFIKh1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KDYQrpc5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0C2DEA6B;
	Mon, 19 Jan 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857635; cv=fail; b=neLEaWtI/C9/0hcwWgHqLt25JbOgqFjthZpf9SM5dWzJyw/QQiUhfntFDHHCo47odc2QuvkpwLwNEaBXeJ6yVb2rDuPewWpUrCjxOzT1drPnzqOXobv2ew7VaqDY3C5ceE/nVi2fRvAkf/4Lmx5u2n4Z7rH+Nk2azLts8AjMtRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857635; c=relaxed/simple;
	bh=TrV11ej/dy5t2ZF6He0ra9vblmXbmlsd/i6ev2Kw08M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ng8uo0831IuEdKVqdfl8opbsIKaM8q+Bw0srOD18ljJE65iZyF08ZIjR5N9qOQNe9VjJTEmAzlRAdGgiEpNPdVYDPHQyKMlW3gO2DSY7TdrlTyE20ih3R0bTJQiMBOBUyX9LHQOWizK+VK9kihmgQM21fZMxlsR0XIxPBx2SFaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RxlFIKh1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KDYQrpc5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDQXn1037397;
	Mon, 19 Jan 2026 21:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9NB/xNpGGorG6uLTe47zCLELvNAMhUaEudNabs9pE4A=; b=
	RxlFIKh1aHPEe8l+U2ODp8oJtVZ6wFVg+HDmjZCjA3BInmob8VeBcm510WLAvYtH
	AIUe8p/fH3in1YRdnGgtCRGe4emwfDQO74Kl2JLbr2ldxs3NH4jZG9V19CH8zgqj
	iF0YJumFAVgMuCUdmssNifcQomW2E1IcKqj42sJJTsGlSMDCK03ZgBm3Cd7Ugrow
	kyEh4t0PcWq13TvqNJVRhBHYrFZASp8fWuu5CPqNh7QKIpDbu1+t3wqy9qpQ5mpX
	ZgjtnZ3DQKQZbwNgfxptkrVOFFCZo7TVGyKQYo02qokxRZk4bK53VWMhKMIwNWn+
	dxYJX13Z+b7iDMQDmG2MGg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2yptnn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JKxRlH040602;
	Mon, 19 Jan 2026 21:19:33 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcj0wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3FW6SZfHN/QjMw+NtpXH3z7sL2Oq5b94pk6QJ7MXi/GacoUyCz8xaib7zntCoxMMlHghOnaqLe79DiTEyJbL7+DFtEXRrJsP5BMZGsIcf8jRmovrZZG5dmAHZ/W1+G0AsrbvJzC1QkoA0SJDpvbM8fRYZQUcWtwl3U6MlQDUqQnvITrftD3Tdiy0lHbynT2KWyilO+cnpoKLt/lI5NKBwhdZuee75sr23Ci9NzLu2zwJEG8JHQciF48GVWHSwVT07Ei/0KMYYCbzt8m9fks3U0AOaaPWT6y5mSKu58FGTg2ZYUlsqtkZ7xEpG5upUwkxP97w1GwLtSVcHhZ+aIImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NB/xNpGGorG6uLTe47zCLELvNAMhUaEudNabs9pE4A=;
 b=sbZLocgWmks36FQfrjS0K53l1flB4ZwmWR281ua9R8fhRHsrLAZp68Tfz6IBeDEds9FBBQo4Yxkk6qHZctqkTo4cBFUFXQOgPseQ2mhtQ4Yv1MOGjvvk5QqVK3i2BDU7EBdE97OC3oD9dt5T2BgSmD+krAQnNJTjL0k4DXW4K7HY/4VRU/D33Ig5ZPbwP6zUkKesIn1CqnobbpEB8dJMD4ApigC6Qtk1mg5/eYKW6xRJMPnw3ZZE2IgggSU9zUQrzc0Q1kcD2ahJBnSLK+zgy1mT9dOnbyZkalRyTYG0/IcW9D35SESXoGvO7CRYSkPeM8k05iaGIBdvMpMFny21bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NB/xNpGGorG6uLTe47zCLELvNAMhUaEudNabs9pE4A=;
 b=KDYQrpc5C8wVtgGnICMEG5PWNGlMjQGyNgzuF+P5aHPyVSSnPdfAUViaaxjWIVA1DL1anKyYQ7vAxtIn5n+PpjvV2DJ6aLEmRGxgcq+n3nySwWtiNIukqUDMWA+xWd5Gg1FPIwJ7HB6t2hYY9i5wez3gy6mPriKZJKvc7NSiHoA=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 21:19:28 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH RESEND 03/12] tools: bitmap: add missing bitmap_[subset(), andnot()]
Date: Mon, 19 Jan 2026 21:19:05 +0000
Message-ID: <92ba93be411cc49d04a91802fed8c32a6244f67a.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 843847ff-91d7-4c83-7f3e-08de57a06ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4Udgw+U35Zi/VNGG17xyOHSRW5sBQ+zb8Pdf7b8gtcuforU6OcFo5DCWDbq?=
 =?us-ascii?Q?yvfBNJ1sDsc2w23FNVaaLM3ajxDsZq7FEuvD0xMtzQpzvSX4s72D7iLYgPet?=
 =?us-ascii?Q?YmoljRN+JzqOTIO4O7i+ypqQsx3UwyOHlOtra1QSkifXa6uwkIctc8sXPAUR?=
 =?us-ascii?Q?ZmzYahabTu2bNhvGr0oYOkI46ebfty9YYY1Y8Ejl7JUsOBfC61oYb/yCmEZX?=
 =?us-ascii?Q?gELkQLLgEZENa09CXlnaqRzlvJ2wnZvjImNp8X1335fSe9o2+0IaaIXXhZF6?=
 =?us-ascii?Q?fq+n1Bp46GqUdQKCDeF0kX76okO1N102Sz36dytbL6suGRolhfvOIO93bJ4V?=
 =?us-ascii?Q?YznpfBZgBh4Fg/dOQH8dEJmq3uO+Y0JcFdKtQLVAjcQkySE3+Jtie4Lqvt+V?=
 =?us-ascii?Q?jfBrf3x/uqlpBgYJclGLI8pdMMl4aCkwqMVNFsG9qx78l1YKKOGWDjXJ6O3a?=
 =?us-ascii?Q?p9M2Po9umWjz34aDvOOBRhkDh8mGkv+MOTSovjV+0G/0GYNYLv7ibZYaVrEV?=
 =?us-ascii?Q?uMTKQSwja9Tuygm3T8v4xYAZRMkxIEGKczvDk3bUSiFBzM41BU9QPx1aPwzL?=
 =?us-ascii?Q?70+cw+CXBD295zI3phctJm3Uvnq4BxUZc33ZoswJABmdY6nLe2lMIhOSVmzE?=
 =?us-ascii?Q?Fi9wdARQrCPVq2rLz9TvynBj4KhtSBNu06H6Z5B75J80Hzo++D7OVoJj+hzd?=
 =?us-ascii?Q?SabQ68XXaYslJlGhgUFCNx2dAYe3q8z26oV+TFci9YUszqmzpZ2f+8eB0kiR?=
 =?us-ascii?Q?MzvbPVphwzelo6EMffwVx/mFOV/UzZAFqLgP/4U6nrxkSPSr1+cz1gCJO5s6?=
 =?us-ascii?Q?clJBf3JGNBJ+jU1mazHPvnBHiuKxX9hSPaKnC49+sPtludndneKCgUgPkWNR?=
 =?us-ascii?Q?742kUAkTdoZpXgtYdYjnA30H02NhlUE1mDoMyiipFhfOCZJy9pMCbsmnvjOz?=
 =?us-ascii?Q?AdjNVRRpKHp+gOftWEUoYo/RVxMGlGwN318EWNKf7Mp10j47shRUaDkp1CYn?=
 =?us-ascii?Q?iwNaf2hge7B8NVjRCdO9+5G7+VQibptTDLPVk+QtOY53JpT6hXicEA0XoAnI?=
 =?us-ascii?Q?Vg0ZixdxQazij4qsXIvAKZV/6pzT78GIvStPR7ca7J3CTESHWxWCOveT99r3?=
 =?us-ascii?Q?W0xzvKwckYLYm+wX2wtNG7rOzKF0x37Qbyj57pMvKvc2sYnAqrXhLR3HW8wx?=
 =?us-ascii?Q?z5XWEXiFitke0CET1kRQr/UW8QwnDIBSGzivkLZ5ywARuk+17KSQQVfurvCg?=
 =?us-ascii?Q?nb36ONKZ4gFcyqob0Y0/3g7QLK3vjvkOfQgfTDEfcKJy+dcEMBThSRRD3t89?=
 =?us-ascii?Q?JlpFGkJ6cn9djTOPhgSQxeVxw8HXme5jvAXsMkMcCkmVz/ZPX8ZFXkezY1sc?=
 =?us-ascii?Q?993pJyQVe1NxwIzNZpsn48JXH9nSk5fBJxrMN0OfxaU+Xtd6dGtRm5BgZCOU?=
 =?us-ascii?Q?HTK1oKzbmY0O7aMGZXLmCL5WlPDKIt/hEt+9nbiPw1/LP2rr1P0lLK8G+XUh?=
 =?us-ascii?Q?9QT/9/Fw6diabH+0hn1iY7TdRNfC7nbhZQX+T3OzPSpCectCmPRLfQf4QDfS?=
 =?us-ascii?Q?JjfD+KzzOeQp6dXXD2k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9nCPEsGOBfji65KZmOHsLAGezKQoWU2qYU/zBO/lu/u8LwJypjkOb2MwSBTY?=
 =?us-ascii?Q?qkdszE/Dsw8wU8INfHKWPMiT02l1cigo1E8tFrJ1UXfDhGDPALkUBh3HSCip?=
 =?us-ascii?Q?J0MJd9BWHYdOf2hhJ2j1If3TLe3R65aflIsqxIyE744tAErvKvSkIvIk77L3?=
 =?us-ascii?Q?tni7Dt7icsNSzpZ1jghI/RZJi+iwrohY15QSv5EWAVIh8Y+aZs+Jvzrf10LL?=
 =?us-ascii?Q?26L0VgkjxkwLy7JjkcNM3AifsiTB4zw6x+CWEpCNwLPESxi4OwOY8cJUgXaK?=
 =?us-ascii?Q?admx+xZHd06UfDEwe8T2HM+pwvbNa4m0J8wR/YKzmyhQrh2jfjH5oOktRUAb?=
 =?us-ascii?Q?14kVAL7gA8NaRcSISHem5cPKEqHMelweSOnjR3G/MDV5gBoRQCGhwhL9EFSm?=
 =?us-ascii?Q?h0e0lUrNCieT7sToCZN5HJk58g5LQqzhoSt3eG6KWuryNN0E1Ii9kx0FFfdU?=
 =?us-ascii?Q?zQN4efYQytNkHII5IqB6Wss3uIAeCeq/e1vKejcnxgTzUVa+XQHcenXtPP2w?=
 =?us-ascii?Q?JmNPDJ13FGqIEW2vLoSZavXNBdQFX+h3HjdHvjv0mPDcpzn5iC1RcNcKinxj?=
 =?us-ascii?Q?2HnLBD8ZVG+M/D3hjktoWly93htfNd199t72965ybG8+O/msrPOPEt7eY0c3?=
 =?us-ascii?Q?p7pc1M+Ks6Nsuvp1h5cF9YblwAtYshdeAUgTdW7X2UbefwMoEK2ltAK5znLD?=
 =?us-ascii?Q?5SmSNvfS5DBFrBBLEEK/Wqgq+IjUl89CFJYsMiXf1wg4OYJgMbLQ1Yl0H6gq?=
 =?us-ascii?Q?Hqfzf5LG/2OLAR6kZboMoefOvbjGkFTWimCYfgr/QekcY+w/YqqjM78Hb2oK?=
 =?us-ascii?Q?c54KSmP1pdr0JqxDmc1tkdAaQ1d+kooXg69MkfrJ8lGp3/fDTuiKb5+0Bujp?=
 =?us-ascii?Q?SC/2zcs8CyofNBc0Jl6FrOPbS4ymbGbBba38oSurgC7VfqbmR9z2HwS8lEmx?=
 =?us-ascii?Q?Rq+QmpYLgp15KWC34yi5bgoj0o1jwLktq9O0iXG5NCd0hPCB2kpUCILhUmSX?=
 =?us-ascii?Q?8ZlKSOW1zMcuMbmZDzCCylBIaJPDg32DgMU/4Z/fb+Q1OafxdXnM0318Cc/b?=
 =?us-ascii?Q?/UdJWSen8Tu+htAj00/g5ttA9ATqG4FYs+HSrhVQ2vrY+DS5AkWlcZz25NOR?=
 =?us-ascii?Q?C5CtIp9F1EUlk43CGPkP+hW5ot22wIbfhsaAb2tA3MEcQDBgc1yTAZJhUlFE?=
 =?us-ascii?Q?48XzhdUhsg8T6QvGMwVPeEmPwbROvI9GrMYuTgd35RCCSWtV+4lB949kYjgt?=
 =?us-ascii?Q?3XyzRrvDIQc0PGJ6t6IIks4hA5pI5fzY3hlDv/KR2WgU/9SCbrYR4CUewKFy?=
 =?us-ascii?Q?e/VY6d9eGJSVo6WWyyhqmbR+i1hJoe43Enoryuxb5o83lrdYj2HUjmC0QiK2?=
 =?us-ascii?Q?LyK4ADBtPex+jwNTQPrutwZRj3BGiECkfGdRfBDtmCGcifY41pHLiAK3XS3s?=
 =?us-ascii?Q?yTvWN1qZmTtrzPNTOH518bDJ9TCB5/bbVPuX0KTdDmoe3S3yXGmlpNLB2jqi?=
 =?us-ascii?Q?4yWEFftak4lFOAaTRfJeUanPC+GeTMoKj/u8BKzzuWWNSA8nW6wQEnMU01Oj?=
 =?us-ascii?Q?8EDEPf8/dke3CJIAsgCL7cgiYUsoj2l62u6Jk5KNTAhWLA7uQUAav/20Iv/+?=
 =?us-ascii?Q?/QvlleweyP6yxuIaktT1pgY0sb64mIWh/72UJPD8yPNkMrlkWSD27k6Xjg5F?=
 =?us-ascii?Q?F5OGTNnz6C5yurkxtOYm6GwApA9gCOfE/pxNa8RjTnolSRoqTm0FSFtG5KRL?=
 =?us-ascii?Q?F5JbJtFb0jmlwuuGQf6B5EujTMIUP7k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vGcJmhXL/5XMVmKY+oGsj6eiEHMCZszEOP2crH2HgnIQk3bsTZHD51mvZ4crNR+Elg+YEBGKaJK+0yg2s1V6SwxxHl5OB/tgt4UAKjSrx9xagS7Ryu1WmtP9WSp1rtMfZzgi+BncQIlozXWz5rHN22UeQLXc1UlZ6nyZiGyLGuxaAUqRfKSyYDd6sH+/rVnvTIwB7YhvIcPO+LkdtvGNYO3ezhKG7jOL0/yfXk+CwnbXkGG7rcS9IJh0sqpL0bjSumd+Y2akmTmN+pU7JNUODeW+/RIzafdgn2sssSIR2L2J2G8+bKYG84mz6eYN5iC4qDFj9HO12DK+54c/KpgiKGJPSI8g6tdzKxuRii1iRDkdvDvVmRQ57wuv1bUYaoW6A75rPIQGD5NCoXpQ2dSZxMAOZO5TpAEmfjVI4tThedraATbYe1ATwWq9cCzeoOee97PRau1RQ5zGF5iXr0akQKi5210apey6ROZb9uJAh8aPO2YcAqd29PbHes11rZ1tPZ51hXTtGAvrSp02xP0944R4EhUolzTgeFcSGCbcG4nkn+bLhHTjCnDMxDaLr3sT8NUBZub9i2ma/ve8DG3m2geafWIRu6+tQHK+HDDu0X8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843847ff-91d7-4c83-7f3e-08de57a06ded
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:28.6314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gkd+mIS3pqJf58lz8JkFDLyr7LJKoswjQSF6Vhh1oQnTu0TlC1MKRbdc8YYsQQ6LPZA5jYA+kILKvnOhpZOW9CNeekYisq4SI4zR+Is1iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfX8+5fgZPCVyMh
 nSepckdQnSn1gRH8QmCZGpSVth3dHwgQ8l2jP8daRmMduxg/NSruGdLsWrj8M+YX6PjDgypy5Eb
 0ry2fiBVWurVvZCPAwEuIYliDtuETVdq591ImQk83tMgnOfi8t5YvBzet9EOCwvMcVF05x2DsSC
 oPVj4y61+x54nNOzKBWYT5F76EyZjNrEcn3gxUPbYeE/yRVhub5p3N8SGMrYC4L/fpaQOER/tRY
 OfDBdsD/aW+Qc29Sw3NO12NCQB0mG8phd9eRwHpfvV1KZx9UytC8LeJ9o3tIWrynfVoAPeh8vJt
 YKGGiHCD3pcy7InKgqE2fqGsyEhO/8iySVyuNXzW7CiI5L+UbltI0CcKygth0h6QIHcuJyoGAzn
 XFX5LtKQgwuEAax1oqWPn7pjD1BnYAPtn+gbjbpP8ZjXFquSRlkQyWODeKe4hiUp6gGa6W32QRG
 jxzVWaB9+cazJ9Mf67PeT4fOtbFZNu8FlWspSFF8=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696e9fe6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=H-iTgMMs9P7KWOOVCMoA:9 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: P-nvsmq95nR3Z5pkgPamkm9wh5EGlxli
X-Proofpoint-GUID: P-nvsmq95nR3Z5pkgPamkm9wh5EGlxli

The bitmap_subset() and bitmap_andnot() functions are not present in the
tools version of include/linux/bitmap.h, so add them as subsequent patches
implement test code that requires them.

We also add the missing __bitmap_subset() to tools/lib/bitmap.c.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/linux/bitmap.h | 22 ++++++++++++++++++++++
 tools/lib/bitmap.c           | 29 +++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 0d992245c600..250883090a5d 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -24,6 +24,10 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 bool __bitmap_intersects(const unsigned long *bitmap1,
 			 const unsigned long *bitmap2, unsigned int bits);
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int nbits);

 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
@@ -81,6 +85,15 @@ static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 		__bitmap_or(dst, src1, src2, nbits);
 }

+static __always_inline
+bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+		   const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_andnot(dst, src1, src2, nbits);
+}
+
 static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags __maybe_unused)
 {
 	return malloc(bitmap_size(nbits));
@@ -157,6 +170,15 @@ static inline bool bitmap_intersects(const unsigned long *src1,
 		return __bitmap_intersects(src1, src2, nbits);
 }

+static __always_inline
+bool bitmap_subset(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return ! ((*src1 & ~(*src2)) & BITMAP_LAST_WORD_MASK(nbits));
+	else
+		return __bitmap_subset(src1, src2, nbits);
+}
+
 static inline void bitmap_set(unsigned long *map, unsigned int start, unsigned int nbits)
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 51255c69754d..aa83d22c45e3 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -140,3 +140,32 @@ void __bitmap_clear(unsigned long *map, unsigned int start, int len)
 		*p &= ~mask_to_clear;
 	}
 }
+
+bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k;
+	unsigned int lim = bits/BITS_PER_LONG;
+	unsigned long result = 0;
+
+	for (k = 0; k < lim; k++)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k]);
+	if (bits % BITS_PER_LONG)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k] &
+			   BITMAP_LAST_WORD_MASK(bits));
+	return result != 0;
+}
+
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] & ~bitmap2[k])
+			return false;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] & ~bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+			return false;
+	return true;
+}
--
2.52.0

