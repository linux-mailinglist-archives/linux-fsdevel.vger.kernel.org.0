Return-Path: <linux-fsdevel+bounces-48191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1BAABE6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5F73B831B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846CC272E7E;
	Tue,  6 May 2025 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EeWbd07k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Iaqr4nKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46D264A7A;
	Tue,  6 May 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522334; cv=fail; b=bpunIIJ9UsKTd+t5VHiazLTozCRYqtqyTYGiHekNV2W/1SNahzStP0oHLKnFLe7jUOi7N5GLeFX/tE+Ahak/SBP5sD6iiKqb8kO8S6caG1cWNz8F+Jqb81gEkGJhdkUW3CiPUfdGh49DvBS4emC6NW79NEbwWikYduFw0CopusU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522334; c=relaxed/simple;
	bh=kVSqAeWDu8ziqRxQQdgsgIOGdhMwthyM/ociEtJJwSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iu+YTJx3NBT4n4gxQn8WrZi9qO6+CEBTrVktBsTtmpZhaVZX0DuMgKMwAY5wsdfvZpcAqcen8Pa9IeAMe5BFQliCYqJKX6L+U5/1d4ebt8N4rz5ripMMTV1n1EaDcjpaBij2Kd0eAa+fVRJeVoFteAsrdsca849CiRuQvcOwVqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EeWbd07k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Iaqr4nKC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468bbn1027344;
	Tue, 6 May 2025 09:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YCritS9m2Q6aF5Hw2sqkjF6hPr3QDEKNBZmkOs3fKkg=; b=
	EeWbd07kZNFmBtvr+tgR+vtGzqxaKHuKi3uzKYWeUhZoDNJnWwmpZHujA1MfqREk
	e5nEqJP6jS6cQkW7s2PvZuwhVNetYw06XqqkZHTs0ZCuxMweMgDP2l3sR3E9dwqB
	upODsKpN2QLohtE6UqTtPnnAgPA5qymjcKJouLF5VbPhi0hCXAw1CNHsKrUS3Rew
	LtFtORI9l1DsC5Z7LJ4zFJqQCh9CezFOXBk8hf5cqexA/AofR1PD9WoaFJ65iCZl
	WHfOcZtrYjYmFZd05jTRgKelFa7QDAOgxYW1f+TgYINK3hXvKRwtKVSpOBbVKL/A
	HklBHyIjZ2vQgP9dBfB0Ew==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff2t02k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5468CAR4035353;
	Tue, 6 May 2025 09:05:17 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8rmqc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+ugqXbeB2cfHJRqXcd8YaNnKrjyjQ/fDLoKN5Ke1KbN0kM+uClZ7LN8nkdG+2l9vG1kciQUTbY7MQTBNP+UNxixrjRQLMGc3y40gxdpFEN377C8uLXlHy3wHurhPPQ3QRnVqe/oc3nZxOikyAF9yH8981EvwpI2gnn0Rcr+B1PLcaS9WQbxtlUmisZmUb3WvtoX3lX6u2Xsj1bK0jq3jGBQQ/fe8U+WLvhmSDnTf11aiaoh1AatXRqdZvGde3N+3S+8mdt59mHH45YBO6lbcG3UlJBBizCPzVBwUgD46d6IOP0b5G6CgwxDmNscQFW3d0SRq9bcueFbmnVv2l71nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCritS9m2Q6aF5Hw2sqkjF6hPr3QDEKNBZmkOs3fKkg=;
 b=FWQoEEUGOEpFCPQkQiq/TwgQljP0ljHy/5ep8RwMW9Id9p2F2HXgamD1TYIekY7szkrt4mHXX7SL3YQTrEQ3LaN8v7ZYUNw+InzQyaRWOX1TdhwUKQyAybERQttB6dFLt61SLokBKQH5vXm9pE+T+BPO7/2V0KboMIGx0YX/X7/QjhWngGATZ6WeWE8qL+Kmi4Cxz40oE116mldXRrnkLxNVZsBFxdcD2/Zx9RMsvGPu0DvTM6ZsOMPeR0vyYK0Gi4uW55mndSfbLgvgbJ3RBV0jc2/SCdFl0d8qDIXPa+UMaLbc6JTUbCSFRRxbTwq1IvupbEY+JppI/SR9OxX2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCritS9m2Q6aF5Hw2sqkjF6hPr3QDEKNBZmkOs3fKkg=;
 b=Iaqr4nKCuXgt6r4KQ5Ovv8RSgSz3dx9Ktn6K39z2bJlUUbOW2vDmqAvUWGVQxSGDxPJdhEGob8BEHwI2W7eEIbG758x615iozjkXpVemMFbmDOH+aUWcUK+ZXPwT4quniDtXJIpd1Zae1sUyBrTpHM/f3jUy5wb3FIiHZRWLB5E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 09:05:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:06 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 02/17] xfs: only call xfs_setsize_buftarg once per buffer target
