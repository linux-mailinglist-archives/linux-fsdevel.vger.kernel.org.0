Return-Path: <linux-fsdevel+bounces-27431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A55C9617F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBF81F24717
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A351D3623;
	Tue, 27 Aug 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cpemDBA/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x4+41gv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9791D319A;
	Tue, 27 Aug 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786812; cv=fail; b=aOpgFvGpKCIp1AkzMo+U4Nm02z6/ztsiebNu7WQ6GzwuckaS8e7y4jcXcyfKi7cQ7Uay3vfn7YUXp9+6Hk3U4Xb+zHb/ShzRmCVXMnakDX20BxfAZ/2BOEQfyFAyBeUxeluRsUXNbXUkxz5W45xiAVxapk55frfAfqjTxvVGCdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786812; c=relaxed/simple;
	bh=inIrylw8SYiIBxIWpu6wMmQ6bS8nPJbUfgITiceTF5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o/nN11wQpiyJ4cBV3tG2WQL492jIzBzwjiVGMpbyFMefyeMEv6lG66BMsDIe6CGWalVEWFvDj/htXdUK0XldbUg6Um2As0Dd/Fvy3Ba0DJp+UFKNTsk9ARDujidF9LpPHM1C/lCjgaz16eZ6jr3oiJb/1ei3HBQF/svbzQZBje8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cpemDBA/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x4+41gv/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RHMs1w027033;
	Tue, 27 Aug 2024 19:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7L0jvJzxfJOrSn6
	DSWHa94NrQOHRzB4vhKnwkNQxfzM=; b=cpemDBA/avThZADPv9tXF5nbIzB2cA4
	Oar4gOMdKtRRSSMP+i0SwFKKsBS2tIQ9XOjzn7QKTExZOEekGzJ5W/pmUYFmL2Uw
	xw5nk/0AP8vvU40w2/hNY+1lrJlZKCAqgKnil3zBEfzg/q0yt8z2EcZF2YVN8JMp
	lNUPHOHef2Rx/cJiCpCUtciMS9Wf4DOq+rg3jNfBENdCS4DM9HKdCudAhGC9apbm
	Vo5SU+vAbbjABEgp4g/p0iqBFitFfXs85yr7nyZD4MORK6GOJNrGvX/dr4o6Ft5L
	VIi2mnCL3HQ7sSRsaMmP92PA32mfbhoR1r0TN4TDTAWqDsMFuxMxAMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41782sxff1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 19:26:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47RJ2pKd017435;
	Tue, 27 Aug 2024 19:26:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5stesr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 19:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tn3D1oqGrFn1wee394BQv9mfledTjqaJQogzYVP+sCrq6Whwseekb7sgmruWdrGlfPxGJHuKB2e15q5IjFmhCRpqh1GfMy9ryDPR2Jl+zXwu/M/3i2kQoKFSh3wU7FsyRe1HZfLINDl5ded/y6cjavK1akO9kfw9VLFccl+TS+TfF9eHyrN/Au7EUKNyN50kTllj2ik6KbGNNr1jZAL/R4UxWpEUS/ecGyJ5+tksiILe4dLoP2vP4ZRNSqsjFKpSeSa8jlAOb7zaMNwsil4q7QcCATv8mj7olaKJ+sONJ5GiJ8oKeNUOsKgl77Yz5VG5NJYyp+QBoDv66rByx1IlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L0jvJzxfJOrSn6DSWHa94NrQOHRzB4vhKnwkNQxfzM=;
 b=jiULu3uh8ZxtVI/RmADjuXEqTT9bN493LZrWLvSIfkciGBqtbWBpRHVVb6MXcW3Ec1RmCKd+arDDbJqx27o+h9cI4enQabGAq3o1azaAYXov1eSgWcdVO1VbXvtNRsvw9IfMH7ZMEyyH05eANiox/Xn5PMLmUOs6UGXtiK74I/IBwcAWOMDGMX+ZguFp5QO6MuIVIYseRbd+4xKAej6QxDE4WZVjSgN1QoBMXQw1PpjeBSJIUKCoZ6fpPuuWP/DIpFCULtwVX6sF+4vNAGqe8G3fxBjAFrZs+r8O7KhvAJX9BGB4kUnIzYyBROa8Uz3QuMlqR8rVW7AuL/kMaZxZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L0jvJzxfJOrSn6DSWHa94NrQOHRzB4vhKnwkNQxfzM=;
 b=x4+41gv/Csu/QoyE91T+b5k/lFPbv1Q4dPs09Zufp+q+vLXmclHiV3tgkFXH0U4qLVTMNyHrTwTA3i1YQddEyullDSk31HJPxu0l/WIRd/ohgPzfKXDuuniS+UNZHcuY0MXa89YFLvKnk9ior130Iz2vsqQldqdZm7DF0fD4img=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7857.namprd10.prod.outlook.com (2603:10b6:a03:56f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Tue, 27 Aug
 2024 19:26:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Tue, 27 Aug 2024
 19:26:40 +0000
Date: Tue, 27 Aug 2024 15:26:36 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 04/19] nfsd: factor out __fh_verify to allow NULL
 rqstp to be passed
