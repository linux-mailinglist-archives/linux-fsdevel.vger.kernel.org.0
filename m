Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E70563746
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 17:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiGAP7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGAP7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:59:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A9813F8A;
        Fri,  1 Jul 2022 08:59:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261DC0Yr012655;
        Fri, 1 Jul 2022 15:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xW+sPwPV7WXJnJLuq5+k2dk4qgZKNSy+/KSuhSOMPBY=;
 b=zzZ0flAOouUvDKNt1+xRvvIkWgWf8NpyPOeiX4IBsBHOWXZvE60qreTC82tuzq/EKWTQ
 3y5y7ppDjuW3sBLnYI29EbLp+/WmobioujkJLY9sMXbip2KpveXF4qfYcbPdIJWB84vd
 DufodKJKeY9W08fKl4OWEdVmedeg9xY0W/Vp0yzrpnX3G7iKIB/bEPyzr1A74GAt3PcB
 bYJZUAJsRzM3RSKUT7QPRu+38ybcxBZ4qQg84EBdJDN79VDJ6jkS2U5VlzaFyPJHTdhn
 RUX+It3uE3QWp2tX5QALwVvYhi74+gjYu/PJiEfULwkFXQxoTalR4ILRm25y8FyJ/Kus YA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwufq7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 15:58:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 261Ft2Ba017231;
        Fri, 1 Jul 2022 15:58:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt59f0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 15:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cc5A68jHelqf2sYNna1f88OaceGtq68TPJvqL4NG4XmU5Pvk8wNQcojhtQ6Uyk6fK1YSRmSJ/5qCoPLHJLW5718u9SqNg40km0yBU3h+shG3/n/cDtsLifIYkn261yIBtzaEDuQSxxNOohQiS6kcxRdvgDUF8xZyDyxGSFzD5WWLrVjeLSmU9L3EKtfVnnoR9zDW8L8dtFB7eZ0vNuprdsuwaxM1jmAgjNlT2YHEdTf8sKk82I3lyTUMxnczhr3MA0ThbvK9UnMYM7F5pfeBDvC4VVJZyIJ7Kzo0Vhb7fV6PswsKmVxTz6NXq/5KosTwTd94afude4iTudsuFoXruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW+sPwPV7WXJnJLuq5+k2dk4qgZKNSy+/KSuhSOMPBY=;
 b=jBIowicft6ZzBMG0BMExbOCp1TzxDvJ6VYdrAAAAQPpsohTq4IZJv5aFBYEKm4Ip35ruJWBne4GX1SJf8Em4ymRmuAcXyXNx3l2YpRcSssM19DfHnPgI0+CQyjdW8QHfQgnGP1KYCA4m1WhRkH+ZlTgFsgar2rS/FxTlPf19xbHvewsTpxIJW4D+vQl0Ky2yijb9LoeDfPLolS+tgIHL9+YSEZ32V0axpFREvDiYrwptF9ZXokbzmNhIvsx2BYjVoEQGa1uSQWw+1IpbwXlDRHC7Hd6f1J2H7Es2bWF6yk3IQs/LFH5OJKvMZeAHhKXH3mUJncsATF/EGkwIfNBzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW+sPwPV7WXJnJLuq5+k2dk4qgZKNSy+/KSuhSOMPBY=;
 b=FgU1ty7vvFoTKsGofPqnyl0ks5IIG/RsnvRBcladyxLd5wb7EaIS8IQwj/UXfbXirw6hWVnPRih7J90zI3MFxuxyc79300ZG7XOfCBQWKl8gqcFrUhR4Lda7rYq7qpwpn6nvmTO/EtzDWcK2QCH5sXGZ2vmlMTTJhvnGAYsjfPQ=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BYAPR10MB4103.namprd10.prod.outlook.com (2603:10b6:a03:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 15:58:20 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.022; Fri, 1 Jul 2022
 15:58:20 +0000
Message-ID: <a9fb9c9c-32d5-1b8a-f4f0-f97394b6f621@oracle.com>
Date:   Fri, 1 Jul 2022 09:58:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 7/9] mm/mshare: Add unlink and munmap support
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
 <1b0a0e8c9558766f13a64ae93092eb8c9ea7965d.1656531090.git.khalid.aziz@oracle.com>
 <Yr4amM9d6HpwH5BW@magnolia>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <Yr4amM9d6HpwH5BW@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::37) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4c5a156-ad7b-4e6d-5960-08da5b7a84fb
