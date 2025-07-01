Return-Path: <linux-fsdevel+bounces-53523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97360AEFA96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E104A075A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB17275103;
	Tue,  1 Jul 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U2lTXceC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e6B0dm9v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C92741D1;
	Tue,  1 Jul 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376300; cv=fail; b=i2qmAcg+7cXTbPI8qTpaLXOdWQUAWFIaeF8sNs2zGr63gnHkBwgrJr9vyyUJ1gVZU8FijrUqHd3pFvL4D4si0QTTX3h7JyuzWUUqKzVziv1HgL7NQPlPn920juEobT0WQk6BJJgqDIpV5fZSz3xxBf/YZyUuU8UqHAEinneQt6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376300; c=relaxed/simple;
	bh=a8PVapjAmWcRJyqKd/4JRjJ/0cLheOKkZgT2iDvXWMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oRhQ5nKSdHAVlGks3by0ZQyVVsUvsqvSDjF4/y1/PTieLcHoJ3cvq3XwpyFivyIQieA4V53ZEtjABLGU6YGrpJ9I1p31yKItuaexWLmn2ClkAZORxCQEYtMHL55s4OM4v3cIlwLJlVk+unzDZuI3tD5J/D0Ff4/8K+haGcxLRQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U2lTXceC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e6B0dm9v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9S1U024741;
	Tue, 1 Jul 2025 13:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=g7oOdi8Pp5T0Z62fvD
	tZDDkScHTpwQ3fvwc5/lJ5NWE=; b=U2lTXceCgtjC9iuLFvHtLSWa7o/Z8Twjsz
	ZjVpwp96N7WHoCXWTzLs3/l3FKsf7+ZmZjgL/s3ArbO78q4TI3jMo8HO5lYKvlaF
	+CrIIWF5RYBI2U6LwRKBFrD6rd/LgatDjk9lb8gaN0k4Zgp51y5T7EF49TFa9r2l
	Z4OlzzDF/dTm1kTKj5tFawNogHErTEiGptDrHXXNbRzj7r6rsgDLpZc4PlTkMiWP
	08V2/Y2Wj14SpUb8QFmGcBvNJDj6E4qjn3bYQHgC2xonAsIqaHeCnrbvNwsiJ+0i
	DMQ7o10LlalgQyYVh7TJeNxxhhPVPXbG/cUxn5Qrp2AjYsZ2r1WQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704csep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:23:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561D5wri029818;
	Tue, 1 Jul 2025 13:23:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9rjyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:23:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zREVQz5GI1NMdFEHoOs+uXyio2d1jGn49IMYVTxbIHVSlGNVZeHU4MUAy2fYNBjDtZABUgTGT03T+W197+g4TX1eSvw9hXVMP/edzyn1NEnjfv2yKs4DCU2k0mlxcLfyTNiK2EfOCvxKF5cjc6QKkwCG6yaIFrppHr6AlJQ/vAyPDHvSblP/i57ic64gXo0z6POZjurYQnyoGELmKAib++egxCtVNVuCViV/0w2wXk0S693xFJPkksBQXJ16epS0/cmICe5K9mgRf5hDeem3RL7nYICZn5KhWy18BEnyeE6ZzaVI7+XlR61ivAGSydKhSphHxL8ixYv+/uTSiDX6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7oOdi8Pp5T0Z62fvDtZDDkScHTpwQ3fvwc5/lJ5NWE=;
 b=QtP1LgohMill8nUWQJu64UUzKGpN4KZReag85cto5edtu/C28cZ0YlhiL8+fDffjvcpXuQrmyk6vGkBqhdTbGU++nusLI/DoOfik7WoaDNaovfsI3Dey3C9/wjau5QI5g64sp5OdbORV5ndWe7pEmqapMjuFU84intCBqpvH6v7MApD2EWWYeEzxT8dr7sChpsmXMUzKxTg1Mgght0y/jeqi1Ftb2isRnS9NrYN8ci+aBxxYMnASuWJgkRiBvaAeJ76S+qpFrzQNLApavILkOVmFMbr5nMcaS06SlWtjOZy1FmaNBlC3Tn4GGeiOdP7TlNDSu9dti5syIXF2vY2pBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7oOdi8Pp5T0Z62fvDtZDDkScHTpwQ3fvwc5/lJ5NWE=;
 b=e6B0dm9vPZpFzzmj8OBIOnP3dWQqBb/EvaUeJIVENs5GJk89FoO60yMyjSvfg/0a0v+9gkSqG0+g62YCFwYi3CPr6oh7WdT9L5NctJqkW2ak/8yYuVw68OgFvERxS8xtGOlFLMxkioT0ldw8OiUQzd2+XlLIPM9PhEu1xdTzQkM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8101.namprd10.prod.outlook.com (2603:10b6:8:203::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 13:23:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 13:23:00 +0000
Date: Tue, 1 Jul 2025 14:22:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 29/29] mm/balloon_compaction: provide single
 balloon_page_insert() and balloon_mapping_gfp_mask()
