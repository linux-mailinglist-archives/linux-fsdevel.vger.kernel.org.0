Return-Path: <linux-fsdevel+bounces-54531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C94BFB007E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D6C1883EF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA92E763B;
	Thu, 10 Jul 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aGUjAAr0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N+Kl4Mzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63ED2DC32D;
	Thu, 10 Jul 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162736; cv=fail; b=pfAJtZ+Fw+vWHNZC495C5fOU/LA/I/n9NEbimVyosBJvEs3WL3lbCENAvXRNFJaRfHgusPSsUQyl3vmE2NVitaSitADO0QbBXfpx7vQuw8LAUclzRdM5Ggq4cggNtcJVk0kSwfRfOZqfK3PBDe+NVK+UlnTZzOu+rMivCoxek8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162736; c=relaxed/simple;
	bh=w9b70YRhR0J4qe+E+GHuc75O5MEpHjZSgzYvp69/XTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qB5Xf+SCCHn7qo5KfK0NDLdRCHl7hIS+KElaE9+XcfEf9OME2S7s3YWDgGKoeOvpsSTpH9yusPsVj5AmMLtD2aDQwr5Tohl41h6MfKxLL0/q3mG8rY+y5zbJixyA2on0Qbia2T0t2bS6gxqvxfNlXe8rAu64CDCBRwXr9lbShzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aGUjAAr0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N+Kl4Mzf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF1g5O010345;
	Thu, 10 Jul 2025 15:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UCQQnsa42MIfPSuuBqL874zdUhwmLlCZBFO5rTr+5b8=; b=
	aGUjAAr0nuGz/aW/KZvXUSSq6R/EnHV3CyfK6KsuyI6gUhidpUiI8/wPh4A6r8WE
	D90hresOTOct8EmqhFbLVAeDMmtild8bYC75x+GkA2/Or/rQtln70jZsJA6gdtr+
	3rWorMeCXd5kE22pGBiST79MJaXOLZNHeeYxY2XHQ/xdssKtRI93WJ8Wt60OTfEU
	jkSMjoZgQ4xIjTEO6eLoI1Q24c3XMTgE+UXXK2wrBLX+w3WqdEkV9S73x8IW2tMN
	rtfbByyFMJ5LU2ksgCwXnRaNCfui7Jpags/qMOQyMz2AKdvw2qRfgZSrYhrryltO
	oVtCnsfiQN8vBjNGv7kxLw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tft083tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:51:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF0dXZ014184;
	Thu, 10 Jul 2025 15:51:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcfr16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:51:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gL7PqAM0srLli10XQDNJv9q5fmkzwoNKB3cFJw/FmlJEWa5pDvZvXt2nob5e96r/a8ii0ibFT2DyZrjw/gJd4No9bhA7RNeC8Q6nzzntCPgdwsdWR5VVWk0eFmesrZq+nHOlIPboiT8qA2EhDv/KedUDNCfjeOHn1MVHQYnNjk9NXlpgfYGvr6dP1ypX321EotCt+V2BnAvocUZKpI1B9Sn/bgFCb5i+MAbireH/cLfehAQJddGTBdJaatO3ITn+G8anbrDpsbAK6mUx6Eet3xQLWl8wcxZ8/M7VkYezVTlo5PsX8LcN3t5QmDaecjv3h+3tCdbt+5SkA3sVPynQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCQQnsa42MIfPSuuBqL874zdUhwmLlCZBFO5rTr+5b8=;
 b=EyeF6hLZxgXtpER8YnDCLxOXJrPDSupwyyQ03wCA9T8/CJrQviC6BBP5eZAAJxaqRuyEA1NPvGnuVFw27dVlXFkyAw6AOhXASz6/db0PL9fb9markTpGlMIy70lsKM5wOE6RIXZMROaDT6g2Uk8+IX0VJFHPkqPpMTlZ8ngsRs+s20D8+rVIhcBv7VSiGsQh88o7FRQg2gqWGZ46EryavGn0WIDJ/YrV5M8VxH7yHJlya7Xu32vckrcsiAHQFXhsvVj10LCgegjZTnLTAdMy3868QzehSypnfEKcvq2O0TLry3mNHsSmiTfpv6pTmvPX6Hnqjp2QnvBWIxrFVHMSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCQQnsa42MIfPSuuBqL874zdUhwmLlCZBFO5rTr+5b8=;
 b=N+Kl4MzfivwRUml9oFzdjJmDF9srAl8r1gzkdOHBdSkqF8rZRND7wvyn8FR6BU8tZklbdpWYOpwCSqKevX0P2JPA0D6Jxou4iqbUO+aFJN9iHvgEJyiT65yR80eiIHhCS03OXu6CL8J0xzsqLnjXvmOpm3L2CNM55GAlsptMC4c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6769.namprd10.prod.outlook.com (2603:10b6:208:43e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Thu, 10 Jul
 2025 15:50:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:50:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 08/10] mm/mremap: clean up mlock populate behaviour
