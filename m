Return-Path: <linux-fsdevel+bounces-42775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E4DA4876F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0535C3B9FCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A116126E62F;
	Thu, 27 Feb 2025 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J38C44ch";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oExC5qY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683026D5A5;
	Thu, 27 Feb 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679734; cv=fail; b=ungG2cnnjgTXrJh7rbGcx3NOJomFQCfkahj5ZMCR1wf3r3JT8eK85DFNqolvTxPcVDgnO1n2pYuGjsldUC6fLkyJ+vlZMmLpW0iFNt+dG8KWe5Gv4coNdPSZi9mMX/TVugWlxljrAZT6sIHqx2fVL1DM5uCnqF+jlypEQuT59Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679734; c=relaxed/simple;
	bh=/cCIxwU/qNQjjrYRzRXvinLY1UKIwe7V4Vc8nY5Dnns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lT9OUP9fWt4+6xVuDLmFB8WSy0YoKsOwL3hmKkyJOFgKk5wLdPo+YHjxQSR4Hhhx8cIBgtcJRv/w/PrWsiwT0+a3mvSV5NjJPOV0wXMbUYA+QpL7KbVbrj5ihnGcyomnFCLctowSFkNJ10GgZjT4z3HAnFsbezz51sqzcX+BifY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J38C44ch; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oExC5qY6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfjbG016101;
	Thu, 27 Feb 2025 18:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=12/OspGuQEyOVIsPram9VvopVsj3dnRA/aTOCu9dpdM=; b=
	J38C44chBZj7nIs4kjzRclwl0hhFkOi6ZVf77JUkxU9nrFUI4w0mAfqX1xHiOUpj
	jFGzkrdi1BHu4A/5aHrihYgBAwWj8Jwhme8aLrxKrULzuwN4kyiV8DGpFeKmcPlg
	38TeKq4cwR0Sqz5qxFEIidC6D49lWhUfkvUABLIrooasKwereGsOvpvQJuz0xZcv
	bSG0sgW0aEVuWaF0tuJ0Kd9Zgtv7X6dz7FUCNZLOvTR1gDQYwUTPEsRABuLf2vNz
	LuASjXSD52OQENXQ4muCTIynSRALTFtOCNyPsOunzmbH87Qrq/At5xCodEJ6FLo4
	9LXTimgNcQPVFtgRHN/WsQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse407k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGrIOf002880;
	Thu, 27 Feb 2025 18:08:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51cq20k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnOAB4zE20r7+weZaAvy3M99lYLEDihnJ74NHjs3k/aBg/vCi1Mxhz8CRKqB/loLz3sj0+JnZXoso4OZJZYV02mKEhFWc+ialWGHSh7C53GSd3yZdn+oQSo2H/zFZ+ka/5lu8Y3wq89GPkN/6LyIIOILFcrNJLIZGqba+zKlhMFwJ4PjTB5bNog75UGcJ2nW2/fxC+QR0r48JnSw08RHkESWUksdMzr7/wAb7RM4e450Nr9UoVokBeIOfsIZtBsQSPRgdZnRYRyvn/+AimalfUBk9IfiVwecoCw7mtLvfKtyLplcatOb6YqlVsju5YmIOtKlF9NlF/1ZIcg8tN9EQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12/OspGuQEyOVIsPram9VvopVsj3dnRA/aTOCu9dpdM=;
 b=FybDUAMOoveIyhkk0BcwaLk/OF/RkwXD9ziFrfIqBGRLMl+pjw5Zs6fH9Cj3iUv9L3lOD+AiWTGn7rvTio/o/dOgs3HLnrjgz08efXSAkxzCE8ICFKJmHmTfebExEfGEZZSyjctLyekYsHSPxiHzvPREvknbD408BMGGICzbUBTJRE7vecXhc7AC824v9DtbBLbiV8+4DAVVq5OG4y9bMG50TDvJHYf+ve3O9Ei5+JHRdGbrGot6X5rROrHPYlpbUz/iLuWO8Ba2i3DYk9gRjZhDKKfRlQ95kQ6EteH57kTWD6RF4HU7dfQy4Eh0unVS3tZSfP8rwxGLHGQmJ+TC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12/OspGuQEyOVIsPram9VvopVsj3dnRA/aTOCu9dpdM=;
 b=oExC5qY6qIVsIKKFky2w407ryzwruoVnS0bJNtNYOY3UQZ1SyK36MpHNAROm9VTIZ1jiBOTam/Kfdca66rApK4MeLqWWaEVN9r5Ghi0naO9LWDstQhQ4y2MR6k+t0vV3CZokxu4E77ycxUtMmXD1rhkLNteI4U2257/6UmAJgMk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 08/12] xfs: Iomap SW-based atomic write support
