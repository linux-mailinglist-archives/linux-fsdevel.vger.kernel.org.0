Return-Path: <linux-fsdevel+bounces-55270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39BAB09253
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D16E3B9C7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974432FD5AF;
	Thu, 17 Jul 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZN7pjjLN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vQLqYmIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1FE2FD599;
	Thu, 17 Jul 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771412; cv=fail; b=amv6JwbteVdrdR9W3oZCue0O9jOim1S9AuEFtrr0mZT1j8cPyrYWPUOIyEoQV2h15VMDrsbuvZxplOAyOOr8Rq3xtui7Z5b4RcY+0lpQzk8JEgH+f2A3ME0IZrH4g1aq8Yp5Udf2XpRorffe9R0nVq9w+FadRv6sR2ViWoXEZ0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771412; c=relaxed/simple;
	bh=NBrT1Od29eBbfxjcaH2a0zs6Sy/iV0NDAMrC5PAcrNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqpliQj4uUGQ4dGkuzXBXOB0KcSIdJnG+mIm2tZCoqDcu0OlNlD3RdF3odkUxQPthRX6KjgSwMd3e+T8D/2nBL8SX0cOJNXnTPxJjMX47Xjq933CgxgBCbfTk8KH2QIG6pGHY9+qZtL9Q4sFOHJy1yfyz56kD2GRukZDB+EcPMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZN7pjjLN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vQLqYmIN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGC7OY010970;
	Thu, 17 Jul 2025 16:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0X5s0Gy0EuWbHF8uqiSSwLL8tE5t8Xwe+P+OfrrxOaY=; b=
	ZN7pjjLNFUbJNtjFOxm7N2od7ffFKEPqrsbU53bsSsbsjRkZmk1rxBK6DBZBga//
	VF5bxF9g4Jh8GHLZiELeuGqqSa5lPd4nqzyW/NfD4nUzGC/o5ongNBZIP6JOMX38
	qzf6OSFAWGM0DgtxqBV3ZSjlUXZ2nzpcxiRRhBzPGVPCTDKn3zrqV0aFU/5Z3wyG
	WHpKCmtNp4oGX6DJWd+4GT/KRHaQ9kxPmPYEYrFjwByXuLHgYJ5XG0X5zhQhJIqy
	18qRjRb8m/YF4DLrkgRhSRaM/idy72aPJS8UvHjcbNAyAEwqdiCmQJR2FBwihk1S
	kw1POLG2Z8Q+3lNaVeEBww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx83smn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFGN0C013788;
	Thu, 17 Jul 2025 16:56:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cgruj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6pF0/dvT4itaVC86HRSeL0DPVLWOX3hyhAXZ5/UeF/Jr+WrXPvsKSoZlRGdQbCQz+o17ZZx17nuD5ipgcK5FjUGL1PhkweO6Yxir6n2XULQWX0OUWm9LSe/6xUPVseba4uw8CwyyoYI/+D0IR1fSnTrAg13uqQFRtAorFMgxVKyOgCl5ttSaUbzjCamIngg3YAJZDl2QkwkknhR99OW4fXTdMN5XS0Z/R/dssA2opHfqXzcwrvG02U+3KNFSaEy9zOuFh1KlZyKQz4EZVeDneGDf5tgdMLXFTXd5tvYB2fHOPPfnTPpyJbQ2pW/rX7hgjQxTvKzf00N4x3/WBjgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X5s0Gy0EuWbHF8uqiSSwLL8tE5t8Xwe+P+OfrrxOaY=;
 b=l1QOmFTKk2FiOhlVySJwOlieGxdWO1Sqf5YH7DnsEm96H5t0nURbnhi9/azuqmthdEmi9mNaZS/yjtCV3hQneCe5rzTWvm/d5hRg2uQBR4InJcYKtFqn7yv10J5LHggk2sFkJnwdmkJIIMvY4BP64ZiAUdJphP+5I7D3b315vxunLElQzhQUwJfRdDJ8Wnmq9Dn1CnMRrsINUKD/WvqZuTGgmUlP19BDduaieWzmeBzTTOHFyp8L9cPdgy1sdbB2V7kE9ziil4nI/afBJonwUTp3xIM0dsDY9muuWFflyW6QgVvyjeK5/hKJ+BVin/QETOtCtddrGyUwfNI+KarPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X5s0Gy0EuWbHF8uqiSSwLL8tE5t8Xwe+P+OfrrxOaY=;
 b=vQLqYmINMCX+EXetPbeJVqGsCjfso11GvxsXEs9GKYKik7JKZrS9id38O9JFNeR5UpUTqvomCMTmMNffBupNvX9W9DERZtsEFCPaVZK9XAp+ytYrgtlPIK+aIv6I3ggRWy+tq7Ft1hrMFXj1ED0y+CDF5nko7yGrM/UlgD6ZsXo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF66324196D.namprd10.prod.outlook.com (2603:10b6:f:fc00::d22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 16:56:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 03/10] mm/mremap: put VMA check and prep logic into helper function
