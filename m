Return-Path: <linux-fsdevel+bounces-66760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F9C2BB13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3677F188E32F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C430DEB9;
	Mon,  3 Nov 2025 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OqmSQevb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zKeZohRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774630CDBF;
	Mon,  3 Nov 2025 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173233; cv=fail; b=PYmVvjGCX+c9oKOvdh0SbE/RbuoqMMa1rQJmX0HPvqMeE6xfcNoGlwFZtQNpl5p5Bpxu2/4rCI3vKECXk/f2oNNsa3+x7WicE7WMwkC69ZvN3TOXIYmZeNoDzNoQPkXv6BWSU+XM0k+BE6Q+PHl3xeCEwdk3rokSlhjxWkEbW1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173233; c=relaxed/simple;
	bh=+1AITt9B1AH8OmblGMOUSIDpuarrQv8aDKLW/2lhCKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GI/MSgZZ4h2d5Djuk1LxYVpFE2jGdQJk3nnj+98HNYFmqdJh8Sa9Clwp7cnLdxDlGuZl9xi9Lxr9H8hlMavg28EmI3iAnDgmUC/MU7om97i/eMUWdLpXq8vbr2QQjFuxQu6nmHgZcLCRz0lJWKMHNsYrZ/YdbjC4nxfl+pFamB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OqmSQevb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zKeZohRM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CP2eG031542;
	Mon, 3 Nov 2025 12:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=egI0qRreT/yxUPZjzy2y6msSKFmp4kULwVBcR3j75/0=; b=
	OqmSQevb5hYABAs/AsxhJLSy4kr5i7yY3iu1xYnEvctE60GczN1xPC/O+qIZYrkz
	UdkBH6dG/W+wVfZ7+vae/7haiCY51NP9kbT1FYGwsOmwZPgDUvWCIx2xo0xQ73Ci
	rSgGaucuWDEct4Z1/1l+8TtGjwEQxO2lQhvCUZhlgUNFcVNuOLdMyT4BVBAAdqRt
	lf9C5b7gxkNonglbb3ccsv50MXH14x3tPfYD+peU53q4Qq7PLW5me4FvvsN2LmiC
	cCBkyhcB7LkIdWaUNvdezZBxcDFy5eczxANIjLodRSA4pfHEpqVU3r3Zhh+nO8zT
	Uqj7sDi80eH7T7QQ3Q12gA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6vcb80f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BSiuB009599;
	Mon, 3 Nov 2025 12:32:18 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbksty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6CxOjrgxBu2KsirXRZJIULdL0vXu4MuB6PRp9wxEEYPxb1ODVv3+59i8g/QBV9AS9Yf9MBL6WhBfUY2Y3amLeLM1P3GKANdewLOFULERLzf1E8UcNe/UBYpcnY5gqYWPziMbq8+qbHOiHVgSs0s+t3bxGa4Zj9VcYksF0DQmj8HHwkZod2fNuYMUhFeZZ2jAAalqCWWdNvkpe0DMyMwNnr/f3hV96xg6ySv7fmhrapxEHV/SCaJfn7a939FrUgV8DN2DxP2mLF8AxrozTd2pe1ETsLUTN/E98djCcaqASz3ccjRxlXahJIva3peUMqGrPbNOa3hEYePtEBgg/dHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egI0qRreT/yxUPZjzy2y6msSKFmp4kULwVBcR3j75/0=;
 b=Ib7VdOQhWsrtfE8S0xDPKIjBvU7+4VRebBUj0HNL9XMpO5qw7AxXEa+o/EVFYf4bkkT33T9zev6ttXfMfEa2tz9FJ/Em3s6RpOzLa28kf2DXI5icYb/iI7xc2/AhvrJTQ3Q2qWCQLi0VZT3LS8sRpVUhTP4lzjiwk+mzl1n+SnALXEmx/Mg8QH5patryX4ji2IVF2Hei5YT/iRqLBvOmN0dlZABOElcu/isv8SO1R1NqfUjVKu2X8V78ynNhmMTpaOBFnqSxxo8AnC2iP9ZrujLcJ2E8zSckldkUIhIxhjO3q1njKo4Q/gOluESujeyKQhLWjVRwfG9m9Q0BjFUEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egI0qRreT/yxUPZjzy2y6msSKFmp4kULwVBcR3j75/0=;
 b=zKeZohRM+ICEK3koBm3/QZz5QJmKtsJyekRZUq1sGxuc7a/unVOMg53NQKuuMKhouDtic3Z+lfQBRA4fAEoiTSQ1W2xhiTrosXgrnAbyIq8t0OhZz+SQ24kjK3qmFZ1vDkGuozKkBxnbJ+qB9qliBznghFCBTRKUo2pC/9zN3wI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: [PATCH 02/16] mm: introduce leaf entry type and use to simplify leaf entry logic
