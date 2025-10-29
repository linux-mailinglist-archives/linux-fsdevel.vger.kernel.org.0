Return-Path: <linux-fsdevel+bounces-66348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AFDC1C995
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 18:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCAB44E2BF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82BF354715;
	Wed, 29 Oct 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J0isvBb6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FKtjbfzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327402EC086;
	Wed, 29 Oct 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760254; cv=fail; b=hZR6AODWcl61lJ5hpnWl8oYCQrG3efAG5czfl34TRgxAvbD0Ct5nv3dcLPB9Wws6rXsPxYU+ilaXqo4s6OuNjrmaDIL1Yh/k2NPq6LiiTIjd2KilIoKpg4lNSeUGjg6if9G9HB/B7QSIKtm88AEYp6kk6HBwFTQ8g67bgwGqL/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760254; c=relaxed/simple;
	bh=hYuBBL5Y4z6++SrDe2V1D0A229u5hQxcxNWqjxAbhDA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZFp37MnUT44RC707ed8TUMV+vAz/d0EFwyD94w8oZonOpTA1Hy2i/TtWhh97Wro1EwLpiZo8OiWtyw9Xs0IM42TSo1P+7xYBVaVBYBRM3a7i3FXqMrc0NK/tuqkiDcln+ruOoCW4yml4Ejv6A/B7+k5GWilyzl3v4eHbbdRlXEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J0isvBb6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FKtjbfzt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGfsAl011054;
	Wed, 29 Oct 2025 17:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=xGqO5D5EtIQzCO9G
	7kBawBJiIrNeeoDKgPGbzvVZZAE=; b=J0isvBb6xO92sr7v6aRDzzGYjQJ82/ph
	UK0KcxWJSKsSyQt6/Nqju7YI9xryaxWIilJW3ylJNkS9w62EbS3SEP410OFQbwaj
	9gNCEbuZAP96ZeEvOVyGOlP4oxxn+9LypPQ1di8buqQGbhN1lcsErqr6e0ka1Haj
	flEIxiFaW+254fs+ZONVEaObqKd4m57OMdImUrmB5D9aWvbtDYS3hgBtOZf54rem
	xQNWare+hf82SQy/YBFea5BlxCg4igKLJlvmmUJBTRsPX+kyTvsNKcKKc3XKkWXY
	tK1nd49ekgkUaBwCNhEi+1JopLAP8QoSfv8KQyoZSuH+85AHexOvKA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vxjh6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 17:49:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGEIGm021287;
	Wed, 29 Oct 2025 17:49:48 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359u6xpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 17:49:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiMvpGZ9yDHtvNjmCUmzwu8+j7+UrKjE4mbebikNbUAkYItCCimje+o6uqa5xFXO8Pnrf1fXc55jhwIaxRYvXWoawTsLQbBUcgG0BI2sboEfHpoaDKDZxPC6n4l6eUs+iRDLTM8ofAHQc9YyjZnOKil4uwU/YytXXnhWog0CaIhThsXXaSe0mWxrS76CT+mtxaItdOZsrGzap/9gev9sC9nGTzuLQyGcXJR9Qkwc2gtPhVjJQa8damIU1tPLsMHW/WXo1xwO+A84ImQQztD1RxxOfVb4lXIJ/vrtuyg74VcUYj7ex1VzH/wbaM/GUYlnwqV48MTBWH5w3RaIJ0YD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGqO5D5EtIQzCO9G7kBawBJiIrNeeoDKgPGbzvVZZAE=;
 b=EXRvL2dLeDTd/aV43yviNVPrOaTc2zDXcvAmHQMAAGL0Vqh1QauMx+kNOmZrmNd5sbm7ojFkheugCvb1vjIdO+Ff4JG+Oc3Aulj+yrJcljetjRdLXt3oVqg1eLl5zVIV6m7gtyru4aVUcSBGtRbJfSgLg/Nj5JysZQb3RStSzcYS+ixOUgj+9b72aZ3P67VAnFbkba9EbP0u6E3Vy5Xe9V9ckayTz1ornW3nQhapUGomocJE1LqvN61kkIRfJGiDEUJWrHGySoqzSqvohivLY1kUjzLO7a2RmQdwpH/WBN1QXLoWqkbDdebRcNq4s9hSR3qvkTOovKyUb7JtBeVqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGqO5D5EtIQzCO9G7kBawBJiIrNeeoDKgPGbzvVZZAE=;
 b=FKtjbfztNjE3azl5oEMInNeFjgvgpGIJqC1TQysdeWGCDTFnWTgx+sN9gXP12Q3f+T0fiEXwwBGgt5Kv7BJSe5Qq9IDnaNSYV/KiYf13kPOI0QFEPHWF5yW51eV/8ZApOOtVfN7mhlE2nrpm1tYxTyKLEjF7tZHKVqxHc8OWNbE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:49:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 17:49:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/4] initial work on making VMA flags a bitmap
