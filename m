Return-Path: <linux-fsdevel+bounces-67766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C5AC498DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550CF3AF267
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756E346A0D;
	Mon, 10 Nov 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pqAskCi1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S8yk0cUk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584743446AD;
	Mon, 10 Nov 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813466; cv=fail; b=VwTb/RUbBzdDyO7WubrEAUrDViw4Iq5oNmE2UzvsarecFvH/q9YMD9YX3KDbZWBhBJz4c5l3K9ruvEYFMxWeqliLpwIkcvMYwgJki+HAt0g21kRMKHj/BluV/Zb0F7Ph6bT73xl5PNdVqiICVbTL8Ck16hxu3W2VRzFhJMHeYDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813466; c=relaxed/simple;
	bh=UVzI0162fEkE8W4HuwqsQyiwBgaQfv8gaKgbWm5zR54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UX1PDPzIHui1GnxQ+yOZ4QOc1wppooeRbclez1IDjzzCqDFXHVXLCwRsk55De2r1RNtNNPdh1I1OqZEvGsXG12iyArhiiOLsWi/NLg0/wZAkQ547cHWIrB0vjKNBuz2VCTTgge2JxkXOrynU/gXsN8oQwEOaYR4Oq7xLhU1cVmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pqAskCi1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S8yk0cUk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAMIJlg025921;
	Mon, 10 Nov 2025 22:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qu4T7fD6pb7n42lUuHwrGUGNaZkm34HScexd2cq7FIE=; b=
	pqAskCi18J4tEzwKO6fuGmoFPYKuMgdyuUjIE65WoRcaTrH/rVCVmJ7UxFSdZNWB
	tUbBmZ5nts9H5CCtE95toGMwCe5p5hmnQCf/pzqd+gGV/p6I85Q7MH04ql/xnpAB
	F18n0Wkxs+UzKFQ3wS/vg2MWHdwZgEXWUYKZA5WfucWqMU1o8OuzejahpHSocVC8
	VpGeIaUPzAxvTGLekdX/z1mTRaAHZb4Cy3KcSzoSzQebgq8NYCxhGBpPR6Dr3yNL
	6Ri8ljzjc3iV3cf2y1mUTMB80eD4EldmLRSpXXSu0tYvtYa4UR/BvPVCPz3TTJFh
	8G/hPVKnIFXlREP7r7aI8Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abr5vr2ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAK9m0o040038;
	Mon, 10 Nov 2025 22:22:10 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8ryxq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4IcOk+hxmWxzb7Rs69/u0WFeLySRcUs9zdWfJdyb/UT0rUtVACJjW/YK1fgdXpyoWywuxU4M2/u2LzT/bbaq+Q0Df76tJOE59p3gSFiZQxq1oiRGItTmigXHpjxV2H1xfTBKuHGbbH8sAxpwiHv1Tc6IGGAw4Gp08u2XLAXJ5Rn0UBoPyd0cl/+UciRsaEPe56RrirZUxksJmOIpZzi77FRwJ+9HNdEpZwaXE7VPRaLYY1MNrOLxcWhqXATDul6XnN0D8U/pIQzowT+hgGiPuplNHgGd1bEVr1SnW5xgLE59Plvs03TD5F/BMa+mqdPiraC6w+IImT95GCpDEuc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu4T7fD6pb7n42lUuHwrGUGNaZkm34HScexd2cq7FIE=;
 b=V8h3YKsI3JZZ/sTD4sXzcli9yRTcORngBG6KLX2P9fliQhvpZ1yWVbRZ9Q5yii7kGjPxSyLHl0JmrsB15RpodlvIM7VipirQh1ZzMUWA8Ja6ru8iC63qM74+i3GQ8FdPy4uEUuUjv5om0sCvhHkJEAefYyPZOZUFFHg0HHnmFEqnS+tPA2e6wiq5UN8GWw3XjYF3ZOBngzroTlBS4G9JyIq5PqzW7neQOFvhcm/TjJKxJ/6jrpvtiRmp2PuByVP9eeQdAGxQJ1bdRIW+T5iNFT4S/Ov1xdu412w1+3pxF7yU7xptew2x+wR6dDF2l+7P8GBOSC8lGN+bYw4Gcx/x1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu4T7fD6pb7n42lUuHwrGUGNaZkm34HScexd2cq7FIE=;
 b=S8yk0cUkesD5yXgQEt/Mh68R4eq3DQXPshVh556a7zf5EFqxkRPoTZG44/qK5MMoCKcYHUi8n8AVcOeKnca2PPIhixHsED85q++VDw0Bi1l1ImV4QWBh/1o63hVMLVFszXeK9mAUyyUZtBq5zE5bLXoT23WGPQLmHOsznotYhhs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:22:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:22:05 +0000
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
Subject: [PATCH v3 13/16] mm: remove non_swap_entry() and use softleaf helpers instead
Date: Mon, 10 Nov 2025 22:21:31 +0000
Message-ID: <2562093f37f4a9cffea0447058014485eb50aaaf.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 67da5d85-357e-4f90-6a07-08de20a79465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?boSUb5z4irPYLA7tF4WpXiTvTvU6rUr5W7nxQ4Cd21LuBk/YO4Wnb1t6mrob?=
 =?us-ascii?Q?MnvmWaVuumgmpK8o0zE+nLO6CKrkswfx1BDQb8j2KS5xL2CZcYmCjBQWIGWy?=
 =?us-ascii?Q?KivdyjV1kTeEh00kcAeO7tB31rNAetHDn8azO7EMu3flcbaWj6/ll/HaXe7h?=
 =?us-ascii?Q?KOm5Hb/2ZtKhhgSetWz+otDGqeXWyc/TRn1R1JkQ8Pn96u5RnJPoFnqTznWF?=
 =?us-ascii?Q?LqrqIhI/DrH9/WXOkvMJRcyO9HZpUAXdhVRXnJHWOzIGA4dvV7NHzLaYPOPV?=
 =?us-ascii?Q?ubNmSxYLgx56sILfGhzPQncGzxkvvfZJRmNFamq03vjAhM2HGPpCg6Na5TFm?=
 =?us-ascii?Q?Da0Xpmhjl6H2RKc/uwsD3/3Bc8WMvC6H5AE1n0LVErsw5oZzlakTeFXK3Dtd?=
 =?us-ascii?Q?aaK2mfdbssxnHJac5umeGsu//cjeZYzr64zfXd869Zb9pK/5g96XCnKrnCH5?=
 =?us-ascii?Q?NpBU59XeBXMbXsVT4t30MOJRCelp/Id9dmHeD7HdTutX2OceQI1nrhAkCEsF?=
 =?us-ascii?Q?SFfYzK3JhNYZjUNLPfxceokcFmMU+ue/FBH0MrXa+6YVxUeSc0BNS3km1dua?=
 =?us-ascii?Q?gWQ+k/ZwU7kteb9JAhhuGjb4ss6aXMwA1qe+pYXkruLhmYjCnjeTGSz20B2a?=
 =?us-ascii?Q?yCimYlrkq1lFNvXn+q7cTiVCUOmGaq1ZA1qEPN7XynsIfSe/ffuDSKd2Epw/?=
 =?us-ascii?Q?XJeA6byMeEY1HfC8hTdQzsBql448Rz/EtI6Nch8wCEZp74BKrGVTe3hQsJ3A?=
 =?us-ascii?Q?U4mC+bHJeUJLfvvayVNM8fFQCdVFQIVy1/JhCvXCC7ODgK2uAJYTQqG2YI84?=
 =?us-ascii?Q?Gc7w2xO2tqe/D0SqrjMAr8/5PzqCLAmXu7X67Cx9b1K3k3GdvxZM3oCxe7wk?=
 =?us-ascii?Q?ONrOv02vY9nUCjSjny8Mkyo1qLjMHA8dzwr+p2a4D6mvlDyMIYQFOUbtgiSj?=
 =?us-ascii?Q?ojSJDbPQ/NAkH1oxp1rOlVcEsbo561yd6kQ+Qxxc7xow5XRrrVYxeOKV78OS?=
 =?us-ascii?Q?fI7sMHgK46z7PhdXqN7kO6l7q3Ac1kSC5KPk79h6gkWJZTVYFFYicynqQxTg?=
 =?us-ascii?Q?DTf/ORcmfPSX1e9P0z8XzdRuXDuLI1zSaOQDKdWO/jIVCdo74/giL3lor5Y5?=
 =?us-ascii?Q?FI41z2fQ4SvgM6u0jAaVi6ioMmzH1ODXVIO6aBhH9ll/hZS4ScO26JjS5dk5?=
 =?us-ascii?Q?Y11t/zb9nUNy9NNl6qWxEEb/65BIBKB5OuE/I+MYpI85BKp0MKqByl/gQQzQ?=
 =?us-ascii?Q?rmpRwr+tRHWw31/23c/rmT+jgnsAIEgTJkdF9cSUvMV5U4X3tkQRkEp96bpv?=
 =?us-ascii?Q?760oWg32ZXr5uHvvpHFb8FLXjo5ImHrs4mLcqbmKzRS+xLtkL4Va+K0pdkep?=
 =?us-ascii?Q?Aw9uGs1ASK9jN70nDWadK4mW5AcAVt20TVSkscl5X2qHkIfudUplf5KwTKL7?=
 =?us-ascii?Q?Of2CyZ/Bsvm1GzOScdAHzl4JPIFCii+K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7zswWGx/t35SEJIln2nJ459NeQZINV67g5qfsiruh+k0O4GvcZxEXQaWjWp5?=
 =?us-ascii?Q?FxEEJ+6P7iKsdcpeBIY+0pWiwwRQVcvn1IyBrJvTqomeMz7J+DYn0rAzHuJT?=
 =?us-ascii?Q?h764muAJBxGJou7Od+Fkyyfacglgsuk1KzVH3T1YH88Gk3iU3gl9fKgSOg6W?=
 =?us-ascii?Q?yhtBVcQ9DJOfQQvdZPaP4dFJJ8uEN4CDynkvkdJB4e+QUit6bH6uHjI4VgFr?=
 =?us-ascii?Q?aPcmTRb8/4WN8kQSGQUbZViwvg1bUau4NznxD21fOsPLLkb1Hw93J3L6Mh80?=
 =?us-ascii?Q?pSKOZ92qmB2AL+8+7I1RtZe1Fmzxzujmp2FikouZYjf9P6NwBor+aR9f0WwT?=
 =?us-ascii?Q?p5kK2U0wC4xID+8kNcPfUX3zXBHVHwa5YvPqPnofWVZerR16qEyDtlGc/awO?=
 =?us-ascii?Q?l/wuTwZfKlFGEW8OTebDcMKPNLb+NUFEANk51nt9EmkQLFvR44gbMlGxAHnj?=
 =?us-ascii?Q?5x8PHOy2Qmnx2zFNtXz4KE0EOGU56zwVAsnt3svTTwHOJzpdInh6D64S2wM7?=
 =?us-ascii?Q?f59SzDGTISz2eIrcYl8tkVkUO3JgX/DWCqWSataa6LlUEQ0BfLaBWyJNDbkB?=
 =?us-ascii?Q?CODfxvy1A0xs605wZ5LvoZnLHGap+jXDnfUYkjjNpyiIpS3ZypEJy7SMfC2J?=
 =?us-ascii?Q?eYxa29lycl/3bZ8H96jDVZEy/BxcYx7nBoMMLnkrARWbqQBFVSRTl38d8rHn?=
 =?us-ascii?Q?r5YXb06nK1kc0HOuy/wzYQ8y/VmYgNRgtR6g8bSdYgyBUU6KyTg2XL9WR/w3?=
 =?us-ascii?Q?gsdPqLnSsYuV9TwQLoGDCllxPh4PNWEjcjoKxH2BsUY7qr4kGdbgARfTn2BN?=
 =?us-ascii?Q?jld9Onnxj7xJGhTBpiuLbVukG7m+JOi2kw4F8BxDpwaw09XHQGaDleykV75K?=
 =?us-ascii?Q?vE+7je+RXAijqh+aY0mIhZNFIsbwcKudWkli8IvJ3txxfrjxrdVH3NYKXZRl?=
 =?us-ascii?Q?VMqztdLAV6yne17a6jYjQUa1EoyORRbPXvU6P2NQX2ogC9GwlUE7KdW/HYYF?=
 =?us-ascii?Q?JXJz3J2M+sy8+zkaLSavKd/EBPORHcl+cGtkisfuLgw2yyhaZSVA6hMJOPPg?=
 =?us-ascii?Q?RWEEx9ZX7tZCAgBNKeFLteg0J4ftAu2zU0kDIllyFAII9B+sw0F82U+fMDgT?=
 =?us-ascii?Q?deRkVIcg44uOA6yRksvL7PKNKVMdqN4oUNKTn653qxSt9+cKzwlaLidW9aAH?=
 =?us-ascii?Q?5Cuz8y8JdFg5aalMiJgRTNO4DPNxzS3MFHJSVs4XeE/LIsnhf5soIDN19uxF?=
 =?us-ascii?Q?PZO3S1ablhPEAzcoHXr9eDhx1EFiw7b6GoRJJquCnz9E7QAZknMS/8UIFPdT?=
 =?us-ascii?Q?RGXSrmqozC9/w55P+0mlh5Z7gmmKOcovpHuvovH70/mebnm22rVAnzciSkbL?=
 =?us-ascii?Q?dLZV4oblltfmKCPZQ6YtJh79cOeQTVDYY5LaRI/cuC/hIu/utGD4LGqeN4PG?=
 =?us-ascii?Q?qtsmAPHMLyU8gBrLW12twovkQRh+lBjNy6rvvp73+T5zH0vaU1xGQQ1JSKmI?=
 =?us-ascii?Q?XF4BwOJF/PmMwgwTxIaTpDmNqKrDdkys8DBm/yLkkcrBojmV5JocKLJDq7rY?=
 =?us-ascii?Q?8TV9xtjOQKrWKmrSDwm456bywFQZO815EJGwjcf/UMQz/F3ocn1Y+JMXnZIi?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vkfTuEkQLA1aKJ2TB2cs92F9xWSa5t8zhHsFgoAPNdNh8lVGGJlJam8HGKC/ApbMc4AlW9gX/BUswVMgESKhL7ZXRf9rkkSmPK8E4Z+ixox/Edg0R53+JHTp4aaZ2vN5iY4xZvBG8oS2i+IbJ/nkWrXGkt6vzqR0GSsqlKuVbk3Q7DeJPQTgCHWcNUzhamJFVL4hcGylDlJek1K2B4/llYRDaWvU7tocUxK4ja2r7//cuGvLd2LdZHdRGUwaiI5mZ4dBczWQBBpnJn1Olek+cDksXUAe9cSiMRaz4k19I6Yw+VkNWbr+xk8UPLfrIuIkpc62/vHVCGGnnwrGCjVc/Kp+QYI/1i6Ol0Hgr+z/zbfaczmbLTptVtLDnYVcVa9qDtWRLNJm7Jn/XUHczFYH5kg7CMkBqs6WKfM7daUVBw4j0kVbj8xax72JrGAb6w6ofvrHlGG5toi0yJlvR8Ihjc1LSuaslgp/UhBSRt4481eDcIUAXp5s7byqCZx1NXgascpbH+/7mZDxCUQvgNBkDz0wmAsmruQwBzoHZab/jmQhwFU3qWhkeuDcbj2ZCnskMYn/Vk/cLzpU2FwPup07YSCMfM/08W7HSgh4lk6MVvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67da5d85-357e-4f90-6a07-08de20a79465
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:22:05.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obMNyq0AF0WRMFGUnL43cJHSa7KzixaM4E1rZybthmKf9mWWOMzHX1CqaMzI7FHDRoklkLrf4QphqirFVC2MIGXe02xyqw+sKa60VSCE12U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100190
X-Proofpoint-GUID: MFc6-x_c5hFzvlMUHHVLlKBF-KZAU5ld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4NCBTYWx0ZWRfX2IQgTHv6iTuD
 cLdFTHENm3uE5UpQzpBxlIwsn6c3IbTkXYyyXRKFixWGod6fOgQ8BlMFRJPR0Jhi1wlj/YeZ35b
 4GsO8xWHMpadpvKHFKR4OMseT/HTFKmFK5cRFPw6g5ueVJHeNbZRMrfqXtAzEyon5y6zI+RUapY
 rjIAXnBdjLV4LptJs6V9G8a3WgGCDpDd+ulk2sQAuW7TCmrkPVpaNTm4vHneJMzSeYiBKzvl3dW
 c1IjybOtg3wUzs427A7ECarbIvLiOxzYWKcjaRQcIA6qWGeKMKPJJj85vzd0RxsPm8FBX0M6In0
 33n443zzNtU/HfyvGSbjPTDH5sK1SCIJrs76jKHZAKkTQ3zULFCqahO6zhIhxZFt6g11kLK/Atf
 ApmpDORn0noZSwm4yZdHkIRPhFDPbw==
