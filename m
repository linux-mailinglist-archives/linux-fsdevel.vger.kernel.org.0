Return-Path: <linux-fsdevel+bounces-54856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA80AB04066
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C9C188FA53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06FA253351;
	Mon, 14 Jul 2025 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MO28Iwqd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ngd1fAPO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79E1F91C7;
	Mon, 14 Jul 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500422; cv=fail; b=BkZ6aP2ZQe53+NPuUd1BqdNznRblwsm3sy3cbXQ7PXWI5Q/hzQ8meEAq+rNhOEukUXRCV+hAeQnfKNlpDuoiR5omu9vkhGTydaZAgNcM2PuyKR0r6/UXrkew6Ck9LrGPstB45tGVwLxX4ZdHWDLrlDgWO5s9+zkJp01SSfPiHjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500422; c=relaxed/simple;
	bh=h2W0KP3/cAEMnKKl9ZmnpCPpIZYhykM3fLeAIjNtmyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZjisTkbedNxDxB+6Lf/hM0Nrq5vwLXm3A9x+I1yyDChnJzISJBoag1UChj9RRIwGDkzO2o3ZjQxaS8vjxnglh0C2IkLqvXbe1kjbDY8doJg2DZ8CVFRW6YbuqE1KWCrUUSWdq9jOS6jfw2RWAqHW/LuLj2VpC+P51eTwURuKph8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MO28Iwqd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ngd1fAPO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z3PN026780;
	Mon, 14 Jul 2025 13:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hD1lSYb8oKDvqQ0mqMQDyWxLP/Pe2L7hRBZtMAaq4Kk=; b=
	MO28IwqddtCubJ/ZCn2InOgunb6iicJ0Vn0Wi7uR+Hjqr03TxZ6e9smCAnbOSDty
	ZMEJPijSQ6cKlG7Fnb+cCVetYBX84+Yfqp5xikS/DRJICA/AFb8ZCDS13lSlhtv4
	vjnZw8SW/XTyLR2tAOPOh2jMc64UNyySbk42HF/uXtD+eQGrcFAif+MnIrtrzhCV
	aJv/d/BvPTiYc0Duoy8t8ZlAWn+Z5IYlV3DZLnJNn1le3Y+Nq3/h4Br37rA+gDPQ
	ayhvhvwiSKyP5OF3fK9WGUpVS0U4RPHhvJqIe2xJSX4TLMVKDVuwnlas4p//xByA
	/6UPh3UdnU1Qr+1O2kk9TQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf4gst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:40:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EDDgdj014046;
	Mon, 14 Jul 2025 13:40:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue582e94-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4LxQtn13JXVX6R8zAjtSuu2UbNJ2QeEyjyGcDLegyazgYhobu/447b4qYhUyOvna028ZB0x6vf2Is3Aw26c4yelMY3RmsSHM4FaZ+Os19Oh/fiotZUlPi+zX8EMZHS+cCtMp+UsSPiW8ljhuoIiixznjlc9khttQ4upo0mcSyJyAoPFUwYkOXpgR01harYGfXBGwnFZA8UnufZaAVfeQ+X6Assp66P72RDaT/5N4ie3Ot767uXqzpkSIxYJLNd6qJZDhYi9xrkTp2Z8Vp6ifop+rNPuIYSOo/rWOOkqT2l3MVVMOPaDpfv7mEne89JQlOr3908LugJKpCfIcgGlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD1lSYb8oKDvqQ0mqMQDyWxLP/Pe2L7hRBZtMAaq4Kk=;
 b=jzWnbdDNwqtyQDeqoFE52Z3uSV0dVmcj2+7W5OAEHqJafP2Sx0SnYcMRB3888O2VwaYN5L8I85MQQPnwbyRIyPRz4hettfYCj1EtOOj3fVjclyIHwXCrvMrMmjtJd2h6t3XbzWYC3DKv+MVvQcD41++JS+tjBhJMvmUA+sFJ54YrCLbgmUqGoq4AOoXY7Dpm3wArbqekQIa/xgP0MKqTyyOK4z43kcv+Obu+H1WS/VF7zVMyUqyPY8OJCJpD7DXmN3i+elEkT7GCURM+g5DGT9jH7sIrHZiy2zSLluveGKcmVuiH78AjumNAZHMso6yMv+wnmPWoXSU0ecDm48YwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD1lSYb8oKDvqQ0mqMQDyWxLP/Pe2L7hRBZtMAaq4Kk=;
 b=Ngd1fAPObpu7b7jfte1v8939nKSSYTAp5oPXzU8fnvHBRc1Y36nJkdzdUpOHG21uk9/YSGrdU9fRmJSvTFxmsYf1mfzABKrniqX20LnwYuR2TMlyFWxCt1dfv/p354173w16iUkF3X6Qtm6w4LUHKPw14I+DvT43fvVIQ6Mxzis=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BY5PR10MB4323.namprd10.prod.outlook.com (2603:10b6:a03:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:40:03 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 13:40:02 +0000
Message-ID: <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
Date: Mon, 14 Jul 2025 14:39:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250714131713.GA8742@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250714131713.GA8742@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::12) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BY5PR10MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: eca78fb6-d9fa-435d-d79d-08ddc2dbef18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG0vUEREVExXeGhUVmo5K0tmZU40cmd2Rk44eXEzWmlKMXZXNSsvcWRjUkZH?=
 =?utf-8?B?VmVYWHRldUlkM3J4NGV4TnJ4TE4xaUlaNVRmWUJVc2JOd29ORGI4aGhERi91?=
 =?utf-8?B?cmZBdkoxUmNHMzg1WVhBUkRSb3diUWpwMjYvNDNFQmZ4dTd6VldPbU1KU1ZI?=
 =?utf-8?B?SzdycVlWcEtHaG9iTjRoYWlkd1dmQnpBSTd1TkJvSmRCK2lhSkR5bW1CMTg4?=
 =?utf-8?B?RVI0QkUySC85M0hDTTAzaUQycVI4NU9VMHJoRWNPUWJkTm1zQ0dycDd1SitG?=
 =?utf-8?B?WjBMZktFdENjeCtoRWZTYjFnVTZ5QjdPekVieXMwSHpXSlh1RXpwSGtKSTFz?=
 =?utf-8?B?UlhoVFFheWdzTDVyRmpwOWs1YUhRYlJLWUt3WXJiNi9wZU1sZFoxMnFjQXNZ?=
 =?utf-8?B?NFBKTVFhSi9SUXloUE5mcisyVzBIaDJSWjc1Q2R0R3ZVcnRyWXhVZUhrSEZN?=
 =?utf-8?B?aWpXSDM4VFdqaHhFZTlkRTAzU3dKSjM2czYvbnppNS9JUVMvZ1pXYkpoSThm?=
 =?utf-8?B?aTdWVEZqOWltcU9OdDM4TUlNWmZGYUpGRTIwd2grMjIwdWtnUXl0QjZQbnlE?=
 =?utf-8?B?V2xWZG4yY0E5YUVDbzNORFc2eVdoUWR6NHhEV3ZoSjBZVitMN2NHcm9BbnNF?=
 =?utf-8?B?YUNRZkVCNHBKOTE0TUFhRTFJTE50aGl6WVJtOE5TaFJna05ma3ZpN1orL0hz?=
 =?utf-8?B?SjVlb2xtUUMrcmMyK2xiTW5sZXN5ZmtmRlRrSGd4ZllvOG1oS2UyajNXSjdF?=
 =?utf-8?B?aHY4Q3F0cUtsd09kSElvQXVTajlQZzUxVExYZ0hIcndYNWVQZWQ2ZldOUFBo?=
 =?utf-8?B?WHJNUTBqZmZlWjFzSlhWN1MyT3JpSEpNNEc2Zkt5Z1lKa1hxTFcwd050UnIr?=
 =?utf-8?B?M1ZjVVBCaEpNVFY2SkNGcXlUNmI1RHkrWitJTFlVQWMvUW9jQUd5RmVLTUN3?=
 =?utf-8?B?SUd0czQweDFMNVU3U1Q4QjdLeWZMT3M1cVBiZXUyamhRaEkrM0ZSQkpMVUYy?=
 =?utf-8?B?Z0N2RG9rcUJzREJUazZ2ZHVWaU5iV0dRb0lMM0xHSFByYzJROGR3eDN1Qmh3?=
 =?utf-8?B?MDQrU1h0ZUQvNEpST1RxQ3hwRXZodjNlbVdsdHRwYzlPMW95clhlU1NoaEtp?=
 =?utf-8?B?d2xLY0UvQnhMdm95eVphTU5keS9ZU1JEV2xQeW1vSDM3ZmI0UWxyWEZ4SDJZ?=
 =?utf-8?B?elZEKzJTNEx0MnF2S0YvNlIwaFRRbkh4OTZKd0JHMHhQK3RCVzhmaVk1alU3?=
 =?utf-8?B?cGJGcWlZVW5ud2FhaUQ3V3JWODJUNzc2amg5ZWd5ay9Qa1JBVXVBdG9pYVRI?=
 =?utf-8?B?OTdQY2NyNmdzZlNQYjJpdEluMVZBUmNsS0ZmQy9nYUs0bEQ1NVI0MGlOb3dC?=
 =?utf-8?B?Q0JNYWRHdjQ2aEhIWnZqc0NyMFVmNFRsQ3h0VnF3cUo2SW90Mjc1bWdJYUZU?=
 =?utf-8?B?NVVjbDdVUWZKRzUvbHg5ZEw2L2QrWEdGT3E0Y2M4d3U4N00va3crcHZ0YTAz?=
 =?utf-8?B?MUIrbVNINlZmVVBpR29NazRwd0p4YVJZMDdvYTFwUW5jVDV2enYydWF2Vk90?=
 =?utf-8?B?MWlDb3dmR2haWFNPTW1vNWJHVW5VZmdYLzlnOTN3ZG9BVGhXQUFrS25pM2Qr?=
 =?utf-8?B?eFU4eER3amU2VXpzYUpELzE3VDlXYVc0ZUlENFZ6VWZXMWRmTERhbkJjd1JY?=
 =?utf-8?B?dHd3Qlc3ZHBjdlFNWGtkUmJwRFZrQUZuRWFDcTNIb3VVL3BnV0xtbDVoZ3dC?=
 =?utf-8?B?eWlXbnB0a0N5MEY4QThNN0EyaERFRHRWbEpkRHlwTGYyelh6NHo1RVJzSDdI?=
 =?utf-8?B?SnNEYjBVY0pBVFZEUitlTEYvcHdkd1JNUVQreFpuejdJMlZMaDVubU5QQjBI?=
 =?utf-8?B?QVRNYitDdEFJQkd4YnRSN2hwdklyblZUWiswd1VNeVNacDArbVQrVXpBdjN1?=
 =?utf-8?Q?TYDZs8hSvB4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3JMZlNtYlBlUWhXMndDTWhhM2dBZ2hOTVE4SFpsMXUzOXhhSjN2ZEpOU05y?=
 =?utf-8?B?ZUc5ZFhBT24rbGdicmdCU3duWW1tSy9oWnZwNkx3VTFOeXZxdDNTN3ZDQUlu?=
 =?utf-8?B?cXh3bDg4NnU3RDZwcFAwV1l6UVJRU3Q0ZERLcHJmNmpnVDV5T3dhQWVJWHJo?=
 =?utf-8?B?ZDMvalh3a25MeU5Rb1ViMnV3a3I4eE1ZNjBtUXBCU05sam5PVXp0MHd6ZzBW?=
 =?utf-8?B?OU0yOVlMbDd6QkZjblBjMWYxUzRTRysrdWxyelJWRTBkZERRYzhoZ3ZXWU12?=
 =?utf-8?B?UFoxTkJIRkg0Zm5uWGFCM013ZUgycmM1ajRudWxrVnIzRVhWUWJ4Nzg2YVNv?=
 =?utf-8?B?T3Y2VU40QkJTTmhTOGtUOXhicU04REtjSitRbXdzcGtPZ3pPMS9SRXBWUGdG?=
 =?utf-8?B?UnRTSThiVUpiZ0xiTklqeVgwdzJBYlVwOWpKbWRCYkdaK210Q21xdmlCcFRi?=
 =?utf-8?B?V0M2Z1ZQdVpiWi9nNXBEU0lzbEFuR1BhNm56NWQ0aytwNWpTYm9icUtmbHRu?=
 =?utf-8?B?cVRxM2Q5eDBlbk4vZ3RtVXJNazVuLy9qamdoWW5VSFJkbDdUalQ1eS9EZ1hL?=
 =?utf-8?B?RTViQVJwYnIwYkVLVTJTNkVwbU1DdkJxeXN6SGxRakRkUkV0WGFjRzVTMWNP?=
 =?utf-8?B?RmtoNi8xMGlsQVN1OGU1SnUzOUpGSVplU3JNSWxSaGl6eTNzcnQwNVZrTkRH?=
 =?utf-8?B?Q3dJL1pkRXlRV1YyQlFPNmR0YTdBbDR5VmptdkdGVFFUN2RVTkEwT3RRVVQx?=
 =?utf-8?B?YjBPbytZSlYvNWtGRm9YV3FvRTFPZHlLSlYzMUVBR1Rxdkg0U3pCOTVxS08z?=
 =?utf-8?B?eC8yQ1BGd3lNSDNObGtHS1JaUm1XVHh3aFVXSVgzS0xHUjhTY0M4SVhWY0NP?=
 =?utf-8?B?Q2hyUVhlSS81Wm1MK1Q3TzgzVUFONGErSU1NaHNVekRhZitvaHhWRjNGdjNN?=
 =?utf-8?B?WWpFQTRvZUI0SW9qUjFYcVlqREhOUHNxZno1WXU0YjY2YVJzSW1KV0V4VEw5?=
 =?utf-8?B?QjhqY1VLelFEM1RsTDRtanhjOXgyVGttazBQWjlpbjlURDBNRWZNV3BCa1p4?=
 =?utf-8?B?WTlPTzY4S0tyRWZISk1NbGsvS1poMXFnRnIxbWJuMDBYNnp0Uit6OXFMYWlV?=
 =?utf-8?B?WXdFUHBkQmg5VjVGU1JSb0QvNlJOZEIvTjE1aDhlUlRZL3JZWVZ6MmFwVExv?=
 =?utf-8?B?OW9KSUhRZGx6SVJPa2djemNQcmRoUU8zUTE0RDNYNVMwM3dzNkF4QUo4WXND?=
 =?utf-8?B?VnZ3VlB5ei9iY0c3QkRtMzR5WUxFdG9ac0NicjFzREFMNmJyaDkwK1hiSjZt?=
 =?utf-8?B?L3I4cUw5ekxPY0VIT0FBR25JaHJwRWsyMjR1b1ZkYlB6cExnQ2lmNFYzWXAr?=
 =?utf-8?B?a2ZMMkpYNUh6bC9waXEyd0RUSmFyb2J4RlJ3VThUOHJwYWczblZJekpDUENp?=
 =?utf-8?B?bU9KOVUxQmhSdVdXdUdHenRBaGl1bmlocEpWY0hmS3FiSWtDLzdEMTNtTXgz?=
 =?utf-8?B?cGN2a0E3NUJxSGRYOEVLL0FiRlUybGJiWG9selhJblRxMWpyYlVvRXM2bGgy?=
 =?utf-8?B?TjF4RTc4U0ZxWmhqZFROdVZxaHZHU0NJNDZ5Q1I0THF5OHRsbkQvUGd0Qms5?=
 =?utf-8?B?U0UzbjBXMjZFbjBhK1F0N3JZeE12M0tMNUJiYitWZlJiemRxZ1g1M2I4QS9p?=
 =?utf-8?B?Q284UWRENElhRFoxWFRtbVgrR3J4R0luOGlteUM4R2Y0NUs1c3B5TmJMNmxB?=
 =?utf-8?B?OG9MZFl1c2h1ZWttYWVmRnVaTTAxVGw1WElIdVhMYkE2YmhzdnBieFcwdTRi?=
 =?utf-8?B?VGEzaDl1c3RLeW1sdVp3ZjdyNGVwYmJxVmpCZlVpQWxjQ0IvUEhKa3Vid1B6?=
 =?utf-8?B?YU9lOXJ0VWk1WGs0WlN6OEg3MlQ5YUdXTGZWbDNvZ1Q0VGlTT1d1cWFJeVNJ?=
 =?utf-8?B?TWtwb0haQnZmNHdqT3B2ZDF3QXNQM0F3dTlUMlI4Unk0RGpSWjVDTStIK2wr?=
 =?utf-8?B?TlhVYmttWituazNPaFJ0YWxsZ09DWnArYXJkQWF6czkySVZPQUl0MWU5dkx0?=
 =?utf-8?B?WGd5NEFkblJqd3V5K2RDTmZ4aUhIL2EveE1Na3h4Q0FqQVhaWnBoenEwMWhj?=
 =?utf-8?Q?CBFmuqTRcalc7UmOnKKn9bUQs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TxjNEALaN8H/uZcZfhaqtZA4cv3N2b1kL5WBzSlIfAc9ekoIdukcRS4Pgv03NqZkoJ5p1d68L1J7YO2Xm7kZYReZfJVKt7sTjh+5zDoD4ABb73I/t67nGpEPmDBDNFHCFQDK5jhZtaTrWIKffYJTw5MtsmTEQ3UCON5p/xqBYpATb46RHtJ+L9/wua65gy5ECQADPMQqNs+QW8LVtBrZTXtfIrvVeOTU08SCBaBE1G1u4mxJXJcM1Py9x7s/jJ1pVQBdxoF6mqL1JRgKQR6CQw+5tGGGjhMLopDCAZb2jcuiGxzJ4hjDg4LDV4NCKAixSR4SJnLjaHc9VwuXCWWUXvvP0EGJMcnz8R3K6nnIYYL0KeZ/ccLL0SCubZMEMy5eItJ6oZ/oajuVeCeDXc75oTzIc7KYij46TToyO+Y6s+PFlcEDJ/wLr8bZJ1FF+ImTrxetzwNdW4NV7RDcRfyZjrPm+csw2jxy/Z2ni3wYGhAxS57X75+9+ogKp5F1P5bYzdVOYth/SJPNcNm4cxAIJNl+zdNKU4+Xtqv18Ctv4wcNJC4sZnuDXsuOnunk7cDH3U89Bp0srDDRHH+ob+uat5Cl7FYY80DH93wBzZWGL/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca78fb6-d9fa-435d-d79d-08ddc2dbef18
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:40:02.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0WLqCtgvUYklg0SoSWkG4UxtOBTJqiwg3XEmO4cSjTkxgrY8gv2kIn0ceBp3yhmKDz9mhGHGre1/Yf/jSMamw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140080
X-Proofpoint-GUID: icgWS-XRlprcKFqVTuwY0HbuSrknkkaD
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=687508b6 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kLWA3gBXtu5QbDPQ:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=a2qSARpz2R8t0M8RxgAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: icgWS-XRlprcKFqVTuwY0HbuSrknkkaD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4MCBTYWx0ZWRfX6v90UHgGPOJC fc1KxcEBpB4p5HEDW5N8JYz7ukQgJdzKJklZgkOBt30EVyl+mAqCZrN1qf4pW4vWK6rYPv5tvnp ZzZCipNCO0KBuGZIkL9dL7950QMz++9ZdWVxQNbyGedMsLfXITXhjuRbW4wMbgK7iFU4HuWCUen
 GO7TiVG2HJfmh+IHZVNkxJ0ymgR2fvgjD7smlSlUdyw7HlYQpEnqCNT0wFA5EGFkkVwsrCHa+Sv BqIVfRAqisAHDt891vzhe49drCnMmzVCNWTz7+dPx8xCJ6OXVFwZibplG3kl4JpevVQw7gsfgTQ eF3dps5mX1VAxXqqdYpfCy7bj69A9e07AH/mqogCaJVxzGNQndJw7Pw5tSsTWial8SrTh1dZPuO
 t10DtLCJGnXH6lBkWA2Dht+lHGDKK4EtlOEHg3oUyVoq/kvDqp0esLrDWlY68uDiY1U3O3h0

On 14/07/2025 14:17, Christoph Hellwig wrote:
> Hi all,
> 
> I'm currently trying to sort out the nvme atomics limits mess, and
> between that, the lack of a atomic write command in nvme, and the
> overall degrading quality of cheap consumer nvme devices I'm starting
> to free really uneasy about XFS using hardware atomics by default without
> an explicit opt-in, as broken atomics implementations will lead to
> really subtle data corruption.
> 
> Is is just me, or would it be a good idea to require an explicit
> opt-in to user hardware atomics?

But isn't this just an NVMe issue? I would assume that we would look at 
such an option in the NVMe driver (to opt in when we are concerned about 
the implementation), and not the FS. SCSI is ok AFAIK.

And we also have bdev fops supporting atomic writes, so any opt in 
method needs to cover that.




