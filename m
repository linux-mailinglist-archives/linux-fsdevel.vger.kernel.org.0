Return-Path: <linux-fsdevel+bounces-31947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A399E20F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4132840C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8805C1E501B;
	Tue, 15 Oct 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QuAIG1g5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BpuJn0/H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328181E231D;
	Tue, 15 Oct 2024 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982941; cv=fail; b=urGYuKjnOoK6UQXAd6Evd5qE6yShekZeB1MC7Ty1BQi2TmGL41Yqz2+sBM3tAIj8JEvUFx6rajERrEsNgI/zTmUbY6akTnIO6HzP9ROJtMuzHCqMCYf7BDbzpux8KWlPUjyOK7nJ5Gz0K6daGUoLlMkU/asYftSvUYsEz7Y3suA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982941; c=relaxed/simple;
	bh=EOxTGgWGNvSBh5KVqmsKi5I5eCDIe2YPdvjUuB0v+j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPv6uV0Z6Pj0kEcu+gjNxSk3LK1fpkm8NHtOHD49F/JNDAP4gcIrSB22IbV1JMMmhS+EDozz6P5k2jQr2giHteJigiUa6MBtyN7C5hsNKWJt45RtAHiEbyeM23G3MQ6EWPnd2rahWThb3dQYkztBVPjZhhY6LReANegefJJ56KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QuAIG1g5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BpuJn0/H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6G9VF003405;
	Tue, 15 Oct 2024 09:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PwGjmoZ5QwxhepSH5fFJmt5e9UiJ6neS0UoagzexhoA=; b=
	QuAIG1g5kyZ4aKl27FmihQWFByUiwd8gj1Yo76bDbads2bzrDvXI/daOuFExotG+
	u+69SbuuVQC8Wlq9XhZcsYEGMRRWxQ0UWiwy6eomFTrqEzyb93P42crLrM/hHMTW
	J+EgPrITadTbq97iPsQwac1ExtpjnBIJs29SBWQbHKmH/EIDf1yH6scJ44Fcgw3x
	riDbh39NZ5cknjY5AU7NaBncd6+OL5b2YSUNg9GQElHWK0OvTS81l6EZ4XzwqutI
	l3NDb/QTZ6f7R12RLyGP9S3XOa3XOAQacoOaN1yNUrDGudgCKBhrXz7qnZncnz50
	4XDz3ISchOflgu7YL1JAGA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcftw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7XTSx019936;
	Tue, 15 Oct 2024 09:01:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj75k05-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNC0ScCn1swtXgOUhEpKoaA+2eZ9uxuv66+0IWHuxuxFCnynbeJ9yFmhwrW8DKBQzB0olXNItCQJqCXD299CdcHqWAXef1/p3e89TofL021Uyi4FNl/IyEwWogJAmSDo/nBQ5QKIu9u2pR9ulL6JxD/zLcq1tGLfGBESITl9JyOHhfjptw/BnHIAla5XlyVVM7O/PoLLRVwbxV+nIIs4kV2ipF/0MF6UXb7AwceKay8+79HlP4cKxsCgzsTQBcRYOcu6VQBGsbqHMLQaheOxsuxqqCWxdprjn1rhRskFAx/x/rcihmA9JqELFXsRPqYaD/apOFOPpfzMSrEISXl7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwGjmoZ5QwxhepSH5fFJmt5e9UiJ6neS0UoagzexhoA=;
 b=hNMF01UseAWsH9va6Jezz6GK06k75VN5+7ZzEHlSLwjqlIba75oG77shd3GEipwXbQl6MlRskt7mbh+7ppWBqre9CM81vKmtN7lWLyEaNcszTZbhAQsKVf1xC2E6Is4FibKYPljsM+W0ed72seq8ae/HEZrlF4uuEBhv3OWY30ePD3LPwdq03A9tag0O0iWca64AylNYBYx7ZzLlulsGlVYxHdj8qhBl+9d8Iy3qitYsCncPFFgYIZUBb1fDvhfLJWpDmfk2iJjDYQdkgbIlsVTc9a0cT33BH8zxHXAwGz0o4tO8xvHs1HctWH3dOxPcNqv0IoqOFVw26oD+8sAKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwGjmoZ5QwxhepSH5fFJmt5e9UiJ6neS0UoagzexhoA=;
 b=BpuJn0/Hri9i2ltGiiRLWH8Np0GTmGS1pQdUVYryq9+GikAzNV95UCcDr4hN8V4TkIAY2mw3/Cd5wZ9hT0MH9CJHsdQoit8j+Hz4eRxjNKmrKXX6bGRAKy8/kcgy3YDxy5t4c5S8R4yi0X74f2AKrqotuHcstcA+cVO+3IzvsfE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:01:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:01:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 3/7] fs: Export generic_atomic_write_valid()
