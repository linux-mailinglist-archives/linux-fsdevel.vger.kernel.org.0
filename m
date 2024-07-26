Return-Path: <linux-fsdevel+bounces-24324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D83C93D4E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 16:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A65285138
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261D49445;
	Fri, 26 Jul 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XvPibVU3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ESQO5GPV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BDB28EA;
	Fri, 26 Jul 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003290; cv=fail; b=kAQQaK98N+Nujb9K4aUWE9zs51yEoXu4lN25VaVDnu3ivDtlYQhVpYcNf9uja36AdnYM6k44oMkyO3DadZz69pRblkgMXR7CaFfQ76qf8PcfofblDkWElAKfK6xe8KC74gZPrV9qNjCwU5nZvECUsKV53LQfz7WwyIcO/qh8W0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003290; c=relaxed/simple;
	bh=g0r9ljjnjz0g7C3SiXat3SRthUGh+k9EgHN3vDU/euM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6vAufTgqJYt5HLY0JpZeChmYPPrvTOlWD0q4BkoMM5JHIh+5Pen56GEF3NezMu5CcE/egrCx74EEa8fuoj4PqwRZF4+QfR4vY6z5n6z6rR3hUPP2jBm9r7MSWLX/gHBQXX/zIuv85MXWY9eUjWc3lM03EpM2TcpqnIPXWmsBm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XvPibVU3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ESQO5GPV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q8uI4u007856;
	Fri, 26 Jul 2024 14:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=RNwsIFd0G+9NHQpv6uhdm8ZrobTxMVKMkUB3RttPw6w=; b=
	XvPibVU3w3XFx5/LZj8dmpGHobRPq14ggyGmHT3bFzOrnlA04oFQoOkGZNLrTos0
	7XAha0E2LOxVPgEA2iJ6fC9K1O+Jj4WRSQsuTYNB3OXnbowZmLThOTgGVXnWwkb3
	0WdBkn/0nWIiSwqPsmdEgj6YDuBXBFQ4rIbKXFRmwKoWaNZWT3MjRGVyE4+R8Rzw
	QFpfvcKlulW24Kn26wARbyukTYzBT004K4hiykSW781SmLZKSjHPs0R6cae9HxjR
	I7/g8fOZz0i5pHV7v71OQ+rJ3JJoQyutl2T2YpeW3HnPDd3d07k/Pa8LETMGo8IP
	87FwFDctLp2FFIU8wZjkUA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg115cm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 14:14:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QDNPlN039007;
	Fri, 26 Jul 2024 14:14:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29vg8sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 14:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQSa0SSHwNAQ7Ytud0Vr4hz6IyTxOL7zkNEK8+SKSeuOMzEHmiharp9R2doHtkibVt+J8Nz78hgdvB7W66ndYZ9dq9/FYDwv22Ctf72zhG0X77fe/GAZ6qqKJBajVUK4L1Wd8rRb0T91M54nyPdx2zG3giIFA0wjXwO9sgqJttLG1KqNNHzVb931TWDcq4c8J4NB0XcRdM8qgkYj3b3bughqaRB+7otmGlrwaXkYD1tqQREPQjdmLltUZ1qds6E9py7ZnukAYa2/TN0HeVBRsOwlnSjoh3SkaHULcHWJpYvt9XJ+ku69LwgHDFV0diTk8oRGlC8PQS+1VdJzhJQnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNwsIFd0G+9NHQpv6uhdm8ZrobTxMVKMkUB3RttPw6w=;
 b=PSLjN4R1gR+GysefEk9FuHXiDKTGBrSuQw5YrKPcmMA2PvkFpoZRfujssdm+2BSHGOaW18n9LNG9nHStExiEmk/Go5Zv+TWzV5kkPZgKijNOZXEiR8RofQD895ayYcq8yXpPfZZ4Iaq+/mYXOdw0bqE90FvLNgmXjEs9bqZZ/Dow9rKo1b/yoNe5mGRZ/pzJPC7E86yas5ZRciaLW1KHA+2ozFnO7JxXeubcca9Ri8S2EymTssj3sWBdXllLn7Cx2WIGkacCvnWpbB9pTraIFKaWh/VJo1erRVym+MqhVj5Atkm7/8yP6dLSAb6NbVfP2XB03hGX3KfMdbWn4bAOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNwsIFd0G+9NHQpv6uhdm8ZrobTxMVKMkUB3RttPw6w=;
 b=ESQO5GPVrjSBwkr4cn2EJh+rytIC/iCU9kYIArZsbGCvRNIRTnvEf4YnLJEXK98q79TmDaDW2GMWi4tUwD+uxUj2lKjPidiKoQaQKhkGCrDkz6g6gtSkBEJq6mMZZn6clVePhl2ONpNlEXtqtDTYG2yNrQnImi9sYgqG134Hl5I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7257.namprd10.prod.outlook.com (2603:10b6:610:128::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 14:14:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 14:14:27 +0000
Message-ID: <3300ee10-5f70-4ab5-821c-98eebe0f2d9f@oracle.com>
Date: Fri, 26 Jul 2024 15:14:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        chandan.babu@oracle.com, dchinner@redhat.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        catherine.hoang@oracle.com, martin.petersen@oracle.com,
        Matthew Wilcox <willy@infradead.org>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
 <ZpBouoiUpMgZtqMk@dread.disaster.area>
 <0c502dd9-7108-4d5f-9337-16b3c0952c04@oracle.com>
 <bdad6bae-3baf-41de-9359-39024dba3268@oracle.com>
 <20240723144159.GB20891@lst.de>
 <2fd991cc-8f29-47ce-a78a-c11c79d74e07@oracle.com>
 <20240723222603.GS612460@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240723222603.GS612460@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0362.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 982c1573-1470-4ca3-d970-08dcad7d425e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDc2NE9zcVRCVk4yclJIYmFiS0JVZENNVTh4eUtXOHVlK1BjVFFObWc5a1Iw?=
 =?utf-8?B?L2lza2RmN1J0dzdHcUxyUk93dU8yYlNvZ1E5NWQ0bkpWRS90UWl1VU9zblNO?=
 =?utf-8?B?Y0lnZjg2MTEzZU85bW5qNG8zWnFaaGpzWENTYTZ4V0d6Rm1XYi92QVYxUjNM?=
 =?utf-8?B?Y3hEM042R2FnNmVkSVBUeDRWcWpHM0ZBNVdCN0FMMXBxMlBvWlp2NEcwRlNv?=
 =?utf-8?B?eGtYNkEyUDQ4dGN2THR1SXVlV2F2UTdMcEF5K3AvVy9icVdJYVFOc2h4MVd0?=
 =?utf-8?B?cnRFbDVNbHdGRHZUN2luUkhlOUNBYmM2ajFacTlTQURBZWFud2h0RDljTldE?=
 =?utf-8?B?UEoyOEVVOFB4UDB4aWtNWnBWQ1I2OEdFbk1NbG5FZ1dDZkRVcXpaRmxZV2Jl?=
 =?utf-8?B?YmNjWm9CRUthQldBTnQvaFA0WkF1RmZ1bFZFQVV6YktZdFJ3OVhnN1VTVmJk?=
 =?utf-8?B?TUVDVFNqd3VaWkVxWXRwNVdkcmxCeURNcXd1U1ZuR2UrR0dHcUNzYXQ4WDAw?=
 =?utf-8?B?dkxGV0Z2M2hxaHdacTVuKzArYzY0Z3lodms2SnFYaUkxRXZ5T2E1WHdJUWl5?=
 =?utf-8?B?RXdrVnJCRGl6TmVIZzVCaFRaeVhVQ0ZHSUlaU3FkcmY0dGh1TFY1NHV3RTJ5?=
 =?utf-8?B?SkcvYlF5R3U0a3g4c2huNFJzTVk3b2dIMUVrZEhqVzFRY21mYWlkcWd1MGEv?=
 =?utf-8?B?OEtReE8zS2VESWwxd1hIaVp2Ty9yL0ZiTXdxQm9KVW1DNXM5T3dVaXVqUUlI?=
 =?utf-8?B?RXo5TnZkaTF4c2pVc2VRYjRKUEh6TmRJNU5KSEJlYURDenZZNGUveEpkMnFR?=
 =?utf-8?B?SDJQL0d1UGh4SGNNRUs3Q3RnTW9XVGR5MUFkUWtZSy90QUJSRUxHVk1YcS9S?=
 =?utf-8?B?WXRnRE4rR1BkaWJQb3ZlNmZ1NUVYcGsxNDIvU09TUG5zQ0lxa1ZpVnpXaHNp?=
 =?utf-8?B?c3lTY3BhU0VvbE92TTdMU09XQmdnb21ndURyTHRQdTNiUUoxTmI1bjdrMXpG?=
 =?utf-8?B?SXJaSCtQSWIzRDZ0SGpYeHNnaW5Cc003NEhxU1FGZ0JCSlNmOUN4cnQxL0RP?=
 =?utf-8?B?QzlTTkI2WnNCeEZoNHhiUU9pVExmRW5vemJXWFVoZWN3elNkTE1WY29uYkJH?=
 =?utf-8?B?RjhxMEE1N09rYlRpTEZyUVJicGhDZ0RlTjFtWGd5bDRQa3RaQnNCZWFmYVZF?=
 =?utf-8?B?N2NiWjh3cjREemJWSkVqaVU3OTFaZHBSSXh0SkR4NzEwUmpiSVVqMm5hNERB?=
 =?utf-8?B?ZEQyV25pK3Z6N0E0a0hRMUpqWGNBcEpvcGNmQUdoYXpCUHh0ek5OZmYyd2ZY?=
 =?utf-8?B?VHZJd1dQZklFYXdDNjhBT0lCMy9mdDhYN3NOR09JaGZYbHV0UmlJSUZCSzVl?=
 =?utf-8?B?bXdmN1VWWVNCR01iNG5YOFhtM0ZhN1hxamxoSkVWV2RpY2lkYm9SNkZNYUNR?=
 =?utf-8?B?emtCQ2RKelhIdXBmc3Y1QlphaDl4NlNsN3RsM1NvWFdaM3YveE1YdTFsSDZY?=
 =?utf-8?B?WkFrMnpiWFAyaXdJM1YraS9yYmFTcGNtWlI2THZldUFQK2ttZjN0UXJsSGZh?=
 =?utf-8?B?OHllQ3B6dGlEVXpEWHFzOC9XaHRYZUhoNk9uYkIrcEhWdjRqSmc5dUZDS2Fi?=
 =?utf-8?B?WXdlcTNOY0Nmb05WM2o3T0lVMXNtTGUrYVlBWnJrRVFuaURHU2JPTlo3RVY2?=
 =?utf-8?B?T09qcG9selRudUZHVHF3VU5sN0dGSjVXUjUrRUs3Ly9HTjRKUVVzSE5GYXJ3?=
 =?utf-8?B?WVQ2YkVkMWhITE5xcHpiQjlodHZMK2Znam43djlJM2xWWGZhS2w1V2dxMVhR?=
 =?utf-8?B?S1IwbGhaamZSN0JnN2tOQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek5wZkVGU1N6Y2grNGhNQ2x0Y1lkOU5XMjUzN3NFRGc3NGdZcmhENSs0bDRm?=
 =?utf-8?B?UDMyTFNUM2xUeGRXa2tkSjZoQ3dJOENlcU5DVE9wZENwOXBKTTc0OHJ1SmxR?=
 =?utf-8?B?UTg1QXJNbkYwQ1M0WkJMOVkzYzRYRkwzMkJ3SUNqZnVPNFJ5RHc0aTVVSGZz?=
 =?utf-8?B?UmQ0K1ZKa1B1ZTVEVVQ0SlNkV1R4bTdhTTdiTGVpa2hWaFJCdjRFZ0tPR1Jn?=
 =?utf-8?B?N3NBUDBISGwwWHdQeThaT0s0NUlmekxZKzVGN25ML05ZV2lpUkJqcVFUMDVp?=
 =?utf-8?B?RDc5b2MyTmxMWXRnUTZGNUh5TUhIV2hEL2NMQmxyQ3NTY2pVenBIZkFxUjE2?=
 =?utf-8?B?OEFzL2o1UHozSFFyL3diSGFETFlaNVFheXFIZnVYY2lrSDA2N0tZQTd3dzFq?=
 =?utf-8?B?RzJHc0F0cExaSDFrNWhtM2ZGYTRKSm9LVjdoRUY5a2RTbE8wdlBnQmhwbzdK?=
 =?utf-8?B?dVRydnQvMG56ek5ieVd3VXpPb0NZcHM1K0pTWWtyUEFud1BoZ0t4RHNHR3hG?=
 =?utf-8?B?bUdIV01UdWZ2R1l4TDc1L0FhZmMveHZzNFRLVWpyaGgwUklodVFhbUxNekY4?=
 =?utf-8?B?MHZFTXRsR09ZWGpQekpOREFHUmF4UDE1RmtlWFVyU0FzQk0zMjNuU0UvOUlI?=
 =?utf-8?B?bmNxeERZWmx4UXdEdVN6VGlzYU9Wb3NsVmJLYThybDFTVVJhZS9nUkM5dGxp?=
 =?utf-8?B?WEhNbjNjb3FpeFRpWldHaHZ5T2FIZkhTaTdkSnhkU0hoaFY4WERjbXJ1ZFVB?=
 =?utf-8?B?TWRjRWFKd0swMmdzbW85ZHlHdVJEQWRNbVJEdjN0a3N3TS96d2VYeVRaOWRP?=
 =?utf-8?B?UzFLUDJJSlVBYkpvZEpNWGlNRW03aUg3QkVvNkU0bzAyT0pJbE9paUtBNDBa?=
 =?utf-8?B?R3JjMzZFazdodW5qeVNOMGh2V0YrTmRkQWJBdGRjdXFLNFo2Y1EyZlhIM1po?=
 =?utf-8?B?cW90QTg1Z3J2KzJqdStjT25TRkpyTWg3ODlUd0tLMWd5U2Y1ZEtRQ3E4NXVs?=
 =?utf-8?B?Um16YmFVb0VSMHRqUGtBanljdjUvV0hJSVFVYXkrSlluOCsrSis0K1RubVV4?=
 =?utf-8?B?YnNLWXV5ckQwanN4ZGFPODFWYVhaNDVQUEFuWVg2S1ltZmpBMUp4MmhPL0tH?=
 =?utf-8?B?UElPRGtyZTNPaHgxb1FJR0VSV1Ftd29PendHdTdQbjR1cHU0c0h1N0pXNEpj?=
 =?utf-8?B?cjJOTng0cnV2emloNlRuN0xMbTVmOElYUmRBQUNrVkF3a1pEMFRQbFZuTGE2?=
 =?utf-8?B?YTJUcWRkaXg5UE5kQnBSTktaNkd6OW5DZTNuUzIxOEEvWEdIUXIrMExuZFZ2?=
 =?utf-8?B?Z0thOGhIc3FlaUJnbGl4R1FRU1pTMHJBdUFQVE9JcjhTYXVtR3dtQzhURmR6?=
 =?utf-8?B?Q05ZV2NQSjBxWVhDNld3eXYxcmNFcnhROFBYZTRVUGk0anYvMjlwbGErZTNi?=
 =?utf-8?B?bGZpd2ZhZzA2Q0NWU25tbE83b3dQdzFEWEFCTG1uWk8zM2lGOUZiQXdWcnh5?=
 =?utf-8?B?eTZqVFlzK01rNHBpdG9JcG55Z1VrdTBUc3o1dWtMQytlTzlSQlRvL1FLazJp?=
 =?utf-8?B?Z3lYcE1yZWNMTm9Qa1Z2UkJUMVhIbzBsLzRvSWozVGZuVHNkZGRMMDZITDgz?=
 =?utf-8?B?LzdJY1YzK042T2U5WURtL1phck9wMUZoWGRKM1VHNzY4a280UnlJWHFtMjNF?=
 =?utf-8?B?c2NxNC9YYWcxcUhUWGpBYWNKd290aWF2OFBmM1B0MW9vTWRsRzZqY0psaURx?=
 =?utf-8?B?V3BTOGdRYU5hdG8rc2tpV2UrWGx2RmI1S056OE5STmpHckZvVVVFVVo5LzZr?=
 =?utf-8?B?bmNKTDl0MXNUbDg5UzFhWkFZYTVjZ1JsYzh1dUN2WXJEdlc2TTFyQytsMGVw?=
 =?utf-8?B?eGtUcWN1MXB1NC9xejlXMDJiTmg0ZnBDaXBoeU9JL3JtUVZhTnhaYS9IdzB5?=
 =?utf-8?B?Q29kdzVlR1BydmFRZk85eXowWnNFdmh3VE5KTk14SDhDOFp1QVVYU3ZkbStq?=
 =?utf-8?B?T3JJVmtjLzFxR2MxalNZbWRrYVN0bW9pcTRQQ3UzQ0FJYng3SUF4MTlSekFi?=
 =?utf-8?B?MTdyS1dzOCsxNm96LzZMb3V1QjJ2MC9zQndLRnJTaitGaVV2Tnp6WUQzZlFq?=
 =?utf-8?Q?NYbzWbiL2u1yJqXrpqetxa95R?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9m1+K3EnlPtmo6BFvjCu0edESodjCni/cjQTtY7WvDis1PYPeeS1rgc9A9eusOvzdHsB9si59XjiGtTxMKM9OxSmQRTo4LDsKi8VBj87luS1F1JzgWjRevgWSPJoarH4qvZyeank+/ubl2+ELQLtyqz+idNpSrDDsC0PhLQjwE+M+P6F9mt+42aNLEsh2WvTQ4bIoJtyhLwbzAaCG7StGI3C/yxyvkoqU7qGcyIyauu65VdWVK03gb8+wVfxT8okzAw0S371mVUm0HCbf1IRS3jl/TV+X9TPTAFGdeO7XmHafOwCFVJl9mVLVZGY/Kh4Q3v4gDJ2E5rY4VkDC03SAaw4iqnH1NOa/FyqzehVjon7niV9nhY1aBOMbqphmbA82XoYqayAYzhPn37jBc58e1xG13GbpBEi0L6ri/LzGhJzwck6S7b4Yp4eRzSxRs6Y7v1QVt36HBZcacS9+cNTUkgTbkxB9SSs0S0TCsPYnYEy9HtC7rh05pwAOMevRi1KMq0Ff6wFMYdZEUk+T1ykVpp/JI3IX3qZHBZFCMN/fDxjJz0W9nBEKZG/n/EXTRmxuJjslPgJwtjVmbM1OLZODXkh1oMdYIDGoJXK9/Mz2Lg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982c1573-1470-4ca3-d970-08dcad7d425e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 14:14:27.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPm+nq7SIOxKGCLKUvpsPyAl3tuNWrt7S31abqhJRFKhWKxaZ+zqR1SRfYHozx9q3a+UiOhg4SuIgwKzD/c/5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260097
X-Proofpoint-ORIG-GUID: jEHR9LtfG0Iv854PIBdjmEJajhL5qwmY
X-Proofpoint-GUID: jEHR9LtfG0Iv854PIBdjmEJajhL5qwmY


> 
>>>>> So what about forcealign and RT?
>>>> Any opinion on this?
>>> What about forcealign and RT?
>> In this series version I was mounting the whole FS as RO if
>> XFS_FEAT_FORCEALIGN and XFS_FEAT_REFLINK was found in the SB. And so very
>> different to how I was going to individual treat inodes which happen to be
>> forcealign and reflink, above.
>>
>> So I was asking guidance when whether that approach (for RT and forcealign)
>> is sound.
> I reiterate: don't allow mounting of (forcealign && reflink) or
> (forcealign && rtextsize > 1) filesystems, and then you and I can work
> on figuring out the rest.

I'm fine with that approach for forcealign && reflink (no mounting).

As for forcealign && rtextsize > 1 it seems to be working for me. That 
is with not too many changes, so maybe we can go with this support 
initially. Personally I'd rather not, as testing may be spread too thin. 
Anyway, I'll send the patches early next week and we can make the 
judgement then.




