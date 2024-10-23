Return-Path: <linux-fsdevel+bounces-32643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487389AC005
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 09:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70B91F26186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 07:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D55B153BD7;
	Wed, 23 Oct 2024 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F76NOYsD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EDvLfzdt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F3152E0C;
	Wed, 23 Oct 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667940; cv=fail; b=tq/Olueit62cLEv6meu/VqB+HtDtOb2mauMy3alr9eU/y/D/nrBDBOsUXF9PtHR/H6NNifWWQAgBEogfUMScP2IY6Q+HY7xedLCsBt6WxqL1UVkrbKFLZttOKL7emq4p+mn6n7y6lIcanE3p6Sg+EKcK5Ey8FtDQJcdt97RvkWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667940; c=relaxed/simple;
	bh=HR//hzbzvfCzKOGQ/X1tRWf4CDyEkCcYEwrs82tYvAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c5gmk1gCE71ooLklxE11JnAlspkvXNobKivtAtGa7Hk3YnCGkOqfIYKyW7/R2UPjjV6GHhc5q5U+ulYnK8AYifHVFc1NfnZ54L/uv60KuzXdLit8aIgzZMbUrKEhQ2B6gXixRVi6WR4NC0Ybjdbk18kKD3UZaduO4Zd75mvQCEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F76NOYsD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EDvLfzdt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLQcAx016592;
	Wed, 23 Oct 2024 07:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=bBLR6oEx8Scv8e1Kcq
	07hPD+gzDgUju6r5RMv/p65O8=; b=F76NOYsDXKTWODXCJubWXyHabe9xVGBcdk
	sMUBowKkYu2C4CUARyTetmnrPYzb9VYOYg1lm1p6pNPJHeLy6ZJ2HRoVkT/F7G6b
	jFofx2N1g/KuesxrUuF3uLTR6WRsn69TNz3DgV8j/eLDbZPIxgJZr6d9JLPQ4Rga
	QgpxKCzEMK13n8umsg/e8WIuG1nQHMacvK0fKpxlFO7X6P+MqUC1Y+rQF/NuPnoP
	WnNVhprQ21cF52Sp4NiK1pdJueAv6VW6zzdbKROxxgDMXrpbO6HWMzIjL2tXrULn
	QVH+I1MBfqlvduLfKiR0Hd02pwTsy7tlNvD8JoBKEJejXWpz97Kw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3ehmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 07:18:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49N6RGwg025385;
	Wed, 23 Oct 2024 07:18:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh95b6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 07:18:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbxoYFVOsKF0Y/btlE+4rY5WjnpHtCATisI26CsILRyk/XX3CtagbpIl4dGQxl6TDaTtz4/Rh6nrKrkAalDdi9vhNrQXrpihMiO/YDhhZje7kVH6gEf9rjfrkDp+BURmD8PAlWJ9Vtsht9oD1n+xPCOHWXr9kQ++0WREn8DWS/BUXCdC4zrx8HoSTcT+YCFXsCAcbPoDXD2AZCTAueW0oUsoR6KhXM44JSSHLIm8U3E15SNiZjwbgdZ8VJN312P7qN9OrBPgOK5g0cRP+3D6fAcEyPB0pkzscL8JXHlaeZKczwjwgswTP7hNh5bjGzuDAX2YifcyH+rQBe3xSVrtgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBLR6oEx8Scv8e1Kcq07hPD+gzDgUju6r5RMv/p65O8=;
 b=h/0sRZNCNIAG975So0ZUhX0Kkj/rU9dlvT/CFHZi6BPgrYHI6ufMRkXfJ12CSo7Q0xcurbcYV0iWYy6s1aD18vDmUet5NJFco3b675S41fwYnGpKsqBp9XiGy10JaibokdOBcWhgsZouZTAKqrCac0TDiOBzIlb09It5lseVXUP0ehD7/+Bk2W8hkjd0xqQ9ZCePg4dc0ME0Yd5d12HFlHB1+z/7A53fZi+yndKSOrVz7jXvfOJx1qpNj48M+ry+Q5m3CWa/Q/4onxifkpj/W0fTClmB3L1hsQRwyDFdGXur2UrOQi4b1sOuo+FjVWz3x4SPSXEcdk5kf4anT6IJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBLR6oEx8Scv8e1Kcq07hPD+gzDgUju6r5RMv/p65O8=;
 b=EDvLfzdtwnKFOY7kq6Xo6PdTY4entFmU8FI0kaXH8/Ywv4Ui7sCceSZCk+vvBGWB45t1VfVMcPneRtVinwOEQObPzh5vf1l30WEEyzR0qe1m5CvfLp9bvWMmeBYrELByoe0PC1GpoRXRa1P0QUMKFbmxpqVylQOxZ0lwpnRgFNE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB7298.namprd10.prod.outlook.com (2603:10b6:8:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Wed, 23 Oct
 2024 07:18:39 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 07:18:39 +0000
Date: Wed, 23 Oct 2024 08:18:35 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 2/4] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <f6114921-d3c7-4092-b503-09f99d98ad83@lucifer.local>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <3bf7f2d8efc768007b5de8122275405afc9942d4.1729198898.git.lorenzo.stoakes@oracle.com>
 <fhy36lhgeedrdwoubuuxarownhji2k4avcherjnedtid35yael@jokjnyb6i66b>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fhy36lhgeedrdwoubuuxarownhji2k4avcherjnedtid35yael@jokjnyb6i66b>
