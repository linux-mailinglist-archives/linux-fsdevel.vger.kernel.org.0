Return-Path: <linux-fsdevel+bounces-49142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A998CAB88CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B0D4E5887
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F1318D620;
	Thu, 15 May 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LEvAUCqQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SUu4ZcLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABC42C0B;
	Thu, 15 May 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317736; cv=fail; b=dujLUfTfG6fgUvX8y4wq/al5pWFPngvicpSZ9TlduDVrg+8aN0YbZ2lhJoEkyI6FBvjQK6+3WvPGBtGDq4stwf/BXyJ2wZbDSv5KFPputv2oxza5i+jni50s9K/nPhP3QCpNrkMv12RLXAP8JjXuc3YvQGybYI+dICQF7Vx3sp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317736; c=relaxed/simple;
	bh=F1ivptBWTtFvjL8/Ym+IX2XwJDgjYXSgaAAO8KCXH9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ehjXUls6pEB4QEi6LaQskBZIv7I/IR9Imxsb5isCnChUI603Ov/rM6lmub3VPgw9f2/rSIaPnlA4Zqj7/8VdHGV2w79C9ZpEjZSkjz9bwl4YOEzO8QcwCc76kmOhdd5PMBjkLSp+q8AzKXBaRjQ0SemoxEvKPRMoDPJageLh6AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LEvAUCqQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SUu4ZcLB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7Blkc015554;
	Thu, 15 May 2025 14:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aMGqxkHPuA78iCXaSlQ14ZLgA0UkSkCv8UFxjKFwIKA=; b=
	LEvAUCqQqf/Ea4nQkWJkkcXVKPMI9R8uLVngBijnCTbygpu52cZ3P7UHoXTYoL/p
	o/LpNkYExn56t+EWdtZVZio3k4daBCXRRnZz1Ucy9E7/V5AdS87EJVCFEb05Y7N5
	JtiogZU6JxAXDcFS1Z0e37t28R3QjFLXhJnWNGVgXebPClkvS2bPs54AA2XZ8UC9
	jApTYVIX3+O3LyKsA2/Ha+ZO6Z9q9+7+XJSkxM62WbHnMa8EhYxkoWbNsGabkIux
	7SSazYyfsmrMFI4gjlhmETHLj5bvnJUxQwMQtERFUKsQjBCY8hjW2qZJsXYaT3/D
	1rkxf++S0E6qkM1KbFycFg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ms7btwv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 14:02:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCVxcP016906;
	Thu, 15 May 2025 14:02:04 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011026.outbound.protection.outlook.com [40.93.12.26])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc34u9d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 14:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vA3qbru7xf+q+j/+Zy5wbHaMY1dTOJp9M3uOSvPabkkESrVKXAsXyjQmLajyWPp0CtaWppe+IdAu74e2oC1uVbAkZn9R5rqftYL85TO9aihN5HezMC2z0xzGA6+60mB5H5EWtuKoWuQn5ECjQpu3DhOA27TV+Mhmng4j6IVrZWL9TxxVGjLNz0LSLIv5NaGL2Gxi29Oy9RHyejWyWdy1LgHVJbcn5q1b+1/8ivDXDJfvlnieeZBRTGvRqZ2OwstbO+LBex270+dFIfQLzx/s/dynzyhXB7nPY7Qu19aaDP6fzi/cfSNm7LdqYAKJtfLL4yZVxkx03PSXCjAxidKo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMGqxkHPuA78iCXaSlQ14ZLgA0UkSkCv8UFxjKFwIKA=;
 b=W5hi+7MlZi6NBHk9CLCR5GXTnOj3KYf6YECFDlihOgzpklnmZNbmBNnNKitjCt5RAqm0c5ZfvBJlBDGxKzVbtuOHGrj2BNnUcTmkMYZSkM6iP8+IrSJp/ZlbUMZQrZI5FKrXc96GJ+6SZwAQ/qBZbClxPA1vy9AquDjbXsR4xqBxDJL3RW9w5AZOySkKyZyBXxpnLNRw2gxr7ehccRv4jR+FFKXLFNObpgQpEXgC2RjV3dGOIm7b4Z4JUbffTglT7IWzNbX6YNsYbtYmuSCTVhzOE4hlY5aKNn5sSqKAfSkHNFgbP+sOY9uuMuQkdjOUsAK15aRkgQMcvKEHmIm7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMGqxkHPuA78iCXaSlQ14ZLgA0UkSkCv8UFxjKFwIKA=;
 b=SUu4ZcLBrm9bpXwBoiTgZAJULvD9PZarYUoERhai+eQBHudAs/BNOsDnzirStaFJHGKev9l2809Trsa4z4zX6jwF/21PadMme4tPWSWHM1H3KdzxZc+67Buz21Z961sSxawOhyZczovrykur4MlFL9ulclwJB6ovtRA80++Dc3Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA3PR10MB7044.namprd10.prod.outlook.com (2603:10b6:806:31c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 14:01:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 14:01:58 +0000
Date: Thu, 15 May 2025 15:01:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jared Kangas <jkangas@redhat.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH] XArray: fix kmemleak false positive in xas_shrink()
Message-ID: <053ad5f9-3eee-486e-ac29-3104517b674a@lucifer.local>
References: <20250512191707.245153-1-jkangas@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512191707.245153-1-jkangas@redhat.com>
X-ClientProxiedBy: LO4P123CA0405.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA3PR10MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: e71ba156-7f47-4d19-2285-08dd93b90ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDJ5a0R6aGxmSjBQaHFML2ZTVWUwNGoxdWVSNUJZTWVvcGhRb1d4aE9rTnl2?=
 =?utf-8?B?cUpaM2tWKzFzNmwxZGFXTjRNU1NnblM4Z1lLdXNtbURXblhMbU81UUdjUnE3?=
 =?utf-8?B?c01pdUxpK3NDWmE0d1pEZng0YXo0VmNrQW9kWERjeXhUVDl5VWJoY1NTM3c1?=
 =?utf-8?B?aXhMSFU5ek44L3lqenlYOWxrTDBLeDJKVEk3dUJzbWxzaW90eWNGRTdGYjl6?=
 =?utf-8?B?Uk1Ta3hxaUFaRVBEUU1aWlJaaHpLSkt1R3hncUtZVWYwbzFSanFuTHVRSVR5?=
 =?utf-8?B?YVB0SlRtcHh6cm44TWVIT0ZQclNBWFozNXJzaGkycXB5aUZqUTlpY0Q0cnVv?=
 =?utf-8?B?emF2NnJKRzNCdU9xM05PNkdTcGxFdzh1ZCtKbDUybzZzend6TmpldWFVbW9j?=
 =?utf-8?B?RjFwTlZTRVFuYWZrSDl2bUdUa01xWktUdHBVU0U5NVlFT3B5TnpzajhlNXM2?=
 =?utf-8?B?S0o5eFV3QzlUVWEwTnViUnhjR2JMQUdTOTBCekZoWTVYdllMOTRFeWRpclg4?=
 =?utf-8?B?OHpxWUd6QkNERDRrK3VOZWRhMXVYQitNSVZKcElJTjA4NHJJekJwaWFnY3Nw?=
 =?utf-8?B?MUxmcmpFWUZoNkNhV0pNaDVJOEhUVDBzb3ZkaElJNWg1ZUNyMkh0MitrZDE3?=
 =?utf-8?B?dXJSQ014MlVkMDJjWWtwVHEyNk96Snd2YTEwQXdCa2hqTzdESkthTFNET3Zq?=
 =?utf-8?B?SVl3S3FweVY5Q2d1R3p6UDJBa2wrV3NwWjE0UmVvRXJ6Y2tVRkZveU9XVDBK?=
 =?utf-8?B?VHNrNFN4ZmFQeWlZb3huNTY1VnZScHFTMnREeENTTFlnQVR0aXg0aWtSRGRW?=
 =?utf-8?B?YldKbDVyajZRNGFrTEJWYW41djhCdlYvTTJVNlhwVXhxZjg5Y21penV3endn?=
 =?utf-8?B?YWdSUHNheHVXdUNLaS9FbFJJRGRmY045azlnNVgxUkNyQTQybGdJRkh0Ujk3?=
 =?utf-8?B?WTRFR2FueHVCWlFzYXJmUS9MNUs4WmR6d3NNOHpWQklsUjdxaGRpVDR0MDZG?=
 =?utf-8?B?SjRUcUtyQkgwT2hYT1YrVkZLZ0RMQm9CNlA4MTBnamVKN2MwZU81ajdNbDJO?=
 =?utf-8?B?bVpTWElsSmdqNEZ1eW54RVRPL3lLTEdtd1lCMVNMK1dES1NNT1JRU1Z1T0hz?=
 =?utf-8?B?SnZCWXVXK0wwMGo2VFcwMnQ2Mnh3RmM3Ymp1b2tsMGxwWmpyUWtVNkJKMDBD?=
 =?utf-8?B?eHp0UzRaQUtrbGhNSjV1L25jOGFWV21XNmhqSXVuL1NsZWJBUG9EQjFXZCsy?=
 =?utf-8?B?alR5czI3M293VmprWGxlMy95Skx4MGRIQ1VXcUE4Z3pJUlRWZ284d3BaaURr?=
 =?utf-8?B?YW5iTnVPM0IvRkJxck54d1FEbDNHK3pta090Rkpxb2ZQbkdiZS9MelBNKzNz?=
 =?utf-8?B?RVZZNXY2YWlXRnVyd3Rna0EyN3c4VGh2TkgyT255SkZOVGVpNW1BcGl2ek5K?=
 =?utf-8?B?Q01oVGNkMGcwOTBXbXhYTjY3ZUs0dHBDd0xIbm1zZmZRUUlZYTk2S3FwaVMx?=
 =?utf-8?B?cHA4TmJxWnpSRDY4S3AwNGUvdVJYY2RXZVJkaXdzVGNSL3l6NHpLTUcrNzk5?=
 =?utf-8?B?SzFaU09hOUU1SUFBd0xXazM3Q0JpbWhiUFU1VTV6eDgvTXNlZEg0UkJQdGFz?=
 =?utf-8?B?aXo1MWwxVkdjclVZNDBmSFVWakRXSUZ3ZytOd1U0aksyeUkzTGFJUFlUaVNo?=
 =?utf-8?B?Y1Rka0tuWWlFZFNoUTFmTUlVb2txMHliQWdLUklvUzRLdFpldHVJNG5ZN2Jz?=
 =?utf-8?B?Q3AxTjZuUUpUbHUrS0hqZ3kxUm8vcDRVNWJERFZNTmpWc3JkSUkySTBoQWxF?=
 =?utf-8?B?TTRoSHhTOFQ1VzlOcnVKUVpmL1FVMGplaVM4dEx4bDArVnc4M2JSU21IeDdR?=
 =?utf-8?B?aDRqY0Z0V1R0TlRTWHB5WEdjZmxuaHBUSlkzbTErenpoaTNGQ0w3LzRGK3N0?=
 =?utf-8?Q?Kp2Ptpd8ASo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnNuM0VZYVFnMEdFb2ZSZkE0UUFDaU8xZTBGbmxHK2pmZmpib0ROV3pZWml2?=
 =?utf-8?B?WXlZRVdGdWUwMGM2N2wwRUh6TFZqYXplNVMzWlNmck5JY2srK2U3SUU1TzBM?=
 =?utf-8?B?NmJaMW8zc09tNkFMMXQ0Um44UE5JQWhxUHIrSWRDR3gwRGxNVkNEMER3M1Vh?=
 =?utf-8?B?V0grL2tOOGZNajk1NFVQRnF0Um5CTnNkRTdQazdjNkRqNDVNdFB6bmdPeVpi?=
 =?utf-8?B?QnB0dXB6RUNxTW4rNThxcWthdGpHc3l3ODZ3NFhXc0kzZGxiOTI3eTZ1bS93?=
 =?utf-8?B?YXJwalg4WkVTSTQyU0VaRDEvT0RTMXh6N0N2RGthOWpCVGZwaWhENFhHdzFh?=
 =?utf-8?B?VkVVMUc0bGFtMlM0NFpkQ1hJa05Tbjl1YnVZOFZNNHJFd1NMMGJTVmVZWXpT?=
 =?utf-8?B?WXorMWxhN0xXa2RQcFdxK25wVE9tYmRObGwxSzJuZnFYdkFyTStYMGhpTk83?=
 =?utf-8?B?OVIrTWJFUkVJU3M5MGF2NzYxclM2YjVYUm40WnR1ZkRsalFwVlZ2MTZRbXlo?=
 =?utf-8?B?NVVZNkJ0MS9LTGo1TGQ0MFdKSmY2OFJpc3ZnM2U1WnNkZzlWTVJNaVlFWVo5?=
 =?utf-8?B?eG9UZkFpdEoyYlFOYWFVQnEzVHNIZGhUSTYxcXdITFJWenlKeHlmNVBmRERQ?=
 =?utf-8?B?R0dSSllXb2k2NXJHRVM2ODh0NngrSkczMDRydTZhUVgrY3hrK25xTldMMDcv?=
 =?utf-8?B?bDZQU043dVQvQnVhR0JTLzFFcXNpMGsydkZWVWpGTkRYRVFSd1BkQzdQcWtK?=
 =?utf-8?B?Z295d213eUVzSVIyUzNWeDA3Rlk0U2FvaVEwKzFEMzZ3bTQwUGsveDRVOFVt?=
 =?utf-8?B?SCtZd25CNXZLV3Z5T3J4TDA0bnp3VGtDVG1MdVI4K3g5NklQaEtGd3NwVVYw?=
 =?utf-8?B?bmRGYkdsd09URVQwa2cyaU5RMGJWOXJBQTdoaytTT0xIVUx6bnh0ODZWemFi?=
 =?utf-8?B?M1RaTW1BSGpucGdDNzBNM2hBZ21lT1BiV0tlRE96RytxRWtpaUhGNEtxbi94?=
 =?utf-8?B?M1hIVVFrN3VLMmZ2QkJMTkR1YUNxMXdPbXZxR0twZ29ObHRVVWtUNHBsOTNY?=
 =?utf-8?B?ZHpwK3lIekpZY0ZHZ0F6MFhtQmR4bDVsTUV0Wk1Yc0wveTRobUVycG9JMmF4?=
 =?utf-8?B?TjV0N2ZnOUlYZHBpWVRyaXgxUENacG9ST1RLMG5YODZsbjJ0djJzRXl6Mjhn?=
 =?utf-8?B?b1ZNczFJTFkwdVdFTVEwbktlUzhXUW5GNjFVUno5VG1QbmNXamJ3Rk5obTBQ?=
 =?utf-8?B?ZGU4SUZZUXJwVE1hcDN4SkJPaU5uM2Q1cXRwTzNGRXg4RTQzdFdhYzVLK254?=
 =?utf-8?B?UWcrYUxIZi9iYXlhb2hDbVI2TkEzTW1xVm9SQzF3NG15QXlGczZBVmp1K3pi?=
 =?utf-8?B?ZzAzcHBXdG1LSHBtQS93K3dpczBVOFhtYnRLdW5XVXhkUG50ZXpuOEllUVJO?=
 =?utf-8?B?eGtrN2dFakJiZWZGNXNzMVpMeUlDRWtjbk9kL2VsUlRydWV5bDNSUitlUEg5?=
 =?utf-8?B?USs4V0NnWlFFRnRpZHZQQnBhaUNCaGRISzBFb24yRUZIbTh4b3dDRXRjUitW?=
 =?utf-8?B?QUlmSDNud1hhZGdYTVVRcFVkMFdqY1VhS0tKRlRVMnJ0N1prQ2pMZXg3dmUx?=
 =?utf-8?B?blUvMTN2aUp1R2pHU1hRT1YxOWpKeE9CUmRybFloU1N5VStrTmpGODJFdmtT?=
 =?utf-8?B?SEZhdjA2OTRkS1ZoOFY2N1RHRXdyMDRsV20rTklEMGlTYnhrZGdZc0lpS3hZ?=
 =?utf-8?B?MmUxRldCMm1ZVDM2Y3l4aWVJalRPSGVEdEpPai9NYmtyaXI2Z2IzN2RSWGFx?=
 =?utf-8?B?dllYczRmQTdFK2ZzVDNpMDAzbVVkUngxSWZIMk0zSU42RnREZWNNcTVjejV2?=
 =?utf-8?B?U3VKTUJKRit5eXVxV3Y3Q01pZXNJVmhFYjVpV3hrNndFVXBnajlZVXB4TFNY?=
 =?utf-8?B?a0FobTZUMUI0VkN5ZmFJVTYzRldZdlVqT2FLUk9uSWo5VzNIL0pKZGtyY202?=
 =?utf-8?B?dkVFSkhqR2JPRDA1RDBaZjlRTkpiV05vc3R6cGFnamxtVC82eWtLditkTlZx?=
 =?utf-8?B?NEQ4TXo3ajVPY0dDUSs5MDJjbVp5aEl1N1dCQ256UGVyUkczSEY4Nk01cE1n?=
 =?utf-8?B?N2p4NklKUS9MQ0ZXR3hXUjI4TWhOYllmSksrT0haUXErakFtMXBJekJ1Rkht?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z54AEiPKU3LPLCaObIU9AFFrBC3t1I+PGqSDiCEXuOeWqw4+ynBAZQUSrD4JVk0QyROTC3NCZylRmUWY31k5VSdQeZOYqWAz5nkYGcQFx0IEXYLYqsLja3hDT9+oM+5sbPLdAY6icrdGAOVpS5o610LdBoEWrCTJ4xOzqdfHi6pN2QV07iKIZlHsoVAPelaY0JrgVtF5UjnMj+z/mKjB2VBfjGHNLGdFWEwehdFATiAeCe7ob4ZDpRXq6FL/SZSaFOt3MT9rdOPaXurCJjaXO75gsmjcXVvJykBFjPidgN6ZlYXX8pU+orak3Pk0sNqbBhRsgN+edCQh/5WvN1VlnmUirPRx5BFyIurXlAuGmR3CXmwGUI6dQOYPAcZmB9f3HIa678UByRVL8tP/dOQIxwbNhSulvZ2ce7VOqyu21w+Lr0UynH8zFatbPHJUdImfYkThE/pjOT/59rqVPIIDxuJDXPORCruWXtvIy7diGkk+ul9p1jfF7yVIEgEWZ3rZUqYLjZm2hEbOy9lNoRn1+CCTVAeYOBuSIW1dyuh8AL0wZuqR9KSpWIErlQz5IJdOH0I473byS9s4/lzXipJ23z3ITULYDdPbYsvIwqs9k5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71ba156-7f47-4d19-2285-08dd93b90ef4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:01:58.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKKWOPal1XdiJqU1jYTHwtqzBeTrLU7U+wAHODRrGPMR/Jg17b014P+zItReX0NKIUsjwfTPZVMirmSuwhjuNnCITpej9f7JhVKTw2GNpDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505150138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEzOCBTYWx0ZWRfX9Z3ZUhnY6PqE +mqS1iYX3jZVBzKuTNOVv2zRe5Kplz5pxUxaEfITVYDzIIHIU9NBt6nMo9X3YglCqTy/rhCo0Bl hblWMT9TFRNaxef+TNNBITsXG0zsoIGT28I+vUi/VaMAjPhH4oMihsLFlpRIQOjQW9FDCt8uoRR
 x1AIcWysgQtreBZq7dMxl4agKQGuoLGwsztckbVythLmz3xw1ortJ1X91wUNc2q8JQoBv9r223+ 9Hg8QqZOBzd6CKIbbPoaHqRCfmrNWCTjPVJRj+3YYQBYeg2LocnNJKNXAnq7R/xml+YUW2n40Oi Agj8P3jC0nGBt9MSmD9C292H+76yFDSU5IJHBoje2GQyqKHrnXWUba93ru7U+lnK7ch3xRhxcYN
 2UQpvwCISF01cc2qMI4NaDFvWdjTs/KSO1zrHtgCiWlmE/gv3JlAnZIxdMc0W6eEHkW53H3F
