Return-Path: <linux-fsdevel+bounces-24687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB0C943133
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4DC1F21989
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B89443;
	Wed, 31 Jul 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EmSqvN56";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d8bY7yld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF51B29C9
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433532; cv=fail; b=EMMKmfEuiYdJ8K5C7g8UoC0mA1ylzvgVUdnbk5TRfbPo2wVzQaaZnpOKTZ4F8ODvI2nQOajGDoufy4cWcqD3C8S2rLgSJ5JNP1SB54ZeFKzj1N72ZIYRzO6qTJlCLhbnBo2doZ+VLKwj5tnCAkFk0lCltXL31loYaIAMwj8cqAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433532; c=relaxed/simple;
	bh=MeyQkdlrXbMgUeyKYlqYoYhVkPip59HS073KphPXLYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mU8xOi+Us2kcGDdP1nOkujFADdXGlsxgpOtPjuaDlN2ITW9dzhk3A9fMycKcS0SrCiJ64qhC3zWXrkVifTZdB78hmpjKUDQ8Zq5aoM2twE5bjGpwsW3JLabWiiqDepDp3rkNMjPPRUCEBM7ckg5ooWjg2pBqlBzl98yI4EBOrP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EmSqvN56; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d8bY7yld; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V7ujRW001624;
	Wed, 31 Jul 2024 13:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=AtcmFstvdPz1Pfs
	x/lY3LB4GVzDtKi7bbOmMYgyuQa0=; b=EmSqvN56k3rWU6nnCX4+Dbi52DboVG7
	2NGGx/ojcbs05la8JZARGHySYw/S7HncT6uTLyKyYX74z6p5Sf7Tna8YdB7Odb3V
	td51FyncNTOOTxKRc5AcXdUFotxQ8sJac6GKPGZpMn5QBOG/QP/SEkdjMrhfNec1
	rpqYYe6pT8qsjS4etnh5fdC0sTGP98LQKvuzOsTzanOtlqwp4QLUJ1R6tvCsoHmo
	3iy0KYs9eRu1+R+2/Bb5HNIHaNtGJ/2W8aeXCHqU6ibnr6Sa/7x4QUUcMQNlb7kE
	KDBndZPZvjgSPQpUupx8mkexod5GKaZEwcbKf3nEOfxfKwueSDC2YjA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyfcct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 13:45:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46VDJlDU019080;
	Wed, 31 Jul 2024 13:45:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qjms8v7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 13:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co5ONfEiVbTRN8AR7xDYpSDHMSZD45VXBS2EnKDeuvQYH7ESl5KOuMu6Fj7bysGRn0MffVE+fvj3muO4w0kN09ZIrkgvma4P9QlrAE5C5Vo3wRFb5GyEXPEqnMo87YORWu1kPuU5oHKEzRPsd23GNv+LUa72fdTOaXuyyy9S9Y+7M2NwiFF5aqTWdcC9lcgH/SopVyje9bStjeHy1na/jnWuSCmL/2/WOgEsJByfCDc+mFtnfospy2X5PtOYTXv+p20ZBlToJlwrl2QYa0vCuK+BUboTEfUDAH/1+gSOCygk73A3vdpzVYeymJhrnS0V/0et55Az+6XdTjdWPWr3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtcmFstvdPz1Pfsx/lY3LB4GVzDtKi7bbOmMYgyuQa0=;
 b=gebgOAICl7MQjYiw9ba2HZZE2RUyZ6HFh59tJHNb5C6efR4A2LiBjnLsxC9Z9/7prH/FY8/wfNKzj8jNKljFP85Q8Y1v2/GgfGzs7Ep2P4Kcvr8jjXuJguP5dggf8tekVJf1PmRQdsvvQfS3DqrTEChal/GA7VdjPpl71GSLf8slCpwRd3/24YjeTQStGW3ZvevA3tQcCwQDiTMPUYi5eaGIvJ6tXc1GGFbeob8SnocmUIjUTt0Fd5k2dGhXOqQRUAKM8j/VSWvPuwO2dDx0R6EQmcycewwTTz9tLQaoXjyxt1zT1Z9CtrguDRoyaiefaJZ0ZzS7cIp93PrWBfDrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtcmFstvdPz1Pfsx/lY3LB4GVzDtKi7bbOmMYgyuQa0=;
 b=d8bY7yld7EWytqMR5ZaBVPX0Wp341KlklLvSA0Gs8ldyBwAQIaYgGfVAHK9WEuBo5CS1cyPpMaEuYESXdtvXJToCBk+EyL1nIiqI8s9DbguAz3pPpZcc1C6/d0VNlQdFaHghob199DSFop5uhF8x3CmOfLHxtPGJZybZiuMshKI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7143.namprd10.prod.outlook.com (2603:10b6:208:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Wed, 31 Jul
 2024 13:44:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7828.021; Wed, 31 Jul 2024
 13:44:58 +0000
Date: Wed, 31 Jul 2024 09:44:55 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: yangerkun <yangerkun@huawei.com>
Cc: hch@infradead.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, hughd@google.com, zlang@kernel.org, fdmanana@suse.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        yangerkun@huaweicloud.com
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
Message-ID: <Zqo/12NtiSkdQ9n4@tissot.1015granger.net>
References: <20240731043835.1828697-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731043835.1828697-1-yangerkun@huawei.com>
X-ClientProxiedBy: CH0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:610:b3::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 871efe56-34a6-4207-51ff-08dcb166f7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+1+VvORXw/rIfsK+hPqfcEIZwXRhgYQBlL2/trtRlkM/Jw/zC0zPXNjSSOgL?=
 =?us-ascii?Q?v9GXZf5MjO0hDWTDtzxIIjOKSKJvPcx4/Q1tTaQPzcUPFv28mN9OFRueCFMJ?=
 =?us-ascii?Q?LoMMwyDAmNumcVstkHid9h4Ne+0NrC2GSf5B5DVx4gR9ouJ7tFIA//D/q7Tb?=
 =?us-ascii?Q?grcF/jaoMhiTagLfLO+W6uqJUNV4qgHVDl2NFuykiPbFoLasLIRhYBD9U5HH?=
 =?us-ascii?Q?I5zmUtSPpfY7gxWpTnY29q6YI+yrT/KeFwgxD9vVrVBJgRa8WpJ8+bxPUN7G?=
 =?us-ascii?Q?JezJCoZqCd3T3s6+5SxoIYgaXpxPehwSfGXUQMn1L8eGuOdpKxhrIpubH2wb?=
 =?us-ascii?Q?zvanzAsGXYOCmd1wHe6JPpo9Zfetpzap147zr5QEd6MMEaMqdMPUEAjDSNAx?=
 =?us-ascii?Q?fNdgj5lL7DLINY1GJcFitoH9M5uRjgbs7dYOS7dub1vXtdxxTvaoyA32nqwy?=
 =?us-ascii?Q?n5FzeRe6Byh3LGDBNVMiBCMlzYK1HgfViaQ/b93g23BFZ41Kq4IPJSXPn6jp?=
 =?us-ascii?Q?/4aDgJHeYx72baTxRkeScmpt14atOw7sboOoC8hghFKDrTq6+QFxJwNP8GPo?=
 =?us-ascii?Q?Vkvbu2Z/B2fD5XpCZIs77z1ISHvO/raAmQvVkDgJyGqgVY41cskePBRRfB8x?=
 =?us-ascii?Q?hH92vZlkCIxb9/TusO+kkf0zQf2TZFD5X106TufHtkq4K79I4XwK9Mlj0K/p?=
 =?us-ascii?Q?eWo7R2IEk3+FBCvaFD9VM/HMkxbU96LGeGneua7VPZp/sEHQOx8gyPW+CA6p?=
 =?us-ascii?Q?y/0tvqXB8b+gJpOWzoJCHbsOBH3UmHUr4ddAFnsWhElBowB09KxUzaEXFfR7?=
 =?us-ascii?Q?3GyuV8Z9j0xt6bnPYQAh94h7YG1hTWCeay8cmHLHXO0UyVH4qhmnBSz+5mU7?=
 =?us-ascii?Q?vmUvRcDwbvmoOhj1GN+szVjFXP3BzFmh9Or5UbRU3f2K52ColGafQ96GO/2z?=
 =?us-ascii?Q?/qKgcZ+9eSQMX+75A+oDUpZiZY2ZkLRmnLbs0XzIyTy9HsSeX+HMCdxmBLgj?=
 =?us-ascii?Q?/5u8OsdE3i9Gs13HhH/k1szlek3PNdKP52FY9x12rDT0qskACUWld9vJdkLz?=
 =?us-ascii?Q?4cJmBJLcQEOHCU4aEaHXhlxT4aFAV7yf+nB1mGju3Z9prXQkzTE7bamogCv5?=
 =?us-ascii?Q?zAIpJw5BJwa17kN5vzITq0c1PSB5MKLGwk8sUuNrvYDqjgKzrqc4qdfXPbcK?=
 =?us-ascii?Q?vuRttpbpFlmT+ZBhI6uH1LWca+YNAMQGW1Q1XyzR8FVflmBUxTAYLiBcdCH4?=
 =?us-ascii?Q?dGAqeEiWoEixquDciE7mgs4ORdSijLddBsHD563Hg9XxDrck67iX9KzG5xbB?=
 =?us-ascii?Q?sijKqYMgcEXxqJmTDy6rag0hEFFL7uj6NemyLTAgVTzeUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hcxWbZyVyVLsr5MoRh5IezFyFT89FexGVf4Cry+dTvYSpAQELw3LB8zeTvax?=
 =?us-ascii?Q?I9AZIPHJb2W728mU3/V0/jQ/N33QPS6N0tGWN+U7LEUabCrMSru4/LGR0rZc?=
 =?us-ascii?Q?mumaOAWfUGH7/KbpGCn6/VwTjmVyKttVvc8969s2F+bIzjf/B4fhEXooftZ1?=
 =?us-ascii?Q?Yzgkq/tLrZ6AT85bddvOikPMGMdbLZkxhtzhzV85eHECZslbI/dzYZ3UaW24?=
 =?us-ascii?Q?OOqWkjIBOHC4yGLpu0a2y4aA0LJfy4CsLiRVBKuqkFiDnKlxOiPSUtCEBVV8?=
 =?us-ascii?Q?RWWFMrNjdF1Vy1JI5zT+HYXtBz3fysxgxkD9MWgA0kacODT5mOuLTarUZag9?=
 =?us-ascii?Q?TOxNFO5gB1q32stCEpEzPyVst0gS78uOFszqN4olfgWZF/IBXh1kWOFbIuat?=
 =?us-ascii?Q?7ngAC53qTs5qlgWHZ+EkC01+83ViwpPhMWq1KVhVf2w/j7WKTZwFMHIse4p7?=
 =?us-ascii?Q?bpGijTwO+1mcNuTffceiEBikrR7uwVAmNOaZC7YIJFRMqhKERaPmmNLbUMxX?=
 =?us-ascii?Q?WK+axBAVsKpjbBzxOruNsayfZkQ3VbM9CrxKBdxP7LTTweEhawkJfejdd4zf?=
 =?us-ascii?Q?QN36HZinjIlSfV3U6KrbJlep30Q05z+6qp2eD0YFwkIclkyOwewlnTcpdHNw?=
 =?us-ascii?Q?2/uNu7pYFKnk5aeiCcMUU8IPZczFoyGqmuck6MJAQ9xA5YgLZi3zJl/JlGxX?=
 =?us-ascii?Q?/SUdaE59feMuYktY7qId3G/uBwkMoSgAYqdPMLOTZx8k/cRcmful9y0DDD/+?=
 =?us-ascii?Q?HCIjbEwmMHZuiTFeUkhPInbGzPiKo7cIUfrjv4mjsOcG4nct26JjLueT/h2U?=
 =?us-ascii?Q?F2KuRzt78C2e0mnNLqAaVKSoV6+3SykHePxepxi7aKvcEQL3Iy7tgUHSwtvz?=
 =?us-ascii?Q?k4WIO/7m0t8yXEC/nLXKiz+gQ1Ok6M2I8aX33Q9If8lf6T+0XLx26xnA7DmE?=
 =?us-ascii?Q?p/xZF4X3HeQHF1C8CqaV5W8HCTJVhXYC4yxGYeKr0S3TS/w9o/w9b0KLHS/Y?=
 =?us-ascii?Q?yUZJXDW2AUdj9iteUoFc6v+tII9ziTPUhvj/+gi2P+nWhAyhKlEp84r3Zx/a?=
 =?us-ascii?Q?wGfzUrrv2OrOeRTuMsfk/BBEzE1UhfRUzldmkrdUIRt10Ss9CMCBctHKUmeD?=
 =?us-ascii?Q?yIMmACkwiwV9DTJFbyipz3Vkhaa16IpyANPHIPJ9YnfM5a+IbFj2gwNpw1rd?=
 =?us-ascii?Q?oDusAXV4NYM5NZKQP3FhqGcQ+WBMxjP+l2un/X/mHHobQNthtzV7G5pyx+dz?=
 =?us-ascii?Q?SjWEADsan4wpqAxdN28kD5IhGfr3LAOE+fpNm/GgvvY57U9FlhF0gcPB7GWr?=
 =?us-ascii?Q?Qt4asuyiWWUcqo2Yhm4wOVUP804efzGBrqiAgZ36v2KiCu28P9Y74WO9W8S1?=
 =?us-ascii?Q?/cc0HkomXeBr57E7if5NN7VZ/F1BaEsC2NmRADHngonPyCVs4Av5/LFKCx0T?=
 =?us-ascii?Q?LroB7FbPb6DFf3fiKPVnhbFJFsvUfMg8G/inWhf308QUnU1uPHYFun3nK4D7?=
 =?us-ascii?Q?jVYO/D8r/fRVDklMF2/5hm2XuiBTmopbsMaf2vDi2xH8+wMqupyacDA5If3f?=
 =?us-ascii?Q?Z3VTUVzoYWv4f44B574paMPNkINkjzXLEFuwnS+i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mepBh7IquAGA6nYehTU1gW2FXXs72zu+SJcZCiE5kNowdpBXQDEV0nZ9aA8/gZQVfLiCz+84QcYWxHG/Kl2SiML3rVkIt7BUAALBxn9z5ngqYGTNLr3Z3i04ZcYnzPJgnSMtMscCh1ct5y7BFZRoOh1rJj+KoEAtHOOsJdMHyWjUHvnvQr3aqsJFwXNmqUlPx0bOBmtMFKEm0svBOysJ9yZf+v1C6oyLrlUK/q58I0POW+iNCODJza2J1ZqjfmyHAapILkRgw+keQ0/btD4tMYGdrWthvvb8FMAf7poA1SjRaYfxn3zIXq2h6z8oBPXoUbdVa3EgZdGf92dv8kYTUeybf2ECgcTxioRKSTblf0WbH61pMij50EdLif4E9pCavh9uTMNWZH3luDZSkAj2Snu94Mgu2hFn4CGqWkz8YxJ2xOg5DZCOKQQCckGoraNa2qa8B47qP+AgEwKj/NNuFzezEa/guf2kf3sENmsUOnEV1XenbDC4rFuptpIWBQNRPPwA05pS7V2Dh1/PgnoNw/EYftvlsCkCKaO1G+u+XOSzneuCWHr7e/Bfyd8/UFvCeYLDE+dQsx/Rz31DuN5/dN5cXqyRKGsoaIpRsGPNKdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871efe56-34a6-4207-51ff-08dcb166f7c7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:44:58.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8N8tPYsZA2B8xouHuDVu6bPQ60M9fHXSAEbhehU/G4nBCXopkaNyaSM6YS4FegvLl1ULeJ1gYdmz4ntzePBhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407310100
X-Proofpoint-GUID: EioM0dAQN4sVQpw5NCj0Y8VGsmNBUkEP
X-Proofpoint-ORIG-GUID: EioM0dAQN4sVQpw5NCj0Y8VGsmNBUkEP

On Wed, Jul 31, 2024 at 12:38:35PM +0800, yangerkun wrote:
> After we switch tmpfs dir operations from simple_dir_operations to
> simple_offset_dir_operations, every rename happened will fill new dentry
> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> key starting with octx->newx_offset, and then set newx_offset equals to
> free key + 1. This will lead to infinite readdir combine with rename
> happened at the same time, which fail generic/736 in xfstests(detail show
> as below).
> 
> 1. create 5000 files(1 2 3...) under one dir
> 2. call readdir(man 3 readdir) once, and get one entry
> 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
> 4. loop 2~3, until readdir return nothing or we loop too many
>    times(tmpfs break test with the second condition)
> 
> We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
> directory reads") to fix it, record the last_index when we open dir, and
> do not emit the entry which index >= last_index. The file->private_data
> now used in offset dir can use directly to do this, and we also update
> the last_index when we llseek the dir file.
> 
> Fixes: a2e459555c5f ("shmem: stable directory offsets")
> Signed-off-by: yangerkun <yangerkun@huawei.com>

I agree with Jan's down-thread comments about llseek, but other than
that:

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  fs/libfs.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8aa34870449f..38b306738c00 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -450,6 +450,14 @@ void simple_offset_destroy(struct offset_ctx *octx)
>  	mtree_destroy(&octx->mt);
>  }
>  
> +static int offset_dir_open(struct inode *inode, struct file *file)
> +{
> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> +
> +	file->private_data = (void *)ctx->next_offset;
> +	return 0;
> +}
> +
>  /**
>   * offset_dir_llseek - Advance the read position of a directory descriptor
>   * @file: an open directory whose position is to be updated
> @@ -463,6 +471,9 @@ void simple_offset_destroy(struct offset_ctx *octx)
>   */
>  static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>  {
> +	struct inode *inode = file->f_inode;
> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> +
>  	switch (whence) {
>  	case SEEK_CUR:
>  		offset += file->f_pos;
> @@ -476,7 +487,7 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>  	}
>  
>  	/* In this case, ->private_data is protected by f_pos_lock */
> -	file->private_data = NULL;
> +	file->private_data = (void *)ctx->next_offset;
>  	return vfs_setpos(file, offset, LONG_MAX);
>  }
>  
> @@ -507,7 +518,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>  }
>  
> -static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
>  {
>  	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>  	struct dentry *dentry;
> @@ -515,17 +526,21 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  	while (true) {
>  		dentry = offset_find_next(octx, ctx->pos);
>  		if (!dentry)
> -			return ERR_PTR(-ENOENT);
> +			return;
> +
> +		if (dentry2offset(dentry) >= last_index) {
> +			dput(dentry);
> +			return;
> +		}
>  
>  		if (!offset_dir_emit(ctx, dentry)) {
>  			dput(dentry);
> -			break;
> +			return;
>  		}
>  
>  		ctx->pos = dentry2offset(dentry) + 1;
>  		dput(dentry);
>  	}
> -	return NULL;
>  }
>  
>  /**
> @@ -552,22 +567,19 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  static int offset_readdir(struct file *file, struct dir_context *ctx)
>  {
>  	struct dentry *dir = file->f_path.dentry;
> +	long last_index = (long)file->private_data;
>  
>  	lockdep_assert_held(&d_inode(dir)->i_rwsem);
>  
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
>  
> -	/* In this case, ->private_data is protected by f_pos_lock */
> -	if (ctx->pos == DIR_OFFSET_MIN)
> -		file->private_data = NULL;
> -	else if (file->private_data == ERR_PTR(-ENOENT))
> -		return 0;
> -	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
> +	offset_iterate_dir(d_inode(dir), ctx, last_index);
>  	return 0;
>  }
>  
>  const struct file_operations simple_offset_dir_operations = {
> +	.open		= offset_dir_open,
>  	.llseek		= offset_dir_llseek,
>  	.iterate_shared	= offset_readdir,
>  	.read		= generic_read_dir,
> -- 
> 2.39.2
> 
> 

-- 
Chuck Lever

