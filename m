Return-Path: <linux-fsdevel+bounces-47066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822BA983B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452551890460
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF5E278E6B;
	Wed, 23 Apr 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nd0XD1mA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a5LZsHSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368726FA77;
	Wed, 23 Apr 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396982; cv=fail; b=q430M4IMVR5Dl2Sx1rJ2P9VtLRzJ8fdmxC/8D5Csc312HtRGMmdwB1Qx5cI1U9PgkvBwD9sAP30cXoM6pmcbEhEvX7aT8C8YNHILRAdHLtWhZRP43/3FHHOIG/ApcwMGkYZjif8rm31IzqewnftOH4ygPmMOqHCUsu06rVmRV38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396982; c=relaxed/simple;
	bh=LTvkyY/uI29yTB2WgqjPTI97OhiM35/4qa9Sq4S7RqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lHJJuMCII0K6ckODJnfFHyJAnsCpklFbjG/2+kh4nJP21VWaBC9tSWeUZs8IIEF35M5U8NWQJSH/20VDU3G/2E+9BnSH2nKEEPxGPjIv7CAoHsQbSsQBKeSFbxO8TX1aVboX1DKgjsuJ5wNH91vCBLZ6sjJlT6/CZhdGnMYkQo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nd0XD1mA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a5LZsHSZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0uPWd003003;
	Wed, 23 Apr 2025 08:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Soonj3NygrKaznRqRmM+Ve496N5QJDpKTvNpTW+FkkM=; b=
	nd0XD1mAWmpvjnGCTs7+weutTH21hAxajP+fmNi6PfaiqHHlM3YezR8Ko5hoZE4I
	Bc1Vj3+99O3LzUW9QplZCPN6OLGT/ayW023O/uAa/CG3llhWo1Xo9byCodvUKg6T
	ZcNWlc03Bnei9IBVGmwm4NDB44i0z1ptnyE0e7/ekhMSF1KJDjBUjinAAdNcerXg
	JOK04/P9kFzf8RZTMkI1zNnpLmIvhUzNYIJ3iBgl1mkmyAAFHSASIysMe+scryRk
	FL9fiIr51R3ztpZ3/Be4+tODXnlUo69RK+/TM5auanVRgVMonXAk3edMlsO2KRDl
	wci4lFXwiIUrpCxp7+1L7Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha0qp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 08:29:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53N8KcA7028402;
	Wed, 23 Apr 2025 08:29:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx5s9tf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 08:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5rxvVYdoIdndVCrzvJbfq75sF3TYXdwglebUIWC6B1I8gUyhPWVUhaNwlbQk+K9+o6rV568zIMmGwV/OsKOBwcdL1zLXMqUxMp6DZk7PoRUzrmWRW7nEHfFT0I2YiLqB3zoXEI0jxqObo1Khg+g0sMp3s0O5/BZY8/p4zNz0/eB4syLTgvTapA509jzxQ8LxvRWnN1lPT+45dqwLulgcIURnjjolw3aqhBTwH0TVvvEDS54CtHrk/ENBkXc9r4l0mqI1bE+VHfmCU3YOauJ7Zi2utf7pYFvPe/fC3EzWJc/LEoo1flwq+HrnL6zZf/9stpiGKJB2t68wU7SleY58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Soonj3NygrKaznRqRmM+Ve496N5QJDpKTvNpTW+FkkM=;
 b=e6X/D5PnNfN0juK6Sa+ZcRFYlspBqvIpzPtRnVLyhMOHfXIGiuxY3s0FJiBjy46RvDiu+ux7U2AKGw0SzSp6ngTr5f5bezRTcPdJnroHdseHAInAtpbYDoAU+TOcmTjH9u+Dy9WfGLlLa8OVOcLVElCDwZsU4uANLdaCnV+geGK3Jxdyv9CcAkFWf+CmukOpZyNca7tuLB689fabWdtYC3fIsT85SD5XSQQiWD4RMHZpSVI/ovzPT23IPfQIbnUTjgp1jPcbqMTl0nx3A9OcDgFyWblZsHHnz6fITA/4LlKwg8w/2q/rtpfauaNm0MLAXUj4REZgSGIxnOxVYPVfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Soonj3NygrKaznRqRmM+Ve496N5QJDpKTvNpTW+FkkM=;
 b=a5LZsHSZAOR7EJ0+xhozl+aKZxMz73RYgXUwx0QbvgKABDpldvZgKkmJsdhe34X+cdbpnF3YATJ3sfJ8Xa4XR7/EU6qnENuCrFW4fUq56NLPNvtF5vCYEhV+tapXd7G1z6d6YjjBaNIMyX20ZUkrMlHw9rx7YlnzQYsE0H1Fw14=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by SA2PR10MB4554.namprd10.prod.outlook.com (2603:10b6:806:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 08:29:09 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 08:29:09 +0000
Message-ID: <0125a34e-a33b-4c3b-bf43-2f32f919a638@oracle.com>
Date: Wed, 23 Apr 2025 09:29:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/15] xfs: add xfs_file_dio_write_atomic()
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        catherine.hoang@oracle.com, linux-api@vger.kernel.org
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-13-john.g.garry@oracle.com>
 <20250423082525.GB29539@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250423082525.GB29539@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::31) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|SA2PR10MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 603017a2-4fe9-412d-2df4-08dd8240eb27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG5SN1NCRkc0VE9VWXY0eHM1aHJ6TFVZbkUzVjllSE1OYTFSRGxkOTFRcU8r?=
 =?utf-8?B?N21kalU2b0svKzRZVnl2bnE1cWdLOXFNZ2tEYm03elpQaktsNVFid2RiRVZ3?=
 =?utf-8?B?bnZ5YzJTQk1UWnJBZS9tNUNxdE1oU1dVLzhhS25BSGpiMEpyMFp5bUZLRitD?=
 =?utf-8?B?OG16WFpENEJNOHl4Y2IvR0gxTUJCWjBodFhOMWM4aG9sUExaTWZMdnpORFdj?=
 =?utf-8?B?Q2lvNjJLTllwSWVVOVU1eGUyTlNDT2YvL08yeTVJVW9BdnY0WTVQZmNuR2hE?=
 =?utf-8?B?ay95VGd5VUFEUFJCbk1zMGU2VE9TaFJiajRzRzhFRHQrUmEyYlQ2OU1Rd1lW?=
 =?utf-8?B?Q3ExWUZyUnlLUGxVejN1ZmhoamthRnI3U0Fab1FmRHJXRjlrZDdMckp4Ymhq?=
 =?utf-8?B?cXIwME4yY1BDZEN0Q1F6MjVIZWtrR0hZbXVUVkx0aFZqU1Y2bnpGZVZPQlJO?=
 =?utf-8?B?NjNNWW9tV0hSakF5ZFNWamlDblVRWFZqeXI3bUlWQWlXeWp4Z1NWUmNVem5M?=
 =?utf-8?B?NklPaC80Q1d4RlhCSk5RQXBnb1FvOGZHZVJNdzFrb0NzR1ZnQWYwU3pYSnR5?=
 =?utf-8?B?eC9WQjd0NGh3WE1MZ1kyUmVCWEczQ3M4Nmx1V3pZbVBJU1BwYTVkNTU5SlZn?=
 =?utf-8?B?VUplNVFka24vZGk0dExzaUhiRFFJOFdVMVl3MGxZMjFsL3NyeG9pZ05kdkJI?=
 =?utf-8?B?dzJ5UkVzR0l1dXFCOTBJeVI2bHpYZkYyM2VoMnIxQnZobUNpOEthNk1GRElj?=
 =?utf-8?B?aXVicUVpUkJrTGliWDQ0TjNuM2dsa2xDN2hzajhpMGk3STlDMEUwRjUyRGxU?=
 =?utf-8?B?N2tzYlFscjVKc25OTzhOa3RLSlcxNEJmclFnTk1DR2wreTVqWElySGFocVFR?=
 =?utf-8?B?UUxHaGx0b1c5OXZ1bCtiMGZhU3V3cnN6SXY5amJtZ01aMU1FY1FwWDhaNFI3?=
 =?utf-8?B?dktDc0F4L1UxaEJXS2pIdDJJYWhYUlRCZ1pQZ0NZdVNSWHVaT2lmUjYwNjVN?=
 =?utf-8?B?UHpBdkVKSDF3Mk5mK0llTVRmNTZJZVJCVWZzaE5vR3RBRjIzemxnRHFUdUhK?=
 =?utf-8?B?VFFnZ1hweEJVc2pRVzkwTWtCQWZUOE1HMVAxalFIeHJCM3J6c0FyVzhiazRZ?=
 =?utf-8?B?b2FRWml4TVZrSnJtNTRVcmdTd3NBZ09oaHc5VXZPMFpaMVBBRjN1VXhUY0xn?=
 =?utf-8?B?Vm9aci92VEowM05DZzBGb2JTUVNmODlpMWpzcnVnQ0lGT2xZRUlDUStqRi85?=
 =?utf-8?B?U0VDZ2hYOVJvWkxyWmlseGExN3d2MzUxRXRQcTYxYk9EMkZab09JQk1VYllT?=
 =?utf-8?B?NEtlUmtqN0FjVFFSY01Ua3RkRlJ3VDZqaUhpUlNwZ3hnSWdUak5vaXpqbjJN?=
 =?utf-8?B?ZFVaNUlpNU9TanhPRHg4WG9ISFhNSXJEcCtzRHcxaXN5dkRqTndqeHRZYmRS?=
 =?utf-8?B?cGVTcWNaSGJyZjA0U3cyTlFhMndNcHRCR2ttN2wya3krVkN0Y3ZwRnBlZU83?=
 =?utf-8?B?ZS9HYm1WT0cvRktRVkFwSE91cTZ3YXpjT3Z3ZDVqc1Flc2ZlVmtIZ0RrM0dQ?=
 =?utf-8?B?NkdCbWIyV2NwQnV3MFErejhaQThTVC9vSHlNZEE2L3l2cUIyd2R1UXBPd2xr?=
 =?utf-8?B?T3E1ZWoxZHZDaGxGcis0MXVYamhqZ2NuUlVEdW1nOU5aS2Y4c1ZtQ1AvSWpL?=
 =?utf-8?B?NHRHc1dEa1RDcDZwb2QxQm9XcGxIS1I0UDQ1akpqMzJDT1hkd1UxcU1CQTRV?=
 =?utf-8?B?Vm5kZHg3aTdOUTVPZS94OTg4WXFPcVdxcURIbEhBM1BwTjQ1RW04NFhMdFBB?=
 =?utf-8?B?L2ZoOGJNN3E2TmRQM1NwWEhMTzBMN0FwYnFOV3oycGFlaXVtRXViQVltRm1M?=
 =?utf-8?B?aGloVUhRVFg5ZVArY0twSERxUzBiWTA4RzY1RCtQNWk4RThZZDk4MGhKNXpB?=
 =?utf-8?Q?RpCpRnsRiaU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHBmKzk5RnJmWHRFS0cvWVNySHJUbm5DR2xQeTFFcUNQTTdmd0YwdDZVWFph?=
 =?utf-8?B?UzFZTW9MWnY4cEw5RnVuUDQwMk0wZkFxcitnd0JPTjZyandwQjl2a2xzQVBI?=
 =?utf-8?B?UGRERERXak1wMHJTNytTcnd3YXlZbzEzVGY3T2V2bzlkQ2xNTWh1cDRmeHNP?=
 =?utf-8?B?cjNFM0pPVTIvV29DdE9xSURGeHUxaHNYMEZxZzJBa00rZ0RSc0dBYTE5N2V4?=
 =?utf-8?B?NzNWM3NscGxyektJRk04SDJ6N2tKT1NaZEJCTXJ1WVowZGF4U1VWUjFsa01R?=
 =?utf-8?B?emRyeC9vVkJXVWErdHpsV05oM2dXdzdtVjd5VVE1bXNaYVlCeHlPTXY1M2hm?=
 =?utf-8?B?dktGc0xqRm1XaWNLZEJQSDN2bjloZFN0SWJabzlnMFNhamg5WnJseFFUYjQ5?=
 =?utf-8?B?ckFMeDNZSWVqL0lJR2xRbEVONktjL01VYmZhWWNIZndnQkhpV1lxS3d5WFFz?=
 =?utf-8?B?UkEvalV4WHlMZzBUbDZJTytxYlVoVHB0eUs3RjR4MVdlMm5WeWdpMGJvVTVs?=
 =?utf-8?B?ZGtPMlNXdjB4Tk5iZ0dVUlF0bUoxcUxOdmNKQWcycEhQUzV2ZEkzNHZpSkdP?=
 =?utf-8?B?QmJ2NzZJdEd3V0FVT3UwMFlLMkxXWEtJSCsrQ2VUNEZ5NHZiVlAvVHZSeDNH?=
 =?utf-8?B?WUNmMkVRTUlQd0dJbVNuMHdQbTRNZVhULzhwa3FVSW96eXlpTnYzRnNNTlhG?=
 =?utf-8?B?VHZ5U0pFUGdtQ0hnejBCd2k2RUt2Q2dRRWhlOXdiOCtVVmVDVlZiYkhCVlpm?=
 =?utf-8?B?bGwvVU5EYmtaeDdTOUJlQXVDa2tucjBPaWJpVzdYUVpoZit4a24vK2N0WWVk?=
 =?utf-8?B?ZDIvWGI0VDMwbXhNVkdrZ0llakpRT21hR0hPd3RTQTJObm90NE92Vy9uYnR2?=
 =?utf-8?B?Qm9CT0tka2NzdzhOT05tQmI1QWgrZVBOWUwrY3lXRmhqWlJ5NDNSNllhYS8r?=
 =?utf-8?B?TDRPVnVMOFZ5MU9zMFcyakZnbUROVjFHeEdyNGpWWkZqSXdMc3dlbVZCblo3?=
 =?utf-8?B?elpZbDdnRXB2VjYvVTBZaXRoL29Ec2pwNGVlVnkrK0NaQU4yYWk3cUxUYXJx?=
 =?utf-8?B?Qk9ib3Y3NHgyYUE2UHc5VG5KbStXV2Q1MFZSZElEZGhieExJSThuLzhndTRP?=
 =?utf-8?B?NG5oTVpONHY4Y05mdlhGbG00dE4wTWQ2a0J0bEpXNSt6Lzk0eTJ1MHJPTkxt?=
 =?utf-8?B?SFloeUxLbFFmQ1VvSnJ0MG12UURpUkVpVm03WXQrd1JpeFhhTFZRNlhqTkph?=
 =?utf-8?B?OHRBSFFRa2hFcUZqQk1YUEt0ck43N0JjS1Y1UXVFRHdsSHAvWE95MklQTUdj?=
 =?utf-8?B?RUsvZVpTVEI1SkQ0NkNOaURsTzVjYU1SemlhU2ljVFZVSjd6aTlIdVZqT3F4?=
 =?utf-8?B?bjVOWnlLTUxOTEZFcFN4TmhobzZVaUxaYjY1RVRXUS9rMElmUXRJYVhjQjNU?=
 =?utf-8?B?SmEzUkRZNndwTlRuQ0J4ZnRHZE1EVk1rUGRKa2VqRERWU0dMWVcyV29KRU4w?=
 =?utf-8?B?a3RXa0hFd2ZRdzllZjdsL2VlS0hUQjBaNUExUVpPYjVTcnkzcHRwRzRsYUti?=
 =?utf-8?B?aDNMUzh0dDJXSXB3dW05Yk5teVE3YXJDV0xNOXZsR0VlUXlkK0xVSmtYT3Av?=
 =?utf-8?B?UTBmVlNLNkZpU2VjRENYUWZWb2drSThJN0NUMFZTRElqVzM3VTJHZWdINlp3?=
 =?utf-8?B?L2gvSms0ZmVXNUVXNWN6ZHMxSU1NcFMvdXRUais1WGJ0RGlsMDhrS2ZLZVd3?=
 =?utf-8?B?ZDlwSU51NndYZ2xyVWQ1Y1lkajJWWTNyVnZTRHpKa3BGRzViTkYwbEhYc29Q?=
 =?utf-8?B?L2MxZ2poZmlJTFRDak5IczdNT2hwSERicHB4Ry9KdDhyL3Q1eG5MTTIwQ2JJ?=
 =?utf-8?B?ZHd0eXcxUDJkam0zeHVJc084eml1aDR2TUNVUlNtTDlPS256VjRtODA1dXFL?=
 =?utf-8?B?dW0xd0Fyc2JwV1JNMG8vQjl0cyt6K05ncjN6TGlsUUpyamxNbXVNT0tDQ1hQ?=
 =?utf-8?B?QzN6cHNuN2FFSUNHdC8zcElTdXhTNTJ6OElVT1FiTmFvVTVYYWw1TWUrMWR6?=
 =?utf-8?B?QTdlVUpkZXdmUHA3Y1hFWmNENUNEYVJGbjlrNnNDamRObGorUjB6YU9kUHlN?=
 =?utf-8?B?dXhoakpoektNdENYTXRQR1N6aFRRMHRDcS9OazVjMjMyZ2Q5UXEzVCtzaEtx?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wQCOkJUq3YjZmr5gfPsP/A6nuHUBfXInwegZ8kM6lSJD9aBqnZWa2vbqX3gA6OixEhk59mvh2+Oapr9M/R+BAQixVI5K8puxN56dbP0GYjy5AbQ6kybkrqzM2P5AxMKeRUPRu2MyQErdMCed/5FFAQcYBXKJx0nxEfsQiVMYyCYbVpB06gNMAYfBEAIvuKBJoFyhCBkV/NacZsbpGx9UWXB3wvwI4LVUDCe/Ufp/k1smd83dUxDx9TR3pL7DmY0HeNKG8fdm5XWElHiHRKylnO1vPkLqJmHOmXu790Hn8upMbwONL6YK/OLChs5YwLJZhKTKC0FbSkndmAaIvt8N5qx7zYvPdqPvBfsnORcjFZfRC+7pXqQNWNqvQLqeyKZmPKx1xef66TSsZ66nZmrhqld1qK1beVoNJYGBZxiSvvoyUwG5Rp/EhvC3DCa7PeE0eL3SiCm4VAvLtRNyIqolcTv6jtdy2+LufxxCWXLLh0NQFnTxo2mjLURocXg0D4kaUZElprml2wU4UdKGlTys1eG8yKw/7tuPqxfpluh6sp8r4T1DfgesSGQEuiLO6loyywoj9NlrJSXo+Y3cc2KDwugvFuhWINA2MrByGv9VG5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603017a2-4fe9-412d-2df4-08dd8240eb27
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:29:09.3316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rp7JN1EZ47Z3EwF7Zbh42HAVZdiEUWfjKr1zsNXpLUJaU8H7xInEaaDLm09Q1XTjqImTsYORbbn+t/QiMbNLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1NyBTYWx0ZWRfXwb+bUldfv1Qa 9OZfawuBt/Y8kzQi7ZiVt9OavmVYEuUK8ZkznZBtJ/NoUvV/3g4eo/Wwxstd3tVIIxAokDj6x6K aAwS7PxhuP290bRyPuLqJM+QCocpX8AHlpAePwrKUPo1kdalHko8YZColKNPK2xYNjC0rw/V0/1
 dwRVTlpAF3FEyzwrxbWq0r5yXGEtHYz062ch5uhJOclf7wNNfbZtwC8QijL8KjILypj4Gc0h6j0 buwwlCaozSETOWjvBioBb3Y9OnBTR2R2cY1u90NLY4WodTaQAUm549/4VG//fGsQ3ONKO8cz/F3 e+8vlkry4UbbMDhe9RwiN8F5hPmuCY3a5PgZEpy1aVhGnMeRjRlKsl5QiRkTLqQZNpzMBJLDXPE 8XwhYqjq
