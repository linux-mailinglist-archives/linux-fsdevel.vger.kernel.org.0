Return-Path: <linux-fsdevel+bounces-53644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F10AF5311
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1733A4F0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDC3276031;
	Wed,  2 Jul 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DXax91Vy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kR4PuJIz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F2238177;
	Wed,  2 Jul 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461642; cv=fail; b=dkmOByP9xRpBvS4V9l9tAU7dxo2u1gc3MsbS0h54Wk7BZH1mw8lLelXv9TbOdpoWHA95Gu2LzYhq6p+Zx1o2pYFom5gCPaO/C3TeA6b5SfMGJ1GpFp4Bdweq0JoD6vy2W6UvpAWH+rqhs0NynR+qZJm8OL7+8D3QpDQ/bFMzZEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461642; c=relaxed/simple;
	bh=WGER8LUzt/Gb3mH+SKlDjwXPQaRrkuZxbdJKBthXr08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nM8hjBY0RHUknFxpUmqfGr/X8tyCV0HSQj1ggqIEQCkekS9epI1B0aaQzQ7NPpamfDsnzKE6z4+U9ejs4vBFDRqW26I+GvsBMS4Db3dZgNItjSEyCilGuNgs80u2vX+RARdC/pe+M1i8aEy9fkEx0jX0+rkjE3LKEv2qQpL2LlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DXax91Vy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kR4PuJIz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BibQe027546;
	Wed, 2 Jul 2025 13:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lzI8nH2nT5zxZ3v870
	AXbPWZGlHJSJ1P327RNX7R3A0=; b=DXax91VymUqzRg5IdK1zFaPJlTHETi3+Z9
	yyQVPgnCE2DSUB6Lz5mhC0JzJmP2atEHrV5aryW3Plg6dwDM1+GMVfU3I2gIF7i+
	kBVsnnIO2LZH+LLBR03gJ8lbhlDjZZEVF7mz3VxssbWneAhj/gmZOZIEd8KEi7gp
	4TR0afDo1ACuMB9L/iPXnE2TQ+CINHuL0KWUV311WhgrwzE9IiWv7+rwhTeHZgM1
	my41533mpYYKSn6Jo3+tsqPCEcSo6fcQsmYcZzQpx/MC5jDHs7giNduljQuUzMzI
	eK1F+laIZa7OiRY8dxoCt1BC+/KqCePbB0ubbiApPXAnS7BR2aTw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766ex1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:04:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562Cgu2g027426;
	Wed, 2 Jul 2025 13:04:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ub60xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:04:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVJAiKW2rFWRE53hkQstoImCn0B3LYNK36FUfryGMIdMRXBJupf2m/A35Ol/hMqj/t4pbDHenpP084ZKmBlF5SpK5j3f/7G+E3hAOTBaqO4T1IaO4nf8s1h/mAYPZ4ynLESfaAwwdxTWO6bmlgiOdubPPwllPNNJjbRRfMtP4U5krPRpW5mJ0bykqRz52NKxfDRTfx3pU5x/D5wiwW8liZl6KDkChcJ3Llyp0OvOiUatGpgLi1HXppTWDhsi+p0YpjHNAw+8Jxav4HbrxjMrLpLDb2gIkwDcX9bjG6aSLtsxpaLY7T+s3tV1GmZx7dzSSkb4oenG4JK/oT/GQ4WMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzI8nH2nT5zxZ3v870AXbPWZGlHJSJ1P327RNX7R3A0=;
 b=jx4OCIlGZtsof1Vi7NPlBptUAL5ko/pGAd/7mbiUdMY+DisFYQiW5o5cUDwN7TKUI45XrITZmrwO45atGs//fWCI0gp9bmrTD6ZBgc8oyJD7h+kiMN2IkmrW625wd7BPWgiN2ptajMBNn3G24dCWt95tfEsEY37bBp1SMDzwN1EL+I/wAHOUgwAGYgu9rVdJt0mdTjKK/6+DUKPKSdt1odktSDMwBI0FwKUfIQG4rBwmiYcRdrDEKWAtDbq8mzCLSEx2pa59fFMo4sJed7fvViYD9UdZNRO6g7GPfa48tW1fuK0StjmLa2jtEFe/OSqQpBc0iF1/l65dt3BLO2IvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzI8nH2nT5zxZ3v870AXbPWZGlHJSJ1P327RNX7R3A0=;
 b=kR4PuJIz9EvaH0nRm+xdt9RzrTaaM1Qc+CNy76fvkRxFZVoxBGOmNwOduIYOPsj/6LGCcCh4rIz/eAhjRjj6pmDU/FIQRjhpnWyjwAffACvEqHy8zMdhs7oi/g+kaOPNd44TtbMqXABvyJ+MppGU5edC13htqlNUmm/ASHuKsf0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 13:04:38 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 13:04:38 +0000
