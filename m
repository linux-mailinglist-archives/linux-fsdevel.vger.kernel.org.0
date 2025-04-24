Return-Path: <linux-fsdevel+bounces-47280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B658A9B4E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 19:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5681E4C38F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5001A9B4C;
	Thu, 24 Apr 2025 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DMxdm+jF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Do6j6rrK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0428DF1C;
	Thu, 24 Apr 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514018; cv=fail; b=OH4S/T7sRDFRSHAHpk/Z+AT2KHb//S4LRoFZ42dJsYt6BIGkYAu7uYoxUwVSARKg/0nxP3EYYNLfUMnqzQIO28CHJ15FIT1aXnV4nDFnDcxsdT3cZ7qwS5rmktfiYeJxGVpAlBHWWkNEj2t6YBFQ5RN6wi/33IlhZO3AZCJl/As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514018; c=relaxed/simple;
	bh=x2NC6Fo8h6zrXHLra7kEmupfLBNLYRn33zJyHUTfaic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UQGWuW2kPRChPoohaBu4QTAUWQnhxE5x6JSCw8CPmcO4yL0049Vx9RwVrwkRiSfGj7b0FMLAuzUO2r7CjNLzo5cXQudK88VpoqCpDk5PjEr8nrRpdCQDKdq+m2Pwft6xus1YUEJWICq6jdYhAnzDgpYdXkAsUhQI2zD7BN7vhiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DMxdm+jF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Do6j6rrK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OGl0rD029143;
	Thu, 24 Apr 2025 17:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yO0EwlOKHp+EhFiVILjlUQQyi4YkDeKxU4B1YQY4PVg=; b=
	DMxdm+jF6WWTxoEvSm9uNiC1JbxdBxvJa+rozRTGQ+BtcuapcObjc+CQwd6R/MbW
	bFGEk81BCGaI6pT/cAmXHbE06B1inrjbGdYY8ndq7z9/DQijmMqTY+f+Cmeqh2fu
	J4e1owMO0P5IosbscxhE1JdYTeneO1BsYjWAto1nbXH3fKckJmTvE/dW90whajBU
	X2J3L4e0R4euLfikFJRRudM0ixKc5oWDmoXpXHi+f8MOXlEjPjS0qplao8ZlomtS
	BPk3GZNlniycN9BDv/MVzSgFkft1yd2VVbaYWmOtScyX9rK4v3mJT47CaGCoN9hz
	GI5zM+c5aszlCDEsCiAd6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467s4a81fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 17:00:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OGl9Yl014191;
	Thu, 24 Apr 2025 17:00:00 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012036.outbound.protection.outlook.com [40.93.1.36])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxqjds5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 17:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvujOd+2+UPDaY8loB2zBmQ1HKdDPod7wDZOE+iUr/VlD49/lh5Uo+9uaEEw8eRWT1a/T9O27vGbqgJHI+EQxwPbNgEOBu8E0qHy17WZyk3QZlelpXNEkeU4WNyU7jRyrGA2oaCFoC7AWUibv9Dyh7l99FV2msd41JwfHMN7t4Fq1OCJVsntWyo7p7aO8mhbcvO1on3MfBCqk2DZS5c4+fcDcOKKzCbaGJdSjvDAxwGqsCi7jMk4qoxvFKUwjHeLDhAwbS5KwFdtGntWIA47dEw1ohg+EPmxyTJWf1c8KXoRihSRL60pg/gPtXLFJf0KKmUGXE0AYKl7y040KKcQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO0EwlOKHp+EhFiVILjlUQQyi4YkDeKxU4B1YQY4PVg=;
 b=KuFSGp7GYEuTrxQcTKysU8fTXaLFJlN3inCb0b7f8ov9TCNa6fQyIsivjx6+SCrsl4PYqbYTJFApBQO/JvvjixiPTppazg5jflIIifyeGoVxYkKdH15AAhsy7VyydFjvo4xD03dMTQw2DkZpE7pXt3StAkiH70TMW3Q5+lzl2L34rqzWz9rBJCEPmdI5dhj+EwlVQLEyLQBb5o900vsuysJKD6eFJE2Ec5uM5a56Ja54J2bG0b48h989f9nY37FUFGHdr4uLdcRjzizPGDiRAbYM8M/M+Rg/T8gzwFE6rIR70ADNiXti+N6+mMlT+e9CtQwYnxYtSeXomJJAM5y1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO0EwlOKHp+EhFiVILjlUQQyi4YkDeKxU4B1YQY4PVg=;
 b=Do6j6rrKWAMsCdQEynEnI9B1f0OwpqScHAXYBSrpRrvIOMuULOha6wimxK6c72FDIXrz/srAh5Mtpc/L/z0eijRhK/eTya5A7/iUdB0vvCTlaNXaTwAKHtx8/y07EpxLAnFcaY2sGdQIPo+ZipbjZSNoanw+UQiWcqY6d02Pr+U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Thu, 24 Apr
 2025 16:59:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 16:59:58 +0000