X-Proofpoint-GUID: fnYw20K5weWUUwoVEDBXNh7uiV_qe7zS
X-Proofpoint-ORIG-GUID: fnYw20K5weWUUwoVEDBXNh7uiV_qe7zS

On 23/04/2025 09:25, Christoph Hellwig wrote:
> On Tue, Apr 22, 2025 at 12:27:36PM +0000, John Garry wrote:
>> Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.
>>
>> The function works based on two operating modes:
>> - HW offload, i.e. REQ_ATOMIC-based
>> - CoW based with out-of-places write and atomic extent remapping
>>
>> The preferred method is HW offload as it will be faster. If HW offload is
>> not possible, then we fallback to the CoW-based method.
>>
>> HW offload would not be possible for the write length exceeding the HW
>> offload limit, the write spanning multiple extents, unaligned disk blocks,
>> etc.
>>
>> Apart from the write exceeding the HW offload limit, other conditions for
>> HW offload can only be detected in the iomap handling for the write. As
>> such, we use a fallback method to issue the write if we detect in the
>> ->iomap_begin() handler that HW offload is not possible. Special code
>> -ENOPROTOOPT is returned from ->iomap_begin() to inform that HW offload
>> not possible.
> 
> This text could use a little rewrite starting with the fact that the
> hardware offload now isn't required to start with and entirely
> optional and then flow from the there to state when we can use it
> instead of when we can't use it.

ok, sure

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!


