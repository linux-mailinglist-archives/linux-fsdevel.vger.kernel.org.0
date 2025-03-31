Return-Path: <linux-fsdevel+bounces-45380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24A5A76CCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 20:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB8316568E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C29A21638D;
	Mon, 31 Mar 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kryP0H9N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A4g6QyGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802C145A03;
	Mon, 31 Mar 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445262; cv=fail; b=NxaawzOHY8OU2VPBdlJDhKGry9f7KGmwYqiZcmuBicX4IdfXyhE3dndbwF+T7aWvirZCf65cYpcOk/TjTItxtBKJvcNfz5NDjIcGveDPl2ElRjN5oftlFb5hVo9SM4bHooG4ts0XpBHY2FHSsbk64ON23OHfNolNMaEB3OyXJiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445262; c=relaxed/simple;
	bh=KWM80elwNeybG23IHBhgUZPRGpnJ6mgFFqXHFhVmvnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DFysFd0+EEu0Or8oHmtm9TC9SsrOr1bdnwgs7YXGdKAiwpm2OZfLugL2eGfyG7l7kiCSciLTy+uNi6Sfg8utDYAeAHscB4cq6uxnDOA/VDbuBQaRirLLvt9ws+FDWKOoifK/mwkdReXxN1MnLG7iXXfzk4rBT+JG3I45k4GhySU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kryP0H9N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A4g6QyGn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VICkBl014309;
	Mon, 31 Mar 2025 18:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=lJYvcdu3J/oZvq1fR9
	pO3KCqEzDnKMxp/IHE3HcsRME=; b=kryP0H9NbY8IR78ZD7eEzoqOJkcgw21VEI
	EvlJKX3LnDjmRLRY8a4xt/lkox5XABQTUHBhylbWG8HL0FkmfH4oxuaGhZI68h3D
	C33GavsfRxPAKjWTRpADGTxNXWIhguk45rrST1fAa6RH1PIfQ7gc7xR7qShoaKpg
	4qVewo93eci/pt/cW9qhsT89HeF6yd9//xjKwAOd5FR6IEFytGIwO952kqA9CNFh
	QasyPS7TQMNfqmn+WAjMh/yhpJi6z6SDnSnfVWHG6MArbbYes6vQ1eGPwE7XnPWS
	0gds+jr83Av6U/b37dfc0sUUpKxBTluy0nFRuFcMKAA41jwCtMGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n23vrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 18:20:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VHvsEm010698;
	Mon, 31 Mar 2025 18:20:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7ae8hgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 18:20:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrTunlLkzgbj575U8C56Y4tBFMB2jhlvouaxMJEjuSgHiC38Skv9agaQp4cWZ9+Q6zh+Y/+OHaCebZxZX90zV0PnllO5RGX8qARWHreipuOz+R8Wac9SEarRzW/BQ0oqnKkuYogcnYTuxMOmAZjHo22k7jPuuL9dWUmWqSYO2hxuVZaGLrXMpnRbe+Nzvc1y91VsnBfFlnbivlrYjGmZDZpJu7/SkiNZdKTY5x10U2wwFbisO/T8lWRf/cdtF29GbokV8XBFRwQJUj9PEmJAzs5z8OFv1a9vmGJBm5hS7YsCrcG0QV8vNt1VV8dD3wEKEnqByO/zSny2Ga5xhb9HiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJYvcdu3J/oZvq1fR9pO3KCqEzDnKMxp/IHE3HcsRME=;
 b=PIm6fahAEp+OjTBj0WBeiaKDQIC5z9Pw4d/DEVAMV6TUGpwF9cu/0YANkkrCErJxhhomRYHVSMH6vkwDix+GGInvaUz5lVbxavLp+zk79tRhiJlko/MOgApugaaBu45MLI3tyyNfGtNnZDz4crDTVVMkMduXYRsDKRAsncrBhp6AI5I9eTzaL3DCmQd/xbHqOov4YH8BooVG80bGMXOopac5/u+i+m070t/MaZdj71Za8vNMlhA4S2fR4cFb2hk+++GwwJmx+bn+CI7dFEMSvglx0chQU+pwubsK1nkNWD0t3+6usTR84+on6zv0WQcwZbtiaXlGQpJ9GzIAd+o9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJYvcdu3J/oZvq1fR9pO3KCqEzDnKMxp/IHE3HcsRME=;
 b=A4g6QyGnvx+mLMfVtRB3tVf7JFNg4QIEyXaJVZSfn3Wty6L6wJX/RxoAMoBC/aGY1QgY/ATf8ERBLYG74rG67s8jNF0svzeQBTSX0Iz2sdUQCfDKumYaCxJlQ3Io9beTViKREjE574VA1JlLIxakfPgCauDednkt+03UezUwbX0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 18:20:35 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8583.030; Mon, 31 Mar 2025
 18:20:35 +0000
