Return-Path: <linux-fsdevel+bounces-37280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB899F09F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 11:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D7284FA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDB11C1F03;
	Fri, 13 Dec 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LrbHHiLf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E5NE4RvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1619993F;
	Fri, 13 Dec 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086759; cv=fail; b=Wu2Bg5PuSw2f59/amxahG+K8J+I/zgtyryp2YV3/Sl+JonyR7mIu8xh/ym1G6G/UyV1C2LX6Ow3e3mtarixRtLQtPOoMuJrgboOGZ7ZqabI6Z4Fhk7PWvkNpmiimJfFksJmlu6hWbKwrWuW68A0xIFDXAuAg2AUBXMtxtImZj7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086759; c=relaxed/simple;
	bh=+AntZOZtKyZFzueECDGYu2htuzgeqCEjN1Id7mdLcig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W8ApmXRmVTRT5yjurZA3eUBDoNG5tuBBLS3N9SBvcgeu6MAhsjE9Ql1IFCercPgGLJ4cPkJthMo9L7DlH+89V/5rdrJbKOsg4UXmZ9Rpx5GT6bCAQPpMvxA3cCzmX090LaBKtauNjwUWFTuu7XQ73iLWUSmsb8RSRBTwJFhRH+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LrbHHiLf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E5NE4RvN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDAQw8p022680;
	Fri, 13 Dec 2024 10:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=s4VAY/M0rQFHSd+wCyeDZ+lu8Bedk7aUqTcL+/MYL+A=; b=
	LrbHHiLf5ZjawsWhe3jj8JlfyBbx3+5j100PGEsvgmNuYpozf3BXWdn1Vx+HLpnw
	yTFTSS2EnnMUBuu7CgrmXRL0rfpZa+ixtwdQnjpjhB8FAHxKE0cHOpcv2ZB8H+6D
	mjZGgePxf4gBbGgSf8YwspXYyRosMTHhWe9q6Tgyqs+yHKl+GgJcSm/Uh3ydJHjL
	ttLB12xhNkjBMsuo3i43c7Di0uWWvHgesI6HhFQmRAKCsONdT44P7VF9BmxzLVAR
	7/HakM/dZCDH+THMO8itfmwPjgVysxQ3lY5pRpdEhYhKyq3zFcdNM7ZphsVzWjsJ
	rH06VLKaao3DnZ0Be87+uA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9aw8qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 10:43:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD8n11A037979;
	Fri, 13 Dec 2024 10:43:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctjy4v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 10:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFDJcCSlRi5NHllLdbJbKGEJh8nXAzo7oYNWSI1yyo4+yeZIrVaWhSk8xRbAx9OMGoCGbBKY/jmKpWqm/4SzWqbPYGBUbrizNktnXM64lX//o4tIZ2QlUjntw/3x6/nMpfob5qZNIKSQGXi/m7KXONCmT3trPArymhoNjqNyA2kjohk784H+iKH2d3kRCTMdhG3Pg5n90vvGmDksrgzRCroQoJ3HpzIoX+uHPr5Z7yT44TmQnKLJmd3I8vKKXs2q3p1iUwpv08T9k/CnRzs5Oo6a02yqWFSu5jVx7sUsQ5qwcDqDfTGUF3Dxnp8erlZ6oC1bBipfYeRTdi/FMAM7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4VAY/M0rQFHSd+wCyeDZ+lu8Bedk7aUqTcL+/MYL+A=;
 b=ndeAwAqVQxyoNWxUowUzltO20KVO5ea5styqhQF1QkX6J0icw5P32l6WR5QswIkJS/QXMkXylZnoT02EIEZn7Nq0GQ0FOfMs9YKa75drw+1gSNb8F1dCzOsFhIpUOGu0i9AwXiJLQajRkZ2JSDBUsrawXIx62r9U5ZQyNaJmNDXTkq4c6Whph84ALZS4nRg7zvF/FaoUtoiUR7odkrYCl/Yh/vdbdA4NWxIWNB7/SME0VWx3VrCH7GBAiiLalFcDawIXluJyI3omDoInBoVZWGIxrlGBLdVGMs2FvRz5rSKTsWIxhAorL+uKIPxBTr55IyHKwCXQLJgLDjtMCHcsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4VAY/M0rQFHSd+wCyeDZ+lu8Bedk7aUqTcL+/MYL+A=;
 b=E5NE4RvNfPy3v3kXws44tGLdKy09157YWdU1DGjjyplv9QJpWtzcj95DskMi6qZV/VAHrr1vkJcVFjbzi7miYgCODt+0tbzQN9s5Kquco6ZaDSC8yXwP06cgW1Vnkdg1MuQ/TWlfKm1InQBBGrrjcZl2KlifC0zx5Qi+Wm7nlLs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 10:43:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:43:23 +0000
