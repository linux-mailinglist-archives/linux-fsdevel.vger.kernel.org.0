Return-Path: <linux-fsdevel+bounces-24210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B956593B705
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 20:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCBFB23646
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 18:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581B716B399;
	Wed, 24 Jul 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R4Ri7Xk3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X4ulv2au"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1F15B13C;
	Wed, 24 Jul 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847038; cv=fail; b=hno9UHTohN5fauYORXn36Io2laVFteBzbwfHvwLzGTJYBlwb1oyy8jnHPk2tiaMQZihFZGfdzr72jMnc3QbzUbuFulDYjNdhrvMLRON7sr/jv6tMX8feu+zdmT3xlfIKCtgT5hvSFDPrP/C9W3P2DxW/oKoevWwduoobJSPzxpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847038; c=relaxed/simple;
	bh=tnOBP0IsLTptpSZdnUGtRO1LRp1jUY/cJs70z/1fBJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aoBv6Rwkee0MNeftR3SyGGU09WBz7VQYFQjqhqf19G5kJNqV91tjTmqxBZ51QPdVm8afQdO3Nmg9iU6bu8Bvua5N4BgiicBsMhcoAuG4PUCn2TA7U807iv73bK6FLJqZM2fGUJbig4AVsBOlKPEIsLl0LL0u5ys3i2x0KsF/rNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R4Ri7Xk3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X4ulv2au; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXrdM016724;
	Wed, 24 Jul 2024 18:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ld2IgluGDZlaGvkDNIE6lDQNG+HAAF83h2TBBgxMsYM=; b=
	R4Ri7Xk3sfTevtISKwrE/n6iVGP7j+8OS3cbGuYXb4QUlJyVX9e8uvqB+wtq3Kk1
	0C3os4oUSWoV+s2HShqfilQ1Z+TMl/4xM137Qn2Ta/WxnB3v9CBR/dYvJK0C9zDu
	+TnYBEp1MFVaF6Z4gejnSOd7lHWyYC8kLK7Os15RWy1Jb1ETmjq6IaaHJ4hAS8jf
	tO76o6B+2yeTriBpelrecdRPhMyTK0HhrCglWB9fgHjUho5EJ+Ff3qwJ/c9m0Ey4
	W7wu5ZUFxbUPn2gpeigsiVTURs689A5qhXoMuA/qi/zQncICSEE/Rr9p3XzsdgaG
	WqNwkf6esqATyez+UOItCw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcrhrsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 18:50:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OIRK0O011001;
	Wed, 24 Jul 2024 18:50:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29t2013-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 18:50:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/1VpbHoNz+cZicIg69Lt1Fv6HOPoipmswyPC3tMwAs5Dz30l4L3t3PAFlrGyZh5hkWCGoA0VpTjHdWDNtGEoLEk+tl3+F5q36CreziuesbJtyCBFHuNWMv9BaaGInjZVohT6ZNpzIE21HFKFNJGGSxffrCTdFyyGRa/EZltzRv7ISRMfO2JWtN3Ar5rqBViRpnlQmLk197K2hJF6RRP2PIQSm5tmcBMKyQ0jABjyJt5OOnXDfsLm7CGNNZtVjfkBcIDG+Wm2p+s1uJVmAkjTnZV4phQEm7OEBLvjmM4qp2FLM8bYvLatc7HUNxQAwV/uQxXEyBVcO6Km5rMQPrPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld2IgluGDZlaGvkDNIE6lDQNG+HAAF83h2TBBgxMsYM=;
 b=Qni1Qi2NbYeab4VUIYUC7Vsn+4BVi/wxSOmOHL9KeoLCJV+1AZq7/OxJzJuYB3kEUp8jPnUBgYz8aotanE6gOk1b/juhK8g6c3MXSqgcEnH48HG7W4MadlZSWau6/nXngdIEfppCSPGq35hUE0YrQvTBy471f2hP+RWToKt3S3j79yiD1pFaKrUmU0HckuM4FpXssDDb5+CEh63iF6ytgYHgOp8deqwLhlo2g4cEhstB2f750MzL1jwGZzQa6K8yshTkg13F4ez0E30D/y2ddKuhfEgadJYkvG95sJHiqNYnTqg/FE6z9Xj4Mi0gITyT3DHx+8362JIYkDuamfGjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld2IgluGDZlaGvkDNIE6lDQNG+HAAF83h2TBBgxMsYM=;
 b=X4ulv2auae52YzSjX0H9xg4Tnu7tcmzMBPrcC/CHBx01qTIcCbZsBJNjBTuNHX/jfci1Bjf2aZL4cgyYE7wu6SRW/EMB3/s7OpIA2w/S+VfWWUu63rsbhzd+W2vWT9WUdyf9CglhCEhf57svLuD+nBBYKKwLftT9S5uh/o1uTQQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 18:50:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 18:50:19 +0000
