Return-Path: <linux-fsdevel+bounces-67760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A01CC49875
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78F724EE770
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90241340DBD;
	Mon, 10 Nov 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dcILQqPI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fFqGGErw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2F340A72;
	Mon, 10 Nov 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813451; cv=fail; b=L2TSNV58XHOW45Jlzq/rs0T5i4DN2wAgiqaBtiQAa9bpfkPDuils9BZB/5s9BcCUpYF2MGhZNmPEkdum5Feem1KTYH/IQVL01P2gsWhtI5CQ89GnQgwYbZPphDDBIZ/kSm0JjbMH3zYFZg49fn3Ww6wyW5fss2q8ypgFnczzO6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813451; c=relaxed/simple;
	bh=Ywwk8BgU1vvgEYMYYm12WFq+m5B/cdbVU9dI9FbCrwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxT3NySbDgZPYc7Gd6sCX01Yi4BmDrD9AJA14Qh3yLyqI7+6j1Fg2C0fcxJhAc8+zonbCRYvOzcuWmwIYYmQo5BuwEcvLwB/nC6TocIpr+nZEo6tpGGBLs11uyo6OSo53e7bYes1H01Tl3KtLqGHtmXHpo7gwITViTUDPdQyUJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dcILQqPI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fFqGGErw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAMIQ7q026148;
	Mon, 10 Nov 2025 22:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8Mj4dZ2xkCZUyYXA/0EAZ/Vac+RE+RRWNsVC2E5wqGE=; b=
	dcILQqPI2I1lrj658IeiVrC4i8Jomk6wt6KP2UScMg/tbpEx06SOIJa7kohsZPEi
	zz/xvpNKuJyJiS7jW8AXeMiGMbhrKh/9U6ZVdM8/2Xj2W5C613mi8VRcr2QvwQbF
	PoYmmgI91koc+uWQQSCFkWpHk676E5do8TfniDj//F4phDjFI4E5W+MGmdv9waVz
	ESCA+UEvZzgkFaZR3SsSOIIzlamzJ7zU9HuUzYPUaslYnuE/r+mKD5Yf2d3xta1R
	gWD5dV6084Wn8aCh5FxbK/G//H5hDXkFQk+r93Zkll9zckv+lqZ0hYCv9P1KfUEO
	MlHlH1x3X9bdk2L2ApWuiA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abr5vr2d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAK9m0q040038;
	Mon, 10 Nov 2025 22:22:12 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8ryxq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uC3FAylCYUXSQ5gzHebJLUFsjJUzWYqz2gj+S+AV6XsePnw2X0yrqUNDn93baK1W9o+O1bqDcFOLMQ8Dir6/DQqhgKxmDSk3Uyfe2KZfggvN56CJDSUACl98jAgEj494GAEEsMRxEvN1ZEjxH+/TOM+qtb106PMkeQ8cJDzSHY4w77hTHh3D2EOYoJ3i/u3AuZE/Jc/LdY6zTQhs0n2A5GdWd6pyAkGvIJJDgxx2ZMNXw0bRfDHZN/UdauIAqceLb7m+Hmo+VXWeg8xajkUCOGkFisYo8FNzk8ftmCGBqDCVAmINaDbWBii2gdxs9D9SsGNoRKj/9WMYHTK96VKVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Mj4dZ2xkCZUyYXA/0EAZ/Vac+RE+RRWNsVC2E5wqGE=;
 b=q9wIVwNpz5GMrs5NmhnCnpfkk91pSLesAIlpliPzHxRCsWVWomx7RR6VJTd2DMFT9Gzv5UdPyVqu7moEEbzmwpgA/Vh5bHL+loyXzLd+ziFEAAiMQ0jpV2mbDaOcfIkDKcI2PbeyljjrNXk8599T9sXJh3ShvtazQ47oTZ5yONaO0OzVGJlDY6YEGJQDmlSbDSjweiFnCIgcO4jCfkbT+/5vuanjnFDDWReEbaJjW4otCfAV30p7fWx7FnH7379l5zS9yvE5hwugVt78GJt/GTon9K/G9uqUF+s/RI9Rq8uiIoQiCDGc7J8gPtWQc33KL5lmR2ZGqCdgmUbWIaBmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Mj4dZ2xkCZUyYXA/0EAZ/Vac+RE+RRWNsVC2E5wqGE=;
 b=fFqGGErwjNLLc6UthQbkgaFPsT+NTqk5uflg58UJSENXkpDKt8AEBZg1p0Nn7gkLb5VZRakeSji2p67E4XaOobSlfD7ORMp1ayFyIq75OdyhU3srKTKqdkyABPaL8BqMyvl90WfDz5G4T9BvQoMAwiVZFcis88HotnWnIyYML00=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:22:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:22:08 +0000
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
Subject: [PATCH v3 14/16] mm: remove is_hugetlb_entry_[migration, hwpoisoned]()
Date: Mon, 10 Nov 2025 22:21:32 +0000
Message-ID: <0e92d6924d3de88cd014ce1c53e20edc08fc152e.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: f633ecb7-41dd-4db0-aee9-08de20a79601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7aP65Pna5gqFhGWAn9I6t7YVq81tD5uw/qii4Iird9ZZJBF+Kwi8MPIwhuF8?=
 =?us-ascii?Q?Ft6hINN5c258Q4BguAIhnbyuJDF8ZQHhhWapNqJRn5iBvUmQ8JlynCjpXQq4?=
 =?us-ascii?Q?xkjLUh7pG2EYaUIP5C+FYdVt/FcLRB6+S476EtOmWaOG7ei7vXbc7C50N2+G?=
 =?us-ascii?Q?HlcDRMNk5TQgJmlidMuQ/oaHcVNCzaf7mO3Q9spkhu1kgqjz5r6FndWcyH6o?=
 =?us-ascii?Q?hZX0/qAPSnRsJvNjnVv1TCP7XWHNA5hsK8c2PzEtsyRvI9b0tEeaml0MgXkl?=
 =?us-ascii?Q?FzIXBQTpZJht5f0B+Xi658N7e4BNS0m5TQaSovnMTaKcoR7pa93PpFnyRlUR?=
 =?us-ascii?Q?VQw14gaYo0Qxki07zmLe4Yr4C94eRsS+PeiyI2S54gl3Zn4UTsDepDd01U5j?=
 =?us-ascii?Q?dnXVRCRFoQzcrv56Y1tE/rceyTKj82h//b7mbCi0jPnwK8OlpGshNKghKZ0/?=
 =?us-ascii?Q?UDxDOBr9wKAS6OtcGefP4U4NiEdYpC+31MrRy/wb4izV1sQquFLqeltLUk22?=
 =?us-ascii?Q?C9ApDM9ALy2/faOPmNGhLPnLQ6hTVwDwcqRnKETmgTuqtl405f8gcl8yf+lO?=
 =?us-ascii?Q?qdIMtlM/ilbRbGbLcI1dIqPk1Ncu4Ku0Ym2nYWi77JlN9YwvTePfLSbxgy8w?=
 =?us-ascii?Q?1c894CvfsbVKOZqnIhw0fEGmYH4pflSNmreHTZ7Pnw2/LLC595okrbUj7USa?=
 =?us-ascii?Q?w3r15eDuZuEphKs3PEz//w559fExcoaOTLSUUpOUhxNFtqtnuT+tbVgTVWwc?=
 =?us-ascii?Q?+TvucSqqiP7JwpKnYKiiTzf7qzT6uxASEbx1TglRT7fGqOp+ZTviSzDX0xG0?=
 =?us-ascii?Q?eRLYYppOf9HODN1wBybsAvR7ybncGZR7VzWs6/y2BHlJLwA2jwAajJ0k6tcX?=
 =?us-ascii?Q?bcnurJAAMUSlpj30hahSoPe/xQEw08C/WYgBceIS+fQILJEYCkt8xru7xekE?=
 =?us-ascii?Q?3mLOthdy/CEJoe7fdCJ/JLokoG9PmN6Msag6yqqAKnNKAQ0uWoxx5udODZg2?=
 =?us-ascii?Q?u7HCgp80WTcZmJcDpeAiKS2WbF2YLbVWJP5b6C7jS2MIYRDIbMuWF8gGRn1T?=
 =?us-ascii?Q?q8cb1J0Nef9eTNFPkFNRQ3ObsUwm+9Za5bWJLZHXjsoTNGJsBL1NZ2qDGav4?=
 =?us-ascii?Q?GlWAUy7LC3NEz8Z9JsAaBbAhCKtD18ZKzUH5xgnz+6NprQ3RCW14EvuwbnpS?=
 =?us-ascii?Q?MvS2O+mE1hgzWsbVWutpiKkIuLBMa6OAyHodYCpfi5182qNnl6DuxKomf1Cv?=
 =?us-ascii?Q?DfcBYPbFiGtJrb0UuOhk3vV6jtyTrqImW9MwED7Xb3HtoMDWK06wC8x1biL4?=
 =?us-ascii?Q?TBSXMWXAhOs6CVPgDAE77U+n6A7LR+rJXn/DVlfUDAkoGi8VoFv2FLz6HBM4?=
 =?us-ascii?Q?L7uuEQPhcfaNaW4MhYHC7RMfA+F8pexwxh3dJ/vFzLyqhzRSwMFNxGFGjzkt?=
 =?us-ascii?Q?wb2GIGnA0XzBCSY2tl/pGYwyvPrCVKDE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KKigt8Xc8ZcGerH1XoxB0WDTS5RIES+2Zl6knURH9qIuEtOpAaOWijHFDRL2?=
 =?us-ascii?Q?DP5G/oGm37OY5HhUZAgAclnzrOSqS6XViqEUQMUTEQfTaa4Uphcb6jn1fQvb?=
 =?us-ascii?Q?4T+RhjWa+JfSiTcKpeYLVGfTTuMGUxL/lfqlnpO15d7pf0WTq/szEqZp/SGK?=
 =?us-ascii?Q?UG7oymB74SGsokXlNmFrAP7w9d+dZronQcNwoaH2kf2/S064w2TJcoD3ijzA?=
 =?us-ascii?Q?Hxk4RzbNl0BABnOxUPfPcuHFZOpWq4FCO0hAsC7HHqerCnN5YdtaHfd1i6sN?=
 =?us-ascii?Q?0ScdEjoYA7CGlkOB4kHUAI5NFapaf0mEzFdKqsUvCO/Nqk7xN7VXg7cjm5Qo?=
 =?us-ascii?Q?3nz+9VhY7yA/ON2d1l29RZti2xCoOqRXhSgRXVhOBpr+s+Sj4Fu5GrhUapbB?=
 =?us-ascii?Q?SplDl7/JiFCUoctOVfu0qdSr4gLSQLB0+azTeJOpVoeGs+SmJSvg+HIv3Kci?=
 =?us-ascii?Q?SSFM7N1Q4jnirLT/wVUTPfKzapgvOAIhMCH953D4+Qfdy1jUiYvU+43x28ZQ?=
 =?us-ascii?Q?YsXQNtcpp27kezTAUvLyBoq/E455VolSjoGv0QLyKqaTVMumNrwu0bOEWOdT?=
 =?us-ascii?Q?iOBzCdMQUL7uO95mkKC7SlyBNyDmclkTLlHVVqmK9vCwxkP3fXJP7WhIykmU?=
 =?us-ascii?Q?ydBKc29pK2JuGNLU40rBr2xn+mPgDw53QsYG84PmT8YccrNUjf5Q3spuRKoA?=
 =?us-ascii?Q?wyhBGvYS7l8pA6ibYVv7xUsRvsCYbIG7nHqyOHUErz32lbC9g+Qomi0hJbjz?=
 =?us-ascii?Q?OqGxoMoRxadQkx0oO4MF9I6fRc2G7jZHeKaRnrQKUvnIypaoTHD1dkc/r1ru?=
 =?us-ascii?Q?ZxS5/PvZwUUuZrqz+GPxjY7xD4nQcnIFjnjw/+PQagNYfMm53JWAUN7K1x4d?=
 =?us-ascii?Q?9HVyfyFJHMDFinu67BkRRFkCP7w6fNMjeK1JYBldFBoSvhbJHlG3tGjBVUgJ?=
 =?us-ascii?Q?2lj163EPEEB2uyA5CsEojmyLY36qg7tZJhe6K44ZWCGchNJ0QDn83MItjDCF?=
 =?us-ascii?Q?FnfoD52QaWPoaFztctnVrbrs+h7rGvm0tam++UBUgnPH1osMvs2PgNCXXAvj?=
 =?us-ascii?Q?cNuJNzcqOH3X8iGi1eSchSH5FyDMwp2GWCB6sdPj9vnGjXZ7TrfT/4pX4pWV?=
 =?us-ascii?Q?h9nvB1TZ6EIi6EKD8v+QRwm4giGIX4MBfTrF+gKclP3OUMdxuTmQks5AWse4?=
 =?us-ascii?Q?0PAIgyfXG5Ve9aXeW85gUF2UlUuectqyB/tKpUAen661cgQVOcHB/EvwLMRP?=
 =?us-ascii?Q?dl+c5wYGQb39vcyW63QUWJBYj+3mhOXqCasTqJ1ZN2nVmVOdkCS85NCfsPnk?=
 =?us-ascii?Q?f5jrpjOTV0Rb8v13lKbOrn9OU4TK/SDwfEXF26DF1IL+zBehUVJc3qhKSHdK?=
 =?us-ascii?Q?Jw8BjSZiG7fPFGyMuWZzWy7xnDI2BKGmYgu2zSg4L5AbD/U0MFfCkSAKZJXO?=
 =?us-ascii?Q?W5ndV2RSRCFLyql2VuHwGr9BVPl/hSsjtosErJdmYJ0P2cyS8ZBq/wWljeA/?=
 =?us-ascii?Q?+1jMMuMiaycbwTyGPLNWaZ8f2U0cRRu0hrsFSf0UkWoZa+ZWQ5EiZ2MR2MnW?=
 =?us-ascii?Q?r18CuOiJydFYwFldpKIFBFgfxfgbqqYd0ta90PaPU7SrOR32EGW5oOtPZn/n?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0uqd/jHsf3JigH/yUUCJnPMx8egpmgwrtPsg8IgIgbTrwb7z+KVSExWE8QbL5+JIvKBN6nVdB5+oaJg4hJ0ix0wnPhMOyxb0Y9P1dg0oPuOIrSSUleeYrYUhP78PfjAoLGV5VPgNTSKafVg1pBG5bjMLXcLsNeNhKWEsfkFYDk6ZGTF8XwZFA9msD5DsccBG0Yau7S9kQpANcbqHMfWLaVe8oW/oD9RvAm4M4ZfIP48e85gHd8FFktRE9p2x+A9IXnEiY5vJL2CTUMu9qHxl0O0bAJjfBVDa5nlSmf9xbRUx2FsoDe+IDZQrSiRhKVctIsE21ZBPQjdKJW0tC1gNNVbAIURIWsTfAIxRErHmI+R3Y/j2BZFd9NK8/3mR5DaYFqmR+1YX74DBqs2znR7AleLH5UMf25GfPqSNYUoo/v4hPFU4Z8XgorGSCmbXwhorDwE26VOjhASShQdFwrePRBhtxhfto/jPxy+HIx+AKKD2+u7J8Rm+aMLR6tvfNtDCkIqh7AmJf4R7YHhFxkmiYIBNMT9Fhhpr2HbwINtVRT7xCXwZoF142VmUslVa5sMRQXexEkmCqqeLRfbx8nhFypWpJ7ikA3m0DccqVnzxTA8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f633ecb7-41dd-4db0-aee9-08de20a79601
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:22:08.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVBQqjNQYPrJaCJwiKGpVfwDX36+rinJPxZyGYNDvgt4AauO9qsTFsVoXeoQ9jfhAPY6faS2XeckGMjQuMA49Rxxi9UWUNbKu3iGb5UGKGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100190
X-Proofpoint-GUID: yFQd-S0gGg-n_MuzvJcyUsR4PscbTUef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4NCBTYWx0ZWRfX1YrPK1+eH6U9
 BP/t63kMORTT27AD6xIyUgYltNoH9TGtab6dmWZnq7F9WDjSxmGqH4K4eLcJrpewiVQUwiXjM+b
 FgDp1Pv97uZhqfzw1cnuOeerjsmHpzFyLANpeSLKPOKmig40PyqQgBDpLjxm4SVCNopcJ/zJdXc
 3+nRQOETAVGKDevpRvKEyYYt5BkaDL+wjeI5Lpuj11vH77IyJnZv/bnpTfUfAu9zfL2dpSQPds7
 1khTT9VS5z4lCO7oEojjKfbiZm5t4h314useS/OmTVMvb7rYPKVVhAPebFD0w/aIkpAb1LvBkf/
 YUQal/YaU0gRVvxPIB39fweoA24CQbwhHxomiGj0qfK71L1km6QFYGkYCcqNNFMQBgnxqmY7FNr
 H+wIixj/eGG2CIJKHksa1z+Twde3mw==
