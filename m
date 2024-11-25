Return-Path: <linux-fsdevel+bounces-35834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEB69D89B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 16:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7CCB3C87C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B031B21B2;
	Mon, 25 Nov 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PO9kBGfc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ClautYOu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB411B2194;
	Mon, 25 Nov 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546774; cv=fail; b=KtPibL5+yDkWqpEdZUGApkRZ5oC0OtlHnXG11HbJOEf3PYcBsA0yQLq5fTfXoLZlBTJS8mMqLv02q4SyGXI1tuB64yOQ25QW6lRvia9tUtMfCW18vZa6N2oDC7PVNXSeyFr4m+oXtjGypE6F7R+0uwGM0VTieRm8E6Sdy4GQPT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546774; c=relaxed/simple;
	bh=5EkC0Un+SCtOyB5ogevU2axqvl3N4tVdMxOiy4V+4l0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AvSIY/gSOXEUXcsoYxLKINRp6swXR1dY81XuzxhfkZ/Vtet0O9tDu6dfP/xAIZXMZUdme+3bBQ5GERXG/2w4DsAKv9beBNXEfUaT0yuUnobw9DeJylU2s/M9vf2QmluRza2xXxBtiVfzuO76HC/7+ztPKIVP3aUasLyVA0NuT4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PO9kBGfc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ClautYOu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP6g521032702;
	Mon, 25 Nov 2024 14:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5UOT/4PcuoaJ38VPVuaTJ8G/4HjchAo0r7g2MSF8wK8=; b=
	PO9kBGfcjgW1VlGh0kPIyusp6qA9c+11kqR8GLLZUEt9O3UkIF50a7wWRJwfgbbK
	D5/SfaAZ0dPOexJuARIcjVACJz1bwNsIlxy2Uv95HBkVqwv4kepSoY4VomYO3NQA
	QiOVbgETjjYGOfVWaGQupWs7uoi2bLpenW7bLiZ5ROgYcOLbm0MCJljSg8DcgG82
	+fOL3X9HGGlkLzb1XUzGUtYlQi6Cm4j1q36Qtlltd5A+ZHKFQznIuwHYugJOAaF7
	C+QExnC3jiqlZ8vTkHDL3dvKXFyuAWR3Ur+NBb6vBLq//A1yspIyILpcWMvOf3NE
	fNoI0imKYwWc1NmtSLNf9Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433838kbbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 14:59:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APECJSt027070;
	Mon, 25 Nov 2024 14:59:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335ge0bhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 14:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+zKSNjTOqiJF44mP1zIJK4F0S57oR9DfqJv6ZTZf9b5ON90uJC40V6A14YZ3GtgVgs90kv6JNqycm5WtphjhXJs+8asvp/qBUpLt6AXM7r5dfeSDQyP5/ypblrTQH0/zd8UjB/DjaMHSP5+HzOAJjQ9Wree2tCVmAY/6SE5k8mtdRtemipaQjwX/5nIp1ne0jCIz8EjmSgJRhCcvOrqSUXI5B1WN3xdJTBE7iroKjxFp5BvecwFtM8eZITCfUvsrOFE8SptmNW7rZT3UXTEJ138bB9ShJKDL9bF9Nk5ar35UiQITtDB7GdAROojEqXQcc7TT6suOHn0yVdRjAA4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UOT/4PcuoaJ38VPVuaTJ8G/4HjchAo0r7g2MSF8wK8=;
 b=TiAnN0mBlA/Z7mzUOl78apFhji7Etva8w4nfGkH2oKeKe7I+nvUDMEnn/CtxO1ErYIGluBAF7uYncyfBBk8qH2pjJCpGAydRfa7wbBGifubPqQXoqqrWE8ZkJ/+n4rbHYwQ3jzRXngx929MMWwaXEVLgt1wA0haN+o9XY2G8rL3aSk1Sh+qKKcudN/XsRenuoWKcmQsqWA5aGZNlSrIr/kQexU6eaLMfU92lgIEarMf1zwaCY+x1agTKD5Y0d1wCJv9H5c5W6rI3Sux786MKCf0rttZKfYSSYq6sLs+6TJL4ceGLt1x1g0N33ftX2mSXb/4i0di6g35CV1WqOO3doQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UOT/4PcuoaJ38VPVuaTJ8G/4HjchAo0r7g2MSF8wK8=;
 b=ClautYOuMuOorBU5ug6Oo/zZnS+/c4xKPS/4rNiSPU0oem5dSk8yp14yFYoG7bw8IeV4jKDy8Ij22Z2jzzWFch7cabOaacGLeF6hkDIQoMY0OXsMYMdBnmFzv2RugNTcpX2Q69LnDXy5a4IyWW+z0z5r5lGvHUn7DIRYKUDn064=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7916.namprd10.prod.outlook.com (2603:10b6:408:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 14:59:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 14:59:17 +0000
Message-ID: <8ccd30c2-4902-4948-a0fe-eb2cd9b1e7c0@oracle.com>
Date: Mon, 25 Nov 2024 14:59:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
To: Alejandro Colomar <alx@kernel.org>
Cc: asml.silence@gmail.com, dalias@libc.org, jannh@google.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <Z0RTHYtaqEoffNrG@devuan>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z0RTHYtaqEoffNrG@devuan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P251CA0009.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5fe18a-5cdb-4cd4-fbde-08dd0d61bbd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0xFVVkwZlhVQWxTbWF5cVFEUTB0OENtVVRxYlVaOWtaTFJ3ZzhnQzBabFA2?=
 =?utf-8?B?RDdEdzdDUG8zTkNvaUFUb3V6WXVRcTZwUFNUSTN0c2RtbEpXY3dQN29BakdJ?=
 =?utf-8?B?NGNheDRLa3JJMmZpZDRrQ0E3NWNmTWZ0bm8rc2Y1ZzRURCt0T3kyRGkveXVu?=
 =?utf-8?B?M1p0TE5Fc0FaalBYVHZtaThzTS9PSE1ZaEgzM24zY2NOZW9FVFpTaVRTSXE5?=
 =?utf-8?B?NW14dnRET0E2VWppUEhHMnk5NHp5dzU2YThacjVFYmo3c3E0aWdDSTN4SkU5?=
 =?utf-8?B?NkQrb2hsSDhScUdQejNFUmlSMWRMN3JZcHd3dGFiWmNuWjdDWXlLbThNOWs3?=
 =?utf-8?B?cFhQN3ZGR0IrRkkwSS9XSEZqMlA3TUlWYisxSThtZDhqTFgvS1BHeVlJTXJQ?=
 =?utf-8?B?bUtMSjZEcTFpdzRIN0J3Q1NsYy9DaVVvVWNqVlQ4Uks1a0Z6alloZGMrSURH?=
 =?utf-8?B?a1BWNTc1SmRPYUdyS2gwSHJvTWtaZjdDR1VTcFliVzQ0aHkzM3ZRNUN4MnZm?=
 =?utf-8?B?UjVXS1BnWGEzWWRHOXBMNTJpU2lZRWE1WUM4WFZpYnZJdklwM21TS1ZpMkFI?=
 =?utf-8?B?VW5uWmZITXpHbG1PVWxFc2dmOThTS21hWUtMLzBxL1VZSzFyZGIyNC91ZnFH?=
 =?utf-8?B?em8zc3VCc0tEVXVIcEI2S2FTNlo1VE5Wa0R2TnZSRE1lNmlGb3pLYUsxV3M5?=
 =?utf-8?B?STRucTlOaEllSGgxQm9tWG8rWUNJTnRrT2lONmNMTW5OTE4vblZJS3U2WTVa?=
 =?utf-8?B?Q0dGWElGMnh6WFJnR1VWYkNjRFVaRGsvMTV3M1VpQzdha0RCQ21UNDRINWJI?=
 =?utf-8?B?d25OclUzcXpCalJqQkJnVHpCSEJHcGpRcks1bUQ0cmlUTmlSL2NoOXJVUlZq?=
 =?utf-8?B?UE9iaHpkUGFYSzRDajVHZ2xuTzk4VVNVTENJZUpYcC9QOUNJTW81Tmx3bkxS?=
 =?utf-8?B?QUQ3cUhLanZyT0FxTTJySWhZZk9iSjhnd1ROd2tDZ2JLaWZ3TlZJcHF6SDd5?=
 =?utf-8?B?dmFXUFpNeW9DaUlRUStIemZrSnV5Z014QXlQRG1ickZzQXpZOXR6R2Jhd1NM?=
 =?utf-8?B?RE55OG1FOFRwVUhoMnFpYUpRbm4rOTJNNFBpWTk3UUlSNTJqVDNpRGl2QUNR?=
 =?utf-8?B?MDRnVHRVWlk5MmRVdDVZQXdOUEw1N24yOHl3WmRHaEMyVS8weVpXUXJmL1ND?=
 =?utf-8?B?dmxTV2FVb1MzOEZSUTNzMmI0VXZnRnlsWE5aTko0bkhNOHNsWTBDZ0tOTmFT?=
 =?utf-8?B?eHNmUjJRa2RzWEtYWVREWG5meWlOVWpEd1FDYkdXMURWRi9FVUFqMzA4NTJz?=
 =?utf-8?B?cksvRU43dlVmc2JDUUZMNkNHZHJTZmtyV2RJR3JUWnJhRCt5Y25qWjZSaHcv?=
 =?utf-8?B?dlQ1ZXJSUGlaZmt0ZVR1a3EycmZIVXVUTkJOcm15dDVuWGoxcXZYMitOeENK?=
 =?utf-8?B?dEpqa1pIWk8vV21jNVdUekNITFNJbUw5MXBHVmdKY0xuYnRGV2l6MzhBSGs3?=
 =?utf-8?B?VmJ0Y3lKUDMvSTFzcWJmVFBkTHBNTmphMDhqSWdEZ0dBcDRqbUE2Q2hyUG1C?=
 =?utf-8?B?bVlLK1EvS1BmT1AwbUs5MlZMbC80eENEZzZERjdBbVp3R2JFRWdSd3NYZ0xm?=
 =?utf-8?B?U2xiK2JlRGhDVmpLNkJoVS9Eay8zWFNQZVM3MUl6QmdQR1pFZThlWk10U1po?=
 =?utf-8?B?QmY4S3doZ0Y5VmZGZkxRZTllN0NSN2t4WWlnQm1UM2NDbDk5SHBTUzFPSG5N?=
 =?utf-8?B?S0dYakE3Wk1ObnRKZWFZNkxsZjBMUmtwTWQwZVpNVE9pVkM3bTBSZEpzNmFO?=
 =?utf-8?B?aFZWRGJOcDVTbDBRSXdkZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHhrMm9pU1VTWUhCLzk2SWs1RHR4OGFYME1QSlBzdDd6NWx3S0NPbmZIeVJ3?=
 =?utf-8?B?VHhJRXJoMlhxU0RKdzhQOWlLQXN2VCttMlpKZndHVXZpUUdGOHlkZ1BDemxZ?=
 =?utf-8?B?OHcvWC92OVNJbzgrdzBmK0x0alhGN1VCWWRmZVlpU0l3R1BvY1Z2Uzdmdmty?=
 =?utf-8?B?dU9jOEZ4UnhKbkVIS092VFdpcjRQNDFNTjNxeGI2UWN5aklMY3FINERWSlFy?=
 =?utf-8?B?TXlXdEJsN2ttYTRjOEMyWmJPc3dLOUUra3JyMkxnK0lwalBJT0s0Lys2ZDVU?=
 =?utf-8?B?RldxelZlUVVXR0RWN3BBbWJDUXU3SkVqazByeHFELzBPTzl3VGZ3TlFiV2Zn?=
 =?utf-8?B?S2I4V1Z0ZTJUdThWQ3hkdEt2Q0c2VUVIbkkrWkVqOExKTHlTdnFRNVlwdUht?=
 =?utf-8?B?SmJlbHNidmF1WXJNVDFjS0JLVmw3U0lzczYxMEtZUXU4QVNhMkpFTy9NU2s0?=
 =?utf-8?B?NVRPVHlmY0NpTDdrMWZ6ZUladXZ3Z0QzWXA4ZHNZdkRtRUdzbzQvNmJlWHg2?=
 =?utf-8?B?bmlsUmpZWWFMb1l4SkNQQmY2SHUxdGZLcWdtU1l6eFFQei9UN0Zmd2Q0WmUz?=
 =?utf-8?B?Z1VhdU4zUFR5aXRGdmJLMkM2enhDY0xhcWZqTEgvcFpVWE5hZGhjVjNza1lO?=
 =?utf-8?B?TVNqS1NTaStLdzRHRDVIN3hjbFRUbTdmZENZNnJMRGUvVElLYWdJR2NwOXhv?=
 =?utf-8?B?U1ByRmZleGwrNzQxZVlRQW5MT0xoNnJvckVSTlB3NFdEcDdDcXR6UVIzNEZ0?=
 =?utf-8?B?UlJFWW44T3ZidDkyTlpyL1huNUVaOXlSdXU0RWxEUVd2WHZHZ1g2cE9vYlUr?=
 =?utf-8?B?NUw5WWxMYjl5VVE4RzNKRUIwWFA5cmJnZ0dzRWowbE5PMWZDZFVsM0o2MTd0?=
 =?utf-8?B?ZU9Lbm5GUDRkWkdYZGNZL0ZRK0ZSeXR6dXVkQjNsME5lNFNkMXAxUDBpSDg3?=
 =?utf-8?B?K0pkT2VRZ000S2lHNmNaWi9LTld3VVFjRHZPSnZ6dzhkTTZlWmUzTnZUZ2Ns?=
 =?utf-8?B?eVgvSkRUMkdZZHBOUjQzYksvKytRcXFNL0w2b0g5NnF6Z201V3FCTk9FcGlv?=
 =?utf-8?B?NE5uejYrOHBjZVAzamgwOG5MZ2paTWRIZUhWd1lmelZnSjZ5S3R1SHI2NUIy?=
 =?utf-8?B?M0NFRDY1aU1MdnQ3aHhmcDQ4S045TzQ0VFpmdmRYZC9LM3dVVkczYUQ1Q3Ft?=
 =?utf-8?B?UjJwVHlkbVMrZThZWGZXMnVQMHgrdVlsQ1pMZFdyZDM2LzFQMERCTWNwSFo0?=
 =?utf-8?B?eG9DQjV2RUhzMmJ6VzdaOUhzTnZQdjJhcUxNeU1qdHN5YjlwdTFOdkRWekRK?=
 =?utf-8?B?NXpsZUxFZ3c1SUZDcENtV1JWMllQSnVneVFEUkhUUUM0NlRIdDk1V0pEUlVv?=
 =?utf-8?B?U1lLN1hsTVBua0VOYXBYSjByajdVRlgxd3JvUlZnc2tCVFBRYnE0b1pNOVVi?=
 =?utf-8?B?TkFjS2R6ZEkzalNhang3WHJPajZwMWREK0RFZ05rT3pidzFraWpGN1BNUDdl?=
 =?utf-8?B?aWRGd2ZRWTZLbUg4R3FlMXhxN1U4d205cDFEVEpqZzFldlkyeUMzRXgzaW51?=
 =?utf-8?B?R1VYdmFjeHI1ckNuRG9tTTVMVU5ESGVGbzNSUVY3WDFXVFN0RkxXZkhQTDd0?=
 =?utf-8?B?M3AxbUwrOERFeXppRGNoUVBrVHRoTTNjbjR0cCtDdFc3U1JvMVZCK0tvbHlN?=
 =?utf-8?B?dHlSWlJQbXRBT2c5N1BJaE5hWE9aeXk1WS9wdzhLUUZkaFE5NU5JM0ZwM1BX?=
 =?utf-8?B?Qm04QW9jeDBuNjNlQ3lHcHdsSU9jQWhIeFRLT0E2WjlQUTZnWGwrQ1Y3WW9C?=
 =?utf-8?B?b3IxVERvUUN6UEl4Vm9YblR1TUdIRHhLdkFqelR5dGorclg1aGhlMEJNVnB6?=
 =?utf-8?B?ZXU0Zmw4SlBhTlJxWlE2QUFUd3RGUmFiSFk3b1FrbFo1d2doS0VVMERGOS9K?=
 =?utf-8?B?YTlqNmc5eXJQdzlVTGlkRThaaG81a1k0dHo1Y29JcFU0RE1lOWUyNTF0VTZy?=
 =?utf-8?B?V01aekc1VkxlQmsybjJuYXF0T2lab0VITzFSczBDRWdBNGZKZUtaQ1NSWmtt?=
 =?utf-8?B?R0Z0TkR0M1NDRXVYMHBOQys1V253OU5wTURzQStlQUQ0V2NWams1aXBYODIy?=
 =?utf-8?Q?SXR7njdsVF/UxHd9ZjNmaZBU5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k9IwZ57we7u3qXTBjqEqKsJoGzBfzssWgZbR8zPV8Jsz8IciDJxdQa2ROL1fdHXLB+LZLFtfCbI0tsiL/9Yr6i7vurexkTuDnADgejKST2zedt1FvrF7XfuSpI1uFUHqoeAuSUQZe+5Wzlz2jw49TdTbUwQhUdCGvNcCmr6Zom67sEDZvlQJEEf+pmGK1x2OLuOsToQHqKaleTsJThTSFr7feZoeVHBS5m2+6uzzzIM5kxqF5r4j21Ur3/Z5tNBqxj9V7j6dY70M+PdzLC1e+/2A/MfW6wJutIjjRwuDb7N4RWY2HmlkAGtkT1L1wweWxOCeZECNON1eA9ZYwfzK1Cwu87s+4IfU42FQzPTTydUVvZtqBX8eJQk98gcrHwSiv8tioNrgjxGbmRXuPVin7MFhsLgak9bGQk7hFoinQ/Ri6eZ9vqh+Fh+eWbyPu2caHggASYklqs1djDpbP+/XL76feKOrymo3KnywUGt44gcSC1E6i6tMdW90Wxh0A3We4Bqf9/Osh/2wwXrERVFtZrng38wO82smTjtxSgsk628rrT2QAXFAU3T9HThEOkIKpyBcUja2gVkWd7EUMOTCz8NhwXL2yhvDnZZAaIb17Ps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5fe18a-5cdb-4cd4-fbde-08dd0d61bbd5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 14:59:17.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALWXQwgN9fgTKD0XuN9RlMdfyHIqrdXkolVi8mip8otdAfP6oDMsxVfQ9Hu9gmMNevIwt47yVlOF/vUVOK7ruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_09,2024-11-25_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=872 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411250127
X-Proofpoint-ORIG-GUID: DazWtu1PsOBfVNWDaBRvCsVid5xn16k5
X-Proofpoint-GUID: DazWtu1PsOBfVNWDaBRvCsVid5xn16k5

On 25/11/2024 10:36, Alejandro Colomar wrote:
> Hi,
> 
> Here's a gentle ping, as John reminded me that there's no documentation
> for this in the manual pages.  Would anyone want to send a patch?
> 
> Have a lovely day!
> Alex
> 
> 

Nobody was forthcoming previously, so I will just send something. I am 
not too familiar with that flag, though...

John

