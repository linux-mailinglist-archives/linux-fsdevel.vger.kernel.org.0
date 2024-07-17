Return-Path: <linux-fsdevel+bounces-23806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135AE933A0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF867283E30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EABE446B4;
	Wed, 17 Jul 2024 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ngqGEkcf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EsMd2Tpi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879639AFD;
	Wed, 17 Jul 2024 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209013; cv=fail; b=T1O2paygMNeMcUPSrIMmxVXxocjAjcSAJyWpWEbvZRTKqeH+v//3GJfmmVu526cVMwTi5OjAfihbzqZXsMN0NhDTH8XhTcPJWT36H89UDFGdwBhUxVUHn+qv5EHXVAQSPF9W9cztkLEFyvQbRtmuRUY7IbCZpsIZUnNJ4l9Mj9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209013; c=relaxed/simple;
	bh=M5WRwWHH7r7/YkmPQf4h9H+yOTW32Tfojy1lrlu+1RY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oZF2jI2MhQvrqI3/3qxfjh2ecKzFBmByUmKDJdRh0rA0o4h7EUHQsqIkHf56CT8VvOUQME1Oudz28nTtQWbsSthCTWL5F308HQtuoJ62S+1Zxuh6stUc59rbQrGaxEZYHX6MID7GsRCFg++b7mxwmFbp7SC3/YMCUuEFV1s/euo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ngqGEkcf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EsMd2Tpi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H9Upob005748;
	Wed, 17 Jul 2024 09:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=harQ/De12u5rI6D75UJFmvCmpbtYXkYM/uNlmvbfej8=; b=
	ngqGEkcfXT/npqAs9HNvWRhaVA46rUs2WU6FgnqNe68tvTC7d8dHg3LYCqm6gy31
	D9D2jeknQckTa+z3Umcnve1WEiLXinCBDyCoWoAEkVY0RdAQ+L6xmYVq2op86G/L
	P/2gQig500TPyc1zRmSLXS/n6qBktHB0VMmh/eiuAVvnE7zzxGoGfw46yobV8nhT
	pCdct0jA69oBZ2kJkZT57qdiYpYrYi6e6FLR8Iq4NPjwVnK0JCE3LfILTa9/cjo5
	ZDU8fIll5lsG3KBQT+3QxhFued9xXK3I5u+MQl3V8HSz68O/47OlCT7YmPoCO2Ll
	FEiWtxFx/xfyKghU8CN5Hw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ebcp80e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 09:36:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46H8AnjP019491;
	Wed, 17 Jul 2024 09:36:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexu060-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 09:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PymOISozCA0eoFtELpBpgS0O289On/szD0giRmdCXIQnxFmtWE9Icap6gExW/36T+AJKxdRYD4k4hvmLYTy5Z/QQocS0YCvnXnJGQiBPGH6H9SVt8aCWkCW9xzPinZg0Y4XL/SV2dNlUhkyeiXfcX6b/2WMItxEMHG8cyhuSTM7HSt9VE3f+YpSE2z6qWNbl1bknhvAoRTzjFQVCNOjA4HJLZ15BAm2i1dQdJwrejnW0LS444Quf5DrPrDY33IvDFD4FXTvwP4Dup2xMq395bcD/Wz0zWBxIw5QTW1pbgFIPTOVkxj57F3iGbT5Dz9z0WKldU78m56JDCrWZB3TeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=harQ/De12u5rI6D75UJFmvCmpbtYXkYM/uNlmvbfej8=;
 b=x2H3uPHS4accInkha7KC+Z8tKwDjqCyAozOBjEhD9U7/Ej9Nzri55AAOWOkxmj+2I7se7k+A3rvY6wUKYKkWmKuur9MfVxAoaoGks8TMl6/cZJGbutcp95R7nJEHcLJmx1ARSnHCeJ1zJTgY7eCAFiv3EJDh5bv/Kdg+zZ7qHHtQZZvOHjS2uL4zfezxX8FAGsVxNCQYqZeSjPNwjnd/65hw7omeVTn6v7jxILpgC+Pn9REngCB5XBalN41mrSAeu9fpKNvc97cX74Q1YJ1NXhI7cXCGi8PBoIoXlvdEKruZGyXsu3edxNBbBe5YZtcCPB15rvvzGF3x8v9wQ/78zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=harQ/De12u5rI6D75UJFmvCmpbtYXkYM/uNlmvbfej8=;
 b=EsMd2TpieR2inirn+OCBe8mV7ANNyLFaX5IVMmaENYWTjOK2DSH/Q+moujyOrPTOSgFIFZnAolkCUZkDD3h76vqcZMHkFEhZ4s7cieG4tT0HAtZq9VpKJdEGDoLw81leeArfP6BxAFvJ+ouFHTGkTUlCUq79oQF+QXnnKli1BJs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 09:36:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 09:36:40 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 2/3] readv.2: Document RWF_ATOMIC flag
