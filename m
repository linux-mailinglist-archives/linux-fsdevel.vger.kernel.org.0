Return-Path: <linux-fsdevel+bounces-40741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93050A270E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0431884C23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AD620D4E9;
	Tue,  4 Feb 2025 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zp+rJrSN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wObCihP1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DB1DC745;
	Tue,  4 Feb 2025 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670656; cv=fail; b=HsuKXUZrsoaNlPYk2QpACe3l8rfu3wxAmtWszW4adBkBabI4BvYaXRwIMDoDQ9GBsLKLH20SqWtodlpToJKvtQcimsRyYDlwQqnq6w/8C6SwqQZFFXOFcVK2PHN7MnAhx35gReEz1WJAX5HDWBH9SfEii/DNKWkJXTmGHuN/tms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670656; c=relaxed/simple;
	bh=7dUTAeEtWDPaq19wjAbzmEn0QH/LvAN+DvULJaSA2o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M5hD+g4i37prZoAdiVq7QkvNRa3z2qkjThdw/XGStmzkoBVd30swDnHGPqWB2+H/V+TEQKnnqYZvAUunVU6TQHBj7jGRinmwsxZKYZJtoQjhNaKcRrviD1BBepbxeq382rfNXbZ9xFxzYjJFcKwCQayeqojFyliN3Ik/w/uCeA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zp+rJrSN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wObCihP1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfZIe010983;
	Tue, 4 Feb 2025 12:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FtaNzOx5hB2a43pTrcPVMW7XGddsgb2q4iQIuJjK/bg=; b=
	Zp+rJrSNw7ua6edNrPwOgjCWVsMgWJSwEqba0zS2j/rE/OsICGV1fHsHtcVwR0iF
	JWbSoYEHDN7Hd2EhqrpP/EGhua2BicAE5IsVQh3CVOa0b6nsb5jQ+exlqKEuIPZe
	1nRFI1Yero0obN+pfGjyZcEINW1V2ospWNtyAxetENycJ0B8mAbk5VMyXwpF8VWQ
	iFHEid0PrpaN/p9mwFPFJ5rZzVUMshy6r5JWz9XuNw8tNQPmpKDAq7x22sF0mc48
	l2Gq1N30YYciWqOiOGPlol7yGyUXfgxZ1phx+7jxU+EWv0Xejpy0psOiPhpCU5tG
	iUR6hBLAOEY3SO/NNplvQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgvruj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514Bl2DZ036260;
	Tue, 4 Feb 2025 12:01:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fm3ykg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYIiiFC1y6u5fv+Hi5ueJq0uoAn4TN/8WfxtEV/Tp8NwGKOctnAB6oCOi9QAmgbI+1uiVautmv8I4nSNpiupHdkGmnhoQ602r0soSLOjTGoSDU7ILDti5fD1kqYfgLEGQjo3CfL/XwwJRYEETonmMYvlO6Q49aK3WucS2uZsnwd8yoyOg2cqqqxKL/SnkOlUhKEJ3aC32ye5mT6QbsoqACcM5LNOQQeSRy7H84aNUqrMAKvAGp4Mopeb9C6fa8rEN134ODrGI9Q67JfqAcGh831/lNzMdnhw9G4spJ3XX8muip0B0/wrgxDTiyzX/5e6eW1QUhNSOiMqUnwtpLG10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtaNzOx5hB2a43pTrcPVMW7XGddsgb2q4iQIuJjK/bg=;
 b=YK68bkTgWjquC89gx177h2KAuejMm/DE2cVifrxCLakOy3HvrXadi7j5HNuu97XNCGSrYlSROnNraFiB7PXL+QaNkfXCOHumBVD8a//WswL5Y7IEBDqceqlFr0A8re6l3acq8nai4XHbL3FK05AXLF0lI8NzpgxP41+jGPmoLLBXGzCnt5TpRmk9jdPrw67saOULCGwISQ+d70A2FYlJk+GXLGV6vGhTbZewWe3T0yFtkmASnPFLQTpMpW5x9CzUnGNV44pEQAW8zwoXhMW6KqQibJhVeV+veTR+mv64hn1BaBrthtB75MO5efNVu+V7II/0t74JaipYb8jpz3oLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtaNzOx5hB2a43pTrcPVMW7XGddsgb2q4iQIuJjK/bg=;
 b=wObCihP1J7zK4d65Y9Wdv0CnrsgQnz2yvD8kD2WRIvhdAw2ZmFpWqffiILquhFcs05osJ0TDRlHjCdZN1aX7zniuJW7dTs4Znin9nXYcVTirizCxNg4fSW6GSq31ztWTF/vxTw1ytDm5nwmKoAwpc0Hm6r43pO9tznjo8dWKjAI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 07/10] xfs: Add xfs_file_dio_write_atomic()
