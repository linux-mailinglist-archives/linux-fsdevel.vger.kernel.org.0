Return-Path: <linux-fsdevel+bounces-4868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4A8054DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 13:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC46B20DB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E93261696
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NDyqT3Ww";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UEwbplBF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F9135;
	Tue,  5 Dec 2023 03:10:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5AT6aB005616;
	Tue, 5 Dec 2023 11:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QYcm/eL4cgZQi0mx03/95Rvu1TPcMKGwMAkBsig0ojE=;
 b=NDyqT3WwBIvEUutG4UxAj87+RNZIP1D2Q/AMDvgRCgZFzE8/gLqGW4tZIkTnZ+P9rOXb
 x6Dqoi+wUzV/+kK6ymPikACZxMhQWohUfaoI371pXhrYGgcz8l7qY+jJJ1Mfl966vYXq
 cX9tbyEY0LerLu/FGiNWH93eIl5O7f26Nq8yRI9U7zrh4lxY1kUz/C2e+MnO/Fs0SyD+
 Nik0YWfe3U2SwhuwVM3LIASv1CzuSgSOnGyFTViPQMsRq1lHzkPSIUuVUDbXea+d17Bv
 La9A6CpSbTZRW0syKQS7lV73Nk9h6vGL3YjtmOJPjK/Ihqo/Fr3wsc5FO12E3M0qm7j9 Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut0qh09wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 11:09:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5AuYFj025939;
	Tue, 5 Dec 2023 11:09:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu17b4hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 11:09:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5NeIhnmPDrOcTGCVsS17RFMOuIANfML6O0ZKcd3uaRN0OuaLzoI3kq7P3+xiOWc96nFIzd45Xlr1cAxm7rGfGctP/6UpPWZoQVB7KGBWbpFoMQ69B7D43AwiMdfB3xC+qMfu9fvFNdziBFSAw4ZkMjbvmCtGJrGOSPx6mjJlDbEUeEgU5iQ/SHGIWSgZD7w4twTm83dHYPMEVVCCoKeC9NaWN7ZLNf4XBzeLYICpRKlVDgtRFqHUIVpR8WZSyeMu3mg+S0xLMLqNC9JpG0XWsJTNIVx5xVH0+A/GrcIpjK2mDxsKoODMsYEscofikAOUoBou6PrdprFE+XazI5v3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYcm/eL4cgZQi0mx03/95Rvu1TPcMKGwMAkBsig0ojE=;
 b=F9bT17QLi54ZrIfhv33m2bzsmk+ytBxNZ2zgGJTLId0fcF/P8CKvkp6RdxapJKgYhkJtJT+ScjJoGkJ60sPmspVr1ZSzT8r6tGWsj6lUQ6cGNOmWxjD1ajjOBYZTQljL5G/0G+eNgSXjCkqdjZEkkSiTW4Vn0k1L8XcGg6Si2Swsi581HYdFSRtS0Uxm2kyUZnx2RWeY9PNaKVUTzYZ65EqV5F72xoPbTQ4m9WlDJcXPiy7KcAKju9Bw63xzgsuQJO+3GQuH8TSZZhs101FDqvOwZbloZocb2sBGicPptdOU54kLC2DL2TRxamPqj3uCWXqogHv7Vzdrcfiyolqhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYcm/eL4cgZQi0mx03/95Rvu1TPcMKGwMAkBsig0ojE=;
 b=UEwbplBF1yBJoS1yZ8kPHMvIK80gJc8KbPtXX6OyTsihJzkIWB22XMCsbdzOkvd/SeBn3X4jHszxSPPkfC5tcfK5pV71+2U/YA4akDqaQydZuDCFgl5tZZxJiSw6GQ2scOT+Dawg/8KwGogV9fa5sT1wnktvs2LobKBG4K8e5Sc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB5757.namprd10.prod.outlook.com (2603:10b6:806:23e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 5 Dec
 2023 11:09:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 11:09:50 +0000
Message-ID: <4b41c8df-bc56-4ff1-b2ed-70ec00080f95@oracle.com>
Date: Tue, 5 Dec 2023 11:09:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-18-john.g.garry@oracle.com>
 <20231109152615.GB1521@lst.de>
 <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com>
 <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
 <20231128135619.GA12202@lst.de>
 <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
 <20231204134509.GA25834@lst.de>
 <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
 <20231205045539.GH509422@mit.edu>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231205045539.GH509422@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bba4f7e-1ee2-46ae-b40c-08dbf582b2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4/8mVAioN94YmWQC5B6nAX4XCsDCGLAeORrUwIwD1/DnqA8ZXkOzu6k4ZIRMdwMRt2lMYQyhLebeLge6gAK+J1pfFnpRucX+uvRbUDpTvcU6OT2jXki+NNbh7EOtcrFfPTcAJLJHnFhX/xlYQTheXGsjEI+OAfAcFjl09SZ0rrzNNMKaKt8QXQoc95z65UO1h1/mVob3TbwSIwWVlBDf6ttO9uZGFRf+98w2qyAld0KsHy80zRcieODKgYA0jLKe6q4MtvCTP29Gy48GWtHwyn667DW2VPsoEEBgkkEch1yUrheW9qlW33WG8iVRmRTwXwk67KwlM/7Z7bRS8nn1jXPtf43rH/qKfmPa9FTcAdJjVwg/6lIbd9oBzC1aQyz9akjdxhynu4BtZJC7vIAgb+EiIDnrv2cfVfhiYuu2om1c9Y5AH6Y5oYIp+FsczIcDNjpVSK72qqo03x+CthwPxVGoE4jM+eXgBxGDBK+qDyWctF0SkR8V1yBV1naWB5YlDVK954TGGv5GLi7c3NGtVIOLZJfYxS+pfM9LjOKYNyggWCvJaBvCeHKwBP005Vafesvrb2VrflBJyQdZJnMnOWWHO8Z/kE1K5Q8oVKDBnfzgZ+jturRH5Ym1kGSH3UtJUQ+0SLwv2twWKXW9nwddng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2616005)(38100700002)(41300700001)(36756003)(86362001)(31686004)(26005)(83380400001)(7416002)(5660300002)(2906002)(36916002)(6512007)(6506007)(53546011)(8676002)(31696002)(4326008)(8936002)(6666004)(478600001)(6486002)(316002)(66946007)(66556008)(66476007)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bTN5WVdTZ0RvZGdkSndLZGE2bnpMWTVKU0pXZ3Z4d1UvUjBaQzUxcGNOdVZV?=
 =?utf-8?B?WDlLNjZqNSt4b0lCZDZ0emlkdFdNWUVCaFp6TEE2WUpkcDE2aHRaWnNocVhU?=
 =?utf-8?B?STd3MFlTK0RnQkRta0daOHBmRmhkbHA0TW5JaVR2ZWx5WFppQlhhNy9LME42?=
 =?utf-8?B?L00yQzdnSW9VNmZYSG40VzdWLy94L3MrMnFGOG1ibVZkZWZyWWZUQUhxM1p2?=
 =?utf-8?B?NkZQSGtWcDBjVkY0NEthR2s2ckZ0MUE3STBLQlBVdVdjeFNuM1ZRMFBpTGJV?=
 =?utf-8?B?T1I5eEVmVkI5TzdmZmF5SkVNZkpmOXEyZ2FaUEJMYnQwVE1kNWJ6WERFakk3?=
 =?utf-8?B?SzdIMnJlcG5BeDRvUU1vTk0xanppa0ZVMTY3RjVrK05mOGJtNFFVUmd5cnNT?=
 =?utf-8?B?a1JqT1BvM204aDQ0WkVkcGx5OWQyUjh4Q0c2cXpGMlJYT3piZkJoeEdCOHl4?=
 =?utf-8?B?Y2tmNjNuMTUycW5ZMWt3Z3pSRDJ3NC9NWmNiSXFIb3BJdGJxV011MTJNWE1n?=
 =?utf-8?B?elBaMk5PSTR1MWdhNHJ0THVOSFJvZ1pUd0VnS05EMWlNUjhOMEtMQjVua0Rm?=
 =?utf-8?B?eHk0Tjc5Y3Q0aFRLSmorbmdIVFIxbE9Jbm1YcWpYcytGNnh4TlRuU1RUTVBV?=
 =?utf-8?B?RTBNRXZzQzdGTHY1dVVNOVBjUEtpbnRWcmE3YnFjMWJpa1Zqd2ZQV0tFVlgv?=
 =?utf-8?B?Y28vaFdveVlyUHpEWTdtb3FVRVNUYkxmdTFZbytYc2IrcEU2TndyNjZwbkpq?=
 =?utf-8?B?N2FDdCtMeUNPbGlISDVYanRWWW1OS2cyRlpRTnVaQkVxdEJJTmw5Vk80cHNX?=
 =?utf-8?B?S0hWREhMUEdPV1kwVEZ2bE1WWlA5RWQyamZLbnFLMWs0YlBuaGk0N21OcDRU?=
 =?utf-8?B?eUdERXk5ek9US2JWblEyell3NlRhNjVoSWJZUE53WDlwM1FvUm83ME5GQXV2?=
 =?utf-8?B?bEpLYmZFZzZ4MDVOZnFacnZIWFRhMHoxaWlMQjd1c3MrbytPYVJXVGRIWVlC?=
 =?utf-8?B?T0xzdngvMVd1NXEyY0pFaEdKU3ZkYVFpNnpPRHB2RzRSTmNYWGdUcW95c2U5?=
 =?utf-8?B?TlpRZlQ3L0p4aG5iWjA2NzhqNnpFV3duelgvSFIrR0hLZ0IxNXp2ZDhnak1i?=
 =?utf-8?B?VTRTL292U21ydHhrNi82R1Z2bzM0L1JQanJEMHM2VW1ETzNPY3NTVDNGMElW?=
 =?utf-8?B?amRaTGNCOGlsaDJVeHBGekNtcTN2OXphclB5VE1INXVJTnM3OUMxaHl4eHgz?=
 =?utf-8?B?V2JjbGU4MkRqWHoyYXM5aFAvZ2E3cVJaS0lhaXhJeUkvOW5FVWRqYU5qUjFW?=
 =?utf-8?B?ckp4dmZVQ2lzdC8zaVZlMVFUSm9vYjFaTUx3dnhTQUowelorc3lOUmVocGFP?=
 =?utf-8?B?a2pONHYvNTVLbGdndk1nWTdjSE4vMEh0b29oYW1FUmlhM1N3ZUN2b3l1aTE5?=
 =?utf-8?B?SkcvTUtGc2laU0FHZlczNUdoaVlxWFRlUXJuSUxoYUZxQ1Fvd0JEYjBmbVpC?=
 =?utf-8?B?RjFPUnRxTlZ4VmNkTlo4SXVnU0pHWmx5VDdPcVorZWtsVGJMWHEwb3lIYUNP?=
 =?utf-8?B?Qys0SmNyU01mb1pLVCtvbFVpNW9LVWhTcVdwNzg3MURXYSt0ZUZiNlF6TmNV?=
 =?utf-8?B?VjN5eHhHaHkzcWhwNmlPT2hGRmZtbDZzSzd2Q3liNW9rbXZ0S0pJK3NtWVcv?=
 =?utf-8?B?M3F0NE1wSkx1a0ZhUFN2aFlJajJFVmgyNDNlUEM0M0QrMGJYbXA4ckNta21C?=
 =?utf-8?B?TU5vSmFXQVJsclZJUS8rTlQrVUdqYmwxT2o3eGc0Mkh4SVVSMjBVVWVhNGFE?=
 =?utf-8?B?Q25yVFhXNVRQelIybWJiQTBRdFZWL0E2bWpRdHNiUkM5QlZ4d0c2YXhJTEEz?=
 =?utf-8?B?V3ZMdk9JUmIvQzBNakdPcUF3M21qUForQVZIQWp4ZkVmN1d3RHlqQkd1SEZw?=
 =?utf-8?B?NStGeE5xblhrWHJrL0tueXZZWllRbE81a0NBNTRoV25GOE84OW8rSHJkQnlz?=
 =?utf-8?B?RVJKdzNKMm1lSDN0aHB5MThoM1Ixa2VyQThhYjhsK2k5ZkNKa3VqY0l0V0hO?=
 =?utf-8?B?QTJRcTlMeDRsc2plbFZWSkhnZUdjbjV3blA4ZElTQm1UWWV1VWJqWUpGQlBH?=
 =?utf-8?Q?wihNyIutMTmUSPDTrjqYZv/qT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?MFpWY3hFT3NIN2svdUJ4WE0yR3RJMEphU1NTdUJDUkhoZEM2NmJwSkZuT2Zr?=
 =?utf-8?B?WEw1eDhobXM4a2VWTlF3WHpuSEpwNkJrZkVwVExQbWQvWnUvSUFxRnpOVEJs?=
 =?utf-8?B?Z2RwaVB4aHVhOTZJNjFDb2twZ1UzL2txd1Uwb1lEZGNYSE1lWUphTlZYNUgw?=
 =?utf-8?B?Z2ZKT1pJQm1zcTBrUmYwZUpiNGUzam5rc29NaVFJOWl1V2gwS21TalpMVkNK?=
 =?utf-8?B?YlFPbVlOQ25aSU9lL29uM2tSa1U3VDB6bVdha0tKQ01VMEtFa3BjUk5JZXcy?=
 =?utf-8?B?eUVZYVh0bzJJSTcvTmdsc25LR0Z4bnk4b2RGYVVMekxERnhxaW9GUFkxYmdx?=
 =?utf-8?B?aDltZUNBTFIyaENVcld4TzRTL0p4c0xQQjJwNE9pYTdnVXN2MmtVaWtiZ28x?=
 =?utf-8?B?NWk3K1ZQRTNseHpjaTdhVXJwRXRLRU5lUTRITm1rR1JNY1FINzlBWkxSSlZ3?=
 =?utf-8?B?SC91ZHR4MkxyKzhkN05sUzNmOWlhQ1hKbCsxbmJyOW1OZHFZVFlicHJJSXg2?=
 =?utf-8?B?ZUViVkVXQ0ZONDVVNHJZNWowWFR0anNHYkxSWkVVdW1xV0pFaEhBdWhQaXMz?=
 =?utf-8?B?c1hueFJJNHVka3lLS3hoYVFEaFZNNDBURUdCUE5IYU9yUm0zc1BXZmMxK1c0?=
 =?utf-8?B?U3JqQVg3SVN4OEYybWI0cTd0K2ZrTHlWZStibCtNSTl0ZHhBcG9nMStzRnhr?=
 =?utf-8?B?QjBzK05FT0h4SkJwZy90eXhGbFhtcFR1ZmwvbHY2b0ZDWWthUzZHR3BmZmRs?=
 =?utf-8?B?Y2NsMmk3NmRxWGMxRGxPcHJvSnRvd2wybDVPY2gzM3M3S2J6ajRIeElyMjRS?=
 =?utf-8?B?Q3VDMHoyQVYxNllqL1p4aEJWN1J3SVc5ZjI3ZkNyeDVPMWt1YnFadmZ4ekRI?=
 =?utf-8?B?KzBBR3QzODFHNEdUQmFUcTFRTHJTbVRkV1Nib1dSSGZzc3huKy9FWng1YjJO?=
 =?utf-8?B?MTltTm14TWNZM3Zmc25MWHdWS2pJY2xneHRKNnpFMjVIQ05KQVB2TlZRMEZz?=
 =?utf-8?B?S2R0QURVMHZsVzcxOVJINnZOSWY0QjZWa0FKZEJuN0hwWW9kWFVvWldaS01l?=
 =?utf-8?B?T2dNYnRtNm5BZHBNMGFVcjlXSXFHTVhuQitPRnpBUjVuYVFFZmFUKzJvaUpQ?=
 =?utf-8?B?UHFZQlJPd2RIdFczN0U2N2E4RmZPTzI2b3NNRGdySXdmaTh3bEx6ZFU3ZGo5?=
 =?utf-8?B?d2xWVVhGRTQyMnhOSGE2eUlYUFBCaTRDS0JvK0xvaCtCL1ljcDNzOUJRQWVM?=
 =?utf-8?B?Q1JlZmxRcHY1c1ZTTHVNWGdTWnIvc3duaGlWNzFNQnVsVTM5bnhzaDVyWjQr?=
 =?utf-8?B?VjR4STV0d1FXNGZqY1Bpem5MMWFiMlJHWTB2NUkzcEZqa2FPNUxvYkpjeE9W?=
 =?utf-8?B?SnNUN0dPMUdYb2lYWXcyUlVoQThnKzNmaFIrazhFNXlRdmhMRjUzSGtIQWZB?=
 =?utf-8?B?ZzUxWTM5eW15UWg1aTdOM2IvdVppUXVNcFpicnJ3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bba4f7e-1ee2-46ae-b40c-08dbf582b2e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:09:50.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw3Si1y6jQyHa35hEeDVkuhxeRLvwJwWGU/49FL7E1Sggs1iooss/PhDp5Fy/lCGDTuC4tOIycXZpjPW8JxNqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_05,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050087
