Return-Path: <linux-fsdevel+bounces-31709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0065599A462
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB5C2855BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934D2185B9;
	Fri, 11 Oct 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VxDZKwg2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VHPhN9/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F220B1F3;
	Fri, 11 Oct 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651951; cv=fail; b=OgkxtNS1+DQ9AXaif/ZbdT1kgKYRBTZLcOZe+rS5L8sPe1UzVV7oMg/wCbVLt/v7C9Xxv0idEgsU11g7SCFx5Vd/ciYSzlYjQNYd30P4DNDQkqyRnNt5PbC8NM2ct9MIVLj/yiCBQvPSIgDMh+QEO/fh+SNqhk940jmMfh9exe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651951; c=relaxed/simple;
	bh=6PNXI6UvFK5k97YGScUb0ryvdrqOkpLhomuEWIa5aEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tq1Z+2H/h1yOGnJ2dvy5wNfE5+Fm57o0gDXQ9WaLAE6nRCcJh7NtqANUikaSOUF5L+E+nGhkwpDR1M5qEEYhnCR8ZHAIxpaG89jTOzm5Q3yjeoDiop2j9m51Qlq96lWZPLKtD2K1tgcrqNCjjvQ48smC8ZZF91UVTEvLIet60go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VxDZKwg2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VHPhN9/9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpXD8010297;
	Fri, 11 Oct 2024 13:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Xv7i4twWqZ2nPErweq
	HXYV7ZL7AqvC/N6Aol1iMSENc=; b=VxDZKwg2BSkEAJCex17nsRFY8J+x1bNfEH
	D588ObM8eYNw9/RwFmt8rAsDzYnT/fmpELXqlmrVzs2kI8sOkoaA92pP1MvZ7Wyc
	PDWrl8sHJp1DkhhMNfwQWeU9PVn525mp4QvpgXOUY7EvMNvssNQoG5/oyHu1CBlB
	iGOrJe8E9lLe4FV12pOn9kjtllotlZ3qp33ZqKISmGT66/eSeaN9p98zplPoT8Pr
	plFwlXDSEOpwG/Uc2IliHWssnZOWgmzRhSe/4b+8pZMuLPd5UKbIhmbidp2Uvo5f
	VeZUp7oNaQGpyS/U0CoYTuyFUoR4q1voEg7B/mIJfsf5uhfhC2ZQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063vspp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 13:04:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BBYLYb040247;
	Fri, 11 Oct 2024 13:04:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwhmarc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 13:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/pa+BXukbV3KIhccmtx/vO7TJeTotJH3kEBHIcv/+ebUgaiZim4twyls7fnN8BIRSNJtaVQMJ9HpMOCXItXHrQbS7ed0ygoGMlVzUj6P0AnPihYgtP6BtfaJKueBMM9vcf6HTK0ky2b6+2OQyYBHuX8VQkLtmiOFBonq8yJe7P0qYpTNcN5j9W4WH4kAyr9nEog1qJUfE+bsMLzPXjahu/pbNgYqBxSL0gYhqvKT10JXvOaC1eoZEF57E8H7VLJpwz2paM+eRuKRLb8pdYjktivIw1fYo6A3qpmVnXjcSj4rgS3MhVmWI6+Drlc80UyWp4EU1DezXCp3W+MlScW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xv7i4twWqZ2nPErweqHXYV7ZL7AqvC/N6Aol1iMSENc=;
 b=a6Nw6dysBt37/iB+zOlnaACPfQ4Ye/oP8bQgueksTwtwsbAPaEo8aLg8fweNEbyWkTwT5IjC0GscH92DnWETHdS13VZOtIQpTZ24uR7d3A0irB0loBe6Wz0l8kgTRc9KhtdwULiHBbHkL2mSXxSL8sZpsQ/Z9JztrzVSXd5XDmSxgN6lAEMEihWza8qAq+ak214XFveA2ZegmkmwHUn6j5JD1p6jcfRXKMSS41rsef30O/KWvJGvREDXU4DgCaKRxwdYR6v3p95HOgvQlxcyD4Tvvb4DryIoMUXKgYVmFl34Yzz+r71NrUqvzT3V/L6MDrWSzq7AC05gc4JDZgnn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv7i4twWqZ2nPErweqHXYV7ZL7AqvC/N6Aol1iMSENc=;
 b=VHPhN9/96f+SOxtndT6MDFzuEDl3tS4DA5/7uHPI1rXC9eFkAgH72rPh+LRwVczv7MjbtDVyBcJxuvGfrwsaZvacqATw7X2mFrdicfUjOTrgtptMW3LVD0Cb7MQaIz4mNFKu3ayvelGvQImGXLyrOBMYaVvYCyV1YFgW0a3KxYc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 13:04:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 13:04:12 +0000
