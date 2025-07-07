Return-Path: <linux-fsdevel+bounces-54048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A6AFAAEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C31189BC10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A18A2701CE;
	Mon,  7 Jul 2025 05:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FNBCNX5X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lf9/07ih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13471223DF1;
	Mon,  7 Jul 2025 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866209; cv=fail; b=oK7eOv/l3/zrDxw5fCoxOOEvvv5Ry92k68vsejDLlEPssxbOBKivBVa2a3Vdrud84DOjHU6pU05TwUJhsxY4tEmofdrSYs5t2ehLRVtddypdPom0kQZ9Sg2345/LQqqcZ4NFRERjmt6vPDkBBiOJ0wrOHAoafwMDzAGKVcKAgzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866209; c=relaxed/simple;
	bh=qFnPV5LhESmfVccBAKwH1Gwb8Z5IHju3ZMcCAfrGs+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=luLXhdSP0B0vHr9zQ123Kma52X7ozSidCruwt1X7Y0WucOTZwBpD8J/tFoxUrFuxY+LmrtxLQfcU0qPpVwFvQHdNkuPIq8xfzWZhQ9R6Uk+AppIgE7MoRC+GH5xx9PytyltwchQbqix2NJlVY22yPG1THpgxcJ7qzv+dgA/tdZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FNBCNX5X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lf9/07ih; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566LeUe3004231;
	Mon, 7 Jul 2025 05:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NM6i9pblmjitPoO5W9OF2SX88EM5hA6mCVZioM/mT0o=; b=
	FNBCNX5XKaBlLpTZuNxrTEqVU3cdkiNkIjvJszz0BRMntUIs6gWHllKxo2T5FARB
	JjXKdREKOw7+f2jrpGR1iyp+bz1h/7JEXXgjzUUVJ9T0m3/BvgGC1ZQvHLNI51CV
	QizpE2XzM17u3la7+m9APT1+h+tC1m88JaCv/1RFbKrJAPTOTJ3EXmli/nSkCobU
	bj/ToqqHXPaIWgI0TSWs+AmVMZvfCOLWctQh7ed+6p7E4SFNtGxUhinuAfVaQzaC
	jSBi1x92ykk+buWrghsDh9tJVnWpreJAjM9L8DA3Ew2Q+aoaN/w9jba1XWtQjJgq
	THtMkUwm/tDBZdlE7RRpWA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47pvkxsxyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:29:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5672PVBt024285;
	Mon, 7 Jul 2025 05:29:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82hd8-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDUGryXIyn1tBKweW6NQ8TQTnba9e6swS0ibBjO8w1Kk8GGRcowJInCzP1k3tdXB9AJmbmEnudvrkm3RJC71X8jsCCEKNxBi6TEPkm4ajHHh9/IpqbqCjvKixJr4rFFUE7v97QMQc4zA7pGYj94pt6hBrtyvIYVXQF1dMHYzPAGL4sliWWQhOiR9IMgqi1p1h5A9ii1l+lveRz6NgYg2jsEVy/kgdpztHNNzKNFv0n3+CIMQqV5+7pFgMIq/RabMHip4WW76b0u5p825GFKxpwSV1clJDyjdCTOIgOgzzPP/2rKEbkiPMPOYMKU8FefW79kKyjrubQWQcRbO/InSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM6i9pblmjitPoO5W9OF2SX88EM5hA6mCVZioM/mT0o=;
 b=SGOXnnE6uapwqnVhWMs9IcVo6zDcF1Ho7BbL/BahH9Q6OI1G1+aUhXLsx5Ag1wVveCP/k8p6eXLCrIh6RQGnde57DE5NB/MnDur84gVAz0is/MOgUONu74t23psnHRzHPYdwthkoCQXg2NL4Z6yPcFHoJfSWCCaPQtv+w0jB8qV3K4R07nBw9INm5MyZjeCgLBC+6n0Ce/5QwTKyJFCQQkhbAp+plSU0aYWEM6xfYZIaobTjCyVIt0/m2ro4WVzwcRrOqWxA1F/BWnQBY2titJV7N+nyomHgk9eVryh0IfdAev/pJcJu0gP5Ul87kYwoE6tBSwfx29y4J9R0zpZXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM6i9pblmjitPoO5W9OF2SX88EM5hA6mCVZioM/mT0o=;
 b=lf9/07ih/pid08snhX6x+LzPh3Iyy2mib1tK+FUjvC9b+0Il1myJDc/93pUumHgSrNQkUJV+gb+rUEHVtQ97nXChCboA21/tc/59IK4ku6sxczA2pBoPHtf3CBiovOaKQZgmFGG5bLgUk7pDdz6j61HULhGMkphxhFWtfVvxMlU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 08/10] mm/mremap: clean up mlock populate behaviour
