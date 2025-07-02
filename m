Return-Path: <linux-fsdevel+bounces-53624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D963AF11FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2901890B5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6BA2561B6;
	Wed,  2 Jul 2025 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q1wq+7Wl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l71awHLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772EF229B16;
	Wed,  2 Jul 2025 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452565; cv=fail; b=Cl/QgJhcGWkpZIfUlix6zUb+NeqkLMEk7xqbAk9phCs9ExwZ81LCOYWFhSxIHQNHdZN2nqTMhMSJXkcZnwWeb3e2EasFA3rapgPeaQOCfySQzAv/00jarmOCiONJUmGvvwPD6KSfzJ9maaokMagaVNoTvWrUqnAN9PneWzdE+1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452565; c=relaxed/simple;
	bh=wmpXeRun1lzwL39oJhl4jgAgANST87bCo+qcxqdrqP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AaJKUSrAPlr12uyNzwcAvw70MOfhWpwtMt6U82Q1bMXsaUhxhKo9NeVAWpaqtJgdji7uVH1crvomBbXS56uf9tlKlN9H4LNJTHdicTJUHk+tBqGjZkB3iKO/vo1GwTe4gOZxvJN6fi2MYw9upICnI3JAy7Bv06SpIeMp2W154bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q1wq+7Wl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l71awHLA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627MY5e025687;
	Wed, 2 Jul 2025 10:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ryoEYXEMleJRTt6vsQ
	ai5LCQrCzfqUEj1QQ8hsiUsLs=; b=Q1wq+7Wla7V1Dd+L174RlKjG/elSgC3hdg
	bRBidaaCi8ZUSLxgs10FxD/r0n6K0W9LsG6giu5BkJpzvEhp7CDTrVFvK+9Kz+Oo
	yxc3sxhHSADS/qEn8lpp7rl/lJjOEY0RKClwAzC6u0ppeIV/vnvY6S1ndYAeauWq
	zDu9/iH/mFZEVy9hKmbGcHMSGnFVRJ74ZaMSQLVrTKpaa68SvwnmT5l4SQm1XEsY
	LpZC9UBYGHnqcyhUaLnNquw4Zs/yZlOSCd/zWTW6r7066tv+1v0Si/X48ZCn/oDt
	Z8J72r3EHujpPnC2d7W0HxK3vdQwDTsLA/XBWuaetJC/frmYeP9Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766epmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 10:34:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562AQELm025107;
	Wed, 2 Jul 2025 10:34:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uj9rr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 10:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzQxL+JdQuzmcEBGRrlZ2nY5+nOFb1vmm1eeaReQyRvq7ofvxdDv7JhzF0XJ4/04i4l8BAegRo7JgNplPHFmoGZ3JBi8eNB3d0W6GuNdM0RmO4QW2/bF/xEbSlLdU9vOHcvJDIXf+M1thGawpiSWjN89KuUQ98yIE76k/3tIiEaXQ/ia73zPURyhqxPyF9x8M6eIyHzvmZ2ngvgsYaCsLgyRi4k+TrXHPnpTUNiPRtC8ywooji6i8iYGXecTqptdbULWyrYGwYbcOAVbzeV1ys8pUIf0+GxWP2VopPW+9NItYmble+8+YEwZ356+gGsQ+tgqTkKBmqLcdZhw98XTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryoEYXEMleJRTt6vsQai5LCQrCzfqUEj1QQ8hsiUsLs=;
 b=rSC7htvnU6JwKer6l+jGeYNa7wcDjgl9kz2OjK14UOgP2gMID9Sd5C80k2zrmpKefj/ExVyQq1xG5VAv5649apWnpXQs0Eh1On5FKKTOTLT8q+FocDb/AtlFI6Xnn6dIJO/KfM24sQMuwzLZ6wKV965LavfPJnCgBs2Qo93pCqsNZFha4I1eOYo9UdSOTnv/QpdTAC846GSiR11CSjmu8J1naobOV5LEqoBa5nZ2SJS4pyp5ekQoXNK11aKRI4stDyVHCyi5H8NnxMV+BVk2V2YhG+yuqq7ob8drWRKAMgCH938WaDw7k66VFi8Xe3kjrhK2eA3h+GcIOOAywW7MnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryoEYXEMleJRTt6vsQai5LCQrCzfqUEj1QQ8hsiUsLs=;
 b=l71awHLAwgvs6l+U9ebUabfM17HeRz4i9cFxkJE6BTTnwCe4AAPLW99pGKMcOcUwvt//Qh4VnEMoc+K8Th1Kfpmq7mV3dyzRveUma7LXwRqKs7J3X6IPy3eS85VcdS0D+FCyBPeArRzFYWGQA40nstxa+3Y1jVxtAyx2lkT6YB4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Wed, 2 Jul
 2025 10:34:34 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 10:34:34 +0000