Date: Wed, 29 Oct 2025 17:49:34 +0000
Message-ID: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c1736c-c8d1-46a9-5e13-08de1713895c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uan6OgpC3q6fPAZuTuv0mtA9DoyPAPce/AnTfx1jgOpBhzz9oFej9LjF/DSo?=
 =?us-ascii?Q?7AJcqksm+RA2GzoSw/ci5ugCsGPwPCJ26Auy0SA4pYDDJU2Iou0flaPu3Ks3?=
 =?us-ascii?Q?48ymmZIwiM0WD71RCElGHmmeaNPeqA3uAMhmj2ZBdsH88KFSJscBKcH/P61y?=
 =?us-ascii?Q?0FDOx6g15SO8C865hc8/ZUmfrB/SCLyuvHdFxNQsM4P2wtqWTe/RaKl7tpo+?=
 =?us-ascii?Q?O5wZaOAtuVpVx+awAG6XUoloASqyAurWCtlBNWaVMw2cjnLEINe01wF8TQmr?=
 =?us-ascii?Q?sQGz6EXgTnsIo+rcJqS9At5flFgiUYigVQ9dmxlhFSuiMf5PJpuuEMVBEEVT?=
 =?us-ascii?Q?0eKwgOiBVQ8u42hsYZyiyjs0a6d3rIfaE2DQZm9YQrSDZkPdRZrkNEQFISbB?=
 =?us-ascii?Q?KqP83AKEODPSS7GdecjWLxDhQWlYcDywBy9GwGKSCkec6+hCWW29x5hNUW/Z?=
 =?us-ascii?Q?1WpXb6C5tIvcF8+K/h1tcD7nWtYJQNerN5Bidfuhls2cbVmYWqEIutC6Oz+B?=
 =?us-ascii?Q?hmM4rf7Lohvghgcz8QvUJfDcmuFs4LNXdIcODFTTh7yiTJB03paHfbkpNwZ4?=
 =?us-ascii?Q?OQx7WrwjodstHyfOTNJObhlyclnzVjByOJtwxtt9+t0DOC3/Zq0ngUj7zd2h?=
 =?us-ascii?Q?htaKnFIltE5QOQnFqbG7eOEG+bowU2/4XCpWqJOKIEiWWQqbgqP/eU/LW7PU?=
 =?us-ascii?Q?KL+lby8j0YoVaJMwpTDM4rI9W9kmSzfm1yJpyqlcOFe1xV8t0sfmUKWzZkGI?=
 =?us-ascii?Q?unRUE8M9lVDEni+rRmyCsNIfgXU6+xBsqPRD9zhJzcAYxMAFpgCKFGE8jtz5?=
 =?us-ascii?Q?A5gn6lBkDAszIIKIWlWqLfGzUNqkRACQ7khcdPiAr/d+ddwf24yOjShDjCdd?=
 =?us-ascii?Q?PdH1iTYD4wZm72BQGZh8cZWr5jekrEjgP78m9+H6yn+EwR1nKQyvUNSSWEmb?=
 =?us-ascii?Q?G4Qi1hhq2t/4LEAVv9FsAIEhZEF9qsfM74RLX77A2d0ylCbjh/nfB6Rvo98l?=
 =?us-ascii?Q?SVIPzIF6l/SaDpxXZfbvjmFXsfW4q7qST43zyXku5wiYVFHz3c2zoOwzZ6qy?=
 =?us-ascii?Q?rR0g0zFmaKTb5abD8BSO4MoSWxBeP/dajLbkA91zkiXTmEM72fLJKDdIfmu7?=
 =?us-ascii?Q?8JX2eoyY5ySvjqstP4+oae9Y4Yk6n8kJbgvqWKKagsgq3sIWDgogFFDEN7r2?=
 =?us-ascii?Q?K5u/bL6FAkc0tMAcAzf32XH/DRqPt4CkMwMp7XhjokYw35UH0SOlmaeMang1?=
 =?us-ascii?Q?n3ZT2J1lgMmaT1h/i9wGiN5vNQ1ryhal16rmqu4fpAvXjbUOgqQcNb/LtZm3?=
 =?us-ascii?Q?Y4GNBKX4AWYz7WGTXPZMC6h9BTkEJQzpDFB2hfgjxbR9fD/x3bZouBExsLvk?=
 =?us-ascii?Q?zb4sK22iNYu9mL6PbaiLJ6oXEmJ300ucpTcS/EE1OXS1rpOdX1uST0qYU+cv?=
 =?us-ascii?Q?7z6ThqvA7N5D1SiqPPosAPgkk2M/j5g2Bf37iTt5BtKxjcV5oCn19Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1449lP3Ft+xwck92dTKrTHmn2hd5lkoOclHRx7tW1vUIx3N8sR75mpJR8iw?=
 =?us-ascii?Q?1HPdxikdPj6mmqrGYRUaHON6MS/uJ+SKZQjMgZaN/nfWJfnD0HPm85+YiGjZ?=
 =?us-ascii?Q?7vsLIoJyvQZeDgvBlIAa3eHCSbIfpBR6k59ca789EI80lElzNA573s6cy0DS?=
 =?us-ascii?Q?0RX3PvmPY8vGfc9JWTkczSlVCTLH5OpC+7esXZGiSnudp8Xo0N89aJmzXzsS?=
 =?us-ascii?Q?YJaZcYCTphUetIYN0i8VNY4mgQU9mdhgvIZPeVkAT0RGQwsQhn59pI/AOuCK?=
 =?us-ascii?Q?OjD177A/0fvxmJye8zCOF4klkvB1yknoHqj30cwbW5MAWDc7i1lFqUlA0T0D?=
 =?us-ascii?Q?vp28lN2615Kl3bO4pamzk7VzHhgqynjh20xV0WVWZGpLxxGXhsofWdL3R+/8?=
 =?us-ascii?Q?fOtu82sB4TJHus6vWHvNLiUF/oeLLiWDqISd13e1vzZSaxkIiBo0FocCxWtZ?=
 =?us-ascii?Q?laUWPK7hCcUQR/HAF1J4Igj3uOAWVKr03tX/Oi1tyYOs1LEj5QhmpayOmIRx?=
 =?us-ascii?Q?2sS34piN7MrjeGvUd57BhYEvXeoyx8QrzoPDxRSie0D1HEyB+zp+bCw7RBCv?=
 =?us-ascii?Q?+MAw7LSxVDk+NUlgqs8Sum4pXMR0NsRol2yOARxkV0If62izv5H8o6xVBwRK?=
 =?us-ascii?Q?OyhPA0B5+FCmcD+sQTO7muWjkXCLNehyOR1oDfDVgQOf3kXs5BY0qNidg26H?=
 =?us-ascii?Q?A5vnJ7zARpphO+Wk3qT6Zy2LWprBghEgwZxiZyTB06Jz62x4hYbTLQMLVrDl?=
 =?us-ascii?Q?4ISdz12IOpRKkDMiEK041IT4DMvN1Zch6/PBAc6XTer/emfni38tdlfTwVRo?=
 =?us-ascii?Q?y6qS2m9+5ESy/WW/Y46FqAUPLgZ+M8j4V31xhQmJYmzdiR5BnXi9PaxwAXNQ?=
 =?us-ascii?Q?hjb/blyBr68EnIYTimwZ9DIBOqCnhBdyUCG+M46tXgLFi1xiUsz1Z/59LB6Z?=
 =?us-ascii?Q?GttHeMec6JgUwCRCRv7hHajdhtLXkONotB6VvcTCPuR2yBLLhYu73UkVvkGB?=
 =?us-ascii?Q?Y+W1A6geLA4QkiZeiZgn6yeXtsoP6dkzjjeWJa5S+7rfIazfbLM1vglmAHOq?=
 =?us-ascii?Q?jbjFDBb2UTxeKDrE9NNwwqbpNnQgJDSjCag88rI1gW7jUdYgg6bBgu0RC8vj?=
 =?us-ascii?Q?Qo1wknAFqbQkDwgh+PNlfthdnZh6d/kuMlDdwNAgCRNF4tKz66h9BWdpSUkZ?=
 =?us-ascii?Q?32BN+MR/65HqBYFn1Aw8O3YWvQlt2AL28V1JYT1xP5g9P4E5e3PHWB1WZhmk?=
 =?us-ascii?Q?mLjzpG1GIe52P/Rwkr0NcPhz/VKyJiLcrlnMaFrlq1zAQRw84C8jLwoO9FOP?=
 =?us-ascii?Q?1meRpIv+Xx2mVA8O1EZW/Wlfzonj+8htFvl8i69zYloqToyJPI8dMjHkNAbe?=
 =?us-ascii?Q?SPu4Jhxb4/5cZQT5EdU+eo72yN1ZMJxNM0oU3/M29nlGintpoPFL9p2mHCo+?=
 =?us-ascii?Q?nZFe0uxWbzOUsZ5uUROz0jm0FqBejTqlsVTHyHZaD5brWfbjkkeqhpo2lWvo?=
 =?us-ascii?Q?zAGMN4yCuMDtyJm/PRmXzZnQmJSd7H8aD67Y6zrjeKVM2Ji4J7/Lm4kEAK1B?=
 =?us-ascii?Q?9IhLatXtS5S0wD0SxTeozC6gpr0+eD7+9kmEHmCvMiZ8J/Wmu67AP/5T+da8?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wFnbN6UIzVErgYnpzzol7LV/kVHqhbjpWu+VTg4UZRa+/Nyg1gqQYBl/QINiqIPzP5K8pRtBf2NeneBoetYUY05gDzIsSnu135BaRRRcaB0ufI9HaiFw/CKO2G5bRtsSHMpLTievM80yS0p2aBsu8NeK/eWqiiXTmtaGG1myq24pYkEcngF5xdOC65bK+OWAdAPB/qS69Ov0AFpdJ1vMmhozltdnZ2tXbHcUQ8fUTHsuPkBc8wmsN7GYL25lHbV2dgjS0/A8qXc0OLStFz9Z6erTI0vaB/Fja8oGmUnuiKFBb95lK3hgBTzFAp+4CITIUCZF1lzgJzqWwkipUyjdb1auU70vM2srga7N2kict/OdlxpKfcZ0Aat698PWidRWp84nfXR6NO+8B7wksD3LlMwA79hC3u/CBW66dMM7B7h6fV8HEqD64qPeaRH4amTjbCOSF/aixUSoZiV5tTR4HsCtgYatoXAWrQg2xDW0qaxgu+epRPogFa/L0pIPtv1BJP+NTQjxief7dtNGXX5VfTbwXRIlia4L+/wjKdeE6LzkjH2hD1aj2TSZfmGDUv6ccmXSPccsOdyJdlmNTWyn50MPO0A9j6RPD/6Kaf+wURg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c1736c-c8d1-46a9-5e13-08de1713895c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:49:41.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3AWgUX//ATaJl1Ga75kS9z05y7bkqgz4Vdot20Oz6nAnRU8LBYuEjqC2nR8KzyC2i6/uGuNeC0PUe2tCJHNP3o66IgOaqn/FDAUEQ1dRzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=723
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510290142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX/WSs0MwnDXSc
 qGE8f0wFEiiMlmwoJz3JfZzYRPBBJHm4mZs84pc78LzkLrS2egfLhnKlIi2US2v3xY06++C7han
 p8sNKPaQJqJxEkjii24uhO4bSgsfcD2LMlikJnY1INZHgxZgciBqDzPZGeQEt7mshXLy9mlgkjH
 KrPq8ZvJ3yJ+Rqlxd6vOCuXd0AjMgBj78ZzNyv6FmdnV/kvMBL3hA8xotNCsxRbaDjSkt3Fe3Iv
 oV8OberBnRmPZVgm3JBubR4coWuKkFzdPaKDxI0NyTvTYzaZp+mAbXYnGU949MKNc9L0lMkB/pi
 GakkzYoT1Foflk5Oda8tb173KWyouQtvYfzYUXJB4ZGU6fqaXtzlA1ytCBnfAt4qvrol9/MCxZL
 8DHI3nhkIPXcQRk5wkZS50A6jNox9QtVlLgH/mvkz6MIwAl49zc=
