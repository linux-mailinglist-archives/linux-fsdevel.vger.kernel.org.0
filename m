Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD04EFA4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 21:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiDATNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 15:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbiDATNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:13:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16736617D;
        Fri,  1 Apr 2022 12:11:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FiZgS014831;
        Fri, 1 Apr 2022 19:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pB6auUDIXaCbBmfQq+nHkxDYysNsnDAewY8YKzxjLow=;
 b=hW7EHaNiQgZb/R+VIGRc5Ed2tyloFQDBIYNmZCiCx64snRIFDFc4AFjaKdhkR3FtyQLH
 s3GxH2b/2dw/XVfTp7JTi4RfEInrs6VH3uI0/s16LYASussJG4YuvxWz3GoU/nydu/CP
 U+uNBEt0YAy28Uq60Sbu1wh51BzmzomayZVzZHXu/CySAL5hANRLmaZnHoYAp8OMbfwX
 J98gB1k9/Kq5qXSJ71UMxkMg4JeWuw89aTleaFPbf/EY+mUwufEPj2r36GvISeifT3o2
 oOix+jLm0CRda5r1+U9fpOZh/Keafsq8dpZR0YTM4YC9IUMkt5B4lz+H6/RacP+RDTfr aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2qwkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 19:11:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IvPB0025285;
        Fri, 1 Apr 2022 19:11:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s969t2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 19:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZejBq/Yjb4RmeBkKHRg40l3x0HK5VW8FKi+Z1LgLsTFI2Awy9DhY3sMPz50Z7mTEZITuUMrWClkCV8WF38JWqMmLKpdgsHDaytSq+S/Cp3M1AZtKNyzioiZb/jki5d7G8ip7SgXILdFKLn3bKcjtqpRWTePodC7/yDVhInYKOyU06ZEu650RTfUoSz9ZWt11ssrS7kSYeL3ctFZD+4IeieQlgXduLdxzz1w80HQyRgWGZC9K5iB2AH72+3ntoNDsrZ+QI0GuJgsFhrF/sHvPT/OQBkGCqallpg/nAGoFeZRVTHzXpUK+RELtlPJ6OdCiM5QCB1Us6FarnBBp31EJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB6auUDIXaCbBmfQq+nHkxDYysNsnDAewY8YKzxjLow=;
 b=NyanZnMg9Z3iG4KLM9OmZJ4UjpbdKbDT7/qRqVXg0+K238bUt4NgBUdjtA+i7WeZDCsslKDaeNF2ArieQQU0Nlkrd49c02YY+7w3pbxFewjqkQ5ytKt4WfLAtk2oEHQkHLLpw4TVK67gayKo+GJ/jEhS2ZIJsCwHSP8hZfo+qCQyI53ZFmnQg0lNXr6gBM0Ov/BNrttaS0t2gLtpw9u4d6Y+5O7nGFnDlnRjDaO66U79dMYT9gaCT7bF2b+fd7INGJfJgT8xVZ9S/vxmYDM2N3zQIGbnCqq/6Ex0FRAPvaXdNK+JW4AczvyX296qHwlNJVVqLXCkXrcDFPOTh4gkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB6auUDIXaCbBmfQq+nHkxDYysNsnDAewY8YKzxjLow=;
 b=jvyBPctZfrwnWMD+mPaZ1+oH4Ii+oyGmze5cBOSnDngqtBzGssF6GRLbqW84TMdHmjJmpQjn06QMM6NMN9lWAI1lj9rlwfVVSSk95RNvee+ua/Uf47gg3JAPJp+TKypl+U4KQdlpMsUrUoUtKQQDDNmmJjW5aZqgEvTIF5UM0d8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY4PR10MB1640.namprd10.prod.outlook.com (2603:10b6:910:9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 19:11:38 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::856b:6a4a:7f60:df74]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::856b:6a4a:7f60:df74%6]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 19:11:38 +0000
Message-ID: <8dc762fc-dac8-b323-d0bc-4dbeada8c279@oracle.com>
Date:   Fri, 1 Apr 2022 12:11:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
 <20220401152109.GB18534@fieldses.org>
 <52CA1DBC-A0E2-4C1C-96DF-3E6114CDDFFD@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <52CA1DBC-A0E2-4C1C-96DF-3E6114CDDFFD@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c09d66b9-a9ba-4f20-6874-08da1413721c