Date: Wed, 2 Jul 2025 19:34:04 +0900
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
Subject: Re: [PATCH v1 19/29] mm: stop storing migration_ops in page->mapping
Message-ID: <aGULHOwAfVItRNr6@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-20-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-20-david@redhat.com>
X-ClientProxiedBy: SE2P216CA0029.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c0a078-6f36-43e2-7c82-08ddb954092f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T3ADkQLr9vNTyoX0C1cOdHJp5pDFCUszfxqdf7s5dkP1WAkrq0tuzGKG6cbn?=
 =?us-ascii?Q?ZF1zi468s87LHp5N+KP0EEQg17kyg0qrrElRuIAGZ2f+E+PaqflpzrIAHKnt?=
 =?us-ascii?Q?0liFi+Vg8lhn2IklYHQ7h6E23CAYzmm1c7mxdKPK+c2KCMC/tMzcagxjzFWL?=
 =?us-ascii?Q?cZf3O+2E6VjW1ZzoqWLxXT7He6C17j1PjL25mhjNd5iXwp7WXoQ11XeyhF5x?=
 =?us-ascii?Q?nq4RzIfapi4APt+Rhq1sFZxK5w6thG3am3jJZg6obJYUWA2TnRbW2O6WLSy7?=
 =?us-ascii?Q?IDR6v4tms+dwG4khlZHUO3SwROac+5XdHI87HK44ub+TuRekfRZKSo+zrknE?=
 =?us-ascii?Q?sD1kKbl2tovCTB+N79DF8EF8GfzdPxSF/52XqQUXOH7iWDmzF3SpJI0CRFlJ?=
 =?us-ascii?Q?mlkTbps6ZKRrHjyC5Yn9XjIAZknTTpKCn1FEoAG9lIJtrk4Ruc7MQzR23i28?=
 =?us-ascii?Q?+z/OG19t2puX+JeORgm+20Dp2+mp73Fv+RMn7Z0QCn/V/Hxd3vmUNcJLeotu?=
 =?us-ascii?Q?oDzbTlzI2eja3Kyd57S9vkoxAfzsta2UzMnpc0Sgmn4ZJJn+wss/Mi1nfyNb?=
 =?us-ascii?Q?yR5vRHUzVEPsmOkyQJpqhSZ5exlL7uBBx1+4d4xJ80cTJCDguBwemvLU6ep2?=
 =?us-ascii?Q?vEstK2IiG/OzO+5PybkgZG6RIgkmdYVCno2MldP7zGPu5ITf2T8OOpWh38gP?=
 =?us-ascii?Q?W20NE2sUb3vHkqcVn1RjNft4FPQTsIDrBF5ZkzqA3MGXotwPJiYKKN0oyOoJ?=
 =?us-ascii?Q?rzAG2IPP2/GqE+qmixbphr9eLQARN1vLqxet0iqtgO4z2oMCQO7wUZcy5Ylc?=
 =?us-ascii?Q?R/GEdWGPX2Slr0eWqAVuG4whyqbK9oBV/Bk5dNVWQI3feCtGT/4sHEm/I2VF?=
 =?us-ascii?Q?SxW4cawYwFsw8ZPhkS3HCqpg8kvV39CYLZIGWCBk5UzTB2tHncskgxrW/E1/?=
 =?us-ascii?Q?euRBOkZ5j5EtyWN1Y+HvmBvLCPbt2IFKeYXQwuq0uYJUbiNE98nUd/PBWkm3?=
 =?us-ascii?Q?5r5yfb9HRDg5loXhRBUG1xDVosAia3fyAHFG/P6/1Fi+TzOB5UGeGqSh4NUr?=
 =?us-ascii?Q?4eI8s8G4UnyI7YRNLp+uBcepfoRztq0u7KzUqxFXE9OXsiFWAb8dFrsR2mNm?=
 =?us-ascii?Q?LZ+Ja+J0sVFTtOyW/GZ+Vv657wzMoMH41Cd+URSMQ1U0ROu78GmPgkSd2/Nu?=
 =?us-ascii?Q?lrT5Zf/o68l4vglflhEeZg7BwqIuXgv4PqMSlqSlYSin2QwahKc8RVaQFsqQ?=
 =?us-ascii?Q?EVLyLJuq+PnxXuM6m9m5vS8us/Vb0zh2lwIiUYTGSs0Y4pFNtW/w9bxAB9mO?=
 =?us-ascii?Q?6MUiy3FjIKXymUceX0qUd7cY3OoiOOH3XDBOYSgtp9cK5qrOoyjK3qHmYQBx?=
 =?us-ascii?Q?hykAuK/uja6SQx3yn5Q+0CRile4RyZUgEiVEdsdf01QiuXxXbcjXM8vMpDPU?=
 =?us-ascii?Q?5IyUBNjE5kk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lj9pU/SjHfwja5Zd4KhneXcWvWvC/SeURVp5424C2IZqol6/PZmx0CIEXB6A?=
 =?us-ascii?Q?pDzDkt4TnwSI+V0HwEk5jRS+jM9RF1YPRvydCPRAeDzRZGrRL+7MYK3JVr7V?=
 =?us-ascii?Q?HDMgfIc15PWsEMa6c2TH9K0lq5aApDSahpYPyOl/nlgYyaxVNz2QrLOPhjNq?=
 =?us-ascii?Q?6XcpU005X43PYcA5hXmvxzwKiFTwreX3k8+qnd2mvyWy8LnqkbnUvb4sQ9eY?=
 =?us-ascii?Q?92GJDfE9hvekE1H7qsvjUeMkVwZ8aWPysR8XlzhE2avalt0xoa1e3dfrQjxH?=
 =?us-ascii?Q?dkw+fH+8D981ReHPtq0B9zek74r6DrGoYvxbNcrhUryYptJ82dm7yjhmucxV?=
 =?us-ascii?Q?Hcl13LQYw2uCQXnZqutBXX0iQnmP28bzvaLzorWAoBWhyQoKS++KuOTW8044?=
 =?us-ascii?Q?XgHusshdJuPM44hfvK92AKikmeay12jo5U70vpmMZDBEBYzXY98o0QWynpDt?=
 =?us-ascii?Q?ZvYOtseRJnGeK+OdZaBzEh04qYoBqZUNJM2fTR8H6yA5+Hfv5M//zRSzB1Q4?=
 =?us-ascii?Q?zmXcm440KufR14HK20ADk3QJzKWaePa0G1eCZWsYTDiSK4cZtbCkySKpKH1U?=
 =?us-ascii?Q?xDpTkql2Zv/v6Cgm26r2QmojMFsuJzuXyP7EFocjX5Rdq4U+IYKZBTmLGRVN?=
 =?us-ascii?Q?iJDHDuzqgkef33hFYyhJo6cDZuHqTm7xkSwr43MZvL0Q3mSCPjL3KqUR3+ie?=
 =?us-ascii?Q?OW35Z/zpVPHbbgpDzIeblDuNQXS27kFtjKlAzUNdRxfCJ/NA0eBGTGl0TMVM?=
 =?us-ascii?Q?v+53jFN7nMjavbQnxG48LuP7O+I7tzNk+ecjUkQzaeubygXMm6GVR0e1b51P?=
 =?us-ascii?Q?laf/gRjFwIEcEE5Yj+MuzVPw6PcC6kOyv4ZYSc46UzqNqZcQnf+jNd9jke55?=
 =?us-ascii?Q?KRlWSQ2/VPAGL9RAV9u9Vnm6AJ3Hf/JyM8BJ21Jp/ElpCPooxTV12D9ktZSg?=
 =?us-ascii?Q?QMhm/g+v3/DheDdFVIW0gMOTiJCcqKrMV5rEsDUUn+5FISPW/C5If+E9cJ/l?=
 =?us-ascii?Q?buMkd5tapLurA9cRvTnsIEn6usgoECG0sbsApvjat/7b4mF3xBDT+EG8ZMKL?=
 =?us-ascii?Q?RdCnvYxwqYYSS6B81d4noKlXYyCJmp/Gv1II6krJLBvZHt9uwxdbayFkXL0p?=
 =?us-ascii?Q?tTN+Rp7qm+bwGVBHQgzSHhWUcvpgniK/zkA8yq+hrOvI2YTMqLtidiyklxuj?=
 =?us-ascii?Q?nl8ajfd3HW2XLHBu2sOWEBWv567F2YmwNEv9+k0au6+DaJBfe0vQg+GCIQEQ?=
 =?us-ascii?Q?dPa+kM2aB7sL/wfZIiyUntq8Ie6k2J9HGTU9zj0pnG+6vzAJbfgiJT+vhcgK?=
 =?us-ascii?Q?V98frbudPXBTvcMhBdoUgFORNFjdcb4GG41dD+VEwOe+/lhphZ7yM+3v7d4W?=
 =?us-ascii?Q?cOaXVsUJSaZinu7XglJVICSo+JNoGPnOqq9r0fYVlbBeeKRU2jv8MF2g4n9e?=
 =?us-ascii?Q?8S7xhv4XSd6AUwJyrK3h2v/dA29BmCuq4WaSPbISszsnd2zkvTA01Uz9J+Oj?=
 =?us-ascii?Q?0fN4z0bRyo7S7MgcHNUs6qr+gJB+oDy3LFBHH36KiCwF0UahCErayHZlITXm?=
 =?us-ascii?Q?lYT0W5/ghGh5hCkes1jrczu+r9FtwDfMLicNWit7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YVgnU/Yz8FZIwGiPmzSaijkLVCH7ZLuL5MoC/2AmWb3dYlRWbNWm7PbTK50ny8peK2SVa81heAEuTKeeZQdrIqiGNiTEqWTOZgh4iKAWoyy+vmJlk4I8PhcXF3TNEWTui9eo9xQEBhhvofHp15aZWKwsWf79JVAoAzT2TQEX2IxtEUBVPKtH6xbKMwBX2/05ByotxCeUbwZHkXU/ZvWCsrZnK/01DeF3ZyzRQNlUiSYcXX0d+G8y0U2YA6ls32fZ1BmeNy/JUEIAv9wgwZp+DMT2xNFT1/GtCWrp+dwKggJ5NLXNm9pAPtcbgAPNy8f0ekVSP7QvvmdYHqmoV1bDKMMQ0mEonFG/DEattt1fxauJZkz2YKY98EFjAM38I3mkAb9X5K3Ub1uY91LO99SEYO06+njCGcvZ98Tahq4MMU487W8BjI31D/tH02gm6d/O5gDBaRffLdVzDcAJo16BCP6kkLTAqVlJnq+T1RPKBOL+psTLoLlGjL4fhHLoROQeev/YWyoa9wCBfk/Avr0u6icoXH/D+BG7Jo8RncYdd3lGgj7weRvsf6pS/hwojKLXccvivBcc4I4g55oTiWwF//HMebdKo0QL5lRyCjWV3bk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c0a078-6f36-43e2-7c82-08ddb954092f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:34:34.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEuMvZACo1sUiQOUt3Kf70gOvSm1DxQW3DrE42qvWJjM7eX6oUgmaRBQRevzPpKOKhMJ86HrFnVq4shHuNv2Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020086
