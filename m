Return-Path: <linux-fsdevel+bounces-23159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095AA927DC6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5701C22FEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2013BAC2;
	Thu,  4 Jul 2024 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ok0O6C+d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pT2kgb+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32166137764;
	Thu,  4 Jul 2024 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121312; cv=fail; b=pCe5HcTXP0pvCZsEaisIIdA0dH/98RDYrLhT4LLVgh/XWkC+wQmCVLU2vTzVaapSDMFcIfVAQwScNT8U9Xu8re9hS/JBdi3TTl0T3yIwBnW/cwavbtGQzq8avK2FVD1ze8oeXB5k0f+1EFFGU6Qgc+4WeNGvt5Xrs28inNJZczA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121312; c=relaxed/simple;
	bh=GC56LjCytjL9RtNhULAYAG0cnQ/cmJC6TTLnbdzJl1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=buMff0OEEzHFocucJnb562PLNnL0uq/M6Ddjp+pIQ+/7ZyOvEVpq84IZzVNwaO6Anr5exgdWrHgSWb12Czmg7FYIQipG30JIoEmveyiulH++nK0g195hh8rlCEwubt/cUxyQqiZ3m4/0fbco0/j0VpI5sUwldcE1vMHimqvXxgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ok0O6C+d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pT2kgb+O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DnvgH016605;
	Thu, 4 Jul 2024 19:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=22hILCM5X9sMn9gY63YTPAbD4zPS0lb7vfJ+lyUfogw=; b=
	ok0O6C+d5glkHyuqRvTruxKpAs33y7Ilf0vVA4Mo6rCwetc3sIY+XVMwEV5qRlxM
	UozUDq4KhhxXRDO/IfoUcVt3RFeX/vJ/UITscF01uKIOozDGw6gZEjXA9ok+eeU6
	MRswowq+1o8kH2zOQoJTCWj4r5hiL90nCQDFQ5RQB2HBp6UMGZTtAklqh7lSf6oO
	4/yKpehdNSUFhYp3TWyVC4A4QWAnFxxQ1jV0FjYlzAmf5l4QKR0/4cspWWQomJgN
	FGo/+RjhSWhAgywutHL3PQN+1aIYJ/Y8kujDFtjBj0qoPI1Kzp54CXLLCWmhfV6t
	5ihCm6KeaHoh7c4MbL/pNg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0ts4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464IUqZO035674;
	Thu, 4 Jul 2024 19:28:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qadwxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVhWpAMJbxzQPK+5jIAzvUg4mMlBqqbcbbuMDdkDOEVd2Dpw2LQtldJ4RkAQRhpulEexhAVwJDTz8Kip7Wh/e/jlfa66RvmT4IN8bRWaVef4icznEl4hN93l3bDAwAiXP1ffX2j7OnD7coMwFZncHos93SQxw6ElQSmg76seRrmj5Okv/fa258Dhl1zIeSAe4w0J68MI+rQlrUpAot9khhIyl6fROL3ZzsWXbTGBuFUmCxekTJ86Fbi0aKw6pijbRx5y3VpNFoM0HdZ7LRIQWB5eW/k1jciyFOlgjGxX/ZAxAThU/xmYYOuJokrCogUPolV+LELV9ZOC0sz79YOHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22hILCM5X9sMn9gY63YTPAbD4zPS0lb7vfJ+lyUfogw=;
 b=aud9vzDjajy2uam0y9PiEoo6DpnQ6lcCkm126pED6Tl1GqAbMIpnxCuHKkUh86kBg5X4yxtQX8coPpnaxLG0nGIwqcLZhqIyolUltD3IifMWWuqohdJm+mH8qkvudC5bDyUoKvAgXF0ktXvhlBjxulDr+MI+OZGzACzSn6IkKJLoUv+dkgN3+oywk42s5VuLOE7sZWgjq9tds+z9pOr8NHgdao91LV67ZqOfU5E71eOVq+Ck/SlREgMXGcjdLeIIJxs1N4SDYzUyHlo9D5d3UpWu0OGzUrmmkq7+UR0PCCL/5N2VqXBa9NgMu8imKnf0RZ8ewMSlh/dmifnlz6WF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22hILCM5X9sMn9gY63YTPAbD4zPS0lb7vfJ+lyUfogw=;
 b=pT2kgb+O73gDmJR6MhIyvX4OXdH6RgsTtxrkypxSYhHNUwVR/cPYa05hAUuJi9y6ua72FAY0aqnot220WM/+rq45bSdyT7i7jqRg105l0AnSoj3LBIjWVxBNcXkFlBYh5hQ1DcfNv6h3Dn/yyVhoyFOoNY6MFEjlV0+AdnMFOMw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 19:28:12 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 19:28:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v2 1/7] userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