Message-ID: <Zs4obErc91MR/Kfu@tissot.1015granger.net>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-5-snitzer@kernel.org>
 <ZstOonct0HiaRCBM@tissot.1015granger.net>
 <Zs4hzbVmqwWKqQ3u@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs4hzbVmqwWKqQ3u@kernel.org>
X-ClientProxiedBy: CH0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:610:11a::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f1ef94-afaf-4334-fe2f-08dcc6ce2d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vnZledyCJKHEaWFY2Y1eyroM3yeM3cya4icsXt/B1qIavp2dE0yGu7BfBGxM?=
 =?us-ascii?Q?i4T5mhuYjGkduZsLKRecPPSS+2lk4zarhcncCIZ+P3WaEDIkb2DpR7vCgYCd?=
 =?us-ascii?Q?lKLIxtYLT4vhY4yvfwxyKK7X7DBVz1Y9Ss61oZ7KTQCW3MlXEIAsbDsfzjQp?=
 =?us-ascii?Q?3tqSaIZPzFetZnEUXSw1mbLbqW+m/Bm560lvxK37lLBKOM7iUCWnYsOnvklu?=
 =?us-ascii?Q?BkUnfGQQkxXufCBj18kKeIqcnY4l5vUPfqwcn8+VhPWz9yn/LYFRLAGXKeww?=
 =?us-ascii?Q?+vO7JGFQs111AUyMVop9iDJ9QsatU3GSYg+TL/WElvitbtXmIHoC+WsUVahp?=
 =?us-ascii?Q?09oK2ewOi+zXb7oTfwXWRxvB0/WimtvbVsBH7Qe1YXTc1DaD4Ht2ptj9sqQx?=
 =?us-ascii?Q?qexO7ESlwUelk+HIPNg3lOCRcZzIRFLSqnUmJWlMauFRyNsqxawvkE2cI7Hx?=
 =?us-ascii?Q?u1E2wpe903SaS71gm6k0uN+cQxuBqus83cBZ7T5G1qUcaY7EYe19+3ohKKEL?=
 =?us-ascii?Q?6QDWeyr/uWReKyNiQxmqbIQyF7/PEVmnqQ45rXYchaW4fpVqAF46lo/7X6id?=
 =?us-ascii?Q?C6AHgT4z5+CXomeGgvxYv//6w76qveotjuGEiHKF0GKjJoAl6k2kYxjrFeh7?=
 =?us-ascii?Q?1AeeZvZnQmzF5OPtbjkaaPLDUytcu99yZZeH22pIbrkm6JrcybGpD84fn/Bn?=
 =?us-ascii?Q?oxSlRphIV7Fv+6FEkmpdtFPJ9aS+S76fDqNBHBHGJ7LwfqncRX0RhIE4BvxN?=
 =?us-ascii?Q?L4Tjma/meu3qmhLi5+s9157hhM58wOci734US2sTN5S0ty8dyE5/f3Q95DO/?=
 =?us-ascii?Q?9EyERZOqe0xMp71W9fTR7oRfJ8KVX71nV+FLFVmzxUOmXKQQ6ePsl8M+B6hF?=
 =?us-ascii?Q?jsQYasExsfIyvIAYJH7w1VYexkmIyXN4nKsaNNXiYnIN9KbS8SM+UgFV5VGk?=
 =?us-ascii?Q?ADE+N9HSXiZvY2biqUdWSQE3d+kELKlJjr2ZZwN3bUuPoaoYwhWcnHiJGvB6?=
 =?us-ascii?Q?CBr4ndOAWWI5hmHZth0Rx7lnVW1feeInfjUJiuJWqHUIiKP9FF3U+C2qwaYm?=
 =?us-ascii?Q?XD0pU0f+D6XoeAoE8d0swMG2evOL+Kk+cvjuVIL9P6CauKmKtEZs3q8eyevV?=
 =?us-ascii?Q?XYVme3wcHPA/pDMV6KEQQP8R/hgcw/NYsU/5fP0/M5Yn5xjwADD2T/wLTv3E?=
 =?us-ascii?Q?hqEo1QOxKHtO0Xbs8hO/KnafDplS5hBuBF4emXnTMAlxb3QmY31hbA0/fmL3?=
 =?us-ascii?Q?UAN890KgAbMm8Q09/BAu7aZLbgfoT3lOi68TJjY6dFrmKaM01+UxgflVKBMm?=
 =?us-ascii?Q?372GgG6EoOvgq0C4gyqEv9C3BUtubiSbcGq3xp8BZCaBbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6pJ/+sb7rnLZuL1i4CKIiOhUMMWhqpkN67gR52ZYZDan3ehSI78TG7iYZPy?=
 =?us-ascii?Q?T9eu4t02xspPNbkEa1pvzNssmCJR0AUI48wYe38sfWCsolAAFj/rNZe0zCxA?=
 =?us-ascii?Q?5tmrFZRrxg7CO/30kXzpwI+UP52feo+H6YDPN6Wy97yDRo5oAJYROkqqX79I?=
 =?us-ascii?Q?GPjgqytqsE6QqB4JGztTMQCAojI0/qw4I3kz59gdeT9UA1mhXFuLKv6hDLLl?=
 =?us-ascii?Q?1iyS9FEp62e0skaD2DS7iCAGT8f3tbGJvj/C2GO77H8/qTsNhosEs7jRi5NW?=
 =?us-ascii?Q?KgdomIdLsrqudwsESPzsMd7/6WNRi0ftps0TClfW8/4ZiAJ/mAUtWqSFGIMV?=
 =?us-ascii?Q?12vIzR8ZRudv+IfBVDNCQ4prAj6+jZ21kdnmUvsF4GY8G+2kXRK7bAN+eZOS?=
 =?us-ascii?Q?ORYd4RxXjeJl7HYnMzV8olNOTG14kkeLCM1tdoUwxLGbQlxeFcHjpHoFzwd7?=
 =?us-ascii?Q?1O+FPsjDvfnLJzJy8R/Qpfa+BAoyn9JZ/fUxr0b4naRElSuZ1E164Px4ilB/?=
 =?us-ascii?Q?9iDTNb39XlZIIBJ/ckrZMJgn/T3ombnStrd42sADuDpKmQca5cPwfy/VR6Ym?=
 =?us-ascii?Q?V8f3idnHn8tOvYvfqFEjm1ZrE5lG2DtWpsr27Vv/wbPZdnK9f9Xf/ENFGiCn?=
 =?us-ascii?Q?l6dhuR93CuqVjCfiBxvtZvwjmUvpbGV+n/i7BdFqRdD2jtbiDwv8HkFwXzAU?=
 =?us-ascii?Q?alx56Di1MUc+F+pDCfxtN7WkPLTX84kezSlSuQ738+J/OK9o8m7MF+z5OTBV?=
 =?us-ascii?Q?XgLSiiylNugIya+fi16IpViaHHL9AeiHCcIMwPU+KUyMQGt9WzeMrW+On5la?=
 =?us-ascii?Q?owWrlstUdxmBn4xm9wgY7df27tZ/WAJhljDPUT/HsDdW1U4kOm+PhWEOGvEO?=
 =?us-ascii?Q?UYKVUmIUbtDaRw1Zge/8P9n6ZRhJXAmpTFJgb2Ow3HH5lzHZMFPFhMP1DSC6?=
 =?us-ascii?Q?O3DWOpAnTId1KBZ77BCxT4+YfRQY4s+djKtuZv01+kazI0u/E6C9IwzkHX0e?=
 =?us-ascii?Q?4cH11dV/zkO7ojv8AQ6CVwXWEHMQn8WW0YFzRaJokoCcEhLr1UOAhtiZwQrF?=
 =?us-ascii?Q?AaLxXGL3v6QT4mHi1Y6JZOqSVaV2qCelwmLZvFOD6beUDtl5XLQJGRbIkWxp?=
 =?us-ascii?Q?64PbafHedB5lFjRrkDciK+JU2gBVcsvH/iZgnWwRjqvwEbsOYbFlP1O+e9Zr?=
 =?us-ascii?Q?8PsICwKngOhmoKAcAk01LgXYlA2iwgyNSqEvsfrRLTzr+x1Oc0o6z5wJw7T2?=
 =?us-ascii?Q?ZWw7BwIq+GxydoIcgzXGO/KerDJEtP9u3AT9YskMalOtEsOY0o/FVf2WnjY7?=
 =?us-ascii?Q?DpH94cu8IfcrRxMqGIj+LmdFWkr+KsJ42txAH0iAFa9lHd6oOFVsvGJCd4/R?=
 =?us-ascii?Q?c7tBu/rrbKm8UrQXd6N39JcjQoQacJgHXeka2F0KAlMRjtfQMTAMyoo8F2+3?=
 =?us-ascii?Q?8BdOwtl+EnW7E3abWqVa5yLW7Wpz/vCEdVFnxiKMKTrfYklRnxUjfcda82bJ?=
 =?us-ascii?Q?8JZ+5hmBQRhVveO9AJcjx3KoLlGN2HM0VBNQPK9pyF4IL0j4/w6ROWs5c4Yt?=
 =?us-ascii?Q?1IL0CfGeMcHqCsQlFXuCcWxSeJ5Djcx0qTrg3gPR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LgackiRzBul/oHIxaKAjCebS6HD08kspQnxKqK+VEyt+Vlg/dh1QnqZfj2OXvc2UH2TLtqqhQVXGSBJefTV9hQQ53ZZx45gi2gsqpbU9bV4HTr5P0mZPBv37sHHfsoAa+YXnyMV1PXNJqKhgCJRiWqEzuGNyle/ZW66QLvDeKnqljeqsGiJDMv3aMpl7C2hofgLuUBinreS7mtjFXimMC/9HPSyjGSgPBu9bJqV87FI8EJy26utoAYjdsA9D4vGVEjsrjX3H3LCNE+V8ME9SGOyhHYJHwrO16RK4GT8ArI0pIKXgh4zFxcCb4Iw7vY5ZSO5tS6xebQQ44AkRlhOKjssC3cVarbg9h3FPtKeu4Dn46DeuVi4fywsT8awc1scLEp5kPmIo/+TBowdxhesAK8ZSsJcFUOKbseYCv4rwkUOosDMWtnvv5itD7pVEVlkCK8hSOTGPP7FeWas0xOYF03jRe4QAjfRFfeeZ0Q5XFsiTeI63fWYylPVYq1nyQxB1unvXoiNY2DXcJy1VtHr4+mMvAL3r8ciG6+ipMNhDgtXrfQ7+ilhObdpdq9O1n/7FZVzarTwhjjjPD7X+G8HupRppdvlSShpFu1529awLc0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f1ef94-afaf-4334-fe2f-08dcc6ce2d26
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 19:26:40.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cgI0++v2zK5VeJquE5wEyBMadn6CvLt9Nh4+MtTMJ6YTJUvNbb0k07azn6cmLXwchVJ0FGUXUj4HtTmP6xDew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270145
X-Proofpoint-GUID: PVhvCq7iFWiHgKQ4hhDilRDYW4CiMQUK
X-Proofpoint-ORIG-GUID: PVhvCq7iFWiHgKQ4hhDilRDYW4CiMQUK

