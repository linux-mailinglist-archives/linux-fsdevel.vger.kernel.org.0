Return-Path: <linux-fsdevel+bounces-65420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85011C04D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A8E34F9A7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFFE2FD1BB;
	Fri, 24 Oct 2025 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l6OmIo7N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YR4BoARq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE42FCBE9;
	Fri, 24 Oct 2025 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291862; cv=fail; b=mkl/K9yhjWNujRo/NQRZDIXurNOIctJaWQ/ROCVAU7+rlPQp5mZaiPgcOpwcu1n1BHHuHliA3KnyCYAvWqeKRUQZS8rdivk5zCT9Q9/sgv0UVCvtzmtRl6CMPHmGKKkg1uTXHda7yzicgRvhyExQGobQZF7Xc3PDthDlLFXoI4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291862; c=relaxed/simple;
	bh=UWHX9UHnprcyLb5kMeKNmtqeEJ2U1uqpbJpiYbdUnd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gzo15uofIWquOIxlp6NMSdxyRC8nbdq+uRz/NkP5qumv5r1Oo7VBEADT7fHeSbmejjVFiTJNYiKN13v02FZ6RPJdUJek3OIEecYVYpxX77OvdvU77iymQ1uGgv42LCx9slBHcDNMvxqgIlasJWmCPqhnavv0o8OTkfjo0VcSCTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l6OmIo7N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YR4BoARq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NTOv013975;
	Fri, 24 Oct 2025 07:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LVpJDWyXcfjTsF8jl2cXqkq4T4wMAJmr5/sSgKUEvVg=; b=
	l6OmIo7NhxwK2KT6i6faafg7R9PtnKwB1NUlr9rJ7CY0CnPa3DONeiVSrESF/Ca+
	HL6AhTduZfSfjLyHlSHVJcOMWAd68d791MiZOHrnM1jTGgezw2urO+MWV2qVVlPJ
	1O/ptNChdkV4izHapjhIejYgE4H+/yovg0kQDjIeNRgpGdSd+zv5X4w6tT+ScjS/
	Yyh4y8g743WLcGs0BWY69Vo1dBpzGeFd5RbP3lmk6n6ce5w+QMR1cmASS4HTHdol
	n4hYnnEoofysUukPmwW1b7zjxbvkcc2ltXhywAq3wWoTiPG/Re4MoYgdHTA9sZN/
	aeHjHXs+TgDs+hY/7wevYA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xstymdr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5cSMF035805;
	Fri, 24 Oct 2025 07:42:23 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm583-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRjFj8ms9Fst7OZr7JXepmwnHP63SquEZLG/ArafbfymOSEO1ozKEZ45tr21qwYinGguXAPmWgQvKueVbXfTmMMsocwJriDTqJv/DjJesFBHW726iid6zxdm8seM2COOobV5dzr+1DmpNJzRtddRILL1/RftuL3GllR9H/Z1RaQc8a3Xlxo3jRVp9Ock3Aq0/rhL/AGC5IA3RBcZgcxsLGGNbtv1wJ+omc2/THzHx+LPVtTHjYfFJzMH8pER1jSLGeBbrEWEJz+rcPdRqNMnYz1irvHxR4MoDsMXPELJvebCwHs7kwVstuutEN7Wj2nTsxl/gPBJ21H8+cGnmJ9EwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVpJDWyXcfjTsF8jl2cXqkq4T4wMAJmr5/sSgKUEvVg=;
 b=UIoX/mXE8fyGTonorNlaGrDMKcwnXiHgZJQ5JGXX/+LIM6aKUL/FadQLigMcFC/Bnd2dNEro5uRvC603zdGOwAF8OPXsL3/+11gEDd1tDFxZi6pfnKAZCRO+RTthJoO+R118kf7RQ98Z4Ow3kSYOw2JVZPQ1r/bxMmMvgopNPi6XKSLSs/Mgpg4MWtA7PZm3rePY6LAyJkjoONm5B7foKaHPqf7JrNsJKweDdgiZZR7kzpNYKHawcjbV5o3WWOmLB4edzHdD9EkIEYTMRdW48EUEBccRXVY5tTjBqeiaBBeu4t1nsM3GbfJj5NB9WIF70RtKkRlLmopCDWGFfycSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVpJDWyXcfjTsF8jl2cXqkq4T4wMAJmr5/sSgKUEvVg=;
 b=YR4BoARqERw0CxU8bKSBL0/Wr6jyh4xtcdp8bTfwbbStbW7GlMO1p8kPoG/KwryQBura8t0gsK2N1ynmRQiGckJslvooJ1CiDAhbb56cDlkY3mDQuXctdsavmHwJXwznMcrDt9+aRnBXb1mOFbdsx2DZ2bKQYw0j4SG7HMsAGXc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:42:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:42:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
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
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 11/12] mm: rename non_swap_entry() to is_non_present_entry()
Date: Fri, 24 Oct 2025 08:41:27 +0100
Message-ID: <a4d5b41bd96d7a066962693fd2e29eb7db6e5c8d.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0062.eurprd03.prod.outlook.com (2603:10a6:208::39)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa4aec4-b3e6-40bd-d22b-08de12d0daf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XgmY425H/Tu4OzvpIgGAZ+dFx8IhU9jpzbJY/JgTvzaBMdrS66pxkgZv3sni?=
 =?us-ascii?Q?km9D5ojvUTHO6tCCBmLKNHUDLsOf0Rmtg3v7GsvJdlcuYDXFO23AM3sy86e7?=
 =?us-ascii?Q?E+5P4VPevb3db23J1r2y8Gj6uwHck+Ba3+XmL9kEW6L6RCxukriimE5rnIfQ?=
 =?us-ascii?Q?YAGlMcCxOq2eR+LWz1RDR4emCJIqqs/r4eDMjodUUFRzS+Qt/1FxthE3jTkU?=
 =?us-ascii?Q?C0ZKJBL8AFOs8lrJIgiaql5FJVhCAErfCIEOY2FhSLXBQyjW1lNZ/hwqjw2S?=
 =?us-ascii?Q?rISagFOVnxbLNVzFLTwGY8TJR2pi9fOt2nabWVZtRQeEni2cgYCpePEM22mv?=
 =?us-ascii?Q?A89QBY4UavYc5YGO/4x/5ZHEawCOmaaQTi85Zld4nL3+e72gfHyPgPOizAc8?=
 =?us-ascii?Q?JvT3ZGG4bgQ4JpXyJHGHmeewuPq/4MlxCMEyIOfqElNqE5BokBXjWPrXn+O3?=
 =?us-ascii?Q?Pe52jFSSdzrR6sgP9QjJd5AdKTdWUF39FwJbXg+IxzDjhvG2SbdqYPavlkqc?=
 =?us-ascii?Q?vCVgQYzGJM9HpXeTznyVgJWnJvEyOiXLnTPMZGQQ3VLkpZC2DyQbR48HN4b+?=
 =?us-ascii?Q?IOC5cf9xMQrWTqEls8iARRWV2ZE2BW3iOPwZnGOKEon8l1nPERWjYBVsUtjo?=
 =?us-ascii?Q?5CwuZXP7qcFzlFfSEmMup6J5iOs0xVLGPFMgimxOlt5d5U3ZW4gMIieIgRtX?=
 =?us-ascii?Q?l5VlGbJgtPehwKnB0Cjh/E1WrazMAfLW2RMxv0jupW4SYI1K/yZ3DBSxdTdO?=
 =?us-ascii?Q?iIt8Y6qiCE/j2dC10CAkwGwMoQUDjRIKcSuvzoJvlZD+r0j9lG0b4BV+Dnl5?=
 =?us-ascii?Q?DXln0JvtvjbErHzRdpZXXEYn3arUd3pPh/2ihFBONFOV8S3i3OGK78pfmYCN?=
 =?us-ascii?Q?n8v3TmWusT6xPTp7GtiALyOU0n9O+oqRiDYPYEMNc7d2QRcik1onwMTsmSik?=
 =?us-ascii?Q?TrUh/R6Ru3d/d/90VsrT+CCiRToRsN5qvOrSkwo0YfQFSNOG4CYU+36DsRIs?=
 =?us-ascii?Q?2290PiLsfuTEgNoNIWSGmTSNZnGmHLNWQE8ch0jd3slKrKg/GTia7c1RHdFa?=
 =?us-ascii?Q?oBASPv0Is6qX3fFn+mQcsL2d0jT72uZynokG7MrWapbRzwU2HwF+/Hkv5Xrw?=
 =?us-ascii?Q?eyQAkXjTKujQIlzwDyTd5QA1+ptcdBq4S8Hn0yRWqsiwh18ioWlE7fOuQREH?=
 =?us-ascii?Q?TmYqEGd8HhhtPKdnOM7AlUs6nb1JbuRsllBfeTS2dJo7GIDVju6dDE18ilag?=
 =?us-ascii?Q?2QqFO5tOuGKazDkux26uQAZvMZfhx5lT8RtXUImOzCF5ug0VoBTn8tb9WUdG?=
 =?us-ascii?Q?937/VRT03ZzLXtrHWJrQ4efpDn5VcH8X5Hafp157Knex3Frbxzm/8S+xxlcT?=
 =?us-ascii?Q?uyXb2YRCGi2nTHN6zgS0+6j0DnWWV/KkWpb9JgmgO30Oqez29EPBNL9yG5E9?=
 =?us-ascii?Q?bxHiZrgXJ94u1jiP3JOuvVYN/YjTzJ08?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3yINlQJFMmj4DIUNVwCLIiiFEzmG9vTulSbOIzg4Vqx8MTxScyXf4almvTsi?=
 =?us-ascii?Q?QTL1UJgJ2f5s1t1iyz7qTOr+x0bRXJd1WXskfY92glaLtf0I4sT4Tf4o44nz?=
 =?us-ascii?Q?apBsTgcMePxADRUlbjVbmyaEr0+mM1wkEL/A0Kqy5VpoM2h/wS7O26Qt+X2P?=
 =?us-ascii?Q?7AknfMoyxCks7mtZoSQp7GNgNbKglhvJM4a/bflz0bIqY8o8CSdO+efwGy/r?=
 =?us-ascii?Q?Bi2yO6SpfDQLaF0/aaSVrQ6WbhyU6KcUb3QWLpwR2GO/a7b/kJBd4FCg9oze?=
 =?us-ascii?Q?Hm9XtwukuF4SWyKtllDvDjtVdfd0td2iry2fs5QLpLETwXkDE7DuwDh1MJeJ?=
 =?us-ascii?Q?RQgQLhkUE50m/UH3yCLM67/Cu8i+k2di72RM6l6xEnKOl0kloPM/cHgPI5S7?=
 =?us-ascii?Q?kgLSJagLD1+ziBvL8TOWHBCvR1D+scMND4XMVH9E9vZO3CbhtlAIJ+pST3If?=
 =?us-ascii?Q?Wzy617q8Wgrx84QzkM9kvvUCsMpqzWbD0/mBcacic+0Te3Rerv/knV8bDpsk?=
 =?us-ascii?Q?+RCwbqYjWWX1rArZDG/tugP08Nf8Ist9VOyq+IlGqyfvdCJlXjPOqHXHZvfL?=
 =?us-ascii?Q?6WFXKINJm2Tc1vw/UX8gY8hVtbHWC/zoiPjVbEU8v8MM4WY5MYQFCplMYf8a?=
 =?us-ascii?Q?fBdqX4vMjs7wBrNVBwugdJTjafKvscAz/wbERsvxvD+wj21k9sZeRDdZtSOs?=
 =?us-ascii?Q?MwW7nFN3JfHwfdfdADyFJVICTFG1HJFmPt546d1ZN+R7DYwG+rUykfbKwuKh?=
 =?us-ascii?Q?7pWMHnfglZSSK0DSl9k2iPWLC9XrvQBeX9d+9nHAxwyv5uaNYWqcW6VjuOMV?=
 =?us-ascii?Q?cbsDdEE//jFN8epvcqLmXDskpRL3DGTGnon+y91XIFRxOSmW/55D+iCbWb4B?=
 =?us-ascii?Q?Ms6pZlBL9VF96FSGs4VWNPEuaNCSy+qvcp6q5UJIkq0qqcAoUI49sqXnI9sm?=
 =?us-ascii?Q?2hyFaPrNXQAzBGnHTxaMN2oUc+Ulz1DH/z04hJKsyk86k5/POMoWakzc28Iu?=
 =?us-ascii?Q?Hici/Ianr7j2nFkhVPQYJ9IiWd2MG70arq5JSgkEBWHOVtmv+L8gpuYGP15f?=
 =?us-ascii?Q?+M1s+kbhVQ+UFGp7+ieLfJAlFIpEDFoTIPDVkekShayhHr0KzanIP9hsNgyf?=
 =?us-ascii?Q?0RfKa7dyFE4qhJEHpXfS/yeE3H275zXTQh8KLqGJ6uTjkGRab4JFHuyG2dwf?=
 =?us-ascii?Q?eDbeyTuURF5zBooc7IsQovEJJEPaQdQ92YQuiNLU2vSzYdXr3Pcg/ertQOp3?=
 =?us-ascii?Q?G11lSDZGXK+I9Di4qBOccZUiSJQYyNmHT33Wy4QusuR9Hor2oJncS/aYKhfl?=
 =?us-ascii?Q?F/Jl3Kse/kFbR9XU9bbAcg9mZpTRg7YA0ZI1Am6TkksLHspTy4AYyojlwwDn?=
 =?us-ascii?Q?r9onuoxKWsPwJmlNrLlfKSzLTlORNsKYso+lYi0U8nGJlMOHnGAb44RmYj0C?=
 =?us-ascii?Q?gJsw8uWrJpZZpZ6Chnrungw6KJyCz/YSbBgZIG3FsAO31ZKl9chO6Q/EPCWU?=
 =?us-ascii?Q?mMoCDCge95X5S1ghtsY4TVbc5M+L6OqWF/8zGXWdbVoNzyBlLPoSMVvfmzea?=
 =?us-ascii?Q?HNrEwbhX2ADTWghx8VBhdPk5GPpDP1s3owaJRpUEfZsO75pFkpsKFah7yP08?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4+aP0lmTnMio8Ow973LthBb0XTP81IjCK3+irEXQsjmY7k0MLuN7+h14QW7K95yUGPfzF4yo5FMMx8AQWn1qn67QBkn/aGqN3R3paGKXBBZ8oauu7RqQUq3LjRgVPw5/Iq57VduPd0NUQtEe5D3uiz5zyvDOux/YOPAlT+DlXiJlpAf1B1TNuVwvJvwxfMrotl37LYPJhsgZlsF+uOqNjrqgiatX4WssDak1Pd5tUuri+Nu5bjyZLM1HavxWXf71pLVXt1aMq50/xR9c7Z/T0gQI4qswtVmXp/MVkVOatnttke2PdgU+FZT4nHV0YXzaojdVD3yCSjWONlWFKXpMBIKVmKXK6fAi36K2jfRnkDRWrrO0HExtA8TWzJMupy1/KFtQIJd87QmEKlNSqk4bTW6a9boYncwXjbvUrLtjttwtODLhz6ACINxl/hAOAC7J+8F43pG9mP3jJnlsUowc9Z8xgV9Nt6AqHzyGKRcDqCRCY42qiRzb/AumgVfG9kLUuZumRuIgvNHk6lqhVQPxL7JUPc95bLhp9KfDgKmpRHTlw6nCMavrGeHnXqTXTFkzgOvM3jQTodboBCmr2lXUPdAsZl540DQP5zablyN4eZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa4aec4-b3e6-40bd-d22b-08de12d0daf6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:42:17.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uJt1cqLFDF1dvcrPbLe3xkFJ3sEdtv4YWP2q8SnACG0Srb8bl/NK8cdSUbYMJzIOOV8WmL94f9wjf8aMKRIg3gZqlApJdDCzz3+Ld/llVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Proofpoint-GUID: rQ8M9PSRW27JN6ffzOru9tLbKUxwFRbP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA1MCBTYWx0ZWRfXwA8EEKnvuFrD
 owibirGyRxyKkvYLCa9eSZNB+WLOUZbqYxzAYROBP1aojoeesNdeQMprNz2H/J1yH1OGxsZ6ebZ
 5xuTTQ/Lxwvt/Fo62BvPhipFT7bna2iGymel8TYwSW4ltYfUCWqPV1oVuSTCnuhNdtiy9nrtNC2
 V0m1tbcaulIkrop3dXlqmBTjuHDbAvS1Prc+aeBnFaVPHXkVHCkeUypU81XlqY0YdUxB++LQSou
 L91VVJxxXLacgKPo5mD7+Xp2Pa57Eg6JNBdCRTjlA8nFvZ4vjMBWOnreaU9LLJh2J0k74mjIEpn
 y7u1LEdbXf/FoDzzCYMt6GjGFBlKBeup52b3Uqeofi/y/s8frWGUTsDhkmA0ZzQL7fOzY1vARdU
 86enaTDaBIyaGglgxp0Plfd0Lr2g0jvPd20+V+vHYkQWsrGkXuA=
