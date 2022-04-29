Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15D515210
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379593AbiD2RbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379669AbiD2R3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F38AF1F1;
        Fri, 29 Apr 2022 10:26:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TEWl6O011361;
        Fri, 29 Apr 2022 17:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=S3PeElY22RNlUbrk/8SqZD3nfCyUfuwH+IZSWjTKUv0=;
 b=KnfmDrBcSBJgYM6G8vqJF3dlza2e/nb2g9/MdgqAN2gmPU6FGtCwN7jaftIzMCLRjeLL
 zQPg6q8KyJU750NW7qs7NATLQ869aUZvNN1nDUVezTlPblMo28kMNViWhveuhnNxcJwc
 trMZppYQyE/OOGFvPzBsDhrfuWrmxv79e7P4hvpfTWUe80+m/sk3a6o+6CJkI9z8rIO9
 MvYFPYxCVsPQWsm2m5wG6m62y/fhxaLWzoQ1MX1zzKu+drWBo84Wr4wrYl/CI6MAPKMZ
 4XXtrI4CtfiDrBlAJKoIxSUUvOqvz2P4cGyhdL0lVoerekAzi+wkIrS+oMNGrkYeJ/B3 Ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4qgqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:26:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23THGgsH033401;
        Fri, 29 Apr 2022 17:26:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yqe2ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:26:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9c2OofCO8eC8iiuScfrH4gUC8KKzhdNUYuqxF48wPKna7fWJGpyk7cZzEcsy6pSQEZVoj5tmIBjAX7ruY6Nbax+qOEk9PWumYPrygPD4dcY28/sc2DvAPqZKjlz1P2LJ2b+fQFrlGVfBn2vTftdoQyOCWwqcYQ3ruR5M3xsdUAA3lUr2HdqPV5PeWK3u/JDuPduokT/8RN8AeNeJ8/G5L0gvChR84Oa0lilUFgF9FH9GNCZCNTViXCj/Al0qZzoopoIvMPwDbpzGbFTr9/98UNWETu9jycSAklv9a6au2+y03CCvjnoWGvG8xq+JTdNpoqXi5WvN5fL/SSAYSVkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3PeElY22RNlUbrk/8SqZD3nfCyUfuwH+IZSWjTKUv0=;
 b=eqjJ+92qJ9g8cLfd3U6EwSxeUi6JoJZy44/kW3h+XrIMSIlwvnzXqZCC5BNkhMVsDgh8uxO3IS4qiSQIyyfYP9f47ZpIMq/0DXgXkvk/qC8KEOC7dW5+Lh+G4I3JwfAjzGVxYEqLS6FwQ9CD5h656R/368yDcNz1WKcuUY6DpJKHYap+Le3XpC8fw5dNrz4er4+AM/37pEjCTWXaZlTz7U+LBIrLCKQcMEIJjrE/ZoqlTGqsDhRqAaVJiZAbFHv2aeh0CZj8Z0m7obVTWd3su5wg98Jh5LHeN53g50DdyILlyHBzQkS1xAalWOXx0HJikJXguGSwmZJrKxTKkIuuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3PeElY22RNlUbrk/8SqZD3nfCyUfuwH+IZSWjTKUv0=;
 b=aoHY4/YoP7U6QgD7TwmqONsrqAT5PRljvGz7B3MYZFYVAjuAEif33/cFAHZqDZwB1QZkDvycN6uxAHU/LxhH5adGHKTwJeRGiX9NwU6we6AC5i+Z04+dS/QUddHie1z9P4NZQP7Kfmrw3kc75+Eo2+R5kK804zkuFibhlMNeq/Y=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB3753.namprd10.prod.outlook.com (2603:10b6:5:1fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:26:20 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 17:26:20 +0000
Message-ID: <f5e41647-48cc-48d4-984e-158e4b8c48f1@oracle.com>
Date:   Fri, 29 Apr 2022 10:26:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v23 1/7] NFSD: add courteous server support for thread
 with only delegation
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
 <1651129595-6904-2-git-send-email-dai.ngo@oracle.com>
 <20220429141620.GA7107@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220429141620.GA7107@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:91::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02650638-1ef3-48aa-236b-08da2a056015
