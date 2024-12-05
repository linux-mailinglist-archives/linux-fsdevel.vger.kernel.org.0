Return-Path: <linux-fsdevel+bounces-36528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A79E549A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 12:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2C3285C6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8CF2144AE;
	Thu,  5 Dec 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SovUJ+K0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GTpghCCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75621325B;
	Thu,  5 Dec 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399503; cv=fail; b=ZlInYIhIbNSJhj0/lrt32+HKPYcU6zTJ1aarVOHJ/rW560WM0i0ywMWYMI51I4+OicyV2RW7d/CCQ6JGxnFuUTUbaHSZrLqDwMempXBvhZX7yikFzZF4HPU/IeuHJwPGJRQBBwrg/qeqturuLQZ6PhOqJ6sQKpoNaGicCYaQfIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399503; c=relaxed/simple;
	bh=uhdjE7tyxoALekbXUaXwM8LaBxIbBaxacAwqx/5JI2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vw1UXW2Tki1vIgNffOqHprzf4jvxRTE1Lf+C7/m+f1374McqPuI9nhdbcWzTwxp/zpVzlmqKNSTBZ4lxXsMEkCvks1fJfDfahD50nZ2xe/uZSbN5YfKED69VH6F7ly/upvdcz1vQFPxx5GBGlNqzzKQ1mmIZ3HyjjSVrMbBreF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SovUJ+K0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GTpghCCY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57MlwC000791;
	Thu, 5 Dec 2024 11:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oJtUTlxjSVzZdv/cT8xk8f1dBDuy5Aw8HlMYIhs+cxg=; b=
	SovUJ+K0pyICFAz4rCqUprjRX6DJe+bYgxfdhLqGpIERfQKnArao/gytpqYCvSPw
	XZAsmgdSfsOlR5jiz5kn3fHNUy7xUSxKMneyxkUAOV347Cm2ATkWnO3ySeYVdMTY
	jkRKZihprBv5ySigIWW44kc8Yap8THaUFJLDBe6nhC88d2omT+BW3dR8X3932l+N
	7FvjdlrLI78XLSxB98Iw1dhvwFbw6xgfyaYdEKTOzdzBZ1wg+YT4qm4vrKkl4aGF
	V/fCszWp9jSKA/O3ft34ADVGkO1JGz+JuExnCvsFYtv1nyG5uTHPxV+2YXO47WIu
	CKSsecjATWCHTnR4Ej+GJA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tasank5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 11:51:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5B6Di8011672;
	Thu, 5 Dec 2024 11:51:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5arj26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 11:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEo2TinZsD7WuizjlIH00TcslLUYiIgd97u0UOEp7eTmfk3BHqImURJ6r8/Axy0hN3fClU/VSFDYZeFEfCwwdPqEKgd95IYaeR1yjz4ywuv6qcNKxxV9heHHZEWBArhml9KjJsLEP1xYocuM6G2X0TCJRz3t5OSpXJYScChtJSaVFQYtNEeliU6ZPf7qU8CwlEdDSoxl/dCNbH/uwVMo7r37rZZRZIjcjjVr+yI92bev0K2hterDMU0CxpRuzY25LFiyRPiDVTELLSaM19bgn8iIIl+JfHyVYBPUVHPpVAInWM0VLznEiq08CNRdvMZN9XtgzbcEDgqwX1sewJ9/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJtUTlxjSVzZdv/cT8xk8f1dBDuy5Aw8HlMYIhs+cxg=;
 b=PKn+j7m4rkdlmvTjKSLINHpQHTIcqcz8XdDgT7VLF5Ui7KqcEMbbczsLw5/m5svBULUMX8CqRBNH/KJmLSy7c1crfEq1qJgJuI1yM7/J+ehC0MIhol4JtaShyj6AeuvQcqAttdwcuvayiv5yCWQmN3qYcQAA5NLEDspmTf3RFCkcG+c5j59m5+2GMruogUZfNgBBY0pLDh01yFXUCpsiqCM6qWfPuegfDHdv9Lt9gYaoksm0tU16l4tG7yjYAD+6RvZj1H2UBEmyeYVsdaB3Bvv9AV3vvLltOjiAD3XJGRjia5eRbPSsItmxXT4eCeJdwASC4uRWCGDR5FCDSvHdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJtUTlxjSVzZdv/cT8xk8f1dBDuy5Aw8HlMYIhs+cxg=;
 b=GTpghCCYdfwc9jCKsNZjliRvlesk6Q5Fw/s8nWhtAT9Kvy658hZKL1mZsehDp64EznC1lA0mrk2e9xcSaLvg5ePH6tNj0BmPWvgUfDXs8NkKJTUs3uCoH11DiA5RqMiq7zJVuMOT0m5J4n85L5un9bJtLMuV577WE29sQMwCt9c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Thu, 5 Dec
 2024 11:51:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 11:51:27 +0000
