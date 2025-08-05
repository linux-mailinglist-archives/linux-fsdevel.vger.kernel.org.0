Return-Path: <linux-fsdevel+bounces-56774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDED0B1B732
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 17:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649D5182184
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 15:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABEA279DA9;
	Tue,  5 Aug 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dGisaU86";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w9dIjqjz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEA2797B3;
	Tue,  5 Aug 2025 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406564; cv=fail; b=p+v/9WIclk2MMXBNCJzP7nMscglIa7iKuZY3QKI9ENxARMIVCLPDxIppqIgNfpV0T9vAZH4oCddPYqGUC+1Oeh0FhsZNYIHOOKrrU04ziz56oLVNS9oX0jdwxuQtl+lSCYmlJ/QDc9PVsjORuIgs57wBSUMAKS9rdVBmghgy1f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406564; c=relaxed/simple;
	bh=7iR+S12t8Ez892G7+L41z6AXh/HitYwHTyCIG8a5W9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/hhk0TrjCcCo4hJefXrHPdtDbZZK76CHPnvT/I08Rg/qCRZJaCTFqmhmkxazFT2Sy4JhFAgxD0lDFyA4/yKW8h5UIn2bFep+t+7zdd7iqbKkJlXXlNYL8j815cCsAAlK9Er3jUaioe2S7W4IeygWaEH0xfYTCC36BRAV8k8CFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dGisaU86; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w9dIjqjz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575EpUpD027077;
	Tue, 5 Aug 2025 15:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=juJ5MV12Yluo29y41/
	nC5wR+fL7WFB7uCkhxhWrCAdU=; b=dGisaU86gSlDFQ2r2YMWMhH+J1Kvsk0Drr
	O1lYDH/4Tkt/kKMcA9SDUsxZE32ooaSWh2X/9VjR48clT+Yc9vbShwubOj33iAk5
	Nukud4TmG7YP3Ni82R7v0r+Oi9wIdejc4z7UGAQbTZWZj8VjQ5NNyQ/77cma1deK
	rUrSbSzKgWXB6A3KLyo102qvQCnqYP4dXHddsrpKRFNKiK2fFnntkQxmA4f0PsI2
	bWxabATkySecXn+nQPSHfM+4dvhSCwgDW9qYI2uyVuluyy2lYAMMgivDsEqSK5WZ
	j5W8lt126BvxHixwjPahUzgetpQdN+oP5lDb++x7LgWdW0c2zzig==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4899kfd2tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 15:08:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575EkNvM034633;
	Tue, 5 Aug 2025 15:08:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jxbsbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 15:08:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBBkuFCEjYcg2jZheFlez+Ab2eaZ3S4qYfzhBfAF6q9QaBV0PFEzvMtP9mydA8GnfkMW13D5fUqcdnu0wl1M3Jd22a624ZxjsWKHBuPG33QtyNkdQNsnhHERiUk46eRgfOhmDoiXeKiZsBoNGIZi97RiYuFDG+mGpRErlsnsVgK1Ya+kaNFj3rHtncSXFuVP2sot3a5qY+tr0HTgegFeuKD1L10ITu0sffhFYaUOZmMZ5oYECCU+2Mc9N+3uAaUnQX7shOmL5HLBSZ/a+lXTLjj7HPcYBk9gpHKZUe2QEa5PZZcxHhBRov3CP9IojyXFsDR7J/uGXd9EeWgbL3sPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juJ5MV12Yluo29y41/nC5wR+fL7WFB7uCkhxhWrCAdU=;
 b=J+ziG6pYLOwY5pmwZ4KodSfdx8KPYou9ZYCTIdeJ7fjxUnTDn8iGpGI82shAPacMEr2xYQr+omB1R0euN+M5pCI4KS/Vt4WgtQ7Cvj/6oHag0wUMH7/IPgDKmd971DA3VXiE3C2lIbKwFVIlvcF3N3/D60bW+Vk16LMseoH2yL4tq9O+PsSL8cDe9ZgL5LyqQRAiICYAxdfiilt3J9DxOQa4SoUYBOr7KI1Mr9wg9AFZqA//I9GLpJhPlN1uLRa9ri+j/w7mzDZtwTQWD+Do5gknIqyb6tdBEhqBAh4btBPGQxuepv8v71Vgjqu7QygUfah9nQM1qabUjso/v0laAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juJ5MV12Yluo29y41/nC5wR+fL7WFB7uCkhxhWrCAdU=;
 b=w9dIjqjzQkbGyY8RRRP6Lg+smO6GbxkIBnHU9+NZMuSJ7626jSblSJzC2fAq6S7my2+t/kYmE64JPuIlWUvV4Y+RELXm9K9FYarCdYhwiUD1Hu2loPN8NvMPMLVHPLOLq/sLsNyx5GhljNsas6NO+6QBpJ5f5A9JyYKys+uSJRU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8278.namprd10.prod.outlook.com (2603:10b6:208:561::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Tue, 5 Aug
 2025 15:08:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 15:08:09 +0000
Date: Tue, 5 Aug 2025 16:08:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v3 4/6] docs: transhuge: document process level THP
 controls
