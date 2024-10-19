Return-Path: <linux-fsdevel+bounces-32421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0399A4DFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 14:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB52F2810CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88B826AF6;
	Sat, 19 Oct 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CFLolAMF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tBtXI4AO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658C224DC;
	Sat, 19 Oct 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342432; cv=fail; b=K/C0W9voxVhTxU52nOzonQFWMPXt3LJxSgR3d/pAYSoTBhK65reqWoamqh9FUnSx57PUs8DBhdCobiiTSlm2eluhQaIPnhOFy4xwKeKrQLIT53ayq2/y6BRMGsEO/vgLMt+nbmltIHotPUrglyVS/naH+1BpTsywcT3GWDsyFuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342432; c=relaxed/simple;
	bh=d7pCKy/v4R/az5P1ZFT4xRN/KoSadNhULPvY86q3tKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPESlg0vtebcGj+srbgjub2Hrl34SlwG0Yj9ziTpFRg3hgAIpG1fbW7YRi2uxltoOdPw/fD6bgszmMJWbCVeBte/b57F/gTahXozL0g73dZ2nCAdE7PTsfwQTl3R82cYHt9Qelb1IfYWh2P42ScUBUAV83tIE5XNA9KDxqiJAW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CFLolAMF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tBtXI4AO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49J45eEG016052;
	Sat, 19 Oct 2024 12:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lrb4J8JHejQPyK6TrSyNIOUpJ1mtMiCcpVHtMQikrnU=; b=
	CFLolAMFa2nAC3e14cHBLlGVXcsf2Zz5JDW44QbkWVh0+RhJb+LrOS4XjkbeHTGp
	7sOu3M4henHxejvtlOaJn4WlTURSf6TmFYM0m0gkkGtpPjMFNj0cFWppb9D6Y5IG
	b/AsQHG6W7hEcyNdeV03hghQLqhImWEWTKNRz1oGYZhMv5gr1q7a4hoxtucKevvp
	gy0f4zkGUeAIU3gRjcNwlnQamaRE6iB23jWB1gDbJwmR5vFFrbztuZrIeGzOQZBk
	yXB/U4LkUpGWaJiurlLlWnZ0QK1j7HseUKqAcKEml88j4v4Je1uznC8MUqRemoJO
	IngrC28TQSfL4mj/E61Qig==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c54589tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49JB7irC020344;
	Sat, 19 Oct 2024 12:51:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37atgep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPM3ZfswhQhnWaEPr+gAOa1v0tAKjBZQXl2ycQoALbqEpV/WMmNNwbmxF6UKkWlc+vSzQKXukCktGAlmhZ9a0oQqU8JLa1riIB2N1IA4QCtRB6k28WA4XPSP1CSFdn4FYCwJnxiHFjWfQTPcb0DCX6IL9Hm2UWG6wdHSyEVG+e8/hcaYOKWD2rVvVNDM62HsvitiH3zhnes5AFd/BMFmVdlRMAKQq6+yamctG9FirFuS+9TLXiCJ4JGrQSNRJI9f8jW9OdeQ8HzaTOChWQ5I27CCkaotVeRc9yeyljnounLGWGFM7OpUnQ7CohW1RTwex7Qs2eOLzwayiYIAIEXtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrb4J8JHejQPyK6TrSyNIOUpJ1mtMiCcpVHtMQikrnU=;
 b=wzJbUskanVKGMHDvh42zKanzYt8AlcHdU7OcpDyx1PH70tA9vuxgWUAr9uHs4PZSoJNcHmD1srqJSi7bCGvkwA/8EOfIB8YpR4E9tmaAaQtV2EjDzJVdsojnlgvDHUMu5gHnL9zoarmnFrW1yJy0ja1V5W3Pa5UYBNJDVuCyS3LPYR4pz7m1HmTAmjHlkzxieQVp2T1FkDIq9HtPPAfxKfUzj3vcJGt5LoNvU0V2V0wmD09YvgpPGDMgOiMyj5uWIINm2asjDPB7yqXfZCeBSQP7v269lld5Ydyuc6rpROJcHXxbwIf8uqL3vE+O5KMBfuZa4d8F7UML+CiSsyp46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrb4J8JHejQPyK6TrSyNIOUpJ1mtMiCcpVHtMQikrnU=;
 b=tBtXI4AOgFBdgvIviwoEHRU2Tm+BbfSFGRkAm6JCvU4UzqOYCHdBM+LbTAwdhv0brLUm8qW2IrFLCSwXs5+3mAZ+661x+gaAoa2vIBrRLfJwdxF4uCS5wSkblJo3Iq/30JgEBn61bwTMQhQg2oiRy2NFAPtnGMrfxqW/GexE89k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 12:51:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 12:51:33 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 8/8] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Sat, 19 Oct 2024 12:51:13 +0000