Message-ID: <ba369f42-686b-484b-afb7-dc435b642c83@oracle.com>
Date: Thu, 24 Apr 2025 12:59:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Initial NFS client support for RWF_DONTCACHE
To: Mike Snitzer <snitzer@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, trondmy@kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
 <c608d941-c34d-4cf9-b635-7f327f0fd8f4@oracle.com>
 <aAkFrow1KTUmA_cH@casper.infradead.org>
 <97033bd0-dcf9-4049-8e44-060b7e854952@oracle.com>
 <aApsAAYJMMRtKr8h@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aApsAAYJMMRtKr8h@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:610:4f::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: a5659b08-533e-45e7-550b-08dd83517197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjRXOTNlNC9NQ0RoRXlKVStLUHpGeGVsbk5La1grblZFUHNNUitQRk9BaDg3?=
 =?utf-8?B?V0pYMUFPWVk5MGJNK0xGempWSWY4R1dwQ3V3dVhnaURQeElKVFZRa0swOHFN?=
 =?utf-8?B?QlRHQW1nczl0bG84VENYK3hJNGlhWEZpTEN4dDFncFo3TGdPYkcyMTVEbm1S?=
 =?utf-8?B?ekh6Q1hqTmh0dThKLzQ5K2g0Znp3Tk45N0R1S2FxbytXOU1VQVZyUGtMekZW?=
 =?utf-8?B?NWpEbThDTEYwRHoyV3lqaHNhRkM2eEJwUm9DU2lwZU9zREl5MVNXYjdhY2o1?=
 =?utf-8?B?WVRiQVA2ZXFzOWtRVHBHMkN6c3VXb3paak1tZEpKdTIvRmp2STBSSlYyL0NK?=
 =?utf-8?B?U2pIdGlIQjNqMVdLYzY5ZnRzMms1WVZybGR2QUJVRFFSTld6RUY2Yld5SFZO?=
 =?utf-8?B?Z2p1SkxZTitudGdWTU1rckkzRElpNzUxekFuM0RQUUVxS2xqZ0xrVHdkbTFR?=
 =?utf-8?B?cnY4TFo4ZGlscHhYMWN0NGxGMExXckxPNGRnR2gzYy9FR1hyTkNwSEFDZEFT?=
 =?utf-8?B?WUVTNGg0eXpGWlhhaGd0aFVLbEFZYzFUb3JNOGNSbTVvQ084ZVFiWFk5bDAx?=
 =?utf-8?B?YWpxd3FjUFZlSU40bGNmYUUwZW5qenF6QkttdlorMFZsSGU1VDhCRHdLajk2?=
 =?utf-8?B?NFhRRnp0NThZMDhTbTVjL2ZZczhPUzRuOG1OMnpOYVhIazQ5S3FUb3BOTTN5?=
 =?utf-8?B?MmRFNmpQN2srQU1BOEdGMGtmQk9ubTRoZTJyK05KSnloN2k0RklISGcvL1Vz?=
 =?utf-8?B?K1dWTzRFdS9oK3pwSFdUZVI5Q1ZVYmxRdFZEMlVteW1nTHJCalo2RHE5bmRj?=
 =?utf-8?B?TERZQThjQ2VDRmdnRHRvTXo5bG9qSkI1dkVhQ2pidysvajdzcnhyUzRyWTAy?=
 =?utf-8?B?U3NhRGVyTEdpMmFremhQT3N4YnlaYUZmeGlkejUya3hUUU8rSGJ1N0xwVXRz?=
 =?utf-8?B?dzRITkx4K1JDRW5ZNWdTUjk4UmpqM0ZSUDk2d1NZZFZpaVpEKzVHYXJwQ1hL?=
 =?utf-8?B?aTU2NS9Ueit2ZUlGZG9kOHZLMU9aT3hmN1I4U1NRdVpEODdiZHFHa1pBNjRS?=
 =?utf-8?B?RjdzOFdsVEhFQUxyaE9NMHlGc0NnNms5NHZsL3NKYS95TDZNOWdzdGd6aUI5?=
 =?utf-8?B?RnVwa1hpZWI0U0R1ZWJScXErbVNUOHY0c0Z2U01BZVcwdTg1TUtoREJ6eWZi?=
 =?utf-8?B?SER3cEtUanlWUnRKSUIxa2NIK0IzK0FXZ2ZPenltdDhVYWRmZi91WlBYOHhx?=
 =?utf-8?B?K25mdjZLcEZTTXRIQ2VtVXhTVFdndjN6YXVLVXorQzk5djc0MXZLNXU0eUxZ?=
 =?utf-8?B?TlRpaUkweXJKOFdCdlB5U2FuZ2lxMkhDTm4vOWxwSHJTL1l6UGErSDNDbXR1?=
 =?utf-8?B?dytKYUgwR2w4cXQ4QVF2eW1VMzI0ZkhnN2thT1dUWjc5R3BXek8zNGV1YXVB?=
 =?utf-8?B?c3FjUkdZdUE3clp3R0hIM2hneXdKeXJVRUNEMmdOUHcySGVSSWRQaVc2a2pC?=
 =?utf-8?B?QnFiblk3cEQvYzF6MHNnMG92bEw2TFo0R0thL0ZraHNFSzBSZm9VcjV5YVRn?=
 =?utf-8?B?akJLUDN5Ny9sRGc5aW5QMTM5TmhMMjIxM01LKzFyd2l1UWdLSDF0SUlpVkxM?=
 =?utf-8?B?Wmw1TzFzUVVCeHB6cVczc2wxdEpWVjZBNDNVcnFXb3d5S0pOT0tWMzBsTjd2?=
 =?utf-8?B?OXExUnFxR081K2VXSjFuYmg1bmY1dVFvRFJ0em8xeHB6RDgxZTZkd2puc3hy?=
 =?utf-8?B?eXp3dlNYSS8zempOYzVqU1psQzdpK3lIcXFRdkYwbWxhRFVKUDRvbEo3ZEc0?=
 =?utf-8?Q?McoOB4dE8Z7ru7S1ofjQCvRtaHgTQeVhWhtO4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlhvdDdqNWlrQzZtS0lsNFN2endTbkhPL0xwczQ1WDNPSVI2YStsZldabWpz?=
 =?utf-8?B?SkVvQkJhSlVqdXE2ZUNoUTdiM0RhMkl3c3NhMHp2QjRjRkR6NGtqUE1SQzdW?=
 =?utf-8?B?QXB5WVRWUWFHK3JQRXAzaDNZbm8zMFNMczYwL0FvMjN0VU95SVdqOHFXek5H?=
 =?utf-8?B?N2xOWmw3YURSNkhJNWxGY1FPcC9YWjBldm9oWmpxMG0wS3hxNjNGYUNrTEYv?=
 =?utf-8?B?OVErZU92U2RQSUdCSXZXNWYwS0RBWkJXSTROVmhkWnp4L1dDRi96YmIyWlds?=
 =?utf-8?B?WThPUk5QYUNuRFRpOTQ0NlB2RXpMTGl4QXJxK082U3F5SFAzNnZsQ1NlVTRw?=
 =?utf-8?B?U2t2ZzlSdEVBaTQxQW53ZEpvMkpycHRXZDdRYklZbUNwdlcrUHY1NS9iaEVm?=
 =?utf-8?B?RDU4L2ljTjRnT2szbnRJU21jTUJhd0pINVdVN3gvWktFVDk4T2lYalJadVR6?=
 =?utf-8?B?a2NTWHpsdU9XY1kzQ1N1cElKOW1tY2plaFg3K1FDVE5zQ1d6VzdhREp4N0d4?=
 =?utf-8?B?VjU3Qk40OHdnUC9VNTRodXlaSStDMjAralNHTDBsWEs4NUJLT0YvZWRJazUv?=
 =?utf-8?B?RkRRS1hVS09Za2l3M2VkRU5qVWhIS1ZZakxhdXRETlVaTEZkZkoxSkNHZkpO?=
 =?utf-8?B?aFRPNmQ5RFNYekg3NU9zTU1OWTUyT0tFaGpvN3IxUlJrNFNRUk9mZUg4VHoy?=
 =?utf-8?B?M2FZM2ErQzBDOFo5RjdkUmVnQVFWblRPdDcxcFdzbGtZY0IxM3g1UnlXZnJy?=
 =?utf-8?B?WXdqbm1kS1duYlFOU3hLOE9iQ2dQYWUrdzNUbFllcjhpemhLdHNUL1NjT0lr?=
 =?utf-8?B?MU5qZFpTcVBYR3VRYWZHUENXZDhVUnZ2WkZ6eXVqUmhqU0ZQd2YxejBLM29i?=
 =?utf-8?B?UmhYVTBjL3M0b2d0aEJjSDZMZXA5MXJhNCtZc3VFOGtvZFZHbUtWZmNOdDlK?=
 =?utf-8?B?cGxzOHlJVno3OSt0a2E5THhDZER5ZExLNFFzOGVzVnJoWG5QTmxIVGF5YzVB?=
 =?utf-8?B?a0JOZHdwMHJ0bmZnaGxvZ2ZlNnRickQ1MjJBMEhlVVMra01aazhtNFFjTW1Q?=
 =?utf-8?B?Lys5MDh0TmhjWldNK1djTnhVak9DSGlySEdLZzJsSVEzdkNpT2lIOGZsMysx?=
 =?utf-8?B?S0lQSjgrakYxSHNvS3o4M3VaVDR6M0pnVXdVN3pCNkg1VjlEOEtaVjhsSVZQ?=
 =?utf-8?B?UTFPeXBzM0VvR3R5Q1RqQ0tUYkNrMGdmQUF0QUh6NXN4dkpwc211QW04N0xS?=
 =?utf-8?B?Z3ZSbnZ5c3FIYlJQK1I2ODY4Rkt3OE50RWdpajBqYWg1K0tqU0xqY2tubzYx?=
 =?utf-8?B?U0VUNGdWZXJjeWJuZVN0emxxdEJrK3lock5jRlZnNkZkcnBhTnJ5cHFMM2ZL?=
 =?utf-8?B?NUloc1NSVU1ZQ0UwL3kzckxFOWhPT0REZ21xK213RklRL21lNkQzVVBiLzQw?=
 =?utf-8?B?RjArZlV2amgxQzN1M0tRNlAyeXN5Mi9XS1dDbkJ3Mmx4TEVNd0NVWGVxdWVm?=
 =?utf-8?B?cUV1ZVRyWS8zSGFuQ2hkWW4yZ2JZZTBKYzltU0ZXYXhHTWNxTkY5cEZaekhF?=
 =?utf-8?B?MDFoL1NJeVUzeWdpcUdmcktrTkU2N0ptY1h6YjRLS2pLeFVqQU1pcmVycDZq?=
 =?utf-8?B?Vzd4d21qQVRwMXpJMmpPYTEwdXlxVVF0bWRzdUpaclNYMG9lSHhDMkdRNDZU?=
 =?utf-8?B?UUFKUlQvaWMzR21HQ2EvU1BjankySnZjTitIZlZFdWFXK0lRNG5SRmZHd0hN?=
 =?utf-8?B?T3FNZ0JuNDcrNWFvMGNsampsSHo4Q2cwVU0rWWY2OXBXRVhBQWczNnZYMnN3?=
 =?utf-8?B?Y1NNQTlpZnJNbkIrRHR6QnhjcWV2dFdRWHdDb29ZbXVkYUJ2OTYrL0VPdlYr?=
 =?utf-8?B?T2dvT2hSN2dGekhJaS9HTzlxdllZWnRLWmNNYTdNVXBwTDh5QVRRUG15ZFVD?=
 =?utf-8?B?ZlFGTnZNVERHMVEzUFErSUE3NFlpZWFodUtjN0t2dGswN1dya21MTjhXaWxn?=
 =?utf-8?B?czUyYThkOFg2aWk0SVRaZmszajk5Z0dmc3ZIL3FQUEZMa0dRVElGek5KOTU5?=
 =?utf-8?B?WnlRNHQvUm15TUVvMEF0NVEzaHo3amdoa0tOWWNMQjZ2R2FwNG5FZlBmMkNt?=
 =?utf-8?Q?FI2HiRbvtKCSMbltWNSayXSdW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O0CfJY/Z++r585VacaT0zctMaiBOgE+DmcJ1j8D+BcxumGOjKEDqnqDK71/uWkwPwk7eLh7aYd57EO+53DEqairYwcndIsTBkhnirU7nO5EuSBuLkh0RqjCuqerFVkD8S+gfPpycapmvZNIeQauf3olVXlZqwZP+7NWNgCBhNQPYJYGhQ0ctuhT+oCd81dIFX3x5LTOpvlOWP+S5YlNfAvhHQutKdAi+BlVmdV3vPCz1MBPnx6edCLI85ZcicNhmlkgKH8NLUn7SsSHxXtADvoXwGI4p9V9KixYjBlOAZpe0+ygnCxxWt4sYI3FKMh09NrwVw3FUXmqW+oroczm1t01LNaD8Hmt2rwSNzl6lY6RlG6S8Ig1PUeqLrS+7C/WadWIVjqQ6oNfF2CsnwMF0+WANsVlAtUgOnyszTU4t1gmHnivFTCTKAtQebJqw+P3sD37eIAa5eMhNFv1w/+JpuyHqKCN3cC+3Gr28sguBAZ44iCEuqq0WtBhPeEfW0t3xikGR4Ly7CqBV6+DBbzJ+T2kstIow8/wV+BnPe7BisW+zgeWi3aYtLlaDnfT+5SAzhg29zmWu8K9ZSFiqp6dow4bAltUnzRiXWqVENNqA2ys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5659b08-533e-45e7-550b-08dd83517197
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 16:59:58.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u36765qTv3wM2uasTpU+x6WcVBDUG7aJiZ9PS4YKQLRosMmDYv2H5jA7Kz26xg63IRi8D7Q7so/0lt9aetScwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240117
X-Proofpoint-ORIG-GUID: q9scPICe-9k8lVvGE4mQ0bN0krhz42zd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExNyBTYWx0ZWRfX0KDgoqsLzHBd Ji1SAAyMxlEHyYZTBbUsVtGJxJHua8Zt3gDNmbLLNzrAhXRjBKnkRrwsyL/OTdzWBbUlQzYQUp0 +96gTREHYwCS7kfUcK/ciZGB2nCUKlbqRTovl6dYQvO5UHIk18pbDEn/Y+YFY47nc5tqLpkGl4b
 RWof7+8Y75yDMIwYsEGhDbo5L6hhzmgR7uEmeNbWCgItJ1osec2Z3SOSSFnrPVga+9ymUM1Pph8 RgEg6dOZkXYx0FTXyR8kefsRFDah+OuluoE8Alk4jrDfFg+8NT16isCOQpYxkBrywmQo4Eob8kz A0//r7/8kxx90oFncLQG7iNybq9es3x586gCsAfA11CdfxSIB57srsp/YrpgAfdHE2v0lBVr6yd Zv73eLFC
