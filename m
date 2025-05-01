Return-Path: <linux-fsdevel+bounces-47836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87823AA61AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B6C1BC2036
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E827D21A428;
	Thu,  1 May 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EAKUz8G2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AFW4qcbY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458E165F13;
	Thu,  1 May 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118686; cv=fail; b=PQtH65DeJkRlhUnwfduUKYXAgLAVn/dGv4hK6rCsn7HxbM5LWo22KDoiA7DCRRP4vtrb82vNRaPv2J8WaPw/cQUNPaEX06sU7niU/H4jknt3edLnY+V/pOdTEFXgum1nHwcT1WnGWGZlpYgJoQmENuoMaPT1QzDl7S9Tt80tolw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118686; c=relaxed/simple;
	bh=s9umRKRFfgTIQlD4/bOES5+0zQw8uME5kwsNul37vHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qt3wIoIX9B2PpzP8EL6MijA5Sa2nXbmRnRquA1J2s3sR6amvTZt/miSRFSJqt8+ozEziyObvXs6tJ7wtrk+wuF7skGVc5IAlw0lzJlmW2cqpe8+g3gySaTKVOrA0OpICgmyPXdxjtMetffHs9xbPQOa88ZEEeng9YTgz3V7toP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EAKUz8G2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AFW4qcbY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Gk596008223;
	Thu, 1 May 2025 16:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rd6C5ey/l+sEGTPpaZvEmNeGhYfJukcUhgGdg2fVxfg=; b=
	EAKUz8G2jvDiN7aIEgaoLwH+OxDYFhkUrRYlXsYCbMMhuDQebDCRyXVyP3NmXVNv
	GBiXGU62O5OOzZV0w0WJHczXQY5v+B46WD7MRqvRH4jrI/joke7o+a4B0FdIQajj
	JNBL7z4QwgAwVAj3uzIj9xOIBQQxsZFCMbiZ0YfMIuwjR2hAFE08+gWLNo+07XeI
	q/dUoLN7cevPtiJ01SSMSDngAXv4BI5bTK+9WDQ1lg3VYDx8yM/2b+4IhPTWoj6U
	r18aczFTFf6CB3Y75igdC81g1/LyYDtEiaGFx0cUL7TJ+T8OYTe+qvrEzTobqOcc
	upji++ALP0Tpj1HeQFpOSA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uskfsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:57:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GH4Vh011314;
	Thu, 1 May 2025 16:57:49 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011024.outbound.protection.outlook.com [40.93.13.24])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxd9ada-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBYG8IIo4Ef7jzPa8BgMRGLf8CGJ51xQXFgL2z65Xy2ZOG83G7YZqs/dJFZGT5ut4RwQ/UWi2SJO1N75rZZwoQ/aZkgdqQDStQvUqYoF215R6hA5BI/eEtK5J6Je5r9AIt7bqMwm9mp8K+5Y8890IODrL+NbyXVmvkEjrLHo2OTMgvKB9y8c+dpSQui4+s5PQP3lcLiSVRKQohre6BaP3AhatL/50NxghCqkkdWmqagfSagOOURtR901Mvd3kOMd25cLMRrAOgWBxmuVXzQO0z5rcc05RyQ3HY5ZAlz5uwuotv6zOIrS0R+HSwOKY7HXYSqe3tA9uUTT2yE9clsqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd6C5ey/l+sEGTPpaZvEmNeGhYfJukcUhgGdg2fVxfg=;
 b=lE+A6hhbIjXcE916jdfN13rVxT8PkGjeoREskRhdPuEpD0rLOpOHKNR83ewOdVoO8xZn6NpQV0PXHOQf2sAxSL84zqezwlUG8ZHRzT2rcUPmRm1641LxDf9Wej7bqjjbWFruSSpfPOvMrEYpOlj7kG9l2Xk2vZ3psyRy/rQbPRM802usL9ceGNN0hzPuE0u5lk0jzsUKUoitfmHBcZl5ZnDB2PZwQKfiwL0YQquaEWF5oN+bI/ZdU5VBar2Ue3a6EAHGKBUIk1s7wy9UCYuNbFsw2fBFjLZ2OazyBSe9KdCmZoty6/tISj2fiMqZJ4DCXb2x5pHiEduPh3dKZcv5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd6C5ey/l+sEGTPpaZvEmNeGhYfJukcUhgGdg2fVxfg=;
 b=AFW4qcbYSQ2Hx5vebuteueAufBN2QdxTYObicWdzZTKuaYwnrdY7DfaPkUoLctwwLknFqE8Mcg0hsr5HYo3vc5gFHbT+MsQCksrqfzOsiEEqynuNid60QDTRKLcJhpf7py6wGTEAdNgEqWpNMHIbxexKXjYUt47W5ku71kEetEM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Thu, 1 May
 2025 16:57:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:57:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 01/15] fs: add atomic write unit max opt to statx