Message-ID: <91a21c20-088b-41bf-a728-a27650e13345@lucifer.local>
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-5-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804154317.1648084-5-usamaarif642@gmail.com>
X-ClientProxiedBy: LO4P265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b136ee-82a6-4fe9-92be-08ddd431e3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tsp9ecgTIRPrB8kJq+tnJqSD7knTWnqPl1q+Z/N2hWayRSyDxryfhUVpSkPp?=
 =?us-ascii?Q?+I+YFNdUOl4SDquitWLujs/ZckCaEBic5KUEjcHk0RbLtM0K+smLcOzD+Lrp?=
 =?us-ascii?Q?issjxu7ZQQylJ6r025AmV1AufB5yyRSE0iAYL2jJQMutJvW78VhCNVklCgWn?=
 =?us-ascii?Q?BllondCMz1oHoDYFKWsQOr7NpkeVAG/awB2kY/y2VB1FJ9A3BF0PRHqBT6WQ?=
 =?us-ascii?Q?BCbjwyyUccOfiHMZXTRID5R6rDvnUpRkX9tiHaTnJoqin8LXHXY3APMsA+Y3?=
 =?us-ascii?Q?9TGzBVkvzuM8FdERERxeDUQHUI7LhkhKzfEps4fp/4GxkK1t0n2PVnT+riIY?=
 =?us-ascii?Q?TPcVmb4GoTgNV8Ybyzk3am5gbUy3LVfQV4ruIs6Ftu3/RjFJGoLoDIkZ2C/3?=
 =?us-ascii?Q?Tbhyj85OEQxQDp72Nej1rw0poNfgjN6BvfIjr3AUyxXx+PjQbRFxthdJ4/US?=
 =?us-ascii?Q?raJ+P66HzQWBfW//HJI4+obILn2x0cYoijayiNFIunEWX3R14CWNjWiMwaKW?=
 =?us-ascii?Q?dbkPMoko3fBch3E+L4rThTH3mEFXaMeJohvSnCsOxz2n3W9Vg7/8aw6omS/Z?=
 =?us-ascii?Q?iDHAfGZphzAQkmJMTP37RcuxvcLNty/sg7IugUMie40WwkK7d/RKl+c46YOe?=
 =?us-ascii?Q?2/am/CCZXROyBqWnaWkX5CPZUPZsAY6EvscH8Q9t2z2GxsVn7Llw19iZDcri?=
 =?us-ascii?Q?sRAsy4W7JXYICqFymLarrM5Bktqnuemp4zWciGGQAJWBkF5Wy1EtGd0gOXiA?=
 =?us-ascii?Q?wMMQyQ7WZIhDrEdADUlmvGYrnQysz1L3yqhtY3v0Egx4OB2tGKYF2/JSaClv?=
 =?us-ascii?Q?+XN0+X9aonkNdWx57Ja1i3EutWqUlu4jYoZ0cjny5OiBMdyd3T+kIQZOrMLM?=
 =?us-ascii?Q?1jMlhjNp0TNRDov6TyJgQCEaOwcX3lqheNjCX1bf9zXbZJQYoTfhuytrSqHn?=
 =?us-ascii?Q?mRcow1Uc8C3CbcGAyxHrpZ5ZzXdxGFk338P5bOKxgSXe1e1V0HTm6hjtj2oO?=
 =?us-ascii?Q?S5TXZK8nTd9jqqpj9paR/VkBQZ2hPPbs0IT9pnUquKfz4h6U9xxNwe9DjtXS?=
 =?us-ascii?Q?5Mr91dDs7XwX/UZ5sj4A9KT/e1R1lGeGCQKF6u4KFvRn7sXDBWw/AD7BmLqC?=
 =?us-ascii?Q?t3EQdUgoZoBmtyOI6TsQrN6ohoKNEwZREh8KfLiMJcaqLNbT3R8uqKC+jhAJ?=
 =?us-ascii?Q?GqZdU1O/QvnPesYfTBT84flR1zCotWhd5GsmRUpyeDh/obRZ3C3rYQt8da0r?=
 =?us-ascii?Q?mHTDOzAm4ZLMjJ/5yXfWCNf14zR77u2A39dSHWwSdV6BV38cfbfKDrznkE2W?=
 =?us-ascii?Q?RSM8n71ckVaSZclyCLnzmJeT7wusEwXdOcPrX6fCpNQoAiBDYHwOl+uKVt6D?=
 =?us-ascii?Q?hDfqGE3VpKIEi3sGUCLofygnBjtGJ9tQ4AnR76wofUKzvbko4cmgty53uOZk?=
 =?us-ascii?Q?IpeBJ9gJxmc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r7DiwOd0fTof2nNQh6BcDEpkWvwphot4Z3nhGiB9lU2PwBpAi/PXhZ5Hs7pn?=
 =?us-ascii?Q?66S4Zspe7CZPN12aERjVLttn/+j0ET87F4+xFRpYEanRgJwuDw6t4iaTti4M?=
 =?us-ascii?Q?oxl66rqiYwtVgx+yRWop10w6s+/Yc0rkrKFcIhsrz0JNWyRHdAZr5sguGE+l?=
 =?us-ascii?Q?0aRr2gSXRHm7oXE0GuYma15wam/0yosLspq17NPC0FgU6rjNPxzrx4XR9W6e?=
 =?us-ascii?Q?hrfze2eMvmGB3e9GlKQP3thGG9X820m4TLwSzUUyhyOyrOvSmOT8C5J8PQe3?=
 =?us-ascii?Q?5MP3yUzvQfc71osBpPokDtS0IDHAa0H9E/29DovTrbgpwJKp/q9xYu7hTzam?=
 =?us-ascii?Q?uzGQEaciLKHXEJfy7AX9+EwqytFHLI6VkflLhtTKJ35KqiAxGUL0aEiJXHbJ?=
 =?us-ascii?Q?5WmpmM30UhodGCJaN3sFUjFuHUcOk9Sqwd7piMB/oRHKJLEZfjJPv/nUZXYA?=
 =?us-ascii?Q?OPtqO5W7BIv5THR9C0xlrnF+zVfF2Lt2ojfI1B5IXGNGuLy5GXqw5XZRR1Zb?=
 =?us-ascii?Q?rG8YKkP4vlPZpV7hGQoy+OzVognmIosBM0fs9hJ4X2DdHSZ1Pn4Sr5WN0N40?=
 =?us-ascii?Q?VrW09Pzn8DCPHkGQHoIOeIwqjY2pMBoGWIw+8wtuqL0vGbxixT69DMePQL02?=
 =?us-ascii?Q?8LeE/RMJxSqWEE/eeHk0lTZOG+PBM83zgWlV64sFwJ4tcRVrt2STAPF4SDX9?=
 =?us-ascii?Q?QumhW/au9/yLZHd4cilVcQrRyfn68pi8jWzJYYL2M4a02GCdT8R/ubkDuI5j?=
 =?us-ascii?Q?nBqgOpJTFpUIrE7kchkDkrFch78EKOkdaWXxqg5sxQPgBq8i5IRChQtvxYp+?=
 =?us-ascii?Q?i4jiafGaEMq8ose8HX8Io2Ei3F2oiY2q8WiJ8i4oPW24v7yLK+FN9sfO7Q6e?=
 =?us-ascii?Q?R9m9Y++7xlwGAKZZio9yUECObvKupa0SqClht130mG/GH4M7i9UOcKX0rkrh?=
 =?us-ascii?Q?LTtUGJZqzoI5qZUe3gQTrJcFaoSeLuepTlxEgeAa5QAFSk4GeJRnql7TCvMf?=
 =?us-ascii?Q?dFzT0h6DTLwzN4tPzkc9A4tGWONoCwkAsItoxd2WJ/lk+o4I1ucYP5vuAToC?=
 =?us-ascii?Q?4nzIPoMa3S3m4LsBAde1tLemMqzRdCyKSvJfvJU0EX+uMR99gBtnimG7UqKm?=
 =?us-ascii?Q?LyI7PHB3H7Z4Gg3/wG/qpOoqRN/nxsriWycChZHaLHp2c6SyWD5WxniDZMoC?=
 =?us-ascii?Q?n2crH3a0fu13qJr7sFf5VodgMQbQ6o4WIWR3UH8pI0R3xbdFo9IfSGZyyaqL?=
 =?us-ascii?Q?xD/DB0rOmpmang5wgz7X6wn08rSL7XgPGKedv+WLmb6d63Ycx5t2ZR7QhWYb?=
 =?us-ascii?Q?DB0hZHshCmnkJUZMvvjL7ewI8C2AX4hiXIYLXYrz0s+KsN01oNw2vFzgIMPv?=
 =?us-ascii?Q?GFH+2HFPd3KzbtmCwvjZe0BepBrE3AgjAsocR/BzN8lJhMjH/S9dDe9Ld/Vk?=
 =?us-ascii?Q?0dSLwyAPfNbgdobwNTfb5kF80QLZ65YSdgpTNdEsh7A/fyrT0Zyf1w9/7kXZ?=
 =?us-ascii?Q?20aj5ZAteBZeGCsD119sUxsd53bW0J7FHeuuxrXUg39ZwF7FnCo8uDY4Wd+v?=
 =?us-ascii?Q?ZZBWgSIH2Pd8uxRo89Dn/FhS8EVhSBdGQyngHnDCyGy1fdoeZOh7XC+imsV5?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ECiSvgQucfHb2bqBBiD06sGrlLZIysb2ng0dtDleFC/8/3tGKhSQh4DdlNswPMAzNHGXoUBfNAyp6WhYtoP8X+i++EPqMl4+gUSGdjq+uNRD1+JtrRc9/bCOgi2O2BW45QVHZuodzdNAC/+1JFaDNph2DVYbQjF73EqyWGqqcfNCO7htF6SsL2onsrrdJrC25WXPAt9Z8mmf2bmrzf356pvLuEO044LV2Y20PF6sZmoAPrnfAN2Pf92OkflWCMM1L9PPkQc91/eSf7z3tAhM/D4f1YckMYQ3u0GcgyujS4/BQK3+ny9iiXCTDVWmpNgzgz9NgEWu/FaL6+ATbpdk9LIwpWb2Y518IP8hb9Q4GN4FL17UVmYvtHFFxY0z8EuqqOJ6uPo64ARvqKLB49jWDdQd4e+WJ8M0c4s3PtrlO5oCGf2xvYdBu9Y313HeJ+uhJafXiC36jjrt+BOrFeo4cHcWpbLGow2Nu9r5WqXbhjpWODIfPjvDloucEZVi+Nrl8y0nkMQqQ2m1zbDcOW7sPId01AvtFCz6GZrC1oCv4bpG03PMqXUP3MSY4IRkIEZnqakfNPu4t5fQXf0A2PGZSzZyctwWiocZWm7QU8oRIV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b136ee-82a6-4fe9-92be-08ddd431e3b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 15:08:09.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfYKn9PVt5x/dl9JE7+32NPUF7hgT6ragywGF7x+g540KEfHSinn4XPT7WIZNPJpdHnijKZuTFqqlXrS4S/HECgATIODIsgyiex+hccbSM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508050109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwOSBTYWx0ZWRfXzs3vHYcXCXme
 EvjL5dRRf6iYKe8pfaPFDjS/PxHUNSu8qI1iaUMgyskQF5ktov8h/fCVmyUtrguI8ZCHp6e7JZi
 jIpMe1pUexcI+NuSElQ9OmE6uxbyC1U9B4VucsElFXQ0s0TcytIwLDcBiyZ0Zxzeec/veBH44FU
 3fkeOWkth4nMEZ2QoZeO4rOzPSpYcnpVqZVy2mUNfQCe08OgaFu/l6aoPA9XKuGZq4Ydbtqw3Wr
 0mzZRYKZ9jUqABfs6rv4wnhg2CIniz6uOfdn2TTNsWTLHxSzwjfwlh43jFx6Df8qjX3xZsiyM8X
 CZz3m/rB/A4zkuIiaWVZ9PWKebb7boYA/m8EKBK75sobYDuvgrLBofQgSBayFBE0Jp8d+fyZYsA
 YlDl9Xd2ZhdtkBF4HbA//Ixp0I/9Ki17jUY5AbwUXD62BgfyvAsFyJ4QlNKyFuOi0TTDVKpr
