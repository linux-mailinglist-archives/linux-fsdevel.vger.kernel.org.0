Return-Path: <linux-fsdevel+bounces-30519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E699698C205
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECA01F26305
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069151CB321;
	Tue,  1 Oct 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fEz1q2RS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fq0NFtct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E01C7B9D;
	Tue,  1 Oct 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797758; cv=fail; b=cJF5GwijoMXOY2iNxR2R8SqBDm7HrkLzAusU9IjV9haf+z4gN6ilZ7BcJcgpg+rhzxORiLuVbbE9YvJb7CkQg4SGQu8TLYB3E1VBm4sCLgQjsAcGBvciUYDRpjaOlWCLkYZsYvsQN3szZi0tbkZi88/z8PeLAD3zU3BE7WOtCYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797758; c=relaxed/simple;
	bh=fczhA5ePa/IWdn51py0b+OoDAM5eLn0I3CGn/PSwsR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RQek7moTSjBB+OzmvZPxXlCjOWIOsaGfLh3fCHYo8DwtLw6yUg4OjtxYZfBku5aDK/svReP1ixnV+m0mzRQMddE/3Pw1qLa/9QrHqE1TWU/ubyqoqax707hmp9dhyHKvwztItA2m492PU9YwMN/0PAwBj48O2hFVHOmF6Y2c1bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fEz1q2RS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fq0NFtct; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491DtaQS014808;
	Tue, 1 Oct 2024 15:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=T9ir8gQJNe5SCwpLzKGH0QRYRFczdrR0nM2+adB/vtw=; b=
	fEz1q2RSkDjhECKkfoqY4LaP3DX0l7ZX0mu5Ttt9+doFISMKna8C04lFdwsNHJ2W
	ko+8QdR9eIZJF8banPDJYFwILe51GEvv2gB+SXh8whEskrodKsC1FuYcVz8k990A
	s4wbNqIVYRq5EMeb4ikw2EA1XdFOqKlOpR7SGQPsAZLIkpAAYeg0QbkroPofADzb
	R7A+E+blqbisL+FpLRW6kvAyVeE9tnpgOnxHVBm5c+3Z9iYxejjh4sZCNxLRrOXL
	JQ+ze87Z2LvCqrvMr8DnlRGAH0oxK5QGzE9UOaC3P3p86lf/lcRxaiUaWtDbom5y
	kUJWZyPLiq8HhiApkm5K9w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1enf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 15:49:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491FKx8G040537;
	Tue, 1 Oct 2024 15:48:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x887qbhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 15:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBWWAsA+h7Xvb8UgzKNnQyxzr3KI5AzbQKpLPQ8v2rBQJYx2bYULpP9SIQoj3gkvORRl55cpZnfXVvjLwYmTVAolGLUOEceUqB92IazvMbqx6D583OvXOHiCe4wZJDouC4LAoG+tDLM9WS8KqUt9c5wUN+DE5I438XnL49J1OfCCutjcKdqPRkKFTWBV4e6GIH2W5fzozx5Ug0pEMbjw9r+jD2YgIoImsV+edItcPMAnrTBoYtRcbHV+rasCJs8OaYwWK11viaqxgX/xDomvoeG49RZ42807VojxoVbixsFyuG0dye4U2QeF7a196JTXqydo1AAlUz+my0/GCWQogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9ir8gQJNe5SCwpLzKGH0QRYRFczdrR0nM2+adB/vtw=;
 b=uYFGICUFoQvJdgre+h7BRkG+StmILHvjaUhx6fAg++yMtG+u3VQ0yfwBX6aebLpsdQcdhRGqDQXGAduz5edOXuD9oc3m/pVe+IFbU0OKQOtxWhdbtviiTi/bf28QM1NRCiaQ9D1PCXwPphju+iCMoMtB8Kz0YyIviIuSgDF1TXF5QSI4j48VkVJr//2E0rpU+/5AQN/tmIvjQsNVFaYQ2O7vas+A+Bpx0Du2IVwfnzS8iLbGPqe7FPc3KNDNLddGj9MCNaWvOIzV7IpjPoeqRDOpnl3gBR0LxnLdXKj5054f77OBXGmpG+Je9is6pB0x2qvwWbTaxbrOTBzPhJwRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9ir8gQJNe5SCwpLzKGH0QRYRFczdrR0nM2+adB/vtw=;
 b=fq0NFtctLoszX1AU+My5UYy5R8rd2e3bWgyo1k1zE4bR4UzNFdNeso6zDWmgV0tk2mappq+g8+ojTP0C+femqqADYwfR1YSUle0eGz7QE/GTXHwsnDOj5Kau8S3unoeTwmMlL/LjowfES61oWnjqV9QHu3X+cB7JWrFu89KXDVE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4692.namprd10.prod.outlook.com (2603:10b6:303:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 15:48:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Tue, 1 Oct 2024
 15:48:55 +0000
Message-ID: <8138f79c-7390-4754-b5f0-8320e82f81f8@oracle.com>
Date: Tue, 1 Oct 2024 16:48:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] xfs: Validate atomic writes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        dchinner@redhat.com, hch@lst.de, cem@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-7-john.g.garry@oracle.com>
 <20240930164116.GP21853@frogsfrogsfrogs>
 <7fa598f5-3920-4b13-9d15-49337688713f@oracle.com>
 <20241001144851.GW21853@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241001144851.GW21853@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2d51ed-57a8-496a-bab7-08dce2308e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHVUSjdrbDNzRVk2bUkrTk1QS1JBdGVwNi9Ja2theFpNVllQNmNHNHFDaTBL?=
 =?utf-8?B?akFlRmcySDJXdmhxOVpTVkpkN3ZIeWwxZ3owTHlkK2IwbCtPN2gvaENyWnhY?=
 =?utf-8?B?ZU9VQ3lzN09LTmh0cllVZ3JHNWhYZ21WVUJCYVY4TUhYeE1GcTFKeTNnSVVO?=
 =?utf-8?B?T0RJRnF6UjRGajZwQnY5T0psckZmQUVlc2MrV09jWlNNa25LcVM4TlVvWDlj?=
 =?utf-8?B?TUtFZXNONVU1YUd6MHlTSVNTY1dxTnFoZDlBVmVxdnZnNmVDMklRU05zaEd2?=
 =?utf-8?B?Sk5mOWs1Nk1vdmR4M01kNGRlcUUzaHBDUGVjeWhrcGxuQlUwWURodUQ5Qy80?=
 =?utf-8?B?K3VJbEdWK0lyM2VNejBjK1NRbXl4UmhBdlJoNS9XbjBBM0F0cVppdVpYMHdI?=
 =?utf-8?B?Mk9yYk9BcW1TakFBVVRrenZyMWVtajEvaUw2bnFnd0lCVXNnWngrWkdrU1ZF?=
 =?utf-8?B?SUVQOU05bnJkSDVYdnF6N3piUUovTmNzRE5Bak1ZSVE5bWVRQUMrZG9wdmpO?=
 =?utf-8?B?L1VQZWNnaDFRcHpZRjhRWUYzVlozcjBlZFRMejh5WDF2SGJjajArdFJYUWhL?=
 =?utf-8?B?QUZzZVdhUDl3SDZFckZrWEY1YjhyZ040ZklxQ3BGOFBLeEw0dElsbUZrbXV4?=
 =?utf-8?B?bXF4RnNVNU9Mbm4zRXRtcTlNWnRMZW4xNWppK1UrR3RlRjcyVkpKMlY0Zlc5?=
 =?utf-8?B?ZDFMb0ZXU04veHpQb1Fudkk0TjBFaEtHcy9YbGV2QysrNHFzcHBaUE15U2tP?=
 =?utf-8?B?c3QrRlRibFFFVjIvQTdoTnp1R3QrK1VVK000UGsxMjhxVjBIdmhidWJad0cy?=
 =?utf-8?B?WVNUZUdYbStRa0xqTDJhdUtnMGJFaWllbzhiYlRTcGkwVDN3VUhPTFJ2SmVU?=
 =?utf-8?B?RGdsQWIrUWJZOFFoK3NvaTVsNFJ6TXlCNVFCekcxWktyTFhrRTdqZ3BTOVQz?=
 =?utf-8?B?NTFXZ0l4ZExhbTdwRFRYT1dxWFB2OGlCUGp1WnR2UGpjaExtdDhOL2xWbzRx?=
 =?utf-8?B?L1hNaGpVMjBXN3dLM3dmaVc4TSs0YkdnQ2dZcnV1Wk9LSXJ3Vnp0Uk5lRVI3?=
 =?utf-8?B?aTVoZHVwNUJBeWdqQlBPN2o2R0dsSlIrMXFQQnFXNllZOU5qYWJmbmRGUEk2?=
 =?utf-8?B?ZHFucUFYTG9qbWdjOTliR2haOCswVi9MM25oU0QvN3FrV0tsVDdsL2hpaEJm?=
 =?utf-8?B?c29OczN1NXM3Wmp2ajJjc3ZJdXZwejJzTnhJcVJpdmJ4dUFJZGpoYlFza1pt?=
 =?utf-8?B?Rk9sOUdNWXpuMCtybmh6WnpkWDJGckF0MDBsRlR5OGI5dmw3ZFZMUjdTYjZh?=
 =?utf-8?B?TkI4Y0dCd05nTVFLamlNTGZXeFRrQ2xJNlNZZ3Y0cGdZR3NDRzArZ2VPd29W?=
 =?utf-8?B?NHRQcnpybFcvVjVHZWpHVEJvUkxKVUNvTFlPZVlwcStFU1dCM1BvQThOTTVG?=
 =?utf-8?B?d1BHYTVBcVpBRk9HeVo0OVlnd0xONytnQ3F3L280L2lKeHIxWVpSem5WblhL?=
 =?utf-8?B?UGZ1OHhaRk40ZGthVW5KMVl1U2RKTWhRbDdnSndtN252UHp4ZGFTQWI5aUNy?=
 =?utf-8?B?TmVhUjhkOXVLdFFNT1ZySzNkZjBQdVlGMDJ2NUlTVVVMcVJJeklRNk96SDdq?=
 =?utf-8?B?U2xZZ0Fma24zQU9OanlSaWU5dWc2YUF5R0dPWkk3cC9Cdy9RTGJCWTYzRzB1?=
 =?utf-8?B?RFRJVndibUdSc0VqODJXUmovQjNPTVFPMWQwVHErdWV1ZVBZMEZvbGF6TWJt?=
 =?utf-8?B?eVR2TTJwdy81dEJjbk5DVzdYU1lwZUk0a0liS2Y3MnFmdzcyR2J5UGdzenhq?=
 =?utf-8?B?ZlRUOHVFaDhvRHIxVytIUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG03YWEvZFo2c0ZYaVNuNHM4ZCt0blV5UUNuREFKTDVyYkxoSmxCSVVFOHNP?=
 =?utf-8?B?dkUycFlXWFdubFR6bC9TOFdhN1pSSnhybzgyZkc5UUNzcTZKdzR5VmhsVjhu?=
 =?utf-8?B?bUVaWksxTjR2N3NhUm1xT2kyVnZIK081TURSZmJCaVhwV2M5QjRkc0VRd0Vu?=
 =?utf-8?B?V3duTlUwU0NONklHWVRGeTFWSHFkeFBST1NZcmhCdGhPZGYzMHZyTmVnbXl0?=
 =?utf-8?B?L2JFMjJhek9EN1I2ZEV1WmlJb3NTTEJZbm5FN2NDbHFmdzEvYnQ1VVk3VUMx?=
 =?utf-8?B?b2JBZ1dBUUhUUWdVWXd0aUZpaW1YTmxSWlZCb0dZdlRtQVFEKzlTN2luL2RY?=
 =?utf-8?B?eWhYWTB4enpCbDZ1MGtFL0dITHdaNjhGNnFySkdDSkVhdjVaeHZaZVNsVGVE?=
 =?utf-8?B?dTJ2QnYxUlNCVXc3OWpNc3FoODFFNE00Yy8zaVNiZzVGeXRnTmgwRU41V0p6?=
 =?utf-8?B?dDhVbURRTjBQbTRVS3BSaHZueDZ1RUN0bHBIYkxFYStXL0NQdzlKcElnNk9Z?=
 =?utf-8?B?UmVSeGwxR08xdnU4NzlFRDI5NE8yNUpoZmE4ZSs1c3ZPUjBwYnJOeXRDNGtX?=
 =?utf-8?B?UFppN2NoS09nRGtLd1N0emZXNjRuOWZIRllOSGR3c1RrQ1FHZHgwdkhwUWE3?=
 =?utf-8?B?OTc5bW1pdU5jTnhwOHQrQ1Y0ank2U0JqcERSdzhUK09nSlVpL0ZVQW5mdEoy?=
 =?utf-8?B?d2NkYVFVT3pmdHRINUtWWngraUdKOUtZb2VsMEVFaWxWbTNpMnpRTVRMUTBr?=
 =?utf-8?B?a2FaemNQN0dPV0U0cmNFZE84WG83ZWRmZzJ2ajI0V2hyeWJKZGQxVS9EMmVS?=
 =?utf-8?B?Z0JjOEdRWHlHRnRDajZ6SHNETDB5R1JFcUxXYlI3STQ1dXU2YUZwM0NwTGFt?=
 =?utf-8?B?VDJYYmdUUVdCSDZMSXJ2Y1pRSTNsc2ZDOXY2L3ZFNWxybWdnbzBheTlweEFZ?=
 =?utf-8?B?YWtlR1JpVnZiR0xoUWF4MndoUEFPVG1jdHpaa3loZUxNSHZYTWZzbWxuQStk?=
 =?utf-8?B?Q0Vyd1ozTjJJVUVrNkI2ZHFVTXk2WEh0TkhDY0RVOG5YeCtUWUVoVVlQOWxo?=
 =?utf-8?B?eXphMVVVOUlsQVdqdERNU0RsQ1NpMWFmRlpUQktzS29lRUJ2Zjdjd1p1QUdv?=
 =?utf-8?B?MjlzYis2djB3cmY3ZGs4U1R0YzlxYXRjRk9nS0cyWk5ENXVSK01xaldib3h1?=
 =?utf-8?B?YnBkckpjYVVpVGxwR1BHRjBPb0o1aTJCeWdMa1dKbXBnYmFrcEZPYjVwNlVm?=
 =?utf-8?B?eGEwWXF3b2p2d25YcEpCYjlaLzczUTVhS0FqUy9acmFIT2ViV1Frc0ZjeWZo?=
 =?utf-8?B?R25XUE1xZzVCZ1J2a3VUUjRDMG5FcU9jRkhFZkxub1RjMDF2ajJOTTFMTUZF?=
 =?utf-8?B?akprbmN2TUtBeU4wUDJ4WDJLb2RuNUtxc1IzL0Z4VS8yNWp5cC9idDZuVGty?=
 =?utf-8?B?NHNiRXBMY3h6UkZleW8yV2VITzJZU1VWZW9nSTFZL0k2V3YwSmRXR0d0c3dI?=
 =?utf-8?B?bEZyYUlTd0NFUWVZYlBaUjRHZmFwTFQwQ1F0YndaNUN4ZS9LekdlWXpFWmIz?=
 =?utf-8?B?U3YzaEdVc09XSDF2c2pkTm8yenVoZkZrb1VLNWxhQzIySmZPVFpYNjROc240?=
 =?utf-8?B?ZzVSUkpqcWFYSG9nZEhST2NYOEtEbEFTb2JuZ2dTVXQ1RGw0ZTA4eE5BbU9s?=
 =?utf-8?B?bW4zZmtrbnVoc1NDOGNQUDVIc29QdGJRRDlNdksrUFJFQmdFcDVxcWRmVmtP?=
 =?utf-8?B?cGVpZHY1YWZTcDE2NmMzajBxbmZUalc0alVqNFhtZ3V5ODZZNUh1OG1pY1Vx?=
 =?utf-8?B?WWJKZ0pDRTU0NjdFL0hwSTdHdllhdEovYmJoVEI0QlFUcEdXSjc5emcyVWgz?=
 =?utf-8?B?ODVQNENkNy9KdGhwNitmYkpBNmN6Smk2K2QzdUY1Rkg2d2FHakt2K1dmbVc2?=
 =?utf-8?B?K3NGYTJIWXJUUTlSQXNkeFcyZjA1WTdCalpDWDhvUThmcFlrVWVuUENwcDRY?=
 =?utf-8?B?Z280KzFmTFBPZjE3TndmOE5GVElPZTZDV1lhVHhHWCszRjdDUWpzZ3VDUGth?=
 =?utf-8?B?bm5pTUhDTzZqb2RkT3JzdTJvWmVINjQramU2L3kxamVPZ2VOWCtTTElrR2FO?=
 =?utf-8?Q?ioj/epY2kc0Rbt9/rW8/Nnk5M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i6q84XFXAvP9NsEDhd5PBACf43cSihRdH1IU93fb0ySUpsssxNmXxG7USrYhuBYWTXSk5dfLCEeLqDyW69uupcAmj6jVQyRj80PM/Zu/+mlT+j3OSDCw8cTe0/4oxg9V/prfnX9++RZEO98oxBZSAJ5XvMx3tONoKv5d7oJl9h1nCmuXfLz/quD8Ky16eFLDU3wNXRgGoZPTp0pDRJVtdxtdUIkG3E1eBbWiK3CNOAVOpXiWDUVBr967Hqc77oTBbhRVg/yvgM4T67nw41KDhkcNfwXmJLd3Nm3EB4tov6+C4PhuZin6Ekpcb8kBp7CH2Hzrrd2MQmQuzPUV7L0fNrAuvbRRXd0eUcUFHs9ilwCHIeCi2ojMWWSVOI1IdTAQUtmb594Ckd2IX9RIjZ8pCJjzIfZFrPSPWuF+/enr4i0+70k4NTx8lbvSF5Nkr6uZwGMsDlBaqCMKF102RGf3K57LAhNDaBCk+UK8QBsavvVBvvFkjtrmNl4qrIg3imDZu00pumCf0t2Gu1hK6AjOC0hzYHePNU+6CQb0jdu17p7CrTKA6zVAcKiSQAr+JEuZfw3q+vSBRZPz96rcQCTr1ofdRPhL7YALgN6DuoiWzZo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2d51ed-57a8-496a-bab7-08dce2308e11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 15:48:55.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fk/v8BVIayUR+inYu2KX4LA/29EUj11D0IclsAqg4fxPRCaeFD519iUe2peINlxMHlj2jlyPyLEeXA6+eB0w6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410010103
