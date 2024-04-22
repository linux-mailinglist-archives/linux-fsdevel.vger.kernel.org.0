Return-Path: <linux-fsdevel+bounces-17394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A098F8ACFAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D86028495E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86588152522;
	Mon, 22 Apr 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BhwPhjuq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gwvtoXby"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45D15216D;
	Mon, 22 Apr 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796858; cv=fail; b=sosn2jCnbcAk7Y25JG4amCBxqF1L53i07ZCsDAC5WYnjp/l7ZQBlOwpvT/ujJZUs3AT1F62qtYrG9Tx7BGmt9+qILeyiLn7HvBg7m98fwLQu+KGbbSErW4xECc+mDc6+qBXcKPWM1qEWxt/yNMdu0jf5H1m6L4+cXlKPwKd5OdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796858; c=relaxed/simple;
	bh=LQNTJS2Dl9j8hWesCuTuvvFAVzuhESZ6PR7W0z7t758=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTEWqD6xq1MLIjJE9TtaC7SMuPZ9CS+Ign50dmCjiUMAp1+lZgjUBV4G3F6Fx1lOSLIWcHoyzjw2e8F6wKVJojknWqE4mNHRxuunE2hDk+lWFA4uNOsQXlUF0KnlGyN6NuqvGz+4KoFYuDLQhY8kQUuojc0ZRktfoDRs7RKZlEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BhwPhjuq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gwvtoXby; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDY0xb005886;
	Mon, 22 Apr 2024 14:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=taroF7H7egrJK7Pw/kJDYZMg7eDmZ06EnDskm+PiDNQ=;
 b=BhwPhjuqA2w59yTi3pOKNql2zPHiMdb44iHJtEu/VGvDIkO7lFO3adSTjeavzWRKO3AT
 vl/TS2AqsuK0WerUVG8Wo3w2MRAN3MotD3gNSgZhCdkrp3Mzvg2u8oSFcsDQvAuO3oSN
 4HtWOGDft3QlGb498jTn6ohj4l7lGunv0wbQAtv/IJQVz+Bwp4hpEg92JwA//+u2f+r3
 DrEprtN8Mf1TS6qFYjmRiPQcMO50W5DcoAv+6a4xlmJliccrO+QAuvbGOYM5o3MJqGSg
 OTiUYXCZawx617OYoUbLPIJNTKxTC8KM4pypUW+8P2w496nuotEMoMvjd9qmq5z8EYAb pQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44ettkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ME73O6009698;
	Mon, 22 Apr 2024 14:40:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45byksu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwAtI3CEaGPPWnGHKziNieOCqMQbroxTDMRxBx/JUdOvb7noVfEWwUaocKztXUnx/3z7Snrr7RCjXE3MVRDSgjtI5Kpevi6JF2jo0tHhh8ouBiYrcmSXNO/DdoMJUfmof3c+WufKIuo40C06XqEA417QNKp+Lu4YXPXKB4Cx8xUsxP8YruF5n6GxNTL6gjnKPlc1BEWnQw4Qn1XuMGE1pI377XDvtDJUYaeMCvdQwbUV7VmVtlMyBqZfzuAbc6oglQ/TloHj5VJpA+LUli2t4RK73EFABk+kB5ub+8mlr6+0Qk43NaAfYXD/4ZU4/6+Hm4LLwzwOgQWyzhwr6CG2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taroF7H7egrJK7Pw/kJDYZMg7eDmZ06EnDskm+PiDNQ=;
 b=jlEevv2OWZMz2z6zBk+x5vRX0Ihw73Wx88kmQ7jeuOVVKSt0CTbYfUGaaDViBVE++IemGS79qss5lI23obwkXrVgzdjgATXdvChJT1yak7+rIh7XbRUbuxAolCsNKzBJN72Jr5Oz2s/q9e94zRManbO8isTD1wRf/3s7ZQYY4FRhTwa6gws3r0wjTIAXUeD0lvbf8XKCXE+iiIkUr9MYWfK3n2xaoOpKxC9fF8tJNRX4zND4zsBVGqeSRha0KdTCF0uhf3FlMuiAOA50TqZKcR1xf2rlYjA3zMyW5ctrMgPh7jdgATIvz6ronfA6tjuU+YsWUjQNoHIMsCV5pWZupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taroF7H7egrJK7Pw/kJDYZMg7eDmZ06EnDskm+PiDNQ=;
 b=gwvtoXbycNJ5Rsk+5JGG1KpyyiIZ+X70TYG4R7t5INa7Qp18jI1h/jFjKX1WU/rzPZlZgh22RjEGjU7uklLmz9dtPNnOx55kVRK05EVt2EqItXcjgxIZ/2aFl+5w40KOEWO8vcbpq3abre4O2EhdiSg84+3F802WD2RntGK67D8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:40:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:40:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
        willy@infradead.org, dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
        martin.petersen@oracle.com, nilay@linux.ibm.com, ritesh.list@gmail.com,
        mcgrof@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ojaswin@linux.ibm.com, p.raghav@samsung.com,
        jbongio@google.com, okiselev@amazon.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 5/7] fs: iomap: buffered atomic write support
