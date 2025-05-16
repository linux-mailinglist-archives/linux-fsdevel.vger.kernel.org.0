Return-Path: <linux-fsdevel+bounces-49258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B9BAB9CDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 15:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC67A94DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B01024169E;
	Fri, 16 May 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X9kjb+pM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ytd+V3rg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11F239E83;
	Fri, 16 May 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400721; cv=fail; b=F74FjrN+fgF5UyHF5JfLVhcH4SycGozpERly86TNXXGyHQ/tp22uUrCkf2OSsGKKGUKSW1SlT29Z065ExW5nJCxCaCvL5++EPkgR+I1qBd0JT0OGJ/kH0z6lRUhm1h+rzN3Yma+2CBzQ7MZZQou31lzsdXPwHlBzyrmdJO1fF28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400721; c=relaxed/simple;
	bh=ePqzbp94VpapVeJ/vMJ4/JtPiUsNN7ZOJhPB4SR5w38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pykERG8hN/BZeGlLWHEphgn58FH4chXpWh53sa4ctSBLKyWAjNgJfYpp9ojgnoRatVm7A8rgJWd9EuV1Z1P6d112JPzVE5dHSb/AlEJW2cZEpAhUiPmRcpOZvwvNUwtA4VSizat2gJ1zFM1EGdkn1OzwEMSw27wpo+JU+Itw5KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X9kjb+pM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ytd+V3rg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GCfwBM008639;
	Fri, 16 May 2025 13:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F/lTxAXGAxmRG4byV+FAU9z36cNknsbznkADjrwWfdU=; b=
	X9kjb+pMkiLKIXhWJtnKTIJSsBYjWMTtvPyjM/fXRtPjnhZFSUg1gcHRcE45aUAp
	zB3I5hKWpeFFo8qtDY1gD11pwKqEcp97Tbs5QkhwPcBglf+EwIOrNAj0wuAmFxmY
	nX+0AuDMY93AuTEMr7x21qgfyM9kieM3Vg+vWobX5ow0wMwRa1T/rLo3V8BCel4O
	Up3yAcX7CuDs4KlQ04RVwzRUV8LUnp5holN4EEWl7v2V8ZCFsYiRb58tvoWZomv0
	XImOB49fF66ZQg4HqA9fhQQFr4C6aYLu4fp9BUBjI7qSMLIt6Ny1LwIXLWOn64Fu
	u8FaX42IbD1Ova3BwBvWwQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbj1asq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 13:05:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GCUBEp016764;
	Fri, 16 May 2025 13:05:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc362m17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 13:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8KxXvV/3mbZDaed7ozbm4acJpfBHG9OQ1om1G0zQm2PLEHyLokY6rM/JUcaRf75Qwl+G5quasEIh+uuFFVvrBI7yGQwTp1PdpeuNYbb8lrTFSznYIikhaI00mUmerrkqOtSveuuzfvACV9yCLpJFme4HydjSTMexPqEUZ0SClAzCxBTHPiV/mVnbmBb1TZP/bD3cW08Nh0DpSD30kJrB0DRP2FC2A+oGON+59wddWuY1fKXnhCvQU81Cy12Bu/Wghq0wySJ6DAy7ZQrj/P55+55HJ0Gs1RgjLKKAOMJ9sgYUSGigNzoyz29UKM5KDBi3Uj7HS/PSb7aqTW2XTNxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/lTxAXGAxmRG4byV+FAU9z36cNknsbznkADjrwWfdU=;
 b=c+4kzwNomy0/vhA3vXF+YWS5CUYH3Yp95bXADy1a0ZLRZWZZIwSzF0cyoaDKdtnz8u4jP7/thyBJI++EwQvp4TL9JH4pJwqi4YbFtQDglysGbwo4t2udqkU0gg1Um72bO2eNI9qhU8amlFrFrRjMY8Fi8aFBhcYS54cvWN3wXshe0dWXmfBpXBP3p/XUSPXqmJxnAnj0oiT5AnR7oF2eU96W3YMjfdZmkCHrq4zjkWGq9pL2tmKpc3DwixBittd4rpWqzKFdbyBq++Fth/3Stiyirl2TXdj5QwVyyX5I82SYDM0bzD09rVx4674VJz6cpmJhYXuuJZEuJShVknlAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/lTxAXGAxmRG4byV+FAU9z36cNknsbznkADjrwWfdU=;
 b=Ytd+V3rgjOPPVWeaCWicx0dmiOK5NUzzyTQUxfBr85lAbaQHMvbx60e4mfwhpubiAy/n7yivL7hZBV/vDHakHlS3VuzE0C2t6EXmokDvgFaVyvdoOCsZarPuR2c48OjXOpYRc3rqxzVyYN2vevaiN5RzoSCNQlHYeN4kNKs6dR4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN6PR10MB8168.namprd10.prod.outlook.com (2603:10b6:208:500::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 13:05:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:05:08 +0000
Message-ID: <920cd126-7cee-4fe5-a4ab-b2c826eb8b8c@oracle.com>
Date: Fri, 16 May 2025 14:05:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] ext4: Add atomic block write documentation
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, djwong@kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
        cem@kernel.org