Message-ID: <d574743c-f0b7-4030-84c3-da334b02466a@oracle.com>
Date: Thu, 5 Dec 2024 11:51:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
To: "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <20241205063029.GB7820@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241205063029.GB7820@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0201.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d2298c-2116-41ce-f9bd-08dd152326af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0MzeWhpeG1OQ24yRUZ2czhNZzNnbHBtbVljYys1OFB1dXk4T1RpZmd2Y1R5?=
 =?utf-8?B?RmQyWmpCMmJHQm1vNW53Sys3ZHl3WE82eG5TS1NOeDNhVy9SL2loWTZmT0xo?=
 =?utf-8?B?T3Q2N0JjZ21hSGEzeWt6UnRMaFQ3TEJvMFRKQ2dqbnpqNm9qSFdJZ3VtejV4?=
 =?utf-8?B?YUc1ZDBVYWhjaTd0Sms4eFE3dk5sOWZTVU0xZGx1YlI3UXZwc002R3VkalhZ?=
 =?utf-8?B?Z2FlK1Y3NkxURGphb3JJTjd5eTBib014d1V2THVzRnpVQWpYbVdXbDltUnNQ?=
 =?utf-8?B?RkYvNmcxQXo2eElCM2NteFRkaWNNSTUxRDRrMjZ5bU9XUDAveXRpTUVyY3Rn?=
 =?utf-8?B?M2x2T3pvTFhocVZQRWg5bDFINGoxdUNlbjlrWDZGYzhmY0d1OHhYWVF1OHdv?=
 =?utf-8?B?b29pTEVXNitjUXowY0hFdlZ4RFg0a3VVSmF5NFlzYXJ0TE5nU294L0J3K3ZD?=
 =?utf-8?B?dzJ5ZXlOQ25XZk9aNmMwb0laTUFUK3N4T1poMUh3Z3RQMHRuOVpyaHpwZWN0?=
 =?utf-8?B?bkhmUHpzcG1aRms0aWdBc2I3UTh1TVkvYWJrTUtQVFY2allCK1F3S0RmRVVQ?=
 =?utf-8?B?Zk5vdkpIWGxUMnMzbmpRNWJQRWRNcWhwR1dONjJIUlV3QmRENktHL0dSOTdQ?=
 =?utf-8?B?UUFlSkUwSTRaNFZQRXVRalZzQVZHQ2RYMUdrVGJPZWZYbDFGZThDemRrQ29L?=
 =?utf-8?B?bGJJWEU5TWhlQ2dmT2xPNFd0dzFjNUwrRFgyOUoyZHo0TnZPNVVTaUlHWWtW?=
 =?utf-8?B?anlxTk1rNmtpY2JFSnpYbEg1Y3FXNFkraFpwcWM5aXVCbWxtaVN3ckJIMG0w?=
 =?utf-8?B?UlhoZ1Bjdjl3emtraGw0WnN2aVREditWVG0zdlQyekswSDBOVjhRakVWRFhj?=
 =?utf-8?B?L2R6ZFNDQ0hCVTZSSXJyZURNK3ZWUElkQWFZdkJhWXdsNmF4SHZBQWtZdVN0?=
 =?utf-8?B?K3JhdlNDZ3J6Nkk2Z1lxYU1qdmtUQXdUblMxSXpMY2hQTmZNeDlnZ1hpVEJq?=
 =?utf-8?B?MHl6WVdZZnd4eWdUQWUra05XSWtkV2Zpai9qR3VjL1JwR3oyRDFKcm1TTk1O?=
 =?utf-8?B?VEZsMndGdFVubWMrSmJ6STNSNzZrUHNCZzlqU1RwS2ZraFZNcG5RRGYvMHRu?=
 =?utf-8?B?K0dvejZxdW5tdXpiTkNEOUJ3OGIySE1nRm4yL1RFNmE1RDdmV1EvM2NTZkFK?=
 =?utf-8?B?VWZXZjhJTWJLU0pMRmZKVmZxOTF5VFVPeThYNysydXplMHlUOEZiMzMvRVM5?=
 =?utf-8?B?bFM5L2xBOEJmWGhmZEhhMUUrSFR6bVN2T29xZGxrK3ZGSUQ5V0F2cXQ2dW1R?=
 =?utf-8?B?Um9HQ0VPdE5WcFdjVWZpdndHM2dtWXJQeXB3QmU0Z3lTUStxL0s2SmpESUt0?=
 =?utf-8?B?OXNKNG8rMGtzYjlNVlc5bGJqaU5WeW5aSEJtNEJyMjBsT1hUMVFqaWNUbHM1?=
 =?utf-8?B?Z2pYdXYwd2hiRkRlSjBGTEZYeGliK1V2L3FnODR6cnJPaVZITmpZTjltSk5O?=
 =?utf-8?B?bWNnRlExcVdjTkpDSW5kbXlSVWFmdG04WndvRFFmWC9OUWhackx6eWFiTnYz?=
 =?utf-8?B?QlVMQ1FIOEsvLzV3UjY4VkJoekk5cEl5YmdGVzhheTBmZXh2bjhPZkk5T0gw?=
 =?utf-8?B?ZHJuVVhvNHhBdGpydFI2aE5hRlZOUExDOVY2dC8wNVRFL1RMTEUzc05IOEJt?=
 =?utf-8?B?VHpDbFlXMEFmZTYydmdTZXpaV0UvczBOaTF0UU9kSENqWGU1RllxVkFINXlp?=
 =?utf-8?B?Qi92QnJKd1FGbWJWazBsNVlsbTdKYzRZcVNpTW9MU1R6aHN2WkZKRGs1WGxr?=
 =?utf-8?B?elIzMlFFRTJvOTByZXVrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UktLSjZWdGV2SExyOVQrQzdlM0ZhY1lzV2JSRmpRdktIM2xFVFNlb1FKVmIv?=
 =?utf-8?B?WnJiNkJZYVBwOFR3QXErdTk2TlJEc3M1RjRQUEg2M1FjYnNuOEdnZldUR3ZI?=
 =?utf-8?B?TTBpZE13SEFRaS9jeEdjcngydks5ZHFOMjMzbWFNWFg1VS9ZQmJlSzhleWxL?=
 =?utf-8?B?aGcvczdDaUtVT0w0ejFVSFlYWGd4SnJWdnMwVWlWL0diQjdhemU5clFEcDkz?=
 =?utf-8?B?a1BNRlpSdDI3eVlhQlFGUUw5b05uKy9KN0o2WjFxMHZFZlB0Qm9SSHpraE9C?=
 =?utf-8?B?NFplenZTOWpBOWk0RUFrcnhwTnhYWXZFLy80OVNEcGIzSmh4VUtaUU1XRVVM?=
 =?utf-8?B?UHNvb3k4UmhLOHBlR0xEcld6WGZ5WkQyTGx4Z05wOGNvQ0lYL2dhV1NUZTVJ?=
 =?utf-8?B?RHdWc1B1d0FBVlU2VVB2dEpBY2pDUkN4bXpDT2k4b21MWXhDSVo0TkQ0YVJx?=
 =?utf-8?B?MzNsNU00d1ZhWFZvSEwyWDlmR1NuSEYyeFk2ZTFiVDl3Y1B2MCt3RDNUNDEx?=
 =?utf-8?B?Q0lVMFprQlZZblQyYkVRTnJnVnZWcXBGVnpsVTAwaVFaUlJBMGR2SWVNTGRu?=
 =?utf-8?B?OEVjdGhvSmdQOElNMkZvWEg4ZnFQSytHR1Z3SjRWd3o0VUx3b3p4ckN3YzBE?=
 =?utf-8?B?M3pqNURZZnZOTmhISGN3OHp3YzduR09paGNYeDB6bldpUDlzZzFVWjhvS1Vt?=
 =?utf-8?B?bmNyUi9vM0o5dFFsb0k0eG9UN0VFdzVoZURLcHBBUEowSXJnOHBHeWg5OU8r?=
 =?utf-8?B?MEpFS3FuSVlSTVFWai9HZGp3MFRkdVozQjBsdmhtUGpLMWwwSG9kcC9QeTJx?=
 =?utf-8?B?VXJLTEkwU2pwY0RqR0podTZSWGQ1L0gxWWU0RnVXc01hc09HMU1vQjlld08v?=
 =?utf-8?B?R2FvNEVYMHdWbldyWXplWnJrRmd0RGdQTFhFTkw5WTZBc1B2OXNTRkk2alBs?=
 =?utf-8?B?S3p0RjZ4Z3RLK1MvblN6TWcyV09CS0Rub3Nhc3ZxQjAvSHBydGZORll2RWJS?=
 =?utf-8?B?WWVUVGI3MnN4N1FsSkc2VmtQOUltYVdwRE5PM3htL2JibGMrdTZtNGZJYXBy?=
 =?utf-8?B?K3VxNHFJODNXa0JleHBOSnEzTUtJZlZiVU9CMFBLMWIzWU11SEgybXZsamZT?=
 =?utf-8?B?NFhqbzRZWlhCRW9wbXBXbHpXZ1RMeE01UUFZRCtGSlNrVkVLZkFYU0NaZ1RC?=
 =?utf-8?B?U0N5WmpDelFyNkZtazQzZjRIOFVCcHBoeWFLSzEvdnRGaVZSWndFM0ZNMU95?=
 =?utf-8?B?d0lITHI5WDd5bFFqWHN3M29JWmlZemFyYWlpWUhiR2VJSC9Kc1RrUlE2bWlq?=
 =?utf-8?B?aDdkcHpEdFM5NVZIWHYyMnAxZ2QrZkl1TXoxdm5tNDFFV3hMZm1PcUg4NDNi?=
 =?utf-8?B?cFNqNUsrUHlKQmpyT00va1g2UGpNZTdlTnRNV3hsaTFCT1ZzRzIwbnNEeGtj?=
 =?utf-8?B?QjAxY1pjWFJ5Q003Zkx6N2REU3ZVZWpNWHNIZGtPbzhPa1Z3b0l6LzN3UDM4?=
 =?utf-8?B?Z0d6eUlWSUVtSzBNSytZSWZMS2duSlB0ak91a0x3VmVLYWRpMVF4cGFHcTVo?=
 =?utf-8?B?MFVQL00rRXdia1FNTmxXcVprZXlidGpkMjNMek5ES3EyY2hnUDVJOWRqSDFw?=
 =?utf-8?B?TjdwTG1zWE9lTDVuSXdnSVhNVzY1QVhuN05HQUdpd2g3b2hiNE9mUWlLZVdn?=
 =?utf-8?B?TVBpSXdHV3RvL0ZWMStvVTdESFN1RTlEMG9zU3JEWFZ6UHM4cU5GSlhEbVdo?=
 =?utf-8?B?cFFKVkFVREc1ZkdJZlZ6R2EwaFRRYmdhSVJKckVndFZETy9MRmJJTDc5M0pE?=
 =?utf-8?B?eTJoZHJ3QkEySE5yRTF6WnAvYnNNM0x6aWVORDVla0d6VE9HT2RhNDFVTThy?=
 =?utf-8?B?NXdiTTF6bytKM3VjNXVwblRjWWlGa21uZjl4ZDNXM0FPOExkcnZMbTBKeDRu?=
 =?utf-8?B?L0hPTWhjOExiczdoMFA1SzV0enI3RFhxRnowemU4QXpqTkZlZXF4V0lMSm0v?=
 =?utf-8?B?SnNqSDNoNkQvclI1K014RVliM0xMdmhzMmE0L1ExWk1XaXA5bm5OUE9FZkY3?=
 =?utf-8?B?SGllcDFQQXJRWGNmcktpNEkzNDZrWXpyWjVNUzgwS3V0ZFZacjhoVkxjL3NP?=
 =?utf-8?B?WXN0VHVFcmhpUW02clJ5RnQwYzZYd1B0cFZuZVJlSVY5OWg0amExeTJ1bnpO?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2SzxQxwE8tfdAfXLl9G5Jy53VN1cw8u+BFabXUx4bnW4ukvxUhL6mzfXVT/13oP2hnb9SGk9W/KrqasmaXjxl2woT8QHR/0lAZNngF9NqOr65YxsNlBV1883RHq0fk5JCdT8v6KMFF19zTWQ9pWl+pebiyAEidM9ll4VveVmPgzZirHFBc7R3elmzTXImz+omCcF4ML9SBpXd3M9ZuTajv9oTwCAzL5IdfbnrP7sd5XgafZusv6RjBHl8/EE9JqZss9zPZxZIyzj7alMO5b7opxVbxbALQdMV2UMPB3PYpIW1I2fLi7tAT7PLR2aBLw69ekvTZMmnKz8+am3TugJ8/uKRsvaPmh4kiAgucyie55xV+tuxVGUo/Yq0PS92LQedzANqB9ziK+I19q7D2kqCtqvDQv8xfvqK9AywISbY9DEizEdbvxgLh84EBERvEuhxTd8uq/4HUo2tyMUjx+pS1OgYTfcksnOQee970LJVadwcbQm2Q4oKrWexUf4l2cPEYF3jwEfh+OOOrd0ZV7OoqEomY0WkqU2BlXRsB81WocxmHb4J+i4oV1XeyflY/GoXSdi0tYoVIS+x6Bz45QbsuRoBIcuTaWVvTKF/tHbKR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d2298c-2116-41ce-f9bd-08dd152326af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 11:51:27.6121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ep9wGxlbyL4r1FghUmje5UkOwodb9ZwsxYUSB3eIfpiSmxtjBswHyuVMBB4KQ4OVQuGD7KlePuE5eIMT37W5hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_10,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=905
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050085
X-Proofpoint-GUID: uL-1l0w5eT4D3_eynCwxLvuScEzseemw
X-Proofpoint-ORIG-GUID: uL-1l0w5eT4D3_eynCwxLvuScEzseemw

