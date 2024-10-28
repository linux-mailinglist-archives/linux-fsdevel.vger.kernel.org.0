Return-Path: <linux-fsdevel+bounces-33077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D02ED9B35C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B011B22CA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C68A1DED47;
	Mon, 28 Oct 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mMN32NpJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HNJ336/K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A051DE892;
	Mon, 28 Oct 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131604; cv=fail; b=TcyOrHNst8l6UYdac2yz76REUYQcjhFh0GK3CFJnPaZNXIfYbf0yfUoUhPmYB9Ugr2QIIXDZZ6r7Q6br/GcQ5nNUgjWXITl8lHWge+S94SeXwV5y+OebKWrgyXqz7yuTqcJGYSX57W1Qzh91uSmpDTwRlatosgghgWWMPzZgU0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131604; c=relaxed/simple;
	bh=+OQCzP0FLjNZR3MYzcVZSjN+uuKVeFAHmVqWYzUA3sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mwvQSDG4DX9DUXdDLhcjuKjfIKv8n7UTr42Lgtk4jvgaSPs5XPZWuKOoXYXorPOFvzTl+IntVVD3okJu6mNAx/FiUrZ7zCMGMzH8HG1J4Pavf11prX2KK1YS1XjVlXpN9BbjCBumf3edOuCDImzAr1pyKOzr2u+ClRQU5ZnxD4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mMN32NpJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HNJ336/K; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SEtdJl029653;
	Mon, 28 Oct 2024 16:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6u16vWKR147kTtxzzr
	KOqgQDJjy5Xpy8WGUJaCxX+Bo=; b=mMN32NpJ2jMjnHvEse1YfWlDZC8sfSJmVl
	XvRarXm96Kpg4CkZ73+WNDYwwaFjvD5JNtgCb5tmL+aKxTvZXnqflPrA/TdBDpDR
	cfTos6XNmCwFugCHzScGdzj0wwolsrR3i+2VrbFcZdHIYCFxQTUKMV+xBTXpGp9y
	Xhw+0cbLU7k/vcDcPkXAkfdrBpIk49Nn3uAZ2c11hJ0m3g29BwY7KUeXM3GQLbtD
	xGM+LF6d9yXPGMs4Mju39WyN0brYbf9jS63TvXq4WlVvesmp4gDtVK2b7zG7DjBq
	OPweRL1cvAHdom257NcmM75lK8XJwkeUxVheM3hlxhgkhG8b7gFw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1u8bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 16:06:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SFBpT0012103;
	Mon, 28 Oct 2024 16:06:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnaaxr0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 16:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsvrrSWeLBKoWhIex8itMubAAv3VfyJrDyK7ggD8+U56KXGCPWP38bkm2LemheEiODSNkruAt3bQDqNXGqbbd+A8zKLdVxJ9NKvCg4ARpgsDIcx19cVem8T3Dgkv6eIwZaBAlfiLnoaFsi7QEG6ksQnUPNPYtttj/kfvinfqd8LX1gRrO/meEWR9Ain/mE7LNtrr5Umr2teZ94iNs3nOep+VusNEEC2uEyp5Pfmk80J6OvBQoGdLLiJzNRYQHl+Ex+JQV4GvC6G9c1Fmh40/JUN5RLbA8uU9b1Ry0h+R8lgCLxuWl/dGT+G4z44LN9rrZb2vmkY3g6YAtISk6tdkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6u16vWKR147kTtxzzrKOqgQDJjy5Xpy8WGUJaCxX+Bo=;
 b=XsivCZZK+1qRiPcqzC9NOQuhEK+7kLkydFXy906uw7A9iSMfcRtPtt0OPqVZztVvF0t3biMNcq2248tqdya8Sa8t7mNltPQkernHdWSRTgkUPdOJmw/2K+R2xihm1hheue3FowsAnd5gEL7AgSG9o0x/lwRSt9cnJSwXJ5jD/vVNPbvJQuEyPsAcCjA3zuEbJE45Z2wC2CK6LfIZniE8z64OQ6KB3eoVYV4tlZJ5BKd+D2JIJHzdEO1rjWKxqlJ+sv6WUyL922gWpaLC/eeu0hwMxVsS51fltvmUM2fdJAPev6ojsqI8TlndqBFA+Brup5WPnnMQ3CDzakX/zEbdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u16vWKR147kTtxzzrKOqgQDJjy5Xpy8WGUJaCxX+Bo=;
 b=HNJ336/K3PupunxQcCYAipCjbg2bostS62LUhvqtkp3t+/92QBrmNIPicS1djVU9Qgaw+7my1wb7FTYDt6g7RIEPr2WZwwlGluoV0y5ZQ9CXAOVySZapcRmW5Nj7hNyRhSChkHrlbN40iKHESe2Miyi7EffUDriDrx+tRNnW/eU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB4941.namprd10.prod.outlook.com (2603:10b6:5:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 16:06:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 16:06:10 +0000
Date: Mon, 28 Oct 2024 16:06:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <c96df57a-fa1b-4301-9556-94a6b8c93a31@lucifer.local>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
 <8eceec08eb64b744b24bf2aa09d4535e77e1ba47.1729926229.git.lorenzo.stoakes@oracle.com>
 <20241028-gesoffen-drehmoment-5314faba9731@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-gesoffen-drehmoment-5314faba9731@brauner>
X-ClientProxiedBy: LO4P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: e8986c95-2076-45d6-b313-08dcf76a7089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I5py0VbdLU1gj1wwHroh/6V1pvczJPLg63d1TyRegSC0LNnTJrNfD/px+qvO?=
 =?us-ascii?Q?T5pDqCGLzEAY0j9u3V00ozuc5deZJKpZjnhLBm+Ioh116a0OrJ6MRzueB7ls?=
 =?us-ascii?Q?Pjolc3+qQn0YRDJll8gWLXbE8spTFIW6tF/Pc8HZU5vNgblxP/8qNp0Bj6sW?=
 =?us-ascii?Q?HDW1QGPHP0GME/kMsQ6tXMQJzo/hHbyppvVa7ebeXNNZscf4m4bfaoSiL8CJ?=
 =?us-ascii?Q?O0kZR9kGhmfYFb3U+hZv6synIgBU3M5Q/eOnbPk6e9vshNaOG5QU38xt2cwW?=
 =?us-ascii?Q?1Za0CC2lFO/jzMDlHQo9siZNNh5/iLs4tv5pofZMvBAPsOhQYCI3MUe2VGmi?=
 =?us-ascii?Q?RhNy83376kknjgg1Tqa4qON3Z5qxKZEp0revA21FedLT9FlmGX+cpNxlNWbc?=
 =?us-ascii?Q?g6k3bGQIHhhvOwmcGjoLT9IK6YdbY9yKoYLmd60TEGyRJKktB2l7x4Q+Dqa2?=
 =?us-ascii?Q?BEGQ4urcCxog+5lo4Eee3zv9x/UpmFQU4s3z5SQEjhSIpSf3gAIzwPx4q7ZC?=
 =?us-ascii?Q?gGb8pKCkkrn0kbr9oyUCcX8GCgpMmx5frt9Rckofra5fEslDa06H7XLK7vO/?=
 =?us-ascii?Q?5ngKHM0G46SXQr2d0lmakupxLsIiJJYmYgPLAgVJ49MyYUPSxKNUU7TBRPgb?=
 =?us-ascii?Q?xx73CuAkVybu1vcMB59WwXSZ3gLbJnhUnOBjgzoXA4f3meU640GT1wQjCxPR?=
 =?us-ascii?Q?MyxSoJG8SWb9E/OE4rDH34rvuVlD5TNJg0RjIk2qKWM1E/Ya6xLCQyizdFE9?=
 =?us-ascii?Q?UYXzCLNeCCaiLiqxLSUX3WS7YrrIPMgY2GtM/NvyO9PGOz4Hzj5nggm+haAg?=
 =?us-ascii?Q?kciZ5OPkq1ZEMxgTTYDvP/c072WvUSbXUm55MPFdCFzfbYgFcbA0s1Tp4Dkz?=
 =?us-ascii?Q?MOU+8bWWE/bIhSgKhRsp2qBqPr7iCB5nzibrcvk/FFt8Ob5A0MEAyeyEFrsg?=
 =?us-ascii?Q?I34ilZqEjnblzQtG5IFW5ZTF0EJZkQOiqzWtKuGfVv9xAmp3lbHkzbNhq2+V?=
 =?us-ascii?Q?FP3i65fGYQduWCXN3jqBvTItXN5iGy4msMCQPue27JNpFt6RwzJz7TE8FIE+?=
 =?us-ascii?Q?dErTL+5AyLb/VWbtwZ268K1DRwbbMuYkHIQv6YuqidbncQGm8Zx5phl86UT6?=
 =?us-ascii?Q?iQ87qqVJQ3fbqhX4LXAIP/Eprm6Ye5wfIzSHEpjUfvGKlOp08F4PK0owPWqL?=
 =?us-ascii?Q?YSBBw5UlQkrc8f/jjXUGORs4YZ6HTFNjDmtGT6vOu5bAc9uhYFol0MjcbJiF?=
 =?us-ascii?Q?eBLhlO9ZehFZuAnPyfK1a3pXxQZL0X9j7DSU62qo8EgfdVy5SP1zrIueytkG?=
 =?us-ascii?Q?Z9JeK3IJ4Ej8JYXqRsHz0o9p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hhbT1elnv8OrWJQTM8C8Qvc2X2Itt57uYvIdpDqrxIHrPYLMr4suW6fbmc87?=
 =?us-ascii?Q?zX/x3bfGB1pe84lf7ThZQz05g5qa6p4ovqUN6byBCxFP5mDD1ds/qJ+WrBll?=
 =?us-ascii?Q?UugBMUTvu0X4xwdH6pFHH9h3VzBvZBhwvX3XQfPeWnIpTjDs3/cE6O68199O?=
 =?us-ascii?Q?6MAUiS3fsIidFLbCMQ92saEmZ2bpXNtsTAkQmF5LJ6rWjqQTtjoaudbGpKyu?=
 =?us-ascii?Q?3y6ePmQO4JMSBCJW3K9LDm/gaZWfEOkLDittYjbSS+Svwe5AwT85b+nWgnuE?=
 =?us-ascii?Q?lWI9M+UHcg7r9uWjmLr2QiML6uqxZ6cqD6j6I8jlA4UZBmfX81SZLi1QIQUX?=
 =?us-ascii?Q?MgvnZlWSyUo4PsIDMJa52DQJ3BCvsnZ0zvGktyoonAbt0B4rWvNQptK4+lz8?=
 =?us-ascii?Q?EJ8tQ7GC6xW4JPitEdJxf6YM79KOw2/TsCoWtBMqG4GE5eSb/O/Xjmif6iSk?=
 =?us-ascii?Q?MlRMG1gAS4L1IE9poYlTWHVvNtQOONU9phbbvE981muKzHJxf99pV90ovYX6?=
 =?us-ascii?Q?cGEoXA7PM1S2ISYu380tZeDwWE3Rm4QXXoK1MnJlylZMHkWrhw6Nf/E9eTGc?=
 =?us-ascii?Q?oZusoqRu261xh4gt0YUwk8wUD/gD7A8anoaehXopTn2D2NB6Rv9BEgKW3W16?=
 =?us-ascii?Q?GVFEDTsNmApKdGJdNBuPD8MXP53ImyRN4E+7MI0wClCngh5xUoX0fE0uJJnb?=
 =?us-ascii?Q?U8wM0Hq4FE2ziPUlmjCSs6Y4xBorrYK/w0DF2m6/w9nZskJSY7SkQuvLNEgs?=
 =?us-ascii?Q?OyryfiNp9oAraytKNy1iIxdTkdlynAzBnUzZEq0go8Ym6Xy3eQZAzwLItpAA?=
 =?us-ascii?Q?GtE89/BAtiqhn1t4bZT2+PXOIqM0Ph8HGVrKTIx53Xr9W4iqsMj2gf00h13r?=
 =?us-ascii?Q?P9shwjchS4rGt58Ibq3tM+z3kvu5ovFwS/607KekmIAXa5hY64p93JoGnjxl?=
 =?us-ascii?Q?pqhcaHAur3aIq8TfAQicSc+BCIP8RXTg0qM6wCBZGr7rDWdmCa+7xdoN/U1m?=
 =?us-ascii?Q?tJcNjsUE1eds0BoE0crqMgz7E9pqlaqUdFWeNdCxHGXHf8yAh5Dp/H0DkVn+?=
 =?us-ascii?Q?FX1KXWmm7CV+uqqi2iV0d5NQXbTzgkfaL81sULfLGJRxNul0Xv6EETxu4hGP?=
 =?us-ascii?Q?+DPBBD2H0KfnQ35hE+O8GU0YCIcNgs4whnJEdARhsTAIWIkTAdSDZVdZGDsS?=
 =?us-ascii?Q?wEbgPRzRgeh9TTg/0RkliV0IOB7O2Q6qgjSvedR0VqM45FP0WIx4JsF797sa?=
 =?us-ascii?Q?606hutCAY4512zZ0CAbBpJOq0hy+udoQLXiMECQ7WGMAPrCg5AtDw9BqHU47?=
 =?us-ascii?Q?WBTGd2IpINeT0SxHr1E3la672y4cYLpytN9GeakPD07waylzR+ndNPrC1BAo?=
 =?us-ascii?Q?hXqHFwbgvJtZomlcYmBH6JcGNCl/wFUyjGaZW1AVO57U/t6+B8idJm+wUH2f?=
 =?us-ascii?Q?1sm4Nu4mISC8A/1JA+FW45K34LP92Kwm/+TKZFb9RozpcWQ5H2JGm4VBOjCW?=
 =?us-ascii?Q?wMHEnICYvYT15PAWmQ6w/ktq31x4BfuiKOiRfZms8HW7wXbAEKKGsduVScKh?=
 =?us-ascii?Q?V+gCcbFPRtv7mmih0kXWAy/xtgmjAV2st3vKsJA0huoUDRvhcoIIY/3XSAx3?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gNNOKev8z7N98QG1Mw3ypWAivMYfLKkWU2Zir82V4Nr0iCNIgmLp0bJ1G2Oi19/s1NY/LR3CcZL9vliX1LlG7uk11gbd4Bai+OAun5rmFVKTi9yL3ICvm5hfwV8prH8ITLlKn96XR/okgxFXdb3KhFLDW0c3epZl0S4UM4xEpnc10YusHCG+Un/pGwA12T5dzaX3lM2E0XIcMzKJWUWEPwYTSRee7ayvoZ3kPsoXe1ZQjmqAp+eQTFDZ6VMOe91Z4b4oB/9WrqxktbuVZAGpbmBfPKkkwPjECnZdZ1wvY4fHS4xEyblSH6uPSn6U9CyEtyGg3S3po6MRrtI0VnFjOnl47ajtvZC1SL9QZA9Xr1uLzcjenmLTEkE13/9zjeDEB3iiJLx096OyouIrMNPXVlHSZkvozHvYti6vZUklglThluHWNllGs5Br8+u33WLg++ufFGvBRLW2WUb+i8Uo/zO4Gto8SB0k/n308VW5yOQgi1voww6WLsoLKhz9HIjVJDhxzSP64f6VVc+c5k2XVvA7ryQVDd+rFLjvd0ZhjVXDitpmquCUxSB8LPsf7iZ7/NGXdXGJANyt6+ZOSg04aqvWswolTvujcliRpwva6+0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8986c95-2076-45d6-b313-08dcf76a7089
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 16:06:10.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfusf4HSSl6p5hCnkabSwvW32v9cssj05V0dshY4fX2LUsoKhH9bnq9Mt5beC7uvkcTeLXmt1WoCVLTXNXDc1XDUPpqDguy9HDXZgvXlwHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_05,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280128
X-Proofpoint-GUID: 0pWmbviwtRbR8RdoURFymKJoCE2_ca1r
X-Proofpoint-ORIG-GUID: 0pWmbviwtRbR8RdoURFymKJoCE2_ca1r

On Mon, Oct 28, 2024 at 04:34:33PM +0100, Christian Brauner wrote:
> On Sat, Oct 26, 2024 at 08:24:58AM +0100, Lorenzo Stoakes wrote:
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
> >
> > Due to the refactoring of the central __pidfd_get_pid() function we can
> > implement this functionality centrally, providing the use of this sentinel
> > in most functionality which utilises pidfd's.
> >
> > We need to explicitly adjust kernel_waitid_prepare() to permit this (though
> > it wouldn't really make sense to use this there, we provide the ability for
> > consistency).
> >
> > We explicitly disallow use of this in setns(), which would otherwise have
> > required explicit custom handling, as it doesn't make sense to set the
> > current calling thread to join the namespace of itself.
> >
> > As the callers of pidfd_get_pid() expect an increased reference count on
> > the pid we do so in the self case, reducing churn and avoiding any breakage
> > from existing logic which decrements this reference count.
> >
> > This change implicitly provides PIDFD_SELF_* support in the waitid(P_PIDFS,
> > ...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
> > pidfd_getfd() system calls.
> >
> > Things such as polling a pidfs and general fd operations are not supported,
> > this strictly provides the sentinel for APIs which explicitly accept a
> > pidfd.
> >
> > Suggested-by: Pedro Falcato <pedro.falcato@gmail.com>
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
>
> Currently, a pidfd based system call like pidfd_send_signal() would
> simply do:
>
> fdget(pidfd);
> // use struct pid
> fdput(pidfd);
>
> Where the lifetime of @pid is guaranteed by @file. And in the regular
> case where there's only a single thread the file code will avoid taking
> a reference. Thus, there's no reference count bump on fdget(), nor a
> drop on fdput(), nor a get_pid() or put_pid().

Right I missed that fdget() wouldn't take a reference count I assumed it
would be equivalent, my mistake.

>
> With your patch series you will always cause reference counts on @pid to
> be taken for everyone. And I wouldn't be surprised if we get performance
> regressions for this.

This was in response to you review saying I can't pass around a pointer to
the fd, originally I didn't do this.

This was the only way I could find to de-jank and make my shared function
not end up problematic in the light of wanting to keep the fd within a
single scope, I didn't realise that passing that by value would be ok.

But obviously hadn't realised that fdget()/fdput() sometimes doesn't change
a reference count, mea culpa on that not an fs person...

>
> In one of my earlier mails I had mused about a fdput() like primitive.
> What I roughly, hastily, and under the influence of the flu, sketched in
> the _completey untested_ patch I appended illustrates roughly what I had
> been thinking about.

OK, I was really uncertain as to what you meant regarding the scope of this
value so had assumed we couldn't do something like assigning the value like
that.

I guess I'll try to adapt that and respin a v7 when I get a chance.

>
> >  include/linux/pid.h        |  8 ++++--
> >  include/uapi/linux/pidfd.h | 10 ++++++++
> >  kernel/exit.c              |  4 ++-
> >  kernel/nsproxy.c           |  1 +
> >  kernel/pid.c               | 51 ++++++++++++++++++++++++--------------
> >  5 files changed, 53 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/pid.h b/include/linux/pid.h
> > index d466890e1b35..3b2ac7567a88 100644
> > --- a/include/linux/pid.h
> > +++ b/include/linux/pid.h
> > @@ -78,11 +78,15 @@ struct file;
> >   * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
> >   *
> >   * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
> > - *              @alloc_proc is also set.
> > + *              @alloc_proc is also set, or PIDFD_SELF_* to refer to the current
> > + *              thread or thread group leader.
> >   * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
> >   *              of a pidfd, and this will be used to determine the pid.
> > +
> >   * @flags:      Output variable, if non-NULL, then the file->f_flags of the
> > - *              pidfd will be set here.
> > + *              pidfd will be set here or If PIDFD_SELF_THREAD is set, this is
> > + *              set to PIDFD_THREAD, otherwise if PIDFD_SELF_THREAD_GROUP then
> > + *              this is set to zero.
> >   *
> >   * Returns: If successful, the pid associated with the pidfd, otherwise an
> >   *          error.
> > diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> > index 565fc0629fff..6fe1d63b2086 100644
> > --- a/include/uapi/linux/pidfd.h
> > +++ b/include/uapi/linux/pidfd.h
> > @@ -29,4 +29,14 @@
> >  #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
> >  #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
> >
> > +/*
> > + * Special sentinel values which can be used to refer to the current thread or
> > + * thread group leader (which from a userland perspective is the process).
> > + */
> > +#define PIDFD_SELF		PIDFD_SELF_THREAD
> > +#define PIDFD_SELF_PROCESS	PIDFD_SELF_THREAD_GROUP
> > +
> > +#define PIDFD_SELF_THREAD	-10000 /* Current thread. */
> > +#define PIDFD_SELF_THREAD_GROUP	-20000 /* Current thread group leader. */
> > +
> >  #endif /* _UAPI_LINUX_PIDFD_H */
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index 619f0014c33b..e4f85ec4ba78 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -71,6 +71,7 @@
> >  #include <linux/user_events.h>
> >  #include <linux/uaccess.h>
> >
> > +#include <uapi/linux/pidfd.h>
> >  #include <uapi/linux/wait.h>
> >
> >  #include <asm/unistd.h>
> > @@ -1739,7 +1740,8 @@ int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
> >  		break;
> >  	case P_PIDFD:
> >  		type = PIDTYPE_PID;
> > -		if (upid < 0)
> > +		if (upid < 0 && upid != PIDFD_SELF_THREAD &&
> > +		    upid != PIDFD_SELF_THREAD_GROUP)
> >  			return -EINVAL;
> >
> >  		pid = pidfd_get_pid(upid, &f_flags);
> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > index dc952c3b05af..d239f7eeaa1f 100644
> > --- a/kernel/nsproxy.c
> > +++ b/kernel/nsproxy.c
> > @@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
> >  	struct nsset nsset = {};
> >  	int err = 0;
> >
> > +	/* If fd is PIDFD_SELF_*, implicitly fail here, as invalid. */
> >  	if (!fd_file(f))
> >  		return -EBADF;
> >
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 94c97559e5c5..0a1861b4422c 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -535,33 +535,48 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
> >  }
> >  EXPORT_SYMBOL_GPL(find_ge_pid);
> >
> > +static struct pid *pidfd_get_pid_self(unsigned int pidfd, unsigned int *flags)
>
> The @flags argument is unused afaict.

Oops will rework on v7.

>
> > +{
> > +	bool is_thread = pidfd == PIDFD_SELF_THREAD;
> > +	enum pid_type type = is_thread ? PIDTYPE_PID : PIDTYPE_TGID;
> > +	struct pid *pid = *task_pid_ptr(current, type);
> > +
> > +	/* The caller expects an elevated reference count. */
> > +	get_pid(pid);
> > +	return pid;
> > +}
>
> Fwiw, what you've done here is essentially reimplement the already
> existing get_task_pid() helper that you could simply use.

We're looking up PIDFD_SELF_* values here. So presumably you mean the:

	struct pid *pid = *task_pid_ptr(current, type);
	/* The caller expects an elevated reference count. */
	get_pid(pid);

Bit is duplicated vs. get_task_pid()?

I did that because it wasn't clear doing that under the RCU lock was
necessary or useful?

It seems useful still to have the PIDFD_SELF stuff qseparate, I can replace
those two lines with a call to get_task_pid() if you prefer? Unless you
meant something else?

>
> > +
> >  struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
> >  			    unsigned int *flags)
> >  {
> > -	struct pid *pid;
> > -	struct fd f = fdget(pidfd);
> > -	struct file *file = fd_file(f);
> > +	if (pidfd == PIDFD_SELF_THREAD || pidfd == PIDFD_SELF_THREAD_GROUP) {
> > +		return pidfd_get_pid_self(pidfd, flags);
> > +	} else {
>
> I think the else can just go and we can save an indentation level.

This has been raised a couple times before by other reviewers, this is just
so we can declare variables, especially the fd variable, which you were
very clear _must_ retain scope only where it used.

Otherwise I have to do something like;

	struct fd f = {};

	if (...) { return ...; }

	f = fdget(...);

This way we don't need to do that.

I mean probably the compiler would do the right thing but it just seems
ugly to assign/reassign a stack value like that.

Ah, I see struct fd is just a wrapper around an unsigned long, so probably
not a big deal to just leave it unassigned then.

This was the only reason I did this, I usually much prefer the guard
pattern.

OK if you're fine with this value being assigned like that then no problem
will change!

>
> > +		struct pid *pid;
> > +		struct fd f = fdget(pidfd);
> > +		struct file *file = fd_file(f);
> >
> > -	if (!file)
> > -		return ERR_PTR(-EBADF);
> > +		if (!file)
> > +			return ERR_PTR(-EBADF);
> >
> > -	pid = pidfd_pid(file);
> > -	/* If we allow opening a pidfd via /proc/<pid>, do so. */
> > -	if (IS_ERR(pid) && allow_proc)
> > -		pid = tgid_pidfd_to_pid(file);
> > +		pid = pidfd_pid(file);
> > +		/* If we allow opening a pidfd via /proc/<pid>, do so. */
> > +		if (IS_ERR(pid) && allow_proc)
> > +			pid = tgid_pidfd_to_pid(file);
> >
> > -	if (IS_ERR(pid)) {
> > +		if (IS_ERR(pid)) {
> > +			fdput(f);
> > +			return pid;
> > +		}
> > +
> > +		/* Pin pid before we release fd. */
> > +		get_pid(pid);
> > +		if (flags)
> > +			*flags = file->f_flags;
> >  		fdput(f);
> > +
> >  		return pid;
> >  	}
> > -
> > -	/* Pin pid before we release fd. */
> > -	get_pid(pid);
> > -	if (flags)
> > -		*flags = file->f_flags;
> > -	fdput(f);
> > -
> > -	return pid;
> >  }
> >
> >  /**
> > --
> > 2.47.0