Date: Mon,  3 Nov 2025 12:31:43 +0000
Message-ID: <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: f1081bde-c56f-483d-9d7f-08de1ad504ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Da68B1zaBnncsAX9UMZ7bws38gqT/P4MZWEQcoPzRBD50mjPnTpEHVbIOxKp?=
 =?us-ascii?Q?fhDrLXGwrvbWRZ2vHbFtL/A/K9kQDPYyM7NzliO/MaXiuJJWy8JJUvuQ+Ab6?=
 =?us-ascii?Q?wQ9PnpnUtr7itMg9n0HoQf+PVGXVlu8LVg/CYHmuKlIcEE0j34XuG21SzjTC?=
 =?us-ascii?Q?4tHRJWVgjv9EgrtK3PQM25KQSN9Sbm13WDYkKl/gxnWPx7QTBOJ2xfOM7qJu?=
 =?us-ascii?Q?0judCxHsKKlGpUeuU0d41+s9ltY6gaWeY6gv1Mpen63znlmzXZLwTNEJM6Pj?=
 =?us-ascii?Q?FR6qArhxurvj5cDFVFJ9vG5iiXm1HtPILGRXZmp4wpjwU+aQBeKRAzDRqlkX?=
 =?us-ascii?Q?QPlJUo+hM0agCc9L7tPIu5gQVHDJgerxmV8113cKk8MxcxJSyM0uY1vvSzwJ?=
 =?us-ascii?Q?iI3diQKQKUZYC7uKbUmYYJnfZ56+wedt/QVliEYcR7iEsU7ydptuPK1OCRPG?=
 =?us-ascii?Q?3+hzSwiPbQmLnaiWyHCgp2KIi9pWn8Ft3hfmxdQ36yKXNR5i5DyMTXF1DQhD?=
 =?us-ascii?Q?6EP+PSj+PaNTR6vsFlmyd6QsS6z7VUt3DdGe1nk/+YitKjwfFiDBOaZ8+4r4?=
 =?us-ascii?Q?s8S/oso5xnGtVwD5h6ai6LHrevT6fODbrClVLtT5FE0kSyhnN2kKzvVHDeIF?=
 =?us-ascii?Q?64p745TAXuENTAqvN3pOAyUM+IqQ1EoNi7C5UoeoHPdhxRT3xYkAPy7DS8Jr?=
 =?us-ascii?Q?LExhPBo5ZLu7JQzBJvrPRXyayLFBfkS9lhZNY8Z1veU4CMOS/ezDnux5qxB4?=
 =?us-ascii?Q?RgGvLvayBdNyT4EBoyEcAg1x/oNEPIzmHzfdilkbF1a8/in10u2dpwmeDQ01?=
 =?us-ascii?Q?lp5LCOCOBV4lKL7C2kbmMrpjNQhUlbQxW6/EH1ixWSoqiURmSgGeC5CwhZ/U?=
 =?us-ascii?Q?1VAy1LE4jM7qnkVCwbC/2X5q2P7kM/hDIvj7rQy7h4UwEeBxaquvlCwCLs9f?=
 =?us-ascii?Q?ckfNHH29JeN5LFu5Z6aMF/XyvWcC9zWZczzKIzCbHv6wyA3Cp65PTZ3CxQO5?=
 =?us-ascii?Q?hIVcpst3BOFMubJ/TwF3eINMuAfQhH9v+6UH1hePLlQPkLJVFEXxb2M9nO7X?=
 =?us-ascii?Q?kP5MYxEeCFdittZyxERvq5cVD9FeL4Zwe/LadFZshUTfyefmSgXCG1Nf3jtQ?=
 =?us-ascii?Q?LXzlHVLdD0fX0XVJoqQPxJ9RtCKdfR9zpaJFYZYZap1y2jF0YlyZZbCJByNy?=
 =?us-ascii?Q?zNwLemDVkxQp9G/GVy/9LeFeuSy/7YMpNoaMMa5WllNH9e+I0b2m1A3NSv6r?=
 =?us-ascii?Q?IR63jc5eIUZwciD3szwyaHmu0ztEg+M/yz1vA9u9n26p6r36/KLm85cL1gYN?=
 =?us-ascii?Q?8GOgrsIQ9Q0zBbazVe7pTCz0IKkNsEGN2CJ7P1qrvYp4wCEjD7f7SCLyAq6S?=
 =?us-ascii?Q?Bmsyl1lPkjgYMe6RbfUxEe+10khDh6PKDSnjahuNxuK4IEx0Z6+46VgH13a7?=
 =?us-ascii?Q?BlEVg5D0zvvh+LUgXeuzuBSB7+L88lZI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nf9MPbvZTtg6QKTq7WwO1Jg9z+lRGPoydE/sOZEK7w+MrhVvprq//FcYb2eO?=
 =?us-ascii?Q?1UN+eFM3GKR71irPuiXZxh3UzOBAZHrSQ3gsPUDK4N605BjZnSsAI9WAjRUG?=
 =?us-ascii?Q?h35A9kVTnaVSFDw99S16+fqB/rLLB1gHOQVeZ3TC8M4JUISrRi1VfcMJ3uuD?=
 =?us-ascii?Q?6Z+Nh6XD8MC2ny23h+z6e1wyROZ8wxyb3+p1v9zlM20/CBr8arUFBNcR4MIX?=
 =?us-ascii?Q?Z5WIudfB41U+YzZim/RyinQajD1zQU7ehIX1ld/kKk+ch2yNmfK1uQT/A7S0?=
 =?us-ascii?Q?Cof7PNFjakJuIL2rKAT5R8JQoo5SaYReUVV3nRzT7WLqGGZFssDT7C3o5j7Q?=
 =?us-ascii?Q?KCpdk39EVExbbjL1oWcZ7DZSN/ydxs8EajG1go/Qf7gl8tOJyDwJBNoA5ZAR?=
 =?us-ascii?Q?BMxlwVmRGRc8OjLFPGLeKv5KQLdoX/hnbC0RUd6dnEX1PHVqu9YM+3303/3h?=
 =?us-ascii?Q?q+AkQrq0faKfUWgahrd+s3v9/OZ6PQidn7GnKRlaEkCaiFA0BFQ3opGU81iH?=
 =?us-ascii?Q?nT8/0rvimKxP2wzb+5OlxVNvf9OgXLYYGfkCiavn0RhBcya5Gkf1N4z9VInp?=
 =?us-ascii?Q?EsRP9AV+it/VGsZ10N5Emz3evM+bdnDAFnYTMjUXZqJncsA8uExxsh4hF7/O?=
 =?us-ascii?Q?A8LXJWoe51P42Dqpf7Tte9YJHwPEJbQk/PWmNbyk3PP6xqmzg3/Wc+QziUGE?=
 =?us-ascii?Q?/Z7KsBXR5zLgvJjqtSNgdl25hEnezU6flnZjqp6Hnj74lKvnL0MeblvlGdQ9?=
 =?us-ascii?Q?A+XeGfH25kPBBsRVC+Wxu38W4Gn6Y5mppytQooi6djfaDTRCUncddIxqBItP?=
 =?us-ascii?Q?yQUpZ5ND4fJIzI49Rob9Hwvy9/CvbUrdyD0ww35CubWdTYVIgj5ZNNhhXZ1T?=
 =?us-ascii?Q?eNfhRbpfRkhpAccFualNqhU+nCnw/y3NoLnTcVphAFEY/RO3vXqFTbzSK5tT?=
 =?us-ascii?Q?PUcnpm8g7iVi55qQJRAf/JIFamB3OlLh8L5Pd1Ngo3+1uXI/Dtb87M8yJVii?=
 =?us-ascii?Q?p8KUbfmtvyyAPv+h9HM/XVfnBmVSpYyV9XeH4+zTnMUyqlCcAhfnUDJXjF+m?=
 =?us-ascii?Q?GnaC9gTkdr+sZwYXyfvO1XjrPh+PPwE43PR1ZfzUVvliT3gz0EzKR4A00DUp?=
 =?us-ascii?Q?TQNhr3TJi0BnK708dHCpnJSVbi620eTF8LFw9GHxXGRbQtn9+3bnnhyDP5r+?=
 =?us-ascii?Q?mivAOsOkLmiiHhVcer85vTwoRTb0IWhP0g0E1RWeYkvTugkEl5TeiKNyDYNW?=
 =?us-ascii?Q?wVwlcHlBxW8GQRvX/Uq0tGc1k4O55ymlwrEEUHIVFcRK5Zo/jnGxcWhRbSXn?=
 =?us-ascii?Q?BP2fU7KeqNDB3KWVp2Tq9rXJXi1YN7ahxIUGB3AOtIEFiV9m6FEJlESWXAWd?=
 =?us-ascii?Q?Im2yIgfVVwhZ++I4yqLVtwZAf75G6Tx1YDQgGZDob6eGYncqoXm7HCoVIVPX?=
 =?us-ascii?Q?UD7gExcErh4q0dEgwN3a3H+kaeW9Mg7u5bKUd3f20CdfxPBnqJtvIzE47SE0?=
 =?us-ascii?Q?RKEj6NcFgwwVmjbHoYIZI+7VfbkSOO5CDb43Xr3pBlG1enFHQhhqtg6l4IrV?=
 =?us-ascii?Q?ixz2XNwQqt/ySljtGtUGvuri3VEiix3vyf9FThJzp8uawrK1oaKahb+nNvhB?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8K2sWm4qDSsYPytVPz0EXUQR6MYTi2YZJrRVejlDVQdvRO73XCQ9nTcQBUuBYqzGZqeWJdSrHrm0GB4RPxzWiI8QIKhksiEpYSXvvkHxBAU+4p7hRlNPr8PPv5EVITR3pDJot1IvGkYBWVfMthH2manJCHoxGp3mPWTeux/x15MkHvum42bKFnCD2juPhx+0az0QkaiX6e36hVJAHkMfn7JdIi2CmLfXm12aBn+gsjhIlGOUvRlCYfg2arNhlGPV0Bl9AKq6li4H5jJOTkk9VEZ2jvWTKrX83RPMLSGRk6hrXkwHzHHllJwvz3BfU6qvngvOyfFv5vYno8e5+NG1cXR1VGEhKnsmUJML9fOugtHrjOs+2CZywQtw5RmXWAv3C0RK8XNO1npFoAXc6rpIiBvtr8UPR50o/c4wlpzheFmavA29wPmyQKfNJ3yym8rQyPhR+GvT4uFe5+r4YIBa3HZPh7dwSX+P99WLvfl0huTd6GfOJSo/cH+uq2VDzw9PkcsfMH6VbznczfHyfON6GLuRpGU9MOmOtTMzW/7YMHq1nSj9e78GSnInCFlFML1i09B1LntnQ4kX2V1AIVvSq4AvApkm3h1Spnb4BhX1IfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1081bde-c56f-483d-9d7f-08de1ad504ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:14.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y63ycJdUZfccJ8wZes1xMrh1jM4M5lDy24Cxq6ilelFTxK1zdMMrLRq2YqNIqKdicbJnu/y9VnuPqwzcgpuMoLYHNaTqLxphbPGH0jwvqyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMyBTYWx0ZWRfX3kjlXmLfqwqO
 i18TqG6fBFpWOLEN1MKPaAuUXH+gODd882rN3PrRw3xU6UirF23s368+5e47DPc8y5nShWKGbMf
 hOl72v+qBiXKWhZ2gCIEmbyzU21GnYeDpA/aB2ShzSL3h2BCbqw5yyPSv71/WadD1dug4j5+Qhf
 g0U70ACmIYZ7izkqPGHnXGybnD6R8bHsXBhpFAs4BOIBDFQj5eOwNtrw/QFtYQhKehbRCW7etaX
 zBmkgQzJe0XhuS+ecLNbE8TAKQerhikQMToSRyoh9MaFct06nfr4PJfEDCBI6cZVnEekjAV2lVs
 9olGfJcnF14yjoVtnFabySmIHK/Su/U4O6DSw+c1rEOJoD7W6euSX90WpgeuTeXaXVDowwv399S
 P336QgcJcELbYynA3SaBFh9UWYSAUaJvCA8FRDmuP0lvuFJLNhY=