X-Proofpoint-ORIG-GUID: MFc6-x_c5hFzvlMUHHVLlKBF-KZAU5ld
X-Authority-Analysis: v=2.4 cv=YN+SCBGx c=1 sm=1 tr=0 ts=69126593 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=jXjnEuVU91_iq225JjgA:9

There is simply no need for the hugely confusing concept of 'non-swap' swap
entries now we have the concept of softleaf entries and relevant
softleaf_xxx() helpers.

Adjust all callers to use these instead and remove non_swap_entry()
altogether.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/s390/mm/gmap_helpers.c | 20 ++++++++++----------
 arch/s390/mm/pgtable.c      | 12 ++++++------
 fs/proc/task_mmu.c          | 12 ++++++------
 include/linux/swapops.h     |  5 -----
 mm/filemap.c                |  2 +-
 mm/hmm.c                    | 16 ++++++++--------
 mm/madvise.c                |  2 +-
 mm/memory.c                 | 36 ++++++++++++++++++------------------
 mm/mincore.c                |  2 +-
 mm/userfaultfd.c            | 24 ++++++++++++------------
 10 files changed, 63 insertions(+), 68 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index d4c3c36855e2..549f14ad08af 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -11,27 +11,27 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/pagewalk.h>
 #include <linux/ksm.h>
 #include <asm/gmap_helpers.h>
 #include <asm/pgtable.h>
 
 /**
- * ptep_zap_swap_entry() - discard a swap entry.
+ * ptep_zap_softleaf_entry() - discard a software leaf entry.
  * @mm: the mm
- * @entry: the swap entry that needs to be zapped
+ * @entry: the software leaf entry that needs to be zapped
  *
- * Discards the given swap entry. If the swap entry was an actual swap
- * entry (and not a migration entry, for example), the actual swapped
+ * Discards the given software leaf entry. If the leaf entry was an actual
+ * swap entry (and not a migration entry, for example), the actual swapped
  * page is also discarded from swap.
  */