X-Proofpoint-ORIG-GUID: FZH49z5P-EjPRjLas5rhLB4AHzEyTpAO
X-Proofpoint-GUID: FZH49z5P-EjPRjLas5rhLB4AHzEyTpAO
X-Authority-Analysis: v=2.4 cv=P846hjAu c=1 sm=1 tr=0 ts=6825f3dc b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=kiCF4cq8ajXqcS231CAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186

+cc Liam, Sid.

Andrew - please drop this patch until this is fixed.

Hi Jared,

This breaks the xarray and vma userland testing. Please ensure that any
required stub are set up there to allow for your fix to work correctly.

Once moved to mm-unstable, or at least -next this would get caught by bots
(hopefully :) so this is a mandatory pre-requisite to this being merged.

Cheers, Lorenzo

P.S. Liam, Sid - do you think it might be useful to add us 3 as reviewers
to the xarray entry in MAINTAINERS so we pick up on this sooner?

$ cd tools/testing/radix-tree
$ make
cp ../shared/autoconf.h generated/autoconf.h
cc -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o main.o main.c
cc -c -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined ../shared/xarray-shared.c -o xarray-shared.o
In file included from ../shared/xarray-shared.c:5:
../shared/../../../lib/xarray.c: In function ‘xas_shrink’:
../shared/../../../lib/xarray.c:480:17: error: implicit declaration of function ‘kmemleak_transient_leak’ [-Wimplicit-function-declaration]
  480 |                 kmemleak_transient_leak(node);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