Date: Mon, 31 Mar 2025 14:20:32 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        Daniel Gomez <da.gomez@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] radix-tree: add missing cleanup.h
Message-ID: <zukwcnvdw4xldq6fwztzi7jvr6boi7xo3tmuriwf6b32t73qmc@xaeigyxmhypj>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, gost.dev@samsung.com, Daniel Gomez <da.gomez@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>
References: <20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bb8927-190b-464d-2c6f-08dd7080bb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pE191JBzMb2yGAYbwCQoP7GAHrPfA2SegU7scc0ebeHnIaf4clCV84pdqV3T?=
 =?us-ascii?Q?PFjQHzzqsCCHTTTmxvsuZuxBXDXrSXvZCw80mjF4xsIczHTCe1LV5ECKq5JJ?=
 =?us-ascii?Q?QAkU9/qefira6E/ZEyMUfzQzduhfZOg1eEUTDVwyirsyH+I3oz+oiPz77VzV?=
 =?us-ascii?Q?nGzB31EAJo018VQg481whgaIgDJDDH9IeP89nxv+NvQxuthRtt4SfeYG/b9Y?=
 =?us-ascii?Q?KErYWhEf38zDJNibbRXyGwicOYtyeU3pOjMAW5q2viU8CrmlnXd4QnS2V54e?=
 =?us-ascii?Q?g6Rmv7gomHOZ3GD6+ml6kFpBkOA1pxJUTvcsyfjperp7lnmWKCei+rYj9GX1?=
 =?us-ascii?Q?o+rdKyOO94fhtEy4H8sgzU15TAQuSogWsWiw4d1xcV46eWxXPzRf0MLCd6GR?=
 =?us-ascii?Q?1R3pvZO+3aa1V9+vFt05oADmHRyIw9odAZ27Tls5TqDFP3EiIBGvNAuaaX8H?=
 =?us-ascii?Q?aS9kv2yPgNlp0CI0ufnZkKi7po5R/sOFx+amONqjLNfsrWE2LMj1tYsgRPYH?=
 =?us-ascii?Q?M/HS40jSfcP1UgmQIeCWBYgxWwK1ZR9bRppDMV291l5SM2I8xli+GrAH6Hf3?=
 =?us-ascii?Q?gWUSuG/lfkYpRgtAEG/kV052Z5Kl9ncM4Il7PNmYnat++FaESOd30vpYRSR9?=
 =?us-ascii?Q?s3VDpbwE3rPUi3I1q3ZtTUA9q1jXfdWtA9IA4oLBCvq6lHvDzrvbeStJh4HR?=
 =?us-ascii?Q?M0alUiR7xxM48G9C6W4pzush8keSs4bH+HbO4ZRft0IL9tWa2gJiCeqjnW23?=
 =?us-ascii?Q?vD+ggsTdR8eSTqfPvt2tngXnkTVh3YBGQggMVwMeYefbYfXUT1qy4oJxKwy8?=
 =?us-ascii?Q?RYgc3SbsjkJE3uE21yb8CnVwbJTiTFrndI8soerXyVBZl/bbjs3arcIVk2DD?=
 =?us-ascii?Q?mKW2/6w+lUW3xBFKG81pb0IOjHx56h2PPTdz3pI5pO2gieeeAHThNSmmXs9I?=
 =?us-ascii?Q?6IOKMdFo/uZu4VcpIujtXmxiFXCpAg/sAZyCQOAyTPKgUpOptHXXJ/84g4Fg?=
 =?us-ascii?Q?i9AWkrErNJUSB6YemSXPfQKjtVSFbmRE47KCgIHeL4QvGvDG7ytc8oGGJ9ZY?=
 =?us-ascii?Q?VQTKBybIesenB796sEKio2E6iwi2PWcw55J7PcBcobeNXxHzOiu/2Ruzn8kD?=
 =?us-ascii?Q?5lUnYBWxY4bCRB58le5oHeihXGeuWfQGnREzT2c/nM0u1FBFPTeTQa55RJd8?=
 =?us-ascii?Q?1nsGQWrx5BXvgjF++jBuWgNJBVQ53gUbu4j9rJrmLYgF9m+nlsTSR6YssnFO?=
 =?us-ascii?Q?vkASUZTOkHUJNq1d7E3R2uXXzPA2q7wdr6wuUK308yC5w2QIR9fL92ZwtZut?=
 =?us-ascii?Q?jadN+AyJCjcpuHEWc+t2UHh0HELVtki2Nhy1Kjg6RLltanOZ38uaEmUZ8t1A?=
 =?us-ascii?Q?0NgJPEs/wKAOhxwBWhiZyTBQdEKs8UFTn7uv0TYcvMcyRbyG/BhyeDkhhh6J?=
 =?us-ascii?Q?vIB2+MPvzsLB5TGQodN5wnyXkvpXf5rG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2ZqR2rD1ZHSvewdifc/q266M+6IRNj2BdsGg9gEppxLY7jCf5fZ9ZjYcOhx?=
 =?us-ascii?Q?0dRx8xX4isiH5pNlSOL9a5lc48d0IOmF4vfWZ2zpqJ085/CDak+ovst8flgF?=
 =?us-ascii?Q?j+IGdl9hL8GV9WS8E0QPqA0DGcjWhP9eNO+Z1arn1jg4hDdp9r9KR+oStIKg?=
 =?us-ascii?Q?pCuD5/HXOZ0/fE1dTXoeEMkK5s/BzTLt/EB4uvVGGl8cqThod1Xoz8mddMId?=
 =?us-ascii?Q?Fmt5KfEXPtm13qHFa4PVv/iKHSkqDt7aaWfCUcT3qt7AtDobfhmte8rdiAW8?=
 =?us-ascii?Q?Mv2xAG1aqa0VtYDuY2xaJ36gfZ8EPEaJsfg+sALHuYAQW1cxT6fPAog3AUNv?=
 =?us-ascii?Q?K8XOjy1PxRzc9A45RO8omkTEk8iq3Z0B2AZnKdQnHBOBpa3xAKcQImh2eMxc?=
 =?us-ascii?Q?OWLXqxp4H6mrm/WtdyzomGWz0f9LU1Zc2i+HaWHwlU+2hcrzsAC33zqvWCAm?=
 =?us-ascii?Q?G83zQ1pwRmD6UUaqTu/PRRb0lFBb6lEavdV8nRVZKv153u/x5bH6tHgl/AXV?=
 =?us-ascii?Q?EoOp0HPZdHBCBCxC7ZpGgWJP1kf8RqzCXYyBNDf+VwK4mmei3qTnnDMXBlqT?=
 =?us-ascii?Q?nfaFk+yGRsxq6V8iQPBhkfzR9UVsLSYmQkpSakHTCzsI9GTd++eQFZ3pnKO+?=
 =?us-ascii?Q?C6ESdRYidTqpVE/qp0DpTXfP2DbBgyq45UyVAIIx1s+C4K2/XjvFYiliyyDc?=
 =?us-ascii?Q?nOkg9RSBmVjFQk+O+RWBtuP/zDfJ/R+5mjQ+hPLzRKZMfwr+5HgTqe/Us6u8?=
 =?us-ascii?Q?Icg3XkIRU20UCL7TUZUW2IYglozBoKeiF2bKfpgXkvT0K499gADsuF2imV2+?=
 =?us-ascii?Q?aAVThYMH1aatDzsENrruyEnOmARhSMrnvAGrAyLRNDx/ykllP2IafSdQ+UNU?=
 =?us-ascii?Q?/SEDQwbqroj7ZfmkeFeGO5HSmAcZvFhjJdozV/0gOJnPsEYdUIT7Kc+5sZ2O?=
 =?us-ascii?Q?sFwSxttLxUloWOAWk97VSvNGR3usyrhPFhsfDO5knJzMh4Ybf3Ii3IDuo5Vj?=
 =?us-ascii?Q?BkBV/lOQ7odI77Myjxh9E5aBrHcYXnEBzJizsMNWSCCTFBMDNAgY5dAcybK3?=
 =?us-ascii?Q?ZDJtQmqKN1gPeq3BYTlYbxUvMNs/PDQGojBeg/wDQuRnwcoyFXytgltUrUwQ?=
 =?us-ascii?Q?wC1b2TsRn4+CTRC0fDejFFZHfmYnjMUz9OOW7pnPMQW+Ecl2dRMVY14CNM53?=
 =?us-ascii?Q?CKUJ7tCHbeGC7JX6NAdmkr9PJJKfzVPVmO06sOg+DG75iLAtK+Ivvlka20g8?=
 =?us-ascii?Q?5jzTapfoBgKfhcLFZGcO3fyzRdMEuGuwyNhZ7gmKNJG68usskg23vGT3dtzl?=
 =?us-ascii?Q?pY3dFU21Klv35j4HNmf3K7oEfKTWBAOr3hi0uy/GgUT6KYDtjFSKNU9kek2Y?=
 =?us-ascii?Q?42WwIUitoo4Wi/CJmnNvNNQbZZT9sSprguU/fsazoCTl+jiq1riIw5UI7lmr?=
 =?us-ascii?Q?kmxKg9NczK84CvGHZtC6tCc1HDe8RyO0FPjRhe4udi4rxWsjCYu7VkZhXrD4?=
 =?us-ascii?Q?l4FCJ5SYXGPOo1RzQwdqsQpINGjDn3vSTJvVoAH6bW0EydfiJ4WUYC7OzbYU?=
 =?us-ascii?Q?0aJdvNxAyITeJwR+6KHowpYo3XYTRR4WyccOJTjG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g/svrczpvgDYD7/0nFAVYmeG9J4vtP5lL6Nj214qAPfSveLnu7S349ajp5mpgiHz4C3EmL+rmBxW7TqcGV6+kJrAEmPdBYcfEIvHtU/0ByJJLJoKHCdLQL3/x5jrKGgnefNeMbXrr3uSjIr8uF42Kj1GLJ0KI9/ixUb6GwHI8ZW1mCE1+MEGc7MaNuyYl8IogFwX259GOj8TuOQU/u5CZpeDgS2xdn6j1yUxUbo59fGM/AeQ4ZCe1Vggay8i9LEVt9ciBvK9qb7d9Ks2p6QqD5+AOwzZ4ebzn05fshrnCaWTVNpauMkgnWJFey6v91bJkNqCCU9ZQ5wgob7cCDfMeOruawSacUPHu2vc53Fr9ciQd7DI2qyjqX1j5XK5eaiOTzu4ii3BCW2vR9IZTODBWkMsvGP6AYL0GXY5Ur958R4x29EzVBLQUTzXJfR4PyDTtt3PhfDrrZ9F4POhW0MES7TPefLeLQWwHX37MYSPa2XSvnd8/OcCMKocxDu7+OC3yGmmV/qaMhIYeumpwfbF2Yj9RKoOxc1WFlN/QahKCh41NbFtCWgbRADKN6LOWzSAFiHYKS8On4JaMYCW9iZop1XGpqeBmq3FW/vYVQpLMys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bb8927-190b-464d-2c6f-08dd7080bb34
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 18:20:35.6902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbt5+O4f9Av/FMqy7Z947fPsuONavbQUhlHlWdtieDpHYEE21CUVofMgEUyW+Vxgk+CjdqhW33VGGk4TkMgc/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_08,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503310129
X-Proofpoint-ORIG-GUID: ftTlw-tYS-kCIfi_ec3wHQwnRQr5VdIV
X-Proofpoint-GUID: ftTlw-tYS-kCIfi_ec3wHQwnRQr5VdIV

