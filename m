Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF1051518D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379554AbiD2RYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378061AbiD2RYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:24:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6E4BBA1;
        Fri, 29 Apr 2022 10:20:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TEIpMf032176;
        Fri, 29 Apr 2022 17:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yPHTxH6cOb1fnFmwxwxAghdNrZbbSyct4iPOECNS6jc=;
 b=DKPy7e+YLIoltmZdPfgtsAx9ymhj4+ZSmVyYOyWeq5amAThXs9fzMn8N75nq0G18RtgM
 skQZKtx45xVvjJ0WMkqlu0S+fIRJtlvzg754XjbHhWpT7kHIW5nAn6LiDX8sCqcKU8Qc
 8278vE+3PEhUm96uxkdyq5YsMMUIo5oTSayN/7Z0JerSNHB+ZBHRlMmliUrI4OyAzhSx
 YSV9wjp2TuyNR/XfjP156ZUpflcDTSZ9b/dn8eTtbsgA8a5B7JusHpndks2ith+2m/Jt
 lk0dXkoUJgR7cROwJgqlBZqDk6MPQh1gbmBT7JmcZOqpF70s63o/D4FSD8TGZUM4hFyB cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb106pfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:20:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23THFFDq030305;
        Fri, 29 Apr 2022 17:20:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w8a68c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:20:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAjGyEFMYCAI9qgfr82myMjwsJDwq/1QYZvVPZAKq9/XHrzUare60Pfbx0QXtlT/DHoEE5yH3PrHfv+E4K6YtSt+GBFfW7XxorYgvzfiMI5GD2j5JPY7B4l9i54aFLvsYGMkTVgyCVi3touZtoQCdrw4+o/ijhgsU/+J/W50qn/VbMdlRZJJZupCCcT17cd0d1ln1p/37Y4hbhxPIMJuSVQPWl+LibWMZKkrjozopKEPLEgtKVkujlNWQoXcwSEwy5/L+/jFouNu8cG4M5cUOJCaLhLtbDBQDXLbHXc3r5sGyWJczeUJlF4tZthcbk7pwADResMjBCAj/unpzH7bNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPHTxH6cOb1fnFmwxwxAghdNrZbbSyct4iPOECNS6jc=;
 b=gWxf7gd/0galr4TIjq+fY2nT2FdJIKL2eNtXg3vIoIKd3j5o7JkJfYe9jsxNJZgG74sk4seTDVMOMisKmq1VNVc3voFWSHoNFQI91MmMyoQ3/jD2CYUxTEGrTo4vai2su/S/gK9v07WHsfGe8NwVc4OcJUVekyKRQ6kXTfDwdnEI3ZH2ZtSr6CrUnewZoYJBQhg/YkWwEhXpD6sMJ389TmGozN40b1pH8t2IzdaxU2H04agO3G7xunnPZN+DnqrLBEEPHFvckcmLDeBzYJkxFKr5lCJXWguc1RLyAAqZlqHX6dNlWl3CLYl2ma4tVKOE3N0uQ/IyBbvIzxCnDw8Tdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPHTxH6cOb1fnFmwxwxAghdNrZbbSyct4iPOECNS6jc=;
 b=iYiKNe5pbp6O715w2qJ/cV24rMItV6XV9CL8WbCDRbDq/El3B7cW3oEIYF1em0h99+a7xH9D8KPpZvctrHbx2VlzUX5P+JTDj+NIq/CUv/XjqAlu79lGraRoXqWbzsQ89ga4bGEvzImdqSbnH7Uonx+H55WDIta1AlNj1B9FdF0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4019.namprd10.prod.outlook.com (2603:10b6:a03:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:20:42 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 17:20:42 +0000
Message-ID: <902ec81f-139f-2b15-42ad-c721dcbe8a75@oracle.com>
Date:   Fri, 29 Apr 2022 10:20:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v23 2/7] NFSD: add support for share reservation
 conflict to courteous server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
 <1651129595-6904-3-git-send-email-dai.ngo@oracle.com>
 <20220429143619.GB7107@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220429143619.GB7107@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44ea59ef-d386-4f0f-bad8-08da2a04965f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4019:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4019E5CE0CF18E161EC8B66387FC9@BY5PR10MB4019.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGJApQU5Gm34JLfsE0AkBkDSc2KabTnJXdt/s7DHEfVkNK0B03PKZDkxKPlPYH04ZG8rL7gUGfvE2CP9CPNNPpc1cEnfhgIjY+B66Fvx5a6JZEc6T1crETiw8sqGTMHgR3pctew99yFoIiDvzMYduHnpgiwPYARy7tmVgZos+FdY/avdCmZat+9HCD97IR9alm8buDYhScgsNwAb1u9k6NekI8VmjKt0vO7ALl0kZTnmNxcy+bgl93DURofQXfEOVk0TQR24QK40GjbAuykGTOxr9aL4Wm1W0uwLWjFXzHeEwZrKWqy0j0L8+2O6LotrvF7r5L4aTleE1jLPoGfsaleD8410sKmAPgT7fgQ9tN8yKmMzadYeRVEjzBhyqx2qdG+KRvbca58uJ4vgKF9ix0C7i+p06VSugixsub4Sxtv9pSohw28raMK8r9azT1KRa6+z6/0K11fvaqYPyFbMnN14s7qWdZv2+/mfZVM5kfVKRvyy5SRv2U/wf/OsV5MUSNxoYfzQaRGBq75YN0SmDTD/2HzxHMKaW6ZxDeis+grm8Ymjrq65/U9HhS7nYWkczHf9fG2Yi8HVm8dY+hea3jw/U4fMGJWjEZhrNRumm0I3MoS0vQryrwkeiBhQCxEnt2we8VL9qHMJq4TiQBVSPriWyUKGpc1czKqlrD+u5WQQxdp2bcXfaJWsqvAxd7vbn1b1RG2qbkqYBfXLPxjH3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(31696002)(66476007)(66556008)(8676002)(4326008)(66946007)(86362001)(316002)(31686004)(26005)(9686003)(6916009)(2906002)(53546011)(6512007)(38100700002)(6506007)(6666004)(5660300002)(2616005)(186003)(83380400001)(36756003)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGZtN2h4L2s1ZVZ3Yk54SlA4V2JHS0drM3NIWU5pS3RkdEY5RmFhaU9BbVhW?=
 =?utf-8?B?MERObHVEd3JHZFBjT1NncGY0QkU1ZDJSVlcxUHNQazFnQ2d0ME9PMGNZbWxS?=
 =?utf-8?B?SnR1dTBQK2xsNlQyUE0xMXFRV0pJVk9yZThYeXlVcEVGTGRDTXR2Nk5tSHdo?=
 =?utf-8?B?b29yY1NDeE1wTEZrRSs5SEpQYzltYnNmd00rNlBYKzZ0N1VQU1luU3pkOXhI?=
 =?utf-8?B?SHRtQmdzQTBHYnZIOXFObnl1OE9vSFp6TVZuTHNISFRVVS9Fam5WeUZNYXhX?=
 =?utf-8?B?MEZrTFlKZkpLNGl3eUdWYWRDSW93M2pUbmpHNGZxRlg4UWRyQlIvaVJVQ2Q4?=
 =?utf-8?B?WDBWczN3TXQrS3U2REVzTXpwRXA2VXZoWlhTVTB4anloN1Q2S0FhVTQrY0l1?=
 =?utf-8?B?K0xhVDRXbU9aenZRcFllZUxzT0hPek5oc1NYeEpZdjFPNytpcUk5ZG5RNzhQ?=
 =?utf-8?B?eXNFNitHbGU1V3paUzY5RUZTbTFTZGhjQUszWDZLTkR6dTQ5ZjVBc21qSUJz?=
 =?utf-8?B?RVJ3WENWRWtHNXk4dTRqR3dSNmF3bXBWT1BadXBKR2tGaVNjaytDb1UrVHg0?=
 =?utf-8?B?RVVlVE8xMHRESVhYLzdaNjF4YUFNT09SSTgxWkNjWDVVRGdGOGxjanN2Si94?=
 =?utf-8?B?R1FUYmlYNG9EYjEzMDNoUUs4ZVd2NDVrRWZ0ZlVhbDhCc3hlTjlmVGhydVlN?=
 =?utf-8?B?aS9BdUpVVUFaU1gwb092R1Qwd1lCUzkrRDFKcUduTWdUT3RlNDg5MkNMcmJJ?=
 =?utf-8?B?U2FaRU52Nlc2YnJWalM5cUF5VUZHeVE4cytETlJHREIvNkVzeDA2aVByQXZB?=
 =?utf-8?B?UzJrWmJKVmwvWncxWFo1M0hFTVdOVjM4L05iR3BHaVdaVlV2TFBvR1dMY0Nr?=
 =?utf-8?B?OFAvd0UxR1NPZDVFcEdSVm41aGxmbEVmb3FtSm56TGY2NHdiS1F5QmZVMjZJ?=
 =?utf-8?B?WTg0L3hQb24ydnl0VjF3S1pUR01iVEs0aWtGdFpyQXpNNnR3NEd1RU1WN0oy?=
 =?utf-8?B?OVJFYjQydHI2NzFTMURSSWYvbVZsR3lQMGwva1Rzek9NcVhjVWw2bm1ZaVNU?=
 =?utf-8?B?RE96bStLZ09RN2VvZGcrRXpSdEpwTC84Y0pBWUhSUXh4TzlYRUZZQzlHV2hn?=
 =?utf-8?B?S2hrRE80cnRaTXB6dnZMd2djMnkrUU4wUzVVSGovcmJtZmNsU2J0SkF3REln?=
 =?utf-8?B?dUp0SUNlVmRzSkt0V0RYK1cvRW5nUGpJd1NYcTBKYit1K25DcDdTcGlzcUVL?=
 =?utf-8?B?Ynp2b0IrYzR4S0hKaWgrOWtFei85WmdJQ3dzLyswbzZHY2VuUm9SdnVjKzEr?=
 =?utf-8?B?N0lHSTN0RTBDbmJQTEdLUEg2TVg1VWhzL2FFUEdONy9CcnR4bDdMSGR3aVNV?=
 =?utf-8?B?eW5ONGgrUVgzOHIwMUkwRVBWVVVodnU4TktubklKREw3UGtqK2tUUHk0dW9z?=
 =?utf-8?B?OE41U2lIVFRZYVdhYmNLWWk0UVZJT2JCVDF0YUF5L2hmbmxsbjdHSWRsL0sr?=
 =?utf-8?B?L3IvOVM2RGVVYjJkenV0SEVpSEgzY3E1Tm45b1lING96WXRzMDlzWTNKUHEv?=
 =?utf-8?B?OFFYTDRxQk1rUm5Zc1VtWWRyV3ZBdWw3MlVmRDVCb01RTUlyUzR6N3ZsZ0VF?=
 =?utf-8?B?cnFaMWR5YmcxKzZXU3VSc2RFU3FMbGc5eHl4YzU3cnpvc3VMc04vKzZ1RnZE?=
 =?utf-8?B?azZoVU42RGNET2tQSGVJQ281WkQ0bGpUOGZiZTE2WFdmSFpRT0NHd2VuUkZG?=
 =?utf-8?B?QlloWjlaS1BLdy9hQklTY3hNMDVZNkRMTXViTkk4WEhwYXppcUhnZnROWTJK?=
 =?utf-8?B?NitkdTN1ektkM3hOSDdoUDNaN216QUJPQm1CRUkyRTErdFFFeTAwVk9pYnVx?=
 =?utf-8?B?YzNqR3JBaVBqZWord2RWZUxZTk16UjJOL2RMayttYnIvNERsdzFDVVV5aDdT?=
 =?utf-8?B?Z1hEb2Y2cS9KQ2kzWG1HUWVsMGZxbW9MenJWTGp6WXl2REgrMnN6bG8wVWY5?=
 =?utf-8?B?ZWw3VklGVGYvcHhGeWVFYWc3SCthRXdKUUltMkdMYm1hWTh2OTljOGM2WEtq?=
 =?utf-8?B?Y2tEQzRIUnk0QkdydkptaTZpdWtzRCtTTVBkNjRSZUFyVWhRTTVSd3c2WDkz?=
 =?utf-8?B?U3p0Y3RsV1FPOEp5UjQ0bWR5QmRuVERaeGRLbFZaT200Vm55TEpGdGRoV25z?=
 =?utf-8?B?Z3ZEV2hHRS9IUXNBRUdDMnZJMkZYNk5PVW5aeFUwVW1tcHg5SE1Bb3FjUEhl?=
 =?utf-8?B?b2c5cENHME1kVlNEd2RSQ2lWdkIwVm9FUjdxMTJPTkxxZTZ5THBKUzJ5WjhJ?=
 =?utf-8?B?UjRYOFRETC95UTFNaUlqOHhsM0FEMlpKczdyS1U4MkJzNUNuamU0QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ea59ef-d386-4f0f-bad8-08da2a04965f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:20:41.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANFoZPfUdxG09OSLHFYoIrDunrCUcgWlYBXRBwoUQHGZnlkxEkhaCkoKFmyNnzASzml6rHnlDhJ3NF/SLcrBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4019
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_06:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290087
X-Proofpoint-ORIG-GUID: nFsh-nebDDHbETgI0bK3ccH_0P4RP9it
X-Proofpoint-GUID: nFsh-nebDDHbETgI0bK3ccH_0P4RP9it
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/29/22 7:36 AM, J. Bruce Fields wrote:
> On Thu, Apr 28, 2022 at 12:06:30AM -0700, Dai Ngo wrote:
>> This patch allows expired client with open state to be in COURTESY
>> state. Share/access conflict with COURTESY client is resolved by
>> setting COURTESY client to EXPIRABLE state, schedule laundromat
>> to run and returning nfserr_jukebox to the request client.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 104 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b84ba19c856b..d2cb820de0ab 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -694,6 +694,57 @@ static unsigned int file_hashval(struct svc_fh *fh)
>>   
>>   static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
>>   
>> +/*
>> + * Check if courtesy clients have conflicting access and resolve it if possible
>> + *
>> + * access:  is op_share_access if share_access is true.
>> + *	    Check if access mode, op_share_access, would conflict with
>> + *	    the current deny mode of the file 'fp'.
>> + * access:  is op_share_deny if share_access is false.
>> + *	    Check if the deny mode, op_share_deny, would conflict with
>> + *	    current access of the file 'fp'.
>> + * stp:     skip checking this entry.
>> + * new_stp: normal open, not open upgrade.
>> + *
>> + * Function returns:
>> + *	false - access/deny mode conflict with normal client.
>> + *	true  - no conflict or conflict with courtesy client(s) is resolved.
>> + */
>> +static bool
>> +nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	bool conflict = true;
>> +	unsigned char bmap;
>> +	struct nfsd_net *nn;
>> +	struct nfs4_client *clp;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		/* ignore lock stateid */
>> +		if (st->st_openstp)
>> +			continue;
>> +		if (st == stp && new_stp)
>> +			continue;
>> +		/* check file access against deny mode or vice versa */
>> +		bmap = share_access ? st->st_deny_bmap : st->st_access_bmap;
>> +		if (!(access & bmap_to_share_mode(bmap)))
>> +			continue;
>> +		clp = st->st_stid.sc_client;
>> +		if (try_to_expire_client(clp))
>> +			continue;
>> +		conflict = false;
>> +		break;
>> +	}
>> +	if (conflict) {
>> +		clp = stp->st_stid.sc_client;
>> +		nn = net_generic(clp->net, nfsd_net_id);
>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +	}
>> +	return conflict;
> "conflict" is a confusing name for that variable.  Maybe "resolvable"?