References: <cover.1747337952.git.ritesh.list@gmail.com>
 <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com>
 <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>
 <20250516121938.GA7158@mit.edu>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250516121938.GA7158@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN6PR10MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ba306f-d051-467e-684f-08dd947a48af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVVHVFhqaFZ5VlZpejZyTS9hci84TTFyanVIb0NtYTBXSk1ucXlMWmg2eWg5?=
 =?utf-8?B?OGhvRzlmVGowMFA4UnZuamI0c0VHckZ3WXl6cjNHc2I1Q0swTkxZUWxJV2VE?=
 =?utf-8?B?cXFKZEY1Q1NJQ2ZyOWNzSnNGNTh1Y0Q5NzE3cS9PeWNEc2tmZ0V2UUlIdFhw?=
 =?utf-8?B?SjVrQmRpb3hXd0QwME9aUVZxMGw5WEVqWDljQXZMTWtVcjlGdzVERFpWMFZv?=
 =?utf-8?B?dENzQ0ErSWVPUHNGc2tKb1VTaUxkMVVyeWR0WGhwL096djY2eGM0Vnd0ZnFi?=
 =?utf-8?B?WnI0TXV2SXU5WFdvd1FNTTZNaHBHZm1xam03UDRibWlNSE5iRE9NLy9nWGJl?=
 =?utf-8?B?bGMrNXV6aFAwd2pYZk9wcjRKeld0eGtTL1hNVXM0ZGVLZXFQN2lFZXRiR1Rz?=
 =?utf-8?B?QmZiTW1ROE1JQ2dMOEdiWXBZTzV0UUhhWW5KS0Vhc3NWcGFseEtOZ0hFT3NX?=
 =?utf-8?B?OUZXZ2w0L2dNVEZUSEZkQkEvb3FvT3dvb0g3Ym9WWVlrU3dhQnBmUHNMWWdm?=
 =?utf-8?B?UktvYnFLMmw3TG9ET2NZNHp2elA3Z0NiMGdEUDh4cWl1M2dzQkUxL3I5YWtQ?=
 =?utf-8?B?bEllMGJCR3lGYTFYMS9HS0VRVFMrYjg2dnN6ZHVtbmllc0FhNlk5bElWZVdC?=
 =?utf-8?B?S0FLYWJuUm4rVEdmckRDSGIxTWo0TG1iT1JGS00wcThDYkpIYjh2VEprcW15?=
 =?utf-8?B?MmVldUtUVzk4SWZ3Q2hsOEs2Ym9RR3VNMndhSVMwUGV5dGRPMEFaa2FXb2VM?=
 =?utf-8?B?TjdRcEZNYk40eDRjSFUxcksyYWVqZ2x5YStTbXM0M21ueXF1NkNEZ3BoajBR?=
 =?utf-8?B?ZFllZ2dqNlRiODRKRjZPclJLVVhLSHhIWlltdXpaWXJIckoyM3UzVmlrQXM3?=
 =?utf-8?B?MGpKUlNEY2p3NUg1bmp5VUNsSjdtVGx1SSs2anZHWkNWcXdLcUNkM0lrWVhz?=
 =?utf-8?B?NDVsUHlmRk9aU0tpUThMc0tPZmlpL0VaK3poaGNHc2xxcWIzK21lUXp2Z1hx?=
 =?utf-8?B?QUg2RG9BanlVNEVwWlVyaUo3R2M5MGFtNGs4UWdMMVdjd2U2T05VUGliazRW?=
 =?utf-8?B?dFI0RTVyOVBMeENqMTAxbXlVQ1FNV1l3K0gvMW1UZUxBYXdtYzRzcnJhT1dx?=
 =?utf-8?B?amNFbFlrTjFHbTBmdEN4YUVNYzdYeVZmWnBHUVlsUFF2a1k4dVJ2WEl2dkZO?=
 =?utf-8?B?WVUwY0NuVmpQRWRDZHI3eXphYlpwSHRwcjI2cVRrWml6UDJHMzNEdjhWSEg2?=
 =?utf-8?B?bGNnUVFTTVpYL0lkSHk3ZSsyRWtvZis2WXNEVndhQlhLSEw0K0M0N2c3ajhj?=
 =?utf-8?B?YmlrWXphWHREZlFHT1NhNzJET05xZEZ4Ym5wMjJRWE9WZGRTdzE1ZUh2cHR1?=
 =?utf-8?B?VGxjN0lVakdSUTY0eTFyMnA3RnlCTUUwWVlzL1kyQlV0MW5lejV4TkR0aHFv?=
 =?utf-8?B?OU5XYXlJV20rL3pyWDNNK0FrbFVadmdDZFNlRmlzZStNaW9CZkNxWTlodmhy?=
 =?utf-8?B?WXFZUklnYmx1Y2Y4N1cxRGRKYUVLVThrN0FDMi9Gb3UxUkZLSy9DWlRoUDNV?=
 =?utf-8?B?QjNpdGY3aUROcjhkb3ZaeWpHTUxoQkQ4ZkkrU0kzQStUUGh5b21ZdFprUmRw?=
 =?utf-8?B?MXJLeUZJNlVoSTdSWUc5RWRFM3dObFBvOGlNb04wd080M2Jkb1R2Um5Jai9z?=
 =?utf-8?B?YkpuMG5EQUpweHlZalorSm9oc1l2cHhaV1p0aTc1TGxsNlg2bDk5V3JpUGd3?=
 =?utf-8?B?ZEl1YW9pNGVOcFFYQTUwbUVKcXFWeU5yeGtHRGFsMVdQU1Z2b0E3UHgrQjVj?=
 =?utf-8?B?TTByYkR1WXExdE43bmRyNmgyUGxiTkpzbXlvMDNDWmR5S3RBbS9RWXhqcjEy?=
 =?utf-8?B?cjZlUzJpOE5oNVVUQjV4blRhQ1dpMk9jVi94SU4vanIwYmNiNlByWkVtZTZ0?=
 =?utf-8?Q?L2ob8+kBrpw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk0xU2JDdVg4QmlUY0tDLys5TTQwK1plZWkrRmlwSEQ5ZHNSbWdQYVQxa3VJ?=
 =?utf-8?B?cytFNUNqaG9kUmxkcEs3dng4MWx2S211aS9maUZOQWYvdkZMY3JNMWVjSkFU?=
 =?utf-8?B?cmhLQU9rdFFVcGZLTUhzK2MwYU1iSDdPSFY2a0NNbDFzMFU2bkFEQnl0a0M0?=
 =?utf-8?B?Qkt6ZVg4TW9TbFRNMHhOTUM0aHIvYmJxOE9GeW9PZG5tc212YmI3YVhUUXVT?=
 =?utf-8?B?RVpkVUpKdFh2WUtoN0lBdnlzeUhDbzhrMlZzL2xTMUVtK1NReVlaMUdVQmx0?=
 =?utf-8?B?Y2VFQnhvT3BaWGxhckdhalFsT01IVWJ1QlhEaWk3b2c0a1dHQXFLMWNJLzZL?=
 =?utf-8?B?c3ZIWUpJdjdEWC9KdElyaGl2OHFVaHV1TmJCdzNzcXJxdmhmSTNSdG5oWlZz?=
 =?utf-8?B?UHY1NHoyT3ZUV1dDTmVYaGNpdEFEVG8vV0dyUGFzYUZOTzE5NUJIRXJkZEhs?=
 =?utf-8?B?UXRDOWQ3SVlPVnF3N2NHVm5OVTYzc2VYUlBrS1RMdmhMNXNvNDd4TEhQUDN1?=
 =?utf-8?B?UzVRaUNWc1dYSnpuRkRjR1M5d3JvUm5UQkFYMHVBUXpHWEVhK3VmN00wYnNZ?=
 =?utf-8?B?YmdRN3JQMnc2Y2tJWEFLVVo2MlM4WmpwMy85cUNsT3owSjllUkRLcW9RS21t?=
 =?utf-8?B?RFFSWTJSZnk0c0VIYnlvK1hDZkU3MFZ1eU92VnhLRUJSa1VQRUdTdFUzTnJB?=
 =?utf-8?B?SVpYUkJrMGVlUG1NSWFLcTY1eTRHWm9vUllQditkRko4SUh5UjhvWis1b2hw?=
 =?utf-8?B?b2VZQlYwL1NUZkVFeFE5bjNFMGRSVFFtOG94LzEwaVJLL0hHRnhRN1paTnBq?=
 =?utf-8?B?ZmJWVXpSUlY0Tk96TWZzdHVNSkRSZ25WOGNoUXFwY0RjOGpiRTZ5eWhuSVBo?=
 =?utf-8?B?MUIxK3piam5WUVRmUWZQUVU3Y3J1V1AwaTAzSHdPKzJHZTZXY0JwcWVObkQ4?=
 =?utf-8?B?Y1ZhQUlpUlNSZkUzUzZncmdqeS94VUNHWVJuYmdrdVUzRzBtUEFKMzhqaFpR?=
 =?utf-8?B?T09nL3NwVXp4RXd1Rk5TVk4yNGJzWGppVHhad1MzZ2I3aVBha2duWXRyd3Ay?=
 =?utf-8?B?bzZaWXNaa0xiaFdxU2EyQng0N0tyRnFjU2JVT3pmNVVLTkNRYVp6S3FKR1hM?=
 =?utf-8?B?eFAzdXZRVm92ckVvbVFvTWVSUC80NU05OHFmYnZnanlHNWlNdHpqc0ZZa0k5?=
 =?utf-8?B?V2R4NkpMaDBBaUt4RTlRV01xN2VXbEJRcDVyWERBd1NRWlZHV05ERnp1STBs?=
 =?utf-8?B?cnl1RzVrZEFaMis0bmJBdzVDRWw2M2xHR0xwaG9WWklRdVdvdTU5SWZ0MGVY?=
 =?utf-8?B?N2FJMDVDQWF5cTB1TSswYkwvc1Zud2dSL0tuQ1B3WUpxYnViNGNWd3BsUlQw?=
 =?utf-8?B?aTQzcnVKTStxRklJL3NMdXRPWGJtM2FkV2VKYlE0U2hNU1VCV2kwL090dGlF?=
 =?utf-8?B?TWlHVlpZaUp1OEJYb2R6VmRrMERYbTBBWXN2N3cxYWNPa1ZSL2xOb2twWlhn?=
 =?utf-8?B?Qm9pODN5OTd1bHVQVnl1REdtRnFBS1Y5N3VzNnBDdnZicXRkRHpkVTJBUms1?=
 =?utf-8?B?eW8wYzJ4NnFrcEFjcnFpTTR5a094d2ZLOWY1ck9DY3l6UWoyaVNjT05ncXY2?=
 =?utf-8?B?REkyWHl2L000ODROYys2VUIrb3lkS0xaMEJsR0s3cEtnUlRxVTd6QWlxUXhN?=
 =?utf-8?B?bUNUWjcxaFNMQTdRRlhreDdoZjdIdjg4enFIZGhzUW9GeDZOc0dyYUw5MSs0?=
 =?utf-8?B?aU80ZEZaKzhEM1FLU1A5K1RLajhjVDV0UmN5a2VHT2NRK3BkL1grQS8yei9T?=
 =?utf-8?B?VkJISS94M3NmMDZxakVQVmsvTFJyekRKMFpUMEJHWm90SUhRKzlCTEJVcXdO?=
 =?utf-8?B?T1ZjNkQvdGMvU21QcC83UGNDaC9xWDU4cm1QaGZCUjZzeExxbGozWUFCdWRV?=
 =?utf-8?B?UFkzcmIxSm4wSjVxUlpoa0d6VlV4dHRjREJGbmc1NFRWcXVPaXl6dTY1RjB0?=
 =?utf-8?B?bEl5ZkEwaWtrWTVwMzZkVTJXb0h0TTlIckFNQ3JhYjhJNmk1NkJBdUVXY3lx?=
 =?utf-8?B?dVY4M3ZhZ2o1OXIzT1JvQmFxaGw2M0FsdnhQWXVPdWFtaEZucHFiU0xJcnR1?=
 =?utf-8?Q?zoVoP347hbLxptiFi03guOjJA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xPwg8CMvWPW0iSZmB47cFtjYsJULjoerTulGrACOWY9v9qSqwmHhpoDUfZTQ4+MQblNyAunl1jc+lYuz2bwW2jSNrDUFbU9THQaadda890A7TLZE+VHcLrars0AslznFn7QFfPUfauZF3BZtKpK3UHDObXiTXd9iIxTHro71KYNJuLTO3EJQs0YHWqdh+UwAeb5fAxHGypVc0Zek8JutepekxvdNmfSViylrc7I31MqTwpYOjnNkPxnQnb+pSexoPrxKYTim69IT/c5w/qdBBzK1l+GYxk8a+CzxAZ+76AIyXH+WS9Qmp339kg796xIxXHW2cG7o4IOZ1gYIhw8D+DO45g6LCPCqsqa+RzoW8envbkl/fh6qFQ2/4ThJRQ74/vTAfEOSSLmJW2U4/Ydx5JpC+7VAWokJQ78PVduIehtjplt54eLBYPSVKBmGQ+XaHWeksc99DmwLU8S+k6dYHUYTRX/JGd3U6ewbcZheDEfd/TrSR6bf9ZCe+HIklsQaYGq+k8fubD+AZfsQrGbJPpHQTAoDwhH6vTEOYoAiP3OIgx11B+1qu5EHrg/WMdebSe6JXwuw+4RaR07mwjukDEreh81XaxtwIAdALY90jBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ba306f-d051-467e-684f-08dd947a48af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:05:08.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiYLNWITdwWYbrFYWCPZnIZPyLDwjUyKfO2/2dpbOM9P0ARw3Ldn1UBTbJsWDHgNkjAht8UopR2vuBwIfAzkLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEyNSBTYWx0ZWRfXzSgv+1eIyZ4D 1zSYBEbzFB0s3wuFCeBXROZroXFYVNhfl6y2a+uQjPbfmlfA1xB2wTdRuW0YJzly1hILlUhDDuU 8WYdtTKo6ctElAH6//sU4UQ8eLR4t8nxrzf+oByY1lh0pdXqj8prSLFNDmOx+tl9lw/0gRAwt8R
 rXQobBtvI5Hsl5FQyhNxpv7jZ41Mx9fLN6fp1MD0dh+ZkuuO3l/x35Q1NhzTHtLtuZ/6vQz1cG3 pOSxTSJbKh1otBZgARufF6hdYqjtfOI8Twq+FgcKspfnpGzGHIByPCssjHaUxGAiXUZuJWtvRwn Suq7MRulEc9+nNlGvJ5URKRa1DcF3+VNV80tDwj9ppFcyd9S1FWf4iM9HA2NY3pD5MtL/Bzv4qI
 6jqL3x78ryRGBfi3Hzi6F5lEeVcJgCrLGXgUUpuwqnIgQGJkTlASnv+ovavTztnd+boBux14
