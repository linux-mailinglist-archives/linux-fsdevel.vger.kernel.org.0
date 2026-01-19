Return-Path: <linux-fsdevel+bounces-74543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5DAD3B98D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AC16302F921
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3C3002BA;
	Mon, 19 Jan 2026 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kdxb0VZM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NA9HzODm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D082F83CB;
	Mon, 19 Jan 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857636; cv=fail; b=p+kyV90UtendWK5UCMLu8vGLDlujgxl+U74DsT1OfAQsO48VK1NV3iS5MzS3OXjZh4Q5q/rpctb/+v1KYg1qeecbWleeisi/CbFU4pazIGdg7KCfCuzd/BYlVFXXJcy0hIo8qYl9qNjI3WwUjxr/qqVnR+twzeoZwi72xZjrvD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857636; c=relaxed/simple;
	bh=r318+/pt93oS6kd+kmPtrnQqeJ+r4JMYbBBCkYdDmlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxxb36i3hCwI8tgIeI5YYG7xLQU+5b9ZIkDIf/aVApNO+p+0RVxNSFcX3xo2bVipI7EcSNM7vk6F+jldM/WBjWFhg1RNVvEh5onI5GgXqOiq7vnWpcGWVP2JyhEvEH56i6D/aymrajVOJiDfav5qMUV2YcG0Z4HZM/2Y0D9UZE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kdxb0VZM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NA9HzODm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDZIO1512530;
	Mon, 19 Jan 2026 21:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mcZ9JcPMoFHjt7sePB7JQm/1+juaB8CkJxWwpXSJrpM=; b=
	kdxb0VZMogR7jzVT+V750WKVHI6mOwDgC4wFitGblTh/2mPmYCJt/VXhGQB/5uAl
	Asv8Q/O7FxUEa61q7b8xtf924/PRaQBcn6yfotJxghcpNxw679T30vO0muxQTYAc
	JhPYahkkJkteJVwwkscOdy0KTPHGCPxNDRsACfXfeZ37Sga1qsM6bytaNXwT3q8Q
	LnN2GsECVjk6oYhrMK8wGIvhdqXdQILUQlgeQRA/Dc5eCAIGNhwdjd4k+d3XoPBQ
	LElUbRr9lTSbyl5O0IXHJcn9AebRrTzV97FnrYS5YOEzQ9DL7GTxt+QnXpklE9TY
	mSa6WdC4x9sN3klJqk+LJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qas1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JKV84C022439;
	Mon, 19 Jan 2026 21:19:35 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcht17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgBNDH7nhmpaedHjOGDx7QJBjdFRVSmZUDUoFehXip/W/JkqpK460jd9HahHzTj4qrGnumUEDBgncz1JW7O8nhf45Ds4a/uG8cI3UsIS85686mpxSi7KDb626eXWR3YAOnd+cgY6AiTjZpR5NId32GyLm98LXp+OScwaLfhKDg6dabVZSToOthxRqNYMcxB8zU+ZntrTODSvlFVTKX2Z3qYZ+dh6dQ2GYPgrFpPCH/FezYOBvOnfTHMMCgOXd/GiJiKsVNVGMUj0V7Z+d7JG6Kbslg7NyG0oTmQe+VnHA2gIp7jx6sm2NKeEkgI3qMsnlWKuJRI5ou2RGKlE3wynPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcZ9JcPMoFHjt7sePB7JQm/1+juaB8CkJxWwpXSJrpM=;
 b=efkVnoS6qbJkBacyNcFON/lWZl02G9uoXkDUW647bPSgg1I60U5SIIiEBFXHy1+Z9crA9U1te08aGp0wKPXQVU7Q/LUcARpmx1kI7M+HbvD4NjUG9DEV0x50/5hvgFeL0jkzNgPSyXcL9X8+evGQO/kKn/lTQqPy0VtJdWJJlM/LXjI1zHxXxF00XCTs0D3kP1WNQEP/BkCUGKXTgFpSCsOtBnvSUO+4zKeUos9hI1Yjs80KBb2Rko7wNwbukYg1shfbckHhzN0Aod1d462X/ShErD8kwCuY0ykI7WDScHA7Ru2HfbqQxG3q6j45M7ddCbFR7fnzeQndtThy29n37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcZ9JcPMoFHjt7sePB7JQm/1+juaB8CkJxWwpXSJrpM=;
 b=NA9HzODmvTARLuzHeHOGij569Pbg2wflHGf6rcgEn9CLYmBaepTeiWl1HRON07nxaF4glFc35ZmokBho8r9WTMTSCKiEIZWLv0nrgfw211vpFBRk3Lz5KNMuzaZBayMDHqjKpYg/Opg4yZ2Vj1lASApp4gD1sDXWdfxAObZSXX0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH5PR10MB997758.namprd10.prod.outlook.com (2603:10b6:510:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:30 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:30 +0000
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
Subject: [PATCH RESEND 04/12] mm: add basic VMA flag operation helper functions
Date: Mon, 19 Jan 2026 21:19:06 +0000
Message-ID: <c632744c4a23cb7d45d37450cf13dba450ffda3a.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0362.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH5PR10MB997758:EE_
X-MS-Office365-Filtering-Correlation-Id: 19eb2020-65ee-45bf-75fc-08de57a06f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgoADhKNlLLC0VIzB0bQCqfsqg+DgB7gHxeUC5uUO7v3334R+C8eoYyoXPs7?=
 =?us-ascii?Q?mMFkvMue2p1b86qngy0tgHNQwk55LzflD9DrDAX80PSxP65A8ZsfD2/FrZ4H?=
 =?us-ascii?Q?P5MvRsnTad+ECdiPN1uEDAkqc54EdX4lFFlq/HeK3TdiQ8gr+Y1EAsjMu9wg?=
 =?us-ascii?Q?q0ilSXLU8u7Vm5/BY0YUU86mZIVLvnaMtlj1N6/N2TB2RTHSFBNL0Q93S81J?=
 =?us-ascii?Q?5kzfPO9gm4zvB3xatoj1eobfGZSBeF0ETZeNdaZ0zeDdDU2teygtCDSL3ZMR?=
 =?us-ascii?Q?r65LwApI4TEboR8zQ9DS0NnFKZ4f/HTVtiEaYR+USkMZ5rtVl18q/Xnzujbf?=
 =?us-ascii?Q?NK1PDuYHQr6Fvj/D6Rg4IB6cJ59r2pRd3lSeLwQB0TFVgeu06YHeXlJrrg9G?=
 =?us-ascii?Q?H99R+cely/qkzzWz+HAyvVsFRQgWQAjxROKI4PvgNNaxqWIiylpiMqm32tvz?=
 =?us-ascii?Q?+LoL+Sn5G9Ld14YNavsPxd1AxFhwnT4KxKEJpAS94tGDXOnZhu7idkllg9ag?=
 =?us-ascii?Q?cX2LX6p8uZyFVXlL/b91i07Wl0Fl1pkn3VSTsuKsde+0/jCTksFuQ0V0x2kP?=
 =?us-ascii?Q?zY11cSX4FD+77GWfX1/oDfZ8XcxHPdGkd9FwwiTTQtWXiVU18fuEo3/it3tM?=
 =?us-ascii?Q?Rm/gkblP7AFYPBF8MK3rPJQp0x6nGzF8kpn8Rk0yLGY7/yR4aRvLqgitR7SA?=
 =?us-ascii?Q?+YX+gnoAMeWkPCQOQjCxGpbqaI+/gFIi0QgEJuZ2C3k0aKKCP6oj/QCHBoU8?=
 =?us-ascii?Q?pl092E3gTgzhaLhh+F7V11yiHJv2TI0MQsRAyW3OBxn8l+jo/lyCUoqVqr6Z?=
 =?us-ascii?Q?Fm+P3vEDQr2FSRjOQdF6ClA/5nup97GVRtQqzQGj06/ITmUdYnZu2avPjuq3?=
 =?us-ascii?Q?alalsbDfC1csna0Co0AB5z0oTW49nfGghWDR5G2TqfT3CjbxcxJriZOjXVeU?=
 =?us-ascii?Q?BNESRsY7kPgWamrb45Bmb4z+kt3UNQbBLY0y4OhHxaAPxOpk5clD5tlT0ghT?=
 =?us-ascii?Q?BS36vFZG8UaFgToCacTbnrovUZW/hMQHGAA2FAVDTvL9G7Ae/p4ukgkzafwi?=
 =?us-ascii?Q?JkY5R77y3OI9rlP2wsxWWT/McqwTkOSC7qPvRBIA62kWs1SIuRgG/u6SAJEK?=
 =?us-ascii?Q?Eo6thcR4SxoIkaGqPmFUY/qPOQrENIo083TtSwUSupmPp/3CdfC3H0Qjel9A?=
 =?us-ascii?Q?gTI4Ix69Y3BFUBGFvnmse9GHAR2o+LZEgJsyrRtHgQy5AEQfYZUH5ySxSQHm?=
 =?us-ascii?Q?SPIqj4H5G9Vqh5hZg5g1odIvncIrk5gZ6apQgrYFM2xTswCdL0JgcCoUsRzH?=
 =?us-ascii?Q?VIqHVDO16Td6AElSF5KpfM1zYfdTQX/G7ri4IVNOIvxTmVINRUoFOiu7D31o?=
 =?us-ascii?Q?zlCXtC5wH894hJyqLL35DINHzKRbWO0S/kf2DpjmQBLQmnBH06PzZjAxf6Hp?=
 =?us-ascii?Q?VB3g41iWqlFgQ9AE0HFqBfpliSgKLf9DtnFDkR5J960SlUIsYdQTOe5g1fSO?=
 =?us-ascii?Q?0bWmqFYL31jNZ8pkp0s3ZOIpIpTfRz8r3PWWKqzoSLBnrUlhEB76S/5d7C46?=
 =?us-ascii?Q?ZBq1kQJPJ7RtvnM7xJI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qd8nzpeFwPCzRjrtH1XVcNrr/CBUJ2lbieRrgzTowfyVyNlfM6eitSGHLByZ?=
 =?us-ascii?Q?aSVTTpz2LBdR+mN3SPrSSdBsWUPtavT3RloAtalrRQnofKrQ56xJ3Lk1UUh4?=
 =?us-ascii?Q?TmRe3BwqJ7jU3WHH+uoP1BWJ7Q1FjQTrU8p0hXVofL7+diNREW0XOYcqTG87?=
 =?us-ascii?Q?LAUAO5fSMY1r/8ziunYM/GIgQAi08sOdmN5J/FsvXvDIcFGcrs6J/HiGhsmN?=
 =?us-ascii?Q?+2223V9J9Gb1Ra6lTfGPnFetyx1xxDA3gFRVf52IGH05l+sqpRXXIIwD0BGR?=
 =?us-ascii?Q?LX7yLqq9DYJK4HuJkeeM5djv904n4OJT2NOwGUGEjVmNd0BZUMuhDlKdn8HU?=
 =?us-ascii?Q?JIcr391g2aMj4n0U42PmwLpR8pvLg+BUXMO2UR3kIz0nuYzwXTJVCsBm6x7+?=
 =?us-ascii?Q?NGVm9gFqEnGZij6GLsbygUZZV6HEE2pSSoKCjAcb76/E8gxFENrRZPx28Grs?=
 =?us-ascii?Q?HLJ4vSIEPljN+Q9fDRWjBcKEWCZ/1JZ32oDmcpwkz4q2IRB8pkxjpI2GRl3f?=
 =?us-ascii?Q?OI8kCqxjp3cx+Hh7wB4ujUFLXZGJR+mMq0kUsHh4kqpotalsbJHDJ3W153Xd?=
 =?us-ascii?Q?yCW1v21BxPDCoLJoP9PQaYrYRaCr3dpEQbpgbQe1PGRWmweDI1cAMTMZwaUM?=
 =?us-ascii?Q?0G5jDszVr0a0iUsf254FKNg3J87HgCBTP2T5SX5d50Jshw2AWgUA6MlLefu8?=
 =?us-ascii?Q?9YT6rSULcsTNTfL1qjBMMA6SYNzIIfsY2ioqSoH1DHwWJR5DfPQrE8UxfqCK?=
 =?us-ascii?Q?cF63vDc+eRL7MDC6yQPywJ/THXfeDBa4WfgjMyYRPw3ya4FbMeMnptCav3Yn?=
 =?us-ascii?Q?wJdSzy/OL0eMHKeqt8uMmF347coYas1tPWfA04YYKK1nLGpl+Y6MBi16HKzU?=
 =?us-ascii?Q?8ozcwG8yDYEfZeVsDKdph3xlMUpPLtcjkccQNrS5CZnzcbcFafFeQzkDcMlq?=
 =?us-ascii?Q?v5NPDNnfTe7NiOfLHNgyxshezvSDnTIbiB56xGE1kxGTCNe234g7nQ79kfk3?=
 =?us-ascii?Q?bLnNnUxspnacDDbmm8aWsK2gwBhAtjE+N57j5h0PYnYwSYoCz9gheXBp1Q8w?=
 =?us-ascii?Q?O+F58WI7BVJ4HZ8oMvtdUUFix0RoY0mLfnegKVnmBRAG1N6+LgNDhF+MUN3V?=
 =?us-ascii?Q?yIrIUm5wcj01C/kmWYDfn/ccxzxndVEjTgh5SzCoa7SXVuxZJIyeBUdQZASr?=
 =?us-ascii?Q?j7+2RDRBwlTgcwZkOavIshUso77P8NKJWsbyZW281RsQCvTsbDw6YEKqTMZe?=
 =?us-ascii?Q?vXNtP6cqikS1YwMwWvIyk6t5MRsXfGtlpOkVrWL43MCOQgmJnr8Enw2tl94t?=
 =?us-ascii?Q?5Fhnwbf81+j7dAEqezLXQ9fCl82AuK4Vr07IF8sBzDmAkVKtuu7oj6DPYRaR?=
 =?us-ascii?Q?1KqlXXWQw1WhKA5yNgo2+x8F0TnBwGHmovrTY+ACauyb+RUZ0mB4Mhyx0ZYo?=
 =?us-ascii?Q?q8L2fgdWdNtPy5ScGl4+csG7ww6H2CDBWvJG0TAYN6t8a5ZqP0mgTxT7G4LD?=
 =?us-ascii?Q?JcDMJoxxfuFozyySjESBvVg5b/9pdXJJEexaDMPT/qDTn5w39DlDc3VDpJ8T?=
 =?us-ascii?Q?MIIVa5zDsMUcL0/U5KAK2v614jS2cRQ18qA4NSNS7k3zpMGygdTl9uvnOpIe?=
 =?us-ascii?Q?oQqrh7Fd7exLSH49a/MLyYRTAudwDHIFQLY3+vfjK5OVNHDRRMZiXG8hj+BC?=
 =?us-ascii?Q?Ig/KPqXc20lmA//HOXB1TVjubVcYJpU+IzkE52N2lhYX34wiX/3jBSgfZgFH?=
 =?us-ascii?Q?VugB+0u2mNSQqoBDyRj0N99s46ieN70=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F7Qno/e/Di0UgO6lQv1BxbDiOF6L+3Y7VdyyQAgE22h4gvda5o9hUHk3eMliCYfBmxai+x1lVdrrrFgihtqAh+Ax/T8DzEukRBk870ZiOXGiK0pAtrlbaEl7AdzFPC1zx1f+HmhG5NTyqs4H3Jzf78VAFrEgeCYK99p9EaOjb6qqVuUZFjwk+uC1NJCXnf/CMIAIs+jwTTI9rcklwVwpIEGkQNI710lL948uLZaEoMSLw32VfTkULxDm3FS/mWqGBALyuWiLBe9WWq98ef7HBacarP3EJrp7xJ+25pUC2pQHUot+i0TUxWiA1ru/UySFkLrXMtPVLqCPapT1IgOSsqOAfLORO8h92hj03eLLAUkxHdFvGYx80l8WrdQ9EMzaUmyk6TH6IDEg+jS/thUPwV924CmWh6Hmk/zyGHZ1RQDamTbMQdBSKBRhQP7eRmE9oOcIhI8utgfZe9foaxY86+sZCGBM6jaLCKdrxNW8Xc2T6VWtduozjXrWnEHEFEAgDkF5AksET29IEyeuElYw/gVwyajRcIK8qPVHediK5WG90VQ9QTARs29yV2CUCoMpnc90w+5f29YUc9XeMUoLsHWPMgdUdG6gK0OnhBZV3z8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19eb2020-65ee-45bf-75fc-08de57a06f32
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:30.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvFqejZbKUM4mqT/E/TaCCIj6qN2XpjQpoXJLwWQN13hY7mVdNQbaBZyB6TrryQiODjRM3zJoBibuxLAwLLfxNHqMzUMN5fAhsmOwGEsj9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Proofpoint-GUID: 3MwYbj1BeaX7bkLwzxSiBfXA74dG5VS-
X-Proofpoint-ORIG-GUID: 3MwYbj1BeaX7bkLwzxSiBfXA74dG5VS-
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696e9fe8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UDVvRVEZh_dx9K85IDkA:9 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfX2ojFuRTXszCQ
 HAuesgQ8iYCATg2Yv0nkc7nsDlZ7hzR4zaSGgN6VoXPY0+QvgoxEk85cvGsT+STlKq7B4/iuMQ1
 wVTKdiwDT4K6gsS7TbScXdPjyxT8008FoQDbXdiQaT+1B+hQwtA+Mio36mru7i9vwWQ94xwz0EK
 UV3J18hWCrwgvNDQxYKdOaFbB/xyTQjKJgYxNjCQM3JU4OvzevNxnpAAs7FrbB299KVAZUkLzXT
 Ndg4Hz/YkKWc/95UYGDTBs6ezyqlaIxMnzsxWvxPfFoupg0647yrdrbC5haHCTarM2iWa8QNQb1
 XsKf8q7zj/GkUOW/Yxrdsj6IlHIQ2ncnz6SKgB5cYFiDrjCjaQ4NX/MgG/tcwT5aTl5GYcx4F7H
 mp+VRsfYky1LkG00HoDfThZhu3iYFzV4MbYzGJNEpM9AGlNBCesl+3eEkVVkevSYeSJmCvVnQWB
 8EC+QlLRf2gBGWNMZhoFzrvYrP3xJf7YL4SRKq+g=

Now we have the mk_vma_flags() macro helper which permits easy
specification of any number of VMA flags, add helper functions which
operate with vma_flags_t parameters.

This patch provides vma_flags_test[_mask](), vma_flags_set[_mask]() and
vma_flags_clear[_mask]() respectively testing, setting and clearing flags
with the _mask variants accepting vma_flag_t parameters, and the non-mask
variants implemented as macros which accept a list of flags.

This allows us to trivially test/set/clear aggregate VMA flag values as
necessary, for instance:

	if (vma_flags_test(flags, VMA_READ_BIT, VMA_WRITE_BIT))
		goto readwrite;

	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT);

	vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT);