make: *** [../shared/shared.mk:37: xarray-shared.o] Error 1
$ cd ../vma
$ make
cc -c -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined ../shared/xarray-shared.c -o xarray-shared.o
In file included from ../shared/xarray-shared.c:5:
../shared/../../../lib/xarray.c: In function ‘xas_shrink’:
../shared/../../../lib/xarray.c:480:17: error: implicit declaration of function ‘kmemleak_transient_leak’ [-Wimplicit-function-declaration]
  480 |                 kmemleak_transient_leak(node);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
make: *** [../shared/shared.mk:37: xarray-shared.o] Error 1

On Mon, May 12, 2025 at 12:17:07PM -0700, Jared Kangas wrote:
> Kmemleak periodically produces a false positive report that resembles
> the following:
>
> unreferenced object 0xffff0000c105ed08 (size 576):
>   comm "swapper/0", pid 1, jiffies 4294937478
>   hex dump (first 32 bytes):
>     00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     d8 e7 0a 8b 00 80 ff ff 20 ed 05 c1 00 00 ff ff  ........ .......
>   backtrace (crc 69e99671):
>     kmemleak_alloc+0xb4/0xc4
>     kmem_cache_alloc_lru+0x1f0/0x244
>     xas_alloc+0x2a0/0x3a0
>     xas_expand.constprop.0+0x144/0x4dc
>     xas_create+0x2b0/0x484
>     xas_store+0x60/0xa00
>     __xa_alloc+0x194/0x280
>     __xa_alloc_cyclic+0x104/0x2e0
>     dev_index_reserve+0xd8/0x18c
>     register_netdevice+0x5e8/0xf90
>     register_netdev+0x28/0x50
>     loopback_net_init+0x68/0x114
>     ops_init+0x90/0x2c0
>     register_pernet_operations+0x20c/0x554
>     register_pernet_device+0x3c/0x8c
>     net_dev_init+0x5cc/0x7d8
>
> This transient leak can be traced to xas_shrink(): when the xarray's
> head is reassigned, kmemleak may have already started scanning the
> xarray. When this happens, if kmemleak fails to scan the new xa_head
> before it moves, kmemleak will see it as a leak until the xarray is
> scanned again.
>
> The report can be reproduced by running the xdp_bonding BPF selftest,
> although it doesn't appear consistently due to the bug's transience.
> In my testing, the following script has reliably triggered the report in
> under an hour on a debug kernel with kmemleak enabled, where KSELFTESTS
> is set to the install path for the kernel selftests:
>
>         #!/bin/sh
>         set -eu
>
>         echo 1 >/sys/module/kmemleak/parameters/verbose
>         echo scan=1 >/sys/kernel/debug/kmemleak
>
>         while :; do
>                 $KSELFTESTS/bpf/test_progs -t xdp_bonding
>         done
>
> To prevent this false positive report, mark the new xa_head in
> xas_shrink() as a transient leak.
>
> Signed-off-by: Jared Kangas <jkangas@redhat.com>
> ---
>  lib/xarray.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 9644b18af18d1..51314fa157b31 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/bitmap.h>
>  #include <linux/export.h>
> +#include <linux/kmemleak.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
>  #include <linux/xarray.h>
> @@ -476,6 +477,7 @@ static void xas_shrink(struct xa_state *xas)
>  			break;
>  		node = xa_to_node(entry);
>  		node->parent = NULL;
> +		kmemleak_transient_leak(node);
>  	}
>  }
>
> --
> 2.49.0
>
>
>