Date: Thu, 27 Feb 2025 18:08:09 +0000
Message-Id: <20250227180813.1553404-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:a03:331::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 353d4b2e-65d8-4c29-5ea9-08dd5759c4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7X79F15fiICXzDLLg4lTh4w1EG4Tm5puEnj72SdXjqSbwNZqG76Dtrt/dfaT?=
 =?us-ascii?Q?IpDV4hdJ5jnvufpVxQKs9lvDUmFqotV9sil/cwR0jxeSlSyPA+/P4AJaCy7L?=
 =?us-ascii?Q?118H+LzWsL0kqJj4klaZfz2OO3oHbL+vfcpBMEW6s4Vt3TS5QAJCuRvyOmLx?=
 =?us-ascii?Q?AwDt5Tt5OvT615Wub7lqPR4YyFp6AFFFSjIHYSB/Bnct/YVW0ujqp8xocOdp?=
 =?us-ascii?Q?sQabS6v0NEJn9WhwqD98+UJs2jbn1mU6bz+uPNQoiER9TV10Inyy1dw7odGk?=
 =?us-ascii?Q?rxrURQAhMvSYCp9XniNjxjfbgYfSgBasdPm9gOCY0y1TBYj/cWJ8WY7/D9pr?=
 =?us-ascii?Q?2SwL+lVX/mtj0Bn20YcfskqSSChUp9m0osCSFvM3d5lkVzJDJJMOz049++WN?=
 =?us-ascii?Q?7Hyq7Ab+qIhWc5Hp7rMVM8pnx4cCBgsewp66gTtjLFaPnonyUC3HYoOHmQRy?=
 =?us-ascii?Q?tzCJlqx/Jzc/cAzVCwyQ+CTo4uCGqQoWgZ+cFcm3MVpMC6RQ8abhRyjV4O7O?=
 =?us-ascii?Q?fDSyAf5ohKX2itWq6SCszdOhnVRQblAQ79WEQHM77tiP9bSrVCCQTjPjAWeZ?=
 =?us-ascii?Q?EaBPMXxD9DZjN6lb+DUuqDcZyIivxYJ9VNOVfyaM7zNeFyanQyWXtt5tdcmA?=
 =?us-ascii?Q?qOyw0iV9TQeI97+uPg8SHL+y/iMPH5h10Q1Z107oi53VjBej5uHp1qLza6mm?=
 =?us-ascii?Q?VV1KWXGKC2xwD1QNZSMzINtE47WcVIc08bA2mX3qmvpU6ZCoxjCy4qtoq6Bs?=
 =?us-ascii?Q?H6XRC40l/VmSV3o/qJEvXvbP7lWud6MUvgbCzqKq0t4p1vSlsq501WUKf4Zm?=
 =?us-ascii?Q?Iwe806bc/GdW5vNhGE0TndJktQ8o7J6tV3uB7DDx0PmKNdQQXhNfr2FfktP/?=
 =?us-ascii?Q?KGhWpwHhTdpUItlmFElBOfXqBnaqYFH7Qvho25K2JaVSXV/GZee78cYNA/Rb?=
 =?us-ascii?Q?Tm7dR4mpEoUOJSdmwIHuG6QTCHadIFeSPmBeOhjZckz8dlHifXQByRyPrdtB?=
 =?us-ascii?Q?N2DcfoVnEtzesCtQ5OQgB0NQMJkKlyj3gEf4GoJQHsXYWbLT24/xFPZasd0K?=
 =?us-ascii?Q?czsuDVGwQLVy3dFvSkOXu7TBW3aBcUhKLB2ndInrkWxPna851FYw2SLlg59b?=
 =?us-ascii?Q?Nq23x5luW39AsmBq9odtWent6DaAfWWwFBFUyEU7uol9jsWMnNAdkdYj7UOc?=
 =?us-ascii?Q?tQbzuROD6H8+dMH6PqGDvsKvOCZU5G2j5gMeerk6gUlrnqFUJHHFjp1bLbzl?=
 =?us-ascii?Q?PBa6K45yCSiJvY/lGyzSF9OHd3oUPEvYP4dOCqtre+5mscetuiDt9Kk3Dyfh?=
 =?us-ascii?Q?dbvZz/RQh9xmvVx7Ke8tnlpQbxFeOz+GVFhuSWh8Bpnig9tzrKYMsTDAxKi1?=
 =?us-ascii?Q?6/4xrInPaIzCLPp1a+8j6F8G1QbH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hby4N4pUhyyGEsgONz3e+j3qN5NlBJv6XEboHfek6ewhCQYtgJpR0S2GdXM7?=
 =?us-ascii?Q?kwpVTkIX65HBMo0m0zjCRUd3HXTKwcy7ml/3Wa6WTsQlbnfBFh8soiUTHcH3?=
 =?us-ascii?Q?Grz81CtH2exdwYap/yx+IFhDHlt6WLDTu62wMoNUmtOK0ZYynPJ4iH3dHuTi?=
 =?us-ascii?Q?+4zrGkp++2vWc2MCmqDtnQNsV9n9S5WTXVMS3pyr0qpLNOihswmoHYatyj9/?=
 =?us-ascii?Q?/rUV38bFcEyplUUccKu2aSkBqRhpgPzGM+XQUiRunNoGUHIg/DN5i3IEa/RW?=
 =?us-ascii?Q?1F7PBVOSIsBmp7hGOjSUbgmX30xEhs4pv1urfGlcbediatKYDbXGTyXRJ7sW?=
 =?us-ascii?Q?nbwDNXH9i0WFWGz8T3GhulYehZU4eB65/A9e9nggtW8n7y7OvCwwwTveTz75?=
 =?us-ascii?Q?Mi5OSP+6cROr+xUAUzxH1vgnzbs+3/C4h3lSwgrszCTWLl0oP8v65nJfP8Cg?=
 =?us-ascii?Q?8x/ci9NaXlUJFRYUif9DAGtZG7ZGMc7GM4LNg7fNsU0kigFZADBduCBHetdA?=
 =?us-ascii?Q?BMa7HWPwzyOmPOt1cChdp0At36A2DrNOQTcGP5ogLccJxtA8Ky45ftK+0edv?=
 =?us-ascii?Q?yUurDIbUmgCQg52H6pm8GRv9mvoqawzSSzLCiCAIFcHL591yDuWrbGl5SWEo?=
 =?us-ascii?Q?L8Kf1fLV0ayhh6HyxNuV8EUO8DeY+9MzvqaYnkvUzaDULLS4/FRbwZ9BKFXv?=
 =?us-ascii?Q?fK+rBQbKmdHQs8TSd1XTaKRouFqgJnH/vvD/TKU5CMt2KkAIcAjGl7SD2wha?=
 =?us-ascii?Q?hDe7Y9uEipHKgi/D2riMFm36KFOqlFY2cpXBTIW2DVK0U4FJH1ltfR9bVO2b?=
 =?us-ascii?Q?qylVXPJk9vFrSHzDBz+xZKV5oPQHP602fdwagmpZ4+GDfXhd4ut/pqSe5hnW?=
 =?us-ascii?Q?l7Ks5nZ7GMxrGmvBG2ME6yKtFPKk/iZZk7VRXf43flSXADIkNdykhV96kNb1?=
 =?us-ascii?Q?lN8Y+77gCV9WqmjLn4MThgxE+WGWl6gobXMO2Z4DdUxb2HAHdKuVAviU81Jb?=
 =?us-ascii?Q?QRcDFT5so/ElLOM+EUkmaVvJYhyctDGIXhlXkcdH0d8WsgvRzzJ5xQQfMcfP?=
 =?us-ascii?Q?BClKLUkXG96P3ilu5qGMvSm2zoXZkIfBt9H1J5xlIfgUJrzRhZL0hTPzd7d4?=
 =?us-ascii?Q?qkgZt/i3D85VnfYgadAUlPG2pHkTRYMbxFmhbBRdVOk0MbJI/mFhA5xLu9/p?=
 =?us-ascii?Q?4uVy57+btxLLOL1nCFFCejbil3iEdYNEkUrJQwbeYUHlKG/VZrU1JNQAc6cU?=
 =?us-ascii?Q?8sczQQHrlsWIDaKmcYbuIde55Yq3n3eQkqqfeHD4ww8huzLUUTOZLkS8Yjel?=
 =?us-ascii?Q?GdPCPeluTgcHItu5BN08++JXWB9XGUqTfcMSPidawtMsDnvIQD8VgCpmO7Uf?=
 =?us-ascii?Q?nFL4a4hLgdNIVbp2DN9TKBhdZgvHsl6/HOJGaBK0NNpRcShCFfx1c9YRIZ7y?=
 =?us-ascii?Q?dqY1CRSfxNP9wOM9DSAOTeKCyPXLsU416tgMGV++KkMdgqwQAtRMefUTSg1o?=
 =?us-ascii?Q?8gd8Hyz9uJF769IS9i92jrmp7tF4bwrxWZRhS6MASNxeBCVi4713u1/a8UHb?=
 =?us-ascii?Q?hsENVvPLrPrbrxuO2oeaXuZOyXtcewyZIRGSkwE4nr0Nh1675rPBuz7FEkmv?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vond5mLwGhEweObQpAMaTIytwWGzcRTx0HNDzPn6f7hDWAf7RXDJZsLuLbEUlZ5/vueI/XKB8OeewFBX76EDB/Wt8A39GS1W8ujywoCkVWyvMGZB/yrUpM8RgXaTPthlVehwIpgGUGHCKmg32I1X0nLYcC+0Di6Rdu2EY+uRtl7gwMUTqY4bMIALgwistD2UWkHfoy6FBr5eC5MdXOu31950VumEdWxf3nBz8qSrum0cCUE3CSX2fBVaGI/athUYDhqpRH8pI4nT72xD12AwzuOHXpJiiU+9imhthmC0B5AiEP/v0+ga2Ia68LA/50G6GamPJ8cLKl9vwwQjaAww6CpbDz14sKAc8ymkMq4TlwC5VwxHpEotMfrNwp88ca3cw+gzxc+W0C7f6BzAeB1xOSjttUL5Z1OgwieQDPWd4iNoP4RabN/jbYGdkwdIHfiLLewfl4lCi32VKWh8biqyy59bQP3npkJz509PDc3cvAun1apSacJ6Q0KtMOUJRbvVEQZ0M6vpZNERpdzl7i7NiHhGqQk+q7l1ZoO6er0e2lJq9zZseaxLbIKpaas1+Np1rDKxtfqrtldpHK7YldwHcp+qAwCPQmUtBwki1Ma9dHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353d4b2e-65d8-4c29-5ea9-08dd5759c4a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:42.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiKkCWBOYknX0kaWMsKnQvM06SDYC64b2CxxooHYLulhLEnlY5/loSZQumt3DdhDIlkoXIqxSiQ1k2xaBIeQxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270134