X-Authority-Analysis: v=2.4 cv=M/9A6iws c=1 sm=1 tr=0 ts=690253bd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Is72dkD1bUUwoFXTfKkA:9 cc=ntf awl=host:12123
X-Proofpoint-ORIG-GUID: v70zDqWfNSPV97opzTaLgkWdzDtd5rJJ
X-Proofpoint-GUID: v70zDqWfNSPV97opzTaLgkWdzDtd5rJJ

We are in the rather silly situation that we are running out of VMA flags
as they are currently limited to a system word in size.

This leads to absurd situations where we limit features to 64-bit
architectures only because we simply do not have the ability to add a flag
for 32-bit ones.

This is very constraining and leads to hacks or, in the worst case, simply
an inability to implement features we want for entirely arbitrary reasons.

This also of course gives us something of a Y2K type situation in mm where
we might eventually exhaust all of the VMA flags even on 64-bit systems.

This series lays the groundwork for getting away from this limitation by
establishing VMA flags as a bitmap whose size we can increase in future
beyond 64 bits if required.

This is necessarily a highly iterative process given the extensive use of
VMA flags throughout the kernel, so we start by performing basic steps.

Firstly, we declare VMA flags by bit number rather than by value, retaining
the VM_xxx fields but in terms of these newly introduced VMA_xxx_BIT
fields.

