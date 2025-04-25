Return-Path: <linux-fsdevel+bounces-47395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989FA9CED7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8134E2763
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899320E003;
	Fri, 25 Apr 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T18a4TOK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lVvX7cRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107941A9B48;
	Fri, 25 Apr 2025 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599723; cv=fail; b=cxuD2poHvbea72G8JP1jLZGSoyLaQZXIdQ9wc+TzaKwE6anGFMM8RlS2pZmh8gbSzaipuaWLoCFWzElfTQLZh+PStSqciVMIIGakbZn1zXrIbJwO/hPHinYsaIAypHjiXpLlxTUewCZRSEaDSV1e8uwP4rJWx0cs1EXOMmWDTUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599723; c=relaxed/simple;
	bh=/Gc9YxwkEPXlQwpTWBqIaTS+N0I2IhLUfDnljXWFgSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lL2BZ1FGtpsBKL0HKqlrSRSCLnvHEYmNe1wh2C5JOFLuTsx6vAq/RSun3QNX8pGsv1X9a3237l3mTpXKM6EPlB6LhAREPY1rmxpV3tOpQa7IkDtmP9TWtZTXDOV36MWY7BSCLq49Ux1fzPPYMaN2JYirfrSDHlVU6fPQLi8SuLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T18a4TOK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lVvX7cRh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFqV5h008417;
	Fri, 25 Apr 2025 16:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1DLzKEzxZWroZS79L7ym5z5u37TJWbokIXzfpxvotNA=; b=
	T18a4TOKQySMRP7l3nvXJYZDCtxafEdwOHi7jx15nl0mlRjB+emWWtufitEmNFQH
	c4HZ31C7HU/Ra/PUPEdReZ26jyZVpeN1hqp3IJBR7EqFtqvRC5LTAqsYnF89HL56
	rMEmvtR/x3TuyHgGFsjgc9FSwcsTJQSB4RvWaDh+QLwXNWw/7kq98x76wv0xcC8I
	nupFiztUJItuVma+hFkfIg922VxfrpJsNth5VmJVOb+J9UDkpx7DZZKqYlQg4frO
	LvR/pN1arpeWjYfgsW4kZ6prdmDgKTyl/5knO16sV8DBGl+euEBIcQYw9WgS7b4z
	D46OWkos2NRFUPmLn57KXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468d45r9ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PG8NQc030936;
	Fri, 25 Apr 2025 16:45:36 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013074.outbound.protection.outlook.com [40.93.1.74])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k08ves1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBEpBZoke6sb2/4X7Mn8FPg3+y56Wwcysp0fE7GeJw9k5/FTFvcpJiJ6AnMS8U8Hto2qceFT/VVX0prSH5bq9Lxlm+E1ThNbB7ztRudtni2Ov7hS2Z1CU68HM4cp06hLw3ShXLx21qwPZkCaZQyJ2iBM1eGyGbal4ePpRRnntCFifi8G6r42sKOBPxlY9VYqr2oszAVsov1Sd7cJdSmBGh0gSTVrnn42ZlWPgE/O576SqXy9REG+PNC/Q9iWARTcAj83twtmrCZ+MBsLkJj5MgAQErDR8V86Rec++Zxq3v/aSnuR/3hnO5YZJV1MEiYhc+nvBcg6zJ+FqF8mEPY/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DLzKEzxZWroZS79L7ym5z5u37TJWbokIXzfpxvotNA=;
 b=f81kDIfa5+sJl0jwB+yEAwAY8wxOB+wew2wkoZftibl4bO0Aa3uSUDJLBwb/4Bxy6S2GmEwwI+B9Z/DGi9eXDDqxsheEo5s/N0bJdm2MFYF4FicLNEFFFqw8wYvgxilJJYkxXj0SdzqH6I8j5qGqNrlI7bpftGS1fFXD9gtMU/BN833lJ80U6mU+dl2K6D3E8YT87TrwknoNjE8Yq6dksbT2jbF131KKjqz2l/QWLTat7BeW/lICBPgnL9P5+Zi9nkHmkjXhqjksc3QiPOWwygogMkOPGYJQRyNxyb+u12Sj3+yig6Vj2mlvpyTLGyskwnvdGBnwGKi7sOu+BAH3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DLzKEzxZWroZS79L7ym5z5u37TJWbokIXzfpxvotNA=;
 b=lVvX7cRh5xouXJ0nIK0swLuO3TfvAOn+Wn5r9FK7EZRboCQgPvvru5ewD5BcrOO3MOOsz6LmJ+o6BBE9aGj3/9KQRQ21CuN/jkBboEOqzaDvdkZOXZYQzV5ySCvHNsf01X3kK2fwc9bzfjsjONhhxi4/66J7Sb/3jyBUlDxojC0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:33 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 02/15] xfs: add helpers to compute log item overhead