X-Proofpoint-ORIG-GUID: yFQd-S0gGg-n_MuzvJcyUsR4PscbTUef
X-Authority-Analysis: v=2.4 cv=YN+SCBGx c=1 sm=1 tr=0 ts=69126595 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gaN7zjf0O2erDMybN6AA:9

We do not need to have explicit helper functions for these, it adds a level
of confusion and indirection when we can simply use software leaf entry
logic here instead and spell out the special huge_pte_none() case we must
consider.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      | 19 +++++----
 include/linux/hugetlb.h |  2 -
 mm/hugetlb.c            | 91 +++++++++++++++++------------------------
 mm/mempolicy.c          | 17 +++++---
 mm/migrate.c            | 15 +++++--
 5 files changed, 69 insertions(+), 75 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6cb9e1691e18..3cdefa7546db 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2499,22 +2499,23 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 				  unsigned long addr, pte_t *ptep,
 				  pte_t ptent)
 {
-	unsigned long psize;
+	const unsigned long psize = huge_page_size(hstate_vma(vma));
+	softleaf_t entry;
 
-	if (is_hugetlb_entry_hwpoisoned(ptent) || pte_is_marker(ptent))
-		return;
+	if (huge_pte_none(ptent))
+		set_huge_pte_at(vma->vm_mm, addr, ptep,
+				make_pte_marker(PTE_MARKER_UFFD_WP), psize);
 
-	psize = huge_page_size(hstate_vma(vma));
+	entry = softleaf_from_pte(ptent);
+	if (softleaf_is_hwpoison(entry) || softleaf_is_marker(entry))
+		return;
 
-	if (is_hugetlb_entry_migration(ptent))
+	if (softleaf_is_migration(entry))
 		set_huge_pte_at(vma->vm_mm, addr, ptep,
 				pte_swp_mkuffd_wp(ptent), psize);
-	else if (!huge_pte_none(ptent))
+	else
 		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
 					     huge_pte_mkuffd_wp(ptent));
