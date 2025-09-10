Return-Path: <linux-fsdevel+bounces-60770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D485BB51913
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5047B846C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2C322777;
	Wed, 10 Sep 2025 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OoKAai9H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jVIsoDxD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1D0322DC3;
	Wed, 10 Sep 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513665; cv=fail; b=Cj52LnfJwEGjQPO75Bpo+won4C61cd+b1j72Z+VWr16jgaOeZrcPI5fLMolSWkX7EXPoWnkUJ4J5xHmAJ62wBy+0Q2K0QSXKKfaz8MHVFaGhWjXJXpo/mC9SPs0Ej+k1BwgPkYup83QxxDHU1EM477S5gDslscZdSvuEcb7tz2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513665; c=relaxed/simple;
	bh=+Ap9u6IubG775PVoFAejwIpXolVXBV/FFfGmrfzDPn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nG5ZAKLI9DZT7QjQcFWrp1vjEd6wrAShliiHvUUU7oS/2iHbxx75Tns4mOQNfpzsPNQnipGeAHv4vK6bPRC2VqMvSU6YOlXFk/ERZmTy3bLv7A654E10DTd7GrH7Q8iL8mx8+cjCTJg1LGI8fBfMueuZfA74xbsR0XWbjjYDobg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OoKAai9H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jVIsoDxD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADC0Ih004232;
	Wed, 10 Sep 2025 14:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hc+rhyWKVqjh6VVMJsTiOW9E8PI8hI3W8PFfLjYzHPs=; b=
	OoKAai9HHE2b08uVjVAMKEeF9DnIdrBhs9++K3vKRZqemErnur3rGbQbuqgLr5J9
	zZNnxXcs/To2EIhTJ+FkhTMA0dBguvbIk/CPKYtPum5kijaFeD2IJcAROs2VvHdD
	q3zkxxvzyZPKZAc7yglUypypKJv/GUaolId+D0hcdXhvoBKVWj4XxUMhlea/hehh
	4+IS/j5BhXdC2DfIM6GshMoR5woTSd1X73hTI/uakf2nLKBUD/wdrBfgA2A+wqhQ
	Zkz9422i9Z0/En6AIibCnHmhfYof8mFzCY7gsylxBA+99rDvYB/Rgmd1Mt0apjEb
	yfeSa6A6hSpdzY5f2E5qRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shv47g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 14:14:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AD97p4002755;
	Wed, 10 Sep 2025 14:14:17 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdhkj57-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 14:14:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHAl6K7uS5GAFt9y5cJNEB+jv39B8vaqZzIcM6BC6ypOqGA3CFOGODF39UidEPd/R/aZ3b4vLciqV0kuwGc5u5/15yY3UKjXX2SetpK60l+RgpMKMdape6gUsGqdeTp6tiZDILvefGrWqmlQMAC9Tqhcs3d1cz92870/Amr5+jyK3K4qZHE2QpjhWxu1lmuGogx7kd1mf6RzoTYTvZIBkd29AZPTitSBYygcd3Q9GP93Vrzrvzd/xe0VQYMIlFHrjjOprpfUbUOdfKipPeDxvEvvG4t+6SWUDfqAe/8vW1SVf1uLmXuwWRlnfLJokMKEatN9S5ViNXtWHACLGv4Rqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc+rhyWKVqjh6VVMJsTiOW9E8PI8hI3W8PFfLjYzHPs=;
 b=VtAE0/L0sITtACNdZqsfu0flAbPINkHFmfRhNr18qI1d4FHhdq+q2ch1O4SuKVMLkmxlsR39iuugzAT7umc3SySsfjp/d7L/3rF7egWcFOwylgbNZc//SogRCnnRKfGj9On6TrRmWoSyIP5edTR3GpfHA/sKWT7oKEyObiux/ioAMfUcAZvU2f7me8nbWccg2iPSssWEStnhWS++b3yEKfXNp+F6R/C4TSYq++oLL/xkRyAzvJ8BjOO9uYLNlqZvrYCiON2sE1FT9DIFucxPLjeYSgV0j/kFasQaJKxNhS2i9SqdSmmBMwz2aRgTDBIC6foU2Gc0xrKUxWa/Hq8rgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc+rhyWKVqjh6VVMJsTiOW9E8PI8hI3W8PFfLjYzHPs=;
 b=jVIsoDxDQOCsvLywMAX8Z+1y97LlBkjORX0YuxH6XcEegKXF2gXUcrCAAaCkt+dPdLSvofpIXnNsICraGkfbptgLMtdkkHqiGC9yURfbBPpDGSjvfHvwc7PHh5kUgsCIQtBwhteCwu1dz4rbpzO9O7Mv35wEYCazWVxZh9MvNxs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:14:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:14:12 +0000