X-Proofpoint-ORIG-GUID: tOTZFdGEQWujBZvIkb7AOXNKFSubTckx
X-Proofpoint-GUID: tOTZFdGEQWujBZvIkb7AOXNKFSubTckx

On 01/10/2024 15:48, Darrick J. Wong wrote:
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -679,7 +679,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter
>> *iter,
>>   			if (ret != -EAGAIN) {
>>   				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
>>   								iomi.len);
>> -				ret = -ENOTBLK;
>> +				if (iocb->ki_flags & IOCB_ATOMIC) {
>> +					if (ret == -ENOTBLK)
>> +						ret = -EAGAIN;
> I don't follow the logic here -- all the error codes except for EAGAIN
> are squashed into ENOTBLK, so why would we let them through for an
> atomic write?

Right, the errors apart from EAGAIN are normally squashed to ENOTBLK; 
but I thought that since we would not do this for IOCB_ATOMIC, then just 
return the actual error from kiocb_invalidate_pages() - apart from 
ENOTBLK, which has this special treatment.

But I can always just return EAGAIN for IOCB_ATOMIC when 
kiocb_invalidate_pages() errors, as you suggest below.

> 
> 	if (ret != -EAGAIN) {
> 		trace_iomap_dio_invalidate_fail(inode, iomi.pos,
> 						iomi.len);
> 
> 		if (iocb->ki_flags & IOCB_ATOMIC) {
> 			/*
> 			 * folio invalidation failed, maybe this is
> 			 * transient, unlock and see if the caller
> 			 * tries again
> 			 */
> 			return -EAGAIN;
> 		} else {
> 			/* fall back to buffered write */
> 			return -ENOTBLK;
> 		}
> 	}

Cheers,
John