X-MS-TrafficTypeDiagnostic: DM6PR10MB3753:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB375326E28FC741FE5AC9A1C387FC9@DM6PR10MB3753.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huVbIjkNOXUzDFKLaI489+An+ejoZXYHS8pU0Lw7CiWf6J1S4Mf+WVbvVv+GPqNjJ89f3fk43G8WN06DX5R38b9vBVQzC98eI13tcWzrQ3PeA894MRsODMx+souLetdyfvz9zQtoW+VhIji0XhcJlie3PM4cm+nAJczNgHoQhxb73C3zChxT8ZDS7MKEeSowqbeCFh9kWP3RrmPa29KQcnB2NnvHLYqcvXTZZAM8WX4Al7q6nf4S6A0lxIWMmQWg35zZdmpnpycG8cKQtI9SnCF1l5OhwITh2JEFf0vTT2Q8g4lVY7txLhfcyYm0TOHkdpEmceMOIIzxyqLfs36Pegt74P1SEc1rpkn6ciZqvQfbBPzesZqkFbzkTeoRcupZcK1clQsjG2BYPXSfNjkNeoahKl9pBVxZcv4Kk43fANuBYLQcogLrpDx/cbRni4a1whxdbPGdbdigy/5qiu0LerjYP3oGFW+l/ZRWa5al05zbEviV6m4izYCj0Je4Yf9wUrWriMgPJ+hSGqf9xOgKX0rmgRKyxfOSSUYoinNnI3w1+L1pq/AsCvLJuZOlcUJPrQqRGRk/2YwsnpGH1WEFv51vhmPNONt8UjzFN3B0wLvysupznNka1iOZXRMdu5w5r68nw9aSs7RqyM7s3CsZuaAeka/ASjrKHL+LlBANMhnPSsGHQt2oKh2M096W0xZgVCvRa4ClmDQRnwnANiKumA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(38100700002)(5660300002)(6666004)(6506007)(26005)(53546011)(2906002)(31686004)(9686003)(6916009)(8936002)(36756003)(2616005)(83380400001)(186003)(508600001)(86362001)(66946007)(316002)(31696002)(66476007)(66556008)(8676002)(4326008)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1VNSzk2eGZxdThpQWtWUzJJWHU5MFJ4L2pFMG5QMmNQY0VmUElIcTlDRDMx?=
 =?utf-8?B?MFlvcENqcS9vZWhRMnBxOXlqeVlieWEvdjlPQURiUjNxNmdnbk5kSG5kbGlp?=
 =?utf-8?B?V2haUE1Vb2t3cG9VMXdhWU9ITHFVTFBtcG5pdnAyQjVLdEV3aFJNTk9yUDNn?=
 =?utf-8?B?UjRGajVpbGZic25EdHZDY3VBYWRyc0ozU2VBelI0VTZZZlVPRFY3QUxaU0hP?=
 =?utf-8?B?Q2JRSlE2WFZKMHM1bUlidVZYdmttS1hHQTRtZ3lSdDREWDNCQjZjVm1yQU5p?=
 =?utf-8?B?amxjUjByQXNVaFRPdTQ2U2twUCt4UUxzV3lNTDMycWwrWERIc0I1MHRwc0hQ?=
 =?utf-8?B?bWNmbmdIZ0NZR1JtbitxRW92ZlgzRUo1Wk1TcmRxM0pGdXJXQ1F2YjFkUXA4?=
 =?utf-8?B?bFNLZ0s4SGFJakJNM09pRXBVV1BVODRZTHdUWUNZcVVoa2IzRU1rY1RHTjNz?=
 =?utf-8?B?Nm5GYUZZMHAyZmlPL3h5QzBDdEI1WEZTanpZZEZscmxBbTkrVDh0TjJBYXFx?=
 =?utf-8?B?QTFjVEdkWUZxVEpiWFV3NlZYdFh3Mzk3VEFzblF3ZXNBNk5Yc1BmUlZGd1RD?=
 =?utf-8?B?U0xYSzNlVDNzQmZxbVNBQjdmQUdPY1dDdy9JQmdhMlZYVktnbkM4NmhJMEdZ?=
 =?utf-8?B?L0FtRVJkaG8wQllZNDZLb2ltci9OV3gwWWliWnA2dEoyaEhVQkoya1JZWVpZ?=
 =?utf-8?B?aTlmMGZCMTgzLzNpek9TRDdqMm9wck9SczNRZllRaHNLbERydFFqNkY0cnJT?=
 =?utf-8?B?dDZFc1M4RXhOTFdFc3pNRFBJWFFmbVpEQStrQ3RvZEJIcFZEVXZYMTY1Q3lo?=
 =?utf-8?B?U0xTdytZZmx1NExNR21HdkxYRzNKdnV1a2xIZHhIKzlkaTc4UURBMVRVd0pS?=
 =?utf-8?B?emdEQUw4dW9PemxmZGpSMXc5U0ozeFZYRGwzR3lqZ0JxZDl0azhXSVg5cXVx?=
 =?utf-8?B?OTVNTjZyenVWVG1lN1FWSjM2c0E0cXY2MmlmZ2tlMzhiNy9rNS8zbkwxQSt2?=
 =?utf-8?B?RWJRbVJQWGtOWTlUVHJHZGdDL3FJc2JtNGR2TXhiL2dUL0hmUG9ycXVxa3Av?=
 =?utf-8?B?aU1lVWQ2WnA5SldVdmtuSE9KWmdiODErcG82ZEZuT3ZLSDVIOVdDSWxjVkRz?=
 =?utf-8?B?d1hlb0VEV25YcFNGdWpvRDN3STh5UnFaK3gwZTR6dEpsOEJqVWNmRkxiYUZV?=
 =?utf-8?B?UlAxQVFMblhtMzhHblBlM1QzY1ZkbmI5SmlZdmRTR2EzbXpiQTNNMmZwOGtX?=
 =?utf-8?B?YlZWMTJMRlJQdXRJZmZSOWwxWHRBZkcxQkh3czdHMTBvM2pmLzJWVDh3ekpu?=
 =?utf-8?B?ZjVxTnBLb2xOc0N1bHRheDVrTlVTTjZmTTVURnBSbFlMUTZhMW4rTHUydCtv?=
 =?utf-8?B?dWpWZWJMME1oZUpRUjFFbjVmajd2aWpCRm8wcHZmQ0pLZXIvVXpWRU1SQ09l?=
 =?utf-8?B?M3JsLy9EUXdSNFc3ZFZNb25PNnZvYVFTZ3JhcnYvdmNOb1Z1NERCRHhzTy8v?=
 =?utf-8?B?S0d3cy9LcUxNbDVYdno3VkZ1L3JWNzkwcGZpdTBwYnZqY1FrdWVkQUtkWDNI?=
 =?utf-8?B?VTVndW0wZE90S1hMMjJrQ05jbkY3eVVCZW85bDFPZzZwUDhrNW5sYVcraEJT?=
 =?utf-8?B?SkRQUFFWS2F4bElZWVo4TWlqUFFlVWhJWm9jV0ZNa1daK2FKdG00d1VYUEFi?=
 =?utf-8?B?STlNcHA2YXRHeFpaVEVVUWg5V0tvRyt6QmJNcjF3ZUpja3JYakovN3Q2Vzcr?=
 =?utf-8?B?R3M4VWdiTEZHaVA1K29WUWZZa244a2dZZnhhc3Y0Unl0OWFqeEljR0duT05j?=
 =?utf-8?B?WC9JNlptV2ltTGJOQnpXZ1V6ekhBa2J4TldxUElCR3lZV2VzSHd4b056U3gx?=
 =?utf-8?B?ME5PS24yQVliT2pkdmc1YmZ3c1hZdUFCMG15R3ZkNGl4WFgydUVDN1JtSkhP?=
 =?utf-8?B?azV5YTEyWFczOEZPZ3ZIa1ZWendWMnBZejREa3U1NmVkTWhDckdpcE9Qdnlw?=
 =?utf-8?B?WmJXdm5BdFVKUTFMVFY5UTJtbllHT1JCY1N0TVY1ak1Nc2NqalR3T3lHdUFG?=
 =?utf-8?B?eTd6VFM5VHlWOW1hK1o1M3JYaE1sb1YyTUlQc2tMRld1akliVHl6bXdVTS9z?=
 =?utf-8?B?bGZhQjRYbEpvYVFtT3FrWVg1cXRmaWd3dFhLeFR5QUJCVEZFcFdWZ2FSaGlj?=
 =?utf-8?B?N0s5L2l6N0dRb3ozaDFwbFUwNGd2bU40cWVRQTVzY2VWTys4Y1IxOThaUk1P?=
 =?utf-8?B?MFRRckRvM1RMdWE3cDM4ZjJRSTZrYXhoK01EUFdZM1NvOGJ6d2ZQdmx5ZEhZ?=
 =?utf-8?B?ejZZa2ZOTTNmV0FCb3h5L2gzbXJZazREZHNkUi9YK2hPYU40MjFsUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02650638-1ef3-48aa-236b-08da2a056015
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:26:20.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaKc/+vajNspqquBz/MVsUg2BALE0ddkC0LvRRP/TK2073ZUbq3G215YG2jmP4WpbpKMCoZZikkT2qHve4rdEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3753
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_06:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290087
X-Proofpoint-GUID: -Enqq7oEdWpJVllqQ_qJgJ_AvUoJYlqZ
X-Proofpoint-ORIG-GUID: -Enqq7oEdWpJVllqQ_qJgJ_AvUoJYlqZ
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/29/22 7:16 AM, J. Bruce Fields wrote:
> On Thu, Apr 28, 2022 at 12:06:29AM -0700, Dai Ngo wrote:
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
>>   fs/nfsd/nfs4state.c | 79 ++++++++++++++++++++++++++++++++++++++++++++---------
>>   fs/nfsd/nfsd.h      |  1 +
>>   fs/nfsd/state.h     | 29 ++++++++++++++++++++
>>   3 files changed, 96 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 234e852fcdfa..b84ba19c856b 100644
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
>> +	if (try_to_expire_client(clp)) {
>> +		nn = net_generic(clp->net, nfsd_net_id);
>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +	}
>> +
>>   	/*
>>   	 * We don't want the locks code to timeout the lease for us;
>>   	 * we'll remove it ourself if a delegation isn't returned
>> @@ -5605,6 +5617,58 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
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
>> +
>> +	INIT_LIST_HEAD(reaplist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (clp->cl_state == NFSD4_EXPIRABLE)
>> +			goto exp_client;
>> +		if (!state_expired(lt, clp->cl_time))
>> +			break;
>> +		clp->cl_state = NFSD4_COURTESY;
>> +		if (!client_has_state_tmp(clp) ||
>> +				ktime_get_boottime_seconds() >=
>> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
>> +			goto exp_client;
>> +		if (nfs4_anylock_blockers(clp)) {
>> +exp_client:
>> +			if (!mark_client_expired_locked(clp))
>> +				list_add(&clp->cl_lru, reaplist);
>> +		}
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +}
>> +
>>   static time64_t
>>   nfs4_laundromat(struct nfsd_net *nn)
>>   {
>> @@ -5627,7 +5691,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   		goto out;
>>   	}
>>   	nfsd4_end_grace(nn);
>> -	INIT_LIST_HEAD(&reaplist);
>>   
>>   	spin_lock(&nn->s2s_cp_lock);
>>   	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
>> @@ -5637,17 +5700,7 @@ nfs4_laundromat(struct nfsd_net *nn)
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
>> @@ -5657,6 +5710,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	spin_lock(&state_lock);
>>   	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>>   		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>> +		try_to_expire_client(dp->dl_stid.sc_client);
> I don't think this quite works.  First, we're only looping over the
> delegations that have been under recall for the longest, and those
> aren't the only ones that may matter.  Second, just calling
> try_to_expire_client isn't enough, we also need to reschedule the
> laundromat.
>
> It's not the end of the world, we'll just have to wait another lease
> period, but I think we can do better.
>
> How about something like the below?  (Incomplete.)   And then you can
> check cl_delegs_in_recall in nfs4_anylock_blockers.

fix in v24.

-Dai

>
> Otherwise, this patch seems OK to me.
>
> --b.
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4f45caead507..23041584d84f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4780,6 +4780,9 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>   
>   	trace_nfsd_cb_recall(&dp->dl_stid);
>   
> +	dp->dl_recalled = true;
> +	atomic_inc(&clp->cl_delegs_in_recall);
> +
>   	if (!try_to_expire_client(clp)) {
>   		nn = net_generic(clp->net, nfsd_net_id);
>   		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> @@ -4827,9 +4830,14 @@ static int
>   nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
>   		     struct list_head *dispose)
>   {
> -	if (arg & F_UNLCK)
> +	struct nfs4_delegation *dp = (struct nfs4_delegation *)onlist->fl_owner;
> +	struct nfs4_client *clp = dp->dl_stid.sc_client;
> +
> +	if (arg & F_UNLCK) {
> +		if (dp->dl_recalled)
> +			atomic_dec(&clp->cl_delegs_in_recall);
>   		return lease_modify(onlist, arg, dispose);
> -	else
> +	} else
>   		return -EAGAIN;
>   }
>   