Message-ID: <11a66cd2-7ffb-4082-a8cd-ae34a48530af@oracle.com>
Date: Wed, 10 Sep 2025 10:14:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: Jeff Layton <jlayton@kernel.org>,
        Cedric Blancher <cedric.blancher@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
 <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com>
 <aEfD3Gd0E8ykYNlL@infradead.org>
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
 <236e7b3e86423b6cdacbce9a83d7a00e496e020a.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <236e7b3e86423b6cdacbce9a83d7a00e496e020a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:610:33::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdef965-6f7e-4e11-e383-08ddf074514d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M05WZ0YxVUdJeXNxcXFyVmNCV1dLWU53MGh4ci9Xc0V1QjVNWndMUmwzRGww?=
 =?utf-8?B?ZjA2YWVKUFZjRmtnZFllUkNCeU5CZy9iaExqMlF2aVUwcUhrYVdiUkFpT29j?=
 =?utf-8?B?YWlTMXFRdkk0ekZHSUwzY2IxeTYvZmtLUVFkeFRJVXdubHZUdis5aGdLWjlU?=
 =?utf-8?B?bFZmdUk2dDB1anNHNFQ1OHhOSXZ1Z1NiemFSZlYxYnVUVzJoWEd2eWFvY0Vm?=
 =?utf-8?B?M1lHRHY3c0FLa1Q3RjlLQnlMY3MwbTBoVnh0alRsWTJncklrNWcxTWtlVG1G?=
 =?utf-8?B?eTFEalgvZVkwUVBFanlGVlQycTJENDBsbHFMMTlNRVBkamtkZmhuQVE1Y1Ex?=
 =?utf-8?B?YTdwTUN2ZVJtQ1RYdEwrQUhXcjh1WkNrVkhZLzVZS3FPVE1nS0Mwa1VQVGdD?=
 =?utf-8?B?OXFxL3QxRzBLaHpFTXFWWDlVaUxrdzVlRmh3czhVMnNqeS8xVjZWcGt0Q0dT?=
 =?utf-8?B?VCtBU3NPWE55bTZWZHVZV3IzWmV0c2hHNUxqTW50b0JhajBuSnpKTng0N2Ro?=
 =?utf-8?B?UGlLKzhFQVFjcEczWUdEK2FXbm1Mdjg1UWdSdnViUDlXWFV6Y0VWeUhGOW13?=
 =?utf-8?B?YVMrNnNUaS9CS0pOVHdNRzhBbk15MmhzUUVRTlpUcTdQWWtCRDc5eC94Zmxi?=
 =?utf-8?B?ZWJub0Q5NUlHRmZUNWVqQ2Fta1ZJU0NrRTZRYmRqbnUyaUNpS2hlMlpiMGl4?=
 =?utf-8?B?RGZBS3lRYUNDNTdBNWFiUzEzVzR4cDRMK3UranZ0VHFFcjIvVUhxc0s2a3Bh?=
 =?utf-8?B?S1RPcVh6eEVpWVF3UWRjNjcrc2VQUlcyN2VIc1ZiSjNwQ0FhY0l3QzBQeXVO?=
 =?utf-8?B?d2xiZzl6d2RzcHVKTjdPZDQ0Ri9adUw1TktqdTRsUGVHdEowL1ZzQkV4Qk8v?=
 =?utf-8?B?MGdCb0duQldrZHRZeXVGQVBFZTRNd25ndHNQOWp6aXN4b2IrUDFkSFBXbndL?=
 =?utf-8?B?S0lGOGU0QjBGQ2dnNmxTUTFueWpwZ0RSU2JSWWhoM3dNWUpwejFWK0hXeWEx?=
 =?utf-8?B?TjFsMnc0bkZBbXVxU0xHazZmQkNJTmJSMGMyVzBhbDBCc29hVTFiNncySDVE?=
 =?utf-8?B?UDdmcG1ud1h2R28vWCtYS0tNZWVTVUNTcEpMYkRzdkorVGtScHJFK3ZhWEs4?=
 =?utf-8?B?UUVVemUwVWZocFNBa0JudHVBcmI2YVpaTWN3ZGRhSnkxRzJ0SmFycjc0Sisv?=
 =?utf-8?B?QVJvWmtZZW5sQnVOYkdXQ1FUdkVmRFl1dWpKcEFYaW56K1N1ZXhRNFlhSVE5?=
 =?utf-8?B?T3VxTGRmT2I5RmY3TTk3WnJnZVpCM3ZySzVQMHBOK2RxTUhVclhSaDJ6NkN5?=
 =?utf-8?B?N3p0YmE4RmZ0aFFzMHdkL3NadUNUbHFiai9JSWQ3Z01vdmo5Y3RUR1M3TElC?=
 =?utf-8?B?UVZ6dkp4Rk5oWmZwdjZSSEU2c1BlRmV2b1I1Z1NyK2hpbE9HVFFLMGRKWmE0?=
 =?utf-8?B?QTRKN3pEb3lxTS9oRzVVMGxSNEZROVlaay9FMkJwN0RnMWRqNTRzVkZUeDZO?=
 =?utf-8?B?Q0dsRGtNVDdVNXdGck1PSTk5c2NScW16QWtxMWYvekxCaVhJSUdFamEvZllw?=
 =?utf-8?B?T3d4SHAxcnFiWlA4MENybGYwUENpMVpITVpidWYwZzJlREd6cjNUcFhGRFdP?=
 =?utf-8?B?WGx5c1lxZTNFeTJjZjlFbEFNNTJ6VjA4eVdzaEV6c3c2T3FyQUVqUUN4eEdv?=
 =?utf-8?B?SUgxQVdkR3RJS2hHdjZjYkwvWTJBdTRMYzNmWU4vTVVLMk4rRmVLalNtQ3lL?=
 =?utf-8?B?aGJpQklMQVRwaWVoZUEvWENuZjVDaGdjT094OENzQlkyMFlHb1FwR1BsdCto?=
 =?utf-8?B?U3doVmswcmRLMUNoOHBGbXgyUjZHc2d5bE91VXZWZkFMUWxsWmxFVGtFZ1Bp?=
 =?utf-8?B?TERlQWRLbWFMb291c2dlcVV4RUZVcnBBdVQzTUxpM1ljZUpFMHFIaFJJdFVZ?=
 =?utf-8?Q?cDhIPzuawkM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dWVaYmFYNnNxV0owc2xGYlM3a0pWQWsweHpJSksrZEVWZG52SGU5Y3NQYzY3?=
 =?utf-8?B?M3grOGMwbWIrS2JZZHJobHFhMjV1dnFRb0RLekNzMEo0eGg4N1BZdkZOQXBL?=
 =?utf-8?B?Z3UvK0s5WkRTdW5EeHR6NU14MDNTMUxzWVNiazhVS1dPSzhMenBUbWg5dml0?=
 =?utf-8?B?VWNLcnIxZ0tPUE9INUFRY3EzS3docnRKc1NPR3VyOFhuekNRdzc5M2d3UUVV?=
 =?utf-8?B?ZW5KMlF6dnpTdkQ2SFJpcXdKL0hNYjNiSEJ3WGxBUFUxQmFKVW9oTGhkUmp2?=
 =?utf-8?B?dk44Ukc3RjZMbjZsazJIRXQrWXl0OVBsWHV4RHhTUU8zb2dqd2xiWU5UL3RQ?=
 =?utf-8?B?Q0N4MHRLaElUZFd3U1pETzREN25OVk9rQWZLMCtobGtPT1h1OEtacXVGa1FZ?=
 =?utf-8?B?SUIzOWlRaXV0ZmFGT05qYTRQVUpnNHBjY2Y5UExjbUwySDh5MWpYUGVDOHZN?=
 =?utf-8?B?dWJ3QjdpQ1dUeEhnS2RSVGFCL1pueHVrRTVhSHR3ekVhckdiTHVhVTZXdnRT?=
 =?utf-8?B?ZkxYM0RHTFJUQTlybWorL21wWHlEWk1Uc2RoQlY4QWxuZU5nNVJoK1ZSZDNq?=
 =?utf-8?B?TnptU0o0VjAyM2c1TTBXdG83NTRxdS9xdmpsRDhDc3N2TlREams4SE92YlRl?=
 =?utf-8?B?dCsxRzJhaE1hMUZCaFdweUIvS1Nzang0TmZaMzdjMGxVSkEwd2tqOEcxOHNj?=
 =?utf-8?B?TjExV1MzTUZyY0NaU3RoNEl3ai9Jd1RLVjkzQWxqdTBLZGV5YlZBbytubWFs?=
 =?utf-8?B?NmFKazh6M0dnY2ZWdnpBd3hyRkltc1BMZkVyZS9YYlNFcTFJTlArN3ovODc0?=
 =?utf-8?B?cVVITFFkclp1UnpLck5XdFY1TmRwSUJnaEtSRFI0UzYvR05HcUIxS3MvMzRt?=
 =?utf-8?B?bWFBc2h0WjlpRXBWc25hMS95enBiSFpPYUZnWE1TcGhic2sxdjNhdkx6TVE3?=
 =?utf-8?B?RVlyWDRtVGFGbzhTSTMyQk1wb3BXUzViTzhHam5oVTBneW5QRXl1cGZXalJi?=
 =?utf-8?B?ZVN5am5lOS9ZSGttUWQ1Nk1odVJWR0c1VFVhUEpFeVpoNHRvalBZeXllNEYx?=
 =?utf-8?B?Q3J1YXN6ZmhiRzNQWXRheXRYVWtIWm5RM0hiSGplZ2NpbzBLcUlMVEViU3NG?=
 =?utf-8?B?OVUyYWlGU1JxTklubVVNNzY4bDlIQUhTZzhLeDhpc3ZtWWEwSTRQRVFnYzdq?=
 =?utf-8?B?Nm5CVGkrZC9Rdkd6N2FYYnRQL1hHVzZLOCs0cmV1dEdsODhQdzdsM2VGSUJK?=
 =?utf-8?B?K1oyRWxDdXBUQ0RxK092Q0NuZTNheTFYRWFiRng4eVpJRG90ZExTeUUxdW5X?=
 =?utf-8?B?QnpkeS9KMU1BNjFqZTdmNkJGUklUaEdzWU1qZEZNT0VhQzYrSFB3N2xRYlhq?=
 =?utf-8?B?Y0xjTHNxeEtoWG83R3c2b1dVYm5iYVhBV1ExNUZBUUxKS1orUEFIQnF6b3Bx?=
 =?utf-8?B?Y2FEanVOanEydU80NFZHWlcvMGZtYllzQUdDRTZtWUFVd2JtZEJMSUlNVGdV?=
 =?utf-8?B?T3dmRURVbzVGcWdoNTJtWkpaYjhrczhObVB0dFZDSUdSTmM3Sk16c2R3VkpL?=
 =?utf-8?B?NFU5RVk1WXFOS0RBbTlBTG1RMW13UW1SdXRGazQwb0lWQmpIcXZmellTZUk4?=
 =?utf-8?B?TE9XNStMeG5rbDc3U3ZMTG5DZ0wwZkI4UzJEN2xTSndEa0htcWc4b2N6ZTI4?=
 =?utf-8?B?elVCSS9sclJKdFljQVo2VlhKd0hXSGxxT2pvcnpacWF3aGlGNWM2b3Z3alhz?=
 =?utf-8?B?MG54djlJOW0yWXRmUXplUkxQNTZQbVRpR3N5SzNrZndjV3NNS00rMXlkaWE1?=
 =?utf-8?B?M0Q3UWlKcFJyalU3bmprd21ZOVE1eFU4bTdUYzB3bUwyRnM2TGRXZjV4S3NH?=
 =?utf-8?B?cHZodzQ3N0lJMGVTVTUvbnZEalNMcWVVMkJyZGNkOTFXcXJIaHZ2bUU5d0F3?=
 =?utf-8?B?UnhDS0ZWYjcyNXhTRDZJRlliNkNGK0NiK0dJU1JHdzVnZDF5T2kwN3VvNkQw?=
 =?utf-8?B?dFRVd0EyK3dKU2FuZDN3ZmlYUFNKZW8zeEdWOTdJcFJtcmxMeUptYytiYlJ3?=
 =?utf-8?B?VFRTSk9Ga25CWDRET3o5UitYT1pRci92d2hxcWdzL0RjdWZiempLdDA4bkNI?=
 =?utf-8?Q?YApuFwBrHVALQ7Pjgib6G+EZ4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wjPmu6Vz2PMRY/PvAX+hoHlZA10BW7s+pCoeXKHKdgwcFZee5/tAE4oKbB+QXz50TNjqtB61hptB8U9//UIl+nO61klaecpc0K7NXGTe+9kIWGF7lkbeNodA3a+TuJWTCYwIFoieC1d9cAI99Oxz6mfIMSv5dK/+BMaW+rYU+9cmZTAyqmK3UAUOLwbRd1RUCMgdcmexHaOxlCG+bbEhvsCrxKAa9aK/pKXdxlUss5t94pH/MSttDjBqHLkRKWWk1hu8NcXfuoUnrEp3sSaVCnbdRf/RR1nzrm8VlXu1bok+u8qzIPj6knnmhyoIbNtCKuyQ5wFLZnfgx/HbXtKVPoAxi7AsNJYraKm0Csdn5St1Qly0ISeePmX/ikQnewJb4JcCdd3XP4TYhAUWPs70Hr8BYKKO7h4sUoP1X88nEX4NV0N0oTEw8d1WSNWdSyCFhA5F72SBJS5atV1bWMcBgRHj7odWBNZVXH2F9/Ipa0MyNdzrnXFiJT5mMMazXV/O/YRc5PHMKqdGaKjjqGeRUJUbEowF/GDMbmrpmiaLjnpztrm5VUmV2NTO4RZgh2l45Tzsv9ibgwVV71Sq66scXmP8tk7ngcN+2IavIab4dek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdef965-6f7e-4e11-e383-08ddf074514d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:14:12.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guf9IvQhSXy49xw/W4PYJE2quDDtqypeJjBKb21Rx4MUUjKkVmC2xz2b8UeHOd4lIN9VHf3gBSXaJfX3km+FTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100132
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c187b9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=HHsExrWIo6z470ULgqMA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX7HkWOEoOM2ZD
 uHoi208oxFOOCwFtCqAqP+H/ZI2QI4XAfyj4SCp2wCcmnSjX5hxo7WojAGyYD0xfAHcXSLSk+WX
 iUg2PWJlspG2m+GKd0b/o4W6WOEimxbCdoM2lWE+XOarP7wV7XMO0eTIemTnrXLdoGOEyHhOJMR
 K42zXKSn/HUESXwn0h52zyTwRPe/AS/ZT+8Wuq6vBbIuqzbWVby0sTStjvJgEAxSa/W4gtp5KqU
 0iFpTyNVgkYaZeFeIjvQbmH75DJMsPRnwPpGfquCZOqviJxrHaSXGNbZ3k08C2xToscovcZjoP7
 7OblK/xJx8fIXwAhkFKW2lut1aDfmY3rEHtmyo1su9JLyvzdy0gn6WJVIH1rYxEDoYdz4eImQW1
 XSIoT6Ew+kECFm+43srVnsoljNRbag==