-	else
-		set_huge_pte_at(vma->vm_mm, addr, ptep,
-				make_pte_marker(PTE_MARKER_UFFD_WP), psize);
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2387513d6ae5..457d48ac7bcd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -274,8 +274,6 @@ void hugetlb_vma_lock_release(struct kref *kref);
 long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags);
-bool is_hugetlb_entry_migration(pte_t pte);
-bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void fixup_hugetlb_reservations(struct vm_area_struct *vma);
 void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a74cde267c2a..b702b161ab35 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5552,32 +5552,6 @@ static void set_huge_ptep_maybe_writable(struct vm_area_struct *vma,
 		set_huge_ptep_writable(vma, address, ptep);
 }
 
-bool is_hugetlb_entry_migration(pte_t pte)
-{
-	swp_entry_t swp;
-
-	if (huge_pte_none(pte) || pte_present(pte))
-		return false;
-	swp = pte_to_swp_entry(pte);
-	if (is_migration_entry(swp))
-		return true;
-	else
-		return false;
-}
-
-bool is_hugetlb_entry_hwpoisoned(pte_t pte)
-{
-	swp_entry_t swp;
-
-	if (huge_pte_none(pte) || pte_present(pte))
-		return false;
-	swp = pte_to_swp_entry(pte);
-	if (is_hwpoison_entry(swp))
-		return true;
-	else
-		return false;
-}
-
 static void
 hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
 		      struct folio *new_folio, pte_t old, unsigned long sz)