X-Proofpoint-GUID: ozir6QmfoiA2hf1TNm_yDl5nNAAXMJCJ
X-Proofpoint-ORIG-GUID: ozir6QmfoiA2hf1TNm_yDl5nNAAXMJCJ
X-Authority-Analysis: v=2.4 cv=YqwPR5YX c=1 sm=1 tr=0 ts=68273807 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=NE3O20gFojlDAxTRfUcA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186

On 16/05/2025 13:19, Theodore Ts'o wrote:

+ Carlos

> On Fri, May 16, 2025 at 09:55:09AM +0100, John Garry wrote:
>> Or move this file to a common location, and have separate sections for ext4
>> and xfs? This would save having scattered files for instructions.
> What is the current outook for the xfs changes landing in the next
> merge window? 

The changes have been queued, please see:

https://lore.kernel.org/linux-xfs/174665351406.2683464.14829425904827876762.stg-ugh@frogsfrogsfrogs/

> I haven't been tracking the latest rounds of reviews
> for the xfs atomic writes patchset.
> 
> If the xfs atomic writes patchset aren't going to land this window,
> then we can land them as ext4 specific documentation, and when the xfs
> patches land, we can reorganize the documentation at that point.  Does
> that make sense?

So I figure that we can organise the documentation now to cover both 
ext4 and xfs.

Thanks,
John