Date: Tue,  6 May 2025 09:04:12 +0000
Message-Id: <20250506090427.2549456-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e364bb4-5152-498b-6dd9-08dd8c7d1868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NPW+ld1RNsWVwneBNpjVPpcCMxMPXB9Gx+0lfnI9jY2B3vyTx/PNL1/CfLCk?=
 =?us-ascii?Q?rODjT1Wf27SNskx2sBb7fLOp7qYvi4ZmiG/xbayzNdw/Ygw5nHkCFY0WFtdk?=
 =?us-ascii?Q?tTVLoG0kU2LgK2OEkiz6hNsDJ75K6JvJ0FiDxGTv0QMHUUaDWV2+zmN8FGtW?=
 =?us-ascii?Q?0c5OH9amD1CRcCuQHzeFjiTuJ3SjK+xXUi5EbuyoKHMjiy4RaR/W9nW7zEkx?=
 =?us-ascii?Q?QKuuC8GL17FTMP8ZihmOkI7hqMvzqvfjpySRfonFp97FjKAjfjab3ysuwrIj?=
 =?us-ascii?Q?D1n3BrYVfMxRlHcHcQKVbyZczVYCQ9b4qov6w8iJWQEQGyzkZBUHwZglDb4Q?=
 =?us-ascii?Q?uUltb9hxSZ1I0UDFEungrQCxi9aWDgz6cmruwX728rpj0dbBsZmWHBi8qc+4?=
 =?us-ascii?Q?tdbW7SuDwhpjCOQO9b9XAMP41iwPNICmajZU+M6uWeFnBO4mUYqF94CBizzY?=
 =?us-ascii?Q?4an9eum/8zqyUeaC9WRJ3S39negYow8FiNLrnWqygbrTBBshMrk51N1T1s6K?=
 =?us-ascii?Q?IIRE0nlxi+MAIl+AqkQFcvc4QbOJ8F4q7CJryIQAtLeVyoNMf7H+NkQLpmOL?=
 =?us-ascii?Q?Slk1bdt9qWaT0P/PkiX+sCCaSLW4GAehAKNOsE0j1jVE3kv+P1t5IwmwTVFl?=
 =?us-ascii?Q?JGwkGSWcRvb6jElKvfujwEcOuRk9fLrRjeOmHV9VtRfcDXSKPMkNiOSfefLb?=
 =?us-ascii?Q?hc1FP75FrH9QM6YaCGUBeg3MrGsIt3Saxf5CcPXu0xCERlw37Nuqhe+BNXlv?=
 =?us-ascii?Q?Kc8UWTJd8p16FmUeClA2IqsQp5CklXxhLmC1DkFlZKsdGBEG53vt9QYih8oZ?=
 =?us-ascii?Q?inA0NulZLh2y5efb4Vh0gO5pakdjdndAgpWbloGLFubTZVsJ+Jl91E9R31hG?=
 =?us-ascii?Q?9I/+fHn99i96jGFFHPAR7G4rx0Tg+NBfqX1NxuENT5Dkx+4gCZ9AwQ/R7kbn?=
 =?us-ascii?Q?+rDsK0hyH35DTMo8dMqWOGFY1lL5no6tteMcyel6HRvbJf0cxEoooCLrM1LV?=
 =?us-ascii?Q?H9vEB5+dS3PHRDsCgFf9UCfTvLFyD4+b2phToAk85axlV52pENr+AT2gzdM3?=
 =?us-ascii?Q?9+rNric3GwiV8nfvkyO1TM8MCzwS34E4JaiaHoI9AjPpSkn4q+MU0juzIRVM?=
 =?us-ascii?Q?om+03J9Z9kReLx1LHJ9o5q8rc5LRVMGZhyh3vi4yQ0MJ3IX5fRgtEda6UIZf?=
 =?us-ascii?Q?xHuMCjomA5QiZvByI4TTtvubsAqMO/w5OU77Ncr5Qqibi+601Cjg14++ZoYK?=
 =?us-ascii?Q?On9ZIRmgFWnrn055WLzeItxFCpZNbfhnvhQzpsYcvmKFrJ2panWEqVkv4zxM?=
 =?us-ascii?Q?p2optQ3FxIrkZPo+3aVcGMjDF0HkHxEDnAjg8gW9slJD64Mk/dqxVZy99hVm?=
 =?us-ascii?Q?8Jl9oQTt9p+o+m2RWYaGCGMl5gCUUvVlm5UZbRYJa9FI/Pl1ruybe+l1R9pD?=
 =?us-ascii?Q?skxgtC7weE8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LZKsMyPRuR+95lxF+y+z7jllS5wZRdRIztbDiiHSxN+mhbgiCypaZZUtDltP?=
 =?us-ascii?Q?Qi0d/pplIXoQthOTB1sVTlqR+PSmRiZsecK7+T7vTRw4+f3OKwbuD4gJNFvB?=
 =?us-ascii?Q?JkWMJlRf/S1xmCzpNHLuJH27NHqvbX/KbUTLZLvpcP/wp7aTKV7a6VChW8dK?=
 =?us-ascii?Q?B4GsPID8NQrrz6eawUuIM1cD179nvzcq+5jAsZ1qXRy6PxOd51fp2qKjchiG?=
 =?us-ascii?Q?cBbbUhW46lp0DzksMrsolOeivPF/dhJLdbRgCn993SGADlUpS+ASEGgOdSMr?=
 =?us-ascii?Q?4AnrGCSQtQ2W7Ur/Sb0MC0IQZju1BAoviqD5QirAN87Fg1ZA4ZD9EoQUMDXu?=
 =?us-ascii?Q?rDbDPCbd9O8rQTrkofilk2tola6ayzEBwMOaGSuJLrIoUHhMJ9uEH2yefdtx?=
 =?us-ascii?Q?/PzGmi4l7byNm8vBkne4z35SRHij5H0BEoqtI4PQpxKbiGM4VGoqAxJnCCXI?=
 =?us-ascii?Q?MgxuX+0xs8/pC3+CmeoVvDXXNldpTbDakGzvEoPkjAonvaUK1eC6FhDGHUh/?=
 =?us-ascii?Q?rlp3pdcAOe3qcdPeBm0qHw5KWGUg8ms4xQI07DAeYvZ2Gr6dbHf+h3fSDXrT?=
 =?us-ascii?Q?U3qTe1Es0ud07mv8WLc4qZyeBcA/aEPRvtjMTiWvERCOlcYGnisbsHvIubVE?=
 =?us-ascii?Q?DUwdcbc57CQZgAYOywAyivkfIg9hs8uYxXEG7sn692xg+6PPiJZTtAz46ccG?=
 =?us-ascii?Q?qfLNspR3ngjnBIeEuWvBNhNu/rXpUI+hxRaxqKThxRS8SLGXzONShTOwR+xb?=
 =?us-ascii?Q?2fSWDtF3vAJK7aztH0QMGK+HvEtDh/YuOetVN/aWJWhUQ1N3mkIXnXoBblPP?=
 =?us-ascii?Q?5dkUqjtbCIY+NTJ6AN2981gt441wgqiWEfTJ3UlZbsdPvv8UFO6v+MLRHa2s?=
 =?us-ascii?Q?p1tU6deMtf7I4DMxUKmH8R6jHbWPottBR4NGVtdB6J1THGeQRKyqG6WOYqI5?=
 =?us-ascii?Q?plUYV6Tfssx8swfdTvLv+/P0/bPGVV/PTtGhHnUYSxQxyKVEIPMW5fd+4z7s?=
 =?us-ascii?Q?xgBhDa6vK3abFAi8CLg/wwO8C35LGgLA2km8k2l64J+p8FmtHBfg1GkYrNra?=
 =?us-ascii?Q?8Sjm08yAStxczwp0pPrGx+KHd3k6sa2jV+N/rQzt70g9BqeNScMeaIG9REFV?=
 =?us-ascii?Q?HWqEtC3YdEh9dUNoihTUqul0q7n7kv7kJpBQzsBnTnpz5bwCifEkwp0LGkdN?=
 =?us-ascii?Q?4pJ5qcJ92kLNUQeydFUoQUKeDbI0SEjdLVMuwLaJR3ne3PZZ3VAEiETMyNkS?=
 =?us-ascii?Q?PbL6/ToGA7PufTvzhVN5Klk/1DtMagpYpFBrOeGt/tQmGNHcregSRnJbv4tj?=
 =?us-ascii?Q?fTrgZIxq1eIO6KsqyIfysW59FEDvzKMkJKq0vbvxFyMgJbjm3Q92Ofmitwkl?=
 =?us-ascii?Q?/WssdKvbNZG1NUlgmQX0KpODpPTzit+8IV6egxuUM9RxEDxikAiKNCRYMUvF?=
 =?us-ascii?Q?PNU4cX58k4K9oRPboSg80Dt1MQhMplxAiO+IZEcD5VauS1QV3SzXViHbqPNW?=
 =?us-ascii?Q?Ic3Jk60hxTPaih11oULwK2zelrX02uNZqoA7bdHvXepbc4yUsNaq5cbHeNaU?=
 =?us-ascii?Q?KdDsLyq2huIlxqtQxVmAD3RMszwyJl5I3M2GPXXx7H8jzgZj/G9OO7GJmXOW?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rUezrOtZyMmSCH7at+Ae2TfOkehcOhZlp+TW3THcviVEO0eyPX+OluyeGb58yk0JTVpcm5scXDftodk87FDejtyG8GCwjKXAX7lJRmGABw26/BX0gNSjaxWx65XIT9S5NBRpeBdHtg+XzkpUzAeEIaj4KmfwjVFoaocZaZj8hw1QVBQdQqj4ZCvM35ir2AFe/peX1bPtD7/SVh3oqq0uQu2Ofe+yZd8VeD/xK/vchYHV4V8OPlNolHqgSBAXfzs6+H22qMoZOI+AslTvwdolQWHLiDdLxSua2RGgpdSQdaLsUh1ePlUOMePs+3dEVoGuXTozjFxWj4XI8O1+HB7qBFdCn0AAvUd1BqEeEgw3/ThJdFNxeqlzw2Te53Kb/Oyi/wWYpfSA3M+yAcrgvI99DErp51fu2TOd1l1ODh68gqV67l3YqEyDK0YiVVrnD0aY5urujZiJ3++XKN//TpzlMhwtUjEXGJ15zZl/TSz3QoZ+fH9Krv/AF5XxOQzu/NgrIMsNJ04yIBmrmL51Q1QGT5mcvoeakvhgqAfc/BU4bScKyskSjM8OUcOTUuJqHFBJ4rRTcb545yn9tSMxQPtzEUGi6nj58oYLlmnufzwlBHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e364bb4-5152-498b-6dd9-08dd8c7d1868
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:06.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gc45kxYO6QQb4/BxmFbi5dXSga+z5NLcoHXJ+r3k4Nut/GNy74J6znpTvehVz9e5+i80NfpyqmKnQ6X6UQHGpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505060086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfX9eM3G0VyF0kC jZNphH4z7+u6ZL5XfQ9w1JHOgvLKMd/P+vu5cM1riO91usZk00dlPT7yMQJGWi6akZHFb+58Ktk neXy+JgME1HcxekL99o8Bj0a2LgNl0eqosFlAGK1I5omV8ZaodccXRImHvSLn3IlSbCv+76D46O
 wBUEEqkrRW1GXWjb2dV9H9ZSILnD7N3NV3E4cZxpMfajiZ3Bl3GC3rmn4TuuO4dYphxuVHbovf8 dcP6OOuKRmzIWCUxRkNg0cnmfG9dLvtYITpaL5ZceLT9QxeLty6cG0B3C3FAMdEnL2DMqodywtt d+haNQuw9mQsTNKEqTpZiFYFOTdtikbVUCQeeRfc2DiJTtPT4qAuH0jj8Id8WsudZBxbC44Ucbn
 u2p7C8Ua2I0mzlBQ1GJeiPc3xBWbxuGE2vfvqRdNZ/N24cxmEEBKyNaWKy16zY7q8gVSnD/F
