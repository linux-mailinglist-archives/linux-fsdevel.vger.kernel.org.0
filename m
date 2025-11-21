Return-Path: <linux-fsdevel+bounces-69458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C65FC7B81A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 20:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A43BD353F7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134052FF65E;
	Fri, 21 Nov 2025 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MFKTorrk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WSChAuLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED811E766E;
	Fri, 21 Nov 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753090; cv=fail; b=ney1G84wvorC8weVXzw5kG83UZWNVupo8P31qCKUGdbP8JLinOfh1bGJ9OPOs4DSbqIXVYywC3tHcPU2hKIsZwnMXyT/cViBrjpIMKA+2ikL3nTFEbJpzwUA4/7kqW9LcZjYWOWiMH2RQI7jHe1EGVZW0hVUcdLiCsaeZvd6Vo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753090; c=relaxed/simple;
	bh=8lTVXZVCsohqTlKgsqbe1+PCpS8DI1KyNmoLr0uhdQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lWgyWscortgvRmgnevNiW1X0YzcgzrgN4YG6VZWQQ8ZkoSy9N4BUhj7tPZLuJCw2fU1EgsERfSb6WsAV8BLM6qCWOH6zFPhbKMkpuNnTmrWWnQVn6d+OGcNGdZmww+CvEd6795Du+hblxPB1WFShto5jxlrazASGw0+6x7aIKPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MFKTorrk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WSChAuLX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEgn64017123;
	Fri, 21 Nov 2025 19:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=t/e72bn9mNF/f9EDDV
	NtHe8T8p+1ltOiQoRgWfDJRWA=; b=MFKTorrkNTyIpzBNzsdrhYNzWRCmvRyKB6
	E5ajz4tmVqq9LdrvkkTQXnWf/TwfARGdYckCRQJHPnl0QzFqmBOa+bJmW92hRayL
	hsARahkyIZpU8q4jF2jAMy/5neeJwiRbp0CEFR2kGHGjWSFtQnYaYmVUDq1ctEhn
	fGbgty5CODaTN5y/GK8k3+mupltMVhcWSwWkxBm5KMKnwlRqHe3QyUpEmXvX8aeV
	49nn4CpQe/ZNezx8uP4YyhrJhXKzOAupB8pzoNJgl/myHef3hN1m521o9mPqWNVp
	KOpUyG8HtFP7aeejxEibZED4NqicFF0CWnyPmuQe/MmIml7CeXzg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbc44vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:23:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALHwhCE040040;
	Fri, 21 Nov 2025 19:23:47 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyrbxdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:23:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hw7ldwkmVDrkr7R6Gzbd4M1XaCc1eHM/LfD3HCTtAiGpG91DGaN8B094RIAw32wH2J9Pq90R1cK+44BruNI7H2GfydP8HZn+rAguZzaShtImfdLeON+RTigHLZ7D91ApL7jMRcfI+gRa8/mJk4snLQLVKWQWAQ4B618KCTzT4+SZBEamyXItWe7V3uQwjPtLZMPHNObMe8vXJ9TGZVL13Je4HVmhjraCKM6pDNWbeSVEZ0b605CK1key4/DntUqer7CQS7BXLeH3NfeztpeFkOMzsrDq+DH2r9QEV29bAvQvW0esw6lREQAbHAf3/ZXzbCpGs6vQJY0BQfe/uhj2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/e72bn9mNF/f9EDDVNtHe8T8p+1ltOiQoRgWfDJRWA=;
 b=JgApCY7N6R1fyu5fpedaiSiaQ5AszHzju+yBY0eMh0QyAv2cTGMBR3+MG/NvQNgxhE9gy1PHMXhIQw5YasVlz1RB9UcAQfssW9/8ZjHRyoSy8TMrj7Ta/+HvI2qQZUwp1gtbZlVefK8jWTt8XZdH4GtwBCeG3tX7lkRBzIBkIweEb74MhgD3lajYaCMgbvpklWMtYR7/UbSKEXCa9fYuu6SuuJZfGBUlC/trsaSPDcioYFWgqUshduFKWC3iulXDOvk7CEc9/bJSg/haufI680JVAVciwRyJ8mPE54gbL4A48Xgxm8Pf1O6CEmTgkWb5FxbieNrJHdh24Dx8ZSz+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/e72bn9mNF/f9EDDVNtHe8T8p+1ltOiQoRgWfDJRWA=;
 b=WSChAuLXcN32m27K7z6Q2fRDoKPScdZUptBJKfwHQEQ8UrbSH0WcQUtnbtmrYDaPgGMO4ebcJWJORL3skxpgIAwBCbFCQk2U44awioJx2QKovEdbWe93RUlJHKg0cZq/2drGH4l235pKujDPsdwZ8c0ai87BOOCrj0b4xEoF/zo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7573.namprd10.prod.outlook.com (2603:10b6:610:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 19:23:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 19:23:40 +0000
Date: Fri, 21 Nov 2025 19:23:37 +0000
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
Subject: Re: [PATCH v3 10/16] mm: replace pmd_to_swp_entry() with
 softleaf_from_pmd()
Message-ID: <cd97b6ec-00f9-45a4-9ae0-8f009c212a94@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <3fb431699639ded8fdc63d2210aa77a38c8891f1.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fb431699639ded8fdc63d2210aa77a38c8891f1.1762812360.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f401a3-f772-4215-42f6-08de29337a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yrk3IC1IuINM6YvsxUzzC+b0TOCQDYZVlTq/i3g5/6dXU2TGB5GyR0aLcLg8?=
 =?us-ascii?Q?5GVbAX+rSgAyZjxndLHX+uCqha8BGN8wWcwfVevk12qq+PTLB/6JVH8oKoOp?=
 =?us-ascii?Q?Fl27IpLZmEGaKcFDaY0Uu8Pav1cOgMPFHHcIsFM6oJLAvxRVr2F6tS9HG5Op?=
 =?us-ascii?Q?zCNN5iFbRcti3S7RfOE7+7h0NE+glGNOtQLdYaNnLL9NfAwALcl0XAAG61+Y?=
 =?us-ascii?Q?jQw/jKj9KZ1pqxVq+HnW89vhGKT1pNw3gZQF910PRpGKniVJ0OA82eqcQ3L6?=
 =?us-ascii?Q?thrafzsnZWx2COk7Nb52y6pJ4Aa5p52A8YBWGwN5ujfzSlYzVhwI/LWw3hWD?=
 =?us-ascii?Q?6wFx2aV7xmKzWo7uX1z04h5VkB6ROo8sjSpfIw7cZMohwmG4J6buKwcYl0zz?=
 =?us-ascii?Q?8UNIUdmhpxaezf07DXwrWiZqZsWtUKkllHYzyo1ciE1rPUKc1ou4E6MO85Rw?=
 =?us-ascii?Q?S1YZArcjkOckl1j72MOkwFv86uMz+F5VYgsnr1d+oKUICYX3jzzxWXCN3IUt?=
 =?us-ascii?Q?nUzxCsc3QK5uUtKfwzlYqK7GmEN1knhSyuffc3P+g4fo7/shDjVlrnly8BYb?=
 =?us-ascii?Q?UiiDr6FW9WXoMnNFWJxVSyZQ1ryOfwz5vQINJ+svSwWuyXNN3yOtoFzldajF?=
 =?us-ascii?Q?y7W8+j8kc9zQ4lP/5snfgE9BBihZVhAvDnt569pdiCTujHvpwO2wnPyvNYOq?=
 =?us-ascii?Q?m3n3iqrEYYcnc1QjOY6U7gGEHCYZw42C+dzofeD/YBcdousZw6EJAXxc0sIv?=
 =?us-ascii?Q?iR/K9vYYYJFq0ykk5NuX/as0tSPfqOYF7Xp5oPw/1hSSXeAEym0llozzGXyp?=
 =?us-ascii?Q?y2CySHy6axB+AB6Pt/MgjMNP1sOadlN18Tja8BBZKFlMCH9+6mVu981FHpN4?=
 =?us-ascii?Q?u7cFQ3ZCKe9Fu5cL47rKYe5sOQAoAQpglQ9MKwxldRo1amZLaZnABUhqPdfu?=
 =?us-ascii?Q?qJfu0HAjFMr6f5NWpCImGNUGHqrvxM3ovgj9QJ+huCV4wrYtRXD/l2hJYS0A?=
 =?us-ascii?Q?fgMoNFvk/E/duZeHTEumZ0gu0Ste3NU3d6ajcfCInwiJaIb+73NbX3cTQYwj?=
 =?us-ascii?Q?qIljzLxAXGcntydaQVk1MZ1Yq1an/HC1dghcqXebZZmSyn79j3hmGN3ODj4y?=
 =?us-ascii?Q?Z8mgBpT0E/VKSEgeTSkur9FHUTUr+d/2RBUW/Yrjk18rdqa5Zfe8e6KNRAMn?=
 =?us-ascii?Q?qFijy5MriiHIuibyzBzaeahWyITeeOQ/3Lu3zd9QGZ5eb506+bT0SKVGXT+W?=
 =?us-ascii?Q?8kYOUiv4sSPB8K0oKu4p3JtglaZoWuwY1TZBaki3arYLGNEamp5fvXMiJX72?=
 =?us-ascii?Q?6YcKVGucIhWJm03wSaWcDMGUcdvwNdLALqQavK8hrvgEn8WUC3EhwKWnMTir?=
 =?us-ascii?Q?YIKcG3h6VmIlbDyZYdEei55kTEmtVqsMQYwETwuIotPH3PBdT4nhh7YEb+uw?=
 =?us-ascii?Q?dgxOhH3+IrT8rjEzswPGWhcDBuUqqPuT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZKkm+MQHBkksO3NzUkZv9W5J5IAXY6nC/PuAIa0//5dyGV06MHhWMPkcS+rt?=
 =?us-ascii?Q?tgzUwAg/t08deuBfr8ttoL89GosZEIp53WxSb4inefNNxg0VRW2wCmwQF9I6?=
 =?us-ascii?Q?pHnOss6mAkMh9FvYwY1QJY8rQNSUbgpRwsCxA/HMcskxppeyJTuJTuWyYO0M?=
 =?us-ascii?Q?URxK/0EDSdPJoVsymjOgkymiFGOAP+hf0OgO8VXtA5gDE3NGeLKcupBYOgH2?=
 =?us-ascii?Q?Ob4hzWfFRME00u4M7rcsX2djOUKx1/tubQ3zVYJ+SmhwViyeiyZAxwWaxnEj?=
 =?us-ascii?Q?iit2xaRE9kB71/j5+mp6aai0o8or+bJ0FRyI/dRiGrGRPUVA78dw47kHBRnE?=
 =?us-ascii?Q?yUHZeWwssAyc7o2hozKcMe6jSGB2H0cUnqsyZtwr6Z/6rskgf63sGQAS9iig?=
 =?us-ascii?Q?Pe1rpX+hqRkA/GF/Y+gRKMWWZZZ0snCEuaQKa//7FqtJ7RJEAL2jRNW4AVlr?=
 =?us-ascii?Q?JUBifV4EhVd5I9Ao1ZYhA1UcZ3+pvP7KJO4wjT8gsjaV4wNmH+v7meERvlej?=
 =?us-ascii?Q?K2WUHYDuD+AN60d5I4Ip4G0xWdoY/xahX86rtq5iiHBTdDMaV/yO/qkVPBUu?=
 =?us-ascii?Q?Y9sGjN9UaOWuoWwnMe3cPcgxX3eEEI12S/z4QzPenOD1bEXFEUPCX1anR0SG?=
 =?us-ascii?Q?tFOsq2j2TS2QsEv+KT+Df3+8XNqsMEOWfv1OrpcuLFK3TOsMlPxCku52dD5B?=
 =?us-ascii?Q?OCJEUkyrqtLEP1RHmZqCcZGugd28QWOjGKtjFMMz+PQOXLceBtHFwJ3pLxvw?=
 =?us-ascii?Q?gdKp/Feu6/FjbHFwGRhvip25YSK7BSyOU/n5VJFc76cs4ianwDAhc7ViClAG?=
 =?us-ascii?Q?EPFUAK3fzXssqMrHGkkC1tRwO88apWZRBGouxvm9Xtdd+sV86lkq0sqHTdZs?=
 =?us-ascii?Q?Ve49gK23E3tNifV8bL1fcGcIN+AZ3UUl1SRNY8fXBHt0nZQceFWz26herDCf?=
 =?us-ascii?Q?5+rYIg2AYEW6WtEySE9hBg196LroFb9Rv/2EI3wKKxb2f+JBIBHOYh8u67GP?=
 =?us-ascii?Q?/0YfpEvCSbh/jvpgiK/OtevOG8S87HNcX5ob+uEpOf5i4Ez2qEiYaGumqm/Z?=
 =?us-ascii?Q?gu7hQkC0ZZEASrzEyyE8lSrjMGY16+Ca1VoYf97Q7ETwaNIajmAHfQPnCWsG?=
 =?us-ascii?Q?i8O3fp/Q2inv7TWGG9TI+Z56fO7B40sX2lgFm7ZfwFlbBVs4i/IqjlZyVMWh?=
 =?us-ascii?Q?cj7kHPecjn/b3lSA33faM2v2aS+j1dVWyJ3XuCSGNLxgRuLkKbktNs7SDU7g?=
 =?us-ascii?Q?I5rhECaF0SNBa7qH63/GwYQ+h7kmtQlwGF1jQF7zbWhK4txT5LdnO+Zwxt6J?=
 =?us-ascii?Q?Ulfuu0qAT0Y/zGI7rbquXUs0W5621b7OQIPo1N6CjUBVmnT7zOsHyb5S0lAz?=
 =?us-ascii?Q?yZ6HGwIymZ3P6z41hqzhBGKbtJIUsjROqrWghk+2CpmGPpkUjED0foZOeKtw?=
 =?us-ascii?Q?+2DC2Ze1FERNuC2MlSH0PvvMfog4DQDiTn/X2O7EHfWIM/jmr/MoQ1Km18K7?=
 =?us-ascii?Q?pFmwSM2nvPALmwzYwzS47TB8QkbVw1AfxJaEHLUkZpMlQWtRqcoq4qrIKkc4?=
 =?us-ascii?Q?6pCaDtLrua2npYfE7Zb1NrvCrngl5FCJwbEwxx7em4lwXhizl7lduQ2qCVnH?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5q+lZeejG0LQSuYvngLFwWZ+504Gq+NixtVdUvDrULr4X6zmmw3WHQ+xGs/q9ITyCBfs96jtcrox6X2WpyNI0sLMEshjaCiSeyokLEdXU1hgZCFRzoJWtXi4ejFECFoLBmmCXZlOyHEgXmW5bGfnp12bfdQfSeZ+A3XF5/80PvQUARloFofVAgvfehx0PJQrKlLSaS5d5Zy+fYXtHvx6uzBsYNhLDE9JZ1MWsM9oUonrEaVn6uoGS2B+1z/BPjtDreXbW27KDU7B2Hr9nMFa3fXV+hpduXRWWVBV0LCn82Y1AY6cyWYzPQJ9pOWADgOnVue0wqu37OBTYKCRCm8nYoCHVbKuAwh2+8Z8yJbBOXvGx4k1aNqcADjx5mibcYXbxN2fUTAf08NmtJ8+bQkwdl6WfRHHqlb20CrRBsFKVOhxvWzC+DIMZiYH6mvO8NldlVojFfZi4Lm1owvYWugAljVJllWyLNYwXy6ghak0NjVdysr591avjmtXV4hZT+3kOXiHpSS5iHAb1lenRRg71gQvAL1GGne6peIHQVo2f4ZbRI0+2cYqgkOUAUvBdXgZsVPmW3yHa+GntYHT0AIXDvZXn44sk7bTcYJcBRd7MaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f401a3-f772-4215-42f6-08de29337a1d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 19:23:40.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ePWg87Imk2pWnbJpnJydG1Qv39cEw/8TjSM4FIppsTAWFl1ImNSoiShCGpHrwcpfChF2kmyWO+XS3IqOyLarfq1wOgaMz8BNMeyH6EMOgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511210147
X-Proofpoint-GUID: _ox0XUjJ_IGxNF_bytlpLSxHy4q97q79
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=6920bc44 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=afmQhuwv_NL2WsLKng8A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099
X-Proofpoint-ORIG-GUID: _ox0XUjJ_IGxNF_bytlpLSxHy4q97q79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX7S4IhRedptFe
 fA4K08wQBO7/v7BgccVKNtIsgyt5z2tDO1bITAsS3i6DNr2hXNJCaAtaDhCGEG3NAmhsNSGTYPZ
 rrhsaUhFsTfUBFtZN2KXuLwyGJUnA2TSsVEKCk40jjtJvjvVsc+3twxO3W/Naob1oGwwo6LTlaO
 JKDbN9ikQboS8TuwGJ6DrU8GQ8GWbOn26tdhQS2wwa+ctFgO5q2kcCPFao//e2Uf9+uFk31QZdE
 7566Hi9a4fbcobxAgEf4uB9qBNQ4jMAdyuTOb7kKlldzptGyv5Cx7hWIpKkIgG9MdsYvheRNf+P
 8ALYCjfFq6ueMQo5zBqVBs4BUonoVMkzceP6fLEDgFcZUK72dK4ZZLx5G3mSA2WCOKa0+6Z2E6z
 pG6eEYdDoBoxZql90mmj0KRCbWyR9ceNVniiBhBrOVrz600HPRU=

Hi Andrew,

One small mistake on this patch as discovered by Vlasta, fix-patch attached!

Thanks, Lorenzo

----8<----
From 0fbf3f749d378153533f041d1be27dd498dad3a1 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 21 Nov 2025 19:20:57 +0000
Subject: [PATCH] mm/page_table_check: fix device private check

We should check writable, not readable/writable.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/page_table_check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 9af1ecff5221..741884645ab0 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -181,7 +181,7 @@ EXPORT_SYMBOL(__page_table_check_pud_clear);
 /* Whether the swap entry cached writable information */
 static inline bool softleaf_cached_writable(softleaf_t entry)
 {
-	return softleaf_is_device_private(entry) ||
+	return softleaf_is_device_private_write(entry) ||
 		softleaf_is_migration_write(entry);
 }

--
2.51.2

