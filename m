Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E081C539959
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 00:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348287AbiEaWI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 18:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiEaWIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 18:08:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D75712D8;
        Tue, 31 May 2022 15:08:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VKrxT9031603;
        Tue, 31 May 2022 22:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=doaBt3rHjKx9iK28vUcq4wmB1ISh9zs8gKHU5gQ6Fpg=;
 b=ehTdBgmvFKcytqcmolPSeZ4IUsnPVZog15A3le33pfyGmi8297oEzywC/BpqyUE0svO2
 cCZq6Apw3wruIOZu6E7/A8HPRvoXFMdFr1Uqqkxfq9fYTomVCxgMZJCgMj4DtYS931kL
 LHJPVkuJiICnmUiIH5uVGHIPaNB0NTwd57ggBV3Ki6KGu9oXr11fD4hc0Fbqvis7nqE/
 iJlARlT/xfo4o21qcXdizdSpgfzFalPRf7zX1WlgTTFz3O015pBJeGOnGeaSH2m3JkVh
 5MlvP/vCODCOTuSbfJzWeCJQqRZ3fTWUQ9CoSwd85voC0tILzR1k+/Pz+FFBNN4RbShJ 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahpbv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 22:07:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VM66m2032286;
        Tue, 31 May 2022 22:07:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hsy4ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 22:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lODRU/4Ce2XhfioVmlrrTrjIwxXRWGhnce6fi3mBzJNT2QSe9bQEotFQjdSkH5dThl4K9sO2UZLy1CIurEX1s3AdnX8tvQnd+1ME68mX1pcpTt1ZzLLZqnJD32+tIvqM8b5euwNkkZxFKecZ89vePr1BytVXi5WQQfRl9OirIG+73ZI/JLDuSb2zUu2TL36rvkEoTFEx5YG6BF1Ifkrrl8qPmvf6KkACx3Ef++MZ56nEnOuiBBl1XsL+CVHup98tRyPPbLLy/yvrK6kp2j9mZW76eWoZLTKXAvDUEIbp0iOQ3/g4EfWMxdscfFJcGn5fxgs0Pn56iRJXiu9nZJ8sCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doaBt3rHjKx9iK28vUcq4wmB1ISh9zs8gKHU5gQ6Fpg=;
 b=cLd981IxwS+twTZtBF3woZAokRny0DksIEtRh/TJErYVx5iNhFKRZ9WqXBGy4yFM8rW5PRS2TVa+mJL6fbbOOAaivw03xN/4i0UUqOCezIIamlnItqk8B31xVb01SU/P8pIvIddlxWaTWZ2YO5We7Gtpl4vprmvnw/woScVh2sKg7ZrhIRzHLjdgRq2PJGewYxVU1lbWgxonFJ112CjX8kXbQQh2lmJ9GEOo87Xmk5EBtClUfSh4tC571VETdatnyrY23Z27OmLZSDjULwTdHqJIIycyb48QVlvYym5UQOPXU1q5HXBJwRNFQwgwNRuS6Up3lDi5gDNMLRqiG40R9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doaBt3rHjKx9iK28vUcq4wmB1ISh9zs8gKHU5gQ6Fpg=;
 b=TD9AHoYUnIlSvRvF+Ruqh3Yb7jZuYys68rw1lorywi/gTynJp+ioniUlagR2zu340nSxah9XYBniG+4XEhuNMogO33vPeHIsQPNVmNzzj75c8Qw9HZ3v5UXZwzYz6AGsX2ejbekalRUkVUQ8DZJKHzpK54GJETIsOwtqFg/nRJw=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MN2PR10MB3408.namprd10.prod.outlook.com (2603:10b6:208:127::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 22:07:08 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c%9]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 22:07:08 +0000
