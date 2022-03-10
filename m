Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE194D4061
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 05:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiCJEpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 23:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCJEo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:44:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11963B7161;
        Wed,  9 Mar 2022 20:43:57 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A1MOxc002638;
        Thu, 10 Mar 2022 04:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2iRHccnSwzzeRGIGTfY7/hY3dZYa+38BdaZAVJUXk0w=;
 b=ZxvbIMkVcAdbeWAr0SfRCOQeHbkFA1fH/DQz+ZUoHTxVGHIrQvlRjrCNcA6IQIQCmNgp
 Ihaz4yl4CzXfnUQnGiye/QtUuhVLksNnpIRsfz9c2qG6BTac0N6ipnX8guriQ0Cc37SS
 1hG0X/HomHrdNmowN2DWf8lYKunW115wIbeBTQ+waI1DZIIK3QgGl+hl3G5Iepm/haCv
 Re7IEBLwMksPpzYaOjN1tD8Y2yj7m+ERvB8hKivM/Ur9ht61p9sEmvKyNNLqa2J4yGCW
 Zc8SXGOJwU7CSNPD9PlkA+SkV5tLLnvJ2XiSkHYL5JQ1Z1ptLjrjpv0W3b2hHiM9qhe7 qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9ckv7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 04:43:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A4aQMM085194;
        Thu, 10 Mar 2022 04:43:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3ekvywde63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 04:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdD0LwwNwzoKbxfnLFZWiFNzoRCXLKG/iGr/EVGoRpdcn9k2fLfZlaeI0qv0uXlnw88YQNVG7cZCm+Bw1y5feddhhJfMU/SgYyoXVdbxO73zU6ulNShyXbZhTE2kclnvpUoT5YG7N177Jwvn5R8Lpz+8zdFVK1Jy0S0LQ9V6PUzAbELr6vq4fOFZDfUWr28R+iAxrqCM7bWobtGnmdxcpLvp6D0mdj3iOUfDCdNtqb3xACmh9fZ7euUqEkcsaqAIF1585m/bXWTvtKyUiTQvKlsKLqOZ9B8R7eUiJHUtbVxIqWlRa0dD3x+AEpjNxBveEl7rP3ISagGzmvJCS4KeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iRHccnSwzzeRGIGTfY7/hY3dZYa+38BdaZAVJUXk0w=;
 b=J4hN2oe5vnvbn4N8ekz6zXwMwphoW5JGAA/yYnCLwsl+JgO6QAeKxEm1NXOPGvmSspLh/6ZsD2B9NXc8ZCty5vh3GkCWkxFbVZ+Q5rRZXpWCuw6rnjxA9QTjuuHMuPBh9K/TFerGADUVjAy+efWbgRO3X0LwjzQJJ/fpR23/qoZvjY0PKyjQECKGi3E831rUGt3ItAvdC17VNq6EqyrKdFTxoCSXGGN+pxB6fBEuHL71GVPaO+U8cld/iwlWRFc6kJ0WzyXdutq5YlIoV+AJWHlXP8SDOYM4k60o+UEMo/7K5pAriDwHOXhLhGdE5b6qkgGKs5siw3SJHguXAVZnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iRHccnSwzzeRGIGTfY7/hY3dZYa+38BdaZAVJUXk0w=;
 b=aunAiNWoAXzRNKSBODVkC6ehEeXObGY8hnVSn/ej3gvC1lcHqtcfcR8csA1LT8vBrn5WvDy+6Hy7GI7bNY/AGXOi3yAqFgiwFj5yQw/6lGtmR1lV1r9PCo3jeA1FODHkHcgvV5Jdw5LQpXv5Sql5+bEiPlNEc/Siv3SOzjk9V6A=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB3801.namprd10.prod.outlook.com (2603:10b6:5:1f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 04:43:52 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 04:43:52 +0000
Message-ID: <2362ce2b-ae2e-2399-d43b-f3473313bb0c@oracle.com>
Date:   Wed, 9 Mar 2022 20:43:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v15 07/11] NFSD: Update find_in_sessionid_hashtbl() to
 handle courtesy clients
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-8-git-send-email-dai.ngo@oracle.com>
 <E3F16183-1407-430F-B408-A298D4C29401@oracle.com>
 <89b85e56-dee9-da2a-55f2-c0134a109f07@oracle.com>
 <CDA6815A-D05A-4DE1-B065-4398ACF8AEF0@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CDA6815A-D05A-4DE1-B065-4398ACF8AEF0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a8bc45-2350-47c1-2d2f-08da0250934d