Date: Fri, 25 Apr 2025 16:44:51 +0000
Message-Id: <20250425164504.3263637-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: 28783dd8-4309-4d30-6670-08dd8418988d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qTZx34BZktWGQM1Pi22v9MR0qMwwOc/FKh8QjKvQODxTYsAwFMJhQiA5DEtQ?=
 =?us-ascii?Q?VKxzblkAW33x2FZVtdF/Ay9zHjEyti1cE3ek3pAj4E3AIjT3wzWdLTBkXYyA?=
 =?us-ascii?Q?oKDoysvVgE1AGv6L/dHmxZamMCZNd+QDB7FR13uUOQP9iuSyjDv/POtg5b+6?=
 =?us-ascii?Q?QyfxLE8TCviYbBMzdlO2lATU9oUmsEeln3lhg7thjGPhOrLwYQY0kuxXNIMB?=
 =?us-ascii?Q?TlSqFTptM8TofIcDkWvoL2ULcjqjiEu7UIing7gkeH8m+2Cn9ln+6fwRp2va?=
 =?us-ascii?Q?AbTaQjT6m2qVovjBvXUcyW3CKlJSBra2UA+2pr0m5NFD8MNG01hYepceWyDB?=
 =?us-ascii?Q?zaJS/rvodbquOxuqP39f2mX071uRhH+CHph1oeJk/qSWrEmiisTWpIzlNRy0?=
 =?us-ascii?Q?UB82tNRwd0ba7mNm+Jr6OtiZoJBwN8I74S8EwSSxsCSvP2QXLYop8x39Wj5K?=
 =?us-ascii?Q?nnWqgAbKjUqp5Ar1n4kKQ6NJZGmmeeJDMQffp2GYAiupCO4WS9iWaTfmxQSP?=
 =?us-ascii?Q?AULWNTMH6/xjrC0/cXYFkyskB2HXdkumcumxxHMPgfLozR02UhMTe4UD5qcg?=
 =?us-ascii?Q?54ykFWnNhZL7oPgeF5aHRoVZoH0stClBUQwvMEoKKahBkNo8ntS8upYD6Vig?=
 =?us-ascii?Q?5c9NpWtz5LeNTPLLPjQMVr8dDLv7KPzwvdPalHgfYvBw7TlozI2PjsI7xAKH?=
 =?us-ascii?Q?J2h3m6WNI77dgHI2QDRYBkZsU0NnD9BupFPVFepme4hoSnQyDSMPAB3F6xu5?=
 =?us-ascii?Q?8+/SIeA5yJHEEKX6fdLmm1W0Gphksqjoy+aM5/yAJKb2x5wglXdzw6atkkb0?=
 =?us-ascii?Q?GPh/+F6WeNJ/p7T103HFIQaLWis/SwACgpJyLaiZ5gg2ADYrhJeesHHjYser?=
 =?us-ascii?Q?c8sbGA/TgfwhibasO4OzZX9ig3xZLzbrFxVG4XhnYczlXIPhKOstgDc3uMr3?=
 =?us-ascii?Q?kS5JbrMy56mjuVOcAgX38Fd4n9yjqrnsQE9K3GhrbL2avEP9hAZvP5AV/ivV?=
 =?us-ascii?Q?QxDQSDhwATTHakkOeWIhTyAXVjOvOz3R5gYHFmLXFn4L9LMD6SjrRV3l7K2W?=
 =?us-ascii?Q?3nQ6IZVO54IAjEZpNOEATYk1jknkK/Kxlkh1xYg7cdm+MxaxozMNsxmRjREJ?=
 =?us-ascii?Q?q6dVsaQoun9KMFqbLVCP8+UkKrhJOEfIQuO+SOzGVAiqXSbk03aWtb5OqR8Q?=
 =?us-ascii?Q?spN2MPMBT1ch1Spijl8HONG+FdAkyFWVeKqCl/cOHhpi2Sn6W5Vb54+muv9J?=
 =?us-ascii?Q?aYjRSK+9cHYtREVprdKJyngDvuz3Hbet11oXyKgTEpg5Mx36Fuzvz/LPnRty?=
 =?us-ascii?Q?KcNjt0H6QpK3rZlOh9rbBP3HBCnvRAgpGMNDtY1Nvk9xS0CD5HXmQh6NGOix?=
 =?us-ascii?Q?LtcK/KzBwoljlHa9RGrdkkTpipEafa119byZXSpp1ZDWs8Uj5yZKZ2WJwNtp?=
 =?us-ascii?Q?vdCJSalT/Og=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gPJmrRzrpe2OJmQ77oozkCT8RBkoMZwEVW6R8swq5Tc+O5+pq6UO0qvplILD?=
 =?us-ascii?Q?cZVfpzDk9LBt4v39Hkz/GTEa3w46PR9zctuQnuyAu0X+U4DcIPodDPu+l40A?=
 =?us-ascii?Q?KVTgAJyotbxvvyayQv9ls/rQyLpCMFhH0olIMk+VVsiRwndtLWFzABf/V6GM?=
 =?us-ascii?Q?9i1h8UziPwG4KnGJtOnRk+2wybgj2vGWzVf3x1hO9QF5sStZpGXOnJuZnjIg?=
 =?us-ascii?Q?ZIhj2jDc96FTq60BUvfWAlymBr2zKN0opczTYtTLxvQZm2hWu/moJV++o6hs?=
 =?us-ascii?Q?n0btnksgi7v367Krix7JvkHUFVvd2SlnrJPTwlae8c1keyL2JCYZx61z3YCL?=
 =?us-ascii?Q?v+zRmGVLzCB1Z936yxp1zPLJU1A+ZOV7E/h8G7Ni4cp5mujKS3vZFzmUv42B?=
 =?us-ascii?Q?YPegkESqEbjJoSP4F0/TqrVHhbwEeBAHeY/PZq5VpjA2APZA6P8BHhiwoYEi?=
 =?us-ascii?Q?3FaBq1AOJyRUSH++lXaG03c+qUKXzCwbt7QGeYutAcEzgrnizYYd9eCddCno?=
 =?us-ascii?Q?gOZL6NK89ONTjHR+41rUa6NpprXGeZ23hpViFLowIsAFv70aIKb2jVPfQ0sD?=
 =?us-ascii?Q?Cs7x+gFWpU9EO5UAm/HWZ+wYzUsuZhRsNrOMXZTa/QuNCIfjvvKnvJj/mlmX?=
 =?us-ascii?Q?cUtl+1qT/XULjI+z+pqcpmfxlTyoHNAXf23hMtR4vbT38WUkSZFpZKxFgyZn?=
 =?us-ascii?Q?bKlouRmDrdqfaiQTuTK9eV7N5fUZ2T9paFeer6+GUYiRPyOijRi0kC+PcTsB?=
 =?us-ascii?Q?t/VcSjD1CRH2mh5ScJI/Xaz1vQjEnyPxvTI7FKs0k6WP7E9ePMAyWdrwULJE?=
 =?us-ascii?Q?xyxToiF4+gqVXko/5XuQYZdQ8Qyi8curvsjJAdEqZ6edzQEtgczlH1GkTFQg?=
 =?us-ascii?Q?cMpAzkj5xYuU9F6VTKQJQn54tub/Mzx41YKuMtNIt2oTkgZ9ZXkEFnpWNB+M?=
 =?us-ascii?Q?rUlnaNRnr7d2gB/rFEYjoJ7AqKGa2P4ykKVda++iGqvZXZptWFLHiNCKG/4T?=
 =?us-ascii?Q?zzYGU5lhqDmKXWA3Xsnmj2OJhJbsw4qptJIXv8K7DfKV8IWxbfcvR0ZSENG4?=
 =?us-ascii?Q?c1fiWypR01IsqpSjYi1lccodauELnRVAFgjTWr9o11kfiRzdyckZN9k57co2?=
 =?us-ascii?Q?w+loj0YzfRn6R5C9O+1NAcJocn3dN1ah8i/qqHqyW4SQPVxrMbaLVEYLYlke?=
 =?us-ascii?Q?k/FECiOKzNLyqhbKTJFsc+l3tZhYoNMjlYiuUNdCx7xct5ZpeXVikqBypvTC?=
 =?us-ascii?Q?iBhzmER7hk0akmZ4YOwcF3s2mabI5+uZVAr7rBr2puF82Ff667WcfaIusrev?=
 =?us-ascii?Q?wBslCQA0uE0rNaslERKakXHl2W7lLbvHlszAbbt2i9uYUE2cYJ3Cq5y1op67?=
 =?us-ascii?Q?iUdbXr1H8AqgN/1FEMkDVHBz0KFoOnseLqR1tM1ysVJ0oX2pbpgnKDR3w0PF?=
 =?us-ascii?Q?QN7FTOc+BCiP0FdgfNLJixiatbE1go1JR9PhCpbDpdL4oSXdPLBnhCcmuFZ1?=
 =?us-ascii?Q?qBTdV3NtRLy1FGXrCLs6XaIFkE0+cujT718BWkD8UIpQqZBAsQwtTMTtauZH?=
 =?us-ascii?Q?pFaDoM1f7j7wrKLBMeRQl9mB5uGvRkEHEJx+9AZEuuCMTCweQa4d6/204ofC?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EmNNHq1jFajM118LMrCzuk9SCptv9F6nyLjeJXROaYPV6ern2AhMc6VKsIvlSqp2yiZjQd7P3n/c0OoQ1uydBktJcsetiChAaCi4886SftJgdswA9qaHyzrsxpAphwYCPDn2vN/aQzXdTNuovpwkNmFDEmzGBVj7A51XXUoLICTUuy+dQnBH3TsECDGzEEaaXcshnULJ8XHAeAfp2gggBVXqxQPMJIIM7uZdaJIcewIsuoGmPHcdLEP9y4Sxmxir4PUVud8LCpbAoO60VATcWoFx30qjJ/mjmkRleSRnG+1m0qDUjubF3Kohv1yvaY7jWMeGSAyDIzhnMGJl7PlrLV/6ErX9DyQEtFSU3V/VXoEmKZENJHFuXru9CFiuMCbirVMOGSFPcCgBOfGg6uaJ5/PKHjNWy/Dp78kKi2o0PqVM4US+UUL+PmpUSmfnL9dRpI4Uwbcr46/33M/l7TjEdXzM2b6SwuDfjDFE/JMEu5msFD/dF+vCy/Lyo72hzoF4bEeCwxr+fsYkLrDB5V5oJeL57s12xc29a4wWRCNf+9MR3HbcNWrqJdzwOvY9FXf9DE+owkCKXa0+HQOnOSIXIo6G+KcURDAR75tsiqk5kuc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28783dd8-4309-4d30-6670-08dd8418988d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:33.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6td3mrud68RvUidOTdV5HXBVlMQNcTJM1+4kQi8FFv4AjRTofkhVgPuOvZDKF+nmRyq4KbeGP0TbpgEIrGU9ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250118