On 05/12/2024 06:30, Darrick J. Wong wrote:
> On Thu, Dec 05, 2024 at 07:35:45AM +1100, Dave Chinner wrote:
>> On Wed, Dec 04, 2024 at 03:43:41PM +0000, John Garry wrote:
>>> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
>>>
>>> Filesystems like ext4 can submit writes in multiples of blocksizes.
>>> But we still can't allow the writes to be split into multiple BIOs. Hence
>>> let's check if the iomap_length() is same as iter->len or not.
>>>
>>> It is the responsibility of userspace to ensure that a write does not span
>>> mixed unwritten and mapped extents (which would lead to multiple BIOs).
>>
>> How is "userspace" supposed to do this?
>>
>> No existing utility in userspace is aware of atomic write limits or
>> rtextsize configs, so how does "userspace" ensure everything is
>> laid out in a manner compatible with atomic writes?
>>
>> e.g. restoring a backup (or other disaster recovery procedures) is
>> going to have to lay the files out correctly for atomic writes.
>> backup tools often sparsify the data set and so what gets restored
>> will not have the same layout as the original data set...
>>
>> Where's the documentation that outlines all the restrictions on
>> userspace behaviour to prevent this sort of problem being triggered?
>> Common operations such as truncate, hole punch, buffered writes,
>> reflinks, etc will trip over this, so application developers, users
>> and admins really need to know what they should be doing to avoid
>> stepping on this landmine...
> 
> I'm kinda assuming that this requires forcealign to get the extent
> alignments correct, and writing zeroes non-atomically if the extent
> state gets mixed up before retrying the untorn write.  John?

Sure, the code to do the automatic pre-zeroing and retry the atomic 
write is not super complicated.

It's just a matter or whether we add it or not.

Thanks,
John


