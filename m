Return-Path: <linux-fsdevel+bounces-54621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E4B01AB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF0A1CA7A3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2D28DF16;
	Fri, 11 Jul 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XAOwDwfx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O8nLAlXu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02828C2BE;
	Fri, 11 Jul 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233992; cv=fail; b=ed9wlW9aySuVJMn5SY/5HkvZ2mJpH57rgc8xi7YOKLMIq7cQsE7wmTSkZ4ZFELO7cE+P7nlscDkbzsklD7xRuYrwPpxe8dYdpBNbKO8m2oWb8wol7J0T715/4w4qa49Iy8p0oRcUjFYtbcbvmPCE+swuFTLiHX5Xr5wI+b7yki0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233992; c=relaxed/simple;
	bh=M+h6lQRtOP9BtXSSjt3ZQdXZJp3t6ZmzBxqtOdNQWE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=itnUAq0rSZfw6CdwUrlrHiRbKhBk/1nq3xRIT02u37xnX6QozHz163g60wkGMyAuiKE5TZQlumeW8ltR8c7vQi21Mo5I9QegntS9ue2lxMUksIeumLICj/tzcxynQOmP1yaH4XeE68D1isLXXJAFuMpFBDnr4EUPslonyQeiU5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XAOwDwfx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O8nLAlXu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBbMNT014301;
	Fri, 11 Jul 2025 11:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=b3xD7vw8m0RO/Q6K5JRIt6mRvTK1wpxk31Jp9CN8r84=; b=
	XAOwDwfxF7Vdhlfdw0r40QHSEyBQsxP7YavSIrKFNBdryqStNz/lsC4ItKUZZx9K
	NrclVXo8vbCselLiAABHkE0nMpPZo2RJk+Z2PyR/gsTwOXzBEZe+VV+lpD40s59e
	9aoTksw/gVbopoJ7xhpCE6jIbLe/6tWajNPYS6Z5ZidBBgXAk3LSnEdoTHSF/odr
	DaUdh4yiXxfP20cJa465F9n3wMgcC5tc9dPD6ajqVFD5n64DutxmhmAwJxqaga6+
	r0+rVH8eEI7c/FgYTxrz7f7cVbqgWuQ/Lwve8OdCes25elShYNADNgR7uzThprjI
	ReB1U2IQogjqsmJl+8qtKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1w1g023-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B9exmg024212;
	Fri, 11 Jul 2025 11:38:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdpp3n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BukwZstjP5tPQH3KQjVpkM2WTfkNSoK9ef2IHHIlVV+RGLfX+D+UKy745zBqe6s2tEuzA+YiuasKfhTPvkSDJ69TDA2yz3OzOMit8B5Bvm9IWIU52MQ2zIMVltqWFa+rwCqIpvvmQqejonyW9QDn97kWUVgIsuu9lkTz37XhmauAreo1GDGA83AzLXr9H2tTzKRzBHvJ/q/J4eXEeJhPWP2ULiVcfuFlFC37CkBMtJ60LcX1Rf7y4n6adf4zJS/4jgHwkaBO/0LkmfY3SQAuVFjCt0SF/O4cpZaX2nAYpa2UEbG5/hElqzX7elB5QFQTbZ3kQuMmsXV5J8nYIfGgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3xD7vw8m0RO/Q6K5JRIt6mRvTK1wpxk31Jp9CN8r84=;
 b=uGdGZVCzP9jkZ6GrroHniw0ECIPTswbnwNZpaiQyAgxzEJC4n/LYltRlErd+eYZu+tr4+yW7F38iLQOsf1raPpd0GGHmtcBymYpBCv4FFncpd9mC5YXUsL54mM9JZkAbxbXM+pBGgaTU9hqKTHXll+rr6WZK0BBp4jHiLD+zjCGzjlknRf0NTiKMTZoIh4gOYNo0dL7dlanVaj8Jxm6oahRmYOwJgwGi6jTiNp3Z/MUsO/aobYhKNo/dW8gyy8C/ic6s7e0G+rFJufKtplPsdcRg7rzdk/CsfckggUcEs8zam6rZGTitohi/s/C+oNIgG9KyTGpbamOixSA4ZdRabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3xD7vw8m0RO/Q6K5JRIt6mRvTK1wpxk31Jp9CN8r84=;
 b=O8nLAlXu2QWDKCOxrZgvpmRkeG3umLOH7zhG8jYLj5rULECNBUHMHiJxD7tMsTia08tt3i9EtWNu8zxpfEE8cyoB5teiGDAdeX4KQGlJY3YsO8qs6jk9ve2AKrco+Z2W8c9JsN6pg4sC/AMaYjtGxISrh3hWw7wmrz0zclj16qs=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:38:44 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 07/10] mm/mremap: move remap_is_valid() into check_prep_vma()