X-Proofpoint-GUID: KTAOiScif-I8B5Ppa-U6k4rQ4BVetFEU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfXyphhwnSkQAOD fEu8iLAOdqRYKxv0U0QZ1ioKR5+UNRpdCl/0x18U2dJaxEORxsIk5pRACPwP3TTLLVrurcTvaCf HPWXICCMwSg/+oziCJq+zxeZoMxPkwSqfWMLVnND6INTdsiP01D6Biv34C/u6xKH/cPPYG4Si+P
 0siaU4uPV/jQpDMGsKWemN2mIiUnqJsgjJw1yxbmIr5VBQC5fUY9nBL1d2P6+qpGnoqzzXEHsMQ oAI4RTHkLsH5rFOfWpvPX7ofuCeq6AUTDYJakCQheDb55NN6K6u6mv3bTvZ1Vq5kmoU24gyriqH 3vDzuXphL8AzE2uCPCzYzUtF6bghwvEN2R9GcskMLIeAph0EXfjIsYi1aKzmBZ7uqOqLN6mmZr3 FF2WAABg
X-Proofpoint-ORIG-GUID: KTAOiScif-I8B5Ppa-U6k4rQ4BVetFEU

From: "Darrick J. Wong" <djwong@kernel.org>

Add selected helpers to estimate the transaction reservation required to
write various log intent and buffer items to the log.  These helpers
will be used by the online repair code for more precise estimations of
how much work can be done in a single transaction.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_bmap_item.h     |  3 +++
 fs/xfs/xfs_buf_item.c      | 19 +++++++++++++++++++
 fs/xfs/xfs_buf_item.h      |  3 +++
 fs/xfs/xfs_extfree_item.c  | 10 ++++++++++
 fs/xfs/xfs_extfree_item.h  |  3 +++
 fs/xfs/xfs_log_cil.c       |  4 +---
 fs/xfs/xfs_log_priv.h      | 13 +++++++++++++
 fs/xfs/xfs_refcount_item.c | 10 ++++++++++
 fs/xfs/xfs_refcount_item.h |  3 +++
 fs/xfs/xfs_rmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_rmap_item.h     |  3 +++
 12 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 3d52e9d7ad57..646c515ee355 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -77,6 +77,11 @@ xfs_bui_item_size(
 	*nbytes += xfs_bui_log_format_sizeof(buip->bui_format.bui_nextents);
 }
 