Message-ID: <81844b5c-3b01-4704-b2b1-902d708acf74@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-30-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-30-david@redhat.com>
X-ClientProxiedBy: LO6P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: e0956201-b5de-40db-c1c5-08ddb8a266ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ljh9MPrbKR+kLDcX5oxeuItsefnh8HfQkQkpfdd0PjMh6+bObG6NNsOXvvYB?=
 =?us-ascii?Q?MvL2h/TpSzdq3eclYjAMZ5iGWe5z8aUEgfTSycDawlDa6YvX4K2VkDvBOiGk?=
 =?us-ascii?Q?uyjXccXWhqNN4ZDmZo4ngsTUeMF/Nrp3ZfYzVsNGo74IpfpOk5WYZpwpjNGV?=
 =?us-ascii?Q?c3FLMoCkFN/wkt85d3CX2Hg23hyOAB3heAAl/ZQURHWbj9kfHMwzo7VgJWwY?=
 =?us-ascii?Q?1AV3DqvtR+JsYFBD65EZUt4/hOyZh692STnaXo71jOOsLDiOL+90peC03aGk?=
 =?us-ascii?Q?7bdq4m8Q8YKIUvFymwh3NHnimoAAJEitrX1pP4lyro/kV3pMc3WBvnw5Uco7?=
 =?us-ascii?Q?zAp+FWI2jM4hJ1/PbLQSwwoSt1/PVrW5+zT4x97BQhXoBPoMQN7mUSRtIprn?=
 =?us-ascii?Q?caI3164VSf0OLwgOW42/2yqIzOYte6C/cI80NNjgXkOVLaRS/5J92ZGZHX5l?=
 =?us-ascii?Q?t2ADt8CbJkPtjYvOLkZ9VuBE922JsFa87zr6AhqzfsRPcxdsrunLLkkChlVS?=
 =?us-ascii?Q?eNwxfJ5jPUfuWHbPtejTWID/ZHvU3e8X76fdPgU5ACX7IttK1ITLfOJXFhF4?=
 =?us-ascii?Q?I4KVQ0+IRpZPUMKC2SrkmsRfwaKpqP1c0P+lyqfB5FJ2fg+IKVzHJOB94rGG?=
 =?us-ascii?Q?LCNDiH/ub8ltLxm4HCX7etAVSR83+MUqHAlWfgGMS59+dWamXDoQmKW7m3HX?=
 =?us-ascii?Q?6gcVVpkDoupYDfR4NJp448Z3G/TDnYpw0gdGi0F6E9DanB1K+HIn4tExVZ0n?=
 =?us-ascii?Q?lnmZ1hQmPtZhRbUiCNZMWGDymBZbZSTtzErPsoBQK8lzkSEPSHKuSx0C6/hi?=
 =?us-ascii?Q?0YIwxdm4PkCnrGSGzHlrtJdN/MlVjDLYev1PyCnCmytw3Ff97GqPKvwwgKsc?=
 =?us-ascii?Q?UUGWOlfHKDcmTUyztkXntrkUnmJr4HiX22PYpldRv5Mqeuu6cpIrC4Gr6n+T?=
 =?us-ascii?Q?bHMQkBboN9hI5pIB2fHJHobnCOsHfDno7wh/2R/yC0ijn7Z9JKyADaxIO1Pw?=
 =?us-ascii?Q?ypdjRyvYS/wCCeeDFWu+llbOGfggHOasXm3wfyckjhbKiJvP38df6y0q6I+r?=
 =?us-ascii?Q?uzYOD5nMVJbY6EviXRVNRLAnswE7BzVEq3JrL1OtJPMpRoBT5qgnKWa8g//F?=
 =?us-ascii?Q?JeK7CgegxcW45POaHOv0xVpqSiPRryKFsoUXEY+kl8ys0qBYPeLz28ApOS9B?=
 =?us-ascii?Q?ldpAbPr8ss590dSCQvMQs22GMg7q/5OQDVkNSfu7MIELQ95oIqVJm4lHt2EQ?=
 =?us-ascii?Q?5MEpIimT131dAqRj4bKgZ+K3PzVRERjM1AZ5uGVgYZ7AIzqb9g4DtHWQXr9l?=
 =?us-ascii?Q?IXBE7An+qJvbd8cTqmUE7L4eiEvIX1tkS8bGFbquXCCc/GDvBu4mZaOr7AJF?=
 =?us-ascii?Q?U1chqigvcucaRpSLVsTJpXniC7/BN/T7oBwlreNsjvzxekuLUMdzxwqkTE4f?=
 =?us-ascii?Q?iSfDgLCy/d0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+J4vtyZS7iY4wAew2wq1tO8soymLU8Kwn3+Ckbb1Yt/ktULPwqtkauukkVjP?=
 =?us-ascii?Q?bg0Eudpr0gc+0UOr49V0nU10Sy2a+LP469kgHS3/YpDmriPkXbk0DkoXt0Md?=
 =?us-ascii?Q?zdgzjQSpaFl6mYBX4PQbXhNr23bPqv821VfAn27kmOso2hxmfoZm9ZE3Nyuj?=
 =?us-ascii?Q?CpF/YOUWV9OyS3VczDSxlQ00GonIO3Q+Al7j7gQMN4BoThj1cFgEm8aQ6ESu?=
 =?us-ascii?Q?ukKabVKVismMxJTT8jAEGPhffHsjAHF8MZBaU0Ls7mljKrk/JLQtKJk8tS4+?=
 =?us-ascii?Q?+AKSLzlU484IA9g9rregeHQ5lEA55hO0qNacjbke5fb32rtd58hClFjn3e6t?=
 =?us-ascii?Q?z5BO7MVjm5tQ8lpvXpTnJ9hAOhc0LFzaH/4RdDEWSN/DjIVf3a0lxM7B/Ek0?=
 =?us-ascii?Q?1hF5fCGlBh+/Bq0rvYq+xsHgrrU1li38Avc7SnBFkvBm9lhxafoNw+7BcYIc?=
 =?us-ascii?Q?ralgEXjz8jPXNn4NIR7v2v8O4whv3j6BkTLlK7sW0P+tdRoszA6yZ8A7C5lU?=
 =?us-ascii?Q?9pnaDd74SF3Mp3bu2TjjbHjSg7FG7jFf5XwPYbzyJQhHQKJzROshb+M7Hwbj?=
 =?us-ascii?Q?EJQQlJ7lWOEd8EAwt06tnA+oSSs0EA7Ib9c1pBgDSVfAxu1sbAle7jANxBRq?=
 =?us-ascii?Q?A5a4eE0q7uDWMCrTw4QA2zMuSB6DkTTS8SJRX6svtp2BXUuhDlGIHNPaQO0N?=
 =?us-ascii?Q?GxSIlimWvQsd3lTdCtPMS6l335oCGCto+O2HP1T4j+acT4Wx6NrLymgi3vBW?=
 =?us-ascii?Q?j+3viVw7oOm9AWKpAotEvdu9gUkO5dfYhigKeSD2hIreBoS65HCnU7poK1MF?=
 =?us-ascii?Q?bDP+EtMEio/bRva60/Zk7QHth16ilObUJRl7PuoC4zFfXsQL8BiVC1vLfWf7?=
 =?us-ascii?Q?94rCSIdI7ZDN91TX7HLQn1ouiQOm3JGsBcplItPT5VfKwE0gnLKJX5dO2J95?=
 =?us-ascii?Q?8dtmlC4mz+g+tnhkU+Ycsid7WdWjL0eCr+ut0QMlWsbOvBsEhAbIbC/GcDEh?=
 =?us-ascii?Q?LMOtd7SLtAFs3pfXGzXYDzWUSDJL0vOeZMp+RQz3rv/Wf30qxMZkZPGqgukm?=
 =?us-ascii?Q?v7XgrZWfQEKVyqtN9LtCbwKrcS+RQipYoGqsSbI+fgkAJ/hftme7ADmpP1Fe?=
 =?us-ascii?Q?YB8PKNCZ8sQpjg8Sl0sC2tn3WdnXibWOUQRf2ko2xPEcnlFnUVnZo0fUZDNS?=
 =?us-ascii?Q?WtLEbpaq2P/Q9jBro8g+sB71Pyych3S8iStvgpx01YKL+jq1oap+thHfcPiN?=
 =?us-ascii?Q?Nx/DkcT9ksYSGVExvI2ZxzO7fRvjR9v/z8EWZUoUNKZTtz40AuZ2TUbV/5l2?=
 =?us-ascii?Q?KI0iKo9RsyVL3Wr8EiKoFSR1ARNIoQjRH07gsJbVUoDxtfpf5z81tbzqDN32?=
 =?us-ascii?Q?Tei4uhnS9H73TSpPuGUo0iIOUhDQ4B/aZeMz0nkFJoaFPSDWMb4O2jv2NS2S?=
 =?us-ascii?Q?FSM1PP358g9ggacuaJJ0CokjdBs+4Yp6Tv4cCz69keEH/Z2tP4ificpGjSxK?=
 =?us-ascii?Q?4hqlVwghOzH+vGFEWB/c5YXLoQpVj9bs5WypZBn1uhpr71Ak8zfqPB12tjyG?=
 =?us-ascii?Q?+Zx5sVsZ8lCdofT8T66FUQ4MJ2Rg1gtbKSw5OGyw10oXE3ASWbJpNuvzoa02?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WDflm73b8SXPnaEhWmSLNpP8hZ7z0//HUgafavOThg6GqpE1A3eqZdSK+6eAljPA6L6AA+ozcY1zSVLzh1oy7upF/VfaTC0Of+xy/3kk8fhALM2zRRGwK1OAsYKh0FscKwSS7dxIxBcr6S0w89Q9ia96FT/a79siDmR0r5+zmY9j5FkExOhv/FXWPgTF4+816hRt2FyB+LkAELhgoKHHODBPQe+GtFIYRlOynMjROG769ziB3URrsA7wj9SuN6cbxaSamFpXRfWqrReWyCSPhGXqpDpHje97eJbl84i/huD/d5ECW3GrsAsFZ4i62Xr5qm4CPkXzWZbgRcCm+3OHGsHxHeWW8Y31A6OqwjjhhLMrh/HfMqFrQ+ryIACRTDZNPRaJ7tEP9YEKOr5MVnoT9xj4K9HJAv4tUC82VhhjMIrG5KBlFv3AV+kj78Q1DnxNelQXUZ9I3KP1p9HrrKjSlchsA8FsVPSpqjSPKkjmG8WhrAiMlladQNXxv/48PBpKb7ueccuWkPiW3UPCDU1UUGeQlIMKUus06v6W+YLNLLncbbEGUtdWyV+Cb73axkIzfQWZ2xykCskN9Oj4uqWaMUExt66XLz/4btA4U99Kzfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0956201-b5de-40db-c1c5-08ddb8a266ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:23:00.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALP7iBuAIJOBOn5vhnSgHtdCFJ9AWTdBZ0W34Gg7chPjzIg+w+FNPIzyEmNh9yYvpjdY2Jo6orX6C1XZdq5D05ESY/iFFLrgK+j5P4iRoDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4NiBTYWx0ZWRfX8W+cSn0RRYdK z2444/Ek93DZDhvS1rDNlHwhfHZVgd5QzdSRGrPKUfzdFdFneZSm0GN4eIXZ0142TmlOIGUWjG1 GZSkvH9BPgWV+/IaO7uTr5N2o+w89DRe5+QQaoaEjEtzsXbw0WSh/QeHwvJqZmqM9+svYwYTvJJ
 K0xKhFYNdEcJ/u2oKJjENXXzcJ2YyWv64A7aCqFat/Dz89ykiQzXRxCtVsWkWlkkaegJeemVvEI rcUjjrefoZTdmd+PAXw5flwUMe22xWIBocjnfUALGepPVmTMTMlT7zPbxYC0dnWhmx46B4IupGX dCOne2/zmtPkpmWthrRRqvDpeI5qXJpU7wG3HzQ3hzb94NVwajlkG4cQ2AEYpqZXJHbdhYcJj0K
 4sA+EARPGm+VMqhzDIU8um5GjeR8UHz/nhC2wDbA74Ak8QCHsUvn5qJliVtsOLqda/gHns/v
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6863e152 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=-NgofIoVi_djHdvg_LcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UiIRcFfQLmd_7sy9BXRSHVrH2NgVwFOe
X-Proofpoint-ORIG-GUID: UiIRcFfQLmd_7sy9BXRSHVrH2NgVwFOe