Date: Thu, 17 Jul 2025 17:55:53 +0100
Message-ID: <15efa3c57935f7f8894094b94c1803c2f322c511.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF66324196D:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b9dc34-6f08-4209-8341-08ddc552d62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/JvltEUBo2x2voFcJHXb8yhzLq5SdBRLMUgEl4MpQJt/1XEQKoVECqXTOJsV?=
 =?us-ascii?Q?XUALCSqixpNEMTRrI2qeOnDjDo6CrahM+orFOztW1SW7EMtfPdKWp2fbMalo?=
 =?us-ascii?Q?gS4hyIVKmF7gC+/QdqKzbTvxu1CHQjoCpVms52iRfuyS38OniS+ISDSlVNOR?=
 =?us-ascii?Q?UtkgVvGCVvxBv67+DwZm5tSW06x5hnKzb5vqoQReVHP0R83FptRrjGhNGtGX?=
 =?us-ascii?Q?lXLyX5HwtQIdkf4+DgnSxj0G48lA9aIn2KyUAK71ciQNaTDikzCcPa7mXQcT?=
 =?us-ascii?Q?RLpiB1eo5+OXMjTmITyWfxk5yhxmY5TPw4ss3+qR2h1w6wnFR04Y+aGqNdO2?=
 =?us-ascii?Q?+QePNPnM69VSlbbqqyT6wTPwaNdmVRJGMaldQ8H8cbnxBBmn+aVEazWtdCZB?=
 =?us-ascii?Q?6v+TnViQeSb3H2x/pn6EL/vgCuWjkq+NAFVTIMjh7ASPhmuIMnkhrh16ynGi?=
 =?us-ascii?Q?V+QKFSTXKu5SJVOxmKfKRpP9aM+GVhIXiVOtG4RBxUx0OSN9o7ZKstMtZ9T7?=
 =?us-ascii?Q?Dc3I13mGgrPolTE5IDz5tHQ+8IywoUM7nkt56/0hdbXL3fpDScJll20Q4/XY?=
 =?us-ascii?Q?H36PFYPhISC2ouljhX04dLdvPUVU8rrw4PdVSe9bzvCkHdVCG8lVIckaEmVr?=
 =?us-ascii?Q?gPtz7xi/pvjWymCWUbsIhsoqOfS01vLc7Qnrbxz9CqLvVQ5/XFVYHhs4fYXT?=
 =?us-ascii?Q?rbKK576CKSXWB1eQpNoHkTd0LSa4bg56RqFAJXXXHXv+FSOGtWgsC7n7oWaO?=
 =?us-ascii?Q?bhNhLBayv5LSVZmBHrSvGW5nAJvnCIRtgBf43DP6mZzba0aj9nZ/9GyWXb7n?=
 =?us-ascii?Q?h/HV7BKLFdt//7DPJVK4Am14o4FERZk0KxU/9H0t/avH/pUInCKjiu4Y9+nf?=
 =?us-ascii?Q?kT1uyZk5Ig0c6bBaTsrvDJeNSw2SOR41S5bGxm0OIKDx8CZSz2xsiXR5h8hU?=
 =?us-ascii?Q?JNHmKm4lICwQ7dOkFo0yXJ/o1Ma3PT0CNx2ZherD4xQKY1lawW6fOUfQ1n6v?=
 =?us-ascii?Q?7ha9+XGXuYI+RWh2Ed8yTmhWLO0IgSkyZ1gtpz9VDQnzQ3D3B70Qkkp2q1C2?=
 =?us-ascii?Q?bF4FULpuIsh2Of+q+t4eVVDYG1cAA663zUF4FPYahAImWMlOGOGmw9l2Kowl?=
 =?us-ascii?Q?H2fiTUOMP3rtFY4T2ZXH4y2i/crsfWWxe/ZSlekAylW737tJZdVKEVRN2bR6?=
 =?us-ascii?Q?t3DRmvAfpuN1hxxysBj4TtN7Wvh2Qe7NFFj0sPPtyxBZ4O3doHR9RX3IwiCG?=
 =?us-ascii?Q?rkbFD6a+2UAny+GzAGk3wbw3GMT4n4ceRgRk/SbmADuGwFp8hY8ITOWMhEfK?=
 =?us-ascii?Q?YWrLe7Za4lIH7PDw+Zo/dyy4iimErw7+ZYOoJOKax+5eyVVmfoZ3ZIjyc5gp?=
 =?us-ascii?Q?HG68oGZ+WSq4PKRjFpNdjJkZCfkb+d6TU8+ipnMOls2pvFxV8k6qmyaYcto+?=
 =?us-ascii?Q?HNXJXVpM9I8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pEKr6+AZx3RxHJMdw0zkuNSyfTXzrMkYC7U42dTo+oChtvyf6KLav7WtNKha?=
 =?us-ascii?Q?/R7vYr95gKZgXeIJCUT6Bt347U+rjwb6+4qhsM7UbqLtx3EarZpFjf1Cww8m?=
 =?us-ascii?Q?tiZcMOzOZsU+H3aWUcwczmZ+RfzmQ0Wp3A8fyBh/IT6HeRJYukRcNC5qJo1v?=
 =?us-ascii?Q?fij0c4tQH3ZNY53K1nEL/gMiSMpvMNxzPA0eP4NxbBbqVsZxs4gDZED57xdv?=
 =?us-ascii?Q?s4hYen/HI4yqZ2Zuj3bF1zpqaxR+HYSTI0tL+qj5NBg6ZgnwBmFJ+tka2y33?=
 =?us-ascii?Q?kdbFfST8TtCxa6yJ0Fp8pgS6yLSqskULV1AYhbwYIJQVY2mbvepNTtleaAfn?=
 =?us-ascii?Q?1nhHQKuh+UulqxQ7fkTJvjv8arzkY4sSLr4prUpdbljTrjVpmqGAfPbLO4Ry?=
 =?us-ascii?Q?11cpi4l8w6qzWQzqj/l5n3q3CW0S3awhOtni6xau9ptcCYYFNIwJ6XS/Krzl?=
 =?us-ascii?Q?gyuOnfbaBTD2Z//nEdowEoCQYvUmhDAar0JCXTIehTO+cLF75fZAD/EyEI98?=
 =?us-ascii?Q?KmP+M41MGeD3lK87ahUce/gNuP12n7cgV44jTnd8aqiRMZnLkYamcEwCE3tD?=
 =?us-ascii?Q?msM9LzEZg4Dqb9uo74d8h4mlZDicpXjfySGwmMDxziWWKyUHThlgExeuEVMb?=
 =?us-ascii?Q?yUpy2W6Q+barbsNi9XtA86+S8LkEYv6RNaqtBwTdIoUDu2C8YkVjx8PnTUHo?=
 =?us-ascii?Q?5qsCOUnnGxMYhvHtV7OJaINgfvOU4LsbS82qPgyqBPZCjPVnY1F0bsV+nGT7?=
 =?us-ascii?Q?vk/g8aV1HihxEK4sdb1JoNUm5nx2sdaS42//bZLeo1SQszX2kH8X9pZag1I9?=
 =?us-ascii?Q?dKlDYCcHgtbkVEg/CfGpBDWIlT3HjWuavi7+93Qn8GUyf+LA6tne4lbKWTdV?=
 =?us-ascii?Q?aWciH7FYaiB7/lpKAe18GTfHW8VGpQrw7Z+zSUoJKrcxbvENDwKSl6EVZs/D?=
 =?us-ascii?Q?Lh79QOnsHyRzdIqC3MsFLLUvHwFR6qQgIvGYsiX9/p2L16lffhwiqJDrHF6n?=
 =?us-ascii?Q?JEaCNdjPvEvAS1Ot6xalk+uvDTi5yJPX3c737JjrBsE85W6nbSNwlr7AADjH?=
 =?us-ascii?Q?MWGiJinQLHXUtr+YQ3lPRw1EwdUrUjA5M5Qhhjqk/smRyOXBcIFKcylw8K/H?=
 =?us-ascii?Q?wSyjYwK4IzliWVqo7rGBx/2oW8PPb4LSnhGqmA6x6WKI012kB/t/AM2+MMkl?=
 =?us-ascii?Q?cwWsF2dU+2MolNxv8ynZN2n4ECglBEMVq7mgLOzF75/M0pp6mDqjzlc1xjFY?=
 =?us-ascii?Q?QLCYUcTioPLispwgpLg7Dy+ni2QYjU4iuIatl9TTCjpCCaRUoDcY8Yr6VGw7?=
 =?us-ascii?Q?WvVc8h8LkqBcooWwYGfcpbTdAnIKNGG9ERw9z+T8nSVeBfKE9Ii4fCkbmmSi?=
 =?us-ascii?Q?JG+WCOfFfAEWz26UQGqkxm6PeYUgtsts5tfJ+UuRtza5JEMCqmHgLBK6Boj1?=
 =?us-ascii?Q?q0KFc/dQs0NqGnHb9APdWiiiBJXdpM9SNnKWkYx5JYFD/LPUqCSW+jPdtore?=
 =?us-ascii?Q?NGoxYfm6vvswGGijR/J8t7x6ym9rPq6OgNEsvm9HNPjWojyjGZ3YoHkpY7GE?=
 =?us-ascii?Q?EOY/zxpy7b1iEfEFFMwedMyEfkG+3bWtK7WrqbqTfkE7LSpu/yKtSN8TnzI7?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Eil3n306kByLWoGBl1sSgEB+SLgKy8X1Wo1UeViGbOswOda8pzhA+zyxvcjUhF6Ezw4ptQIFMC+NtCC3y4XjHXVG+j/vt4ew1R+xSIHGUlQy4BtyIVAI3u6QlfkRghfXeH50h0f0eb0a9VtLXFDtAt1Gpy1dJDFw+FpfM4fYe99qNSuGlEbzAxQw1r2dhXbZvYyl/kAj9OY38UVX/HbNvBiZnchJq1087UvqraiObeDQaKiV4ihx+tCd9zVtJInfUxJMGLjA7Bqvo5R3qSHlWdyjU+yvOCDi3gksCFfkvjg0GeOg7BRbDUNuQpqThOfc+5HLvvNFtqhilcFItDOPz7wPdLhSvmio+0+J6LyMiO/C3NSque1K6zMOXZhTFjBfcDTf1Xekess2HGO5x/+s3g4CiSoOIFe3igZE/SA8cRixSz7hKnIpvyieMjOi2obT+UIbFsfuGLEYFubYtsGI8YdGuLmjywSsI7J6ral5NbKRIYZN0M+HcrsUYuu1K8ogQQItCEco2RjHZkC8FZhDy4msaHYH+vcjlIo9kvm7zxBW0fpM+LWB17JU7k/IrEaGzulictn3XffpcRtof225YgjPV24TSTc1xOsGj848QMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b9dc34-6f08-4209-8341-08ddc552d62b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:12.8203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtVqHFJLA864dqYPX2Am/HWGLd4a3M6to/TgVNMHQoCdN7h4/JJaYbcV4oARGHbVMln6U259BjJyY5d4kc9mB9ztSt1ZZWMfUxxkWl/xSLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF66324196D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170149
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68792b30 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iY89YN1uBm8AvMjWrUYA:9 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: 6ZDFOisNltkhtHU7025rxFElSVUnJlmm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MCBTYWx0ZWRfX66CfiM81N6QM sRX3loAK+PgppU/logIQWiHYdB6nG5yZMIXBrbUrPbpbQNlJtynZx/+3aGWsevWSdZlIf45BA3I GBRQF1YYflxWWekRV5Qj26nN2+kryTlHCW+fTQ9B7dIVGok/eVMsuiGXvsGQbZ8R1U9Wzpx+ANr
 ic5ImvsF6nb+cfJv0FP/jTGBTO/VrT9FcRaq9AjMkrcy4FTyU4O6mIXxCzZPoGt8cHXaUzqesXP g8fPrRLEB8rTh/OiDkpVvMbyf4m+TVczMmbveUjzsDGDhg8WXFRuf+vWmSSlC1z1dFAaeISHvPM AxM/XqeWUZ3lGEZixjMnM57siMO1G3G+1IThBYahSesjZTwjpZZTcs6uw5ecv2BRQRuZ32VWgJG
 BUEL7nNWJxserxH5m9HBRlH96uh0hIM2hHVEnARFOqj988hiuwH0zMdKZIbHgDtOnZEIqlCi
