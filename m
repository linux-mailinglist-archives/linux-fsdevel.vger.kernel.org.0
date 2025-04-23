Return-Path: <linux-fsdevel+bounces-47097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42574A98D51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 16:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBAF17DCAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC88827F4CA;
	Wed, 23 Apr 2025 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e4DQITMi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gWFlwfYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D427FD7F;
	Wed, 23 Apr 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419132; cv=fail; b=snU8NNO/XXYceFvVSXQNSNNbDiysIxj8gp/Pm37KtNoou1WbVx1/zsM0i99Nj7YlcbFvD9o3oWFUJbDV6fC5Wssv+vAiJP892r3bEXof0jJkjNvXJkB8wCvDqDX/ANKzaztXcXGArYnCPs7Z/lgaARKHa5Z7T2wVWEmcgX+Ta24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419132; c=relaxed/simple;
	bh=b0EmcKChSH3bXIs2KZDgOsJsCDLx9BUTaUstiW14w7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nD3kcUdVsvmfJWCC3qNFkohjCJQU5fKYJlArkS1dx5pniZtQGzNYnEmjnEptqJaZbStfS2yrbi/8xbPEta9mJHPJD7ubhaQtKmHBGoU2N77IZVxWXlP9ECvtyD23k/WLISUr0wxRxWOe2gMmFcVRWeUXpD/tLnAqJar0pdzOXKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e4DQITMi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gWFlwfYv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N8g0LL024014;
	Wed, 23 Apr 2025 14:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tGpAnjgIBuo/JZEHONV582A96vNX4SU4byIvmhoLhw8=; b=
	e4DQITMiA4FzuuP163uiKdSg/Cy3eJyWoKUp2K/dButfcTL82DEurSf685+0LHaX
	WKIn7/7fcDnUZMd7zW9yEPxNcFsbeCAhC2po7PvfN+5+8i8hbTWtNgHOuqIXS73u
	uXQ/OJ7bJIsYV6xnuPLGIf4zg4aQ70LBMP4HjN4eH0gtl9W3qDFvaLtuhknO+n93
	Xc2C+Kzd9p8y1tId8fLorddQaZwoCFdcJ50zyDySIHdPxC6wpZG2nvE9G58Gqdxo
	vc2uYXNcnHMQ8d6GchPSfC8t+3g3s+OI8aysjiqHdhJ7bUfHbI9v8SkIP+HB7AlQ
	68ibO9bC6hTgW/Wmlq9Vcg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhe1d4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 14:38:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NDdX6U031052;
	Wed, 23 Apr 2025 14:38:41 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010004.outbound.protection.outlook.com [40.93.20.4])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k05xktt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 14:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtttUx2cdLR18xdKIyAJtra/sfWNmOhEK1+/oBNGcJkEAyPb1BkE83jl9CF+Idto1bLlNwrWfS+PNsXTTgkBpjEgYa5W48YvD8may1/jTE1bsxWumDeI3VX/xDft9FuHIx2eq2Hovk1HYSdA461KCBBUTCZDK/toaE5KEg3WwcDWRUoyWhjDoSxI76h1kjYPj+iRdxqD0s1hdmrkDByYbbEbZLoE/hr9mHFkmAze1kSUxd4wPReUFwjcyT8hKvpWEf55GcKcH9/ikTUAcduy4T/a9oOUE2Q6YA/3QZT/GSpkj7s8k0GQyJCh6KN+aAxZt+jUPfkEi6vBkgYwMGBqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGpAnjgIBuo/JZEHONV582A96vNX4SU4byIvmhoLhw8=;
 b=KOruJ4+lTISQ+qKWxt/IHc06KZh/zd9SLKWt/soxStzkPtsGpjFUtPCdrb+HCyNVPqMkRVRS2BfzIHxyhtvmcBF9gFdRp8gD+KlXQm1G/2W2D05XoBN6cCC572dJl8VGMXMCXrOu5nfoXWtykGxLGNPefNxzo8QN1tIIrbW1j0rvgSnpFtgitTshqSBNnfLHvL/OHS/6lmoFBYi4JgXiqNkjSGyfw9AoAYjFZxMZL0sV7seoBY+LdDvhMC3QJ6vNSZT3lbqtJxBm5UzSDg9UW8EXIQeWfn5zQkOWiWPpl4XENdRDuhnUO7goxUbtKDdV6/jeVky261K9vMTg27kmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGpAnjgIBuo/JZEHONV582A96vNX4SU4byIvmhoLhw8=;
 b=gWFlwfYvuEOG0LPvZYQvOuVxZ8gFUZxrLchd0Q68C9ptIiN/kqkhqi48n61EKhdA6UwmdONamjO+B75fZO2O83PNVi/5jXKzrd923AVqYSvYMFd+ntvodHmO4yotKAllRC8OXJt8U1nurxb8KfeqN/BAQb3D+okHHwMb+7ng4ok=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 14:38:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 14:38:39 +0000
