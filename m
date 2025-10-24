Return-Path: <linux-fsdevel+bounces-65407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A2FC04CF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D4D3A33BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0DC2EAD0F;
	Fri, 24 Oct 2025 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rU5n0X7R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lal68pwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B22EA17A;
	Fri, 24 Oct 2025 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291773; cv=fail; b=ftW6pRk7By3TFlONuK0DGjEhBEOicDOv1T5OaSlGdRuSbiqQ+TYPiWJPeJ6p9D/fFzxfLwT7PmcYXH4Pk/b2p59/rRufQaRzIsDhD0yOVF8ANMvCHtnMYK3Lp9XbQCfOXRZFVin8QWZH6yNay74vNftIyNVYeaKIwL7rcS4Qq/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291773; c=relaxed/simple;
	bh=BChO7Rau7gmgkwOm5A+sCibX4ZI8WzKHOVrVk+Peq0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWxBpc9yyc4foUb3YAR6FPJYMjWXm2EgWBl96TqivQmknU6OUoghfgU6Adz6r29U/M53Mpy93CcJMZSnqjXlGzi6z4MMKhlwK83dQ8dRgyKI4W6RG7ZvmS2ZLdDZpHFe5FW2l/phWR55q47tmhrJZWNSEHs5zuMO59WYf91Sv14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rU5n0X7R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lal68pwL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NJ6P021549;
	Fri, 24 Oct 2025 07:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=41DtXBGfoXkb6wW3BSgju7bwEbVsnazQBfxYe46KuV4=; b=
	rU5n0X7RJMt0dU3zBnOJaojivjm105SnFXb3fmPXAbKztErB3z7sUGgvlSUK8qiv
	CNbi2H5oEK5pKBnEXnD8Aam9dSJqOCteXwTkfu9qeTAV/GXuGncU746qOHeuB/pO
	T4ar2xXu1xJog93s3L5hPMD9aUiJUO/eHhRY9nu/5y80Ieu3xpOlYVY3B5EyuEss
	Wee41A/MiOOB3TlLRqv2DI5v8StzF/+LfTl33ViyYVLCuPfc6glUM5Ifl0GSgvdg
	nrM0mZ7/N09pJceAwUsC8ChvKbFUNhvsvXBdWKXDWdaBE0hadDbCw2EPVtwHh8PM
	/4qVCcqWguayAYOMLMr00g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3k46by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:41:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O6JkJf000823;
	Fri, 24 Oct 2025 07:41:46 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfj864-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:41:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GixRPlqgathbjf+Ms1X9i0JSith3Il+6hSNyGlSiAAAeo5N9mxNWjiK1mlwu47IBjUD1M9uFd5qKCzJidIQS0cQ2F/ZaYP49CtkXOBMImu83gAEPq6BSuH179DF0t0khZIp8tCnOm8LYiYcJFZLm31NkJQ4ECi4Fpo/eUcG+MoirAEGGIcRLi6AlWi5R+zlbl7+IUgnXdQIIoUZdHaExHqwwFLBJV4ItrZ4++Kd70DJPGiPX1CskAiMFGO+Uc2QiyHGyCAMdU736+Wt7uJSVjtsY7bin1SNHcUPu5uwNfB49gy3kOZ51VhKciKzQJ26Od/xp6uy7vBhPXN7YfI6FAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41DtXBGfoXkb6wW3BSgju7bwEbVsnazQBfxYe46KuV4=;
 b=e0+eEzjQjeLlzU8n7XnKVIK+YV/1JrVpAnUthb8BiWN1Pe32aAH1RT+Gf3uxanScY+VDEIkV2XmsbaRwr1YyFLB5vPkegUGz2Bg6MtYccaIgYTWqt/RBJXlxUaJJ5RyJXNt4v2Z6zlL7GeJN5Ra7n20GswdI1H6wcm/lY6ew91FkQ33d8XQD4AVT2Jit3kUkM7FMeu+dOuNAlKhRzG/2POmU12WMYP7ymL20wl8Tk5CyBSJgShREKcnxG/j+5K6B0XMcD2u8DP/wi4jT1nRweuDCMB9BmzfMo6LIMlekFVB9lMSyjlm4c/YuYgriplq1C6/Y8a1Kgz5UlwGH1MA1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41DtXBGfoXkb6wW3BSgju7bwEbVsnazQBfxYe46KuV4=;
 b=Lal68pwLi7s974YmPp+sbOwnY8pqdTlxVA77gLcqEQzMNHHe/31Mj2kmYLqwnEV8AH1jfcf5QesrbFL+3quStUv6lKMGgN4YbkvwvAsVLq3BXJEJIqXy/NepOhlpvkXSPeUFdtyJ8oTAZiY4T6AU7JZe18RTnhFztt+1Qb/Eh7c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:41:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:41:42 +0000
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
Subject: [RFC PATCH 01/12] mm: introduce and use pte_to_swp_entry_or_zero()
Date: Fri, 24 Oct 2025 08:41:17 +0100
Message-ID: <ebfe7ddeb8a165b757ad08c346b388c3dc7d6140.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0143.eurprd04.prod.outlook.com
 (2603:10a6:208:55::48) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 9067c73a-3f4c-4bdd-50d7-08de12d0c69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7b+a4b6cfUul1vMX/uUC1tSyisNMG1M8iHL/rKNbV2OO9I3hvltrTnHYV95F?=
 =?us-ascii?Q?lRlG3jeoWwdycl/FF16CbcFOCNmKaUp7cqJl4QbDzDcP8cBLUxHYO/Pzb3xr?=
 =?us-ascii?Q?baiIONC6sUY9XtErlhhSUV2eEV6B9mQj5muIjB5AuhfN06UMTZpYrjNXDgeA?=
 =?us-ascii?Q?sy1xuj+Nl4CCHIERYMQx7mXTKHljTLU7YIlUgC2qQwIIaUsZB4Y9mRK6ohvk?=
 =?us-ascii?Q?+fyqI8aD2IoQm4Z+zu0ky0Tk6zxxS9L2B5TwYYC3Rq1FINQWtXnCHT1cR9GM?=
 =?us-ascii?Q?PFff9y9FfdVFAIc0DKhN/bNdP7gtKQ+6VzN3dBhgENlCnhL/AWx6gmfDXAsB?=
 =?us-ascii?Q?ms98sWVBnW0evHnpEDKi7GdtnSpmnJGO3fpzpLyTqtV4UFXNG0ja+NgRTSvd?=
 =?us-ascii?Q?A/M9NU/8gSWZBpKdYEoEvim2j/mIXjRs0scTXaVfH3+JwIE0TOCY+BTu00a2?=
 =?us-ascii?Q?9eGNZU4qDHPFzC5vYUOcQkWPGECS0XUtFusysItdqIkUbdVFhjYdX9+QmNw6?=
 =?us-ascii?Q?CUg98q5q2jUEOeHKv+1LzN5PAnLm7TRNQvPOLfJwB/ZQFUn/aUWcrOHq3jnl?=
 =?us-ascii?Q?wQEgDCbIge6Zf2hqiAfz2Dm/nME/Kc464wf6TOVq3nNoWLihkK0NJgPZgGDy?=
 =?us-ascii?Q?nMLpdYuuaO4nm4Tq7yo/AT+DSHn0dkdSM/qTs/KLpn/Ik1FbuUjFdLTPWxxq?=
 =?us-ascii?Q?0s3ipv5K203MYOldkQVJOhEUGyM1SefLApD41AoxXu2/BcA5E0SnpFKxoAEA?=
 =?us-ascii?Q?RWbQ2lkS4oKVqUVxaNFdyckU3Zs9tPLcEoVu7IXKR/ROi4nflR+N3wsOa/pG?=
 =?us-ascii?Q?kDWZhBil2qGu4Ig3wanIaf07Gc2mX6sDBDRXqP3WArom71Uvb7KEa5c9dH12?=
 =?us-ascii?Q?b+hEzEtjh5PBK3F/ZKT0tHH8+6sxgBSrAMDGpmf04bElme03g8dfLBkuQ2S8?=
 =?us-ascii?Q?s3DRvtcXYVmaDqUbpymW9nW5do2Ruz6hYh4gHRzZ+BKUIDLXBs+liQ0rhftH?=
 =?us-ascii?Q?6yOVx8+9QY1H6AZxpKYz7qUBNdET+nxXc044slUFhnKIeMVGpjBlcCk0NS0u?=
 =?us-ascii?Q?QWd5u8lF1E1OxsypvocYO6fDFHWwQNsRoDLl/YBIDIcy+8STBdeKuXJ3vlOK?=
 =?us-ascii?Q?+7ywn3SLNhrKwSolPUh8++Vd4A24yVm3O/4iJjMZbI8YzANJjAKHxEdH/aJ7?=
 =?us-ascii?Q?L/cqbxBGYr6tPa9xGYEKfC/kiBjSm3L09SW2bX5X5kocwdziNw9tl6q2mZlG?=
 =?us-ascii?Q?klZSUBPcp3kJYsJwym8ummOkkUhcXM3qvH8pQh2mfNzEG20Z4KWlo/VIZON6?=
 =?us-ascii?Q?IG6k+cyICYRFVa1MTd4l7SWDTuiNspGkQ2lrHGh8Y4Oowjq1CwFE5Phy+Jbh?=
 =?us-ascii?Q?c4Oa8hruiG/7Fg3zUzIFGiCb/JuM8oLWBWBudZizZH89ERIRc53pMRsD5TQI?=
 =?us-ascii?Q?TeSAGcQWFjxM5M+r4RwNEj5RGDVV1AZY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rv/nIknS1AYvRYz9G5B+0SukCCYR/wq49QhsE0MzH+DiIR8YKsnUfhMZUar5?=
 =?us-ascii?Q?QTNmebkHHJ1F9IZQt/MGftpy66G2okgqJ5cRvh6fZ4z2vQ/hUsSk1dxZIsMp?=
 =?us-ascii?Q?8tFMhaK6RvdAACLPXVDKmwZmvXg5NqV9pvhBUchevbzm6ew0M6q8mqEb5o5V?=
 =?us-ascii?Q?O2za7G6Wy94w36yy5wyOa0RKfiGGDrHVi/Gs7BpBS+/VpHfXWQBT+ZnDD1zY?=
 =?us-ascii?Q?uQqgaDc4pUSodAixL2d7fl7fECOxx+OXzBHQ6VTOuXNCa28qXiISsEhgUN7I?=
 =?us-ascii?Q?6G3oTeGgXWaUYeqWeN77qroIwjiwGrKYjp9NmZXTpRLUUqPGRjke6F6o1Mqd?=
 =?us-ascii?Q?JyUnq7o9/gzp9qZxQvq+gZ3w8w/4/UrLQ+/pJbJUZM0NzSP8s2W4dSqI9EEF?=
 =?us-ascii?Q?6sW1KTUEduK4GJgu4RDiv5DuyfS/7K6rFXRMNwP3ydGZxnfx4SaC2Bf9LMl3?=
 =?us-ascii?Q?M0GqKBR824eIrIDBmuQ7GEDLM+O4qBlT1aUzu3BPLM7R6rZpxmNnWckOK15z?=
 =?us-ascii?Q?KfSoB5wiHK4KUZzHShfvMqL7G/XIZk4ZB0E6bxPTulV1Xshi3/BkY+eG69s0?=
 =?us-ascii?Q?vWX3uVDU+N7nSSI7pVGqAe1xpbFOsEBOvnsWbfwdA1kgy6e2oXxtl4o6sqV2?=
 =?us-ascii?Q?RSiEPCC0kMiyqqsixOsImQhQ+Uhja4/tHRRU47TUdsXPSdzmYhOML5YQgUcZ?=
 =?us-ascii?Q?mdcsZu/hdejG9t4jl65fPlG+80lbKdI/tfzmWYnSaMhfCtXT/SS9pUIWaySN?=
 =?us-ascii?Q?oDLXbiB1lk8SBV3GVMH9V69iJx6ZebQlMl4sdwUemmVOuwzoBdYte8jVrTyc?=
 =?us-ascii?Q?Z4ER2/pDUxhg5GTidyzAF/onGrmvGY3XacVqmW1s6C+Uju99G3SP9OG7t2ic?=
 =?us-ascii?Q?Ssdx7DJRLKqv0ulLtVTtRAgsTtrKV3rACza+0a2tQEp5BfeK7aH1HNm8mzxZ?=
 =?us-ascii?Q?6bY6ayvEB3Tbae04DkoabalYvsKIaa7EYjGjmVKLN9vjZtHAjOwVY//b/Nvh?=
 =?us-ascii?Q?yaW97qzEberp1P9FJKiwDb4Z8OxWCdTlClNv8agjEXfMJ0z7r1LPJFMQkXHe?=
 =?us-ascii?Q?g2FVcFO5EteD9wvmAuY6MhNdexCrF6qWHGLUOv3hFKca6V+rFo6LIkEMc3jC?=
 =?us-ascii?Q?qlHGkB9/Z/jPNVfyZVMwBIv1Jmgy5RIUpOGaHPGDkQpvpnIdhL3fELRW8Gvb?=
 =?us-ascii?Q?ubBzCiqKZ3T8viN1NkgM9z70cgD4r1b8NCUAqPNEhNH9bRWDlddMz/g4DE4b?=
 =?us-ascii?Q?9XeDLxqYmgv9OL3ptLulnGqDSiuUzz4G3CJoB6IVe39rv6bWCFZ4N+B/aNJs?=
 =?us-ascii?Q?2UHDdLqCfGEVLNxky+w8oyPOQm5tLpoPiFneXvproa3hWq+TnSin1np5XCBK?=
 =?us-ascii?Q?zrUTkmXqzAGxMHqUbjjU2N76aCJHV+IK1WIvQK5UiIGJTZCrW4jri2zYPFW3?=
 =?us-ascii?Q?KppoxdfhX3Jmo4euxlBcwMnYa/xL4NFOZL3bzAxDnPImStZbZkF9YrjBD2wV?=
 =?us-ascii?Q?K4RXQfvkXwfkEPL3rmUQqwkjA/3Dd7OI4wPW1yEI3yGL4IgQpGkdx6hQE1cz?=
 =?us-ascii?Q?gsG10UF0yHxmK/R3PE8yWuv4FE0EVWauAbJf90adI5fMminQQ6i3J1pnk0Xy?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ddipwzKUk2bZTs1wX1rzIhS+BTl9GBbe8+6sQEkdaloqwuD5SB+6MeRXpmqR5mgSb/mMxrUVkOfXYIk0X90UsGoeohtsk/8nk3fMdB6dRhvpk/Zs5YzmvDjTWW+Y5iMjBUM2jNL/d/bQB8MCap9reR7qZMqBDk4fJyXZyto9EwslBeNxAiTIqoNqtmKopM2ibO0ZeHvuotTZDCppeO0ceWdtWlqH0Q3GxCh26JGb5RVuGp+AkWovn27luEFErIq7s1QHwSSry7/MsYoYPBzndKB530p49kJsyvhkR2mmlPMiSFAazgSaV8IeurQk37WVXygspUg1pKGboi4YCLx1afPLQkiKjBI82gGvsaI8h4gJUtzLvjpNztjj+g7T0oX4Yd1DUi4/LvALcBsy9iwgrPqY58k6nCbssWKk8W9/XATL4iZxIUhQqjrPl/Hs59I0QJ0FFVBitm+PCSQprzgV0vNq7H/hpTdTeBlTU+kZnbeRodc2dJuwsTMTXho0obOqaAqO4ZSpAD3sUTFE4ntv1qVPdh9OA9nXXeOl/0cnoqfk7RoYihj7VxI11JIzcxB2Bw+GXT14fodHQqEoq3eqJqtKU4Oo40oOV8O1FFau7YQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9067c73a-3f4c-4bdd-50d7-08de12d0c69a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:41:42.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPnOyQnuQoZ7fWNxsgDgAcAbGrWyM2SOX3KnVomRZKp3YNGH2Z2X+HqISTPu6XdI3vTgn3VRruXrXBlzgH06uIa/rXjHdju4E5D9XDNSBCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Proofpoint-GUID: Lj0FRVfCIOeFRpe5zjres3GnVVmjv4SI
