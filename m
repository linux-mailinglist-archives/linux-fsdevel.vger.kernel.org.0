Return-Path: <linux-fsdevel+bounces-38674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A8DA06692
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 21:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03208188979D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35F12046B5;
	Wed,  8 Jan 2025 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nk0yYdRl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hGboOs0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA01FBC99;
	Wed,  8 Jan 2025 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369037; cv=fail; b=NhVlnOMBNkBn9loTXOWKIoR1noCzTOd1wNUnzMFClunS1zSh9/RT/OC10qDo3+EDsGeXApXhqGAgphBdu2tnFkKQSYDDlgkHSIAKslqV3vBPErVoqG9ZRxO1U9G3S+M77VNOpXkuKYCUbe+vHhm0Fy2f8I/j6nUZeCPaWf7PSSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369037; c=relaxed/simple;
	bh=dXmkS9amhX1esXkRkr/42aZpw3TTtXKof+PjAf1ALqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b0+EOXxsaPY8DcdnFJd1S5NrVUPj15FlTeSaQjW5ti9tNbSe2eoFRF1DufzluPal+5n3yTu4O8FMzvIJeTHf/mJBRnLFQPlrWSkmHkIP6Ib4E/jMKYmKNGdTQJPbpfSlpT9BSzLjmyvqsD2HI9/Kg7vHtJ2n6vjlV3rKGW9iUIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nk0yYdRl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hGboOs0e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508INQoO001255;
	Wed, 8 Jan 2025 20:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cV5bdfxdfcO4MSCTresIAILf7dQm6zgGeXfI6wiZsGw=; b=
	nk0yYdRlBvLdgu2C/Gt3SUj3YhKZffu+LBDx6PcHxT+9f1JX8Ag54uxhd763xp9e
	7uGEwOGWdsAGkz1GB92nh9yYPz01uy2A3cKXzrLfv9t2P/HTgjaK0g9SOpLTRrGO
	nNKjpvmGFsUyBU41iOeWu4w63oT/6cnHx+zOB3UrfIUPkR6unpEqWYDrAmbJT2eW
	RhKBmV5Re5TuwiEkoP3XAwzks7qjoqpfsONSeC32Q4U19FTi5Y/6+5rfSlyqzIPy
	ar/xwCabaQ3RWHsqEbcIUmkoWaZB5n8AxBKZqI/cH5DGKwUofKmRqRpSBdtpd0AH
	ryd2igp78notOos0ORpgXg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xw1byj3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 20:43:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508KAdx8011015;
	Wed, 8 Jan 2025 20:43:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea2jvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 20:43:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOI+XDH4lLXia7ks9/TiWamR92MB+fjLz5jTT2/LlAxX51ETvkXY861DnzHDBcW51YH7zVRroQDB7EZGKApnH57Qv5dvBOEaoDmjd0e3XXTNTjJJqnNqkbdQJE7eq+bR4P1OsOFQAyJBRq8sRbYHROIy9EriXP8AlXyJRG7DuKuvuML0B8yGZAEMeRuy7x8JNeqCA7Y90w4mYERqdtT/CwEWGEJcr3mQOpJfWnZOt8LNCUEzz059k3yVEkFspJWpiW9fWRvXDLOl+sQTdmIpEO9TwzT7jtHu+BUy/Si8YI+YkWPSRt8rQmeUo03lYC5RMBb0SLKtlwL7lGBIn7dSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cV5bdfxdfcO4MSCTresIAILf7dQm6zgGeXfI6wiZsGw=;
 b=hSO090Ae1PWPtBJRd67ybfeHEhcPr372iUD0SPq6kH1/nv6Dr1GOEsRM094YfaaeyZkBg/KQrk4d/OW6rhfmjhcPIen5tfm1eNTBaLiskq+T0V4m60I9WnL7f9+GQTfpPiRKmxNBGukJGxtP/NE68/lHzSgAv2j8JcQTtkC15GdD85GyePAfofEM0QUQuk6o8zvxlhTnxSUW9+2HpbuNqgsRvyw7roakHS4u4+Gp19ha4z4p0nBKYoyDbaYjl4693/eYFzhtMZwBthpimPSZ1ws/cU36UKNPTfzmhRBtDMOiYXEpVZdQRIpo5lqXp2xrT1iCpJ//7ZgjzpnbNOg+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV5bdfxdfcO4MSCTresIAILf7dQm6zgGeXfI6wiZsGw=;
 b=hGboOs0eqwexA+UQFGqHw6OdRYzgDdJmVU8Q0mJi6Zn8z3Zc5eI5IAXPayzWeyCbSlq0IRNm+Ykc8mpWOhF2bfpVloT+0NCogc0N0sCQi7Xv1SxHuN4dGXXiXu/SH9m1ad4nkdUSG9GJ2Zj9+hn9BSSOIqRC0FrKYAPtJSNqnlU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CYXPR10MB7950.namprd10.prod.outlook.com (2603:10b6:930:db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 20:43:41 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 20:43:41 +0000
Date: Wed, 8 Jan 2025 20:43:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Jann Horn <jannh@google.com>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, surenb@google.com,
        kaleshsingh@google.com, jstultz@google.com, aliceryhl@google.com,
        jeffxu@google.com, kees@kernel.org, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
Message-ID: <7e508a01-7d77-4065-8656-e5e5a551fa5f@lucifer.local>
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-2-isaacmanjarres@google.com>
 <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
 <Z3x_8uFn2e0EpDqM@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3x_8uFn2e0EpDqM@google.com>
X-ClientProxiedBy: LO2P265CA0304.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::28) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CYXPR10MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 4275452e-d55f-4c1f-407d-08dd302522ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlZMdmVkQjIwOUJwem5jWE9rQ1VjT1RZYzJWbmVmN0N3VUlBTHNpK3BUS0di?=
 =?utf-8?B?ODRaQ0pkLzVDVk1ja1lFcGJIaXlGbEpMRXUreXlpRWhVNDJxL2Y0ZWFlWjN2?=
 =?utf-8?B?YWxvQ0JUdjVIVndISHlJRjhxZzh5MlMzanVXWHhxNmFqWjRhZDRtaDBQTXpJ?=
 =?utf-8?B?OU5jMStGM0ZLVFQxcFoyWTQ1eHlkVHRHV0o0bmFIblZJTVlLQTM4eFZxbUtl?=
 =?utf-8?B?SllQV1dHbmpZRU9KajNzeHdCRTE3WEdtajFwazB3MmxyR0FXYXdTZjNzbzQr?=
 =?utf-8?B?c1IzK0VXWUNadEZ1TVhoTGRDK1hwVUUwcmtZTDZWSmVUS0p0Ky9FVW4zcVBJ?=
 =?utf-8?B?ZXlLUkxLSXVMRlFiOXpDdjlMb1BLQ2VSQjJOL1ZGb3dOSGxFeWEyUkdobXZ1?=
 =?utf-8?B?cG81MjgxdTN5ankwaVA3RVFsUEVFTEg2QVhyRXFCOXhsYm9jckE1NDVITlY0?=
 =?utf-8?B?dExqNW5QdXhhbWs1ZHdlaWZIRGYvZWdia05lTGxrMEdnYm4wT1lBdEx5VXBJ?=
 =?utf-8?B?d2lwbCtKalFDWW8rek5jbjFhcTJ3K21IUWJKblFSNkV4OHFLaUdnQTFUWnFh?=
 =?utf-8?B?UUd0YXRncW9IaWhqSkRFeTlLTXZsOHVYWnE1QjR4N3dDbVdSR2hBQWFlcnNS?=
 =?utf-8?B?UTBMZWxhLzdGK2gwc1c3bUZOcHVmQXprUUlIZVhjTUV2aTg4dksrQm5uM3hq?=
 =?utf-8?B?RHBzeFdmQWNJMWMzWS9EQ1d4SW1rNmVDS1RNOTFPVm9sQ2ZqRlVrRGYxMlhV?=
 =?utf-8?B?WDVZcUMvOWZWclR4UmY0NDFWTjFSekQrbWo2L1hBZDNHSUxRWnZ6TGVUblhV?=
 =?utf-8?B?aXo0N2FZaGlSWXB4K21uNzlML2dBUUprYkltNExiWW4yTkJYSEZHTjUrVEJV?=
 =?utf-8?B?UlErdStuQTJVdG9UUThtdFR0c3lHcUhLbzVFS2JySUIxU0Z4V0RTa2RtbmtQ?=
 =?utf-8?B?SmdTNGxERENUOE1lak9TVmZNUUhhRVNtbElyRUVtNzBIWjhDUDA0NW5oQnR2?=
 =?utf-8?B?TmN3ZXBMNVRqSHZxT01FWlNRbEhkMVN4b09CUm1sUVBhcERYVllvU2VtVkc4?=
 =?utf-8?B?RUZjeEk5UzgraHA0Ri9vWmhYODFVZFNZaVdTQW9PNDM2S2JlNjhhOENZRmYz?=
 =?utf-8?B?cG9mVlZSdmtVTW4xblRJc0gzUHpUODVnRytBMzJQRytLMjBHYnd6VStmS1dq?=
 =?utf-8?B?cGtPNEhBOGc5QnNvbU5WbDIzNEpVOE5hYkJyNG1tRTFscE93M3B5SU96YUdO?=
 =?utf-8?B?RkUrU0Jxa09ReGVNMy9NSXFKcnBQdDd3bEQ1OEJ6QVVFUFY4TzI2OEpJZ0o4?=
 =?utf-8?B?V1I1QWw4SmV1eHV3ZThOSXlqQWcycW9sSWg1R3pJUTNZbUJOVnc2bmpWSXZn?=
 =?utf-8?B?UDBySEI5NTBmNXJVZlBDM0I3NWFUREFWZmxOOXIrS3pMS1BJRHNpMWlvMXFF?=
 =?utf-8?B?bU9uWXN1ZU00RG1FSE01MFJMck5HVlBvcllqT2FVNnhROHVRV0ViTFJlYlBD?=
 =?utf-8?B?MjdtSGtmdFc3VnpyUldVTXcwaCtjczk0NGd0eC9OSTVJdW4xTFk3LzczKzFS?=
 =?utf-8?B?L3VrQkllODRVU09LTmdlVWlXRWNzOTNUZkxZVkVXNEo0ZTVXcmo2eW5wTnVB?=
 =?utf-8?B?ZW9DMldGeWgrRGZGUjU0UGd0V28vUVd1YWptNmgwWUUxaGlWNkJYdzlMUk9h?=
 =?utf-8?B?TFd4bjhHSWZ5WnZtTVZLMmpxZUtrekt6cVVJNkdEdGEzR2RSWE1tdVVNZWpm?=
 =?utf-8?B?QWpabHdWUzVOY1JsTHpkR05QazBQU1J2R1NqRnFrSkpia2lMZk9lRSsxYUxy?=
 =?utf-8?B?bVhzaFBOZnY2M1pQcTFsQloxeEJEd2d0MGx4N2VKOE0yVGtiUG5zSlpZUHNZ?=
 =?utf-8?Q?o90p5aWQEgQ9K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1I1aGx0Y003RGJGQkF4WFFhV1AxSzhFSjZrdHdJVXpUeGEyNTVtZ3BtWnZS?=
 =?utf-8?B?bzZka3libTc3YXFFYlY1SGxqZW5PQ2F3RmpMSHpVdzVCaUU3OVhMUWw0c04r?=
 =?utf-8?B?UXhuRTY5K2Y5SzJvak9XNm1ZQXpJRld1bXQ1aURhb2hXTm5DNkg2dUdDbUd2?=
 =?utf-8?B?NENnb3RGVHdmeGs4TTNzdGNpMlNrSThzS0Q0cURGaUVHMGdUcTk2S1NCN1dV?=
 =?utf-8?B?S0YwaktaUUpLQnVtRVZybkpmbVFjc2RRWGx4YWE1SnlYbGtnNGt2c0E2alBK?=
 =?utf-8?B?SmZ6UVNIZTRONjh6SDFvV2FjcGRLY1d4N282MXJnWVNWWS9NUU1pWisvdWNM?=
 =?utf-8?B?bkxDc2NtbXVzcXRremJ0Nk5UNzFTNEtrRG02Wmp6SVp3ZFlZNUx1RmdyL0tu?=
 =?utf-8?B?R3NOQ21XOS9xNS9ISHJRZkorQUc0QU5sZ0RmKy9YRVM3cHVRTmFpU3RVSXVl?=
 =?utf-8?B?c3RkNXNMcitsMkJPdUZJa0w3YytUOXVpR3RydFBNNGpuR3Y1M2g4UmFVSWJk?=
 =?utf-8?B?OFN5WDVLcXBBY1ZRZmJHOFFCUkVWcytiaVg0azV3YkxVbVROaWNUV1F3SGho?=
 =?utf-8?B?SHRWSlJKYmY2aWxId2dhb3c3WjRBb2xIcDMvLzdtcjhpN3grZXNmM0JPREN5?=
 =?utf-8?B?dmhpb3pQTXZjQ2FWWVE1NEo5dXpVczhIZWJTN0ZnVVlBZC9ST0FQNXAzUlJX?=
 =?utf-8?B?SFhJM0dMU0dYSTBRS3YrTDRyUDFwVGllRDNYWE10Rm1BSEhxWDl0QmYzUTlZ?=
 =?utf-8?B?bnFjR0ZLTlI3c1VhTHVsbksvM0FYdU1QVE5Xa0U4bTNNTjZGYTdtR3dqSmdG?=
 =?utf-8?B?M2laaCtVTlZUcnF1TXZSS3E4NkdKWXpBdGtQUUhWd2hpdzdtOHNWODdlMkUv?=
 =?utf-8?B?NHJqcGcwVUU1Ym55c2IrUFkxMnpEN0d5bW1rVEVBb0w3SXVkWWV5RHdROTQ0?=
 =?utf-8?B?U05ZSXZ4U2Q4REFSQVBtS0oxT08zWEVtVE15WWNHZDR3bXk3YkVDWDR0SmhL?=
 =?utf-8?B?VTBYbm1RQ3phem1rZksyTmRMYnM4ejZaOGhUNUlobXE5LzhkUVVlRUxoVTJy?=
 =?utf-8?B?LzJEZkFQeFVPcjZiazhuYW93TjVDckxHc0RoVzFXVFY5Snc2NjFPczdhd1Fj?=
 =?utf-8?B?cklMSTRHV2h6aURxdEFZQytYdnpGSDA3S29JdlJkR3RuR05LZ3NIVHpEcktk?=
 =?utf-8?B?cHlNNldvM3ZWTTVUaFlZaC9JeUg2bE00cWdVMzNJZ3NacThReG5scldMVm45?=
 =?utf-8?B?WWxpWnRkMitNRUd6UWFYNzR2eFVPd0Q2SE05eTJUcVpCNmpibXA3d0s3UCtI?=
 =?utf-8?B?ZlRsa0Jwd0IvY0RMcUc1M2dZdk1jeXRPbFBFcUdGT3NQYTlZWm91Y0Y2R2py?=
 =?utf-8?B?cEt0L0tCODNQamNFak9hODJWSjZacUV6aDJvazRzRStPUUp6OFhONmRSMEN6?=
 =?utf-8?B?ZEFYc2VuSjNkUnkxdVN1ZWNLa2lFZUp6T2VFeHVqQXIrS3hNTHNkV0RXaVhS?=
 =?utf-8?B?eW9tYnJhRlRnVFNnYkQxYU1IcmZONjV4ZVB4cEFzeE9YT0ZCS3NPK0VyeFBr?=
 =?utf-8?B?RmVCSzRiUkEwTGdkVWR2TTJ2QnhMZmh2c0NMUm5kZ2YxSWpIZGlCMjVWelpr?=
 =?utf-8?B?MjVueEF0aENJdnQ1WEhmbi9IZTE3Umt5QXhFcmJ2L1hOekZqWG9qK2xXRGpV?=
 =?utf-8?B?T0xVVTUydEJNTis3SUJiV0JmRDNDcUw3SlpKYXA4cmV2a1U4ZkNSZVFyRlpa?=
 =?utf-8?B?N0tWUnB1a3NDMlpyeUZCMDlCMWhVaTg2V21nYmJCd0pweDFMTkxtbU1zYnN3?=
 =?utf-8?B?b3BVbHkyL2dzL3RlZDBJRmRicW5lRHdIVDk4eUVTUjIrai9vZGZydnpDU3lR?=
 =?utf-8?B?amk3YzZoYW03ZVk4WTM4MlJNdlN1T0d5RTVPckQwbjlGUVpqdjNCaGVXVHlS?=
 =?utf-8?B?aG1aWXdHSCsyYloxWUs0dVZzWngvSkhXY2ZkMmgxNC9mendxdkVYckx5ekcz?=
 =?utf-8?B?bnlRaFI0cFlGWWc2WkZmdUN2Z0lrdnVrdGdrNm9saHgvZ1BvT2tJRVRXQkVa?=
 =?utf-8?B?UTN5MFlsT1FKUzRuUUFLMk05UHNOdWhBc0lTa0xyWUNsQnlLQXlCeG8wRWU2?=
 =?utf-8?B?ODZpYldqY05vSXdRRzU5c1A4OXpQQVRpdUZZTlNUNVhZUExpaFdTYTJOQmVW?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	shZvT1AhNu3WuGr+gcIboHq2ySb+zu+2KdLX2OiV8/ERfaeN3U8f9T/vTxpRESF6113q+SlnHXz8TwgoioP6QVMhgrq1a881tdodDRWBKnsQz9gvKMp8T4AFJCJHIIv/e6cEOOL20U3vm0BdKpkVBOVoJ2p0mlvp70cNei/uZqUR/R1zcTaNSv1swtdAZgDambmgLLa1OLAScm8QQvg9p6DvhZyx2GkNGaovawnu53gUN1zgb/8xfCJbhOrcLvndh3iPTygyTP3p0K5rJ6Vv1/5obyaA+VgfQ3mLK0pEK4Jdeom5KqXKSHVYKIY+ozUwnRrAnOgjkXAKhqKv/9v9OKvXzyfBJJs+c6MZf+zkE3fgWRoAba8XpcBZNQGQDn6SFPjdZ0gftlLGQA3lmeQVe2+GaOm4fE/NwNO0GSsXYTKBAU+stAe7VZ3tbNTn35OgGYNOMOjmv4UoJxVl0bRBPR7J/OnlboNNmsb6V+1oXWXQ5l85Ltc/ao7n95tkGW8MwpVkO+suSA1MaiQOjveTKW+WfCVXrFlB4dVK9Ik/TZ3fuEZrvVGQyLqMCK5Ebj5bFxz31nSC9yE47zeqbOYcxPJMsEVbBigZz7GhmJRWXZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4275452e-d55f-4c1f-407d-08dd302522ae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 20:43:41.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VmQdOHsg2oWN8VPDpmd21HA22/9XLRXkNFDy+kzDlpnsrtY5IbLIdt84aNja2A3cajStBs2o0nPOLaDiyO7bLGinxlOfdAMpG2TkJbqFTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080169
