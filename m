Return-Path: <linux-fsdevel+bounces-51519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B33AD7C46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 22:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4442D3A0816
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B37A2D3A85;
	Thu, 12 Jun 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eGMna+6i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hlDJEgsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD21F237A;
	Thu, 12 Jun 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759493; cv=fail; b=DCBiOf4TeDlFTFbginJdoOMQEkcNHWdEurLi0tsbCKp48NnVuYOdyJY+BVQB1Nn2oFepIGU0FOG7zNsJSZOhB5ZY2JE3ZoogyGo9f3JcEV66uvUP2jvfDQdTBZNWDu4LkeD83LfDNcREwqdkD2DEkRSangt04NY58KnBR959Zts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759493; c=relaxed/simple;
	bh=NXt1M9vVI85GQyM+qRUzoln/AmZ0xOSJGArX/+J9MP0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cq75d6toZ0ziGxmFE2QWvuLCbXFfeXb2rZVuq+ky6+kGsXoTupBR0V9mhvr8sifW9nOHehzkpefrVgCUDOKIru2VbsIdk12z4IQlvEEZ5bPmQ/hF/IjxXkM5JVGRC1OBQFFOuzY3f4bT4V8lCTW3u84AR6No+a6WZcXB5OIR2Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eGMna+6i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hlDJEgsl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CJi6Nw011527;
	Thu, 12 Jun 2025 20:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8BUWiPX9DBp4c4hHLOM+K3EDqIaiC69JmRTzwNI1y3U=; b=
	eGMna+6ieVLxvIsY5MS/39Jn0o6tXn/Rh9yDBmYf6v/wi36YJOHIZr1acgiDF7PB
	pASSXBn0EK29fFsqgUbeK6ytXaj/tKZ5qHDNIeRIPuD+5Xg9kGIRMBonOB6tVRqm
	EdlZiThThCU4yyColsS4w98furrsRyZQQGNLiDVsUFRu6ahKGbq7sJv4p+5giWcE
	NjIZO1yhKQU7VBdgyvki1HyeGl4j3n1o9nk4gFwbmqokA9g5BtUqMGQS2ZrGWsGK
	0RO8bCD1Grkl3vYii5Z/2Al9XqQGLxOuSUtMu1IUKHIxd16eRcuy8zHXwpVypRC2
	QurPnrvsZhqR/xWkthhRuQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1vahc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 20:17:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CIUB9a016728;
	Thu, 12 Jun 2025 20:17:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvc2tyv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 20:17:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xj+ZZT8VgellsaToErL1vE9KOABIh3w9Q9KuMSEZmsuSr5C0iCSUympbb0B5B4ur4qlHkx8A5oyJ3VeQu4uoACLPyuCEjeJ/GtfjapleKTSzIWQPVPZFyoa7d6smF5iA/AoRQtbqR0H20cIWmBF36Mx6S/9t9bjQ7TQaXCGhz4Z0v9K0Ke0zwJ1yEvmwZIO1j7nDZkA4rl657lvTfZ8gRnPXHU7AnU+RgKPGZKVQQN5+exiN1knpAnZALcxP5AiUh0MGnfriGy7IdghfOKkTwDbQXDLe6C7fIFOtNbRdcbzu/IEuVR8fXXytcLLrwl5KGrA52aGKPEQ+9BfBAPlchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BUWiPX9DBp4c4hHLOM+K3EDqIaiC69JmRTzwNI1y3U=;
 b=SN3+jzWJW+5EkTWNAQIVUic5V5HTIb5xzC3jbpaFm1ZDq/QYW/cGpTHg+LnSw1tqncvtyw7YWasLiYRkw49lDHscitRzfLrNPOAF9YleHjpjoit+NzU9Hp7YlvCJIBr1OBKpgpSd4RJxYL6Cgc7moasjYTzssy1SgWumcyxwOl3eNMPIXo1XVTlWk11mZArpwQcQfoQtkkibY+RF2BaTQFPN882H4yjR6Y9Z53J9hpBI3C5RPku8sjH9+DdjFR5Ii2EMmCNT8OCXgUWgbAE0L4pHklGz6FfUwPsHi41PC2vDR1k1o4DBOSRe+Upz6mO7Uy90YQljTwuePBbBJjqVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BUWiPX9DBp4c4hHLOM+K3EDqIaiC69JmRTzwNI1y3U=;
 b=hlDJEgslZDPPjz+U/fcPyGGoWYWykZkcK4wq/kD00MjRFA5S+SR6onuP2qZfxY0/etoic1A4i0y40LQ4Dtz8luvtieGx29cgai3BbXffImmhrwBZ+58yK41aGNLg25lhYK3qV/S11AZ49TnWtM2LlxOtorJqjZinie3cXYW4UHc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5606.namprd10.prod.outlook.com (2603:10b6:806:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 12 Jun
 2025 20:17:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 20:17:48 +0000
Message-ID: <c6cea2e7-b848-4ccf-827d-bdcfd22926a5@oracle.com>
Date: Thu, 12 Jun 2025 16:17:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to
 add DIO support
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Dave Chinner <david@fromorbit.com>, willy@infradead.org,
        jonathan.flynn@hammerspace.com, keith.mannthey@hammerspace.com
References: <20250610205737.63343-1-snitzer@kernel.org>
 <7944f6aa-d797-4323-98dc-7ef7e388c69f@oracle.com>
 <aEslwqa9iMeZjjlV@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEslwqa9iMeZjjlV@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:610:e5::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: f4353076-d317-4624-be5c-08dda9ee3325
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cTZPSlkwenY4MEFoUEZhVHdwOUhvTGdJcFdzWlB6eEV0cXRSSDQ0RkxMSU10?=
 =?utf-8?B?OXZzZXptREtmRVVPQzE4TWR6OVNzU2FPVjVCUXM3RWhiOUdHS3A4RWN6NlIw?=
 =?utf-8?B?dGpBZEl0VzRVaEV3YmoyajFzUkdJQ0ZMVld6eEF5eVlmdmFwTHYvQUZPcDNX?=
 =?utf-8?B?SWZaS21HZit6SGlHdHlGZU9pUXFUWklMSU9iTXdKOVhac2JhM1dTSVR4eWZq?=
 =?utf-8?B?cldTVVY3b1lYUGJ0MDhXaXpKamc4RjJKbHRUNzkvZmMyMjBESWk1V3BxZ2FF?=
 =?utf-8?B?MHNRZFEzWG5nU01HaWl3T3ZtS0preVJFZFpDaEVzU3NzRy9CYThNOFFNazhM?=
 =?utf-8?B?Q2dNR0VOUFhhWkFCMXRuQ2d2WVNhc2pNbXlpbEprUk5WeFRlU2c2aktZc3dj?=
 =?utf-8?B?U29YSnBKMUNNdDBrTHg5ZEZSWlpTMGVuWGo0Q1MrMldGK0FaWjArTDNpa2U5?=
 =?utf-8?B?K2YzQkt3STlxemxJeHk3elhCSnRxbjNQWmJFVmtheDI0Ylo2R09ET3VBdGhF?=
 =?utf-8?B?dE5XVlV6dGFNQnJQdXR4RnV4THN3dW11Nml4ejVlVnY4cGQ1dFpYMFVPMkQ0?=
 =?utf-8?B?UnRuOG5aZS8vQ1pvc1BkRWlKSHN3cGVvRmhkWE8yazkwb0ZENFN4ZmNIRUVU?=
 =?utf-8?B?a3o5TFlqOG5YRUsvMWt3Vkk5Rm5mcjNLdmIxUzZkRHNmNGRYYktnMVNwU3Zo?=
 =?utf-8?B?dlgwRXNmblVZTzZqSGhPRjd3ODBGR1Y4a0k5d2Q0ODU1R3VFMzFTcmxwV0NY?=
 =?utf-8?B?NjJWYkJ2Mi9sV2VuNnZrNlpmSFMzUkZRVGNzSW1Sa0Exc3lRa1NlU0pVYnU3?=
 =?utf-8?B?OVQwQkdXRGZqSTNpWWczb0l2aGpWamZaWTQ4dVd3QTFOZXN2NzZjNXl3TVEv?=
 =?utf-8?B?YllnNDVkMVY4bytHOWx5S1RkWDdkWWd4aW9FQ1ludExJWEZMWVBkL2FwM3o0?=
 =?utf-8?B?YXlJUlhDU3FFUWJ5WnZIVU1WUzVSVlBnNGFwWS9DMkt6ZCtxNGVXa3gxY3Nm?=
 =?utf-8?B?QTZ1RDJSRUZFZ3RnRkVFaTNoSjRVd2dRcFRYcUk3UFVkaCtBek8xbnZPR1hi?=
 =?utf-8?B?MEZpRnFGdW9oWkhoMVAwaHBTalB0Rkl2NDNCYmM5d2hka3lSMEgxYkVLYVZO?=
 =?utf-8?B?SG1KMWlET05mb3kzblk1NWkrcXZTcmZZOTZmbWtGOXUvWC9JMFBHTnh4ZnVs?=
 =?utf-8?B?QUdsQks5TmhpMmh6QzUxTjVubDVHM2RLb0xIVEhCa3REc2JJU3h5V2tPMHN1?=
 =?utf-8?B?SmpkMHEyV2dmK21KZ3hqaWh4VmRheVlSWjV6UjM3TFcrUDF2TDR1UjNRamRQ?=
 =?utf-8?B?NjRjQXc2SkNvZEIyVUhzYlNLVjc5NUZrb1E2ZHdOL3lNajZGNEJrdnF3VEdX?=
 =?utf-8?B?NjlPRDZOc09sVnA2aXRSU1ZRYXZnbG1rNFRxdncrcTAraHdTdmhEZWR1azBO?=
 =?utf-8?B?UGsyRUxiYUduOHM2WEtBTUVWSkxybFZvc1hwNkUrSzlHUVNRbFozdEExU2ZU?=
 =?utf-8?B?Rkw3TEZnSFRSYWtKWE1jRnBWbS9aVEY1UlhnWkVQODY1TE5seXpZcUVLdndS?=
 =?utf-8?B?dTB2MkRBcUhPTWlnYlZsaHJxRkh4YnhOK2pKb2ZSbEFKRkc2bGF6Ti82a0RR?=
 =?utf-8?B?OHIvSHc1T3BrUkdsZmJmcmFWN3RMeTFHSDVaZVRxSzQ0Q0pDVll3VkczUXYr?=
 =?utf-8?B?cmgreWFueXhxaElYZ0cvaC9YVjNWWEJSV1pKM2tSbUxwNTBsNURwSjlKOTg0?=
 =?utf-8?B?RzMwSXdoaFNWZVNHL21TV3dYSUozZDg1Njlnb01BaC92cG9kejRBYmZNVk9t?=
 =?utf-8?B?ZFY0YVVpSzlNRGd1Z0ZTSVVyTVdqY1ZBY2ZYcVdNTE00MjExNGs1Z210LzJu?=
 =?utf-8?B?UThDRWpuRjMzK205ZUY3YWJ1cFN0K0hQYkJvMzZHcDRVYWx2WmgvZXNadmhu?=
 =?utf-8?Q?uWsZTHcIDF4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bGZiSHFpK3ZYN3NXMlJBSFlMT2F6Vm5naFF1SmRXUGR6Y2JVVVlHZXVUU2ZD?=
 =?utf-8?B?S0E3T0RyeDEwMEZkS2wrOWdYbGZZdDRBSFNGQkh4K2tvcThLTUJybFZCR1BW?=
 =?utf-8?B?SzBaaS9neUxWdHI3dEpjT3MyaGF2ODBQY1laeGNNWkYzcE5MUlhiR1pna2VE?=
 =?utf-8?B?SWttNkozNjYweTZ4UnVxUVcrYjF3aVNCRy8zYjJ6VWlOaVVjRGNKeGJXOW1z?=
 =?utf-8?B?Z2V0cDJPbjNPMzkzeXljQUJObWlOZlY2cjRXdWUyYVVmbjJxZTZEV2dycStj?=
 =?utf-8?B?cTJHL1pON3E0YWZWSCtZaTBUdjBWWXAyUkljMUJlTGlOQTFMdHpJOTZIYkp6?=
 =?utf-8?B?TTNEcmFEWmkzcnRVQzFRb0pNam10RWc3MC9ibW91V29ZU2I5L3daSTl1bDZL?=
 =?utf-8?B?dEt2TG5qL3VtTlBCblJibUxuZ2dDcVlKQmlRcHRsVnpNYjhncmhncXVmeUsr?=
 =?utf-8?B?M25Qdy9tNVpObjlWRm9SWGE3S0lsMWc5SE0rWkU1UmxmWDBCdHFqUlJJdjFx?=
 =?utf-8?B?RnlDekhRdW5qcHFVVTlYNXgxSEFxUnFhd1lBYWRTNk41cXZsZzk4cFhvM2hp?=
 =?utf-8?B?aDhTbzJZSC9EZHdJc040eGw0azZqek9wUGE2SWs2cGxVbFhqc2NwckliOWRO?=
 =?utf-8?B?ZW5tVFZLcjMwTURvMUxVK3phM09PbXU0OUp6NTFjK3ZFZEp4TEVwbWNQdmtz?=
 =?utf-8?B?YjNrNXBXS0RQWkxma2x0VlcyejljcTlwdXYzS2trbzRMM0tyVnRqTUxhbFRF?=
 =?utf-8?B?Rk5ianFjUWRvaGw4NnhNVnk4Z3NkRVdEZnp4K0JTNXlQd2toZ1M4aE1GZFNt?=
 =?utf-8?B?UGdEWllvQlBQYW1tRjdabDhLNVJocmFKeG1Ebklib3VRUnRhcFlXRmU4YzVW?=
 =?utf-8?B?VURJckJTL2N4Ty8vajdqa2h5OHJRWUNSRjdwbTUrdWhsSjJBNktEQWFuUHJl?=
 =?utf-8?B?THYxVnFaMDJ2ZlZ6SnZnN2dVQVRibEVTTkhxVXpzVkQ5YVM3Vnc4TkdaU1pa?=
 =?utf-8?B?Y3Z4ZWxuSGozWHlIR242SjI4dWZaVDIvbThHZWdJVjNUbnRKMzF1a3d4Vlo2?=
 =?utf-8?B?SlpmTk9GVkxUODJHRTVmQkl5ZmtkK3lIQWdlQVhhWEFGcDRjalIxdjgwb0dM?=
 =?utf-8?B?U0htMkFuRkk3RE0zWkcvSlpTMUJvSnFyc2lzTEQ1UW9EbFpMNk1VRS9KOGhk?=
 =?utf-8?B?aVVpSTUyS3BzNzFtK1VwR3dYNXFObkZjcnUyaTVLZWtpNUM0cFY4UW5vbDgv?=
 =?utf-8?B?bUUxNmdpT3NqR1hqR3FjM2lkb2VzYXd2VHU4WFRwdkkxeXI3VUI0eU5GSkRr?=
 =?utf-8?B?bFhkdzRTVkNqb3Y1ZFNLTlh6OTRqT3dtSzBMOFlQcEpkSS90MnNnbk5sYmN4?=
 =?utf-8?B?aSs5VGVVZDJGQVdveERCaVQ2SU5XRGloQzJ3U2lDT2hXOEwyK2hoUjVaVHdY?=
 =?utf-8?B?aFpaVlFsSEZrMFF3dzZpejgzS3lYdVdxUHJQOFRUZzdXc3p2VHpZSisyTlJl?=
 =?utf-8?B?N0htSHFDdWQxdXpDdE5XWitPSkMycjhrcTE4dlo2RERrQ2F2RVovY0ZHZ2Ey?=
 =?utf-8?B?Q3l2R21DYkVrZE93aVAzTjhSOUdQMnRycC9ZczJrcjVBMXVtNjBIQWl5UG9W?=
 =?utf-8?B?Vlp1WFpyZVdZcGR4YVdGVGw2RG9ydXBWWG1KSUpOcEpMc28yQXBqNWFzblBj?=
 =?utf-8?B?eHhwL01aL1owUDRWcHUvWkdMa3VuZEpEeC9UQnpCWkw5Y2JPWHB3SnJkczJ3?=
 =?utf-8?B?U20zbVFaS25FWFRoZEpDYWFWTWpGTjY2M1R3bkFBQWR1bE9VTzd6SmRBSG9F?=
 =?utf-8?B?Vzdzbmh3eWNFK2ZjV3ZVWmVFV0o4ZkFuOFBmbm1Tb2NUSlVCT0I0L0pRcXAr?=
 =?utf-8?B?MXUrQ2ZXbUlWbHNUWDNUN215RnNqeS9LVnNMVWJJSVhBaFBGTWpqQWI3Y0VL?=
 =?utf-8?B?ZHo2R1dPV1JZcVErNCt2bWc2c0ZUSnpGeGg5c2h1TGpEL29EZXZjTGZJNmpn?=
 =?utf-8?B?UGpLc0Zwa2plUzFZRW01ZEZwSWVvemt0RERhek9aK0JkNHpMVjI5c2ZCcWlK?=
 =?utf-8?B?dG1qY3FXZ0UwdVk3RU9vc3lURTZTRWtIdk9KOUlYMlFGaXM3MVdLOHoxSjZP?=
 =?utf-8?B?enJWOFhtSEtKWi9YcGw5eXBiMlIzTUJhSDMycHlVN2xXNnVRbDdHZzlxOFVY?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PrtqUNs0N4DyW0booEIKDKTsYrxvxAeiVEzDgsanPiCrOe91ziHBgrMfo6HQUPFyfoCE4ljluAUvmlpIjUjJHPGDdNalWXMQNS6npeZVwTaIoQ7BUeOLu+3F92tIe/P5NE3ED3l387w6L9NLencV9Qr1U/8VEi56CeoSmZxCD7G73IOez25b+P8loBhHiq9B29yrsK6Nnf5T0lTVwgZ5YNTnz5MC15JTS50ErcCl+Lct+hwLK02aYaglTuaxrHH61EM1EL41bs/eTw38SC4Wk68JM5akmRtYXH5MgXL8OJD7Jf+TOCif5F7Ra5F1QqPi7lBIZMg3EOILxZW1P3zqX0wZ9xyZgUNd9SxHuwFMNNdvi3b1ynSUbGs4m3lsvPM7vILaJurzXbR8aCZQrSzA679lF7yoiKmadK0u942vjHY9OAn+E2QQaz89E9Aqm7Kv1dzfu/zWmzHWO7Ml6hITHbyk2BUSRu3NWUnYfPES/kxSupt/uup0rv569+JNVDnNSSHY43lriEnyauF/7rT5ZGV7N3KRSDeXJC1Osox+vRPGsDpIf6QcTs7UaqOtZ4Ta8OTni9kLUuJBV3x5fFLldqOqqbFV8IaUkSeml16lj38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4353076-d317-4624-be5c-08dda9ee3325
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:17:48.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvlPjFu17MLUfVAo5K/o6pFgz/ROu3a/sj8/2OosOYEcNspLf/7SoTljTeKMmaUH1dybudPTTauh7TkEKp+6gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120156
X-Proofpoint-GUID: G3ui93Lg_PmLokX5ezZ2JdgtHLTy6tI-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDE1NiBTYWx0ZWRfX3cOJHzwT+dkn uPqkUBmRKl3IsJdMdy9Qkm43LTPsCjjUmVx/tccESdMjk/ICVeXS9J50YkBlMOw9x8KZsiMWURN 8mfJORmvGNtWsluxhfyump1zWfkkjWJHxiaTRTBnn8jgfhUc+/kKJnD6zhV+PqWfmUPv4peH1cW
 xjeo2Xgoxf9H2m4mVHRP3PaH9Pc+ORTEsUNsM2P1pTieRgAivmh7HkPLWb2OjAPY8BZ9oiMR1UO msO4ZUFFx9iv7D+6GCcDblgIekfLYArdGSGcPybCujmJMYCAmLS+mHyzSA6yQDkK5LCwEeT7l9g lPanjHzrUeDB64vzs9dOC7Oixk2O3DajMeOupg+nQ5OJlrDT/dAybQNSRyCaQWdQXPWet8nxLAc
 DsVwwZ3ahU0ts2r9k4CiWE9h3MFk8YnCdqCvS/abPO9fqT1cXATLwXano9nuLW87H7EfJig7
X-Proofpoint-ORIG-GUID: G3ui93Lg_PmLokX5ezZ2JdgtHLTy6tI-
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684b35f0 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=ruQ5qpa-6hlgn8C9aaoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714

On 6/12/25 3:08 PM, Mike Snitzer wrote:
> On Thu, Jun 12, 2025 at 09:46:12AM -0400, Chuck Lever wrote:
>> But, can we get more insight into specifically where the CPU
>> utilization reduction comes from? Is it lock contention? Is it
>> inefficient data structure traversal? Any improvement here benefits
>> everyone, so that should be a focus of some study.
> 
> Buffered IO just commands more resources than O_DIRECT for workloads
> with a working set that exceeds system memory.

No doubt. However, using direct I/O has some consequences that we might
be able to avoid if we understand better how to manage the server's
cache rather than not caching at all.


> Each of the 6 servers has 1TiB of memory.
> 
> So for the above 6 client 128 PPN IOT "easy" run, each client thread
> is writing and then reading 266 GiB.  That creates an aggregate
> working set of 199.50 TiB
> 
> The 199.50 TiB working set dwarfs the servers' aggregate 6 TiB of
> memory.  Being able to drive each of the 8 NVMe in each server as
> efficiently as possible is critical.
> 
> As you can see from the above NVMe performance above O_DIRECT is best.

Well, I see that it is the better choice between full caching v. direct
I/O when the backing storage is nearly as fast as memory. The sticking
point for me there is what will happen with slower backing storage.


> "The nfs client largely aligns all of the page caceh based IO, so I'd
> think that O_DIRECT on the server side would be much more performant
> than RWF_DONTCACHE. Especially as XFS will do concurrent O_DIRECT
> writes all the way down to the storage....."
> 
> (Dave would be correct about NFSD's page alignment if RDMA used, but
> obviously not the case if TCP used due to SUNRPC TCP's WRITE payload
> being received into misaligned pages).

RDMA gives us the opportunity to align the sink buffer pages on the NFS
server, yes. However I'm not sure if NFSD currently goes to the trouble
of actually doing that alignment before starting RDMA Reads. There
always seems to be one or more data copies needed when going through
nfsd_vfs_write().

If the application has aligned the WRITE payload already, we might not
notice that deficiency for many common workloads. For example, if most
unaligned writes come from small payloads, server-side re-alignment
might not matter -- there could be intrinsic RMW cycles that erase the
benefits of buffer alignment. Big payloads are usually aligned to
memory and file pages already.

Something to look into.


-- 
Chuck Lever