X-Authority-Analysis: v=2.4 cv=bLgb4f+Z c=1 sm=1 tr=0 ts=68fb2dbb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=ygVAc9bbd075Xlgyr48A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX8czeh9ILKmEs
 lUXyw4e0dgRGyHjTRobnxvfEuB3GA/1Y/FpyuKsTduX+JZVujmd5VXEN9WVvQBgRruvZj5f2Sf8
 HVME7KrRpDXdBJ3yR4dvMUMsupTRl3mViFUqVWUEOHiEQWHWk4fjgYUxH1Fh8j/luBFKhZR6FGT
 EDLK5hTbIRaniQmTB7V4I8NrIWH1msnEplws/iuxf91lQwbF5XIi0GjPR4u5v60zLN7C6IQ6DdN
 Iy5KSZ2NxJyaNUwBiw2uUaNco2HH6q4SofzGeDiVG+ZjGWQJUboIjs7fmxdkp0XtSVIPoV2snH6
 uWqg7fWvyXqqtUyd/n/RfpSuHYiGCSl/EHFkuaeM6NO2wKkExtXYCLSdzUWgZCAb8Ne1Mk3Wbnm
 Ds4ZbDQ+9fjZfcGJxH9hCctbSPFWLA==
X-Proofpoint-ORIG-GUID: Lj0FRVfCIOeFRpe5zjres3GnVVmjv4SI