Date: Fri, 11 Jul 2025 12:38:21 +0100
Message-ID: <93a21f09b6f6e1ddf07eafd19cbb7a328006e52b.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 143c988d-8cd3-4c32-ef32-08ddc06f7dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DACXgG2lFmZwYkQVGuN6iWCphSapDtbvq4oFTRXLApuRmuN/IYa6GaxnwDpO?=
 =?us-ascii?Q?FVWhkMsfVv54xAwXk+87o5osjlFjtbZJDAMe5oVKrfwjbPEBr16rTlXZOPL1?=
 =?us-ascii?Q?ooWUNqDAbN6OiBsokMdh92qBwOqRCRivcIIPJ7ImZ1cF66koCGK9NVklcEsc?=
 =?us-ascii?Q?yWmWbBKdaA7J9xQZAlpDMV3FgNhf/fl3ZgLjTZ2pR4gGj6pYbbS/giSzGBDq?=
 =?us-ascii?Q?VRmvWAYaSfNnvz2B8WA/Hu6szTBiG+nLqL0sNnLrx6uu+bhpHLFlWI/BkMuZ?=
 =?us-ascii?Q?NaNDoPFH2w3boD3QmY3cPRTLaK/hCbAPBWbLbjLZYWsThdGJ4hmrsW5iRsIS?=
 =?us-ascii?Q?mK+ezdy58dQXkRgAm4Lnxtc5wzXD0PDSvG7nkBPqYFUW9KbZ1mAIRvKwlJLX?=
 =?us-ascii?Q?Zy3sBOEBz5K0eX5ez7uYnAv7vuq/5rbO6qF+Nb78+1fw6EKnkN6atKepIP/n?=
 =?us-ascii?Q?zV75HbLoL8BlV1iqfTrobBAFHCaOVk7xe8Pqc8k0zLT365dk8ahVzRGPVfkh?=
 =?us-ascii?Q?bRNniUi5nx+FyU3f2EHMaQ98ssgGc2YIc4W2Jt0gaFb3Q8IRZW1Ug+zgFdPS?=
 =?us-ascii?Q?upD6l1MEs//lD70KRKHRp2RH9Ekt7b/3QDFNInt+tNrrozFLEw3C9k9uMYb1?=
 =?us-ascii?Q?kF2YBDcxiAqOqkYHHOgotD/LWsBPezqv5T+rojuHfGxOjWl0N8Lb40kuH2Vc?=
 =?us-ascii?Q?HYkYasXsYTRwMZutGj+lY6M+z018JptXdngZHUqsjbNgTWmfMsxGDVE6Yymh?=
 =?us-ascii?Q?jzPIdu77UmT0XO12X7GgSIVasSr9Xv5Yjkvyd4GReculYiwOtT8u+5ImMXm8?=
 =?us-ascii?Q?v2aU5+MzsbHVm19jhpAuy+RhdVsf6X3Jnc5Y2+cRrHFhuizI9BQF31fg41E2?=
 =?us-ascii?Q?Ayc6ajnfrfgIS1Y7cNJ4FWgUqi04ydDtMkT6deeUBkYdAR3/DqC8xI0e/rWl?=
 =?us-ascii?Q?+Jk191hH/1SatL5Z6h5uSqkZF2w4hT/0UagHBWK2pttXx6FKYuvwcgLdP6K0?=
 =?us-ascii?Q?3h9Qp5ccB4lKgGk2/60CG3Mf6K10ITpsLUPR4OqTSgn0ZU+9rxaeJew/1J9F?=
 =?us-ascii?Q?OdomwwS2FEvzKanudLExWk19dSsCf0iGcMfvPf+quilTg8/G869OJ4xI+T7K?=
 =?us-ascii?Q?Ht8F78y2P6frQz1SaMJWylrVBH/L2R8UQG4FfOLHzbxU9Y4q9j8UaRsXfCUi?=
 =?us-ascii?Q?nTAaKVKX+j79ir4zHuDxW+3O5F/7JnkRdF/vBuEv0xsRHdvs/ezg7QXgVRtu?=
 =?us-ascii?Q?S+ZFgM+vCUTs42mlU1hPeyiOs5U30O+ehNs6aR7Fi4IeTuw/5H6rAldDMydz?=
 =?us-ascii?Q?ICDBS9hkJRBGyn1mhC4M7zgdBwbOtB+AjjucuIYv3fUDGBH5MM/vDgrnyJao?=
 =?us-ascii?Q?zU5PDq9j2q598qR/YXIb4fuANK9THTxvPdEgA4BrwWbE3TaTwlFA4E/1bnjz?=
 =?us-ascii?Q?+WMSKuyGAcY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g63TUS5z9ryxuZ3G4gNuVT3L9+HN53X5gRwDQ7XK9qEryNTxm1YRq4chQoW9?=
 =?us-ascii?Q?btYSEj/irN170KFze73+2FlVhSsptGaP/ooWAjjhaAP/pOEw00N4bp3j15FQ?=
 =?us-ascii?Q?muLn5Swa7T0R2DMu56y3uyy4oG2h5v58m+eugIRX0No6EXTyvnO/gXoPhA/G?=
 =?us-ascii?Q?4n7/dlMdf3B9AuBL42jUYBC8m3DnlB7sBBM+o+RoSo49Yfl8nlYFmjYLLlli?=
 =?us-ascii?Q?HdV7amSnl0tA8iEx/K2KoNHPwO1xvRsPteWNekIQXj9LjUoaHd1AURCBoNeO?=
 =?us-ascii?Q?3Fwd5FMUumtu3cI8N1Yp7CyhsXy7Va5TVd1YO5vYMVpGt8wsoTJlXwKC65V5?=
 =?us-ascii?Q?MMu8L4asabzxNQ60d08CP6Ty+tMjsUBaoAHB66eji1AXuyir5zWCA73ZVl1D?=
 =?us-ascii?Q?RSMXSYz2FGIYshSTn41s+QNiM2kdEULjKDodDrUtX1cwp2ZnU33Do2R4/Hkz?=
 =?us-ascii?Q?XYsOv63zAT4vhmmt5+FjQDZOjx+KfU3bhA0f8HqyRRABnOCdGDralbp1SJjK?=
 =?us-ascii?Q?lHgPFwMG3H9SHcznleUk5Vgb3MvJH1F1dre15OG4PO1ju/26bmTv0pUwTXU+?=
 =?us-ascii?Q?TvGsWFgy/5sewZ3LARsspt/7xfIjZvfCC5uRL4XsEGX/pwTYEyQEIw5Xcprz?=
 =?us-ascii?Q?kkwVOCTzlN7T2gxcxPm8HgrGEEkiiPLAZ1MJkeVN0h0ZDfT2FMxw12E6jJZS?=
 =?us-ascii?Q?QhpKKnUvo6CgDSB9gO33ZkRJpNir5u2QfuaclCyDrEswSVtjUCvchSvLt4kV?=
 =?us-ascii?Q?9xu6CAw1lNr2t5R9Dg8KAl+errK+92hRjpbTNHacgDL8mN+kdEbp+zvYuM97?=
 =?us-ascii?Q?uJqAgs444liVm312cpmWKKBTzaC5c2z0DhPtSMtYROUACTNHgZhbiGr5jsmr?=
 =?us-ascii?Q?ryrWRdavIThjSEIRlvMrfIRZOuOq/qopnhBcqrT0n6fvdVQCLaYXMe/b0Gq0?=
 =?us-ascii?Q?Y8ewxlPOc2qDMHjKNqJ4FcJXiNdFPc4KF1MKp8BC5BpNqhzpa9rVBrTVQzpU?=
 =?us-ascii?Q?4E6T/9wuokvvKj2IciWvSMukiJxXjh9iploWC38TurgJkFqe7Za4cNNZiOW/?=
 =?us-ascii?Q?KxEdV6v0p2uRDMWKTzclJBQ8dVNTTqKB77fWAjEl0SZpKRF1tzcdCm2gScIg?=
 =?us-ascii?Q?VeX1Tsq4xYK4MyZB1HZ+H8MYY0DUM85hI7FYCTqlH5a8p2Wd5F0t1Oxe9c73?=
 =?us-ascii?Q?KSMK2U4LzSBWGNwWuNTVPJBbt58CqbClXqRc+xifXi0g9LyzNRHs9EYNT3Bd?=
 =?us-ascii?Q?HgoxGyRP2wAsVwTZNQ614IXdvFfV2lXj7kRoNyR5FTgZGTDtCvdZbagJrBOW?=
 =?us-ascii?Q?qeCWhaEpAfGsr9UhthNFlR51ug71jfmAZ1el7Gk/4JF3vc2ccF3Ku9d7+nOo?=
 =?us-ascii?Q?onZcKJ4DHnuOOJxfzh/iu0L5K+gb9GrB/1skSGAIi0mea3Xr9tsZx5G+yIuO?=
 =?us-ascii?Q?GfpOf1eBhOreJlwqIYJUELF1gw4z8OY/hcPLcV1KiPjZdNq9hc30/ZCEBn0m?=
 =?us-ascii?Q?XmM0JMKLXK9Ed31DxS4m6l6UyIHC05zrsE0tXBDl7vi4uBD0w9N0Vi9I+Rol?=
 =?us-ascii?Q?s9UjiltLANd8sOXykhC3o3pVnc/SQTz6+CqEC98J5WRpkTPr9x7hrK9x41Rv?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K3zGebgVxXgo1aIq/nbze4G8tzQVXpGRPzZyA03FC1cLhc+9jg0QQ1t9ywBIeDF0cyC1hzi+KPMJ7pj647HLSslntqiYfvKmAApPu9cPoTnyjJKgmw7lI5HKShtNdJEdHMMiPbZMknrvLDqrZBBM2jHx+yo3hEwyJnJ/CM2sE3sw9L584hCigXTgcJK09WQK3z7gDzizEiztZUB05/wpsxPsE+YUSPXw/5hD1qzzw9rWHjuw0e3R+Fz3UWnrmyQQV88uGPjxlSlg4O0nx3e9qkbjGeLZxIqmqfmfLdkncsUCnO0704iodOwJG8iwRzSXXiRoRf8BxQJoFwMXqS+cbAPbzW0pmOkI7Z75zDYNAz1jMhbWQ80INEgwVJcLMfDtv0pdjJl3bcZChRnM8oq3+kReoFmBm/mFCApl6mnZXZt8H82liWUMZuZzfSdmYbGZProa4xK8pbWWsAQzbmTU9H+uxUVLvv/5wGKvb5xEIe+bHHF21CD/WA1Qqa5CgZbgmb+I8g+MPlk+37OpJ3I6NXalpWdM4YLd0JLGcCeHsZ6LcTVnNECvGalEIY3MXxyFD6dpttqA+lHC5F8iyPbjitRp4CNDlmZpQtBZYTePXkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143c988d-8cd3-4c32-ef32-08ddc06f7dda
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:44.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTlQcudTIs8ZrkQ7jP6QriQh3ID1MnHVi69/zseGRMBsMN765feqJQte8LA0WWkv+Q/E2xQ+/thBh7HtXesuyToeLI50aeSMSKWIJySrxGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfX+gZSTiwSFzea qiNA+mzXvMXq7+JRia+3C8yo+Wi1HavF6yZvgsRsJr+VyBSFMYPMHUr4zcxu6lC4lf165hwRplW Miret44lVMS5Awysy4Radrs9HJGV+39CFakoM04+2uqRZI8ENXBWbmzRCA2gi/ZG+9K8YScHL1R
 5Mt3vC9apaYL3Ygisi19j9UM7lvEe6JwY3bJ8EkMAgjotDuyF0b+c/J3180k1PSGwZtLPxhNR0P kfZy5rXkVfHuIpH4Iy7e4uk2HyKPewOoy95Q80u4brLBAFVa5d+5CvxmfNCTHRu0U3i7iTVTJud WXRd0Q/LpDbZAQoTd8I9Zc+8fvZe3Y+EEjOgnvW7/0+BQIbwLfN/dqV7FQHTIxRdYfc5rrsEPT1
 2fMyu++nuAppUh1gUsB0Et3aXgv0hfo3uW1Bz+4ycsArVV7al7mvlwUSf4fKZ8/hkD5f8Kom