X-MS-TrafficTypeDiagnostic: BYAPR10MB4103:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xrvkAUeLZD/OgHrGq/d8/BfxOO9vmB+5rMg7NsFPsRCRVi/5GpF8Tx0MWwIfh+ko1Tp5e13vpcPKpODaB0xgxu43kzUKTmNMr5s5VPggO5UK01dCOS2GVez4zaiRp5Y2+1f6ff0z0EicxJQL5tXNSbn3X9pQlPR00ip6hoITeBqGBdE3aRqAX1w/pOORF5Dygv7d4QMTGAK6/jMmE+0FPQgl3GUUl8VC+5LqizOPYUDkeobJ9jaP2nc0ZOiMTywp2N24SsT4Jc6uztI+T2RlREGDBQio4P15D8GNIx3lqTC0tYV7lHCJX2O7RNaFYZzqdAbxutHHmKM+VClZAfAEJYh19ofw8X157c4ZzYtchF7lLh9kTK7BFjNQ4EtIX0csa44JZxyvZ0LEqjgmwmloVvT19GPk9V5vxq1jLRmbV3Sq3LgBpUO1UE81eswbbDM2FM9zQMx8hVftYNDn6HJt97hcJ32ETEo03X0ig8EyrFVhjvFN8SajiZ6labgGMAVHuAisJGYGhigMSjIRNNvIdiXTTk9wagMhWglbNBCqHg6Hbvz4mc0SKdHzGAcSJvU+0wGwl74KcaqP5XbuttcFHUkAJlJehBAZ6vz2egXbK8/LUf+LSt1tUEzCOPbyI9wnhGBDW5uMGZakgnApZrguEDQxJ2B2imjixwwsNih3qdUgZRPeWuJiAtrkuSV598GMyuRl8vf+muwujAhlf3A6KvqMxHd/4LhqkUdO8Nnf66hlPxMYm+MOAxiu1mDem/oe1TMQFyNQlcJ+noqQ6JzcptAHv4fguy5qhu2vnHLvZD+VkqmNpWYsJqpwOvRI4jYINnr4aj4aJX7ssSP4NC/Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(39860400002)(136003)(396003)(2616005)(31686004)(66556008)(6512007)(6916009)(53546011)(4326008)(26005)(8676002)(66476007)(66946007)(36756003)(186003)(83380400001)(6486002)(38100700002)(31696002)(6506007)(44832011)(86362001)(478600001)(2906002)(316002)(7416002)(8936002)(5660300002)(6666004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjBDMS9vNHBGQXN3WUJrYlFOOHgrci9UL1pvUXBLS2p4Um41TTRPdXdQeXZG?=
 =?utf-8?B?Y2J0c2VsK2NlcEVjV3JnRTNzV1kxaGlXZXMyMEU3czc5Z1IwY3RuazlWeThP?=
 =?utf-8?B?SFV2aWdNUjJ1THRKbVpZbXNLOHlmNkZyZWljL1BTQzZ0K3V0QmU5UW96SzE2?=
 =?utf-8?B?aWVLczBpZVFxUkFRdVJodWpaTkcreUFuSXNXYmhMK2kyWXplcUpXVmcwbGtD?=
 =?utf-8?B?cXpjd3JHMFlJLzlMblhtS2JUeVo4VDl3bll6RzNxNzF3MTJJN1ZXaHdiR1ho?=
 =?utf-8?B?a0hOUGh3Nm55bnR4SVE1aXlWU1l1MnRLNVA2Tkh2M2NtUjhjWVlid080RDdM?=
 =?utf-8?B?ZUgrNU1oajU1eEJSL3lwWGpJMFVHNVVmTURkS0xZTENqemd1cXZOV2twV3h4?=
 =?utf-8?B?VzhQK2tWQUk3OWJvNHNRSmlyeGJrT2RpTE1URnhLOXdNejFIL1VrNWtuOXRG?=
 =?utf-8?B?MkYxeUpFTGViUWx1c3puSXMvdUVTajBHS3BZT0ZjSzJCcmROZWQ0cEp3MnB1?=
 =?utf-8?B?bUlTUFFRK3pnSTQzTk4zQXBZbzVYTU1UOTdaTVBCQ3ZHWXE3YWFpak82ajRV?=
 =?utf-8?B?WHZXTE5QS2x1RHhHZlhlVUc5cGRyb1hzSmI1WTBaZS83a01GVFlHVXFhNW5u?=
 =?utf-8?B?UWU3ODQwdlZ6bkNqMVN1VmxuMHNkWWJoekMyYjlQenpFSys5NXJiSzdBYkpZ?=
 =?utf-8?B?ZDloa0VLQjJWQTNhL25JbHdMMy8zc1BlaHc4dkR3TEQzRWc4QllTZ2w0NUdR?=
 =?utf-8?B?RjRHV3FEaUdQdTdaK0Y3eVE4ellVNHpzUFVhOEs4TXdxUWtzL3VVWUNsZE9N?=
 =?utf-8?B?UVRETk5xT3lzUlJsU2pZSlEyd2Zva29JdkI0RW4xMGtCMEFmaElSZFRtN1RL?=
 =?utf-8?B?R3M2SjFxS1FHNUo5TnJuNzl5ZWxPRkh4UWZqYXdoQ1ZzWVFyZWdkZHRsR1Mr?=
 =?utf-8?B?MFBuYytYcW9aNDErbGlGelJ5ZFQ2SGU2bEVNaWZkd2NyZ2ozVldJQ245VlBk?=
 =?utf-8?B?M0hhdFJEaW1HNTVUNi9XOEZyTjBYMVUxeUdlb3QwYUs2UWVPM2krZkxoRmNK?=
 =?utf-8?B?eTFyRWxXaTBTcUpydjlMcFRmYXpTMWZuMk93ZnEwWEFYMkEvS2ZieWVpaWd4?=
 =?utf-8?B?K3I2RXZENUEvanVUSVlod21KVUVFcHE1SDcwZWZ3RWtkRW9HZldnMU1KblFh?=
 =?utf-8?B?K1FiYll1YnhHVVNvVzlJVnltVEJiTnF3TTM5My9PTG5ZMFdESmd2ZEVzc0hL?=
 =?utf-8?B?dFZrcGtUczA1SGxCV0NKdDlQcUJyNDV4bmlhT0FYYjgvaWs5Zk5hRytnMlMx?=
 =?utf-8?B?dmV4bThQTDVoQTVYSDhZTmszZWcvcHZISUozRlN2RzlTb0p4bGE1TndOQWIv?=
 =?utf-8?B?Q2lpOHdqZTg3bTdrdWNLMk9YUCs0N2NLZjRUM1E4a2ZVbDFudHZxam5MQUpu?=
 =?utf-8?B?R3hQaldLbk5JS0R1akcrY0Mya0xwWHNBbHN1U2kyU1FxRXpWT3lHVVRQTFZx?=
 =?utf-8?B?cDF2QzhndTFLK2grUWlVQXZYNU8xbVRHT05QTk9GU1ZPa250VmV1bi9RcUxR?=
 =?utf-8?B?akFGZUMyRmlucnhuQmxtZDV5TTJCNW9RSFFUOExkVUEya2FrUTZueWpseWE0?=
 =?utf-8?B?WEZ1and3NTFWbEZRSUVEMmd0L1ZzOVgvQzZHOXZobXlBTGlqa1dmTVExZ0tD?=
 =?utf-8?B?M0VQSmc3ZXlYRXJXd3prNEdSNHpXaHZVNzI5YVduNGdlWDVzTVAzQVYzWlBl?=
 =?utf-8?B?QnlqVGVITmVqOFhMVCtFdTdSck4vWUdtVlVUOTB2UUZqNkdIa3p3MUwyR3pj?=
 =?utf-8?B?N2cwRGpmbU53ZmR1eGIwd3NLcFFoSXcya3g0U05BR3BZWGkwTVlBdE5IS2F0?=
 =?utf-8?B?ZnJTRGl6R01BeWZkSmtKZTdMUk54Zmc4c0g2dFNZbnlwcGh6aWhMTnZLWFkz?=
 =?utf-8?B?YUdmL1NqdGxQeDRyaFIwMVRSMGppOVFQVUdCSjgyTWtRNEVpMWRnajdEdjZT?=
 =?utf-8?B?K0V2K2I5VTVlb3J6c2hZRHUxeHB6VitOczZza21PZHB0Mk5aYmZiclUybGlU?=
 =?utf-8?B?R3FYTG1uMGhYK29lNXZKNXFWNWVGYUVnWWFYSjE3RVFwaTJxVUhuOHAybTNC?=
 =?utf-8?Q?+VVbVyl5XbO49sX2gcG+zF4Q1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c5a156-ad7b-4e6d-5960-08da5b7a84fb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 15:58:20.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaEUW1lv7dWV0b1W5R8L/iQJ5yJDtglGfiUFaozjupoxAPVkp69ZgNYDfz1ED2HuxdSmm4iDkZikMSHNaNB8cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4103
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_08:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010063
X-Proofpoint-ORIG-GUID: grHj0HpwV9WKz1KhU3NC7gC8SGAtkSaS
X-Proofpoint-GUID: grHj0HpwV9WKz1KhU3NC7gC8SGAtkSaS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 15:50, Darrick J. Wong wrote:
> On Wed, Jun 29, 2022 at 04:53:58PM -0600, Khalid Aziz wrote:
>> Number of mappings of an mshare region should be tracked so it can
>> be removed when there are no more references to it and associated
>> file has been deleted. This add code to support the unlink operation
>> for associated file, remove the mshare region on file deletion if
>> refcount goes to zero, add munmap operation to maintain refcount
>> to mshare region and remove it on last munmap if file has been
>> deleted.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> ---
>>   mm/mshare.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/mshare.c b/mm/mshare.c
>> index 088a6cab1e93..90ce0564a138 100644
>> --- a/mm/mshare.c
>> +++ b/mm/mshare.c
>> @@ -29,6 +29,7 @@ static struct super_block *msharefs_sb;
>>   struct mshare_data {
>>   	struct mm_struct *mm;
>>   	refcount_t refcnt;
>> +	int deleted;
>>   	struct mshare_info *minfo;
>>   };
>>   
>> @@ -48,6 +49,7 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
>>   	size_t ret;
>>   	struct mshare_info m_info;
>>   
>> +	mmap_read_lock(info->mm);
>>   	if (info->minfo != NULL) {
>>   		m_info.start = info->minfo->start;
>>   		m_info.size = info->minfo->size;
>> @@ -55,18 +57,42 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
>>   		m_info.start = 0;
>>   		m_info.size = 0;
>>   	}
>> +	mmap_read_unlock(info->mm);
>>   	ret = copy_to_iter(&m_info, sizeof(m_info), iov);
>>   	if (!ret)
>>   		return -EFAULT;
>>   	return ret;
>>   }
>>   
>> +static void
>> +msharefs_close(struct vm_area_struct *vma)
>> +{
>> +	struct mshare_data *info = vma->vm_private_data;
>> +
>> +	if (refcount_dec_and_test(&info->refcnt)) {
>> +		mmap_read_lock(info->mm);
>> +		if (info->deleted) {
>> +			mmap_read_unlock(info->mm);
>> +			mmput(info->mm);
>> +			kfree(info->minfo);
>> +			kfree(info);
> 
> Aren't filesystems supposed to take care of disposing of the file data
> in destroy_inode?  IIRC struct inode doesn't go away until all fds are
> closed, mappings are torn down, and there are no more references from
> dentries.  I could be misremembering since it's been a few months since
> I went looking at the (VFS) inode lifecycle.

Documentation (vfs.rst) says - "this method is called by destroy_inode() to release resources allocated for struct 
inode. It is only required if ->alloc_inode was defined and simply undoes anything done by ->alloc_inode.". I am not 
defining alloc_inode, so I assumed I do not need to define destroy_inode and the standard destroy_inode will do the 
right thing since standard alloc_inode is being used.

Are you suggesting per-region mshare_data should be freed in destroy_inode instead of in close?

> 
>> +		} else {
>> +			mmap_read_unlock(info->mm);
>> +		}
>> +	}
>> +}
>> +
>> +static const struct vm_operations_struct msharefs_vm_ops = {
>> +	.close	= msharefs_close,
>> +};
>> +
>>   static int
>>   msharefs_mmap(struct file *file, struct vm_area_struct *vma)
>>   {
>>   	struct mshare_data *info = file->private_data;
>>   	struct mm_struct *mm = info->mm;
>>   
>> +	mmap_write_lock(mm);
>>   	/*
>>   	 * If this mshare region has been set up once already, bail out
>>   	 */
>> @@ -80,10 +106,14 @@ msharefs_mmap(struct file *file, struct vm_area_struct *vma)
>>   	mm->task_size = vma->vm_end - vma->vm_start;
>>   	if (!mm->task_size)
>>   		mm->task_size--;
>> +	mmap_write_unlock(mm);
>>   	info->minfo->start = mm->mmap_base;
>>   	info->minfo->size = mm->task_size;
>> +	info->deleted = 0;
>> +	refcount_inc(&info->refcnt);
>>   	vma->vm_flags |= VM_SHARED_PT;
>>   	vma->vm_private_data = info;
>> +	vma->vm_ops = &msharefs_vm_ops;
>>   	return 0;
>>   }
>>   
>> @@ -240,6 +270,38 @@ msharefs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>   	return ret;
>>   }
>>   
>> +static int
>> +msharefs_unlink(struct inode *dir, struct dentry *dentry)
>> +{
>> +	struct inode *inode = d_inode(dentry);
>> +	struct mshare_data *info = inode->i_private;
>> +
>> +	/*
>> +	 * Unmap the mshare region if it is still mapped in
>> +	 */
>> +	vm_munmap(info->minfo->start, info->minfo->size);
>> +
>> +	/*
>> +	 * Mark msharefs file for deletion so it can not be opened
>> +	 * and used for mshare mappings any more
>> +	 */
>> +	simple_unlink(dir, dentry);
>> +	mmap_write_lock(info->mm);
>> +	info->deleted = 1;
>> +	mmap_write_unlock(info->mm);
> 
> What if the file is hardlinked?

It looks like that is a bug currently. I need to account for that. Thanks!

--
Khalid

