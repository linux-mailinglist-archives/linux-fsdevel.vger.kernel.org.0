Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988184D3F8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 04:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbiCJDMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 22:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbiCJDMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:12:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A827C152;
        Wed,  9 Mar 2022 19:11:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A1IlEx002635;
        Thu, 10 Mar 2022 03:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3SBEyvjyix0iLZn53eRGIFvV0zuRYWwsctG/c0o/jqA=;
 b=hlBBAoUVUE8s736/snb5ZGzUVeTOf97tb9vfZT6hynvVQgQMPCU9LKtgVPV6N2lfqynD
 N6DmFGfYY0DtG7N5dhZWxB2tBwHKiffkJp1iOyg9y/l3ycvMskNvA2KoMmo9c+jpGI8d
 8OskmzHPnvA+fMmFqITeujj4Aodt+piDcDJ2FwovU92+ERjlJ2bWwU1ZIVdH8QEi4Wkg
 HEh+9fgi7LEroBOMewVSH9Wzl+0xJpMQqNY09SsMQdh4B7a7S1wu95Exg2UOYQqxv5ff
 ddftv5o2lMcHnWlhiE4ZhWJTcSHlKVTdBnjwne4obZ1fCEdj974x7xl4gJF+eiKWTnIq iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9ckrn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:11:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A3AQ5e144014;
        Thu, 10 Mar 2022 03:11:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3030.oracle.com with ESMTP id 3ekvywbtya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:11:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkTsM6V6VkHPmTtFbfP9Mu//iQ5WVuVIIhVA3M8PvZ51WJHRvChCzQsd2DMuGOV/N7ZQNkq4fLrUmIlMhBV/47TUTVuy8Wwis/grh+pdYLloXtmRsJ7tlkRhe4hXVQuu1re0Nv9JAxm2cuvd02GuhYlIPyhPdRX42+yreZnp50uE97Z77rmVleIMx70MA4cRL3NJpcJFtXvgVy2BMsO17vmX54sTdO+9C1AEVKkJWOMTGWSQWKfYqiLmucHLU+wMU1aoa3FTN0TdlV6xzVX2dpQa72Kuq6psVncSLn0DWlVv/bJ/Qp5K12I1ng1oduVD2R03VXrf6hYvR5iLHkDbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SBEyvjyix0iLZn53eRGIFvV0zuRYWwsctG/c0o/jqA=;
 b=c1/plXvLlvAzgcwlzmGol0MxSfykIJPT1BUtgy3vVtZnKuAi7TouHMrl4uoAuCm3Wxj0SEE0j92xxN05YfPKgKBCNQ3mf4a+LG9UdxHFYZl23wcPgE05ZP4rqnqMf3wGI89PASrf9uL1K3mSCLsdZ4bnTN6dx4qkiVRCG07DHd1nknASjO3QYUPG3JrKBLiTmFE9zz8LV1UfcSkQolYCVOEGjBkgAaUOHxXCLBJnijhHcC6/rBLDRDYHRhxyjoZfArFqOs5qj27kYHm1nXCZk/wiS41GT/d0g2ne5ZrY0Jt/wC3Y8ihhpt76i3pMumoMP9rMR7X1G6yQoBt/XhP/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SBEyvjyix0iLZn53eRGIFvV0zuRYWwsctG/c0o/jqA=;
 b=vJQ1axQm4NFsrEW3hLqePV+Ex4yPyRqtPQ+/wMoi+CLh0rpDZpzMTMvpg8a+V/fKRB/eJOJk0bzCRucpl5Tq1LHguW+9zWMQBjTwy8tRx+PqH94Dv6y9VgzDpGmSeq+KRXR6fR8Sjf7C+/MCFbVYOELygR1l2hvwBvk/L7m1pWI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH2PR10MB4053.namprd10.prod.outlook.com (2603:10b6:610:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Thu, 10 Mar
 2022 03:11:47 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 03:11:46 +0000
Message-ID: <25e27f34-15c3-104c-c90b-cecaa03fe9c7@oracle.com>
Date:   Wed, 9 Mar 2022 19:11:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v15 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy clients
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-7-git-send-email-dai.ngo@oracle.com>
 <EEB29573-9801-41A7-9CAF-9E3AE1B23D6A@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <EEB29573-9801-41A7-9CAF-9E3AE1B23D6A@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94595bcd-c4d6-4083-bb95-08da0243b616
X-MS-TrafficTypeDiagnostic: CH2PR10MB4053:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4053EC1F7069336031080F6C870B9@CH2PR10MB4053.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9aOwW5yxO3Gh/8bOI78xjy8+DR2gm/YegmCv6lEPdVrPU0w71bx8gx0POmGIm93nHxxeFKcSzJ9MvT4rdgScoh3Hor30L/tvwGZFWXXXrVlCX1ryRdnklG0SoDCuJJbCmWisEzJOw0dm0ajfQLVsbLf6S/TkqOAnDKQ5mf9oaq/Xjv83vPG0yfU3YfEvoXSLdmjUmbDOsLnbaHmKOZIVpyWlV8ieYWaIInNCDjsj3hROmXqD6o84IPQFH2H3CbkGTtQiJPi+hS+JluX6siAAFKUuXFYxu71CuTu3U99+0pVOioMkBJdQRgGrg0OLnJdBBqjfOLv2YdU7vwL8D75Q7VcW1jKUsbg4FhOQa1dP+qcOBChQrcw9kXD61h26jLIDszrnlv4UKMKjM2/OW/hvoi+uJjL/AcAuUA+nFdz4ZDeXyjRoet08OipWdS+xBlqP6bCAuRDVifI1kkMJ/OwYSL+SzUwGXRTk4cPgIhNzR6G0WUMmUdkNzJbwyq2t3bK1/4oN/AdorEefSmtuch6R8xFLLEE227uxO1Z8D234+z7F/8PpPWjHWeRAYfAUMk5KIWcXpx8L3BXHTqKn4eCvwJrEDDiCDvFbDRbLh28gmgF5ye1AT+h2IYBieQlCSGODW+lzimRlsi6t9XDjQsvgYY4RK5HFnFQbak4vGzeDTlg+zBewLu7XvN6oIbQg/WjVOH0wLuDY3/lAsgxrwTPAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(4326008)(5660300002)(8936002)(54906003)(110136005)(6486002)(8676002)(66556008)(66476007)(66946007)(316002)(2616005)(26005)(186003)(15650500001)(508600001)(53546011)(6512007)(9686003)(2906002)(6506007)(31686004)(31696002)(36756003)(86362001)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YStIV0lESndCRVZxdERYa1JRNGJQQVFQSHE3TndtUkJ6MDZHKytvRkJMc3dy?=
 =?utf-8?B?Z2hhMFlvR0Z6MVlNUG1VaUh5cm9UaWIrbjVKSHpFcklQN0NxZFFXdFQyVE5U?=
 =?utf-8?B?OE9DQXU4bjFlNFVQUEh2MWp5bW56OWxlaWo1eUVxMWxTMUNnWUd0MXhicmhx?=
 =?utf-8?B?Nkg0RjRNbzJudEdiUFFjVFFYUmpGTm4vZkppdGxSeGRIb29Kd2c4elRaQnBu?=
 =?utf-8?B?MkR3WUNHMjFiU1RPM3dPbTRxajJiTUJLOGdGd0Mwdld1ZGRaYU5BWFB5Qmho?=
 =?utf-8?B?aG81enozTW5pbW5zQXA2cXNIMC9UOFp5ZzhaL1ZjNGlIeklsVmlPWEIzek1I?=
 =?utf-8?B?d21pVlhXUUdhZkwxZW5IVUNORnEzeG9VU0dXQ1JaMDZONnIvOWU0YXNQV3kz?=
 =?utf-8?B?NXJxeWhydHlXaGFNV0Z1V1dFRVd3K0NQckYvVDJVUHF5U0h4WHk4dTRRempL?=
 =?utf-8?B?Y0JicVJlN1RodmdEZzhPeWlPcU9nTHBvVHlnS0lqY25sSXpFQVN0N3Ava1FG?=
 =?utf-8?B?NVp3RDhqbnZOVVBQOHRMUkpiR1pwME1CeVFiQmN4VGJYNjU5Tyt4MzRkekRR?=
 =?utf-8?B?YjVXanA2a3k2U1B6MXRBbnM2UE9ERTZYMk54Qy9KQndqMUluQklJQm5EcHBh?=
 =?utf-8?B?ZmN0MExDRDFzRFcxaWpBVmRjRWNrV29aUlpXdzJ4eXVybko2NHZQOW5jYU85?=
 =?utf-8?B?TGZZKys2K1VBdnV5UUk2ZmFJd2JENEdicEFvUSt2Vkllb0FUU0VORDZ4UTZl?=
 =?utf-8?B?QS9Ed3JnRE1LZjliUWh3aVBVNjlQNEYvb0ZKL0JaNW1Lb2xIajNsZVowZHVy?=
 =?utf-8?B?SzQzeGNaSzZNcmwxZEFXc0NwNVhqb0VnUGNsZnliTHE5cGovc2tnaC9uSGRv?=
 =?utf-8?B?MjQ3bVcxK3lRd1V2VWdMSlk4OHE0eDZSTCtIblpTdG5FYzVvcGlRdXpEc1dB?=
 =?utf-8?B?dHV5dU9kUUI3ZnNoVVNKMkpZenVYYnQ2V3BHTVdMditleXR5NlFyejEwU0lL?=
 =?utf-8?B?Sk4zOFdzYjZxSTlwMHVMMnNhcStGVTJYSTBUTXdsTGIybjl1YUNDSU1BczRV?=
 =?utf-8?B?Q2FCQjRaTUU4MURKUWYrb1c0QTBaMjVhY2xWS2lnV3g0MkIvSVZUQ2pQbXYv?=
 =?utf-8?B?MDVRajJ1M3VHQlRIYWVMb3AzR1FFbnN0TncydFFGVnQyaGE4U3UzaVlEL0M5?=
 =?utf-8?B?N2NFYUtQZlNpckxpTGtucjk4YXd3c1BFS0FxZVdmQVBzNVZyZm1saHp1S0lR?=
 =?utf-8?B?NXZPc2k3L3JuVTFZemZEQ05zRjVEcU5CQS85bWRIMEZyeFYzS2lGUDNhYWd1?=
 =?utf-8?B?MVhPQ2NFQkxyTEJyUjA3SFA5TTBTVytmZ2JyV2hHVitkM0pIMkE1cTYyODJ1?=
 =?utf-8?B?c2tsdnNER3ZDVHRHS0c1SVlqOUlvRlBMUysvdDFkVzVseFdoQ3FBbllXenFH?=
 =?utf-8?B?WS8xZjZtZlMxRDRnUnRaZnZESmFVWml4Q1lJN21kdjllQWVqODVBSlZ1dFNT?=
 =?utf-8?B?eW5PWHEraktiRzdKZXpDN21ncmkvT1hIMlZDa1hPRzhadXlwdVJaeHUxTng5?=
 =?utf-8?B?ekVDNkJwR3h5UUhoV2IxanFzak1wdGMyTTNBSjBYai9KUUQ1RHNRUFRLa1lZ?=
 =?utf-8?B?eWQyTFluL3RmQXN3d3prOU5kZFhqOGhVVWl3ZzRHdkxTVi9hRElWcnJrNUh1?=
 =?utf-8?B?UFV4UTNrb21WaFRta3lQRG45UEJTcjRTamdkMzdMQlJMMDdPVlBoa0d1bnc1?=
 =?utf-8?B?dzRWNFpjSEVDRDFFVDBkOXFoOEJGNjUxak95by9vY3A4MXAzZ0o3SVJJRlIw?=
 =?utf-8?B?ckdPWkYvU1k3ZTY3YUZFVVlhZFdIeDdvNjIvbTZnTElzVUx1OWZNYzZkR0xl?=
 =?utf-8?B?VEJhZHF2YmVNYWFkeUVPWlR2TGlXQVBwOTM1NVZSMjFYTS9paTNLakZiNHVY?=
 =?utf-8?B?UnZSV0V3WWJBNFhUaWc1SDYyS0tDSnlmQ1FVNmJHa3B3QVhobmV3UXllTksx?=
 =?utf-8?B?d2JwaTRxY3RFQW8wRXVNLzVNTnRGS3FPS3ErT2JUaUxrejVXUkRHTWlGY3Yw?=
 =?utf-8?B?bWhUem5HWW00QzV1amFoSnZxdGlmaGxEWlplbFZmUDJLak5LOUVCQVpPOGto?=
 =?utf-8?B?eW5XeHpQQ0pPdkxOdFhGQW9qaU9aWkRBR1NBVjFGckt0aW9tV1R3TmRVa1Nu?=
 =?utf-8?Q?EhAYb0tTiqTxHdefJQuAWTU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94595bcd-c4d6-4083-bb95-08da0243b616
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 03:11:46.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG7Qly/AwtYrh85r8s6/5VvXgTqTbOmXYjd57mZsic56sXiF/BNQz8Q87h8vA1LWDjWw3/7B75a1AeXwnDMswA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4053
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100014
X-Proofpoint-ORIG-GUID: VDP1gq4SioyRp7LA2xQSMMJ7J7t8g10w
X-Proofpoint-GUID: VDP1gq4SioyRp7LA2xQSMMJ7J7t8g10w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/9/22 2:08 PM, Chuck Lever III wrote:
>
>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Update find_clp_in_name_tree:
>> . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
>> . if courtesy client was found then clear CLIENT_COURTESY and
>>    set CLIENT_RECONNECTED so callers can take appropriate action.
>>
>> Update find_confirmed_client_by_name to discard the courtesy
>> client; set CLIENT_EXPIRED.
>>
>> Update nfsd4_setclientid to expire the confirmed courtesy client
>> to prevent multiple confirmed clients with the same name on the
>> the conf_id_hashtbl list.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 52 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b16f689f34c3..f42d72a8f5ca 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1929,6 +1929,34 @@ __find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net)
>> 	return NULL;
>> }
>>
>> +static void
>> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
>> +{
>> +	spin_lock(&clp->cl_cs_lock);
>> +	set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>> +	spin_unlock(&clp->cl_cs_lock);
>> +}
>> +
>> +static bool
>> +nfs4_is_courtesy_client_expired(struct nfs4_client *clp)
>> +{
>> +	clear_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
>> +	/* need to sync with thread resolving lock/deleg conflict */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	/*
>> +	 * clear CLIENT_COURTESY flag to prevent it from being
>> +	 * destroyed by thread trying to resolve conflicts.
>> +	 */
>> +	if (test_and_clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
>> +		set_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return false;
>> +}
>> +
>> static struct nfsd4_session *
>> find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>> 		__be32 *ret)
>> @@ -2834,8 +2862,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>> 			node = node->rb_left;
>> 		else if (cmp < 0)
>> 			node = node->rb_right;
>> -		else
>> +		else {
>> +			if (nfs4_is_courtesy_client_expired(clp))
>> +				return NULL;
>> 			return clp;
>> +		}
>> 	}
>> 	return NULL;
>> }
>> @@ -2914,8 +2945,15 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
>> static struct nfs4_client *
>> find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
>> {
>> +	struct nfs4_client *clp;
>> +
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	clp = find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	if (clp && test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
>> +		nfsd4_discard_courtesy_clnt(clp);
>> +		clp = NULL;
>> +	}
>> +	return clp;
>> }
> 2983 static struct nfs4_client *
> 2984 find_unconfirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
> 2985 {
> 2986         lockdep_assert_held(&nn->client_lock);
> 2987         return find_clp_in_name_tree(name, &nn->unconf_name_tree);
> 2988 }
>
> Notice the difference:
>
> find_confirmed() does find_clp_in_name_tree(&nn->conf_name_tree);
>                                                   ^^^^
>
> find_unconfirmed() does find_clp_in_name_tree(&nn->unconf_name_tree);
>                                                     ^^^^^^
>
> I don't think we will ever find a client in unconf_name_tree that
> has CLIENT_RECONNECTED set, will we?