Date: Wed, 2 Jul 2025 22:04:25 +0900
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
Subject: Re: [PATCH v1 21/29] mm: rename PG_isolated to
 PG_movable_ops_isolated
Message-ID: <aGUuWduO--jv-yif@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-22-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-22-david@redhat.com>
X-ClientProxiedBy: SL2P216CA0176.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::23) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5915e4cc-2a34-4212-5ef8-08ddb968ffcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jdqp2B4m6J6O1xUdV/xkS8S4FSrM+LY+NO5lJVz8OlPdxVnNYUEO+JjrDOuE?=
 =?us-ascii?Q?CLajrrKND8kLpuc1x+4rdE+wa0jSqXxzKfK2wrpNmGXIc5DBV5N9KvyNjhms?=
 =?us-ascii?Q?Uvq726IPVjTYOMMMkwY4kowQbxTvvRp0hfUE9v8KnyG0m/aysnq07SQRRXhE?=
 =?us-ascii?Q?gnir++HDnDdy17OJIPH1qa3MzMef3o9ZUH9LyI1SaZ8SCFYPhPgx1ssEYoTa?=
 =?us-ascii?Q?5KMXpKBQShfMThtY6oybAWrxnWh/YXYd2zdv59UIQlyQVOw3N7s+zrhns+FS?=
 =?us-ascii?Q?ZyRR7GU5JpCjbXQfBTR6EQu5wGc/XDzW5XhLNABFXh+fbZFBVPkpqzWACRzk?=
 =?us-ascii?Q?IkzKKYGacpa68+bWfA9aXp85/d+C0WZucCO4cLzSWyGIaY/ecmXNqIT1+UjD?=
 =?us-ascii?Q?PdT4VRFYk8k0zq359ukNWxvk3//iHm8klZ02e8mqjG/kwRYm5CDnZGD46q6P?=
 =?us-ascii?Q?bpNITg/pHOB7llj9ULFHuvdDzCgv5y2JR6A75gwAuT0Hz+uSrvJ2o29AaUWn?=
 =?us-ascii?Q?EUMRVWBoMV5dm22JuODnb3pZFXvRxqA1Yev09aswvceotGrft4wvVpI0o3wQ?=
 =?us-ascii?Q?053IAXL11mA0LKsi5HsOdObQm2Kk8h8JzkYxYXRTSrOgu+eaM4YgvFIp7UZA?=
 =?us-ascii?Q?bxuGY0WjJP6nTQajKJkD2Y1tGjM9GbCcPEdp1UG3JveAdyYAD/y8H2bpQH+J?=
 =?us-ascii?Q?TTZPKlxQ8RWm5CcC6MZCAqyue9MlNGMlMRv2hLTZXfq88e7McY1smp4LPeg2?=
 =?us-ascii?Q?mV1bovbtkY3ZoOkKyfabeh3v9dvU3Zij5lxP2xBklfjN8HThY/NdxDSkvLC7?=
 =?us-ascii?Q?JDLutcYIa5SgsaijYaNF/TRqtH7AZlVIWtc0UCPdkyvzZ9K5wzK7WcxFx4cF?=
 =?us-ascii?Q?1D5UThOv6UZUVruLTBTIjHF4rR8/cL661psFUinybFDoRHJDHvWB1YyJBdvw?=
 =?us-ascii?Q?EHgEOuO03p8wosupRWDuXOQCg6KSf3rA2GK7rz4JwMBf62QkRiphWPUfhHQs?=
 =?us-ascii?Q?6+zHD1E4U+Ny/oTQKmkVIQDhBddeOa6Yy/km4bJ4H2PnQK9rXi0+Dt49Ndq4?=
 =?us-ascii?Q?EUV+hgj0XubE5VuAi66qkXZFueuFQWGJJzOWBARiIpaG4w3mO/8nRmdqtwHy?=
 =?us-ascii?Q?oMrMnXdG81luO2C25Oic10uRfrFl4sbdxFryLJPAwS5ac869tXkDACtGz0KN?=
 =?us-ascii?Q?Z5eSJ+1GAxNeMhECE4/VLufrhwniiV4xqK4tRPuRXftcIby5+iNnMRvDaJUZ?=
 =?us-ascii?Q?grLTxeFfGpM0qhdBMnHsxZ9PNeqv965lpxpqulq24AKZ96g2+Cm54vsWMvNr?=
 =?us-ascii?Q?EbGjoAsTxDCngOeyMzEaamhY3SkPxbLzh/LFE2qpeLjgCEY+qVcb8boDN14W?=
 =?us-ascii?Q?w5wvJ79L0JrfUkXEiNwGl4rv0cCWI8HSqN7S1mWm1ZNST6IR5XrTbpzqhYI6?=
 =?us-ascii?Q?Xk02FSu0fG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w374l33kvUujDCgF1oCdHIHR/S9NXwhZWKDblqj1/LCaqNV9UCuOQFZeNh6c?=
 =?us-ascii?Q?aT5aMmx78kj1lIBEgjWEZoGTq/YLfHf+9DbXqGQ13Qp4/4b50OX8vuPX4004?=
 =?us-ascii?Q?7fTfMUzLtP5tM5QkbOryHM9O05cMY+IMu3wdq4hsYlA27HX0T0lBTuHXkiMn?=
 =?us-ascii?Q?epgaCKiLsRmKmwcLjrmrlp5a90wonsq5cyX73qY2x0/KB5rLbGjeCc6n31/x?=
 =?us-ascii?Q?pbHDbI+9NwjLRhhEmlejpOH/oT1eAnfu1EX4BBfYLIn4BNgnaNuGKQkOonGK?=
 =?us-ascii?Q?Rt3Rref7/SU1dNLYHFct7AQ2tMvjhzPY3F95OT7VLWdDOtSO/0lYEJGZ/bx5?=
 =?us-ascii?Q?1ufoRofsUc4zqwpeIi8IPr65bfJ30DUj7v/if6zso3g35jTKKJHXj2wXeyb2?=
 =?us-ascii?Q?URnuevtpx/kSDXpgaOxwiJShxT3lYG6EyQPTo/392uHVV6FTNAJG8ImHrM7L?=
 =?us-ascii?Q?W9Yq31CxTdwQBf5pAwCRsyiYfOeHznMQAF7Q5D2ahMoE7ec/W6NBtPk6fbfs?=
 =?us-ascii?Q?oNnm6+JNd0qtPc6qXmQ8jlEjAxZqLCpjS1pDuTaC5nYiKliSnh+MNHFNwnAL?=
 =?us-ascii?Q?DVY+dJ4LtdlI2SIv8s8N/T4TZzKHVM2sCPDzRTZQKTDeZmS4CREy5gN3bmx/?=
 =?us-ascii?Q?thYQdasH44KRn9qOwPMEfoJ/MkCi/4+pFOYPQkZZz25GsZBbzYN8dU283JI6?=
 =?us-ascii?Q?mhWpIpb1xb03NiBm2NMbo+8YHiADVfXo2CZELYa/mQZa3NiD3556XcftRRyc?=
 =?us-ascii?Q?jxeydAhHtPPcnna6Q+qNwMo9oLu2GY/dP81C+NssE68UIc5wCZ17FZsgkqgf?=
 =?us-ascii?Q?J0tZ4nN68BuU76qN8Ic4i7V/8OpZZK9POSyz6bPSaCSuTxnwXNCYrdyqSriY?=
 =?us-ascii?Q?UNql+qe/06XIvZi9MNWNllBGu+XYhS7K0cweSIB/EgcWZPLl6m+aXFcAweoZ?=
 =?us-ascii?Q?HQh4R5LnALwXBeCL8dOXsoi7mTpCtbKgOubXrNcbK9HymaXHmUGU9O7Jdw4B?=
 =?us-ascii?Q?tFt9jDrJTvHRCH85Rch3tIc8vYakWzThCVVUHh0gGUmbe9MKBhRue0II7nu7?=
 =?us-ascii?Q?syXenFUzlwU8F+u1LgBqdpBJfLvgn1tPdiEdwHT+6xXZv6jjmQxPtlzat//d?=
 =?us-ascii?Q?1hBWiz/TKEkn3C3EM38mVTGjoGT2S4kyoaTNsj6Jcu6V1CATzD1jOuPnZihq?=
 =?us-ascii?Q?yjTVABrDlrgG5olDMZJIUOZtvAxq7zzzLnomNCRvp72Fa97lOi+hAFT6xTQA?=
 =?us-ascii?Q?zMw3EBgERkd/64YUvE7XrH8EMqldqTV2fsu02pEdb15N7J6NCAEe31DqOuTa?=
 =?us-ascii?Q?SHfdL1PaAM273mFmLvZCRkn6llQ6j+mVHXEVe1gLDDPehfbsgas+OABJjByF?=
 =?us-ascii?Q?QbcqnejyeC6Vj5d4LUVsWknshyujI9b3RpEjYCsemQGBc0nlv246V0Bvo7Hp?=
 =?us-ascii?Q?T8OxW522vQQkMwDVvKzNG3jCQJ0gxhZC8xiY6hvBSyhndk66wnHsOKLdWexx?=
 =?us-ascii?Q?4X2yh2i63V9F55rLb9YHgvCVVAwajpCZD6DW31mc/06xjRryzBN2b34Ixdfb?=
 =?us-ascii?Q?X1cGPLNqUcruMmqjU3qcGFetlRDHUOQH0CAZagqG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jI+fKxxdabmaTxXusq6lxQ34te5NFVDJThPFeLq8QWPgLTMdrIqFNWt5xtTj0GXaaA4dHIqsm+jIHEAwO9mtVDoR+l4W5zmO4uB3iFKPHFtzUO92FleyGW8nbwYwNEylwT0jvgEWIrcf/PYwc7ehl7Xf+bSRHWCs5Jr3t6sYTL4O2vEa5/JJg0KPmM8Cy4NxVUhVCpZ8Q4rxjNffj9qncNzL/ldZqII1JZJGtppj6feWceXT0c6LUy0MGMR+jZfqAot9xALxgg2yM4nknat3rOhdtxT4gxG3nvUVh/Qdq4PNHGuEL1eNHagMMOeC34b9Jn+hqQYgYppMuBU13h0W26W5AUPhfx+L88dKcR+LS2611bmPIACMJRuJdzGBdpL5tFeGoJdI/Z4uiCQCWngox2u/pb9ft3f6RF8gOztGl8zuSPzEOi7p1ug048sCqPwI/9zJADhUowx6VsxX87KLYdBqLYVrR0dMSFPZuQHTRvPFkbl5Fnmota6/JN4i/z+5da9EGUazSWOBfOKkhinOtujXuOeyD898APX5kKp810xUGnNg6Qq65IVJhJzzPwLjkH+MLb0AbSlSob/G+8+4K1BHbwp+I/brsT5itcn2Ej8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5915e4cc-2a34-4212-5ef8-08ddb968ffcf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:04:37.9457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjJ5hC7qoj+RztFLlxHYjpq0V/eKjPx9cajIYpw+EqvX2r3yxGK7pABhgrANHzATk5+l3bOJ9Nb0blWaxgO4tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020105
