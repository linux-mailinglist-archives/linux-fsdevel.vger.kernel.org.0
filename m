Return-Path: <linux-fsdevel+bounces-48166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A79AABA1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F361D4E754E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF7E259CA4;
	Tue,  6 May 2025 04:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hDpD8eFV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vhAsidph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DD2D4DE5;
	Tue,  6 May 2025 04:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746505644; cv=fail; b=t/9PDcj3QpyAR630TT88bKD9CvUh2psd0PvN+KYUORytSs84Tb7w8QzqIZmXcmjv/vPP7Wg5VT3T1AAPhtc8/AQmkYKY/5SeHvJ9YWTvoMzXm0NlRNHYxqkHAl1iD4/HOouFKBoZbXhkOtRWRaC36qfu/pjpMJI61rhs62dMJDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746505644; c=relaxed/simple;
	bh=t3Jg3TIoXrLGNbkydOI8DcdKQko+NAlX2oXdcv/B1ko=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=bMUsb7VU8zCdSVHoVJvu0Gx2FcY674w6GsiHrBoeNCM3DFKE7pJZ0wXnI9HRvbOQLmGn7+PQ5S0PV3NlbYLXwuwa72SX4LSHke55mpgp3XXGZIWnvxVlpVx+KHIU4wZfLIKM0Ngs//O9izOLxBz/DrXbpo/ZMN1EfbGPbMZM0cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hDpD8eFV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vhAsidph; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5463bQFx030305;
	Tue, 6 May 2025 04:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aqSPq5NM6SiZ11fjTj
	OU4JCO3wIMfuE9CAifRrzrhHc=; b=hDpD8eFVajrcjtIqTXNB1g6E1CSetyuOse
	zIZ8rChl0Boh8RtS8nSMN4Dvmwn8zkQn7B3Rsl4u6E42M5aDQUzw3S1HcwzuqO0W
	GiocQeUpQoJasX6VXybNDCGasXA09Njkr72Fqq+ArD8BLKWScnei0usKafdEp6ht
	G0OjgRyvwjJfDWUgc4qNYx3UxqH91+xPwLy8KfcK3qLJxCNGR34iMqNo79yoGHda
	2GIYRS6bezRGckcrfiMwE+4LUovGyMq12EkNHMG0Bi2KTyF3ij9r4nPGJPI5x80z
	twg8UWOXuJ6reMwzuYh6HTthefmbSjmpDsFYm+8VGPGIYoZy9C6w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fap1g179-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 04:21:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5462Stcd012160;
	Tue, 6 May 2025 04:21:44 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011031.outbound.protection.outlook.com [40.93.6.31])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9ker9dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 04:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfCiMew47DjiN5k7+tjaSpO2pZkC2E6WMCC8qHxJvBnyUZDinhcbAB5F7P6Qv9wyKSnSXkXYEdWtnCH/RsRMb0Adtu4XOkAKVJ9/wJKb9c1ipWWPDdxRYR6/aVoVF4r2+czxCAH2g1s/fk1SQXv58Cqzs4Udm8IOxkP33J8zlio3Z9tsWJfu85yitj2n+vnfJik7PQ1YfikQCbnIYE8J+WabQgcG7iIRI+5viyoJk9GIbKiEll8h8p5v/LGmSC5zG+mQuosrN9jS6SM5ggX3De7F+jYA11q21YGvgdM0I6GJh3h61xUv7T+PpHwPKgj69JAeY9gQvwDfyHvLa1QRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqSPq5NM6SiZ11fjTjOU4JCO3wIMfuE9CAifRrzrhHc=;
 b=V3LYNHmJWGgE7vpTVU9RHO0e5lB8G2nUaVGuDJDy8/1p3IerTemn7kmiBIkoVs4LcUofhEoAnVKRcoJcCBPCKmtxQz4S8YEdPsVhzdI23wF+2gK6/IcL1plYJkjgOqFBqyUoq27G6C/khPCaXOMyYlY7AUO5btGV8EkifH5JrZulfB/+53EommLN2uvCfkRYSM5FS9iHM6BqVIeVtyV22Vy/7mUAzcd7+6zXBnyWpGsxahc67mMlhWhJ7duiRV4rNIJixiJMQD0pgcrGHfylIRljZe8xdbuHTI/slOOZDWGYM7zx0S/uWtPxAzmWp/XDZB7d2o9Gf3An/khP/4uHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqSPq5NM6SiZ11fjTjOU4JCO3wIMfuE9CAifRrzrhHc=;
 b=vhAsidphiQyIOdk2TB3iUbh2Ou5um4s6n7gouzh2veIO5ATLHS3oT2DQx7pFEh5XstWmPeLgYKMBuqwJw/36iVrJniM/ZBotMe/s/s4bQjCzXrwKIHNSKvVMcltmPbPaHcpcAdUo7+AeIQoI1wPKoBXsl33S1BkD3n+fk+P1cZU=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS4PPF376CF97B3.namprd10.prod.outlook.com (2603:10b6:f:fc00::d13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 04:21:37 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 04:21:37 +0000
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
        tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
        bmarzins@redhat.com, chaitanyak@nvidia.com,
        shinichiro.kawasaki@wdc.com, brauner@kernel.org, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 01/11] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250421021509.2366003-2-yi.zhang@huaweicloud.com> (Zhang Yi's
	message of "Mon, 21 Apr 2025 10:14:59 +0800")
