Return-Path: <linux-fsdevel+bounces-48198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC30AABE7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41515520207
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287827AC3F;
	Tue,  6 May 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QsDpYXwx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nPXKCdWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108027A449;
	Tue,  6 May 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522346; cv=fail; b=giYNc8iVrnaEfr3w5HMKjbmUi0PO4moznaDLT4MvDoAcjWyD2S3D8guDUl8izb06b1Gn+rNh5r0aB2o+OM83nNYMnbzcH1kY0lHNvLp0LiYT8Hkg+Sxx0JvlsW2snCkJZE5rbuCt/zrx+eE8L1jJl4p05KxtmENlEEhj+Ssgdk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522346; c=relaxed/simple;
	bh=KNVNk1CCx42+fiaAdF2Ll76XGH471BCcnQSWw3yt3kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aaV0cLRw6nq+5ArxkZn38zH42IRtsilREJacaaXCPPErNeSXU1WlkqEs0qd5OLFQIU3gZ6OBcfgNDEy3cfKvVAvD0rPZfTMtAqNL1jVHC+tqsTeIHgFsJelwFRFWqFZvSjrpLl7MlfBxL4n7tdk1vohP//vGs+T5Wux3xaC1GbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QsDpYXwx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nPXKCdWt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468vYUq023344;
	Tue, 6 May 2025 09:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W8XlzjetqY8WqWXCTcttc3zdjyPUAZ+82wHngghAoCM=; b=
	QsDpYXwxZevxKkElIuUOvHuaf4Nw9wxmbrc1swFGAs1tIEXr2Roas2X1lUskZ5PO
	xWufUaucEaRu9ZhAjS8cA/ks4ixer8ZHRDEBs0AsBopQtnzfhjo4x9eu1mHOksiU
	4Fa+0gavJbelTNeyyax1C2fFGIkLeXfriPpWgVr1OA8WAW5ZK2NwHjwCBGwe/RoW
	9C1pnlhSrezcWa6vN0/RPjrxTlNk3Jxo+AgQ4eRSGzgzIbRVqDspD3dhR1UkXH2V
	Z8OTM2aVgAi0+/ybD4eP7nUwJg4+uQ0AdgKVByQk6dA7QUl4BpsSE+ClvQ+0kwq0
	a2lideuDD3ddHgO2n7B/4A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ffc680f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5468G3bO036085;
	Tue, 6 May 2025 09:05:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8rn1p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aROejmSvBQpZSA1avhjWvsl1uW7+qDfvcpMQROEC/BIjE9d6iBER0sNfiXQCKdUX4QBuCa1fUgwj+vAOXWSBHvd6WwGMsY9ADmqbtrsENNnIdHPNHxekCrzBKPsQ4pRPKQM0+X1JiPyBDMy2DeMPrY5LRBzOzQQPV7ROYM0yxXKNvWa5B1v8KuLjOQIlLAy7eVqvpzFvLw6lK8m4jgif0sahyalCQ0Mv98uSjUtJuBkkm+MPhwhcJTecD+qUeeR+DBC5pbfEHhv62yhL8F06nLldtZpOkNRLfgEWMBXV9OMVxxcn5VSPfFNaZpu8YN3dbPjMObZOciIJaKC8iFv3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8XlzjetqY8WqWXCTcttc3zdjyPUAZ+82wHngghAoCM=;
 b=iH91HDvTY0Mkef4O+IsEMWptclEDuzZFlZbsXSRnL8mn7kbkXXw/ecSP0UuXfZBqUdXBn+8rcexLn9xsyZ+dvK9+jYWq7aGXwP0K7dbnrOnmNDRzYFmKJNlD8mtHnIFs+OjGzV9eYPn8HrFx6iKQh3tH4Hhz3GEuopFeHAkHslZasS8tVsWA0wOdsznS7zwEoxhWl3+9f8eWX3VU+I8w+omYDeo/K2BEo6uKUbDyZ+YLYQ5ku4JIrR9AcTe2WgJ4ye3pAcyVBzt3hxefwXAssq5irXDFO2pRPjpfGLM7hddw2Nq5SgaHNsN4UpGFhkneTV3eNn05jX5D4U2GXfcvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8XlzjetqY8WqWXCTcttc3zdjyPUAZ+82wHngghAoCM=;
 b=nPXKCdWtiaZnbLAmesHMb10IX6jDYPn9EjB7uWyA+uqT8W1A4n/ezRlhnEz9BXmITi/xKa4zTkRLswSQ9cMKIuPEEp+liNomickLfqsNCRp351d9wjPadI1CPB1fDGJi5Ma2y86hKleFKB8qfp99oOoncP/L5uH7lGJe6iI8SXY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:05:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 11/17] xfs: add xfs_atomic_write_cow_iomap_begin()