X-MS-TrafficTypeDiagnostic: CY4PR10MB1640:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB164096DBE5341FCC3EABF7ED87E09@CY4PR10MB1640.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: My8mqiVxOKSe/b/d4b0mzA2eYtgJNITFvl3XXoCQbw18nXcc/5FmfVJVDpvNuWrmuLPhor9n34oe9ypr9y8/x0bOxPrTuHtbXD0v7I8putg3ou+wW2zOXaW8NGn3ZwCRw32ubyyUL2CHC49Re3qoMkr9/aheZhq/K09eQ3zxsVY+f8J9DTCZlHpBXkp/dnnxVLPIDvv0O60HBnWRGAXc8BCexhRZfqZlxyOZqMGDGQJxXo2NUd1VTw2z/bUcm2B2P1CuJ4oSFl8QZ31y1W1hST7aVJhsNf/xYCFCchV0OVfOhCyvAHPWdxGb8m3flM3OXlepcP7hQlI/Ob5TD4wqcDWtYCmW3st2zbRl6cV7jJ8xjRYbmkYni0PEeYG3tOHBaHHr64SY+gzqi7wov2jSSn6RmZsHJRXb7Kct6YfGeGfZfOl7naKwirxVdKs44PoWB+4XlcrTwP0vByvbw2mRRdGOSFZmu/s9ypaCY4wskLmpGXvkfd1txwnJcF27HAKbaVzSMuzARxX96pNnZgR/5vXhgxJQY1odL5XgtSXP11lsD72OT2OuGA6DRXyBQGKjWVVE1fMEc8Sh8+cJfLETnvvLkw0jX77DvAqElMPGp4Oxo805ffqOJQyy4bHGU5F9KkSNSZDMSgmDWDPrctJPQsHTq9urVrSc/Vgh6MwNXfW1TBlyr8uwb7vszD+cNGuU5eXkfTW3zQa1JdkDi5IHvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(5660300002)(38100700002)(6486002)(31696002)(86362001)(9686003)(53546011)(8936002)(4326008)(66476007)(66556008)(66946007)(6666004)(6512007)(6506007)(8676002)(54906003)(2906002)(186003)(15650500001)(110136005)(31686004)(83380400001)(316002)(26005)(36756003)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHFnc0s3YWFrTmM5ZDdSSTZVMmR3VkY4SEJXcUd0cm1yaHhFZllxTnVPTCtU?=
 =?utf-8?B?Y3pYR1FucCs3UUJaVTNXSDl6UE9nRTRmd1c3aXJ1TEpJN29Fcm5zemtkMmY5?=
 =?utf-8?B?OWJSZ3dmWG5rMnlyQ2x2RTMxcHNDOEpVQkJvT2ZaREJyWjUxTVlvcEZEYWFS?=
 =?utf-8?B?TklhN2ExWWxPQ1lUMHhhQnN0S28xdjRaVUlZdUtMWm1CT1BqYUpTcEx6bXpV?=
 =?utf-8?B?NWpJVVZEbnpTYm5HRGt2OVlxdk1zUG9CRGozV253eWQwaVp2bU9HdU42NDZS?=
 =?utf-8?B?WDlTb05yYU9NbFZUTFMyNDgzMCtSVkV5M2RXMEZmcFBDQWFIZWRYdWUxcmhU?=
 =?utf-8?B?NlFpU1FzaDJNa2ZySEMxMFpzSzd2OHpUOTg4RmRWcERmdTZvOHV4alpuT2ZB?=
 =?utf-8?B?aStTaHRiOVBmT3M0OHJmaXVwbXBVbGhqcVVPZkJoVllQM0pMWWJxemt3VWxP?=
 =?utf-8?B?aCtGbUJWSTJ3bXBpUllFN1BMeHIyQlBRaEl1SWFuT0MrNndCVkIyTnVCRFJj?=
 =?utf-8?B?a1dUbEY5MWNvSW04R29LZkRrNFdDeGQrcGRoSXY2U2FFckMwTmxmS0N0YmVv?=
 =?utf-8?B?TjhkeC9CZGtyMExERTVwVUtBaUU5ZzFCZE9SWjNKNU9FTDBpR2V2dlJKODFv?=
 =?utf-8?B?VDN6NUxSYVBWTjNGcndJSUhJRWxUdkhRR2plSU4vd25BSldmMGkzQlVCaldM?=
 =?utf-8?B?NzNJSEIyOWJxYUVocXlUYVlob3Z3MDBLTm01Nm1oLzNnODZKMTVUQWp3aTI0?=
 =?utf-8?B?SmN6Y1VLYmJMSnpXV0ZKbGt2aWl6REhBWUs5TW9XMnlnVy9EZ1cyMGI1eEhp?=
 =?utf-8?B?dC8vV3U3Rnh4UFVJWllKTndaVHcyaUFOMjdjZEw5aDFGbVZ5RXhVOXR6K3NM?=
 =?utf-8?B?NXBVemJqcEM2Qk53U0VWTnVDblA5R2pZcFR1eXF0RDlHaE1yZkZ0SVdtUldV?=
 =?utf-8?B?cXJpR09sendSMkVpTXNMNExadmVWRG9odlFOclVJVGZhT2Zrc0ZZY2NUejRl?=
 =?utf-8?B?bGdFRUFNblVpRmhQY1ZDa3NOSjVDQ1NYSnF5YmJSdGVWTUV6dThyZlZqbmZM?=
 =?utf-8?B?R2QybnRJWEtWUmFLdmwxQzZKMjl6ODNzTmM4RHljc1E3YTdhbkZWUUxBdEtB?=
 =?utf-8?B?cU1uNlAzRm5VL1dmSW44R21jejRBeXd1RjRtMktPUWNyV2xMV1hoSjAyZlNU?=
 =?utf-8?B?bTd3MHVobXdoZUoxai9EbzcyQVcycVJrOTVaYm0wS3VQS2Njc01YbkdDYkJX?=
 =?utf-8?B?SGk0TDBPMVcvcUdQNlJlTTNhYW85aFFMVUpleUs0S3I0VUxnNCtCc1BQNmVF?=
 =?utf-8?B?aWpTa2FlQ3BtMHFIU0NLL1dTUDhWR3IzUjBFMFJaZWNiQ1V2bGhxaS9reTky?=
 =?utf-8?B?U2lySXBvOHh6T1FKWE1PNUg3UStjOFpsMmZ0TGZRSVM4Y0E2WDBxV1JpdW9I?=
 =?utf-8?B?eldHQTArOVlXQ3d3N1czZThiZVB5eXMraUo1S09BSmd2VTdraml2YnVMbHJL?=
 =?utf-8?B?SDkwR3RjRGpyMk5vbytkbHM5NERqazJSdUUzeUFMMTA3d1N6c1JZQW92R2Nv?=
 =?utf-8?B?MDcrYWNMRy9FMHllUmRHRm16REVlS05xNmFBL1ZDcm5Xa2gvT0pDU3JkL2Ry?=
 =?utf-8?B?UTdGb0trMzVXak51S1VXMGZUaGhQME82bGdIWGg5VUIxS1VrOGI4L3VLZk4r?=
 =?utf-8?B?OFc2cGFSdlpJV091Sk1GbTBYWklTdXVETXUxN2tzSzE3UlVSOThoSlVEaThT?=
 =?utf-8?B?SnJiT0ZESjBFOXZHUEI2M1FBMjN6L1QwUVFrRlNNaDV0UnFEVmFFaXB6ZXNO?=
 =?utf-8?B?OG1iNDFia21ZVmxWUU9wQURqQmMzVElvYmtmRUwwVGl0WHdHYVlkTU4xNE4x?=
 =?utf-8?B?ZGNnREhPaS9YekpzeGI1NHNybEc0QmdUYm5DQklxZCtSRTZheGtkcDB6NUxV?=
 =?utf-8?B?djVtMVJidVB1YmYxRTRtTE0wYTJEakQvbGhoY3BJU0tpTFFERWZ3SHc4SVFN?=
 =?utf-8?B?TVBGaS9nM3BuYjJwK2FNdld4bGFXZytaNS9ZR3JBRUZoWXA3dDNMMzlYN2Nn?=
 =?utf-8?B?RjMzUDVHRDluYzFKQnVuK09xNjlVY1NCZmZHZWVMWlNPWFp5cjVocVlpbVVs?=
 =?utf-8?B?Q2p2WWFDK2pPakdVb0UxVEx4d1ZvbmlhdHFGUCtXMmQ3UWM2Nk02K1c5eU1X?=
 =?utf-8?B?MXB1RWYrcFBGYVk0Nm9Gd1hycHdCaFZuU1Qyc3lWeDhHdzdHaXJGN2V6TmNC?=
 =?utf-8?B?SE12ODFpU3dETWR2ZU05SzA1QmR0ZFh2L0tkN2s1YXhPTDNreW1zSWowalVQ?=
 =?utf-8?B?TU5iR28zS3haRE1mNlJNMWJCNXpva1pBWWp2Um5lZVdoVUxCZFZnUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09d66b9-a9ba-4f20-6874-08da1413721c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 19:11:37.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOtevArbzOobaZQbkrmc7SEXW8JpivhYNBjhzbiSBeFIsen+TGEk0LJP7Oy422DUunndOI13sJr9Z6Xgy+sdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1640
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010091
X-Proofpoint-ORIG-GUID: EPpTJMe2oHXfQQ-yu4Adup2FnIrCJXzT
X-Proofpoint-GUID: EPpTJMe2oHXfQQ-yu4Adup2FnIrCJXzT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/1/22 8:57 AM, Chuck Lever III wrote:
>
>> On Apr 1, 2022, at 11:21 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>
>> On Thu, Mar 31, 2022 at 09:02:04AM -0700, Dai Ngo wrote:
>>> Update find_clp_in_name_tree to check and expire courtesy client.
>>>
>>> Update find_confirmed_client_by_name to discard the courtesy
>>> client by setting CLIENT_EXPIRED.
>>>
>>> Update nfsd4_setclientid to expire client with CLIENT_EXPIRED
>>> state to prevent multiple confirmed clients with the same name
>>> on the conf_name_tree.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c | 27 ++++++++++++++++++++++++---
>>> fs/nfsd/state.h     | 22 ++++++++++++++++++++++
>>> 2 files changed, 46 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index fe8969ba94b3..eadce5d19473 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -2893,8 +2893,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>>> 			node = node->rb_left;
>>> 		else if (cmp < 0)
>>> 			node = node->rb_right;
>>> -		else
>>> +		else {
>>> +			if (nfsd4_courtesy_clnt_expired(clp))
>>> +				return NULL;
>>> 			return clp;
>>> +		}
>>> 	}
>>> 	return NULL;
>>> }
>>> @@ -2973,8 +2976,15 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
>>> static struct nfs4_client *
>>> find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
>>> {
>>> +	struct nfs4_client *clp;
>>> +
>>> 	lockdep_assert_held(&nn->client_lock);
>>> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
>>> +	clp = find_clp_in_name_tree(name, &nn->conf_name_tree);
>>> +	if (clp && clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
>>> +		nfsd4_discard_courtesy_clnt(clp);
>>> +		clp = NULL;
>>> +	}
>>> +	return clp;
>>> }
>>>
>> ....
>>> +static inline void
>>> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
>>> +{
>>> +	spin_lock(&clp->cl_cs_lock);
>>> +	clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
>>> +	spin_unlock(&clp->cl_cs_lock);
>>> +}
>> This is a red flag to me.... What guarantees that the condition we just
>> checked (cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) is still true
>> here?  Why couldn't another thread have raced in and called
>> reactivate_courtesy_client?
>>
>> Should we be holding cl_cs_lock across both the cl_cs_client_state and
>> the assignment?
> Holding cl_cs_lock while checking cl_cs_client_state and then
> updating it sounds OK to me.

