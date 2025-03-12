Return-Path: <linux-fsdevel+bounces-43810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A6A5DFA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74CD1895500
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752BD24EF69;
	Wed, 12 Mar 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="he86W0ji";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bD6P70A2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367FC18DB0B;
	Wed, 12 Mar 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791739; cv=fail; b=rGm2Ag9Kje2vLBeq77dUlF9s841cUelthcYOjF/a8V4JwNvLNGbpAiwGH6YIeVJpE2E+CMM0w8TvheJdIIFf/wu1JdSmEqlimMFG8joF8cXlHU3/+eQULF4ePDLuXf/BTn72sAxEM8kgWjiDcXwytq+KKm4DBgvv7K2ClWS5ju0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791739; c=relaxed/simple;
	bh=oL7ZUwYE8FcxQmJ/7+rZjA/3tf6Dil5zuWSz+EkkenY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ti6BRbLa7Ev6aQESIJjTMfCqFmpW62RiTeFPz+SK0wojHMNFB5So1KEWn+eaD4Xh99qhvutPmNhxNIng1Xjj0U9sPIVM/G6LniDKyAncylUSypPXwrBtO4QkF8NJV/vNnUmoS93VknRvRmrg156YCvvkm80zq0g5lZ9vWAzfBbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=he86W0ji; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bD6P70A2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CBsZD1022177;
	Wed, 12 Mar 2025 15:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=X3sD2VhdeXDzQ93IsbTuKLlg511CfUAJZ525uyIbc+g=; b=
	he86W0jikN3+tOBAROa/QVvM/9prHDh1Mqo/HOpuce+TK90+57KQalHKwEKbFbBj
	iKVeco0e6OZAAZOQNvwJ3iupkKewVb29+ewVSTLDbVFMWie7HIMqms4y+0kj7UcQ
	D5Ou3XJIaKIgIbEiRfSh2JJE1bsRofaYeZU99m2KXesdp1CZY9OTopZYfg7yVhoN
	kbk+i6YgUZPQrSWUmNgjvDb4HcDBCauG3lwlUCG38oJPCQjtlj0EOlhapADtlGFJ
	5bPY/RkTfOJzUlGNGAF4OmzYn+B4dxzPK2WeOwXkva4W2u/GZ+1ZsfFG/EUTMg9S
	o3lukRrCSvkzVTlakvkWrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h1ytc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:01:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CERGr4002149;
	Wed, 12 Mar 2025 15:01:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn7dash-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+ncgP0FIWyZOOeDMHYf4Ey5+RIN8U63dbvQw9cyEKl7B0is26girGMvFE3noLSSLP+P5I1EvsiKsFhTmoIEtqcqRlbWzthLAUInGP2IkoikXbZhFSQjc/Ix3vDosnPYo20R0IIStKYTj8oktsv9lKUmSNGLlu/FsBarz3eXWOVAbs02ii5aWJGr3/Bhi5UVd7ntDzsvWZT/IjaCjfFKbssYyNyG4Vo9h/51PjhdGfh01BXEzErIpxNqugVgxNv+ff6Tbg3+Wl6d8ZVreRbpLqqPzvSeQkqzqS/inyyEYio17/VxyoKg+WRIOBI7DjkNM40bz6H/9c/EFp4x8lriOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3sD2VhdeXDzQ93IsbTuKLlg511CfUAJZ525uyIbc+g=;
 b=rEWo3i4xk/XTNQirt4SIB01FmD1bH+s9dy1aVmbV7DxPythku33qQLPwH3mJw6gxAcGQDIPixlXJ3oMTqk4bdpgc5UF/dXCXkg3NVCGnYtkQs5WpthNXhFYR0RS9ksT7wfXW5/j0TWf/4K+HehcEYHLmWhafZ3C6oYjDik4V8GJVI1UCwoDXeknqQ8u9U+22JlP4uSPivbqeZvH/PJO7pZQCv2oGBBf+o+KmghHXRJ0ZsCJzL3NMWzxfHsicEl+0KCvJK70m6dxRiSX0xGeJgrBc+ToOa683/33BzQUyr3dF1NS/gYD2JQ4Of82XQ5EkD1yWh/WupZELLOZSAOONGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3sD2VhdeXDzQ93IsbTuKLlg511CfUAJZ525uyIbc+g=;
 b=bD6P70A2zsIDdi4ADUXJi0O2LSxCnSePP7qcIkhd5v5AngKPIJc8VwXHCmm0Z22qoFVQXaDbfhhxvscx7k/+BmYkiFROvxuMpig3f9uUYr9XjpjOmwWoplQNfcq1LYhw3X0netbBdrrU2DaAMXcbuvXCCloH+VeQwKM/FADcDj4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6550.namprd10.prod.outlook.com (2603:10b6:510:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:01:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:01:46 +0000
Message-ID: <f65f317d-cf00-4a96-9d85-6aa27a95ce17@oracle.com>
Date: Wed, 12 Mar 2025 15:01:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] xfs: Commit CoW-based atomic writes atomically
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        catherine.hoang@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-8-john.g.garry@oracle.com>
 <Z9E6LmV1PHOoEME7@infradead.org>
 <63587581-17a5-431e-9fe3-a1a24ea4fa21@oracle.com>
 <Z9GSKbuollfpAZeX@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9GSKbuollfpAZeX@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0237.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: dee4eba5-12b8-41e6-3dc6-08dd6176ceaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFBmeW1hajdScWNCU01qQi9rRmcxN0dZaWNlampONVV0Ymh3VmthdEc3Y3lh?=
 =?utf-8?B?Rzlyek1uZWhGcnpIRnJYSWZRWWYyaEVyTHpRbGlZUmwwcXg4Z2NMUUo2bHFM?=
 =?utf-8?B?ek8xdWdXc0tVK0I4VEVybUVGbXgrZTFFajhjczkxUys0dThWeTBLRWZFTERC?=
 =?utf-8?B?N2xLV3lRb3hja1RUMVk2b3Q4TFV6U0xTclFXeWloY3BiUDZCN2pkbDJDWFQ4?=
 =?utf-8?B?N1Z2ZHU0YzhwRVMxUUxNM2JNWVNOcWRFdTdCb2ZIMTRhak1mTmR4K3pzZWNr?=
 =?utf-8?B?K1g5dlR3WkRsTXlVR1VCbityanlHTG9MM2tHbzkwbERVNDAzNCtpV05OTzNS?=
 =?utf-8?B?TTdMamViUTBXaEJvVkh3ZWNMWlF0aTBFZURPZGg3YVNjbWsyMS9yQ3haY3M4?=
 =?utf-8?B?aFJramJ6SVRxUUFFb1kyUXhQNlEwaVM0cEloSG96dk5hT2YybkREYWhsdnBU?=
 =?utf-8?B?TlFvTTR6NHBCaFdRM08zNkR2ZStZSEZpVjZLdG41ZXh5Ym5pWXNENVp4Y0dx?=
 =?utf-8?B?aTRhczRHeWZ4UjZjY1ViTUhsZ0lSKzk2aHZSWU11RzNHakRVSUhpVHJRYXpi?=
 =?utf-8?B?OEZWeHEwWTBwUjMwdzVVQ21RaFhzdnZxbE51dFc0KzdsaFh4VWZhbnMvb0hW?=
 =?utf-8?B?KzMrVEdJV0VtWFo3cVErYUkvTXppUmlQU0k5WFRKQ1N1WHorL0dDSFNxcVhy?=
 =?utf-8?B?VnBJSU1kbVZHenpLOXJIeWhuMlY2QU1ZbnA4UzhLUVc5TVJCL3BhNXhBSzlo?=
 =?utf-8?B?em5DbXRXWm5LUU1ydEJ1NVIvYlc2U05mTm5wVlpUUUU5bFpjZUZYb3hUcE5C?=
 =?utf-8?B?MHFPZlJucXVDc2lZWUx0eTcrUlFTdGYzZDFIOUxCaFhId1ZiWnlhMUtPUUxk?=
 =?utf-8?B?UU9pYWV5a2JqcFRrUDUvdWtjMFNQTHFjenZEYWpmUXZTTXdZZ24wbE5YL2U4?=
 =?utf-8?B?dEZsRFhBNzNUbklSS1cxYVNKYmtDSGNxc281dU5mVTc5L29DbXFIcEpuM1d6?=
 =?utf-8?B?T1I4UHhoR2liTDlyVkFxNGRKaUpBU0w1MmJ2aUYwTHlDL0szdGU0N2RKSmQw?=
 =?utf-8?B?QXFqK251eTNOMEJ2VjB5WGtSU3RCSGJUa2d4YW5FcWZvcEtRbnR5TDMyZUtk?=
 =?utf-8?B?dFVISGJORXlpREFkOGJpUXJHcVMwZUJVSHVTZkhodms3TEQ5VGhkQzVBdkp5?=
 =?utf-8?B?NkE0Nm91UW81SkpMb2J1Q1UyME9veGp6MWRvMWt4U3NGUC81QzlXZEhrWStQ?=
 =?utf-8?B?ZUUyN1Z6b3pIMUc3UVJjT28xdnhGUkVYT3c1WEIrdWhmWURuRitHL3h2Sktv?=
 =?utf-8?B?Z3VGM3lubFRUTnVOZmlYdExXNzgvdnFOZE9xUmJZODZ4ZkMrNDVLMUJicnhq?=
 =?utf-8?B?eUp2b2FFVm13RElNRHdhZWJCclk4Y1dpUFY2bTBTajBPMnRRL1ZhalpIaVQ5?=
 =?utf-8?B?MW42UnA1TmhXazB4UmNXTWxiM3k3UXNwUHdPdUJZRU5Ba0kzNk5OQ3U5NGo3?=
 =?utf-8?B?QlhGWXMxZjhqYmg3M2dGRjF1cktIaG15YWU1NDB6RkdUTy91ZzYvR1p5MWhT?=
 =?utf-8?B?REg5S3BZZ2NPVk9uU0xnQ2dydUdrbmw1UVhKZ0VpOXI2dDc2NDF5TnFGQ3Iv?=
 =?utf-8?B?bUhBQ2F0VHN4eTBZYVorZVZGWTBiYzd0OHl3L1JDdmlSNVNZLzZQaGVidTVy?=
 =?utf-8?B?SzdHRWgxT1g0YzI1SmZuaHdFRkR6eGxhRGVuVXY0aHVUdi9CeVBKbkNiWjdG?=
 =?utf-8?B?TUVFRlJJRmNFUnZmU2FZS1k3V0tmKzNCSlV0WmZudGhBSHFxanhzU0JHb2Ji?=
 =?utf-8?B?QXJwRnlHWVVwVm04UUJaSWt1NlQyZEJEckxjM3c4Um8xM2hNNkozQ3lYb1BR?=
 =?utf-8?Q?U9Ce0ssUFLori?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDVROEdVNDVFRFVYK3AyY05uTG9tcjBJcGRVNEk5bVBxRzc2RVhvZEZ3TkJ2?=
 =?utf-8?B?c0J2Wjc3YnVSK2ZqK0RWWjZqMjNvTWRpaDIxNGw1cllpdnQxUUtNMU0yMGpW?=
 =?utf-8?B?bWJ2eC9sMTlYclA1S3MxY1VaaEFpci9HNU9Ybkg1elZUZ1ZSWXg4Q2Jhak4z?=
 =?utf-8?B?QjNvSWxaWlJ5bEdHZXpUQkNqekQzTzB6RHNRby8yc2JYSmJkQWxLdElvS3ln?=
 =?utf-8?B?eDVCRmFicjNibmRmQ3JtVituMVVuY2gwR0c3QjFNcjJRT294dmQ0OWtBV2pI?=
 =?utf-8?B?ekZESGRUbkl6Y1k5MHJwQkZWR3FDN1BSOG45Q0lSRmM2OWtoNEVrWkwvcVFF?=
 =?utf-8?B?eGFyRjBXcVNuQ0M1VDhzK1o3amlBbkJKeU9iMjBJbFJTVmFnRVdOeEtFTmI0?=
 =?utf-8?B?QlIyME1YNDUwYlBpWHR2ZFJrRkpkc2pCYkx4MjNoSHBwQ0ErSmh5bkJFZkRR?=
 =?utf-8?B?Y1BIN1l1SmhFTy8rcFhYUjdTUzh5eFgxYUhVMFVqcjh1eGF3RHVUL1Z4TS9m?=
 =?utf-8?B?RkR6eVVIb1hUSzN6dVQwZFAyeXRGRmx0OWl4RitsNDNOcjNxZ2JucEJtcW5q?=
 =?utf-8?B?cElJSHJ0OFlOamxVdGJsNVpZaTNLSzV2OU5TRE5iN0prSGRqWFFlV0tFdEpy?=
 =?utf-8?B?ZjVONitqSFZXS2kxWjdtRFB5OERnbG5QdnFsc2tjMStxQ2FCelFVTGlUK2dm?=
 =?utf-8?B?OTFSejBtY0hWUjRKVHBiSnBlVlBuTWJtekNyNjFvQkkrMkZyWS94OTVCcWNo?=
 =?utf-8?B?dmNVV0xhcnJoM1JEV1RmMndnczBCc2d4SE4zRlZxUHhDYWZLYjRPWTdUYW0r?=
 =?utf-8?B?ZFdYc1RWYUZRNGhyRVY3RmpXb3FPUnFLMXQ4RDNib281L2xraU1tYUI2djk1?=
 =?utf-8?B?bTVDSXpYazhtSzdYYkdOblFvc1lzY1czQVBaZlZnNDN5U1BNOUNFQzF1WS9S?=
 =?utf-8?B?VXpObEMvVnhsSGVCY3g4WmxzbHZxeWZDMWxacDNGSnFuZllqTStMbkdFUEk2?=
 =?utf-8?B?Nldwdk1hUkl0a0xubVduWFBST25JYXZrN1pSSzhsVlBBVk0vajIvTlNDNUVl?=
 =?utf-8?B?MUt6K1pVSno0alI5T2xSNkZDVVZhQWl3RWp1bWNIY3dJdHpVNGxDdTJKWWg3?=
 =?utf-8?B?YTVpLzdGT1JkWWxXZWwyRmRHSkJyRm9MN0RkNEp1aWFqVERxL0ZBOXU4UmlN?=
 =?utf-8?B?Rmt4MzliWHhzQzdsb2NsN3NvQzFDejJqMXNkMlBOVmhPYzlPV2ZWYkhrV2Nm?=
 =?utf-8?B?akZuT2swa2lLcEYyWTBQUWh0dDRIQmk2Tm1yK3gvNEJLNnc2aVZDamlUeTBo?=
 =?utf-8?B?a3BaN2tKbllWaUE1dHg2ZC9mUklVZldKV0trWnNja0c0elhucVNFREwyZ3ll?=
 =?utf-8?B?c2Q0cVNMTnBwK1psK3BlT3BoRmxqeFNGalA4Y1NPOTBKSG5wT2M3MEE4YjRY?=
 =?utf-8?B?WnlueUNGUnVyK0ZlVmxmQkVRMUZnYUNRbTlZODgwTjVsaDBHR0trdkhSVUlw?=
 =?utf-8?B?aENYSlNlWGVuaktjVTFNRTY5VVdyNEVaRFlqNXlmdHZDalQyZUJHN2l2eVpH?=
 =?utf-8?B?d284S2dKbjEreFV6bDdOZHhySFJHV2kwdHhXZ1Q3b0ZoVGRVd3RuQ09WVUh1?=
 =?utf-8?B?MFgzdElQMmVyZitXK0lhTDR2cDRzVk9jYWNWbDMyODFjZWl1MUY0WFhPNjNM?=
 =?utf-8?B?U09waDl1Ny9QSjBTaDZaakl3TWpMV2ZFNjhJLzZiVUgzMkRNblRZQ1FWRkNw?=
 =?utf-8?B?TTBXTFczZEFkajJya1BoVUg2TVJVSi9naithNFRHdkl0ZDdhUDhDNEltMzlK?=
 =?utf-8?B?azVrZ3p0LytHcnZjUldsMkdoNjFza2FMNUoxc0hFTUZFSkFwNHkvWE9YbnJs?=
 =?utf-8?B?L0puVUwrd3dVVXRNQVkrUjE2NWlTcjNPRU9Vc2ZDWE1qK1NTZjVFaUpwVVRF?=
 =?utf-8?B?QWNkemVHcERDeVVQTG15VU5SaFRXcTV0Ni9nc0lJRTVTZ2JiQ1daWWw2RmNR?=
 =?utf-8?B?VlBSajJGbFRjbVdweWZQV3RWSnIxYjRxR0k2VFptK0pCUVdFa3ZrdTlvbXp1?=
 =?utf-8?B?ckM5MnF4MVlaenRSeFBYeVU1ejVieE5vMDFNY3JEWVkyWlRTdXlpNjBJL3Jw?=
 =?utf-8?B?L0o2Rk4xa1c1aElDRC9ON2ZSRGYrblBSbTBQZmFkVWdsazFaZUI4UmNHZ0h4?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/4Mwf+135Q/Dz8NTPa7eoRefTze0TeDklEdl66r46Blx1b4Zk/ecqQPtodjglCdVGQLSCNOckqwo78BIdG5o/5zi7Yi58JqJJFrmetNn32BUSu+r6h0oC5SBFd+9SWJ/0kwLeYAVO2DI6HcluBnwGnIRzedsQzLtYTNcHSRVUlZLvP0MeCmSQmn9I/wT4hPmiCyZ6O22wQ0mAEROy7HKx9AtwaMNKWbvdktrvTlw2s1cIfATlTaCG27+JOdI94s8y2kvlQcudecZRVYMTh0fazatEhPDcV+tuOJsRiblkjMidg7+Q2A7bL2vCJZ5pEurSZQY2B9C1Afsqkv1CK5XAwHDjnWs0hibzRSXZo6Jh62f0utftUWH2EX+9LE9sVFxYU78ekul1RJ0h7+wMrqXqoxBF4xiBeM2Vv6yYJktNrDjiFp+KwMUaqs/BOPGWex+X7KWHXAVSsPMDDj7YwHCZWjjDzM0fAjTDgeCvnQSJlIkxFMKmVUhFqIdQmoWv4u+NnBkPP/moK5JKNRhzEDUDms+rfc26U3cj+qzg7p+LPO/IBft9NYfdbfVXS8mEUAzylDgebeeHhRQPPi39I5xbb1UgGa6sCZ2C8xP/ps2wlM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee4eba5-12b8-41e6-3dc6-08dd6176ceaa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:01:46.0551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwiQI5/8rnA/SnHq1ZUApS0W20UEEDW8C/NsKPx5I9klIJV+/A/Mu5OpEtSbqu9zOIZiBeba8iHc+WFKLU1jKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120102
