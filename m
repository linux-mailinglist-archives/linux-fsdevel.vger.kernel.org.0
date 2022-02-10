Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782764B169E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 20:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiBJT4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 14:56:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241544AbiBJT4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:56:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6745F5B;
        Thu, 10 Feb 2022 11:56:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AITRqO027666;
        Thu, 10 Feb 2022 19:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=x6XWlRmGvKl76gT638miPnAu9JP9fxkoS6MFmr6SvR8=;
 b=M2juQjjhjrgZo7T+I/SqPvisMIAN7e0tzTHsFQjxxeDqFvwxDCAoqrf/84GKQu6Mo4dR
 wH3L9EZ5KGiR77Jamn1M7a5t/f2T4iyyY2S6jeEYdXr+JaU4KWnU9AYtMuQVqxdFuzFA
 6etJfadox5fkXYjc2Ggjx3K8maGq3ndpbasBp75ycgHRvnBpMs1geanxH1oApbx6zTc9
 lpfn5p0rFuNYIsIQZA0tbW0h/cfZoCiQQJsXxF3cvh6ZFWsCSexGBgaBrxTPMELttoLT
 ayitvyIbBAwuNx4sqc6H9TLbx7FUepMnGmZMxOywrl7GekK8pD3jkh4AySMmjivDkg0u pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdt16h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:56:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AJeE97037258;
        Thu, 10 Feb 2022 19:56:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3e51rtx5kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdJ/X3fnab9eY7J1DGrMFWxuN5RIPEZ54PcE9Um4W5cMkZJGrfiNMKpBJpx91RG5f7aI4UK2/vSoG4/k4dTk+Sv2661iVVwamBoDaoEKBhKmpZ65jJPKyxTWfqeTwgVE9EKyb6KLEieTFOcCVCU2nuyVuN7bqPlY4IkkjyPi8ehCTEONiNp9Cryr8bOGj6nsAsu02o2Hjs36UeuPemvo7QCCrSG5qjWBsugZ/mAbGmNhdDvudZgpvSWZv1ZlVTWwl++TQfeA0axC0KbtIZyoQ+v0OgvirP2dtmYFlpnR0Uy7MBXa3B6VVFZaZilAQMgBolyIoQ2J0rGELxIG1+GfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6XWlRmGvKl76gT638miPnAu9JP9fxkoS6MFmr6SvR8=;
 b=fSC7o+hSuqBlXbn4lRMH0FJJBG30oYBlhGNWvhuhaMGkhz9B3VJqTXP29UU4pNE5TrzHdaJNBihjjE3DiIGPtB3cEn3Moupggd2JaVblReOZpg0VcZtVEpgJ+Lt49WL/80LAbPkaAdbMIwTfA2Tj0E2ozISEqGQe9sbYRSdrniUDAz1mOTLVXiAHkhbYcEbGyYxwDw8VQGABNoGlgPnk5Vsc+ZCP/iJlK2rxMbzNrM7tPf4SRnJKZh7bZfuxrddAaRdvqsnSrWd1o2sQUbvEB9Qg6BNZUOz5dya7K6MET8NneTOQKtUKVJwQ3THiaJQNvDqBk8AVXTwoeJEIgDtlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6XWlRmGvKl76gT638miPnAu9JP9fxkoS6MFmr6SvR8=;
 b=czWwZHyuMlpsFPDR1OZxlnkLTLkZvf/2Iyecpdz19ggrr4AbOD0VG036FDvoavDAiJq+DY8g7kpmZBQwSs69uV9m/q31oobTydwmIJ08GuHw65PnxQFOV93E1RNdaqzjFUoXzMEy9RnKvMItpLKeb84PkGTv9ny7XibVNYPaaT0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN6PR10MB1875.namprd10.prod.outlook.com (2603:10b6:404:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 19:56:26 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%4]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 19:56:26 +0000