X-Proofpoint-ORIG-GUID: 4AuGqrSa0B-eT21yL0UuwtOM71ZWrGb4
X-Proofpoint-GUID: 4AuGqrSa0B-eT21yL0UuwtOM71ZWrGb4

On Mon, Jan 06, 2025 at 05:14:26PM -0800, Isaac Manjarres wrote:
> On Fri, Jan 03, 2025 at 04:03:44PM +0100, Jann Horn wrote:
> > On Fri, Jan 3, 2025 at 12:32 AM Isaac J. Manjarres
> > <isaacmanjarres@google.com> wrote:
> > > Android currently uses the ashmem driver [1] for creating shared memory
> > > regions between processes. Ashmem buffers can initially be mapped with
> > > PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
> > > ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
> > > permissions that the buffer can be mapped with.
> > >
> > > Processes can remove the ability to map ashmem buffers as executable to
> > > ensure that those buffers cannot be exploited to run unintended code.
> >
> > Is there really code out there that first maps an ashmem buffer with
> > PROT_EXEC, then uses the ioctl to remove execute permission for future
> > mappings? I don't see why anyone would do that.
>
> Hi Jann,
>
> Thanks for your feedback and for taking the time to review these
> patches!
>
> Not that I'm aware of. The reason why I made this seal have semantics
> where it prevents future executable mappings is because there are
> existing applications that allocate an ashmem buffer (default
> permissions are RWX), map the buffer as RW, and then restrict
> the permissions to just R.
>
> When the buffer is mapped as RW, do_mmap() unconditionally sets
> VM_MAYEXEC on the VMA for the mapping, which means that the mapping
> could later be mapped as executable via mprotect(). Therefore, having
> the semantics of the seal be that it prevents any executable mappings
> would break existing code that has already been released. It would
> make transitioning clients to memfd difficult, because to amend that,
> the ashmem users would have to first restrict the permissions of the
> buffer to be RW, then map it as RW, and then restrict the permissions
> again to be just R, which also means an additional system call.