Message-ID: <3f402a11-7dd2-4da8-9e1c-ea8a4e3ab33d@oracle.com>
Date: Wed, 24 Jul 2024 19:50:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
To: "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
 <ZpBouoiUpMgZtqMk@dread.disaster.area>
 <0c502dd9-7108-4d5f-9337-16b3c0952c04@oracle.com>
 <ZqA+6o/fRufaeQHG@dread.disaster.area>
 <20240724000411.GV612460@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240724000411.GV612460@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0027.eurprd05.prod.outlook.com (2603:10a6:205::40)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 83064623-eda9-4579-3cc2-08dcac1176fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlFCakhHVWJXcnIvVWRBTXl6MktWRlJ4ZWxqQU5XRHRmdkNmaUhMNnV0UU9S?=
 =?utf-8?B?KzlkVmJMRjYwWXRDRDVmOU9YaXJmQ2lnS0pKNklLMzhBMnlwaTBYU25oOERQ?=
 =?utf-8?B?TmNPT2Z2NHZUb29qWm9iemo3bklOaVJPMnNDMHhTYmZtUVNXTHJnK0dJaTFO?=
 =?utf-8?B?S0xKSnIxMmRNblJXc3pOYWtHNEg3TURhbXNuaklyV2ZQb1g4L2NVNzhEa00v?=
 =?utf-8?B?a0NjQVU2SjZadnpzMSt1SDFpTTNwTkc2MWVuWDhOc0lVb0ZQb3lON1V4RG1Z?=
 =?utf-8?B?NXgwd2pwdG5Ed01Rc1BLMEZ0aXRLajVWWG5XRHJNaURjTVJhL1RaY29OZ3Iz?=
 =?utf-8?B?YU5Xb2tUZW1EQW5iQ3VsS2R1T01EZGgxcFNWa2hVa0w0R2pwVTJrbC9Sc2N1?=
 =?utf-8?B?RU1tVnhkTTNkWUVpOW54U1NPWkRxd3pvc05PZDkzVWN4MHVQRGg3RlV3L2h6?=
 =?utf-8?B?MTI5TXRhVWZjdFZBQi84NFdoVjcxTTNnRWY1UHF0aXJNbTlEbUV6NFRzcFdB?=
 =?utf-8?B?WUVUemJrcVlkdzZ4WTg4YTJ4L0Ric0EzY2lLQWo0bDV1LythYm1vRFVYYkxV?=
 =?utf-8?B?emZjQTRiTHNwWVBLOWlIRnFxNWFDRFJKV2RkYjVpZC9jaXpISktOZDJEQ3ZM?=
 =?utf-8?B?VG5mOXpqWDhWS09SaE9BN1ZBMjBQayswVm9iMExDOEpRTzBGNVNhU1FVOWpT?=
 =?utf-8?B?d3Vyb2lIUml0NUxpa2lCZjVaUEZ5TldYMThhL0JqcTUydStnY3lVSTV5UWpY?=
 =?utf-8?B?Z1hta01EWWVhTm1GdUtXcURldWVNS1Vpc0pidTEwcXNLWjI5c2R2UjRSY3Fj?=
 =?utf-8?B?azBxekNZSHVTam9TVFl3bmRKaVhUQ1d0R2JkOVR4RG1jdUZxVEJXSE9ZclEr?=
 =?utf-8?B?K1VwaXZiandjeG8wMEo2cUZObUQ0RE50enFXd1pvS2JtZmhrNWxJTGlnNW5W?=
 =?utf-8?B?TmF4YmpTcHBzZW1pOFE1dk9IcnlhaU9QNHMrVjQ0ZGVzWmpYekZJbzVVaEVa?=
 =?utf-8?B?cldXUlgxb3kwRmhqU2dxSm5mYkJDTUVOdys2TmZEVytoUGhjVks5N0FTeG5V?=
 =?utf-8?B?RWFZbVBMWmJVdzFJMmxlSUNERkw2dlplQnlBU3U0Z1F3QklIMy9jR2h2cmwz?=
 =?utf-8?B?d3R2amhXVDJ6enkyeldiRkdwaTZnZzhDZWZBQVNpSTFoaHoyTWpqdGdNUEZo?=
 =?utf-8?B?V1dxRVlJRnRnanJlUFNycmRpVnAzejd2RjRxYkpjLzVkeXNSdytGZWR3YzhM?=
 =?utf-8?B?cGtic0pWdVFMNVlsTjJnUm1HdC9MQ3FUaU1kWWVwbHJFT202L2xZcDlpcVRN?=
 =?utf-8?B?SVZlamZ5QXQxdVlpK2Fad1QrT1NhS0EyZ0xoR2pjNWVJZVgwMFV4SGZ4VWZM?=
 =?utf-8?B?ZTBVUkl6ZG1CdVFxOSszK081ZzhsaDNzMjlDb2VJM01NSWpTMG5OalN3cWxa?=
 =?utf-8?B?bjFlSnQzNUtBVlloNFFaZENML051WFp1K1NUSDFrNkwzWFVRTmkxUGwwdGl2?=
 =?utf-8?B?SFoxNy82bWgweGNDNHFiekVJN1V4MWVTVHQrN1dvbHcxRlc1U3RZY2dlbjdr?=
 =?utf-8?B?SVBpbUVHV0lRWXVnbi9YQ0NLV2p4eE1WZ2ZmTjZLZU1Fd05nbzQxMmJmQXRp?=
 =?utf-8?B?V3dqaTZCdkcwWFRHY3hNWWFZQ08vK1lYenN3UmdBYlhWRlJISjJVMlFXYmgx?=
 =?utf-8?B?bFhLbDc5SjRPSFdPQUVldVZaeHBWRlRpNUZaZ01QbDU2T1hUN3ZWcS9OdHdT?=
 =?utf-8?B?TitSeG51dEZFOHRZTS9rMmg0UDZPelNFaTV1VWZOclNyL085UFljakViZ0lD?=
 =?utf-8?B?Y0RodDYrSnhJQ2V1UlQ0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1pRbHZUU3hrUC9HMnkzdmV4RVdDTXprTFRscGdHV2RreVNJdUVTK2gveUVO?=
 =?utf-8?B?ZVBHWVpXRlpaZENteDBlWWdsOURmbXJ2NkxDMGx1a0RIeVIzckZidnRJY0Mx?=
 =?utf-8?B?WEhKT3B5NU5nTWU1WldQSEhGTkZzY1lhVEdHS3JhMFFZNHRwVXpYRUVZOGdv?=
 =?utf-8?B?ZzZtbXBnQ25helNNL0htcUM5RW9KOGRBMXRlVUxQRjlXMTc2cGpHRDl3M0dq?=
 =?utf-8?B?VzRjYWVFU3g2U3VwZ24vc1RKV0psaVAyeHZ0TVJVbFplL0V2OStpRlhrTDdq?=
 =?utf-8?B?N0N6U2ZrUEFkdXl4T01pMjQxaS9SYU00aC9xZ0ZTdlFHMTRGSlEyTW5rT0hI?=
 =?utf-8?B?eDIyTXhjaURYclB1dTNSMHpnNUhNSWV6cnBTencySng5N0ZVZklVYlo5Riti?=
 =?utf-8?B?WFJuazV0ZEI5UHZtd0QxUlQ2QTh2TjE3amdGTlhYWVI4S0tid0FpMm13TzNC?=
 =?utf-8?B?M2tBZ3AvNFl2YUljZXQxNGhZVTBUaVVsa0xiK0xGR1l5SXgyQmYrNEhXSWdu?=
 =?utf-8?B?N0ZMSDJkQlBJQ1RPREUrQ25sRE9UWTI0THptblViUERrTWJudjA3QmNEdlZM?=
 =?utf-8?B?aFlUdTVwMHN6eGk3eXJBRmNqNFk2VmtFdEpQSzg1WTNHVUIyL1gyQnYvVHUx?=
 =?utf-8?B?TWlQTFNyOWtYRXQwM3c4NXkvMGlZTGNLQVgrdWYxcU0rUmhCbnNhUzA0enJ1?=
 =?utf-8?B?SGp5dUZvcmV5MFM2bzRmaXhLbllzOTNiVzlGekZNTnJoVzByazRVdTUvWjFL?=
 =?utf-8?B?UUJIelNoVmZPSHB5MHN5cFFzMzBCM0lxYXlDN2NZSjE5eHIwUXc4ZWpOOW1I?=
 =?utf-8?B?azdaWVFBOWs0YlZHWWpOUFJLcjZ5Sit0L3NaQzFvUTBRNjRJYmJTZjhNbVBs?=
 =?utf-8?B?cTdhODRBRzE3VS9Fb2VjM2N6WlhIc1BzanBEZmYrb2xjTXhHS3V4YnE0dHFT?=
 =?utf-8?B?RzV4UHovV2tWRE1tYjhwQ3p5dmdRWElEemZyb281U21JTlZHbWhtcGNYRGUy?=
 =?utf-8?B?UUJNenZsOVFjakRqa2tUa1ordk0wNTBoYzJHVEV3N2M5bzVQaVBWRHFIUnNU?=
 =?utf-8?B?YWRnTUF1aGxFNHBVK2NYZUJTeCtVMTdIeE44OU05VUpKa2FtaWpyOUxTUWhP?=
 =?utf-8?B?ckczbVFjdU00OWtYZU9RTWdCNHRybnluOTd0eXBDY0hUM2pzNVZHM1hMczhO?=
 =?utf-8?B?OVdEZll2TWVmaENhdUlrOXk5NDRWKzZZTDA3VVBXK2VVSVl5NjlGYlZvMVBw?=
 =?utf-8?B?dk5INUxVQXVFV1B3YVcrUzJ3YnJ5M25YL2E2VFR4c0pUNHFCM2FmZVJUN0Ix?=
 =?utf-8?B?Z2swTjZiUGVPaUs5RW9KRFNoZVdWMDU5djJ6Vis5MkZKRmhGTGhQTUd5UXQ5?=
 =?utf-8?B?a0lrTFpSRXdvTEFKL05lN1EvYmVMV2JsaW1EMkRONXpaRml5ZHBzbTZ6dzRH?=
 =?utf-8?B?bXF3TmRjcGJqNzdKRGFwcTE0R2RiZnVESm5PSjZ1djRYTXpQMWIzNmIxZlNo?=
 =?utf-8?B?NjNNM0crM05ROFFtRVZvT0hVSWl6QU0yVUtGalRRZzRVTVdJMklhSUlsZVJ1?=
 =?utf-8?B?ZnVMRi9iREhlTHp0dFFIYWZMVDdkQzlCR3BDdUhGalF2dU92VFFaRXczaStu?=
 =?utf-8?B?cWxoUkR2OW5jcEJIYXhabmhSQk53S1lwdWJ3eTZGWGNDRXhKREtFREFva0o5?=
 =?utf-8?B?cjlkdWs0L3lsWE10TmFYOWI5dUd0ek50QUFSN2lySXliTE0ydmtpNDFZZ0dC?=
 =?utf-8?B?Qmt1aEJIb3MzbS9CZlVZM1lmZW5xb1RWbjl3Z0oyQmdtekgzdzI5Zld4a1pG?=
 =?utf-8?B?aTdaajNFaFBIM1ZnamRRVkQ5d1lZYjFXSTBBN1p6YUl1SXl1T3FqM21QdEt6?=
 =?utf-8?B?Nms1TDFCWUtGTXJ4NzUrTDFvUTViOEFNZjhlZlluQ1RFQ21oZHBBYnBzQ2px?=
 =?utf-8?B?VWdBOFdoRHA4Q0h0bGx1ck5kT2VKSmY5RnozNDRxa0kzUWE4UjhaMG5lQktq?=
 =?utf-8?B?ZzZrU2tlUG9TbDAreHpWZ0FXdUY0QTdGanJFYWdFL25DMmpzQWR2U1Vad043?=
 =?utf-8?B?TkdLaW5xUWYwRkduZU1SRjVhTmN1MFp0TVhyTzBzMW94VWRIYnJhRGt4bXhj?=
 =?utf-8?Q?HJArfh9/pBWZ0wZaAKDlt9IsO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bpyo2/ut6rUWR9Mu9vERP4a8xj9tGm/NV/zkRPMwuKnriRZYVvC8Wl0UkLsIJz5ZICWsAL762Dlml5SuED2SPUVHxDMdlPB+wKj+UHGuQpHNliLkk8Is9IsjLLy96vGLuu8xKC+rA+4mY8eWsvTSo7tBYW1aD7aTgdsaodc/hK9la+3k94EdYCMXY10Vldod1GjFgnahRkUiiQJGCkLpCCwAZlc/8rGjIlPVkazMQZ3Q5cauhXDprURFxt/hHtSHG+EMall+CFIIqohRC3d6cecJ7bRzKDK/lBuh6Dpf9r+0A+/KC8bYr2c2MVnaTKe3957KGzSpYq1RS8Q6cHuVXvl1LzuHInxYxdxlMMPukRtj7RivTWsXJ2gLhH7B/742nWDo5dBH4a+yyb4muvTMcIKrl3+YzBe/yW79EMwB44iSf9VPy4dfxutV3gzkXNdskU9IGSt2S6nfuETqj5adMzJCKaQqs8NevDbkcOAyFZqSinQigpU7pWDnonZeYZA0vWvbvJTyhVVQrftIKKcfrNV064LlUXjOrHMo79SxYdt2iyvvH+CA5JaoLeEk9YzllJErIhe+JY6eKBzH7+IV7wjfbm8VOx+SeuwnRG6dKsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83064623-eda9-4579-3cc2-08dcac1176fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:50:19.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhEIoGjpltclen5NRVvUNzWH+TgwC19zSvwxzesAOeroOo09uzCUgjA8BELqCD5/WAA+dBtpbSZC081Xr0YH3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_21,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240136
