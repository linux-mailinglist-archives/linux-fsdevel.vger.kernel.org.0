Return-Path: <linux-fsdevel+bounces-60501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0253CB48B6A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AE4341EAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F1530100E;
	Mon,  8 Sep 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n99bVbKq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UNtIpMqH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B872FC030;
	Mon,  8 Sep 2025 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329928; cv=fail; b=AaVwzcA26qlYiPkd6MiQWiAjpeJzCbaEerDQPQoJ0hgCRLa68YGxA+t9SNtzc5sWCLD3ZIBOFzeS2q9V2+i9QEN646cxL1wcWm2NEuB86GJfRrarvi8DCewLocchNxANRkw/NxeOFZEj7DNJKrTXLlft4n9Zh1PJzBRVosjRUYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329928; c=relaxed/simple;
	bh=47IUW1/9cRgfISDdopw/gejXAPn1glYAhjTzBUmNCNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Et8vQFHhjaQyj4qdVAzZCXMbQQVlGgRqWcW15QVVZAEgqrDM6QZpi54QPFK99qYXvkC+WvEXSfUTeb/fi+e+xUvW66ZARGsSWyOgtxD9+ZeQjb8drNfRIUHxmo+yN20yaiQF3w9Ge622xfULcuvsVddzyfBeloRSQkJqP739CRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n99bVbKq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UNtIpMqH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588AsxUN014185;
	Mon, 8 Sep 2025 11:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=x2m2zJltpI2d75i0wgHzJI3NxuI4tTUMGch3HIo1zkM=; b=
	n99bVbKq/QgU6sQaCWoof0EwWT8mEUL+0xF2z2jPDM/zVmiz2chsHbJF5dClHPHW
	bDeoALC9fpcenfbEc6m+Ti/hJKv5gmze6Arh4gw4KEd7B9g2e3F3I8HV0+gg9mE8
	/O0pcNwRemBesUezO5ZlCf6OnM3vW0GmlPSUm4Z9zXt8Xn0eeo4E8wT7stHl8vOz
	YOVynDKxebfSvM8zLcZdNtyzH/HLO0Kr19xqCRdT4xOxFgH8ao7yHtAS/kFF2OMX
	70J6DgrOJe2gOridplPK2JHFRQ+U/fRbsQc6OS6I8j7ug4DX3HTcY7iswl3Q+L2y
	E2wOYYb7gjHLC4YulJgc4Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491wt5g0y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5889YAKo030737;
	Mon, 8 Sep 2025 11:11:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd819u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgMPXspYgBEw77Lj74oiAKOXqle3cpEOEic5BeQGHDhcGSYfV7lSLzDJvUD1rPvlWkNfGKJaylLSR4Jf7pvJS5ERuRfAKRqbVnvmanEQgb0GIrrbukD1cwLlPWphd+GqbeQrsPZn+XWeG2LY1rhsurmXFH5VAyM8Bh7qG6EidLt1AtZUj3R4d9EqcNWv8cBN0KCxHnIjW0ppck55QAIZyJYpS4l3VheGCeKWSGhigYy9yTRfyFmgyGyfCCRxLPe0Sz6pYK7UKkOfPKBtcUs7k7xrujGNmhJaqS8ld5bdeI7ypUmdrIxxdoG2M6OgzJxRlVZ91mheBVxn4Y4EWuXcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2m2zJltpI2d75i0wgHzJI3NxuI4tTUMGch3HIo1zkM=;
 b=Aj/cq0bsC+UtINi+qOtvM6RdYl+A33ZNxXTuBBdCHGP8MzWZ+qpMobotDLu/vbXkN2NGI3mGQyOlf0fDibTrKrFwoKPQ4v2h9HIYJq+VrW3ySwUiaXW/393pKakAyysbyp39+bMH4Mlp+VcM56upIdTfrnTqvIpBcyMKMFGm/YcLhQNgOUmA6oO7dCjRacviUjl8ME5LxlmAh+LvPuYow4iPCJbxqZ6VzFuuQZvyTLXykCRiG9VONFeG5M8gqrox+V1CL4bL25UED++vqPrdeB5abo6YRC91hQjlOdyikdZ2Z47atclObGbFu3nzUgVE1BJvqKNoNqTTFN/gqXa8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2m2zJltpI2d75i0wgHzJI3NxuI4tTUMGch3HIo1zkM=;
 b=UNtIpMqHRBVmTX+BZiFBxJcZzNc7uTgA4VP9eaxCj9fm14mr82zmHgMUtFAUg6y9Qv4r8yFtOBpeaY2HMSTtenPWJ8SPkK6UC/hIiJZTQE2PV9ErCy79jzhJo1EMqEmdcswlEkS2FCGn1l0FOB1IgSFHUh0NQGIDYvyjFhLhc5A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:11:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:19 +0000
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
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 05/16] mm/vma: rename mmap internal functions to avoid confusion
Date: Mon,  8 Sep 2025 12:10:36 +0100
Message-ID: <626763f17440bd69a70391b2676e5719c4c6e35f.1757329751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0066.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c10ec92-f5c0-4fb2-2e4b-08ddeec86fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fJsAGUh1nw6ES1DR+uvg5v/kp1C9oEl4SvcQN2PZfqXiVeX+BLROh35QqKaj?=
 =?us-ascii?Q?ypKPPdIT89GpCu2+7cI3OysLnFfoy7o2XI51A+059IvlOsj2VXjlDbCKbU93?=
 =?us-ascii?Q?mnbxCKC1Lw/1t2f9gP8NeL6cRZlJfQ686SZ2iZPraqVV/SDhHAy7/LfTLwYj?=
 =?us-ascii?Q?kgMfQgp7TedkIIFV+TDInNWeUPmy/gJXV22ZO47SPhHp94/IYBv9HpiUeusj?=
 =?us-ascii?Q?PEkJUX+Hw3037DJ/l3dwxOnSOMiIg/21aPZj21NWuNPXCaRDQkQ+Vz+n9t7n?=
 =?us-ascii?Q?cWtcen+v93f+/nmGs4f8vXaQSolcDA1QdX8qlERJVZllck2GbvA4HNTqcn/p?=
 =?us-ascii?Q?xglrwpBbifcZ7BDD5E6JU/lXj44FTIIOkzSGz6/zzOloJc13KzWceJAKMy95?=
 =?us-ascii?Q?y082MVl41MJvuZpX4SlGFE3EjsQOQw1WHzmJjcasH2SOBUB4mpkQW3udpnzq?=
 =?us-ascii?Q?M8kEE+dd7d3gGDQaUtDmROVo/bgD2PGvjhOKDzQigwYJtGXkp+TLze0yhDiC?=
 =?us-ascii?Q?lxUYEhoGxW2L65PsJCJoy90FdQgN0rjNCYsWg1KFXgrNT1WGZKqnr8Tkqab0?=
 =?us-ascii?Q?86rB4GI2OGDOHec7w28Jvg/zwYcjVvcnf1jAlN2SWZXcMAomS3+fgZbzkOAJ?=
 =?us-ascii?Q?MpJOJLrlko50AfcSmtbX4gr4u6UMNxyn8VA//bmvr6D7OtgMoqoY0qkO2xxL?=
 =?us-ascii?Q?9nQt0xy9KUL792K0KCLEtMHbyAiGjjPJRKJkm7Pyqr8aezZOCoVvSmolG3ZO?=
 =?us-ascii?Q?Ta5eEgYc7RJpWpVao0PG2+AVe4BqmUae9HkknJCeDcBWD+YRwgr/OBB6Sg84?=
 =?us-ascii?Q?p5NvawyYDliaSPEN5LXbOGTLFypvbA/lCdZPhb489TR/B1XombS6cfUbw4TJ?=
 =?us-ascii?Q?aINqAnGJdcUsqdC1X2//RVe7Htj5eUP1gYJYPgjunLbcfSabK6I80099zOxi?=
 =?us-ascii?Q?TsK3QMNnzdGM78Ma/9SBCxcSn9QyaVzP+Ob/pQuOjbTM1PV2xWsnP7MqRvKm?=
 =?us-ascii?Q?8zXXnwCdEO/JKo//RLo07hYc3VoZKhlLYZcdH9mXWXvD5UDU6CfUiJbO/Fri?=
 =?us-ascii?Q?m500iDuq6RJA8Q1Eq0pJcIkibIIxpAC7C6htgIf3xhQRNCzclb7VnLl+xPiR?=
 =?us-ascii?Q?hGX6LG0s9B22gfGl9/FQdqbAeBpwbzGZBpRQ+M09e9yPjHWh5/kR4lp6M2Jv?=
 =?us-ascii?Q?cgIkjI1rs1huwyLC+TUoml/iF/CE8b2ZXSJNmEVN2+PHqEG2MfHe4D5efvFo?=
 =?us-ascii?Q?S7zd65kWlPAY3Ox1ZuW9nTEi9H5gNSB6G2CbjZzrLaiGAObRZCFO8NFUisiZ?=
 =?us-ascii?Q?Q7ZaRenOi2vjr7648n6sFBE1HdnJhFSXayXRIOh/YuNML4MckNlwEoYsBb5h?=
 =?us-ascii?Q?SEnLi0KGJXw3LmNwzUOM82Eh6KQWHywllcLy2lg1Fn33Uc6dmfoSSuZi/Myi?=
 =?us-ascii?Q?yucabGIYMKU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rKvOKsWwfnBbzUGAEQsFgQM+oSFe0wOZtRRVLk63mwoWPr04ufCK5LgDCVDA?=
 =?us-ascii?Q?fTLMbe7LCIM36Fy/MI4RqYRyaZbFAirbZUJiy7NaG9+s7f41pnoio5cMh5Ee?=
 =?us-ascii?Q?kHhBBKUvMcCDPhX0n8QS4Uskv3IJvUfVLu4ypYTIw61zL6qk8/wSGvpmuQ8F?=
 =?us-ascii?Q?jh9vyUwv8IFgmazGZUiZN0RRHFT7j++Qz5NhqU05oUSyX2H5fohsrgr3P8fU?=
 =?us-ascii?Q?AXgzEBYzb8QtzyYzPy6+BQBsDQv7DiQXId5lZUhf8myQjQLCuQdhvRC3c+Ak?=
 =?us-ascii?Q?r/VRYjYEatIQNujk3raPBkB1JcVPmmXmEZg2nqfYqcKZDR3xGn5UAjEvqOOX?=
 =?us-ascii?Q?mjOCXlyPdRY/ZQLL4lAu3R70R587sU94kL/eodBaEfBvDMoQY4xN+r2NWLX1?=
 =?us-ascii?Q?Wh6jxcE9S9rQBjak+sL0UdXt0WD/V41T3K5mvLAHdQLAt5yu58P+ywGVI7GE?=
 =?us-ascii?Q?0jt5Oi3NM8WBUHr8pc21OWz4oSacd2xObt2PF+Xcj8R2xm1mr4KyXz+IrHQZ?=
 =?us-ascii?Q?9zN4LxF26/5JNjQr6JkBFoBl/fmvO3tNpXZMsDV3tpPwbyrAU8aoMRzpiME4?=
 =?us-ascii?Q?O5ZI3Naw6agbkk333zXH0Zx1lf9CTx336kmMDw8CdgBVFn0gEvehKi1CR8Oo?=
 =?us-ascii?Q?pmval2sY25ZmhB4BKkGEjUmP9e/CEb1+0JOvE51+havXOWCS7zOgqsKctxbP?=
 =?us-ascii?Q?gRz2uFMWZYvBNS093eTLxMEyGyzYJiGI/VYzPaBzWylxGWvdQHWfARca0WL9?=
 =?us-ascii?Q?NRPy1mdxuoBV134lEgPhvBCGZK1yGOky2bZd0pWKirFHetLgtenNJp4nr0C7?=
 =?us-ascii?Q?TCWVBSCAPfYxHMKVByd5lRIDcW1aNl0Fu/5J9WNXVq5f6Z69axOOyeftqkg+?=
 =?us-ascii?Q?LbwGLGFQNKENzXv2BknNxtz0fJWFqj7BBChJLxTuU5F26eW0z5R9eKEBLcvg?=
 =?us-ascii?Q?pQJr1fIycOYVNtWzRUbDXgmZSHRYQp/9UDVmeodQXlpLTTKYtZD3GlChesRm?=
 =?us-ascii?Q?VSyIgsqAaEZgK0QN39l6xQ7/jkXjPp6e54p02SLJA9NDbRVFx9ris6gfXL6W?=
 =?us-ascii?Q?4vwpJfybyDcSQeRsePlAYFxafo2bo9gpCjzfRjjmMZkTAqILLRkMOo6v0zqu?=
 =?us-ascii?Q?dBsO3scdTb11k/0oFGxbuzR+c80Lm4w7Zbhrc47z27kNzMSB2+13FDFGhSxW?=
 =?us-ascii?Q?8P9FszPr3Mufn9I7GpEJot6kP8vacHzj2xRfKiA1Ps2xEDARJaLdOExSPiL1?=
 =?us-ascii?Q?SdpIsr7KCJreYBJ1mTLq9xkYXXg00zTKFRXe4PdgFAN4TyKULkkDLthJOQFz?=
 =?us-ascii?Q?CpPPAwF0RfxCnOfTDw7P6vCx88m20OMITSHQx7fUmf9nortmqsI1sUqX0ymU?=
 =?us-ascii?Q?TPmJ2mEPVeP9OEtEiBtpMZmKqsq2+PtqmWZ2d5p2rzErnLcTrYFYZbbc+j1Y?=
 =?us-ascii?Q?X9sSZI+ysfd2tHvTla0+4ww2DOwX2LaXGYgcOMZjTfFZwNKQvnjwg4qnNIpg?=
 =?us-ascii?Q?gg/8ytkJla0S59RqrmYWygo7c6jmLwrCekpOu+A1Uz1fz5XF084wLldC/mZn?=
 =?us-ascii?Q?NzXg0WO6C9V0o2QkJ4EmPOtgqgE8bSmlyIqxTo5Id/LQKsCeX4pXJ+7Xxpof?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ETNn+vKgGRj90fn3dMMOx9eJA/r8WsgB6S73gV7qGDaKsKL8AiANDihkvqn0vZOkVSM20a6wXUA+aHY0xFjFVIp+ElqLlyKL5mI4gbZ/QmUdhCrxsNeY2yqBhsYnoHQM9iWNe+SVPpa8hi69esRgg5FW2IfXLblkylEuNbKjbpi0xAfxrVeKkpsMI4mpF+acyDHKsZxHThYiCUHt5+HlPr7xxuBl8z4xylKNMKnyEsICzv3+2g8NzHlrrBNrR1DxyAzGRLj3KNWB4PuGLomGMh5c3aSXZhuzmqj+PXCZT4wC3iTFNrNwI7BPvF4ojgZkq4a9CpyyhABjOclnJDETenonTRJQ4mtAgd9BJlCHaC38ceFh6vfZgPzZbbz2PjeVbmqhJzpgCa7vlpKJwEMcoH4kyqph6CbTseXdca7D4c22Zx7a4w3LWlQzRvcW6SYJaARZkCVRDSzoD9xxWqc5peTuQtQm/xVkrpW9vzXHp+nIj8tok8NZJ7cuma/k85neWU3TX8+Yc4ad31FBXilZbFrxL41CcMY/AkG+tzDMymOo6SCPKbR8IOwct5qIppYERoDgcCT+q9CvPQlu8H415iLIcSfIBcoaU1SvvHQsXRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c10ec92-f5c0-4fb2-2e4b-08ddeec86fb7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:11:19.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2Vl/xtGhpYFsq1Ij+9X6Y7AYlb7G7KWPeB2udVVZG61jAp2LnTghDVLywtDg8Mc27J+exFjrucAJfTcYwUjHS6/ZVWpc8AhCqGxp8cHRDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509080113