X-Proofpoint-GUID: LE2UgoEtf-pjvR6jMYO261qdxQ87qf58
X-Proofpoint-ORIG-GUID: LE2UgoEtf-pjvR6jMYO261qdxQ87qf58
X-Authority-Analysis: v=2.4 cv=Xr36OUF9 c=1 sm=1 tr=0 ts=6819d0ce b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=RKwlAWmLcNA2bNi2txsA:9

From: "Darrick J. Wong" <djwong@kernel.org>

It's silly to call xfs_setsize_buftarg from xfs_alloc_buftarg with the
block device LBA size because we don't need to ask the block layer to
validate a geometry number that it provided us.  Instead, set the
preliminary bt_meta_sector* fields to the LBA size in preparation for
reading the primary super.

However, we still want to flush and invalidate the pagecache for all
three block devices before we start reading metadata from those devices,
so call sync_blockdev() per bdev in xfs_alloc_buftarg().

This will enable a subsequent patch to validate hw atomic write geometry
against the filesystem geometry.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
[jpg: call sync_blockdev() from xfs_alloc_buftarg()]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_buf.c   | 28 ++++++++++++++++++----------
 fs/xfs/xfs_super.c | 16 ++++++++++++----
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 5ae77ffdc947..d8f90bdd2a33 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1733,11 +1733,7 @@ xfs_setsize_buftarg(
 		return -EINVAL;
 	}
 