X-ClientProxiedBy: LO2P265CA0316.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb974b8-e8a3-4d0c-de84-08dcf332eaa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MyXgXYzcRbT6vfOfBTGhGsJyRALSDriWaGB75cAXqLiGGFGnggG8HLJAteHe?=
 =?us-ascii?Q?cNFK1JtDzAXAdxhTN1mAlCq6RuhZPl8mJ3dhpG86Jy2k7VNd3I83VVVtUr4I?=
 =?us-ascii?Q?3sPAEr+cnuTFrwz53azW9AlgQiY2bQYgVF1BFPZWiz9h0LCtjr8JiKtjLsYM?=
 =?us-ascii?Q?ZEQIHdc3c9vftgm+tUiXZFK4j45g+kwN0mEF3Wcx4tIqSG/mfIiMmuI1+/PW?=
 =?us-ascii?Q?LHjgSudYi/imse8se4PY8n7oMq2ZN0CNcrpzBXTfx3MNtQgCITLHt7sclREO?=
 =?us-ascii?Q?we6wOXWVqsQjriKNyPmBVCNrocFLpOt/mMiYN1jnIEgrca9P22iyszBu/d0Z?=
 =?us-ascii?Q?dXTEwYu2zIYZ8zSlMIctZUGMgg+gnugbYufQSPpOHq30NZ5HkKTNOuULY19U?=
 =?us-ascii?Q?h3AT+/nSiO52tveveZsb6lLvZqlI/ZKrbWuL6CBGGvReQBokxfXetva52Rk6?=
 =?us-ascii?Q?VCYAoViFfLC96/q8m973Iw0ziqf6Zz8Gp2+hxPGHmdqOPhU6v9qzjBfGALE6?=
 =?us-ascii?Q?7fJlz/VfFDm8OcMyzrPCnsL2PFKUoR3B/e7InrSZAEEJhA8ivoleZOW6g7h3?=
 =?us-ascii?Q?3VqOiJrWOfAqVwtY7c+bxP+vWWQjy14uRuUvdf6x1Fj0vd0muMtbNqNVte1d?=
 =?us-ascii?Q?RCdFYhFNrihwWGhXQ3l540bLgYticGreI+bJAhzQmtJcHEyBv3Yb3GibGa51?=
 =?us-ascii?Q?fqkqz4HQZAIc0ImMfGIdWqteBEe7plIAUcSBlhqZh1598XprO66I8tPO3itF?=
 =?us-ascii?Q?uAqEuuPsmGRPGd9JRjI5AGPftXl5h6He8VgVepRb68iJNLuBEPJwWmSpAyFK?=
 =?us-ascii?Q?rl/WZS+AkWhCYSas95a61EvEpYsM7DoVcAU9bg/qxrGPWtQuRuexE3d04+9x?=
 =?us-ascii?Q?tCwP2ycNuHzX2fkbQqtxYJVmtbRzeqa/dLXWOPPMDxtRbzmpXN8RQAbOIVys?=
 =?us-ascii?Q?5Tp6nwj89Q91NUQM4/c8+C7rS6OPgYBvJsCCsrNKhh9hGUFWLa8163uEHFs6?=
 =?us-ascii?Q?DhK6tg6lPrNx/UdtoovIXrnde1Cc8gtJeS9xyr+6+sP5SakCb3+84bgoySba?=
 =?us-ascii?Q?7hrwbLqSndgqZIltXkjU19ZlNq0svbeKWo3N/j5h8ATCFVFQzg63XkRV9LHJ?=
 =?us-ascii?Q?4DysE+aOJPvmaBmm+ZcUa+e5+rs0CVpkXiXm/drWwYmTSKbPGhj47XRA77MU?=
 =?us-ascii?Q?Qy8LjgW3RM3wA+oYmovvTOutOlOm1VvEqgTZcHLeFWaEy+95EXsjwYLtgYkg?=
 =?us-ascii?Q?Sjtd5swxd+TE15vbB0DdPuU0gHlg0+DQ1mzjC1uLOC5YWz/mfYktxkqCVmwf?=
 =?us-ascii?Q?67U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wWga/6oYFJKvFXPREO/1GY9vS8Z1PCNjDRcbUTQHVY66ishrWVLuQaUA3MMz?=
 =?us-ascii?Q?/HTr+Dm3HXDX0gTq0mUxrLCsc5FmqWDZA/mzoxZue7AbkgBCTSyNIBE1TFLR?=
 =?us-ascii?Q?rzmnARytReYOFwbBMbdKR9IAiTHirGwLOovWgTMJosTTJFpomjh7+JkYkgS1?=
 =?us-ascii?Q?s+7f15UqriHlzORtIMVcBqfcNtlPSPqTYFuMn1F8jv7IP0QuWs1+vhZeLZgP?=
 =?us-ascii?Q?+hZRswmXSHquYdWLHIkH3Nhib3QmRwYEKIz+E+AMKig0YdWUl3+7fJgDxDrI?=
 =?us-ascii?Q?X7kgwXrLmmw0WOKaJuUzJxxY2ZdhmHDrN/Y0Em+FRuSLNyWs/epiZI8KJ6gk?=
 =?us-ascii?Q?5CtbzLGT3LevFlsRYyuewi2Slwlt3Aw2U7Z+xhWth+6+/ISm4rl/WhgZ7YcL?=
 =?us-ascii?Q?ODqk/yzGSyPEDa0ZNv07xSA162Aze6jiXEtKyPU3TfITahjdoWoX112LgBMz?=
 =?us-ascii?Q?jSyZWgTC+IQl4L8Fpt0Bp0Pf+x0ZzlneyJNNXgs7+5lj3TOTTqCu1zzcEKfn?=
 =?us-ascii?Q?pWr4A+IZaEzG+Nz5oK0ofyOwUZsCvRCtGGbIQNZoa9LQm4QqnH0m/4WJjRhq?=
 =?us-ascii?Q?o88C2rVaxoNEwOaY+jkEKoqmUxDH6HwPcVMYqsJ6RaDsOeT4yec+D9WEqE7k?=
 =?us-ascii?Q?7jnCDyoYmOB/za6dEgsNCBzRygjdrcM2BnL51BDVhgSvN+ymYmRp/MLY2IzU?=
 =?us-ascii?Q?m5JdI3G3KMJXA0RRjcsE0lRUKHZQceG7IG77uvHMxhZYDAOhBBFxxaQyqh6d?=
 =?us-ascii?Q?gBlpAM4cJd/tZ3R/B9V8IzDGH7nCguuV6DAXKTjSZEciKbssRvgW7zqnWK1m?=
 =?us-ascii?Q?a2iOf8yQNEMKnFy1biZx9dwwdfCkwj7xhIXZvv+CjzIwFqUFmE1O8shPmbSV?=
 =?us-ascii?Q?wSSOZT6qDbAB83ElpnH8IS+MxvpJtzxw8mo5pTERV/VRZusrXFouGOCi/0JV?=
 =?us-ascii?Q?a/FS9smfYr4synCmmb+OCbMRK/KVLptfHWV6BVlPVti03PR36m8FIN0TYonS?=
 =?us-ascii?Q?FY+UvhQRBv6Ys8UMCISDJbV5yXX14uTxJQ81lFy6BuUjcLDgsXQXF9o0lXAI?=
 =?us-ascii?Q?E00AkQKL0jloyAhSuabkmV9p/hU1aAO0HY3hMnFnVnIuSyEahRfrd6XvDJMf?=
 =?us-ascii?Q?YMVcWAK4feiph/bNy9+qCti7/7uP3mnBI+CiH6pjxbkACM/jVmoEhKiRzpum?=
 =?us-ascii?Q?O7oet4P3gIxdh11q3X9fDNrvXsupFQyuXOEDuoAwWLYrtHmsl6OXvCOmUU15?=
 =?us-ascii?Q?bDrH3xfhQ+piQBJOxwuEhaTersgKgIXSqPojhsHwHM00Q9VlzBt5i2JtFkzC?=
 =?us-ascii?Q?pZD0rNwmGgqHvWh69bFF/jU9yXyvOdMYmw5cUiCPh000997/2L/xl2I2QuiX?=
 =?us-ascii?Q?k41F+l2J25QRQJq0HtD8n8kXLvd7b6N4jvlApiQRJy9+jRcgOLdenQenE9xn?=
 =?us-ascii?Q?TNiG2k8xudCyQcINKYt/qkDCgxWqeRsu1TusaGazA3+9vt8XwVn1DAsdRe7W?=
 =?us-ascii?Q?V2PpzX3U9bcBvxA961CrPrV5cq1KW0ku5mn8H5rBW/+bL+2qpHDWSeW7Jdqt?=
 =?us-ascii?Q?KCal5InSoVjfn0DqhLIbTIpw3qasspYtDngSKA3dx5uFv25fU0sT4MmHLZ89?=
 =?us-ascii?Q?YG1hud/c5dzKLnFSBwQkdPY9yzLZc/QtcnqMrI3T5WPz+mOTzfwSSdpA5ASp?=
 =?us-ascii?Q?dNy44w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JUp7S3Y7ybiHgAWrio29wMoQMjDjRTlUt4f3TTQM5gtj2khtfGAbZ4Xuy7G/zZ615Q6b5M9xQd7fEuGIzOiVfGy+HQK60B+4TS18UkWethWSM7BUp8rUqBwN1CIy4+sBe6iZjjadxgZ3BgzRUM7WoQmD/aj+fOrCb6Hemr2G2o1shyKHxbIRgtmR7EPN4kXGjRmZlh9nnPAnA0czBJ+ZBTRtQsxhAQdnUIzqCX0B7h4H/KmOkT89Gd02AB6W9ONi8i54IUDW9P5LhVGjOyG8Jpok651aF1Xw4j0dtFlS7uhLKDqmunw4jaiDpYAaCaHAVCPhnVCgPwVFukcIe/yTEKMIPBmxmw3XZyLkHJmjPZ/AjrdDQnAbMpQ1jPrC/HM0/ykKfJCYEoOENWEyKA5kB3OWyhmGX+vlAlKnEwUwkSu9Fi2be5v1A5RGzw9h5e3f/FopFfSrcBN+kmtICg3MDf/oUUD2C6aggazF/4NpBxrYQH6UVl/Wybm78A8NKDR6y4jh+SPQMOqkD6NhHU2Nc21xBbjLb7sLnKuJe9lnD3ZxsFHYZOuouj1szTwfBAMVJyCtwSkAh+m0JdYIJSvnPhoFCNLGTU3OjqJ71VIFZn0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb974b8-e8a3-4d0c-de84-08dcf332eaa0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 07:18:39.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gP3ZVXQmldq67UNGFLe5oY6/nAMQVBkPkeQPN/TcWst05zf+u1/bg4w9bmXahSC9B0beKS08FzGhlGxtwEouaG6b2xREPPqjG9ofSMViduo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_06,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230044