Organization: Oracle Corporation
Message-ID: <yq18qnav4zj.fsf@ca-mkp.ca.oracle.com>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
	<20250421021509.2366003-2-yi.zhang@huaweicloud.com>
Date: Tue, 06 May 2025 00:21:36 -0400
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:335::21) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS4PPF376CF97B3:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa0c0b1-cc1e-4a89-1113-08dd8c557e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fAEZAm+ju4Zh3hyr+SJLYtHwkXZeqNGWQOPXCZ1KinBduDPf3QMGOvu+M7gu?=
 =?us-ascii?Q?rgP+uherZbLfyyXBruil2ItRXnKC+DSy9tpg5fPWbk5rb86PCtTAcmdZ+twZ?=
 =?us-ascii?Q?+qFGK6zf8qkBQQXvnYbTjlWA1MmK8aV8PHFu8JLjG2mPrKGVeNvVbHOEZ8tE?=
 =?us-ascii?Q?p37tL7EFnmBvWLHQSnL84guK44UcySZVLNL+BMppAaibCwANulqfdFJhM92h?=
 =?us-ascii?Q?KPWx0ukuKrh4DBtazGfeDW0y0KopfBHGfuu2BSFPBN33ktY6pEKX2u6emaLq?=
 =?us-ascii?Q?OvFSKDx6QgL3JRdua9r51l7sThBcWznU/cGrcOUWJBHv2SaVYRvjHk2AIGkD?=
 =?us-ascii?Q?TNQVRGLeMW4EehVXNuCQVhvrvbQm4ueB3dXygIVGFJTI9ZErwO6cm7UE6gyp?=
 =?us-ascii?Q?NsgPHiIAu8KPsAjfpwQgqckf+Al/fNvRf8j07pCx/ZrPxfNm98QnpGgSroI3?=
 =?us-ascii?Q?hmeNqz1i+q2I1g6u4GT55ELqFR+gwOdTJZloCVMDHThbCNM2s8MWQWReeEL4?=
 =?us-ascii?Q?rGxzO3g3SVbPQZLqPPfWvA00cJ22tC9uxzvnvnnf160FKl8iPonb6wOmGGl7?=
 =?us-ascii?Q?thr611RNJ2csmuLPCHwWLOZ1wJS2MoaI7RohPVZK1FHcsIaTQhtNyeDnDVzR?=
 =?us-ascii?Q?uQYZc60jgXoOm1RI0rwsbW/4VfZJ7rCToFCwK6aITO3j88rl4anUxCHXjS9F?=
 =?us-ascii?Q?PcD5UTS1zLn+ayaQJs0Hql0W8tjj5EkEy0EoiTzamdEwbheEA5ChByKtF9qb?=
 =?us-ascii?Q?EWrSywCWEl1Xh8zZhCpUO2VyqbVqQLp9Qc5LIY1wZiRIZ8JfNWYyUvP2Zx+b?=
 =?us-ascii?Q?IqjYC2PkhBNUwGbBUqVNJP3tJw7C2LhOjdnkCpQ3EacVgafbGCmMChQqPtT4?=
 =?us-ascii?Q?8TeL+PLWMZ5yxIJsIHXB18loMvEXvAPQaImftRePu5uvEfL+ig+8O9MGy+hY?=
 =?us-ascii?Q?PXsJGD2G2mtI7djke/igLXn4RAOHPriZIaOW+S+BKqqbxJQKWOnOoNrqOO52?=
 =?us-ascii?Q?HYebgc/QsTu9cmXIzBBzKV3ynUnToubFj+6Whr0mm/tbvxbln6oYQ9OBL0wx?=
 =?us-ascii?Q?B29FZvVV1MgWQEjD1stFy5SQOhbfEyIHA7Rvn2VKATdZR7A/V2FTO9FZeGfS?=
 =?us-ascii?Q?G0kffs916d4X4Xvoc4vz6qohYU8ZU1x9Uz07UNXoXeYfDaCwPpQXeGTbWugz?=
 =?us-ascii?Q?VjhKM999HX8wk3IQPFxDgsqV4piD+C58uihiOhFdlG9k2iXEVCBmScD5HMg1?=
 =?us-ascii?Q?3aLukEM8VwlF1zX2hevpZVYfVRWK9eqHKvsib6nD75UBj7ief1IR/6eCsn7p?=
 =?us-ascii?Q?iTJ5AzqGCEWdHKkvYjD2EuABx2jy2AS7jS5vOn2F9ptVM1EjB+Y9gPVidHqc?=
 =?us-ascii?Q?XzOo/Dhj6P1WOs6l+0M6WOAPkAprcQF3u1MNQ4k8AiBG0q3naIU319tPb0ck?=
 =?us-ascii?Q?WeLQk+tVR+I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XCtpa1vsq40yEeH+Xx5HV4Gcvk+hG/ijgq+lX9b2FGe6aBFgbPDJVFHZM5Cm?=
 =?us-ascii?Q?hBav8YRi8j1bdQ+xN9qn5luRA3xRGmKGkjUrfi9x7fiE5g73SHYntf2uQi+y?=
 =?us-ascii?Q?mrK0KEOEkMGfF1WTyi7owqk+BRS1DMtShMt8dRkijA8T9etfnVk7X8hpD2Jh?=
 =?us-ascii?Q?7qZgO86gfpM0nIDyFyY/EM3c8WSMEFHcTodjqSw4O0ANu//P2qfmkQNy1AgW?=
 =?us-ascii?Q?/qpEfvtqf4SIosK4B+TphIfcA3pXP/w/pg2qCbTz3strWEI9WWVCD5D2IdqU?=
 =?us-ascii?Q?5PWl/d2Ya8gstxUtRhUEBlRWnpltQFlcM+GQb2wRRQLeTqkQzWd3BJlBrH1F?=
 =?us-ascii?Q?tA6VrTYuzQxZl1fR5nBVKiUa45eRx/YIUwtEKQjlU5cFx/ro4qsByauPZiZJ?=
 =?us-ascii?Q?j2J2vbeGTbIqVeq8KQAYyWNKv3gYHnHfGqD5KQ1gz78ved08PY5HByTK9m1C?=
 =?us-ascii?Q?SSFqCAOFdgx9X7GQWgCTbJ/e2kbPDzMfy04TzqNq1IKYqgKOu0JTsiumx+Jr?=
 =?us-ascii?Q?Gz0+rH+ZWiTXsZeYirAxtmyQ0a/hgEVfw7ff6LzaCtehcf0mIW8ypjjv26G2?=
 =?us-ascii?Q?OzKoXTJW1E2fhe+LbLPCe1qSL0ZDvOKunrjtiCtofMobIkH89zCK9afjjxRS?=
 =?us-ascii?Q?H9JUkHD65Jm/kcv2961sGj/jJzLEqYf0fzqDXf0qR2syV3rIVGpcEmseV6Ql?=
 =?us-ascii?Q?aAS+MfIbIlymSaSZ+N4tjvVtr591oO19H86RVgbGXv1r3IIhggPXydDheUJp?=
 =?us-ascii?Q?Dis7qsf3o0QQEg15sAIRvVwyfNVEeP5JNsMJ53XpUNxK38yTLg+xusQVVLA3?=
 =?us-ascii?Q?Kqfw7GihraHRtqRcjf2UUZ6yCaxQLBt3cvnBT/EdrD/Sunpfpw6ueG/Zinsi?=
 =?us-ascii?Q?99NhJGlc5DuRdzWEEBdbxXkA51P9XDC61ZomVbhezU5/BXd51GDP69R+yG90?=
 =?us-ascii?Q?T7btLjvRdnEqEkU2nUC7Cn2j3Pqyuoepp0lzN4oRlOe7KKt4D2rbkbiKhoeq?=
 =?us-ascii?Q?WZxfyOuAoeqkDV8EBUoOdY+cisAWP1ceoMwDH/r34nwSKZCz1pEgvmvsPBvk?=
 =?us-ascii?Q?aMvBgCo/ZSktxYJzTm0QhjngIXeXvTpb5KPUa3zhwCTZgMxpzr3VxSjUMweP?=
 =?us-ascii?Q?qGknfESpUTtuEXFVFWL++ksabiCZnhRoWfAvCzrKCwxBY7aAws6pMUIdlun8?=
 =?us-ascii?Q?ForJPucl8DQYWU/YhR9Yz08FP4R2ZN1vLuI/CQs7oMftocgFLSoo/GfgZCe5?=
 =?us-ascii?Q?RokahwMM26BJgLngCylHqDdPyUsZRfwlf2yHWNHMdurBBwHtpZqCOZHLlh+s?=
 =?us-ascii?Q?sjIUUc0xmQHAcq4ASNh8S9AfRUIY/piyeAGPBztXPrKOx6dyF6bY7gHeyRB2?=
 =?us-ascii?Q?BYhwQbFqXdmGOnogofDVDLxYaAvmMCToOHRGNklsAUAPCr7IM/XwPVYMEs+W?=
 =?us-ascii?Q?KYlcf3ZDaKgkjNOGwQS1Ez4kEQFa4yZ43j8sOPf5OM42p8dVh/a/AQTfPWx1?=
 =?us-ascii?Q?CAfmV14pYbJ0xcWxnKra42pRyQ+jcNepmaq3bfrnoWd6oVdikQD2LF14lEjK?=
 =?us-ascii?Q?eAMNtj8MqWhsOdTKRrwLUZRgC57WD8EnB6IGWkXRuvDsKVAomJpQ3W2XFkta?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/H5Gr/ntaFfNNkmYu4+L67oAoB0LzxDRBszu4fa35ArhwEckirdcJv/MuYCIh9lST7/bXhwboeKEo2UdWq1+hZHyBMlNjYehZ3lTB6mQzdFvSmgvybY/T8UwFvqqTtNIasSaKEZapkniWSPDt5rcCakDWBqyQFmkrwDcRUx/uPRPZM7f0LE+s7AyppPcm7Leva5P8ncmJ1U7AUKKCxRB607SMSRvOsWFj3/Wj5HSKANoePCLztq4A7wqVXQXfSma21DzTP5JAmOWHEQRVR2vyI0KFlsN5bD9UVgsowBwTKX5cWTUz4aGpYK5oDVxMyH/AYZxSIR33pvEJP1WVA+Z/ZbBy3rBYPTN7S//xZRRhoCYrxOGOJmZo9nYG+qtrQp5xGxD6t8Kn1Gxm6EFLAZTyAa04Mwkl/tlyANHDPPbxPBFs9kSgwg3c8QnrimKucrmquURtJ+pLr/3AwJBmSN4uNkzjz1ss3HYycOGjtVXx0edkv413+ikHuYafFgK3ITiWCKCOZ99kI9INpRp8c0V7Tw9nbQY8Fd8nPdddDmh8Hm409qvbbrlVXqObxIEzgox5lCNAb0SYVOAKKUerP0Zb3XLQiHsEubxhSI/pLiRsJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa0c0b1-cc1e-4a89-1113-08dd8c557e31
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 04:21:37.5492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpXL63vZm215ScnziXsgX2vcRKRhFPivYGvLJbsMt+gSXA4G4odzARM4Ibag3S1WHAh9N4c38men6SQ0N9YMSIwIMN5gdc/2saQWh10ZULU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF376CF97B3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_02,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060038
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDAzOSBTYWx0ZWRfX0Fn5WqtdTqO5 0TOZOZT9fO+MWWZtNyvCkXRKdfo5FEyy12469fxbyxvsx10idBKeKGpRFwdWbLENJm+lYEt8KC+ Tx8vxYxnOOU7epuYwVB1p6iBUJC7S8rQ0xd7IZ3sLGMJA7R46jz81S9TB8loydwRDjKMhjfd6Rs
 gW58W+ycaoBHBfaPBtDqVLPu9hXDrdCgS6o9ApYwvtfQ/jRMg/NUnHXiu9ufhPyY3lCwkL5Cl/h p80Q+erH1j5ME6SIypzs8WZVld/MDbPr5jbHmGvHLvQmPIBd5k60lo3tDL8fy0C9OEoRf076m1I k0bJpUVZ1JVigmEKwkK+W8un6QRAQ7TleMQ8MSCU1gWf0a3ybLNCckl6qxUsg2uQCuisWiry+0Q
 VHlGioe3K1g9fHPVZMe6687191BqZM6yOKqkpMKgqjegnKakXISQcnmZOrVuBxfHzWe0Tq6o
