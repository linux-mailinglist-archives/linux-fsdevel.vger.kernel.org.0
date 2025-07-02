Return-Path: <linux-fsdevel+bounces-53651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9330FAF59F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EC74E225E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9F285C95;
	Wed,  2 Jul 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="coJKZ06x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sCuRU5ER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B58280A5B;
	Wed,  2 Jul 2025 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463755; cv=fail; b=qjgw1HhU2aKnwg7M9F7bxIi5aM1/yII9aDgkAEcky57Fb/wqFdZbT8aBGSvJPPgvBChM0A7sHl0XX+SUlyLs4POfCcYr+HOsgva/KopzSb+tYoX9MAatp2lGH6niLVYQnsql0kQ/nIM+ZdBSpS1/8pjD8i9DA5kI1cGECgX60GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463755; c=relaxed/simple;
	bh=NybTsr4zuek9mkS9tnFJ9tJp98qFlsBgt7Fa6vttw5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fe/mOCmOMts504HZonWG7ZiUCBHpbQcz5jLOVACd5F/8YL2AHtr+KCvo13o0Jg6p7Nz4a9zckRiN+yMesorHKDnRAMSfZO8YYIvtCJSXQd/oCHyloq7HXBJmYPJwQ0ACBLqsCeG1Y5Bdm314JzeUhw9gk6cJMJ1i07gvCZh0P3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=coJKZ06x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sCuRU5ER; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BifS2016711;
	Wed, 2 Jul 2025 13:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=z/PbIRUyVhSehJU8SQ
	Von8MnTAhHQysw3z/Zp9qBrtY=; b=coJKZ06xlPnNBTsyXqEpRxg16yO8x+FRjD
	S9fbdKvw/CTimg5EaAXkIu8VLsPWItTuRMYqz+8XB3sfXboGZbfdxRki3LbFF48j
	J9gkn6Jsn+BZmUcH/q7j7EVVR+g1yz7f+c+iJ9+bgiyK0x+TBwQv2scu6zATMYcd
	NERXjorqUyZRFvNZeiVMAuvW0rbLVJ7TQImqTvL7ShKLKYAfOBJqSY056qL+g3TI
	styRprstAs09KRHNCui3/KjaBcqXWmxKzPVjlPB1VgyfZZxpvmKQfBXlYmJTn5WZ
	xj2s+jb7N7M1yi/ZIk/5DSSjhoOexd2D7uvoZjJdp1Fcldqz5oUA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704f0cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:41:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562CckIr019270;
	Wed, 2 Jul 2025 13:41:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1g07us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAIUfZH4+QyqjSolowOe3DHkkaldvLJSne8MztTxjYC2UC/0TiWyMOSR2EhJKq++H+JLB6RZWrJ0gBZ+8v+E4FkYlnUq9KgB0qzv5DauqaIs3TWJvl+YR0roqje9M1AORCTMdzBzSl2AkOtux/+mauEmbMk0m19KYecL9XlsEJSt/1OeazYgdXy7JK/E2upWKxpvgsGRKNabVlZGHPS/fIvtWRzy53zxf5CpLOIRWPFvgE15IBGeKR47ovfxOjUm6+Wb3SXXausSLarELHbnd38krAyDQXFnda7BTXPOx6RE50mqaF3VcMTxyGOTC+euLstDP0saA8dCPW9Cdz0IPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/PbIRUyVhSehJU8SQVon8MnTAhHQysw3z/Zp9qBrtY=;
 b=fHiR4J49g5LuJGN71gov4ZIqoST243CPe2xuKBI64o7C9QGNBC5X3UOObg94vzdjgWb4d0yl5+LougwJqao2ZwWtXkZ49fa3Kmy95CNg9ffHtxjffQmwXUfJV0C2I9S0Uo2q6DenFrtbKbojJJio0KW25TQ2RW1+fk0ZGDK67gNo27Z5XT/RLVETGHP20TWweFyeRsvJY5G+v9DzQNOY6N5KVR7yZMi0q58G9YehcQiwvJ+fsnubr3Y2wOWOTK1YQfxK+WhE5e0ObatLUd/4EOYfWKoiBflLsdab6SIkjfpGbcOuLHUUOYQQ/1VzCpMiYQSD+VeEdDpeswU9rXER7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/PbIRUyVhSehJU8SQVon8MnTAhHQysw3z/Zp9qBrtY=;
 b=sCuRU5ERfW11yWQXZDK7E+D9VuEEgseMT2oP0CrpgSbD3PEnGBhxDpp7Zll6sf6a83NW1aS+ZFCqn2NzJye41h9b8g95L+Tq5gXspzopH4XaMMc6PwDRMZRfYbPG/1aHd9tzlPUZ+4dsRlTjYYJsOQQgPGRgeVUjqyDR+pqpB8M=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB7461.namprd10.prod.outlook.com (2603:10b6:610:18d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 13:40:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 13:40:59 +0000
Date: Wed, 2 Jul 2025 22:40:39 +0900
From: Harry Yoo <harry.yoo@oracle.com>
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
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 25/29] mm: simplify folio_expected_ref_count()
Message-ID: <aGU21_49Al4m9SgE@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-26-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-26-david@redhat.com>
X-ClientProxiedBy: SL2P216CA0102.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa896fc-04f5-437c-8146-08ddb96e141f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbzJd1mq4ZyGuO79GvikTrQjG+3xv81hJ4wDQZ71ETFU5aPgv4lTyDDPxCaj?=
 =?us-ascii?Q?y/sh16aETVHY9c5WEiUg2IMTfaI62SfwIAJGHaSkc3zhwMIIjE7/c/Kn/hfs?=
 =?us-ascii?Q?5ZZEne+aGy2apHb65/OrdQ463pGHQ63pNEGvCoyaSCTCYWOcb5FsOZ18zqqG?=
 =?us-ascii?Q?c+N5I2qynn5rFvzsGdFW3Di7MZHNd0DlgloZglqWIZyI/Zt8cq0NgEMzBrFs?=
 =?us-ascii?Q?zYLtDhpcpSvtyEe0nMHMic/lzvBEXGPgwHScgvaxl2KbCkuY8JkbVNenBReS?=
 =?us-ascii?Q?50/iP2G6lsOOng5WB/6Cc+5mf7izKuYOkrval0jSoQrkGO4lx7JYyFUFx3pd?=
 =?us-ascii?Q?rE9+q8bBbBLdTcK5T6VCGZh00F0p4naSDBDdOO+i1W89qD1YhwgnA6/+DcRm?=
 =?us-ascii?Q?9aBrHmC1T6amK8FrnYwnAvyigYzzXbxGN1e/j449IOfOiM6DXavnokwvqcbg?=
 =?us-ascii?Q?10Gql0n+xHkAQLqGa9Rw7ilzPXX5SYQcH9Xti6H78Xq1m40OcTfUtE+rVuTY?=
 =?us-ascii?Q?+UNC+ZFwLdd3KwaL9cDZybJgaDNHwZvQy+FOddSTWgpJBJf8Hs9ENv51E0B4?=
 =?us-ascii?Q?3WWvDKr8aAg23TIcCpX04w8BEmoF+kML7KkhSAhJ/ORIDTnpX+LBPBkFtJV+?=
 =?us-ascii?Q?Sc12FMXbLmQjkf6KrJzYcorqe7W5KJpUnMilVnTsUJ0J8rxpd98Fjzri21/c?=
 =?us-ascii?Q?2pDSFLdIDeQU/WxieZ2H626Ueqm2AuLlWnWaQLOabrcTTspqCH9hoy4Xpq5w?=
 =?us-ascii?Q?2waGLctuDWarMob8rw1yQm73XfEZ0mt6O1CZWemtauYDZUEi0NjmiQ7XGttg?=
 =?us-ascii?Q?9hJG5USH+2ok1KC+RLqz1G/hg8H5sFlpgSbepqyWuIDWTTzAc6iXmnXqbgzO?=
 =?us-ascii?Q?+Xo+HPFeim2njdWkoSBgYQ9aP+n5HbQtEKjPLWUT1f7jdc3FKngqrCxr6yJU?=
 =?us-ascii?Q?4AC6AOy5lUVgCLPyFcraIeIdI04lfm+qhuIguBIQS1Mhd99AFr73zU/S+Yxx?=
 =?us-ascii?Q?R9w2ZkOjLCxFDipu2WWXaMGgd/aaoW25PtBTanAf0rg1p5KQ9pyNOlITI/zr?=
 =?us-ascii?Q?Nf97YirY6RriyHVrKwbHQAyHQcZdEUZLunAf9YGEqiTbCYkFrxQW0vZoJi15?=
 =?us-ascii?Q?HjLSRfg1xjGsPIlA3lhkx/T0N7tJ66dXgcSFr3g5thCs30tbB0nknGhtle/F?=
 =?us-ascii?Q?rmJjGULOfU94ktyQRFC80dr9a+UC3yoNMJS9xxUh5nmYvYvwzJ2ik3RHaCo9?=
 =?us-ascii?Q?gwV1a9j28BbhB5eHUSVvAyJuaabyLg+7zxLGJe79e8rntLomwEFO9WOfCfNz?=
 =?us-ascii?Q?WXaLd3aTHMm6A8AXJHImtYwBIPeHk7cF4m0wH5pOg/5PLKb8LsWYBmf1BCMZ?=
 =?us-ascii?Q?Vlsy9k1Q1GIwu4/Q+9uS1g0m4SDFk1LU8SkCOFK/wn59IW4Oz2pryRKtrq+e?=
 =?us-ascii?Q?jERTPgAov7U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yYbnmASuo8afaks6hsw8Xr0tm7ZWv87vEBeWrvFt39D4coPnnxA6s1AGNEl8?=
 =?us-ascii?Q?CbUIoAfEof3KNRrDse4cR7W4StYyhfjLobFOassIK0XUfYBtPp3/pRGjvOlW?=
 =?us-ascii?Q?6yhMIldAmAA2/wNmp/p7t2JblxHg48qHCFY6mZ6MVmnS+uItNCtJjiRl0+10?=
 =?us-ascii?Q?DxZ+tdjtXofHh5iJmerZxwT7qkeL9MjRl3fIexKJgUKZt3fIKz+VHZFkHGfx?=
 =?us-ascii?Q?aSvocrNEG/dTyJVl5d+VOH/7a/aZ5VkWShCxKUUe5b5U1yRGIbJV5c3wciUC?=
 =?us-ascii?Q?NzsdfJVc1ev9DitHUiuqjBdI424+/jJS1S9gKQoTsGNGd09OOxpzDlANvZUd?=
 =?us-ascii?Q?FQgY98xyU1x+DqhDsqhqzfTWhecZCiGhA2ts1fH2lr3klUy3hd6G1NeaqnaB?=
 =?us-ascii?Q?Y1zMGUVLQbPIeEyve1EB7k85EWHhfpckhQTblplg2nSyxVOERGOgOYQxRRZ7?=
 =?us-ascii?Q?B1Nktoskx912v7JjhgznQcWP/YwsXOdgc61Rsxv5n4FFBcnzBtLYuYK/ZLAd?=
 =?us-ascii?Q?2y7M1BjqvUKQtcuyJnHkqOi7XU3H36Nt2eqa64XhyKzh4m2XkDYYPalxwx6Z?=
 =?us-ascii?Q?UCH8ZLTxZG9JBz9jeXxMUn53KY3+d94H25KfCOH3/sh94+aut9ZlUxUYh0mV?=
 =?us-ascii?Q?OeEZDjzkL3K6lyxwhW0wT9gB50FzCCLHuQZKdxAh21VpqHKvfsL6iPsCCjdP?=
 =?us-ascii?Q?dr4fohZpnIaFhG8RDoAkYXbG9Ax1+y4+HgJy/4UvRuj9Jk+3tjAH78Vv04H+?=
 =?us-ascii?Q?u5lExunuBrgQ4BRAjAKbITzpR0+CH7TRpv5D/25Yltg/FP0tP93KtVFl6nQY?=
 =?us-ascii?Q?W3B9G4La37uKia6llj7+ZDSBlteQoRuItDc4RtnwAgvdNVKuRB8dDjo5DSnQ?=
 =?us-ascii?Q?GhCnXy69tdjVzgxZarDSN+toZ8nIkJkzobGgFW2lt3g2eDRGIYk4ae1gK8ax?=
 =?us-ascii?Q?2n8hp+/IwbL/wgVmvo4VHR0bamGHwus6GyG2wm9gdisGEoE6Pu/LTeMhFCxN?=
 =?us-ascii?Q?S2hwgPRYVcDI/S4b4yIsN99XuBTvsQUnhmbv5Wmim0K938c3zWty7D4GZ8i3?=
 =?us-ascii?Q?bjbn12mKs6JoDTtFaJkZ+laB1+tihvCy8+3qhE+34tCOn35ciDTfZNuDDJ5/?=
 =?us-ascii?Q?c0zbrOa3Vu+3774bnebQsX0UDmW1CufKi89wKUWZbVIQz5ry8zwfNxrX1TBf?=
 =?us-ascii?Q?8zUmBZtysHz6BfEYeJKdeIzwaJ+kTvESao4whjWFon9eCvtJnBLezQ0EIkDj?=
 =?us-ascii?Q?Dx1b2mGmhi/bu3deT5rx2bhaO8hoREYrl8712mH94zLus1umko6ITgH7mw8j?=
 =?us-ascii?Q?265kTCa/uuWUFdHaSR+kzu+z/V1e6nSoyL0Np1SKkQ0oOPBgLMtE2JBxZqWg?=
 =?us-ascii?Q?iCMix0jxy+M4Zw3qokVKteYZV5staycPTYsLsJUVxuet+4VLnXhfQM68kNhV?=
 =?us-ascii?Q?22fwlDyv4E36JA+4Di9rVQJkz2FkWNdXRNuSgDMIalYozrPgGyVvWpZoTlki?=
 =?us-ascii?Q?uY2EQSoTT9qD4ansuqbYQagkDkBvQ2ToEF7DXErmdQ7O0qAPVNoHJX2eUZAc?=
 =?us-ascii?Q?Kf68XOnB1R1IS5ARJOtpu3UoTXU9lK/aJRihHSSh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oBY3tUGbDHP5TQGOByC/i9dPCe76gQWkhNwcM8Wm3/qdQSl4x3w2RH82RNazgdA4CgsbqiYOaczVSyPk+0b+LiujKZT2qJOmjP19hsrHJgr6VJg/irCGBeQD7CdCgciW3zV60lKGWMwaA4eE8Br3ic/YKIordG7kmMKSi1xtbnImNYCUxyBmv5YcR4bsl3AdD1i00vUqB8C4CULwFh39wZaBL0ZAZS0da05e1fKOwmNQHyPn/hdz7v6kGx29yX0hqv8VHvazowO8eMPG5OXLWnYz2a+4GEG4elG2u10FgHYvDm3P4dELhT9VFfobAKk1Vz4GzYooAtjKUVNWVdFaejeZihYuFOgdsZ1aCC/NIuJdAZEQrOzz8MB9NTs7qotAekdPeWfMscYwq/SNBNpbtjKJakEnu2NV2qjrdBm9QCogFIzic1gF17uDoxUFJ8dIaoYPKlmrPFpo1JfNTiQvztcQyxBfk5K+1SloOxd4XOJYbmtD7IH0mwTX6SpMJe4cjSVvcIifNKBbUWni1iyfS4JUuxoyaPt2gzAgKfvuPi2T/RghECs3R72raGhQ9aOvT3VVOTFP/uLEw3cqlxI4816Q9SoaOglK/Te7iCsRlmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa896fc-04f5-437c-8146-08ddb96e141f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:40:59.4739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrRQTHtpzbyEVxUHPv+pOwD+7eY4lZO7r6d/5xBNw2vSz3/cMeSTxuHNU1+f8A5SY0EDz/Xx2H9LaIxYnbtjpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExMSBTYWx0ZWRfXxkFL45vSpsiV Wst/+Dhj0GE5F1DZyfFE9GaeYwEcJuEC3zYJy4x/b+mOqAAxyahHLOS0IGWHe4G5BOOQYoCSm7W 6aGuYMwx50ICelGuqKXKIpOlH5Zqp3zdFsk0UrIr+r5WHIylM/96aRlEdJGK7f0irW9AWgY1mTZ
 z+sHYSIHsrO5qrvhC+moE/4hwNnMyZZzjKNboxWkU3q1jkSiPjNTF57Ya5ivTR+3uUOgSll7Oht vf3bfrt/3z0y0Nz1yr913i5CZJb2WNB16vAcgWJn2tod23xg/iAafiL2SETWgzsQoIq8n9R7o9p l5NVYj6NZoIGyxVYh4/ge/e2vAedsLJhOTOVA5tieJz/179agMGtp+a9qpTPePJpfhHfnyxcRks
 3DFulfUFUSfBUt/KW4mR90q/QbB2o9Vwfq5zHdAmIefnt+zb3we1u2qVKpoNT/uq7PlR3Est
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=686536f1 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=au_1ynU8MFqBXQ5Py2kA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216
X-Proofpoint-GUID: Qz7cFcZs3ce1sg4mllUplQQRcuOGvLNf
X-Proofpoint-ORIG-GUID: Qz7cFcZs3ce1sg4mllUplQQRcuOGvLNf

On Mon, Jun 30, 2025 at 03:00:06PM +0200, David Hildenbrand wrote:
> Now that PAGE_MAPPING_MOVABLE is gone, we can simplify and rely on the
> folio_test_anon() test only.
> 
> ... but staring at the users, this function should never even have been
> called on movable_ops pages. E.g.,
> * __buffer_migrate_folio() does not make sense for them
> * folio_migrate_mapping() does not make sense for them
> * migrate_huge_page_move_mapping() does not make sense for them
> * __migrate_folio() does not make sense for them
> * ... and khugepaged should never stumble over them
> 
> Let's simply refuse typed pages (which includes slab) except hugetlb,
> and WARN.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Yup, it doesn't really make sense to do this for typed pages
because they can't be mapped to userspace, except hugetlb.

LGTM,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