Date: Mon, 22 Apr 2024 14:39:21 +0000
Message-Id: <20240422143923.3927601-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240422143923.3927601-1-john.g.garry@oracle.com>
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: eb47ac47-80ae-4058-f4c4-08dc62da2548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rB1eh7mcGR5wskUc5CTOWu8lvYeN1OtwR5jSSIhzmB4Ljyz6qk9wQldClS78?=
 =?us-ascii?Q?3w5ZKU3EjeuUMcyJ9ZvMN/TLiMwb7CEunEOm9etFGQKSrVZ0tDSG/vJJuJLP?=
 =?us-ascii?Q?voPunKLsxCFtwOkmy0XBbbAIrs7PjI35jJvxFaT/3RBiAeKq/99tJBTeF5PS?=
 =?us-ascii?Q?/n5kIvLim6bAYlr0yImUzLyZYGnX6/3cindh8YCETNnqpSSFYHpbSuNboYxk?=
 =?us-ascii?Q?roXoY044f6nYD3s7VRd5CHjs8OXHVvRDa+rVmuCAITBDGEvG7riZpfTVkG6c?=
 =?us-ascii?Q?dAHiKKnfSjaXaIfuA61+GDD2EtUz/jTrBRDoPQOskiGltlew0a/u+GIS2dR2?=
 =?us-ascii?Q?Bn29741JO3/77cL3frHz6LzsSA8L9+pMS+H5z0OHeeXZZYueMu00W4rfv8oK?=
 =?us-ascii?Q?FHYsrPoygD07LMGtRHCCora/Bi4KC1lWybH+RS63Zk09yVpF8T3Ui1WNOoX7?=
 =?us-ascii?Q?Vh+ui/fSoKhWOZ8RvGYr+ZeCTwugOCRZi5u7p4flqTVdNSchSvCiiylNSIjJ?=
 =?us-ascii?Q?u3REIiuYue0OgtYWHlhgQ91PGygkDZqisWCNSXvbROkLd1saI5IteITJC9Od?=
 =?us-ascii?Q?+5Y1Vv6QQJpZGknJ5n1HXB7EXZnTelHRq/1TwZwNkw41xaU8DBLNQ9QIfGMs?=
 =?us-ascii?Q?QPin5kdOmWeuws82Wzcu3OuSraGWLYOeaSOWcw1IDzChr3d7ZUVxANT9ODGB?=
 =?us-ascii?Q?ApPju5qaaSWmjtHfmTZEaihjPfruZOlhrk2wnw+pl8c7eMS758RKHycbR2Rc?=
 =?us-ascii?Q?sxB0av22CBkEuLaGQZyIPk4k2hWwuQ4rLvy46+Ub+vGhmOy753jSsG2Yd/o6?=
 =?us-ascii?Q?CSRtL/Z4vGcHuzHv0bvc/EGlHvzNq8scg+JUa2nPZI3ZkWfC1hucSIsaUwP0?=
 =?us-ascii?Q?LlYxl2itZcaatyBStpbueoWHPQel1x0VgXVDe7I4Gq/FZQNm4WwGi0Lcq/gV?=
 =?us-ascii?Q?xwBbnKlgHEFPAMo79tPbCJNaooR9y63H1MQGaG78yYP7yP2+vdNMTIAEqWnN?=
 =?us-ascii?Q?Za0TAd9XqCoLu5CYsL5ozM0SEUvDDlxJVz+ESLrQbGC4/MNo/wl3O/N2uUWF?=
 =?us-ascii?Q?wgVdI5r2uLBqA9H15k5K0SkKWdxgRqAugAGI0GEvbsfMMM3pT/K/Xs5ey6si?=
 =?us-ascii?Q?9EbFwrMCoHAnL96Y8K2QHMFah/7xWw5/uys0YKuf3IO4wB4+2+9YckqnOSEZ?=
 =?us-ascii?Q?DymblTT1Zu62EvwyzyYmhy5rahTOBdA8WS+TvetpsnsYuGor71j9t9LXfu8n?=
 =?us-ascii?Q?kNWUVIukh8AjF2Gzkm21KkZYQgvYC5RX7djDY5pg4lMw88+CtcSLhAH2tvYE?=
 =?us-ascii?Q?ARfYE/cQwGagikJT9C1ysDhP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w8gviT6NdX1aPPpzDJ+HJITzUAvCC5Vd7mzgfsmPlnBx2ZpeMhSbqaWsL8SQ?=
 =?us-ascii?Q?mKnUGpvgOFiIxhYVH8IopqDLLXnG3lrZ6H2pUAAMLUu5atujv/uYy8n88003?=
 =?us-ascii?Q?DMJkXTX8MHvchtIzc+WqSI3LJWq8HslIOHYKuJB57GlRuayMXKD2VHwbkBAC?=
 =?us-ascii?Q?POyjl6H/p5Qn6pOYsGRvDCYnGr5WZH0Ou+0eUnJtKQ52HYNyea8XAZYBGAiV?=
 =?us-ascii?Q?pkhJR9x8uY+m84+9hNzv2+6k06fKBUETCyZmVmNcORBJicjUbK3hez6V+OXh?=
 =?us-ascii?Q?HZUlI4iaQRgFAGapnDvpwIPXncjuK+ZPWhD1HMtRFUhQEfPkYY39M3rEBn5s?=
 =?us-ascii?Q?0gx/QRRV8inIZXgGE0p0iL4aIOalxIsWiCS2lOVIwyd6Rw566N5UnGTdw3xp?=
 =?us-ascii?Q?RvFndoXx9BMNuqWeKPbvpTpI++W9s3vnlLKpH5Z1+XG9VG8WWEuEPS4PlGya?=
 =?us-ascii?Q?TmyUqOVlEvzdvYqa+PcXJgqxmkdl8bkViPUxHYbV0ZjuGWTc/TPE3kpbTs9W?=
 =?us-ascii?Q?vdiGOc1GlAPnJFdL3V1BegcjRYZHvzHX0q3xsdEby7TB6hO/uvpAbhJQILBT?=
 =?us-ascii?Q?T8/muFLmeaj/v3IhhfMPJxLzdzL0bXutCF9WiYwHoFX0H8+DnPYil+h9tbjr?=
 =?us-ascii?Q?MyVM3UqKXxC9vEX7kvA6qRwuFbrIY2PU2H+nCGD8xam4XIbrj5LBCs5c2m1q?=
 =?us-ascii?Q?Gk8EBVRoPVPow1Idd7azLn3sA7dzQCG3AuPTm3m9M0GGtjkeEyZMybOEVCaB?=
 =?us-ascii?Q?QcBf+gflqG2PAZ2op0DO8TcbmOOLUlIvJM/KBzPqaoVVclesVJBh0c3kRxxy?=
 =?us-ascii?Q?lieYPRQoxnZh2H8E9Uyfp/pihpls7WgtgMVReM8Fe8BzTpO6vojo2LnLsDfo?=
 =?us-ascii?Q?1diwHEEL5Wc7ZO84UdOzVmJsbwhyWamdAP6kkMk+oit7+71L64oqfbgjWxRP?=
 =?us-ascii?Q?ZnAUKVI/TDRQR79SILRvrqf5h/SneWGB6NwPhJfV3t8LxmqLP0buCtK63fBg?=
 =?us-ascii?Q?1hncqxjrmriDmtEbMxA7onO8Qx8BPfJ942fx+Ln/v2h+SsxtHN/oheSV3kzK?=
 =?us-ascii?Q?tva8ftJdVLUBdGCuz0l7rGFDzWOjkAJKpfovd/xcPWl0hInaDRItkj2NCTQu?=
 =?us-ascii?Q?frS/1tna9mJDe77n+kr5tAZHkF6D1MPLme5p+HSA+sb4edBkdxcfo5fGuLjL?=
 =?us-ascii?Q?JSKYPOR6bcsEWXqPKgZ1/FJwun/WbttvgH+IUDN/EpwJCmJ14CSC/OUjlc7R?=
 =?us-ascii?Q?L7POKcC9gry/BGim7GYpbWzLvIpRouzv4NYufntsj6C+wjRTGBsCwwBsie1+?=
 =?us-ascii?Q?rhFtclImPIA1X6Gb2Zqh2hAd6L1JqilhYe3JL0h2f9CdKa71mcErlzTEIOtF?=
 =?us-ascii?Q?3JjozNkb4ZnOs1OfXKBnU7d6zFtI427L/w4K2WsKmMQ22uzep+DPfTHzUjNP?=
 =?us-ascii?Q?MBoRjLU5Y27558Vx01wo6vn+VvNJYf7Y5w8zWlSeVj+8TnJCJWS43iuYsYdd?=
 =?us-ascii?Q?3/LQeSHsddLZICPy4jYmPzklNQMMtZZjHx3xfPlYY6WOnu289W9zL/oie7T8?=
 =?us-ascii?Q?ifzEmJ6xTw+q0AsziHXG93gBfAGnHu9w6Lk4hreJRb4mOYEL2P4wZNO5MXCQ?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iMQ1leu0l6zcaMq5gYg8MwdJafGfmO+Tg8rkrUVaokUubVJfp6BvBCGHJAUcSJdggzUrpH69d1HTge/ZT2Y3zvxTm3rydZTtnTEsip83fkpYlGeiep+oecH4RK7PharPcQAf6gRT7rOyEZLg76t1VEADyR0RPTpq0r4JsMubT6kFtpS8sCLnPpDqfg9AKyUwlHbx+j1H8Y3V1xBlHfjJ9rI0Sv1iayPSuDgbMYGuVcG+0gjskz/N+2z1fva85a9Ici9uBjBpkanLb6f6NMPM5ycEzAL0HCOnvjfb8zd8CXk+7CNAqNFK/v2WbDvgOPhbTvkYr7sjK3s1IxGJMb4qAJMnIWq001L7sA+vUcerJDLHQRvJNrrmsZah6/hEMgH6IE6ICdvZW+mnvDGLMh/jkkJiG4B6xGtiEkf9AI5SgpswYxFk06HvN2YJ+Ae+m1oAxLfgC21aOMeLAEK479RKs5v3vOIGiu0Rdiwf4PnvaWFqeAocWaTLlB2zziRLlNoZrxgUNKZKYwlLe4cAf/KCYlFaKaqxlMbo3+1hwTudWUZpyRL1Opb6gCNVXIvSmnUOmKn60stzsX8cLzXtSa9M+wkygRStb2CN0xn1h9vtois=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb47ac47-80ae-4058-f4c4-08dc62da2548
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:40:24.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyU4QUJSaQShh/uz0X8SuIHChrzKdgWW4JnX4FDZqVPcC9M6VzKos8zWICuVqoH2/i1W16eHhi/cjgc6nppZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404220063
X-Proofpoint-ORIG-GUID: de4RcoK0WpeaFunLdETakunvmUYU-xgk
X-Proofpoint-GUID: de4RcoK0WpeaFunLdETakunvmUYU-xgk

