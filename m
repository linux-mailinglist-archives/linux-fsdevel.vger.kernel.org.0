Return-Path: <linux-fsdevel+bounces-24810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2434F9450AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1601F237BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189341BB6AD;
	Thu,  1 Aug 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n1KXPles";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mJrKFhAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062AB1BB685;
	Thu,  1 Aug 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529925; cv=fail; b=FwF3BG3s4tgsx5XmikIzXjNefOdTnZkc//r3xiQoomt6P4vLRk8W6adutOxjWA1is+2LoXE//r/DxEEKu5zQ/N8YD+mMhbsTQT7Tno7WN23aOB3TD9k4uZZgfrAXpzdDnF/LIgiHUCsm7PkJL1xIcLQgQF90RVigUg1RhH8sO30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529925; c=relaxed/simple;
	bh=hsE5Cd/KIR7uZAjw48M8B1/Vb2rYE3lT8W+MoOPY3SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cbbqPBkQ+72eiSimpOpaZM/tYb0XWHJ8cjVYSMXbLaO7chel4sYdaFtc76O49fOSG+iQzLudLZMLAifYc6PRw3lVQVvH0WNxt426g32R3APtMkwkqU2/C2BmCP6b2h9QJVnEA5XGdRYdNgZE7QdwqRmILTyNXFD5MW3hjqYmvEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n1KXPles; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mJrKFhAZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtXtx023400;
	Thu, 1 Aug 2024 16:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=/mokp+9iiGpAswmtDttU9r8YTdVzCW4mBm26v+Hil1o=; b=
	n1KXPlesBp5lwN4wy0tjnwjfXKuJDtAnudlrI4nuxxE4JB1GP9hh6jayad2o8kwm
	LpGOIInsb6SUjo2d77Gkk8JNJj5+u4y5Lo7Ue69RNw6seTW3eetvNEwz0rZfa9OE
	SDaZXRmcQen0UL2kwb1aPDlI2f++QIEYssUtsmK6Yd2mYpSp3umXlkBMKTM6HOud
	HT2EGfbdG//INq4IroTYmwq+MwVVWo86rYhTcZyQhZAmH9pZiPp0iRzQv/2oIB1K
	htYm7aPNf8zr11PD8vtpp414oyDG4YkYD0sNJpoKY9DPJrRpDk9/Hw1yFqTEpeeT
	I24dmHQ9q/w0Tf5gw+xfTw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8t4cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471GKsKa019040;
	Thu, 1 Aug 2024 16:31:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qjmtvqgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSvwczpDsNBWeCeg7OnMBfsuisERJ2ZxcvTAfDfXy4/W99zuQFqLumpoObz9dpIqUDZeqWcqwkUHP6Cq2xXtWaKxLduGM1CJhFt3dK3vOne3Tad6TZ7DLE84fr2KZMFx512WXrlK9/asq8YIxTMrMRPW8QUswbV6qEKdi4J1QoeYwvoOM1Ma1+JazMC2WlDRX0GN/i467q9uLl5/S/CyGXmOdrlaDz3MpAxQrnTDc4bPKk64Hc0WliEoXZo8k8GCZiRML6ZvVDu0Sl/G1/R1BPqyGrevTysxhKIP7m6DRbNnEkcoTfzxalIYqclMMym7wG2g9T5S17UdPOpy8dQ3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mokp+9iiGpAswmtDttU9r8YTdVzCW4mBm26v+Hil1o=;
 b=iRxEtxunKhYyO57+ShAtQvdm2vc6zu1JZoExAZDHBXxuhS/Wx6EPYzCzVpSIDIXGZ+26J2fAeXewr28g7TvYRt9jkPmM4pJE67w8mmE/Pcx+S7m9BmVy6h67fkfZs5LWuVfbfNkJ/SDMwt1uRNbWWFgsccroTPJzTnwP/EU4JosjWTvNO30hz7ZMzds193PH9Y2qkgiA05Nck1cx4P9h/cAGwJcUlHcvJ27A+3gHsd4XcKOX1ozXMBXLDBzs+fUHk8s5AqfWAUEHZ7cTQp36oIg6jxBPi/zltE4Jwh7deyrHhXI7UfjnXcq1xqMfNz2r/05KyqHK0ce+c9Kj1CI0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mokp+9iiGpAswmtDttU9r8YTdVzCW4mBm26v+Hil1o=;
 b=mJrKFhAZf5eiVFed2fFnlEXW2ncmgiPLkc6eAq14MD1FHwXJnGl4BP17bUhfpHUnJU0rgaGSrWJDq2FQztKoVC8Oh81WRJqJUvFQz6Hq5tsYUO3WSGe7iY10IaCoXX4vl9SwnuAZJautvWbhnuFEKQA050ngEBJhwAeBvW2CHWY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 09/14] xfs: Update xfs_setattr_size() for forcealign
