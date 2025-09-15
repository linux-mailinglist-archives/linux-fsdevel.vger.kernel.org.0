Return-Path: <linux-fsdevel+bounces-61308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE794B576D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1ED43A6A4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A812FD7CF;
	Mon, 15 Sep 2025 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fNwD/ctQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JbI/8K4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC271B4231;
	Mon, 15 Sep 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933050; cv=fail; b=fYXdjmwGV+Oj2bmgyxyGAlK4GAkG98I4rwGk2f/JEnWHeieu9+TkOrBpzH1iKWqnyGUEW63SDM6v3Jzn+Mu/WYwna65C8KeTCN23XGquh6MK9wHvLNlTIiJzrCMlu32yWoR5tCPjKWDYGXggY7VXdmsywPQanaIW21onUkYhMq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933050; c=relaxed/simple;
	bh=J73XwvZh7OR0Dq/HGSPs3BV51/ZnHoq9lo13+6zIJsY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K1v3hS8NhVPSKRjJeNLXZWzvdcp1mHXdAHWRnLfV3HVqSSi4z+Kh0hcHXVcdsgybXAD/LISAR47Wv48CcP7uIn5QxUYNvLM6n6hBfMUlVs+13470BrR/VaWoni5gJVQrtanQQ6RxAgq3wz9N/eE6P1VHh6+Cvm3L8kKP9MpzNmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fNwD/ctQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JbI/8K4O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6fswG026635;
	Mon, 15 Sep 2025 10:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=v3BmKnSn1Z3tGyEpUB4+vVPp85Evwwyv++2NpLCzuv8=; b=
	fNwD/ctQNnhZ3HXZZekr4P92DNa6Ek12KO+rfS0Q+jpyl4KaucuprKuOj+lJ9vC1
	LR02UxzLBWsuqQsKuvIho5ykamgHQXCll1ey0zF3HJWwI8q610Z4Zovgo8+NfBBb
	0YHkw2eEogB/rc2KlNts6LNiK/rpcl6Z3rYuVXvp7WviEhP03SPHplKx0lb7uveW
	JARUw+5iBW3qYQgH9hUg+/8CdQ/aiA8nQbVpARlyiLwMIq3Elks5Pr/hYuhl63My
	2tgyOx+K75UavM4xwG4WYTkhJFb8znKucV1B4ID9FwmIl/m/XRBSvajhLyq9qfOj
	63LmfBKSjzYvnFNPKlL6iQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49515v22bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:43:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8HrJx019126;
	Mon, 15 Sep 2025 10:43:33 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b3enj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:43:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLeYsfqUuxX+lAuPpRtr+oAN6+RaKoOt3Efkq7he0JGM4woNIzd3vhr/rAYnFQ96wUGmR+LyaU9NLsDmgt9fJRm8uLos2kSemXJrVmvtPreNVIxbxPWrT2eZs5Y8Qgv7VCyUkL3ZPOfeBpSgK3HVauXiTJyAYxdeSaWYx5WWhHEis1wCWgmqRipWGloQP/AzHegcuWrZB3MODjpZ3TuW3czDY4ApZQgJvPShOppGkgNIzGWMCdmlYegzmKd/uriZIIrAg7ZjO/CWJr9eHxv6V+6QQNRb7kVwIIiK+tiKJ+fM+uNirZUNceynedSQlcxNJEUTYlXKTKQUgQlkFMO3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3BmKnSn1Z3tGyEpUB4+vVPp85Evwwyv++2NpLCzuv8=;
 b=wI3VC2lkz+z0yh8kC2u9KrYaWk3Iln3/xtFNwABdPESfOro8lr4tBm4p2hXilVcPSkCWpVH/iGN/z/nPzXOj48HoXaDM4azfwGWYaZ+ewzw3CZjceDZkfHvWMrNbHcS7D4PVrBAQRK8sqNcGBDdmcPQfrjvldhiP9xH8gckiRGr5ZTZTGKzwRnvHnoby89RX0lxo8jMug8hrwUS4mmQ0MUxJ5VTwD9DM6Pcg+AiOTEMmhSwIK7sm11qNxdATm8gujhDfEac8rf6TYzDUgxvvvfNis83biTpDSZHFLDKVoYdu1EHHaKEweV3glgHb15UnKgVo3aTAveAFN5/nVpu29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3BmKnSn1Z3tGyEpUB4+vVPp85Evwwyv++2NpLCzuv8=;
 b=JbI/8K4OezFedyLmCwg5r2UVasQvqlQJr9OpXmjQFMYX2Imw8WyraAxNpEy8Mq/6nGZMuqR5xAzB80S3mWDqYTrVs2kkTwVTzJHtmLDGnvKrA9CofBwTr6fwBSR/Fn7u6NLpv/88zX3MgXKKF+V+L+R6CXGoIL6UF8f0INKUZgY=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:43:09 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 10:43:09 +0000