Message-ID: <c608d941-c34d-4cf9-b635-7f327f0fd8f4@oracle.com>
Date: Wed, 23 Apr 2025 10:38:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Initial NFS client support for RWF_DONTCACHE
To: trondmy@kernel.org, linux-nfs@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <cover.1745381692.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:610:e6::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e04b11-72a7-4a44-5b2a-08dd82748994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWVWS0Q1Q05lSTF2NVlDZkdhczFNL0FoQ3RqMExEU1lDb0srMEpKSExmeGFh?=
 =?utf-8?B?TEtnaC9NanFoazNCVWlBNUpiL0lCMEtLS0lqWFlndk9rYnR2NmNVOTB4VlZj?=
 =?utf-8?B?VUd5Z0lxbUFkZm9kZGo2eWQ0VHdIcWtrSmlXUVcrUGdmOEVENGV4ZThsVVVs?=
 =?utf-8?B?NThjd2pxVjIxMGpybU51eXNTR1F3MlhoeE42WjI0MlNTdW15RHFlbmRpSjFN?=
 =?utf-8?B?dEJTblpRa0F5eEkwaUhsV1Q5b3lzVk1QNzRYMm4wUjhHNWZYZkNmYWJ0Vnhm?=
 =?utf-8?B?eXpRRG5RbzRBTWFZaXFabEhPWDhaaDhLVExoQVE0NHZEd3dNYXRPdTNLUmFi?=
 =?utf-8?B?QWUvQU40N0NKTHAwd085VVluUG5FRzRTbFdxNlF3bjRvUXhxY0FkVDZ0SFVi?=
 =?utf-8?B?RlBuMVFYRUx6UEk1WWlDU3YveWdWOEdMNmJ4Sm1RckVoWG16NHBPb1IvclNl?=
 =?utf-8?B?MzBEMUFML0tPcVZjQkVaeGVPVXh5V3NVWFhncWRmY01tZWxTcGxvRmh6clJB?=
 =?utf-8?B?QnJwRkNCNExLUitVKzhUamxPVVJyczh0YVFwSFJobjBiNGhQWnRMUEwvZmJK?=
 =?utf-8?B?UjN5cjlZak42OHlCUm1aN3N4NlpwVi9IQnh4a3VBZnlZMHdVcmtYRUFqUGgr?=
 =?utf-8?B?WTdvdjU2Zk9WMW41MEpsL1lDUjVmTnc3WTFWdGhJQUZFTUFzaEVJOEFLdTBM?=
 =?utf-8?B?eHJ5NWFYb2dVc0p5UEdWTGJwY1dIdExLVmhuT3ZSRjNvczZ6YTFzWHA0Nith?=
 =?utf-8?B?R0FubXNvN0ZCRUZsZVBIbU50KzQvY2tBRGlsSEUwaTdYVXROLzR2c3FkQWV6?=
 =?utf-8?B?SUJKZHl3K2ljQTFJUGRvVHpBUS9LWkMrdVpHL3pWdG1seHFFYVpyc3Q4UXhT?=
 =?utf-8?B?MFBNQVlQNTRhaGUvV0JtVHhhZ29HbDAvL2NhSzFtZVJkNXJFRG5uZ2RkK1B0?=
 =?utf-8?B?M3kxTHFYV1U2VkhTR05kbEp3SllIYm9zZTh2VEU4aGZSQjhlVUhwOERUdzZ5?=
 =?utf-8?B?ZmdyZU4yUCtwY0RJRWVGOUFrTm91dk9kMUh3RGFORW9JZXY2endka2p5dWla?=
 =?utf-8?B?OUFROWxVSkdzemFCc3gxd3pHOGQ5Skk1amVNVGtrMjlxTlNyeHo0Mk14dlUz?=
 =?utf-8?B?ZDBMWTV6a3dQNllCdUJqZ0FYdDg4S2dXb25BOGF0b2t0WkZyc29SNmlOb3ND?=
 =?utf-8?B?OHpUSThGNXhHdHRSTzdmU1h1NmNYRys2NlBqVWxaWnVmUEp0dk51aWErbjRr?=
 =?utf-8?B?aG41NjNQV2gzY3dZajJTT1I4Y2VXSzIrQ0F5cDZrWG0rSmg2MEhQeUZiczhG?=
 =?utf-8?B?bGNPNTVvRWJyWlhIRXVOZWsvbUx5S1YxeSs3RlhZVWRWbjlEUlBQZGdTZWgr?=
 =?utf-8?B?WFZKRy9CQy96TEhKNkhvUTZWQlh1YjRxMDA4QkdMY2t6UmJFUjZLV1lOQmlI?=
 =?utf-8?B?aUtnR0cweTNwWktQQVhnRTBSYVlGM2VBbklDR1lQUTM4U2lzUUNValJFRWRW?=
 =?utf-8?B?T3hkTzBUQlluVlArT29KMFEycEdKU09OTnRKWXRzREdxaVVwWGlKZmUrVGUr?=
 =?utf-8?B?R0pzV0Z4SkFtNmNyLzdHRm8wTEd4ZzE5TFdBK0VwVXdZNkpyaHBhVzRzN0ZT?=
 =?utf-8?B?c2FRV1dOMjVJY2lQYWRmMWtqMEIydnZBT2YwOFFoclJZVC9BS0wyeTEyQko5?=
 =?utf-8?B?cTVVME5ueEl1ai9IbU43OGMyaHIxSG9YSTl6SkRScXJ6ZCtQdzJERjNWblJ0?=
 =?utf-8?B?VTdYR2NCZ0piOWhEM0lqRTVEWDlvaHVxVFBaN080NDBUUXo4MGN3NHJXYlZY?=
 =?utf-8?B?RnN4T0M5UzZKUGx0c3dEcTErM3lrRVlaNUtVS2NNclRzUUhmdkZJWmhzS2N1?=
 =?utf-8?B?UU9Ga1Y0Q0lkRHd0d0xDLzArUStkZnlvVW96R2hwcmwrUkRpYVVFMlZ0bExF?=
 =?utf-8?Q?EL50/VIW1pU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmpWb0NUYjI5UzlUMTNYemFCcFQvZkZnSUNuSThtNWtlMWtwc016SVlsSHpr?=
 =?utf-8?B?bnBZS3FZSGJjNitKNHVmS2poWTI2UTVHcGJjaTJRZFMxb1hWVzNINTRUdXFp?=
 =?utf-8?B?blRCS0tyUkxiWnluUVN4M1I3V29ub2RYb1JtakJJQnVhZTdRUmt3ZXNvbnZX?=
 =?utf-8?B?MzhzYzZTazlod0dmVE11K1dlOXlVbGNoNkd0SU5FbDZLQ0tTb2FPeFRjYzVE?=
 =?utf-8?B?SVE0cEtMRWtGY0tjU3d5S1NOaTUwbHYxNE9wTVhnWnhScXdpWnVEWEN5NCt3?=
 =?utf-8?B?SjhnMVpYcnJxV1FNcVFReHNmYXJqcU1CMXBvZUpjRmtzMm1QS3V6MlRybW1T?=
 =?utf-8?B?YXExVitsanVVUE9WTHFyY1pKRjlpNW9hTmpsYW9ZaytpMkJncE80K091Nk9Y?=
 =?utf-8?B?c1lrL0lQZ1M4alBlSjEzbnFuMzhlVE5uRmRUU2lMR3pZYlAxaVkrVXJwLzdX?=
 =?utf-8?B?enduVWNKY0t4YzlPT3htNTE0Y09RTHJJSGN1TE5xY3FhM3I4Zmd1TUUyclN3?=
 =?utf-8?B?R0pHSTM5cDQ0eXhqTG0yanBRY0xRTjk0b0dhSTFSTU1QcitwVVM5NnFDYTVS?=
 =?utf-8?B?eGhaTXFpSXVONEdUMC94aU1Eb3ZhNmhmZlJyTUM0L2V5eFIydDc2dFREbDlx?=
 =?utf-8?B?aHpENWkvdnJhMFI4MGVPSy8zZ3dCZlBCd0JJdTFPNmlYaXV5eWxJWjNWQzV4?=
 =?utf-8?B?UExneUc4dGE3ZzZSdkRUMU5KVGp2b25IU1A2UTU2SnFoSTRjM1ZzTXl1YjVU?=
 =?utf-8?B?VVVGcWZvaXZTSkkvWW5BRDAyUXp0b29ZcjVrc3Q2UHVjZG1nMGM4TTMzTFN0?=
 =?utf-8?B?MlN5ZTVKMzNMQmY0OTFjejdFdWY0MTNDaWpXNTgrZE1jd3BkeGowRWxOZHc4?=
 =?utf-8?B?ZEt6Um42Sk0rdXRuQ2JVRjdOSW1XSVo4TUlJMEhkWmNtQ1VTczdKNUp0N1Fw?=
 =?utf-8?B?ZXFobHlIR3JiaVJKaXFrdndxVVAvNTdFL28yalNhZGlDYWtuR2Jub1RLSHU0?=
 =?utf-8?B?bFhHZW9KbnVBLytlc0FYY3dicEp0dE92d0lQNGpTaGp4KzJNS2tRaDZGVXN5?=
 =?utf-8?B?R0JMRkpGaTRXa3RQUjJ0SGUzVFlOTDRvNkU0WFhQbXhWa09yUGxhblNVL0t2?=
 =?utf-8?B?R3E0eVNHRXM4WDBFb3VyNVNNMkZKZlZSaXhMcFM0dkRwOWxBMGpHVURod2s2?=
 =?utf-8?B?MzJYaE1rL29kcE9XUStuZG9OVVo5cEpFT1ByYXQ3dW84Ujg0S0JhOFZhTXYv?=
 =?utf-8?B?eVlnOEhGWkVMWlBIdFpXcU9ZMzNBeS8yVlo2dWsvMVZLbjVCK2tYUHRFOEEx?=
 =?utf-8?B?RTcyekU1U25nd1hzdWllcWlyTnF1dnA5aFNwUXhwOHEzZHRDTW1LcU5zQ0li?=
 =?utf-8?B?WGwweVBBODRzNUZvK1hRTGkyQWhxRy9aZmVFcjNwMWQ3cUthTGw2ZlBYa2RX?=
 =?utf-8?B?allpaWtQL0RwdVRrTFdvVytUbXlQVmlPSGdQaU9xQnF5QW15SCs4bHAxc3c4?=
 =?utf-8?B?MFk0L2NZSkhwWmNSSlkrWnJuc3E3QlJRU3NEdGtCZ012Y095ajM3b3hCQTdH?=
 =?utf-8?B?OXRFT3lhc2NTQk8wU3oxR0VnWDl0M200elhSUndSOXB2cy9yZ3QxajZuWTNu?=
 =?utf-8?B?TWYwM2JyQ0xJRm9QL2V2SGJVdmQ5SllScStwNzZ2KytKSDMzUXRlMExmRCth?=
 =?utf-8?B?b3QzWHY4d1NmTTJPRkVEQllPZ3ZzVEt5d25QTTR6QzR4L0tEUWVOcjVhMndr?=
 =?utf-8?B?Q0prQ3d2Nk1tWklvWUw3YWdERzBnckpLdldHR1BlMWFvQ2VmUStscThBTGd0?=
 =?utf-8?B?YU8yeHhQVDZJS2toblZyazErR0xrdkhRQkF6bFM5ajdBVEdQY2ppbjJmcXJG?=
 =?utf-8?B?TlUxSGQ4UEFnaWpOK2FUZlZ6cEprNExLTDFNekd5OVRObTArRis0amtxWnU4?=
 =?utf-8?B?b3NBN2szSGdGK1lXaWNlbllhYnhXMk45RTRKQnpHZzYzRnJIT21yS0VBVE5V?=
 =?utf-8?B?b1drTjZ0TEtveW9xa1JOdXRtL0hjeTlJWHRjbjQzZE95aWgxMktmRStqN0R6?=
 =?utf-8?B?NWcvZjRYNjF5NTA4VnplNjBSOEE2NkMvcVJvMm1QTERLQWlTY21EUnpnaEdQ?=
 =?utf-8?Q?qwcnEdgch1I+IcafR7pz16guJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jPH78myatbeuiAcv+67IhnaS7u7ugKXjfuE6YR3vVdJfq1OBKoERpYajhZ9BgAT/2XgRsTd/Agtm27eC+uUji8PBT0cL/9c4rKXrqfXbXOcBfb1Gnn1ENsDxPSv+CdiP3S1GSNr2XWjZNH+fkBGN/WUZepkVvhl8BCCPzCvyoVpGI7wuWwNTjc6vSsUUL+2WstHL6ofFkGkkPhI44IKJ3mQo0B8rIeiH1vp3zIL5c8RYwqR5jPOLldy/SMn6d8co9ILcQdtwWOItcIGDbstyEIlnQODlASjFuj8y2MCaXRsqc5fT0nvSwaf23DkF4UOSzA8dtRsHJ0GvSVBGjImH30Xans5aRvbL6+xQkyfI9/JsTzMn0w/cWvtUeZIR4HzSxJjux6FX7/7vr6QSdHKHqKjpHucnB6p63o9e41nB0IP3W26ZRfCO8ho4mOl34x9iYz343EQFWAySA5p7sjJ/15h7CkJnzpmLaviurhnK8kZlLS8wBJJQgYDeNgL/+x5zQ2Nfqv/3uijws1x9zHOW8d44Lg/H7KBI6fNl6K0S378Dd6nZTN15cA7r+McyEcWcAfjwkUt8yg8WPuEw/t/xTqtcQNn8kBA3ooNIb5XkHd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e04b11-72a7-4a44-5b2a-08dd82748994
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:38:39.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAmP4aAb+1WXJN7yhw9F6XGXBhrwQLzO3+/J3r2i55i6iyizXH9MKaRRSwahFOm+DmrPO8Fm5zj2xbzSsuQI0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230103
X-Proofpoint-ORIG-GUID: UNYpyKXjK3KDJUGj18IfcofdcRX1tMdQ
X-Proofpoint-GUID: UNYpyKXjK3KDJUGj18IfcofdcRX1tMdQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEwMyBTYWx0ZWRfX4rJkqct8T11E YjjPQt/EYrUJXoq++9Ny0feu8QxFvZlnV3/GkM2hQYpAKfkUh1UPT3RA7ayXWyh6H4YmTe/PO91 5oUv3+zLXkM9jkmHeemjoL3/NPI59+2f62bS5L/W5LyfYK+uoSsgaXEyhnlCF0uCg3GPJgviSip
 F6SwONXTFasUn8F3lsmrDojOhnhEhivlVM0RgO9gy1oxMOkjEuesQyq4FFvhTJHdxZMGsBwd2SC Ai69Ftu3ER5LW5BvTcZb2uSieL2f/5PHcEf6IgWrPhWYOfH1WIp3dJhdPTuaTtzfOjk3yxX/O4E sMChkXJFXFBk/pP8OC4O7F23qMvz18AFX3sqOiGejCbehh83omh17iJxE2mcBGBiJaQ9FvhT2YG Pqt0M6yz