When we check data in swap entries in the form of a predicate it is usually
the case that if the swap entry were zero, the predicate would evaluate as
false.

We can therefore simplify predicate checks where we first check to see if
the entry is indeed a swap entry before doing so by instead using a new
function which returns the zero swap entry (that is, swp_entry(0, 0))
should the entry be present.

The pte_none() case is also covered by this, as it will naturally evaluate
to swp_entry(0, 0).

We implement this via pte_to_swp_entry_or_zero(), which we then use in
is_pte_marker() and pte_marker_uffd_wp() both of which otherwise
unnecessarily utilise is_swap_pte().

We additionally update smaps_hugetlb_range() following the same pattern.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c            |  4 ++--
 include/linux/swapops.h       | 20 +++++++++++++++++++-
 include/linux/userfaultfd_k.h |  7 +------
 mm/madvise.c                  |  5 +++--
 mm/page_vma_mapped.c          |  5 +----
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc35a0543f01..a7c8501266f4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1230,8 +1230,8 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 	if (pte_present(ptent)) {
 		folio = page_folio(pte_page(ptent));
 		present = true;
-	} else if (is_swap_pte(ptent)) {
-		swp_entry_t swpent = pte_to_swp_entry(ptent);
+	} else {
+		swp_entry_t swpent = pte_to_swp_entry_or_zero(ptent);
 
 		if (is_pfn_swap_entry(swpent))
 			folio = pfn_swap_entry_folio(swpent);
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 2687928a8146..24eaf8825c6b 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -139,6 +139,24 @@ static inline swp_entry_t pte_to_swp_entry(pte_t pte)
 	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
 
+/**
+ * pte_to_swp_entry_or_zero() - Convert an arbitrary PTE entry to either its
+ * swap entry, or the zero swap entry if the PTE is either present or empty
+ * (none).
+ * @pte: The PTE entry we are evaluating.
+ *
+ * Returns: A valid swap entry or the zero swap entry if the PTE is present or
+ * none.
+ */
+static inline swp_entry_t pte_to_swp_entry_or_zero(pte_t pte)
+{
+	if (pte_present(pte))
+		return swp_entry(0, 0);
+
+	/* If none, this will return zero entry. */
+	return pte_to_swp_entry(pte);
+}
+
 /*
  * Convert the arch-independent representation of a swp_entry_t into the
  * arch-dependent pte representation.
@@ -438,7 +456,7 @@ static inline pte_marker pte_marker_get(swp_entry_t entry)
 
 static inline bool is_pte_marker(pte_t pte)
 {
-	return is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte));
+	return is_pte_marker_entry(pte_to_swp_entry_or_zero(pte));
 }
 
 static inline pte_t make_pte_marker(pte_marker marker)
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c0e716aec26a..4c65adff2e7a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -447,12 +447,7 @@ static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
 static inline bool pte_marker_uffd_wp(pte_t pte)
 {
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
-	swp_entry_t entry;
-
-	if (!is_swap_pte(pte))
-		return false;
-
-	entry = pte_to_swp_entry(pte);
+	swp_entry_t entry = pte_to_swp_entry_or_zero(pte);
 
 	return pte_marker_entry_uffd_wp(entry);
 #else
diff --git a/mm/madvise.c b/mm/madvise.c
index fb1c86e630b6..f9f80b2e9d43 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1071,8 +1071,9 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
 
 static bool is_guard_pte_marker(pte_t ptent)
 {
-	return is_swap_pte(ptent) &&
-	       is_guard_swp_entry(pte_to_swp_entry(ptent));
+	const swp_entry_t entry = pte_to_swp_entry_or_zero(ptent);
+
+	return is_guard_swp_entry(entry);
 }
 
 static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 137ce27ff68c..75a8fbb788b7 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -107,10 +107,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 	pte_t ptent = ptep_get(pvmw->pte);
 
 	if (pvmw->flags & PVMW_MIGRATION) {
-		swp_entry_t entry;
-		if (!is_swap_pte(ptent))
-			return false;
-		entry = pte_to_swp_entry(ptent);
+		swp_entry_t entry = pte_to_swp_entry_or_zero(ptent);
 
 		if (!is_migration_entry(entry))
 			return false;
-- 
2.51.0


