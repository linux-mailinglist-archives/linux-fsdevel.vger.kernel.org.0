Return-Path: <linux-fsdevel+bounces-66967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE0C31F4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 16:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F244D3B8F13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2A27703C;
	Tue,  4 Nov 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SjXGkJWg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tQc9hPRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A895215F42;
	Tue,  4 Nov 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271689; cv=fail; b=KICmhy7pGi3BPmQgxauQQSjw5IKiVFV2EfvYEew7sE585l96mAgO+r4gdsB0Vcy1EARyWcwYRZNkHpKViL0rs9u04epbrTjXdHfNkEnSHcxQs2g7kvr1nUpaV282HKisk5hzDDNdks/abUxKmc+EKtsv99qp703SgN8tCCKPBU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271689; c=relaxed/simple;
	bh=g1g3265jauBqiohTRineZ0/VvSEXLhlxOfS8b+itC6I=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=YaNhdFM9atcKR7GgCUic38jQvlYXGT9MC8+gjhiLKjqwMAnmmQIhdqT90eOkVC6yZ4jPjJ5fl2Tih0JzHuNkuPb+jM/u1TaedHUwN7BsiRtVupLgoaRFglEdD+BwFGXYbdtP1yeTkcEpkijrCR0J7rHqA6s/BbxmB54g3jWHqq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SjXGkJWg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tQc9hPRb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4FjHPi032175;
	Tue, 4 Nov 2025 15:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=etvfdEoZfseA2bYE
	VOPjW5OmJG0kFXAlNBJBtULF7ts=; b=SjXGkJWgwv0sRKZ/5Q73dok/4Zv0n/d4
	nU0gQ9lhMiHh+RE3PXFMbO8Fu3X1unaDYNhOcHTKxZuzc3ox343UQylIp7GMzDjC
	d1CIqdW672xRsmh2mPqDWQiLK0tWSXbaqIZ312QUHLLjBH62SwhL7VbxD+25Zgw2
	D4ihlQm5RJ9JEiMgHrG9wLbLq0Q3csoVhjlS71x9KKXaqw8Jc8cNpcUEw9IY9k+9
	8hNMZ+AIw0AMkWMep48oQpgXCzOseXwbhui+WgAWrUDYtsldkrbqSi7QXuDaFJOO
	gcCyQOGWv6NIgSezmSMSzqHRdUaBNRT5tIEnOgaIizO19UVAvN91qw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7mdhr0t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 15:54:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4FRqVp011625;
	Tue, 4 Nov 2025 15:54:45 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nd9pkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 15:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW6oxtoFyFo75YD2s9P+sszmsbJnJEpKPE+5q8kX19q6TwJsksD+amQzSLu4P4mDTpdEz0bzvmufLDN/zu2tdwkbx/NeoDPFjX1XkyfLQymq1rcXHr/ykwb593Vu7lctpnRhG6Rlrw25c0M5v8EjFzi0H7LtC7oF4o4NKoG3SRgI0AaEINxbrUygMqpkls0dO8kOPeEhPoKhcTheSUlRPFvtJ5eM2Z2VfVwt5zIBYs+rZuwFvHoGyxsjKbBp+94o9hye9QAsny456LG7OEDDz6mZtpYElCbqCT8lj6rALd1NSWlLDYxg8iqTMHM/dCbuIE8cdMYEJvC2o4zZ8oUt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etvfdEoZfseA2bYEVOPjW5OmJG0kFXAlNBJBtULF7ts=;
 b=dLo5kQOa76oqkYgYtT1PpkhBpcoJ3GyZ4UjaHYSBDG2ikAJBOhwMrtvHfKAsYxWNfgVImmm1t4u6VRPK7/c9+LORQOgt6YH+d/L40AM+VJvOIa03x1wTKO9FWOBNyI8l8tLn0v1fxqnAN3F+EnM25Zmhzd50ULJz5G/LLpBOT/DwlwVrKBS+fhfWM03TTxCUE5zOunBooBffk+AKcb2OVX8vwOR5c5Lc9sIq3qqSH3/zLNNL6iH6gXrvGEhuloaF029vb93PNswt050uuaqgWBGzc0ZCRdl7ldUOpoKA0QSDI/iUfBQXSQc2vcWYyy65VFUssa0jLhTgGSNqGo4zHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etvfdEoZfseA2bYEVOPjW5OmJG0kFXAlNBJBtULF7ts=;
 b=tQc9hPRbFC5yrEg1ao7zMJ1Ov5eAN9oQmAMy9+AHiLngcEHXhggCjGe48VfoOlj97coiaGUnTHsseodFuesPW+er5gYkbQsdg13DvT2UhQxOLSNJoiX/6Qzr6YVanY18HxWWxXEhBFoVL5TtPU2HpekjAwpjAjJUAI0sf4sUciM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 15:54:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Tue, 4 Nov 2025
 15:54:43 +0000