X-Proofpoint-GUID: 6ZDFOisNltkhtHU7025rxFElSVUnJlmm

Rather than lumping everything together in do_mremap(), add a new helper
function, check_prep_vma(), to do the work relating to each VMA.

This further lays groundwork for subsequent patches which will allow for
batched VMA mremap().

Additionally, if we set vrm->new_addr == vrm->addr when prepping the VMA,
this avoids us needing to do so in the expand VMA mlocked case.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 58 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 9ce20c238ffd..60eb0ac8634b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1634,7 +1634,6 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
 static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
-	unsigned long addr = vrm->addr;
 
 	err = remap_is_valid(vrm);
 	if (err)
@@ -1649,16 +1648,8 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 		if (err)
 			return err;
 
-		/*
-		 * We want to populate the newly expanded portion of the VMA to
-		 * satisfy the expectation that mlock()'ing a VMA maintains all
-		 * of its pages in memory.
-		 */
-		if (vrm->mlocked)
-			vrm->new_addr = addr;
-
 		/* OK we're done! */
-		return addr;
+		return vrm->addr;
 	}
 
 	/*
@@ -1714,10 +1705,33 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 	return -EINVAL;
 }
 
+static int check_prep_vma(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma = vrm->vma;
+
+	if (!vma)
+		return -EFAULT;
+
+	/* If mseal()'d, mremap() is prohibited. */
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
+	/* Align to hugetlb page size, if required. */
+	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm))
+		return -EINVAL;
+
+	vrm_set_delta(vrm);
+	vrm->remap_type = vrm_remap_type(vrm);
+	/* For convenience, we set new_addr even if VMA won't move. */
+	if (!vrm_implies_new_addr(vrm))
+		vrm->new_addr = vrm->addr;
+
+	return 0;
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	unsigned long res;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
@@ -1731,26 +1745,10 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		return -EINTR;
 	vrm->mmap_locked = true;
 
-	vma = vrm->vma = vma_lookup(mm, vrm->addr);
-	if (!vma) {
-		res = -EFAULT;
-		goto out;
-	}
-
-	/* If mseal()'d, mremap() is prohibited. */
-	if (!can_modify_vma(vma)) {
-		res = -EPERM;
-		goto out;
-	}
-
-	/* Align to hugetlb page size, if required. */
-	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
-		res = -EINVAL;
+	vrm->vma = vma_lookup(current->mm, vrm->addr);
+	res = check_prep_vma(vrm);
+	if (res)
 		goto out;
-	}
-
-	vrm_set_delta(vrm);
-	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
-- 
2.50.1


