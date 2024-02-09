Return-Path: <linux-fsdevel+bounces-11001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD9384FB0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 18:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23ED1F26513
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841E7E59F;
	Fri,  9 Feb 2024 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ELaZ8Thm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a2CkqWfI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063247CF37;
	Fri,  9 Feb 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499924; cv=fail; b=XIO+NC7SDE1+ptQayeiWy02ScfU4bJyQ4/TcGZwTHJfjsen4c2fYmqU7hS/PuRpjczzvTs/An87vxB8oqFmCCDH5JuLQoxEmeEqs1/eGnnv4LGu3Luhc5SNki2pA4eA6U+e84h7ax6jnoDeFb/ZtOoYXfM0TJbEzr3tqrKWju4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499924; c=relaxed/simple;
	bh=MJe0uKSBb4mtMjXyR+4/Oa83XNEL2ijlh+dv8urP9w8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BfKGtruxiOCb6pmJWvLkGQdj3JsexCrjhhn/F2SwbFQn8XqwtrgySm7o5k+IxD+zkVgRfApEEBdR2Odrgm6btXLGb5r6oLKY87XWA9efwo5al+6MoB/PvhMY1Nuj4Op/siJ62QIEyttGhjD/4icCJZJishLJN7WZmfq/NWk7cWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ELaZ8Thm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a2CkqWfI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419H49Ji014997;
	Fri, 9 Feb 2024 17:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QOUj8fYRUY2PeDi0I1Gi5duzpN7/bIPocCR37+YS7Jc=;
 b=ELaZ8ThmkXOShgDaB6uQmGNzoj+GX8gRddUJDf6im58+5RkGaYdz6vnklAvWRKwNHpG2
 RLczORWzT5klezJ36LWMTucd1CbygPLBLDpyd5Q1PTidN8TwLXO2141CT5+HlPuy6UG1
 wzkf5A1i+lVnj8IV0Q80rwvQqVwKQkwB7ULly8gLoQts6UR+RoKJ0wVN2vZy2h194agH
 4sonG7fN+NOM57CT70XwQgWIdYgN/qLYJs+q1Bcf1jt7bB/DqGJkUTfT04S2JYrCZoEX
 EFFR1PGr3Rvlum+iZfVWuAdkaHpngG30SFIQNU9MmfNgOXog6faHk5JOnQQz9Vff6v4d vQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c9482qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 17:31:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419H6vxe019687;
	Fri, 9 Feb 2024 17:31:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxjrv3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 17:31:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx8UP0TwR/bnQMShRD1DeZ4nfPfFCHuRrmPAzLYYMAKe9CgHDDTP3/BcPISS3LIfQymhPykALgt61eyI4WILVaNi5/3GmF47zkQbkdjqQB77azbVOFMC20un0DkKnkyUNfFbgDnaXfws5h744Ludeh797f5oDiXlF4R9W8T3+kvUFPWRfn35YZJQuvKJTsJKi87T9Nxo8nFjcWFMWMq3Amfq3umR0l87t6lXO0QAtI79EKfMZUoxg9FhPBjfLLkyeMAZnQR4zkmGOa8MXXxn0Uke6dZkPXaWW1QVHtqlcguAIm/ZuJLZHgyohl7rqLaYv5ZyHgFDWGTx2mH/Vlkzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOUj8fYRUY2PeDi0I1Gi5duzpN7/bIPocCR37+YS7Jc=;
 b=TrSOpNTjrqJXn4tXHxcqGURIJcHJW1cETXiFwIXgGowdjFAUO9ir0Y1nvzLlVPYb/JvDuhrtqTIuNcEvZNw1aUSAHMMOeNZKGHOg0VN1flwGM8ZajGhv5i5eoA91a4PYM29kuo631sf6jVz1xSKTnP2Hr4qWI6OFb0wxfTuOmVebkN21cElG9BEo3D6EkittmI9gcjat8AMpY6SPPrJjOgzOQ12D4G5D+CU4QLxqAeBi6TgWqL7FLFQ20jWPvElZx4yAFqRVnxVQtUKZ4bSzhkUcwRNOGJVTPWIf1mh8HpsijrVGMo6ajsRQ8G6pwyZLJaPUNYzHrKHKPZwMDa34ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOUj8fYRUY2PeDi0I1Gi5duzpN7/bIPocCR37+YS7Jc=;
 b=a2CkqWfIWfCgw4Od/CrkdBsSuQevFAQUBh0HJ4Vu/Vx3/rr6Z2a3AK2bdHAlbhkOerpYRTUw1r9WCR9G0zfRSIT7W7T9bWocsycPtYLJ51XKLEtP2p4C1GrtoM+KRAUqUUq2B4vqlhydC3dNZULTq5qekXX9OiyptvTuLbaHYZs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.45; Fri, 9 Feb
 2024 17:30:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 17:30:54 +0000