On Tue, Aug 27, 2024 at 02:58:21PM -0400, Mike Snitzer wrote:
> On Sun, Aug 25, 2024 at 11:32:50AM -0400, Chuck Lever wrote:
> > On Fri, Aug 23, 2024 at 02:14:02PM -0400, Mike Snitzer wrote:
> > > From: NeilBrown <neilb@suse.de>
> > > 
> > > __fh_verify() offers an interface like fh_verify() but doesn't require
> > > a struct svc_rqst *, instead it also takes the specific parts as
> > > explicit required arguments.  So it is safe to call __fh_verify() with
> > > a NULL rqstp, but the net, cred, and client args must not be NULL.
> > > 
> > > __fh_verify() does not use SVC_NET(), nor does the functions it calls.
> > > 
> > > Rather then depending on rqstp->rq_vers to determine nfs version, pass
> > > it in explicitly.  This removes another dependency on rqstp and ensures
> > > the correct version is checked.  The rqstp can be for an NLM request and
> > > while some code tests that, other code does not.
> > > 
> > > Rather than using rqstp->rq_client pass the client and gssclient
> > > explicitly to __fh_verify and then to nfsd_set_fh_dentry().
> > > 
> > > The final places where __fh_verify unconditionally dereferences rqstp
> > > involve checking if the connection is suitably secure.  They look at
> > > rqstp->rq_xprt which is not meaningful in the target use case of
> > > "localio" NFS in which the client talks directly to the local server.
> > > So have these always succeed when rqstp is NULL.
> > > 
> > > Lastly, 4 associated tracepoints are only used if rqstp is not NULL
> > > (this is a stop-gap that should be properly fixed so localio also
> > > benefits from the utility these tracepoints provide when debugging
> > > fh_verify issues).
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > 
> > IMO this patch needs to be split up. There are several changes that
> > need separate explanation and rationale, and the changes here need
> > to be individually bisectable.
> > 
> > If you prefer, I can provide a patch series that replaces this one
> > patch, or Neil could provide it if he wants.
> 
> I'm probably not the best person to take a crack at splitting this
> patch up.
> 
> Neil initially had factored out N patches, but they weren't fully
> baked so when I had to fix the code up it became a challenge to
> sprinkle fixes across the N patches.  Because they were all
> pretty interdependent.
> 
> In the end, all these changes are in service to allowing for the
> possibility that the rqstp not available (NULL).  So it made sense to
> fold them together.
> 
> I really don't see how factoring these changes out to N patches makes
> them useful for bisection (you need all of them to test the case when
> rqstp is NULL, and a partial application of changes to track down a
> rqstp-full regression really isn't such a concern given fh_verify()
> fully passes all args to __fh_verify so status-quo preserved).
> 
> All said, if your intuition and experience makes you feel splitting
> this patch up is needed then I'm fine with it and I welcome your or
> Neil's contribtion.  It is fiddley work though, so having had my own
> challenges with the code when these changes were split out makes me
> hesitant to jump on splitting them out again.
> 
> Hope I've explained myself clearly... not being confrontational,
> dismissive or anything else. ;)