Date: Thu,  4 Jul 2024 20:27:56 +0100
Message-ID: <76a0f9c7191544ad9ccd5c156d8c524cde67a894.1720121068.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: cebb3c64-af75-4420-1597-08dc9c5f719d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ySkwQSSYk9m3eWEmnfaLhzpnpeBDyxxpo9PSdxxiVKfg4gEdGb5SKvjLFlmY?=
 =?us-ascii?Q?KxSzuW60mWPEoIBJKtr8eJdW6e+lyWRGkVjlCri/7lxSOkD6tN3w+2oWhn4v?=
 =?us-ascii?Q?rqy0rjm7b+y0qnc6e692NtqDbtgofyo4o3FfM4Dro4U2w8ehHn1XzGtKcuX3?=
 =?us-ascii?Q?bHWOvJ4Dims7y4jvamms8lLsSG1oOhatpqbv5MS4Ktw/8bXDU2qNKz10BOPV?=
 =?us-ascii?Q?j8ks8CAeWuP4c/lBtXsSwfKMISTByO+nvaUISccT/6WiObwY/oxwNLrsUcwK?=
 =?us-ascii?Q?sBAN1QA4iZsVbDPUc7381YEJdydrEHK15tgbJSSjv/mL6SVeblA4w36MXP3c?=
 =?us-ascii?Q?jmlZ0MglOhNjZVfFoUS+k+jNRQQumcwR4XJI70NaG6jyUt1KzDFcU5dmK/0G?=
 =?us-ascii?Q?iH06lxSyrtXs40vDmCXipv5MNecNbNEuupW5WbXjnj9njkYEtGxBG/VxzTUO?=
 =?us-ascii?Q?29Yka8g16RUmXf0hk8jpqVpV4sqSnOZOvRT3Ke2MSkabQG9Y75ZElikqmGE3?=
 =?us-ascii?Q?qUvAQ4f62ZqjaNlIVv2tlKG93xm4Y2/14/UpaidA6/bpNrv0aGcnVUuTfsWx?=
 =?us-ascii?Q?+iEwbGiPCchOJLjDdC9vDqOIfa6wh152EGrNtVIq6akCJbLt4woL1PMMeHsf?=
 =?us-ascii?Q?tiRYXznMweCWggtARdM8zjrscjCCkUYvvGLE5lp5gxkM93JPLXHty3j9zRrx?=
 =?us-ascii?Q?hUIIYI112zew6GTjP+FT7gN9UvUYEyXptvS4vnZRoFAeGKj5navYASGPnWvo?=
 =?us-ascii?Q?/hiZLh5Se/KAREy/n/ljAzHV5P8jqKURxj0PR9GBBHyuNOtEfOB9jkhBFkxM?=
 =?us-ascii?Q?GKOLBodOjw6bSX0ACUNqoTfds4y8TgEVpVDSrFP5sZ41w/golBZOc62EtlyM?=
 =?us-ascii?Q?Hn9YdvZMyP8gBoXw31ceRUs+WTTSqzlsVtbsPIiwyyMYGqpEsd/NpEUBDdbM?=
 =?us-ascii?Q?BbYKeK0K6yGgH2gZX9Zx1s1+IqHjKa8gW3+DBtJ0iIFJgTdj/dDj7WWhGwiS?=
 =?us-ascii?Q?PIXeKpi9STTX620sA5z5vz2f7WUmGce3HPThhIDenwVTqLiKD/5OpCbj4Cyc?=
 =?us-ascii?Q?OMASqCzzo7um2u+teqcuibyV8yCPIMmGhn/+mSazTodIkpaYjW5AxqG7//oG?=
 =?us-ascii?Q?vJkw1Je6QS3JovxhDOWOFII6d2BckqjqxNEbfii2iyjQsTK7jHn8+zXnpons?=
 =?us-ascii?Q?WEhMHO1CKTpo4XFaAyLA1g+1p51FHJ8RBVEdZrC/sC4hY1W+nS0os0GN220E?=
 =?us-ascii?Q?L3KXdadizQ9UwC5rp9A4ws9ZznwSnBxXpPd0e2E25aKXMvMilmwhaKgrzI5t?=
 =?us-ascii?Q?lcYvBQmbf23EUJefhDFaCI7IaIs6MLb48osp9aBQAGnzrw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IHk9qjifX/ZtarWqJkWFHUmk/jCOQHotddITmtYDn75igYG1poiQqDBL/OuP?=
 =?us-ascii?Q?PkCrLzMXE0EAg9Xk08HKqC/uqkCvPhQQGvnx+tJuq2fb40wNGs//VpLNHT5W?=
 =?us-ascii?Q?uohhnJ1ZaHoziMIpyHQ1drccxPm2F6eQpjDb/Ok2hvLwF4WI5fD4MRrP8wYX?=
 =?us-ascii?Q?2EHfJeBrnTdVh8ABo7jsY//jN4S0hQgGokDi3xNGXujJYWAWsnRufwAjw7rH?=
 =?us-ascii?Q?EJw4Jz5pNrvzPmwOJIahyX4Aql9ULdM9dmBkZEQUZrqeFvRZHpJ4fBX/2de5?=
 =?us-ascii?Q?Mc680JX2/vlckh3VqEdx4Mtom3uhcjeqCU6lOfv5l4Xt5HYt8lkyeMYXrLy1?=
 =?us-ascii?Q?THv+XTSpxntFlppVLkn38NwLuXooOz5Xea4mKiNXDB/k7vqQALNgSroUNvR+?=
 =?us-ascii?Q?4ZSYRL4rbfeUO5ZIOKhfu6zoGYberkU41+F+K1BME1GkU2I6urjM6+5mEm6B?=
 =?us-ascii?Q?QCdMWLi4iBW04kaHcx3m6QTdAhQLRMQ0Tf8xvn6VCS7/T2lpP2VzopsIzjK9?=
 =?us-ascii?Q?pfpz4NKPU//RQ727HUVONakTOU6TaNcNwbclru7V/pBK8e1wSYDAexxvRoxF?=
 =?us-ascii?Q?Zmphn6s0yvfmUpVX6TP/JVNUrLiG/12r68rCL2bUyWLabrfouUB2l8o8+oOT?=
 =?us-ascii?Q?56s9eSxNkDWRSxAVWOIRNB4PZc7iVwAHBsJPsbDarL13gsx9kB0k1UrARjBw?=
 =?us-ascii?Q?WKcg3jfC2uRWmY4GF1NwEob4a15yqxVXMOvi+6qqCIYUmiPpv/OjOJWzlG7N?=
 =?us-ascii?Q?twM09B3gj7DiJqjFBIJ1WRxvhboN4HiMZxDPViGbyr3mdyyqtxtjEeTpyNhu?=
 =?us-ascii?Q?vtT2ccNjwee92wmXKYLY82BgYFcPq717cUH5PrlCDEnVVe8PETFUfVrLO9Tq?=
 =?us-ascii?Q?OLuHI7vW6vHbCKmWuBhS9s/A3ctT5Uy6eP4fCA9BucKhcGt0ZGezVkK2bTtL?=
 =?us-ascii?Q?LEBYypo6ErGTy0+lgpwhnR4bxWSL95phkm1mgNkVsPckKG4qDx/whPIaxXM9?=
 =?us-ascii?Q?N2WRz7iJ9hIt5Kdbgt0j6uEdZQv5MhHMSa/mq+MyxwtXkv9bPvObG0fl0TQi?=
 =?us-ascii?Q?cskMUXV/ZWvfwn92TEbvSKFeYGBrprqG1ik8yPdJlrlD9P+Yb1RJhJFX3ig0?=
 =?us-ascii?Q?nTuKgOo5ENhHzHCP2V74PW6lMVpt99Cq8sr+r78gPlCZtNEzlCYGpnauIcRu?=
 =?us-ascii?Q?Y4QoZqQq9RZnUs/aIHMLukaTU1/dfNzjnGGoKAn0xu7a28qaaBZnv25Bq+mL?=
 =?us-ascii?Q?oxC7FwyZtHY+zCFoHoLijZ5l6oziKNYfMPNYuU9tkYb9MbrEO8L3Hlf924x3?=
 =?us-ascii?Q?jTOX4Ushb5pGhK8s9qqh/Lj160ot52A23I1dIQlrIgoi6CdMOGV1/x36KafG?=
 =?us-ascii?Q?Q9HveZanr5gVtbW+pVm6JFbyW/HZ3ot/mHYyhunuSOhovhpiA+MtOur37kBE?=
 =?us-ascii?Q?6x1wS8USzpDuPyYdQJYAX0vDyvH5j/znnCufJARWIHomxG6anFD3NfBSuC3B?=
 =?us-ascii?Q?JwvFoImK5kQaqEuoV/zury5fVQXiK25ObvhvQVOvPNVu3GouFih6CQtKeWvO?=
 =?us-ascii?Q?LpPtFOsJtdIDLm3BaegTvxe+n+xq7LuNZDNZykwgisflbAtd1X2Sl8HsSjVM?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wznoMgHNqHdZBTKFUuqR4941DH5KXwH8PaowtUg2dwuUE3okykU0x8DS5KCqiGDqlIePbYfZO6Mt4Bq7Ejz2xqDYiL8bi9vRANtcXgbOecdw28RVwZDoLEsbKey1+5T0CMd1IBiu0tJHa1WsamdKHBGa7IfCKa8Rx9fDGGMtsxdro8UdUNTFdo2PFiOP/e/Ic1xRO63ephujU7mGODR8/cWmDaFiyVTOreBRXU9IVTZeiDJC4Xss1sgS7YnQyMA6Cr9hX/X6UzFdaYczRMIfXcwUN6rt2JGHDbfE8in6Qg3DLiQ4ixVl2gxHsURGPPIZPCq3kN+Wvl/ZQOSo+Z+hbfG5CLO+WzxvMuQ3hLOhEIMvWG/mY5D8oJIcl+PNFhUdzYUys6/g+IfgLIZI4maDGPZPWO7271AdztoaG06dIb+XrQ1SvOKRs9T4JKhP5Y3DbjC8y8x83G8Rs/dviWm+Iu0rpXwHsTPBnbNx924feWph1oRNGqCUlQiIYoISwTvhembxQQYJZ09dxDaqHJfw3jBsI4pbwzHaS+WPnJ+DtRfMae0QRhMe/YV9jdNUAYfq/HLzizKJgSFhAipJ8/sYVJXQTJ7qo2cvjQ+uNqoDYqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebb3c64-af75-4420-1597-08dc9c5f719d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 19:28:12.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGpugw3Pidp6PvNOmZn4K0pog3SAT9ZOH6ySS0dYTy73OWrQjU5ojV/k7J0XWwlwJQUzEjQPCk3vSG6mI52uS+pkAQVShLBSUwLs6AbgDdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_15,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040140
