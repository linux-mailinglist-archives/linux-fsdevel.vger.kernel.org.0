Return-Path: <linux-fsdevel+bounces-52236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1E1AE068F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60AFD7A6380
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CEB246348;
	Thu, 19 Jun 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j7yLYyvi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mbViHm0R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62178F4A;
	Thu, 19 Jun 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338643; cv=fail; b=u3MnOnT+YAf+j3urHPrvto0v2dZWfn1R2YSlxzJFcyj5U6BguCamc7XwpgeZbqB3tqJ0Pa4kP3WOJO2pD8IBPmgwHmgv580MkfBARbOnY3l02GKPj4gSGGXgPP62P7e/mmII/eWOcgsNkePoto9Vg/P/fm+t/gOIEU7yWzkCip4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338643; c=relaxed/simple;
	bh=UQXkGv1sLXnmj7iCGJ/ivuhhxwgylNxVf6PgZN6frjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FSrnYomu+lV3aRvBE7c4xYy70RiAAjgiivGSMUrXz86iRRjLTLtT/+RD4G3J++R+PMzzoDPFzZ1evLUODZuAQTuT1kcu9mTPswpWZ8EHJDeSgAl1aAuZqLoRu4WxekKkp9TCfRRRbL94Hyer2U1OsvZszZntJeeqc25SybWoLt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j7yLYyvi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mbViHm0R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J0fYot013637;
	Thu, 19 Jun 2025 13:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jBUtTIzkWGkzuhaIS9DDcs5Db3YZmBSPSW6fHV3XjAI=; b=
	j7yLYyvi9fu4xiUtOd/+9U4BEadY3jDHqGniPAfh5NC0scr+LoSD6GKmnLxgQx9h
	VYX7iEDlGQ1hw35Nt+P4T5F+9+57egUHZjk+CKFx4imZ0AtV4UviRw7wLGjcZWfO
	g0kCx9jPvcd2BRazDiTdpqI0b4i+cD+GHcT1ivrxgSpfIUbepZhz4PbIRxSmXF89
	EwS2RJ+QabR2fhvdeU/KeX3xhNA88BDWYA7/DMWVxFrReLNxd00vPS+rXfYvtRrz
	ZByfwCROTwKrv7TTdzO9wVVgeNR04cfzf6fjWS4Xg5MWyuk9RgHowZ7Xl+JSm/Nj
	RsmhPOgzbCkRM8LwvGx+0Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvn9a1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 13:10:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55JB1JMg023309;
	Thu, 19 Jun 2025 13:10:34 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012004.outbound.protection.outlook.com [40.93.200.4])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhj5d06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 13:10:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYIznqnLorrv9HIQklcsm/QFNhT01OSbcs1+iwOIcXLbvWhmzMsTqrs/M/pIDcRrMsD923l8xhz5Lp4hH9m5FevVS0NVRRWXylRRU0LRlEd+zT1r7nbLhfG+ahgJcOV1lDu0p3jOzHW5TdJSprsBTqQpepd9l3NlnMx55d87GjmxJ5Sl78tczaiSdK0LWQm7HZhb8dvamYnC9/M7lMl0hK9iPAz3YJpo0ajQQoaNLT3/OTB9pupG1uDu7KbYSYROoJLo47MCyz8DMteNCyAW8sma47xnEqH1ozq1iFKtPvj6GdgzOrIrDbL/zJgk3rqn5XHQUQyiWc4U02OO92D0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBUtTIzkWGkzuhaIS9DDcs5Db3YZmBSPSW6fHV3XjAI=;
 b=A6dnuaw5+ywKCC+68SXRGt5bGuQmyD8CZ1gh+1qbXoK7it0QGUZHXxVYmO/XO0o4bpu8AhqXSc4ScqOA6vxIXckkVTXDwgX5CuTpFTYWRkHfY3OUax+BMd0W5u9WKvbO4Gu+LXGLVqI7z+RjihnKP4m2PjAmXIZEOTST/lrZMhLpXTLqpJGEaQsleknMltO+FxmMEnG0bCi57gYbm2c9GAFuDg1JDpWbPL/s5/dz4r4N0ZqwkzebsdlC0PAAWD6YENqvMidB2Odi6LSPOn1wBa+nyTFkc1r6RlTX16rFjbhZzYnL7oCFNZa5XmcCYwdaT1wb6mWVM4rbTK9jqJJhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBUtTIzkWGkzuhaIS9DDcs5Db3YZmBSPSW6fHV3XjAI=;
 b=mbViHm0RAQrFyBJ8Ep+Frp+QwDHt7wLkt5BZtf6pmuosNh9stdDJktei1+/hBb11nJS9mN+wEc1v3mMaVYsf5Oimr2VRJ66aYuf5EU6m+xnuIJBSkfEbIkWb3jTw207vdEUSuE13FLC6++nh0LbgtTA6cuCuIX8yK73dogr9Qwo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6242.namprd10.prod.outlook.com (2603:10b6:208:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 13:10:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 13:10:31 +0000
Message-ID: <e27668ac-5134-4a37-8b50-290e3f04edec@oracle.com>
Date: Thu, 19 Jun 2025 14:10:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] statx.2: Add stx_atomic_write_unit_max_opt
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        djwong@kernel.org, linux-xfs@vger.kernel.org
References: <20250619090510.229114-1-john.g.garry@oracle.com>
 <7ret5bl5nbtolpdu2muaoeaheu6klrrfm2pvp3vkdfvfw7jxbr@zwsz2dpx7vxz>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7ret5bl5nbtolpdu2muaoeaheu6klrrfm2pvp3vkdfvfw7jxbr@zwsz2dpx7vxz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: f075d165-4801-4f70-ab35-08ddaf32ab58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEN4Z0dzR3pKUjM2dEdGcHo5Z3RZMXphVkxYY1I2bVl2cGpsY3hhemdQK01r?=
 =?utf-8?B?VGNxNGp2WVcxbFhDZ2pJclJuclU1aGFMd09XSkh0OGw5ellYMEZGZW1WbmRM?=
 =?utf-8?B?SytwNWIwWW1WYW5WQlN5VTFsckhxYVZCQXRRblRqQ3lCUjZQTGplbm5Dd09K?=
 =?utf-8?B?WlVRVUVvZ1ptcEEyLzZNNFNtQWh6RkgxOFE3VTNoak1iZGJYZVFJQjAxT2V6?=
 =?utf-8?B?U2xsbkVMKzBHRXFTQ2pjZnRDVktkUGx2NGY3TzhZTFRoZHc3RDBEUm41OUJl?=
 =?utf-8?B?Qllna1pjMUQwT2V1U2s2enV4YnBoU3Radk9rU2czNlBMNkdjNXlRV3B6cnRs?=
 =?utf-8?B?T0xXUjFhOXBlU1E2L3RvaG9pR0pZMk42UGFnK0pVVkt0R2JpSXVqaGdOUlVE?=
 =?utf-8?B?Z2xlQWI5YXhpUGw1MHlGbHpoaVlZVzRsM3d5ZWZRQ0p0dTY2VEt2Y05OTHRR?=
 =?utf-8?B?TkliT29Fd0NSQUtKSk1JVHhmdnU1bVBZVmVoNWdDTm12cVl5QUFGY29tM2pn?=
 =?utf-8?B?SEZoVXBSZnB2OWZvdlE2dStjNlduSHVWa05DSzBwK1hkU1BzRjFtSnV4M1V4?=
 =?utf-8?B?aGtYSWdKQ241V0tJRFZ5dkNGSjJtR2tBSEY2dE44THovN29jTDJGYlJVajRT?=
 =?utf-8?B?a1hBRjBWRVc2cE0vSFFnblZHU1JzZ0srQ2lGVEhVRThMRDZEZEd2YTZiMUg1?=
 =?utf-8?B?NlRFTUdWMW1lQ1lzT2Y4TndiQng3bUppNktsMVExRzFZaDhQRDJKNjhMT1F4?=
 =?utf-8?B?WVllTTRxalBqc3NmWk9tMGp1WThnY2VOTEVzbVIxVnl4elBIaDZMRDdJbUky?=
 =?utf-8?B?eFdxQXJkaTN4UEVkR0Z5RmpnK1lnczNJdGxNN2NtQ2NsblVZbVN6QzZ6MElW?=
 =?utf-8?B?VFVFM1JQMWZlZmpSSDBzd0Vhek80c0VoRzRsRVQ1NjR4ZDFBNGt1UGNMQ2Zu?=
 =?utf-8?B?N3lFazNnVGIrMG1WaHRVdEhCazRlUkVqQ1pCaTJHOThwcHluc3hUZ3J0RlAy?=
 =?utf-8?B?Z3ZiZ2FqUlR3UEwxSWlBeStlbTVBdWtTbXZUZWNrcURmcEJLUEp3M0JSdC8z?=
 =?utf-8?B?MXhWRldVMFU5bVEzc1llcTdUSks2UHhCb3gxdjhEbnFZaVBZa29sNWd5YmV6?=
 =?utf-8?B?WURqeFY4NjZLek5lSDVoa0ZPK0hqMDNWd0R1TC9JcEU3Sy9hQ2tnRGRQc3Fv?=
 =?utf-8?B?OGFHMXFwQjJ4MXBKUHNrRXYzcnJuOXFvaHlBYVZqcWpXbzUwelFNNjJPZTEy?=
 =?utf-8?B?bStjMzMvMzUxMTYwWjU3RlNPcFIvT3ZNbHRFUWs1WFVyOEM1bWFMMWx5Q01u?=
 =?utf-8?B?dUpiMHR6REFnYkFma3I3ckltN0RPV2xaS3VHbGN3RHhjOHJsTTFGVU9zOEJE?=
 =?utf-8?B?cm1HTFBpUzZxZEFpWjF3Mkg4Wk5MZFNvQUprbVJ1QmpqMC9LakVac1B2RGlq?=
 =?utf-8?B?UjZEYy93aXIvVGNNbGFBVWV2MVRvQmxuUnMxVlpaekhNbUQwWkU2ZnZlZm5l?=
 =?utf-8?B?TmxNVHkxbi92S29wU2o1Q1RDUE4xUnBBc3hERkI3NUtJOUwyZVBCZ0Eya2NG?=
 =?utf-8?B?N0NjdTB6WGppMm1Yd055ckJZditVcEloMHA5blkxUkNudmRRSGsyOEhNdVVo?=
 =?utf-8?B?N0Y0RlNDOFdmSVRqK2VoZXdTTUhlZlJERjREdFJLSXZ1TzIyUDJOcWdGajhS?=
 =?utf-8?B?cFZJVGtZQkpJWC8rdkhQTGxGUGRaOXFUSkFVbFlRVWJmVkdPQUkzWlB4ejN4?=
 =?utf-8?B?U1doc2ZmVjdKY2xnc1NwV3JRTlJRVUlGd2ViWTgrUjdzUVZMRFNnRGdBNFRw?=
 =?utf-8?B?bHJZUlJYUndNd1lsNzNCajJJTXlNdzV6aG5xZFJ1VUUyRVpyS1FveDNtTURW?=
 =?utf-8?B?QXp5c1dMV0FPMHp1VytSRDR1YmxobFJBdTIzV0ludm5vWE8vbGhBa3d6U2gw?=
 =?utf-8?Q?wDlKSe2PC2Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDV6amthaEcwdXFjZ3hwYlVyMEJWQmtnR1d2UXlxU25ZVGl3bGxkUm5wZzB0?=
 =?utf-8?B?UEQ4QVdQNEVMYUpNNUNUK1ZwcXJ3SG9tczFPRU5NQVZzMzNqWHJRT3FrbFB2?=
 =?utf-8?B?aWcwZytWUUMydzh5TisvdmsydTFXY2lpWDNnMFhmKzV3Lzh4MlZnbFVoK0NY?=
 =?utf-8?B?Y251NjhpaVFCQzJHVVlKNzE4TnBTTzVNMFFEeWRhb2pONHRCYy84WU90QkhV?=
 =?utf-8?B?REJoTEVIZ0p1RXYzSjJDSTRHT29CQlZUQ0pBNnJveHdzYUIzNFlZSHRtYzdm?=
 =?utf-8?B?ZEk4R2pJQkl0K2hvdDJyaFF6NW1TNXJvYTFJZldCSVBvS2ZlQlFuNU5nU3hL?=
 =?utf-8?B?RFh2L3N6bnYzRTJvc05xeUpPZk1USlpQZXArMUVtWnh5RktpOGVGVnBHQ1Bn?=
 =?utf-8?B?OEpZV0IrVnpheVlDK050V093TnlycGo2ZWdBV1pMdE5nK2l4TjIvcnlSdmpi?=
 =?utf-8?B?dFgycCtQSUpKWHRGVHFGOTlaaFVpM3hzSnFrMFEwOThTR2cySlJWVFJXOXBz?=
 =?utf-8?B?QTlXUkhOdHdraEgzazY5MzM0WWlqRWRVZCtVZnA4RzI5bUFHOW9aVWpmWjlu?=
 =?utf-8?B?Z0VPS0J6N3J2Q1pHMHhIUkZxTXJOV3NqQkNmQkc0SUtYVXVrYko3b2M0V1FP?=
 =?utf-8?B?NEc4WlZhNlBDM0hEV0ZId1B0Q1FzdlhZNjhJcUh3eEJYcytWOWV0K3VXWDMr?=
 =?utf-8?B?aWw5eCtTcGtjY1JCTGJYL2lNM3JyVzVUN1BheFppUFJNVWZhY1UxZlY3MnZQ?=
 =?utf-8?B?M3ZXbnM3THZqTTFhSlg1V2RnV1BrTFZJUmNYeVFIL3VkUENQV0pkbDltWVRj?=
 =?utf-8?B?QW12aFYvSFJrZ3JidHphQ043OTE5S1RjUzlDQ01vNUtlSDZkWitOLzhPdVc1?=
 =?utf-8?B?VmJDaG5lUWhmWXJFcURRZXFFR25ISDV5bnZYTzg0VFJjb1p4UWxYd05Ra1I3?=
 =?utf-8?B?cjlPekc1djhNRm1YV0NlNitsSURKb2pDLzhCbnBFVUZwMGJEYUhGNzZwVk54?=
 =?utf-8?B?K1ZnZERsK21reHpOd1h3VWVFT2xmYVRxRGE4ak02Z1dkak1WZWV1cFZxTW9L?=
 =?utf-8?B?Q1FJcW9SelZsYWZFd3ArTytwZHdsNSt5VjBVT2txeTkwamFhVko5MnovaVNZ?=
 =?utf-8?B?MWVFNGhhbmtWdnFETDZNa2dzQi9FQ3NUdzhWM0hMcUVIWkl4MHJabjV5L2Zm?=
 =?utf-8?B?ZjZEbUJneG4ya3VaMGRpWnhlWm1DV0QvaU9hdFRQOXVONTZMRzZUQytEeFcw?=
 =?utf-8?B?dU9xUURsMEtZUTFhYmEvQlFJbGFNOHpZbTBwTlR0Zk9LMmFKZytmUnNLeW51?=
 =?utf-8?B?ZFBnd3pTL0orV2Y0bS9oUkNEMUxJdlFUVGN5UzFlOXMzTmdlTE5MejdMb0dv?=
 =?utf-8?B?cnhlL1VKeGR4V2NUN2pYc1VLRzBRSlZ6VmZRdU1PR0dVdWtPekYwbUtjVDdK?=
 =?utf-8?B?UnlXM0NiWG1pSklzOUZNTkNiVGljaDFRcUdPQkhYVVpoblFvNno5WTFFWGU2?=
 =?utf-8?B?WFo5clE3UjlzWEhzVGtMRlhpa2xjZVlCb2sxOHBjdVZLMkZpQ2I3bzMyWXRH?=
 =?utf-8?B?aGF6bFNKblpXVjM0ZExFZWR0YmpnYmEvb3ZjbWtJNDhld3lpdy9NelpwYjhJ?=
 =?utf-8?B?aGFzaDZmdmRrajVPdWRLR1hESGFVd0REMkI1cWN6ZXZDanlWL2hzTXBSYk1l?=
 =?utf-8?B?czIwYm1jU21qYVMxS3hHaFVLTmc3SXgyeDlPU3FHL2tPKzVncTFBaDExNjRw?=
 =?utf-8?B?bzQvdEk0U3NPSFdjM2V6YTJ1a0UwNUZnd3VwcG9OTEU3MlFLRElaczRWZ2Vo?=
 =?utf-8?B?VTU1dXVRdEVWRTRxRUp5dy9XUGRMNXBMeFN2ajB1T08vYTYzenB3N25tekFY?=
 =?utf-8?B?VnovTVRGNEdwYlY4ZURjZDJseVF2WWZ4RTFSQW1iUll4YWYya1UxalhnTjhP?=
 =?utf-8?B?Uit5NHVOY1hiVnVUeEdQVHk0c2NvVFd4MzVvK3gwamRlZm1HZSt5ME83dFBL?=
 =?utf-8?B?NkhsbFlobUVJR3NVd1lVM0huZEY4VnVvdFlxWjVEckx4a1dHTUszZ2M4RGZR?=
 =?utf-8?B?RWFMZ0ExTnRiZDlSNzVpVThRZCtJdWl1aisyOGF5bWtMOFltSjdFcXJTcEJq?=
 =?utf-8?Q?3Sc7nZDV3RpTMI16MAOBzwJqz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vLGYGX8ov6zxpM9xLX8qmExjTgT7KeazVwo/BJZk6qekyXDjfyU1E5r2rpxOc6V2+T7HCLOSDEfqyV8z8WUPwDrUg/krZLjvTzL5moaXsZXgJAOfsSm+TuobJn0JPJh5tC0mXKpwta3T62OwlPFnsLqhrexbJ72Yfg+ijie7HVt0UBCnzXCMJd+RCaLvL4CKUueu4UkbmW9jRUjND+kpnQxH5s2vdjrT2aFb13VIitm+gC2H9UsOmHEegXllsiVZfisd7os25IonrkskZgDs9vvFic5lWmRw7E33uQeIXoXgj6/+j+7p+A3D7gkMfauGxSV+sYneTehaO88FPyNtlYQODH3XkQzRqz5nYipVaOWgVLvI9eJvvf8Ma2aOGKKvwyuNllt7a3f9Rb77dGFn4iAsNVf5upZj8fnzx5TW9nt/7oIqUx9L4pFnF0nSc7MUv3aPnknYlXVjdMNUVCsJokPWD2uGOivIknW1kuOItvdzAeHirCl9E9h9u0qA9F/AwuzCnW95E76kITqJNfyEcXRaZRwH8YLvzze7er7Kk7npWOjIEKCaq2YdfkxCBf565rLQZjgNNTZ8TjP6a8pwbYdQcANZrZTx/+fUUUhx+us=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f075d165-4801-4f70-ab35-08ddaf32ab58
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:10:31.6902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SxXTKQq22g0gxg7rNCkr2hiqZpUg0JSAR4UKXYWACm3LcP4qn0PUkBOaGu8mHgdqGIdtvjbV7mQdM2czKx2aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_04,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506190109
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=68540c4a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=eGQuwq3soYqW2mG_O9QA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: LkR3AYniixamC5SXA_DylKzPxq33RMfC
X-Proofpoint-GUID: LkR3AYniixamC5SXA_DylKzPxq33RMfC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEwOSBTYWx0ZWRfX/D1S7uh8NjPr h94DOmfTrbPLpIXqNzoBpfiPbZ+zvcf3j/wUFhDexyJ5zZz5V1dSzPWqoL/3yzoholNxZmkrYK7 JWUsTEapY9tbgwaNhDt5r6hme/baR3hGTlKcAlQZZ/7kHN6QxNP2g8k19nJ7tPMXa6tsxGvf19s
 lnDEFfTnq+1T9mMxEKSpk0XgOf7DII+w3uZ64evSSE59yjSuU/VqDZ6GqO6JqsLaBZi4ReYI1tM ltXaHf3s6d7BxNygbc/hA/aaTNh69Z52Zuc7BaSdYAj52L0MCinld3E+ubsNaMa9hW/F7u/TI7Q g+Z95WojktdsscCxodIic2ImUAvkaYZ6WF405d1lf6vQTLI1i7J0FQWBSqVuY6ogOMctX9QjCOF
 vnuQQg8ZAEHSHoQMbH4YLnX/uNF2e8RY5/TQNg1aOxaboHfqoBtN5i8Zs+fy9Jkxba+U/ZUN


Hi Alex,

On 19/06/2025 12:05, Alejandro Colomar wrote:
 >> @@ -74,6 +74,9 @@ struct statx {
 >>   \&
 >>       /* File offset alignment for direct I/O reads */
 >>       __u32   stx_dio_read_offset_align;
 >> +\&
 >> +    /* Direct I/O atomic write max opt limit */
 >> +    __u32 stx_atomic_write_unit_max_opt;
 > Please align the member with the one above.

stx_dio_read_offset_align is actually misaligned (to the member above it):

                /* Direct I/O atomic write limits */
                __u32 stx_atomic_write_unit_min;
                __u32 stx_atomic_write_unit_max;
                __u32 stx_atomic_write_segments_max;

                /* File offset alignment for direct I/O reads */
                __u32   stx_dio_read_offset_align;

I'll just fix that separately.

Thanks,
John