Date: Thu, 10 Jul 2025 16:50:32 +0100
Message-ID: <26d2af0a6dbbdfe839b3b09d3a8ddd7b10d4be7f.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
References: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: b929259d-64d1-4d2f-1786-08ddbfc990d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6IQrz953sRtoV7PJQgRw63YbsHPFNcikkhl+MY3AZfmTwo1w1N5PVrkAfX/O?=
 =?us-ascii?Q?2NTTiTr+GLlOLg0W2dcBDyz2fNs4cQVBzbJr5aVFLbexhtq2z1BQumBIsWI2?=
 =?us-ascii?Q?DzyQslDRlMyJYKqwhOSkmCOvW5k6tfPH37YpgSVptppoIuQNZoOhilXawmkV?=
 =?us-ascii?Q?AeZ8EZlccZ3Nw9keWEmIBBXF/blaNaazFOPMHWa5P5yuyoZrabjEuh9lTOR+?=
 =?us-ascii?Q?ppC/DqiFfIJziPuJJqssPEqspUEVlMp/9KJCq+zLqk2rWx1aQR2V3sE0CkHx?=
 =?us-ascii?Q?gxYlD8g8zCCFh7UKwVCReaosuBEjmOWb7BnHsF3dJz0FukgEke48IEpkhX/g?=
 =?us-ascii?Q?/EK+/s6k64u6dvUHjKqch/ZjjniLiOEekXJ+jTl58QIek1fTI4IJ1QDf0DzC?=
 =?us-ascii?Q?Hg/MoYaZG+hUszf3kJ2kxf0sX7YAmBsRTH15Xmgr7j54cVYSAgxolKtABzjY?=
 =?us-ascii?Q?PGMLjXdInx69taXOz0xdpyVhAdoB5EGKISlMmx/LqHphHc1TiFCiPEQsaswN?=
 =?us-ascii?Q?Q9vL47iH/tDUz52xICwidPReJYNuDvobXjoAoxHrakp8RqgnCiGBQnzLqs3h?=
 =?us-ascii?Q?at6eZqiBeWTUUScqF8RCyG4yJz19Pm6CeVx3yyYETa9RAlSO94JgTFSxtcgx?=
 =?us-ascii?Q?Gq79L/VcqdsDHG952xGy9QnXNZFjnZ6USzzld8PuslRY6Ly+YZxu8xBaBZ0D?=
 =?us-ascii?Q?kFbQEmVGMm1necT5bdQZ0JKfHwrhiFLm+Rm2UdGBxWBIyd5hu49Kq0t0lafo?=
 =?us-ascii?Q?dxItKx4wn92Ld8Cspv/+yVmotRQgwzfU175P0ngy5wK31zV0vdl0JQ6bmHON?=
 =?us-ascii?Q?AswhfU+jI00gii3ygV1nOfOjysKz/8ASu3eV+2SR5aGNnxeWm73T4naisWSj?=
 =?us-ascii?Q?bfSicWs36d06HWBgbi2/Jn7kVjRSLKnuLqxNFAFcCO1SPIgjkMbr9lJkwdXR?=
 =?us-ascii?Q?TrQGCk89oLdcJdqw9CDpvFsMe+eCjAd0dnkFSlQaqmcn0nm6f8YqJAGwRhBh?=
 =?us-ascii?Q?pHDd2Jt62WgZ/h9hzaL1rxwRwKzHmkt8XoZ3ZuVQrOzKmPEyX5jJX9zVSBW5?=
 =?us-ascii?Q?udTTd9MLw4uCecV9n3noOaI09jfjRYS9iRq+AQ9eOLHHFgJWbOikAUcJFfsY?=
 =?us-ascii?Q?XXoCK7MGHOK5QStqoRy33ucvnK3AAqlDbSgCeVmT8Uv7Nz11AGh7Px8d2gfF?=
 =?us-ascii?Q?GV3BX9f/1M2BvVdh/U2nCbEto+6bJ/x5SKWw4tWWI1EAJEVm+35Z4X+jMlt+?=
 =?us-ascii?Q?Wn//pMKFt2slGPRmuq+by53VYN+VrQLnSxzF9vDMJHTZj9Hmole+20S5mG2y?=
 =?us-ascii?Q?w/fF5g8GE3a+X8inmcJETFGDuQ2yndNsqjSicvZih7AfWVfh6t8vY0HgG06O?=
 =?us-ascii?Q?qtb3yDrpghWYMbfex2YXnkG5Tgz4NfJpwUX2bzs8ZgVImIV3haG1g9SfIv8O?=
 =?us-ascii?Q?LttskRstYfo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ZRZMQy1OnEylJxXIwYkghBgCQlak6yhiQiDTYY1pDyE7gHASQKYkLuw6BLI?=
 =?us-ascii?Q?viKMKJEbLU7gCXcRnWK2GBfXsiIQK20R0OLQSouSRPWPdDvww1wi4hoZabDL?=
 =?us-ascii?Q?YHFeynTrIg7ocDBjtdWKLdOQsTEZfWV3p/o66/2ReazTSaX3addbaUF2lFb4?=
 =?us-ascii?Q?gsdMkpsNN9zQckBhgutZgl/Cvdz2m6SGcOKP2eUWpdjT3a7Ge9Ca76xXsq2s?=
 =?us-ascii?Q?NJu6tdI16sEDmQ+kz7+gTQQGa+OOcYlYxSFlWy8plJKNhz19lnAqzzf6P8Sb?=
 =?us-ascii?Q?6pQAfmtW3GUL5pKxL5elY+TGC4z0CLxIKZyJpn3gc0ARTr/KO0+rOtQR2ReI?=
 =?us-ascii?Q?F1fCONRxS6zm16pQY/ylBK7pKdz9W7cunYfRghbW4B9N7H+FbsU+TED3SKDy?=
 =?us-ascii?Q?JAuzf+4NsGg9zAl+QuVOIzP9kDULUHUueA5R4xgWYU47NYMkmmyw9JGkg8xG?=
 =?us-ascii?Q?xyJ8b6STjYw4N3LTYdQQ2/kKZP+tPYaVIvOVtz9ECbS8RYeDNcCAJnPtqOmf?=
 =?us-ascii?Q?eX+5ai2IuWXspYv4IPefXWgVRDF8UfuYJNno8LeRn6YLu8aQBCd52fTDzD0n?=
 =?us-ascii?Q?V/F7OgVlm+5+U01tgfUDYMJQOxV2gbEZHo+JIi1zoxFlsrl9xHZArlloQGyX?=
 =?us-ascii?Q?Dt4iw4fYtz05TZgSUiZ9UNemejFk7vN1WWfHzrtgOJlRDl8uLaXrPM62dase?=
 =?us-ascii?Q?HdwCwCEByZgZX51EIVLUdQZNq1F4RMxs091dVZqwNcCfc9e9u6dpBBunSvGx?=
 =?us-ascii?Q?TKvVkn9vjUZH2q940aBuuJAcCEllAb7uMvDFQK1+4w+DuTXuTY1t+lNF22Kw?=
 =?us-ascii?Q?Nh7FO4A5unsHHT/aTmESeoFyMYYAn10Mo8bDcSJCIFlPrwp19detTAfrWc2U?=
 =?us-ascii?Q?KB1Ir8KzqRxEaxM4lbcnU33slm361MrFG84amhEKuE0oXrco+TwMSJ8hybzq?=
 =?us-ascii?Q?BQNgxLumx5Azh8bt8+KwoBInNINiWsnMsZ19sjGS8iVWejFHdaF261xo6dQm?=
 =?us-ascii?Q?I9VyCu/guRkj0Iv53TJcGtEbIsMzJX0YFvjUquOIH2dGbkdHfvcsvqFys67H?=
 =?us-ascii?Q?c97z74sHqyEEfCpWtn4Oyu+NtunXX7++g8ICcQMdRraHOi0oQNxQWI9ylwol?=
 =?us-ascii?Q?mp/MoorAcyijF6jj87jVlQxluSFgHOEjMloldnthY34dEfXFQh+37slUUO4T?=
 =?us-ascii?Q?nXorKJzQhBPxqoUfWwKC64s32jdAkA9Ldi+O25vbtlXCZEVggd57Qzi6Df5l?=
 =?us-ascii?Q?Wwes8PBebF4dF456WnuEGaiwVK1fpbRY0RyhUCvDi9woTxPnIAq2D9QJKtcu?=
 =?us-ascii?Q?QteBAxdEt4gMPIopdT2dgWMubgIZQwX9UVdl4O3t5N9u6FC0tPd5V4sEzuMH?=
 =?us-ascii?Q?8yzA/A8YBSsTGjmLB1AS/z4eD/j39Lc+znPQ1hioLXPIRRN0zyOav1R+VmjU?=
 =?us-ascii?Q?+H7NawNSFG8Rhil3g9qVNc8JZhP76/ML/cUw6LAyoc8vH+Ixv6xuRp0vMBOW?=
 =?us-ascii?Q?9jd7fRYdQ7JReBNT9USK1tGl+R7kA4yP2Xl7xJWNDw/h+oAzCjySsfAUWFEu?=
 =?us-ascii?Q?anLJRW8SMtImJcM9BwoL1quU4rswdLKccJcl9PYoEhz6zrZSuGgN0OHmnwsK?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mDacA9D0m3oe1bi1GsoiaHxTC+N5nvlQa/tnuQjdVXVe/48ocADCGo4N+7/pFR//CIjQytB90YXho79lgf/Sk+tWD0JohjHK3S51YJKrWz/LBhyM3liOXOxjy49EnLm6zpjah2atb6QS1hEPXwBleDFozNi2f9Ug82JMJDy00FwGD7mAhbgvunbhu09QY4tFy723x1gebniMijcu8pD7VKn1PNl26lQC84VKWdOIgxYl/Gu7ZZjEnkeLcKh3Zdi5jCSmFDJ2WjjtxfgvqKr1l7cAwWKMTnM6Esrfnt6wlfHzg3ELugNZJ9NbG0LUFK+GzzF7ZgYHkK0vK9QNWtJsnPaJUMAczUDiqZOsbs9j4oIeFkII66wdh+5XWHYkLL7tb+kUSyPRA0u/TqVXMGEuyk2ZEk/oFhETKpRFpsRLslxJN+ZNhQo+0596+Kxtt2z4Dk+PoZd9K7Lrmk4znmP/GnBfL1uSw5r5l5cKCVKJPAnC/NiakSrj4gVg9b7GBlJIq6OA05kGXAocbMwmimqmYsE2iCwMcIdIi5+GSpMEGHRKltRqE/a4P3rDsqCTh2+qY4oJKxRsNmXa93z9szUQMVK1i6/ACB7YNVl6+2y/nHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b929259d-64d1-4d2f-1786-08ddbfc990d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:50:59.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaH20A/DcjOXTpTQuI2PmCyIVR9/m258aHV5W3yqffpe76rlD4XjrJS32XLhYqt8/WFcHaGgTL9xIuRZ2EBOXexpDKkzguF/WBEtWpIY+0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507100136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfX2FXup6Pgubru 5Bn9CL/KA+94pBS+iitt7TP6fBDiFPOjjg3bsK164pIWeRtbbwvVz0vADixGCcJZC53sv/U7aVo Cy2IBgw9iv2FBx8M+9njvqU1YpTLY9sG65x/39/RerwH+MszgA82voLiZnhh9OAT1hVIbRqMjCz
 jZRJRQpjAd2shY+4hTQCV7mXRtCt3dao34FiIGjMY9bHBGpYpbYoY9I4NzfM567AWBaJ757cCP3 8PVX02vqgzfNaoD5UjKPPwKry9oyvpTwCGg7cpOob6nkyddm30Afp39vSkTYlQh+9m8Yrg50ycR dRhHVmVwegCIl3NCaC2yJErWScCYHLCqrvHQMfObijt43TDNhHQceyuYNlmcy9JS07KZUXZAwPK
 47HNbEW63GLq91GeGTR9m6+eUmx6RgDqvaOYkhwI90ASDqdpb7/j/8r8Z+OC+O3nR3dr/O4+