X-Proofpoint-ORIG-GUID: 6Fm0KsyhgyyvHWcH_OWsBMtKAtUvBY3a
X-Proofpoint-GUID: 6Fm0KsyhgyyvHWcH_OWsBMtKAtUvBY3a

This patch forms part of a patch series intending to separate out VMA logic
and render it testable from userspace, which requires that core
manipulation functions be exposed in an mm/-internal header file.

In order to do this, we must abstract APIs we wish to test, in this
instance functions which ultimately invoke vma_modify().

This patch therefore moves all logic which ultimately invokes vma_modify()
to mm/userfaultfd.c, trying to transfer code at a functional granularity
where possible.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/userfaultfd.c              | 160 +++-----------------------------
 include/linux/userfaultfd_k.h |  19 ++++
 mm/userfaultfd.c              | 168 ++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 149 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 27a3e9285fbf..b3ed7207df7e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -104,21 +104,6 @@ bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
 }
 
-static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
-				     vm_flags_t flags)
-{
-	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
-
-	vm_flags_reset(vma, flags);
-	/*
-	 * For shared mappings, we want to enable writenotify while
-	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
-	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
-	 */
-	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
-		vma_set_page_prot(vma);
-}
-
 static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
 				     int wake_flags, void *key)
 {
@@ -615,22 +600,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 	spin_unlock_irq(&ctx->event_wqh.lock);
 
 	if (release_new_ctx) {
-		struct vm_area_struct *vma;
-		struct mm_struct *mm = release_new_ctx->mm;
-		VMA_ITERATOR(vmi, mm, 0);
-
-		/* the various vma->vm_userfaultfd_ctx still points to it */
-		mmap_write_lock(mm);
-		for_each_vma(vmi, vma) {
-			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
-				vma_start_write(vma);
-				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-				userfaultfd_set_vm_flags(vma,
-							 vma->vm_flags & ~__VM_UFFD_FLAGS);
-			}
-		}
-		mmap_write_unlock(mm);
-
+		userfaultfd_release_new(release_new_ctx);
 		userfaultfd_ctx_put(release_new_ctx);
 	}
 