We also add a function for testing that ALL flags are set for convenience,
e.g.:

	if (vma_flags_test_all(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) {
		/* Both READ and MAYREAD flags set */
		...
	}

The compiler generates optimal assembly for each such that they behave as
if the caller were setting the bitmap flags manually.

This is important for e.g. drivers which manipulate flag values rather than
a VMA's specific flag values.

We also add helpers for testing, setting and clearing flags for VMA's and VMA
descriptors to reduce boilerplate.

Also add the EMPTY_VMA_FLAGS define to aid initialisation of empty flags.

Finally, update the userland VMA tests to add the helpers there so they can
be utilised as part of userland testing.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 165 +++++++++++++++++++++++++++++++
 include/linux/mm_types.h         |   4 +-
 tools/testing/vma/vma_internal.h | 147 +++++++++++++++++++++++----
 3 files changed, 295 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c2c5b7328c21..69d8b67fe8a9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1062,6 +1062,171 @@ static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
 #define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
 					 (const vma_flag_t []){__VA_ARGS__})

+/*  Test each of to_test flags in flags, non-atomically. */
+static __always_inline bool vma_flags_test_mask(vma_flags_t flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
+	const unsigned long *bitmap_to_test = ACCESS_PRIVATE(&to_test, __vma_flags);
+
+	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Test whether any specified VMA flag is set, e.g.:
+ *
+ * if (vma_flags_test(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
+ */
+#define vma_flags_test(flags, ...) \
+	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/* Test that ALL of the to_test flags are set, non-atomically. */
+static __always_inline bool vma_flags_test_all_mask(vma_flags_t flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
+	const unsigned long *bitmap_to_test = ACCESS_PRIVATE(&to_test, __vma_flags);
+
+	return bitmap_subset(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Test whether ALL specified VMA flags are set, e.g.:
+ *
+ * if (vma_flags_test_all(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
+ */
+#define vma_flags_test_all(flags, ...) \
+	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/* Set each of the to_set flags in flags, non-atomically. */
+static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	const unsigned long *bitmap_to_set = ACCESS_PRIVATE(&to_set, __vma_flags);
+
+	bitmap_or(bitmap, bitmap, bitmap_to_set, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Set all specified VMA flags, e.g.:
+ *
+ * vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+ */
+#define vma_flags_set(flags, ...) \
+	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/* Clear all of the to-clear flags in flags, non-atomically. */
+static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	const unsigned long *bitmap_to_clear = ACCESS_PRIVATE(&to_clear, __vma_flags);
+
+	bitmap_andnot(bitmap, bitmap, bitmap_to_clear, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Clear all specified individual flags, e.g.:
+ *
+ * vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+ */
+#define vma_flags_clear(flags, ...) \
+	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/*
+ * Helper to test that ALL specified flags are set in a VMA.
+ *
+ * Note: appropriate locks must be held, this function does not acquire them for
+ * you.
+ */
+static inline bool vma_test_all_flags_mask(struct vm_area_struct *vma,
+					   vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(vma->flags, flags);
+}
+
+/*
+ * Helper macro for checking that ALL specified flags are set in a VMA, e.g.:
+ *
+ * if (vma_test_all_flags(vma, VMA_READ_BIT, VMA_MAYREAD_BIT) { ... }
+ */
+#define vma_test_all_flags(vma, ...) \
+	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+/*
+ * Helper to set all VMA flags in a VMA.
+ *
+ * Note: appropriate locks must be held, this function does not acquire them for
+ * you.
+ */
+static inline void vma_set_flags_mask(struct vm_area_struct *vma,
+				      vma_flags_t flags)
+{
+	vma_flags_set_mask(&vma->flags, flags);
+}
+
+/*
+ * Helper macro for specifying VMA flags in a VMA, e.g.:
+ *
+ * vma_set_flags(vma, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ *
+ * Note: appropriate locks must be held, this function does not acquire them for
+ * you.
+ */
+#define vma_set_flags(vma, ...) \
+	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+/* Helper to test all VMA flags in a VMA descriptor. */
+static inline bool vma_desc_test_flags_mask(struct vm_area_desc *desc,
+					    vma_flags_t flags)
+{
+	return vma_flags_test_mask(desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for testing VMA flags for an input pointer to a struct
+ * vm_area_desc object describing a proposed VMA, e.g.:
+ *
+ * if (vma_desc_test_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT,
+ *		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)) { ... }
+ */
+#define vma_desc_test_flags(desc, ...) \
+	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+/* Helper to set all VMA flags in a VMA descriptor. */
+static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
+					   vma_flags_t flags)
+{
+	vma_flags_set_mask(&desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for specifying VMA flags for an input pointer to a struct
+ * vm_area_desc object describing a proposed VMA, e.g.:
+ *
+ * vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ */
+#define vma_desc_set_flags(desc, ...) \
+	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+/* Helper to clear all VMA flags in a VMA descriptor. */
+static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
+					     vma_flags_t flags)
+{
+	vma_flags_clear_mask(&desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for clearing VMA flags for an input pointer to a struct
+ * vm_area_desc object describing a proposed VMA, e.g.:
+ *
+ * vma_desc_clear_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ */
+#define vma_desc_clear_flags(desc, ...) \
+	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 78950eb8926d..c3589bc3780e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -834,7 +834,7 @@ struct mmap_action {

 	/*
 	 * If specified, this hook is invoked when an error occurred when
-	 * attempting the selection action.
+	 * attempting the selected action.
 	 *
 	 * The hook can return an error code in order to filter the error, but
 	 * it is not valid to clear the error here.
@@ -858,6 +858,8 @@ typedef struct {
 	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
 } __private vma_flags_t;

+#define EMPTY_VMA_FLAGS ((vma_flags_t){ })
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index ca4eb563b29b..1ac81a09feb8 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -21,7 +21,13 @@

 #include <stdlib.h>

+#ifdef __CONCAT
+#undef __CONCAT
+#endif
+
+#include <linux/args.h>
 #include <linux/atomic.h>
+#include <linux/bitmap.h>
 #include <linux/list.h>
 #include <linux/maple_tree.h>
 #include <linux/mm.h>
@@ -38,6 +44,8 @@ extern unsigned long dac_mmap_min_addr;
 #define dac_mmap_min_addr	0UL
 #endif

+#define ACCESS_PRIVATE(p, member) ((p)->member)
+
 #define VM_WARN_ON(_expr) (WARN_ON(_expr))
 #define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
 #define VM_WARN_ON_VMG(_expr, _vmg) (WARN_ON(_expr))
@@ -533,6 +541,8 @@ typedef struct {
 	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
 } __private vma_flags_t;

+#define EMPTY_VMA_FLAGS ((vma_flags_t){ })
+
 struct mm_struct {
 	struct maple_tree mm_mt;
 	int map_count;			/* number of VMAs */
@@ -882,6 +892,123 @@ static inline pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
 	return __pgprot(vm_flags);
 }

+static inline void vma_flags_clear_all(vma_flags_t *flags)
+{
+	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
+}
+
+static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	__set_bit((__force int)bit, bitmap);
+}
+
+static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+{
+	vma_flags_t flags;
+	int i;
+
+	vma_flags_clear_all(&flags);
+	for (i = 0; i < count; i++)
+		vma_flag_set(&flags, bits[i]);
+	return flags;
+}
+
+#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
+					 (const vma_flag_t []){__VA_ARGS__})
+
+static __always_inline bool vma_flags_test_mask(vma_flags_t flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
+	const unsigned long *bitmap_to_test = ACCESS_PRIVATE(&to_test, __vma_flags);
+
+	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_test(flags, ...) \
+	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	const unsigned long *bitmap_to_set = ACCESS_PRIVATE(&to_set, __vma_flags);
+
+	bitmap_or(bitmap, bitmap, bitmap_to_set, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_set(flags, ...) \
+	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	const unsigned long *bitmap_to_clear = ACCESS_PRIVATE(&to_clear, __vma_flags);
+
+	bitmap_andnot(bitmap, bitmap, bitmap_to_clear, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_clear(flags, ...) \
+	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline bool vma_flags_test_all_mask(vma_flags_t flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
+	const unsigned long *bitmap_to_test = ACCESS_PRIVATE(&to_test, __vma_flags);
+
+	return bitmap_subset(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_test_all(flags, ...) \
+	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_set_flags_mask(struct vm_area_struct *vma,
+				      vma_flags_t flags)
+{
+	vma_flags_set_mask(&vma->flags, flags);
+}
+
+#define vma_set_flags(vma, ...) \
+	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+static inline bool vma_test_all_flags_mask(struct vm_area_struct *vma,
+					   vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(vma->flags, flags);
+}
+
+#define vma_test_all_flags(vma, ...) \
+	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+static inline bool vma_desc_test_flags_mask(struct vm_area_desc *desc,
+					    vma_flags_t flags)
+{
+	return vma_flags_test_mask(desc->vma_flags, flags);
+}
+
+#define vma_desc_test_flags(desc, ...) \
+	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
+					   vma_flags_t flags)
+{
+	vma_flags_set_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_set_flags(desc, ...) \
+	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
+					     vma_flags_t flags)
+{
+	vma_flags_clear_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_clear_flags(desc, ...) \
+	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
 static inline bool is_shared_maywrite(vm_flags_t vm_flags)
 {
 	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
@@ -1540,31 +1667,11 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }

-#define ACCESS_PRIVATE(p, member) ((p)->member)
-
-#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
-
-static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
-{
-	unsigned int len = bitmap_size(nbits);
-
-	if (small_const_nbits(nbits))
-		*dst = 0;
-	else
-		memset(dst, 0, len);
-}
-
 static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
 {
 	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }

-/* Clears all bits in the VMA flags bitmap, non-atomically. */
-static inline void vma_flags_clear_all(vma_flags_t *flags)
-{
-	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
-}
-
 /*
  * Copy value to the first system word of VMA flags, non-atomically.
  *
--
2.52.0