Date: Fri, 11 Oct 2024 09:04:08 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, ysato@users.sourceforge.jp,
        dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, kees@kernel.org,
        j.granados@samsung.com, willy@infradead.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, trondmy@kernel.org, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com,
        shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com,
        souravpanda@google.com, hannes@cmpxchg.org, rientjes@google.com,
        pasha.tatashin@soleen.com, david@redhat.com, ryan.roberts@arm.com,
        ying.huang@intel.com, yang@os.amperecomputing.com,
        zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v3 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
Message-ID: <ykseykkxta6fk747pejzpatstsf3vzx63rk4gayfrh5hsru7nq@duruino6qmys>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kaixiong Yu <yukaixiong@huawei.com>, akpm@linux-foundation.org, mcgrof@kernel.org, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kees@kernel.org, j.granados@samsung.com, willy@infradead.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, jmorris@namei.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, 
	shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com, souravpanda@google.com, 
	hannes@cmpxchg.org, rientjes@google.com, pasha.tatashin@soleen.com, david@redhat.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, yang@os.amperecomputing.com, 
	zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com, 
	wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20241010152215.3025842-1-yukaixiong@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010152215.3025842-1-yukaixiong@huawei.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB4822:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6501f8-e6a7-433b-5308-08dce9f533ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ku4B4DEneJi+OHNBKD5p7U1uHaSCfFQOGqJCUb9jCDui6F2QHDeK134U4DkP?=
 =?us-ascii?Q?ER8LZBv97vJv/nTbvtXX6G8EVt+/uR4DB+4yWA93qgqSiaRFshSHxodN2nTM?=
 =?us-ascii?Q?AxR++gQIwwqVeYmFumtt1GkiojVrkkwCIbmJ+XGamKPXlaKDr6l7OZlFqfT8?=
 =?us-ascii?Q?gC3840b6Y3IoZ51boDWXuLvt9KYQa+shJX7Cf0BOM9w8UzUO8T1vj+HyVJBe?=
 =?us-ascii?Q?56YpanbAjttEVobUL5D1D7Je/0s+zPybrP8jIVr8Q0f9YfDqBrjUV5y6FHkM?=
 =?us-ascii?Q?On02DKuG+okxB2ExetnEDxAr9ITvaVL+Qjz4PDiMY37UDf5y8Uw1zG9lSeOX?=
 =?us-ascii?Q?rrB29xQjJRpDNAdB59llEho0fefZaZyQqtRgqJIeGULtGHuoFDmkhRBzQG6v?=
 =?us-ascii?Q?ventSjWMQHTFi4u1kqu5HujeK8T1sD2TPtI9o1gYU0CLORm+IIRL6n9772it?=
 =?us-ascii?Q?JAHpeeObyyM7vacI2E8VcXaT+8rmJKdgbKPImyAMoKs3jYhs2bteYDn7garU?=
 =?us-ascii?Q?HXdB5rS6TeNUPD3ElxY8pwNRYyx4yhn/4dJJTuhO/NY8Hj72trllXgnaHFJK?=
 =?us-ascii?Q?6B2KeUqL1APhI5RwflhhSZvkMdUsiW8ZXjavZzvexVi3SjSip6m1tACxNpah?=
 =?us-ascii?Q?SI72XqAxxHOAA6Ze0RG8TXeGKbgbukrtwKh3Xvj862OJ9x1pxtwu4pGjIDT0?=
 =?us-ascii?Q?AadxJBHBmbTDaXp550ZcIVe9kgsn++80cVfgo91a8reyKGnv2mvCqsIwWNGu?=
 =?us-ascii?Q?0/13XPy+GTT7de0FdXHfbwhYB9395BDMcv3nbfdWgfH74yDaQGrt504y4MWC?=
 =?us-ascii?Q?otiIvTkoFbmrRNTa7cpOUncjIpvnWli24k8MiXmp5aPsIZo8ZDDrWCZ/Roqy?=
 =?us-ascii?Q?IHtSRMswmqvZy+SfwoyeN5607oovHGquGHNSuWr/EQ7JLzBEU5GObzSkpO/O?=
 =?us-ascii?Q?7s2zPhnnO1YcvmKZZYO6W+FJPmc2xEZSkGUyjg1kgZrf8p0b9BNxvD7P6XX+?=
 =?us-ascii?Q?U1f4vFVjNtTkm4tY9dzHL/K3TTDgEByuMyq4FTMLuhOJRuGTSkXNkaA0uRj5?=
 =?us-ascii?Q?dthkHQ4JtUPLTKJzAI3lxWcQApy4mfTrST1e5WsVB340mBk8SwnJj88zSlCQ?=
 =?us-ascii?Q?pH2DTQeByWi21G2muEdKU4q2dp3mnNXuTCm7Fz7OS1o8UzhastLwSoAg7n64?=
 =?us-ascii?Q?Z0Lvys1urM8OtbtdlbV8nvzuAIrQ4mY8XN+BgKGvnc1mT9SPaK1h/KONAlbt?=
 =?us-ascii?Q?qKSua4lztpSnM9xAea8iqiUGCiFg3TthPpNWz5S6Wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PinfTI1DIDAf/pjKsYAQ+5RW44m9+3jd6/qPo8987Eqz1vtr7iJqDBeHiGA4?=
 =?us-ascii?Q?+9E1ady++9lHfLm8dGPnw/Ra+GH1KKdaK3COa6VE2/YrJoREDME4c1V1/kaU?=
 =?us-ascii?Q?WklPDjdQ0WNxVAXuW3mXNwGFQLa/jNN5HSWHSnlZdWiAqy8YnO1PWm84AfEN?=
 =?us-ascii?Q?602hP53Y6XJAiLoi2FUSlwBnKTmWB/q72bad1S//i/lltRnAT2Waxwo4WDWT?=
 =?us-ascii?Q?KQe+tDxpziaOvGZdjFQRHDnCfwHCnlxNsKKKJ+Eke6XvMA6v92L8OptVSPb9?=
 =?us-ascii?Q?GSvzUv904URj9znMD+zCh4Vu2HahY9H2mpNFRQe+dv34pmbDUn+8VUOg/t5v?=
 =?us-ascii?Q?IpvG2T7oojpyKb/AyD03KdQgcFQebmrS5rDXZfvXbSwEfbgOO9Bdcq1Epwrb?=
 =?us-ascii?Q?1JhNF2b32ykjZWvZGuaIU+GSARTLHg9Ht5hRz3S7LsWdaqpQKtcX4D9fnebj?=
 =?us-ascii?Q?afDW13DwygNLiWnrGs8T8zsZMmO5P9WEsOpx0s97kHXmK0Bnh+cqm7j7Whrl?=
 =?us-ascii?Q?5iC06uuD2JH7b+zOmISMHJwwXgK2m6m1TvWw7+udZUEV1raSoGWlB07j/JAy?=
 =?us-ascii?Q?zMQgwUZrl5Gm/ji4OIDS7QBDx9vWIehX/po5GLsZdl4ZR1Oj1K+c5FxWNXa4?=
 =?us-ascii?Q?FIjAOMoik7dnNzSyQuSVnp1bNxPocLA7eD/e+poPPP5FBp6UyDtV3IzhA9CB?=
 =?us-ascii?Q?sAowmEVzdc2yIEUzWTv0G7Q2AAt6l7Dh0CK1ykKs3trwRhI6d99aohAKaSvN?=
 =?us-ascii?Q?M9o2Crk7/6UGid//DePHqjKX4vFbK7+1PYLE08YVLawR8pJquUPNNr2LHDFk?=
 =?us-ascii?Q?LSAhjf5+59u7O+oquqK/cEwopHy8vheJQH++e1r4oaM54hudhGmD9pZA4IvN?=
 =?us-ascii?Q?c2yI7NGbw9pSFs2BmbkHiuKX9whyCW1Fts2dJ1V+faIK6RuTq+qNNBhNSiC3?=
 =?us-ascii?Q?39DDrtHJCf7uHA+tXMJYVdIg1Qgi21j3FR6fIveabHpU+rqQkeNsX4WJFlU9?=
 =?us-ascii?Q?NOlFr3oUhGZhtXlRPRxNoi5gJ7HwbLhzkH3AV60No/OojPUDPhbPN6zWPTvo?=
 =?us-ascii?Q?AFE7616X6EoUK7RjDDBlL3f7o9SIQLUuJMRZa+KMMYr4kl9EpX1t35OlvRnZ?=
 =?us-ascii?Q?JJXuqtrAL1szaXdRJgGTaLymGtbyFOYEHAto9P4geq2a6oytOceZQWJV3cp0?=
 =?us-ascii?Q?FsV4hohvX3OvyhHAgykA/KlWB1tznBd/SwQ7OECuhv6oZXz2RVCOKVnJJXX9?=
 =?us-ascii?Q?W8MNXIw4L4CgXEU1WLTYLB6HTCxYYgXIed2VsqAqO2mXgIPqoZjD2znAEUGk?=
 =?us-ascii?Q?ogwqXZKOyt0i6vgLgTcoSW4QdzXn6yKV3Q87qwqZSduJfZdB4aDAETdpYm0X?=
 =?us-ascii?Q?L6v56wB6roDmuUioHaKQEW5vSwHEv0+IGB9cbK8oEXmUwUT3GaM+rx3x773w?=
 =?us-ascii?Q?FdKfBdwt1NPSqJ7nf8MtZFogbeBqOZ2RtzfJGbXauyxYDBi3j9MxYUBbhL+K?=
 =?us-ascii?Q?eh3eVr5lGg5sMm5NGq2O6t6rUlQhh1hrTHeFbrmhqyo8qAFX8tTtFgFToFLQ?=
 =?us-ascii?Q?gGQvYL5BjaSC+dW8qkk41WSjfdAjTHm7EIrbV7Ao?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zJYIfmwhgHfO176yTIsZD1jAFhn7zift1SJR9F4VWhnHe6hQyre9igRUu8mvrIq3nrTF9t56XndoZ36Y5MU01ep5habnE5G79gPIEBcjkVHygIPvKoCwB876wAyuXNhA8+BeWfZKUxvhFeYnG6D1VvN80l2OJCXkh/vSI4gOoOX65nH2ewhkThJhURQljs6UXRLbvbPwYxwXjuyR3BtYvMnbt7nycLUMrpQv7o3PM1ot53V7vSu0SPbaCNC8YWUJrkyUI45VVJNjy9/q170oD0X/kBJ/ez+D4Shd2tBrJtzBVbyYYHbQozUf6IfATKqV3KD+QPiMn5uoyLxJfwYBoZZFgKbWiAgacczKVistIsRXFOb2Ln4qAREzrcqCiLwOR5LuWpR89DORciACZlqm16fO+Mx7D5/wwDHcRiBOxcEEG40kqBzw1bSFyA2iTedSLo1k2d9CibgIz926IvzGxhu4ispLV1nFTYxkzjttam50W7VyD12gUvy4C6RFp1a8mJ7nY2ERroL6FDvkKRhsR+FYcEWMUBYSq4YkVOd8A7VZ+oCV7rd5+nqabehimhmmv+l5T38HRfhoK9IoESyQzJABcsGWM0x00BXaUwhfyxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6501f8-e6a7-433b-5308-08dce9f533ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 13:04:12.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ux76YyiUINMKGS+7t5G/jaxHBRXAKaGg6XhORb6/Cnf6okUMLnzlaYTPa9JWicdMzhFnAe4ftqi/legjabGtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=808
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110090
X-Proofpoint-ORIG-GUID: AwLEYMl7R4QnbxQLdIHoNoaOCHWHMGly
X-Proofpoint-GUID: AwLEYMl7R4QnbxQLdIHoNoaOCHWHMGly