@@ -662,9 +632,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 		return 0;
 
 	if (!(octx->features & UFFD_FEATURE_EVENT_FORK)) {
-		vma_start_write(vma);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
+		userfaultfd_reset_ctx(vma);
 		return 0;
 	}
 
@@ -749,9 +717,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		up_write(&ctx->map_changing_lock);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
-		vma_start_write(vma);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
+		userfaultfd_reset_ctx(vma);
 	}
 }
 
@@ -870,53 +836,13 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 {
 	struct userfaultfd_ctx *ctx = file->private_data;
 	struct mm_struct *mm = ctx->mm;
-	struct vm_area_struct *vma, *prev;
 	/* len == 0 means wake all */
 	struct userfaultfd_wake_range range = { .len = 0, };
-	unsigned long new_flags;
-	VMA_ITERATOR(vmi, mm, 0);
 
 	WRITE_ONCE(ctx->released, true);
 
-	if (!mmget_not_zero(mm))
-		goto wakeup;
-
-	/*
-	 * Flush page faults out of all CPUs. NOTE: all page faults
-	 * must be retried without returning VM_FAULT_SIGBUS if
-	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
-	 * changes while handle_userfault released the mmap_lock. So
-	 * it's critical that released is set to true (above), before
-	 * taking the mmap_lock for writing.
-	 */
-	mmap_write_lock(mm);
-	prev = NULL;
-	for_each_vma(vmi, vma) {
-		cond_resched();
-		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
-		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
-		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
-			prev = vma;
-			continue;
-		}
-		/* Reset ptes for the whole vma range if wr-protected */
-		if (userfaultfd_wp(vma))
-			uffd_wp_range(vma, vma->vm_start,
-				      vma->vm_end - vma->vm_start, false);
-		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
-					    vma->vm_end, new_flags,
-					    NULL_VM_UFFD_CTX);
-
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+	userfaultfd_release_all(mm, ctx);
 