X-Proofpoint-ORIG-GUID: qHodKBiX_HPErlJx4H0ztu0kR9TCFpRL
X-Proofpoint-GUID: qHodKBiX_HPErlJx4H0ztu0kR9TCFpRL
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=68198e59 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=ATg2Pqb6Rx3dOvEPEroA:9 cc=ntf awl=host:14638


Hi Zhang!

> +		[RO] Devices that explicitly support the unmap write zeroes
> +		operation in which a single write zeroes request with the unmap
> +		bit set to zero out the range of contiguous blocks on storage
> +		by freeing blocks, rather than writing physical zeroes to the
> +		media. If the write_zeroes_unmap is set to 1, this indicates
> +		that the device explicitly supports the write zero command.
> +		However, this may be a best-effort optimization rather than a
> +		mandatory requirement, some devices may partially fall back to
> +		writing physical zeroes due to factors such as receiving
> +		unaligned commands. If the parameter is set to 0, the device
> +		either does not support this operation, or its support status is
> +		unknown.

I am not so keen on mixing Write Zeroes (which is NVMe-speak) and Unmap
(which is SCSI). Also, Deallocate and Unmap reflect block provisioning
state on the device but don't really convey what is semantically
important for your proposed change (zeroing speed and/or media wear
reduction).

That said, I'm having a hard time coming up with a better term.
WRITE_ZEROES_OPTIMIZED, maybe? Naming is hard...

For the description, perhaps something like the following which tries to
focus on the block layer semantics without using protocol-specific
terminology?

[RO] This parameter indicates whether a device supports zeroing data in
a specified block range without incurring the cost of physically writing
zeroes to media for each individual block. This operation is a
best-effort optimization, a device may fall back to physically writing
zeroes to media due to other factors such as misalignment or being asked
to clear a block range smaller than the device's internal allocation
unit. If write_zeroes_unmap is set to 1, the device implements a zeroing
operation which opportunistically avoids writing zeroes to media while
still guaranteeing that subsequent reads from the specified block range
will return zeroed data. If write_zeroes_unmap is set to 0, the device
may have to write each logical block media during a zeroing operation.

-- 
Martin K. Petersen