Date: Thu,  1 May 2025 16:57:19 +0000
Message-Id: <20250501165733.1025207-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ec6f49-c907-489e-fde9-08dd88d14c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iDloXCPCgX5+Y7/wmexxnN0/2dZiRFHK5ArbxV+xSTW3rWPIJj14O/Muja4p?=
 =?us-ascii?Q?SrrqJlOBsN6+laqQr2/U2mitvjRN7plHZAudRFTlOlvVWRSrLxqGa4hmDqAt?=
 =?us-ascii?Q?nPZQ+A/BT0ht7Na4yI6CB55gzVV/r2H/iSXuuooZ5FjqgcSDusY2CcipmQ6l?=
 =?us-ascii?Q?BOjjCv9mDcGm1DQ7RAzF2yud+jYJKlRAtk8k1cSAK6sR+LB5Ae43KB+M7Pod?=
 =?us-ascii?Q?IYmLueAZTGC1qNOT5Gsw6Gj/T4AeWhRsIN/kXP3BVbRqUU5OpR5d+/vjJPBL?=
 =?us-ascii?Q?JEm5Y9OMP8DST/WwUVSnBljv00yLlmFB32t1767nRF61VKS7yGIvYJjXvY0K?=
 =?us-ascii?Q?KN8qe+ynOCZBy+HeiZAyp6lCNwotNnOvVrR7h3sO/MJwXcxbbR780xiaEkl8?=
 =?us-ascii?Q?kiyOVo8pUJlrtrn0ljI7ba2Wgy+2eyC68NWhhhn+E4mQjBEFysId6telXChb?=
 =?us-ascii?Q?5LM3rXQJFxkHbq+lwS/AxEJv2h/EL7hW8q1TwQrtlERVMiKkd8YR90JkUvYO?=
 =?us-ascii?Q?n3e7YfHYZG1gpjnNLgrQhPH7MG6e2KVmEcmT9kRxX8iEPvQ3DDp8+kDGYZTO?=
 =?us-ascii?Q?F1L8iWjIyr4wud91jLfYHDyhJmLhHj4dMBjC+32zkGtCCg7KD6vzdWli67Wi?=
 =?us-ascii?Q?xa0ScIk0lNdsXfHEoL5oBeOujU2FEmLrYzeqseTO11pMqJNBf56qr+S7H5U3?=
 =?us-ascii?Q?Baw7A5du93ArzycRckoXfhNk2NBc8hkL1kxKjXz2ZgS6gNZKcNDQVZokhLeh?=
 =?us-ascii?Q?kFktaAKhfJ2kSwzmqYMxb8ZNB/MEbqahBofiKcVOiZrW0LHZGEk6hckc9tya?=
 =?us-ascii?Q?yVSj+gOgTSocFWRHmXjGhuU8zQ45V+P3+b4mf9CuhYJKMz/cUgrvhSx0JrZr?=
 =?us-ascii?Q?hNIo2N+quziFcX3ksYr4/AD+lNSjRPYJGOoz3pJ9bChiS65kbXGMosA520sH?=
 =?us-ascii?Q?uDNyAu14hOYCg8GPS+rQ7naJD75AUR+KoHZLsE7TDxN9LM3X5xZ6ELXURNJ9?=
 =?us-ascii?Q?y6kAg5n539vIC0+RCr+ecMXvK3kSzULi62JC2Y383WA3F3kEX2MYvxFi7B0x?=
 =?us-ascii?Q?hqBp5WGVXhwhTbiDmQrmdrpd3DmQO2ZcQBnyZC9p47bxWikk3L5yHNtiwbsK?=
 =?us-ascii?Q?52qd227NBD75hOc8e02L/AIvMp8di1F3qTE6GLKkCrUlUr9umLwFZQcPGp46?=
 =?us-ascii?Q?N7FPR9xVaIIRdbk+iAkQKWSlStg4B7yc/65oeruoUU4jVRmevcRhTz1IK0OP?=
 =?us-ascii?Q?g/KXnNfY17A6DGZk6HdwWt1XVrW7i/47BMYHnBR6EJWqiZj1SiguGAXJcCSy?=
 =?us-ascii?Q?cIPdb3bVeSX/uVOUG/5souf3iuJ/YOShHJkL2Gy3Iaxkzgp4R+mwPppsqhqR?=
 =?us-ascii?Q?JWrk0udIduuR9wUekrWHWyzwVREDQGq9pFkWDX0mqRuE3Y4gMMKZrYrwm6FB?=
 =?us-ascii?Q?b0ADwPPTZ14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8zfJSfQhCXunzz7l3v0hx1+fVimLwfLZ8FRJczkMdWnyrfAknWnj8cIf6RUn?=
 =?us-ascii?Q?XJSl9Mx9n2hSt0Dwd46emquv/R5QmO9yPjwOxFjFaA8wM4SACMEOmzzHJew7?=
 =?us-ascii?Q?bpd05fQJJHno8ZeQyHHVtT61W01ubrpInjTOCBNWhic6YgM3fkl7riiuJ8yO?=
 =?us-ascii?Q?/+XO3X32FJiRvKg5WM9sVjc/FBtXrmu6elffCu+prwxDCDGsTU8N8NlH4NPK?=
 =?us-ascii?Q?4QncgCgTlMcEFkIzvfKGYNhu4haWMV9/MBS9Yf7rRqFew8KOOI5cfFejp/nn?=
 =?us-ascii?Q?07gBLDchOFWClJSo4qN9b2vFrCrkKJJ3gxYr9MeYjTiPCps5VlyD2CKH7kwI?=
 =?us-ascii?Q?vYFZJX6WU03u5z7w6HenmXlskV9+YORMFvNqespuxvcwqlReEHGaUYE6tIYY?=
 =?us-ascii?Q?9I4m+nHgEhyWOLbRF7Q9fp1bnZ2Vyq5LQNNT34LM93hoDpBsPTDRAnMcv+lH?=
 =?us-ascii?Q?i4o0YPPW1aHvnQJ9Z/ESRA1T4YmjJOaM6HHsfhgPnhbY7IxijD4FH3YcODqE?=
 =?us-ascii?Q?BiUDiJ9/9iboo8WEOyvnAnPYlm7uMA+4mqKEYgjYgvdfG0nBTezf/Ru7wSPS?=
 =?us-ascii?Q?MD+64a04H/2zsXQrjOaF+d/5SgI5cFouHWtza1s/70Vxz4lbwFtcSykMYgWv?=
 =?us-ascii?Q?ng719kzfbbUCvokNRTKukh0a10WZx3+3qqAC//kPtZyWIEayEj/f3oPyj5B/?=
 =?us-ascii?Q?KtQ1zAtfXCPIwJ3GPneTPneOLjjxaCHDulDSqmmBZwPrN7vqRb0j9l+J/3O4?=
 =?us-ascii?Q?vnRVsBgjP7vHMEgV4Y5bGZfMRHdmA5JgaerOB0xp146qORu1+/dJd+OEnvkg?=
 =?us-ascii?Q?SmoC6kha39nZ53/nAE7V6pvJzWs29hAWprhHUJ+OcM4Q09dfkaVcHHwGVl4O?=
 =?us-ascii?Q?uQzDxmFKZZ65fCQDLuQzOwuW11sR/+EzTcAEtr+pzDy3LpGoE98kwZDYrWa9?=
 =?us-ascii?Q?xSeFJE38T3CEX10rejxfh1SQlyskbTkbKAa2LKb05iGTOX0RqZW3s1MkXRjY?=
 =?us-ascii?Q?CgA5S+DXrQ2iVEWhXdOSPm3YWUSHZNd8beyN3IyrI0cAuYkqMFwNfXuTEtxQ?=
 =?us-ascii?Q?FGSlaf73oBq6Ns99rUAHZu95J2CwLHKYSfhIF+44cfgY/hJJ70V2bLEIuwDx?=
 =?us-ascii?Q?r/QZIILxtfTNJkJYto/5U2v5JdwtyNoXU9SQZzWifZr0Ne/RZhv+hiRM0lAF?=
 =?us-ascii?Q?rxnIIdo/LBeYplQVDdDFINDvkTiKMhtrCne59KSukcDGe3KY1T7+fObTr+0r?=
 =?us-ascii?Q?vCbFPgIdADdxlzeMVA45VutQGin4PJrpW4B6bQ3qU2c9Tn/hGjsfv6HkiNuJ?=
 =?us-ascii?Q?FsoNokrjygEL+Hr2Dqd9IeA13cfrvTNAzm3xmLzsiMSrEYSbPAS5Btf6h+n8?=
 =?us-ascii?Q?PowxJKhfFAHuNlb8H/nYkvhZqjnFLbtYPSBjHKOMuBsAb9aU82jSjl0f6g2v?=
 =?us-ascii?Q?7RL32bZ2R5tGJSSrX78hcFAyWZjhGVTtOGQ7rKTYnfrAuI+Duy1TYj7CL7jV?=
 =?us-ascii?Q?wf+D7M7ywmxLjQlLRBLTEoKQG4DM+HhAgs8hDSU95kejBuD0VrMlp1JcjSuF?=
 =?us-ascii?Q?sBOKIT0pCrlqkItx2y3Oz3FMjGAbi/49WiSwktDGYsGV84bgGEI/FKKQAwD9?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AH95beHXZZlun+zvcRRriAY3v1xrcbd1hmQ4G83+I1JvrwgBUVUzsEC8ZsLne7QWxiCrdTzBRNMssnPlTz+7nFosVPhBT/WlG+TDE5J/CS0wueXpHTXD0OxW70GBjJn4eT9+8JmYHqQX61MTr9FKC8BPaNZbajqtFTxEhhO5cYbbj3AYfOI0rWq7Yq7fCTi09Fy26aIPufqND/kUEPeEN2Ia2ld/NkTQFlA4rWrbGhZVWQyT7+qUYaPIjV7QxvCkCG87EPZ9hnZPbQjdB7iCxDrXlQkQWFyjBeC+qbaXt9SJofDeDWuZouoDr78p41Ng9uvtIiw6095TSOYkFqCQnVo4Cr8H6VN7e+CDBzEC9f7fs1Iu6AyZdlbWWJ1O5vGZsX+ykFnfw+VIitj3FYs0ICMwQaqo/YgNd4ut3f+fCuWet1Uk31ip8MzSGjAJ9FVGNnhDyOmyT3HyAw5pj1ObrA3J/KGdTk75wJqCwhldH54NSExI1Dl7Hcq7UVmXYTBO9ez50sUSXsh81WzDBF+PbmSS7x6vNeL95UpoQLGStPxCHl3CuFefigHu+FZgBg8aWpLca9fX5T13Soqdz58px89xkqBu7igJnHj2DYFWiSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ec6f49-c907-489e-fde9-08dd88d14c55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:57:46.8575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zqe4DTgsyri4VCyOn/FfwI681SyRJRUDTisxeB9syGbPwDOdPGlQukddDey1/zgOVhPzIYof/laDRclebID8zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010128