-		prev = vma;
-	}
-	mmap_write_unlock(mm);
-	mmput(mm);
-wakeup:
 	/*
 	 * After no new page faults can wait on this fault_*wqh, flush
 	 * the last page faults that may have been already waiting on
@@ -1293,14 +1219,14 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
 	struct mm_struct *mm = ctx->mm;
-	struct vm_area_struct *vma, *prev, *cur;
+	struct vm_area_struct *vma, *cur;
 	int ret;
 	struct uffdio_register uffdio_register;
 	struct uffdio_register __user *user_uffdio_register;
-	unsigned long vm_flags, new_flags;
+	unsigned long vm_flags;
 	bool found;
 	bool basic_ioctls;
-	unsigned long start, end, vma_end;
+	unsigned long start, end;
 	struct vma_iterator vmi;
 	bool wp_async = userfaultfd_wp_async_ctx(ctx);
 
@@ -1428,57 +1354,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
 
-	vma_iter_set(&vmi, start);
-	prev = vma_prev(&vmi);
-	if (vma->vm_start < start)
-		prev = vma;
-
-	ret = 0;
-	for_each_vma_range(vmi, vma, end) {
-		cond_resched();
-
-		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
-		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
-		       vma->vm_userfaultfd_ctx.ctx != ctx);
-		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
-
-		/*
-		 * Nothing to do: this vma is already registered into this
-		 * userfaultfd and with the right tracking mode too.
-		 */
-		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    (vma->vm_flags & vm_flags) == vm_flags)
-			goto skip;
-
-		if (vma->vm_start > start)
-			start = vma->vm_start;
-		vma_end = min(end, vma->vm_end);
-
-		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
-					    new_flags,
-					    (struct vm_userfaultfd_ctx){ctx});
-		if (IS_ERR(vma)) {
-			ret = PTR_ERR(vma);
-			break;
-		}
-
-		/*
-		 * In the vma_merge() successful mprotect-like case 8:
-		 * the next vma was merged into the current one and
-		 * the current one has not been updated yet.
-		 */
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx.ctx = ctx;
-
-		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
-			hugetlb_unshare_all_pmds(vma);
-
-	skip:
-		prev = vma;
-		start = vma->vm_end;
-	}
+	ret = userfaultfd_register_range(ctx, vma, vm_flags, start, end,
+					 wp_async);
 
 out_unlock:
 	mmap_write_unlock(mm);