You could do something similar to my adjustments to the F_SEAL_WRITE
changes that clears VM_MAYEXEC in cases where do_mmap() maps an
F_SEAL_EXEC'd without PROT_EXEC.

Please note that F_SEAL_EXEC implies:

F_SEAL_SHRINK
F_SEAL_GROW
F_SEAL_WRITE <- important, obviously
F_SEAL_FUTURE_WRITE <- also important

	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;

Though interestingly only _after_ the mapping_deny_writable() call is
performed which is... odd.

Probably worth exploring F_SEAL_EXEC semantics in detail if you haven't
already to see how viable this is.

>
> > > For instance, suppose process A allocates a memfd that is meant to be
> > > read and written by itself and another process, call it B.
> > >
> > > Process A shares the buffer with process B, but process B injects code
> > > into the buffer, and compromises process A, such that it makes A map
> > > the buffer with PROT_EXEC. This provides an opportunity for process A
> > > to run the code that process B injected into the buffer.
> > >
> > > If process A had the ability to seal the buffer against future
> > > executable mappings before sharing the buffer with process B, this
> > > attack would not be possible.
> >
> > I think if you want to enforce such restrictions in a scenario where
> > the attacker can already make the target process perform
> > semi-arbitrary syscalls, it would probably be more reliable to enforce
> > rules on executable mappings with something like SELinux policy and/or
> > F_SEAL_EXEC.
> >
>
> For SELinux policy, do you mean to not allow execmem permissions? What
> about scenarios where a process wants to use JIT compilation, but
> doesn't want memfd data buffers to be executable? My thought was to use
> this new seal to have a finer granularity to control what buffers can
> be mapped as executable. If not, could you please clarify?
>
> Also, F_SEAL_EXEC just seals the memfd's current executable permissions,
> and doesn't affect the mapping permissions at all. Are you saying that
> F_SEAL_EXEC should be extended to cover mappings as well? If so, it is
> not clear to me what the semantics of that would be.

