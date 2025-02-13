Return-Path: <linux-fsdevel+bounces-41684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F2BA34DD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FD9188C494
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384F4241691;
	Thu, 13 Feb 2025 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ajFqC1rN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gplmo+Wt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD02228A2D5
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472017; cv=fail; b=nxjCpWD5Y9wwHXdQp8GDE0uk3L7aTsEmGjWH3ngJlrEwApYP1O4WxztCTlzyxzYJjJDH0XRfiGsk/MhRQ8bCKtwSr/8AixsszTjZY1Zcv1INCGY+dfUd1vhXZ4uYJnMtdej79S3M3NcMHFW4CRJ7qKR2qXvind566OMlVEUgZNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472017; c=relaxed/simple;
	bh=rQD0YHHYulbnyBvM2mfb7zu9SoNGOVxAnE3HepvjKyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gfE8OaYD3gyi/fB/q8UY+wtWhcgAL/nebeSPzIGZZRLyVeexGInKwhrMHlaYtolD02039wUhrP4Sz/i6MCmm+Vjunoll4NfiFlOiIhO6aPgXYsrxejlXy7n4+bZQ+ed8ri3yMgrUXr1wzDaQPmjdUb4o3mKfFcN+JtkWaFGRcFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ajFqC1rN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gplmo+Wt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfcHR007619;
	Thu, 13 Feb 2025 18:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=l8lMu80P8AcBidejKoWvETxFLZHKhA2IitudASY1JAw=; b=
	ajFqC1rNCp4sUOmT4Pd0kq23FZaEFHpbSyS6ESAdKnJswM77eY4xCueUzaPLnrf6
	1btxIT2abIokXlYH9MFqkEnhCOvTMq/UpaoAcuAXsM+V0hoS3ivqOU1nhpkS9uf5
	9F9uiWtJGLiw2Kf9ddTE6hy+W0XbPGHPpFt8mv1d6jZDCFTLxZsLlWFwJdFPCir9
	5TRmDZIglfX7Rq3+263kFmeC2HGBHrTMV8auqXDFwLzO1XLklnHHHJcm35JwBabI
	rt8davJ7u2WAnXzKhL59yc0LCHzfQe4A8xtGIMhnAYl7vy5G6LWpwxtR2jWSeGSE
	LpvoF2W3vnMQexzwflf8Sg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tgabb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:40:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIUvD7001211;
	Thu, 13 Feb 2025 18:40:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p632hsqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:40:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inwItrQXK+/jp7Y+WeXYdbSOyUQqSMA0ltl5yf5GrrCcpmAqVzkqY4/9np46mjvM0KusvCHt06lq/meqvl6XIDBO4cAfbBHjAuQQTaux06+QEXTVjcidbSRX9AbBVFnaGdmE2Vm67ZZcwzGfD+YlwppClY5XEaENkT+Bmv8qJ5AhZ2RluP+ChSqBwpIBiwtpkTcuR2Zy01nuPLelId230KQ8DZ3jvVy7o1dWl/4PujsVORX12aEy8baM4RxoksYf43Jzi0b4FXNSyg8qLvKWRf71n4O14L2hJ42e1/TKm1PMc32sFsTb59sXyDwvLYLg8xoAZlOuDEvVRio3DaWjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8lMu80P8AcBidejKoWvETxFLZHKhA2IitudASY1JAw=;
 b=wSuSWCPwSjR3djetqd8kAgN1twtf+vw3TrRCokklwJVE5tf5G67w5zQoTL7iVLAqcb0Pz3TYl2QxQOOhbpKBoiKKZrYOKe1MHG7IJnKL/EL2O/OaohCNjnPOJK6+01RKhGm74VVR8kWgG2ffiapDaUKDttg4XPGBqGrMx6/zhemmDK32K1Pja5xOlrdlPQ/RHdGAA9R64RLJKGN54TQfWlxYCzXwBEE9R6lP+ZGsykyyZE+zHB/fJ5yJlm8iJihYiLXS6fjhA9pxELANnKGJBlhItxWXn2s9VHTP65y4QSTxsjdm5zomY+Medvs5/+4iNSp8yxCpnbRRPacjj+oXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8lMu80P8AcBidejKoWvETxFLZHKhA2IitudASY1JAw=;
 b=gplmo+WtDyyO8IcFO6BPsU31lcftMHzEM2guwMWD+NFQXjU4mGf/wuSUP4zojYc51DxvesogZzfc+R87HO4HRKNBZKkNKsDq6xHwQLGrWI2ED9ffTvGW0XSAJ50mmvKbRsTiN4Dpm+1fIZ2lZDbAuR+X6Ki6noeE8GQoK+1YBoI=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by MN6PR10MB8117.namprd10.prod.outlook.com (2603:10b6:208:4f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 18:39:50 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%6]) with mapi id 15.20.8422.012; Thu, 13 Feb 2025
 18:39:50 +0000