@@ -1519,7 +1396,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	struct vm_area_struct *vma, *prev, *cur;
 	int ret;
 	struct uffdio_range uffdio_unregister;
-	unsigned long new_flags;
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
@@ -1622,27 +1498,13 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
 		}
 
-		/* Reset ptes for the whole vma range if wr-protected */
-		if (userfaultfd_wp(vma))
-			uffd_wp_range(vma, start, vma_end - start, false);
-
-		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
-					    new_flags, NULL_VM_UFFD_CTX);
+		vma = userfaultfd_clear_vma(&vmi, prev, vma,
+					    start, vma_end);
 		if (IS_ERR(vma)) {
 			ret = PTR_ERR(vma);
 			break;
 		}
 
-		/*
-		 * In the vma_merge() successful mprotect-like case 8:
-		 * the next vma was merged into the current one and
-		 * the current one has not been updated yet.
-		 */
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-
 	skip:
 		prev = vma;
 		start = vma->vm_end;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 05d59f74fc88..6355ed5bd34b 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -264,6 +264,25 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
 extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
 
+extern void userfaultfd_reset_ctx(struct vm_area_struct *vma);
+
+extern struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
+						    struct vm_area_struct *prev,
+						    struct vm_area_struct *vma,
+						    unsigned long start,
+						    unsigned long end);
+
+int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
+			       struct vm_area_struct *vma,
+			       unsigned long vm_flags,
+			       unsigned long start, unsigned long end,
+			       bool wp_async);
+
+extern void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
+
+extern void userfaultfd_release_all(struct mm_struct *mm,
+				    struct userfaultfd_ctx *ctx);
+
 #else /* CONFIG_USERFAULTFD */
 
 /* mm helpers */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e54e5c8907fa..3b7715ecf292 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1760,3 +1760,171 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	VM_WARN_ON(!moved && !err);
 	return moved ? moved : err;
 }