+unsigned int xfs_bui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_bui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bui log item. We use only 1 iovec, and we point that
@@ -168,6 +173,11 @@ xfs_bud_item_size(
 	*nbytes += sizeof(struct xfs_bud_log_format);
 }
 
+unsigned int xfs_bud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_bud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_bmap_item.h b/fs/xfs/xfs_bmap_item.h
index 6fee6a508343..b42fee06899d 100644
--- a/fs/xfs/xfs_bmap_item.h
+++ b/fs/xfs/xfs_bmap_item.h
@@ -72,4 +72,7 @@ struct xfs_bmap_intent;
 
 void xfs_bmap_defer_add(struct xfs_trans *tp, struct xfs_bmap_intent *bi);
 
+unsigned int xfs_bui_log_space(unsigned int nr);
+unsigned int xfs_bud_log_space(void);
+
 #endif	/* __XFS_BMAP_ITEM_H__ */
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 19eb0b7a3e58..90139e0f3271 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -103,6 +103,25 @@ xfs_buf_item_size_segment(
 	return;
 }
 
+/*
+ * Compute the worst case log item overhead for an invalidated buffer with the
+ * given map count and block size.
+ */
+unsigned int
+xfs_buf_inval_log_space(
+	unsigned int	map_count,
+	unsigned int	blocksize)
+{
+	unsigned int	chunks = DIV_ROUND_UP(blocksize, XFS_BLF_CHUNK);
+	unsigned int	bitmap_size = DIV_ROUND_UP(chunks, NBWORD);
+	unsigned int	ret =
+		offsetof(struct xfs_buf_log_format, blf_data_map) +
+			(bitmap_size * sizeof_field(struct xfs_buf_log_format,
+						    blf_data_map[0]));
+
+	return ret * map_count;
+}
+
 /*
  * Return the number of log iovecs and space needed to log the given buf log
  * item.
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 8cde85259a58..e10e324cd245 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -64,6 +64,9 @@ static inline void xfs_buf_dquot_iodone(struct xfs_buf *bp)
 void	xfs_buf_iodone(struct xfs_buf *);
 bool	xfs_buf_log_check_iovec(struct xfs_log_iovec *iovec);
 
+unsigned int xfs_buf_inval_log_space(unsigned int map_count,
+		unsigned int blocksize);
+
 extern struct kmem_cache	*xfs_buf_item_cache;
 
 #endif	/* __XFS_BUF_ITEM_H__ */
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 777438b853da..d574f5f639fa 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -83,6 +83,11 @@ xfs_efi_item_size(
 	*nbytes += xfs_efi_log_format_sizeof(efip->efi_format.efi_nextents);
 }
 