X-Proofpoint-GUID: jeCFPboJg10bi9UMB3T-7mgcZkyYLDcX
X-Proofpoint-ORIG-GUID: jeCFPboJg10bi9UMB3T-7mgcZkyYLDcX
X-Authority-Analysis: v=2.4 cv=P7U3RyAu c=1 sm=1 tr=0 ts=6908a0d3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=QKXBBNbfDG0Dy1dDIDwA:9 cc=ntf awl=host:13657

The kernel maintains leaf page table entries which contain either:

- Nothing ('none' entries)
- Present entries (that is stuff the hardware can navigate without fault)
- Everything else that will cause a fault which the kernel handles

In the 'everything else' group we include swap entries, but we also include
a number of other things such as migration entries, device private entries
and marker entries.

Unfortunately this 'everything else' group expresses everything through
a swp_entry_t type, and these entries are referred to swap entries even
though they may well not contain a... swap entry.

This is compounded by the rather mind-boggling concept of a non-swap swap
entry (checked via non_swap_entry()) and the means by which we twist and
turn to satisfy this.

This patch lays the foundation for reducing this confusion.

We refer to 'everything else' as a 'leaf entry'. And in fact we scoop up
the 'none' entries into this concept also so we are left with:

- Present entries
- Leaf entries (which may be empty)

This allows for radical simplification across the board - one can simply
convert any leaf page table entry to a leaf entry via leafent_from_pte().

If the entry is present, we return an empty leaf entry, so it is assumed
the caller is aware that they must differentiate between the two categories
of page table entries, checking for the former via pte_present().

As a result, we can eliminate a number of places where we would otherwise
need to use predicates to see if we can proceed with leaf page table entry
conversion and instead just go ahead and do it unconditionally.

We do so where we can, adjusting surrounding logic as necessary to
integrate the new leaf_entry_t logic as far as seems reasonable at this
stage.

We typedef swp_entry_t to leaf_entry_t for the time being until the
conversion can be complete, meaning everything remains compatible
regardless of which type is used. We will eventually remove swp_entry_t
when the conversion is complete.

We introduce a new header file to keep things clear - leafops.h - this
imports swapops.h so can direct replace swapops imports without issue, and
we do so in all the files that require it.

Additionally, add new leafops.h file to core mm maintainers entry.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS                   |   1 +
 fs/proc/task_mmu.c            |  26 +--
 fs/userfaultfd.c              |   6 +-
 include/linux/leafops.h       | 394 ++++++++++++++++++++++++++++++++++
 include/linux/mm_inline.h     |   6 +-
 include/linux/swapops.h       |  28 ---
 include/linux/userfaultfd_k.h |  51 +----
 mm/hmm.c                      |   2 +-
 mm/hugetlb.c                  |  37 ++--
 mm/madvise.c                  |  16 +-
 mm/memory.c                   |  41 ++--
 mm/mincore.c                  |   6 +-
 mm/mprotect.c                 |   6 +-
 mm/mremap.c                   |   4 +-
 mm/page_vma_mapped.c          |  11 +-
 mm/shmem.c                    |   7 +-
 mm/userfaultfd.c              |   6 +-
 17 files changed, 484 insertions(+), 164 deletions(-)
 create mode 100644 include/linux/leafops.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2628431dcdfe..314910a70bbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16257,6 +16257,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/linux/gfp.h
 F:	include/linux/gfp_types.h
 F:	include/linux/highmem.h
+F:	include/linux/leafops.h
 F:	include/linux/memory.h
 F:	include/linux/mm.h
 F:	include/linux/mm_*.h
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc35a0543f01..adac6c42749d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -14,7 +14,7 @@
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/sched/mm.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/shmem_fs.h>
@@ -1230,11 +1230,11 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 	if (pte_present(ptent)) {
 		folio = page_folio(pte_page(ptent));
 		present = true;
-	} else if (is_swap_pte(ptent)) {
-		swp_entry_t swpent = pte_to_swp_entry(ptent);
+	} else {
+		const leaf_entry_t entry = leafent_from_pte(ptent);
 
-		if (is_pfn_swap_entry(swpent))
-			folio = pfn_swap_entry_folio(swpent);
+		if (leafent_has_pfn(entry))
+			folio = leafent_to_folio(entry);
 	}
 
 	if (folio) {
@@ -1955,9 +1955,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_SWAP;
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
-		if (pte_marker_entry_uffd_wp(entry))
+		if (leafent_is_uffd_wp_marker(entry))
 			flags |= PM_UFFD_WP;
-		if (is_guard_swp_entry(entry))
+		if (leafent_is_guard_marker(entry))
 			flags |=  PM_GUARD_REGION;
 	}
 