On 4/23/25 12:25 AM, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The following patch set attempts to add support for the RWF_DONTCACHE
> flag in preadv2() and pwritev2() on NFS filesystems.

Hi Trond-

"RFC" in the subject field noted.

The cover letter does not explain why one would want this facility, nor
does it quantify the performance implications.

I can understand not wanting to cache on an NFS server, but don't you
want to maintain a data cache as close to applications as possible?


> The main issue is allowing support on 2 stage writes (i.e. unstable
> WRITE followed by a COMMIT) since those don't follow the current
> assumption that the 'dropbehind' flag can be fulfilled as soon as the
> writeback lock is dropped.
> 
> Trond Myklebust (3):
>   filemap: Add a helper for filesystems implementing dropbehind
>   filemap: Mark folios as dropbehind in generic_perform_write()
>   NFS: Enable the RWF_DONTCACHE flag for the NFS client
> 
>  fs/nfs/file.c            |  2 ++
>  fs/nfs/nfs4file.c        |  2 ++
>  fs/nfs/write.c           | 12 +++++++++++-
>  include/linux/nfs_page.h |  1 +
>  include/linux/pagemap.h  |  1 +
>  mm/filemap.c             | 21 +++++++++++++++++++++
>  6 files changed, 38 insertions(+), 1 deletion(-)
> 


-- 
Chuck Lever