X-Proofpoint-ORIG-GUID: 1jOczw_FEADcYdKZF94LXkzlg_liQG1q
X-Proofpoint-GUID: 1jOczw_FEADcYdKZF94LXkzlg_liQG1q

On Tue, Oct 22, 2024 at 05:53:00PM -0700, Shakeel Butt wrote:
> On Thu, Oct 17, 2024 at 10:05:50PM GMT, Lorenzo Stoakes wrote:
> > It is useful to be able to utilise the pidfd mechanism to reference the
> > current thread or process (from a userland point of view - thread group
> > leader from the kernel's point of view).
> >
> > Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
> > PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.
> >
> > For convenience and to avoid confusion from userland's perspective we alias
> > these:
> >
> > * PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
> >   the user will want to use, as they would find it surprising if for
> >   instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
> >   and that failed.
> >
> > * PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
> >   have no concept of thread groups or what a thread group leader is, and
> >   from userland's perspective and nomenclature this is what userland
> >   considers to be a process.
>
> Should users use PIDFD_SELF_PROCESS in process_madvise() for self
> madvise() (once the support is added)?

You can use either it will make no difference as both will get you to
current->mm which has to be shared. So I'd go with PIDFD_SELF for brevity
:)

This series and the prerequisites I already added to process_madvise()
already provide support so with this in you can just use this for that.

>
> >
> [...]
> >
> > +static struct pid *pidfd_get_pid_self(unsigned int pidfd, unsigned int *flags)
> > +{
> > +	bool is_thread = pidfd == PIDFD_SELF_THREAD;
> > +	enum pid_type type = is_thread ? PIDTYPE_PID : PIDTYPE_TGID;
> > +	struct pid *pid = *task_pid_ptr(current, type);
> > +
> > +	/* The caller expects an elevated reference count. */
> > +	get_pid(pid);
>
> Do you want this helper to work for scenarios where pid is used across
> context? Otherwise can't we get rid of this get and later put for self?

Yeah I hate doing this but it's to keep things as generic as possible and
to ensure that no user of this logic accidentally drops the reference count
unintentionally + to reduce churn.

I think doing it this way is better than trying to special case the put,
and in any case if you did the 'old' way of referencing yourself you'd have
ended up doing this anyway so it's at least no delta!

>
> > +	return pid;
> > +}
> > +
>
> Overall looks good to me.
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!