Message-Id: <20241019125113.369994-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241019125113.369994-1-john.g.garry@oracle.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0006.prod.exchangelabs.com (2603:10b6:208:10c::19)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ea9b3e-6ccd-4015-5640-08dcf03cc2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OhsU01tV4YPSLCdzOTNha8KUBrG3dSNjxK0w3uSkCjH8xXk+qkkdiftkobZR?=
 =?us-ascii?Q?92Mjzd5//vLUJmliJItbn0dDZdPsYuvTZJjvcF7oKnoI3y9pDD91P9EMqAie?=
 =?us-ascii?Q?6Lu0Y1JPqklfZ+sIplk8R6N6mnOMh1iHrCg+M7wvChrPDbRPIQ1cFNfehHrT?=
 =?us-ascii?Q?Fl1/69zhmy2IY0wshokJi+KSvGnx579udMuHs0Qo+YOKl35WWKRiiRq1DRQe?=
 =?us-ascii?Q?BjMAUOR5/8wocqOahqWhaPR1PptKyNtBKNUIak5Z+ZikrqRcrPLkYJGBQeL+?=
 =?us-ascii?Q?adBzKNJM9ZGrCJLOcO05mXjU00ZSrWLarkEqg9geyqkjoc3WU2isn+RY7Kf4?=
 =?us-ascii?Q?f4NcHUGsBFNcBULQp6o+Ur77/GMjY6v28YAJmQRk0xkZheCVjLOvfQcCmeCD?=
 =?us-ascii?Q?+kihkYH52D6tvvQQG+wRd6kZECMwj/XCN5q+Gukp5IHh+jdWaGO0Qc4d4GwB?=
 =?us-ascii?Q?Va89qyAr0Yew6LVxVX0fsSDt9Va0RcuQgywLiNRamcHUOQfRTFHiSfVKO0ir?=
 =?us-ascii?Q?wHeEMevTlyBlFhYRyvBiV7y/icJn9yRYJbnfmOYhA2riChweMfck7UaUuo4g?=
 =?us-ascii?Q?w0x1q2BP1KhGzpMIfX3Q/eus6hAsgUe2b83vS72vD5MyAl7E+9BTdJ6nJ2+i?=
 =?us-ascii?Q?tkiG5s/Az6ZhxaPYFDSbi6DNPghq44c8A/8U/+vBEf4OQY/fbCiP3XQuZ0kM?=
 =?us-ascii?Q?McrsNlGW+GoaxDx0VlAQukD8rBgEu64oj/aGx/xT39CK4DV7d1Tje/ZYoq6N?=
 =?us-ascii?Q?Tpf6WZ8p1oe/L6fcAJ+vpGPZ1qNiC9hjPqprk8SUL/qz1mDeiMlj5qjwONEl?=
 =?us-ascii?Q?Jz5sw0mu9TxkpVQXFe/PgggGbqCdTPtXtUqGx3IBXW5apdCa1nVXI2WGMhv+?=
 =?us-ascii?Q?C48qUiViRwUZaIYNtswOfqaAK7Z6oYT1VNzTWIQnuTUH8jmretth5BAJGSoI?=
 =?us-ascii?Q?VcTWOai2iswn07FKejMSho1L+5Ld6QtGZIN46hr36lSaAXoSoCLUURdwcDu9?=
 =?us-ascii?Q?kQHt5RBxBjQWCjMYFS6rGp1qQYXgUU3xZCmmOix6ZEYERX4cfZ6EdN/VW4aD?=
 =?us-ascii?Q?4eZ57TLQYhoQcQxrEW/pJIRCJdW4ZK51TDU0VrUu8cvdccGfmGEFLLg8w416?=
 =?us-ascii?Q?vsBlyCYXZo0L9YwOTS03OZX4lHNjFcQfI9fq4jnrdGU+gwJbsQlHp0f/Oje0?=
 =?us-ascii?Q?1j5QeMl0hJkxgHn4PLClk32XfvMVecnSHqXnMYVxMEGBH6fm2PJKsaNE310A?=
 =?us-ascii?Q?DgvM2CVW48MeZklq0fCuxvVyLyFsMQqdG3yxHnnzbFaV5GQbvOaJfSeTJ2AF?=
 =?us-ascii?Q?Yr2g3XM1k5cMaJlf60DD2QdT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mMABBm1rcEuEFUIB3B+SLS5VCcgK8jt2gnYJw07oU0DfTzK5R0JL8IpUNXHb?=
 =?us-ascii?Q?WIZ70HV9rCOJvlxD1D3Iv0DP1hwv0DRV+ebzi095/A4uI1RqR7KaPRHJkSPq?=
 =?us-ascii?Q?67gdMf3btLrZNZPAmfoyJfN1Y+kh9u8N6wSbb61EBA2UDqzrQCwk1dU5skR7?=
 =?us-ascii?Q?b/xsT2hKiVEeL5HpESi0D+9qh1uY1HC9xZnNSduEu5yFwUWrMH2I/5eEs2MN?=
 =?us-ascii?Q?q6gGMQQ5BE/Of9+mzMeRxay0KrNO3fUEqwwRueDvazpbEipuUS/g6nhpBobN?=
 =?us-ascii?Q?qxYL1ywLA2uIzTgdJIo11miaiE5/Y7u6dhsDKNUPjA2RKisG3mAKc2sS+k93?=
 =?us-ascii?Q?HVpxOzsiWZoik9MYJLxTNlhstT05gBJOwlMxoT5SIhE79onhDaw4mgpElBSs?=
 =?us-ascii?Q?n0ldA5Fj2GxSlrHAW56nth/uMvzCCX6V2CHye7lw4bfYRZhyQoEa9DeFga+G?=
 =?us-ascii?Q?vd1FvcL6SiAG5c31NxPki+sIeXqdaSHISnUmTOgnJ0Jzy0jnGdEvY1yannY5?=
 =?us-ascii?Q?mnf80ZnLFSj5o+JRwzfRhR5d9mihrNkgTHMzKKFOM71UOxsccyLu6I/SzzYI?=
 =?us-ascii?Q?8kGGrRVezRCdlLib+aOtQTd5+Fq1AbWYG/6btrx4L3Zzidp3XBWjOBiWq3uK?=
 =?us-ascii?Q?w1NpIWTqQ+YA1TYtQCw/yLw5GiUK8iqJeIKW76QGamVQtmxneWmCvYJn2Wpm?=
 =?us-ascii?Q?gsPGaBxbKeeI/GWiMfkSN1AnOOa7H3MfrC+JbZCPHdAbM9CVTHQJ+aeKb63i?=
 =?us-ascii?Q?0s1BzQJ32M1bGZ9v5f5/z2BsyE3EAx7lqU/MMVRyj3aSoiaVwj/vaEXmJBU0?=
 =?us-ascii?Q?W/cPQ0Yk4QydSRWfn1rwcsjXFtFqYjRq2/i5e1v+BGTdNHmUY8MzmdXcxVfz?=
 =?us-ascii?Q?l9hnGYg/erVl45W5Rh/tRS7eryfHRNmI4SFQQTCVd3nKryls8PDYjO5naEWn?=
 =?us-ascii?Q?Us3pH/7F6nzB9DCOTgY+lyVM3e4H6PVjYx+igMtVZvermS7PMxEdKYronEa7?=
 =?us-ascii?Q?rFLtM3ea5y79tBSlOV15gpzFiJgp/l0SkwoAuO63THdpdkKi4UU4J2uAPVvZ?=
 =?us-ascii?Q?lcf1g2XntIkYGDVxjISWwaUPOc47y6qer8pPX4AR/mUpfuyi3SBarosD2cTJ?=
 =?us-ascii?Q?CQaYR8bTLBK7kxBSFR/4cT+vF//6fwCfRUn+3KAtnoXxJv0Mayfurm7lIfVj?=
 =?us-ascii?Q?j1awx7SeUQAEE8Nm7yz0vllE9zF2HqX8keck67tXbdBa+xqJgEVbLc2AgWti?=
 =?us-ascii?Q?k8r9LmOZ+DYhFUISanUbxtXdWgsQBV5zKmr8v+yG8AHrCog7RIbh2iWD2/LL?=
 =?us-ascii?Q?iZ1Kh09gdxrwsQZ+ryPu5tkc4RHYbsCsnNaLt8yohQOA01DgjxXjOj6VYTtK?=
 =?us-ascii?Q?0XzF1Xywu2nHYby5o+g3K2WqBEeYrSiTJsOiEGWd8H4kqOLsZMJDkPZZMaPo?=
 =?us-ascii?Q?LX5j2Awya+0cEZwwuCWazT56gOuuss/GG/FvBdZkFYo7zfDZHEiHXpEPoHC6?=
 =?us-ascii?Q?cR3JTwRKitSf9Cj3p5y6eKu80AhzPSwB0alUM6oe34YVqgRQ7T2IN64NVpUb?=
 =?us-ascii?Q?ggdo0z1eVw03615Qve4lyR6T6nnsJM4B4dy+I4x19jqjcLe0sYoK6rlG3cMA?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MZc19Iljx6GHKoemG/FAWF3UyeIlFRVs5FGGhiwU1/sq2BDtcJDk8X+xO2HaHvzphfud9V9hRXFohWbZd01JGt/pXfQkZhrzICp7Qsc/73ZNC192smaNqE1kcnkxDHociWbSRrRsBUfRh1d8GJmBzTqOtryoiUHpcNA/X5mdNdSoS09fQDADSUrjcCclk2bBPNaWww6v9/J5VSQrDIX1x1Pwc3e4PNnD1N4AoqWx468Npu0+S+lErDsXKJtd88HsDvR9y9cInwGvy4ZdTpLzT+1KtyNLFYXP8ARFbKr5jCEQVtb8WTtp6U4W+th5LRxl5Vm2NND59NX19LcodmWZwkmIs89ZQNwft8ldlHyfYkNr0LKOL7S9axn2BCcdxoVZ0Jw2VuEVnXnqS9fXLtBl/mD++qXBCl3ZW2qGMcYAD+4p5YKcSfPYaqzxhL1t1JWP6l2ym8Fbzg/hn6nYyta11zk/WSOf7Al9Py9ax0XL5qY71PjSaSMxdhcfkZ9OK1w/vp/6BaR/Eot0KyC0k/+0RRdeaNi1xHan+jHmHFhmE/zxMurNk0YeAfl6tJpqA/VLGDccXPXYo87+c896mxMLmnYfAuXz3dG0HIIRMkyR838=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ea9b3e-6ccd-4015-5640-08dcf03cc2a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:51:33.4955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FH9jWB10Jwm7eyGnGL7h8zlZPXruMwjcr+JfvgG9kySKWz4JAQ0QeNWujckfi8PSCTmA0Farc1ZDX5u8KVmY8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-19_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410190094
X-Proofpoint-GUID: mAJeF7VTANhm4QyeT3v5FzD4C-EU61RP
X-Proofpoint-ORIG-GUID: mAJeF7VTANhm4QyeT3v5FzD4C-EU61RP

Set FMODE_CAN_ATOMIC_WRITE flag if we can atomic write for that inode.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1ccbc1eb75c9..ca47cae5a40a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1253,6 +1253,8 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
 
-- 
2.31.1


