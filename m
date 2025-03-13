Return-Path: <linux-fsdevel+bounces-43922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC23A5FD3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEFF17CF34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D144326AAAB;
	Thu, 13 Mar 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="La1itkLz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zalei3FR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75026A0DF;
	Thu, 13 Mar 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886026; cv=fail; b=WhpYWZa8lJ8PidXruvrYxH+TK7eTDFEtuLPWpT4tY5XOR05q0nc/MO++mqa4K7+nq53ob8zWb2LGXpKHKSPUh/BOgjovN31RDXl0AP/qTsZjQHxyO4E9O/e/1Kx+P/7srtJOu1AaeVLoyFqtYgEam7YlOXXUX4GFfDYST2RAf78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886026; c=relaxed/simple;
	bh=vV6Kl5b3BUXlhiiruF3MW0lRr4GiMmTSPTgbggHIWr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Upav/P0n+0O11cfQ15DEn5I6XsTlQMhDfbboXoZxn/ck7NIFphJA7QMtjTSVdqMy12rdkz4q6Hut93cqjrQEItKROGPNn2b5FU30Ug+PjH0/AOGhEroYkC+KImlkuf3gwQbxwcqWDSQ1NrdLSyOlvybcSClzYzuJzk3e7hduWpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=La1itkLz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zalei3FR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtnUo031899;
	Thu, 13 Mar 2025 17:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6yjabLRQQFPrG6RS8LR4dvsaZaxTptqpFHA/zqEtTEI=; b=
	La1itkLz/RJWjuKj/xFxBw2nK1tPoxEvLFXD5QzCDY/sQg0nGLLqFu7eGSITtgwh
	XhSscP+u+EhLW87du0utiovS63VTb6zydHzzVQ5eQ6ppSQVYt32o1KXehQcO8B0c
	sC4W9gUY4aLoTUuLUcpQmmJE9uuw52vqTXZyrhQDqjlWN5etBuCKV0XQlkbLmrwv
	W1dMLM6IflzQdMqlRb5c8xDjAeywvAMgU+U+lGKWVhwq/0wpvAxWM9tJbRsfH4IP
	NdcU3JXxwEmg5OgHRmkt09w8WGBwOpqvsHDb2Q+IK1gG69pkB0n4gRc3U/ut/zrL
	S2uXsk4NBH/L83wivgrWaw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4hcsdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGhBS4022290;
	Thu, 13 Mar 2025 17:13:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atmwwrhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcTs2oeJGUfpvgPFPc52LH9+5oPSE1TInQ+FJ/H8nE61kqlh3s6NJhm6hNai9OeMihQd+yao8Xld/kYqCa8ojq6YSWw+xiZhfgNZbAjWJFp8XBsRx1049l3CDao1QtBBz73kPQEtimseI3otC1KFsGCSvA8O8uUL/c1fNS39tY129vPlXSHbLthsdq51K4/3Gusm2WLdSMrNsbcXQrgsaaq0rCaCfiTrcgE+Qjkb+6Q96G9zkxuZ0eHoBCC6IQ9KPJwo6P++MXlJmPvGYVZiJJix/4PdCs++ZelitKHYmooyNixAcF2albIj8tc4Y6VhMWqewD8q+dswkOEHkttBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yjabLRQQFPrG6RS8LR4dvsaZaxTptqpFHA/zqEtTEI=;
 b=A/eojDDADH5xx0TMocQwBSFeC5qwSXfFVzFYjDIix4d/xZI9Jm1KNCGUfgJk7Ce4fM1F1jrveXygP/9GqigSbCECYz+RzClKkL9EI+iRlH5tMN4ptJeF/OQvqrSQGN1Bk6PIbw4dUhFMfob7OV4GDtVvjTPAqoQ3Csz5XfmXxUzyWIENnJL+kjvBhPkZvptE8lQqyY949+BN23qNmtW7OrFtvJj4y+RT7l4mvjr93jzX3SeW+F4COU5B2tZ7kTaDC2vh26e24+IZbsAI8saiZeo42YWHNhjV5ir0i6vNoj2fK2KcGNHBfPKMrdP1/kpyoDZbGKmxwoEsxMtCZhU4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yjabLRQQFPrG6RS8LR4dvsaZaxTptqpFHA/zqEtTEI=;
 b=zalei3FRZ0aViqATjlSl2DI8KI2V+1NbYQMeSIDXuUhcNbQTSR8DPbKV1w8kvTsXL+0S6PzWrgu4sQlTDVV9l2G+kVv2zP7PE2it0lw9JDnXXOuOqussvKT4nypeE4dCXLf6lHR+n/l5UYgracZmIikQCpeE9jyxPD6iDnD/Xyo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 17:13:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:28 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 02/13] iomap: comment on atomic write checks in iomap_dio_bio_iter()