X-Proofpoint-GUID: 1I2tZZZnp_u25OlDJdHZglx3PfUloSDi
X-Proofpoint-ORIG-GUID: 1I2tZZZnp_u25OlDJdHZglx3PfUloSDi
X-Authority-Analysis: v=2.4 cv=VMvdn8PX c=1 sm=1 tr=0 ts=68921e61 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=IPxakiSFZNNd7FqHfuYA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12065

On Mon, Aug 04, 2025 at 04:40:47PM +0100, Usama Arif wrote:
> This includes the PR_SET_THP_DISABLE/PR_GET_THP_DISABLE pair of
> prctl calls as well the newly introduced PR_THP_DISABLE_EXCEPT_ADVISED
> flag for the PR_SET_THP_DISABLE prctl call.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 370fba113460..a36a04394ff5 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -225,6 +225,44 @@ to "always" or "madvise"), and it'll be automatically shutdown when
>  PMD-sized THP is disabled (when both the per-size anon control and the
>  top-level control are "never")
>
> +process THP controls
> +--------------------
> +
> +A process can control its own THP behaviour using the ``PR_SET_THP_DISABLE``
> +and ``PR_GET_THP_DISABLE`` pair of prctl(2) calls. These calls support the
> +following arguments::
> +
> +	prctl(PR_SET_THP_DISABLE, 1, 0, 0, 0):
> +		This will set the MMF_DISABLE_THP_COMPLETELY mm flag which will