No.

> So it seems to me that you
> can safely move the CLIENT_RECONNECTED test into
> find_clp_in_name_tree() in all cases, maybe?

nfsd4_setclientid needs to treat the courtesy client a little
differently from find_[un]confirmed_client_by_name. It has to
expire the courtesy client immediately to prevent multiple
confirmed clients with the same name on the the conf_id_hashtbl
list which causes problem for the subsequent setclientid_confirm.

-Dai

>
> Or think about it this way: is it possible for an unconfirmed
> client to become a courtesy client? I don't think it is.
>
>
>> @@ -4032,12 +4070,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	struct nfs4_client	*unconf = NULL;
>> 	__be32 			status;
>> 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	struct nfs4_client	*cclient = NULL;
>>
>> 	new = create_client(clname, rqstp, &clverifier);
>> 	if (new == NULL)
>> 		return nfserr_jukebox;
>> 	spin_lock(&nn->client_lock);
>> -	conf = find_confirmed_client_by_name(&clname, nn);
>> +	/* find confirmed client by name */
>> +	conf = find_clp_in_name_tree(&clname, &nn->conf_name_tree);
>> +	if (conf && test_bit(NFSD4_CLIENT_RECONNECTED, &conf->cl_flags)) {
>> +		cclient = conf;
>> +		conf = NULL;
>> +	}
>> +
>> 	if (conf && client_has_state(conf)) {
>> 		status = nfserr_clid_inuse;
>> 		if (clp_used_exchangeid(conf))
>> @@ -4068,7 +4113,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	new = NULL;
>> 	status = nfs_ok;
>> out:
>> +	if (cclient)
>> +		unhash_client_locked(cclient);
>> 	spin_unlock(&nn->client_lock);
>> +	if (cclient)
>> +		expire_client(cclient);
>> 	if (new)
>> 		free_client(new);
>> 	if (unconf) {
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