X-Proofpoint-GUID: q9scPICe-9k8lVvGE4mQ0bN0krhz42zd

On 4/24/25 12:51 PM, Mike Snitzer wrote:
> On Wed, Apr 23, 2025 at 11:30:21AM -0400, Chuck Lever wrote:
>> On 4/23/25 11:22 AM, Matthew Wilcox wrote:
>>> On Wed, Apr 23, 2025 at 10:38:37AM -0400, Chuck Lever wrote:
>>>> On 4/23/25 12:25 AM, trondmy@kernel.org wrote:
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>
>>>>> The following patch set attempts to add support for the RWF_DONTCACHE
>>>>> flag in preadv2() and pwritev2() on NFS filesystems.
>>>>
>>>> Hi Trond-
>>>>
>>>> "RFC" in the subject field noted.
>>>>
>>>> The cover letter does not explain why one would want this facility, nor
>>>> does it quantify the performance implications.
>>>>
>>>> I can understand not wanting to cache on an NFS server, but don't you
>>>> want to maintain a data cache as close to applications as possible?
>>>
>>> If you look at the original work for RWF_DONTCACHE, you'll see this is
>>> the application providing the hint that it's doing a streaming access.
>>> It's only applied to folios which are created as a result of this
>>> access, and other accesses to these folios while the folios are in use
>>> clear the flag.  So it's kind of like O_DIRECT access, except that it
>>> does go through the page cache so there's none of this funky alignment
>>> requirement on the userspace buffers.
>>
>> OK, was wondering whether this behavior was opt-in; sounds like it is.
>> Thanks for setting me straight.
> 
> Yes, its certainly opt-in (requires setting a flag for each use).
> Jens added support in fio relatively recently, see:
> https://git.kernel.dk/cgit/fio/commit/?id=43c67b9f3a8808274bc1e0a3b7b70c56bb8a007f
> 
> Looking ahead relative to NFSD, as you know we've discussed exposing
> per-export config controls to enable use of DONTCACHE.  Finer controls
> (e.g. only large sequential IO) would be more desirable but I'm not
> aware of a simple means to detect such workloads with NFSD.
> 
> Could it be that we'd do well to carry through large folio support in
> NFSD and expose a configurable threshold that if met or exceeded then
> DONTCACHE used?
> 
> What is the status of large folio support in NFSD?  Is anyone actively
> working on it?

The nfsd_splice_actor() is the current bottleneck that converts large
folios from the page cache into a pipe full of single pages. The plan
is to measure the differences between NFSD's splice read and vectored
read paths. Hopefully they are close enough that we can remove splice
read. Beepy has said he will look into that performance measurement.

Anna has mentioned some work on large folio support using xdr_buf, but
I haven't reviewed patches there.

And, we need to get DMA API support for bio_vec iov iters to make the
socket and RDMA transports operate roughly equivalently. Leon has met
some resistance from the DMA maintainers, but pretty much every direct
consumer of the DMA API is anxious to get this facility.

Once those pre-requisites are in place, large folio support in NFSD
should be straightforward.


-- 
Chuck Lever