X-Proofpoint-GUID: EhcxjFScwZP1sZ4-VzISSBU1aKbzy6m5
X-Proofpoint-ORIG-GUID: EhcxjFScwZP1sZ4-VzISSBU1aKbzy6m5
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=68650b3f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=-6JlZ2V7PJ7UHZdLrFIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA4NSBTYWx0ZWRfX/Ipi9rEw/2qk SfhWnKKygO1muwtp/vXZ5bCYh6sEWoA8fmu2xl2TSGNpZqZw2UN7nFgZ2fSZGpYoXG2bydYlMWx YUrcpUmlGeDB84b3cMaCFeJTHeXsve7saRBV5kbaRfCgrcm0ZBFxEX2VuyyWva9tGLjL7dDTiFT
 or9aBtxefFg0Th2S2nFkY8cwYnKp8gDHuMCIqsUs0vrgYosTvKl1Hp9nrS24Qc5s27MSsxZWIK+ FmzAHHZ115NCvseiGbIlB/tNQYzmLnxtFu5kzbdYNjOHJnYQ7vApuPqsWnKrAe6JBbW2mEEq7fV uBU5gRcoeg0tAwz73dee4JiHPvoHXlJZyxG55A23r60Inf50dI8QTUKskHIkp2LtJcI2LBHEARa
 BCsFNtYgR6oXfYO/NLlGsUuyvhSyRCkNToHXok9CtC4vS1sSkSvxWD+MqvXGKtCtrmRFuDMi