On Mon, Jun 30, 2025 at 03:00:10PM +0200, David Hildenbrand wrote:
> Let's just special-case based on IS_ENABLED(CONFIG_BALLOON_COMPACTION
> like we did for balloon_page_finalize().
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/balloon_compaction.h | 42 +++++++++++-------------------
>  1 file changed, 15 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index 2fecfead91d26..7cfe48769239e 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -77,6 +77,15 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
>
>  #ifdef CONFIG_BALLOON_COMPACTION
>  extern const struct movable_operations balloon_mops;
> +/*
> + * balloon_page_device - get the b_dev_info descriptor for the balloon device
> + *			 that enqueues the given page.
> + */
> +static inline struct balloon_dev_info *balloon_page_device(struct page *page)
> +{
> +	return (struct balloon_dev_info *)page_private(page);
> +}
> +#endif /* CONFIG_BALLOON_COMPACTION */
>
>  /*
>   * balloon_page_insert - insert a page into the balloon's page list and make
> @@ -91,41 +100,20 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
>  				       struct page *page)
>  {
>  	__SetPageOffline(page);
> -	SetPageMovableOps(page);
> -	set_page_private(page, (unsigned long)balloon);
> -	list_add(&page->lru, &balloon->pages);
> -}
> -
> -/*
> - * balloon_page_device - get the b_dev_info descriptor for the balloon device
> - *			 that enqueues the given page.
> - */
> -static inline struct balloon_dev_info *balloon_page_device(struct page *page)
> -{
> -	return (struct balloon_dev_info *)page_private(page);
> -}
> -
> -static inline gfp_t balloon_mapping_gfp_mask(void)
> -{
> -	return GFP_HIGHUSER_MOVABLE;
> -}
> -
> -#else /* !CONFIG_BALLOON_COMPACTION */
> -
> -static inline void balloon_page_insert(struct balloon_dev_info *balloon,
> -				       struct page *page)
> -{
> -	__SetPageOffline(page);
> +	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
> +		SetPageMovableOps(page);
> +		set_page_private(page, (unsigned long)balloon);
> +	}
>  	list_add(&page->lru, &balloon->pages);
>  }
>
>  static inline gfp_t balloon_mapping_gfp_mask(void)
>  {
> +	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
> +		return GFP_HIGHUSER_MOVABLE;
>  	return GFP_HIGHUSER;
>  }
>
> -#endif /* CONFIG_BALLOON_COMPACTION */
> -
>  /*
>   * balloon_page_finalize - prepare a balloon page that was removed from the
>   *			   balloon list for release to the page allocator
> --
> 2.49.0
>

