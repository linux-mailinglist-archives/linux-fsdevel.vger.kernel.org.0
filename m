Return-Path: <linux-fsdevel+bounces-42557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17CAA43AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5A31890141
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2426739A;
	Tue, 25 Feb 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z1QVyAqK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i0wq2TEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF7262D1B;
	Tue, 25 Feb 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477715; cv=fail; b=WJ67SffOPlQLgIfiWVLlqdQKnTvptOBsyhv+Jz1tYgYxG912OGc4oa8a4l53c+HxfqJNUNiQyenHh8DcXLmqwfuxiShI91CF7hnzJvk+mALOAT+YEZvlTEadd7MQgLkwJ669gvFjHh0Mc35FOVFcYD0LFc6CEi+wJLZezhY9NWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477715; c=relaxed/simple;
	bh=72kQGQWmg01b/bpZKKbfin1sOOgJEGvCHxAFYGIliDM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SLypCj1KiGsBuLaT2r2hNcJ3qgDfLxTuNwAamykbfdl3QTZEXocfASzHmLfraOO1xeqPs6k0uiEcvjKLfuWidFY5Orefwc3R5Lk0V5HQ4Z620r1M1dGDhs74NW4A1Ltwn06NzHoCjUTUL9fVAvi25aaZBbA+NuVq5Kyn8Dxp1p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z1QVyAqK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i0wq2TEy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P9fbIP009014;
	Tue, 25 Feb 2025 10:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7/n8NcxfHkkBQ5h1Kf6KW/C1l0b/lfnMoEh1bdUwD+U=; b=
	Z1QVyAqKdt9xWNTV3GsZFZvq7ZqmHiPDRN2MvXnLoj/tE+iI0uPJds3jHKv03R+6
	57/LkU/4oqgO8kK9a6EvwmBBFBqbFReocSRpZwsFYgltkfcX0rjfQTCgJnb7iuwr
	nahMD+EAV9FD4FnMBAsY75m5duK0W4zGDGjRS56cPWEt3uK0XpTnf79MY6K9x/S7
	C6c15uWQshef8I+pRIiNUcc25uobXewqaJEF4QrwYKl5OSqBQUxQaTbni+ch+VWg
	Mgt+iyyO9ZKybO3aHWGHB3knUiGh0ucoNscKVBxq7lJjp2Wx2WpITILU9ckT/yuK
	M5CvS2AuDFdTPU/7Sam+vw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gamqgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:01:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7u1rb010297;
	Tue, 25 Feb 2025 10:01:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518ntum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmaA1uUL5f79xfvhTXfl1L9+Ps0+apXLUv1v98pKkfyt+YPTw4cWB5SqvmgmrXq3lhq7qXAuuJG/P+J1UDki4jHezHmSkXNCOwHnSdYNppV3KX28yJ2od95SW11hlwMMbTXFvLcZeX7oQ4jYgBjORZ81rHRPcT7RIukdQwDcDCVsYcwNImKdxedeJfVYHudzS1elCLlknbawUtM7qDj/JKLlo+gzOTgKWN/Hin4CJ3SulDVCW9TFh6u9T5neGpb80Tz2IcenAAudOlUf53E2fEyFOmU/tCBaPIlhp+yPK+qE5MuEMQxHLMBCVRa5/dRIQOj+lIjQgbi7rzxGXGFN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/n8NcxfHkkBQ5h1Kf6KW/C1l0b/lfnMoEh1bdUwD+U=;
 b=V/3RyixIxrcAkQNMy54fjqgbfBDOJIF2jhTt9jE3wVS7ZhtQnB7XbiQibyJrKEgrw2OnSK7DIVpAwqOq4t+rvcRlKj5cwpjiO5ODquD86CE84Xsbfz/Xp7RjyLVoz4myf0vLpj6RrX+iwYGWuEOhXeX3TOesDCSu5tgpG4WlQjKedK4nAQjdK3cIudnS7C+jpGnki+jWxxc4mOAEsc59wjI8v8oqAwdBblhf9DUjW3MRc8ip0CXYBydYeaub8sbHEN77x5PAY8/SYiFbGj3QCCra9dImsWTF8TZhb8y5FkOnXQZ4bDgBF1GFlUw4XkmmNPw4cFcS8oWAgnyt6YMg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/n8NcxfHkkBQ5h1Kf6KW/C1l0b/lfnMoEh1bdUwD+U=;
 b=i0wq2TEynGVMKO2ebsKsbjixBp8lP0Y4LTtmtBmQ+QSlWza1+toVPWBGLzU4MazosVq59gMFUILgLDhDZPgcMUS2YaLA4Un5Z86QejU5oEKs/Gx3U9QIX0A6SkTR03gNmJ8tXw+1rBVQzwVQp8170agMVu89AZkZjK3vjnBjDMw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 10:01:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 10:01:36 +0000