Add special handling of PG_atomic flag to iomap buffered write path.

To flag an iomap iter for an atomic write, set IOMAP_ATOMIC.

For a folio associated with a write which has IOMAP_ATOMIC set, set
PG_atomic.

Otherwise, when IOMAP_ATOMIC is unset, clear PG_atomic.

This means that for an "atomic" folio which has not been written back, it
loses it "atomicity". So if userspace issues a write with RWF_ATOMIC set
and another write with RWF_ATOMIC unset and which fully or partially
overwrites that same region as the first write, that folio is not written
back atomically. For such a scenario to occur, it would be considered a
userspace usage error.

To ensure that a buffered atomic write is written back atomically when
the write syscall returns, RWF_SYNC or similar needs to be used (in
conjunction with RWF_ATOMIC).

As a safety check, when getting a folio for an atomic write in
iomap_get_folio(), ensure that the length matches the inode mapping folio
order-limit.

Only a single BIO should ever be submitted for an atomic write. So modify
iomap_add_to_ioend() to ensure that we don't try to write back an atomic
folio as part of a larger mixed-atomicity BIO.

In iomap_alloc_ioend(), handle an atomic write by setting REQ_ATOMIC for
the allocated BIO.

When a folio is written back, again clear PG_atomic, as it is no longer
required. I assume it will not be needlessly written back a second time...

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/buffered-io.c | 53 ++++++++++++++++++++++++++++++++++++------
 fs/iomap/trace.h       |  3 ++-
 include/linux/iomap.h  |  1 +
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e8e41c8b3c0..ac2a014c91a9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -586,13 +586,25 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
  */
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 {
+	struct address_space *mapping = iter->inode->i_mapping;
 	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
 	fgp |= fgf_set_order(len);
 
-	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
+	if (iter->flags & IOMAP_ATOMIC) {
+		unsigned int min_order = mapping_min_folio_order(mapping);
+		unsigned int max_order = mapping_max_folio_order(mapping);
+		unsigned int order = FGF_GET_ORDER(fgp);
+
+		if (order != min_order)
+			return ERR_PTR(-EINVAL);
+		if (order != max_order)
+			return ERR_PTR(-EINVAL);
+	}
+
+	return __filemap_get_folio(mapping, pos >> PAGE_SHIFT,
 			fgp, mapping_gfp_mask(iter->inode->i_mapping));
 }
 EXPORT_SYMBOL_GPL(iomap_get_folio);