Message-ID: <1edc69f3-50d5-440a-b751-be02fd7e0834@oracle.com>
Date: Fri, 13 Dec 2024 10:43:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241210125737.786928-3-john.g.garry@oracle.com>
 <20241211234748.GB6678@frogsfrogsfrogs>
 <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com>
 <20241212204007.GL6678@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241212204007.GL6678@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: f56b17d0-72c2-4ad4-e99a-08dd1b62f773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG9zd1l6OWdLb1dKdUJOaXExenZkMm0wRFBLN2wvY2x0QVFnYm13dXFHTHpH?=
 =?utf-8?B?ZWVFQUJySDRvOWs0TVNvK1dDNUQzVDcxWDlzV0hOcDNtcWc5ai9tNE03LzNK?=
 =?utf-8?B?cjNJdFd0Y21pdjJrMWh1WVljaWc4emwzUGwyR0lDSkt2U0F2d1Q0Y3FUWTNN?=
 =?utf-8?B?d0tCK0xwazZQTEthaGdnbHJPOXViY2NyWDZSeUdYTDBleHhjQmlNbVFtRDNv?=
 =?utf-8?B?RUhjNFFpUlZxYlZ0MDBneGxvQytucWdqZG9VNUhySlZTUlo1Q2U5dURRZmlo?=
 =?utf-8?B?eWpUN0NLVmFTNFptS1VIdElmQUhaSHIyRDdzekUrL0lHQWFyNDFYcXJ2a3FO?=
 =?utf-8?B?dXBvNmFIWlVrbjZuOHpmMDV4SlBTSVZuTjRydzkyK1J6QlN2WHkvS24zbnY4?=
 =?utf-8?B?T2xOalVybFlsQVNDdnJ2SXhVWGFQLytITHVyQTVQZUlZRjljcHBicE5ORG1R?=
 =?utf-8?B?NThNcEluYlR2cHFBVkkyUGsxYjJXeEtWNG8vNzJaNDc3cGdGSkxqYUxKcGFl?=
 =?utf-8?B?ZCtmYlcvRFZyY01aQnU3cmkvcG5sSm9mc2tqUHRPdXJxdFdGMmhMbE1FemVK?=
 =?utf-8?B?VjQwTjFoTFNlb2Z5ZExLSE1vV0Q2R0lnNFl4ZzIzU0tLdmgwc1NzSy9JN2xt?=
 =?utf-8?B?MVJacnQxYi9td0d6RG9pZldqUzZTa3BrT3lVQ2F3OEd1TFFoY0FDTG81SFlK?=
 =?utf-8?B?SklOSWFoS1IxbFhqcWFsMmJ4eUdwWFZCc0NZTWo1cHR3WnRTeGl4Y2JQait4?=
 =?utf-8?B?dk5aTEllQXhlUHFISHhLOW1mNGVyYnp1TnNaU1JwbUlqbkRQYXM4TlVhYUlZ?=
 =?utf-8?B?NHRhV3lJbXE2emluNkc0am5qei9hSzdGbTNvYmJrWm43ZkF3ZklRTTcyRnJZ?=
 =?utf-8?B?QzVJQ2pHRUJISTlLVUJVd3dLZFAwVmMzWnJFN0tkZFRoTFdMSnVncGtRcU4x?=
 =?utf-8?B?NmVYZUFNL2UwOUs0UENNaklzZnZrZm9CM0ViL2pIWDRIMXpQV2tJRkZ3ZVFX?=
 =?utf-8?B?R09TbVlIWkZIRG9kaEN2VkVyaWZNdEgyLzJMODBnSlRQSG55VlJjTHZNT3NU?=
 =?utf-8?B?VDNISG1CcDJSTlRhelNsTHhZbVkzaUhKWXJhSm01NDFyNGUwb0REVEZwMGJi?=
 =?utf-8?B?b3NVdjNYOXYrZlgxTTBOdHYxZzJybEEzV1IvM1h3dmtvc3RJYzlFRy8yNVAv?=
 =?utf-8?B?VXo4Wm40c0h5TUhBRVJPMHo5SzJtNUNPK09CdjhSMUVlUThkTVY5dithb0Ny?=
 =?utf-8?B?ODhUOW5SclI3Y0pPYnAxNjU3LzVXL0ZWSHV6VVdyMDB1ZnFNZ3ZyU3JnazFB?=
 =?utf-8?B?SUFneFB5WmpKMGpEM2F4UHMxWHNPaGV6UnBLaE5xUWhUamN1L2F2QXB3ZzVP?=
 =?utf-8?B?MzRuT3lqbzRocWxoOC9kSFlrS1c5TlVlYzM4a1hYNndqM09wcEs3RzRpSnJO?=
 =?utf-8?B?elNRUnJSZ0JNSWNOdGhJUzVqQ3lacVdwMWg1NEttdlhZMlVwN1dOdjREQS9X?=
 =?utf-8?B?LzBPR25zVE1SK01XY2JhWW5PWU1xbHJuamQwc0tpMTBYTm43dU1KZTFkZkpt?=
 =?utf-8?B?Mm1pK2ZhSUR2Ulhvd0MrU2Z0WFNtcXNXanRJc3VsdXdYVHdkRXhHTXBGc2py?=
 =?utf-8?B?SUUxRFZUV3paQWNSNUhZSEpoOWlrb3BkYXNac0hLd2o5SUpSaUdMTlcwNWxs?=
 =?utf-8?B?V1JNdWhuMVZCQWtKV3M2ME9aa0tUZUQ4L1NOL2o0SmhPU2dZWG1IU0h1cDg1?=
 =?utf-8?B?cUNQeDF5RVdnVWdrY1dtRFJTMzJpdFFRclB3UWp2cGpKeHFXVXJHTUVZYlpF?=
 =?utf-8?B?YVliQ0tEZ3AwODNQQnhIUHAzNXIyTmZBNzYzOE9SRFVaRVZMcHlCV0U1NEVo?=
 =?utf-8?Q?BoO20UA9TUVR7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm8vWS9mL2VBQUpCa2l3V2VwZ0RJejhSN01JVktqM1BvbHkvdTVhRFFPLytE?=
 =?utf-8?B?M1Z3dk9iNFNJUTFNcE9VZklSQTR5d3V4bkU5ZW5WM2lIUlh4RzNPMFJndmF2?=
 =?utf-8?B?amRkRHhzdVNIazZxa3l5cVRaMXZaek11cVcycU51cUJJT2NZQlpBSG41enRW?=
 =?utf-8?B?WXRId2N0Sk41SUpHMlpXV2NMNjNZdzRVK0lnRjYrM09PeGNWek55eEIzTi80?=
 =?utf-8?B?eUIyQkZlckNRRjlvQndRMUZKWWd5NlN6TkxxeDlyQ2hTOFJOa2NLVWQvWnJG?=
 =?utf-8?B?eElyN0VvNmhOd3Fwck05OU0vUVlVL1lLVy8rY01uNVUzUFVIM09pRlJMOHNY?=
 =?utf-8?B?a3ZBSmJESHVNdU0wZ0pxeVU2YnR1SUdGaTBLY3hiRDdyRUR2and4VjZoRmNk?=
 =?utf-8?B?SENqMWNKeEl2NXVNd2ZvWE83a1JadzBSd28wZVMzZjVtdjlkdHQ2WW1KVDIz?=
 =?utf-8?B?QUg2V0NZblhOKy9IOTQzZXBZY0trZWpvSWh5QTBHN01Fek5SeDZJYzhyakZn?=
 =?utf-8?B?dXgvVGp5Rml3MmZWejV3cUVwbWViem9idUxXUjE0T0piZnQ4cEU4RjA1NWtI?=
 =?utf-8?B?THNIYTlJVUNhRUxqcFJJSSttS3hjeWM1RWhUclZ4MlpKZmFad3VzMUtiOU53?=
 =?utf-8?B?bjk0UDZlZGlCVjJuVTVWSjk4a3pzLzFua0xPVWpSUkdPOCtQaVkrUS83bkVW?=
 =?utf-8?B?dmRxWDZ3RWg5NlZKV2NKK1hqaDNtamVFcE9tbzUyeFBIZXRkd1lRdzV4d1VL?=
 =?utf-8?B?QnJnUEhNajR0bm1GOHFqYnk5K2FpRHdkR0Z5S2NlTUVTY20yN3dVOGNiSDJF?=
 =?utf-8?B?ejJWWDNTczQ0U3E0KzdMOVR3VmRUSEFURXlTbVoydkpuTjB2aC9ZMHY1U0ZS?=
 =?utf-8?B?TFl6bFRWYmd6aVd4UXY2cEQ2clo4c3BGbCtxU3ZNbU5SL3l0eFpjbnFRaW9U?=
 =?utf-8?B?NG9rQ0VxeWZ2TGVZVTNROFl2M2dtcEFiUVlXdTY5Rjg1dVJ5N2F5bStYd1VG?=
 =?utf-8?B?M2c3QVpSQnZrSERqTENyaTR3NVRBVjJxTmZxb1N2d0hIbkdrTE5XNTAwc0xX?=
 =?utf-8?B?cDFxaTlvM2ZORHl2WFJZdE42M3gwVGo3Vk00KzRja0NoaC83eHBLcnlpVFcv?=
 =?utf-8?B?MFg5MGZ3clczOVVBYnJxclRtK3ZMZXgvWmtBdlJIK1MvSGxCTjJKclhQb0pE?=
 =?utf-8?B?bFBGZ1IybDJYbGNiNU90cVB1Y0Ezb21JZ1dGVGovU1AzSis1QmVaajNrTTM4?=
 =?utf-8?B?eXo2bWtqOW1sYTYzS21GR3ZaVTFtaEdKUDVLYnhxUi8rS1ZKSE5oakNKdW1U?=
 =?utf-8?B?R2huMXMyWkl4cW93RXBoeEZFdUtqdG43NjIyckp0RGs1VkVRNTcrbGovb0Fv?=
 =?utf-8?B?Zm9NcnBDMFZvdDlHZ0U0QjZnejVJSDFsMkVkVTcyTm04b0NjTmdOMnNGb2tW?=
 =?utf-8?B?bCs3UHo0ZnJtRFhVL004aCthYVZuS2E4ajUvNmV1eEdGTlRNVmtXU0RmV0p3?=
 =?utf-8?B?R0dsWk9Fd0E5S2owanV5ODBMRHRTL1JpbDVNWTJQdkY0ZXFRL29pQkVIVi9K?=
 =?utf-8?B?TVJydzV1Q1dEbTZack90Y3NzSHA5Smc2d2xyZnRrSlYvTmswUFJsS2JvZk5m?=
 =?utf-8?B?cWMzMEsxQXZGY1BaWURxcjhYZ0ZUSjJUR1M4dU5GMmtjTmJoaitBcE5WMzVV?=
 =?utf-8?B?aEUrNUZWRDRJbHhGRHFpbGkwa3A4RDNwMW0wUHphSlZzWFB6a21JVmRMTHhu?=
 =?utf-8?B?cFdUcm42VCtvbnlJWUE2MUlxbEtvb3F0R1h5a1FjRXVVcGxkaWNxck1aQ29a?=
 =?utf-8?B?TDEzbTk5ejgzcmlPRnJzWVIwWWp3NXJnL3dxRHZ4U0p2SDJnaDg1S0N5RDRZ?=
 =?utf-8?B?aWRRZFpKT3Y1UG50cXpLQkI0bCtwZHN3cTNqdXMxNzY3QWJMS3BhcmdyaEVa?=
 =?utf-8?B?ZnZ0NHpUOUNqMHlYYTVSRkZIODVlWWF6c2xtMkFGKzQwNkZaV2J2ZEdyOUpz?=
 =?utf-8?B?ODk0L0lwZlQ4aUZxUkZaTDRYcnNMcy9ieE1IMXhXL05QeUVLVUhuNDJseVZG?=
 =?utf-8?B?ODJVOHNTY0dVQnE3WndXMFpwVHdOelEvSmFQNmkzeFovR2VGcWxiWW5DbG9Y?=
 =?utf-8?B?MHJHR1M5SnpqWlRSSkFicHFuMVBmZEkrbUZOTjczUnZISjlhM20xeHFVdWQ0?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UjGZa4AiN5gqhZ/3JRrpaE43wRHLWQVBhz7qXl5r4GY2c/fGWuZLhAZ3sONk3LHavZlPnfLAxWBVMMho2mi5kDd3T4Iev9d/4TJPM/2a8uZ6SpNli3HBpULwEJgFzKLZxUY9l5/FuUX2tIniiT3dIcPmdqczIBC/SvXmiCWsmTYrC3p7Rt3LEyvLJGybIwfvuYG2/RsuwuiNiMHNJ6IXtO6qK5kFzZnVY7k6NSel9mMng+elBTEgqcdXHM99cNW6j1EFHxp6YSAp5CnWdoEiaY7ud0OtALh/TIXhptvRtOUQLmM3kgsJI4iWBibH6hNYIHl5ogrVDxXqGBO+y7UhnosGEVUHlQKDH8jumBgPnDJ5/NiqgB22VI9+a0Is3fHPSH0VioCTwTqIsmNKc5oBHHy5PK7df5BgcxrJwHc5SX3YYnr+8Cvlh7HapdSmtETw1LYY3vHaEHMd3duvqYix6yJHWBkQBu5BNihPzrAJvPLQarltfVEcQLXdn0Ib+lm68QoRxIirQ8IY4v21CKKE3i22WOLe6TzHfdULJunUNK98jOdd1mgGLvP4twuhS6k96PtAfWQX85PMpL826UuNQF6H5krLdR1uXvaGczPlaTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56b17d0-72c2-4ad4-e99a-08dd1b62f773
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:43:23.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/2kn/gbyqLp2TvW1XL+HO6Xvs2tOSvOR7gskELqqWAQ/6pET9rHAXRW5+hSjbRQQZA5GeqYZfQoAC8v67urTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_04,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130074
X-Proofpoint-GUID: T2i4wOnEvxZyf_oOFSlIjjxFWlj2wOVx
X-Proofpoint-ORIG-GUID: T2i4wOnEvxZyf_oOFSlIjjxFWlj2wOVx