* Kaixiong Yu <yukaixiong@huawei.com> [241010 10:11]:
> This patch series moves sysctls of vm_table in kernel/sysctl.c to
> places where they actually belong, and do some related code clean-ups.
> After this patch series, all sysctls in vm_table have been moved into its
> own files, meanwhile, delete vm_table.
> 
> All the modifications of this patch series base on
> linux-next(tags/next-20241010). To test this patch series, the code was
> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
> x86_64 architectures. After this patch series is applied, all files
> under /proc/sys/vm can be read or written normally.

This change set moves nommu code out of the common code into the nommu.c
file (which is nice), but the above text implies that no testing was
performed on that code.  Could we have some basic compile/boot testing
for nommu?

> 
> Changes in v3:
>  - change patch1~10, patch14 title suggested by Joel Granados
>  - change sysctl_stat_interval to static type in patch1
>  - add acked-by from Paul Moore in patch7
>  - change dirtytime_expire_interval to static type in patch9
>  - add acked-by from Anna Schumaker in patch11
> 
> Changes in v2:
>  - fix sysctl_max_map_count undeclared issue in mm/nommu.c for patch6
>  - update changelog for patch7/12, suggested by Kees/Paul
>  - fix patch8, sorry for wrong changes and forget to built with NOMMU
>  - add reviewed-by from Kees except patch8 since patch8 is wrong in v1
>  - add reviewed-by from Jan Kara, Christian Brauner in patch12
> 
> Kaixiong Yu (15):
>   mm: vmstat: move sysctls to mm/vmstat.c
>   mm: filemap: move sysctl to mm/filemap.c
>   mm: swap: move sysctl to mm/swap.c
>   mm: vmscan: move vmscan sysctls to mm/vmscan.c
>   mm: util: move sysctls to mm/util.c
>   mm: mmap: move sysctl to mm/mmap.c
>   security: min_addr: move sysctl to security/min_addr.c
>   mm: nommu: move sysctl to mm/nommu.c
>   fs: fs-writeback: move sysctl to fs/fs-writeback.c
>   fs: drop_caches: move sysctl to fs/drop_caches.c
>   sunrpc: use vfs_pressure_ratio() helper
>   fs: dcache: move the sysctl to fs/dcache.c
>   x86: vdso: move the sysctl to arch/x86/entry/vdso/vdso32-setup.c
>   sh: vdso: move the sysctl to arch/sh/kernel/vsyscall/vsyscall.c
>   sysctl: remove unneeded include
> 
>  arch/sh/kernel/vsyscall/vsyscall.c |  14 ++
>  arch/x86/entry/vdso/vdso32-setup.c |  16 ++-
>  fs/dcache.c                        |  21 ++-
>  fs/drop_caches.c                   |  23 ++-
>  fs/fs-writeback.c                  |  30 ++--
>  include/linux/dcache.h             |   7 +-
>  include/linux/mm.h                 |  23 ---
>  include/linux/mman.h               |   2 -
>  include/linux/swap.h               |   9 --
>  include/linux/vmstat.h             |  11 --
>  include/linux/writeback.h          |   4 -
>  kernel/sysctl.c                    | 221 -----------------------------
>  mm/filemap.c                       |  18 ++-
>  mm/internal.h                      |  10 ++
>  mm/mmap.c                          |  54 +++++++
>  mm/nommu.c                         |  15 +-
>  mm/swap.c                          |  16 ++-
>  mm/swap.h                          |   1 +
>  mm/util.c                          |  67 +++++++--
>  mm/vmscan.c                        |  23 +++
>  mm/vmstat.c                        |  44 +++++-
>  net/sunrpc/auth.c                  |   2 +-
>  security/min_addr.c                |  11 ++
>  23 files changed, 330 insertions(+), 312 deletions(-)
> 
> -- 
> 2.34.1
> 