X-Proofpoint-GUID: hk_KXPonkK4P43P2vKkZSCNoPx8h6etT
X-Proofpoint-ORIG-GUID: hk_KXPonkK4P43P2vKkZSCNoPx8h6etT

In cases of an atomic write occurs for misaligned or discontiguous disk
blocks, we will use a CoW-based method to issue the atomic write.

So, for that case, return -EAGAIN to request that the write be issued in
CoW atomic write mode. The dio write path should detect this, similar to
how misaligned regular DIO writes are handled.

For normal HW-based mode, when the range which we are atomic writing to
covers a shared data extent, try to allocate a new CoW fork. However, if
we find that what we allocated does not meet atomic write requirements
in terms of length and alignment, then fallback on the CoW-based mode
for the atomic write.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 143 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h |   1 +
 2 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index edfc038bf728..573108cbdc5c 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -795,6 +795,23 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_valid_for_atomic_write(
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	/* Misaligned start block wrt size */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/* Discontiguous or mixed extents */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	return true;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -809,10 +826,13 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
+	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;
 	int			nimaps = 1, error = 0;
 	unsigned int		reflink_flags = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -871,13 +891,37 @@ xfs_direct_write_iomap_begin(
 				&lockmode, reflink_flags);
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if (atomic_hw &&
+			    !xfs_bmap_valid_for_atomic_write(&cmap,
+					offset_fsb, end_fsb)) {
+				error = -EAGAIN;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (atomic_hw) {
+		error = -EAGAIN;
+		/*
+		 * Use CoW method for when we need to alloc > 1 block,
+		 * otherwise we might allocate less than what we need here and
+		 * have multiple mappings.
+		*/
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_valid_for_atomic_write(&imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
@@ -965,6 +1009,101 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
 	.iomap_begin		= xfs_direct_write_iomap_begin,
 };
 
+static int
+xfs_atomic_write_sw_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_bmbt_irec	imap, cmap;
+	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	int			nimaps = 1, error;
+	unsigned int		reflink_flags;
+	bool			shared = false;
+	u16			iomap_flags = 0;
+	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	u64			seq;
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	reflink_flags = XFS_REFLINK_CONVERT | XFS_REFLINK_ATOMIC_SW;
+
+	/*
+	 * Set IOMAP_F_DIRTY similar to xfs_atomic_write_iomap_begin()
+	 */
+	if (offset + length > i_size_read(inode))
+		iomap_flags |= IOMAP_F_DIRTY;
+
+	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
+	if (error)
+		return error;
+
+	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
+			&nimaps, 0);
+	if (error)
+		goto out_unlock;
+
+	error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
+			&lockmode, reflink_flags);
+	/*
+	 * Don't check @shared. For atomic writes, we should error when
+	 * we don't get a COW mapping
+	 */
+	if (error)
+		goto out_unlock;
+
+	end_fsb = imap.br_startoff + imap.br_blockcount;
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	if (imap.br_startblock != HOLESTARTBLOCK) {
+		seq = xfs_iomap_inode_sequence(ip, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
+		if (error)
+			goto out_unlock;
+	}
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, lockmode);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	if (lockmode)
+		xfs_iunlock(ip, lockmode);
+	return error;
+}
+
+static int
+xfs_atomic_write_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	if (flags & IOMAP_ATOMIC_SW)
+		return xfs_atomic_write_sw_iomap_begin(inode, offset, length,
+				flags, iomap, srcmap);
+
+	ASSERT(flags & IOMAP_ATOMIC_HW);
+	return xfs_direct_write_iomap_begin(inode, offset, length, flags,
+			iomap, srcmap);
+}
+
+const struct iomap_ops xfs_atomic_write_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 8347268af727..b7fbbc909943 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -53,5 +53,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
-- 
2.31.1