X-Proofpoint-ORIG-GUID: bwz1EKTF55iohkYAdXmwwKMQOtCjHSVS
X-Proofpoint-GUID: bwz1EKTF55iohkYAdXmwwKMQOtCjHSVS
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=6813a80d cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ihQL3A0VzzIQ68P4lnIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfXySFwQT5JWG+Z WcVGqLlPoEvRN0I2lGhZgYrgzCePI9ovHymsoklNj+fsH5sra3NxK9Cl+k5F4SD7Er/JqDoq/KF eJT/WSpJAzrbyC6jc4M4aOUTVHf2nleyliG0aHJ98gR/KP/ueitDxAbsPILbQlcTXq3EyEWZrrZ
 w4h801R3KpX5g0/BaofUaLil8DhF/yn0aPl4Bh5H6naQ3aqwD2nPBqGdaXlCVBRHBFR1O5YnswA r7CnwYujMuomiOS/wLv+6vXm8fvvwaIPXFmRuvh6jPUWgsiC3ORB/oQ5VHhC7zE5booTdQ4CrDa Gxs/AhnoIKztE6lCP6DAUNOO0MjfFwPxrD8TQgj1Tm89+YZsFbkZacXUWWGwWNMM4KIaUMClEeS
 9W9Yuc7QVJz9LR3Ue6DzdShNhwtr7wnt6aUDfDhx/Q/ZyQL5erJJfOQ7+6ZW/6/R0Mx7GXSk

