Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF404DA004
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 17:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350014AbiCOQ2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350002AbiCOQ2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:28:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562A756C39;
        Tue, 15 Mar 2022 09:27:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFghX8029145;
        Tue, 15 Mar 2022 16:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=F0h7tuWOPVSeZMgHb/pu1uXPL+2qtqQqyakfhPm4O10=;
 b=pRiMDkPrEFXZ2vA0wOT6gkGjzLd03J1+u4Lkpjq+5oYLDGC3Ae3cAdqN6NZKvU5cbbwY
 aQZOfti/GD3VNiR645AoV/QAuW2PmHiY3zk2YD+6i459hfl58DxPVuCsq+t2meQb4S8X
 xHlXncw+Avg8MEkWadeJmIlU0hFwJgVXzQfaILN3O6sidMyHobZderqr8Y71VzeiO8RU
 5VQ3HmU5qDHxTuUDHOpL20XXU0Tlxh8BlGiAcMXWllShuC3c7PkN8q8UetdgEeWkZS5W
 R3Q4vj5Ql02xhT7wo5YBO3UiXUMa4epkDhMoFHFAUus3zxynJr0oTwjaeb9govqYsoqV KQ== 
Received: from userp3030.oracle.com ([156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwkjj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:27:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FGRBef153754;
        Tue, 15 Mar 2022 16:27:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3030.oracle.com with ESMTP id 3et65pp14v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:27:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2llJGrMaTCqtxk9TUt09uVP/t5tXqr/xl/9oPLRVJrLiVR55niEvR37e2T9SopQDkkZXdJrxI295VLCWqrbDVnBBiu6BqG0gWM+Lp/ywgDGRrDvAXIuM5seFivzEmrIIceT0IKKRa1xQQtCV9V0HcTtmvrPJOnGudlzOAlYrLwS5ZTWvPwEmTr6KY/3Jaeu0nLo3Qqgs5BZYL0bEiZJ3iyuP0TBWVq0rXF0Z5bPHY8Adwvbjerlr3b741E6FyiCJI7zrbr0Tu6Kk8EeLaQSVz81jBrP0H/he3ITiEI0YalaYUBAZbSH4H0rMq2w4pj/NQy/k7jnZJM+hyRlfdgxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0h7tuWOPVSeZMgHb/pu1uXPL+2qtqQqyakfhPm4O10=;
 b=VJAwdtcvJDQLa5xB+PYqTcWF5D+imhrw7znmBlmxZdIzA+iPCoplyx/upREa79M/Rss8ojjkXNWy0Z9lzOkeV8avO6Aeb5p/EXb7PdRveHRd1vV4JOp7+Wpu4rkZOUMi/Yn5wGJUJap4Gt+YxBmT6tqaCBFqHm8pCS97275iPGgcROO0LksZv292/StBdDjLRDDwxfEmRzXDhRKhFSW62LNcrKW/GXjadQQ2JI5gKbRnmQJX++hGLmfMiKC4ZbOmVmZKJBXxEfEbL0fKbi1jKKehwrJlnWz2RYdBXFVu4nWKr94vS7+nybdSQWOwNF5fmavEXQ94rtU2IJUE+JgvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0h7tuWOPVSeZMgHb/pu1uXPL+2qtqQqyakfhPm4O10=;
 b=NUAJfqC/vBcMetGXJbH0JSjODK7itLZpTK82LJS8iBVSVvYDHS9DGiyw6+cdeaMRxy8fYpIzbxJUVixZgJG+ExlXM5f8xojW9DEnkI5H2/QYFcIHCvZSD53qHqicdVBKuEDjFDtu/tY5rsn/M6MfcDKtpdNofyOQQ4IRHuPIhCU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MWHPR10MB1902.namprd10.prod.outlook.com (2603:10b6:300:10d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 16:27:25 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 16:27:25 +0000
Message-ID: <8a4fe0f5-f011-e944-e4ab-cd250971dc7b@oracle.com>
Date:   Tue, 15 Mar 2022 09:27:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v16 04/11] NFSD: Update nfsd_breaker_owns_lease() to
 handle courtesy clients
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-5-git-send-email-dai.ngo@oracle.com>
 <EEB335C0-818A-4510-AA51-547CB9F57DF4@oracle.com>
 <20220315151323.GB19168@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220315151323.GB19168@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0218.namprd04.prod.outlook.com
 (2603:10b6:806:127::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcd60c8c-6239-41a4-e37d-08da06a0b05d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1902:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1902A17E775FA14D9D63320F87109@MWHPR10MB1902.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xXCuzEIiRWta1xGjROOGUG8Do9ay7rx+XcC72haMabr19OWVYkMKJm7wo97kvKDEupRwQEmXaprnUzmkOoAfQ9n1v9cLp7eJU5ZVbVrG6EGkjhFkoowijgCgcxN8WPPvpvdPcouDTMQ8V46yn3rNfxQ4yFr0KRYlSxdT6GIkoLeYRRJo8ZyWIeusZg3hPSR3mn+4hkFuuKschswBLAzLraWNRjnc9NIZYvvI1WbIL+ekPIZCJhsislASdaqb3ydNrVnNdSsFhr6b54aAOwF9hpJbTOKQfW321kUQsjB0oVH7g0Z36lRzLOMFGzCTJHQ/RrSRNCKiJbZYz6U8jOOV67/0u6cK8swmMJK+5BZI7xfGpujfKwEVcCst9OtRpBYvRt2jcch3tDg2+GSCEfUANTxezV7k2LJhCCshjlQSfHSwZE4gHGO+SkOF4Hvr/S0NaBUnVdR0Ewr2HNpzet8RzWsrsCSCi1fjE4rFZ52hzWIb3qsixGkwhUYVJYd9s8vGiLbucdcNt000iCaMmvULG0655byRlhHKLJ/p+gmHpsuEYVurfeQO5xzrmowDjPiRLnHwpC3GMnjfpZ3SiuuCaWb8rMojdHJOAj6q4V2vVrH0wgWOkJAZxcmVnG5t1aLUJkRpK+pEVyxYjiyMuP5tQ7ULeVWzC/y2sUJROf0UXERCkw6tPvWIXwQd43jk+3PNLX0SL3Zm7N/XwEbkeoHXEBjfje6Ov57VvWHMjXhXRkTqvOSa7C050zrQBrALisI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(53546011)(36756003)(2906002)(508600001)(110136005)(38100700002)(4326008)(66556008)(66476007)(8676002)(66946007)(31686004)(6486002)(8936002)(316002)(54906003)(83380400001)(6666004)(9686003)(6512007)(6506007)(5660300002)(15650500001)(26005)(2616005)(186003)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVlRU2h0OGV0R1RvcVlXSStGbnRHWHdRZTk3bHBsd3NMWktqV1ZnWklldUx2?=
 =?utf-8?B?MDRWMXBnWldyTmJMUW5TUUJLWWxLTWVTWGV3SUx5UVYzNGpEcEZoZmhRdDBj?=
 =?utf-8?B?dDVtZThQd0R4VmZTemJHVXhQK2M5YnVtazFvZTVIMDlUbjR0M3BrVU5OUEgv?=
 =?utf-8?B?WWJrK0RPMzdNZ0trWFpURzAzQitKQUpBdC95MjJUV0VLcDM4REtONjcrM1RK?=
 =?utf-8?B?QWNDYkN4RjludEtOVi9wZXVucGNBcWkzelFzczJERVpQVE9zQkJkbzhvc3pP?=
 =?utf-8?B?TXJWOENCeWNjazQwRisyb1JOT0JuL3E3Y0h2K0NUOVpyZEoxbEF3akdNWkJx?=
 =?utf-8?B?Z0VnRjZHMkpKcmlaem9LbGUwaDJKYSs3UVNNTS9uNTBtTlh4VVNlSVprNlgx?=
 =?utf-8?B?QTA0VTVWVWtrYmhFWGd6eGMwcDFBK3cxY2YyUnVDcjNSaDkwUG16MGJkbG5l?=
 =?utf-8?B?OUpES0dmWWRLL3crRk1sVkFZL2NsZ0xRM1VVRk4razJrTjNncEtlUlIrWHdF?=
 =?utf-8?B?OFpQZmloUEFYZnRabEtTbGJZSjBZVTI2QkVqZXU1L3lkaHlYQU1mN3NYTEtn?=
 =?utf-8?B?alNXUDNHV2p6bEk0WDZiZEt3WjdiQXZadUtpMDZlQ1RFYkN4NUgxU3lPQ3p4?=
 =?utf-8?B?R0RDb3ZNRVlXT2lNNnduanVVeWFZMHJuUzRvVnRaWjZHZW0xUTIzQm1Wcjdn?=
 =?utf-8?B?MzhQbWFldXZKU2c4TUQvV1NjOUFaSENzb1VuN2R5bXREUldyY21wZ1o5WGxo?=
 =?utf-8?B?RnV0YWxtUW9walFSNCt2bUNPWGV1RDdMSjN6TkZmNEdUcGhhTGF1N0hUSk5O?=
 =?utf-8?B?UVFBcExEandlK01Fb3N4OFpNV3ByQUpPTElRT1V1cFl3SVhJb3pzWXJaRVZW?=
 =?utf-8?B?NDAvN0NvYlJnVlJHdWh6bkdieG9PZWthU1dNeWo0dW44b0pJbk5nMG5DZU5U?=
 =?utf-8?B?SWpKWVVZVlZBaTlBZU4xNUhuUlhXQmxsZHIzYXA1L1pvN3hESm4xU21yUThP?=
 =?utf-8?B?L1RMNlo4YWZ3MlgvbHY5cVpTMHZqZTdEaC96dDRCOW9PenNMQSsxcTUzaGRr?=
 =?utf-8?B?Nm1RM0tHbDFaWTQ0eXFmTW50OWxPaHVWbE9YYmxvWUhKMUZuZFpYbGc0dDY4?=
 =?utf-8?B?MmdLUzlwY01aSU41R1BoS2xSb1l2M2plNU9idE1QNHRCM2ZVV1FuNVNrOGJn?=
 =?utf-8?B?WHdkeW1uUUtIaUZ1cWZrOWxqcEJINk0rWFZLQnVyZmhkY0dqWnNRTllMT0Vv?=
 =?utf-8?B?R1dFdkJTVXp6Ymt6TkxUcVo2VjArdzAvRHNQcnFBckV0bkRTYnpUdGExdmJC?=
 =?utf-8?B?cG9jWnByMUU3Z3VZa2o4STZxYVFGcGNUWUwyZlYxeGdTNllYWjVTbURJZkV4?=
 =?utf-8?B?c1pPS2tpR0hoYXFUT0RHTGVKZzVMTGFFWlF5WHlHVE9kQTBqTmhReE1seUZF?=
 =?utf-8?B?cUlXeGJocGloS0Y1bWNIOHcrSXNhYmFQWGt4S2UrV0N0M2I4aEhvR0I0Ykgr?=
 =?utf-8?B?dkQxK2Y4ZnBWckpzV2RSS1ZoeDNrT2IwZkoyc2lGeVpxVmVKK2wwNktqKzBD?=
 =?utf-8?B?ZUlOWXIrdUlsV0ZtTllROG16bkpBSGJFZXp2M1JjQnRsenZqMnd5bzlNQkkx?=
 =?utf-8?B?N21YWWlhLzdGZkFVamhzaHZmL2dnNld3Wnp0L0YwalFpNkZSSDZFTGUrcUNq?=
 =?utf-8?B?NEVjam1ab1lKV3ViRy80VG5rMnRwVE5yTThaeHozSnNjU1diUWlaaXQycHZ3?=
 =?utf-8?B?c1hsZ3pmaVFFZlk1OG9YU3dHRjV0ZkZZNEQzS3pQQ2V0azIwU1lkMXQrekVO?=
 =?utf-8?B?OEpvakdmVEx0WEU0dS9WMnEvWFVhVGx5bGMwYVJtQVpVRWZEWmVHZWRTZDJw?=
 =?utf-8?B?SENDcnBBWU9WUlNiVmdaaXRpeklhNFN2a3REVFBUcERSOXZLdm5sTDVma2lk?=
 =?utf-8?Q?vVmpioO9Ij74TU6SDSYRg+WYwPVQ0lCh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd60c8c-6239-41a4-e37d-08da06a0b05d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 16:27:25.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+9z+1YWlVIH3uZTfXadJLSb0xPOD5nOTBgUubZgeiaMsFNcmk9i1IA20YB235YdfEgkt/3Kp6PV0TQQwF1ESQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1902
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150103
X-Proofpoint-GUID: mHQkOShuK0gUqQA2mTHwM9Q8oOdfFmXV
X-Proofpoint-ORIG-GUID: mHQkOShuK0gUqQA2mTHwM9Q8oOdfFmXV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/15/22 8:13 AM, Bruce Fields wrote:
> On Sun, Mar 13, 2022 at 04:04:21PM +0000, Chuck Lever III wrote:
>>
>>> On Mar 11, 2022, at 9:13 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> Update nfsd_breaker_owns_lease() to handle delegation conflict
>>> with courtesy clients. If conflict was caused by courtesy client
>>> then discard the courtesy client by setting CLIENT_EXPIRED and
>>> return conflict resolved. Client with CLIENT_EXPIRED is expired
>>> by the laundromat.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c | 26 ++++++++++++++++++++++++++
>>> 1 file changed, 26 insertions(+)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 583ac807e98d..2beb0972de88 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -4713,6 +4713,28 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>> 	return ret;
>>> }
>>>
>>> +static bool
>>> +nfs4_check_and_expire_courtesy_client(struct nfs4_client *clp)
>>> +{
>>> +	/*
>>> +	 * need to sync with courtesy client trying to reconnect using
>>> +	 * the cl_cs_lock, nn->client_lock can not be used since this
>>> +	 * function is called with the fl_lck held.
>>> +	 */
>>> +	spin_lock(&clp->cl_cs_lock);
>>> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
>>> +		spin_unlock(&clp->cl_cs_lock);
>>> +		return true;
>>> +	}
>>> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>>> +		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>>> +		spin_unlock(&clp->cl_cs_lock);
>>> +		return true;
>>> +	}
>>> +	spin_unlock(&clp->cl_cs_lock);
> Same comment as on the previous patch.  ALso, this is the second time
> we've used this logic, please define a
>
> 	static bool expire_client_if_courtesy(struct nfs4_client *clp)
>
> and call it from both places.

I will replace the similar code in nfsd4_lm_lock_expired with
a call to nfs4_check_and_expire_courtesy_client.

>
>>> +	return false;
>>> +}
>>> +
>>> /**
>>>   * nfsd_breaker_owns_lease - Check if lease conflict was resolved
>>>   * @fl: Lock state to check
>>> @@ -4727,6 +4749,10 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
>>> 	struct svc_rqst *rqst;
>>> 	struct nfs4_client *clp;
>>>
>>> +	clp = dl->dl_stid.sc_client;
>>> +	if (nfs4_check_and_expire_courtesy_client(clp))
>> Since you'll need to fix the kernel robot issue in 1/11, when you
>> repost, can you also just pass dl->dl_stid.sc_client directly to
>> nfs4_check_and_expire_courtesy_client() here?
> Agreed.
>
> This client is quite different from the one we look up from the task a
> little later, and I'd just rather not have both represented by the same
> variable.

fix in v17.

-Dai

>
> --b.