Message-ID: <370ca2e5-a4b2-4b5d-9fd1-a931dc2d1a6b@oracle.com>
Date: Mon, 15 Sep 2025 11:43:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix the initialization of
 max_hw_wzeroes_unmap_sectors for stacking drivers
To: Zhang Yi <yi.zhang@huaweicloud.com>, axboe@kernel.dk,
        linux-raid@vger.kernel.org
Cc: linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmenzel@molgen.mpg.de, hch@lst.de, martin.petersen@oracle.com,
        yi.zhang@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
 <c7dd117e-6e3e-4b2d-a890-20f5c4bade2f@huaweicloud.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c7dd117e-6e3e-4b2d-a890-20f5c4bade2f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY5PR10MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bda9fff-1cbe-43e3-65e8-08ddf444a94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3NyeDY0MGVmdGJmaGZzWHcwS3FydkM4ZG1WVVljNkxiUXBlV05FUkVoU21h?=
 =?utf-8?B?WTlyclRxL1l1VGNEZFNGdHl3cHViY2o4alRRUjY1UXdYQzdMUUE0VWkrenJH?=
 =?utf-8?B?S25wa205N2N2elI1UTZNLzJ0dTV4TXdxcUxaSFVYZnJjOFd4T3J6NXFjZlBX?=
 =?utf-8?B?YnZOeEU1Qmg5SGVwcDBOUHI0ZFBBUHZCQkM3U1J2V3c5Q0tkZndmVHc2cXg4?=
 =?utf-8?B?cm13TUV0SFk0cndWNVZUUXZZN1RQYnR5SmErOGg5RUd1Z0hPNWExYnlhOGcr?=
 =?utf-8?B?RWlhd1MvZ3VIRlF3dWh6QldkTXgrR0VrQkY4eURNTzN0T21HOUdkQXUyeENS?=
 =?utf-8?B?WmNyTkhuUUpqdlNnM1VkNzZyamdOYlVmaTd3Slc5L0RFcWdPNHJPa1dxVzNi?=
 =?utf-8?B?TVllY1dRZzJCMzdESEd3M3QrK3dBZCtSajRUa2dMMTBZQVNvNzRuZzZKSnE1?=
 =?utf-8?B?ODBDMW95SFFxOXVvaWozQ1B2dnBuY1Q5QjU1K21jczZ6aUsxUllPazA1dGRi?=
 =?utf-8?B?ckxBbDNwdkpZcXc3eG54M2N1UkVPQXhaSVR1MjFWNGNIanZXN21nenhjRzQx?=
 =?utf-8?B?ZTU3b3BaWGcwVlBMeW55MXo2RmVkUUJkVjNuMWlhRnRhN3F2UzBzYmp6OFZI?=
 =?utf-8?B?YkxSWSs4ZGdselVjSFI3RXhGOVo1VC9hbTdaU3VTSGRnbmd6M1NKMVNtMDAy?=
 =?utf-8?B?UWtoRm11Si9rYVp4UWZwK2xCTlcwaUxnZnMxL3FtSnUvY2tBOERqLzYvb3Bk?=
 =?utf-8?B?NnFMVXd4aEVmUTdFd2JNM2pCK1lVN2FNT25QQUVNWm0rWXVuYjBNU3FSY3Vt?=
 =?utf-8?B?cE9GbEJ3a2hGK2tnWmVkVEJlRGRnT0JQRE5XczlBZ093T2FiMW5BVkFDOG8v?=
 =?utf-8?B?OUZob05kTnV6NkpsUGIrWFptemRrQzBLZWZnLzBUZUlIS1dEbFNKL3pvSHFs?=
 =?utf-8?B?T1dzSUM2SG4xemI0K0p4SHVCRmh0STRyTWcwRGxFMGgyYmtQc0IrSlJRLzJl?=
 =?utf-8?B?QnlnOGZCYXllVVpMUnF6QVVLTnJDUjBPaktUenN2TFhHYllQbWx4WllSd2NT?=
 =?utf-8?B?eTNYcUY5T3YrdVN6dWk5dWlaMjhzSmVSTyt1bE15by9LSU9EQ2Vzakt3UUFB?=
 =?utf-8?B?TUduKzZ2b1JpVWpydDZQaGZiSXNCRVArSDkrQUJLLzgwUkdhamRCNEhLWUNG?=
 =?utf-8?B?MEM3bCtRTkRwUDM5UWwxd21NS1NXNE5vMUNGRVJOalJpZGdmdWdCVUhuUTl5?=
 =?utf-8?B?TmV2bk5TUVR0d2RPMEdiZWU2OWhwL1VESi9vcHNjY2w3WXVwWUp5S0xLVEpH?=
 =?utf-8?B?M0dWeVNsVys4bFIwcTNEbzl1MVNHQlFEbkNrR0h2Z2hrZ0I2MEtRbkhmWUFP?=
 =?utf-8?B?T2NDQ1BMeFBCdk5abmxpemtLZjFLRkptY3Z0RktxQkw4aVZwZmlUY2J1bE9a?=
 =?utf-8?B?R1JReW91c2FMT09kNnJEMjd0MWlCalBmSks2S3FzZW45ZTVja3VndGdHWjBk?=
 =?utf-8?B?Y25VdXNreGVXUlNiR0dIZXUzNEliVFRLUVNONWowQmk1aFI3dUk2TmVHUFRO?=
 =?utf-8?B?azZPMGZEVldkaTRsTnlKQUtCZ2ZiMTVBSWNmN2JtSzlFNFBXY3VqaGNXeXNj?=
 =?utf-8?B?RW01WCsyMFl5b0I2Ry9LY0VEbFZiTnZiTXozSy9CZWg4UkR4dk5US1p3cmJZ?=
 =?utf-8?B?elpnTFNEb1NSclQ5cXI4NUJvTEI5eFpDQXpnaDJxaHBaNWpGd1FtVzFVdmZs?=
 =?utf-8?B?TEFHTTJvVGdrQUhWTDRTNzlCbG80OHRCaGJ6UGtnTENCNmhLb0RMangrWnow?=
 =?utf-8?B?UzRJdEswT0N1emduMW92K0pUZlh1MHJ6aFcreENPTzl3YXNRQU5tejh6cERj?=
 =?utf-8?B?UkIzaFFUelR5ek1UOUl5NHZqRko2WkRPdU9ZMWVtWllxN2lOMDlSamQ0aml0?=
 =?utf-8?Q?yWKzQbhcBXI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YllmU2NYNEdsVjNrQmJzTzZubXR2amVaOUdEVGU1a2J5VWE2M1Zza3pVeHQr?=
 =?utf-8?B?bDB0ZS9KYVFvL3drWE9EV0s4MXd2TDhCdUYxQVpEWFRGU0hQcHJqb1N1ZFVw?=
 =?utf-8?B?MHdzWisvQlU5bTcrRHRkRzI0NzFxdlpnU2R6ZDJvb0hmdVF3cmduNmViQ0VK?=
 =?utf-8?B?Ukw4eWdDbnRoYXdCMHVkMUlpWUF6NUV3dW9RZlN2S0F6OEhWcStRMlQrbE5R?=
 =?utf-8?B?SEJjNFJsWkNLRlRLTDdRNC8wU2o5bkRvRWtlbDdLT3lFM1p0UENNR21CV1U2?=
 =?utf-8?B?b1hJbzRZNmM0V2x6M04xN1h0STRZWGlBMGFNTElIK0lOd1lac1FBWjQ1MDJm?=
 =?utf-8?B?MlplcnJIbUVhSVhKc3NjRlVxVWZMWkkwa3JaUFB6UFkyYXR5YndRak42aFVC?=
 =?utf-8?B?TFdIbE1PMHd0TEhKV3NzNHJqdG91Q21tUlBnMDM3UldBS0UrUUdmaUUzb0FT?=
 =?utf-8?B?N3VrWkVSd0J6YWNBSTAvWTdPVVdrWGEzbW84YjAvSStTZWR5MVBGUnlqSGoy?=
 =?utf-8?B?MzByZmJtbWtvVFhxUWREdFZRdXl1ZXArSklPV0Qrd1pTemhuRjZ5OWp3NVNv?=
 =?utf-8?B?TjJQZDlIcnB1Y0ZhVjhEbmJ3U2s5SmlDL2VIU0VWSWk1TWFuRHFOSFR2ak1H?=
 =?utf-8?B?bGxKVE9NNjFqcFg5WlFXTnEyRUVNS2xjK1NSTEdDaXoyV1hjdWNSenNXUm9W?=
 =?utf-8?B?K3JZWUgzL1Bic3dpbnFwYkpFd0RzMTh1UDl3T2w5eTU1VlBiVVJtUXJibGdH?=
 =?utf-8?B?TmJ1VzlGVlE2YVUrbFNiYXdnOWNFWmo0bC9MSzJjU1BTdXVSL1JTUUFtNnhE?=
 =?utf-8?B?TUx4R1dlUFFJZld5aWN6Qno3OG81ZitlWktwQnRWdHovUkEvWVFtUDlKbi9T?=
 =?utf-8?B?NlE1NlRLaW05LzdFM3JHSEh6TWljZ3RRUE5EanN4dVVqYUNwbmRILzl5bkh1?=
 =?utf-8?B?Tk5yRVh1bis2bFFCeTlWSkxFNVJzN3JUZ1Nqem5hWTVUUG42bURPZWdqZ2JR?=
 =?utf-8?B?YkRMeTVlVUdHZGNqZnRpQnRVSlZNMVU4b3orNEY3UkFNYUFHZENqVjhLcHpQ?=
 =?utf-8?B?QlFSWDNVK0dHM0NteEZ1bWI2MHRkVDBPWUlxOEVUakxrS3J5WmNqMy96blRS?=
 =?utf-8?B?YzdlSXFscUVBS0VjVlVOMko4a21VTHJoWEhyTnVkeWxXZHRmM2dTUXR5RXdB?=
 =?utf-8?B?M1A3cXI1bHEyY0N3S2ROanROWVVZY2daZi9KLzEvZnZPMmRydURZWEJ0MHA1?=
 =?utf-8?B?aThJTDhNWElsNm9rVVV3MGZPcHNVK0VUeWpaYTBQOTVpNDBMUjl5RVJOdnMx?=
 =?utf-8?B?UlNCVXVBNjg5RUQrK013d29Wd1NqeGx0bTR0U3V6SXJ3U3lYeThhTmlJRmxV?=
 =?utf-8?B?SDhEbXBwV25VOFRUdEFOZ2FHcEtjdjQ4NWk3bWxIRFR2OE5WcEM1bDZLTE5Q?=
 =?utf-8?B?dURNZ01pWElEKzRnNFR2RnBzRW5CZEYvZmZSbHJNeFlSbm9GakM5bHo4TXcw?=
 =?utf-8?B?d0EvOEJlNi9meXowUWg1dVdaZ2t2NlpoT2pEaWVzcWdUQ3A2ODJoWmVORFkr?=
 =?utf-8?B?aTVldGw3a2cyV0NraGRlUFNSUVRlY09obHFiU3JCb2dzTTdyc0VIdFN4MVVP?=
 =?utf-8?B?dkQ5S1hHQkJCSURGL3JWN0k4cGFHaTdlN2xNeVdJanRxY1M2ZngyRGo2VXk4?=
 =?utf-8?B?VUVkTFBveEZBdHVNYVFTY0FLRkYyYjFoWENJLzVNdzdiK0N4SDFuMWVWaGpl?=
 =?utf-8?B?MjV1YmVRaDVPN2xPaUlUcTVERUlVWDZhWEoreE5VMWJLcHZzZ0s3TEVQTDhp?=
 =?utf-8?B?aHp5dmFjNU9MbWNKZ2c4SnA1Wm90RWxnUXFuWUUvWmR3UmVhZEs4aDRTT1BE?=
 =?utf-8?B?SDRjKy9IemRvak9keVY5VEVDbmcvdlhJWkFySkxySHVOdmN2Q2pYdzBjdGht?=
 =?utf-8?B?a2xVTVFhWjNYZW5IVTJRMUVqc2M3b2VRUU5XeUpHa2srRVVCTWFKOTk2eG80?=
 =?utf-8?B?cE5DbHF6ZnFWNVJUU1JOUXpBdi9tYkFScGhDakZxNDNBcmliT29Tc0NtR0hr?=
 =?utf-8?B?SFVDa3ljSURiYk85RUFnR2lyWS9wNEdmd0N3V1Z6UlY4Tk5PR1BHamsxTytO?=
 =?utf-8?B?YU4vZEZVUTgzS1BIMmdoZENNWGlCdEpneWlpczBiR2EwRGp1VXdyaXhOUzF5?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rXYxxLrwBdb2KTDDI4m/t3fnRXBBXY5l8dz3kSULiLwWVXvJIJfELn96zscYElF4NZpebLt9AiZXRbrsTz1TNKE9cDVcaaYuT5hEcwSZZkV7s9QFpoQU19YVLOhP0O73JCRdpA4ejuOKHurtZBsXjVV+YVC0eRWKQc5fukx4lgO/XRh69HrELyanE9BGoLgURZ/j8td8A6wo8rTqczgabXgpugyX2qWTi+r0PCdGrP+L8Xm3+kOfehuNDMI+54/FYAqfkAd1y1/ZUaZnhM0p2UYPPvzCDKRV4ynisnuFEEGXh7u0Bb5VB1AxiGuohzmKHQcLrTgyh06Jb30LRb/oEKUyhkomv3vrcD7ATPu/aEMjM+kAFtmTX0DEYZk7fPzzgzWJGzWIdsDDKXDKg8aSxFuoMS7Kk91UdMI7P8UCSMVSDX3RXQK5EZFZ39QAabhfoe1kTcYxqqTGrar35K8VPmFeL8efEDm4g/vdfjiUAqgrmMUzbz2GSsa/IB7mZUbWF8ilAwis5+vzyPqxtqu1MHuz7G/5pPE81troc2DPXug7gJVED+E1rCyKON8rety/vw1icdCDHRJsLtLpori5VdfV2W/MYQ4glBkd3cqjiYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bda9fff-1cbe-43e3-65e8-08ddf444a94d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:43:09.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfQpd29KhpQeXT1tY/xh45PmKqJ/xHqEbLPpZwZDxpnGEuOiVPPqAw/pSSzq9JBz7GGFjf+3veRQT0x20kcgUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150101
