Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D93512648
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 00:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiD0W6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 18:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiD0W5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:57:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443BFB3C61;
        Wed, 27 Apr 2022 15:52:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RKSctm011396;
        Wed, 27 Apr 2022 22:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5CzLyxzNI38dfsZeCxYoztdGnPx0byAdwdcH0jJi+No=;
 b=tMO/1eOQa/gvoFMpCtZ09BIPaNNzNjx3ZODqvqoCZgFfgZ4c54IQcoQ9eFTeYMsfYoB8
 F2AvEFMBl/vWBJQHu5xVO/Y1xxI5bFALBC1mywB1edp5RIm01ikl8TRSdCAeTfpvR4q2
 7DoHmtcI2p1PG7YfCwqRFg5ljc4ZlvA/ZE4mhzKKiFQ2cyXCuJ0xxfXAVKBH+HUR0899
 5p3NzHz4qvq0YeFhate6cb+1p26k9LMvRtsaBlCMOv0sHR5CuS7vOe/kFBlsNiTer+pw
 4neVsurMgpKsGEqpej8kIO5TCkTm6K/F4KNU/+lgr9Tr3LGcS+DjZZzlPlwtsKExXcZK Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4jj5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 22:52:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RMpAuj036564;
        Wed, 27 Apr 2022 22:52:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5n7k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 22:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4wVltjy5Locq95wWxK22EuUTNLj80XcHMBQTvbr3An04kV7MOkkPj3TnTX3iHDQ4vUEkh2js7yJWhQG/nAMPCHaerCOXFLW6dKFvZb0ud8LhLSsrAX9GyoByLWc7gcm5XercYpMHy2BEkRZGA8QmBa1xxct/w7YeSQaaKN75qlzPppqVg7aAmmxyJcyYZ+zycdfSF7GWN6wn9WVw3Q7hvBjSq+renkPRXj2F5c1ENsoYn1pv00mWQNk1HS0oujwJvy+WxN+cnX//AFDnz/Co1xN6cGd57xY+T24nK7TpoGvi4zORD2qiv35O5mFfRMvZRdZjAtWiyPJYGXhtnEMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CzLyxzNI38dfsZeCxYoztdGnPx0byAdwdcH0jJi+No=;
 b=ixf7yfnHop2l9nqrYO9xD9omNP7ZzlYCjsD9HB2wOsluQSjruU3yKo6dT/8BW5yIuM57KRe3UKiORnm5iFJbDF8sOhu8nAAAcW7kxnPXKd5tA4rNe4cOrj6o+EHGzuNlvFf14IJ0/UCImW/quZBam/Srd0emLYAdC80KgzX7AnBuVUNvRAY5ATbLal1Rx02TPzXRybXvlaQT6ycrsYsBio2emU3MphVGm5l0cIflJTfjCkqJ7A8jLsBMB8KZwb+1/jgcd5ftoGGASD2Jkk7w5sVrHJhTe1fGOXcaCx5rjnqLBl/KfUBXcOoXK6xVgsKuU3+5/27ho+j0XipvORHSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CzLyxzNI38dfsZeCxYoztdGnPx0byAdwdcH0jJi+No=;
 b=iHPJC1tkSY6/JMniPClKgghlYfo6eetYWk/sGcEGWW87lrkCba+ZOgySHbDZG9LDUALgWMppl9FTwdN0oyGwV/q5CfQdFCHMLMmc9zyvriDaIdU8zqPINZ/a80J5blNIt7YpVR9JhwFCH3PluLcGNLz7AguuCkORvQGIXzWZmEQ=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW5PR10MB5807.namprd10.prod.outlook.com (2603:10b6:303:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Wed, 27 Apr
 2022 22:52:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 22:52:40 +0000
Message-ID: <24607d8d-9a69-b139-ce1a-c0f70814de05@oracle.com>
Date:   Wed, 27 Apr 2022 15:52:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v22 1/7] NFSD: add courteous server support for thread
 with only delegation
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
 <1651049573-29552-2-git-send-email-dai.ngo@oracle.com>
 <20220427215614.GH13471@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220427215614.GH13471@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a61a9ac-d3dd-422f-ed5c-08da28a0a1b0