Message-ID: <2d394dbd-484b-ad9b-b432-51b342ac6fb5@oracle.com>
Date:   Thu, 10 Feb 2022 11:56:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH RFC v12 1/3] fs/lock: add new callback, lm_lock_conflict,
 to lock_manager_operations
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-2-git-send-email-dai.ngo@oracle.com>
 <20220210142143.GC21434@fieldses.org>
 <c069bb1b0ec50358fc4d093ebd7482c7484d77b4.camel@redhat.com>
 <47535edd-9761-f729-1d6b-f474a31eeafc@oracle.com>
 <E7CBF516-9DE5-4AC6-AFB1-148188C74699@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <E7CBF516-9DE5-4AC6-AFB1-148188C74699@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 771641fa-25f2-42a3-b959-08d9eccf6be9
X-MS-TrafficTypeDiagnostic: BN6PR10MB1875:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1875A18BB1DB007CC59F3216872F9@BN6PR10MB1875.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNHL9sr8ilfAir98T6MOUz/QagfPUKa1foX5lnFX0lMxZbNTrym7KOJoDa3GjrsbJJ+9sg41SQfDkisP55K4v0sweSzoSxNHO1hpVSWYEauXJjtiScHJwDDx0e/UyqZbioSmAcPbtGLKAyuh07SQdXp/UiD/gYeo6yt9wioEtVq8LESvp3c8ZGhBrq+SH+zkQ+aAl3/1Qi4cLNzh0SKOsAqxy+Xq6KhQjQ50JdKWJ9reF8cEyfMs/U1RH/CzDA+1Ng+KMqDdLK9gpNfj1PW1DYkSeVzt5ZLV6CBuVpewzygkfqjtM88ny4dP0RqzIAyeFXMkIsg4usGrwSbaQPUqtHrbqqQa21CkKboKwe3TP3Xq6rlUdisA7C7wHNbWx3HwWn+AUid2ooa3bH6/geIoOFJvi98gRnkegvrB4HX0B+5UZY7iBRXUo21iaejiKwpWgDHuIGfkhuPTneTcgK/pG6UzbOgOYQl37s5k8zioWsqmIkUCDx8o5yJFTt+Wf9pbVCKE/FK72/a5YItu+9BVMVrenEXLvy520pYq1JDfo/Djp8lY0sOR9QGScUzfU01CSbTEgiFNtWU2xpSn0AxewKFOy0EEOCXdX9wYOyFTw3X6hGphn6jxthHHrv4onNgjMmoaA5P2Te5TCpVmoyLBZ0JxY0aaeq2lnylqbuaI92mb0tC9fhZwHxw16mLOq+rWfQG2SoMHbfxrFBMGci8TWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(31686004)(66476007)(66946007)(83380400001)(54906003)(37006003)(508600001)(2906002)(66556008)(6862004)(4326008)(5660300002)(8676002)(36756003)(316002)(8936002)(6506007)(2616005)(186003)(26005)(9686003)(6512007)(31696002)(86362001)(53546011)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elFzZkM5SU9nUUplbzFNYldTYVBuNTJwWitiR1BkR2lWNTNNK21lVmpKM1hw?=
 =?utf-8?B?ZVhPRWhRbU9EcjZvWjliKzI0ejRqbGwvMVUxNnhsTTFOTWlPRU9NZ1FGbVdQ?=
 =?utf-8?B?Um1lY3RFY1BKN0pQSk1aaDNYam05TmRITmJNVkUwQ1R2akVIM0NjQWxSNlph?=
 =?utf-8?B?RkRVc0RodlVncy9CRWx1a3I4T2FmSnozWFpCaEkzL0huREppS0dHcFZ0VW1l?=
 =?utf-8?B?SjNaVkJxY2FOa09OUWpsTzF0RmpxZ3ZZMC8rdjJDMm1jUitnQ29nUnNoS3V3?=
 =?utf-8?B?VVVGM0ZkMkV1MUZUWXdQMDVVZ2hYYkh0VlQ0OVJjVXMvc1RLMVJURmVGOGpq?=
 =?utf-8?B?OGRlbXNCUlJQV2ZBUElQMkRXd214RE5vNXZuY2ZMU2pPRTJ3OWhzSWxGbFlN?=
 =?utf-8?B?dDZNNjJaNE5LUVRkSVFzVzlPVnowNnZ6Nys5SWlLdlhVdGhVZFJaSGhJMjQ2?=
 =?utf-8?B?OGhGclZqb0k5MkRuSWx1UU1rU1BDWlR4OUZzN1FySHNsMGUrZ3FDSGh2elYr?=
 =?utf-8?B?UzM0Q2E5Z28wWCthVXR1WThPbzBPTEYzaEk0NWYyQyt2VGVjTlhPYk9maW1i?=
 =?utf-8?B?SmYzQmF3QVYyL2F6dWxGWGl5RlN4bUd4Ni9xb2YvNDY0VFBzY3cweWJJUm1F?=
 =?utf-8?B?QnpDb0dFcWR4bXlaWDgwNGo3OTNlaHFwZUVqQ0tyajBqZ1d6d0RnVmM3Uzg4?=
 =?utf-8?B?MlVQTmVxS0JyUXFTT0RKSVQ0RGJaWnBFMGZ0N1djNWNtUlErNi9qY0V1a3dV?=
 =?utf-8?B?YzdtYzllT08wUUpVUlJaM0t5em01Z2VHaC92eWJVSjNCamM1R0ZTeGN1ZXR0?=
 =?utf-8?B?WDU1eXhIUit0Ymk2WFhGMnJiUjdxZEQ0WDExd2dHVHF5RGsvRk1SRlJJL3BD?=
 =?utf-8?B?cXkzYk5jVkl4NjEvRHJDMHpBY1Bob0x4OVZ2R25hWFBqVFNibFdobXFLR0cw?=
 =?utf-8?B?V01xaldWUTVIRlpVM015ckc0OUhoSjZvYmZyU1RvMG03NlBxQ2daV29RdldM?=
 =?utf-8?B?V0JoRXVRVjZmeG1Hd3ArdG5ZSzRSK3dpSDdMUUZSc3lQM09RL1Q3NDZhaU9h?=
 =?utf-8?B?Nmp3NEozYU45emJNTjFRNkM5YWs0ZG4yK2l3bTNjaTZGeXFUSW1LUTR2N3JV?=
 =?utf-8?B?VEVBK05FYklmd2ZISzU0eWpXSXFvMzZsM1VxUmcwVThweTFrRkRiWEprRkw2?=
 =?utf-8?B?NHlsQ3JiTlZLU1ovWnpLQzBtSkplTWJSaFg5bE5PTGhDeVZvL29JaXdyeFhY?=
 =?utf-8?B?RTgwancwN2xmWFQraUNmbGx0M0Vpb3VOK3ZRdXpJOS8wRE1qNjE3Nnl3UUdD?=
 =?utf-8?B?aGQwRVBJbUcwcmpacUpkT2szTXJvNFVUNklncSttYzkwelYwQzBsT0xUVDVi?=
 =?utf-8?B?YjB4UXRkZWZsV0V3SE1nbG9uRVZ4QWx0cHhIbE0ya2oxbm9GcGViZ2pXZDNn?=
 =?utf-8?B?YjBqRFhldHF5L1ZmN0xqeFF0WUJ0Tjd5ZXlNS0g3U2JlSVEyM0xzWTQxOVdt?=
 =?utf-8?B?dmwrbmw1WW5mYlVNMnZEU3huNmwvT2dwWWVaaG1sZURXcit2STd5eFRaVjRw?=
 =?utf-8?B?Q012aXNGc1doa2paMW4ySms1cDkxcDFBdW9xM2pBUUVNTnM2VlhCVER3Rm1Y?=
 =?utf-8?B?VVdmemhweFdPeTlMQjhvWjh2aUhKcmIvWkcyZmR1QURCUk1BbWUzY2VUV09P?=
 =?utf-8?B?UGsranVNQVdhVXVRSEJPaStjRVhRM05NTm54MTZwelRhTDBIMTJqZjMwODNQ?=
 =?utf-8?B?MjZtODBROUZmM3QyY2U1MkVYbldhaFZGZWxvbjNXdTVtdHNCQ1c3eGEyMGJW?=
 =?utf-8?B?UnBHSFprelZGdDNtWmh5VVVMd0FxamNSa1o1RTdPcUNLSFJIOEVPNXFwL09j?=
 =?utf-8?B?YU56aXZyZEtneDNDSER3TkJiTFBKc2Zkby95NUx1K1BTMVJwbGVBaE5kZk5U?=
 =?utf-8?B?ZmNhRW5FbVRkRGxBdEgxNGhLemtIVnlCN1Y3UFFlWmpDaGRjMjVUOGtXN2Fw?=
 =?utf-8?B?OGRJM0RxWEs1YmdLMEFCdm1UUW9mZEJieTd4cW9mWW9nSldPdkNLUTQvZ1FK?=
 =?utf-8?B?SlFVRzRMZHVPL2Qrdnk5Q1phVjVHNk1GUE9BYW5yL3VseldXUmg5TXgzZjBz?=
 =?utf-8?B?aCtEUy94L1RQMnlubHZyTUFha1VhZ1IybCtlSDNJSzlmanhsUmREQlRJUy9I?=
 =?utf-8?Q?L/JODXib39sIfgHsM7GDqJ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771641fa-25f2-42a3-b959-08d9eccf6be9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 19:56:26.4062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa6XzECFugBKNlVDnAFregNOtnj1NbWv3bvSl1+ctHA+1SRZ6D7lwjc74+eCnr5tVN1h4Hgg8bcmyz/Ib6/+Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1875
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100104
X-Proofpoint-GUID: CqoopeOpS-sSoH_kk5sp75RbtZkl5gmq
X-Proofpoint-ORIG-GUID: CqoopeOpS-sSoH_kk5sp75RbtZkl5gmq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/10/22 11:44 AM, Chuck Lever III wrote:
>
>> On Feb 10, 2022, at 2:41 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 2/10/22 6:29 AM, Jeff Layton wrote:
>>> On Thu, 2022-02-10 at 09:21 -0500, J. Bruce Fields wrote:
>>>> Jeff, this table of locking rules seems out of date since 6109c85037e5
>>>> "locks: add a dedicated spinlock to protect i_flctx lists".  Are any of
>>>> those callbacks still called with the i_lock?  Should that column be
>>>> labeled "flc_lock" instead?  Or is that even still useful information?
>>>>
>>>> --b.
>>> Yeah, that should probably be the flc_lock. I don't think we protect
>>> anything in the file locking code with the i_lock anymore.
>> Will replace inode->i_lock with flc_lock in v13.
> To be clear, if you're fixing the documentation, that would need
> to be a clean-up patch before your 1/3. Thanks!

Got it Chuck,

Thanks,
-Dai

>
>
>> -Dai
>>
>>>> On Wed, Feb 09, 2022 at 08:52:07PM -0800, Dai Ngo wrote:
>>>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>>>> index d36fe79167b3..57ce0fbc8ab1 100644
>>>>> --- a/Documentation/filesystems/locking.rst
>>>>> +++ b/Documentation/filesystems/locking.rst
>>>>> @@ -439,6 +439,7 @@ prototypes::
>>>>>   	void (*lm_break)(struct file_lock *); /* break_lease callback */
>>>>>   	int (*lm_change)(struct file_lock **, int);
>>>>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>>> +	bool (*lm_lock_conflict)(struct file_lock *);
>>>>>     locking rules:
>>>>>   @@ -450,6 +451,7 @@ lm_grant:		no		no			no
>>>>>   lm_break:		yes		no			no
>>>>>   lm_change		yes		no			no
>>>>>   lm_breaker_owns_lease:	no		no			no
>>>>> +lm_lock_conflict:       no		no			no
>>>>>   ======================	=============	=================	=========
> --
> Chuck Lever
>
>
>
