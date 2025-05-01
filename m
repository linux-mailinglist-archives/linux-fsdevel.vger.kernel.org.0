Return-Path: <linux-fsdevel+bounces-47846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E3DAA61EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE4B1BC4A6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020FA22172B;
	Thu,  1 May 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kH7POcI6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iOuPUT4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C318DB1A;
	Thu,  1 May 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118850; cv=fail; b=bks/RPWHcgezYNmsPaiWV6R8O6KXOK2/UmiGJGCXLeOnZXSRhGuD4N6DPgNyTDuQmtVqk0m42MqlTDD55u4YVvMIx7zzGzONZwa/Fah5QV0Fwp0PD8JVg9uuhpuL7a/HzyETQP6/yFiy+v/IOZs+AaIuluj1H6LC/kD6HPs0Kvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118850; c=relaxed/simple;
	bh=ojbL9ETQY9oFRhSdUJ0ncgTmZcoEGxx/N41SjSyeLlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oFpj0Kg3MmM/gKhuqoD4R2alyAIcNkBIc0AKI/u2NfQRnIPTNZOcsFSqVR1/fLeKEiLLmZ9tX2YV2lAAMwOGBmp0AVE3/rP67WRNrt/njXE++bxhpSSjL38yRoTcIk7q9uA4ihUZvu7XCHtnhS3AjIFOjxDX3SygKx+7QSgEXdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kH7POcI6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iOuPUT4U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541GkOlJ020310;
	Thu, 1 May 2025 16:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kZCudiUxfsEHIobBWzcPozzioirBNDfaP6h9ncSziu4=; b=
	kH7POcI6fxf+JCnw5/B5jiYw6/Lm5aUEzX3vM+HDTD3DCCs78somsn3adQatEajJ
	fcWAB0k8VnxVfpA9342ANgy2Ll8t8mpwlHRK5nZlbYHN/CPYdQZS7FhWN7TetThw
	5TbyWczxIsdy2Igf38aMArCJ4OmbwOcX5uiuyBIc8XRdsqYYWcP34e9fnFGfs2go
	QM/WDwKeeP9ZUD5KLK0xe2w9R+tr2qxaXdyXwBrk6vz2pkx0q0+EYusphrv/7BoP
	zyH/3gx4I5YJynfZt4debwT5D8iz/ibWYpewZ4/9oj8L6gqYr3hsN7FjD6ll9gBh
	pvPBOf/5qV1ANY1ggTLY0w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6umbenb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GKbAj013815;
	Thu, 1 May 2025 16:58:38 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcs6x1-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvJuqHrTJmOwoK8/sS1lXuR8IrQY6e244MuutpddyXHNbDSASqSp9uFjgzIu3h6kMirv2blbPBuqLIo3yVu5RR/E3A7svc0A4F2GD/7h4co5MNPeQOcef24UHb0QTOgIfNQl0tcuv3/dDm9KMoNjQS87drzW4Rxy/s7Jqca88HrxASHph7gOZ9C3r4R/JQ2eJg61s8dMjMBPBI/GUBi2bcu6UCrItheitxj4c5lo4h9VQYUoLD5jIs0dc9KS+MAR/bK25Pz5WR1xtKoIWlNCjfY7cKEu9nqr1I0KdLNqF4H5aT1sphf9e6y1Jncl+XrV2sw+9LW6XPGL8bb7sv4Xyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZCudiUxfsEHIobBWzcPozzioirBNDfaP6h9ncSziu4=;
 b=waVwWvat3qVTn3TsdvJfdXMlj++9wlRoFwCndhXtE8/El7+j+G7qsu8+7JmPF2r3RVTju/IMXdIjG3Ur9cfIwG8LTol4ETr4yg6y8Or+XM+htWJxJkBfvPt6gF1AWPo5V9GDx7aCxtfpsOSmBBxHwoxrMclqylFi7rvEEpHvIciRO9OGmOdV9N2PxMq87KxTgisWkvtq3G/U6rG77f4uv4Tu9exyJWbOlZuQ6WtWbAFoHU4IZyyvRhqMu9/yteuozovmnxNSwoJgdyZHcB4aAeZdL/EUxO242hdXVG3wcYgSgC/9u/YbxMC782JfKX5fAoKjgQxsgTGONuUl4f8MPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZCudiUxfsEHIobBWzcPozzioirBNDfaP6h9ncSziu4=;
 b=iOuPUT4UU3gr99znJnnLTtYMVU3Y3TdwhOMNVAcAS3gsxCA0K/FHmFTmojx4vwXL0rlDo/HpQL82wLvCyuXDan6XlHgF+9K1V9D9HJdYdyqSqawvUQsPQRKWbEkv+lIiDld+swKs3/E4BASQtHj9DxKTpb06gFIODRgmYMn9X9U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Thu, 1 May
 2025 16:57:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:57:57 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 06/15] xfs: allow block allocator to take an alignment hint