@@ -2330,18 +2330,18 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 		if (pte_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
 	} else if (is_swap_pte(pte)) {
-		swp_entry_t swp;
+		leaf_entry_t entry;
 
 		categories |= PAGE_IS_SWAPPED;
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 
-		swp = pte_to_swp_entry(pte);
-		if (is_guard_swp_entry(swp))
+		entry = leafent_from_pte(pte);
+		if (leafent_is_guard_marker(entry))
 			categories |= PAGE_IS_GUARD;
 		else if ((p->masks_of_interest & PAGE_IS_FILE) &&
-			 is_pfn_swap_entry(swp) &&
-			 !folio_test_anon(pfn_swap_entry_folio(swp)))
+			 leafent_has_pfn(entry) &&
+			 !folio_test_anon(leafent_to_folio(entry)))
 			categories |= PAGE_IS_FILE;
 
 		if (pte_swp_soft_dirty(pte))
@@ -2466,7 +2466,7 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 {
 	unsigned long psize;
 
-	if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
+	if (is_hugetlb_entry_hwpoisoned(ptent) || pte_is_marker(ptent))
 		return;
 
 	psize = huge_page_size(hstate_vma(vma));
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 04c66b5001d5..e33e7df36927 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -29,7 +29,7 @@
 #include <linux/ioctl.h>
 #include <linux/security.h>
 #include <linux/hugetlb.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/miscdevice.h>
 #include <linux/uio.h>
 
@@ -251,7 +251,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	if (huge_pte_none(pte))
 		return true;
 	/* UFFD PTE markers require handling. */
-	if (is_uffd_pte_marker(pte))
+	if (pte_is_uffd_marker(pte))
 		return true;
 	/* If VMA has UFFD WP faults enabled and WP fault, wait for handler. */
 	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
@@ -330,7 +330,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	if (pte_none(ptent))
 		goto out;
 	/* UFFD PTE markers require handling. */
-	if (is_uffd_pte_marker(ptent))
+	if (pte_is_uffd_marker(ptent))
 		goto out;
 	/* If VMA has UFFD WP faults enabled and WP fault, wait for handler. */
 	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
new file mode 100644
index 000000000000..a1a25ca152ff
--- /dev/null
+++ b/include/linux/leafops.h
@@ -0,0 +1,394 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LEAFOPS_H
+#define _LINUX_LEAFOPS_H
+
+#include <linux/mm_types.h>
+#include <linux/swapops.h>
+#include <linux/swap.h>
+
+/**
+ * leaf_entry_t - Describes a page table 'leaf entry'.
+ *
+ * Leaf entries are an abstract representation of all page table entries which
+ * are non-present. Therefore these describe:
+ *
+ * - None or 'empty' entries.
+ *
+ * - All other entries which cause page faults and therefore encode
+ *   software-controlled metadata.
+ *
+ * NOTE: While we transition from the confusing swp_entry_t type used for this
+ *       purpose, we simply alias this type. This will be removed once the
+ *       transition is complete.
+ */
+typedef swp_entry_t leaf_entry_t;
+
+#ifdef CONFIG_MMU
+
+/* Temporary until swp_entry_t eliminated. */
+#define LEAF_TYPE_SHIFT SWP_TYPE_SHIFT
+
+enum leaf_entry_type {
+	/* Fundamental types. */
+	LEAFENT_NONE,
+	LEAFENT_SWAP,
+	/* Migration types. */
+	LEAFENT_MIGRATION_READ,
+	LEAFENT_MIGRATION_READ_EXCLUSIVE,
+	LEAFENT_MIGRATION_WRITE,
+	/* Device types. */
+	LEAFENT_DEVICE_PRIVATE_READ,
+	LEAFENT_DEVICE_PRIVATE_WRITE,
+	LEAFENT_DEVICE_EXCLUSIVE,
+	/* H/W posion types. */
+	LEAFENT_HWPOISON,
+	/* Marker types. */
+	LEAFENT_MARKER,
+};
+
+/**
+ * leafent_mk_none() - Create an empty ('none') leaf entry.
+ * Returns: empty leaf entry.
+ */
+static inline leaf_entry_t leafent_mk_none(void)
+{
+	return ((leaf_entry_t) { 0 });
+}
+
+/**
+ * leafent_from_pte() - Obtain a leaf entry from a PTE entry.
+ * @pte: PTE entry.
+ *
+ * If @pte is present (therefore not a leaf entry) the function returns an empty
+ * leaf entry. Otherwise, it returns a leaf entry.
+ *
+ * Returns: Leaf entry.
+ */
+static inline leaf_entry_t leafent_from_pte(pte_t pte)
+{
+	if (pte_present(pte))
+		return leafent_mk_none();
+
+	/* Temporary until swp_entry_t eliminated. */
+	return pte_to_swp_entry(pte);
+}
+
+/**
+ * leafent_is_none() - Is the leaf entry empty?
+ * @entry: Leaf entry.
+ *
+ * Empty entries are typically the result of a 'none' page table leaf entry
+ * being converted to a leaf entry.
+ *
+ * Returns: true if the entry is empty, false otherwise.
+ */
+static inline bool leafent_is_none(leaf_entry_t entry)
+{
+	return entry.val == 0;
+}
+
+/**
+ * leafent_type() - Identify the type of leaf entry.
+ * @enntry: Leaf entry.
+ *
+ * Returns: the leaf entry type associated with @entry.
+ */
+static inline enum leaf_entry_type leafent_type(leaf_entry_t entry)
+{
+	unsigned int type_num;
+
+	if (leafent_is_none(entry))
+		return LEAFENT_NONE;
+
+	type_num = entry.val >> LEAF_TYPE_SHIFT;
+
+	if (type_num < MAX_SWAPFILES)
+		return LEAFENT_SWAP;
+
+	switch (type_num) {
+#ifdef CONFIG_MIGRATION
+	case SWP_MIGRATION_READ:
+		return LEAFENT_MIGRATION_READ;
+	case SWP_MIGRATION_READ_EXCLUSIVE:
+		return LEAFENT_MIGRATION_READ_EXCLUSIVE;
+	case SWP_MIGRATION_WRITE:
+		return LEAFENT_MIGRATION_WRITE;
+#endif
+#ifdef CONFIG_DEVICE_PRIVATE
+	case SWP_DEVICE_WRITE:
+		return LEAFENT_DEVICE_PRIVATE_WRITE;
+	case SWP_DEVICE_READ:
+		return LEAFENT_DEVICE_PRIVATE_READ;
+	case SWP_DEVICE_EXCLUSIVE:
+		return LEAFENT_DEVICE_EXCLUSIVE;
+#endif
+#ifdef CONFIG_MEMORY_FAILURE
+	case SWP_HWPOISON:
+		return LEAFENT_HWPOISON;
+#endif
+	case SWP_PTE_MARKER:
+		return LEAFENT_MARKER;
+	}
+
+	/* Unknown entry type. */
+	VM_WARN_ON_ONCE(1);
+	return LEAFENT_NONE;
+}
+
+/**
+ * leafent_is_swap() - Is this leaf entry a swap entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a swap entry, otherwise false.
+ */
+static inline bool leafent_is_swap(leaf_entry_t entry)
+{
+	return leafent_type(entry) == LEAFENT_SWAP;
+}
+
+/**
+ * leafent_is_swap() - Is this leaf entry a migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a migration entry, otherwise false.
+ */
+static inline bool leafent_is_migration(leaf_entry_t entry)
+{
+	switch (leafent_type(entry)) {
+	case LEAFENT_MIGRATION_READ:
+	case LEAFENT_MIGRATION_READ_EXCLUSIVE:
+	case LEAFENT_MIGRATION_WRITE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * leafent_is_device_private() - Is this leaf entry a device private entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a device private entry, otherwise false.
+ */
+static inline bool leafent_is_device_private(leaf_entry_t entry)
+{
+	switch (leafent_type(entry)) {
+	case LEAFENT_DEVICE_PRIVATE_WRITE:
+	case LEAFENT_DEVICE_PRIVATE_READ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool leafent_is_device_exclusive(leaf_entry_t entry)
+{
+	return leafent_type(entry) == LEAFENT_DEVICE_EXCLUSIVE;
+}
+
+/**
+ * leafent_is_hwpoison() - Is this leaf entry a hardware poison entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a hardware poison entry, otherwise false.
+ */
+static inline bool leafent_is_hwpoison(leaf_entry_t entry)
+{
+	return leafent_type(entry) == LEAFENT_HWPOISON;
+}
+
+/**
+ * leafent_is_marker() - Is this leaf entry a marker?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a marker entry, otherwise false.
+ */
+static inline bool leafent_is_marker(leaf_entry_t entry)
+{
+	return leafent_type(entry) == LEAFENT_MARKER;
+}
+
+/**
+ * leafent_to_marker() - Obtain marker associated with leaf entry.
+ * @entry: Leaf entry, leafent_is_marker(@entry) must return true.
+ *
+ * Returns: Marker associated with the leaf entry.
+ */
+static inline pte_marker leafent_to_marker(leaf_entry_t entry)
+{
+	VM_WARN_ON_ONCE(!leafent_is_marker(entry));
+
+	return swp_offset(entry) & PTE_MARKER_MASK;
+}
+
+/**
+ * leafent_has_pfn() - Does this leaf entry encode a valid PFN number?
+ * @entry: Leaf entry.
+ *
+ * A pfn swap entry is a special type of swap entry that always has a pfn stored
+ * in the swap offset. They can either be used to represent unaddressable device
+ * memory, to restrict access to a page undergoing migration or to represent a
+ * pfn which has been hwpoisoned and unmapped.
+ *
+ * Returns: true if the leaf entry encodes a PFN, otherwise false.
+ */
+static inline bool leafent_has_pfn(leaf_entry_t entry)
+{
+	/* Make sure the swp offset can always store the needed fields. */
+	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
+
+	if (leafent_is_migration(entry))
+		return true;
+	if (leafent_is_device_private(entry))
+		return true;
+	if (leafent_is_device_exclusive(entry))
+		return true;
+	if (leafent_is_hwpoison(entry))
+		return true;
+
+	return false;
+}
+
+/**
+ * leafent_to_pfn() - Obtain PFN encoded within leaf entry.
+ * @entry: Leaf entry, leafent_has_pfn(@entry) must return true.
+ *
+ * Returns: The PFN associated with the leaf entry.
+ */
+static inline unsigned long leafent_to_pfn(leaf_entry_t entry)
+{
+	VM_WARN_ON_ONCE(!leafent_has_pfn(entry));
+
+	/* Temporary until swp_entry_t eliminated. */
+	return swp_offset_pfn(entry);
+}
+
+/**
+ * leafent_to_page() - Obtains struct page for PFN encoded within leaf entry.
+ * @entry: Leaf entry, leafent_has_pfn(@entry) must return true.
+ *
+ * Returns: Pointer to the struct page associated with the leaf entry's PFN.
+ */
+static inline struct page *leafent_to_page(leaf_entry_t entry)
+{
+	VM_WARN_ON_ONCE(!leafent_has_pfn(entry));
+
+	/* Temporary until swp_entry_t eliminated. */
+	return pfn_swap_entry_to_page(entry);
+}
+
+/**
+ * leafent_to_folio() - Obtains struct folio for PFN encoded within leaf entry.
+ * @entry: Leaf entry, leafent_has_pfn(@entry) must return true.
+ *
+ * Returns: Pointer to the struct folio associated with the leaf entry's PFN.
+ * Returns:
+ */
+static inline struct folio *leafent_to_folio(leaf_entry_t entry)
+{
+	VM_WARN_ON_ONCE(!leafent_has_pfn(entry));
+
+	/* Temporary until swp_entry_t eliminated. */
+	return pfn_swap_entry_folio(entry);
+}
+
+/**
+ * leafent_is_poison_marker() - Is this leaf entry a poison marker?
+ * @entry: Leaf entry.
+ *
+ * The poison marker is set via UFFDIO_POISON. Userfaultfd-specific.
+ *
+ * Returns: true if the leaf entry is a poison marker, otherwise false.
+ */
+static inline bool leafent_is_poison_marker(leaf_entry_t entry)
+{
+	if (!leafent_is_marker(entry))
+		return false;
+
+	return leafent_to_marker(entry) & PTE_MARKER_POISONED;
+}
+
+/**
+ * leafent_is_guard_marker() - Is this leaf entry a guard region marker?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a guard marker, otherwise false.
+ */
+static inline bool leafent_is_guard_marker(leaf_entry_t entry)
+{
+	if (!leafent_is_marker(entry))
+		return false;
+
+	return leafent_to_marker(entry) & PTE_MARKER_GUARD;
+}
+
+/**
+ * leafent_is_uffd_wp_marker() - Is this leaf entry a userfautlfd write protect
+ * marker?
+ * @entry: Leaf entry.
+ *
+ * Userfaultfd-specific.
+ *
+ * Returns: true if the leaf entry is a UFFD WP marker, otherwise false.
+ */
+static inline bool leafent_is_uffd_wp_marker(leaf_entry_t entry)
+{
+	if (!leafent_is_marker(entry))
+		return false;
+
+	return leafent_to_marker(entry) & PTE_MARKER_UFFD_WP;
+}
+
+/**
+ * pte_is_marker() - Does the PTE entry encode a marker leaf entry?
+ * @pte: PTE entry.
+ *
+ * Returns: true if this PTE is a marker leaf entry, otherwise false.
+ */
+static inline bool pte_is_marker(pte_t pte)
+{
+	return leafent_is_marker(leafent_from_pte(pte));
+}
+
+/**
+ * pte_is_uffd_wp_marker() - Does this PTE entry encode a userfaultfd write
+ * protect marker leaf entry?
+ * @pte: PTE entry.
+ *
+ * Returns: true if this PTE is a UFFD WP marker leaf entry, otherwise false.
+ */
+static inline bool pte_is_uffd_wp_marker(pte_t pte)
+{
+	const leaf_entry_t entry = leafent_from_pte(pte);
+
+	return leafent_is_uffd_wp_marker(entry);
+}
+
+/**
+ * pte_is_uffd_marker() - Does this PTE entry encode a userfault-specific marker
+ * leaf entry?
+ * @entry: Leaf entry.
+ *
+ * It's useful to be able to determine which leaf entries encode UFFD-specific
+ * markers so we can handle these correctly.
+ *
+ * Returns: true if this PTE entry is a UFFD-specific marker, otherwise false.
+ */
+static inline bool pte_is_uffd_marker(pte_t pte)
+{
+	const leaf_entry_t entry = leafent_from_pte(pte);
+
+	if (!leafent_is_marker(entry))
+		return false;
+
+	/* UFFD WP, poisoned swap entries are UFFD-handled. */
+	if (leafent_is_uffd_wp_marker(entry))
+		return true;
+	if (leafent_is_poison_marker(entry))
+		return true;
+
+	return false;
+}
+
+#endif  /* CONFIG_MMU */
+#endif  /* _LINUX_SWAPOPS_H */
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f6a2b2d20016..795b255abf65 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -8,7 +8,7 @@
 #include <linux/swap.h>
 #include <linux/string.h>
 #include <linux/userfaultfd_k.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 /**
  * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
@@ -541,9 +541,9 @@ static inline bool mm_tlb_flush_nested(const struct mm_struct *mm)
  * The caller should insert a new pte created with make_pte_marker().
  */
 static inline pte_marker copy_pte_marker(
-		swp_entry_t entry, struct vm_area_struct *dst_vma)
+		leaf_entry_t entry, struct vm_area_struct *dst_vma)
 {
-	pte_marker srcm = pte_marker_get(entry);
+	const pte_marker srcm = leafent_to_marker(entry);
 	/* Always copy error entries. */
 	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
 
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d1f665935cfc..0a4b3f51ecf5 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -426,21 +426,6 @@ static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
 	return swp_entry(SWP_PTE_MARKER, marker);
 }
 
-static inline bool is_pte_marker_entry(swp_entry_t entry)
-{
-	return swp_type(entry) == SWP_PTE_MARKER;
-}
-
-static inline pte_marker pte_marker_get(swp_entry_t entry)
-{
-	return swp_offset(entry) & PTE_MARKER_MASK;
-}
-
-static inline bool is_pte_marker(pte_t pte)
-{
-	return is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte));
-}
-
 static inline pte_t make_pte_marker(pte_marker marker)
 {
 	return swp_entry_to_pte(make_pte_marker_entry(marker));
@@ -451,24 +436,11 @@ static inline swp_entry_t make_poisoned_swp_entry(void)
 	return make_pte_marker_entry(PTE_MARKER_POISONED);
 }
 
-static inline int is_poisoned_swp_entry(swp_entry_t entry)
-{
-	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
-
-}
-
 static inline swp_entry_t make_guard_swp_entry(void)
 {
 	return make_pte_marker_entry(PTE_MARKER_GUARD);
 }
 
-static inline int is_guard_swp_entry(swp_entry_t entry)
-{
-	return is_pte_marker_entry(entry) &&
-		(pte_marker_get(entry) & PTE_MARKER_GUARD);
-}
-
 static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 {
 	struct page *p = pfn_to_page(swp_offset_pfn(entry));
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index da0b4fcc566f..983c860a00f1 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -16,7 +16,7 @@
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <asm-generic/pgtable_uffd.h>
 #include <linux/hugetlb_inline.h>
 
@@ -434,32 +434,6 @@ static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
 	return userfaultfd_wp_unpopulated(vma);
 }
 
-static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
-{
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
-	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
-#else
-	return false;
-#endif
-}
-
-static inline bool pte_marker_uffd_wp(pte_t pte)
-{
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
-	swp_entry_t entry;
-
-	if (!is_swap_pte(pte))
-		return false;
-
-	entry = pte_to_swp_entry(pte);
-
-	return pte_marker_entry_uffd_wp(entry);
-#else
-	return false;
-#endif
-}
-
 /*
  * Returns true if this is a swap pte and was uffd-wp wr-protected in either
  * forms (pte marker or a normal swap pte), false otherwise.
@@ -473,31 +447,10 @@ static inline bool pte_swp_uffd_wp_any(pte_t pte)
 	if (pte_swp_uffd_wp(pte))
 		return true;
 
-	if (pte_marker_uffd_wp(pte))
+	if (pte_is_uffd_wp_marker(pte))
 		return true;
 #endif
 	return false;
 }
 
-
-static inline bool is_uffd_pte_marker(pte_t pte)
-{
-	swp_entry_t entry;
-
-	if (pte_present(pte))
-		return false;
-
-	entry = pte_to_swp_entry(pte);
-	if (!is_pte_marker_entry(entry))
-		return false;
-
-	/* UFFD WP, poisoned swap entries are UFFD handled. */
-	if (pte_marker_entry_uffd_wp(entry))
-		return true;
-	if (is_poisoned_swp_entry(entry))
-		return true;
-
-	return false;
-}
-
 #endif /* _LINUX_USERFAULTFD_K_H */
diff --git a/mm/hmm.c b/mm/hmm.c
index 43d4a91035ff..b11b4ebba945 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -244,7 +244,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	uint64_t pfn_req_flags = *hmm_pfn;
 	uint64_t new_pfn_flags = 0;
 
-	if (pte_none(pte) || pte_marker_uffd_wp(pte)) {
+	if (pte_none(pte) || pte_is_uffd_wp_marker(pte)) {
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 01c784547d1e..cc7db8fd86db 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -28,7 +28,7 @@
 #include <linux/string_choices.h>
 #include <linux/string_helpers.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/jhash.h>
 #include <linux/numa.h>
 #include <linux/llist.h>
@@ -5662,17 +5662,17 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
-			swp_entry_t swp_entry = pte_to_swp_entry(entry);
+			leaf_entry_t leafent = leafent_from_pte(entry);
 			bool uffd_wp = pte_swp_uffd_wp(entry);
 
-			if (!is_readable_migration_entry(swp_entry) && cow) {
+			if (!is_readable_migration_entry(leafent) && cow) {
 				/*
 				 * COW mappings require pages in both
 				 * parent and child to be set to read.
 				 */
-				swp_entry = make_readable_migration_entry(
-							swp_offset(swp_entry));
-				entry = swp_entry_to_pte(swp_entry);
+				leafent = make_readable_migration_entry(
+							swp_offset(leafent));
+				entry = swp_entry_to_pte(leafent);
 				if (userfaultfd_wp(src_vma) && uffd_wp)
 					entry = pte_swp_mkuffd_wp(entry);
 				set_huge_pte_at(src, addr, src_pte, entry, sz);
@@ -5680,9 +5680,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			if (!userfaultfd_wp(dst_vma))
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
-		} else if (unlikely(is_pte_marker(entry))) {
-			pte_marker marker = copy_pte_marker(
-				pte_to_swp_entry(entry), dst_vma);
+		} else if (unlikely(pte_is_marker(entry))) {
+			const leaf_entry_t leafent = leafent_from_pte(entry);
+			const pte_marker marker = copy_pte_marker(leafent, dst_vma);
 
 			if (marker)
 				set_huge_pte_at(dst, addr, dst_pte,
@@ -5798,7 +5798,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 
-	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
+	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
 		huge_pte_clear(mm, new_addr, dst_pte, sz);
 	else {
 		if (need_clear_uffd_wp) {
@@ -6617,7 +6617,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
 	 */
-	if (unlikely(pte_marker_uffd_wp(vmf->orig_pte)))
+	if (unlikely(pte_is_uffd_wp_marker(vmf->orig_pte)))
 		new_pte = huge_pte_mkuffd_wp(new_pte);
 	set_huge_pte_at(mm, vmf->address, vmf->pte, new_pte, huge_page_size(h));
 
@@ -6750,9 +6750,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		return hugetlb_no_page(mapping, &vmf);
 
-	if (is_pte_marker(vmf.orig_pte)) {
+	if (pte_is_marker(vmf.orig_pte)) {
 		const pte_marker marker =
-			pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
+			leafent_to_marker(leafent_from_pte(vmf.orig_pte));
 
 		if (marker & PTE_MARKER_POISONED) {
 			ret = VM_FAULT_HWPOISON_LARGE |
@@ -7080,7 +7080,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	 * See comment about UFFD marker overwriting in
 	 * mfill_atomic_install_pte().
 	 */
-	if (!huge_pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
+	if (!huge_pte_none(dst_ptep) && !pte_is_uffd_marker(dst_ptep))
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
@@ -7201,8 +7201,9 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
 			/* Nothing to do. */
 		} else if (unlikely(is_hugetlb_entry_migration(pte))) {
-			swp_entry_t entry = pte_to_swp_entry(pte);
-			struct folio *folio = pfn_swap_entry_folio(entry);
+			leaf_entry_t entry = leafent_from_pte(pte);
+
+			struct folio *folio = leafent_to_folio(entry);
 			pte_t newpte = pte;
 
 			if (is_writable_migration_entry(entry)) {
@@ -7222,14 +7223,14 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 				newpte = pte_swp_clear_uffd_wp(newpte);
 			if (!pte_same(pte, newpte))
 				set_huge_pte_at(mm, address, ptep, newpte, psize);
-		} else if (unlikely(is_pte_marker(pte))) {
+		} else if (unlikely(pte_is_marker(pte))) {
 			/*
 			 * Do nothing on a poison marker; page is
 			 * corrupted, permissions do not apply. Here
 			 * pte_marker_uffd_wp()==true implies !poison
 			 * because they're mutual exclusive.
 			 */
-			if (pte_marker_uffd_wp(pte) && uffd_wp_resolve)
+			if (pte_is_uffd_wp_marker(pte) && uffd_wp_resolve)
 				/* Safe to modify directly (non-present->none). */
 				huge_pte_clear(mm, address, ptep, psize);
 		} else if (!huge_pte_none(pte)) {
diff --git a/mm/madvise.c b/mm/madvise.c
index fb1c86e630b6..27e078098926 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -29,7 +29,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagewalk.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
 
@@ -690,17 +690,16 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		 * (page allocation + zeroing).
 		 */
 		if (!pte_present(ptent)) {
-			swp_entry_t entry;
+			leaf_entry_t entry = leafent_from_pte(ptent);
 
-			entry = pte_to_swp_entry(ptent);
-			if (!non_swap_entry(entry)) {
+			if (leafent_is_swap(entry)) {
 				max_nr = (end - addr) / PAGE_SIZE;
 				nr = swap_pte_batch(pte, max_nr, ptent);
 				nr_swap -= nr;
 				free_swap_and_cache_nr(entry, nr);
 				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
-			} else if (is_hwpoison_entry(entry) ||
-				   is_poisoned_swp_entry(entry)) {
+			} else if (leafent_is_hwpoison(entry) ||
+				   leafent_is_poison_marker(entry)) {
 				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			}
 			continue;
@@ -1071,8 +1070,9 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
 
 static bool is_guard_pte_marker(pte_t ptent)
 {
-	return is_swap_pte(ptent) &&
-	       is_guard_swp_entry(pte_to_swp_entry(ptent));
+	const leaf_entry_t entry = leafent_from_pte(ptent);
+
+	return leafent_is_guard_marker(entry);
 }
 
 static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 4c3a7e09a159..299ce5dcba76 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -60,7 +60,7 @@
 #include <linux/writeback.h>
 #include <linux/memcontrol.h>
 #include <linux/mmu_notifier.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/elf.h>
 #include <linux/gfp.h>
 #include <linux/migrate.h>
@@ -109,7 +109,7 @@ static __always_inline bool vmf_orig_pte_uffd_wp(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
 		return false;
 
-	return pte_marker_uffd_wp(vmf->orig_pte);
+	return pte_is_uffd_wp_marker(vmf->orig_pte);
 }
 
 /*
@@ -927,10 +927,10 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 {
 	vm_flags_t vm_flags = dst_vma->vm_flags;
 	pte_t orig_pte = ptep_get(src_pte);
+	leaf_entry_t entry = leafent_from_pte(orig_pte);
 	pte_t pte = orig_pte;
 	struct folio *folio;
 	struct page *page;
-	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 
 	if (likely(!non_swap_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
@@ -1016,7 +1016,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		if (try_restore_exclusive_pte(src_vma, addr, src_pte, orig_pte))
 			return -EBUSY;
 		return -ENOENT;
-	} else if (is_pte_marker_entry(entry)) {
+	} else if (leafent_is_marker(entry)) {
 		pte_marker marker = copy_pte_marker(entry, dst_vma);
 
 		if (marker)
@@ -1717,14 +1717,14 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		unsigned int max_nr, unsigned long addr,
 		struct zap_details *details, int *rss, bool *any_skipped)
 {
-	swp_entry_t entry;
+	leaf_entry_t entry;
 	int nr = 1;
 
 	*any_skipped = true;
-	entry = pte_to_swp_entry(ptent);
-	if (is_device_private_entry(entry) ||
-		is_device_exclusive_entry(entry)) {
-		struct page *page = pfn_swap_entry_to_page(entry);
+	entry = leafent_from_pte(ptent);
+	if (leafent_is_device_private(entry) ||
+	    leafent_is_device_exclusive(entry)) {
+		struct page *page = leafent_to_page(entry);
 		struct folio *folio = page_folio(page);
 
 		if (unlikely(!should_zap_folio(details, folio)))
@@ -1739,7 +1739,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		rss[mm_counter(folio)]--;
 		folio_remove_rmap_pte(folio, page, vma);
 		folio_put(folio);
-	} else if (!non_swap_entry(entry)) {
+	} else if (leafent_is_swap(entry)) {
 		/* Genuine swap entries, hence a private anon pages */
 		if (!should_zap_cows(details))
 			return 1;
@@ -1747,20 +1747,20 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		nr = swap_pte_batch(pte, max_nr, ptent);
 		rss[MM_SWAPENTS] -= nr;
 		free_swap_and_cache_nr(entry, nr);
-	} else if (is_migration_entry(entry)) {
-		struct folio *folio = pfn_swap_entry_folio(entry);
+	} else if (leafent_is_migration(entry)) {
+		struct folio *folio = leafent_to_folio(entry);
 
 		if (!should_zap_folio(details, folio))
 			return 1;
 		rss[mm_counter(folio)]--;
-	} else if (pte_marker_entry_uffd_wp(entry)) {
+	} else if (leafent_is_uffd_wp_marker(entry)) {
 		/*
 		 * For anon: always drop the marker; for file: only
 		 * drop the marker if explicitly requested.
 		 */
 		if (!vma_is_anonymous(vma) && !zap_drop_markers(details))
 			return 1;
-	} else if (is_guard_swp_entry(entry)) {
+	} else if (leafent_is_guard_marker(entry)) {
 		/*
 		 * Ordinary zapping should not remove guard PTE
 		 * markers. Only do so if we should remove PTE markers
@@ -1768,7 +1768,8 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		 */
 		if (!zap_drop_markers(details))
 			return 1;
-	} else if (is_hwpoison_entry(entry) || is_poisoned_swp_entry(entry)) {
+	} else if (leafent_is_hwpoison(entry) ||
+		   leafent_is_poison_marker(entry)) {
 		if (!should_zap_cows(details))
 			return 1;
 	} else {
@@ -4390,7 +4391,7 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 	 *
 	 * This should also cover the case where e.g. the pte changed
 	 * quickly from a PTE_MARKER_UFFD_WP into PTE_MARKER_POISONED.
-	 * So is_pte_marker() check is not enough to safely drop the pte.
+	 * So pte_is_marker() check is not enough to safely drop the pte.
 	 */
 	if (pte_same(vmf->orig_pte, ptep_get(vmf->pte)))
 		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
@@ -4424,8 +4425,8 @@ static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
 
 static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 {
-	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
-	unsigned long marker = pte_marker_get(entry);
+	const leaf_entry_t entry = leafent_from_pte(vmf->orig_pte);
+	const pte_marker marker = leafent_to_marker(entry);
 
 	/*
 	 * PTE markers should never be empty.  If anything weird happened,
@@ -4442,7 +4443,7 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (marker & PTE_MARKER_GUARD)
 		return VM_FAULT_SIGSEGV;
 
-	if (pte_marker_entry_uffd_wp(entry))
+	if (leafent_is_uffd_wp_marker(entry))
 		return pte_marker_handle_uffd_wp(vmf);
 
 	/* This is an unknown pte marker */
@@ -4690,7 +4691,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			}
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
-		} else if (is_pte_marker_entry(entry)) {
+		} else if (leafent_is_marker(entry)) {
 			ret = handle_pte_marker(vmf);
 		} else {
 			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
diff --git a/mm/mincore.c b/mm/mincore.c
index 151b2dbb783b..e77c5bc88fc7 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -14,7 +14,7 @@
 #include <linux/mman.h>
 #include <linux/syscalls.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/shmem_fs.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
@@ -42,7 +42,7 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	} else {
 		const pte_t ptep = huge_ptep_get(walk->mm, addr, pte);
 
-		if (huge_pte_none(ptep) || is_pte_marker(ptep))
+		if (huge_pte_none(ptep) || pte_is_marker(ptep))
 			present = 0;
 		else
 			present = 1;
@@ -187,7 +187,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 
 		step = 1;
 		/* We need to do cache lookup too for UFFD pte markers */
-		if (pte_none(pte) || is_uffd_pte_marker(pte))
+		if (pte_none(pte) || pte_is_uffd_marker(pte))
 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
 						 vma, vec);
 		else if (pte_present(pte)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ab4e06cd9a69..d425be97db51 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -326,14 +326,14 @@ static long change_pte_range(struct mmu_gather *tlb,
 				newpte = swp_entry_to_pte(entry);
 				if (pte_swp_uffd_wp(oldpte))
 					newpte = pte_swp_mkuffd_wp(newpte);
-			} else if (is_pte_marker_entry(entry)) {
+			} else if (leafent_is_marker(entry)) {
 				/*
 				 * Ignore error swap entries unconditionally,
 				 * because any access should sigbus/sigsegv
 				 * anyway.
 				 */
-				if (is_poisoned_swp_entry(entry) ||
-				    is_guard_swp_entry(entry))
+				if (leafent_is_poison_marker(entry) ||
+				    leafent_is_guard_marker(entry))
 					continue;
 				/*
 				 * If this is uffd-wp pte marker and we'd like
diff --git a/mm/mremap.c b/mm/mremap.c
index 8ad06cf50783..7c21b2ad13f6 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -17,7 +17,7 @@
 #include <linux/swap.h>
 #include <linux/capability.h>
 #include <linux/fs.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
@@ -288,7 +288,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 
-		if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
+		if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
 			pte_clear(mm, new_addr, new_ptep);
 		else {
 			if (need_clear_uffd_wp) {
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 137ce27ff68c..e0560cc1ce18 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -3,7 +3,7 @@
 #include <linux/rmap.h>
 #include <linux/hugetlb.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #include "internal.h"
 
@@ -107,15 +107,12 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 	pte_t ptent = ptep_get(pvmw->pte);
 
 	if (pvmw->flags & PVMW_MIGRATION) {
-		swp_entry_t entry;
-		if (!is_swap_pte(ptent))
-			return false;
-		entry = pte_to_swp_entry(ptent);
+		const leaf_entry_t entry = leafent_from_pte(ptent);
 
-		if (!is_migration_entry(entry))
+		if (!leafent_is_migration(entry))
 			return false;
 
-		pfn = swp_offset_pfn(entry);
+		pfn = leafent_to_pfn(entry);
 	} else if (is_swap_pte(ptent)) {
 		swp_entry_t entry;
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 6580f3cd24bb..b761c105f84f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -66,7 +66,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
 #include <linux/falloc.h>
 #include <linux/splice.h>
 #include <linux/security.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/mempolicy.h>
 #include <linux/namei.h>
 #include <linux/ctype.h>
@@ -2286,7 +2286,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	swp_entry_t swap, index_entry;
+	swp_entry_t swap;
+	leaf_entry_t index_entry;
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	bool skip_swapcache = false;
@@ -2298,7 +2299,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	swap = index_entry;
 	*foliop = NULL;
 
-	if (is_poisoned_swp_entry(index_entry))
+	if (leafent_is_poison_marker(index_entry))
 		return -EIO;
 
 	si = get_swap_device(index_entry);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cc4ce205bbec..055ec1050776 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -10,7 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/mmu_notifier.h>
 #include <linux/hugetlb.h>
@@ -208,7 +208,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	 * MISSING|WP registered, we firstly wr-protect a none pte which has no
 	 * page cache page backing it, then access the page.
 	 */
-	if (!pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
+	if (!pte_none(dst_ptep) && !pte_is_uffd_marker(dst_ptep))
 		goto out_unlock;
 
 	if (page_in_cache) {
@@ -590,7 +590,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
 			const pte_t ptep = huge_ptep_get(dst_mm, dst_addr, dst_pte);
 
-			if (!huge_pte_none(ptep) && !is_uffd_pte_marker(ptep)) {
+			if (!huge_pte_none(ptep) && !pte_is_uffd_marker(ptep)) {
 				err = -EEXIST;
 				hugetlb_vma_unlock_read(dst_vma);
 				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-- 
2.51.0