Date: Tue,  4 Feb 2025 12:01:24 +0000
Message-Id: <20250204120127.2396727-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250204120127.2396727-1-john.g.garry@oracle.com>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:408:94::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d484300-a2da-460b-4663-08dd4513b5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?slZobAw70O10TZVbzcTVyvHGUlRe/0VpLgisjeV5VtnYhrxxDFGbx0hiGbK/?=
 =?us-ascii?Q?Rq7hFfvereIkt1fpqWm2OWysE3WsnSnbXMa/ijCiBYyTtIio/NAPAxiP14Fl?=
 =?us-ascii?Q?sjkVOO8331E9lWhUjCosfxGF5zAmKkIz5gBF1uOkXdrlm8bJwJ74W6CWRUKO?=
 =?us-ascii?Q?vuPufjZPLx0+otGXQ4pJUnT4bqWGIPPE6o0Xg+d0cKTovdXNwBCO/tohsk9q?=
 =?us-ascii?Q?c+NpQ639yD8VzwXf2lwsM0pBHH2yKgTD39FHWGQOXTzmBlSpiwydYP5gzrYW?=
 =?us-ascii?Q?HE0kaSSBTbfFxRhF1Re6A37SDD9cydcd7BFDlqkT51ABvzbWI3JK5sFXkLzd?=
 =?us-ascii?Q?0PzEmsOIRu783EkQO8OKlrF2+pwtUWYWOySL8/lqGJM+xJCVXPVbKOJKpyrf?=
 =?us-ascii?Q?hlWxh1RfxcWPHKn/oEyZnWvhZpusnLf0Ti4SsBxyQcEwkBMFAa6mI5CO1YGc?=
 =?us-ascii?Q?EinETFj8cmeUQhGjcLb5YCG0sPccD8S3bid2WckiNPG4bv2EjqOXvi4Utg3K?=
 =?us-ascii?Q?SqhZ4sIZtXqM02CtdKkGGUTu6Mky4nvPVnQwyP/394rcgom6ajo7y+h0V/7R?=
 =?us-ascii?Q?QNx76sp8ESVZkvk5C9XQNEubaY1/TBpg9/9M6sgi5nR8IIi4uM8bLALuEROv?=
 =?us-ascii?Q?9NQv1YL7AOnOiqOmBppMOWFoP+DVFIRQi/RhoB3ZRv8lWlzIvi1nn7Bxjofb?=
 =?us-ascii?Q?fx5v8aw0XEL314pI5gQnIrUpVvZRuH+3Ktlonc1x5nwEXbYfy/bbFt3NPsHt?=
 =?us-ascii?Q?SFVTWKezOcTOcFzGemFtHwiPgItedsAh8eEediZn7MCqJDhHanfKb2iaJAs0?=
 =?us-ascii?Q?gVUY+xGZSKG6oauHVVqrzX+QYCYzI8DqhXpnbcv5wfjNukb6G5CikT2+8yGU?=
 =?us-ascii?Q?ODCLAMs7+S0+1/s8YPorA5MiIC8VXfh3SPLaktEKsZQwQrIDrOH1CCCtnbLv?=
 =?us-ascii?Q?s1aYcDnMyQo2hJWcLGtep5QzfKtC+yVUr8svpnl3P3eSHwSUnXzGVQc74AkF?=
 =?us-ascii?Q?H6CT2jlwdxd/VtCJrN35NY1N5Xptrn2/a36zmf1mbxiqz6NGd1zIwGjVa1Hj?=
 =?us-ascii?Q?PNyMa+tDq0hsgU5qWXr2kvfiq7MpFUn4ARsWAVEaHQveO4R5zSXt3byupaP4?=
 =?us-ascii?Q?ld8oRNRmG5PGktANHovbT7ag9nUK6AGx2VzSiGvwug1n44h8GSJf1/6rrShh?=
 =?us-ascii?Q?Pv+dwGYkiOkhtL+2hI3Y3CSusnXF/VJ0DAKVBP/f27gSdTK88/DaQfsmGwks?=
 =?us-ascii?Q?gop6ZoaDT1daxykcz9dC9Cf6C/g1qHzcnhpI0solbG6UJoIJgNE3rmKgJxia?=
 =?us-ascii?Q?PV29Fny7HmC8oemee/Sj+LjaGD0kUKHhyqcczz/WAmSJSuMPJkJzUSYNX2u7?=
 =?us-ascii?Q?5iRMe8SBlLt0EC5/N6QzB0yFhn/d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?njQGcaNrqoL677Shv5ZyJmQmX1MXygmQlCh7Y2u3+nlH/SKtjigTQmX3+86Z?=
 =?us-ascii?Q?70FqpXD6uTk09P6XPs6G0aaBUD8rvOFsGoyZ+y4J1xPlEIUsiXFPrPLoe1qn?=
 =?us-ascii?Q?73oFJKCnfc/s5juoKDwEANu6KAOxGA/6vmP0AU9r2LiJ9sLxOsYBiJCOeF9m?=
 =?us-ascii?Q?Ly4+Ut6mqlRTBNKXjUDbdPHTVGLDT7NvQZ6tY6Rl+ip71WNcKXxVdwViZOI4?=
 =?us-ascii?Q?F6SqAsZknihyxh7KYVbAPIA4qWXp3g++WjW3HwBwK32WDeQXSr35nORkUz6g?=
 =?us-ascii?Q?QZtnL+UZGSxftS77H/sCLyR1D1ETX1vkpr9XroiFL6j90EPclHXTgVT/5QSb?=
 =?us-ascii?Q?JGmb/uSuOQb5kB40xiGIDlmuBaTvuZyJIyn4UoakDnTVJyJF3L9ojnSSy5ow?=
 =?us-ascii?Q?RQm/kvPnnYrOtit5Etj6q399KBBf7qsurI76ukRcQ4f9lghyNx3+9jZTmcJK?=
 =?us-ascii?Q?Jt5Dlx60vRx+EbyekDTLyy/crY75KEyrfO3pbYjJabCeO3R0ZZeDOI2JX+d6?=
 =?us-ascii?Q?zn8L/jykyr2gBwDeX1oDM+/vrjpnK5JN9H6Zo/Hfk6M2HyBz5AaWcBwADK+P?=
 =?us-ascii?Q?deBN5SNFyZY58RnpZpwqCva4ym3wdERMFAvu9Y/oPOg2CJaHgLll0SFEw2HZ?=
 =?us-ascii?Q?cdDs88mxDnRthkMapYqCS/eJPllyuLm9pE/+nO4b1vtN84hNUYk1xV8bhSBH?=
 =?us-ascii?Q?6Szyj8XqoIPFzDV5T/tUU/r7ZfmVb4ioEDUYRqWuimAAVdf817ICPGE1gfpE?=
 =?us-ascii?Q?imKbMvSXR3wULL+mmxexxxQy+pmCqTuFA9t6O6P5zuGoAA1YocGZEr2/Rmw1?=
 =?us-ascii?Q?Y4mJlaWafABRhX52m9zS8/Q2k2ES+T+Wyl8NkRZl7AwjUCfFBEAWGsuO/pCw?=
 =?us-ascii?Q?EchgswPeBCOJUB0ZWjjnMtbD+FOCcdtPiRn/eNrjd3RALvniPrp2SfS2kiqp?=
 =?us-ascii?Q?baHb7VMwtjuNazRACzV7an3YxS+MZYilfyi/XRC6D+Rl8Acm/LzUTqgKkzIR?=
 =?us-ascii?Q?wnEqbqXVWRk4NnFBjTHyNP4oZldOSb3MZ7G2BgvnTQfawOXs3pYN1uy25JCj?=
 =?us-ascii?Q?Zn1JoFKz8MZq/KcEAizacalOnpV3SxBN+u/cLxTlmmt5yTNH8nlmlwZcLIj9?=
 =?us-ascii?Q?Gw2Yo0hijLQVHicGKy8u5PQ1KKEftM3gIkci0bU9MPpyLEhgPk3rUzaRlRTY?=
 =?us-ascii?Q?paj8Te6LnrQcTpHGndr/eicf/c0OAvJEyg4GtC8L52P4fFkKI7mYkURBw1zA?=
 =?us-ascii?Q?QxajdgUG80mDcIKcStHWbI4qq4gbm58QOecDxSDIrpLR2hPXRveb9QPMEDvW?=
 =?us-ascii?Q?NewcrI1PvcrMCBypW5dwYQWg+HWFpDVm1FoqvlV7xrvh/lgtptuN770nDLWE?=
 =?us-ascii?Q?aVkYuxg4UwWY6hm4AgjD74QZ99KuMDq8XXpuP1nbQ2HAS0yUKUXnXhm5jlze?=
 =?us-ascii?Q?BS0dBi6JOwiyfrE/BjCAteCl3IpM/ygHn8eSbIKleUJgikfcyUnu7czfRZjd?=
 =?us-ascii?Q?EZ3/tt2PhszyOP3ns359pJ2W7n8Q7tdMMp/fxg3hMFw2zeiuBDR9pIbYuFyy?=
 =?us-ascii?Q?oQr4+dPgDOexdaDwaSONdeSLpqwhwNXMb2uaa38QxB0cLfH6a9qEGMx50rAh?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/tSPrg/13HMy3BTgcVzUqM3iqAHo04GVgat0ZTtbfNA4cU9OSzYRK4MonYLqbLKzrMJhU7Aq0QtoWpTBHR6FasT8wBCRi8g6NufaeQGqVGjVYUkVbw2cRhelLWL2hpLQPaUcWqgGQgZ/+ENVqBEUG7SgSGbb+tEKM+96Jsb3zJb3aZZ5zI0tfjXCWOHarqu0aPDI82auRGBjbOZfeoG7BpYhMAgvedmP/BKQXcfHYvQijK1KK3NYh0B0e+xe5SNMKahyATcnH5YZ9BOHvAysTNLkYWeWJQJbGY2I4qDrmKLnj/LQ7CTdxgk2hEJ2U6j8EFEAmgRkMvjk/WJcoXNeukMIll2gWTtqwgHTIFc8Bk+S1aXZwpf5dXMc5rM6jC6vs73TTNCC8shDN0+pc9QHfI+CWvBzRt0Z9M4GtA4uBMnFHOx2AFx1gB5vpQK99wAlB9HTDemyCN6KqUNIBbfwT0nr8X83LwxSZJLDXIPHEeJRzIcxcAFQw1/fmK4Yl1ABZ4C72BJT1sLiKpewyznx335NRgumrNoXUZqtGKfuClv9q8H8JixU+xZ5x2ULrjJH3B03j7ZWBVqSk76/l+j2wasUxtoVs0QVhvEgeyl7P78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d484300-a2da-460b-4663-08dd4513b5fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:51.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgwDLeas0N8syyEmRgzHII3aUlY9YfEZqW3ndXnZZrNVd1I0kUFcXtE2+00ZPEZTFdTUKAhXBOIwF3APtBA8DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: qLOOAsXqnByv2yYATef9Di_hmmR6clgN