>> However, I still think that we should be able to atomic write mixed extents,
>> even though it is a pain to implement. To that end, I could be convinced
>> again that we don't require it...
> 
> Well... if you /did/ add a few entries to include/uapi/linux/fs.h for
> ways that an untorn write can fail, then we could define the programming
> interface as so:
> 
> "If you receive -EBADMAP, then call fallocate(FALLOC_FL_MAKE_OVERWRITE)
> to force all the mappings to pure overwrites."
> 
> ...since there have been a few people who have asked about that ability
> so that they can write+fdatasync without so much overhead from file
> metadata updates.

ok, I see.

All this does seem more complicated in terms of implementation and user 
experience than what I have in this series. But if you think that there 
is value in FALLOC_FL_MAKE_OVERWRITE for other scenarios, then maybe it 
could be good, though.

> 
>>>
>>> Instead here we are adding a bunch of complexity, and not even all that
>>> well:
>>>
>>>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>>>> ---
>>>>    fs/iomap/direct-io.c  | 76 +++++++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/iomap.h |  3 ++
>>>>    2 files changed, 79 insertions(+)
>>>>
>>>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>>>> index 23fdad16e6a8..18c888f0c11f 100644
>>>> --- a/fs/iomap/direct-io.c
>>>> +++ b/fs/iomap/direct-io.c
>>>> @@ -805,6 +805,82 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(iomap_dio_rw);
>>>> +static loff_t
>>>> +iomap_dio_zero_unwritten_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>>>> +{
>>>> +	const struct iomap *iomap = &iter->iomap;
>>>> +	loff_t length = iomap_length(iter);
>>>> +	loff_t pos = iter->pos;
>>>> +
>>>> +	if (iomap->type == IOMAP_UNWRITTEN) {
>>>> +		int ret;
>>>> +
>>>> +		dio->flags |= IOMAP_DIO_UNWRITTEN;
>>>> +		ret = iomap_dio_zero(iter, dio, pos, length);
>>>
>>> Shouldn't this be detecting the particular case that the mapping for the
>>> kiocb is in mixed state and only zeroing in that case?  This just
>>> targets every unwritten extent, even if the unwritten extent covered the
>>> entire range that is being written.
>>
>> Right, so I did touch on this in the final comment in patch 4/7 commit log.
>>
>> Why I did it this way? I did not think that it made much difference, since
>> this zeroing would be generally a one-off and did not merit even more
>> complexity to implement.
> 
> The trouble is, if you fallocate the whole file and then write an
> aligned 64k block, this will write zeroes to the block, update the
> mapping, and only then issue the untorn write.  Sure that's a one time
> performance hit, but probably not a welcome one.

ok, I can try to improve on this. It might get considerably more 
complicated...

> 
>>> It doesn't handle COW, it doesn't
>>
>> Do we want to atomic write COW?
> 
> I don't see why not -- if there's a single COW mapping for the whole
> untorn write, then the data gets written to the media in an untorn
> fashion, and the remap is a single transaction.

I tested atomic write on COW and it works ok, but the behavior is odd to me.

If I attempt to atomic write a single block in shared extent, then we 
have this callchain: xfs_file_dio_write_atomic() -> 
iomap_dio_rw(IOMAP_DIO_OVERWRITE_ONLY) -> ... 
xfs_direct_write_iomap_begin() -> xfs_reflink_allocate_cow() and we 
alloc a new extent.

And so xfs_file_dio_write_atomic() -> 
iomap_dio_rw(IOMAP_DIO_OVERWRITE_ONLY) does not return -EAGAIN and we 
don't even attempt to zero.

I just wonder why IOMAP_DIO_OVERWRITE_ONLY is not honoured here, as 
xfs_reflink_allocate_cow() -> xfs_reflink_fill_cow_hole() -> 
xfs_bmap_write() can alloc new blocks.

I am not too concerned about atomic writing mixed extents which includes 
COW extents, as atomic writing mixed extents is based on "big alloc" and 
that does not enable reflink (yet).

> 
>>> handle holes, etc.
>>
>> I did test hole, and it seemed to work. However I noticed that for a hole
>> region we get IOMAP_UNWRITTEN type, like:
> 
> Oh right, that's ->iomap_begin allocating an unwritten extent into the
> hole, because you're not allowed to specify a hole for the destination
> of a write.  I withdraw that part of the comment.


> 

Thanks,
John