-static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
+static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
 {
-	if (!non_swap_entry(entry))
+	if (softleaf_is_swap(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
-	else if (is_migration_entry(entry))
-		dec_mm_counter(mm, mm_counter(pfn_swap_entry_folio(entry)));
+	else if (softleaf_is_migration(entry))
+		dec_mm_counter(mm, mm_counter(softleaf_to_folio(entry)));
 	free_swap_and_cache(entry);
 }
 
@@ -66,7 +66,7 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 		preempt_disable();
 		pgste = pgste_get_lock(ptep);
 
-		ptep_zap_swap_entry(mm, pte_to_swp_entry(*ptep));
+		ptep_zap_softleaf_entry(mm, softleaf_from_pte(*ptep));
 		pte_clear(mm, vmaddr, ptep);
 
 		pgste_set_unlock(ptep, pgste);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 0fde20bbc50b..d670bfb47d9b 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -16,7 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/sysctl.h>
 #include <linux/ksm.h>
 #include <linux/mman.h>
@@ -683,12 +683,12 @@ void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep)
 	pgste_set_unlock(ptep, pgste);
 }
 
-static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
+static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
 {
-	if (!non_swap_entry(entry))
+	if (softleaf_is_swap(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
-	else if (is_migration_entry(entry)) {
-		struct folio *folio = pfn_swap_entry_folio(entry);
+	else if (softleaf_is_migration(entry)) {
+		struct folio *folio = softleaf_to_folio(entry);
 
 		dec_mm_counter(mm, mm_counter(folio));
 	}
@@ -710,7 +710,7 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 	if (!reset && pte_swap(pte) &&
 	    ((pgstev & _PGSTE_GPS_USAGE_MASK) == _PGSTE_GPS_USAGE_UNUSED ||
 	     (pgstev & _PGSTE_GPS_ZERO))) {
-		ptep_zap_swap_entry(mm, pte_to_swp_entry(pte));
+		ptep_zap_softleaf_entry(mm, softleaf_from_pte(pte));
 		pte_clear(mm, addr, ptep);
 	}
 	if (reset)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d982fdfcf057..6cb9e1691e18 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1020,13 +1020,13 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	} else if (pte_none(ptent)) {
 		smaps_pte_hole_lookup(addr, walk);
 	} else {
-		swp_entry_t swpent = pte_to_swp_entry(ptent);
+		const softleaf_t entry = softleaf_from_pte(ptent);
 
-		if (!non_swap_entry(swpent)) {
+		if (softleaf_is_swap(entry)) {
 			int mapcount;
 
 			mss->swap += PAGE_SIZE;
-			mapcount = swp_swapcount(swpent);
+			mapcount = swp_swapcount(entry);
 			if (mapcount >= 2) {
 				u64 pss_delta = (u64)PAGE_SIZE << PSS_SHIFT;
 
@@ -1035,10 +1035,10 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 			} else {
 				mss->swap_pss += (u64)PAGE_SIZE << PSS_SHIFT;
 			}
-		} else if (is_pfn_swap_entry(swpent)) {
-			if (is_device_private_entry(swpent))
+		} else if (softleaf_has_pfn(entry)) {
+			if (softleaf_is_device_private(entry))
 				present = true;
-			page = pfn_swap_entry_to_page(swpent);
+			page = softleaf_to_page(entry);
 		}
 	}
 
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 41cfc6d59054..c8e6f927da48 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -492,10 +492,5 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-static inline int non_swap_entry(swp_entry_t entry)
-{
-	return swp_type(entry) >= MAX_SWAPFILES;
-}
-
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index 950d93885e38..ab8ff5b2fc3b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4566,7 +4566,7 @@ static void filemap_cachestat(struct address_space *mapping,
 				swp_entry_t swp = radix_to_swp_entry(folio);
 
 				/* swapin error results in poisoned entry */
-				if (non_swap_entry(swp))
+				if (!softleaf_is_swap(swp))
 					goto resched;
 
 				/*
diff --git a/mm/hmm.c b/mm/hmm.c
index e9735a9b6102..0158f2d1e027 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -258,17 +258,17 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	}
 
 	if (!pte_present(pte)) {
-		swp_entry_t entry = pte_to_swp_entry(pte);
+		const softleaf_t entry = softleaf_from_pte(pte);
 
 		/*
 		 * Don't fault in device private pages owned by the caller,
 		 * just report the PFN.
 		 */
-		if (is_device_private_entry(entry) &&
-		    page_pgmap(pfn_swap_entry_to_page(entry))->owner ==
+		if (softleaf_is_device_private(entry) &&
+		    page_pgmap(softleaf_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
-			if (is_writable_device_private_entry(entry))
+			if (softleaf_is_device_private_write(entry))
 				cpu_flags |= HMM_PFN_WRITE;
 			new_pfn_flags = swp_offset_pfn(entry) | cpu_flags;
 			goto out;
@@ -279,16 +279,16 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		if (!required_fault)
 			goto out;
 
-		if (!non_swap_entry(entry))
+		if (softleaf_is_swap(entry))
 			goto fault;
 
-		if (is_device_private_entry(entry))
+		if (softleaf_is_device_private(entry))
 			goto fault;
 
-		if (is_device_exclusive_entry(entry))
+		if (softleaf_is_device_exclusive(entry))
 			goto fault;
 
-		if (is_migration_entry(entry)) {
+		if (softleaf_is_migration(entry)) {
 			pte_unmap(ptep);
 			hmm_vma_walk->last = addr;
 			migration_entry_wait(walk->mm, pmdp, addr);
diff --git a/mm/madvise.c b/mm/madvise.c
index ffae3b566dc1..234178685793 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -249,7 +249,7 @@ static void shmem_swapin_range(struct vm_area_struct *vma,
 			continue;
 		entry = radix_to_swp_entry(folio);
 		/* There might be swapin error entries in shmem mapping. */
-		if (non_swap_entry(entry))
+		if (!softleaf_is_swap(entry))
 			continue;
 
 		addr = vma->vm_start +
diff --git a/mm/memory.c b/mm/memory.c
index 087f31a291b4..ad336cbf1d88 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -932,7 +932,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	struct folio *folio;
 	struct page *page;
 
-	if (likely(!non_swap_entry(entry))) {
+	if (likely(softleaf_is_swap(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return -EIO;
 
@@ -950,12 +950,12 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
 		rss[MM_SWAPENTS]++;
-	} else if (is_migration_entry(entry)) {
-		folio = pfn_swap_entry_folio(entry);
+	} else if (softleaf_is_migration(entry)) {
+		folio = softleaf_to_folio(entry);
 
 		rss[mm_counter(folio)]++;
 
-		if (!is_readable_migration_entry(entry) &&
+		if (!softleaf_is_migration_read(entry) &&
 				is_cow_mapping(vm_flags)) {
 			/*
 			 * COW mappings require pages in both parent and child
@@ -964,15 +964,15 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			 */
 			entry = make_readable_migration_entry(
 							swp_offset(entry));
-			pte = swp_entry_to_pte(entry);
+			pte = softleaf_to_pte(entry);
 			if (pte_swp_soft_dirty(orig_pte))
 				pte = pte_swp_mksoft_dirty(pte);
 			if (pte_swp_uffd_wp(orig_pte))
 				pte = pte_swp_mkuffd_wp(pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
-	} else if (is_device_private_entry(entry)) {
-		page = pfn_swap_entry_to_page(entry);
+	} else if (softleaf_is_device_private(entry)) {
+		page = softleaf_to_page(entry);
 		folio = page_folio(page);
 
 		/*
@@ -996,7 +996,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * when a device driver is involved (you cannot easily
 		 * save and restore device driver state).
 		 */
-		if (is_writable_device_private_entry(entry) &&
+		if (softleaf_is_device_private_write(entry) &&
 		    is_cow_mapping(vm_flags)) {
 			entry = make_readable_device_private_entry(
 							swp_offset(entry));
@@ -1005,7 +1005,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 				pte = pte_swp_mkuffd_wp(pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
-	} else if (is_device_exclusive_entry(entry)) {
+	} else if (softleaf_is_device_exclusive(entry)) {
 		/*
 		 * Make device exclusive entries present by restoring the
 		 * original entry then copying as for a present pte. Device
@@ -4635,7 +4635,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	rmap_t rmap_flags = RMAP_NONE;
 	bool need_clear_cache = false;
 	bool exclusive = false;
-	swp_entry_t entry;
+	softleaf_t entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
@@ -4647,15 +4647,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
-	entry = pte_to_swp_entry(vmf->orig_pte);
-	if (unlikely(non_swap_entry(entry))) {
-		if (is_migration_entry(entry)) {
+	entry = softleaf_from_pte(vmf->orig_pte);
+	if (unlikely(!softleaf_is_swap(entry))) {
+		if (softleaf_is_migration(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
 					     vmf->address);
-		} else if (is_device_exclusive_entry(entry)) {
-			vmf->page = pfn_swap_entry_to_page(entry);
+		} else if (softleaf_is_device_exclusive(entry)) {
+			vmf->page = softleaf_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
-		} else if (is_device_private_entry(entry)) {
+		} else if (softleaf_is_device_private(entry)) {
 			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 				/*
 				 * migrate_to_ram is not yet ready to operate
@@ -4666,7 +4666,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				goto out;
 			}
 
-			vmf->page = pfn_swap_entry_to_page(entry);
+			vmf->page = softleaf_to_page(entry);
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
 			if (unlikely(!vmf->pte ||
@@ -4690,7 +4690,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			} else {
 				pte_unmap_unlock(vmf->pte, vmf->ptl);
 			}
-		} else if (is_hwpoison_entry(entry)) {
+		} else if (softleaf_is_hwpoison(entry)) {
 			ret = VM_FAULT_HWPOISON;
 		} else if (softleaf_is_marker(entry)) {
 			ret = handle_pte_marker(vmf);
diff --git a/mm/mincore.c b/mm/mincore.c
index b3682488a65d..9a908d8bb706 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -74,7 +74,7 @@ static unsigned char mincore_swap(swp_entry_t entry, bool shmem)
 	 * absent. Page table may contain migration or hwpoison
 	 * entries which are always uptodate.
 	 */
-	if (non_swap_entry(entry))
+	if (!softleaf_is_swap(entry))
 		return !shmem;
 
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 055ec1050776..bd1f74a7a5ac 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1256,7 +1256,6 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 			    unsigned long dst_addr, unsigned long src_addr,
 			    unsigned long len, __u64 mode)
 {
-	swp_entry_t entry;
 	struct swap_info_struct *si = NULL;
 	pte_t orig_src_pte, orig_dst_pte;
 	pte_t src_folio_pte;
@@ -1430,19 +1429,20 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 					orig_dst_pte, orig_src_pte, dst_pmd,
 					dst_pmdval, dst_ptl, src_ptl, &src_folio,
 					len);
-	} else {
+	} else { /* !pte_present() */
 		struct folio *folio = NULL;
+		const softleaf_t entry = softleaf_from_pte(orig_src_pte);
 
-		entry = pte_to_swp_entry(orig_src_pte);
-		if (non_swap_entry(entry)) {
-			if (is_migration_entry(entry)) {
-				pte_unmap(src_pte);
-				pte_unmap(dst_pte);
-				src_pte = dst_pte = NULL;
-				migration_entry_wait(mm, src_pmd, src_addr);
-				ret = -EAGAIN;
-			} else
-				ret = -EFAULT;
+		if (softleaf_is_migration(entry)) {
+			pte_unmap(src_pte);
+			pte_unmap(dst_pte);
+			src_pte = dst_pte = NULL;
+			migration_entry_wait(mm, src_pmd, src_addr);
+
+			ret = -EAGAIN;
+			goto out;
+		} else if (!softleaf_is_swap(entry)) {
+			ret = -EFAULT;
 			goto out;
 		}
 
-- 
2.51.0