X-Proofpoint-GUID: KxiSsnLkIIu0Ipm8VDehoGU6q4sV6eKG
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=68c7edd6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8
 a=i0EeH86SAAAA:8 a=1G9tskivovnnYzKpLrwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMyBTYWx0ZWRfX1FTkQDo8NoXR
 BfKcrTkB2gu+MJmXML5+bPaCbRVsodX60GS8u5IZ9cge0xE1anMmZTGsTr/oFuFMH7iPXCLul2j
 WYyKbyhWWGiLojXrX1NbKLMKisQqAPiQFveC/qmMVXe47TF/Yqi3fle4CZ3BMDQkR4GrQ6PRdrH
 K/jr1qNvWOWwaCfcsK9M2v18VBGsdGGD5W3YEmnJIcEJHVBo/v989eRM/DHi5VhoxkdbfLfq35M
 0AxP5XLLIELrVqTFYY3MmoA0nqlX1PzoEi6h2aHQbEaKbACJ1OnS7vXrBOPVPzAvJxS4e4jctkg
 M0geE1z4h6Fb8bMaqfDnZ8+CcFPux1ufkcrXcahnEpmN11IsjU17RA4TZFpo8S+MbMshIiGCfeL
 0RayO4wo
X-Proofpoint-ORIG-GUID: KxiSsnLkIIu0Ipm8VDehoGU6q4sV6eKG