X-Proofpoint-ORIG-GUID: BbUjamf91j4j2d6dycEIv6q1nDjgghas
X-Proofpoint-GUID: BbUjamf91j4j2d6dycEIv6q1nDjgghas

On 05/12/2023 04:55, Theodore Ts'o wrote:
>> AFAICS, this is without any kernel changes, so no guarantee of unwanted
>> splitting or merging of bios.
> Well, more than one company has audited the kernel paths, and it turns
> out that for selected Kernel versions, after doing desk-check
> verification of the relevant kernel baths, as well as experimental
> verification via testing to try to find torn writes in the kernel, we
> can make it safe for specific kernel versions which might be used in
> hosted MySQL instances where we control the kernel, the mysql server,
> and the emulated block device (and we know the database is doing
> Direct I/O writes --- this won't work for PostgreSQL).  I gave a talk
> about this at Google I/O Next '18, five years ago[1].
> 
> [1]https://urldefense.com/v3/__https://www.youtube.com/watch?v=gIeuiGg-_iw__;!!ACWV5N9M2RV99hQ!I4iRp4xUyzAT0UwuEcnUBBCPKLXFKfk5FNmysFbKcQYfl0marAll5xEEVyB5mMFDqeckCWLmjU1aCR2Z$  
> 
> Given the performance gains (see the talk (see the comparison of the
> at time 19:31 and at 29:57) --- it's quite compelling.
> 
> Of course, I wouldn't recommend this approach for a naive sysadmin,
> since most database adminsitrators won't know how to audit kernel code
> (see the discussion at time 35:10 of the video), and reverify the
> entire software stack before every kernel upgrade.

Sure

>  The challenge is
> how to do this safely.

Right, and that is why I would be concerned about advertising torn-write 
protection support, but someone has not gone through the effort of 
auditing and verification phase to ensure that this does not happen in 
their software stack ever.

> 
> The fact remains that both Amazon's EBS and Google's Persistent Disk
> products are implemented in such a way that writes will not be torn
> below the virtual machine, and the guarantees are in fact quite a bit
> stronger than what we will probably end up advertising via NVMe and/or
> SCSI.  It wouldn't surprise me if this is the case (or could be made
> to be the case) For Oracle Cloud as well.
> 
> The question is how to make this guarantee so that the kernel knows
> when various cloud-provided block devicse do provide these greater
> guarantees, and then how to make it be an architected feature, as
> opposed to a happy implementation detail that has to be verified at
> every kernel upgrade.

The kernel can only judge atomic write support from what the HW product 
data tells us, so cloud-provided block devices need to provide that 
information as best possible if emulating the some storage technology.

Thanks,
John