Date: Mon,  7 Jul 2025 06:27:51 +0100
Message-ID: <1bea4f7b5093d603ff323570076142eaabc8a480.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: a9faada9-3e9d-440d-656f-08ddbd172814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zA0Kxx9YF3hE/iVKF740m+Uk+BjrKJ0/rrxOzYePkkXO3BKvvzDUSPenyHIJ?=
 =?us-ascii?Q?h0fPclKF4rb6Vr7I4hwCyDLUQE047JqIhxLOVyV62Y2jrRLfn0w3doBMSK34?=
 =?us-ascii?Q?3s6JRAj/X/mu1zpsBMFwzt3uD5InVUxuq4B9TvlHpgSISPx3EFip9Z+0ljdt?=
 =?us-ascii?Q?scCgGC5Y681H76GvAimcBsvxd3DKU5xXo0+2TKXDNWWPcGf143bS3yaaaRNb?=
 =?us-ascii?Q?uaSnRZUHRARiMLBIv+gG7hiAH2sgaPW5rkz5in4Au7V9FrxV848WxkZJTz/4?=
 =?us-ascii?Q?WvLr8zJk/5wGlGk55+bFioPO3NH/+cg+YGZ468Kk/T545RCG2TwpdDwu5hS8?=
 =?us-ascii?Q?JF+/XXN9J/0X2s2U0nJd9VKzl6zMFcUxNfKjqQcpebUcesPmeAdNXrZqHCNB?=
 =?us-ascii?Q?GFi7ZMz0/fryOOavGOtesRT9vafW7HMKOZpNhWU0Om2eWMl0vl6RdiBg1taL?=
 =?us-ascii?Q?mkq+7dJ2oFcG2tcmkYQzxf7KiMws4acFEJIAoGJo0wpN5HZ8pLfJoAKTF8Eq?=
 =?us-ascii?Q?pAIC9bunKgBLLsNKqLlPxrK1Dxcp36z1G3ucxoIx9yiSDRcpQRH5rkUecMgc?=
 =?us-ascii?Q?trZetJvzM8EnxWQ7L+H58lngXfGwuEAB8dULDSqYpmb2BtkG8V9E0H6lWHhv?=
 =?us-ascii?Q?bcLUoaR4KTBqp5KvePpRMiZzND0+YRdUcpKWh2pxCi4S0npquYs9pnik+69U?=
 =?us-ascii?Q?GGLLQvRoEBAYFbyyRngsk5pKEiuoz8+H0lmrz0RY8A8f/pX3KMNFE/GekwyQ?=
 =?us-ascii?Q?MguRyLZi6GQHqelW2mqp9wNrdBTKgR3YZj/PfEH5WBupeMqbmsevLUlEFcvO?=
 =?us-ascii?Q?hAjmvMI1JW9DN15IfkZ8spPUYAaM7EepFzBCj4F9wAreE4JDNgMavJ6GQNUi?=
 =?us-ascii?Q?1yzagyJ0uNng9ce3IjBKyfCzuhDevIe+UqY8afcK2bZXGKeq26PkHzg39Aig?=
 =?us-ascii?Q?qFNeIzRn4xuL0ZiPMdT46KZH180fL93hlPUgndn6siWvX6ta82PzVu6BZ8bM?=
 =?us-ascii?Q?6Ub597NORIHMw4ZdA6jlePDg2CEfpraIcirtX4yt30NLNfo9OARILTquhwco?=
 =?us-ascii?Q?Uln5wQ+98qH/9akNZamL2RxkhG38SNoUKWZqH6M1PvwkwEBvltz/Ag4crB4F?=
 =?us-ascii?Q?9FHOR6WlT+lhrDI8fYMcpepIanawYKjF0BwkT2Z5e/m7VH6v7yfTkRShYhpI?=
 =?us-ascii?Q?irrlodAjpxzfoMGkZgN/i+qew6SHNOWZRd4nBf65fwp/rXwUKfBz9lNgWHE8?=
 =?us-ascii?Q?W0PujzFFJqfkoL0joktjaUwULb42to/OwWb9Rz7BF5j72uAzkj/TPC7xJDnb?=
 =?us-ascii?Q?YD3VrdBQZKCeGvuk8+eMIfnazH8XsHUVE5qjZ9KtkpApi66+W0Cbp3sQ/OT0?=
 =?us-ascii?Q?/RurolGRRHjItOn2olD4mi2xV82LPtA8LlB0o0UsT+4NIV/Bm3RzpSak0phU?=
 =?us-ascii?Q?hpf6Phgau0M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tAzJuB3mGjnA/IXQCIhw9A4GPIfRW4FOFn8ta6iFRIMQco+jLSJ2CF74qU/e?=
 =?us-ascii?Q?4TOSC6kjFMsdqyVbENrQO+kDb7HLZd7k0zcOjb7wSrUkJEPfM3sI1ldsq8dX?=
 =?us-ascii?Q?XK6RLKZFJ5TLh5KylC+LNlTCcvhojn7RyQXcpEsmr8yWWWbe3Dl6Pol0oATs?=
 =?us-ascii?Q?DRN01R4HG0JlLzTrMc/6uywKljeRoL11Gt0kAQXMuLw3eH6go5m6DtMrQY9u?=
 =?us-ascii?Q?umUgmy6MIfgmVv7IXkiVnG6MtDb7SFaDEcDOcp06/yp4PMNsvfa5vXztpyMg?=
 =?us-ascii?Q?dEbnB9wz424P5Xy12cuxqtCP4veuSYPBVOdR+kJwatAdgjVKZHR1orJWaXvf?=
 =?us-ascii?Q?siV9Y6TmcpI4qbty33D+mIgP2acI4RWN5OLgkXwLoe+EivmSsN4CV1VrTXUT?=
 =?us-ascii?Q?AzdIVnNc8DnsenpD00SsAzxpb+rssye/BV8oVhkdt4kVANPfrTaITRm/Hmg5?=
 =?us-ascii?Q?Y9kqe7MIgyK+PSFawrSvtTJMHVsRrM38bSOG9O17FyzLdxvF01rgkcrGnLSF?=
 =?us-ascii?Q?rx+NkmjKE6F128EEUBlcd/2n0ghEhlZIJ3lO+WCQz/3JTyQYvECQLovAqqP2?=
 =?us-ascii?Q?HFnn3/QiQk6o3ieJtSiLIeflkOdNlaIJrt0wN5u+UtFDUTfkMVSbOSgNVXWh?=
 =?us-ascii?Q?kn0ZRjDxFowK/aDfW+JSOYcG4M4bM7ZnA8v5i9mIN/ICijnpR4LYu0OdPkrT?=
 =?us-ascii?Q?7UjWPtetYebFwJtLfZUksRC17KEznDs0CwdD1VG8FLdpxFqTgQs2HMZys6vC?=
 =?us-ascii?Q?wmTvC7n2x/VgWE8ySVaGtGCvPJRV0FgIkuv6zfnHwmBR/qSro4JEe45skAF0?=
 =?us-ascii?Q?+kpAxQkmNbYuahUAoeVXIHM0ZRlpG6ncIyONBbgk167jMfCJt0oehihBsZNs?=
 =?us-ascii?Q?bQmxW4NGq9GtxfVoeYC3E88AGL65RwfOW28Gkj/p2w1CL9tpkHpxfwCrF3xm?=
 =?us-ascii?Q?zV1MeavXHpVU9xVbMDQCWVr3KBTutQmfgAMjrPv/3RwqmyhSgFBSdF/8rpBm?=
 =?us-ascii?Q?WRfVS/oYk0xisXXf68mV8tLX3CHMkAuoN+N5gZmA2rvKw1xq8Uk9QuqgtDvU?=
 =?us-ascii?Q?/mbC0mv9aNJa7Kza1AWRCE4G6YAHEuSglB3JqfpV0OWoDC6tJZbEyKUUq/1N?=
 =?us-ascii?Q?AlYvyGtNg5/Q/pSMg04V5vbJiiK3ZyotmdsTDvk0zL2Jmyhzp9Pns1oAR1xe?=
 =?us-ascii?Q?o8Y8S68lz6khNXnc28SjIJ8Ti7myX1PoVKBYwvrXSVybM1yrIdiusgadEMK3?=
 =?us-ascii?Q?V6XeTP6WWb1DwEYWFNuSrnFd+gXsGrL0JSITCUEC0wP9BszA1Q2hVMh+jJ+M?=
 =?us-ascii?Q?ShUWId47X24ufcMtEM+QykXcpoMbtauEE1s6de3Mdfnas7Ea3Jwe4c9QvNZp?=
 =?us-ascii?Q?mKbYvpKeuENjYNBZbEGs5kuuuULwt9K4DzdvC2v0miFOhKAKgU4Q5P6kjgHn?=
 =?us-ascii?Q?g80SG4hLRMQUexeAyOlhco+t2t58unhklsj7R+aFJaQVTZn3Ig17gC7Cce/W?=
 =?us-ascii?Q?VjJK8qwmD8daeQEGeWcnYFckF9kBTmgNqe/fnnMVKVewJzeDbF2WxXj/2xNA?=
 =?us-ascii?Q?SF32xkoYezONFS2HgkvHvZtLvpzi50hGFaLy9dLaa6WDFZCjXkfb8QCs8Fi/?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M8iHUhw60PSg1CQZchRQKJY2p+L9wo/UY9k3EfcqJTJ0vCW+TvdTnTrsGbmEXMTN9cFByw5de7sbwAoJNwGyI6ZveoZgaj1o9wLTAfuxX4XadOzYHUQctvFpctQmHjK+cY65hTPh8lVk7I5U+hH0VHl7G/0HeCLpStQQ/MhqC7aLgCa5JGEQtgSeTPTctHxo7BReWbu8/uB7FlX/fEx5H04BJEiEfhpUFhZNi11AmO9uTaQ21nj76zZdcStva11LZ8AMlYD5Ws6ZURlWk3eLh8Gas3EOlmSU1T81ja5vpbRkPV0sMBKy4qqzlP7lWc6NGxAEroSg6gCpVGIA0uyRTL1uwgyh4wQ4KPye6pnr+7Kzf7BWfqi56hsVMe6DTicYWzsRhvlinFa8y/6LdXqEgzFCJeporEoNSbflqihn6A7TcL6URB9kghV+lpRTLprOzTSgoN7MV/7FlBXjmy6Kk3XKCpGNH5l3afdiRnOlMuZB5fI0ojECSA+OFMYv4RjoNFTXIccs7HpJ9+DOP7Dn6jtlsuQpuUe20vI48bNQu/FGMk9d9oGEnTARkww3Lw3UY0VZPBGNmA94b528YDLG+6MidBZ+S7JWlyDbawDNz4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9faada9-3e9d-440d-656f-08ddbd172814
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:51.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxzA3KS9eBr1IGocsN6724NRlYDp4MYVlKr/Qt1lhYhxFQKgp2fXIYmvBn7y7CqgK/N18Qs+bbvsQ/8UvmWegHOSou19kg9sUqxCw/00fq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Proofpoint-GUID: nR3C7P4-0RfbY-XvefB1lw7Ml3hQkGKg
X-Authority-Analysis: v=2.4 cv=a5Uw9VSF c=1 sm=1 tr=0 ts=686b5b1d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vjQNCPEVpfjC6StvhboA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfX/ofo+fPELcR+ aXA+7xdkg0fvIOSpRUYtIfjzy6paOA/USQc+V7FdI8xikZOw336/hLKIezqNLx8eN9dCanEze6v 5m1vPBSGWz64/37hYvczcr4MFy/q6E9MabAqJoAR27hXNWLWe7fUSyAC0Q9n1n4GdI10EEAG5nv
 MBpjJ9GjPoYjLAiWMXT2ITOUzlluXkVCWQDkNeUdXzYmjazEUSGs1UfDI2nW6W88CkAXJxhjZar Ih5qPOdF7jXf2z+eKWxaIp7RggP5dh9TChrzEjQhiknoGwAAr3VbBTlAc4T5Y+GAMrAULV2J1+2 AbvIotTUYIsTifK+gXcpCDNwB0TerjhV78mUvwW3zREsPyC2H2u4/HxC+lahhsqt3pIFRXA3von
 xDfHZ9QU3pgavugDUVU5InqSpYrxSHG7lUURiLWln1MZqR2SosNudUwOaiNcg1+BZudCyDqL