Message-ID: <14f85d24-a9de-9706-32f0-30be4999c71c@oracle.com>
Date:   Tue, 31 May 2022 15:07:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] procfs: Add 'path' to /proc/<pid>/fdinfo/
Content-Language: en-US
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     ilkos@google.com, tjmercier@google.com, surenb@google.com,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Colin Cross <ccross@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20220531212521.1231133-1-kaleshsingh@google.com>
 <20220531212521.1231133-3-kaleshsingh@google.com>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <20220531212521.1231133-3-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::42) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 880be326-65ba-41bb-5f06-08da4351e75d
X-MS-TrafficTypeDiagnostic: MN2PR10MB3408:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3408A4FFBF39FACB81CC0A10DBDC9@MN2PR10MB3408.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vt96wQH8ohLkzlXFUK2mhlGbzrmf2ylI20MAcT3GREjIdECeUA3eukulq5OaIfIjKIJK4KFuelM+v5W6SMwjQwggv6IjQldD7D6/Ry1cMcx8vVlKdbmDWRE5AIsIJACINp7vkUPg0BsTySIYOdmXtVfBehkSUTWpEB2XoTk5vzefplpBIUFM5vYzNQ+o9ng2GkFRPX2/IDYJzfBJq15JCdkBccDEQ0Pf2OSrT27eP25p1Q9T4Ifdma0RfH9nXXiWOLAi8c0fp+VxdwTPnR+I6//tkpRPxcsfyYLvBps4XNIW7qFHElJNTa1kh9WFfwhHQ9RphKHgibvdDVtrBpGanP1g5iEEmmD+/zA6mktWAEF2eUtqmbmegCquhuEzQdJZDyQvAkyIg+0EwiwI7wDDpOaP+V9BF3tJOqYNVapi7S6HpX51lZ7d5yYFbHA1nvLNYgbRGF7a1Cg5a4rijL++v7E1F1CivABUFTryEG22zikleWt+I1LzGzw8dgEwnWnUSyftxSWh1LHVgupFc/XIXbevub5/jMUHxl4w1lA47HrOM46TxHYUsUFL63DnkSypRwZDxvpX9rCpQzcqHcDBlmvERFkETW88G/f2NpbR7pSwUNe5YTql0jE9f0neaj9B2uBHkOCe/Dz9DwWvoqpkVldkymay+7nBn/JR6wDvmMz++RyMgN/hRpgU0CzCY92daUCchfcAo3htnL2y0T6YSgOsTsFviaRalWPnKWOt5VZqZa/lHW1YuSKqF6L0dL31JqT/t6TjHw17XExv8kddnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(316002)(31686004)(31696002)(36756003)(83380400001)(66946007)(66556008)(4326008)(8676002)(66476007)(86362001)(2906002)(38100700002)(7416002)(8936002)(5660300002)(508600001)(6486002)(26005)(6506007)(53546011)(6512007)(6666004)(6916009)(54906003)(186003)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDUyMllCMWpQeDN5aDE5aTcya2o1N1hJUEs1V3NnTHRaQXBvaU93RWhYbkNE?=
 =?utf-8?B?Z1EreEpSc2J3Q1lSNzVwUktWU0RDOGhXVXgxdzVvMDg2WFBCdk9TZFV5ZkdO?=
 =?utf-8?B?N3ZSZnEvK3E5QVZpbFRFclZ4UUZWdmVSTHkrazdka1QzdGc1TzRGclFJcHdG?=
 =?utf-8?B?QXB0MkZvS3p3LzhrWlZyNWtobzVmdkRKKzNhSGNhVFc5T2RvdHlWMzV5WWhx?=
 =?utf-8?B?YnVPR2htRkFUUWg3UFM1dFliOG5yZ0VCNERXSElJK05kcHhxRi9ueVZyV2JC?=
 =?utf-8?B?eFpvWGVjcWF0SmJOdyswM3MvT3ViaXdYa3g3elFqVHJ0Q3gzc2Z0OW1OVHFs?=
 =?utf-8?B?Rmh6Y1Z5UU5BSVBCNEEzdFNCNDhxN3hMYVlLUFNxTENIZXBZYTBMeW5XUHpM?=
 =?utf-8?B?L1U3Wk1meTltRGY0dmg5S2M0bkdNaWNrSmh1SnFmTzY1WDJlUi90bElORjVQ?=
 =?utf-8?B?d2R3M2dpdnJYaTBZZlQrdkJNdG1NUzRMSUk5NFNYV2RnVy9FQ3VVT2NXSCtJ?=
 =?utf-8?B?ejJ3OTM4RFZUNTE4ZjhwUWlDeWVvaGVaR2I0Y2E5TzNyZWZ2cWJFYTloZ3FE?=
 =?utf-8?B?ZzFjTGVpS3pteURHVnpVRW9lL2dIR25kK3hVZUlNekRxUW5nOUlPRzR5SlZ6?=
 =?utf-8?B?SEY2d28wa2hPTU1UVGZVYVR6RVd6Zk5YUGdwUkF4a1dwTjhkdUlmZTBCRlRu?=
 =?utf-8?B?M2s1L3o3c2owcU1jam42bUpEU1BSOUlLbHlNNjF4Wko2dW5iMUlUK2hKdFFy?=
 =?utf-8?B?S3Q0NXhZVkNXcnZZK1ozTHl0R0MvM3VvSWhNZm1YZEhVaHg3ZDl4YWJYV1kr?=
 =?utf-8?B?V2V5MDFiaDQ1NmFTWHl5M1ZrZTRPeEVhMzRCUUV0ckMrbUZqTFJBeVJvVFNR?=
 =?utf-8?B?ZmhHb2dybGhYbmZLWU5vQVVESHRWY01jYVAzMzlZRHBTSVM3R25nQ3RRUVRH?=
 =?utf-8?B?dTQ5VzdXVSs3eFVKMlljSU5QTlhpaVRnRitmS0FidCtyMDdpamxLMFVaM0V2?=
 =?utf-8?B?STR4bk1DQjFiOE9ybFpxb05sM2lOR2JaUmFPK2hBN0FCb0RTcU9waXY5QXlE?=
 =?utf-8?B?UFd4MW9LdlliMWdPMFl4bzhjZ1dBSkpzeVB5VGpOSjd6RE8xUW4xWXVhVWdH?=
 =?utf-8?B?NktXYi9rOVN6QWxNclplakkvaWN6UTd3bXFpMjNZOENNVTdaZkhjclZUMVEw?=
 =?utf-8?B?bmtnTDZCOUgrNHNRMTZZL0pKVEV0WUVnTmdkYlpONExscTE0WVg5N2NySUJl?=
 =?utf-8?B?TU1maFlmOXhKTTBuT3N3MkgrYTFLVURpUDZOVXNBNDZwTVk5eFlRVGQxcUQz?=
 =?utf-8?B?MENSSTJKQzVpN0VkL3JCaTEwSURGcktNZWxJeVVlclhjT3RKck5tUTdJM3pS?=
 =?utf-8?B?R1lKVHdhU2Z3a1Z4dFNEZ3VwZ0xmNXZpSHlydDB3c2ZDTlZVRFA3VUFnRXdz?=
 =?utf-8?B?dkp5bHpLWUxqcUVuRWd6VjNEL1JacFpxR2t0K3VBNlVvOTN6MXk0cXNLTnB0?=
 =?utf-8?B?UGRQVHpmMXFiQUYxU2h0Q3BPZmxVM1BJTVExVmkrYjFqQ0swTFkwYmNxcy9J?=
 =?utf-8?B?eUNkS09zK0xRMDJtbHZSa2Qxc3pQdEczRXlMUkVFME1aZDl6ZURnbzAvSnZK?=
 =?utf-8?B?V0hQZU0zY0Q5dWEwNzlPd1RCcjBiV1lOUUdCaks4TzVHYmJxczBrWVd6SVBP?=
 =?utf-8?B?MWVQTmNMMjNFUFVTZlk0V2hOaVptUElpY21XNGtnQy9JSWY1bERnOGdtSGZ1?=
 =?utf-8?B?UDBOU0ZZeG5wd2x4dU9jS1o1Mm9XQnJKVGdHb1FEb3FCM09taEVpS2tBbVUy?=
 =?utf-8?B?UTZiS09QdUJHSTUrcnRwWWJheGpqTGppY2ZnNFdtR2VVdGN6VzQ2OWh3dlI5?=
 =?utf-8?B?cExFTmFrTStDOTlHZFhkbXh4Ri90Qzg4N29BWW5pc3NkK1MrZkNWR1E1QUhv?=
 =?utf-8?B?L2kweHZnMTNwMk9RYUdIT3JyZWtyUjVmUWRROHRVSkpadWxOU1phMkVmWTkv?=
 =?utf-8?B?MEwwTmVXRjBSQ1ZSZnZySWQwN1MwR3VYYU1PMUxNaEdVdkI1dWtKaHJvWTRX?=
 =?utf-8?B?c094a3l6L2ZZVFlBMElpblBMVDlsN0ZQWW5oYWVFWEY5R1dkNkJqUC94elN5?=
 =?utf-8?B?RmtuRFZWVXlBb0RrUmd4MElnVzBwdzRYZ0d0RmxBN1ZrRkc1SVRXSW1xa25a?=
 =?utf-8?B?UkpMczlYelZaZzBhMC85WlcyUEovSVRFMXpRN2NxejMwMGJTSllXZjArZTBx?=
 =?utf-8?B?cHZpMWU3RCtHYXVNd3lOWXhpd1BycDVhZzVyNncrL0Q1cDJpdXlkS25rV1FT?=
 =?utf-8?B?eUNhUmJvREVOU1dPYzJIOG5MdG8zSWxEamEvOHM2MGZUa0lGN1dxa2hmcG9H?=
 =?utf-8?Q?bOVGGRTKWfFUMOis=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880be326-65ba-41bb-5f06-08da4351e75d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 22:07:08.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5ZAQcWuY2B/ggyBq9GjqFzqOtGSQ2aaw2KuoA7Aq8OBkkeN7CPbsXbTCXZW/I2KCWN5ab9uKF9A6ja2/gFTXO8rQpxwISzQQUKsBCtaVDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3408
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310096
X-Proofpoint-ORIG-GUID: vtGIMmriu2B-m-nMXLrecZZNJvN2t0kz
X-Proofpoint-GUID: vtGIMmriu2B-m-nMXLrecZZNJvN2t0kz
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/31/22 14:25, Kalesh Singh wrote:
> In order to identify the type of memory a process has pinned through
> its open fds, add the file path to fdinfo output. This allows
> identifying memory types based on common prefixes. e.g. "/memfd...",
> "/dmabuf...", "/dev/ashmem...".
> 
> Access to /proc/<pid>/fdinfo is governed by PTRACE_MODE_READ_FSCREDS
> the same as /proc/<pid>/maps which also exposes the file path of
> mappings; so the security permissions for accessing path is consistent
> with that of /proc/<pid>/maps.