On Mon, Jun 30, 2025 at 03:00:00PM +0200, David Hildenbrand wrote:
> ... instead, look them up statically based on the page type. Maybe in the
> future we want a registration interface? At least for now, it can be
> easily handled using the two page types that actually support page
> migration.
> 
> The remaining usage of page->mapping is to flag such pages as actually
> being movable (having movable_ops), which we will change next.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

> +static const struct movable_operations *page_movable_ops(struct page *page)
> +{
> +	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
> +
> +	/*
> +	 * If we enable page migration for a page of a certain type by marking
> +	 * it as movable, the page type must be sticky until the page gets freed
> +	 * back to the buddy.
> +	 */
> +#ifdef CONFIG_BALLOON_COMPACTION
> +	if (PageOffline(page))
> +		/* Only balloon compaction sets PageOffline pages movable. */
> +		return &balloon_mops;
> +#endif /* CONFIG_BALLOON_COMPACTION */
> +#if defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION)
> +	if (PageZsmalloc(page))
> +		return &zsmalloc_mops;
> +#endif /* defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION) */

What happens if:
  CONFIG_ZSMALLOC=y
  CONFIG_TRANSPARENT_HUGEPAGE=n
  CONFIG_COMPACTION=n
  CONFIG_MIGRATION=y

?

> +	return NULL;
> +}
> +
>  /**
>   * isolate_movable_ops_page - isolate a movable_ops page for migration
>   * @page: The page.

Otherwise LGTM.

-- 
Cheers,
Harry / Hyeonggon

