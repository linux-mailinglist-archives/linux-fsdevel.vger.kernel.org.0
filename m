Return-Path: <linux-fsdevel+bounces-53424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16376AEEF9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 09:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F051BC529D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4B25D209;
	Tue,  1 Jul 2025 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="atghJRv+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kn+vDRDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC75142E73;
	Tue,  1 Jul 2025 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354212; cv=fail; b=HJmh3AYLsgMjJBhVptXeTg0Lpnjn9OTvsgy7sYxsJpPAFGrZHGOGmEKfnQKZRq6EwP2knh6egPte3s6yiWZn+YEaOt7mrrSEGE4O7FRZOyeXRxqruP/TK4kNcZ0H4AfibO3+VoqiM9AEGQbrbqHP6iJVlXrVusNM1/wl1lJihkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354212; c=relaxed/simple;
	bh=wYq4P4h35wG3T4NcDRdum97s1xPu1lRx49n+b1zy1Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OINuIBJxbeFDN8ts9a0Efqnk8pp4J5wlgei91YJomd49W6SebINQhbnSKXZ49N+WMZYfMBlR88HeIlQXzeIv+ux8R2Wrqm+FwTDbnPADDAKyrtx2vRYhL4X66FA8XxgTOt0O9xxxIBI+Yn3PPmN9W9JZfBgyb1TVa7Fhr/dXKqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=atghJRv+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kn+vDRDM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611MuIL012619;
	Tue, 1 Jul 2025 07:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ST0e9xy7QZ20jzGH3N
	aigq5Y14PZNSX0pF3Nb9aKh0Q=; b=atghJRv+rCNOw0CknRn4OUVROuoQHd8VWS
	nSMkCUixx/ROcgPbiRBeM9nvz7vC3lXFC0PXIGeKAcMAAznk03zBSwpSuQLR3RgY
	463O0UhWOKqk2hmTQUbILv01gLSZlBHZ40wa9EA2NUsUeVHg+APqDMRTaEQJ4Fh5
	M8dL7XoGKRuOQpTl6kef4AAhQybtmdjc9I+Mc38soVVxNMdFKAh4Mt0mDQQYNlgz
	PCkpHeLMPkLdd35FZmvyHC2dVwnOF1wqpHZGvQMeF41F1+1xIwH8Fuj/4+LIv/v2
	ohlSghL6dJTwFdrk/7HsqHWzRjAryJJT3IKT5Kwi/zUlrxw0a6PQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfc2nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 07:15:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5615HqZx029830;
	Tue, 1 Jul 2025 07:15:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9c9qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 07:15:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bm8sayZbzQq5LxPms2gQVvqrrMyacEUL3unV+ia/TWLe5JNjLbF+cAHa4ElZCIjePs7AuxSZGH3HwzsRA0IIgLgPp7yDRjvFCCzqExQ83fI5bityyx5m3VTkgxNtp9jNH6KMdwbLTIWy5nvxiMHZ6WRq87kjxr66sGgQf/GiSFf4Wi5D+3iwnq+KsraRYaYUeTsuYMkl5q0rY6+NpJpLSMIZ7EGJ42Ydm4N/8AZGbqqWqQlpUyRVRP11TFNt4xbjcbgV2+R/Ph3fCM0nCNNZbJGV2EdACkcfnNYr+FKP2j+9xnwSKgwMqTQGNxUcaV9UEaSwM+mIvdMTnquRVWTAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST0e9xy7QZ20jzGH3Naigq5Y14PZNSX0pF3Nb9aKh0Q=;
 b=MC74CoTl9mV++Sj5tarJWx2EZvo6zNXwwoQ29nnieQlaX0FIyy1dYW3F4iiR94i64z2/XUorkBAyRtT+vkjdCNLlFUxcQnEHL0Kj+Xjn+cOmlHLJUnAKZbJYPpET9No1M0wGuK2RAO+66kjfT3g1FUx4MZW9+jEEZRItutuqNwuUcGQv7z1mN2ZqDVyMXpXPL/WdPLNFSPd46Hf8O86KPiW/+Aj9Vk+fHjue1WQuOwvZWYK+YN9w27Ls91Micy9OH5lUojXnVpOc5WH46UQL3DthUGFUd5YstW0jej7LsosCrGH0XOa7Ol70emeK2baXAD8AG9nZ6EUNd5mpHhmupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ST0e9xy7QZ20jzGH3Naigq5Y14PZNSX0pF3Nb9aKh0Q=;
 b=Kn+vDRDMQZnmm5z9VZX9V2TS7O/EmjmQRP+YQJK6MGFryirMCgJvxQxjDTpo68vgBACCsDe6dTyqeCcZYy/QVtjZrW9oeEDifyVvYLfN/c2UzNeuPiSpRwmFFMFI0hhH0lb1qxqEKdVx0m5PMX+s1l8xQ3oFSRMyX/Pqry7mzCA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4612.namprd10.prod.outlook.com (2603:10b6:303:9b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.33; Tue, 1 Jul
 2025 07:15:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 07:15:05 +0000
Date: Tue, 1 Jul 2025 16:14:52 +0900
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
Subject: Re: [PATCH v1 11/29] mm/migrate: move movable_ops page handling out
 of move_to_new_folio()
Message-ID: <aGOK7Hn5_KHvmVJ6@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-12-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-12-david@redhat.com>
X-ClientProxiedBy: SEWP216CA0016.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4612:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bb5a0c-212f-4fcd-685f-08ddb86f011c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Yu8l9/dWBvMEsi3JGDg+aKDgiWYwgtNuMRoPkMVHsoo7nlvHHflyUWLI8j/?=
 =?us-ascii?Q?LgvSgWk42ffF8mTysIO21U7nxOUUdDVPRlJnTuKZI9d0ii0mN8mVusn+UF2D?=
 =?us-ascii?Q?6oasV2ZYSSYs+5s8jxbhoOI2ttZisdHpcUNkukzyNtJPgdFXOcax2utVkOXZ?=
 =?us-ascii?Q?PLuyv4xotJpAyotjCmuv5fYrg79HpDnxBVh8dmuTMJSx78u61ZqcsGlaAHEb?=
 =?us-ascii?Q?cq3gI8j+yjlbRREHkH9XQH5HDnesq4EvpuqTg8f5S+rPTSRaLeTs+PlNIPLo?=
 =?us-ascii?Q?VzUg465Nm22M8V+ZoReGteuKkp8aTDEp/mMpnOyMagsD/yd4tEWjzY+78dQp?=
 =?us-ascii?Q?TbbM6jxQmHr1rPx30p18IVPQ3yEXhpjSjOpHUn5tih6VAfnVw4JoR/+j/5lu?=
 =?us-ascii?Q?hZxBef54oLf03b68Cgm70RrKduWZrrdXoffLHAT0DdcLpNhSZmv0TuVPLrjc?=
 =?us-ascii?Q?cor0rOodfz13SgkziufcdEDUXKEFDyvyKOXsJeNlntaXgOEpXU7GQBpkg67q?=
 =?us-ascii?Q?I1Z2NbYhAbWwr1fZ3aQtnjcRHaiow6+k9YQ6mkxXYMsmeOqhKoS2v5QVoQTQ?=
 =?us-ascii?Q?ndssm2GAxikmRfjROemRvoeeXjg09ijiDTefciR5N3l2mCfRQe1u7Yk0Vyjm?=
 =?us-ascii?Q?xR9YY8Be/mdlE9oz9WoyShMyHD3cKeOC1Wt/sQwRAdiuePPRlxrm6aipE+O/?=
 =?us-ascii?Q?eFrr6a0kEr/XNiE+8vPdsioPZn/vewfn5Ndn6R9OkWsqAFcxQ6gjGP8Mom/b?=
 =?us-ascii?Q?JUm65SlGtbtqCei9uT4IvNBJKDzHb2k2aLe8nB7d/KQlvRvcQEI7ErNH5AtP?=
 =?us-ascii?Q?4cqcTvUzLUJpPT/hy+eMzYVn3F3wNeLNsQoAHwStkrxi7UsUvnJCqqSux3LK?=
 =?us-ascii?Q?UjumurPpCZd/dPOJ+wX1r/shf4hbhEu7IR1PTMbIN6cC3rIqB1ISi77wpJx+?=
 =?us-ascii?Q?qef3r0zprg+PU2X/eunAXLGXV6Y9scNjt1rKILy4lt2uw2tCOSqqeYlRMvA0?=
 =?us-ascii?Q?OMOz0wkL//1Umceisk221WQcgexIrkXcCwDHfgcuWi0Nq1To74b2Zj76LdD2?=
 =?us-ascii?Q?bOy9J5sWIa+a7RU9fhs+jEesejegCYV7YkBBmA5MmEbaMHGIg56CRAH+eT9s?=
 =?us-ascii?Q?F+H7HwZVU1yRxE+StghajH3sJUJA3bm44Nye0pisSxtOM64CC2jlRo+03gcq?=
 =?us-ascii?Q?EBkq6Nhe9dHSWsYziGauIi+tsP3/SrBxif5esox1WOobkRj/LxDTGjeSg2/v?=
 =?us-ascii?Q?YwCbwpvx3CrV2mrCiJkmSICNUYTjcuVgi1Ku//j8OXUz+Bt6kmrYBKOe5FWh?=
 =?us-ascii?Q?am7V51xt5MwsF40VDN63JWCC95tbDCQjvCFl+qx2+Igg0GsPAT3tnQmqjYCg?=
 =?us-ascii?Q?IaDquLecPVzxTjptZ6R66S3QKyGu9/BcMX/LHdJP3dJfiDXup3QUlwP9cPoG?=
 =?us-ascii?Q?EUqT1ZTeIGw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJmEARMvId78CNu50cjdKw8j9QXiGHiABYNnk6t/yHZ1YZ4ZOGT+OK53Jkl7?=
 =?us-ascii?Q?zHO9lYP8DiETbs5jSQ5RudebKLj2GBmzW1GgRFI4ZoTr3k1l+EJXtrJDLYlc?=
 =?us-ascii?Q?mFauzBp15udzepl88wPsyv3LNfuDUKIIBtRWsUR+Uzrdovo9DR4rvuhSSHxw?=
 =?us-ascii?Q?YcOwmNjblgJLoXfjAD/WJG9mG7E12jbRw2pnK4378mlYlk0hgWynnl7So3KN?=
 =?us-ascii?Q?FeOzjkkWRYKwM8Py7GYiDK2lBAVVtV58QG4Gkl7x+ENjO2deHf1QiZDrdwGI?=
 =?us-ascii?Q?U3W+da03ce05BFhP1N55s9RCyry5ZdNVqIFigDkyAsBS3MdQmDBIW63phUjF?=
 =?us-ascii?Q?z/ZR/pMlLFKrOnZD8cFW6Y3KFB/0dRfM8uTb6wSBH3iFhD2SVtPeO4+DJ/Ed?=
 =?us-ascii?Q?9KGL3X9H6r4ukr1gKyHr1EK1o6yqSwlzChcsjMRBslhr2yMo8VBuvY3lsJ2u?=
 =?us-ascii?Q?vJ+eR+h/Gn7u2r1ueqkhVdVLyTkihKy3M4gHjZ2NHoE3OPVTA0sz6p5UoIZE?=
 =?us-ascii?Q?CgXOJ4vtJG4kbhB5U9HRWOu/hNBvy7HLuxVQx8F2bc6f3C6/p13B/GDtcRs1?=
 =?us-ascii?Q?oTLoNgjJYDca+S6NmnQQBGrvBchIntxsQBO/tL0v6BGeKiC3cNWnwRXEPQG4?=
 =?us-ascii?Q?hDuITSgoiZYmVCud576PkAmH05PTA1CBF2ON6isGVacBfqRa6N+1T0Rga1Oy?=
 =?us-ascii?Q?m1wuOM5S9GwTW6QTp7ieNrQLfShvRUX8XFbUYbuLYDl6evLK9n6heKJxv7/I?=
 =?us-ascii?Q?VQavYgUxIvqoV/1XkeamzY+1Pc7kRXY2Z5kOOgfPBC6QgKTId58BKhPfQqeZ?=
 =?us-ascii?Q?Upw3fttxXYErTNe94x/83vWiNclJOusugduvhGkuHG/0SRMsfsyntANyfFIr?=
 =?us-ascii?Q?2vMNtg4BXCT2EcpFkQHgj+zC48f7DXDSEi0saxtZDfJ8MNU47xBVGL5g0jbJ?=
 =?us-ascii?Q?Os9RWIMcMozz4KlOcbZqSoOx+Utw/mTEGlQjatJqC9HQ8vq/pKC/2mIIMazF?=
 =?us-ascii?Q?Sr3Lr+Pq/PLtXow+EFbN2PlebFz5ySSETrYXfTXVuBOIAy6V5DUmChuEiPGC?=
 =?us-ascii?Q?fGxQKK5WCC9yxtIXcb89GXMfwhdQAGl49YTeL+vb+mHE7e65Vi55+VRwcw7M?=
 =?us-ascii?Q?z+ohiehzNOTrNqYjWvSKSPhXgaEjHQuoGneMh7nAEw/OJ6hOucg8S/MaMeTH?=
 =?us-ascii?Q?WknMhNdreO96S7BIMPr8jaZPWmes2CP7MxmMz+EhebT2uIvqJJhx8BuLz0SZ?=
 =?us-ascii?Q?TxyaA/KKXuvvVcM8KHvojGROX8UIDFEocWwlTAwGzlK/oF+2CXrWJ/XXDFsL?=
 =?us-ascii?Q?83DXCYtDClo3s/lwsAzYCWn3pOb2oJgjqghTsiDsApyiK5YNXWxyDlrM5hJM?=
 =?us-ascii?Q?mDlFPb4XqMfMr2bPcswmG83zMf0zX6j5VLK2/tRVlWjF/kD6Igia3mT0FTLp?=
 =?us-ascii?Q?Az4wDU9RpwUhgnZGvaHa7STY4fCy1T81e1vXA7S9nTlK2KyUsIOXKPA7GR7W?=
 =?us-ascii?Q?gq4Ux5mLB7Xdxx8Nk0h8MaBKndSqR0MuobvQeKkTKPYNwbZLpSvt5nVYnaAe?=
 =?us-ascii?Q?C4Xw479Nj+gFJG9l7VPvbotc0gd4mcdHb59yD9yt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nl5TK74syyPMg6911xnB444O7Ys2YAjKd500D8BdCjyktaA86yFBV9+0pSV4PfF7zA7jEEmzqRkURX0WFw21g5hS3HjEBRTsHXRcL+VFkN7Funb7FcBJTOjbzCuI5iRNsRJv+oO0niP5qo4Sd6T+cezDnluaNoJcRVhzErCzuJr7xLciRgggLSa3XBgwZeUqBGOw+I6j+LUL69UBWx3BEIZ2N1O/ykD1poAVKOvc90C57u01g/dHSjYsIuSlz9ak9064U+tHbjlQs5bnfQ/nqy65NaAiYqMC0wGJXtiY4cLWbrkCc+K9IMpWg9N6PzZtu3oBMuNpaHEPIVta+ng59n+qw1h17pY8XEGTjFukezObBAn8gjduOMFUPut3WTShJIWzEizwJ8suE/mUb997eOlZwOwtPyJUeOu1Xwo/+R5PHtDCunozwfvJweIC0ObryGV9Q4xuCNje+uoPJyokS87rFZeplJin9lIeVmDbVaTBYVCurBkhHtAKNwzEWZr3ToHZ1UW6E+ACZPjN9QNeOybDvK8xjKIbMtF4AJNPlQIOF4zJT+v2qJ86ddc8ZH0J1jkpxWN1n0WqN6tyQP6wmOZjGOQar5rAfvFVFOVs8eA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bb5a0c-212f-4fcd-685f-08ddb86f011c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 07:15:05.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Obm9Y9+j5PTWIZ128XmeXqLw8E9g31GQ0vI/5AlwB5oKbY40mQ7o2dzYtvlxUn2tJchBR3/RKSPFZxe5NVBFqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010040
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=68638afe cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=RnmqlJQ-qsnh_LaFR0oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: wB9HqkS5cALgg1Vk8AWOL0KXf9SYJLXW
X-Proofpoint-ORIG-GUID: wB9HqkS5cALgg1Vk8AWOL0KXf9SYJLXW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzOSBTYWx0ZWRfX6B19UbUTIwg9 Pelyiz6r0uxXM0p69iVFwn52U/bDQKLAdZsyMI5duKQWBDfeEr/rj5S8DSTPxlZXLOsP7JS9jUJ 08ggpisZswr6KpI0s3BanjMWYkKdZViru6bfXYROSpmpsUMppi+B+hR5++sXR4gIMeKT2mUKM5L
 EEv45hMnWTokFA37sI5ZmxRTMOzRaR8oKCvbQHpsBuv5Cw4vDtg6ATlg7wQpYwne5Pm3JKnKVTy CNFIlBKXuq7fCQcQaZK3xJioUX/ddegGNnjCvuwU8ai4T6CnxCO32CQvxOO2diwxW39XRG1CzEd 0h2rlRb1AnOm4PVQ13R7u/Kfha4UI9Y7GlgL1yDDgYL7r4uhHoM+ArHW8razPW8VRMuz4ZJzf2P
 mMlj5yQl9I3TEwccvit1HxySVZamqWthFTxCJghnh6FUgcjrojeaacRi2YOcoo5z6dAgVxZR

On Mon, Jun 30, 2025 at 02:59:52PM +0200, David Hildenbrand wrote:
> Let's move that handling directly into migrate_folio_move(), so we can
> simplify move_to_new_folio(). While at it, fixup the documentation a
> bit.
> 
> Note that unmap_and_move_huge_page() does not care, because it only
> deals with actual folios. (we only support migration of
> individual movable_ops pages)
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Looks correct to me.
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