True, this isn't an enormous single patch, but you gotta draw that
line somewhere.

The goal is to make these changes as small and atomic as possible so
it becomes easy to spot a mistake or bisect to find unintended
behavior introduced in the non-LOCALIO case. This is a code path
that is heavily utilized by NFSD so it pays to take some defensive
precautions.

Generally I find that a typo or hidden assumption magically appears
when I've engaged in this kind of refactoring exercise. I've got a
good toolchain that should make this quick work.


> > > --- a/fs/nfsd/export.c
> > > +++ b/fs/nfsd/export.c
> > > @@ -1077,7 +1077,13 @@ static struct svc_export *exp_find(struct cache_detail *cd,
> > >  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> > >  {
> > >  	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> > > -	struct svc_xprt *xprt = rqstp->rq_xprt;
> > > +	struct svc_xprt *xprt;
> > > +
> > > +	if (!rqstp)
> > > +		/* Always allow LOCALIO */
> > > +		return 0;
> > > +
> > > +	xprt = rqstp->rq_xprt;
> > 
> > check_nfsd_access() is a public API, so it needs a kdoc comment.
> > 
> > These changes should be split into a separate patch with a clear
> > rationale of why "Always allow LOCALIO" is secure and appropriate
> > to do.
> 
> Separate patch aside, I'll try to improve that comment.

Post the comment update here and I can work that in.

-- 
Chuck Lever