fix in v24.

-Dai

>
> --b.
>
>> +}
>> +
>>   static void
>>   __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
>>   {
>> @@ -4959,7 +5010,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>>   
>>   static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>>   {
>>   	struct nfsd_file *nf = NULL;
>>   	__be32 status;
>> @@ -4975,6 +5026,13 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   	 */
>>   	status = nfs4_file_check_deny(fp, open->op_share_deny);
>>   	if (status != nfs_ok) {
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
>> +				stp, open->op_share_deny, false))
>> +			status = nfserr_jukebox;
>>   		spin_unlock(&fp->fi_lock);
>>   		goto out;
>>   	}
>> @@ -4982,6 +5040,13 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   	/* set access to the file */
>>   	status = nfs4_file_get_access(fp, open->op_share_access);
>>   	if (status != nfs_ok) {
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
>> +				stp, open->op_share_access, true))
>> +			status = nfserr_jukebox;
>>   		spin_unlock(&fp->fi_lock);
>>   		goto out;
>>   	}
>> @@ -5028,21 +5093,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   }
>>   
>>   static __be32
>> -nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp, struct nfsd4_open *open)
>> +nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> +		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> +		struct nfsd4_open *open)
>>   {
>>   	__be32 status;
>>   	unsigned char old_deny_bmap = stp->st_deny_bmap;
>>   
>>   	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>   
>>   	/* test and set deny mode */
>>   	spin_lock(&fp->fi_lock);
>>   	status = nfs4_file_check_deny(fp, open->op_share_deny);
>>   	if (status == nfs_ok) {
>> -		set_deny(open->op_share_deny, stp);
>> -		fp->fi_share_deny |=
>> +		if (status != nfserr_share_denied) {
>> +			set_deny(open->op_share_deny, stp);
>> +			fp->fi_share_deny |=
>>   				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
>> +		} else {
>> +			if (nfs4_resolve_deny_conflicts_locked(fp, false,
>> +					stp, open->op_share_deny, false))
>> +				status = nfserr_jukebox;
>> +		}
>>   	}
>>   	spin_unlock(&fp->fi_lock);
>>   
>> @@ -5383,7 +5456,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   			goto out;
>>   		}
>>   	} else {
>> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>>   		if (status) {
>>   			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>>   			release_open_stateid(stp);
>> @@ -5617,12 +5690,35 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>>   }
>>   #endif
>>   
>> +static bool
>> +nfs4_has_any_locks(struct nfs4_client *clp)
>> +{
>> +	int i;
>> +	struct nfs4_stateowner *so;
>> +
>> +	spin_lock(&clp->cl_lock);
>> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>> +		list_for_each_entry(so, &clp->cl_ownerstr_hashtbl[i],
>> +				so_strhash) {
>> +			if (so->so_is_open_owner)
>> +				continue;
>> +			spin_unlock(&clp->cl_lock);
>> +			return true;
>> +		}
>> +	}
>> +	spin_unlock(&clp->cl_lock);
>> +	return false;
>> +}
>> +
>>   /*
>>    * place holder for now, no check for lock blockers yet
>>    */
>>   static bool
>>   nfs4_anylock_blockers(struct nfs4_client *clp)
>>   {
>> +	/* not allow locks yet */
>> +	if (nfs4_has_any_locks(clp))
>> +		return true;
>>   	/*
>>   	 * don't want to check for delegation conflict here since
>>   	 * we need the state_lock for it. The laundromat willexpire
>> @@ -5633,8 +5729,8 @@ nfs4_anylock_blockers(struct nfs4_client *clp)
>>   
>>   static bool client_has_state_tmp(struct nfs4_client *clp)
>>   {
>> -	if (!list_empty(&clp->cl_delegations) &&
>> -			!client_has_openowners(clp) &&
>> +	if (((!list_empty(&clp->cl_delegations)) ||
>> +			client_has_openowners(clp)) &&
>>   			list_empty(&clp->async_copies))
>>   		return true;
>>   	return false;
>> -- 
>> 2.9.5