Date: Tue,  6 May 2025 09:04:21 +0000
Message-Id: <20250506090427.2549456-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ab0bd7-44ab-4c12-1bc3-08dd8c7d2344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IaF6z8crg1T2pzjmDGNQjf4k96AXzphEe8cUbPVT8fAiO/nQ5lCBL/7urJw6?=
 =?us-ascii?Q?zS2hxOb7cHVv+8z0aSN6lgb/5iGlrXIFoMeiUrMB+1EBzgKtsGeCEgJ2LKHo?=
 =?us-ascii?Q?IZbmxcdcV9zSG30DoFVvaA5s9b3Tq9hSnVFnWjedU4mbE/Rw+wljYzpWIMat?=
 =?us-ascii?Q?1KruTp3553KmsnhAZEwTo5H2B5Nrh8YfUeoSCD5bbi0lNabcYLWqhu4owEAg?=
 =?us-ascii?Q?sJ/AGnDt0AzfgiDLc4/KIrqgu7AT0N9jOYooI3ezt5yMfJeAPiTzfh6kRyYU?=
 =?us-ascii?Q?bG8G5H3qOFKh8TsVrHbndRhHpMwGNehdNM8KwGzmu9CqRh8EQLgcxt+b6ubY?=
 =?us-ascii?Q?Ui+sjRCDPHtGyMFxS0GzLR3i2oBt+GQihmMApMR92dWw7UFhJ7D5QIjLGksH?=
 =?us-ascii?Q?jcE/LxvzbyBLvmKpLvi5cdCtpJCn+YFStEX+C89vuO5+EPCH4n6Rm++rR2XY?=
 =?us-ascii?Q?ReMt4853IFJKkFn2gNHPdu1SKcDPAJ2HbWWeaDSO3ofGspLdNg+RnCwqO9lI?=
 =?us-ascii?Q?nkQaHiRrJrFj94x0njZYx2Bo7e/69RzksrSB42+85VK8co6A7Vuq7ikei2zC?=
 =?us-ascii?Q?3AVqgJKrx8Y2cbKdJv9tDG1RpxXymOHSX3Qw3ZgFHxD5wGwUvkS8M3Z3XkLK?=
 =?us-ascii?Q?Y+U4MbMYyYqeTZBjAG7P7oLnSY3ABf2ngb2JFnENZVV05Vuqm4iDL6GDl/Ku?=
 =?us-ascii?Q?pBgmAbg0e1ttqdGA5um2CV4X9TCpK3VEz7cGF1UXLU5BeY8YFo7iULKI7zZI?=
 =?us-ascii?Q?k9gEOWbnogmsBJ/7xqd8CinOd8zSF41ZBrKZo6HG5oRHmsLbVee8VpjM1W5Z?=
 =?us-ascii?Q?0UogM+n2oyunfH2wRHhWSQYYZ9kWFmcgeSTBDUQsEBe1somwgiv7y5Y/YETq?=
 =?us-ascii?Q?Mg4vJBALJNYjRRVzvBw+g0yAzpqE7rfE/G03KK5+Z4+Syva9rCx7jt7Kd4qs?=
 =?us-ascii?Q?fifsvzPkl0ZzMXVL3mWJ2D12xU2RcS4n78AQpL3VdALuWSJ1Kn8R7WSllQ0o?=
 =?us-ascii?Q?K1jCpB6YyJw2ggFfMtPqYmwSI+rfrBNVq0wXO/8VRDZ6BqY6udEhGSNfiTu+?=
 =?us-ascii?Q?F0+eZT3DrbCOzAPHohrlfwgS7IXvsf8mUA2Bh/fn+MCIJ1QmI41eaXVZJfyJ?=
 =?us-ascii?Q?4MzrWCvSSG52nYTnpX3wEZ+ZzdDL5zg3JVym97xL4PhDBy0oH/Pg4e/o2xOI?=
 =?us-ascii?Q?4T2/fTLEl+f0Y3tV18UE8xWw/lI64I5TNAXiDPAcoD5yI4uK2PuDLDzI+rN9?=
 =?us-ascii?Q?MddGcNgXIXHRAY40pzlVGTU3U/8AeA1dIZr39jEFLyC/HWJ5FMH7i5/P2F73?=
 =?us-ascii?Q?gHsQSkSdCKKDud2Swx2U0Qr3jmAVifc4WWh/FcKjRYsdiUWorf/TvEKoq/4d?=
 =?us-ascii?Q?lnh/TR5Gwv3BZzomkpmL/u4ZGBv5EZ6uB74EXs8Q9OeTmopHbgeLqIXBSB7d?=
 =?us-ascii?Q?zp+k5gkkNj4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pw3ihgu/V6MZYwpfPTOST+jJ3zAWsAam5Nr33iOls0/a0/IwCl1lb9RLyzcq?=
 =?us-ascii?Q?j2gFBrbF0WJA2OTi/9e/5PndB1xOaQfYDNpBxXigu0VLfdK6sjGVSRpR6ZcG?=
 =?us-ascii?Q?wYJq1E9b1yzkgD2MzDHS/KK/gf2BOlcGT+P09UyPFzBep4MwiZEoCronIqGF?=
 =?us-ascii?Q?/GSal0QFHEB2XvZn1d6N3AMn55bRqyxwOUKe/x1y3wxI7RAx6xnOQyB/9dYw?=
 =?us-ascii?Q?hXeMf0nTDCgooPcAPKEDH8a4hxDygyAJJ6IhSiyIhFVIjJ871b+qUSxR0Prf?=
 =?us-ascii?Q?4D4kzqk5xsOZ7JAn8F0WOjF8svP+JCKBDxcSh4fY33Tv+dsPh1lSRnsqL4IT?=
 =?us-ascii?Q?kHSEjnFi8Hukpci5wXbm+JW9/1m5wD9S7V/shWz9atAipAhmve7oAzMhcYWg?=
 =?us-ascii?Q?cCpZThsEQBjkEcM49ywl1st2tY/ilqqAy0scwNohGNJ1Zk4EkipKibwhdvUs?=
 =?us-ascii?Q?TD4ROPkuQa7JL4BDnrBml0X0Sp1XBOUWWa0S+grtgIWH5tsxVGemxzFiYMHm?=
 =?us-ascii?Q?6r/gBPwscMJE5wgNQEa8TjvksI60mj72Ba0Zrcw5b77ZPcUSQcfHbC93Wo4A?=
 =?us-ascii?Q?Y13NaQm7Z3CCp39MBA01HkM0ybllfPIfPiLIxbhxy86oi+FLXYdzcvRtgMOb?=
 =?us-ascii?Q?iCfBWXqSjoJHEotwUZhjLe1llomkQEgq7PK7kX3N+vVh9iOHdCCDE/tJr2Bq?=
 =?us-ascii?Q?DK3vDHcAz8VgtMuEilEhnI14VTw195kkLmjXKWL9lhafa4m3uyB62YtXNHyk?=
 =?us-ascii?Q?JGN9k3qmx+Ctqr4LAAXx8te3A4gupWJbX1s0KQlZx7V+RSChYCGb5Ay8dOcP?=
 =?us-ascii?Q?tiyUyZLb/9paw8o0WjpWBOFvWhZUTFliceXAPxVHuaR+jT42mwX9dQ3sMFgt?=
 =?us-ascii?Q?i41pVoU15i2FY3qiprCw3rvRaAiVUn98JeCCWOsuHoWmAW2Q4+o3jOnQ3GVA?=
 =?us-ascii?Q?IIfRQ4CNKEdTFQ1HDwxT0EwiZNKLFiA7DtF0qapgOuao6v0Hz3VT3nouF6RE?=
 =?us-ascii?Q?SYSo8Sq7KfKj6SSQs3+RpBTo4u1dce+oHI+y1umb6emh796olD7foiXbfGGM?=
 =?us-ascii?Q?bC32tpYIUX/dckDoDvK7GM7itcj/K9TU+vPiCT5UvTUqPnvyujnS/Qq6Rdq5?=
 =?us-ascii?Q?IsA5F+OaJLW6zXKcGwKL83tSHjQhp7e28uQqO8ToegsTP61+Y2RfSiXT/oQF?=
 =?us-ascii?Q?Xrm0+Hnm8iClp7VdJ6OTr+jNGOVHvXVHabqDC0H89SmbINRlSzQY1s92qxSK?=
 =?us-ascii?Q?5icAex6R1O27PH0CJ4MoVqdeDRldY1ZMX3un1o+PUMUgExxMKBtH/Xeq8GZ4?=
 =?us-ascii?Q?oI+j0nNFkN+b51Imia7mJ710jTxEAPA/GJFhNZVcLEC4CrcbRL1IIWPONSiB?=
 =?us-ascii?Q?ykUUxvCYVOHutJsY9CyQat0eoeTb23bVZk8cOlyxmV0ymKDyPmAsyUzGGxvQ?=
 =?us-ascii?Q?PzXA/E9ktRJ/70Ny9llPjPVCmrFhIbpZfXPse1u0KSlM3HTaMZsHaobtSGxn?=
 =?us-ascii?Q?/+L3A2odcB4HQ3BK7r/6a9y3x3yqO5JkLWmGOR65AiaTTOIoSwJb/Gkm9GdB?=
 =?us-ascii?Q?rMIrKRgzggCaFvBSpJFfkex8DKCoixpjnoM87hNVVNUH2lP4oh0f+ypDWPxb?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8EOgzRP5GZucWk5J6lkpz9jiJP71xjdyfI1iN40stAb8/k1jo4U3ziWA+LoqaBJn9WgqOFDeOU7z6MAodZv1VqSBi3uIsUbdSqV1pRHAVV0patIHmJ77ebVGfYht8cSyxUDeHLjETUf0JSNGPki07ulWKpAeO9BsZ5JNVimEm0F8UFhRRfgQuUUiIJRnqRS85tIZv0jQ7WVwPzBsHpLl9pna1AKhAsunIAVwOiZuUokUwvmqu1j4MyumHfWfXg/2mGaVuTeQ7BQsDiT3zhGOJkhe+Ci2HeGB2PPo41v7QDZJLPWAjo0cI/5jBt/GALbJ7Rk5BT6/B4JXgrMiJpnVelCCD5erdGJLyanTEog4MSb8ZZtPqiFQkz+wd6vUhGtPxxpbxCpsEyNw5ll0XfNXdQLDDxYWBVdTmS2sDjRQrqtscL5HsZAxixPiDTlsc/I4U0lHbeKfFQg8t6NxYmboCEIzpv/osItQvfOxV8PdQWq9qpCgCTPHBZ0qXRNpmqswJQRnxs5kBfYFiit7IQlFmm2Ur+k8E+OF9xJNmfGo9WPQUq0P367V7aLLLruaOATmIJBso00uOMa0do+buP+uP/p5GhM/rSvyLR5UWsKZlLk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ab0bd7-44ab-4c12-1bc3-08dd8c7d2344
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:24.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ut+Sqwdzo3mmmunrgk0qyNKVEag3uWKGfZDxHhj8H2+9Qn+GcxEJtKS+we8uFL0od8Iv2Kh8APUjPfn6Zwpaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505060086
X-Proofpoint-ORIG-GUID: 4WTUrCblSIzklmB3SBSrf7nzPkPUTAxy
X-Authority-Analysis: v=2.4 cv=Q6jS452a c=1 sm=1 tr=0 ts=6819d0db b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ZG6D_t86WmhNJCCpPcgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfX7tUxNLmBIdT6 ksKi7q0sMOGBaz8ny7proenH43xUxphOxpPW6v80ewC+VdnggDwteQXbMWdg3NobZlHdgH4b+KU g2UXl87zIMhEevm1Eb9yjtM+fFNCVGlMGj70h6pw+lpYVJZgsgGaDM5Lzf3F588HOPUivwtIanu
 jTsSTsuEc3nBku5t7mD96r4Tsl8dSvdMnHtK5NM13NmpLvzWfXR4sRmrBgB1yngr76sJxrIZvdv NvGSEuCzeDqOAxZo/Hh/F6guf/Sy1TCdbcudA/wsU98SKKfpnQM0lswzZg1+99vVmSLxsiUPStG pPbX3pKGW23F4iFi9TrKwkqo2wjkUA/+pBtrthvO/kTHUZQF4GHctizJgLKnh4aqKwG0271jLdG
 ZGJc/WhF5FBdjODglHENEPEdOi9cUlv2PgeMXLG1AaYJWZCODB4MlpZ+B5TMsjxgQ+MSWGb/