Date: Tue, 15 Oct 2024 09:01:38 +0000
Message-Id: <20241015090142.3189518-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241015090142.3189518-1-john.g.garry@oracle.com>
References: <20241015090142.3189518-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:208:530::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a1a772-1d8d-4709-a388-08dcecf80542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QwjxujmzXJi8Y00McSBCXfq41TyFlBpQjcgZbTe7iyHl5LcHkpI6pydyt3YX?=
 =?us-ascii?Q?nX0QPyzbHfbVem9Ap+UOrL8ZuuBiHRusICJ0t9lWHbu9QTPPpyEOY0I2D6wh?=
 =?us-ascii?Q?oxMZAqn7DVRBIMpwsxkVraG91kJM+FeF1yB7r80tpJmXJxEh3My1mrz2ZTIj?=
 =?us-ascii?Q?z9J2V+E9w3JwFo1tvZ9L2Vi03+GXDJ5VzAH+s17pkvKwG5Ax9mUeDYOb9wAf?=
 =?us-ascii?Q?IjkmYm8vh2zbWQiOMM4T9a51K8kI0HMPG6HxPu6RvJOFYHVK8/jEE8A8ZkyU?=
 =?us-ascii?Q?XA85Ayupeh2rJCoalFOahP1KonCjVdae7IJAgt+IYvYBf78QnOF75NFpjV2w?=
 =?us-ascii?Q?10qlXZVd5+oaXZvJxQUSvfnav4/T4xU2Rm3y7PXQwdnqJDu5Wc7UJ+s81soY?=
 =?us-ascii?Q?BkHl1lm8xXHopsZ+yV7C8KJLqVOZxPR+yVimvMAeqWvhZ2LpF6Ypohjrs2cu?=
 =?us-ascii?Q?1QSEhHL31TtNrKpqBQ0rmMyg+KOm/rNIQq6SwKDZtwW+vx1PXZjjrgXrzEnZ?=
 =?us-ascii?Q?iKsmRZqr22mrgHxJhZmPybUcSMWAWpZc84IeU+Ma+1YVMiotxWIMr4xw3vB4?=
 =?us-ascii?Q?UWSqT3J5c12C7XOCE+vbHng8LhKkwfn80mGK/we+oXJcZjGeS5qMtk6QXHuU?=
 =?us-ascii?Q?g/JmeH1SUTbIRXdQH4LtciwLXhre32pBQFQygaFbBJjV/eXTsBH8qd4MnLL6?=
 =?us-ascii?Q?KZ1AFpz+iV2gU4EhLzSWHQCzoNaxilbAWt0vr8ECcVW1frtuQE2Knu6LSpzZ?=
 =?us-ascii?Q?yLIlE3kZ1ZnsFzJTV/pQd0du2aKMSE6kZJCvSyW59fbDmJGeGZFKpSHtKA7e?=
 =?us-ascii?Q?nyf+4rT9iBz5HWnqI4Pfltm0cK7rG9UFEFmv5RhQA5x62RU4cnCP31DCADao?=
 =?us-ascii?Q?secVdOKMBCre92KyagDX/Ye7/9LtyB/Q4oofQy71EwKNw9eXJngp7HXfD4Uj?=
 =?us-ascii?Q?AmGqOw7e0InXI8WX9ZJNzKh77hbtHqo7LiYISXpKUI5lpzqXzdTRdP4hTOAc?=
 =?us-ascii?Q?cJ7ULF+p26S3T7MtGc553T7yNBh4CTxcVO/Jx+E2fnwMLptgnZFv675Vmf9v?=
 =?us-ascii?Q?is123l95pn6JmIPkCK3p7T1mZx4pSyo18PMIYj8FtpWYRkqq5n/oKyTL0mr/?=
 =?us-ascii?Q?jW4G/1g3B8wWcZokejTJOxhMhzD2LBrfYKBEFNXLXy6elxRLeuLEqgJnvqqk?=
 =?us-ascii?Q?FH7e8CFpWiLXkpJD5TsH5r0u3d8tU4bXy8hb+4u3Y4MGVKgIJT0e6U+ZJxUI?=
 =?us-ascii?Q?zg6xAy0QlPRgcpE6NclIUu9Ehg9AZEzOOaoxKkIVXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UkU08/qTg6e09ZNRQf2rqa9+8zmAK/cTYO1+BAy5s2o12Z5KNsYMB4YeyTs4?=
 =?us-ascii?Q?Iei1QaFijUkcOc7QC16LmgKHEFSL3nlWACgyAejLba9y0yP8DDo6Km/60jBG?=
 =?us-ascii?Q?ZflFYHNbkfOPs4I7+o5pA95O9R6lg0qHvnGK/fyiM26MQed3297dJhMjesvP?=
 =?us-ascii?Q?bVlq+MHlxVidOfbp6XCNw4NLydLy0ipl90Ni2c85RFOEQxxg8dqADpBpPDrf?=
 =?us-ascii?Q?oKJTP+9qBYRWq/lta9ydby602pzsn3RFTqaPjxxtkBTLpis+UH5eKfjggDPu?=
 =?us-ascii?Q?8pebPzjH5hTZBh01whA54x1Q2+c/3K+jiD5LXYJIMOHBrS9Zph/+4rciP9Gy?=
 =?us-ascii?Q?h+eYVRF8CTnJcW1xIl3rdLJksRTMzSC3ptYX4DXAf58DoqQE8XUue0Y08SrB?=
 =?us-ascii?Q?KZ4iKIaIXsk7wN//wGVJActmiax2ikKgu3gWxooyPnbrEw/K1whexQG/48mT?=
 =?us-ascii?Q?sGN5MKqOU6zjH6lOp28Lxvt8UGcsO+GpkYza2V8//VLqjL7OQUDbUd2jX+Ic?=
 =?us-ascii?Q?SzZ31Vd8fHlwiiZyuxplGdfMdAt36GAz9NkEuCWpv1rVr06OF2IZkQusdnEo?=
 =?us-ascii?Q?UpDQL8uRubFQ/NEf3h1/MOItMpjxX7cJNOU+YoNwD2WAk+3MdQ4CfwCoaGBA?=
 =?us-ascii?Q?mp4qP5wpEDsTQr7r5iCZWzcN0PRzNngD24NtlcEvnXGn52bYYNYf+/m8dBb1?=
 =?us-ascii?Q?qDmCueMTqPudOoYn2wsFGjDpPEYq5Fcho83qPg0IFl4Hkf5NW5Tr/7N1Vxdt?=
 =?us-ascii?Q?eHxWHADwoMlkFUtgiWAADnwg1ajmBjXJz2RXeT13LuLYDWpbVJChhux5qgop?=
 =?us-ascii?Q?VEgAg5W6vLHIsRrr7rwepz3s3Js65Tc/KvIVSTAow18SlU2gDv3XB4rxY4qM?=
 =?us-ascii?Q?9VGpjVJCJKwwzM6GRJ56ErvoawPPmoUqc8t3hmI4MHa+moiPhfCXidBWvxUi?=
 =?us-ascii?Q?vVbCt+5WzSWvYGbc42t+wBBlid0+JtymdL3MaA+cD4Kio58RF18M4APK83Gm?=
 =?us-ascii?Q?cpJgsFW8e0KAu3N3g4NImbIm8X2GSDqm+Lb0KjeTyyMF5iESNqq4Px5dR0sJ?=
 =?us-ascii?Q?ByPSGzAgqYPZAuNaPyq6zz8DJoo0raUhbFKkea5bubP1qKkr1UnBttHT7cEU?=
 =?us-ascii?Q?4pf3PLqxkxunWTnBNbl2FSGnBKDDTzMwaNAEvjjzGgOt+iOSfe/GTtiycoKL?=
 =?us-ascii?Q?lKUtmpKUNSAOB5JL059+tmO2nRgDDgxBeq4TioqXTSbhv6i5N832akALqn0m?=
 =?us-ascii?Q?+RNxcD0YcWIfn7bQZOdjSOUSXOkmN46gDEV/VZHqgOcW1DDdeofHKckucqO9?=
 =?us-ascii?Q?Hlhfg8n07vSFy6xh7dr8g2c8liREWRo3j2Pu7Bbc03k/ku/9OamMW8uM+m/c?=
 =?us-ascii?Q?VoKq0p5EloIyr010KKCFCXIi621Y4v1hiVN3gFVHadZOcSqrXzkAYrjCUS/O?=
 =?us-ascii?Q?TNKSJbblRKfCx22x2/x05F5b0D1IBM6fNXYPLzvqTx1mx2UP6k+WnJMaIhG8?=
 =?us-ascii?Q?qdx+1IExkvcb52BLneyyiphSD9Fiekgwvl9lmsIJI/llYeUR7F+/wb3eaDdo?=
 =?us-ascii?Q?NMHYKxR5Rf0Y1rpACXarOJ4wyGmeZfGlSzZRFWgLK6szcHVXMEUcxH572Oe9?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	abJGR2Fuvs2Xi+O7XTVXjQH2RBrCMK1AtM2/xbVM+DkJ19iIXqYFVt6ybzNh9aOXeNoRti+JHzEOSIVqpusY9g7lt2zFCFMxzCktv9jO0iQG/yxtM0UK4EdquLHc2F3wme2GH3WjIXsV0vo8Se2BEuoO+D/+4qPu3H4RsPEJGoR6yPBWyCjfvk+Pp0QzM3jgbWP9/Jr1EVqhzt9EgjOyo3NNgpBtLM1qc6Fm5cRjd4KlZFk76Z0rouhBEWaj/9emjii8mkR6rb6T5VbMoBbb2kWwwD10vROovYZBvXshnLsRb4sh0+sc0Yii4q2VvOcuXZgxZ57/BouYuqP+0I/G7qJLFSs2TPdOMjq7YMnIefoQ+s6z8dK/xvARrvgslUnzA3fDHhszt17HpwS0p0VirR1ybRaMDAVAjGPcgj7yZGggrMUCyIZ9Z+T6suWa9kngP0J2/822VS8r0ERPFyfpdqCcT8lqoF0ILHsL7I2+H+x75Akd6i/q8pGFijpQjG37eAfcwBMaJYBwb355s9lZTM9dfUeTk3d1RwIdLm5PfdSNXenPPbuKouMe+GkW+Icy0WdD/jm+Mm0OwI4LgCWVn2XJM2xXLry+PXhn4IkH2gg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a1a772-1d8d-4709-a388-08dcecf80542
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:01:56.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhXIuUFc9V82XlhNnC5QcnxESmHbtYMgX59lVXGrBAkZFus3EEdmRo0q/z1iWdtFfn+hGxpuIPSrzMvAnNXAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150060
X-Proofpoint-GUID: ZgvovGMMlXsw9OGu_iWOUB1yRSJYAb35
X-Proofpoint-ORIG-GUID: ZgvovGMMlXsw9OGu_iWOUB1yRSJYAb35

The XFS code will need this.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/read_write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index befec0b5c537..3e5dad12a5b4 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1848,3 +1848,4 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(generic_atomic_write_valid);
-- 
2.31.1