X-Proofpoint-ORIG-GUID: 6ekuXXYinAdGjfwyUlsf7600NszPn3SW
X-Proofpoint-GUID: 6ekuXXYinAdGjfwyUlsf7600NszPn3SW

On 12/03/2025 13:54, Christoph Hellwig wrote:

+

> On Wed, Mar 12, 2025 at 09:04:07AM +0000, John Garry wrote:
>>> As already mentioned in a previous reply:  "all" might be to much.
>>> The code can only support a (relatively low) number of extents
>>> in a single transaction safely.
>>
>> Then we would need to limit the awu max to whatever can be guaranteed
>> (to fit).
> 
> Yes.  And please add a testcase that creates a badly fragmented file
> and verifies that we can handle the worst case for this limit.

ok, we can do that.

I have my own stress test for atomic writes on fragmented FSes, but I 
have not encountered a such a problem. But we need to formalize 
something though.


> 
> (although being able to reproduce the worst case btree splits might
> be hard, but at least the worst case fragmentation should be doable)
> 
>>> Assuming we could actually to the multi extent per transaction
>>> commit safely, what would be the reason to not always do it?
>>>
>>
>> Yes, I suppose that it could always be used. I would suggest that as a later
>> improvement, if you agree.
> 
> I remember running into some problems with my earlier version, but I'd
> have to dig into it.  Maybe it will resurface with the above testing,
> or it was due to my optimizations for the extent lookups.
> 

ok.

Thanks,
John