X-Proofpoint-ORIG-GUID: nR3C7P4-0RfbY-XvefB1lw7Ml3hQkGKg

When an mlock()'d VMA is expanded, we need to populate the expanded region
to maintain the contract that all mlock()'d memory is present (albeit -
with some period after mmap unlock where the expanded part of the mapping
remains unfaulted).

The current implementation is very unclear, so make it absolutely explicit
under what circumstances we do this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 3678f21c2c36..28e776cddc08 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -65,7 +65,7 @@ struct vma_remap_struct {
 
 	/* Internal state, determined in do_mremap(). */
 	unsigned long delta;		/* Absolute delta of old_len,new_len. */
-	bool mlocked;			/* Was the VMA mlock()'d? */
+	bool populate_expand;		/* mlock()'d expanded, must populate. */
 	enum mremap_type remap_type;	/* expand, shrink, etc. */
 	bool mmap_locked;		/* Is mm currently write-locked? */
 	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
@@ -1010,10 +1010,8 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
 	struct vm_area_struct *vma = vrm->vma;
 
 	vm_stat_account(mm, vma->vm_flags, pages);
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm += pages;
-		vrm->mlocked = true;
-	}
 }
 
 /*
@@ -1653,6 +1651,10 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (new_len <= old_len)
 		return 0;
 
+	/* We are expanding and the VMA is mlock()'d so we need to populate. */
+	if (vma->vm_flags & VM_LOCKED)
+		vrm->populate_expand = true;
+
 	/* Need to be careful about a growing mapping */
 	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
@@ -1773,7 +1775,8 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
 
-	if (!failed && vrm->mlocked && vrm->new_len > vrm->old_len)
+	/* VMA mlock'd + was expanded, so populated expanded region. */
+	if (!failed && vrm->populate_expand)
 		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
 	notify_uffd(vrm, failed);
-- 
2.50.0