I need to dig into how this functions, but I'm guessing then it doesn't
immediatley enforce anything preventing an existing mapping from executing?
Which differs from F_SEAL_WRITE semantics and then makes it seem like it is
already acting like an F_SEAL_FUTURE_EXEC in effect?

Hm need to dig into this a bit.

>
> For instance, if a memfd is non-executable and F_SEAL_EXEC is applied,
> we can also prevent any executable mappings at that point. I'm not sure
> if that's the right thing to do though. For instance, there are shared
> object files that don't have executable permissions, but their code
> sections should be mapped as executable. So, drawing from that, I'm not
> sure if it makes sense to tie the file execution permissions to the
> mapping permissions.
>
> There's also the case where F_SEAL_EXEC is invoked on an executable
> memfd. In that case, there doesn't seem to be anything to do from a
> mapping perspective since memfds can be mapped as executable by
> default?
>
> > > Android is currently trying to replace ashmem with memfd. However, memfd
> > > does not have a provision to permanently remove the ability to map a
> > > buffer as executable, and leaves itself open to the type of attack
> > > described earlier. However, this should be something that can be
> > > achieved via a new file seal.
> > >
> > > There are known usecases (e.g. CursorWindow [2]) where a process
> > > maps a buffer with read/write permissions before restricting the buffer
> > > to being mapped as read-only for future mappings.
> >
> > Here you're talking about write permission, but the patch is about
> > execute permission?
> >
>
> Sorry, I used this example about write permission to show why I implemented
> the seal with support for preventing future mappings, since the writable
> mappings that get created can become executable in the future, as
> described later in the commit text.
>
> > > The resulting VMA from the writable mapping has VM_MAYEXEC set, meaning
> > > that mprotect() can change the mapping to be executable. Therefore,
> > > implementing the seal similar to F_SEAL_WRITE would not be appropriate,
> > > since it would not work with the CursorWindow usecase. This is because
> > > the CursorWindow process restricts the mapping permissions to read-only
> > > after the writable mapping is created. So, adding a file seal for
> > > executable mappings that operates like F_SEAL_WRITE would fail.
> > >
> > > Therefore, add support for F_SEAL_FUTURE_EXEC, which is handled
> > > similarly to F_SEAL_FUTURE_WRITE. This ensures that CursorWindow can
> > > continue to create a writable mapping initially, and then restrict the
> > > permissions on the buffer to be mappable as read-only by using both
> > > F_SEAL_FUTURE_WRITE and F_SEAL_FUTURE_EXEC. After the seal is
> > > applied, any calls to mmap() with PROT_EXEC will fail.
> > >
> > > [1] https://cs.android.com/android/kernel/superproject/+/common-android-mainline:common/drivers/staging/android/ashmem.c
> > > [2] https://developer.android.com/reference/android/database/CursorWindow
> > >
> > > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > > ---
> > >  include/uapi/linux/fcntl.h |  1 +
> > >  mm/memfd.c                 | 39 +++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 39 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > > index 6e6907e63bfc..ef066e524777 100644
> > > --- a/include/uapi/linux/fcntl.h
> > > +++ b/include/uapi/linux/fcntl.h
> > > @@ -49,6 +49,7 @@
> > >  #define F_SEAL_WRITE   0x0008  /* prevent writes */
> > >  #define F_SEAL_FUTURE_WRITE    0x0010  /* prevent future writes while mapped */
> > >  #define F_SEAL_EXEC    0x0020  /* prevent chmod modifying exec bits */
> > > +#define F_SEAL_FUTURE_EXEC     0x0040 /* prevent future executable mappings */
> > >  /* (1U << 31) is reserved for signed error codes */
> > >
> > >  /*
> > > diff --git a/mm/memfd.c b/mm/memfd.c
> > > index 5f5a23c9051d..cfd62454df5e 100644
> > > --- a/mm/memfd.c
> > > +++ b/mm/memfd.c
> > > @@ -184,6 +184,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
> > >  }
> > >
> > >  #define F_ALL_SEALS (F_SEAL_SEAL | \
> > > +                    F_SEAL_FUTURE_EXEC |\
> > >                      F_SEAL_EXEC | \
> > >                      F_SEAL_SHRINK | \
> > >                      F_SEAL_GROW | \
> > > @@ -357,14 +358,50 @@ static int check_write_seal(unsigned long *vm_flags_ptr)
> > >         return 0;
> > >  }
> > >
> > > +static inline bool is_exec_sealed(unsigned int seals)
> > > +{
> > > +       return seals & F_SEAL_FUTURE_EXEC;
> > > +}
> > > +
> > > +static int check_exec_seal(unsigned long *vm_flags_ptr)
> > > +{
> > > +       unsigned long vm_flags = *vm_flags_ptr;
> > > +       unsigned long mask = vm_flags & (VM_SHARED | VM_EXEC);
> > > +
> > > +       /* Executability is not a concern for private mappings. */
> > > +       if (!(mask & VM_SHARED))
> > > +               return 0;
> >
> > Why is it not a concern for private mappings?
> >
> I didn't consider private mappings since it wasn't clear as to how
> they could be a threat to another process. A process can copy the
> contents of the buffer into another executable region of memory
> and just run it from there? Or are you saying that because it
> can do that, is there any value in differentiating between
> shared and private mappings?

Yes this is my point of view also but I might be missing something.

>
> Thanks,
> Isaac

