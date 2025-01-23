Return-Path: <linux-fsdevel+bounces-39984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0D1A1A8FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802B91888911
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AB1149C57;
	Thu, 23 Jan 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ktRSIGWW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d3ejiZTB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8218AEC5;
	Thu, 23 Jan 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653854; cv=fail; b=jNG62EojDN2GAbkIWNn5wRoeJsAszosQYOMcZPR0B+M4fUPIL33To7GKGU3a3bYHKzjaRyNGdw++4zelIjJ+LZ5tvFS28l/WSKySR2u0+eQW1WLIrEKlQ+aLS2WdYnEm+1jm+EamLTZBAOaXFfhGe4Qi+ILow3IzfHD4WyS880E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653854; c=relaxed/simple;
	bh=eheY3Dhf5lem+AocBhrM84kJFtAGuDT1zbLw3W6gK2g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P19vLeIYDvY3Jz9RyFyMfyaxqOLD4H/wrD2ae3DUclUMFtJOLTwKscEh4AjnnXSyhWTCCY/BCVyrz+aYDjO8u6ZKPZBITsZVXAhCARfTbdR8ZeB079Q0uq6qiMR343JhlbRtqsSRlsl8SEBRFGSLqTQws6H1OydXCz9fn93AS4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ktRSIGWW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d3ejiZTB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaMSF006906;
	Thu, 23 Jan 2025 17:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qeypH8k3lNPmjLx9sssN5IO82uaeeJglke33aKaLnks=; b=
	ktRSIGWW7UmNkCOdKrFMZoHOiBSlXNjitWL0WAvN5awanXxQPPjhjfXzp/uue0GK
	ji6hiwmfv0CT1EN9gva897c3Ik4dF8oXt4lyBz3INKHBYH8kLE2B64SczM3rXHgL
	0f0Iz6YjW9TUyPsZkLhRm9wmRO3AO3o+a9JUP7PEYkO6JLDTJCxWZQVwlH3s8KVH
	bCQFRSU/LlE0nJfFS6nBeZBSJsS32fVDBbtA3FsKyUGW+V6G1LMvYGHDBbC48CuM
	qLtAMh5xXSzVOo7GJc8f3FViKL53BTZxOYzDfsm3kNrbV0qg4Nu2kkeoqkWRTck3
	uvSHA/P9KsBrCIeJFkEStA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qatg6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:37:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NH2QZF030477;
	Thu, 23 Jan 2025 17:37:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491fmtcs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUpmTx5Oq3h39IGk9BlZp1f7wQfF8EPc8pbqOxr7kaUMWkjTzJOVqZkFwpEnptQ9v89yqNjUsBhdrOUoLcnJcz3LMCHkrC8kQCEmWEn8nNqtB4ti93FRqcWKcRgfvR/xso8nGHaJkPaizHwZeMo42jL0BWuf+u6Zn/hPbRE8Pj7V2WSFLIxzCR0nXiqxdP3K8KIt0DN7j4z+pDd5EDAPyIAgNL0tyjBzSBB1bWS4hkKgSfd0559VlS+9djgdOoD/rXkOlWiz236UcWL7cIr5Fsm1m3QLmxxyQEh+aBWb7aw0Jf0YSNHJSFKK6SdKCBWtcm4wOflAAZzI6n20zrbQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeypH8k3lNPmjLx9sssN5IO82uaeeJglke33aKaLnks=;
 b=PrbkTkct8jTGNDRljPCus8ksFARCgSd7AdaDPHcLlmRdX0IALf5Myw8RIDwQxGtuvqj5kl0APDfEyd94Ha7npYb9C04QJTOtACo+toZbck77vjM4h5ny7ndDF2wuJaZJqB6ESwcRtpYhqFEUDcBucmfsnxJi2n+It7mjJd9qrvofT23CBVsVqrI8lyro5GZQ8RcVcI0DObX2MAuu7sEFHyqsA9n9M8J8nc9VT4fDv5h8Tmol38lUAEbV5jyUW9PkFiGEOYTQXWpwDsMk/7zbNqsgHUbfRqhpw3NxLUBaPIL/7o/4kcXV01fD6Y11upHj/aDdGapdu2X/mlkkrYoHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeypH8k3lNPmjLx9sssN5IO82uaeeJglke33aKaLnks=;
 b=d3ejiZTBtmx5qgE6NKpZx7Oh35k37O2lAk5ZR1SktRuFoqwCpmxPCq3UqEgisT8XTrG5t8g0dPq6vNSMmPRi/UAfUyRvbH1IeKNgZQgDJLaqjWtQ1I9tUo3RXT4kn1Dp/5ZAK7GYOzC26lqdJgGrQR1LAijybYnjfsxZfwYgG0I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6493.namprd10.prod.outlook.com (2603:10b6:806:29c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 17:37:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 17:37:15 +0000
Message-ID: <bd6e8c08-8914-4b24-ba51-78c2afedeed6@oracle.com>
Date: Thu, 23 Jan 2025 12:37:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
 <173750034870.22054.1620003974639602049@noble.neil.brown.name>
 <CAOQ4uxiXC8Xa7zEKYeJ0pADg3Mq19jpA6uEtZfG1QORzuZy9gQ@mail.gmail.com>
 <c2401cbe-eae9-44ab-b36c-5f91b42c430d@oracle.com>
 <CAOQ4uxi3=tLsRNyoJk4WPWK5fZrZG=o_8wYBM6f4Cc5Y48DbrA@mail.gmail.com>
 <50c4f76e-0d5b-41a7-921e-32c812bd92f3@oracle.com>
 <CAOQ4uxiVLTv94=Xkiqw4NJHa8RysE3bGDx64TLuLF+nxkOh-Eg@mail.gmail.com>
 <d36de874-7603-478b-a01e-b7d1eb7110d3@oracle.com>
 <CAOQ4uxgnQ-4azkpsPm+tyd7zgXWUxXq7vWCfksPPF864rpN27Q@mail.gmail.com>
 <6d3bdbf1-fab5-48f6-9664-ef27fb742c55@oracle.com>
 <CAOQ4uxiXEJzQLaOCiUfee6P5+NUp3yP-KksxaMsZJB2PRLfzUw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxiXEJzQLaOCiUfee6P5+NUp3yP-KksxaMsZJB2PRLfzUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:610:57::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 901c0d21-2190-4f64-ad5e-08dd3bd4939a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Si9lNlF2dXYyTXBEV2E0ZElOdGtrV1lPSU1UMldtbzU4TmhqQWdkZFFzemc3?=
 =?utf-8?B?YlJtVVlrSGxka2E3bi9iY21jMWNxMitDbEM3TlNFYWVqaEtYTzI4blBCc1VB?=
 =?utf-8?B?UVRISVlGc0pmaVJKbzhpeW5ENzQ0Z0puUURYS3ZQeEZQT2xYSTZNVjJ1Rllv?=
 =?utf-8?B?RVhFYXNwLzdMRVNNVDc4TEZPYkh2NlU1WktKdzJFSVdtbVViTnozcWFRV0xx?=
 =?utf-8?B?MFNnOWtlTWt0VE0rZWRHTnVKZkNNekRBci9YVUhOdEVHQmtMYkhvaW5jQjlL?=
 =?utf-8?B?RExaTEtVK2JqazZIOW1zc0w3OUhucjFVcVdyTEltaDRHY0lEVEJDZ3pWbFlJ?=
 =?utf-8?B?Wm5uZDcvMjNhMlJIUEJKS3dxejFHcWtwdjc3S3FRViszc244bWxNLytCUlFM?=
 =?utf-8?B?WmpBODlmUWNXTFNwSXpVa0tpVCtjL3RNTmFrOWFSaStlcFh4cjBnT2NGQ2pN?=
 =?utf-8?B?eWQ2UkZtL05acThmV2YxNElOb2ZXTGVJNFF4c2JoY09sWEh1ODhZVyswUUlY?=
 =?utf-8?B?bjRpdU5IZ2RUUmVmZmpYQS8zNzcrbU13YlRWV3p6QXVYWVZtZmtXNVMzalVU?=
 =?utf-8?B?WWtIWWpWL29ITUFHTlQ5cXhCZVZSanQ0bVNXUjMweSswcDdZdDFudUUvVlhK?=
 =?utf-8?B?czNrYkthQXRKK2Vpc0Y1cFlXRCtxZnF6TlZPMERudE5mZG83QktydTNKZE1m?=
 =?utf-8?B?UVo0M05qUnRqS2V2czNFOUJ4T1NGbzhiSEY0YWQxVXFta1c0SEhQaVRXN2Ix?=
 =?utf-8?B?WG5NYmRlS0t2WUtjeDVDZE9DTEsrK1Z0R3NiVWhMbGl0RW9KNnV5T1QrSWVl?=
 =?utf-8?B?RzdETW9acWh3VGRzcTVkT3UzL3cxUFdwRnZ6U0l2aytSeGxqdFlPNVc4YVJM?=
 =?utf-8?B?Z0pqN3BDQk01S2pzZTZOWWtSU1QwL05HRHMydno3bzhTaEFXOU1VbjBkOEhW?=
 =?utf-8?B?U1JVRUVlcUdRSWQ5U1oxSm5EUVVobWg0T2RuQ0FkdUNWZjJHTnBsckZxSUhQ?=
 =?utf-8?B?Ni95M3ErTmh2c3F1SU5WUjdCd0p4UjdrSVk3VDVhNDdiQVBoQk10ck9zbTln?=
 =?utf-8?B?cGdndmpyeFR3cDV2elRmRG9FZnpDR3llRWM5NVNscjhSbERtMFpPSDVDK1Jq?=
 =?utf-8?B?YngxT01pZldBTWRPQ0xHeFFidEhkZ3cyblBZYmxFUkh2NUNQMzMrcSszdE1m?=
 =?utf-8?B?NGxmczNaS3lTNWliYnA3aS9GOStmTVZkcmV2R3RyQWdKQVJOSW1GK2dPVVo3?=
 =?utf-8?B?bWFDdFlNUTlLWXhsbmdEcXJEMzNLNnExMERBK2dmQ2VOako1UzQ5d2FwM0J6?=
 =?utf-8?B?dnRiY3FHUUpzSTZEaWNybjFSK2Rzd3BKTTNvWGhoNUg5SHA2eFRBaWpkU1Fo?=
 =?utf-8?B?NmJJQkRlUjJNR0kvTHE3RXVZOUp4TUtJN2dKejJjNE5DM0thcjlvUTB0bStI?=
 =?utf-8?B?UTNOR1NjSVZ1RXM3VEw2UEdkN3c2RHhRN28zZW5GZFFqUmxlTGZibE1pdzk3?=
 =?utf-8?B?Q1F0OTZHWUVoR0Q1U1RKWUFsa1ljUVh5QnNzSWtwcWVXRTI3VWtTSFNWb0NY?=
 =?utf-8?B?RHJibDVwUUJkTkJOWWVOVXQzdENoSXh1VWU4c2QrZXk2MWVoalg2NGdnUmN1?=
 =?utf-8?B?SGFVZmZpWGNxclF5NVVjSmpDVG9Ic0lvZEpRQmw4b016UStUNHI3YjM3NFdP?=
 =?utf-8?B?SmhqMFFlOWRVVXlHS2ZHUmx1YkhaL2pVbHRGa2FrMHEwSlpvK0x6MHZxS0xq?=
 =?utf-8?B?Q0pSa3h1Zm9ZNWVndno4cjBkUUhwams5WitQYWdObmFVRTRjbnY0eTg2US90?=
 =?utf-8?B?VFR0dllOZHJUMy91MThzY0FJSkk5Rk5DYmxTeC94MjhURlQ1aDRaVUdVSFhD?=
 =?utf-8?Q?5I1FoUEgaAozN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHdVc0cyb25IN0RKbmYvc3lEd0dqd00yN0pCUkpydTRYbjBpTGovd2ZjZlpy?=
 =?utf-8?B?Wld1TXkxRnFRSC92NXBveTV2ckhiWkIxQnBpdkw0MDB1RGFEdVo4RnBmY3dS?=
 =?utf-8?B?aDVOTlNSY0p4M1NPb2lEWTYrVmJ4eFZ5VTZYQ2lYQW1TeURhSlB1M0c1N01J?=
 =?utf-8?B?T0tZc3Z5eE5TbEMyVFdJZFpvQ2tVUHpoT3Q5VWR4TEVXV2srV1F0MjlXajVB?=
 =?utf-8?B?cjNuTHhrT2xsK3NJWE9GcXhJd0dCeGtJT21NWGNVVk1VMkdBbnhlT05QWGRz?=
 =?utf-8?B?YzFDaDVKVGRDTUdYaWlVdzhkbG1iQ3pXSE5hYUFraWJ6VEw1RW9FY3dlY2NR?=
 =?utf-8?B?eTZ5TlRpVHJSbm1EWW1GUXZMRVZQZjd0endwZmZBZXh6QkgyMktDaXVkZkZS?=
 =?utf-8?B?RWFHTm03ZE9jYWFkQytMaVcwWERjZzE4b0xsN1B0U1Q3c0p1UDd4UFFPbFhS?=
 =?utf-8?B?c0RoMVZrZTdta21TbDFjaEZhSjJ5emRpUk5ZZE1HQkJNN2VkeENVTUdERkJP?=
 =?utf-8?B?ZVdIWlo4Tk82WFRPaWRqYUtoQ3pyNFN0Znh2bmFrOEI1R0pIS1hqbnZmN1RC?=
 =?utf-8?B?dmRRSHpvZG9wTUhoeThVZ3d0QW84dGFrNm1zNzZjbEJ3aEUvZDgwblhwK2JY?=
 =?utf-8?B?NzgydytDaDNMZFBwREdMWjExUjJHK3MrVktWd2VFOUtWU2ljMzF4SFh2QzNS?=
 =?utf-8?B?Z0NwdXdqRWw5dGFTVGw0eVJSWFRPL096QTIzUHZNeGs4aDNicUhaL0hyN1pt?=
 =?utf-8?B?dUVPZTNsR0xHNWcyNEZFVFJDZ2UxbmIxSExQL2pBMnJ2eVlUYVJMQThaWFpE?=
 =?utf-8?B?Y0o5VlpDbVpJYS9BWTJNYWNDckhnN1NlSWVOSmJYdUhINTZ6NXBzWFJjOE81?=
 =?utf-8?B?ZVE1SlM2NGZ0K0kvcXc0d2ZBbUNIalgyWmlTczNqVE5YamRRenNGb3lKSEtZ?=
 =?utf-8?B?cG1oSSs1WlpRZlZRYU83QTBOSndqV25QOHZoNFFoYjMxUjA5am5oNWNtU2NT?=
 =?utf-8?B?L0xSSEZYMDc3VWlGYU52LzRLU3REcGRTL29CclNZOUZwekVKTUw3bDdaamNk?=
 =?utf-8?B?Y1A0ZmdVVmhSdURJaSt2cnhMOCt3bUVweklLN1g1bmw5Z2ViN0QrbEhwTVAz?=
 =?utf-8?B?YWRQSnpsVytDNmtjYXhqVHJLbGJzaE82UGw5b2FpYzBVTDFTVmV1MnNHQmtk?=
 =?utf-8?B?alFjNG9lMmNiMklmUmpIVFJ3SHZ3cmNDYlYvcUkxL3BTMTc5TTBFVGJnLy9u?=
 =?utf-8?B?QjNtNnNDeGR3SCsyTFZ1VzNsSWxnTS9RWXdMUm9kSmFrcis2b0dJVDh2enVZ?=
 =?utf-8?B?cVRRVStReG5OYzI5T2ZZSnNwbGRTQUJOemRlUU8vNmxISFZFbFp1QzRSUzg0?=
 =?utf-8?B?Vk5xb2k5eEFvRThHUkFZT0pDWTRVVEYxczFoTm1OWlBqNjB0VS9sTjZ4eUpN?=
 =?utf-8?B?VlY1TzNYdE5MVDRTODFUVFVHT2NzN2dSOWdvWFVmVHEyUGx3akQvV042dFl0?=
 =?utf-8?B?TVZjMlEvYTdQUG5JemYvWkx4N0xJVUQrT05Za256VjUxMlpNMG0xZlE4VHJU?=
 =?utf-8?B?dVpmS0pjck9FVHFmcElzaGg4SjRpNEhRNlFud1ZIVThoaGRRVUoxY0V2Mmw2?=
 =?utf-8?B?UUJrVlJXeXRwcVczQk42cHdGdnNDZFgvOThPY3pTRmJOUmhaSjNpYmF6azBn?=
 =?utf-8?B?NHUvdXN3ZUJwLzlqVW1aVWFBTzErK3Q2NExTaTc3QXFlTU9JYWl3YWRuWXRZ?=
 =?utf-8?B?enBHZTlvZ2c3Kys4RHE1QlYraUF4anhiVk5vZTY0eHhPcGlydnRvdEJYUmMy?=
 =?utf-8?B?RHZPUDhLZ3VCN3lLWGdqSUl1cVZ5Tjg4WlFBdS9aSVBXaWVMWk4vLzVjWjgy?=
 =?utf-8?B?eTJWa3RUdTArbmYyUjRxaXdNaUJIeTMvQ3F4Tm1ySTNDbVFFblJpN1B1TXpE?=
 =?utf-8?B?ZXFXMGVYcHhxOVcxcnRnTUdTemc1UjZCa2tDbUVsQ0tEaE1UcmdxVEgxeHlH?=
 =?utf-8?B?S1RiaFl1YVgwOFhnSEZCTHhRTzYyVHJTVlhJM0xsVnpSQUo3UUN1Ty9jdzQy?=
 =?utf-8?B?VFdkZnNycjlJTStYbkN2dDZRaGpqczlXbEtBTHk3aEkvQ1ErTUlWVW5KYWF4?=
 =?utf-8?B?ZFluRjNuTENrdnZOZWJTb3E2VDZSTWkraHByd0h5bldoUkJSMkp3WnNSTVdl?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5AKjOgu6ROpbLJGQlqN7x9+82UmSo1PHQEYaMieQi37ltnWkoXB1JbP1fzLOwH7pvIJD0kZmvOv8fNmgufaNJxiX7BZKQi+byREvaP6cWU0ELL9rB4i4FUYU0rItvT7qko22PQBjQ0HRnPbQg4CkK1UZrQSXKU1cDfh87PTHpbXUHg8ijRTJPJlDx5Z1O0387Ksj+jbwg33PjLQE8FZqqhksKb1/EgRqBmfHDUpvjl2WXDj7B3JoosPxnZ7VGgzsV3iWSJygRtH2j+MJR5VjMSwhQ5uNgVWZS/zNMp2CasKV2J47HTFi9NJSLxqXHbT/nU96dNyNONcvi88q52JPjc7seMBtarR4OZ5NCkaLc376YbMoMNQ32xDAp/5Twq0YpO5BXtwgRn/tYAUshvbBTdPk51CDBrSAVQ63keOCcglbWdW/bMbWXdtHn3whVmXe74sy84Brd56dPUMF3s8NOou9YS/VvvAtW9J7v6bKgmGZQn+7fS7vMzKDnOzMES58FxAUxWesv0BzNRMKNCTDh+epplxOT0QqUfzGduFYeUlbSIz4vvv3vgLV9TYeWpMSKsmQDoJm9+ZqpAsoy/x2zdua3ciOjlImXc6NeTSl7io=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901c0d21-2190-4f64-ad5e-08dd3bd4939a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:37:15.4072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+BymHZ+sep42wHXYFZ9TCcx6xAxNae5QIOmUl1Y7wn7GQjxUe8wVcyi5HVdAhXYWVEbMExCmUN/3x6ZicPqwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501230129
X-Proofpoint-GUID: 534r2DR1szV-O0a76CQ3gjVj1rwJY-WP
X-Proofpoint-ORIG-GUID: 534r2DR1szV-O0a76CQ3gjVj1rwJY-WP

On 1/23/25 10:29 AM, Amir Goldstein wrote:
> On Thu, Jan 23, 2025 at 3:59 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/22/25 3:11 PM, Amir Goldstein wrote:
>>> On Wed, Jan 22, 2025 at 8:20 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On 1/22/25 1:53 PM, Amir Goldstein wrote:
>>>>>>> I am fine with handling EBUSY in unlink/rmdir/rename/open
>>>>>>> only for now if that is what everyone prefers.
>>>>>>
>>>>>> As far as I can tell, NFSv2 and NFSv3 REMOVE/RMDIR are working
>>>>>> correctly. NFSv4 REMOVE needs to return a status code that depends
>>>>>> on whether the target object is a file or not. Probably not much more
>>>>>> than something like this:
>>>>>>
>>>>>>            status = vfs_unlink( ... );
>>>>>> +       /* RFC 8881 Section 18.25.4 paragraph 5 */
>>>>>> +       if (status == nfserr_file_open && !S_ISREG(...))
>>>>>> +               status = nfserr_access;
>>>>>>
>>>>>> added to nfsd4_remove().
>>>>>
>>>>> Don't you think it's a bit awkward mapping back and forth like this?
>>>>
>>>> Yes, it's awkward. It's an artifact of the way NFSD's VFS helpers have
>>>> been co-opted for new versions of the NFS protocol over the years.
>>>>
>>>> With NFSv2 and NFSv3, the operations and their permitted status codes
>>>> are roughly similar so that these VFS helpers can be re-used without
>>>> a lot of fuss. This is also why, internally, the symbolic status codes
>>>> are named without the version number in them (ie, nfserr_inval).
>>>>
>>>> With NFSv4, the world is more complicated.
>>>>
>>>> The NFSv4 code was prototyped 20 years ago using these NFSv2/3 helpers,
>>>> and is never revisited until there's a bug. Thus there is quite a bit of
>>>> technical debt in fs/nfsd/vfs.c that we're replacing over time.
>>>>
>>>> IMO it would be better if these VFS helpers returned errno values and
>>>> then the callers should figure out the conversion to an NFS status code.
>>>> I suspect that's difficult because some of the functions invoked by the
>>>> VFS helpers (like fh_verify() ) also return NFS status codes. We just
>>>> spent some time extracting NFS version-specific code from fh_verify().
>>>>
>>>>
>>>>> Don't you think something like this is a more sane way to keep the
>>>>> mapping rules in one place:
>>>>>
>>>>> @@ -111,6 +111,26 @@ nfserrno (int errno)
>>>>>            return nfserr_io;
>>>>>     }
>>>>>
>>>>> +static __be32
>>>>> +nfsd_map_errno(int host_err, int may_flags, int type)
>>>>> +{
>>>>> +       switch (host_err) {
>>>>> +       case -EBUSY:
>>>>> +               /*
>>>>> +                * According to RFC 8881 Section 18.25.4 paragraph 5,
>>>>> +                * removal of regular file can fail with NFS4ERR_FILE_OPEN.
>>>>> +                * For failure to remove directory we return NFS4ERR_ACCESS,
>>>>> +                * same as NFS4ERR_FILE_OPEN is mapped in v3 and v2.
>>>>> +                */
>>>>> +               if (may_flags == NFSD_MAY_REMOVE && type == S_IFREG)
>>>>> +                       return nfserr_file_open;
>>>>> +               else
>>>>> +                       return nfserr_acces;
>>>>> +       }
>>>>> +
>>>>> +       return nfserrno(host_err);
>>>>> +}
>>>>> +
>>>>>     /*
>>>>>      * Called from nfsd_lookup and encode_dirent. Check if we have crossed
>>>>>      * a mount point.
>>>>> @@ -2006,14 +2026,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
>>>>> svc_fh *fhp, int type,
>>>>>     out_drop_write:
>>>>>            fh_drop_write(fhp);
>>>>>     out_nfserr:
>>>>> -       if (host_err == -EBUSY) {
>>>>> -               /* name is mounted-on. There is no perfect
>>>>> -                * error status.
>>>>> -                */
>>>>> -               err = nfserr_file_open;
>>>>> -       } else {
>>>>> -               err = nfserrno(host_err);
>>>>> -       }
>>>>> +       err = nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);
>>>>>     out:
>>>>>            return err;
>>>>
>>>> No, I don't.
>>>>
>>>> NFSD has Kconfig options that disable support for some versions of NFS.
>>>> The code that manages which status code to return really needs to be
>>>> inside the functions that are enabled or disabled by Kconfig.
>>>>
>>>> As I keep repeating: there is no good way to handle the NFS status codes
>>>> in one set of functions. Each NFS version has its variations that
>>>> require special handling.
>>>>
>>>>
>>>
>>> ok.
>>>
>>>>>> Let's visit RENAME once that is addressed.
>>>>>
>>>>> And then next patch would be:
>>>>>
>>>>> @@ -1828,6 +1828,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct
>>>>> svc_fh *ffhp, char *fname, int flen,
>>>>>            __be32          err;
>>>>>            int             host_err;
>>>>>            bool            close_cached = false;
>>>>> +       int             type;
>>>>>
>>>>>            err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
>>>>>            if (err)
>>>>> @@ -1922,8 +1923,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct
>>>>> svc_fh *ffhp, char *fname, int flen,
>>>>>      out_dput_new:
>>>>>            dput(ndentry);
>>>>>      out_dput_old:
>>>>> +       type = d_inode(odentry)->i_mode & S_IFMT;
>>>>>            dput(odentry);
>>>>>      out_nfserr:
>>>>> -        err = nfserrno(host_err);
>>>>> +       err = nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);
>>>>
>>>> Same problem here: the NFS version-specific status codes have to be
>>>> figured out in the callers, not in nfsd_rename(). The status codes
>>>> are not common to all NFS versions.
>>>>
>>>>
>>>
>>> ok.
>>>
>>>>>> Then handle OPEN as a third patch, because I bet we are going to meet
>>>>>> some complications there.
>>>>>
>>>>> Did you think of anything better to do for OPEN other than NFS4ERR_ACCESS?
>>>>
>>>> I haven't even started to think about that yet.
>>>>
>>>
>>> ok. Let me know when you have any ideas about that.
>>>
>>> My goal is to fix EBUSY WARN for open from FUSE.
>>> The rest is cleanup that I don't mind doing on the way.
>>
>> I've poked at nfsd4_remove(). It's not going to work the way I prefer.
> 
> Do you mean because the file type is not available there?

Yes.


>> But I'll take care of the clean up for remove, rename, and link.
>>
> 
> FWIW, this is how I was going to solve this,
> but I admit it is quite awkward:

I'll deal with it. In the long run, making fh_verify() return an errno
so all of these helpers can return an errno rather than status code
is where I want to take this. But for now, a simple approach is best
because that can be cleanly backported.


> I now realized that truncate can also return EBUSY in my FUSE fs :/
> That's why I am disappointed that there is no "fall back"
> mapping for EBUSY that fits all without a warning, but I will
> wait to see how the cleanup goes and we will take it from there.

It's better for us if we can identify the particular system call
that returns -EBUSY. Auditing these cases might show that a blanket
approach is fine, but we still need to do the audit no matter what.


-- 
Chuck Lever