Hi Kalesh,

I think I see the value in the size field, but I'm curious about path,
which is available via readlink /proc/<pid>/fd/<n>, since those are
symlinks to the file themselves.

File paths can contain fun characters like newlines or colons, which
could make parsing out filenames in this text file... fun. How would your
userspace parsing logic handle "/home/stephen/filename\nsize:\t4096"? The
readlink(2) API makes that easy already.

Is the goal avoiding races (e.g. file descriptor 3 is closed and reopened
to a different path between reading fdinfo and stating the fd)?

Stephen

> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> 
> Changes from rfc:
>   - Split adding 'size' and 'path' into a separate patches, per Christian
>   - Fix indentation (use tabs) in documentaion, per Randy
> 
>  Documentation/filesystems/proc.rst | 14 ++++++++++++--
>  fs/proc/fd.c                       |  4 ++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 779c05528e87..591f12d30d97 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1886,14 +1886,16 @@ if precise results are needed.
>  3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
>  ---------------------------------------------------------------
>  This file provides information associated with an opened file. The regular
> -files have at least five fields -- 'pos', 'flags', 'mnt_id', 'ino', and 'size'.
> +files have at least six fields -- 'pos', 'flags', 'mnt_id', 'ino', 'size',
> +and 'path'.
>  
>  The 'pos' represents the current offset of the opened file in decimal
>  form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
>  file has been created with [see open(2) for details] and 'mnt_id' represents
>  mount ID of the file system containing the opened file [see 3.5
>  /proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
> -the file, and 'size' represents the size of the file in bytes.
> +the file, 'size' represents the size of the file in bytes, and 'path'
> +represents the file path.
>  
>  A typical output is::
>  
> @@ -1902,6 +1904,7 @@ A typical output is::
>  	mnt_id:	19
>  	ino:	63107
>  	size:	0
> +	path:	/dev/null
>  
>  All locks associated with a file descriptor are shown in its fdinfo too::
>  
> @@ -1920,6 +1923,7 @@ Eventfd files
>  	mnt_id:	9
>  	ino:	63107
>  	size:   0
> +	path:	anon_inode:[eventfd]
>  	eventfd-count:	5a
>  
>  where 'eventfd-count' is hex value of a counter.
> @@ -1934,6 +1938,7 @@ Signalfd files
>  	mnt_id:	9
>  	ino:	63107
>  	size:   0
> +	path:	anon_inode:[signalfd]
>  	sigmask:	0000000000000200
>  
>  where 'sigmask' is hex value of the signal mask associated
> @@ -1949,6 +1954,7 @@ Epoll files
>  	mnt_id:	9
>  	ino:	63107
>  	size:   0
> +	path:	anon_inode:[eventpoll]
>  	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
>  
>  where 'tfd' is a target file descriptor number in decimal form,
> @@ -1968,6 +1974,7 @@ For inotify files the format is the following::
>  	mnt_id:	9
>  	ino:	63107
>  	size:   0
> +	path:	anon_inode:inotify
>  	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
>  
>  where 'wd' is a watch descriptor in decimal form, i.e. a target file
> @@ -1992,6 +1999,7 @@ For fanotify files the format is::
>  	mnt_id:	9
>  	ino:	63107
>  	size:   0
> +	path:	anon_inode:[fanotify]
>  	fanotify flags:10 event-flags:0
>  	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
>  	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
> @@ -2018,6 +2026,7 @@ Timerfd files
>  	mnt_id:	9
>  	ino:	63107
>  	size:   0
> +	path:	anon_inode:[timerfd]
>  	clockid: 0
>  	ticks: 0
>  	settime flags: 01
> @@ -2042,6 +2051,7 @@ DMA Buffer files
>  	mnt_id:	9
>  	ino:	63107
>  	size:   32768
> +	path:	/dmabuf:
>  	count:  2
>  	exp_name:  system-heap
>  
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 464bc3f55759..8889a8ba09d4 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -60,6 +60,10 @@ static int seq_show(struct seq_file *m, void *v)
>  	seq_printf(m, "ino:\t%lu\n", file_inode(file)->i_ino);
>  	seq_printf(m, "size:\t%lli\n", (long long)file_inode(file)->i_size);
>  
> +	seq_puts(m, "path:\t");
> +	seq_file_path(m, file, "\n");
> +	seq_putc(m, '\n');
> +
>  	/* show_fd_locks() never deferences files so a stale value is safe */
>  	show_fd_locks(m, file, files);
>  	if (seq_has_overflowed(m))