X-Proofpoint-GUID: 4WTUrCblSIzklmB3SBSrf7nzPkPUTAxy

For CoW-based atomic writes, reuse the infrastructure for reflink CoW fork
support.

Add ->iomap_begin() callback xfs_atomic_write_cow_iomap_begin() to create
staging mappings in the CoW fork for atomic write updates.

The general steps in the function are as follows:
- find extent mapping in the CoW fork for the FS block range being written
	- if part or full extent is found, proceed to process found extent
	- if no extent found, map in new blocks to the CoW fork
- convert unwritten blocks in extent if required
- update iomap extent mapping and return

The bulk of this function is quite similar to the processing in
xfs_reflink_allocate_cow(), where we try to find an extent mapping; if
none exists, then allocate a new extent in the CoW fork, convert unwritten
blocks, and return a mapping.

Performance testing has shown the XFS_ILOCK_EXCL locking to be quite
a bottleneck, so this is an area which could be optimised in future.

Christoph Hellwig contributed almost all of the code in
xfs_atomic_write_cow_iomap_begin().

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add a new xfs_can_sw_atomic_write to convey intent better]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c   | 128 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iomap.h   |   1 +
 fs/xfs/xfs_mount.h   |   5 ++
 fs/xfs/xfs_reflink.c |   2 +-
 fs/xfs/xfs_reflink.h |   2 +
 fs/xfs/xfs_trace.h   |  22 ++++++++
 6 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index cb23c8871f81..166fba2ff1ef 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1022,6 +1022,134 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
 };
 #endif /* CONFIG_XFS_RT */
 