Message-ID: <8918ca00-11cb-4a39-855a-e4b727cb63b8@oracle.com>
Date: Tue, 4 Nov 2025 10:54:41 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: RFC: NFSD administrative interface to prevent offering NFSv4
 delegation
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>
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
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 4644b0c2-4dce-4915-2e19-08de1bba7869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVJWeTdTTmJndnArZGFVbXpEU1ZUS29nMkQycEtSNTV4OGg3ZjZ4TGZnRFBa?=
 =?utf-8?B?OWRCY2dHT3hIT2VvdnpCV2tjd3FVUDYvVURWWDVyQ2dKT3EvUTVWeUJjckdH?=
 =?utf-8?B?cVJ5c0V6OCtXVmN6YkxPK3JXZW4vTTFnSkNRVXVuTkt5QVhJb1IwWW5wcWRS?=
 =?utf-8?B?a2N4SG9tcHVSRUhZbURVWi9pbVcvMlZ4MDhhZ0V6ZlFmaFVjTE1SWlNMZlV5?=
 =?utf-8?B?dEptMDdyS1hOQktwRklwQXVnalV5VWNLaEhQY0hFbUg1dHJGRmpvT1hNR3Jv?=
 =?utf-8?B?WVdIYXBjL2NQeVdmNGlOWFRVcEtKTGQ3cUJjMUN1THRPUUlyeUtEU2RIVkRt?=
 =?utf-8?B?QzhTb045KzBRUkNYWUU2Q0kwQjZ1R1FhVENSaGx5MksvTUE4dGMyOE0xa2ZH?=
 =?utf-8?B?N3RSWHdHTlZvdE90a3hrWlhJbjNtaitLdXJ0dW91aFd1M2FhS0YrYkhFb0hR?=
 =?utf-8?B?cllaazk1ZzczQlBTQW1OWjM2VHh2MWQvWi9TSGNZZDAybCsxa2ozTGwrcWF4?=
 =?utf-8?B?U1pQQmlBR2hBeFNoeUhpeDVndG1KZURta3dvL2pZRzhqYWFZY2ZYeGVmREFH?=
 =?utf-8?B?TkpSUFREVGtHOE0rb3U2bWt1YjU5OXVDQWhhdVBIMlNiYWNNTk1QNFNmRG4x?=
 =?utf-8?B?THh1T1F5b01kSkJtLzdpeHl3T3IwdVV6NmgyV1pUYWVldGI2anRVQWo3Y1FE?=
 =?utf-8?B?dXFDWE92STVrREZpOGVuclRhVGZRdVo4ZkhtR0JWMzdPcm1CNDlOTmRxNDVS?=
 =?utf-8?B?SnliYkxkc3lLcGcxdm5PSk1EeCtscGVsRjFTbzVSUFQzb25Qc2JsMFdJdWF1?=
 =?utf-8?B?Q0txM1c3aUVpaWFRYlViemdMa2EyN3hydEdlUEthL1d5emdlM05iRzJNQlNa?=
 =?utf-8?B?KzNpVkhjakppNWxaNzFMQ2d3ZGcvYW1YN2YwQzdJbENqSThmYnhLVHAreVFY?=
 =?utf-8?B?clBMNTBCaDY2K3dJK0ZtYVRNOVZLdmlidXFMUGJyUllOSk8xQ3pEMWc3S3Q1?=
 =?utf-8?B?ckFpVTFWcUVMRDlkWFRoaFJza0VyZ1FOTUhuQlhaUEF0V2pLV2RVTzQ0akdZ?=
 =?utf-8?B?eTQ0aDM4L1JWcEE0TDA2dW1UUEUrUGs2QmJCS1hQV20vL1Z2TE5EUGFQY0lr?=
 =?utf-8?B?VVJLellPaW9FNVYxVC9KY1hvcUtHL0RSdDJaUzIxdmxCOHErN1hHZUhLR0JO?=
 =?utf-8?B?VC9zc3orUDJTNzRqOWhROEE0U2ZjUWhXY0Q5U0MyaUVxaTYvZGdTOEcyak1x?=
 =?utf-8?B?MXMrRnBvUmx5V3ZBZ01IU1R6elA0OUFQbno2QUtNMXZXOERNM3I2a2gyMDJG?=
 =?utf-8?B?SG1SempXSUZRelE4NGsxU1Ewcmc4LzRqSzg2akFxeEtsNkJLK1lSZU9kN2RT?=
 =?utf-8?B?ZDFCbzQvTjdONTBOSzFrNndXNGdMMXpsSWlpUzdRYldLdVJOVmVtbFF1VEVU?=
 =?utf-8?B?N3lvSE41Zm8rVEdWMitqSlN3Q2FxSXQ2Z2ZPNG8zczNMZTlIYi85b1JHVm9H?=
 =?utf-8?B?MU53cE96SHhZTUZTSkJDN29XYm9Xb3hvVWJjazZzckRvdy8rYW8zZU5yNDZC?=
 =?utf-8?B?RmtTMGlCeUJNcmFYMmgyT0VvNEFWM0RudFp5emFpWEZuRkVHcllqWEYvQmZp?=
 =?utf-8?B?WEhwcE9oLzZ2UTh4OHREV29KZk12MURaZ3JuWWdFTlJpZklUWkRlN0NaSkhm?=
 =?utf-8?B?M0plcCt4TXdSNHN6c3VCbDJhNmZTOVByeHBTOTJJQkxnNDJWRmxrSzA3WGZV?=
 =?utf-8?B?RnF1dm9abWhIWmhDcmhZQndUUHd2dVBja3lmYlUyS1NISFhkQVlVMno0ZzJC?=
 =?utf-8?B?SGl4T3QrY2FKUTVockpjRXMwVksvSDBzMXA0cS9oMXVOeVpMVzczdWdsdGUx?=
 =?utf-8?B?aXZYSjRpN1pWOTFFdXFZbHJyMW1sK0Z0NmJqWlEzMjFWNG9idXRKNEN1eXNa?=
 =?utf-8?Q?8zErqDRGxl1raUbneUG+UApaef0e4JNb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXpTWlhabE4vMXJVMFRzME5XbnhMOXRyV2RGTm13Z2FqRGhPZVA3QlFHaVFS?=
 =?utf-8?B?enFQSW1vQjBSL1ZFQXd1dUdOMHoxQlk5RmdackRocWlTR3A3VTQ0bkNvMWg3?=
 =?utf-8?B?U3ptSDdDaWxqNHVmVHlpalBBQzhQL1hoajI1N0hUeGtiL2k0L0JKUTdPbkNU?=
 =?utf-8?B?dVZVTG1CeTVvemdUOHlIeWpmSHd2SDZ2MEQxUCtUK3R3QnZrc2xMdkNFQWVQ?=
 =?utf-8?B?QncxSklnQnRnbVFRbExocEpjTk1mWUhUNXBqMUl3YXUvSnB5NzVyd2U1NDVC?=
 =?utf-8?B?NUJHekM0Znl5WStLbnJRL21BeFluUlJRL2N2ekpPMlppbUluVXRRcmxTckts?=
 =?utf-8?B?bVJtb2FONWkyK0xZRUM3RE9zSnhjNllnUDJiNHlJRGhPYkNPa3lLTTc0YWh1?=
 =?utf-8?B?NGoySHgwN0xyOTcrNlFJVllkNFI5ZUk5SkhRc2ZxckhiYmxUY3Z2SWhHUXdr?=
 =?utf-8?B?Q3Bzc2t0bFpUaUtEc25Tay9ueGhUVXBidys3YmNickl6cWpjaERieFRyd3Ir?=
 =?utf-8?B?djJnRmxWY1R1RmRvdWlSU0gweWNQUXVOZlRqUDhPWHVVVXd2elF0QzdkWkww?=
 =?utf-8?B?aDFWTHZyRlJ3NTNXRmtWR1BPVUNnMXVXMDZ1dkVQUm1JNEZJTlBQT2hCa3Ix?=
 =?utf-8?B?WmpjcnpVRi9vQmZYeXJIbFlVdG5FZ1ljVStiRmJVVEZQZWNiR2YyNGt4dHo2?=
 =?utf-8?B?bnRuemVQaW9zUnYwVm95cmtKQ2p6cFBZRCtvSW9BZERkMmpuMnY0RXAyVmhn?=
 =?utf-8?B?TDVGZDdEZ2cwcWs4U0xmWUgzeXBadFdBTjVDbGFoc1NmNkIrVVo2VDFiL0NV?=
 =?utf-8?B?RFdOamY2N3dSVkZHWDBKd2NxZndicVFBL0pLdzE3TllXQ1FDd2FYaVc0WWQv?=
 =?utf-8?B?R2ZEaVVCRHJHQ2NhUU0yQlZINDFIZVRRSGxHNWtiSlF2S2oxVlpScnJna3BI?=
 =?utf-8?B?NFd6dHQ0Mk95Z2c3d2Q3YlNTMmtpNkNwSkk3SUI2ZVhHT05ZZEVTOWdMSERV?=
 =?utf-8?B?bEFrZWEwM1ZDRTRiblh6RTUwYi9nNitjZ3AwVCs0NG1zdG5kelc5N2FJMEZx?=
 =?utf-8?B?c2hYdVgrUTlWaGdpV085eHg0TVFjcEJTNm1kMlFLMzM2MmNaaFRXY0loUWlw?=
 =?utf-8?B?cVQ3VU1hbkxwNkpJcXhhYTRZWkdiU2xtNGNsdEYySUtWMUxNbVZmRUR5VHJQ?=
 =?utf-8?B?TGd2YVMwdkRYQjVxeEJGaHU5ZWNrdjJSbDdMMXJMdzBFRE9NMWFmcWNKVHVG?=
 =?utf-8?B?cDZUNlhsVG5MYVBWbm9NQVNwUU15L1l3WVdKVjdSQmJvUVo3b3h2Q1hRaG1z?=
 =?utf-8?B?Zm9ORVRpRW9GWDA5K3hZRlNQdDZCMFBpVWZSNE5pcnhoNUx6TWlkMDZMS1py?=
 =?utf-8?B?Vmg2VHF1akxLb3ljc0xEc21ReDkxZVFTUnZvR2hxM1J3OXRqRVZlTHJjK0Jk?=
 =?utf-8?B?bnJLSU9uZ3pCNW9PK3RLbTFwdHVQb211V0hlR0hmUElrSnVXODRSUE9TQnEx?=
 =?utf-8?B?enFySVdiaFFnMlZwTWRNL3hZdmJseHhBMWphK1hLVndCQ2NTMlowSTFsSmV3?=
 =?utf-8?B?bS9Lcmc2K0ZRWGM0VUgwaDZQTUdpVGpzSmdqVGlreDRSenIrNE1xNDEremRn?=
 =?utf-8?B?WlJZaERlWGYzc0FBZ0hTZHdrSUdmTjhkcWNNVlp4NXVIQ29tQVJUb2RjZ2xk?=
 =?utf-8?B?ZUhlKzgvM1RUcWF1b2RHV3VJTlRmV1dDWStiNUpJUEZtNW9ZT0p3UzgrMXVu?=
 =?utf-8?B?MmVzamNiaU45eWtEMS9TM250aE8vd3JaSmNHM0p1MUdhRmhxZi9tVE12VTYr?=
 =?utf-8?B?ZzdxQm5aUGh4S3V4NHVRTzFHL0RuZWJ6TEJCNkxMTlZGUG1kUkVHK3hSSkJp?=
 =?utf-8?B?OStaRmRGS1ZvYm1qRFNadkhXdjh2bmUzYU5jTkovRXRwTjkyYjhadDVSbE5C?=
 =?utf-8?B?dHA1UXNzL0ZBS3BHZlliamMyMzczeDQzVDBRV0wxRzgvbjl0VG0wRW1SNU8z?=
 =?utf-8?B?ekM2VXJOdUZ2MURRdW5MaVNqT1JndmdoVHN0UkFzUmNrTnU5WDIxQ3BkVzVa?=
 =?utf-8?B?bXpZOFpGc1JqMFBEay9ES3JMM2xtWmNtN2xkbFJFYklhTlJ3TlUyUnZLcklE?=
 =?utf-8?Q?4xdYSzO/jaMeSA3Wis9PwHxM9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v3N9kwvCVrqtAeiVk+yukP5tkSdu+vMOdJp8l6oQbmfnBMub1ALX+KtuYQaC4lPyGIi8AyeD9Gpov8wpWiz96cMUVP0NQFK6nFk35J9OVVWQ9Dw7BLK49P7zKpC19KwaAxKTgAJRRh7DOdYKePSd1GYmVr9/VTQL6g7bTgvwzB4Aa/G6J3D+E8+phGZ/TY1iyETrOdjEUxyuQKEbIgWxhtcf4Ix31JS687S+nNV5ytd65LI16HZMnQAvA+yOoRIKiyvhXSt43Ob4GG17QNxiPL5IBtvm4H4Im/x8eISvW1HWwOO0LrRte7K7e/B3aJV7JcVcGe7ehQz8So49SGa3iBV82FgsXOrJojqZ188zBuPYqs2JQsrfB0ZvAd+Nev+vhK1KgyRG6XIKsBOJwNIlFJCyR7TPIIueKqbOk6snCSeXk/2KOArB6LVLloyeu5KcW9yaoWWnGHA7VQVW0nOOZMipMb7dH/8K3iHdk73geete+t5FEkY5lqdLMuOaCZL79WwyoTPDD3Rt7XGTxC/FQqpUWuPgTvm2FfLdDdFfleVMR+SWpqTqhU8g+HeL3wZ8x3zRyNrqOpKlB48DFM3Yn/o4C4asleAiQqZd4WjAv5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4644b0c2-4dce-4915-2e19-08de1bba7869
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:54:43.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rn7A5yEk60bo3OpJV8cXKpaNHAY/d+UKcruY8RZPIK+B/X9ToNA+T9irHeGqzx9zHm0p8lS7dnsHO6Ga+rGv9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=900 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511040133
X-Authority-Analysis: v=2.4 cv=cZTfb3DM c=1 sm=1 tr=0 ts=690a21c6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wZvzrEkeo2RVu8rokH4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12123
X-Proofpoint-GUID: mC7JWeipNXMCt0wcRdL46BX6XCDabHIs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEyOSBTYWx0ZWRfX4UDKXhd+penE
 2sYBFypZq+Renk9/nsNZwS6uVgGg5Iqby6OppxwxPYo/0hKjVRKuRigYB5E+cU4tPL+kNvHf5AF
 MxJYSq1ijxWeeIYYFutPrtq9UZ2gskQ6X3JkXUaYBCOAEkneIB3yGmK07m5wmnHIoQINaDAMkk1
 JwDvAMEpzMuIxCrkT7DC0hRacqEU1bvgMNaKQFYzfh5nr8B4ve/W5pF3IYuU7DaLpAl5dtkOb1q
 TeL7TahMZEBceSiv5Ttfrviumcon4VQwz1BL1pSjwCWYA/X6fNNaUiTjIFFPq5uHsHVtFDLotas
 Figpt+IeIpFAMsAoOeLP5xH8QtjVhhxgyShVWeKz4Ebt5DQVnkw6tCiQxvj5jLxLnNy6tRfq6W2
 3N+Quf640tMWNtUCsWOnsWIsjKgIHqhZhPtbUF7S+gX8s9SL3ks=
X-Proofpoint-ORIG-GUID: mC7JWeipNXMCt0wcRdL46BX6XCDabHIs

NFSD has long had some ability to disable NFSv4 delegation, by disabling
fs leases.

However it would be nice to have more fine-grained control, for example
in cases where read delegation seems to work well but the newer forms
of delegation (directory, or attribute) might have bugs or performance
problems, and need to be disabled. There are also testing scenarios
where a unit test might focus specifically on one type of delegation.

A little brainstorming:

* Controls would be per net namespace
* Allow read delegations, or read and write
* Control attribute delegations too? Perhaps yes.
* Ignore the OPEN_XOR_DELEG flag? Either that, or mask off the
  advertised feature flag.
* Change of setting would cause immediate behavior change; no
  server restart needed
* Control directory delegations too (when they arrive)

Is this for NFSD only, or also for local accessors (via the VFS) on the
NFS server?

Should this be plumbed into NFSD netlink, or into /sys ?

Any thoughts/opinions/suggestions are welcome at this point.


-- 
Chuck Lever