X-Authority-Analysis: v=2.4 cv=ON0n3TaB c=1 sm=1 tr=0 ts=68beb9e0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QQqg7_2JtjZtJ-DplxwA:9
X-Proofpoint-ORIG-GUID: L2muTcunIzeSwfBYBqVKynE-73PpkFBr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDExMSBTYWx0ZWRfX6vRX62kU8AH0
 M+2FTXHRaAwsI3/2A2UG197wggf3oMkgtO3jJJxS+gcqmeDvSq7u+rWBhMgkN9A2T5Or1IVAIdM
 zXusAALak8PFXWFr3kvbriLoT8LnOKFkIBz5i/sDvCHmiiG2B8x3q4knpgPcWt85NsmlzqswhrB
 d3iWVMVD7jFljznS5Tl5O/EI5s1nKiM+UEvTMNUj08ZRZV3fYClO2cwMrVROYNF2gjQ0mv17mya
 Cq6zsmLYgC4HPGmp8dYjaOJy2F1UctejYCIEh7Zk3XpYlR2mPbwrrYo9d0cvdtxZxHYtCL8XqdZ
 9B2t0wGgY2ByVO9oWh6jG77XdQm3eYmgXzc0QCCa3cFzfribPkyJHhvDIO8RKPpIhtfzl02w0Zm
 xm9xMmVp