+static int
+xfs_atomic_write_cow_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	const xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
+	int			nmaps = 1;
+	xfs_filblks_t		resaligned;
+	struct xfs_bmbt_irec	cmap;
+	struct xfs_iext_cursor	icur;
+	struct xfs_trans	*tp;
+	unsigned int		dblocks = 0, rblocks = 0;
+	int			error;
+	u64			seq;
+
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	if (!xfs_can_sw_atomic_write(mp)) {
+		ASSERT(xfs_can_sw_atomic_write(mp));
+		return -EINVAL;
+	}
+
+	/* blocks are always allocated in this path */
+	if (flags & IOMAP_NOWAIT)
+		return -EAGAIN;
+
+	trace_xfs_iomap_atomic_write_cow(ip, offset, length);
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+
+	if (!ip->i_cowfp) {
+		ASSERT(!xfs_is_reflink_inode(ip));
+		xfs_ifork_init_cow(ip);
+	}
+
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		goto found;
+	}
+
+	end_fsb = cmap.br_startoff;
+	count_fsb = end_fsb - offset_fsb;
+
+	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
+			xfs_get_cowextsz_hint(ip));
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	if (XFS_IS_REALTIME_INODE(ip)) {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
+		rblocks = resaligned;
+	} else {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, resaligned);
+		rblocks = 0;
+	}
+
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
+			rblocks, false, &tp);
+	if (error)
+		return error;
+
+	/* extent layout could have changed since the unlock, so check again */
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		xfs_trans_cancel(tp);
+		goto found;
+	}
+
+	/*
+	 * Allocate the entire reservation as unwritten blocks.
+	 *
+	 * Use XFS_BMAPI_EXTSZALIGN to hint at aligning new extents according to
+	 * extszhint, such that there will be a greater chance that future
+	 * atomic writes to that same range will be aligned (and don't require
+	 * this COW-based method).
+	 */
+	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
+			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
+			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
+	if (error) {
+		xfs_trans_cancel(tp);
+		goto out_unlock;
+	}
+
+	xfs_inode_set_cowblocks_tag(ip);
+	error = xfs_trans_commit(tp);
+	if (error)
+		goto out_unlock;
+
+found:
+	if (cmap.br_state != XFS_EXT_NORM) {
+		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
+				count_fsb);
+		if (error)
+			goto out_unlock;
+		cmap.br_state = XFS_EXT_NORM;
+	}
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
+const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index d330c4a581b1..674f8ac1b9bd 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -56,5 +56,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e5192c12e7ac..e67bc3e91f98 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -464,6 +464,11 @@ static inline bool xfs_has_nonzoned(const struct xfs_mount *mp)
 	return !xfs_has_zoned(mp);
 }
 