X-Proofpoint-GUID: 1njQdwj9e6kUYy5kgPXbu16D9zlMaoKn
X-Authority-Analysis: v=2.4 cv=FsIF/3rq c=1 sm=1 tr=0 ts=6870f7c7 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JNHyDlmCLAJVxX-Ft_0A:9
X-Proofpoint-ORIG-GUID: 1njQdwj9e6kUYy5kgPXbu16D9zlMaoKn

Group parameter check logic together, moving check_mremap_params() next to
it.

This puts all such checks into a single place, and invokes them early so we
can simply bail out as soon as we are aware that a condition is not met.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 273 +++++++++++++++++++++++++---------------------------
 1 file changed, 131 insertions(+), 142 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 116203766ce0..3f8daa3314f0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1308,64 +1308,6 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	return err ? (unsigned long)err : vrm->new_addr;
 }
 
-/*
- * remap_is_valid() - Ensure the VMA can be moved or resized to the new length,
- * at the given address.
- *
- * Return 0 on success, error otherwise.
- */
-static int remap_is_valid(struct vma_remap_struct *vrm)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = vrm->vma;
-	unsigned long addr = vrm->addr;
-	unsigned long old_len = vrm->old_len;
-	unsigned long new_len = vrm->new_len;
-	unsigned long pgoff;
-
-	/*
-	 * !old_len is a special case where an attempt is made to 'duplicate'
-	 * a mapping.  This makes no sense for private mappings as it will
-	 * instead create a fresh/new mapping unrelated to the original.  This
-	 * is contrary to the basic idea of mremap which creates new mappings
-	 * based on the original.  There are no known use cases for this
-	 * behavior.  As a result, fail such attempts.
-	 */
-	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
-		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
-			     current->comm, current->pid);
-		return -EINVAL;
-	}
-
-	if ((vrm->flags & MREMAP_DONTUNMAP) &&
-			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
-		return -EINVAL;
-
-	/* We can't remap across vm area boundaries */
-	if (old_len > vma->vm_end - addr)
-		return -EFAULT;
-
-	if (new_len <= old_len)
-		return 0;
-
-	/* Need to be careful about a growing mapping */
-	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
-	pgoff += vma->vm_pgoff;
-	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
-		return -EINVAL;
-
-	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
-		return -EFAULT;
-
-	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
-		return -EAGAIN;
-
-	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * The user has requested that the VMA be shrunk (i.e., old_len > new_len), so
  * execute this, optionally dropping the mmap lock when we do so.
@@ -1492,77 +1434,6 @@ static bool vrm_can_expand_in_place(struct vma_remap_struct *vrm)
 	return true;
 }
 