X-Proofpoint-GUID: L2muTcunIzeSwfBYBqVKynE-73PpkFBr

Now we have the f_op->mmap_prepare() hook, having a static function called
__mmap_prepare() that has nothing to do with it is confusing, so rename the
function.

Additionally rename __mmap_complete() to __mmap_epilogue(), as we intend to
provide a f_op->mmap_complete() callback.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index abe0da33c844..0efa4288570e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2329,7 +2329,7 @@ static void update_ksm_flags(struct mmap_state *map)
 }
 
 /*
- * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
+ * __mmap_prelude() - Prepare to gather any overlapping VMAs that need to be
  * unmapped once the map operation is completed, check limits, account mapping
  * and clean up any pre-existing VMAs.
  *
@@ -2338,7 +2338,7 @@ static void update_ksm_flags(struct mmap_state *map)
  *
  * Returns: 0 on success, error code otherwise.
  */
-static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
+static int __mmap_prelude(struct mmap_state *map, struct list_head *uf)
 {
 	int error;
 	struct vma_iterator *vmi = map->vmi;
@@ -2515,13 +2515,13 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 }
 
 /*
- * __mmap_complete() - Unmap any VMAs we overlap, account memory mapping
+ * __mmap_epilogue() - Unmap any VMAs we overlap, account memory mapping
  *                     statistics, handle locking and finalise the VMA.
  *
  * @map: Mapping state.
  * @vma: Merged or newly allocated VMA for the mmap()'d region.
  */
-static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
+static void __mmap_epilogue(struct mmap_state *map, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = map->mm;
 	vm_flags_t vm_flags = vma->vm_flags;
@@ -2649,7 +2649,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
-	error = __mmap_prepare(&map, uf);
+	error = __mmap_prelude(&map, uf);
 	if (!error && have_mmap_prepare)
 		error = call_mmap_prepare(&map);
 	if (error)
@@ -2675,11 +2675,11 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	if (have_mmap_prepare)
 		set_vma_user_defined_fields(vma, &map);
 
-	__mmap_complete(&map, vma);
+	__mmap_epilogue(&map, vma);
 
 	return addr;
 
-	/* Accounting was done by __mmap_prepare(). */
+	/* Accounting was done by __mmap_prelude(). */
 unacct_error:
 	if (map.charged)
 		vm_unacct_memory(map.charged);
-- 
2.51.0


