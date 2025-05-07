Return-Path: <linux-fsdevel+bounces-48385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A34AAE0F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4EC1BC5A57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB14286D6C;
	Wed,  7 May 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H8/I3FG+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fo924xRV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18E3C463;
	Wed,  7 May 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625416; cv=fail; b=BLAasyzhqBy7ofHlaF/muArgmKScIO+7hawZQCED00arLi71sUJ4ggLWlMjFDZnMq2iqs7RnDQd10nPcqIyCmqVZ2q4Ne8OzYlodKBMmrm8BXcn1LK0sJssLosjFqitx3jrE+skHX1qua3NJzviVLjgm2wmpP8vuN8qpqJFXVqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625416; c=relaxed/simple;
	bh=iV13jWBdOy0baHB+3eShIcc+AQBOGBRts22FGRjSshM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uk2tE1x4IonEatXYK+FYNlBgJyRt4z1GfyyOoDJNIIKw32iulqWDhcdniaRDZzMMcVTC5JBsS1ZVgqfneF0y7AGVxrFyLhnyW6CYa12n/itrAGZArpb4Nj+RSk9mDMppD815jEyBHobdMnRCprLt1bYnuV74sre5itYWvHCcDis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H8/I3FG+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fo924xRV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547D7BDt003425;
	Wed, 7 May 2025 13:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3rk1+6J9xzFn1TYzpIRyOecktXUG0IdwnATHn2Wbm+U=; b=
	H8/I3FG+2ng8493dQXYIxDvfVMhs8PR6RDN5+gu9K82QILqY0atdUkgBQuKMSD5k
	TPwOZ5QgCzjUagSuIEKGL0OOdKyKnYjHVwjMz1Li9Xg0PtOZhIC6dfS5/1+PbMxh
	Mk68wZuzeTgUycMopXb61vLRDOZw81bAAbbSPgJeKbJJfsJHNuR9+7bSxHhES8NK
	cyWv9Fnk3oyS3dTDu2QpqIcnXFUpAHlujhmGMrkqwx6ZS4Z/1vkHqBiKSoMyuu9h
	uqv0/Wzmv2qAPFfp24xU+HM2b+nz1n3ukEjLnxXfov8XAAC4tBPGHg7twCDjJQbq
	Sv1mw1ssmP5R+CuVDclsvw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g847g2xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 13:43:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547DQplc035339;
	Wed, 7 May 2025 13:43:26 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kaeg1b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 13:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBi/4JXkRt5WiyAkbNZOn8b7w6H25ujEtHDfJPjNzPbKKUvc9wlePh1zXkhK2NZHXRlAgbhMAFdXmiClqPwJqubbxY1Nr0K59Mif/9FxRMUpbkYectbvJTPvtJNPRiExY1RtPp39kN8z/NeQCVnJT+spna+5W/VtNuoDMb5qw+2k+6YoyluWV7a+p+6RaU9fCroH1WQGOd15jSTMyX9pX8HPb6nt0eSS1mPzd3WsjWJ0lCC0CVStAZLUFl+FtZ+DHX0zOxpx86JPpvJdcHDcNl9k4TmShjZYnzJ10lg1NiaATJjvAhtpo1GJCi9erW95dSg6iVgj+bQRI5RYrdbKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rk1+6J9xzFn1TYzpIRyOecktXUG0IdwnATHn2Wbm+U=;
 b=JWkWpw+on9oTUmix7mBAs7yBgZ5I7nW+Mpr3mbzDSCuCEYUSZVbWctq+hd42c9JnKrRTNXKaiQQEJv3lO8k6x1+eCVQrzTdW0Aj7X3AY1mQ3x6Cps8+a0U/nEzrKrko60icly/jr+rkSG7fB6K+gsXUBvo7OvhA/+MZlhvjBLZO17I2h1PFh4wwo4aDhPeveH1seIyrj6xjap3MI2fEonAH/2SxEIWAXG4+gMq1NVQdRQL0hiM8hdfjKCo/na+ojZH7GBC3ctrbgZ7Q5dp10ApLDStQxiIPMVsD5P5KIAdd3FS+7XQDK7X6GPawMac72pASw7PFdtXT3ZMjCGGxtiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rk1+6J9xzFn1TYzpIRyOecktXUG0IdwnATHn2Wbm+U=;
 b=fo924xRVKdfc8V2Z+QTfPD8P7Hy9WmFeLyUs57fXN2ojxsmrnBtxie2keOF7JVjowyWPFbuHT8QIfOneg+1jX48vb7VBiO6zQ5fxWGg4DIc1hMmukfZ8ceUS3SE9YChoig24/3XxfEVUahdtkRqPYz/XqVZeMX2e8jwy3ogxKQ4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4503.namprd10.prod.outlook.com (2603:10b6:510:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 13:43:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 13:43:07 +0000
Message-ID: <79560cc9-6931-417d-8491-182e4ff77666@oracle.com>
Date: Wed, 7 May 2025 09:43:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
To: Dave Chinner <david@fromorbit.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Trond Myklebust
 <trondmy@hammerspace.com>,
        Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@meta.com>,
        Anna Schumaker <anna@kernel.org>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
 <aBqNtfPwFBvQCgeT@dread.disaster.area>
 <8039661b7a4c4f10452180372bd985c0440f1e1d.camel@kernel.org>
 <aBrKbOoj4dgUvz8f@dread.disaster.area>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aBrKbOoj4dgUvz8f@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:610:58::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4503:EE_
X-MS-Office365-Filtering-Correlation-Id: 22733dd1-707e-47e3-30a2-08dd8d6d1986
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?clI4OXllS1pwVDIrNUxNWTJmc0dTdWFUS2dVa0pNYnhtVFM4OGtkVHhNK0Nw?=
 =?utf-8?B?VGhqQkdCNmJmZER2SjFRK2JQTmEzQ2NxZUtuVzBWTHJiTHI0ZzVGbkNPZXkz?=
 =?utf-8?B?WFRKUGhBQ0p0cm1wVVN0NCs2WUxFdEIvSXJVbnlZVkY3Z1ZWNEVIcmVIQk9x?=
 =?utf-8?B?ZDhNRTRYamNXdXZGV3lmeUV6UWFVU3dBbURaMEd4cHIraW0vNXZ1SFNoRmt1?=
 =?utf-8?B?WnZSQWx1d3Y3QWUyWEo4d25CYy9IYUx6NHAxc3ZYYUFDOFBpRnhPenBJQ1lt?=
 =?utf-8?B?bkNqMENpYThIMkJnODdWZ1A0SENtSzdjVmt5NTZaWnM3M0xCS0U2NVY4YndE?=
 =?utf-8?B?SjdXVU5idmhlUFJjNkVBR2dLL29MTkE4elZuRXZVQW41anVQNEVDZTZNdEJR?=
 =?utf-8?B?S2lNNjlXdVA2WHRObE10S2RmdHA3YUYyWkZSVmdoYWFCblFJaDRoT3N0L1pE?=
 =?utf-8?B?dVFoSjN4Zjc3OU5ZWDJBYVQwMndvWHdaTTBPUVNnSEdDbmxrejZqM2k2aEJw?=
 =?utf-8?B?cmt3d0FzM01aL0JIMTd4dTBYMVMzQktzbGY2dFRjaHJTT1UxLzFvY1NmbzhW?=
 =?utf-8?B?cHRhVUZpUXA5MVRJV0E4U1NWUVdjTUZyWEkzM2YvMzVTUW5waTY5aXJEMVZy?=
 =?utf-8?B?bEVtNWV5SElEUldHdnplOXJwMEZ3N3RTS1I3Ym5tb0xCWlVBczIrTnRuSGJu?=
 =?utf-8?B?MTUyOEdiYXNRcEpOWndjM2ZodWlsOEVWOU5IY0gwTzhsY2Z1RXBTaGpkVEV0?=
 =?utf-8?B?WkJrVncxTElSM0lJR09HRnNBTktWa3RDSUlCbTdwTlNxNmp3WWFCZG44Q2FJ?=
 =?utf-8?B?cFBWdVdOZC9wbHhGdE5zR3lScHl5OU4wem56Q3hwWGpCcGNsVEdHbGpwdzh2?=
 =?utf-8?B?ZitLaml3TGJPR3pIMVc5ZlhXeW9sRmMrOTA4VzJBTFJhblMzS2FlaGdUdXE1?=
 =?utf-8?B?SEVoOUJlcFhvZE8yV3U4c2gyTlNrRmNjUm1TUHFYRDAyMTJHZWhPQ0UvRit4?=
 =?utf-8?B?TnZobmtRSklHRHBSc3prUE00cXpDNUJ6V0hjeUE1ZEhzQ1dXcGRYd3VncDMr?=
 =?utf-8?B?N0ttODdPTG5rU3VwOWl0UjZCcjR6NVkzbG01NDZDM0ZGK2xHWGxUM3MraEdz?=
 =?utf-8?B?L2tHaXhKZ0F2Z21Zc21FTFZFY3lwaFBCWjcxMVVzTWcrUC8rQlhUS0ZRMXBU?=
 =?utf-8?B?a1doK1ZCZlhEYTM4SlBGTHg1VklCTTg5YmV3QnB2d0NUdmhxUFl0TWV4S1hs?=
 =?utf-8?B?M2lnaUZJY1o1NjZrYnBhWUFFN1lzakdJYnl6WFVtUUc3Qjk2UW9VZ0FUdUMy?=
 =?utf-8?B?QktWY052UlZzSXV3SFBKUXhpbzk3SWVHU3lEcDBneW9jY08xV2RnNS8vSS9D?=
 =?utf-8?B?WDdvckR3cU0rZ1hwZzY1cm92V24yYTI5Uk5UWG9jU3hhN2xBeUx5M05HWTdW?=
 =?utf-8?B?QnJaUUx6L3NudjFSSFRxQzd5elhHa1Bhb1FmdUU1R09sYkU4SjgwSjJ0bDZt?=
 =?utf-8?B?Z0pTSXRZelp4MEh6N3hRUWw1Nzd4OFdOV29tVjg4S2RsdHQwaFo1UDdteEIr?=
 =?utf-8?B?NkYrQmlsU3diNEZieGNVOGJOTkJwMW9rbGx0V3JHUlZJV0g1d3F3elJ5dHhF?=
 =?utf-8?B?ejFoOVowbE83b2xMcUpLRlVZN0l0ZFBka0JQSlNvWlVFWTFKa3owTTBnTDhY?=
 =?utf-8?B?ZThSeGg3eGQvRFdZMzFzaGEyVGZTNTVVekt0NDh1ZW5mUW5pYUFwQVZyOEJB?=
 =?utf-8?B?Z2RyclBMZWV3eXpJN3NJcE55elAxYTFLT2xNKzVDdnQrdU04VU0xTmNIamlK?=
 =?utf-8?B?VERwZG1CdDFEVjVkMjlyRHMrUS9PLy9nejltTG4reFY2MmJYeXBYQ1lQWXVP?=
 =?utf-8?B?cnVtSFNTZ3JzeERESmdEZGNwK1kzSlNkUHhHazZvOE1rOGlzdmdSNzhRaXNQ?=
 =?utf-8?Q?fd3QatJYUQA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VTAyNWg0b3k5RkYwbUxQSVNEa2FaYVRLNCtqYnc2dWlqSnllOG95VWVOTVIv?=
 =?utf-8?B?blNuZi9xa3ZkNmIvTEloV3VZd2dHT0hKS1RvOVVPL2JjK0RTZXplVmV1SG1v?=
 =?utf-8?B?d3krQUhZNXgyT2h4OHZwMWlEQlI1ZnZmUDNKYjJWeHlqN0pPMG1GcFdJZndj?=
 =?utf-8?B?SS9vZTVYb3o1TkhQNmxzZk0yaTVaV3FOMkZSUTFVbENlbkMvWHJ4Tkx6dk1n?=
 =?utf-8?B?c1k4ZGVVbC9mS0t5NTJLR213M0NrV3V4ZUllVGtRemc4TjdmR0dLT3lWd2ZZ?=
 =?utf-8?B?WmNwbEl3QXNzcGNaNmVkZFhZTTlhMXRBV2N0TkVkVW9Bd0xPZnBhSVppNHFU?=
 =?utf-8?B?eGJZMklubXFrak82NEhQS1hnd2JvNmRRV3I3TEY0ZFpVR0cweHo4bHFQZnlH?=
 =?utf-8?B?SjBjdzlTVklFQUdXNW5nczZ1VmN2NGNyOUZIZDI5enNWUEdtY0g3M3JQeFkv?=
 =?utf-8?B?MS9JMkE0YTdpNzhpTGhNZjBwL2tXS2J6YmRydWJPOVVjT0tueUJnbTRzTStE?=
 =?utf-8?B?TDVnelR4QU80dEdVQjhTZzF2TFh0QkZ6c1hLR0l1YkQzZi9WdEoraVpwaktz?=
 =?utf-8?B?Y1FvV0cwallyeGRKTFRzbTNxTGhjaWo4azhTMEVIZXJEajFjcDFjc3dDb0Ry?=
 =?utf-8?B?MXkyRmN6L01lcFBzT1VMa0YwTE5selBnWHRzaW41dnZ2MjBYcURIY0M5Mlli?=
 =?utf-8?B?VDJSK1daM1pMU1lHSmhlbEdKbVUrNXNLVHBmSXJrdkFDK241dG9tYjNPVDRE?=
 =?utf-8?B?Q3N3S0prTTFuU0k0b0IrMEc4RHVmQkdNMjRBZ2VNTndnV2JHM3paczRoWVlx?=
 =?utf-8?B?K1h1cFBFSGpzTS9qZzRBYmNBVCtVckZUSUpiejNDdDNMQnlrR2lMOTk3ck1T?=
 =?utf-8?B?MVljZ1pVWTZaZzZYQmtRcEgxejFzdExoL3FyL01DZDFMUjlSRElvVXhZL0FK?=
 =?utf-8?B?Y0dkcTdUZkFMNmZvUUpseEVTNUlwU3FueitZcU1IRllSQzVGWkRhUGlDZWNx?=
 =?utf-8?B?ZXlZNGZPcHpYU01lcnNDTi9ZZG5YUkx2SzBiVGtHNTREenZnQnVTWGF3MmVM?=
 =?utf-8?B?TXRCV2NQQndmN0RITlIxbHNOZDdrTWdYbkw5SHJHYXltOG1VSm1EckpBUTA4?=
 =?utf-8?B?dlFHcUo5UTVLeGp5a1BkcVBSTXdJbFdWWHFQMHJHMHBSQks4N3M2RmdtWUtL?=
 =?utf-8?B?bnViajVWTG9PS2ZDQWNaU3h1aHZUbmVZeDJBcTFWVit5RkZVVjRMajF6a2Nr?=
 =?utf-8?B?YTUzc0pEbVBnYTB5cHFZcU4vWkZiOUFYOUhQdTNHb1J2SzNqYit1K3lyVG1U?=
 =?utf-8?B?Vlh4VHVML0NKQ004U21MZ2RxSFlFcUIrWDRCNmxmNU96SmZZbHZWbUk0Q1Jh?=
 =?utf-8?B?cFo5WE5Bb2JxZjNUbFZscC9Db3RRYmsrVnJMSnArN1NTdzB4MGdNdS9VRlB6?=
 =?utf-8?B?NFZUOVRRTS9oZjlNMmJiRXJiREo0ZjQ1eE5qcmRoZ1BBTVFMTjkvNENiU2ZR?=
 =?utf-8?B?UFNVZ01YQ3k1SlVDL2dLQ3dDNXZhMlJEanNFRHBuMkdNZFlReis0a3cvYWVB?=
 =?utf-8?B?QXl1YVlWOGc1bUN4MzVROGExUktveXNhajNSbFVrTE9iTUhKcnlLR1h6c3oy?=
 =?utf-8?B?SzRyaTh2MTBNc09FOWxZTnk3UkF5dk5XZE5HN2FsK3o1NG1hQWJweVkyc2xa?=
 =?utf-8?B?V01sb205MDlwb3dkWkkzc2JFV2pVeUU2WmNadi9RTkowU1ZsSDMzNVJFV0hW?=
 =?utf-8?B?MHBQMTJYQnJCSkViR0FlOC8wWXpERFIzZjI1cmVkSW5nck03eEdmeU1Bekxh?=
 =?utf-8?B?OGovMCtYMkhiNFdvYnRvaTFxVDd0b0trZjRaOWJPUDYxTnVUbkFKWHNTNk94?=
 =?utf-8?B?aHhUYXFVdXJ0SDlFL1QwVDVCaHZuWWRySG5kd25iUkV0QmRIZnZoN1RWRHA1?=
 =?utf-8?B?SWdTUGpyNjlXR1RRdnIza0V1cDBEQ0xpSGpNSlBqTTQ5emtwdGpzT010TnlV?=
 =?utf-8?B?STA4OG9DNHhiVWRmTnVIaDNyOUc2c2xqNWxoanA3RTJFd20vekVLRlVxY3lQ?=
 =?utf-8?B?WUI0VFgrb1p4ektHeXlpbE9OZWdnZGhWeWpxVW0vTGFlOXRpU0xUcVNza2Jx?=
 =?utf-8?B?S0p4UW1aMmdqVmZ4UmEzQkNVd3pxQVJTWGd1dmN4RmVzMTJ1MUVsdXVYRUJp?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QqZccHgIrozJR1vZwT0sINRcV8kbkSXUoCRplnPqZZyfPiCAi2E8Z934WcNTnXvZ9xp+6GaMyvW4SKXf5lK0D83i0MEPPcWOYIACw+rwhzPLGH9rYMIQqHTYSAwsJ3zf5DvNrVPjCDeAnyyJ/XOv1q7eI7RHdmOxtwOWHtR0VHMDsf8+URUrUZ33waB4BrMat5csT8oVGwQclGNL0Qj4Cm3E9UpPtgMs7xAXI+5p7UVmlh1nxZAa9hC2Fj8oKsXQGd/aynrUDFyY08t1fML/3jBgW5EmMTnk3QadYJEp+uBlzzuuw3VJr9GKDNZlDLxUVcLpPjfP0iugqiJTKAR7EusMhZMpyBJ8uIxXEYuGOeZ2q5ELRGhZVxVuRTPMMaI6IzRtslNwQkyL1TGv0QuXSNjNUtS35pA0aPIUjsH3IehAROyp+TtFnNAb9qQHKhjvJjZGn9TnKp16Hdwg0WY13HNgXeN094bnelpc93AwqwQmDBRO+qDJHv8kX/6S7HSBhWni9zirytmZXjSi7owBrTpyZ5oqG/k463LUqUBBvfBOaZynDJUID6DLKEtGhOZmQ+cESWGG2iKEf5NMZ+0xo/1jlXPwilyKVqlo7SZkBQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22733dd1-707e-47e3-30a2-08dd8d6d1986
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 13:43:07.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIH71NOAufNF2L2Z+gNlhrgpgPc0paqGMwv2YFefIDGrYiULdL+OGBOgsidQ/ZWLR816CLkaegTheTX9c2IXrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505070129
X-Authority-Analysis: v=2.4 cv=SvmQ6OO0 c=1 sm=1 tr=0 ts=681b637f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=j3XS8_TttYIVoZJDNx8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HIW_5PmoUkKaC5FkqCLhdWpTYFEFI_qx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEyOSBTYWx0ZWRfX+ykHs8FIvG4T B4+IgTkmMoPPIPoNvtbRUurUFMSqxoMEevi2CFfBf+OWfL0NZbJw1MFp/aQ++99mRTPzS+YAsV5 gGAX2CPkC8QbEsuGAzYdRarr6qcVNL3WjJD4KygxuQXaT1IirJmmjEuAn8mJCeNdsTYniNiG+Pw
 fhvBzQAWlNmIhRc5c7Lsu/SEOcoYqvJMcJ4sDIQ8AR4QgZ4OixcV85w3621iQOBjLbXCvlaxx0z oEanwQGgoXfd0ynQyH0OC+CTdbK1x/sSpIACzuFzXZ+vuai1FTTtIXQyh+3L1+ewVKop2T/spKi I5Fd6k0FfbdLwGo3U3hrOULHh7/k7naPSepMuzRTrtU689p4i1zCOOLjsX4nSdhlGtmg4gsmGeX
 t5ivhP7MEk5CDGkWxAiH0GShHvAJqAKvnVHOZdlpEmdc3AbksgYGi4NP+gpgZ588dJ3yqaUi
X-Proofpoint-ORIG-GUID: HIW_5PmoUkKaC5FkqCLhdWpTYFEFI_qx

On 5/6/25 10:50 PM, Dave Chinner wrote:
> On Tue, May 06, 2025 at 08:06:51PM -0400, Jeff Layton wrote:
>> On Wed, 2025-05-07 at 08:31 +1000, Dave Chinner wrote:
>>> On Tue, May 06, 2025 at 01:40:35PM -0400, Jeff Layton wrote:
>>>> FYI I decided to try and get some numbers with Mike's RWF_DONTCACHE
>>>> patches for nfsd [1]. Those add a module param that make all reads and
>>>> writes use RWF_DONTCACHE.
>>>>
>>>> I had one host that was running knfsd with an XFS export, and a second
>>>> that was acting as NFS client. Both machines have tons of memory, so
>>>> pagecache utilization is irrelevant for this test.
>>>
>>> Does RWF_DONTCACHE result in server side STABLE write requests from
>>> the NFS client, or are they still unstable and require a post-write
>>> completion COMMIT operation from the client to trigger server side
>>> writeback before the client can discard the page cache?
>>>
>>
>> The latter. I didn't change the client at all here (other than to allow
>> it to do bigger writes on the wire). It's just doing bog-standard
>> buffered I/O. nfsd is adding RWF_DONTCACHE to every write via Mike's
>> patch.
> 
> Ok, that wasn't clear that it was only server side RWF_DONTCACHE.
> 
> I have some more context from a different (internal) discussion
> thread about how poorly the NFSD read side performs with
> RWF_DONTCACHE compared to O_DIRECT. This is because there is massive
> page allocator spin lock contention due to all the concurrent reads
> being serviced.
> 
> The buffered write path locking is different, but I suspect
> something similar is occurring and I'm going to ask you to confirm
> it...
> 
>>>> I tested sequential writes using the fio-seq_write.fio test, both with
>>>> and without the module param enabled.
>>>>
>>>> These numbers are from one run each, but they were pretty stable over
>>>> several runs:
>>>>
>>>> # fio /usr/share/doc/fio/examples/fio-seq-write.fio
>>>
>>> $ cat /usr/share/doc/fio/examples/fio-seq-write.fio
>>> cat: /usr/share/doc/fio/examples/fio-seq-write.fio: No such file or directory
>>> $
>>>
>>> What are the fio control parameters of the IO you are doing? (e.g.
>>> is this single threaded IO, does it use the psync, libaio or iouring
>>> engine, etc)
>>>
>>
>>
>> ; fio-seq-write.job for fiotest
>>
>> [global]
>> name=fio-seq-write
>> filename=fio-seq-write
>> rw=write
>> bs=256K
>> direct=0
>> numjobs=1
>> time_based
>> runtime=900
>>
>> [file1]
>> size=10G
>> ioengine=libaio
>> iodepth=16
> 
> Ok, so we are doing AIO writes on the client side, so we have ~16
> writes on the wire from the client at any given time.
> 
> This also means they are likely not being received by the NFS server
> in sequential order, and the NFS server is going to be processing
> roughly 16 write RPCs to the same file concurrently using
> RWF_DONTCACHE IO.
> 
> These are not going to be exactly sequential - the server side IO
> pattern to the filesystem is quasi-sequential, with random IOs being
> out of order and leaving temporary holes in the file until the OO
> write is processed.
> 
> XFS should handle this fine via the speculative preallocation beyond
> EOF that is triggered by extending writes (it was designed to
> mitigate the fragmentation this NFS behaviour causes). However, we
> should always keep in mind that while client side IO is sequential,
> what the server is doing to the underlying filesystem needs to be
> treated as "concurrent IO to a single file" rather than "sequential
> IO".
> 
>>>> wsize=1M:
>>>>
>>>> Normal:      WRITE: bw=1034MiB/s (1084MB/s), 1034MiB/s-1034MiB/s (1084MB/s-1084MB/s), io=910GiB (977GB), run=901326-901326msec
>>>> DONTCACHE:   WRITE: bw=649MiB/s (681MB/s), 649MiB/s-649MiB/s (681MB/s-681MB/s), io=571GiB (613GB), run=900001-900001msec
>>>>
>>>> DONTCACHE with a 1M wsize vs. recent (v6.14-ish) knfsd was about 30%
>>>> slower. Memory consumption was down, but these boxes have oodles of
>>>> memory, so I didn't notice much change there.
>>>
>>> So what is the IO pattern that the NFSD is sending to the underlying
>>> XFS filesystem?
>>>
>>> Is it sending 1M RWF_DONTCACHE buffered IOs to XFS as well (i.e. one
>>> buffered write IO per NFS client write request), or is DONTCACHE
>>> only being used on the NFS client side?
>>>
>>
>> It's should be sequential I/O, though the writes would be coming in
>> from different nfsd threads. nfsd just does standard buffered I/O. The
>> WRITE handler calls nfsd_vfs_write(), which calls vfs_write_iter().
>> With the module parameter enabled, it also adds RWF_DONTCACHE.
> 
> Ok, so buffered writes (even with RWF_DONTCACHE) are not processed
> concurrently by XFS - there's an exclusive lock on the inode that
> will be serialising all the buffered write IO.
> 
> Given that most of the work that XFS will be doing during the write
> will not require releasing the CPU, there is a good chance that
> there is spin contention on the i_rwsem from the 15 other write
> waiters.