-/*
- * Are the parameters passed to mremap() valid? If so return 0, otherwise return
- * error.
- */
-static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
-
-{
-	unsigned long addr = vrm->addr;
-	unsigned long flags = vrm->flags;
-
-	/* Ensure no unexpected flag values. */
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
-		return -EINVAL;
-
-	/* Start address must be page-aligned. */
-	if (offset_in_page(addr))
-		return -EINVAL;
-
-	/*
-	 * We allow a zero old-len as a special case
-	 * for DOS-emu "duplicate shm area" thing. But
-	 * a zero new-len is nonsensical.
-	 */
-	if (!vrm->new_len)
-		return -EINVAL;
-
-	/* Is the new length or address silly? */
-	if (vrm->new_len > TASK_SIZE ||
-	    vrm->new_addr > TASK_SIZE - vrm->new_len)
-		return -EINVAL;
-
-	/* Remainder of checks are for cases with specific new_addr. */
-	if (!vrm_implies_new_addr(vrm))
-		return 0;
-
-	/* The new address must be page-aligned. */
-	if (offset_in_page(vrm->new_addr))
-		return -EINVAL;
-
-	/* A fixed address implies a move. */
-	if (!(flags & MREMAP_MAYMOVE))
-		return -EINVAL;
-
-	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
-	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
-		return -EINVAL;
-
-	/* Target VMA must not overlap source VMA. */
-	if (vrm_overlaps(vrm))
-		return -EINVAL;
-
-	/*
-	 * move_vma() need us to stay 4 maps below the threshold, otherwise
-	 * it will bail out at the very beginning.
-	 * That is a problem if we have already unmaped the regions here
-	 * (new_addr, and old_addr), because userspace will not know the
-	 * state of the vma's after it gets -ENOMEM.
-	 * So, to avoid such scenario we can pre-compute if the whole
-	 * operation has high chances to success map-wise.
-	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
-	 * split in 3 before unmapping it.
-	 * That means 2 more maps (1 for each) to the ones we already hold.
-	 * Check whether current map count plus 2 still leads us to 4 maps below
-	 * the threshold, otherwise return -ENOMEM here to be more safe.
-	 */
-	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * We know we can expand the VMA in-place by delta pages, so do so.
  *
@@ -1714,9 +1585,26 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
 	return false;
 }
 
