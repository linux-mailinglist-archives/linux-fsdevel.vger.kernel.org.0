Return-Path: <linux-fsdevel+bounces-44185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F54A646DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 10:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5BA1890962
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE59222581;
	Mon, 17 Mar 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fawvi/sb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ObIRwEzu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA551DDC12;
	Mon, 17 Mar 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203077; cv=fail; b=IFwCoHpEV1XpieLqk62UxDdKOp8tIWl0LgMK1dB5Cw6q95bIiDBXBSk4RHFqcw3d7u43eAfXEuUrWSWyeJE1xSx+11BW0LVVbTCFMyaaJtJ4FfKOF4kDvQMAFE2+X7laW3g2GNK7xi7TCCd3aVp5xwu2JHYIGiqm8QLca+dRzVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203077; c=relaxed/simple;
	bh=T/Ho23DCU2PtUJl5uO5YYHunL5c2h8brPpj8bZtTACs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H4wTCxrtK5Gn7+vsrRhn2SsjCdilATFeBZ2PeLzHcIV+X+fJXu7nP5sBQLGySN8T71M021Z4O60hNsnaw8Z5w3PP1cvKYdDW6Aews+vGxL0P8jLDMErqRS5lzBPXXOqRBMGHt5JUjctXVn8g4rQIzY8hP80CzSJrAwJxO4sq/eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fawvi/sb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ObIRwEzu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7R1aW032675;
	Mon, 17 Mar 2025 09:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bEEr+2ZsRndPXWWp3hW4yExw+jti6kQsmelAMzF3Ctg=; b=
	Fawvi/sb5MfRNR+yK2sjIDc9pyR8Sj9N+82f84OMhX4aVCznTWTP9C4G8btHvMmV
	ENaR4qLFDkXgK8gWSSproayj1dRlGu5lkHJXflrGYpfLS0t9HTjsp9kU4XMFwQ8c
	YFR/C1mHA85y1yvyaG8lZ0YaBuHh/fQoy0G20gIy/+kcGa/i8kDDls9JE5WW9yZW
	F+oakTxNzmUDFW7+jzTYRJm5QNj/1J/ssfB6+5F7C+px+vfEMXr0lFQe4tLWZCta
	f9zyHOkZd06KnW03vGhC9GZF+Pd1hxDtOGzqLubyEFz8+MZi546yRcZNehyj2UpK
	QB9QJMiln+uXoiwM0lvvfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s8ja9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:17:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52H8o4SH023771;
	Mon, 17 Mar 2025 09:17:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxedp62q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR7PKl8Lfw0wfZMlLNevIQxGvaQxLjO3CjjJFazKP32ZyRyieuGpIerFm8tEY7WsLPBu0u+9ppC4pL62z2PPPPLH121jXGNXykgEdyULM89GR9Fof1gS7C2XBf3F9kJctHkPGECh7/pryThP4/XgQGDAOgqDUEDeJQw0zGB98cFVLqaDi5rPE8KX0cvmCAbEBJ0qDC8aOQMG3WfXoZSPUdzwNc70mAbxjskPgR51vsGjV/WAk2GL1FTABpN2IQ8PmTstnodjVgCvXVkKEy86sKL03DdbKbb1tSRVI4vUsWIhEzKYGfe7BuKNj4tPKqVGUVZCm1qTz7YIkVWBSnzzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEEr+2ZsRndPXWWp3hW4yExw+jti6kQsmelAMzF3Ctg=;
 b=dSxuYzDKxSnDFifuTO5yLcMegHQep9el7HPAyXsTPG+GAZfVik11A4+JQ2OQYNzeOLfwydTYqnKguopIpoc7/5P78WVO5jguZVUH1/z10XF6BF32hsrg262Bj3GNNKKMnD05lfgVKvTNQArCYm6knyCEx9Vh1FCfRA1EKzcxoaMXN4f5siEQAp74N6tUsJqqMk0mdbLUdLNcOWeR3t1KuPr09lDienwMSZzLIdJr55YLtSJ04a+4jmIcG+hotr9B322UiEf/Mv4iztUpxIyiBM5/HGEuayKTHSm8cyyuSKFDLwdOukZhATxyHXjxBzk+GE2CbIWANw7bYOe9hux+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEEr+2ZsRndPXWWp3hW4yExw+jti6kQsmelAMzF3Ctg=;
 b=ObIRwEzuxweAcnlGsArcnlSw0X4sN4SpCfMbcoEpy+LLyA0TNrJ71EMx5rbY3dK4kqdyLEOFj6Ul5UXNVgilOizB7zsEe2ziciEMRP0NUngHNaTTrls5yTMDmDzMnCpMfsnimkxQU4hFI6Z02cXt83dMf7YP35Wek7yHg8uh1BE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:17:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:17:39 +0000