XFS will be able to support large atomic writes (atomic write > 1x block)
in future. This will be achieved by using different operating methods,
depending on the size of the write.

Specifically a new method of operation based in FS atomic extent remapping
will be supported in addition to the current HW offload-based method.

The FS method will generally be appreciably slower performing than the
HW-offload method. However the FS method will be typically able to
contribute to achieving a larger atomic write unit max limit.

XFS will support a hybrid mode, where HW offload method will be used when
possible, i.e. HW offload is used when the length of the write is
supported, and for other times FS-based atomic writes will be used.

As such, there is an atomic write length at which the user may experience
appreciably slower performance.

Advertise this limit in a new statx field, stx_atomic_write_unit_max_opt.

When zero, it means that there is no such performance boundary.

Masks STATX{_ATTR}_WRITE_ATOMIC can be used to get this new field. This is
ok for older kernels which don't support this new field, as they would
report 0 in this field (from zeroing in cp_statx()) already. Furthermore
those older kernels don't support large atomic writes - apart from block
fops, but there would be consistent performance there for atomic writes
in range [unit min, unit max].

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c              | 3 ++-
 fs/ext4/inode.c           | 2 +-
 fs/stat.c                 | 6 +++++-
 fs/xfs/xfs_iops.c         | 2 +-
 include/linux/fs.h        | 3 ++-
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 8 ++++++--
 7 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 520515e4e64e..9f321fb94bac 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1336,7 +1336,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
 
 		generic_fill_statx_atomic_writes(stat,
 			queue_atomic_write_unit_min_bytes(bd_queue),
-			queue_atomic_write_unit_max_bytes(bd_queue));
+			queue_atomic_write_unit_max_bytes(bd_queue),
+			0);
 	}
 
 	stat->blksize = bdev_io_min(bdev);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..cdf01e60fa6d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5692,7 +5692,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 			awu_max = sbi->s_awu_max;
 		}
 