+static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
+{
+	struct mm_struct *mm = current->mm;
+
+	/* Regardless of success/failure, we always notify of any unmaps. */
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	if (failed)
+		mremap_userfaultfd_fail(vrm->uf);
+	else
+		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
+			vrm->new_addr, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+}
+
 static int check_prep_vma(struct vma_remap_struct *vrm)
 {
 	struct vm_area_struct *vma = vrm->vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr = vrm->addr;
+	unsigned long old_len, new_len, pgoff;
 
 	if (!vma)
 		return -EFAULT;
@@ -1733,26 +1621,127 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	vrm->remap_type = vrm_remap_type(vrm);
 	/* For convenience, we set new_addr even if VMA won't move. */
 	if (!vrm_implies_new_addr(vrm))
-		vrm->new_addr = vrm->addr;
+		vrm->new_addr = addr;
+
+	/* Below only meaningful if we expand or move a VMA. */
+	if (!vrm_will_map_new(vrm))
+		return 0;
 
-	if (vrm_will_map_new(vrm))
-		return remap_is_valid(vrm);
+	old_len = vrm->old_len;
+	new_len = vrm->new_len;
+
+	/*
+	 * !old_len is a special case where an attempt is made to 'duplicate'
+	 * a mapping.  This makes no sense for private mappings as it will
+	 * instead create a fresh/new mapping unrelated to the original.  This
+	 * is contrary to the basic idea of mremap which creates new mappings
+	 * based on the original.  There are no known use cases for this
+	 * behavior.  As a result, fail such attempts.
+	 */
+	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
+		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
+			     current->comm, current->pid);
+		return -EINVAL;
+	}
+
+	if ((vrm->flags & MREMAP_DONTUNMAP) &&
+			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
+		return -EINVAL;
+
+	/* We can't remap across vm area boundaries */
+	if (old_len > vma->vm_end - addr)
+		return -EFAULT;
+
+	if (new_len <= old_len)
+		return 0;
+
+	/* Need to be careful about a growing mapping */
+	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	pgoff += vma->vm_pgoff;
+	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
+		return -EFAULT;
+
+	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
+		return -EAGAIN;
+
+	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
+		return -ENOMEM;
 
 	return 0;
 }
 