Message-ID: <36437378-de35-48dc-8b1e-b5c1370e38b0@oracle.com>
Date: Fri, 9 Feb 2024 17:30:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] fs: xfs: Support atomic write for statx
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-5-john.g.garry@oracle.com>
 <ZcXNidyoaVJMFKYW@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZcXNidyoaVJMFKYW@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddb000c-9db7-4088-c16a-08dc2994de90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7xHJVccpV13hqJc6RneY2TAB+xXUYPRoHcQZfQDJyv/4sE4O11+ULQ85orp17meqewwvwb16bx9ENzkvKFnfiLYRQo7gaBTPTF1uhkdT+a4igAZUjFywEccHtMCqukJw4zNE1QgxiP9udj9FWTln6BZyFSDqa0J84DUoYwGptOVLRc2f4vsOymbl7dsX9eWIoSyjNDjrpZpNqmrAAcpjYFHQIEbIE2hTVXz1pw5+RBFCDqhWKFF/KJphETmsBDZP71h1dEE9zaIESZN6x5d1B7qQDUS4KtV2U4ItuYV1QxL7TEwjs2zvpoFNXmmufKMtdqPYKlEBkWiqqDzm4VCdReZ7+1brBktnDfqFSrLMDctygnT3BH+zdkkLldbBw+gqIykmxH7G/0YJvugRiDEpCvLzRZhXYG8+AS6+9E2lLdQJulPkyerfWeutLDj5LZsEkfKe7qv/PR+WT9pFJ6Fskb2fmDw1Wg0W1YNg65ihYvCVkiZ5+imDX+C+b2eebsrdAvMkdxxyu1/e9Wqqs4TpFhB6WVX9SwpvuGvqrUkZkmtEyc7sCNOm7j1O/LbgndY/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6512007)(478600001)(6486002)(31686004)(41300700001)(66899024)(5660300002)(8936002)(7416002)(4326008)(8676002)(2906002)(66476007)(6666004)(36916002)(316002)(66946007)(66556008)(6506007)(2616005)(83380400001)(6916009)(31696002)(86362001)(38100700002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c3c2NWt0ZmR5REJjU25MTlNmSGtDc2cxaWxWL3o5U2l4cFFaWVFSR0hEbFNI?=
 =?utf-8?B?dGs2NGVjVjJOcHpJaUNqUk56OERoT1NuaGoxSGFoMnA2K0U3ZmJQd2lCdW1M?=
 =?utf-8?B?NlBveGoyaWpadTZ5RW5IR08zckZIbFRCR0lTVlRBVlVQWUdxQ0pUQnBZS1pC?=
 =?utf-8?B?QVdTcXM0OW4yNFBDQ3dhME5sSDEzTklUNU9BQXJaT2l5dy9VSWw5a2ZOWHhE?=
 =?utf-8?B?VDVoblJYNFFJazFJQjRWWVJHMW00VjI5VmxUZDIrbDIvdEFqVW8wSEMwQk1h?=
 =?utf-8?B?NjJXcnRtUmNIQWJqWGpWdHdJeHUrSjRQeE90cjNHeVVnWVgrUFhCaFVCdUtC?=
 =?utf-8?B?enMzR0xVejQrRUhsQm43OCtzcGdZTTFyaU9XME9sak5naVJBK01LK1BaUkU3?=
 =?utf-8?B?T29BR2o0Z3Q2RGtSSmc3dFRyNk1CTnF2Y3F0MHhHNG1MVGlqMHQ1T1FlUnJJ?=
 =?utf-8?B?cDM1T2ZQMCttNkpYcmlCTmZ4TWYwZElaWFd2amc4T245VnZUbzQvVm5GT25w?=
 =?utf-8?B?dmczVVJBeHM4QWY4dDI1NVllZnoyUWwzTFpHNk5qMjNWekd2R1IybVpvRmRr?=
 =?utf-8?B?SjdiTFNwZ0lCWDJsakdsNWp5OVJTOStrR0RpajJ5amluZE1QcFBvekJJUURS?=
 =?utf-8?B?YW8zT2RFUFdXWitYL0tXdGZoMk1LODUwM2RSeGxjVVJLL1R0V2MvT0VOOStB?=
 =?utf-8?B?WThGWm1JQlE2bHB4Y3V5RVAvRDUvQm80OHU3eTAvbG9Bd05XcjJnb3RuL201?=
 =?utf-8?B?NzhEdE0yMkllQ1Z1a2RySFVrWnM5dG1XOEJXN3dYcEdHTVVaZ2pBQnpGYlVu?=
 =?utf-8?B?SCsrUlhWWGxzQ2ZsL01DcWYzc0RyZjdMWVRjeUhETmtNY3I4SWhnbTV5WUx6?=
 =?utf-8?B?emlzRGgxWXdOcDRLUHR1SENzWHlHUUJMcUttKzhTMDBsNEVsNkIwdzM2Qis1?=
 =?utf-8?B?QlhDanYvTHQwOWoxd2Z2Z3JEeVdEOGhqT3NHbnNJYUIzdURxaFlhS09HS0lw?=
 =?utf-8?B?SVhnRVhFTXFHUHhnVmlLMU92aTk0eDVVQ3FjbyswVFFZLzI0dnhaWlhUWTFN?=
 =?utf-8?B?aUR1SjVOdmxOaUhZMVlKcEZqNVdDcnFuNnRnT2xXeVRpUHJLRysra0lQVnhl?=
 =?utf-8?B?dCtKVzVIT2tLMTZ4M2UzelFGVFR4OWpUdGVzNUtMc3JoY1FKYkFQelZZOHIz?=
 =?utf-8?B?VFBqdzRUY0ZHRHFuNTY1UFBQMWQwQlhRNHZXampTTmZ6cGdHZ1BhWW4zckNM?=
 =?utf-8?B?by8rcHBIY0hLU2UwZ1g5VTVmUGhUMWdpeU1OL0dpVVR2YStyUVJBU1l4ZWpz?=
 =?utf-8?B?aFJudml6RHg0R0VjamorQ3ZQWnU4b0ZNdFhvVHFvYlFLR3pVdUVHR0U5VWF1?=
 =?utf-8?B?bnA0MUp0Ni9iZlU3VVJ0Z0J4dUwyU2pNalhWaVBWZVNBbUM2NnQ5TWZuS3h0?=
 =?utf-8?B?Wi85dkUvbzN4L1lUL3RnUlZyVmJZZUFqU1o4Q0d2WnBkbUt4NlB0cFp3S0o2?=
 =?utf-8?B?R2RsS1FOT3pZMWF3M1I5NXBLQnlYNkR0a0kxWldNSmh6bjdCRFE2Uk9nbXV3?=
 =?utf-8?B?MURwZlJyRVJQMVFPV0FqWk83TVJLWU10QkpwT01UalhTR0FKSGZoY3k3TGpX?=
 =?utf-8?B?ZzJPNlJjVzRYS3k5OVJsWHEwc2NaQU4rL1lETjFGS1ZuZ0cwRy9YY2xHcDVt?=
 =?utf-8?B?b05DOC9mWEFXNk1KRDJyN1FmWFZ3dEFUWlE1V1gvWFhHY2ZhTW5MSUlvQkZk?=
 =?utf-8?B?bzlybXRMdWlaNmJOTHowUmtLMTF2akNXYWlrQzllYXNnaHM4NnhESDBnZkh4?=
 =?utf-8?B?dlRNYzE3c1ZYZ1pLbGNnVmMzOThOdWlSV2Z0ektKcmZIWGxDUkxVNDJ6RTdt?=
 =?utf-8?B?Ly9WMC9FOE5Wc1ZOQW9PbC9CNkF4VjlOSklwN3FLQVVKWm1QanZ2WmFVeW11?=
 =?utf-8?B?bU8yamZyVXdHdldVLzA1ODAwQ2hqVGFWcEsvOFBRMFdMaHJmOGRDcVJDbWRC?=
 =?utf-8?B?UzRQMkVFRFViUHpYS3RvVnNKRDh1cGt2MWJ1d0FIdUtHVHlCV2V6RmhRcWxt?=
 =?utf-8?B?Y2oxUjBJMi96dkphZXF5Sm9EbWM3Zm9tT1Y1WFBXNXRKd3oxRm42dFdxMmpW?=
 =?utf-8?B?di9pWjEvZFI3OFIyU0NyZWtUWFFBUkV3UW5pYWdEbzVYNkxnYVVpcDJsUmFU?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R4ykQ5G4WywLgc/x5CbDf7vf7TRaUo4mqbmUGhbcLfHqJ8IKgYJFXqQ7mrEZIjecuFNporRipYMMabI6YnN4DHb+sxkArfxfjjS3eerO8DF0u0o/i8ba5oRTK/3vCxFFwBj6zHpqccbXvRC6KECBH9P9hJQbtvbpVR7hMvQ5UwGM9K41Li6x42KKI6tF4NVpSi4gB+B2KYxdt0MsDeQ6tFwLe67UGVU3ZMbBvC2QmqNQOhc0TECp4b19UxmXIR2oNKuHwJbCns9D2G6T8VSVb9YDE789dJpPqq8C8xu2XGdRJM52pQQ9GCwE0DEarJ94irvnyphcW1AR6miHTI75XE0KwmCwnxTl+6QieJ0Wy93cdbFni1+AQsc1uyFqDQilqOlssuun9vE3AWSyWZAftrQi6zVFAtvTZ6TaCCGTe1/5Q7Q4gr23lPXRNDup2adehs7XTB4qmSabOFWTB3BgrbGgO26xKfM52aEb+llSgNnwvMU1ppP7Pt1s/T25o3QoWFaaDMBxuo8Dl7+UkM+aC3Et7xiXVaMRQwXE7qZkG6cClkG5U0ykUhEYtxsAz+kA+ukRlrOWiio0xIEpdfEQebvisBb+Do6jUJLrT7yKFJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddb000c-9db7-4088-c16a-08dc2994de90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 17:30:54.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9inySIzxZnWg1Z/OB9z5rG4qpvurRc378suNPrzSZqST3vBSwIWg6271DLdAtlQ7iIkk/mkVialRb2gpvJATA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_15,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090126
X-Proofpoint-ORIG-GUID: ta7eDbqBZwonRBI9aVv5lTZEGpux3bb7
X-Proofpoint-GUID: ta7eDbqBZwonRBI9aVv5lTZEGpux3bb7


>> +void xfs_get_atomic_write_attr(
>> +	struct xfs_inode *ip,
>> +	unsigned int *unit_min,
>> +	unsigned int *unit_max)
>> +{
>> +	xfs_extlen_t		extsz = xfs_get_extsz(ip);
>> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>> +	struct block_device	*bdev = target->bt_bdev;
>> +	unsigned int		awu_min, awu_max, align;
>> +	struct request_queue	*q = bdev->bd_queue;
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +
>> +	/*
>> +	 * Convert to multiples of the BLOCKSIZE (as we support a minimum
>> +	 * atomic write unit of BLOCKSIZE).
>> +	 */
>> +	awu_min = queue_atomic_write_unit_min_bytes(q);
>> +	awu_max = queue_atomic_write_unit_max_bytes(q);
>> +
>> +	awu_min &= ~mp->m_blockmask;
>> +	awu_max &= ~mp->m_blockmask;
> 
> I don't understand why we try to round down the awu_max to blocks size
> here and not just have an explicit check of (awu_max < blocksize).
We have later check for !awu_max:

if (!awu_max || !xfs_inode_atomicwrites(ip) || !align ||
...

So what we are doing is ensuring that the awu_max which the device 
reports is at least FS block size. If it is not, then we cannot support 
atomic writes.

Indeed, my NVMe drive reports awu_max  = 4K. So for XFS configured for 
64K block size, we will say that we don't support atomic writes.

> 
> I think the issue with changing the awu_max is that we are using awu_max
> to also indirectly reflect the alignment so as to ensure we don't cross
> atomic boundaries set by the hw (eg we check uint_max % atomic alignment
> == 0 in scsi). So once we change the awu_max, there's a chance that even
> if an atomic write aligns to the new awu_max it still doesn't have the
> right alignment and fails.

All these values should be powers-of-2, so rounding down should not 
affect whether we would not cross an atomic write boundary.

> 
> It works right now since eveything is power of 2 but it should cause
> issues incase we decide to remove that limitation. 

Sure, but that is a fundamental principle of this atomic write support. 
Not having powers-of-2 requirement for atomic writes will affect many 
things.

> Anyways, I think
> this implicit behavior of things working since eveything is a power of 2
> should atleast be documented in a comment, so these things are
> immediately clear.
> 
>> +
>> +	align = XFS_FSB_TO_B(mp, extsz);
>> +
>> +	if (!awu_max || !xfs_inode_atomicwrites(ip) || !align ||
>> +	    !is_power_of_2(align)) {
> 
> Correct me if I'm wrong but here as well, the is_power_of_2(align) is
> esentially checking if the align % uinit_max == 0 (or vice versa if
> unit_max is greater) 

yes

>so that an allocation of extsize will always align
> nicely as needed by the device.
>

I'm trying to keep things simple now.

In theory we could allow, say, align == 12 FSB, and then could say 
awu_max = 4.

The same goes for atomic write boundary in NVMe. Currently we say that 
it needs to be a power-of-2. However, it really just needs to be a 
multiple of awu_max. So if some HW did report a !power-of-2 atomic write 
boundary, we could reduce awu_max reported until to fits the power-of-2 
rule and also is cleanly divisible into atomic write boundary. But that 
is just not what HW will report (I expect). We live in a power-of-2 data 
granularity world.

> So maybe we should use the % expression explicitly so that the intention
> is immediately clear.

As mentioned, I wanted to keep it simple. In addition, it's a bit of a 
mess for the FS block allocator to work with odd sizes, like 12. And it 
does not suit RAID stripe alignment, which works in powers-of-2.

> 
>> +		*unit_min = 0;
>> +		*unit_max = 0;
>> +	} else {
>> +		if (awu_min)
>> +			*unit_min = min(awu_min, align);
> 
> How will the min() here work? If awu_min is the minumum set by the
> device, how can statx be allowed to advertise something smaller than
> that?
The idea is that is that if the awu_min reported by the device is less 
than the FS block size, then we report awu_min = FS block size. We 
already know that awu_max => FS block size, since we got this far, so 
saying that awu_min = FS block size is ok.

Otherwise it is the minimum of alignment and awu_min. I suppose that 
does not make much sense, and we should just always require awu_min = FS 
block size.

> 
> If I understand correctly, right now the way we set awu_min in scsi and
> nvme, the follwoing should usually be true for a sane device:
> 
>   awu_min <= blocks size of fs <= align
> 
>   so the min() anyways becomes redundant, but if we do assume that there
>   might be some weird devices with awu_min absurdly large (SCSI with
>   high atomic granularity) we still can't actually advertise a min
>   smaller than that of the device, or am I missing something here?

As above, I might just ensure that we can do awu_min = FS block size and 
not deal with crazy devices.

Thanks,
John