@@ -5606,6 +5580,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	unsigned long npages = pages_per_huge_page(h);
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
+	softleaf_t softleaf;
 	int ret = 0;
 
 	if (cow) {
@@ -5653,16 +5628,16 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		entry = huge_ptep_get(src_vma->vm_mm, addr, src_pte);
 again:
 		if (huge_pte_none(entry)) {
-			/*
-			 * Skip if src entry none.
-			 */
-			;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
+			/* Skip if src entry none. */
+			goto next;
+		}
+
+		softleaf = softleaf_from_pte(entry);
+		if (unlikely(softleaf_is_hwpoison(softleaf))) {
 			if (!userfaultfd_wp(dst_vma))
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
-		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
-			softleaf_t softleaf = softleaf_from_pte(entry);
+		} else if (unlikely(softleaf_is_migration(softleaf))) {
 			bool uffd_wp = pte_swp_uffd_wp(entry);
 
 			if (!is_readable_migration_entry(softleaf) && cow) {
@@ -5681,7 +5656,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(pte_is_marker(entry))) {
-			const softleaf_t softleaf = softleaf_from_pte(entry);
 			const pte_marker marker = copy_pte_marker(softleaf, dst_vma);
 
 			if (marker)
@@ -5739,9 +5713,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				}
 				hugetlb_install_folio(dst_vma, dst_pte, addr,
 						      new_folio, src_pte_old, sz);
-				spin_unlock(src_ptl);
-				spin_unlock(dst_ptl);
-				continue;
+				goto next;
 			}
 
 			if (cow) {
@@ -5762,6 +5734,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 			hugetlb_count_add(npages, dst);
 		}
+
+next:
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
 	}