Date: Thu, 13 Mar 2025 17:12:59 +0000
Message-Id: <20250313171310.1886394-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0358.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddecaec-d936-4b4c-6412-08dd62525f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hpepQq6lKt9gpt5HDqjxBxea4swUTwG3Fj/Vl2PsbTgoC+z3MPe0zSTrpyBs?=
 =?us-ascii?Q?OxYEZopXdcaCvMx0Y3VZzvy/qZkLuMVXywldj/WVip4tODGFPMIMuW6pfeIi?=
 =?us-ascii?Q?sxGu07CWyauPoxPJXn+VFychKtX9ybSqoVEpqNyJwG5JvDeGP4tXyWbz5lDB?=
 =?us-ascii?Q?ZBFpD49+Iyi3yIO4cVmlIPZiY7aqAP4irVSjP1s6fNRhrMKgKlf2kqqiJWKg?=
 =?us-ascii?Q?M7wIrMOephqfUCduEPFW7itEy5cpuS/30jjrs/HyuDA3GpiLBpemi7G/37IS?=
 =?us-ascii?Q?hTTXxUCqGTlhU9vS34UVu4TVDBOAVOW3nek1ULkqs/iWlsNzqD8IHqwecv2x?=
 =?us-ascii?Q?5cTI8mvdwERB8gDccL4hPveUh60CyGbuZKReMmuPAWAEJMzir/1Sk816kAI6?=
 =?us-ascii?Q?iqPb00SaoAhh/yh3EX049Wf2ztQX+u6ELyTe17KtLsa4/rwNQP7UR47+FGFj?=
 =?us-ascii?Q?juuWsQj910TIaCCQ47QNNYLEQRohFyS8a/ghpnmk+Wp+cnNP8rpntr8/G45B?=
 =?us-ascii?Q?N3RZwPS1NHbhcf6Z7h97PX5R9/HuI50CsO/LFEN1BeOinB71OQYuiVwt88zu?=
 =?us-ascii?Q?alvw8dwKHJEO+sCrSmETOtQX25+KpZ4A8fmfiGGF3WEzSh5U3TfltQl9k0zj?=
 =?us-ascii?Q?YxKEk8jLDqvWg6vAid/eN35p7EU2RxTXCjrYkRGtMKv1KWxvNzIMjF565PB6?=
 =?us-ascii?Q?imXTzt/37gXQxQZR1+2yo424rrFhIt7nPo/I617g1CeCBZunN1JVZinegGeG?=
 =?us-ascii?Q?m/XrVBGxtyZpj2TP1IPl1xZEzq/8maxfh4OvGFNoz5G9EJjwkhO27XXoq6Ky?=
 =?us-ascii?Q?Xyz7XZ5PwPdyNT5C1NDEo13hFK7WM+9dEBzJjtf+8ZGDJ+k5RRYp0db1iqO1?=
 =?us-ascii?Q?nSx2oicvSbqK+jw2IkyHXwiDu9ef5AWmAcS/u9/1sGpFSg3BD+4gOFp2L/M+?=
 =?us-ascii?Q?Aub8a3szGA6NdDgb7jSK6Z1hLhSJ/idNaDPvnX+T8WO6+YiXP7axHJarpd9b?=
 =?us-ascii?Q?ict8fTZMk0g8sDmJO0IjihdLFtexGplhEuhesm77V+9HVBi1+677ARgV7rWO?=
 =?us-ascii?Q?Uv7v2mSxpYjoSjBYaNzSyxQwttTGNp2DRW+z/ZMagZ76rbxMG9YgUTXvbm2t?=
 =?us-ascii?Q?AkoBYMxR7RmiU7gPz1hZ5kub5NgPpbPihIgiue09g9LXtzn9jKMlJls5Fr9I?=
 =?us-ascii?Q?pUAmDAt5qXDCPKnXDglX4C8kaKUSEcBRAwRg7pzvGieM3SlpdtrrdTnba0OB?=
 =?us-ascii?Q?HhjbhhmEfpeGeayXJ+8wbt+qgyfXY4h6UzlpjR4KN2n9ci8K1Sr9+ONgqdCJ?=
 =?us-ascii?Q?WSa9rU5DvzjPO59ENzhxhyxOffc+pReL8PrABQKtaTQG0I0eT8OGoFFTJxcj?=
 =?us-ascii?Q?vb6Pr3JD3HzHYdqedMWAfcM2qmce?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UdLaPMkMdIFZHPr0y9Xq+YVQ731u25wWE7wIFcExWZgjoPN/bRogHvRsa7l8?=
 =?us-ascii?Q?h8JQlR8GjIPrQePvjGh3bw6aHrFbyr9jeuyriWWcHvtbmrgMzqXzhaELpGtM?=
 =?us-ascii?Q?72m21llL6Xr746iVsU48tpIEiN7xXobwggO/GUdf7aox8fRhcBB+qYNERZtx?=
 =?us-ascii?Q?75M8K8aZ1FYMApJiCQKoWEEkrQu+uzuwAjWq/LCxRyL2pCiSO6mlw4hbeJyv?=
 =?us-ascii?Q?MSKVqvWEC45PwzvPIpbUcfrJw0OfxVgHPuaSElKRwLddSpSYfi+otzJD7Suq?=
 =?us-ascii?Q?QQKiD4p/SaTRxUmfAUpBCcurPAFX6HS/qht9+zKNvFjJ1LmnomGkhDTj+sC2?=
 =?us-ascii?Q?DjNa49A4LH/NLkbHndaXYNvaS3sp8biVUjv/3dxbkgdgcpe6bV6jJEKQmMbl?=
 =?us-ascii?Q?DEgkbXlCn5J8XRL5hrv25KKikRNDmJkCIA+n3Cms1fmWGjkON3iRd38ZtClH?=
 =?us-ascii?Q?epbwYzzaiIGMnHByxuJIfjA3hLsPHinCYwAuAfZtUJyAvNHFDXkQTyQca6yh?=
 =?us-ascii?Q?iyq/ZjPEt/lxuzTHINqmAGUpLoZm7AN35yi052QrgQqXYKHcvsKLjUNpv6Yb?=
 =?us-ascii?Q?6kffAVMPX+MbP74tzt8CkZILahLanwuLM2pERj87RimE96YGexOEjQfEg3cu?=
 =?us-ascii?Q?xs1KLmV1cM5MMpC5ATpxou9+5XCpTC4VjhbTSjrR5DGSArigzQwAf3AWLljq?=
 =?us-ascii?Q?wtVy63BekNwfnycUGLsrkd8q/JZP6L0xOkvtGfBzGYaYuOG/W4fCpV4wcbHa?=
 =?us-ascii?Q?bWcYbqeKTmSvGnL1u1MLsA1lWqK8jvvWZ9F3W1I/U0lffn6ZArlmdyfThPwM?=
 =?us-ascii?Q?m2lNeJGDU/R8f1RFpujBz6Ywaf8M4gsRRdtB+OB7z2NTKDffR1AtN/9D4hs6?=
 =?us-ascii?Q?Wgr7utr58kNLGz7t6mg5kyeFx/W9oCO7RHs0d7tKUfRgiEkXkhccJXZOmIeo?=
 =?us-ascii?Q?PRqzTI8vaPjXyNncwgzwwAYbFzHFv+aNNLxFOzkEb531Zt/KfjZjePh0dfRW?=
 =?us-ascii?Q?PcqaAsosyHTLT9pD4tqTAmijJ+wQ9TpGaQz5ZSuwtrODCk0SgwPAeKvg8LCa?=
 =?us-ascii?Q?vVQlkL4DMxV3o30aNdZPLv9tjeKeq+QGrlzHdevmTxhN6CB+uiUtqXj0ujLN?=
 =?us-ascii?Q?rwGZlweIovv45Hf8FTQWjMjOQf77Qydnnrkmw69Ss5Pou0d6LPNr6791yYBz?=
 =?us-ascii?Q?NRwXq6GQ58Fq9Y0oHdIV00ZflbX6tyTEM8BIJOm1cBl8mVMXADFTh8ey/GQA?=
 =?us-ascii?Q?9Tg1gwN8P0/PtjJAoiv6vZy5ULGNnny2Pmj+8E+JsLtUIqhh6b7PTTBXggdc?=
 =?us-ascii?Q?P7dUX5NoTyaMdKY9eAzzkr5jrult/j+wJ57weLrW2Vb5Hd2MqVpoYNMf0hWg?=
 =?us-ascii?Q?HrleG9l0zndr3K6NNnTNWKtQUr0Kz5KBe2ET/JiYxH4lIO6VteR7g+lo3NJc?=
 =?us-ascii?Q?VZ6ePKw2qHmMxplF3hjd2D7uQ0vGr1Y1jcXvuw5kOJgsturxdMRCyQaLt3R8?=
 =?us-ascii?Q?Qb1zWgKcVq9r3XOb1O5utikqcPulh96sNTfk2OAySflxTI0QE8/NcwCcrOUT?=
 =?us-ascii?Q?24rnu2h6J51ZIeCLZb20SoS5nANWBr3q+aW91CkpthY1IF8ecByEmlJFwsaw?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8zcr25nZP2pe78vPAM6+SoP3fcHJANFqh9qq56ZZ43rH/gtPJkT88uVzSKLZQkf3o6rPpxReJENNLEmV8fG/eCRpQj0SWpjYvsM+UIABDFuPE/JpBmRpCSMRypZJr+nnWJph48K3DOPWf//3j+kwJEB04QFAMZGU8nUtuHaw27X+JSAtvWgTbcLUuNWGsw0F9p3ZaraZ0zeVG71MODGnV3stSX4nW4+UZem3Vr70Bw8VRKNVhne7fQLaBRkvyRBPKa2odioMaoGtQsUuO+IROALjUFIi+oCKl1cErXs7paG0seWl3riyrjlyBpMgI2MQdH8tWRU5BXpYr3E9q1NZFGqqFYKYUeYnLbfjCYDHizHI4bNonnbD5g4MiTsON2bOBYfSqDL5EhEx8/ITMzet6xSrwjNCCPqUkw4SAjhP5/o1ZDfRGXibOssXPmW2i8ON9QJOuI87kBeMHlOH18guROKOodS9Jgps9gp5pEAGt9a/384er3/G3DgFbuPCCBcKNXJCRB+24S+mneHhhgReLd76zxoU80FDYW3mIPOUvJz6Shyk/nII7+l8Dd2F1h1Kjh1/y6ZcXBntrBt0nVtfU3yjnYk/kH4wmU1UqrV7stA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddecaec-d936-4b4c-6412-08dd62525f34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:28.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8cbfzQYse4SyHrBvL/76xJsF8X897ejwXuT+00kHbjwhJTTXv9iq/D1JXzmFuk/6TNgnpwuajkX3HakA3m9Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503130131
X-Proofpoint-GUID: L1jtJZvSG884QIiXZ-zD2wdtBAQfzCJ8
X-Proofpoint-ORIG-GUID: L1jtJZvSG884QIiXZ-zD2wdtBAQfzCJ8

Help explain the code.

Also clarify the comment for bio size check.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8c1bec473586..9d72b99cb447 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -350,6 +350,11 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		bio_opf |= REQ_OP_WRITE;
 
 		if (iter->flags & IOMAP_ATOMIC_HW) {
+			/*
+			* Ensure that the mapping covers the full write length,
+			* otherwise we will submit multiple BIOs, which is
+			* disallowed.
+			*/
 			if (length != iter->len)
 				return -EINVAL;
 			bio_opf |= REQ_ATOMIC;
@@ -449,7 +454,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		n = bio->bi_iter.bi_size;
 		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
 			/*
-			 * This bio should have covered the complete length,
+			 * An atomic write bio must cover the complete length,
 			 * which it doesn't, so error. We may need to zero out
 			 * the tail (complete FS block), similar to when
 			 * bio_iov_iter_get_pages() returns an error, above.
-- 
2.31.1