Message-ID: <56ec42aa-3414-44cd-8ae8-f546b36a2c7f@oracle.com>
Date: Thu, 13 Feb 2025 12:39:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: Remove reference to bh->b_page
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20250213182432.2133727-1-willy@infradead.org>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20250213182432.2133727-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:610:e5::21) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|MN6PR10MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: b1868db0-6e52-47b2-aadf-08dd4c5dcc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXZmeWxTakprdTJSNUl1bTB6djNSeUdYanVTa1FQT2FNZlNqbUJQdnhuV09J?=
 =?utf-8?B?UVowRHplRm8zZVpkZHI2aXVLMHdkZUhPcDhySUtuVHZRaHRYZ1lTTDBzejlV?=
 =?utf-8?B?SWtLSDhyMnBHVmNkTU9vWTRMTVhWMmFoQ0lIVU5yMW9tTDdWVGZud2g1VnZn?=
 =?utf-8?B?T2pjd1o0M3diV3NYVmlKc3dvVm10Yk9mRUppSHVGdkJSRllraE4yUHE0Ymk2?=
 =?utf-8?B?b2ppeXhCcjNONFp0dlZUeXdDcDZtWjZEc0VvT3FDL1o2Z3FjcW1iTTVrWnFz?=
 =?utf-8?B?VlFJd0ZmTFVnemM0dEF5dHRiSjVQTjdndEMzejVlcGhMMTAzYzFoZmZFZW1R?=
 =?utf-8?B?WVppSm1oZzVyelhWVW9FNUptUkFrY3ZDc3JGZ2JQb3labjBGOXR0N2t1bkxz?=
 =?utf-8?B?Nm1oT0tsVDJGTjRjWjNaeStMN0VoZEZqZEpHT29vaHNzaVNiYlJWb1VmZy92?=
 =?utf-8?B?RUI1TWtKMGdMYVNyazQxNjJQSFJHaGs5bjVNYkJQb1dXQ2FLUFNmYkxyR3dk?=
 =?utf-8?B?YmtxSTVLZXNrM3l0TGVhV2tHZXVNU1JxY0xpczhwdDJZc1ZYSVF2c2YrVXhW?=
 =?utf-8?B?aU1CNU1HOFdQZk1xMHBrelNkZ2I3MzBoMDFYZUxjaHlVdEo1TTRLZTlWZlh4?=
 =?utf-8?B?d2Q3ajNjYVhURDJCMWNKUlA1UXM5SkdTcjhmc2JqcldCb0Rra1B4S2NWL1pH?=
 =?utf-8?B?ZHpuNVJsUml6KzZTOEZTQXhWWEN1T085eGRpNkNVZ0NrTlQwbUZuaDRrUCtX?=
 =?utf-8?B?UEtzZDZZdEU4VHlVRGswU1YrWjRLazArdnhMaWlkVXplY0VpeENKYk5sTzRW?=
 =?utf-8?B?S0dEY0xPdlltQVhsYjMrSzlZMkZhd3p0YzNpYnlBSmxVZURnNkpCWTNoTk03?=
 =?utf-8?B?ckp4TjRZcTBEM3lFbnRMdWhmRDRBWm1PdkVKbW83ZHpUZ2Jzdlh6TUI5VlhB?=
 =?utf-8?B?QkFTWDRFMXZVeHZ2NVZLN2YxcEk5RmRmRWdxWUt0Ylk5c2hkOHVpcjhEUzhN?=
 =?utf-8?B?K2FMOXBTYm8rK0g4c2xQTVRlZkRIeGhwMWRrUVkyWlB4eUdwb3pRb3A3UExx?=
 =?utf-8?B?YUhucFhZMkROVGRQTzF4VE5QRHBsbjZkRTJpbzIvUFh1clllWW13UnNnQ2Nt?=
 =?utf-8?B?MUNOeiszOTU5RWhua1lraXVUcElaLy9pRkRMbkh4YTE5QnFvNDlreW05d2pj?=
 =?utf-8?B?aWE5UGF3S2hiYTBpYjg0WHJ1VW84QStKMWx2L0FMM1drODZrQzFJVmFlNXVB?=
 =?utf-8?B?dmw4UmNuT0UxTlFOWVlRcHdSVzFLM3NOZlNFZU5vUEZabUpGdm1CRnV2eWpH?=
 =?utf-8?B?RFpKVGFRSUw1bERTNi9WWFU4QXBpMlpBK2VqejhJZE80M0phSElPaVRmWVBY?=
 =?utf-8?B?ZlNrZVNFUmdxdnpuYzVsL0d3ZW1veStodmZnV3lyVUNDcWJHRFRybnM2Y1h1?=
 =?utf-8?B?K2t4YXZiZ3I3bWpBVDBlVDFmaW1xczJRLzk0b2plcFZKMkh3VUFjeFBKQXpM?=
 =?utf-8?B?eTNrUVBLYks1WGlnSUJVZW1CVkd4MDFaRXh2N0cxb09qNTBwT1RyVHJMWGh4?=
 =?utf-8?B?cVFJMFVwWTAxcmZWK0xudUh3Ui9PQnk1SkxHR2Q3UXhjdjlPTXBXZG5DVzl0?=
 =?utf-8?B?SXJ0dXkxVjNZWDRCbmxlVityck5zMzVMazlaQVVSRnZJelZ1c2FGcm1WTStU?=
 =?utf-8?B?clo3Z1ZkRmlUb204K2Q1UU1scEdjbHJUS0NrQzVsdlUrRW1CMTlSZ3ZiZVBO?=
 =?utf-8?B?bXJ6YjlhUjhJdHNHUDVRV1hJUHIxZGR0UlhBQzFqY3QvYzV3ZmYzVHp1eitN?=
 =?utf-8?B?dVJRVDFUVWhzSU1YQWQwQjZBTlFGOHFrd090b3hWQWNkRzg1VzE1SWxDaCtE?=
 =?utf-8?Q?nfiIUAkjyKfRI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmtyLzhBVHhFQ1FZbGg4MXNtaGQwb2pRMHNwbXI2ckZ1Z0FLenhwWnJKaGg0?=
 =?utf-8?B?MWhTYTBERzdzeHExYUNlcU1zdnUwanQySEJJTU9uUmltbDI2blBpR2dWOUZr?=
 =?utf-8?B?SVR1Ymd0eHBla2NTdnpTc2pFZW11bkNEZEJnOENDRkNxVVhiaXIzZTBJeTRU?=
 =?utf-8?B?RW5kV3BjdHQrVW9pS2pJdmtCY003Wi9xdEd1SGlERWdkeGtsOWYvNkdjc0xT?=
 =?utf-8?B?SnRBM2syTlRYenlUNHJIUUVDcGR4MVBXR0UrWnR2SzJyZTBmTTRnZlgrT1dU?=
 =?utf-8?B?K2NPU2xsVGRxM0pYcm5YYmpjQVMyVnlxV3Z3QkNPUzd3ZVlTdVdJL29ZSURt?=
 =?utf-8?B?Sm4wOFVQYjRxQTQyVVVEbnBNUFJVbjBwYjdUdjQ4eVRPa1pDTEYycDMzbmJI?=
 =?utf-8?B?cVBkR2UyQkE5VjdEbktIK2QxQ3ZFeEdvUUg4eWNUb0wxbEVKb2N0QXVxcERB?=
 =?utf-8?B?eXJzMU45Tzh6eGRXSnQ4RWVXaW1kNCtaVG5WdDZuR05OZW4wbklJQ2k3WEI4?=
 =?utf-8?B?ZVlxNFRscXVJRmhGMXJZdTlDSkk2R3daenpPSE1mOXdDcTdqcFVhUTZNT3dr?=
 =?utf-8?B?ZE9nRjJEc1EyU21HeDcxcldrUlBUYVFSM3ZKeEJZZUpTQmFxVDR1aG9oUXNT?=
 =?utf-8?B?b2RTSEpvdU5idWF3QTEzeUtaeWdrTGVpU2ZIYlRsY1IraXRpc01wQXVJTTV2?=
 =?utf-8?B?RmFUT1ZqRktLVU9GQUFIOFY4ZHg2aEZrUkNtRE9tS3F5R1JMY3BvaDVhTnN2?=
 =?utf-8?B?WUE1Z1JLN2d6SEZQejZFWGdpU3pJYnZ3Z0JuNHU3N29PZGZaYkpNd3J4bHRS?=
 =?utf-8?B?Vitiei94aGUxalhxZm1sVjNBUm5TZWlEUWh2OEttOHhBQkVlbStTNzBIOXYr?=
 =?utf-8?B?SnJ6ZUJDSkdGUXduWm94QnlCbDI5Q3lxMDZhK3dHMGFQc01zM2lXTzlWNFpG?=
 =?utf-8?B?RFBwK0JzSkMvdW9JS3B6OVlyZEMvV2Q0eVN5N3hKNGRFZ0haZFhUdTZWS2pX?=
 =?utf-8?B?MVpNK3RORWxKb1hzNWFINlFVcWcyK2w5QmxTWHkxdmtIOVMyOUNFalhkcGdy?=
 =?utf-8?B?NG9VWDdtelRjd042ZnNZN0tHMC9JRm50Z05VWXpqcmJYSTIzZ25Nc25LM0x1?=
 =?utf-8?B?Rk5Gb1RQK0dEQTVWaHo2ZXUzYVBzWW5ZNStEbXh6MEp0RUp4YklJeWpWVjJC?=
 =?utf-8?B?NTJZSDJEcFVjV01yWHA4YWRETUg4N2J4YmJxOW5zR1dETC95bGpTbVpPOHRi?=
 =?utf-8?B?bWN6YXZOT3NyMUo5YU10Y1hpVDZsOGdCNmhOTkZlaUc0aE85eVNkdXJNc21y?=
 =?utf-8?B?MG1tQ0hzMlFQUlUyNGFBaUNrSEVWU0ZQZmdxSnlEa1VJV2dVK0htZVJjRVU4?=
 =?utf-8?B?T3BZUUxoT3F1T3pjWnpYYXlNKzNUN3VMTEZTUFc2ZkM1VGs1cmFNclJURW1Q?=
 =?utf-8?B?K2REMDFZMUhsRmpBSkdWRTFwOWM3RUEzQmlLOElEdTYyRzUveWpra3A3WFJl?=
 =?utf-8?B?eDVpVnpocGlDYUhDbG8ra0xGa3hTN2w1a1c4TjU4YlRyVUU3R2hXdm4rSkFN?=
 =?utf-8?B?bE9rbm1oNVZCVEcyMDlGTVQ2bDNCUmZCZ0o4V0JITG4zaGpTMDA2a0RRS282?=
 =?utf-8?B?SDdtYWlWRHNNQ3JuNTdHdHdZWW1JQnhKT0s2dmpORUFZUm9OS2R1MXdCbUpY?=
 =?utf-8?B?YW0vcVY5TVgxWTljWXROVXR4eUUzMWJIRzcwQVpXNFdpK0RWaG5MNEtmamc4?=
 =?utf-8?B?L2Y1eHdrUmdnWVcxSTlMVVJ0VGdpNUVBdXJkc0NRditRK0lnb2xnQWs1NlFI?=
 =?utf-8?B?U1FuK01qYkxESERLRndpK0FtZGtibW5KN0dGR2VLQlVWbURmSURyNHUyc1ZF?=
 =?utf-8?B?NG4rdzcrajJHa21BZ3kvcTFvQm0rU3V0RmtZZ01FL21ia2ZTUUExVWFLQ21G?=
 =?utf-8?B?ZUNtV0d0N2JpMEZ3MUphdytrVWd3eGpBYUpNVko4S0c1NG9FZkNyZTBUUTVK?=
 =?utf-8?B?cVpXZVgvRm1HaGlBTUtiTmFUT3V0eGNmdzgwcmVydThrejZMWDN5TUh2cm9V?=
 =?utf-8?B?OVNkUnJBSGlpQUFvZFh3ZnYzYlo2cGZHY0l4OWpmRS9ScEZaME9ZTi9wUnRh?=
 =?utf-8?B?U1hGRTdnVHIwamhCYUNEVmg5b0I1Rm5DcExudXFhVVZUV3pSTlNEaTFZSXlG?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b0cLKJAcxF1FMdyhUMkw/fuwyyibVAz4NXaMjynMTL7OeFgccvVmtN1QxIu0tsiXMJcqWKWYzqaHRoY3EZ/aN9JQPq/qcSmDc8Y1nzdY9zb9lfXZJ5sGMYVPsb+aGHrYpOteBzWYq42DY5NJ/EX0uC1iyyYNXFRKB7FKEB7ZvfjlTIDtnFZs85VJ4b1Gv07HwCdLDbZrG1xYRrbKy+eoRWEjgouqDlrVS+CrGydfNfsHMtI28Zia54yxgWvPxjk8KTH7gEV+anA8WK+92PrWaODU9ht9gctL+C5P6/BBPRZrtfFAAMuoJPgFhpiYo3Z54IOAkTu5kk1gSd9J05iQzrQCA2FMbRJPP9nWvbltA+SJqj2jBSH+KKY+E6YL/R3k8QbBDbPPHx5pJHEef7OTpzFGepGFO//sZJEjIXVaUYDwxWxKJXUkcGfZ9iwRgFmpDdsgs87dOUPc6zXJC1EkSHCnCsNq1wWWWZ7cjOOYt3cwOkmF/nWGjJwuvHoqia+w3wK/qd5sHsP2b576tLUUMFDbCVdPXpI5Izn9HLQ9DwwN4hFZAdwK2SiJi3+gJZYcpKi2ioSgKBvJ+8WGIiA/wm42LumJlLA8mqGJrRIDcws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1868db0-6e52-47b2-aadf-08dd4c5dcc6e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:39:50.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm/yQRijv9eqg1jdnj+4V4h8T+2qFuXGGIoisyvPE9U091qPoQeKNi3ZhLTVrzoq/l1Hg3wBn2nCrsqZzMbptSlSZbfIlXrtqIfOkGacNb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130132
X-Proofpoint-GUID: uROel9fmJTXpsDg2_Yy6JBvXSpdT9dEN
X-Proofpoint-ORIG-GUID: uROel9fmJTXpsDg2_Yy6JBvXSpdT9dEN

On 2/13/25 12:24PM, Matthew Wilcox (Oracle) wrote:
> Buffer heads are attached to folios, not to pages.  Also
> flush_dcache_page() is now deprecated in favour of flush_dcache_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Adding this to jfs-next

Shaggy

> ---
>   fs/jfs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 223d9ac59839..4bb42de33865 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -766,7 +766,7 @@ static ssize_t jfs_quota_write(struct super_block *sb, int type,
>   		}
>   		lock_buffer(bh);
>   		memcpy(bh->b_data+offset, data, tocopy);
> -		flush_dcache_page(bh->b_page);
> +		flush_dcache_folio(bh->b_folio);
>   		set_buffer_uptodate(bh);
>   		mark_buffer_dirty(bh);
>   		unlock_buffer(bh);