+
+static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
+				     vm_flags_t flags)
+{
+	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
+
+	vm_flags_reset(vma, flags);
+	/*
+	 * For shared mappings, we want to enable writenotify while
+	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
+	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
+	 */
+	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
+		vma_set_page_prot(vma);
+}
+
+static void userfaultfd_set_ctx(struct vm_area_struct *vma,
+				struct userfaultfd_ctx *ctx,
+				unsigned long flags)
+{
+	vma_start_write(vma);
+	vma->vm_userfaultfd_ctx = (struct vm_userfaultfd_ctx){ctx};
+	userfaultfd_set_vm_flags(vma,
+				 (vma->vm_flags & ~__VM_UFFD_FLAGS) | flags);
+}
+
+void userfaultfd_reset_ctx(struct vm_area_struct *vma)
+{
+	userfaultfd_set_ctx(vma, NULL, 0);
+}
+
+struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
+					     struct vm_area_struct *prev,
+					     struct vm_area_struct *vma,
+					     unsigned long start,
+					     unsigned long end)
+{
+	struct vm_area_struct *ret;
+
+	/* Reset ptes for the whole vma range if wr-protected */
+	if (userfaultfd_wp(vma))
+		uffd_wp_range(vma, start, end - start, false);
+
+	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
+				    vma->vm_flags & ~__VM_UFFD_FLAGS,
+				    NULL_VM_UFFD_CTX);
+
+	/*
+	 * In the vma_merge() successful mprotect-like case 8:
+	 * the next vma was merged into the current one and
+	 * the current one has not been updated yet.
+	 */
+	if (!IS_ERR(ret))
+		userfaultfd_reset_ctx(vma);
+
+	return ret;
+}
+
+/* Assumes mmap write lock taken, and mm_struct pinned. */
+int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
+			       struct vm_area_struct *vma,
+			       unsigned long vm_flags,
+			       unsigned long start, unsigned long end,
+			       bool wp_async)
+{
+	VMA_ITERATOR(vmi, ctx->mm, start);
+	struct vm_area_struct *prev = vma_prev(&vmi);
+	unsigned long vma_end;
+	unsigned long new_flags;
+
+	if (vma->vm_start < start)
+		prev = vma;
+
+	for_each_vma_range(vmi, vma, end) {
+		cond_resched();
+
+		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
+		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
+		       vma->vm_userfaultfd_ctx.ctx != ctx);
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
+
+		/*
+		 * Nothing to do: this vma is already registered into this
+		 * userfaultfd and with the right tracking mode too.
+		 */
+		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
+		    (vma->vm_flags & vm_flags) == vm_flags)
+			goto skip;
+
+		if (vma->vm_start > start)
+			start = vma->vm_start;
+		vma_end = min(end, vma->vm_end);
+
+		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
+		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
+					    new_flags,
+					    (struct vm_userfaultfd_ctx){ctx});
+		if (IS_ERR(vma))
+			return PTR_ERR(vma);
+
+		/*
+		 * In the vma_merge() successful mprotect-like case 8:
+		 * the next vma was merged into the current one and
+		 * the current one has not been updated yet.
+		 */
+		userfaultfd_set_ctx(vma, ctx, vm_flags);
+
+		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
+			hugetlb_unshare_all_pmds(vma);
+
+skip:
+		prev = vma;
+		start = vma->vm_end;
+	}
+
+	return 0;
+}
+
+void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
+{
+	struct mm_struct *mm = ctx->mm;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	/* the various vma->vm_userfaultfd_ctx still points to it */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma->vm_userfaultfd_ctx.ctx == ctx)
+			userfaultfd_reset_ctx(vma);
+	}
+	mmap_write_unlock(mm);
+}
+
+void userfaultfd_release_all(struct mm_struct *mm,
+			     struct userfaultfd_ctx *ctx)
+{
+	struct vm_area_struct *vma, *prev;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	if (!mmget_not_zero(mm))
+		return;
+
+	/*
+	 * Flush page faults out of all CPUs. NOTE: all page faults
+	 * must be retried without returning VM_FAULT_SIGBUS if
+	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
+	 * changes while handle_userfault released the mmap_lock. So
+	 * it's critical that released is set to true (above), before
+	 * taking the mmap_lock for writing.
+	 */
+	mmap_write_lock(mm);
+	prev = NULL;
+	for_each_vma(vmi, vma) {
+		cond_resched();
+		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
+		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
+		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
+			prev = vma;
+			continue;
+		}
+
+		vma = userfaultfd_clear_vma(&vmi, prev, vma,
+					    vma->vm_start, vma->vm_end);
+		prev = vma;
+	}
+	mmap_write_unlock(mm);
+	mmput(mm);
+}
-- 
2.45.2