-static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
+/*
+ * Are the parameters passed to mremap() valid? If so return 0, otherwise return
+ * error.
+ */
+static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
+
 {
-	struct mm_struct *mm = current->mm;
+	unsigned long addr = vrm->addr;
+	unsigned long flags = vrm->flags;
 
-	/* Regardless of success/failure, we always notify of any unmaps. */
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	if (failed)
-		mremap_userfaultfd_fail(vrm->uf);
-	else
-		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
-			vrm->new_addr, vrm->old_len);
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+	/* Ensure no unexpected flag values. */
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
+		return -EINVAL;
+
+	/* Start address must be page-aligned. */
+	if (offset_in_page(addr))
+		return -EINVAL;
+
+	/*
+	 * We allow a zero old-len as a special case
+	 * for DOS-emu "duplicate shm area" thing. But
+	 * a zero new-len is nonsensical.
+	 */
+	if (!vrm->new_len)
+		return -EINVAL;
+
+	/* Is the new length or address silly? */
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
+		return -EINVAL;
+
+	/* Remainder of checks are for cases with specific new_addr. */
+	if (!vrm_implies_new_addr(vrm))
+		return 0;
+
+	/* The new address must be page-aligned. */
+	if (offset_in_page(vrm->new_addr))
+		return -EINVAL;
+
+	/* A fixed address implies a move. */
+	if (!(flags & MREMAP_MAYMOVE))
+		return -EINVAL;
+
+	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
+	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
+		return -EINVAL;
+
+	/* Target VMA must not overlap source VMA. */
+	if (vrm_overlaps(vrm))
+		return -EINVAL;
+
+	/*
+	 * move_vma() need us to stay 4 maps below the threshold, otherwise
+	 * it will bail out at the very beginning.
+	 * That is a problem if we have already unmaped the regions here
+	 * (new_addr, and old_addr), because userspace will not know the
+	 * state of the vma's after it gets -ENOMEM.
+	 * So, to avoid such scenario we can pre-compute if the whole
+	 * operation has high chances to success map-wise.
+	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
+	 * split in 3 before unmapping it.
+	 * That means 2 more maps (1 for each) to the ones we already hold.
+	 * Check whether current map count plus 2 still leads us to 4 maps below
+	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 */
+	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
-- 
2.50.0