X-MS-TrafficTypeDiagnostic: MW5PR10MB5807:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB5807D3E7781C0A9F7FA5AB1887FA9@MW5PR10MB5807.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLQV78kd1UbFAjb6dz0H6IlNm0G3qrbqExfiv0iLPsK4aUJhPmxPamypJeFhF6II4ZqJvmKihdDnn522enbJeaaex5d8V3YoW7vpMtd7EZzTF/sGPHS2+SUrkEE4bUASJmEuG+9P1p7L7V3NVCgD0SGomUDsPG0GlS3gPzlboq28U05osvPmR6FngeQu/keuK1hX8gErkwM3yad4sumFZmIWHKwT/F6f5gQfpwnrLd+Q/GBkgfnMkdY2qMtMaABN2fHRRoc0cWR6/wYmcZBUXH/m7miXGCkrECkTqKaYTiLZvNxAJxbRMSYTKa9L/K5vUXCh47iS6YiwDhjMo2/T5Lywyi3YLHpqnb8uGOlCBBGMOeVTMywS+0oJHd+uHQ5CoEqvgZ3g74Y21mMzIdtXrtLI2jjulQII+w/CzKBJtPNJDTuzrqLSyTLnarDulmsGk1tCpa9YkTWr1l94YusMaDKBazqnBhK6P8GkFDHqlgvzeh5AkRACUDNdntph2o2ZuAn3AWU8OO/+F0qSQzAOegLHij9C/Y/Hj0dI2/LnCFhLYoitwfjlerJRqpKB2Z2hufKfEST1JLgnzndS5IhuQIl+zLYOO+5XcAhdPfm+LXfJVCC/PCq5Wbc8SFG/pc9vOLUP5TxIePEGnECuB+30YjPuabydVAUokapbIWHpSGSyyIS+HMd6mYZBvijXLd8kuEndIE1oa8LFO89wHBZLVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(36756003)(6486002)(53546011)(2616005)(5660300002)(6506007)(31686004)(83380400001)(8936002)(186003)(38100700002)(86362001)(26005)(31696002)(6512007)(6666004)(8676002)(4326008)(66556008)(2906002)(508600001)(66946007)(66476007)(316002)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRyK1JYZmpqZXNLazZySisvdlhrbndMcmxXWGc3R1lCV2RVQVp5N0Z3NVRM?=
 =?utf-8?B?SVIvU0VVMnIrVjhWOEV3T3Eva2xsdlZkL2xnT2loVnV2VlpJV1lNdlBCQTV2?=
 =?utf-8?B?bjJTZnpGSFpZYWZYU3dPVWkwUnZrZjJKK0xVbXdaMHd2ZlVTb1NXbDVFNXlq?=
 =?utf-8?B?OHBJdmV2a01Db0NnRDA1U1VtNjNrclV5L1ltZHBvWXlObFhHT3lja1ZVNnNN?=
 =?utf-8?B?Mi9sbFY1YU9SNitNVUxXeXhDY1hROVVmVEUyenp5aFg2NjVrcXRkZkNsazkz?=
 =?utf-8?B?akNtaFFZT3RUVjZHTTRmcHE1ZkN5QmM5WjN5MS90OVNXdE0xVDV3Q1FHOWEx?=
 =?utf-8?B?SStGc1RNdlFiSFRHR3JOWGxMbHNXL3RMMitNb0grTkxzRi9WYVJ4NU8vUndB?=
 =?utf-8?B?VXZsWGd0ZFJHSGJ5emxWM2pBZ21INGptKzR4WXhwZXZVMmNQWU91ekxOWTdx?=
 =?utf-8?B?Vm9tYVB5ZGtaNjBQVjN5SXZONFFlbFlOQXM3bmxvZzc0dnZ5MDRZQ2VQV0N5?=
 =?utf-8?B?Vk4wL3MySXgwby9iNzIxcTFkRHFna2d5bWlDdUc1M2M5c2dJZFQrM1NKVmZJ?=
 =?utf-8?B?YWRrWmZrWTlaYlN0UVZvWGsvNVhyUGVRMTBORElMR3ZmeUNWQ3Q4YmZETG5T?=
 =?utf-8?B?WE80aDFzVW5JanY3V1BVaVVQenBVOVZUczdmc09ubnpKU2lsQzFvblhRcE0z?=
 =?utf-8?B?NTNJbklpVDFEbVhPWElxcmd6YVFrMXI2SVMzZlRoT0UxeldPVkpENUVhU1Bj?=
 =?utf-8?B?QkdxSnlkcXlaakZlaUQzZDlQeFFLTWNmd2d0V0p5bmQ5dmY1YUJmb2hmVE1a?=
 =?utf-8?B?QXlrbHQ2YmsvNzRoeEU0TEp4VW92bmlvbDY1K08wZ0pyNFM5SDFGTitRZFVp?=
 =?utf-8?B?WnkzTXp2enBCalNNRzRDdFExL3dqcmVVTEkwdElaczhRczVyVE1FMjFyd3NG?=
 =?utf-8?B?WEhmYkt0MzVSZmFTUzNpM3MzVGtNRW80M1FPZUEzMFcwSU1teUtSR3A4RkNM?=
 =?utf-8?B?NzZrSlo0WGFSaHg1MHhUK0Ywdkw2MGtGYkpOZUZXeGtYWnlGVDQwbmFTemRT?=
 =?utf-8?B?ZE9EMGZRNlkvcXh1RzltVDJ5Skh6VWxqZmFmZEFYOUdNMnNBa2xWZWd0SG1Z?=
 =?utf-8?B?RUIxUFZibmN2ODR0L2xHZE51bjhJODZ1YlJJNkNIVWtNU29tVVBPdTJGaEJK?=
 =?utf-8?B?RWRxamRXbU1uRGEvRis5TzBNVGVzRjdqdlR3WGJDOXIxU09lZEQyRngyKzEx?=
 =?utf-8?B?UWI4ME1ldE9EOWVqWU1BYzdjTVljTXRXb2NkZ3U4cFFjVXhqVDBqRnBmNGp2?=
 =?utf-8?B?d09xd0NBaG42Ky9kTXV6ODRLVyt5VytEUXBzUHFEUzY4RittcGxMeXBlc2I5?=
 =?utf-8?B?Sjk2a3luOGsyOVdKckh2UitweC9saSs2MHpsZC9lQVFtMk9YeUR1a2FDL2lB?=
 =?utf-8?B?QzlUVTUwOXR0ZFo0VUxCYTUzYklEVVFwcWJYbjAzbW1KYWYvNTQ1MWh6ZTFy?=
 =?utf-8?B?bERxVWNnajVCbWtDTjh4c1Nqa2VaY3c4bjcwSG1uNUhKRzcyb0hLT1licGtY?=
 =?utf-8?B?LzRpcjBla0ZWKzg5b3QrbUZ0eFJiU0FHQUtlSjVrNnBtYjR4VHVXcDlUMzhP?=
 =?utf-8?B?Y0FzdHgzZWFuNCtRTjR0bkhxUzR6OGFNQmhsZ3RQQ1hYL1BrTlVYcFhMYkNi?=
 =?utf-8?B?VlpUb3NZZDM5T2JtdXIwYm95bVFoNFk1S1B6VXhlT0pQUXNFVElFRFJhK2kw?=
 =?utf-8?B?NDBXS2VwaWVoVitxYURuVzNyZDdtR3E1enpIbGMxOEpTUDd6SXViWVk1b1JE?=
 =?utf-8?B?cHdIMEgwTE5WLzREaGJEbHpsZzhtM0llc29sRnhHdzhSMGZFZjBnYks0cWls?=
 =?utf-8?B?QVR5S1ZpZjlNMm00bWdHRzFmMWNHc2JUN2lvR2pqcmNuQUNuMEcyRXpVYTBT?=
 =?utf-8?B?YXpYb0JFTnNXVFAxMGtFZ3VvUWRaR0RxSm5rN2pHT3p6SGpnMzhkNXBNQWpQ?=
 =?utf-8?B?RGpDQ2hOZk8zd1lJaC9iaU5VTkttOFNJc2ZxNWQwMHdnazBVRW5GdTRZZmJv?=
 =?utf-8?B?VTNBd0JIWjc0ZzlrNSsyQ0N2MUcyNEY0cjhycUQ0RC9jeFNlejVBL092V043?=
 =?utf-8?B?Vi9FT0UyWC9vQkR3WExhUkhGbHpySVNPdU5tSnhqTmZobWdFTlJjNFlBSGx4?=
 =?utf-8?B?T2U3SzRRdzR4clJqNGwxK3krNDBqZzlXOU5MbjVhOU5OS0lOcDV6RTE2cWpB?=
 =?utf-8?B?NWFvbE9YOXExUkFKbHN3OUMxMXU4Qm8vSXI5MmxPa2YwWHRmRUxZQ2Jjbnlu?=
 =?utf-8?B?SDYyRDhMNE5LSUhkNWxETVdZUEVSWDlZYlZ1ZEpGRTIwYU8rTlByQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a61a9ac-d3dd-422f-ed5c-08da28a0a1b0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 22:52:40.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niDCL4eYuSippt2yNJ4f9SLBZbwqyDAGTQ9KcKOz+fxwL8nV3fujMYKWv/3tKTDKVomQe1hb/icIfsRSBtkNxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270134