-		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
+		generic_fill_statx_atomic_writes(stat, awu_min, awu_max, 0);
 	}
 
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..c41855f62d22 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -136,13 +136,15 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
  * @stat:	Where to fill in the attribute flags
  * @unit_min:	Minimum supported atomic write length in bytes
  * @unit_max:	Maximum supported atomic write length in bytes
+ * @unit_max_opt: Optimised maximum supported atomic write length in bytes
  *
  * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
  * atomic write unit_min and unit_max values.
  */
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max)
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt)
 {
 	/* Confirm that the request type is known */
 	stat->result_mask |= STATX_WRITE_ATOMIC;
@@ -153,6 +155,7 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 	if (unit_min) {
 		stat->atomic_write_unit_min = unit_min;
 		stat->atomic_write_unit_max = unit_max;
+		stat->atomic_write_unit_max_opt = unit_max_opt;
 		/* Initially only allow 1x segment */
 		stat->atomic_write_segments_max = 1;
 
@@ -732,6 +735,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
+	tmp.stx_atomic_write_unit_max_opt = stat->atomic_write_unit_max_opt;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 756bd3ca8e00..f0e5d83195df 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -610,7 +610,7 @@ xfs_report_atomic_write(
 
 	if (xfs_inode_can_atomicwrite(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
+	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
 
 STATIC int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..7b19d8f99aff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3475,7 +3475,8 @@ void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max);
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index be7496a6a0dd..e3d00e7bb26d 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,6 +57,7 @@ struct kstat {
 	u32		dio_read_offset_align;
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
+	u32		atomic_write_unit_max_opt;
 	u32		atomic_write_segments_max;
 };
 
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index f78ee3670dd5..1686861aae20 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -182,8 +182,12 @@ struct statx {
 	/* File offset alignment for direct I/O reads */
 	__u32	stx_dio_read_offset_align;
 
-	/* 0xb8 */
-	__u64	__spare3[9];	/* Spare space for future expansion */
+	/* Optimised max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max_opt;
+	__u32	__spare2[1];
+
+	/* 0xc0 */
+	__u64	__spare3[8];	/* Spare space for future expansion */
 
 	/* 0x100 */
 };
-- 
2.31.1