+static inline bool xfs_can_sw_atomic_write(struct xfs_mount *mp)
+{
+	return xfs_has_reflink(mp);
+}
+
 /*
  * Some features are always on for v5 file systems, allow the compiler to
  * eliminiate dead code when building without v4 support.
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index bd711c5bb6bb..f5d338916098 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -293,7 +293,7 @@ xfs_bmap_trim_cow(
 	return xfs_reflink_trim_around_shared(ip, imap, shared);
 }
 
-static int
+int
 xfs_reflink_convert_cow_locked(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		offset_fsb,
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..379619f24247 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -35,6 +35,8 @@ int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		bool convert_now);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_convert_cow_locked(struct xfs_inode *ip,
+		xfs_fileoff_t offset_fsb, xfs_filblks_t count_fsb);
 
 extern int xfs_reflink_cancel_cow_blocks(struct xfs_inode *ip,
 		struct xfs_trans **tpp, xfs_fileoff_t offset_fsb,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e56ba1963160..9554578c6da4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1657,6 +1657,28 @@ DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
 DEFINE_RW_EVENT(xfs_reflink_bounce_dio_write);
 
+TRACE_EVENT(xfs_iomap_atomic_write_cow,
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),
+	TP_ARGS(ip, offset, count),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(xfs_off_t, offset)
+		__field(ssize_t, count)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->offset = offset;
+		__entry->count = count;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx bytecount 0x%zx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->offset,
+		  __entry->count)
+)
+
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
-- 
2.31.1