X-Proofpoint-GUID: LqwFJ0kkABCuUFDdUY7PHb3D4Gh0MKiy
X-Proofpoint-ORIG-GUID: LqwFJ0kkABCuUFDdUY7PHb3D4Gh0MKiy
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/27/22 2:56 PM, J. Bruce Fields wrote:
> On Wed, Apr 27, 2022 at 01:52:47AM -0700, Dai Ngo wrote:
>> This patch provides courteous server support for delegation only.
>> Only expired client with delegation but no conflict and no open
>> or lock state is allowed to be in COURTESY state.
>>
>> Delegation conflict with COURTESY/EXPIRABLE client is resolved by
>> setting it to EXPIRABLE, queue work for the laundromat and return
>> delay to the caller. Conflict is resolved when the laudromat runs
>> and expires the EXIRABLE client while the NFS client retries the
>> OPEN request. Local thread request that gets conflict is doing the
>> retry in _break_lease.
>>
>> Client in COURTESY or EXPIRABLE state is allowed to reconnect and
>> continues to have access to its state. Access to the nfs4_client by
>> the reconnecting thread and the laundromat is serialized via the
>> client_lock.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 86 +++++++++++++++++++++++++++++++++++++++++++++--------
>>   fs/nfsd/nfsd.h      |  1 +
>>   fs/nfsd/state.h     | 32 ++++++++++++++++++++
>>   3 files changed, 106 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 234e852fcdfa..216bd77a8764 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>   
>> +static struct workqueue_struct *laundry_wq;
>> +
>>   static bool is_session_dead(struct nfsd4_session *ses)
>>   {
>>   	return ses->se_flags & NFS4_SESSION_DEAD;
>> @@ -152,6 +154,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
>>   	if (is_client_expired(clp))
>>   		return nfserr_expired;
>>   	atomic_inc(&clp->cl_rpc_users);
>> +	clp->cl_state = NFSD4_ACTIVE;
>>   	return nfs_ok;
>>   }
>>   
>> @@ -172,6 +175,7 @@ renew_client_locked(struct nfs4_client *clp)
>>   
>>   	list_move_tail(&clp->cl_lru, &nn->client_lru);
>>   	clp->cl_time = ktime_get_boottime_seconds();
>> +	clp->cl_state = NFSD4_ACTIVE;
>>   }
>>   
>>   static void put_client_renew_locked(struct nfs4_client *clp)
>> @@ -2004,6 +2008,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>>   	idr_init(&clp->cl_stateids);
>>   	atomic_set(&clp->cl_rpc_users, 0);
>>   	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
>> +	clp->cl_state = NFSD4_ACTIVE;
>>   	INIT_LIST_HEAD(&clp->cl_idhash);
>>   	INIT_LIST_HEAD(&clp->cl_openowners);
>>   	INIT_LIST_HEAD(&clp->cl_delegations);
>> @@ -4694,9 +4699,16 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>   	bool ret = false;
>>   	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>>   	struct nfs4_file *fp = dp->dl_stid.sc_file;
>> +	struct nfs4_client *clp = dp->dl_stid.sc_client;
>> +	struct nfsd_net *nn;
>>   
>>   	trace_nfsd_cb_recall(&dp->dl_stid);
>>   
>> +	if (!try_to_expire_client(clp)) {
>> +		nn = net_generic(clp->net, nfsd_net_id);
>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +	}
>> +
>>   	/*
>>   	 * We don't want the locks code to timeout the lease for us;
>>   	 * we'll remove it ourself if a delegation isn't returned
>> @@ -5605,6 +5617,65 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>>   }
>>   #endif
>>   
>> +/*
>> + * place holder for now, no check for lock blockers yet
>> + */
>> +static bool
>> +nfs4_anylock_blockers(struct nfs4_client *clp)
>> +{
>> +	/*
>> +	 * don't want to check for delegation conflict here since
>> +	 * we need the state_lock for it. The laundromat willexpire
>> +	 * COURTESY later when checking for delegation recall timeout.
>> +	 */
>> +	return false;
>> +}
>> +
>> +static bool client_has_state_tmp(struct nfs4_client *clp)
>> +{
>> +	if (!list_empty(&clp->cl_delegations) &&
>> +			!client_has_openowners(clp) &&
>> +			list_empty(&clp->async_copies))
>> +		return true;
>> +	return false;
>> +}
>> +
>> +static void
>> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> +				struct laundry_time *lt)
>> +{
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +	bool cour;
>> +
>> +	INIT_LIST_HEAD(reaplist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (clp->cl_state == NFSD4_EXPIRABLE)
>> +			goto exp_client;
>> +		if (!state_expired(lt, clp->cl_time))
>> +			break;
>> +		if (!client_has_state_tmp(clp))
>> +			goto exp_client;
>> +		cour = (clp->cl_state == NFSD4_COURTESY);
>> +		if (cour && ktime_get_boottime_seconds() >=
>> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT)) {
>> +			goto exp_client;
>> +		}
>> +		if (nfs4_anylock_blockers(clp)) {
>> +exp_client:
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +		if (!cour)
>> +			cmpxchg(&clp->cl_state, NFSD4_ACTIVE, NFSD4_COURTESY);
> I just noticed there's a small race here: a lock conflict (for example)
> could intervene between checking nfs4_anylock_blockers and setting
> COURTESY.

If there is lock conflict intervenes before setting COURTESY then that
lock request is denied since the client is ACTIVE. Does NFSv4, NLM
client retry the lock request? if it does then on next retry the
COURTESY client will be expired.

>
> I think what you want to do is set COURTESY first--right after you check
> state_expired()--instead of doing it at the end.

Yes, I can make this change. I think this still has a tiny window
where a lock conflict comes in after state_expired and before
COURTESY is set?

-Dai

>
> --b.
>
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +}
>> +
>>   static time64_t
>>   nfs4_laundromat(struct nfsd_net *nn)
>>   {
>> @@ -5627,7 +5698,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   		goto out;
>>   	}
>>   	nfsd4_end_grace(nn);
>> -	INIT_LIST_HEAD(&reaplist);
>>   
>>   	spin_lock(&nn->s2s_cp_lock);
>>   	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
>> @@ -5637,17 +5707,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   			_free_cpntf_state_locked(nn, cps);
>>   	}
>>   	spin_unlock(&nn->s2s_cp_lock);
>> -
>> -	spin_lock(&nn->client_lock);
>> -	list_for_each_safe(pos, next, &nn->client_lru) {
>> -		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> -		if (!state_expired(&lt, clp->cl_time))
>> -			break;
>> -		if (mark_client_expired_locked(clp))
>> -			continue;
>> -		list_add(&clp->cl_lru, &reaplist);
>> -	}
>> -	spin_unlock(&nn->client_lock);
>> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>>   	list_for_each_safe(pos, next, &reaplist) {
>>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>   		trace_nfsd_clid_purged(&clp->cl_clientid);
>> @@ -5657,6 +5717,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	spin_lock(&state_lock);
>>   	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>>   		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>> +		try_to_expire_client(dp->dl_stid.sc_client);
>>   		if (!state_expired(&lt, dp->dl_time))
>>   			break;
>>   		WARN_ON(!unhash_delegation_locked(dp));
>> @@ -5722,7 +5783,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>   }
>>   
>> -static struct workqueue_struct *laundry_wq;
>>   static void laundromat_main(struct work_struct *);
>>   
>>   static void
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 4fc1fd639527..23996c6ca75e 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>   #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>   
>>   #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>   
>>   /*
>>    * The following attributes are currently not supported by the NFSv4 server:
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 95457cfd37fc..6130376c438b 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -283,6 +283,28 @@ struct nfsd4_sessionid {
>>   #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
>>   
>>   /*
>> + *       State                Meaning                  Where set
>> + * --------------------------------------------------------------------------
>> + * | NFSD4_ACTIVE      | Confirmed, active    | Default                     |
>> + * |------------------- ----------------------------------------------------|
>> + * | NFSD4_COURTESY    | Courtesy state.      | nfs4_get_client_reaplist    |
>> + * |                   | Lease/lock/share     |                             |
>> + * |                   | reservation conflict |                             |
>> + * |                   | can cause Courtesy   |                             |
>> + * |                   | client to be expired |                             |
>> + * |------------------------------------------------------------------------|
>> + * | NFSD4_EXPIRABLE   | Courtesy client to be| nfs4_laundromat             |
>> + * |                   | expired by Laundromat| try_to_expire_client        |
>> + * |                   | due to conflict      |                             |
>> + * |------------------------------------------------------------------------|
>> + */
>> +enum {
>> +	NFSD4_ACTIVE = 0,
>> +	NFSD4_COURTESY,
>> +	NFSD4_EXPIRABLE,
>> +};
>> +
>> +/*
>>    * struct nfs4_client - one per client.  Clientids live here.
>>    *
>>    * The initial object created by an NFS client using SETCLIENTID (for NFSv4.0)
>> @@ -385,6 +407,8 @@ struct nfs4_client {
>>   	struct list_head	async_copies;	/* list of async copies */
>>   	spinlock_t		async_lock;	/* lock for async copies */
>>   	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +
>> +	unsigned int		cl_state;
>>   };
>>   
>>   /* struct nfs4_client_reset
>> @@ -702,4 +726,12 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
>>   extern int nfsd4_client_record_check(struct nfs4_client *clp);
>>   extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>>   
>> +static inline bool try_to_expire_client(struct nfs4_client *clp)
>> +{
>> +	bool ret;
>> +
>> +	ret = NFSD4_ACTIVE ==
>> +		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>> +	return ret;
>> +}
>>   #endif   /* NFSD4_STATE_H */
>> -- 
>> 2.9.5