X-MS-TrafficTypeDiagnostic: DM6PR10MB3801:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB38016B7679E7BACE0C480027870B9@DM6PR10MB3801.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuAJpgKAPR1x5V4melVAnr8N2aY156cGy2tCm7tduqaAI5UskhiotcWSYoph++1qtEENQ1MlnkN9fT5R0mknuDeupQTnGQSB9g+JXnUtrf9ubKT7z8OvVVGDaG09Iwd+8Klsqu/lcR0yu3V9Fe9Y7WzF8pproqx8wNgGbxNg1wM87VSQfnlb65lGgsxFPZecClloFxq7RSOkP57cxiWrPF8Fp/bMHIy16OWigB87esgpymU20oFVxCxKqFK60bnxRx+9aKl0jt3L8UdruRqPAYKD6eAFB3DMi5AH0ErR9dO1/khrcUdTzxfZD/yZNDBKFzORgRSC3HVWmln/ryQTzxbx0e7VuZKBbOkd1zhvE5pjlcmf1yazDpYKvqTgFrx0RiyuZfjK70TyuT2fVY9ckT81PkTfLi0yI29s0nMaK+eGdMUOG8Rl7vSlg15JXt4NPC4yUwZDc4GUoxV0+vn2wmmFWAtMF7ldZNli8/N8OnlP/nGsg8oXyYXeA0reiDWgvGJGh2TqrL96cA7tjtDLXbVYmLJQcDMYuu16s4uKV3aMd+iIHa/WM6LtBcyGbshzcUwhKAUfqEy8CRa5Z2icTy46S7dVH/h4F6MlYznRT3nK+TYmsrJAz45WmSSfM1jcN9HYZ8oz+jIkq8P4OZgPNOKauJ9OkAglwN42yB3dm0pJABoplIj9GKrPNjN8Xoh+z2mAVLgGTNGoHfcIhmPDLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(186003)(6512007)(86362001)(83380400001)(9686003)(316002)(31696002)(38100700002)(36756003)(37006003)(54906003)(31686004)(2906002)(26005)(8936002)(66946007)(53546011)(6862004)(6506007)(66476007)(66556008)(4326008)(8676002)(2616005)(15650500001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2x2NjhDZG1xZkxHTWNURXFQWHo0YlROQ1V4TE9GVlowRE5nRSsydWNmM0pO?=
 =?utf-8?B?ajd4bHJlRm1nMEJKb0x2OHAzWGIwK2hPajcxa3F5cS90RlpxM0J1ZitBa2VP?=
 =?utf-8?B?QW5GTlRyMDRYVmdvWGNnODF4UllBVjYveGpRSEZIV1pBazgremh1aDNKSUlH?=
 =?utf-8?B?WW1OK1VndTJVUXFZU2pTeUxab3dYd25JNXZTNG9Cb1pvV29Sd0lHeXI3aGNl?=
 =?utf-8?B?cEFPTXpaSWN3UDBGTml2SXRJbXUxUnp4WXlsdVRCL3ZYM0phUHFIOEtCN3pq?=
 =?utf-8?B?WFZoaDgybi9RR1JHSFA5WXFBT2svemx4ZUdtS1VvRVJEblVwM0RvWC94OFU5?=
 =?utf-8?B?bDg2dnAyNnQzb3JYNDVnYmE5T3NBMnhZUk5veGJxb1QvMlZ2RFNrOWEydWxi?=
 =?utf-8?B?azNSYmR6c3JtWCs5RDkvMDRhY3YwcTFKajd2MUg1aWNyTVplRlJORTdycGJ4?=
 =?utf-8?B?T1loR3hZbTBoL2NNOVdKMFliUTJPY0RkaFpaODNrTU53VWs5bUcrWDNld2pa?=
 =?utf-8?B?Nkw2UG1mRU5CMlI2a0ltdVgzOXFUSnluakRJdVIrVDVNbjhrVTZVTkhvSW1M?=
 =?utf-8?B?WmZhYmxjNHZ0Z2YzR0pKUmhxT1J2a3hBV1Q4dDlHZDArRzBqekJuODJ6YTBi?=
 =?utf-8?B?Sk1URmQreVJoZXpiT0V5V21mbGtOam03N292dXgxTk5pWTJ6elFlMVFSMFd0?=
 =?utf-8?B?Yk1jUkNrYSt5MFhSQ05QNU91a2puYTZqRGJFejdFaWtVYy85dUF2STVGZlRZ?=
 =?utf-8?B?NVVKOFZKV1ZkSkZWUVpIWlhkYmJYUXZvelBsdHY3UzBYVzd4WlRSNTd0NUhJ?=
 =?utf-8?B?T24yT3JzQURITFUyTHpOUWYxQ1hQSmY2aHR1NGxIb1hqeDI5bUZidTVKajZs?=
 =?utf-8?B?eVRNRUk0bWZ0VVRkZnR0MW1QRkFFbUMzZkl4TUVEN3VqUGRnTkIwNSt0bnJH?=
 =?utf-8?B?RmFFOGtvRE1JKzgwcTBmRGpyZGFOMXpjbEsxdTZXeXpQbGhIbXdVVHk4UmdB?=
 =?utf-8?B?R0VNelZkNS95ZSs4WGdvSk9QUDlTSXZlcVZONm5mOGI2M2VEVzlyQXJ1SE0r?=
 =?utf-8?B?UWxFRHNRQXZ2RVNNWjFTZldQK29LaDBhQy9ycEJ6U3Bzay91aXZHblU3d2J3?=
 =?utf-8?B?bFVRVGtNdVJxUFhCLy9XWHZjTENZMjZMc1owb1kxWjBBb1FrYmp5VlV5RFgv?=
 =?utf-8?B?aldab1pYcDRCbXpuenRLcmNBYTJXU3g3NjFLbzJWNkIyb1JPMFM2VkNEY3Na?=
 =?utf-8?B?OXhaTmZQTkVXMTM3TUt3RStuSUJCandkM1ZoZSs2MjVTekM0SWV5UzlNVnlB?=
 =?utf-8?B?WFEvNGZhOEp5YXlZMSs4QVEvVHdkYVMyNFEybmV0OWV4MTd0UDNRU3BncDdu?=
 =?utf-8?B?N2lWT1ZWdng5czYzVDMvNzRJbGVYMkdFeGN2SkdZKzNLMzZCSjdNYS9ycXUw?=
 =?utf-8?B?Z2pKZnh4RWZ5ZzNZZlc4UnQ2SHcwVm1YN013WmJ5ZHp3MlRtOHJETmFxN1Z3?=
 =?utf-8?B?N01waU9adDRCcGZBamVyM0JxMlQvYzdNSUVjNXZaQkpaVzQxV0p4K0QySi84?=
 =?utf-8?B?NW1ra1dJM2orckhYWC81K2ZMK25pYTlYVHJWVU1Scm1LUmovWEJlU0gwaG50?=
 =?utf-8?B?aWQ1WVlNZTFRNXIrSHNObTE2N1VsTW1xUTRFbmtIcXNzTDBMVjZyL2VlZXRz?=
 =?utf-8?B?Wk1WZ2VuMkIycmozc3pPSzF3aGtmWEQ4ejFFSHhRU3JwejVDVER5T1lHK29R?=
 =?utf-8?B?clJKNFpWVTZ4bFhjbDRxanZNRXBIMkJmSjd2NFd1cWp1VlJFM1RWTHJyNVg4?=
 =?utf-8?B?Z1N2UzduclRQYWtUQWQrN2FvT3ZhUTBGdUNDdHQyVm1xZmFEV1JsYnF0MGJ5?=
 =?utf-8?B?bkptMnlJR09vZlg1SjBTdGtmTEZuZC9uR3hhYllRNjFjaWhjTVRQVDVPZmk4?=
 =?utf-8?Q?7KpUc/HYkoFSd4xveLYFF+GvR9xdgqX3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a8bc45-2350-47c1-2d2f-08da0250934d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 04:43:51.9712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0E/GO97xe1Z4yZ/xO64q+n16iOefbC+jUs147fAqKv+JWoLmld6g70Gt0vgejv1cmdTPC1D8vgd8Px3kh1aA2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100022
X-Proofpoint-ORIG-GUID: LRAYOEuszkDoN4kiJl8yZssHvc5o7aFj
X-Proofpoint-GUID: LRAYOEuszkDoN4kiJl8yZssHvc5o7aFj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/9/22 7:33 PM, Chuck Lever III wrote:
>> On Mar 9, 2022, at 10:12 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> ﻿
>>> On 3/9/22 2:42 PM, Chuck Lever III wrote:
>>>
>>>>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>> Update find_in_sessionid_hashtbl to:
>>>> . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
>>>> . if courtesy client was found then clear CLIENT_COURTESY and
>>>>    set CLIENT_RECONNECTED so callers can take appropriate action.
>>>>
>>>> Update nfsd4_sequence and nfsd4_bind_conn_to_session to create client
>>>> record for client with CLIENT_RECONNECTED set.
>>>>
>>>> Update nfsd4_destroy_session to discard client with CLIENT_RECONNECTED
>>>> set.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>> fs/nfsd/nfs4state.c | 34 ++++++++++++++++++++++++++++++++--
>>>> 1 file changed, 32 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index f42d72a8f5ca..34a59c6f446c 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -1963,13 +1963,22 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>>>> {
>>>>     struct nfsd4_session *session;
>>>>     __be32 status = nfserr_badsession;
>>>> +    struct nfs4_client *clp;
>>>>
>>>>     session = __find_in_sessionid_hashtbl(sessionid, net);
>>>>     if (!session)
>>>>         goto out;
>>>> +    clp = session->se_client;
>>>> +    if (clp && nfs4_is_courtesy_client_expired(clp)) {
>>>> +        session = NULL;
>>>> +        goto out;
>>>> +    }
>>>>     status = nfsd4_get_session_locked(session);
>>>> -    if (status)
>>>> +    if (status) {
>>>>         session = NULL;
>>>> +        if (clp && test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
> By the way, I don’t understand why this checks CLIENT_COURTESY to see if the clp should be discarded. Shouldn’t it check CLIENT_RECONNECTED like the other sites?

Thanks, this should check for CLIENT_RECONNECTED as described
in the commit message.

>
>
>>>> +            nfsd4_discard_courtesy_clnt(clp);
>>>> +    }
>>> Here and above: I'm not seeing how @clp can be NULL, but I'm kind
>>> of new to fs/nfsd/nfs4state.c.
>> it seems like @clp can not be NULL since existing code does not
>> check for it. I will remove it to avoid any confusion. Can this
>> be done as a separate clean up patch?
> I don’t think this series is going to make v5.18. We can keep working on improving each of the patches. And I would rather ensure that the series is properly bisectable. I don’t think we’re at a point where the patches are immutable.

okay, I will submit v16 to address review comments.

-Dai