X-Authority-Analysis: v=2.4 cv=OdeVzxTY c=1 sm=1 tr=0 ts=68fb2de0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=axU3H-fZgswgVZ17bgAA:9 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: rQ8M9PSRW27JN6ffzOru9tLbKUxwFRbP

Referring to non-swap swap entries is simply confusing. While we store
non-present entries unrelated to swap itself, in swp_entry_t fields, we can
avoid referring to them as 'non-swap' entries.

Instead, refer to them as non-present entries, as opposed to strictly swap
entries. We achieve this by renaming non_swap_entry() to
is_non_present_entry(), which also adds an 'is_' prefix for consistency
with other similar predicate functions.

Also update comments accordingly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/s390/mm/gmap_helpers.c |  2 +-
 arch/s390/mm/pgtable.c      |  2 +-
 fs/proc/task_mmu.c          |  2 +-
 include/linux/swapops.h     | 21 ++++++++++++++++-----
 mm/filemap.c                |  2 +-
 mm/hmm.c                    |  2 +-
 mm/madvise.c                |  4 ++--
 mm/memory.c                 |  8 ++++----
 mm/mincore.c                |  2 +-
 mm/userfaultfd.c            |  2 +-
 10 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index d4c3c36855e2..2c41276a34c5 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -28,7 +28,7 @@
  */
 static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 {
-	if (!non_swap_entry(entry))
+	if (!is_non_present_entry(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
 	else if (is_migration_entry(entry))
 		dec_mm_counter(mm, mm_counter(pfn_swap_entry_folio(entry)));
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 0fde20bbc50b..0c795f3c324f 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -685,7 +685,7 @@ void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep)
 
 static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 {
-	if (!non_swap_entry(entry))
+	if (!is_non_present_entry(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
 	else if (is_migration_entry(entry)) {
 		struct folio *folio = pfn_swap_entry_folio(entry);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1c32a0e2b965..28f30e01e504 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1022,7 +1022,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	} else {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
-		if (!non_swap_entry(swpent)) {
+		if (!is_non_present_entry(swpent)) {
 			int mapcount;
 
 			mss->swap += PAGE_SIZE;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 8642e590504a..fb463d75fa90 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -645,7 +645,18 @@ static inline int is_pmd_device_private_entry(pmd_t pmd)
 
 #endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-static inline int non_swap_entry(swp_entry_t entry)
+/**
+ * is_non_present_entry() - Determine if this is a miscellaneous
+ * non-present entry.
+ * @entry: The entry to examine.
+ *
+ * This function determines whether data encoded in non-present leaf page
+ * tables is a migration entry, device private entry, marker entry, etc. -
+ * that is a non-present entry that is not a swap entry.
+ *
+ * Returns: true if is a non-present entry, otherwise false.
+ */
+static inline bool is_non_present_entry(swp_entry_t entry)
 {
 	return swp_type(entry) >= MAX_SWAPFILES;
 }
@@ -661,9 +672,9 @@ static inline int is_pmd_non_present_folio_entry(pmd_t pmd)
  * @entryp: Output pointer to a swap entry that will be populated upon
  * success.
  *
- * Determines if the PTE describes an entry in swap or swap cache (i.e. is a
- * swap entry and not a non-swap entry), if so it sets @entryp to the swap
- * entry.
+ * Determines if the PTE describes an entry in swap or swap cache (i.e. is
+ * a swap entry and not a non-present entry), if so it sets @entryp to the
+ * swap entry.
  *
  * This should only be used if we do not have any prior knowledge of this
  * PTE's state.
@@ -678,7 +689,7 @@ static inline bool get_pte_swap_entry(pte_t pte, swp_entry_t *entryp)
 		return false;
 
 	*entryp = pte_to_swp_entry(pte);
-	if (non_swap_entry(*entryp))
+	if (is_non_present_entry(*entryp))
 		return false;
 
 	return true;
diff --git a/mm/filemap.c b/mm/filemap.c
index 893ba49808b7..1440e176e124 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4553,7 +4553,7 @@ static void filemap_cachestat(struct address_space *mapping,
 				swp_entry_t swp = radix_to_swp_entry(folio);
 
 				/* swapin error results in poisoned entry */
-				if (non_swap_entry(swp))
+				if (is_non_present_entry(swp))
 					goto resched;
 
 				/*
diff --git a/mm/hmm.c b/mm/hmm.c
index a56081d67ad6..66e18b28a21d 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -274,7 +274,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		if (!required_fault)
 			goto out;
 
-		if (!non_swap_entry(entry))
+		if (!is_non_present_entry(entry))
 			goto fault;
 
 		if (is_device_private_entry(entry))
diff --git a/mm/madvise.c b/mm/madvise.c
index 578036ef6675..a259dae2b899 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -248,7 +248,7 @@ static void shmem_swapin_range(struct vm_area_struct *vma,
 			continue;
 		entry = radix_to_swp_entry(folio);
 		/* There might be swapin error entries in shmem mapping. */
-		if (non_swap_entry(entry))
+		if (is_non_present_entry(entry))
 			continue;
 
 		addr = vma->vm_start +
@@ -690,7 +690,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			swp_entry_t entry;
 
 			entry = pte_to_swp_entry(ptent);
-			if (!non_swap_entry(entry)) {
+			if (!is_non_present_entry(entry)) {
 				max_nr = (end - addr) / PAGE_SIZE;
 				nr = swap_pte_batch(pte, max_nr, ptent);
 				nr_swap -= nr;
diff --git a/mm/memory.c b/mm/memory.c
index cc163060933f..8968ba0b076f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -847,7 +847,7 @@ struct page *vm_normal_page_pud(struct vm_area_struct *vma,
  * @ptep: pte pointer into the locked page table mapping the folio page
  * @orig_pte: pte value at @ptep
  *
- * Restore a device-exclusive non-swap entry to an ordinary present pte.
+ * Restore a device-exclusive non-present entry to an ordinary present pte.
  *
  * The folio and the page table must be locked, and MMU notifiers must have
  * been called to invalidate any (exclusive) device mappings.
@@ -931,7 +931,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	struct page *page;
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 
-	if (likely(!non_swap_entry(entry))) {
+	if (likely(!is_non_present_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return -EIO;
 
@@ -1739,7 +1739,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		rss[mm_counter(folio)]--;
 		folio_remove_rmap_pte(folio, page, vma);
 		folio_put(folio);
-	} else if (!non_swap_entry(entry)) {
+	} else if (!is_non_present_entry(entry)) {
 		/* Genuine swap entries, hence a private anon pages */
 		if (!should_zap_cows(details))
 			return 1;
@@ -4646,7 +4646,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
-	if (unlikely(non_swap_entry(entry))) {
+	if (unlikely(is_non_present_entry(entry))) {
 		if (is_migration_entry(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
 					     vmf->address);
diff --git a/mm/mincore.c b/mm/mincore.c
index 8ec4719370e1..61531a7cd8b0 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -63,7 +63,7 @@ static unsigned char mincore_swap(swp_entry_t entry, bool shmem)
 	 * absent. Page table may contain migration or hwpoison
 	 * entries which are always uptodate.
 	 */
-	if (non_swap_entry(entry))
+	if (is_non_present_entry(entry))
 		return !shmem;
 
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 00122f42718c..04fab82a1119 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1427,7 +1427,7 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 		struct folio *folio = NULL;
 
 		entry = pte_to_swp_entry(orig_src_pte);
-		if (non_swap_entry(entry)) {
+		if (is_non_present_entry(entry)) {
 			if (is_migration_entry(entry)) {
 				pte_unmap(src_pte);
 				pte_unmap(dst_pte);
-- 
2.51.0