@@ -6770,8 +6744,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	ret = 0;
 
 	/* Not present, either a migration or a hwpoisoned entry */
-	if (!pte_present(vmf.orig_pte)) {
-		if (is_hugetlb_entry_migration(vmf.orig_pte)) {
+	if (!pte_present(vmf.orig_pte) && !huge_pte_none(vmf.orig_pte)) {
+		const softleaf_t softleaf = softleaf_from_pte(vmf.orig_pte);
+
+		if (softleaf_is_migration(softleaf)) {
 			/*
 			 * Release the hugetlb fault lock now, but retain
 			 * the vma lock, because it is needed to guard the
@@ -6782,9 +6758,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			migration_entry_wait_huge(vma, vmf.address, vmf.pte);
 			return 0;
-		} else if (is_hugetlb_entry_hwpoisoned(vmf.orig_pte))
+		}
+		if (softleaf_is_hwpoison(softleaf)) {
 			ret = VM_FAULT_HWPOISON_LARGE |
 			    VM_FAULT_SET_HINDEX(hstate_index(h));
+		}
+
 		goto out_mutex;
 	}
 
@@ -7166,7 +7145,9 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
+		softleaf_t entry;
 		spinlock_t *ptl;
+
 		ptep = hugetlb_walk(vma, address, psize);
 		if (!ptep) {
 			if (!uffd_wp) {
@@ -7198,15 +7179,23 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			continue;
 		}
 		pte = huge_ptep_get(mm, address, ptep);
-		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
-			/* Nothing to do. */
-		} else if (unlikely(is_hugetlb_entry_migration(pte))) {
-			softleaf_t entry = softleaf_from_pte(pte);
+		if (huge_pte_none(pte)) {
+			if (unlikely(uffd_wp))
+				/* Safe to modify directly (none->non-present). */
+				set_huge_pte_at(mm, address, ptep,
+						make_pte_marker(PTE_MARKER_UFFD_WP),
+						psize);
+			goto next;
+		}
 
+		entry = softleaf_from_pte(pte);
+		if (unlikely(softleaf_is_hwpoison(entry))) {
+			/* Nothing to do. */
+		} else if (unlikely(softleaf_is_migration(entry))) {
 			struct folio *folio = softleaf_to_folio(entry);
 			pte_t newpte = pte;
 
-			if (is_writable_migration_entry(entry)) {
+			if (softleaf_is_migration_write(entry)) {
 				if (folio_test_anon(folio))
 					entry = make_readable_exclusive_migration_entry(
 								swp_offset(entry));
@@ -7233,7 +7222,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			if (pte_is_uffd_wp_marker(pte) && uffd_wp_resolve)
 				/* Safe to modify directly (non-present->none). */
 				huge_pte_clear(mm, address, ptep, psize);
-		} else if (!huge_pte_none(pte)) {
+		} else {
 			pte_t old_pte;
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
 
@@ -7246,16 +7235,10 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
-		} else {
-			/* None pte */
-			if (unlikely(uffd_wp))
-				/* Safe to modify directly (none->non-present). */
-				set_huge_pte_at(mm, address, ptep,
-						make_pte_marker(PTE_MARKER_UFFD_WP),
-						psize);
 		}
-		spin_unlock(ptl);
 
+next:
+		spin_unlock(ptl);
 		cond_resched();
 	}
 	/*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 01c3b98f87a6..dee95d5ecfd4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -768,16 +768,21 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	unsigned long flags = qp->flags;
 	struct folio *folio;
 	spinlock_t *ptl;
-	pte_t entry;
+	pte_t ptep;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(walk->mm, addr, pte);
-	if (!pte_present(entry)) {
-		if (unlikely(is_hugetlb_entry_migration(entry)))
-			qp->nr_failed++;
+	ptep = huge_ptep_get(walk->mm, addr, pte);
+	if (!pte_present(ptep)) {
+		if (!huge_pte_none(ptep)) {
+			const softleaf_t entry = softleaf_from_pte(ptep);
+
+			if (unlikely(softleaf_is_migration(entry)))
+				qp->nr_failed++;
+		}
+
 		goto unlock;
 	}
-	folio = pfn_folio(pte_pfn(entry));
+	folio = pfn_folio(pte_pfn(ptep));
 	if (!queue_folio_required(folio, qp))
 		goto unlock;
 	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
diff --git a/mm/migrate.c b/mm/migrate.c
index 3b6bd374157d..48f98a6c1ad2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -515,16 +515,18 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, ptep);
+	softleaf_t entry;
 	pte_t pte;
 
 	hugetlb_vma_assert_locked(vma);
 	spin_lock(ptl);
 	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
 
-	if (unlikely(!is_hugetlb_entry_migration(pte))) {
-		spin_unlock(ptl);
-		hugetlb_vma_unlock_read(vma);
-	} else {
+	if (huge_pte_none(pte))
+		goto fail;
+
+	entry = softleaf_from_pte(pte);
+	if (softleaf_is_migration(entry)) {
 		/*
 		 * If migration entry existed, safe to release vma lock
 		 * here because the pgtable page won't be freed without the
@@ -533,7 +535,12 @@ void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, p
 		 */
 		hugetlb_vma_unlock_read(vma);
 		migration_entry_wait_on_locked(pte_to_swp_entry(pte), ptl);
+		return;
 	}
+
+fail:
+	spin_unlock(ptl);
+	hugetlb_vma_unlock_read(vma);
 }
 #endif
 
-- 
2.51.0