On 12/09/2025 07:16, Zhang Yi wrote:
> Hi, Jens!
> 
> Can you take this patch set through the linux-block tree?


md raid maintainers,

please try to get this picked up ASAP. As things stand, all these RAID 
personalities will be broken for 6.17 on drives supporting/reporting 
write zeroes.

Thanks

> 
> Thanks,
> Yi.
> 
> On 9/10/2025 7:11 PM, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Changes since v1:
>>   - Improve commit messages in patch 1 by adding a simple reproduction
>>     case as Paul suggested and explaining the implementation differences
>>     between RAID 0 and RAID 1/10/5, no code changes.
>>
>> v1: https://urldefense.com/v3/__https://lore.kernel.org/linux-block/20250825083320.797165-1-yi.zhang@huaweicloud.com/__;!!ACWV5N9M2RV99hQ!JAN4eq3ePrspeto0Hn7563lg3392Lh44jM1oTbgxbDoClxVOh5B73QhGD53f9tiLxuxfJCr51PyAP55COV2TTZAt$
>>
>> This series fixes the initialization of max_hw_wzeroes_unmap_sectors in
>> queue_limits for all md raid and drbd drivers, preventing
>> blk_validate_limits() failures on underlying devices that support the
>> unmap write zeroes command.
>>
>> Best regards,
>> Yi.
>>
>> Zhang Yi (2):
>>    md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
>>    drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
>>
>>   drivers/block/drbd/drbd_nl.c | 1 +
>>   drivers/md/md-linear.c       | 1 +
>>   drivers/md/raid0.c           | 1 +
>>   drivers/md/raid1.c           | 1 +
>>   drivers/md/raid10.c          | 1 +
>>   drivers/md/raid5.c           | 1 +
>>   6 files changed, 6 insertions(+)
>>
> 
> 