X-Proofpoint-GUID: qUf71JfjVIm0pQCIsR_bDJlN_aSvZ4-Q
X-Proofpoint-ORIG-GUID: qUf71JfjVIm0pQCIsR_bDJlN_aSvZ4-Q

On 9/10/25 7:10 AM, Jeff Layton wrote:
> On Tue, 2025-09-09 at 18:06 +0200, Cedric Blancher wrote:
>> On Tue, 10 Jun 2025 at 07:34, Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>> On Mon, Jun 09, 2025 at 10:16:24AM -0400, Chuck Lever wrote:
>>>>> Date:   Wed May 21 16:50:46 2008 +1000
>>>>>
>>>>>     dcache: Add case-insensitive support d_ci_add() routine
>>>>
>>>> My memory must be quite faulty then. I remember there being significant
>>>> controversy at the Park City LSF around some patches adding support for
>>>> case insensitivity. But so be it -- I must not have paid terribly close
>>>> attention due to lack of oxygen.
>>>
>>> Well, that is when the ext4 CI code landed, which added the unicode
>>> normalization, and with that another whole bunch of issues.
>>
>> Well, no one likes the Han unification, and the mess the Unicode
>> consortium made from that,
>> But the Chinese are working on a replacement standard for Unicode, so
>> that will be a lot of FUN =:-)
>>
>>>>> That being said no one ever intended any of these to be exported over
>>>>> NFS, and I also question the sanity of anyone wanting to use case
>>>>> insensitive file systems over NFS.
>>>>
>>>> My sense is that case insensitivity for NFS exports is for Windows-based
>>>> clients
>>>
>>> I still question the sanity of anyone using a Windows NFS client in
>>> general, but even more so on a case insensitive file system :)
>>
>> Well, if you want one and the same homedir on both Linux and Windows,
>> then you have the option between the SMB/CIFS and the Windows NFSv4.2
>> driver (I'm not counting the Windows NFSv3 driver due lack of ACL
>> support).
>> Both, as of September 2025, work fine for us for production usage.
>>
>>>> Does it, for example, make sense for NFSD to query the file system
>>>> on its case sensitivity when it prepares an NFSv3 PATHCONF response?
>>>> Or perhaps only for NFSv4, since NFSv4 pretends to have some recognition
>>>> of internationalized file names?
>>>
>>> Linus hates pathconf any anything like it with passion.  Altough we
>>> basically got it now with statx by tacking it onto a fast path
>>> interface instead, which he now obviously also hates.  But yes, nfsd
>>> not beeing able to query lots of attributes, including actual important
>>> ones is largely due to the lack of proper VFS interfaces.
>>
>> What does Linus recommend as an alternative to pathconf()?
>>
>> Also, AGAIN the question:
>> Due lack of a VFS interface and the urgend use case of needing to
>> export a case-insensitive filesystem via NFSv4.x, could we please get
>> two /etc/exports options, one setting the case-insensitive boolean
>> (true, false, get-default-from-fs) and one for case-preserving (true,
>> false, get-default-from-fs)?
>>
>> So far LInux nfsd does the WRONG thing here, and exports even
>> case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
>> server does it correctly.
>>
>> Ced
> 
> I think you don't want an export option for this.
> 
> It sounds like what we really need is a mechanism to determine whether
> the inode the client is doing a GETATTR against lies on a case-
> insensitive mount.
> 
> Is there a way to detect that in the kernel?

Agreed, I would prefer something automatic rather than an explicit
export option. The best approach is to set this behavior on the
underlying file system via its mount options or on-disk settings.
That way, remote and local users see the exact same CS behavior.

An export option would enable NFSD to lie about case sensitivity.
Maybe that's what is needed? I don't really know. It seems like
a potential interoperability disaster.

Moreover, as we determined the last time this thread was active,
ext4 has a per-directory case insensitivity setting. The NFS
protocol's CS attribute is per file system. That's a giant mismatch
in semantics, and I don't know what to do about that. An export
option would basically override all of that -- as a hack -- but
would get us moving forward. Again, perhaps there are some
significant risks to this approach.


-- 
Chuck Lever