Date: Wed, 17 Jul 2024 09:36:18 +0000
Message-Id: <20240717093619.3148729-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240717093619.3148729-1-john.g.garry@oracle.com>
References: <20240717093619.3148729-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0415.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d005124-19c1-43ef-4048-08dca643f66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mHvzMKP2K1oTjas3a2wQ18TVl+0oEDPghGzwl9VYfgaQk/Y6RlCUstTrWZnG?=
 =?us-ascii?Q?7xl5A82qkqrE3z5oj8cxKH6WJRin+Ut3k8VUDob9fWLEXolJ1MvL1VJilGTe?=
 =?us-ascii?Q?QkABgjsEbHVGtY010nv6D9j55GtHxmV7sMHEzqqkxm6giKJw02j6INTzsNop?=
 =?us-ascii?Q?nvnPEb10sBucKx+IkIfGjVZm75Ig94TXdhd7kdc6U/52muM9iNcSOZua/Usb?=
 =?us-ascii?Q?9bAEclhpv3g9sk9Pc/kBbwbrkFngy0vTLkuQQTYkeGuHtx2mWlPfR4FtVGvm?=
 =?us-ascii?Q?tV8MaHCOzLCjU3o4uuprQZYCXtmwtPpuZIZO3gxtvT4s3UH5Lv9sKSIClVgC?=
 =?us-ascii?Q?4U4FPuL41fj4Q634Lxmgh55LipAjZk8MFGF3s+rxlwwRWL+hc0YkFzyWL2d5?=
 =?us-ascii?Q?VCIWnBHN40nF+sXqrrvcSybMLh+4OaeCSlKCytFxq1NO7oWl71kVA27OjM05?=
 =?us-ascii?Q?BAn5sf2JqlUyIvsoA4jj4UCKyZgEpOh7vQSWstYr51mBFQZjztxhtS2z4lBk?=
 =?us-ascii?Q?vEdKWZih3FcsaS4U3Vy9KJiTBHTT4JRo6/Mz7Tas90fw3VaT0ZwFLIJX0dQb?=
 =?us-ascii?Q?gKgAefkC1tDloU+LowVP3uOHaLG31iDpcUGCInf6TJZ+uEmyuSmZFkTsXqn7?=
 =?us-ascii?Q?oCZjyH4ibDIuS1cIktxcQP5OeYA1vOaMt3+4lVEy75+dAaNkQy6diTpN1AbV?=
 =?us-ascii?Q?VsIVxxti629PKcE7ltsSmz6xMReQbEG4SU9J8DNgd0svqZOuQS/ZYmfuDTB8?=
 =?us-ascii?Q?oBB6T+1V2sQGUWL5mW7Aqz37TMAcw9+A5NeIagg1zMbYi23iypp0++218qkB?=
 =?us-ascii?Q?VFrRnrvBvgoUQScWlj42bmGHdeD1rmMMjSMT5Lame7vc3INS9QKpgGxT8NAk?=
 =?us-ascii?Q?WZywpWZYz2MODGNZITwYZN/ri6XDH+r1YFWYkXPKjXr8GJH/cufr2hQ/zp0P?=
 =?us-ascii?Q?1ZDHuTWg8RwXhrLHyGx9R+uNK6A6X4VIbAe/mJhIlPvwrUk9CfdQLRmtyZxO?=
 =?us-ascii?Q?88UkPmBP5d+ctGnUCHMCU+E+/radMGz94ROB7gnsVCzHrhKXI9TSJYqOArnL?=
 =?us-ascii?Q?UCc4KE298D+owEceFkYTzGQP2Di80APjHECIf5Z5WUK2NCwCiIP0au6fRS4J?=
 =?us-ascii?Q?HmQkeEV9Tn5T97zEeYGnJYV0s52U9fLb3wgJYd8DKie/hFaCovim5Adnzpc6?=
 =?us-ascii?Q?UDHmOQz2Jx6+2ycJHyzHcnxGUbTpmpNeIFC+LFFZmki0+iW1UfBBoGLmv6Sr?=
 =?us-ascii?Q?hZD1eKx6OP6vsMufKx5eJ+0nzLCMgYSReo2jlaIfvMs2wYhLTjPL347yHCHI?=
 =?us-ascii?Q?H7F6vMJBweZhpfF0151BU6yxRJ4cLp6vgNpGV6qkyic9qA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?df1ywCeg5N4nmqAdb855GIriN2n6rQs1SGKK62xhJyLJdsovgfL/3uY3filL?=
 =?us-ascii?Q?ZpEoraGAMURth8PsfOy/DIdep+tAD+sPccHQMDo3Xw57Z75nbQB4W31+6WLj?=
 =?us-ascii?Q?7ObnOvnrDCKktSptPMyJmIIhyDHfNlFQe5HxLx6ftOAhynEIkHBrn4uTBd/z?=
 =?us-ascii?Q?sYOOAaC36rtWWPbQu5Tae4IuJVJQvkd+TkVMLQay16y3txNwN/7t88oQFgoF?=
 =?us-ascii?Q?Z+DbX9852czWMO+DGLdsAGnoEAdREkx8VnSXK9+Ki7qaXeBiT7PiRB1hdk6u?=
 =?us-ascii?Q?rdFTcaHLjjcP9ztu02rdfNDDNmgIeto5T3DFK85QdLgUzwQ3qYMrfAroheEX?=
 =?us-ascii?Q?N0C81OME6ZFfzwGutQK/zxFEmnS6OGq5i1vicRNjB/7CzrA2vyRA5K3wZpZ8?=
 =?us-ascii?Q?NtYnZAwOzbkIU8EE8K1oZ48CzLharTeDtiVJ6m0lIt+b6beiuj6RKwGyeQeC?=
 =?us-ascii?Q?lry8cO7+Qb0DLqq0AkVE33No97ORHJAZh4spdc/gFdl0msEmrUvc91LAgc0I?=
 =?us-ascii?Q?g4eqTYcWc+U5dzz3lXhnDS2/YHvierZS8hloj2BdCDuQhafqPn0ogdOFMHoI?=
 =?us-ascii?Q?l7totzsfqpobRTFbMXLOlZugPMSTZI5cEUsQBps3X0PFVmwR7DqBLOqhRj43?=
 =?us-ascii?Q?/hWs+n0U2NI71lAN08f+nAhLtcyR1W9XT8FfXBZoUgWzCURAZY3XLuWMYFDv?=
 =?us-ascii?Q?WLHxqQAXIYwYjGAnOYT2wSWOaBls+5AoVKjHO50uba8/v2ZCMXRsS1mXz82N?=
 =?us-ascii?Q?TZbLd0hQ+mHZBQdjPzngRXsqaNZOsaBr3Iq+OoYfSzJuKCzvknJTkSBLzW7W?=
 =?us-ascii?Q?Ym9MR0kXgKezuCrUwpa7sJHnMJypJ1XmwgMylRazQP7IDSbPll/MKyJ85U+v?=
 =?us-ascii?Q?0vlsHXPgpz5VlcQFnToMkYcvfVTcITVbYrIVeXuUpGbVc1HICKq6fwARSUMu?=
 =?us-ascii?Q?cHzh4RGHc/bm8+IDIAxMxt/jdnMgrrEST/0PmIO5BZl7lKfq7111JbC2jeV0?=
 =?us-ascii?Q?2n/79r8GYT6nu4iBBVj6b4fdVrU5fDknwbpzX8Jd4XqaHL2BVPbqDF35cE0D?=
 =?us-ascii?Q?q3FJyKwLPDVrjq/KP1kqnBLFe25UbgbbsSIqEQMbe5xaNUyc/ynShWNniWn7?=
 =?us-ascii?Q?ZASK1LJ6AfECXg7h4Si175C761sgK1npz0DHpxUOF20aWaNsT0tnjlFWs2zs?=
 =?us-ascii?Q?+3fL7Tgmp8xshb+HN9hyvA8CyYHXG7FAvO8eYGbXyuiQM39YfFFPTTfSXakS?=
 =?us-ascii?Q?Dfacj0MMhXbY81l8sdrotFwhMfCgXhTc+mrH+6eaHvw42phn4qi9+iGHT80q?=
 =?us-ascii?Q?o7wk0GhdcrGpzvLgjo+NeYsqK86uGbIERjrtaPXfkS6WBy0yPrzFqnVtGggb?=
 =?us-ascii?Q?y1gNtbH+J8k1+w2+f9Bp3kgs5V1c4w9gXzxvYQf9cxj5SNdbn2RzrNI3g0R0?=
 =?us-ascii?Q?ILABCMOAnQBhz3vORLVFHVEc9PXVz1bufWU4JFUVOn140G+XgERiY7W3RFp/?=
 =?us-ascii?Q?rnf6VXmFwoPgbNlHPHPYXsOrgfLMDnO416E7XI4skEJLTdRMVoySQbjMCaqT?=
 =?us-ascii?Q?GBhYZKUQ/ai/6yP57I89VvG7CAKHuKqHxHEb0gCJc3KXISTdUPweJMp7LdFf?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ObyWik4txYK/G5wdqLpq6M9JwtCKmK+cpbmzz79gq9nYL2//ph/rYQhJQ3MEf8XlXwnvwcpW0ZdOp2NLDKJjFkqwZEhh7N5eRmzVq6UMJibknDgqCz8YpCpaMo+V8hLsVbA3ZW8z0qCrZasoJs2IDhosvS2nE5Cc2y5vZNH3v3At7J+V/VjE3QxPGac0FcXzTLyC4ddQG7f4vhWtJUvbezK2BEyH6RGJIPyIYFgJwkqa7Xy5O1zeHMTDIHxcl2QwlkxFATBfezMLHisY0ThGUnS4qEYrM+55K+h3Uhhlx9z3QaW11fl0/7iKdkrQExYrJNMUou/eOgaq1HM0duby0dwf/gbRXTxspsu0tmvi2sw3VoC03XmUvWgiKIdfCKL6nj1GZqhfLuAjsDQusoVGBggUYIidyq6xs3JVwdYa2y4xqDGTZbnh8sQN+zs6KDmTkWU19Ze7u3S5x9y9n1TEufP6xvcddgwgj+xiNhuCT5J1M+aom6DyCHZ3Y93eFM4goaJ/SJoIYXdh8ifi9+LDHSOTLaFnrViSksnIz6sxJnptaOwzVBZ8GxgYtiXaQuQWa4F8UmtPknkB44VnTyxSMJS4/ogxJpfMADTXzqqbH0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d005124-19c1-43ef-4048-08dca643f66f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:36:40.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0K2aD3JlgqDxUblNUdHDqghwkEUaHG3sRYuMrnEQ5hHvdvFxzNC3jX1zWLeNj4XFMRZZa579TMIbZq8p7K1RAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170073
