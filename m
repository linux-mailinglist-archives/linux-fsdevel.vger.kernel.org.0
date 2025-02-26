Return-Path: <linux-fsdevel+bounces-42721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24918A46C81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 21:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EE1188D45C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659CD20F060;
	Wed, 26 Feb 2025 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCnpu1vM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="clEGVM1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800527561C;
	Wed, 26 Feb 2025 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602051; cv=fail; b=jLJhHuDSWpYezoqfS4SipT6/WKZhelgaoNFea0eyiCB6pMFrEATKRJzsKzDbo9xK4IgblxAvzqz027VbouR6QGWlgfwRADD8CP9B5kOOoImIim6hDIIpjwc3haPGVev59+sijCowlNAuc6m7qgW6Bw6vWYuoK2fmq2p5zlVetnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602051; c=relaxed/simple;
	bh=St2DWvD6w+ebMp4SJPyLdGYYxjJgaME1nFpakRO6so0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G4AwBu6qu0XzdXDfIR4RYf3Ve6aYy34oIZWuQ8xTLdibg8k6hugjum4QQNMkijpfaf1acCuQTwH1UJ7Ypuiq+FXy4qKHeTPKQ3dPshT9+NIaVMJ5IVdVfjlbPtIza+f4Ftl2zEIidm7i5CYRDt9jlpqGZj60dXIl6dHxogRjwcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCnpu1vM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=clEGVM1Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QKMc2j005163;
	Wed, 26 Feb 2025 20:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IlUPCGxG4hX3EygbxbRHMr8F+F2vrZE7VSCSVd10is0=; b=
	NCnpu1vMOCTMimfAHm6+kmq8XSxVeaC2+y2WbOjvbahMJiDsMydZy6JsNK+MeOdi
	f53Agjh95A2JDBDq01b3NlVUgutg4g8zfjbSaV3ZccIHKeMIxvIdCCgnA+NqZEqT
	BszJEmH6N4UYYXn6RM5JtY02BKq8WHI4vqC6RcTXEnkwzrMgqcuORRB/kILtzfpz
	Uah+P6vHVY3R3BWmOOnMaoL812BCjb8JumLEgrmXuCmxVGa/NMmGk27smDI/qz4I
	0fGsqrIIcvLEqhD9h0r/IGMjIN4bQNB+TPWD+cfOy7PjmmeyJ2SZlEaDTB8ytgjN
	zn6n0Y2VxXonUCLeSPys6w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psca57p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 20:34:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QIk9bp025416;
	Wed, 26 Feb 2025 20:34:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51hsae0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 20:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSx1IaCXUD+DTGVoHzx/zXR+JmFFh1mr7fMDp9k65E/C/ikK/KQmw/6ooKdPmVNTErCilbUwm80DhwgVWKVl0KQs+xER8VT4gciLL3XHAdFX4UjGooAHE8pSVj+kktCasErwHNV53pGUML4NtdJ5IoMw9otD/k9jq7NzUNf9EdiIK+0kpmxR/Kq31kYjAiyg6tc7cizZTdZQ9zfnMrvy43ut6fMbNzXnc+0cYf61273jvRGsCg7nxJXCqhZC0IQ5zbBiNXPW1SbAmghGM3rbcxbbbpP8vMhToiE9BH/mZa+vfDEW6iM02j5jxcMgBMfPx/aRstssMloZIPJPanK5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlUPCGxG4hX3EygbxbRHMr8F+F2vrZE7VSCSVd10is0=;
 b=av7eAHt05Dgr0IynMg60dA2eG9j+8CyqwPXi7dAPWSYpjvqA1BrvEc5I9YV2z5YoIJqPsMIOpnLotQQSV/LR/84BXu3KXeNjvYDl1c9qXLGAuu4qnLaWGnBlITQ1pO64VWJO7GNvViMTH6htC2ICTk0mvk6uW6lOGw2ZMqHX70kivi2kvJjjpAJkq1TnItsAatBu+dpFkKUzK7TUKKMdNSllrdyC+mmoegVTubohD2YRmwwLNRh+czS38XVVpyOkNepxfPrSKH/0urgc1o3030iTKrPcchdZJLWzsi/dT5ZAfJVIpRCoelOv/7UNrWC1UouXIbfnGH+VijWFuFAVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlUPCGxG4hX3EygbxbRHMr8F+F2vrZE7VSCSVd10is0=;
 b=clEGVM1ZmRg1YbXKReQX/OXZxo1a3FJEQSBQmLVVa331t6G8rE8c69QtVgFON2hIsQen+tDHDSyoFdFCzKMY+1Emn51MJBtRILvtH2bY9aXCa5CybWOHTM3cbXMssNpctSksdFtXM0LPzFRUJhxaCqh9YWnWyUyUOdcRA+L2Oo0=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CY5PR10MB6010.namprd10.prod.outlook.com (2603:10b6:930:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 20:33:58 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Wed, 26 Feb 2025
 20:33:58 +0000
Message-ID: <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
Date: Wed, 26 Feb 2025 15:33:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>, Takashi Iwai <tiwai@suse.de>
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
 <2025022621-worshiper-turtle-6eb1@gregkh>
 <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
 <2025022612-stratus-theology-de3c@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025022612-stratus-theology-de3c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0032.namprd14.prod.outlook.com
 (2603:10b6:610:56::12) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CY5PR10MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: eaccdf3c-150a-4b0e-dd37-08dd56a4e561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmkrZGhVdUh4OFZMdTVoUFRVRGJicS9lSCt4VklCNHpNVmpKT01aM1RtcGNP?=
 =?utf-8?B?eXdWWTh2eEJyWVgrVFgrMGdoRGJmUnd2dG04RGRobFNndnJPRWFuVWd0dk0w?=
 =?utf-8?B?S1puQkRxbTJXMk5hMzVzcWpEand5MTR2VVJYWVozRStBZXpiOUVZZXV4Wm5r?=
 =?utf-8?B?Vy9aZ005L2cvNFYwWWV5WVlIeWR1RVpSZi81MGQ3VkR3cXpNRHI4RFFCMyt6?=
 =?utf-8?B?NFppUEptZnFPWUNsNlhCVW9rYzllV2d2YktKNkFjTHZ3YnJvVEh5Nnh6WC83?=
 =?utf-8?B?a1U2ZDdIdFNFR3c5S3RWMWNBcDg4Q0FxV3l2TThTK2dBdHd5M1R4RVZoRWw1?=
 =?utf-8?B?R3BDSkJwQTEzL1FMeUJxQU1JczczcWRqMElDY1lvYmVCL1E5cXd2Y0dvYUFY?=
 =?utf-8?B?QjVXTW12ZkExZVpPV2dQV1owMmtZZmdyM2F4cDZuMUlKUzhpbTF2ellPVXQ4?=
 =?utf-8?B?Z2ltYnFZc2JLclkrTnJUbzdkd1NHWjZmcHV5UUdMNmtRMW9veFFUUFFXQ0xY?=
 =?utf-8?B?WjR1SElFZTZBNXR6aU1IS1pFZHdaMVdYMW9pZGowOTFCdjhTblh4TEllM256?=
 =?utf-8?B?MFF5eXBMRTdJakY3c2p6YUJSUU1EV3ZTeVhTYWFmakJLcTMxcUhESTM3eWk4?=
 =?utf-8?B?QWlTdWdOQzgvVUVNZjg2NWR0aFh1N0VjaktvWnVSVkREYTRxcUhzamFHRHhN?=
 =?utf-8?B?RDJLZFVUanFWb3JuRzNBZTIreUFmaWNCNm1qTE5wenNoYkFBNTgvcEdQd0c5?=
 =?utf-8?B?LytHVFhJOWdQT20wZS9uMUFLSjl3NU9CMTVxWTI4VVZGZ2hjTnN2RkoybXRZ?=
 =?utf-8?B?TEZmSldhZWI4S2pDTHMzUjhlVjB6dlF6T3VHV3JPaFY4N0IzZXJkZFBwWUxs?=
 =?utf-8?B?RmhzNy9aeGNqWFpTRDA2R2kvN3BTaktaWndhTjVLRjNWRm85MllnVks0M2RJ?=
 =?utf-8?B?TjZIZHpwaDBVSm9WYzBtL3pyYXVXTmFHOC9DN2drSUpHeVlyT2RHVndsTGsv?=
 =?utf-8?B?TGRJaGdpOWtFSFA5VTR0LzhLa0R1K0dIRDBuRlpjVjhDVGl6OC83Y09FMGRD?=
 =?utf-8?B?Um42ZmpFM01sSWRkRDhZRWFXR0MvRVhFZTdUYkVRQVRFMTc4Z3NCaGZNQWd1?=
 =?utf-8?B?M3NQOHozUjIwT3NOVU8zd0lxMkdoUkVPNWFCS3pTWm0rcXdNdjVSWEVoOThU?=
 =?utf-8?B?Y0RXd1NIdGRxVWxaRnZ2TXF2eGk4OVNrMml0cHFtZGhwVVZIdWJCWWgvSXVJ?=
 =?utf-8?B?c0VrdWpJaUxYdVJXUTJwcDRhTmhvQW50QUlndFNhVnFrd3E5MG43YlRUa2VI?=
 =?utf-8?B?S09wUXBTd0t5dElpZnZuZFIwaHNSTWNjMFpjUk5pWFM1Ny9yYTNvUjd2TzRk?=
 =?utf-8?B?eFYwOGRDMXZYNGZ1YnhNSWtlU1h3dFdKWmQ1ZXRRWHJMMFdFaTdEeFdXZVNy?=
 =?utf-8?B?eU42RnVhZlJWNlVRUWJiLzRwSVNHV3gvQW8zUlNudDFjTTlCUTBWQ281aFp5?=
 =?utf-8?B?YXhnTmdseGpwMVZBdGQ4Y3FhdGNHMWtoSVR6ZXpJOE93SXI2bUx4NldEa0tX?=
 =?utf-8?B?bnJDYXFWZTdzTEdoVUFQb1R4ZjlLNTRnd2ZJS0VBY0hoNU1WV2J1d1lqRmJW?=
 =?utf-8?B?bkYyOXdNSkN5RGtMN1BNSmIrTGZ5LzNjOFo2U2lydXpLZURYR2dYSVNIbUE4?=
 =?utf-8?B?OGp2ZG1JK2pvL0QvV2RHbVFrUTlNbVArQndQQkg2YU9tUlFBeWFCYmplRVFS?=
 =?utf-8?B?VVZDaG4wemNvb0hxRFVYNnlmeHdtQmg5Si9lNUd4aTVjcXhNTGlKWUR0ckN4?=
 =?utf-8?B?bXpFVnpGTERuNHBBaWtuQ2lkcjJPcGFmN3gvSFMzWUJOQTk1K0dQTzNGS1NM?=
 =?utf-8?Q?IkEyumBobo4mL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3N4blBSaWhTWVRVQmJRWi9PcXNMSzFkNmhwaGpVUzJYVXdTd0pBYTk5cnVk?=
 =?utf-8?B?RlNnR1hCUUtwYmxNTjlrdGRCR3VEaVc1a1dFaDF0a3NmMmVPL3hRemJSZlIr?=
 =?utf-8?B?TGN5eTJRcDN5YUt5Nkl2REVmZVozaDRhSjFoM0xBQnd2OTlXYWJ5aEhPV29N?=
 =?utf-8?B?VXdKdy9nMXh1OEZvb3B3N1pmRkpMUUpvckdobEFTcTE2bG9NM2p2YkQwZnpo?=
 =?utf-8?B?NmVkY0R3V0lGUEMydUtUMExvMHdFUncxSnVPVlJhOHVUUGM1L1BFU1FXVWNk?=
 =?utf-8?B?Z28vWE50ME5sQ0JmZGkwQ24wb1ExU2lPNThKanFIVDlibFBkaTlwVGlWNXFI?=
 =?utf-8?B?UkxVV2o5MWJ5T3huQ1Y0ZGw5RFJDYjBJYVc1YTVlK09FNXd1RGxna3IvWWM0?=
 =?utf-8?B?OERYYnBUUlU1Rk1uRXZrY2QrWmliZVRCU2k3Z2Y3N212VURaamsxSk9wR0lZ?=
 =?utf-8?B?S29oZDBiSTF4dldTams4bEZxQW9uQjdIOVNoS0FRWmVOcU9zRmtrSlFCVDFv?=
 =?utf-8?B?dkdJbERwdTcwdmRQWTIxVktBeVk5d2VhNVhENXRuM2dDbWFPSmZsKzREVTJr?=
 =?utf-8?B?TzlRSFBVUHBwNFdSVW5EZ1lVUVZrS04xSG5SY0RMRUZDY0UveEEwY0owSFZT?=
 =?utf-8?B?K3F1ME1lb1hGOTk3cXJCVGZSUzZQOXl5RTgzdU5Zcjdva0lqdkFwOC85RkJT?=
 =?utf-8?B?ajZxQ0MzVDJlRk9nbzF3eDRXLzZDT2ZjYzNPbWY5V1VrVHc5aEsxdld2bWhv?=
 =?utf-8?B?N21MRFlDUFlVQVZtQW9wMFoxaFpva2hBWWxjbysyRkkzSzVtSTNGQUxyK3RG?=
 =?utf-8?B?ajR6VXhDVm9ibUNCalpmVDhJNmRwdmV0SG4xczl5WnB6Q21HRmJiR2gySWxq?=
 =?utf-8?B?OWRvZHNjVzdxVUllSjlPVlRYWXlkc0tQeTZIOWx6Z2lQNENQVE5iK2FhYlB6?=
 =?utf-8?B?ZWV6SVVWazJBWjV2U3BkV3IzOUJKMnZHbHJ6SmRXOWtzK2J3YVpSTklXdGdZ?=
 =?utf-8?B?TXY0UFhMWlF5aGJyb0M1cTFTZUV4czI5dkZoZUVJSnJSdFVLVkRGcFBHQ2NX?=
 =?utf-8?B?eEk0YXZhQ25uTzZLZjdXN0pLOWd0VXlnay9sVDg4T1lpdUdzcmFwWVlWSXl3?=
 =?utf-8?B?S3huejhKbFJFcjVhKzJyaGVJVWR6bEhnaUI3SXl0emo0Vmd3U21Fbkcwck9V?=
 =?utf-8?B?NUE0ZTJkeWhmZk1ZL0ZMR01Wd3VzbDI3b3RQN21XMFBlWCthU0s1Q3NYLzlU?=
 =?utf-8?B?djhmZzFPaXBkOStJd0tjekliVzRreVJLbHFzS2ZHUU1iNHhOTE1vc3Irbklh?=
 =?utf-8?B?TldzanJjVHJhY2dpZHUxNFF1M0pXMkU4ZkIwOGdOWUxwaTRiSGREeWtjQUhy?=
 =?utf-8?B?Mk5hR3h2ZjM4MEV2TnB1VFphS0dNcWxRVDBvOEZOU1owbVdSa1ZNYjkxUFg1?=
 =?utf-8?B?cW5ISE9uQWhvbUFSNTRRQkdXblZlcVBsVW4yMkovZVVuT1kyYWxuOFhhZGlt?=
 =?utf-8?B?MGp3bG0wY1NIanFHNzhLSis0RmpkdCs2amVyRG1zUGZSZURsM2hXejExRnNZ?=
 =?utf-8?B?YVp4RStJcHlFa0dTdWxQTTFvazJUWWJHdFNhNkg5WFBkQXFBNWg1aHI5QnhX?=
 =?utf-8?B?aWtxbFArQ3FacXBEM1A2d05ZbVZYT2NVZitYY3l5T0lpMzhSTUpOZi9BWWhV?=
 =?utf-8?B?QjZ2aTVBaFNhTnA5S2FSSkt5anhsbVpDVkhHcVU1TEZtU1cxeTl6TEM1RUti?=
 =?utf-8?B?TVFyQzBVeVpMRFJCcU5xSXFqS3BOMUI0ZjgrM2tsY2JmNG5OakdFbDdpOVQr?=
 =?utf-8?B?SHFjbDZYSkdhbG9HTkgyYWhhS3NxbGZSQlNvL1lGbFZ2MkpWZWhYRFJWMG0v?=
 =?utf-8?B?RkJrOE9uZjcvanZHNDA2Q2s1RVZ1cDBRMXdQOVFUNFRQdXFMQmw5WkVjdVRC?=
 =?utf-8?B?ZXpUbXFjdHZFYUZ0RW1JczQ3bXBIeTEwQ1ptRHVlcnNobVh3MGQ5UERUMTV2?=
 =?utf-8?B?anJncGFMUVJ1bE5TSU4weDlyaWlxVDZCMnpIclI4RmtrL0R0UGRTaWFhQU5J?=
 =?utf-8?B?WkEvbEt5S1JQRUJvcXJoTmlweTJVSjN3Kzh5YkhHekM0bTZ0Zlk4QzZxT3R1?=
 =?utf-8?B?QmhBdUtnZStSWG9XMk85OFZLQmd4ZndLYVpoWVI1M1BCMXZRUlJUbkNTbEgv?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EVR3/FGeu+6dMNhQB/bSFBwUPLWX+iuDrc8kSYE/ZtAeFGZi3auLU/Xt4LZdJGwalp/PF18Ev9/MIlubbjl2QP9eWiegDv7Bq3ndlT6UZ52riyTb4SZrwS+dKNTY31+QVJ10Wl2koX9dMZb7gKvyhaa7dCIOw+jak1kzKlmgEevgC6izZ7ktMsOukzAyC+MHXvH7EZrjpN7oP0snjS7kYobqGSnNV1WZ5FOzbCM2AHiFTY4HM9oKm/6zp9omPIz8nAAlvhAc+GjD2ZJn3Gge6mTOoDsukxKQ3fAX3eIA5lQRBKWiqxGLl9Ju0re2cYEux/GrYWcK/dk1Y7xsP8JANnB7ynZyHfB9Op+4WIuCX/OS91K14KckgZDnLNfO1ZBpb4wpvYR8RPbOZTfnKBuPxnc5gvXMPIgRpe6L7ONlFxKAx8du73TH+KbVQE5P0jUtAxGT6NS97VNEk1MZ/KS3m8T3+HWUi+Zw6G9bBsonZaSbP4f6TbLTf/favI+opEeSdyrzH5ieA517Nad1vS0tDExfFSOojSai/Xc+UTtYXv+6mj0H/nMxhKSCcC+eQWQ25GUY3jdbjWbn1snM22GEMMyiVx/qnBapHzZOQ4gStco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaccdf3c-150a-4b0e-dd37-08dd56a4e561
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:33:58.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/DrjR3zT+ezREWjHsqVkM8sgqoYxxDvIBxXBhZcuPADvYt1zc0Fhw4OJb2amKhrkVRLjTvlhc6S55mjOYXq/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=633
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502260161
X-Proofpoint-GUID: FgZqitwWkDxw2Stf2eeNsT9JeRKulObc
X-Proofpoint-ORIG-GUID: FgZqitwWkDxw2Stf2eeNsT9JeRKulObc

On 2/26/25 2:13 PM, Greg Kroah-Hartman wrote:
> On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
>> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
>>> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
>>>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
>>>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
>>>>>
>>>>> There are reports of this commit breaking Chrome's rendering mode.  As
>>>>> no one seems to want to do a root-cause, let's just revert it for now as
>>>>> it is affecting people using the latest release as well as the stable
>>>>> kernels that it has been backported to.
>>>>
>>>> NACK. This re-introduces a CVE.
>>>
>>> As I said elsewhere, when a commit that is assigned a CVE is reverted,
>>> then the CVE gets revoked.  But I don't see this commit being assigned
>>> to a CVE, so what CVE specifically are you referring to?
>>
>> https://nvd.nist.gov/vuln/detail/CVE-2024-46701
> 
> That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory reads
> for offset dir"), which showed up in 6.11 (and only backported to 6.10.7
> (which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
> d_children list to iterate simple_offset directories") is in 6.14-rc1
> and has been backported to 6.6.75, 6.12.12, and 6.13.1.
> 
> I don't understand the interaction here, sorry.

Commit 64a7ce76fb90 is an attempt to fix the infinite loop, but can
not be applied to kernels before 0e4a862174f2 ("libfs: Convert simple
directory offsets to use a Maple Tree"), even though those kernels also
suffer from the looping symptoms described in the CVE.

There was significant controversy (which you responded to) when Yu Kuai
<yukuai3@huawei.com> attempted a backport of 64a7ce76fb90 to address
this CVE in v6.6 by first applying all upstream mtree patches to v6.6.
That backport was roundly rejected by Liam and Lorenzo.

Commit b9b588f22a0c is a second attempt to fix the infinite loop problem
that does not depend on having a working Maple tree implementation.
b9b588f22a0c is a fix that can work properly with the older xarray
mechanism that 0e4a862174f2 replaced, so it can be backported (with
certain adjustments) to kernels before 0e4a862174f2.

Note that as part of the series where b9b588f22a0c was applied,
64a7ce76fb90 is reverted (v6.10 and forward). Reverting b9b588f22a0c
leaves LTS kernels from v6.6 forward with the infinite loop problem
unfixed entirely because 64a7ce76fb90 has also now been reverted.


>> The guideline that "regressions are more important than CVEs" is
>> interesting. I hadn't heard that before.
> 
> CVEs should not be relevant for development given that we create 10-11
> of them a day.  Treat them like any other public bug list please.
> 
> But again, I don't understand how reverting this commit relates to the
> CVE id you pointed at, what am I missing?
> 
>> Still, it seems like we haven't had a chance to actually work on this
>> issue yet. It could be corrected by a simple fix. Reverting seems
>> premature to me.
> 
> I'll let that be up to the vfs maintainers, but I'd push for reverting
> first to fix the regression and then taking the time to find the real
> change going forward to make our user's lives easier.  Especially as I
> don't know who is working on that "simple fix" :)

The issue is that we need the Chrome team to tell us what new system
behavior is causing Chrome to malfunction. None of us have expertise to
examine as complex an application as Chrome to nail the one small change
that is causing the problem. This could even be a latent bug in Chrome.

As soon as they have reviewed the bug and provided a simple reproducer,
I will start active triage.


-- 
Chuck Lever