-	/*
-	 * Flush the block device pagecache so our bios see anything dirtied
-	 * before mount.
-	 */
-	return sync_blockdev(btp->bt_bdev);
+	return 0;
 }
 
 int
@@ -1786,6 +1782,8 @@ xfs_alloc_buftarg(
 {
 	struct xfs_buftarg	*btp;
 	const struct dax_holder_operations *ops = NULL;
+	int			error;
+
 
 #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
 	ops = &xfs_dax_holder_operations;
@@ -1806,21 +1804,31 @@ xfs_alloc_buftarg(
 						btp->bt_bdev);
 	}
 
+	/*
+	 * Flush and invalidate all devices' pagecaches before reading any
+	 * metadata because XFS doesn't use the bdev pagecache.
+	 */
+	error = sync_blockdev(btp->bt_bdev);
+	if (error)
+		goto error_free;
+
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
 	 */
-	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
-		goto error_free;
-	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
-			mp->m_super->s_id))
+	btp->bt_meta_sectorsize = bdev_logical_block_size(btp->bt_bdev);
+	btp->bt_meta_sectormask = btp->bt_meta_sectorsize - 1;
+
+	error = xfs_init_buftarg(btp, btp->bt_meta_sectorsize,
+				mp->m_super->s_id);
+	if (error)
 		goto error_free;
 
 	return btp;
 
 error_free:
 	kfree(btp);