X-Proofpoint-GUID: 9aurpGICR6a_hmYQvy8ukRjTCrAWbsVG
X-Proofpoint-ORIG-GUID: 9aurpGICR6a_hmYQvy8ukRjTCrAWbsVG

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add RWF_ATOMIC flag description for pwritev2().

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
[jpg: complete rewrite]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/readv.2 | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/man/man2/readv.2 b/man/man2/readv.2
index eecde06dc..9c8a11324 100644
--- a/man/man2/readv.2
+++ b/man/man2/readv.2
@@ -193,6 +193,66 @@ which provides lower latency, but may use additional resources.
 .B O_DIRECT
 flag.)
 .TP
+.BR RWF_ATOMIC " (since Linux 6.11)"
+Requires that writes to regular files in block-based filesystems be issued with
+torn-write protection.
+Torn-write protection means that for a power or any other hardware failure,
+all or none of the data from the write will be stored,
+but never a mix of old and new data.
+This flag is meaningful only for
+.BR pwritev2 (),
+and its effect applies only to the data range written by the system call.
+The total write length must be power-of-2 and must be sized in the range
+.RI [ stx_atomic_write_unit_min ,
+.IR stx_atomic_write_unit_max ].
+The write must be at a naturally-aligned offset within the file with respect to
+the total write length -
+for example,
+a write of length 32KB at a file offset of 32KB is permitted,
+however a write of length 32KB at a file offset of 48KB is not permitted.
+The upper limit of
+.I iovcnt
+for
+.BR pwritev2 ()
+is in
+.I stx_atomic_write_segments_max.
+Torn-write protection only works with
+.B O_DIRECT
+flag, i.e. buffered writes are not supported.
+To guarantee consistency from the write between a file's in-core state with the
+storage device,
+.BR fdatasync (2),
+or
+.BR fsync (2),
+or
+.BR open (2)
+and either
+.B O_SYNC
+or
+.B O_DSYNC,
+or
+.B pwritev2 ()
+and either
+.B RWF_SYNC
+or
+.B RWF_DSYNC
+is required. Flags
+.B O_SYNC
+or
+.B RWF_SYNC
+provide the strongest guarantees for
+.BR RWF_ATOMIC,
+in that all data and also file metadata updates will be persisted for a
+successfully completed write.
+Just using either flags
+.B O_DSYNC
+or
+.B RWF_DSYNC
+means that all data and any file updates will be persisted for a successfully
+completed write.
+Not using any sync flags means that there is no guarantee that data or
+filesystem updates are persisted.
+.TP
 .BR RWF_SYNC " (since Linux 4.7)"
 .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
 Provide a per-write equivalent of the
@@ -279,10 +339,26 @@ values overflows an
 .I ssize_t
 value.
 .TP
+.B EINVAL
+ For
+.BR RWF_ATOMIC
+set,
+the combination of the sum of the
+.I iov_len
+values and the
+.I offset
+value does not comply with the length and offset torn-write protection rules.
+.TP
 .B EINVAL
 The vector count,
 .IR iovcnt ,
 is less than zero or greater than the permitted maximum.
+For
+.BR RWF_ATOMIC
+set, this maximum is in
+.I stx_atomic_write_segments_max
+from
+.I statx.
 .TP
 .B EOPNOTSUPP
 An unknown flag is specified in \fIflags\fP.
-- 
2.31.1