X-Proofpoint-ORIG-GUID: qLOOAsXqnByv2yYATef9Di_hmmR6clgN

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
in CoW-based atomic write mode.

In the CoW-based atomic write mode, first unshare blocks so that we don't
have a cow fork for the data in the range which we are writing.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index fd05b66aea3f..12af5cdc3094 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -619,6 +619,55 @@ xfs_file_dio_write_aligned(
 	return ret;
 }
 
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	bool			use_cow = false;
+	unsigned int		dio_flags;
+	ssize_t			ret;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock);
+	if (ret)
+		goto out_unlock;
+
+	if (use_cow) {
+		ret = xfs_reflink_unshare(ip, iocb->ki_pos,
+			iov_iter_count(from));
+		if (ret)
+			goto out_unlock;
+	}
+
+	trace_xfs_file_direct_write(iocb, from);
+	if (use_cow)
+		dio_flags = IOMAP_DIO_ATOMIC_COW;
+	else
+		dio_flags = 0;
+
+	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
+			&xfs_dio_write_ops, dio_flags, NULL, 0);
+
+	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) && !use_cow) {
+		xfs_iunlock(ip, iolock);
+		iolock = XFS_IOLOCK_EXCL;
+		use_cow = true;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -723,6 +772,8 @@ xfs_file_dio_write(
 		return -EINVAL;
 	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from);
 }
 
-- 
2.31.1


