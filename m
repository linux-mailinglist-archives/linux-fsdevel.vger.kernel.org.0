Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C29A563760
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiGAQGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGAQGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:06:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1807F248E8;
        Fri,  1 Jul 2022 09:06:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261G3HEc011298;
        Fri, 1 Jul 2022 16:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ekxWYIshII2uG7rFbkVxDnfj1gvv/y6hsHfrcw6R8Fo=;
 b=v80BxooYOEEo7eUXp3Vc2NmA/n6wuDnFTRtvwK0ac+NiAiteX3clgIG+cDN1rW4MaQ34
 J+VED2XyDKL1esKRvtcyOHmfcLVk05Hjr6Ha/Oc0c4Q0Y9StU4BSxbKeo6UCZ3VCoyZL
 tG7U3OeUNNe3QyAc7I4jhsm4+yfEQB941PObpw/FHWKvRzyQWlFzI7J0xtegJ9sjDdlJ
 7aJLf0LFqkgAKne4a4uNYsvlUrqZxQXnxglbX4Mm/lUUQcxOf/mUC9YeFnqijEhNl8dF
 ygV/nxkmdAQFMaTKHVjdPaKuwAX+i79v2LcQX7oEdX7rlVZBPK1/I+DL6iN1SONjFHKr bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52qm0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 16:05:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 261FuV7d003649;
        Fri, 1 Jul 2022 16:05:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt52hfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 16:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0fEa3Y3AulrAUCxnkmU091I56+FZGEHYeAEsEUZh2gpAQWhYT2lD82MIsG78h5TchVeIiYBRBb9LiNjvsSutQbQ7LVwYXfSi3vQ/6rzOKIP77ax0XtfDMmmauVLXLmZswe26FgfX3IUH64/tfYxlkC521cTNzZPHTb5WSFLXuWsgR0hPuiz3dBUZoTPJneU39WoixnSA6Qz+ESAWcvMeL0X9b+ysdd5DuoT7ilurL7vHSiRHZFny8Lir8+gShfKH/ZeAEENWbsDmMNWW0oJxPH7kpcVTkcibEUTbpjZK90O7eBulH6dUOnFIVZS2iX4d8RcctB31SYwhscsvPvpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekxWYIshII2uG7rFbkVxDnfj1gvv/y6hsHfrcw6R8Fo=;
 b=ZKLK7CkdbV/h16gSxMgzCdax9oaqajWX7NfKRDHGf/CRK918CLmfejSILPTLyavOhL8cXC69KgAAzS0ZhNT7rFiIH24Xp2CobfqN4OMC7eMd2iOxexmeA9j38EnmUX6XUYfvgH9tAy9kZ8HZlbKSYOEL/H2Lrdl/7BGNFzubsifvuHd59SVRlZskuTsiuGwtVGRuGisPT58IJG149lmujrkogqCG1cxYAC9/MFymduCcSlgugOnBvAr/kVF0oKN/dRZoDhZg4lm+7JXoYp/9pTMns/9hz06XKRRgoPvxyBF8C1OM3gyQNoE7Qt++lsrw74qZHM8HBdMW6JWOy35sbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekxWYIshII2uG7rFbkVxDnfj1gvv/y6hsHfrcw6R8Fo=;
 b=Clf7ZP2+qrV40o9T2A+IO/VZbT/biUY1kaj0OnN1plWZZiJ5yvozWzqMKX8NlYOFHA2POBoq6MM2xxS4LbdsjDahxBBwLUfq/aNGyUFevw6XNnW+x188xIYvxdBAGXq1Rsn+tC8tzprCxG3RIjclmL6b7Z9+hPnAeFvZdKPbnSI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DS7PR10MB5975.namprd10.prod.outlook.com (2603:10b6:8:9d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Fri, 1 Jul 2022 16:05:18 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.022; Fri, 1 Jul 2022
 16:05:18 +0000
Message-ID: <9a62cda7-d9ee-3456-8b41-0423db33a62c@oracle.com>
Date:   Fri, 1 Jul 2022 10:05:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/9] mm: Add msharefs filesystem
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <de5566e71e038d95342d00364c6760c7078cb091.1656531090.git.khalid.aziz@oracle.com>
 <Yr4bREHJQV0oISSo@magnolia>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <Yr4bREHJQV0oISSo@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::12) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f66d57-9311-4f43-6e9e-08da5b7b7dfe