X-Proofpoint-GUID: lSzfCygFIlCJlRyuBA8Fn69EQR223XQS
X-Proofpoint-ORIG-GUID: lSzfCygFIlCJlRyuBA8Fn69EQR223XQS

On 24/07/2024 01:04, Darrick J. Wong wrote:
>> So why not just enable the per-inode flag with RT right from the
>> start given that this functionality is supposed to work and be
>> globally supported by the rtdev right now? It seems like a whole lot
>> less work to just enable it for RT now than it is to disable it...
> What needs to be done to the rt allocator, anyway?
> 
> I think it's mostly turning off the fallback to unaligned allocation,
> just like what was done for the data device allocator, right?  And
> possibly tweaking whatever this does:
> 
> 	/*
> 	 * Only bother calculating a real prod factor if offset & length are
> 	 * perfectly aligned, otherwise it will just get us in trouble.
> 	 */
> 	div_u64_rem(ap->offset, align, &mod);
> 	if (mod || ap->length % align) {
> 		prod = 1;
> 	} else {
> 		prod = xfs_extlen_to_rtxlen(mp, align);
> 		if (prod > 1)
> 			xfs_rtalloc_align_minmax(&raminlen, &ralen, &prod);
> 	}
> 
> 

My initial impression is that calling xfs_bmap_rtalloc() -> 
xfs_rtpick_extent() for XFS_ALLOC_INITIAL_USER_DATA won't always give an 
aligned extent. However the rest of the allocator paths are giving 
extents aligned as requested - that is from limited testing.

And we would need to not take the xfs_bmap_rtalloc() retry fallback for 
-ENOSPC when align > rtextsize, but I have not hit that yet - maybe 
because xfs_trans_reserve() stops us getting to this point due to lack 
of free rtextents.