While we are here, we use sparse annotations to ensure that, when dealing
with VMA bit number parameters, we cannot be passed values which are not
declared as such - providing some useful type safety.

We then introduce an opaque VMA flag type, much like the opaque mm_struct
flag type introduced in commit bb6525f2f8c4 ("mm: add bitmap mm->flags
field"), which we establish in union with vma->vm_flags (but still set at
system word size meaning there is no functional or data type size change).

We update the vm_flags_xxx() helpers to use this new bitmap, introducing
sensible helpers to do so.

We then provide vma_flags_test() and vma_test() to allow for testing of VMA
flag bits, and utilise these across the memory management subsystem.

Since it would be entirely inefficient to do away with the bitwise
operations used throughout the kernel with respect to VMA flags, we permit
these to exist, providing helpers for these operations against the new
bitmap.

These operate on the assumption that such operations will only be required
for flags which can exist within a system word. This allows the fundamental
flags to be used efficiently as before.

This series lays the foundation for further work to expand the use of
bitmap VMA flags and eventually eliminate these arbitrary restrictions.


ANDREW/REVIEWS NOTES:

Apologies, but the nature of this series is that it's going to be a little
painful, I've based it on [0] to make life a bit easier. Let me know if you
need rebases etc.

[0]: https://lore.kernel.org/linux-mm/cover.1761756437.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (4):
  mm: declare VMA flags by bit
  mm: simplify and rename mm flags function for clarity
  mm: introduce VMA flags bitmap type
  mm: introduce and use VMA flag test helpers

 fs/proc/task_mmu.c               |   4 +-
 include/linux/hugetlb.h          |   2 +-
 include/linux/mm.h               | 341 +++++++++++++-------
 include/linux/mm_inline.h        |   2 +-
 include/linux/mm_types.h         | 120 ++++++-
 include/linux/userfaultfd_k.h    |  12 +-
 kernel/fork.c                    |   4 +-
 mm/filemap.c                     |   4 +-
 mm/gup.c                         |  16 +-
 mm/hmm.c                         |   6 +-
 mm/huge_memory.c                 |  34 +-
 mm/hugetlb.c                     |  48 +--
 mm/internal.h                    |   8 +-
 mm/khugepaged.c                  |   2 +-
 mm/ksm.c                         |  12 +-
 mm/madvise.c                     |   8 +-
 mm/memory.c                      |  77 +++--
 mm/mempolicy.c                   |   4 +-
 mm/migrate.c                     |   4 +-
 mm/migrate_device.c              |  10 +-
 mm/mlock.c                       |   8 +-
 mm/mmap.c                        |  16 +-
 mm/mmap_lock.c                   |   4 +-
 mm/mprotect.c                    |  12 +-
 mm/mremap.c                      |  18 +-
 mm/mseal.c                       |   2 +-
 mm/msync.c                       |   4 +-
 mm/nommu.c                       |  16 +-
 mm/oom_kill.c                    |   4 +-
 mm/pagewalk.c                    |   2 +-
 mm/rmap.c                        |  16 +-
 mm/swap.c                        |   3 +-
 mm/userfaultfd.c                 |  33 +-
 mm/vma.c                         |  37 ++-
 mm/vma.h                         |   6 +-
 mm/vmscan.c                      |   4 +-
 tools/testing/vma/vma.c          |  20 +-
 tools/testing/vma/vma_internal.h | 536 +++++++++++++++++++++++++++----
 38 files changed, 1037 insertions(+), 422 deletions(-)

--
2.51.0