X-MS-TrafficTypeDiagnostic: DS7PR10MB5975:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOUqZt6ngj2VNZZfqLyz+FpWnyb5hAPDT30aMqTOIBxgBOgy8YvbB1S5k7ivks8bpkuJ2IatuplwvAF0kM/J8HEmyfqXUoP2jBrifPm1C8FnhUfBf4YmXRSmZEHqJWA87aX5uKwF+34x82UqDbXeXQ5hX4DVTFueJfMNTBZvAG9Gs2ZQWmJyD0MpqurslUKK7QVJRewzKmRHoiUCwrucR5CtMBSlGwYxDDe9sy4hMaXYSK8UEiUYO3r3cZd2dsC2YIFjQVc8W/mWAyfCUucSH0UIQUOVxo5XT5JZJJG65qk4pxnKrniBaNXHlw1zr4n18QgKa6fpTGfzJ/rCJHq1A8Y8PmoAsb91Ta8nUlrkZSYWSCb8bHhvW041Kvrj4Om8jqn+d1dEFYOM1OSiwZQyvgcA2K2igYkQHXPVdCptsYtq+RdJQxM7ZSMLN0Mc9wLDnyCTdUo0X5LCYmVLsXmQn9NgyuC9RozkXzMONx+9ovspEn5z0IRusBVt7Xeh1jni7BhGadtcj2KOmdkYEv3DyGiHqLgIoHihZLtcIPa3GoXFPtoAjSv0qPFgjmDekpdc/sLiQ3s0/n7BTRPc4vXxEx40d9iWSjwc0B5f+1DJ/sqBVghsfrbSTlnYf+4OWj7bG6RgnMIWaAAVzPwxeSayyYiotHJ61w2AyixJTSiBwd8GZrSD9i7DBM8fRFkPeeJ2un8KA+tMTdYtN8VmkiEBO9mpwk62r5LcpO3mWDrav/+zhJy/T+rfJjMpOjfXQrxxZJU24h5LHXc8I29foVBxn0QUheMGnQn8/OR0ylZLNDAUAXd+FfaEcgt+UVvCd5DGESewaFROzrXF7KmM6vL8kojQIM4/AugJkyzX4a2fFLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(396003)(376002)(366004)(36756003)(4326008)(66556008)(66476007)(66946007)(44832011)(8676002)(5660300002)(83380400001)(41300700001)(6486002)(2906002)(31686004)(316002)(6916009)(31696002)(8936002)(7416002)(478600001)(26005)(6506007)(86362001)(53546011)(2616005)(6666004)(38100700002)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnhRK0ZBZ1JwNXlXK25wTUo3MmVXOUNBTkxxNFFxanFBWkVaUi9vZGZGbmNP?=
 =?utf-8?B?TzJ2b3dSMEs1OVJXVU1OT25KRFRwdkZzcjFNL3VaZUpEVko2ZktaSjZxVHdm?=
 =?utf-8?B?QW41cGFOVmwwYVd5cE5qaHZueUcwYS9CMzRBZlg4VXJLMDdERVc5RXBhaFhx?=
 =?utf-8?B?TDhTdDhqYmhnRVU3UFBmcmFoZThHN0hCNXUyQlZPSzJRVnJUVVZUQUlwUnZi?=
 =?utf-8?B?QVkyRktsN3ZBWnpJZVhocGlBTGtBa0VKQ1FBa1JFZnB3cFQrcFRYMS9ocDBu?=
 =?utf-8?B?cE1sYTY3NGRHM3lDejZZNStHbjdMZGtTWUxqRTB2QnFPWFgrMysrL09JVWlP?=
 =?utf-8?B?bm9tUEI0UnYzRHBvMExBVi9FVytsTUZhMHc3ZXNjeXhqUWM2US9YZWwwdWZ3?=
 =?utf-8?B?WldxZm9LMlgyeEtwVHFGT29lSzloRHlZdEI3V3JNOFZhMzYwd0w2VG9sVUxx?=
 =?utf-8?B?WkZqNTZqMno0b21pVmt3S21XU21haHBlanBLQVB0ZlBSS0U1dVRDTFNoY1ZW?=
 =?utf-8?B?YkFjYTFEUTgybU00SVhMRkVMdXptU0c2aGQwVmJsMk5BVnFzYStCQjBBQlZQ?=
 =?utf-8?B?MVFMMXB1T3BVdHhLVGhBQk9EbnZValhJak53VWViaDNFQWJaa2RabUo1N29X?=
 =?utf-8?B?R2xLbTAzWnBJZWszRjFRa1RxZFppL1lvdnlvQ2p3NWVuRVJmc2w5NytvYm04?=
 =?utf-8?B?T1R1bnBOUHN6OFN5NGNPMW5LdFdFS1FxZkplaXk2Sk4rb3NjWkhjbUFPNTRE?=
 =?utf-8?B?bXlmU1JXdklSakhjcjdMSWxaMVNJdzFPSllPRkJGWjNORmZBV1EzNTJJTktl?=
 =?utf-8?B?ck0zY1UxU0FJM3dVYkpidk1URlhIcERZcDM4azBrbTNoSnF6amloYy9WbFVJ?=
 =?utf-8?B?MTMvRGFiUlBLNENGVndDNHcvQUswdW4wQ05TTFNwdUVsY2dEMjBySUt2Zklm?=
 =?utf-8?B?TUpNTkU5NG8wb3hSdzN3dVVhRmxRNHZnTy9BTTJFeE1TRkYzQkU2bVZCcnlk?=
 =?utf-8?B?NGtpQklKbGxVMmE4MjdsVExRMjI4dDlVUEhMTWFSamRrbkJEc0NYNEJienps?=
 =?utf-8?B?VzVrRWZYb2FHYTRaYUgzK0xSUjMxR3doOWJPM0s4b1pjR0QxOUVMRFpWaG42?=
 =?utf-8?B?R2tiak5qZ210b1hqNHNsUGM0VFJZUDB1elgvbWtBUUwzZzhEZk5keHFkc3B4?=
 =?utf-8?B?RnlXZGZtQUJRUzN4YUs4NjFTYXFoUXlNR0l5ZWZKb3pPWXhMSGRtbk9aQnV4?=
 =?utf-8?B?Yys2QXVWZWZjUjlxWFVETi9qNHEySmxhN0FyNWlDUVU0WVJRTWVhK0d0K3Nk?=
 =?utf-8?B?T3UvQzVMcFh3SVNWdW51VVpjNGZUSERqa09OcEIwd2xlc1h4eGNaNlZvZGk3?=
 =?utf-8?B?QmVPZEdzQmtLWWtVSjRRRTFncmc3Q1dsYmtXOEJvczhFaEVJekhCUmEwWC9B?=
 =?utf-8?B?ZStJSzNkcmEwcmlvL29lSVJPVy9XM1B3UTlab2xmeThNb09kSUxSQmFLMHEy?=
 =?utf-8?B?b1JET3ZDK2dHZmdpZEJoS09naGFtQ2tXdjlXV3BNeWtQUlBHQkdWbk9YVGVW?=
 =?utf-8?B?a1htcEJ1N3hzWXArejdFOHpoSklUWXdsdUEwdFlJR3IzRkh6WHNvUC8rbDRh?=
 =?utf-8?B?NEdBOWVOTWN5cVdrK1FXQ01qMlh4bXlEek9ick1LVkk0TDVLQlFFM0ZJcXRw?=
 =?utf-8?B?YWxtdWk5c0pNcmorUTZHUk81R3lialEzY2E4MStDdXRwakZXaC9vYmcwUTUx?=
 =?utf-8?B?UTVtTjBwYUlNQXJiVmZuK1RCS2pYelUvMUNEVk5WUmgwWXVGWG1ZOHVwZDVj?=
 =?utf-8?B?UkI3OFRkNktJMmhETUtLUXZuSnhQRG5zRHpTeS9LU1hCNFE0cElUMHc0cDVI?=
 =?utf-8?B?T2tTK0pQaGthS0tiWUU0cGNFSDJLTWdsVk1nK1NleXJ3aFBOQmpzLzRBaUZi?=
 =?utf-8?B?dkI4eVJyUXMyWVQzWEEzL3B2ZkRvcUhlTEVzU0E4QTlxK0tseDhVZml0Qzhr?=
 =?utf-8?B?bWNMVEh5NEgwc0ZMMDI1NG9vL0NvS3NMMDI0bWsxVmRmVTJQbm55cmlFQ0gr?=
 =?utf-8?B?bHhRbzVickg2cVhnZEpHbDA0Y1BETHpBMVo3RE9yZDNSNlY1eS9QQXFsT0Zk?=
 =?utf-8?Q?2ized4kJDrTudzDRjHtZnZ0xZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f66d57-9311-4f43-6e9e-08da5b7b7dfe
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 16:05:18.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P16A7jTuF/axdbfTL1eOovPeyr8NGLCHDZ7AMATpZov5ktZcFqLSCM3oaccXUMO9aqCgtU+PobAqFt0eT6Yp3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5975
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_08:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010063
X-Proofpoint-ORIG-GUID: ZOzJjfeAGhG_VNJajNbO5cZDByOFpWoR
X-Proofpoint-GUID: ZOzJjfeAGhG_VNJajNbO5cZDByOFpWoR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 15:53, Darrick J. Wong wrote:
> On Wed, Jun 29, 2022 at 04:53:52PM -0600, Khalid Aziz wrote:
>> Add a ram-based filesystem that contains page table sharing
>> information and files that enables processes to share page tables.
>> This patch adds the basic filesystem that can be mounted.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> ---
>>   Documentation/filesystems/msharefs.rst |  19 +++++
>>   include/uapi/linux/magic.h             |   1 +
>>   mm/Makefile                            |   2 +-
>>   mm/mshare.c                            | 103 +++++++++++++++++++++++++
>>   4 files changed, 124 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/filesystems/msharefs.rst
>>   create mode 100644 mm/mshare.c
>>
>> diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
>> new file mode 100644
>> index 000000000000..fd161f67045d
>> --- /dev/null
>> +++ b/Documentation/filesystems/msharefs.rst
>> @@ -0,0 +1,19 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=====================================================
>> +msharefs - a filesystem to support shared page tables
>> +=====================================================
>> +
>> +msharefs is a ram-based filesystem that allows multiple processes to
>> +share page table entries for shared pages.
>> +
>> +msharefs is typically mounted like this::
>> +
>> +	mount -t msharefs none /sys/fs/mshare
>> +
>> +When a process calls mshare syscall with a name for the shared address
>> +range,
> 
> You mean creat()?
> 
>> a file with the same name is created under msharefs with that
>> +name. This file can be opened by another process, if permissions
>> +allow, to query the addresses shared under this range. These files are
>> +removed by mshare_unlink syscall and can not be deleted directly.
> 
> Oh?
> 