Date: Thu,  1 May 2025 16:57:24 +0000
Message-Id: <20250501165733.1025207-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0316.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: b8593696-7763-4968-2d5e-08dd88d15266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/BFSjS/ghAo0gcQ3MG2G2eJN4DdNXgDh0aEevXLjnQ4LQJUI7BXLF6OW5oL?=
 =?us-ascii?Q?nXnMqKeEn9Q9gPycE7LxK2D/vwvZI4oz8iYbelW5X81i5asCOQGcZIP6KMrn?=
 =?us-ascii?Q?pWOyMLUcUgoON7cf3h/yMCONVqFzHfqsmZkCvYXtm6m5PnbnmIOPqxA2Rlck?=
 =?us-ascii?Q?NFykYswmYTPulsimqndRcUgn/SZhr8IPpRQxDJG4dXgqPNq9WLRycZXOfG+A?=
 =?us-ascii?Q?7vDTq15lKELLDCtIEJas6URGvnNwOrlOyu+X5A3iYBsuOlEle7LVHepJNWNN?=
 =?us-ascii?Q?1BqB0Pn/glYZHK+smJBkKXpqYHYltgP7nm+3YTbUw9luzum8ixpdzlW5hiNJ?=
 =?us-ascii?Q?Xx739/GFfLNCcpbFYfzOpxhFYWO0YBBk5hjq3E/r6GrJsN0kC1IxBke21ZR8?=
 =?us-ascii?Q?NMKHHvK5PKhE5ihoVlyL+Z80iQdX0tSFJ9Uzgk03mkDub+Dy5DEUTNuinof3?=
 =?us-ascii?Q?xoCdPag8zT5DRWltzxWvG4P5KHK91Q7r3EcSN34INlAkLkrvJNSsW4desm3E?=
 =?us-ascii?Q?1ewEBcoQQs7zciS6Hp/anYw9wTxFKO23LgMu8ZgJKCG/s3q7KmF6laH5shv9?=
 =?us-ascii?Q?Q8dQ8ITFtoSMJ0Iw3QIALxBzxIFVlr0aQAvQ2uAFHWFgWeyifwp6Xf68cGS6?=
 =?us-ascii?Q?2zGmpFJ95TtLBDLeUF0bUSlSaKNAfQTy2iwa/WCH9gKR9dtGoVUwlUm9L0NW?=
 =?us-ascii?Q?K2Or/rePR36VY5k+3nC5iTFgdg1/sS9sV0ZlbGL+uiBTPK/H/Y3HNjgMSQCq?=
 =?us-ascii?Q?nhrUxmkw9CHEIOZyGxpCgnhlMrJ9lHZNElZd7aVn9xr6rwPsdgtqgWkXD11a?=
 =?us-ascii?Q?PDSVcOrUREGsvjMfS+dZK335f/twnRgE2GcQhhsH8rkyEYeng+g6ppEj7xbb?=
 =?us-ascii?Q?/Ae3W4YsDxL/YLdYnmusnzYNX4UfBdkbMAolvJ7gCRwefTPJDDs6VpsLaW3G?=
 =?us-ascii?Q?/rpF2FOXjzvE544T+99KQjSUlGvHivH1yfMbyT2fADJ8OPaJovuxdKtkCyEK?=
 =?us-ascii?Q?8vVFdrrNWFvX0OocuB7RVRo/gFZwrLt4nwKtp5jR9ncN7g32vErNsVOFIR2K?=
 =?us-ascii?Q?uvkRdaCQ1/B0M66btdaMxaQI/UsXRDal3B+P66UaVFIoreBdBdt4bNZYmb8X?=
 =?us-ascii?Q?8RajUYqDv3N+JR7tzY+Dwqfxo+V3XGDZJTYZn1Vdz93QABoLstIFdIphxqI+?=
 =?us-ascii?Q?SwE3qJUggDa67BOQXIqRWJbtZfeM4p37DExr34WPiMMtJtskl2CVtOiwlJkV?=
 =?us-ascii?Q?TFPCcRakZSfDukEDXv7l1SLlv1UIKNlSLMBpcpjnd2iIp9hmc2Hh8JsIZ7sC?=
 =?us-ascii?Q?vyN+3nuisjXLgM6XPz0NuQ3PNAcSNdQYtNc1RMIJcdmZFzU/EfvTOIJDMAaw?=
 =?us-ascii?Q?g+Cpy6yWha8fKbvRgCzcGzcahXrXjPaE5IxBFhOqwVvta63Jn18P0D5rtf3h?=
 =?us-ascii?Q?sl0tIZ8XCLE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gIZ2aTtiLHz2AXGb5XL+yAUefTrPXoGMAQFnA4jqwmw+CieZQK/rI/n3ybRV?=
 =?us-ascii?Q?dicoKWcr6mlKDaa9kdKeTrAsKL9Mht9ClpMeLml93YPjY5PbXtnHx6uy3atC?=
 =?us-ascii?Q?QfAroWjWxKKtIVR1FQuUEU1C4jlN3zvTuxsmk14Ru9/X+dr4IQ7c9DgtN8Gb?=
 =?us-ascii?Q?v0fzqx+nIQgx8B3DZxzLTURKmEn9yXfxVm2YPI2M/kgIm9tF0r9pSG7hN+VK?=
 =?us-ascii?Q?9iWEDcgbyo+Houn28NknfcRKCN7181klUymK7t2HPKj0AneJldDtqyZ+ofGI?=
 =?us-ascii?Q?KMiqyNJcG3wVv3Laj1BYGBafAyuf6egcbK1F7TMbPOMYkp5VEh3p9YPMCoDV?=
 =?us-ascii?Q?/VHIItmX01bcWZsL7TbOj+u5l3vkcUKyrPBzOTXfcclmpxamRZgTnBFflN5y?=
 =?us-ascii?Q?kIEZotu5V1e88f6Ny1qQzURiA9vSEKCLf17RMUSbLRxsOnHpmxbDz4eFCDcX?=
 =?us-ascii?Q?OrQyBgHir+dosLHPZTOKz+HGj6VrLKhWKvkDnXoBbPG2mUKHTfxbeB5t2hdZ?=
 =?us-ascii?Q?tgEvWOSJc3TElUhhSVVa5GS/LvKBRbnGR9A7/WTT3PLTdDZKqU6iW3UaMMru?=
 =?us-ascii?Q?h4NOdOktz+XCd5p9ZGPWX43OeOFuo2E2oHHlk76G9hNUcAB6Ih5RSplKKI3e?=
 =?us-ascii?Q?Hzq1obzmy2MlI5/5a2VgVqlybCxWSr38QY0YqqgHmGV2m/uHc0ImwETtbIIL?=
 =?us-ascii?Q?uFeR5ry1lcaSUoLuBbwemqxXm2UKRr8RcpGSv0kWGLV5S0qp+bEe9/D7UKfR?=
 =?us-ascii?Q?GZfE+PZj8TkFdjyg7Asi3GKEL6hdN1SeDXzwuFQV1ab06IEyTm8MtDyk2+9F?=
 =?us-ascii?Q?SsdiNKjvPAm+rtgKBslnxb5mEni10Ahn7IzwZmtBG09Y+MPHGa4isqWWMwqP?=
 =?us-ascii?Q?f/02h4CYvvuvVB9sR0ZPm4ec8X7y1WGVVmvAAomGdLD8rkcI4rx8NUy4LqCk?=
 =?us-ascii?Q?buO4hIneqEj6z8wEUEvqj/+TDB3o8UQdRfwjE+446K6t3G59GuxnyxvaXITs?=
 =?us-ascii?Q?4O9uBtM6TpuZARjT7jlxPy2WINBetwU0YRZKL80cxj7awFHoG/EJfyyI/M1x?=
 =?us-ascii?Q?0+b7woAR/U4zITflVRjGtaLW4rjMByix+THwPMoO4Pvw+fyvrQhlgY5CaHaA?=
 =?us-ascii?Q?AfEmeQHRyjPDEUZnwVd4l/rYiyUo++0kIvH7/IurtIF3ESF/Xz8nDdpyON3w?=
 =?us-ascii?Q?O+8fxY6ng+n/eikWXZL2MyLoVL/cIGp65NPuH1uQrYxoskTX9/hFQGdLDfNn?=
 =?us-ascii?Q?MDE01o8h2CyA6hT8EwfOgg1w11j4+JE1BqqImyUnTv3SugHtk5WxW+b/Nc7F?=
 =?us-ascii?Q?1bwVSm0G1VsmW8oI2MtdOWaKEkDCXgzVjx17G+qrAmd1jhwPcLury8HCrxjG?=
 =?us-ascii?Q?9E45n5JBEMWav4R1qCrHXtrMGo19sHWC050VE5gbHDKJL/W5ZlqyHRJ4phbR?=
 =?us-ascii?Q?LtIV1u5zjWxriE+GpckuXkUz6IkhPoBjheOXBVxiOaT0OFzl03kQ9ZcdD+KD?=
 =?us-ascii?Q?F6QOG8IkYYFlZye+FpsDE1MgYE961fk653svGq4FDsk5GR9HQVauhSYBD88N?=
 =?us-ascii?Q?g4RJXpOlaVi00sv8gnWpPP5xCtUtJkDasxbadDEbWfmyy7aBSGHmrF2RqpzE?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PN7AuR3JaUD24fG301ya67dM8+exu3wDAfV91ZuBns755E01f4jaFpKK1z8bdpRFmq51pszs9qMUmc1+0bXJWk0oMyTOTcxmHuQm/J/7imbjc+iYJUN3vrgQ2sQdjdGsidQEIsJOoze6L1ms+fks2Ab07FGknAxhCcuDUlN2baWHh1twW36fKycjbJCQzAvDoK2w7ZFGO3qpZZDIq83Zxi7nvBWy+nT/vpmRHkqu2xRNgTIJLSSwcmMAFY+6LczWT5Pky2L09LM77kAs1/+i9BcyrOfHpd7bny/gi/n8YvNi+HCGe6jz4JiPdDzyxCPqfLj1PdWfBKjbNqK8AsX62rZA6ccYatSVLW7I3+hGmJD0zrpb3pJCjz4iTiv+aneJO9F8xFGfRqLl03cgoR6U2GE7e2qrLKgzRycsj6ws7pQBb5iWfdW2CtE1DCu91G4Xtqj/6UElMxP8OHc3l3Dc3yJ6Llh4LCzlpcF4GaL7yOY1wpWYu8LVvvv6E1qjjBggLx5Tu32mTJUzfmosxYM4S2bmpCx4KoOWdhtcBw56v0Lc6+DKtWDfj77pZ7e4BFZyB3SZ8ut6wltp3Cd3I/zzNSwfhz4sQRj6oZ9ptOIg65I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8593696-7763-4968-2d5e-08dd88d15266
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:57:57.1870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvOSu6tLtVC4IEue3TfcnaVHjHvgKsXuK72/ENClS0HV/TLRwPJi0KBlBheKLAOthkJZ/2nClrWtOSbaMStmjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010129
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=6813a83f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=BdfLSKS78uDQwj0SyGAA:9
X-Proofpoint-GUID: idOyfwps780_zlEG3ngBVnbmMug7H4PS
X-Proofpoint-ORIG-GUID: idOyfwps780_zlEG3ngBVnbmMug7H4PS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfXymQvUO/nNQlF 5Mjz5GhMt29xIhi4MWvpC9MhxthSnzx+b/7Wl3DSv6JQ1zKCV8IFiK2LK3rr1ew0a7k8UOP0lkZ vKEIV9T+q0UvxvTCtkLf7u/tdjdmJc1kuQ5B3EVWZ/sW/DtvzlvA0ZwA709mWHXIuE168JzW4m2
 ttXAZfd8Xw/CVC83nfB184v3cCzy3S1fhWu1xkmcVMkyOVrAjaxjrlCAwwZzXZ/d4tBQRoWYT1J M0eiPZPYDpnRHlhab0th6P+0acfN8R+Npp8nVR7lHRBZHgrXVGx8adZRuGDy54PuemhMwyOEfVg 4sn5VKwHMYKYBIiCKfnT62cJLYPbOPU+efIXP83oIKI+pSckeaYbAMb1phXG/5GCgU5ribYRZyg
 C9HhgEGCap5XflcB55UNCJaRvmRe6TpzPi6dfeuxl9fr980Wua/01d3gREINRumtRweoKOX7

Add a BMAPI flag to provide a hint to the block allocator to align extents
according to the extszhint.

This will be useful for atomic writes to ensure that we are not being
allocated extents which are not suitable (for atomic writes).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 5 +++++
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 63255820b58a..d954f9b8071f 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3312,6 +3312,11 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	/* Try to align start block to any minimum allocation alignment */
+	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
+		args->alignment = align;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index b4d9c6e0f3f9..d5f2729305fa 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to align allocations to the extent size hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.31.1