-	return NULL;
+	return ERR_PTR(error);
 }
 
 static inline void
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5e456a6073ca..6eba90eb7297 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -482,21 +482,29 @@ xfs_open_devices(
 	/*
 	 * Setup xfs_mount buffer target pointers
 	 */
-	error = -ENOMEM;
 	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb->s_bdev_file);
-	if (!mp->m_ddev_targp)
+	if (IS_ERR(mp->m_ddev_targp)) {
+		error = PTR_ERR(mp->m_ddev_targp);
+		mp->m_ddev_targp = NULL;
 		goto out_close_rtdev;
+	}
 
 	if (rtdev_file) {
 		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_file);
-		if (!mp->m_rtdev_targp)
+		if (IS_ERR(mp->m_rtdev_targp)) {
+			error = PTR_ERR(mp->m_rtdev_targp);
+			mp->m_rtdev_targp = NULL;
 			goto out_free_ddev_targ;
+		}
 	}
 
 	if (logdev_file && file_bdev(logdev_file) != ddev) {
 		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_file);
-		if (!mp->m_logdev_targp)
+		if (IS_ERR(mp->m_logdev_targp)) {
+			error = PTR_ERR(mp->m_logdev_targp);
+			mp->m_logdev_targp = NULL;
 			goto out_free_rtdev_targ;
+		}
 	} else {
 		mp->m_logdev_targp = mp->m_ddev_targp;
 		/* Handle won't be used, drop it */
-- 
2.31.1