Message-ID: <0407fd20-4a04-41a3-b978-2867a1791ddd@oracle.com>
Date: Mon, 17 Mar 2025 09:17:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/13] xfs: switch atomic write size check in
 xfs_file_write_iter()
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-7-john.g.garry@oracle.com>
 <20250317061817.GF27019@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250317061817.GF27019@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0407.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9de838-3c70-4c15-dff4-08dd65349097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlljWE5mQmtVdWhHalRpamdFd2cybFhuY0d3ejdMeEJWZ1oySkNHWW01N2h2?=
 =?utf-8?B?Ynpkd2ptTHdDNzdkME9PWnJkSXNsRVdGNnh4eUFGRmlHOEV6S3gybGoxSnRr?=
 =?utf-8?B?UlZzeXFlODNTSW9BNlRnbVM3S09ESkRpM0lsTzdCZDhJRWc4L0ZQckdZekd1?=
 =?utf-8?B?ZkZqajRZcVFzcEJkUEd4QW0vQkNOQlFxT1JiK25NbXozU2diVkowZWcrNUVl?=
 =?utf-8?B?ejJCZHY0c3JyN1dtWDJlUkxCLzRuR0JtaTJ1dlJDcWNIbVQyb2g0VW8wMmFG?=
 =?utf-8?B?cFh6ZUcvSjNuSWxTSytKWVpEV3YvbzViZUkyUFJ0N1dSYWZLVVdIVmQ3cmZn?=
 =?utf-8?B?c0VNdFJqYVppRStOeFZjUFFycHBqc2p2YW5mWEhNSTRYVlNBalB4TlBUUEZS?=
 =?utf-8?B?OVlKamwzY1RQQ1ZxbGtDRlA0WlVpbU81OEFONFNwMXgxTDg2ZG8ybFhtdW5x?=
 =?utf-8?B?N0s4OE5aaEV2aDRvVXFBL2hWcTBsNXJOOVNFM0pwVWpPWERleFJNQ1NuQSsz?=
 =?utf-8?B?eEE3NjJQSWxzUVUyU0krMUNiTE12RkpZbXUvU2V0d3NIVkdxd09pVDBrckdm?=
 =?utf-8?B?TUFuRmU4S3hmdkpqcnRvcFZjaWtvbk12ZXIzaW1NS3pPbEoydzJUZXZ5RGpk?=
 =?utf-8?B?Vm9ZUm0vVDJiVEFPbUJkWGcvbjV6bkxLKzZWektZRzhndEliWWhrd1Bpc0o5?=
 =?utf-8?B?UFFFZnBtZXVzUUFqM3NnQWxrMEJqbjdad05nMXN0RnJnVGpFZklyY1p4RGVk?=
 =?utf-8?B?cm9xZktZWjVEVDNaY09aajZnUmJyNlVpWTQ2YTdMVlBQU29pbUtIQlFGNkZH?=
 =?utf-8?B?SlhtZGFjN0ZYby9vOUdJM0FCcFBIMkJqZ2Rub29LcXhyT3V1Rk1JS3VETXdw?=
 =?utf-8?B?RldzaUZwdXVzV3FjK0FJRElUWk1WK2k2N2ZHNmRnRXBzSGEwWFhIQTRwZ2NW?=
 =?utf-8?B?aDlDaTNVVVJiWUlndm1sRmlSOUVheENFQUt4MzNuWXE1bVRENExiRnNPVGhF?=
 =?utf-8?B?WUtORU1SZ3VCbVhYZk5Ocm80bEVmNFhucVNGUDNFMkg5M0Mvbk5uUGN1Wk0v?=
 =?utf-8?B?OFFNU0RlTFUzRGN2a0tlbEJFcHhCK1JkOWVQajFRTkNIcDBMZ3NaNEQzRldX?=
 =?utf-8?B?V1I3RUdySHk3VXNqQ3dGdE1IcVRzTWw0NkJnZ1JXckxzZTBSQUNkc2N1c1JQ?=
 =?utf-8?B?YTB5K01OUjVNMmEyak9LOHUrenNQcE5NZkR2bTc1SFI3UVk2YWxpYjJudU1V?=
 =?utf-8?B?cEk2ODdhUW95Wnl6Y2gxaWhmczFWUUpURzFqQmtSS2VzdlVEWjBXVnQ5QUxY?=
 =?utf-8?B?YXQxNzVKN3hHNnZ4VUhnWGNZVHMxNzRlRCtlblpBK29GU09pZGszTHNxdzVQ?=
 =?utf-8?B?dEJmLzdYUENxZSs2dHZva1JUdUpNYjRRcVJ4d2QvU3M2b0s1djFWMFVGNlQy?=
 =?utf-8?B?TElUWWNBc0U1NStyQ2daS1UrY2NIRHppcmhzeUJpMUY5MmJ5MFBYbXEycnlU?=
 =?utf-8?B?WEZ2dER4eFpVS3JRRjF0Zkp4RXVudHZUZzYzTEZYR1lSZnpESVltQWIrcDQw?=
 =?utf-8?B?VENBcHdTNDl4MzBJRmFHY1dPM2VOUlhIQW5wdTI0amxKMTdKVGNEOWJmNzBl?=
 =?utf-8?B?RXdFenJJUUNvaytmTEMyM3ZUTUVzaVNaTWowaFovUE1VNjZyN1Q2d3R2c05W?=
 =?utf-8?B?R0tVTHlZVEtVWlhxaUZ4ZjY5VEVXMXBjbnR5bTM2UmZrK2plZHl6R0ZaYU1s?=
 =?utf-8?B?V0pPYTdXa0NoLzdINS83MG0ycStYU2JxZkh2V2M1MkFoc2VKeW1QYll5ZDB1?=
 =?utf-8?B?RjBvLzVnb0VtcXFWRkxCa2p2WHlNOW1jaXVTNHFvVTZSYTYySEEyeUFaalFl?=
 =?utf-8?Q?4QTKalHEsDEIj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUIxMmp4RWN3ZlNoeEY3ZWNtRjA1dllCZmpmb0RJNVJyZVB5WHJtV2htY05w?=
 =?utf-8?B?TW9Lb1RMVGxIU1RFNGhiR1lKcmtGWWZzdFlHQzNwd2tHQ3dIZ1gweVl1Q0Ix?=
 =?utf-8?B?dTNTWHA5UmRCaEJvL2dBMjJNNjBlV1R6L2MxdGpOMHNIUlM0Z1hoblVaS0px?=
 =?utf-8?B?QVBjZDFLNno3TEdnMjcxTllGb2FsS3hQUTAwNWVVM253dnBEcTd2TXJKcktR?=
 =?utf-8?B?T0gwVWNKR2Ivbm5qb1IrSlArQWxaWERZUC9FaUtWYTNYb0ZHMER5Tk93MzEz?=
 =?utf-8?B?dWE1TDF0MjhyaHhraE9HbXQyNjJ6Si93VTl3U0xZVWhYcWpBUHFRY25GOC9U?=
 =?utf-8?B?QWIyU3pzV21DeXV0bmpzQ1lhRHJTSlQvQXBNZFdXbFgzK0d5dUQ5a1l5VXZi?=
 =?utf-8?B?d0lLQlRiaGV5SFova0xnNlAvQ2RUeHZ6VUZHMmFrNEJQaGhreWg0RmQ1bDV4?=
 =?utf-8?B?Z0gxUVpjUXdHNWlLOUZiQkgvdnBQV3Fxam1rVkhCUmVod3NzWFJtNUhpaktj?=
 =?utf-8?B?S1diajJhNXdvMTRod1ZnUmFMNGxYemYxSHI0R2VWMDIrU2w5UXZGQnBvUDd5?=
 =?utf-8?B?VzlDckxQV1hRQUc2ajUwaEN0cFpzQkFTYUZVLzBscTFEa0YyVlJ5QmhlcC9t?=
 =?utf-8?B?dDJzcld3b0cydklFOVVsaDc5WVlzTkNwelFuSVhZUDlteE43NnRFbUVXb0VM?=
 =?utf-8?B?eGlRTHh2RU1UWGNhTi9kcS9DY3dxRHdKeFFmT2hNdjFVTjJNS1pSc21FREcz?=
 =?utf-8?B?dHVuYjR0WC9KV0ZpK2k5b2oxb1lJZWpBKzRKRjdraWoyQm1EcGt5OERoYXBE?=
 =?utf-8?B?elpYK2NLS044WDVhZ0Q2a0ZiSEtJZERQam90VmJpTWJjSi9FNE1jSkV1bEs3?=
 =?utf-8?B?Q1lHVGM3V3Q2WFhpZE04MkdwRzVXVkwrbm51L2ZJaEEvK3FQZFJPQkMxNldE?=
 =?utf-8?B?RzMzZWw4L1dkcVJBMUNlOUtmN3JhN0VZMHNwaXoxQkhWa2swdGZIamJwWHZW?=
 =?utf-8?B?c01rWG1nNWtqUlVNY2JVTnB1K3MvcG0zOWRMZmxOZ0xkRGxFR2JiVzJJVDMv?=
 =?utf-8?B?dXE2bi83d3NlMCtUMXliaFdXUW9wdHlWaWdlSDJ2OFhTTlhobGhwL0lPb1kr?=
 =?utf-8?B?Zk1lQnBVcTExQzR0cmZtL3hFbTJGbXlXWkQzUGRITEplK3JjNm5UWFkwWTNY?=
 =?utf-8?B?SE9HeU41MTJwSC9aVzQ3YmFGMDdqd3p1bldrQ3R4cEdCVTNlTFI3aGs4ZnNo?=
 =?utf-8?B?cGVadkw0azNIVWM3c2x4NGN2U3F6WWZsSG42Q2l3UE5VMDNOU1pHaXZ3bFZs?=
 =?utf-8?B?WTIvaEVjV2hXRElLaTh1dWludUVOa2RKayttT3RmM05DQkU3ZUF3bWVGakd0?=
 =?utf-8?B?SkNjTjUzVDg4UC91YkR4MitRdTNVbUt6amhpRjl6NmFoTFo3MkJiRXdmRW1Y?=
 =?utf-8?B?STduUTRjeFd0Ri9DV3Buak5YN0dwVUp6RVBoMDFRZHVLZU4yM1MwQ1lFT2lj?=
 =?utf-8?B?WXl1cCtXZVZ5bVJjdDU5cFg3c0NqMXI2bXRQVzdqNzYzbTJzdGt3VFc2TmFm?=
 =?utf-8?B?OXliSzRZd0NFSzJ6RU0vYmRQWVdRYlZieThuT3A4aysvY3RBV2tPeVAxdVls?=
 =?utf-8?B?RjhqeU9SazZhTEZ6UndOeUVzV056ZDgySVpqT0Vza29xL1JCUkdJTEl5MExI?=
 =?utf-8?B?R0xuTlpMdHoxK2NoQklOeXFpc3MzdlpmMjFUcGc5N2hGZjZ2QmRDczZkTDhJ?=
 =?utf-8?B?NnZZZkRiMytOY2xvKzlZb2tXeVVnY09ZUkFKWmErYkNxZEt1WXc0Y0NqNjZz?=
 =?utf-8?B?dkRabVFFUE83N3RicFZIM0lqS2QrdGtpbkxEZDMwVHdUcmZDTG8wUEc2Q3hH?=
 =?utf-8?B?bGdHYWp4UkowcVVwOXV1dXBjcldXVzRtQlZBT1dhMGJoUmk3NUl2bmtVRWF5?=
 =?utf-8?B?VUtoVWpod0EwRjhkMDZZUU5ZS2x5V0dXTFZ5azB5NytwaEVtRHFZQzNZN2RZ?=
 =?utf-8?B?bkw2WmN0QkJPdmdkeERiQU5QT041dCsxZVQ2d0VadEgvWGw4WVh1OSttM0s4?=
 =?utf-8?B?RlFFOXRuZjBGQm1WUEpJakYzcjRoaERQb3VvQ09DNGY2YmVEbko3aDN4QnVy?=
 =?utf-8?B?cmVzRlRMeEZHUU1TeGVYcWNGWWd5Z21yRXFCWXQ1YVBiOHZWTnpIWjdHZmN3?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6G3G57Q+SRlr5PgS0To2TjQB/jpyDLMDRcewj/H3p1ui8INBvfcZB3C2lDs1t8uXIFXb7X3Zy9lQtswtPN7f/ShsvuNAGLOs5nLkeOD8J+ws4t3dw5Um1eH6a8tCz68CKT/KN+bDy1XV4ii+lyPuunbNnOcpTDPou0B0nzXE8aRw8l2Is7cZq88pNCjC8qAURw0FhJH5IKThGCIw6hBPrDDPA6OHVhSqRy6aeS2obs2HJN/8Qf+aLwFH7AlERJ2j05jxSLAMHOKny9aslD7euH56YXOkAfMWC1KRlXcOud7spBcHBProFq5Xx1nYYi6BSOeHPu4u7lz1qu6goI8rcFtxRxeUn/Am0oSfDx6rpfXJelzLRKc+5la9x3+l9dgz0cJPkBNwve13PEDhAkkI26NQQ/aXgMYpCmNgILiPI8a7ph/fIAg/SpWRF3dxsBk+BDi4INQ2xAPj3U+HHeCzzmJyEFW9/sXwKfLXJb6EEuevFT7Tzfb1gbTv/LorVgMS/M6tUnXVaO7KD+wv9wfgVcxlHBTeFF3nl4d7YhQqAHM8YgnjLzv0czkIDBGSDLhUbHWuIFmbAFR5Zk5bV5PLKe541MNA0Irth4Fvojfz8ZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9de838-3c70-4c15-dff4-08dd65349097
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:17:39.7831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFdlMZIli8h9Wxsyp//7w/oXAb4NKEP6oycdoW5+ib1teUfY/++IE0x6vStiImc31X2i4I0byR+jz14xQOS7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170067
X-Proofpoint-ORIG-GUID: Uo9uC09Nd28yqLCHYqYBVdtkz-UXGreA
X-Proofpoint-GUID: Uo9uC09Nd28yqLCHYqYBVdtkz-UXGreA

On 17/03/2025 06:18, Christoph Hellwig wrote:
> switch seems like odd wording here (but then again I'm not a native
> speaker).  What about something like "refine" instead?

Sure, I can change it

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>


Thanks

