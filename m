Return-Path: <linux-fsdevel+bounces-42779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873FAA48794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707641885530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F861F583F;
	Thu, 27 Feb 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FL+wTEqO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H5dUpIfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6DB199239;
	Thu, 27 Feb 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680089; cv=fail; b=FYRgNh4GLsnSgQRpswcc8zsaa2yg3WXfwDPP9UvjZnGv3rANMHcaWOw5VHmC3ZcdktHk5bVnN86/WiVk/8fJBr+N3Z8V599PLJ4ovEOGYb8Oy64zRpb5Hq3VPXUat3+i7ShF+9FCHz8HljnLOoPFaHesp9sGQQa2v6BmVhAsTGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680089; c=relaxed/simple;
	bh=LEbJBIfFBooE0zNlqDfOV/z4WOoSwMoCQy8rApqEkWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LZE5N5c7y8Jwfixa0I9xw+AFg0U1jP3TR5EdqizPB+j+jWW6BGgJIT3n3xg/ZDgcxkYiWrBuUyduKdRmffjcRZfnGuPaxsHl4BfOzyrq7d6iqsKDOoadtObhYBA/8OVfgjW+68ZB58i6B2Alm120ppHF4/xvPnmkLXRMZtnESCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FL+wTEqO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H5dUpIfp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGffbE029656;
	Thu, 27 Feb 2025 18:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YioyRx6zmpc8ShPUGKJYxXaOJQP8hipccExmoq0jSbA=; b=
	FL+wTEqO8ApvwfwHWdJiOegU+RyWztcZqXfqc9ya4RdUFuNwStVbU+bJBcXX69fm
	R7ODontQAy8gGZO3Rr5Jd70qVMoxDxeK8dF546klJSOwfG6kB+qajXUZSzk8X1Eq
	+ges6iLWA4wn9Zx1WCm9agJblrVzz8c7xyJyMFF6qAShog99vGn5L5ttkyyPAkSn
	vwfP/+LNGENIAFRUCGBhHsPyQKGj5BOFdSCrGn3x3CgqmLiPJeImn8+SJ8m9COed
	MarGtZlniiO4JjhGEGrnPbNWEa04psbBbfL/+mmKczZ8dnW0IhrJKXupgTDHs9b5
	pkCziyg0PGGVgo5dEL+1HA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pscc22q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:14:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHJ5Ud010036;
	Thu, 27 Feb 2025 18:08:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51c6sm6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn6xMZytzihWgL7kT2kLg6C0mCS7U+eDWlw4HO/mqEA5ckBq697OopVzTXPkO0nrw11qM4nxP//AD9CT1w2VwEY0A7BjVvChi3UwaRiUPYLXm3CGP721LVSGVewQS+VD1dlUPExIDnXdPvuaStmztW5O+JfPMclASscG6yCnewWys/ZD2v1vA9MtIfmMIgAeq4mS2lfND+DZmPH2U1SIiyLC34uXqLSlmw2Ha48gyZiin5pRHZBay8nh+tAjxkQAwQPtfXWYcJGgAj4K3iYGy/5xB7ZpdifxFvIoS8LxEklVMXUVvJvlQl76SZFiqMCt4rPpUr8aiWeK2LuOgMx0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YioyRx6zmpc8ShPUGKJYxXaOJQP8hipccExmoq0jSbA=;
 b=GRyqLFaWv7g97KuCmsPV67FPoH/OEGMvXI7yoj9xfeqTF2ddIncS0zbHBX3VZWVpFMLZzHf49MkWviFNT20eBR/2Ng7KvSrENJWIZ16+m9zGNvol/GqURcqOtvtUj41NH1PriSOydWXjvJyjUhT0F7ibM87mSBCB+c8RHea+sxu/vZFf1DtBt6iBWsMbNyxuAMVbX79FEECg6xYOHNlPtDAPanJMNGL/Q2wXVLFTo0tBUjOomqHfFhBV4alqTzpmqun5dL9l2LMF8ibRpGPgHDrxyT8myE6tHsFCg2oxAwZnMoOOxHGQ9xjOU5c/974voJyYEBge0vOKlJ9u4OVP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YioyRx6zmpc8ShPUGKJYxXaOJQP8hipccExmoq0jSbA=;
 b=H5dUpIfpdEWF7mm9pPolOUwtjldFDSqTMARmHOgu43l8yzkR2/eZ29x+CzfE8IEXbTXWeQ6jahmci2+txSAGp5zHME1FZ1bIM+DVWxTKuPo2NdkQbGCHwSgwMh594d+WogDUKoQuMER8c8C1sbDkyIXhtCTgcveWmSCCg0ZMaVg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:33 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 03/12] xfs: Switch atomic write size check in xfs_file_write_iter()