+unsigned int xfs_efi_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efi_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efi log item. We use only 1 iovec, and we point that
@@ -254,6 +259,11 @@ xfs_efd_item_size(
 	*nbytes += xfs_efd_log_format_sizeof(efdp->efd_format.efd_nextents);
 }
 
+unsigned int xfs_efd_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efd_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efd log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_extfree_item.h b/fs/xfs/xfs_extfree_item.h
index 41b7c4306079..c8402040410b 100644
--- a/fs/xfs/xfs_extfree_item.h
+++ b/fs/xfs/xfs_extfree_item.h
@@ -94,4 +94,7 @@ void xfs_extent_free_defer_add(struct xfs_trans *tp,
 		struct xfs_extent_free_item *xefi,
 		struct xfs_defer_pending **dfpp);
 
+unsigned int xfs_efi_log_space(unsigned int nr);
+unsigned int xfs_efd_log_space(unsigned int nr);
+
 #endif	/* __XFS_EXTFREE_ITEM_H__ */
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 1ca406ec1b40..f66d2d430e4f 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -309,9 +309,7 @@ xlog_cil_alloc_shadow_bufs(
 		 * Then round nbytes up to 64-bit alignment so that the initial
 		 * buffer alignment is easy to calculate and verify.
 		 */
-		nbytes += niovecs *
-			(sizeof(uint64_t) + sizeof(struct xlog_op_header));
-		nbytes = round_up(nbytes, sizeof(uint64_t));
+		nbytes = xlog_item_space(niovecs, nbytes);
 
 		/*
 		 * The data buffer needs to start 64-bit aligned, so round up
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index f3d78869e5e5..39a102cc1b43 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -698,4 +698,17 @@ xlog_kvmalloc(
 	return p;
 }
 
+/*
+ * Given a count of iovecs and space for a log item, compute the space we need
+ * in the log to store that data plus the log headers.
+ */
+static inline unsigned int
+xlog_item_space(
+	unsigned int	niovecs,
+	unsigned int	nbytes)
+{
+	nbytes += niovecs * (sizeof(uint64_t) + sizeof(struct xlog_op_header));
+	return round_up(nbytes, sizeof(uint64_t));
+}
+
 #endif	/* __XFS_LOG_PRIV_H__ */
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index fe2d7aab8554..076501123d89 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -78,6 +78,11 @@ xfs_cui_item_size(
 	*nbytes += xfs_cui_log_format_sizeof(cuip->cui_format.cui_nextents);
 }
 
+unsigned int xfs_cui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_cui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cui log item. We use only 1 iovec, and we point that
@@ -179,6 +184,11 @@ xfs_cud_item_size(
 	*nbytes += sizeof(struct xfs_cud_log_format);
 }
 
+unsigned int xfs_cud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_cud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_refcount_item.h b/fs/xfs/xfs_refcount_item.h
index bfee8f30c63c..0fc3f493342b 100644
--- a/fs/xfs/xfs_refcount_item.h
+++ b/fs/xfs/xfs_refcount_item.h
@@ -76,4 +76,7 @@ struct xfs_refcount_intent;
 void xfs_refcount_defer_add(struct xfs_trans *tp,
 		struct xfs_refcount_intent *ri);
 
+unsigned int xfs_cui_log_space(unsigned int nr);
+unsigned int xfs_cud_log_space(void);
+
 #endif	/* __XFS_REFCOUNT_ITEM_H__ */
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 89decffe76c8..c99700318ec2 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -77,6 +77,11 @@ xfs_rui_item_size(
 	*nbytes += xfs_rui_log_format_sizeof(ruip->rui_format.rui_nextents);
 }
 
+unsigned int xfs_rui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_rui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rui log item. We use only 1 iovec, and we point that
@@ -180,6 +185,11 @@ xfs_rud_item_size(
 	*nbytes += sizeof(struct xfs_rud_log_format);
 }
 
+unsigned int xfs_rud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_rud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_rmap_item.h b/fs/xfs/xfs_rmap_item.h
index 40d331555675..3a99f0117f2d 100644
--- a/fs/xfs/xfs_rmap_item.h
+++ b/fs/xfs/xfs_rmap_item.h
@@ -75,4 +75,7 @@ struct xfs_rmap_intent;
 
 void xfs_rmap_defer_add(struct xfs_trans *tp, struct xfs_rmap_intent *ri);
 
+unsigned int xfs_rui_log_space(unsigned int nr);
+unsigned int xfs_rud_log_space(void);
+
 #endif	/* __XFS_RMAP_ITEM_H__ */
-- 
2.31.1