+Cc Luis, as he added this task to the kdevops build.

Is this going through fsdevel or linux-mm?  It's not entirely clear to
me.  I assume fsdevel as akpm isn't in the email header?

* Daniel Gomez <da.gomez@kernel.org> [250321 16:25]:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> Add shared cleanup.h header for radix-tree testing tools.
> 
> Fixes build error found with kdevops [1]:
> 
> cc -I../shared -I. -I../../include -I../../../lib -g -Og -Wall
> -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o
> radix-tree.o radix-tree.c
> In file included from ../shared/linux/idr.h:1,
>                  from radix-tree.c:18:
> ../shared/linux/../../../../include/linux/idr.h:18:10: fatal error:
> linux/cleanup.h: No such file or directory
>    18 | #include <linux/cleanup.h>
>       |          ^~~~~~~~~~~~~~~~~
> compilation terminated.
> make: *** [<builtin>: radix-tree.o] Error 1
> 
> [1] https://github.com/linux-kdevops/kdevops
> https://github.com/linux-kdevops/linux-mm-kpd/
> actions/runs/13971648496/job/39114756401

I am quite pleased that you saw and fixed the issue with the kdevops
running the testing!  Thanks!

The URL seems to have expired, so thanks for including the failure.

Can you please not break the link across lines so they work with a
mouse click?  I believe this is an acceptable time to run over 80
characters.

> 
> Fixes: 6c8b0b835f00 ("perf/core: Simplify perf_pmu_register()")
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  tools/testing/shared/linux/cleanup.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/shared/linux/cleanup.h b/tools/testing/shared/linux/cleanup.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..6e1691f56e300b498c16647bb4b91d8c8be9c3eb
> --- /dev/null
> +++ b/tools/testing/shared/linux/cleanup.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TEST_CLEANUP_H
> +#define _TEST_CLEANUP_H

The "../../../../include/linux/cleanup.h" itself has these guards, so
probably not needed?

> +
> +#include "../../../../include/linux/cleanup.h"
> +
> +#endif /* _TEST_CLEANUP_H */
> 
> ---
> base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
> change-id: 20250321-fix-radix-tree-build-28e21dd4a64b
> 
> Best regards,
> -- 
> Daniel Gomez <da.gomez@samsung.com>
> 
> 