Thanks Bruce and Chuck!

I replaced nfsd4_discard_courtesy_clnt with nfsd4_discard_reconnect_clnt
which checks and sets the cl_cs_client_state under the cl_cs_lock:

static inline bool
nfsd4_discard_reconnect_clnt(struct nfs4_client *clp)
{
         bool ret = false;

         spin_lock(&clp->cl_cs_lock);
         if (clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
                 clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
                 ret = true;
         }
         spin_unlock(&clp->cl_cs_lock);
         return ret;
}

>
>
>> Or should reactivate_courtesy_client be taking the
>> client_lock?
>>
>> I'm still not clear on the need for the CLIENT_RECONNECTED state.
>>
>> I think analysis would be a bit simpler if the only states were ACTIVE,
>> COURTESY, and EXPIRED, the only transitions possible were
>>
>> 	ACTIVE->COURTESY->{EXPIRED or ACTIVE}
>>
>> and the same lock ensured that those were the only possible transitions.
> Yes, that would be easier, but I don't think it's realistic. There
> are lock ordering issues between nn->client_lock and the locks on
> the individual files and state that make it onerous.
>
>
>> (And to be honest I'd still prefer the original approach where we expire
>> clients from the posix locking code and then retry.  It handles an
>> additional case (the one where reboot happens after a long network
>> partition), and I don't think it requires adding these new client
>> states....)
> The locking of the earlier approach was unworkable.
>
> But, I'm happy to consider that again if you can come up with a way
> of handling it properly and simply.

I will wait for feedback from Bruce before sending v20 with the
above change.

-Dai

>
>
> --
> Chuck Lever
>
>
>