Message-ID: <0c8ba9d8-5a52-4658-abc8-00c05ba84585@oracle.com>
Date: Tue, 25 Feb 2025 10:01:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] xfs: Refactor xfs_reflink_end_cow_extent()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-4-john.g.garry@oracle.com>
 <20250224202609.GH21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250224202609.GH21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0180.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: f3bed339-e24b-4356-20ad-08dd55836418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTVVVWIrMTJKVkV1bGp3RGI0TWM3SmpqdFZsVWtqQW1tYWJrWHFqVlc5VzJv?=
 =?utf-8?B?Nmllem5Valh5b1BhQm1aeHU4SGpsOStIeU04OGpnRGJiOC90K3R4RFN5SWVr?=
 =?utf-8?B?U1dOWDNMWTEzTjFqQU51VVZ5bE44cGMrblRUWDg3dzhlZDdvdGRrdjNlRUY4?=
 =?utf-8?B?OHdFVU5EdVlZRms3SWE1d2FPU0ZrcnJGK0ZpR0dVb1JMWXc1RWg0N2F4TGVv?=
 =?utf-8?B?aDNCcTFPeEJFSlpDbGxvNCs5bXRCOVpLRDhiM1ZLM0FwZlYrOEJ1ZzdTMC9S?=
 =?utf-8?B?d3hiSWJpcGxFWm5ScXhpTjVhNjZiZ3F5a3FRUk8rNkRHR3hzanNwZDcvVmxt?=
 =?utf-8?B?UU1Ka2J1clkrYUFhU05mUnlLSlFtZ0pqdXUvTkQxeHRnWS9RTzdKb2x3L0tU?=
 =?utf-8?B?bisraUFKb3dPQ3VhME5HTzhNZ0l6ZzlLeTFidDBnenBnakU1T2c4Z0Q2R2VW?=
 =?utf-8?B?eUgvSmdBL2ZFSU11WmVkOWY1K1NEVkdkY1JiSVFlMjNvWlRxaXhJbzFWbnVH?=
 =?utf-8?B?QnczbWxwRW9qeXhtaVdtQXNCV2VuZjFRWXVjSXdZOVZSWDJXRW9CdDQreWZZ?=
 =?utf-8?B?NkJRc3JpZ3R1NEtJQkkvNGc2cWVxR2ozdWZrZDBwM0xKRHVNRGN6Vi9HUXJQ?=
 =?utf-8?B?NWltQkQxOEVWaDNZOEo5UGhRVFFvbmE4Q3BKaEg3QWMzVi9QbmFZakZaMU9s?=
 =?utf-8?B?VVJXYW5oL3VZRVZiVzRFSTIyUlBLYjZPenB3dVpKdFdyRnBlUUoyOWN2bU9z?=
 =?utf-8?B?Vldta2NpSXpIeUNPSitDbklsQkhJd0Q2TlhEZzFKaERGc0t5elBKYVpxODlF?=
 =?utf-8?B?YmdZRThnV21HbDRnOHRlTDJoKzdTNWVFQjVCVEhXYStuSlpqYnhYUlZvTGNR?=
 =?utf-8?B?am1RZ2dadk1Sck1ZbnBlK2lHK0x1cGl1clF2N0FnYmlBR0Q0ckNWR1pOMTll?=
 =?utf-8?B?Ym1mUVViYWNoVU5wU0htazYrWXFYZWQzMDc1UG5sTDRrcEV1RVFHU2xYanVh?=
 =?utf-8?B?azA4ZXhYY1ZJYXljWVRkN2ZJbms5b2VxSEFSVWszL1hRdWs2cmloajljTlR1?=
 =?utf-8?B?M3lKTnhHdER1c2pKMjExOHdLWWpsT2p0Zkdrc3hXTTNwRUZKZmRRQ0EwWHRr?=
 =?utf-8?B?RGlLYm1RNndGODVaQWorazVzVGI2Nk1XL2ViTm9XQ01xNTF6a3E2a1BFOWxn?=
 =?utf-8?B?RVp3dHFvUjZKSXk4SWFRWHFyeUNGdFRMOUt1S01IcWoyT0hhR1hKSDhRSXRH?=
 =?utf-8?B?cUtHa0dRVGdMUEVjWm4zMU1rR01ZWEZ6VGpscEFRbG5iMXIwRDFMcUNkV0lJ?=
 =?utf-8?B?Q2d3YXBXaCtpU0tXSHE3ZG5YaDBnL2sxNjVGTWhXQ2R6eWJjREt0TThQY0Jj?=
 =?utf-8?B?OGsrYXgxS0VqV0VlWllRVnErdXdDMUVPY1l6bVhodVh1REMvUnpqbXZyRmh1?=
 =?utf-8?B?MFZicy80U2JMb04rM0JVOVo3Q3dqVHBkT3VOM1lqUDVraVloRHVHalM4QXRP?=
 =?utf-8?B?by9ta250dVp4SmdZZnBRZWtBeE1UbGdKaklMOGI0NGpyMko5WmJkKzlveTRr?=
 =?utf-8?B?NldaZzZweFlqcGs1cWhBSVAxaS9KWU1scmYyRkNnaFBUZHJPTWZTK2ZYWG95?=
 =?utf-8?B?TjQrY01mZTBEWkJXbTcvSFN3M2RXa0dZQng1WXl4aFo1Wm1qY1BUSzFicXl4?=
 =?utf-8?B?WExhNmpqc0pHeVdtcEJxcEpsMDNLZVJJZ3lnNDhtSWE2eFBDc3JMY2M1UkFi?=
 =?utf-8?B?OFl1aDRCTUJ0OEF0M1V6Z3dNREVodG5WQVJZQVJDRm5IZjFGUmVmdnd1M0RG?=
 =?utf-8?B?QzB2R1JETmRrT2ZKbkw2MStrZlRmL0d1MHE2VFNXWHZRZXN6WGRFdk5hYm5o?=
 =?utf-8?Q?GyOdcLNJdd2Ui?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjFPR0o4VG4vbFBjTEh5Z29tcDVXd0d1LzJsamViYk93cVBramJUK08wOExl?=
 =?utf-8?B?c3R3ZXdvWDg1TmVwcVVHZGgvbm5lUWwrbUJFMkM5NUtDL3Y5T0xPWXZkUG9Z?=
 =?utf-8?B?eC9ZcURCVnhodFNGeEtZRWtrZWUxbTNtMWVOTUFtbXJoRkFLRGp2SjhBU0Y3?=
 =?utf-8?B?dWdCNysybHR2eU5ZYUtRWkxQUHdjRHpjdGswS2hvcmVaWWpZdGxZYXBDT0JI?=
 =?utf-8?B?L1VCZFBsWVZUa2VqMUsxL1hFNitzcU1MdGp1aUkySUFOUU00NEUvaTFmNm95?=
 =?utf-8?B?TEdwVlpDM0pSNzNmd0NYVk42bjVYVFFsN01EOUwzNFB3a1RTWHU4ZlpXbWNY?=
 =?utf-8?B?NkQzN08rZFNjUndyM2pUNHZ3Q3NVdk13Q0ZkQUFqVFJnZzlGbG8xa2JWRnht?=
 =?utf-8?B?czVMSVo3V0dLbnFndGJaeHhHc3RCbDBva2p1dTVUR2IzYy9pM3pKcHFFUWVp?=
 =?utf-8?B?QmtiMDRYZjV4c2hYUUx5SElVMUk4ZUpXamZEMGIzdjZTYlVpVFJsdTJJVFhJ?=
 =?utf-8?B?YkptbTBEVWdscEpjQXdZNkI2YUd3NWpjWm81MWU5NWF3RHRMU3NqRHE4TW5P?=
 =?utf-8?B?aDZrUzVaUytSZHB2Q1pvbS95b1dBUGNrNHFtRmo1N0ZDY3lCVGNBK0c4a0VO?=
 =?utf-8?B?Z00vMFFpcnZVcEZHQm9WaVRtY0NtM29mSmd6SndNSEQvd3JRcDk1cTVvL1VS?=
 =?utf-8?B?aFdzN3NEbWlacHErNDFiNTFONmU3QTlYY2RQcWhZaGFZc3lzaE5YVmpNSXgr?=
 =?utf-8?B?aWVBWHhoWUx6b1VEYVZvdTFxeVdOaTdWYXlPTU1HTWZPMmN2d2ttV0orVXlO?=
 =?utf-8?B?ZUFqK00wL2t2N2dtbzNvUHhReWUybFdJVFY1M0sya0RMZEROeEFSQW5VZ2ZZ?=
 =?utf-8?B?ZFJIMElLYkNyTGJNWjdhenM4dzEyMXVJSmRzKzBUWkxTVHRtdGsvUGxoTEJY?=
 =?utf-8?B?WUpjZkdtVDduamNhUVFiT2pQUjNrOEYwRXI0T0Zmd3AyVmN4NDBlWWdQTEE3?=
 =?utf-8?B?aHN1N1FDSFM3RUpFb2F6ZUFEZXFsa04zUmowQUlNeTNYVmVOMm1oVlRIZWRs?=
 =?utf-8?B?ZThUZnNOZnBVK1BXNkJzb2hTdHdhN3E1VDdFUUhobnh1OHRYUXBUNWk4UDdE?=
 =?utf-8?B?WTBXdldnNURtSWFuMVBsNTdtMjJxcTZrWTFOc1liVmRNZ2tvNkg2Uk5xbFpK?=
 =?utf-8?B?Zis3QkFxNG1PQ1JSbmM3c1lVTkNDMlhvQUVYcjI0TkpDcUIzTU1QUzBMYkU4?=
 =?utf-8?B?bGx2VnFkU2sydHpjYjltS0dNYkRtUURlVFp0VGlZcWJ3R2dGY05jaTR0Z3Uz?=
 =?utf-8?B?SDZ5YlUyckFiU0lVUTdLVWlQNFN3eGJsVkMySnBVQ0pPUjdOV0IxRkFWMC9k?=
 =?utf-8?B?Tm5oVXptYm1uUk9hY1ZpYTU2V2QyUWdEbXdvRjgxOEk4cjAwUStFdUhqY1NQ?=
 =?utf-8?B?V203ZmJuWHpNK3BWeTlvemtRMDU2ZFdzVGtJUTU3R0FNMnI1WUpTNnJrclR6?=
 =?utf-8?B?YVI4aUVLc0F0aEZlK3NjczNoamM5dGNhWTNnQzJrSUFoYS9XREcwYlBTMHVw?=
 =?utf-8?B?TlRrcEVpZ2J6b1VaT3hlS3k0RnlHd0JQdy82SmRmVFhwd1ltaHYxY2VjZjMx?=
 =?utf-8?B?ODUvK2R0NUY3bGk5MHhHUUIyUVJXMjU2QXpOS0FNOHhqZkl3bkFPV1JpR0V5?=
 =?utf-8?B?Tmxha3lrNHMwR2JsMk5IUmZTSVpQa1Nna2dkZDlyUlljZnk0UXpJa09HWU9D?=
 =?utf-8?B?T3h3K3BoOW9pY0UzVDY0TUZFeENtL3FVVXJzcXJYeDhrOWowMHByZDBUWmRL?=
 =?utf-8?B?bzFLN1JXTi9WUm14cnhUTnpiU0FXVFhZNXd0T2xwdXViaVpoTWNxZi9qZHpF?=
 =?utf-8?B?OFhaU05ORjRyOUk3SFk5cjRiRFBmTlpSV3JmNHlUVWZOTFh2bnp6RlU4Q2pv?=
 =?utf-8?B?VDRqeWRJaGpzbkw3YVpOVitHdUxHbHJpYllmN1pSZUJiZjcyRzJCSHp1MFdt?=
 =?utf-8?B?cFRhVlBrTTk2RHhHK0RycDhReHRsV2F0WE5jS1NxS1FIUzZEaHIvbmJpSHJr?=
 =?utf-8?B?Sk9qUUw2cTI3R25iTHhIaTVJNW5tM0ZNNEpYNVkrM2FvY09kVVVpS2JvUDJ2?=
 =?utf-8?B?bmJYeVAvMTZKRCthTFhmbUphOW9IU0JKd0NOMXRqaTI4azhnY0ZrYUpkQUI5?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vCw0Y47Ww44fXLtYNtQQZR+8gyl6GEkq78m6fo62mYFzuDGR6vQ696WGpNLjP6ndVSUD4KGNJGt5e+RIQ+L/Z1ZNbhXI+3Nnx1SjT0ufMVXnNAeyXt4xyJKvspKgqDho2bNdG5TKcPTF3KIobft+z+oUV29F1IHQpZxv7oanqVltGrYXqUNZJhI4Hdvbl5pcXfMkYkTReUYHddO787SEjnnGazly1Ye2phMKLY0l//Uzz+LWI741xkwJCJxCvnJXbqmARET5+ohiOk33B5CzlOFFOMm1vZa+/96ooUjplSIFMFH3L0HktPVTwBufirxzo9Z6H1ErmYTY6+Z/f5tXdySohBEwOsmluH5NxpIV/vEYHZsBrqTp5JWNuDRXZFjmLxUUXItpwsfANlDYqy4h36XJ65aJhscGsgh6UmXS8aCdhzIm0y/d5EF8ZEnw2dafQvXWkABHscQY4j73W9zfyGfoi8KVb7CsfVfCoQiqIx8UTd40HsVJrOGKvtfPk6iPF/6piFQdy2sJYVYmXbEaym8YbOXm6165bvD9m2ijqMTczgccFe0iEL+okvNpCAcfRrFzFWYRhubud+pCjhLZkKqEjlEtAl1w9PmX3NVEkh8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bed339-e24b-4356-20ad-08dd55836418
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:01:36.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AloR7I7e0QOGHSQnvqAGJHXnmm5HUyF2p39i39USx314P44SJQzbcOQH/nG8bXX9ZkcH6l0rcrFIYIP/wbpc6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=946 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250069
X-Proofpoint-ORIG-GUID: -NKtMwobMTmnesEbSS3KO7_G5ju3X0Ap
X-Proofpoint-GUID: -NKtMwobMTmnesEbSS3KO7_G5ju3X0Ap

On 24/02/2025 20:26, Darrick J. Wong wrote:
>> +	if (error)
>> +		return error;
>> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
>> +	xfs_trans_ijoin(tp, ip, 0);
>> +
>> +	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
> Overly long line, but otherwise looks fine. 

The limit is 80, right? That line fills out to 80.

> With that fixed,
> Reviewed-by: "Darrick J. Wong"<djwong@kernel.org>
> 

cheers