X-Proofpoint-GUID: lGPksJUSSeZKtcxylntlTvTP7yxfaOpz
X-Proofpoint-ORIG-GUID: lGPksJUSSeZKtcxylntlTvTP7yxfaOpz
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=68652e6b cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=wZTv8dqgbvEc1HQk8AQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwNiBTYWx0ZWRfX0RTmgbqxslaS CC9G/c2GyxDZRvsIj/FQQYo/30aYbdWZnamZw7jk4Nh3O/LICZ82vxTuDik0d1BfeSZZYi56kxn TQG6YfyFbGqiWzYUr/zF3Hpdg1QhEbrV6SYJ9O/DBnA3yBl7wu9zECyqtHAfMCQUni5p8qT+Udm
 regXQ40B4pdQwKa70xq28l8t4/YmakA0ysa0M8WrqVOIGKKXbWRM822qZORRAnWKfM6yhcq6rF5 wteAUo67jUkEpXUfpOrMu8A2xrtEK2ialf6lycgSyGSm3KTuGakBZ9NqOgS/3KfQjE3AcM9wg0N MpKha3eql0di4K8Z7OkytziPPun61PXjedxKx/x1gcFOzAEmW+sTcGajpb3F3xxT/4r8FBMnp6N
 qNJpvQs1S995QOMY1wb58kn41eJyZBwAiz1QSNJVYXznvR5IBiC1ktPqHYEO2lfyCcYanYP2

On Mon, Jun 30, 2025 at 03:00:02PM +0200, David Hildenbrand wrote:
> Let's rename the flag to make it clearer where it applies (not folios
> ...).
> 
> While at it, define the flag only with CONFIG_MIGRATION.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