I'm not sure these impl details are necessary, this is an admin guide doc.

> +		result in no THPs being faulted in or collapsed, irrespective
> +		of global THP controls. This flag and hence the behaviour is

Also irrespective of MADV_COLLAPSE right?

Important to highlight that, as it's the only way to disable that.

> +		inherited across fork(2) and execve(2).

I'd remove the 'this flag' bit here.

> +
> +	prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, 0, 0):
> +		This will set the MMF_DISABLE_THP_EXCEPT_ADVISED mm flag which

No need to refer to implementation detail of mm flag.

> +		will result in THPs being faulted in or collapsed only for
> +		the following cases:
> +		- Global THP controls are set to "always" or "madvise" and
> +		  the process has madvised the region with either MADV_HUGEPAGE
> +		  or MADV_COLLAPSE.
> +		- Global THP controls is set to "never" and the process has
> +		  madvised the region with MADV_COLLAPSE.

Nit, but prefer madvise()'d, or really 'used madvise() with the MADV_COLLAPSE
flag over the region'.

> +		This flag and hence the behaviour is inherited across fork(2)
> +		and execve(2).

Again drop 'this flag'.

> +
> +	prctl(PR_SET_THP_DISABLE, 0, 0, 0, 0):
> +		This will clear the MMF_DISABLE_THP_COMPLETELY and
> +		MMF_DISABLE_THP_EXCEPT_ADVISED mm flags. The process will

Remove impl details.

> +		behave according to the global THP controls. This behaviour
> +		will be inherited across fork(2) and execve(2).

Something like 'this will revoke any specified THP disable behaviour and the
process will behave normally with respect to THP. As with the other THP disable
flags, this change is inherited across fork/exec.'

> +
> +	prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0):
> +		This will return the THP disable mm flag status of the process
> +		that was set by prctl(PR_SET_THP_DISABLE, ...). i.e.
> +		- 1 if MMF_DISABLE_THP_COMPLETELY flag is set

This is incorrect, this is set if either flag is set.

Again, remove impl details.

> +		- 3 if MMF_DISABLE_THP_EXCEPT_ADVISED flag is set
> +		- 0 otherwise.

This is really not clear, people are going to wonder why it's randomly 3.

Maybe something like:

This returns a value whose bit indicate how THP-disable is configured:

    Bits
     1 0  Value  Description
    |0|0|   0    No THP-disable behaviour specified.
    |0|1|   1    THP is entirely disabled for this process.
    |1|1|   3    THP-except-advised mode is set for this process.

> +
>  Khugepaged controls
>  -------------------
>
> --
> 2.47.3
>

Cheers, Lorenzo