Date: Thu, 27 Feb 2025 18:08:04 +0000
Message-Id: <20250227180813.1553404-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0042.namprd20.prod.outlook.com
 (2603:10b6:208:235::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 684d6635-3064-42ee-c132-08dd5759bf7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cZYmvisBUICWnzjMYCWHnDypne8OwO0Mo+kiVY1ay+44+NJubfEy2uGiZTSB?=
 =?us-ascii?Q?nZzed30DLLSj9WcvQoBr0uHyobWFOGJm6WzooIlo2Bx6MeXyfNSegCxwGJ6/?=
 =?us-ascii?Q?DCFiTZRxe5D9hyWYOKjzH7vOz+VcA9Hd70PyAI2BDuw870Cavr+bnLRXb1Uk?=
 =?us-ascii?Q?ynuApIuahngXzn+3zACPzDLpJiUaFIK7PCPiKRyTJ8T7Wtn8AiDceoguCgji?=
 =?us-ascii?Q?txZV8zL9zfCRDrBmwcb1Jx0Kzo9Z25agLphlaYa67g44d6kRZ5tzWb/1ANme?=
 =?us-ascii?Q?Q4N8qLMK3ERGks9fNuB8TjmTF+xvWNlte7RqlJuERPa5AenMtmB7hRlWLncI?=
 =?us-ascii?Q?Jcg7euL6ze+/tKVX3KxJH+JDQafBzwDyglT0bcFRXXU7VzRNS/OFC2SIvxV1?=
 =?us-ascii?Q?mDFXwzdDKJoIqDpargaNpr4c2ZcDO9q4ca6nyHWJARAx4LpZY3R6QsXB15sq?=
 =?us-ascii?Q?EzxpI/39SfwL6JUVNXMIPfS03f1p7O6xRwtyPm11+NP3ag+69fLvBzoegCEw?=
 =?us-ascii?Q?QebyA5OvJe2MehesIiNq7pH5ffdD6J5mtAdlCAzdnWoDO4JufBv3DJ6zI0Pn?=
 =?us-ascii?Q?/NM5DIWRgamNoahXxNQKrm2neMRJ7Z93QxDUqTMdjAVXhDA+81BQ0+ymZaHA?=
 =?us-ascii?Q?+3huT7ps1KoAWpTfOb/aAmXZTx4qLaGf79cCHfIE88MmLEt0JJ0gMbyiMW3U?=
 =?us-ascii?Q?MBosEN7kWcMT4ptIu2GzQ0HE4c11bmBM4w5Bg47i0eulV+zwX+bVIoJYNBmB?=
 =?us-ascii?Q?pj8czc0vq+SvaFR0fdfNC7Oe/YpB8WzvYkEv4faGyZfa1XIGCXJs+a5V9SWL?=
 =?us-ascii?Q?SYqg7bYF+lo5aotkk3/0RaJQYq99qGpvbKNUNyDblN+5p0AACWX9DjIRxL9p?=
 =?us-ascii?Q?eRI9GlSksGLCM4mXqSIlKKc7mKijwR1KQlXtjdNODVPkJnSr2WuwWoaBcB0A?=
 =?us-ascii?Q?y/jyyJBtGqPh3prN9SC7itt2eRI8JyH3y2N43c9QQgJP4QZ8imr0G++O16fq?=
 =?us-ascii?Q?OXiiMlCat+xPzGnFXxFFb+SWGGTuE72iXWo88r1U4mlgeGc+RABF+TtvoDdy?=
 =?us-ascii?Q?3zgK+6WHpq7XfI+1zN8gbTXg1O6mrespmvITcOaToFKTBq0br488VsZhHTLg?=
 =?us-ascii?Q?zDTCT2Nho9qvWQzpTRBWUEeYORxikbt+Q2Z2JafbYRdJcPNgnVFhHQYb5IRO?=
 =?us-ascii?Q?IwSgkLbsnl3EB1kDSagAf3q88PF3mRhFa+wKlcxhlVR5/2ioOA+lnng3IMbk?=
 =?us-ascii?Q?LTeoUUUFQw72py+QgohSX4/2dJ7q/UUdIgDLcAM9Ilfbxv0gCB2vDXv8awZX?=
 =?us-ascii?Q?cwDP/v4jWB4YTMJ9lAYG9fnGcOcCcuFBBhMoCff6jaXouK2oag1XK2yJszX4?=
 =?us-ascii?Q?UCtqHYqAoOFyguthCFVV859sApvu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qVWfb+9bbbFGCodJjFV9vARJ7OYmaaJ0ItzwAXo9WCujF4UJUyATLi+loLUw?=
 =?us-ascii?Q?14EhZsplRQ6V08xgdyfFiEfhOi2/uJz/wnEZzh44ZmPCws6eK9yW4PdFb3mf?=
 =?us-ascii?Q?hTUI6Sos5Z1W7XcjT+nWFOitmdSfMer9KwxWvQ7Ll8wdO4chSLuictK1LqRI?=
 =?us-ascii?Q?HEDJoMPaXIqw2GXjINEg5L5povAndLCLeqLsMHQfWODvuEWfcvGXmTSUn2uR?=
 =?us-ascii?Q?LRESkKgHRcn8WLQ4HsYA/7MhqcL7nmvhcSdX+TH2nztKTVo9Z7BWrw2kldjr?=
 =?us-ascii?Q?CtUlMDNL+fA0lBX0c1f2sQnuoXMLBPhJjlSXVyv1Qt39Xrt2xK3jq4FEbhlC?=
 =?us-ascii?Q?FMuAdZ5j4nwAEyg0U9UtQH2oxtL7d7isysWiVRBCOwYCGTe66OaeXNDn+gk5?=
 =?us-ascii?Q?UjeW6DGNoMCX4AIeMZAZvon9ld19I7mn8WLqTJa530TuozFV6rD5fobwlYQQ?=
 =?us-ascii?Q?YqylCs3sOGKvx6u7cPge4g0URawhEsSFKxStrIj3Vjvq0ByMt0VaYm50dEES?=
 =?us-ascii?Q?8AhmgCnLIefjJ4XDDFpfFEN/gXZLOKpOe+KeDjkZYQPCywVI3k3B3yV6AMey?=
 =?us-ascii?Q?3bxmu2EKAvh8bceFk//qV7Xjc6NK+zpb7SY3ERjXP5cc1L3CCMfPiTBRNVwM?=
 =?us-ascii?Q?RNQFfD+dacqocw4ddsINVaBATshiQvwGLfpIHIrs5uN0CNKpyrIyO4s4t5N9?=
 =?us-ascii?Q?Ck3BpUA1TG143uOu69rUliMGDHbixQj6pE927eX7cq8EUFdkR7gw+LKdr+Li?=
 =?us-ascii?Q?tPmR5q5qo/Bn5XAXmZW/BpE5S8cxtgEAfRQ851HUcfMiqRcr/JHlWdYyj11g?=
 =?us-ascii?Q?hTgkZodS816dIHFoSYjx7nRNYANx2J942JasSu3J77LHxLUi7HU+tkbkoX2z?=
 =?us-ascii?Q?Qi1FY0nEQDJfjTeYbsI3K7O0dcfvI8cfM/1dGOV1IJP3spJOQSKaZiQgp1th?=
 =?us-ascii?Q?MZ+KcSvMu1acLHbcog0m7TwnTJ6QXAiopY9kEW587bDmGikdX0H9xZtZcrV2?=
 =?us-ascii?Q?+79rxlgtiNoD9xAB3uSjVcn/9nAUm/arLA4BuMMzFJnP3fOTs2P6IbA582qv?=
 =?us-ascii?Q?g5zpb+1/Ev+XaGJ0CtlHYK6rrz+LXd1JEUU5yJ8Tj6NeHULGJeeG8F10JLln?=
 =?us-ascii?Q?k4b0KyQ3L5xuB3FsCvaxbz3oyFFiFXZfwrbJPn3QTzn9OjLnb8/74FxQHuSu?=
 =?us-ascii?Q?OAH+ox1+Jx/2IQ5zLZz/NjUKWEqZUd4h7C0e+/SzuWpmPUgBRhO5ySPyG8tt?=
 =?us-ascii?Q?OPWhtEj/fEaq9SJc/EQkUTCUCsfjIMzWCW/DiRvqpmiCZwqcG7WIHT+SjjZI?=
 =?us-ascii?Q?+h9w5znMjdeb6xTl5ZtZ+1U0H0iIyM+kdnKT4Y1Smtdb9c8f68Zm42wreaVr?=
 =?us-ascii?Q?RT9Hs07PaNpWVehtMtSECmfAIJvYp4XERYAnRIVADuSVy4FMe9b8YIKwrtFC?=
 =?us-ascii?Q?erWxVlerciK1/3sn8WUSqIygCUzbRvJ8ysL6auqxKYacbxgbjmXNFxaLs7jE?=
 =?us-ascii?Q?Ms0tr2v5MGHvnlNLxtJiWrthQ8vz1ZEF3zl27j2POHVroEBdVow8O/yBsF35?=
 =?us-ascii?Q?AFaYdsdMPFOdgSWVYHSiehDbB+3afaPnMlw2UsLzjQ5OObiWJAU7QkeTsmre?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RxbsG2YiKiQcpC+q7I2PMZ0qNkKp3kNQ428YJPrpr1aV4jSfAIShqiM/ppaPOUUMtnmUhbgFDgiXcY4YygPo06r9+Khz4J6+GfGyCb5VR5nn8SKV1/n5NWfHEojIru5Cr7lGSQWWGbDHQJ+mtiAzvEpfvrIn/yhRAZbhWAeXfrDIerMx2RZ8Apx2UOPuqfDD/y9qxvWCqPgEp7EBmhL1QNLIISDukWWAZXWqj2wjX1+e0vV3wyx70PwydZyIJKK41GmugeUxeqrxLuNfwkmLEOwTn9TFc+BkCJa1Qo6lXMfSvMn4f23WQw/vCJk3Q5kMkd3Iu0FNq6AdYyQyj3rz2iYB7Mw01FZ0ypblA3i+5PQ79+DwEb/KuCHp+E6/94EQ4wVVulO0ULbQZG+x8iMj/uIp6acnzWJKJNqVY3kOinTIkVIVCXvf0M4fuv7A2QVHKvX6Z3UK/WS2a01GrWZRUcrGsyr1qp+kjzOZ9gSHa62Q27b3+eqdIZMgfY8jYK8dEuWsDDzY0RNKEzjTwvl+hDZr8mDGEgfyeVnIWPqtAuvkqtSt12usWtfEfoFa80aZ889lZxI5HM2iXiT+KtN6KQNRDfu1wHSmtUR9lH0vA0M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684d6635-3064-42ee-c132-08dd5759bf7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:33.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCeHjZwl+bFQm7uSCVou6wbcI+CJlIpLmx2ocMVsgpoaSojw8eTsDEwwWPGgSLMioT+SHnFm533Buo7sufdECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270134
X-Proofpoint-GUID: eBgTVYrw8d92nuqRxGwPbTTOl9WPTszK
X-Proofpoint-ORIG-GUID: eBgTVYrw8d92nuqRxGwPbTTOl9WPTszK

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, refactor xfs_get_atomic_write_attr()
to into a helper - xfs_report_atomic_write() - and use that helper to
find the per-inode atomic write limits and check according to that.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 20 +++++++++++++++++---
 fs/xfs/xfs_iops.h |  2 ++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f7a7d89c345e..258c82cbce12 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -853,14 +853,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		unsigned int	unit_min, unit_max;
+
+		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+		if (ocount < unit_min || ocount > unit_max)
 			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 40289fe6f5b2..ea79fb246e33 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -600,15 +600,29 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	if (!xfs_inode_can_atomicwrite(ip)) {
+		*unit_min = *unit_max = 0;
+		return;
+	}
+
+	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
+	unsigned int		unit_min, unit_max;
+
+	xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
 
-	if (xfs_inode_can_atomicwrite(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
 }
 
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..d95a543f3ab0 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,7 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+void xfs_get_atomic_write_attr(struct xfs_inode *ip,
+		unsigned int *unit_min, unsigned int *unit_max);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


