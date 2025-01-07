Return-Path: <linux-fsdevel+bounces-38553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527BCA03A6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 10:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46DB1885E92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B91E25FE;
	Tue,  7 Jan 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SW8mdkCI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oBSrBMAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39D1DFDB3;
	Tue,  7 Jan 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240439; cv=fail; b=FF5sLTVbZyJpZTJgqHYIVqRpgDri/vSZAhtx4ZktmcfWxU4HtHkztMi50Do04I8kMnxAgW7xrFyRn40ZPzGeUZtJIJ77m6/6AJUzcNzjrhZiB0uprjD/r8itF8O/xdTTQy0tiJFxplxE0sJg8e1Jk99+craswBp3sFs9MN8/jwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240439; c=relaxed/simple;
	bh=edolzEKnQTSYI5+Ivm23fM7YFnK+IopbQD3GO6btm/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AsbS2kVqVoWHoLEr4skmXDdRmVNYQbl4dFm13luNHJp9Rw/6fwnQidYkPn2cOuVAh/sNFuEsWg79ShNpaVebLRDbnOInziHRxsRRn3YjXrmaIvsV6G0zILptyfU05tSBxGVursJtu3fcIWRtPVKzlq1Qh29W5ify82+/fHKEmPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SW8mdkCI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oBSrBMAA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5072uQE4008090;
	Tue, 7 Jan 2025 09:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5QdpMRM5tm7Mgwq3DwhzV7NOT82usThRdARTCLv5t7Q=; b=
	SW8mdkCI+PcTZ5hemHaLhh4I0GxbS8PoAtAFdO7Sx7c+dJrxQCSuYQ5d6zJxKD9k
	uSIMYGHIxRyLKVcauOwuTnPG+ljsELQqr4zB50xq2DzzK8+XeszdXtv0nOxJDONU
	RVSMPglfbYpQtqrfDnECKDlX2pFNkKpNWW3wlWVLA97YlzxqmlFhi5NGBk36M/JV
	vMdTqt0+wuKgtDFtnnbJ5ED7tjo1NgnEMTTbU6F7c8aBh7jE2XA7UXvaDDLaG0ik
	GsCqEhvZmHxZsGh7fJfJE+qpVeYcRH7K9tCuGHlXr+DQ6omLMIbzRrPbYsEsuFU6
	btK+exwskVXo90Dlu4MuFg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xw1buyf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 09:00:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5078aheb020171;
	Tue, 7 Jan 2025 09:00:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xueej7m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 09:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yncTd5qT4/96XEbphRAt9PcU/snrGi5o142qXSSFIJi1F2ZmzX1VsRkn47JTAu00clpvUPSbNYb7u/BapxtxPwuyG7X/bXDghJWQyYwPq9MiMLUDYJLVRgvuNJewnidipfmr0SheX+1K3LqFvTSq7KrnLfki8PYs2JCswUIBAdsWl5A7o/X+AxOaESbjyzp8YaAmTK2PtVZP5ItYFIsOdstB6aPNEK6LDMj8aPwg1pycuoKugJgwG/nT39HV/KNPbAx9UnqpXPvffgvi7jGzUMPX/X3gpUkJv86oJNUxvGM04VAA2HXrvnx8RgGqxK8OL/+cOxuHmBCXkvXmDGSAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QdpMRM5tm7Mgwq3DwhzV7NOT82usThRdARTCLv5t7Q=;
 b=a8O/INYeR4PhsHE0YRZCHUUz1GlrXwirwSf3P+1F64tPHgavNpOKcA96OG/5GpYaKB1GH06aHV1fAtPKIXOdh8QfNEF8uboN9UaVgYe0aL3aCtsiZDH7gfMro4/GAE8V6oURPDUCfNBl4lRrAeeiCUvynvrDdbNbOB1n1bonDAWj5ThJwM9udmBOKQkywGplVtASA22X3sdCZ1YM08z7KhLPenLFWOCjBUJy8GJ8+FmJD9wDUfM8MCOc8VGzmuBaaurCCmc4Sc8/0gfAPC+ZqZVgTPVH0bbQTuH2Lb/R6g+UP8v+1FQFJDxHVJBORP4i3j7+x15fqezbUvkZehc+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QdpMRM5tm7Mgwq3DwhzV7NOT82usThRdARTCLv5t7Q=;
 b=oBSrBMAAT75kzWYYKYvRcaiduEE20VUHpNImKeTtHQCrWsm9J2Ye2lkFNKzDOVwGZXc0Qvuk5kxLT8R9iyQccke2A6OOG4XIa9McLHFieXw3oNFnvTutt0Y/etZsP9ciVIHGiZ4USTmCH70lZYatXbeC6hIrTolMxWW3GooVJ4U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN0PR10MB5936.namprd10.prod.outlook.com (2603:10b6:208:3cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 09:00:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 09:00:15 +0000
Message-ID: <e2ed4bf1-fe55-4d22-b55c-ca230307e186@oracle.com>
Date: Tue, 7 Jan 2025 09:00:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] xfs: report the correct read/write dio alignment for
 reflinked inodes
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Hongbo Li <lihongbo22@huawei.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151607.954940-5-hch@lst.de>
 <dd525ca1-68ff-4f6d-87a9-b0c67e592f83@oracle.com>
 <20250107061012.GA13898@lst.de> <20250107070355.GH6174@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250107070355.GH6174@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN0PR10MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f4b088-84b4-4bc5-f826-08dd2ef9b36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S283MFRFNzM1NWVQSXAvb2xWUTVyR2xLQVpjajlGS21ENmY2cm9obTJQWmw4?=
 =?utf-8?B?U2NjNGlMYThrSFVUYkdEN05Kei9ZQVJKajFuWWdrZU5HQmFyQjFtL2dNNWFj?=
 =?utf-8?B?KytBcW40QkR4RndhVzF0L2VVUjBQNGlhK0hEcUFDbFQ3c0hUSk4rTCtrUDBZ?=
 =?utf-8?B?cHlyRFRaZVdGdmNSVUt0RW9lUnpUelAxL1pOUEw4UUZEYmVKVHkvc3o1ZTk5?=
 =?utf-8?B?REJWMXROMVR2Z3MzOHVnKzNQSnFRYUxobUxXbWdJYjFtRTA2V0lOZG03R055?=
 =?utf-8?B?NGlHL0djazlBZXR0LzBzVy9xOXp5ZzhJcThjalhPaHVoOEdpL2lQYlFnWUFl?=
 =?utf-8?B?dndvTnlFY2RSRTU0enY0Y3dxSnVIUUh5Nm5CSU84eUYrdUdvRGtjaFQyNlF6?=
 =?utf-8?B?bCtreldFM0Y3bHBRbXppeUpVRnlCMmdEcFJhV3FtN2d0SmdPck5veGZraXBB?=
 =?utf-8?B?Ym9mTlJqU2xSQ0RNRmNVSlZJL2JNWUF3TElKM0JwUllET3NqVlpFOWZKemtD?=
 =?utf-8?B?UGNjWmVsSVpOVTBSRWJoK1hpOXZIWVV4eVpJQ2lRcDZudHAyUW05bi9WajJt?=
 =?utf-8?B?bGRtejNBRlJNeFplWCtXNTErSm1oekpxdDhWbllTZnd3emtzWFhGbGxSZktv?=
 =?utf-8?B?alNRN2ozckRJUzhZSSs4U2dSdzgzM1RPc3JmcHpFUDg0S0ZoZjNYOHdFdUgy?=
 =?utf-8?B?RTdXc3IzQ2JaQ1YxSmFvSEZoSWswT1FqR0xTcVVCVThQd1duek5ZQkJQeXk2?=
 =?utf-8?B?dVViMy9BNTc5ZTB6SHMxWW5QQmxObGRmeUluUUVYZ1praHVOVHBxZ0h6UlZ2?=
 =?utf-8?B?ajh2WVdPRWk3MVpMUXlCcFo4QmxER0Z1dTFtb1NVS1hsQjVncUJWREN0Y2ha?=
 =?utf-8?B?bWs1djMxeEJsaDkva1R3Um5UcnFTSFVEZzZna1prRWVyNUV4T2t0WlNldVBy?=
 =?utf-8?B?NGlNOFJRYTJ0SzNDZjBVb0I4VFprRmRNM216YUVzeVlmL2VobTdNL2pCY08z?=
 =?utf-8?B?YWR4SndObTRTazA2WUpFUmpxZ0RBdy8xeE11b1BUOExFL0piSGZhRm5zYndX?=
 =?utf-8?B?Nm9vbnc2YjF1TTN4dnR3RjNBdXpkNXBwTUR5dWFiMGdnaHZab3kvUDRMa29V?=
 =?utf-8?B?VlpmOFdMY0tPQ2w5NC9Ec3JBbk5PVjNhaVhPeWJQcUFGZlVEbE1aUVR5aERj?=
 =?utf-8?B?bnRBa1E1ZW5xUmNnbmxrMEdyZXhINzB0MFB3MFdRVTdVTjkxOE5DekF0dUg2?=
 =?utf-8?B?djZ2ZWtCYlJmYmwxS0xQdElMVk1wNzMyT3lZNjltOFJHTDlWUXIvMEdSL0Ja?=
 =?utf-8?B?UFNXYnM2Nm1HT1JxZmdBU0ZvWlI2d1dSZVlDQUJIQjlxL1JwSHJIeWpVUVZv?=
 =?utf-8?B?V0hNd2FIbVRET3lNNkVXcDI3UGhYMXpRczl5cHM5elhqRXZOaStsaEQwK2xH?=
 =?utf-8?B?NkdtSnBLVmRTUGxkWkxNLzR4dG9nRkJYdk03S0ZIUlpMYVZtZG1wdGM5cURN?=
 =?utf-8?B?NkU1d0YrNXJjdCtNVnJBQW5EeHRmTEljbThIQ2lzWTNoR2Zwckc2dDNIYjhY?=
 =?utf-8?B?VWNkQ2xsTk1IbTdOQ3BxdDdlVWs3TG9OUFdaZ05Ya2NmL0drTzVYTkNMS3Fl?=
 =?utf-8?B?UUdRRlJvUUI1OUpNZDdtTHc1UmI1OGZkQVpxRmhLWWtoSDY4amVoV2szZ0hF?=
 =?utf-8?B?akRPaTBrTktnTW9VVHM0WU5ObzBxL2NoSit2YURzU2FEbDhaZ2l0bXh3SEpa?=
 =?utf-8?B?LzNrUUh6U1VwUVVWUTREMXRuNjB5NWtoQ1lHOXY2RGJJdDR3TjQvancxQk1J?=
 =?utf-8?B?aWdXaVlvN0JxYnlRN1ltaFFWaFp6dzh4SVU3TFpaWnVHMU9KTzR6WWV6OGRs?=
 =?utf-8?Q?yMd7dS2EdwuTk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUt5OUIwV09GbnRGeEpoOHRHc0R1YzhFTENZd2QxOGMycElJQnNJdi92WE1S?=
 =?utf-8?B?emVSN2lDZjVLVmtmOU4rUmRqRFlQU3N0TndEeHluMklXRVRnWENWekh5V0E3?=
 =?utf-8?B?QStCWGc2MmRUT01oSGJoZ0Y0MTRxc0VDUTFmQXN4MDVrNzl2YUlqOVBlTXRU?=
 =?utf-8?B?dFd0ZHNSY1VwM09vL3g1TlN1dTd4cFJoTG9scXpMeE16UmdDYzB5bjYvRmF1?=
 =?utf-8?B?MGx4RmV1bTFJcTUzelIzcVptNFZkbXJpaXRZZE1USHBxdnpQSmtQN2xjQkZ6?=
 =?utf-8?B?TFY0NnlibHAvVDZUVHVCeDZHUGlsU1pHK3FsYWh0ckI1UERBY2IzY3Z2QnF6?=
 =?utf-8?B?T0lQMURiekdRWEZ3a1N2NEhqeGxPK3ZWcnI3c0ZYck5PZUlFU0o0RUk0T2NF?=
 =?utf-8?B?emFHMlBVZldHY3h4R0NKY1FQQzNuLzB2Qy81aWpIWWJmWldxS1BYelY0Q2Mv?=
 =?utf-8?B?MlVpWUdaK0VGK3NOVll2V2o0M0lMbHI3K3JPWm0wU0R6alczK2Nva0Uxa1JM?=
 =?utf-8?B?MGpQRU1rTEZiWmRkY3FGUDJuWE1sQWdYdHkyN2E0RXNmTDRhVUtXTU9Mbk9v?=
 =?utf-8?B?TXZCTU4zeGdNWU4ydE1ZUXBXL0FzK082NXB2TGVuckZ4VW0xd256M3JGSEd2?=
 =?utf-8?B?NXhkZnlxcEl4ZHJ6VENoczNrVjJYZVlBTDFJZHAzRFViZXJUZmt3T01hNW16?=
 =?utf-8?B?SzhwR3pPU1BDenNvREhocWozc1dNL2lKcUt6VlNXSldTRFpjUnJKTXBlb1ZO?=
 =?utf-8?B?WGhtYmpNMDZmS3RGaDJrOElQVjJUQlplWm5Pbi9GYkdBc0hoWEorLzQ0NUl2?=
 =?utf-8?B?SnhrUXU4eVFsOXQvdVUvRytVRmNUckJTWEVmS3RWRFFnNHFqMHZtYktpSE5Q?=
 =?utf-8?B?enYyalpDT2p5eTkwZjQzSEFqZ3N4WFdwSE10b3htK1hHUmx1dy9laGdIUmNI?=
 =?utf-8?B?UTgxL1ovZ0tiTmc5S1BJNXlZdGc5MWxtSnFZTndEelJnaHBZelZGb3VJUTN2?=
 =?utf-8?B?c3IzNFdKZktLdWJOdXdObTVUZVBLa0pKSU5KcFJCUkx4Nmg0eVhUeWlyYnNF?=
 =?utf-8?B?SEdpR3loWG5vSE9wdWdrMDhaYXIxT2tncUdyMjkxbzJYQWRldHZ2Tzc1SHBR?=
 =?utf-8?B?TVRzRzRrdmhjRDBQK1lFcFFNbVlOOU5EU04zeDlwNGtEaHlSdXFWU0pCMGxi?=
 =?utf-8?B?OEZBM1VYMGVEclBvbzBJSjlwQldnMDhZY2tJS2tEUGREcTJ2T2d5OXk5VGcv?=
 =?utf-8?B?TVEyNmYxcmtoSVhwY1paQ1JSOHVzanhTenNPb3QxVXlta2hEZVpMcmMvenhF?=
 =?utf-8?B?eHJ2SnJscHlYK0RxdnZEUk5hSVBBV2VxMzlvNnVGcHZJWUtadFEzb1VXbi9w?=
 =?utf-8?B?K3FOekhPOTVIaCtjeFMvb0o3OGswTlBaM1I2N3NjQXlnL0gwUDJnaDRTSDZt?=
 =?utf-8?B?VzJMTWZUL3ZJc0VWU2ttSGNJcnFCYWFvWWh2WUoxNWNKNE9HTk5lZHA0clVx?=
 =?utf-8?B?TWdUU3VSK3A1NGsrSUQzSEVPallIMFM3T003dE9lNzlJcXVXVEtQTThYdXha?=
 =?utf-8?B?M0tsQXR5T2dVbDdrUktWZ2lENjh5dmJrZklVdWpEc2lsclpRaVNKUkJCK050?=
 =?utf-8?B?WjFWMUF1eVU5RjdwS0puanlHcFhZam94Z09FVU0rZ2V0QUxZUG5LU0xwTTBJ?=
 =?utf-8?B?SVRwaHBKOTJwRndrTzNnRG96WHJnREZGQjJPaHR5UmUxZ3c2SWR4QWMreStW?=
 =?utf-8?B?WTEvcUxObFpsd2k2aWt4RVdseUlTMUJQTVFVdkFnSVVQMDBiajAwMHc0SUxs?=
 =?utf-8?B?dGJrRER6TW11VFJ0U2JrSWl3N2lXNXJ6RmFubzlsc0dMdXZjV0g2dE1xN1Uy?=
 =?utf-8?B?NXJzaG42b1AvQXk3SjdQTjcxMmZIMm1KamIvVmc3a0x2MlN1dXBvR2hXRit4?=
 =?utf-8?B?RjRGRkppTlBTU1o4VURyUVAxUDExRGdsMzBxbUVFV1ZiaHJBalVjb3hLM3Qy?=
 =?utf-8?B?SmNpK1YxQlVFSDFMd2lrb2c2OFo5YlJqdnBNS0o0aXd1RkQ5eElZdWFGV0xk?=
 =?utf-8?B?VmMyRW9tcy9xQmQ3SUJrc28vOG5yUU5Xc1pjT1hzZUQzVzY3ZnMxNzVqUy9m?=
 =?utf-8?B?T094WFpwZGhkNUtFZGJVVFlDTUEva2ZoRlp4OEcwaHZQM3d5Mm51Wmg3c2ZL?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kltuiILZRgpfEbWr3RlUS5IaZ5qPlYqnaFNbrk9y4lq+spY53MB6iDi6/sMe9czEuAwBhlR5tzZ/PynZjyEM2IxcrDHaMRRcXmNhdAMtH7WuzgSiF2RtnlN1DMo39DglpoQYy8OdGIcD35N3at+arxCmJo4orHg7+CY0zvgcgiZ+FClwOVh4CzAotgnElmio6t/CKtSPu8qVDn6MRpv4On1SM3QAgpi0wr+Hjz4lAyzB9Phr6GYPUuhy96pDU3AiICRduVj+g8dkJBV2KNha02xnFi/dob4ZqYvNt3MaVtkevVvmG/wb8HjIT0odhTqHG7+4Hwe92HDJmE4zj94tXHNDWoecqKb4hkRps1prNMQmAxO74wyua3hAxhTeSLCEtnM3pvo/tBkdI4S5aCr4OJy7uXckrbIt5jFW9OLoLXzl9Znl9B1SzSPcFRk624iCwwAbJcDUXEfvrf4zqtb7J0XLtRewlmIiCqjOQUliv8Wo8BpPt3lXno51HoJ1XILzMFrEGSmSQ66seDD8/qv4ygTXjTNfTP9zZvbzgW2DeJcq0Fm3/MYNy8bfVLHbAUM++BfLXoNPPFKMl2TJhLoYJmZq0+IXmbhSDVaroMSnUo8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f4b088-84b4-4bc5-f826-08dd2ef9b36c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 09:00:15.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzuljLr0KApff6gW5rSKlCguXnrhiX8yfja3QzkNcY36jz0nVFpH85Z1Z11vbBEf00bR2l2irMJulukIX9KALA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070074