@@ -769,6 +781,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	bool is_atomic = iter->flags & IOMAP_ATOMIC;
 	struct folio *folio;
 	int status = 0;
 
@@ -786,6 +799,11 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
+	if (is_atomic)
+		folio_set_atomic(folio);
+	else
+		folio_clear_atomic(folio);
+
 	/*
 	 * Now we have a locked folio, before we do anything with it we need to
 	 * check that the iomap we have cached is not stale. The inode extent
@@ -1010,6 +1028,8 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		iter.flags |= IOMAP_ATOMIC;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_write_iter(&iter, i);
@@ -1499,8 +1519,10 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
 	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
 
-	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
+	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending)) {
+		folio_clear_atomic(folio);
 		folio_end_writeback(folio);
+	}
 }
 
 /*
@@ -1679,14 +1701,18 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 }
 
 static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct inode *inode, loff_t pos)
+		struct writeback_control *wbc, struct inode *inode, loff_t pos,
+		bool atomic)
 {
+	blk_opf_t opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
 	struct iomap_ioend *ioend;
 	struct bio *bio;
 
+	if (atomic)
+		opf |= REQ_ATOMIC;
+
 	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
-			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
-			       GFP_NOFS, &iomap_ioend_bioset);
+			       opf, GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_end_io = iomap_writepage_end_bio;
 	wbc_init_bio(wbc, bio);
@@ -1744,14 +1770,27 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 {
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
+	bool is_atomic = folio_test_atomic(folio);
 	int error;
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
+	if (!wpc->ioend || is_atomic || !iomap_can_add_to_ioend(wpc, pos)) {
 new_ioend:
 		error = iomap_submit_ioend(wpc, 0);
 		if (error)
 			return error;
-		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos);
+		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos, is_atomic);
+	}
+
+	/* We must not append anything later if atomic, so submit now */
+	if (is_atomic) {
+		if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
+			return -EINVAL;
+		wpc->ioend->io_size = len;
+		wbc_account_cgroup_owner(wbc, &folio->page, len);
+		if (ifs)
+			atomic_add(len, &ifs->write_bytes_pending);
+
+		return iomap_submit_ioend(wpc, 0);
 	}
 
 	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 0a991c4ce87d..4118a42cdab0 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f726f0058fd6..2f50abe06f27 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -179,6 +179,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_ATOMIC	(1 << 9)
 
 struct iomap_ops {
 	/*
-- 
2.31.1