X-Proofpoint-ORIG-GUID: 9V4IpfKOd6_Zx_EsSWkVPigVbrb3cPlo
X-Authority-Analysis: v=2.4 cv=cvybk04i c=1 sm=1 tr=0 ts=686fe166 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vjQNCPEVpfjC6StvhboA:9 cc=ntf awl=host:12062
X-Proofpoint-GUID: 9V4IpfKOd6_Zx_EsSWkVPigVbrb3cPlo

When an mlock()'d VMA is expanded, we need to populate the expanded region
to maintain the contract that all mlock()'d memory is present (albeit -
with some period after mmap unlock where the expanded part of the mapping
remains unfaulted).

The current implementation is very unclear, so make it absolutely explicit
under what circumstances we do this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 3f8daa3314f0..8cb08ccea6ad 100644
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
@@ -1012,10 +1012,8 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
 	struct vm_area_struct *vma = vrm->vma;
 
 	vm_stat_account(mm, vma->vm_flags, pages);
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm += pages;
-		vrm->mlocked = true;
-	}
 }
 
 /*
@@ -1655,6 +1653,10 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (new_len <= old_len)
 		return 0;
 
+	/* We are expanding and the VMA is mlock()'d so we need to populate. */
+	if (vma->vm_flags & VM_LOCKED)
+		vrm->populate_expand = true;
+
 	/* Need to be careful about a growing mapping */
 	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
@@ -1775,7 +1777,8 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
 
-	if (!failed && vrm->mlocked && vrm->new_len > vrm->old_len)
+	/* VMA mlock'd + was expanded, so populated expanded region. */
+	if (!failed && vrm->populate_expand)
 		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
 	notify_uffd(vrm, failed);
-- 
2.50.0