X-Proofpoint-ORIG-GUID: 6g_p6OhppNuBSgT-PruyTZRt9JJUSLDV
X-Proofpoint-GUID: 6g_p6OhppNuBSgT-PruyTZRt9JJUSLDV

On 07/01/2025 07:03, Darrick J. Wong wrote:
> On Tue, Jan 07, 2025 at 07:10:12AM +0100, Christoph Hellwig wrote:
>> On Mon, Jan 06, 2025 at 06:37:06PM +0000, John Garry wrote:
>>>> +	/*
>>>> +	 * On COW inodes we are forced to always rewrite an entire file system
>>>> +	 * block or RT extent.
>>>> +	 *
>>>> +	 * Because applications assume they can do sector sized direct writes
>>>> +	 * on XFS we fall back to buffered I/O for sub-block direct I/O in that
>>>> +	 * case.  Because that needs to copy the entire block into the buffer
>>>> +	 * cache it is highly inefficient and can easily lead to page cache
>>>> +	 * invalidation races.
>>>> +	 *
>>>> +	 * Tell applications to avoid this case by reporting the natively
>>>> +	 * supported direct I/O read alignment.
>>>
>>> Maybe I mis-read the complete comment, but did you really mean "natively
>>> supported direct I/O write alignment"? You have been talking about writes
>>> only, but then finally mention read alignment.
>>
>> No, this is indeed intended to talk about the different (smaller) read
>> alignment we are now reporting.  But I guess the wording is confusing
>> enough that I should improve it?

I know what you are saying, but I found the last paragraph odd. All 
along we talk about writes, but then conclude by mentioning reads (and 
not writes at all).

> 
> How about:
> 
> /*
>   * For COW inodes, we can only perform out of place writes of entire
>   * file allocation units (clusters).  For a sub-cluster directio write,
>   * we must fall back to buffered I/O to perform the RMW.  At best this
>   * is highly inefficient; at worst it leads to page cache invalidation
>   * races.  Tell applications to avoid this by reporting separately the
>   * read and (larger) write alignments.

yeah, that ending is better, but maybe Christoph wants to keep the more 
wordy original previous paragraphs.

>   */
> 
> --D
> 