Date: Thu,  1 Aug 2024 16:30:52 +0000
Message-Id: <20240801163057.3981192-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:208:234::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 4723f29f-6d09-4e5a-4e04-08dcb247715b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fBegi4Q3Zo5ac0pI9hRIi2BHVBT0e6AEhs3Q7sJFwGqKaE33o3zHSFJSjgF4?=
 =?us-ascii?Q?ZdeFE/7qHtYpS1GBAgXzQMtRvAVAd3N3aWYe66DnwbQOaxIqwRths9Xh4CGj?=
 =?us-ascii?Q?V7zDtAc2dfd4dB0IqY9TMi3FBS6qbo/5NFGeLUresYbW+nLerTVPvDP00Uiw?=
 =?us-ascii?Q?aAHe9MZpFRYEeh7hibAzM3r+ro1wVzlrFTVlvjoW+F3fM1R0RbGCEPReiLrq?=
 =?us-ascii?Q?JvyMMq6kvr8TUwqnnO2TdplMB2V7nAwRb5+Xzo1k58EgdqLjIMeWjd5QZu4F?=
 =?us-ascii?Q?ytOlRPeiVbz9dwqvs0/x0U6jjKXgZHDdrCcTAMHsEhl8yudKxustMvTAPVf7?=
 =?us-ascii?Q?LmPwKUjOhnhGlBMmxxHS70DzyFhwJu8CcjNOUXP1obIiaXOJFDPZqxR01plH?=
 =?us-ascii?Q?IHF5RdfULiiPaNJB+wMEBdJFB27DTCi8/6w5LswNgGlT0RYLsNRpxzgXpUMl?=
 =?us-ascii?Q?B+C+WJnMYDhUyuivRdS3N7Xhl1Tw9vMGyZ7AkT/sKnG16BtkUNFhN8wsghLw?=
 =?us-ascii?Q?RvP7HfszlUc3bO33UoTsmDi+YWAuvo3NfRnVDtPEKHLL2poj8D4bQMYeAX96?=
 =?us-ascii?Q?fBm+Ud26l1NXA+s3qKIAlCPKnUeTpUtf3lR6W8hKbYg1U/6josZcqxv33v6b?=
 =?us-ascii?Q?XiFqegkaoObXrJ7LhGQHNaiY97JxitK8w2EKtuF6xGdi5bcgu8/qKhLiAWIf?=
 =?us-ascii?Q?1gPUacOUJAfZt7dZ2GCqmW6sF4Sr2JBeMGZPlqa/cDjTX8k96xcS1DdZkIL8?=
 =?us-ascii?Q?2gmpBXwZLU4OVlUwHDYsWYdohLaxfxpycN1Va0dim9HcyaleRWBxzWTNhv/O?=
 =?us-ascii?Q?l7GtJzdfhufR5AbOQD7HLq28YmmUoocench3PqoklbmWlUMu48xCP+xhmZRO?=
 =?us-ascii?Q?T1ZISZrc3L5635xn4Skpmgd4X63tfOqQ3HkjEB9El3RBrqYOf/KwghIlkyZs?=
 =?us-ascii?Q?b6snSifcIh0jTjBJtdB2wrFAeODh/kbn8a6hPK48sNtiHCeG+AAjJIKRnB6J?=
 =?us-ascii?Q?u5T6drVgO7KrLZcsdohil3aKKGEbIBRCNa+PfY0mpHvvIl8z+w5HoIVM5SJk?=
 =?us-ascii?Q?eTcXDB3mSkqeokXrnRUruEb0ANk1neGg8DCoPo2E3cqV8MfxbSZMOE78Jzpw?=
 =?us-ascii?Q?99Gjs4wkDS72nx8+66qZ6mvHs9D3Pa9CRJqh5F9rs4lkNY1M8BtBcPSmgqkr?=
 =?us-ascii?Q?mRvA2Csrmqjx1wU6aifbXJH0c1mVt9G15jlu3DFJRBOvdY9ht+UnePGTSE3Z?=
 =?us-ascii?Q?96TRFiV9oNslJEuOZL1juMTw6ey84/9i18cJvVDRQDcQ80tngWSkQfpWk0to?=
 =?us-ascii?Q?MX56f6QtWudFgGA8ekuBgFxQUaDpO3aZfnDIKCQrmBUi+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ER2iG8z5Ny0PPfZc8kA81J68pNGLWTg+tUZga/gZq/iFhYHJmuJJmeh1lmZP?=
 =?us-ascii?Q?jQ7ewXhqPmqfVrolRV5fjXsJgZpqNoEDLHYWjwkpkYq9EBRh5tmhkq09DxT9?=
 =?us-ascii?Q?Qho3Nxy4W8bD9Ornj4XktP5FcAMhnH3RsNeJnenCm6ILKY0FrTPPSCJ0peKq?=
 =?us-ascii?Q?UmPB8tGGHnEXGaPv2tFzRmPZ04etM/RwRkUwdsbhjNRq3PX5q6FH53lKf0ma?=
 =?us-ascii?Q?m6kdXH7VjWbfPOZtyoX/lq2bz8iN4toovBoZ2G9KS7shrvVziThbFj0+3z63?=
 =?us-ascii?Q?b4BdU9bb78hvU0UokgiyyxEinODb9eXEv6yA0vATajH8Iy3ldqywT/7jD1x8?=
 =?us-ascii?Q?eqQ3add5s+HcvwDFkRg+MtABtNnHuD1qcwL7ajRcMuAB4+D83D6+RhG2XYr/?=
 =?us-ascii?Q?KfMscvIMzPJMi/VkVj3qVvAXUswqsqTHxuPmTOlrwzrdeLkUnNApwI0SyfKv?=
 =?us-ascii?Q?Alz9bEuGj+zN34lbpPfWQpKWDeCQ/bRWo5g1ZztxJeKuQ4X9hHsGaYxlF3o1?=
 =?us-ascii?Q?1Dk44318STkOHV1GkqfaWnzVql9JzPSVkkhAFhRoBTUnmSRnz5V1ilkUXSNB?=
 =?us-ascii?Q?BngcBmIloNOsWu/cR5xQsjzPirqbzou10r2mI92lfa4BgG5/LSgU2679pSiR?=
 =?us-ascii?Q?Me6BA/qF4DBWZwvPliTgPmbjrgS+blUpjRQMzGH7e/iljPS2LuvKIO2z87ke?=
 =?us-ascii?Q?k2rK6A8RTyOoXkpH5OoNokZoVWpjFN+xXP59Oig+jsx1lrU2lUdQSbQux+PD?=
 =?us-ascii?Q?ClpXJO7dn6H1aW1YqcGLA24u5RfcV8ti39kDwxVb2Dc9IjZDhmQdKQAlO0xA?=
 =?us-ascii?Q?5l3AHbP6YHwLcq6Qc41E2JvVFuMW/MAz3Z8WTFpOEHNa4MrWS/j9tN39j+oZ?=
 =?us-ascii?Q?ivkqAJbo92rqgexW2paH+/unDUJ2LS3nuvTKHuV1FbaFe+vvbMz0+kEjlRs6?=
 =?us-ascii?Q?Ylh8FFdzmKp2ReM/H2hoI7wc+SlpDVZkCvknlCJSt7XvdO75948m/ba/aHrt?=
 =?us-ascii?Q?SP2nw75R93M0V2toqo4jQy/+fABwd46NNSg3Wz2eyhzXPG5/Qdmfzc1UBxOl?=
 =?us-ascii?Q?1M5miNjRbtR6YRVJ4VdkzA6p+9gc/tJP7KawpL+E18IWA9kWOac/iGNmMWbv?=
 =?us-ascii?Q?vXQ7HlY4J2jq5q8Jqx0RZZA5CpNxvR1pgNaykUVeGgA5SugeDR8F4MrF+wN6?=
 =?us-ascii?Q?5kpTUEfaqAarqQREVYbv01PY7kDCXSTQz3is/1JRadnu7ApagQqknAf5N4yP?=
 =?us-ascii?Q?LyRlfiBBivMEqmIhfJPnXAQ3JdCJY1RdNr/Fm5yTc1buhuZ7Nu/mn0wdjrmb?=
 =?us-ascii?Q?Y/0R/0cItbDcsBguI7vf5S8asCTkv/D3/3D3Hdtwc9QjWODjqmq2Eds1ahNc?=
 =?us-ascii?Q?DrwsseuvWVuZsQ5UeZQij0jjD9cGNZIs/vLs5a01yMiM7UD311I13zn/RLRG?=
 =?us-ascii?Q?b1b3Kp5/RjBhD+w3ttecxtIyrRxH2+Y/l6nAoomRc6qVb2lHuL0feplItz7Y?=
 =?us-ascii?Q?qDdsKHemCam76Bs7GNF0TWCB1+nSHJ4gjvLA8XPQuDazUnKo+3cXq8HVm0Sl?=
 =?us-ascii?Q?dHXG13B4xJ8irwzL7CcPOxghtrniHvnu+pzuyvcGikfdQExRBDdmMJ41krwP?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m/ivzNPYA3EiiHUZ3oKZqYsKB8SPrcivzxT4TQL9+jDZytTM5SKYkv/KFUkVa52vUDaBR5YJXSTFNzp0JyfHTvanSEUn38Q9adBFEXwFsgwttE+JZp4A4IOAurONAcxU9icRsx+HFdzTBPSQggdlnRx15PVFJygePwGgSnvgL4gNI2JmGatWzZbov04LHUNFY6mL8DGooi3H82WOD+/66jq4gnjPvDvMT6eOcMKrBuyv7VAkafzN8V/p6M2EUI8LPXrnjdQfRZTsLJI/pxUvrL1A4KByG+Of6jed7wH44hkbEpdIRJG8by+rREaP7WZ3u4v6QH8KJwumVWHuJ8DQe1GtPeNe3C70q4i3gcZIIFTP9E8eH6GoEXIuhWpIXglgn4zi5gFmyuKebo2yCfKKT79gxf2yj7sQpNrWfC5s/b4ZAY8UoTkq+D8w4mR1VIF8dFFlsi15mFL7oQpTt41QQVRJvy5lmiBJb3bmNWDzC5zjXDLQxK2i+bZHv8pH3TtwQ3biehnyxpKdfSvmx3mvG2ajkCsQhrarg8HSZUS6eb3uHk0ebjUZz1X6wqJ80GDZ/b/Hxt7pIOcYb+hUDWnE7xcogqgOAwTr52TSGHchM4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4723f29f-6d09-4e5a-4e04-08dcb247715b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:49.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qISEzY2KRolmKZKhRpUdrPGkx/fUmqXQpvGRzGFoa2Ayct3/rIF5Q4+6y0BcT21fhiDXGh7B66kWdJrho01uNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408010108
X-Proofpoint-GUID: GCbFvC60IvfQNxoFA7obwlBlE8XmgnHb
X-Proofpoint-ORIG-GUID: GCbFvC60IvfQNxoFA7obwlBlE8XmgnHb

For when an inode has forcealign, reserve blocks for same reason which we
were doing for big RT alloc.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1cdc8034f54d..6e017aa6f61d 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -926,12 +926,12 @@ xfs_setattr_size(
 	}
 
 	/*
-	 * For realtime inode with more than one block rtextsize, we need the
+	 * For inodes with more than one block alloc unitsize, we need the
 	 * block reservation for bmap btree block allocations/splits that can
 	 * happen since it could split the tail written extent and convert the
 	 * right beyond EOF one to unwritten.
 	 */
-	if (xfs_inode_has_bigrtalloc(ip))
+	if (xfs_inode_alloc_fsbsize(ip) > 1)
 		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, resblks,
-- 
2.31.1