msharefs.rst needs to be updated.

>> +Hence these files are created as immutable files.
>> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
>> index f724129c0425..2a57a6ec6f3e 100644
>> --- a/include/uapi/linux/magic.h
>> +++ b/include/uapi/linux/magic.h
>> @@ -105,5 +105,6 @@
>>   #define Z3FOLD_MAGIC		0x33
>>   #define PPC_CMM_MAGIC		0xc7571590
>>   #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
>> +#define MSHARE_MAGIC		0x4d534852	/* "MSHR" */
>>   
>>   #endif /* __LINUX_MAGIC_H__ */
>> diff --git a/mm/Makefile b/mm/Makefile
>> index 6f9ffa968a1a..51a2ab9080d9 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -37,7 +37,7 @@ CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
>>   CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
>>   
>>   mmu-y			:= nommu.o
>> -mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
>> +mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o mshare.o \
>>   			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
>>   			   msync.o page_vma_mapped.o pagewalk.o \
>>   			   pgtable-generic.o rmap.o vmalloc.o
>> diff --git a/mm/mshare.c b/mm/mshare.c
>> new file mode 100644
>> index 000000000000..c8fab3869bab
>> --- /dev/null
>> +++ b/mm/mshare.c
> 
> Filesystems are usually supposed to live under fs/; is there some reason
> to put it in mm/?
> 
> I guess shmfs is in mm so maybe this isn't much of an objection.
> 
> Also, should this fs be selectable via a Kconfig option?

Since this filesystem is meant to support an mm feature, I felt it was more appropriate for it to reside under mm/, 
similar to shmfs.

I could add a Kconfig option. The option would be to enable mshare feature. msharefs would automatically be enabled when 
mshare is enabled, i.e. msharefs shouldn't be a visible Kconfig option. Do we see a reason to make mshare an optional 
feature? If we can base hugetlbfs page table sharing on mshare in future, this will not be an optional feature at that 
time and mshare kconfig option will have to be removed.

Thanks,
Khalid


