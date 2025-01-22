Return-Path: <linux-fsdevel+bounces-39845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941E6A1949E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 16:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893037A5640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31A214238;
	Wed, 22 Jan 2025 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ojM0RYRB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tyZorGGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F26213E91;
	Wed, 22 Jan 2025 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558260; cv=fail; b=YOCs1CKgXTvZLtFmzG8jMvkhr7BFs1AEvsNfk6IoURvzxf3WSAAi2TVUNJqBi+P+A3U/QmNO4Q0bfb+ODVVQ5kPvlZc+q1rrpr/UDDxIaHEwTTxnUv0ZMYjEzC0GAmSnnHn1Gyx6tf63Y7JIVIJu8Kg/das/yUuXJS3ESsAASNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558260; c=relaxed/simple;
	bh=znDc+mP/r+w+pwJIMbKqGS6wQDJfZ7OL73gj4pEkZ+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qgyLhNdGQ9hQjN/ZWUtIrJ32BmnLheQzx4VAp9H18GxLWtxNzCDP5UUOIJloa1UejPizsXG0fm/WoB/JWT91P6Z2asfUuZpT6lV+AdsTzIUHGmqk0MfHjwtEsweX5dpdedXZTmJv4+yWeSuE78lt+kC4K+zGwZIf82Ix+lZ587M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ojM0RYRB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tyZorGGK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MEXlIW023239;
	Wed, 22 Jan 2025 15:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PwClu42LlbdXxZ9Pi1+S6EZI7ptPj57YLb0CsavD0tk=; b=
	ojM0RYRBhwhr9ksWQTP2Mzmt3vlKbNmwDnwUnY9bS9D/OY4goAXuLd9weXlzmAhd
	XMDuf0wLa+zCH5KYu/Hg6CQhgiGwmqmmPfDR1ybeH+793VRwgw/E01kWD/ElxS/Z
	SAsKCddF03Q5tlzraMFcOwKVW9cPxQSUoHyuUGQ/shyZYqFZ4Hj9thGus872ASJZ
	rs+HJZGY93R+QYoWlDi5jDKPt12BwP81osu0VafKc6q3e2lrfIwgoZsTfDRl1D13
	nBVaPdnT5FLxckPVVwqdyMVORUvVpw3JyVrwjbCSi7flFK2yTqVZEfM0ZmyzIea3
	/AhsiX1FDsk0SXNvaj1+5A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485rdfxpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 15:04:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MEV0Jp038143;
	Wed, 22 Jan 2025 15:04:06 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4491a1eakn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 15:04:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cS4FlaC9uJYLp0jPXsoxKFZ0v1s4ul2G0GFO0y7N6QysRXBAaWF8gKqWzfU0+C55G9iPLSxK1HuuZqTj0uU5VdOBrdySyQpxfkkN1WM2l/0bVX0ZywQlHOPUJtAdpaBSo0woiOBDxbI8+o6zAkjeOxIT+IsRTsVhyIYcrOmRKXuahVCmBpeIH7ZlYh1rHifNwPMc65IP7i/s5TVxFixDjByXcaaJvcW7uq43hls2sHLBVlMgujhSg2JPn5PRjKpkNuipH7lbY3hWmSIHLuDaliQNQCpJIFMC2EJAxqnZoSzwOqK6upkFnxuR3VC9RA2PFUNigw8ffzDYOssfycM3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwClu42LlbdXxZ9Pi1+S6EZI7ptPj57YLb0CsavD0tk=;
 b=HNlRiX35RrugOIliIO5WgC8VShDdIIO5VH9HpOs+AsvSmoCcgT6PwgX+84F9eBRR0vFQS82t9Ty6BtU+jenb19wc+N6Pw5zjAfvnlJJshhmLONrwiliC3qqWdLhTOuQ5Tj/1Sd8JmPI1ygA50qyINkTgbbzq2Z+ogcrvvmkeYf1l3kR8RhHcAA+KIJHOVcpyo2A+TKJIyKe/osUd4gVo8eUIqmI4O9XZyrvzgl7R91X5OhdC73RMFpTF1j+WKX+cu6a5kYvgCesNDcafDEvTNO8Di8ldzpdVDF35x07RKzHnGEoP+uKuJT9CDNj/OSV7jtyGMXA3IAG2kQadSrrZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwClu42LlbdXxZ9Pi1+S6EZI7ptPj57YLb0CsavD0tk=;
 b=tyZorGGKCcKNm3bKBY62QTOFpRgZkP7t0VwBzjJMj4VB0P4f1OaqdfWzl/FEl8OU3DFjbaQd8BRBTfcEkyzZS1Vd04rnQ7zvK4QHyP6apuHIbnlZIUkgkVCO0GXs2ZIm7qi3Ge9Hvh6jX05la7SVU0k6IB/zatjhZJkCmqTFkFs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7440.namprd10.prod.outlook.com (2603:10b6:610:18c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 15:04:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 15:04:03 +0000
Message-ID: <c2401cbe-eae9-44ab-b36c-5f91b42c430d@oracle.com>
Date: Wed, 22 Jan 2025 10:04:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: Amir Goldstein <amir73il@gmail.com>, NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
 <173750034870.22054.1620003974639602049@noble.neil.brown.name>
 <CAOQ4uxiXC8Xa7zEKYeJ0pADg3Mq19jpA6uEtZfG1QORzuZy9gQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxiXC8Xa7zEKYeJ0pADg3Mq19jpA6uEtZfG1QORzuZy9gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:610:e6::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 9feb7e6f-3f37-4f13-ad72-08dd3af6029b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2hQVkVZLzZNbTJZei9MZm45R1h0aUJVK3o2MUNqeDNybUd2cFNkR04zR0FQ?=
 =?utf-8?B?KzZTaDdFN0tYNEFnRGxzZ2U2WHNUQTZOYkx6M0FQRDI3bWNTckp1czN3T2g1?=
 =?utf-8?B?U2pOWHVDRkpYbXhhNFEyRTlwRDhXRGplNkNoWk5UMGI2RGFjd3dQZ2VOa3NL?=
 =?utf-8?B?enhZVUtaVVZGM0h3REcvZEdKNUU5ZkRBK0NrejRJSmVGZDlBM0dETGM2MndC?=
 =?utf-8?B?SWFTODlybEcwKzBjRzQ5VmxvWDdrcGJ2WnYxQjFjc2cxdzdVamVnSGN4Zmt2?=
 =?utf-8?B?U3NkZCtLK0E3RkswL0JnQkUxcklLM3A3WUNmczRBZ1RLaHEvcjArVlVkNVhh?=
 =?utf-8?B?Ti9pV0Q0aXJvMjlLZlhuaWhsakN5emZNbFJwVjJBZzZ4OFRMbnNMQXpuWklE?=
 =?utf-8?B?SVcwbW1sNnNhay9jK2ZiMWhaNWpGRTlRM2RuVkVhbkFtWVhqNlQ2Q0pWQUxW?=
 =?utf-8?B?aEZYbEJVL1ZpSTl2NkZyVjJlSC9WREJoT0dxaGNPdTRWbHhrZ3lZMmRxU1VV?=
 =?utf-8?B?aE1Dbll6YkpTS3lSY0lLTWJOR01vU3VjeTJvQ2V3L1U2Uk5mTmVBU2pWcUg5?=
 =?utf-8?B?M1VsSFNjVmZBZ2pRS29CVWF3aU5HaUlpbzA3RVlGMHdobGFlTklUd3lUSjlK?=
 =?utf-8?B?c0VzRkhRVksvR0ZEb1RoMDdDT1M3QTk3TUVuaDVmM1RtelUySnRkOUJJR3Zj?=
 =?utf-8?B?clJFdFNoOUtZR2ljeS92ZVpTTEphM01TTDRxZThaeWJQT085dExJK2NTTXZy?=
 =?utf-8?B?ODFCbDNrdURFdWxKVXpVNVFXbEdpRStZMndlZjJSZ29BUTRabUNJYVlGeWlR?=
 =?utf-8?B?c2hoY21QemdabnozblBDSXM4MFI1K1Z0M2JpTTNlaTYzb1NoN2I0L29vQ1g3?=
 =?utf-8?B?K0RrdEMwSDhWY2VYaU5JK0VMMzFvbFIrb1hBWmoyN01sbjR4SzBUY2ZkQ0xR?=
 =?utf-8?B?UkdRVzNGeFA1TElOcDA1Tm91UzNQWnM4S2t4WHBtZEtFK3U4VGw5cjg5eDAv?=
 =?utf-8?B?eldyTk1oKzJ6Tk8yTEtzTFJLWXhJZXduUnB1TERrb0hJZGJZMk15SGhNQmxB?=
 =?utf-8?B?RTVrTzJVQnNEdWtUdm0wYXNYdkx2SE5IRlR4M0tPcThKaEdwemYzaVRESlhZ?=
 =?utf-8?B?STRMdFkzWmlRcmxZV0hKWUZqZmVTdHdxQ1ZYdTdXNVlDM0JqWEp1cmZOME5X?=
 =?utf-8?B?aHhuc0dZaXhBU0h3WmVrZldNT3RkQ3Zwc1ExaktDaUlVUWJBWk5SbktUK3lv?=
 =?utf-8?B?ZnNGK1pkV3BUbDRpUWdZODFSaW9uUGEza0ppeUZIK2c4a1BKcFRNbkswblQ3?=
 =?utf-8?B?R2dtUndhcnA3U2ZWTElYbFFKZUhvZVZHYlVYdmVVUXdKUHdJcmZsckFwQlNI?=
 =?utf-8?B?bGhFZHZGR1h5MU9TN1lwS2t6K0MzMzhjWGJVbERwT0M4anQrdFZMZlNCcVVD?=
 =?utf-8?B?R1p5QnE1ZEdSdXowZ0VFSFZxK0ZWZk56UkxlM0sxTm5pL0lkZXRJQ1FUS0JO?=
 =?utf-8?B?UGtwMTJ0YVYrY3pveGhJWnJ2TlB1bFQyZzMrNHdDdkMwaGxaME84SzVIenRO?=
 =?utf-8?B?SXkzWWpPT2VGWlVEQ3FBQU1ud0xOSVRiMEVpVEFCNkVkZkhzajVyTy9VTTZH?=
 =?utf-8?B?WitPVUVKVDJTSWpYSGJmNmhnc1BodE1XdzRuY1pzRjRWTWZacjVzL2FhNUxh?=
 =?utf-8?B?M1BYdUtIVTFSY3ZqcUh3YVpGbGlDVEorSDQ3QjBJTmM3N0YrOHdsYjlyeGl0?=
 =?utf-8?B?OGNzYXUwaVZOcVRGODVxakJIc0RjREVsQXBRM3Zyams1NTJEdGQvdW1JOTdr?=
 =?utf-8?B?eUxGT3pPTFFoRDZpYXUvTkNXYytQYzZvUnNRZUFRUGZva2JxR1RjOXZSd0d0?=
 =?utf-8?Q?wh8iBzdt4LJ0U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3ZDNFVtWUwwTFlNd1EzYzdpN0xiTTErVTVaejVIV3FSWEVaNFg3RGRnMmlj?=
 =?utf-8?B?ZmFpZ2w3WkhhaTFYUUozaUpXblRNaDF5NUNxaElXbVFNeDk5SWZpbzE1VmFm?=
 =?utf-8?B?QTU1RFpsZlJGVSthVzJiVkhDYXVZcnQzc1I5RWs4Y3lWNFlNeS82M2dESzRL?=
 =?utf-8?B?TmU5NzNGemlsTkhmSE9zdkN1VS96cHAxK3RhZFdzTUEwY21HV1NORzVwcUE1?=
 =?utf-8?B?TlRDc2ptUG12K3BsV3MzZTA0bUNqUlNtTjRUWWlJYnlvYW5qeHZjWi84V1RU?=
 =?utf-8?B?MzRwVEVyLy9LSDk1VUVuZlZ1Y1lPNHREZDBLdnVPMlExRGt1UVg4NW12S2x4?=
 =?utf-8?B?RkR6T2c0VVBVRGFocmNEcDNJUFh2MUJYV2VnbXhGSFVpd1laa0ZrS3pnaUZY?=
 =?utf-8?B?c0ZlbG4zY2Nxdk4zZ25QemI1Y1RzOTNVUWdpSmdjSHd6dDE5TE5Scm1lSTRF?=
 =?utf-8?B?WCtNbmFpTHNyTUF1WmlwZTRYOExITVdpYzNneGhoS1JlK0d3NE5Rdmd0MklR?=
 =?utf-8?B?YklSRE1palpkNi9CMyszZ2Z0bEFsV3RyQWxyaE5RZTQrYjVtQ1lVNG05Vll2?=
 =?utf-8?B?VkJDOEg2RXNkTEEzbEhmbmpRaENNZ0F5RTU5Y1h3cDdZeGg4R0xGNXE3Y2pa?=
 =?utf-8?B?b2w2WjNJWnMwZ1lmOUtjdFkrUDUrZWR5eFVDc1Aya1hwY04xL2J4NW1Va0dz?=
 =?utf-8?B?Qk1qcnE5UHRSOFFUTndVNUY5TmRDbjh2QjRGS2g1U2xhZGJwOW1lcDZhVjhU?=
 =?utf-8?B?dVdwYTdad2M5akVwVWlHWFIrMUhXMlhXV2U5ZDltWHpmWFRYT1l1aFlBbVJB?=
 =?utf-8?B?VUNQZDFrSGF3K0xTcEZlMC9JRjBnMkMyTlA5VGloRnJ2TVRBdFh4UHNDQURm?=
 =?utf-8?B?Q1Y2TmxPT3dEWThHZUlwbXhCSzBlRVpFREFkckZkQjBpaTk3MDcyQlNpVGVP?=
 =?utf-8?B?bFhua3M0b0p6NTlSb0tML3RtNmdQSjVnK0htcXdKUlZYQXdUTkRvMFgrUFJR?=
 =?utf-8?B?N0RuRHYyR3psRzdFZW4waEt1NVAybGRtOVNPeEFaV09QdnUxcDV5aGpQL2dO?=
 =?utf-8?B?K0NaMkxPQW1pYWZtWXZGWGp4VUhWZHQvVFFWWXE4REJGZitOVHhmUit5MDd6?=
 =?utf-8?B?YjhnUm5JLzVWOGVFZjVHUm5na0VPUUdJNGhFTk1kbGVJWTBRVjhIc2ErV21m?=
 =?utf-8?B?VkliZzJWUHd0RWFvRDJnZkhBWlNnbFpla1hadVJYMUQzclYzRlFpaUxNMHRF?=
 =?utf-8?B?cDRzbUVGdW9MZk11TEF0ZHFKZEJDWFFyNXNlaVJWVndKeFY5WnJkSzM1TGNq?=
 =?utf-8?B?T1IxS0lSeU03ZEpvSmNlN0ExdjJ6azZmLzBvNzlVRkkrNGhTWmJrOUlOcGZy?=
 =?utf-8?B?eUJRdUFrYk1rbFpjOS9sYlF6RnVjL2Q2NlcvcnAwVGorSHY2Z1R5Z0dVaHlC?=
 =?utf-8?B?a1VpbVgwVHZOTWRnUzdveUNqQmZ1VFU2c1JialNvaTVlb0cwVkxmU2gxQXUr?=
 =?utf-8?B?YWtxemFTWkhOUVlkQmZKcThReVU0eHpWM1NSYjdLTE1lTVJRbVVkemhFaGJ4?=
 =?utf-8?B?K0J5enNXOTVQQ2JiVlR2WHlFZ3g0WDNnMkpSVmplNUJ1RXdER2UzOUV0aTVY?=
 =?utf-8?B?Q0hpK1YwQllYeGd0UzhUQkowQVpNTTJwYy93VWpqVHF6MEpUOTQ4Y2U3STRr?=
 =?utf-8?B?Sk5HUVNKVURTVlFpWGhHK2dMaGYwaUF4aWY1dFFlNkc4TkhON1d1c2syWlFm?=
 =?utf-8?B?NzJqaHJDU3BSaW5pa2wyYnhJTG1JMGs1Ym5pM0orZ1FYVmJDa05xL1A5ckdW?=
 =?utf-8?B?am9TOThvQlRrWUdEQ2t1RVFPK0tOeG9ZOHRVMUNwWGkrRGhLM29XMmlEWWgx?=
 =?utf-8?B?dGFzR1dNN0lvVDJEc1JJN1FsSm9BTHpvLzlZck9VYkVVRC9KNlJwY2JPSmxt?=
 =?utf-8?B?UXViSVZLS1I0dkJIcDVacDRicTZneDRacnB5ZUZuMnI4UWRneHlQV3RVT2J0?=
 =?utf-8?B?NW1ZYjBBWjZHYWdXdVJCVlZQTzhCOThUTFIxSkdFWFZZaGFNWlhaVzhFOVp5?=
 =?utf-8?B?eHlmL0JNeXN0RzVPTGRRMUcvYXZwTjJQcUkvTm5nVVphTVZoWG0zN2dyUnpY?=
 =?utf-8?B?RTl2SnhKTHR6d0N2dVRLdnd1SHI4bTE2ckczMTk5ZVdJVmN2OEpLWDBXU01M?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0zmSlR3Gp3gS3PCFku8607Zno55DYqapWSIZoE591FDHBSiws9TmB8olUuDUtjlBP/UCaXRNZD+Ner+mJdkCvp6HsDjN/+3MelKbmrGG+l6SA3p4GPvsb7SWMmyhse7pa2unXCoNt4KGxrvvd8lW79uv3Xty8llbgFKN6EIDUU8PZjoWXDzV4p66u/oAjSQvmy9Or/Y++P0feOdl9ho1au35L6VSUpCvnyf33Y40b7CO48EK7EatEjmuS3rEfBHCSDDwQrcMk5smzYbyK43EBIlg9iVOvnH4LTt+BNwWrTJUPYF0HQN5Pi7u7bV+OkrO10kvynQ98VCMqiJJJAt/fu8MlkPLR0PRZcrmJlUTtYYpBHeko1nR7F3d4qKNp/sJXGXEDZvBk31KPAstLAEgQNCFGDsMtg2ujM616fGxExjz2gNa8M02uj3zyZBWtoUImFOW7biFVTWCdCE8k9HfNwi4dRMCN2mcn4VCRbn9ucizEEZro75F7+b4vgPvSw0JvSaNsvmwlv5OVI2AFj4XcbW45fO7AWYURBQU4gj6BFgoNJsHliDlXaRbMb8FeWbcmle6iLzM3DSSkbJM4iuwkAn9zF7QN/2JwTGFAAplo5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9feb7e6f-3f37-4f13-ad72-08dd3af6029b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:04:03.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhR5HLko5IMVM+4cHNcUfJa8fGs+XKR4XsIMWFctU0cQBWWHKHBhb0KdqzPw2qlpVk7waEhfU/v5pNpCOHwjxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220111
X-Proofpoint-ORIG-GUID: 1J77mmZ6OYOM9E-wm9zb6pWtoLgb5eax
X-Proofpoint-GUID: 1J77mmZ6OYOM9E-wm9zb6pWtoLgb5eax

On 1/22/25 4:05 AM, Amir Goldstein wrote:
> On Tue, Jan 21, 2025 at 11:59 PM NeilBrown <neilb@suse.de> wrote:
>>
>> On Wed, 22 Jan 2025, Amir Goldstein wrote:
>>> On Tue, Jan 21, 2025 at 8:45 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> Please send patches To: the NFSD reviewers listed in MAINTAINERS and
>>>> Cc: linux-nfs and others. Thanks!
>>>>
>>>>
>>>> On 1/21/25 5:39 AM, Amir Goldstein wrote:
>>>>> Commit 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
>>>>> mapped EBUSY host error from rmdir/unlink operation to avoid unknown
>>>>> error server warning.
>>>>
>>>>> The same reason that casued the reported EBUSY on rmdir() (dir is a
>>>>> local mount point in some other bind mount) could also cause EBUSY on
>>>>> rename and some filesystems (e.g. FUSE) can return EBUSY on other
>>>>> operations like open().
>>>>>
>>>>> Therefore, to avoid unknown error warning in server, we need to map
>>>>> EBUSY for all operations.
>>>>>
>>>>> The original fix mapped EBUSY to NFS4ERR_FILE_OPEN in v4 server and
>>>>> to NFS4ERR_ACCESS in v2/v3 server.
>>>>>
>>>>> During the discussion on this issue, Trond claimed that the mapping
>>>>> made from EBUSY to NFS4ERR_FILE_OPEN was incorrect according to the
>>>>> protocol spec and specifically, NFS4ERR_FILE_OPEN is not expected
>>>>> for directories.
>>>>
>>>> NFS4ERR_FILE_OPEN might be incorrect when removing certain types of
>>>> file system objects. Here's what I find in RFC 8881 Section 18.25.4:
>>>>
>>>>   > If a file has an outstanding OPEN and this prevents the removal of the
>>>>   > file's directory entry, the error NFS4ERR_FILE_OPEN is returned.
>>>>
>>>> It's not normative, but it does suggest that any object that cannot be
>>>> associated with an OPEN state ID should never cause REMOVE to return
>>>> NFS4ERR_FILE_OPEN.
>>>>
>>>>
>>>>> To keep things simple and consistent and avoid the server warning,
>>>>> map EBUSY to NFS4ERR_ACCESS for all operations in all protocol versions.
>>>>
>>>> Generally a "one size fits all" mapping for these status codes is
>>>> not going to cut it. That's why we have nfsd3_map_status() and
>>>> nfsd_map_status() -- the set of permitted status codes for each
>>>> operation is different for each NFS version.
>>>>
>>>> NFSv3 has REMOVE and RMDIR. You can't pass a directory to NFSv3 REMOVE.
>>>>
>>>> NFSv4 has only REMOVE, and it removes the directory entry for the
>>>> object no matter its type. The set of failure modes is different for
>>>> this operation compared to NFSv3 REMOVE.
>>>>
>>>> Adding a specific mapping for -EBUSY in nfserrno() is going to have
>>>> unintended consequences for any VFS call NFSD might make that returns
>>>> -EBUSY.
>>>>
>>>> I think I prefer that the NFSv4 cases be dealt with in nfsd4_remove(),
>>>> nfsd4_rename(), and nfsd4_link(), and that -EBUSY should continue to
>>>> trigger a warning.
>>>>
>>>>
>>>
>>> Sorry, I didn't understand what you are suggesting.

I'm saying that we need to consider the errno -> NFS status code
mapping on a case-by-case basis first.


>>> FUSE can return EBUSY for open().
>>> What do you suggest to do when nfsd encounters EBUSY on open()?
>>>
>>> vfs_rename() can return EBUSY.
>>> What do you suggest to do when nfsd v3 encounters EBUSY on rename()?

I totally agree that we do not want NFSD to leak -EBUSY to NFS clients.

But we do need to examine all the ways -EBUSY can leak through to the
NFS protocol layers (nfs?proc.c). The mapping is not going to be the
same for every NFS operation in every NFS version. (or, at least we
need to examine these cases closely and decide that nfserr_access is
the closest we can get for /every/ case).


>>> This sort of assertion:
>>>          WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
>>>
>>> Is a code assertion for a situation that should not be possible in the
>>> code and certainly not possible to trigger by userspace.
>>>
>>> Both cases above could trigger the warning from userspace.
>>> If you want to leave the warning it should not be a WARN_ONCE()
>>> assertion, but I must say that I did not understand the explanation
>>> for not mapping EBUSY by default to NFS4ERR_ACCESS in nfserrno().
>>
>> My answer to this last question is that it isn't obvious that EBUSY
>> should map to NFS4ERR_ACCESS.
>> I would rather that nfsd explicitly checked the error from unlink/rmdir and
>> mapped EBUSY to NFS4ERR_ACCESS (if we all agree that is best) with a
>> comment (like we have now) explaining why it is best.
> 
> Can you please suggest the text for this comment because I did not
> understand the reasoning for the error.
> All I argued for is conformity to NFSv2/3, but you are the one who chose
> NFS3ERR_ACCES for v2/3 mapping and I don't know what is the
> reasoning for this error code. All I have is:
> "For NFSv3, the best we can do is probably NFS3ERR_ACCES,
>    which isn't true, but is not less true than the other options."

You're proposing to change the behavior of NFSv4 to match NFSv2/3, and
that's where we might need to take a moment. The NFSv4 protocol provides
a richer set of status codes to report this situation.


>> And nfsd should explicitly check the error from open() and map EBUSY to
>> whatever seems appropriate.  Maybe that is also NS4ERR_ACCESS but if it
>> is, the reason is likely different to the reason that it is best for
>> rmdir.
>> So again, I would like a comment in the code explaining the choice with
>> a reference to FUSE.
> 
> My specific FUSE filesystem can return EBUSY for open(), but FUSE
> filesystem in general can return EBUSY for any operation if that is what
> the userspace server returns.

Fair, that suggests that eventually we might need the general nfserrno
mapping in addition to some individual checking in NFS operation- and
version-specific code. I'm not ready to leap to that conclusion yet.


>> Then if some other function that we haven't thought about starts
>> returning EBUSY, we'll get warning and have a change to think about it.
>>
> 
> I have no objection to that, but I think that the WARN_ONCE should be
> converted to pr_warn_once() or pr_warn_ratelimited() because userspace
> should not be able to trigger a WARN_ON in any case.

It isn't user space that's the concern -- it's that NFS clients can
trigger this warning. If a client accidentally or maliciously triggers
it repeatedly, it can fill the NFS server's system journal.

Our general policy is that we use the _ONCE variants to prevent a remote
attack from overflowing the server's root partition.


> I realize the great value of the stack trace that WARN_ON provides in
> this scenario, but if we include in the warning the operation id and the
> filesystem sid I think that would be enough information to understand
> where the unmapped error is coming from.

Hm. The stack trace tells us all that without having to add the extra
(rarely used) arguments to nfserrno. I'm OK with a stack trace here
because this is information for developers, who can make sense of it.
It's not a message that a system admin or user needs to understand.


> This is not expected stop the whack-a-mole of patches like mine and this one:

It will be whack-a-mole. Unfortunately there is no way around that
because of the case-by-case auditing that is necessary.


> 340e61e44c1d2 ("nfsd: map the EBADMSG to nfserr_io to avoid warning")
> but at least the severity of the issues will be reduced without the scary
> WARN_ON splat.

340e61e44c1d2 is one tactic for dealing with these issues, but we do
need case-by-case audit to have confidence that this tactic is
appropriate for each errno value.


> I can write a patch if there is an agreement on that.
> 
> Thanks,
> Amir.


-- 
Chuck Lever