This observation echoes my experience with a client pushing 16MB
writes via 1MB NFS WRITEs to one file. They are serialized on the server
by the i_rwsem (or a similar generic per-file lock). The first NFS WRITE
to be emitted by the client is as fast as can be expected, but the RTT
of the last NFS WRITE to be emitted by the client is almost exactly 16
times longer.

I've wanted to drill into this for some time, but unfortunately (for me)
I always seem to have higher priority issues to deal with.

Comparing performance with a similar patch series that implements
uncached server-side I/O with O_DIRECT rather than RWF_UNCACHED might be
illuminating.


> That may be a contributing factor to poor performance, so kernel
> profiles from the NFS server for both the normal buffered write path
> as well as the RWF_DONTCACHE buffered write path. Having some idea
> of the total CPU usage of the nfsds during the workload would also
> be useful.
> 
>> DONTCACHE is only being used on the server side. To be clear, the
>> protocol doesn't support that flag (yet), so we have no way to project
>> DONTCACHE from the client to the server (yet). This is just early
>> exploration to see whether DONTCACHE offers any benefit to this
>> workload.
> 
> The nfs client largely aligns all of the page caceh based IO, so I'd
> think that O_DIRECT on the server side would be much more performant
> than RWF_DONTCACHE. Especially as XFS will do concurrent O_DIRECT
> writes all the way down to the storage.....
> 
>>>> I wonder if we need some heuristic that makes generic_write_sync() only
>>>> kick off writeback immediately if the whole folio is dirty so we have
>>>> more time to gather writes before kicking off writeback?
>>>
>>> You're doing aligned 1MB IOs - there should be no partially dirty
>>> large folios in either the client or the server page caches.
>>
>> Interesting. I wonder what accounts for the slowdown with 1M writes? It
>> seems likely to be related to the more aggressive writeback with
>> DONTCACHE enabled, but it'd be good to understand this.
> 
> What I suspect is that block layer IO submission latency has
> increased significantly  with RWF_DONTCACHE and that is slowing down
> the rate at which it can service buffered writes to a single file.
> 
> The difference between normal buffered writes and RWF_DONTCACHE is
> that the write() context will marshall the dirty folios into bios
> and submit them to the block layer (via generic_write_sync()). If
> the underlying device queues are full, then the bio submission will
> be throttled to wait for IO completion.
> 
> At this point, all NFSD write processing to that file stalls. All
> the other nfsds are blocked on the i_rwsem, and that can't be
> released until the holder is released by the block layer throttling.
> Hence any time the underlying device queue fills, nfsd processing of
> incoming writes stalls completely.
> 
> When doing normal buffered writes, this IO submission stalling does
> not occur because there is no direct writeback occurring in the
> write() path.
> 
> Remember the bad old days of balance_dirty_pages() doing dirty
> throttling by submitting dirty pages for IO directly in the write()
> context? And how much better buffered write performance and write()
> submission latency became when we started deferring that IO to the
> writeback threads and waiting on completions?
> 
> We're essentially going back to the bad old days with buffered
> RWF_DONTCACHE writes. Instead of one nicely formed background
> writeback stream that can be throttled at the block layer without
> adversely affecting incoming write throughput, we end up with every
> write() context submitting IO synchronously and being randomly
> throttled by the block layer throttle....
> 
> There are a lot of reasons the current RWF_DONTCACHE implementation
> is sub-optimal for common workloads. This IO spraying and submission
> side throttling problem
> is one of the reasons why I suggested very early on that an async
> write-behind window (similar in concept to async readahead winodws)
> would likely be a much better generic solution for RWF_DONTCACHE
> writes. This would retain the "one nicely formed background
> writeback stream" behaviour that is desirable for buffered writes,
> but still allow in rapid reclaim of DONTCACHE folios as IO cleans
> them...
> 
>>> That said, this is part of the reason I asked about both whether the
>>> client side write is STABLE and  whether RWF_DONTCACHE on
>>> the server side. i.e. using either of those will trigger writeback
>>> on the serer side immediately; in the case of the former it will
>>> also complete before returning to the client and not require a
>>> subsequent COMMIT RPC to wait for server side IO completion...
>>>
>>
>> I need to go back and sniff traffic to be sure, but I'm fairly certain
>> the client is issuing regular UNSTABLE writes and following up with a
>> later COMMIT, at least for most of them. The occasional STABLE write
>> might end up getting through, but that should be fairly rare.
> 
> Yeah, I don't think that's an issue given that only the server side
> is using RWF_DONTCACHE. The COMMIT will effectively just be a
> journal and/or device cache flush as all the dirty data has already
> been written back to storage....
> 
> -Dave.


-- 
Chuck Lever

