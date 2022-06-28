Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA155EF32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 22:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiF1UUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 16:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiF1UUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:20:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F05017E2C;
        Tue, 28 Jun 2022 13:17:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SJBSTI022068;
        Tue, 28 Jun 2022 20:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sIt5VQQl/ID2HbHL8I5zFd4J1nDAbSm/7CFj4gEjUJw=;
 b=TuPnV8A3YIMlPSySLHMeSD9ge4pCGSzaqe60MO76BlYVodh4O+rnxm4NmQ3IFGIgKvvu
 HVijofnykzEbqQ4bxmSp9l5kkRBQwdtT2Pmmi3OpLExaqpqDvxZg+qb3i+EPMBBvCOkB
 fyz3jtncMSi5Ox78iDueIrUYHjEnK5meFfrKgVFWYniXbGzcMwpJ8+boQKfnI9LB8dVW
 4tzROwPvUQJHwqN5M48HCBJ2XewDVw4kJSEBOTCiw45atGM7+Y0/ogi++BnthIg/DIiI
 q/oGXvX1MNgoZAlLMYebp/N+WGBAqhwJTAEgwZe2ww0bmljlTA/9PKk2wDfg23Vo+qUe /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscf4xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 20:16:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25SKGKlm003084;
        Tue, 28 Jun 2022 20:16:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt2h0wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 20:16:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUV32+QeuxVrUgbpSkb1hVGdFmqZN9Q/csmVN4N9l5Ez4Wvg7QMvTj01sA/raSIZpMLIG1r7e3v8AAvOwHpgYn3RATLF8Ce8chQkTKFeRE9OpZscd1x68KllBdvWPe0s2ZzNlO7Zja8CCvQc3d6Kzwe7EKnjUFh6w7rpsrMpiHRFUxseNvRQfWV48ydWBaEX7CpFX7xWom/+nBO+EAlkWMeTLMPBokEWJsoWlKztTKLRbRknGxolhrsXw2wEqgLEEHaUpkbXeSsjI0wwMwD5T78PT5yApGVeCEMbnRXpFlwOuKvnXCQsXlJpMQBUybzhMM2nhJlwLC9Asg6d8pcUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIt5VQQl/ID2HbHL8I5zFd4J1nDAbSm/7CFj4gEjUJw=;
 b=BMafBs5yrIkWkH23GibPAAAF2ccxZT5Qx5K3qE+ZG64rPBRgiQ7t4brJx63urRNj2sNyiBj2MBvv88tSgoqFJytiVqZPEisgdXnXIQ5bMBMhJVIO7T39k1JXa1a2A/HQqtvHOfc6wU0bMAvQm2HqHzmDlkZYnYLJSxM034PUQenkn0zkgWs0/fP7MhQ/OfvknEYxkJz7Xph8bhUK6Ft3TFWPIMTc2zr9JCWP5vgeLayrEKYFbcZUOrQSbc2dUARaUYSFrSCugz1nCT3yQwK8I0WWTHcPdzNahFLMS3Tt3tfkGX1gvTTT34eom+kKAatvBF+83P0Qw3pb0XFKRWBIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIt5VQQl/ID2HbHL8I5zFd4J1nDAbSm/7CFj4gEjUJw=;
 b=lsFdgNIULh4jS49ZvKJ2gcra9HtGZl2iRZWEihMvKMQeH0Cms9udgQP3NOl29MuqL3nllU8Vj3Pv8e66+Fw4cSKordWwWg55L3TFo+rPg7DwzcROKpWVD1RX1h4ocwo/R6zghxYkPnIafXeeI0x7ZJVIYmAaep0UC2TiaN1qgns=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN6PR10MB1330.namprd10.prod.outlook.com (2603:10b6:404:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 20:16:50 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 20:16:50 +0000
Message-ID: <d5795029-9d77-b4e1-b92e-0b6bc920a0d0@oracle.com>
Date:   Tue, 28 Jun 2022 14:16:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 08/14] mm/mshare: Add basic page table sharing using
 mshare
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, ebiederm@xmission.com,
        hagen@jauu.net, jack@suse.cz, Kees Cook <keescook@chromium.org>,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Andy Lutomirski <luto@kernel.org>, markhemm@googlemail.com,
        Peter Collingbourne <pcc@google.com>,
        Mike Rapoport <rppt@kernel.org>, sieberf@amazon.com,
        sjpark@amazon.de, Suren Baghdasaryan <surenb@google.com>,
        tst@schoebel-theuer.de, Iurii Zaikin <yzaikin@google.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <5c96dd165d7ec3da14306b8fd857c7eb95a8c3e6.1649370874.git.khalid.aziz@oracle.com>
 <CAGsJ_4ySieW+9a2yZQPVa1VA6dtv=9m2qEZ8w4ZoT6PqRFpLDg@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CAGsJ_4ySieW+9a2yZQPVa1VA6dtv=9m2qEZ8w4ZoT6PqRFpLDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:a03:100::27) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f12bb6f-bf07-4674-c604-08da594322b1
X-MS-TrafficTypeDiagnostic: BN6PR10MB1330:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tz8Q14MHU8RHXfjp6sKB4iAFcREsIrLwUbSyyT47qX7Jbz2aSqhOaZY48po8TCohRtdpIHuViaSF+XHlAOLz2A2HEJpPAVGx4GYgk4G5igkqdHB/9c5VwzklOAev5MlEKgzwIdG7NtMZQiyrNWh67BQorUj9DGdHSxP4QQVX/TetMVXYXUxPaBy8mk0inZrlPJFfa0I5Eq/6p1CkDig9p4QDxG8pnQJBA9NcNQFBsH+QbSrq2beB10ndlUJVzJdFrn7TLW/zoiIrN+xZr64jJ6IFBHrB5TDovz9GtkUGcv2N4f0ImRcrPYjzVAbU7bp2HldaojejvNtQ9KNgbEXJpgrcCUy2qVZFqQ1hotmiYyapnXCcKBbqEaylAov5m3i/Z+X6FFy0Eo/oYy7bwYw7GSMvGAxE36Dv/MDFiPKm/BnuLy1CgqHvvBR2hOf6PRg3ZQlxx33iSCX+GkYya8ytWtgxibT/olEzhLbKxTAHNd8lR8xZLc02hFSX/89mj57J2ikxRNXbz+rYgfiKlYEMsn8ZCB7SsU0xagovoTenvgCx3rRU/edNEM7dhN3SpH+JuB0HSi90yfaD64e4s4gswXHcjyGEOGrd9wrWFuy2mtLV48siR6fi/IhSA+zVpx2P/TZftbDA+Skul5RXc6QiBmrBT8W2/js+kZIbfFnUggGhHKPtdeaEdhWnpQHBi5JUPbRV++XG+8sZ96Dmuc8cGbDYgJwfzqOotTKS9IeMQejprVqYQn4OvHs2T1QUrkRh90bstPkegOiIiZBRntiDb8EUyKBizHz9qwwys/27xBQ5O8KZmXRX02JTTqwjoWrrMGvCsLvGy8g4Zl/EfjAoFd2R7cf9w6RSkyYMuq5nSXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(396003)(366004)(346002)(39860400002)(5660300002)(66476007)(6486002)(478600001)(2616005)(186003)(31686004)(31696002)(6666004)(41300700001)(83380400001)(36756003)(8936002)(316002)(4326008)(53546011)(86362001)(6916009)(44832011)(54906003)(66556008)(6506007)(38100700002)(66946007)(2906002)(6512007)(7416002)(8676002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3RNbFNlNFp4MllRM1M1YlRPdnVpS2g0dklJMHNFR2wvbVNyYkx0aytsQkp4?=
 =?utf-8?B?b1E1TFliVGxmY0hjQ1QrKzlRV1F1NGZ5RDQ2TzBmQmxWQVNjNGRiQXhZOG84?=
 =?utf-8?B?TnVTQkF1TmpTdnAxemVONlJUcmplblhqbmFDTDRlME5QR2U0NE5jL0RMRzhw?=
 =?utf-8?B?T1RpZXhRTWJEQU93THliWHpxcmdwVFNUQzdoQVdzWHB6UGtEVk9WQmtaU1pS?=
 =?utf-8?B?cDVlV1d1SWV6MDhydmFRYUJCQTJxckFZZ3RnMHpXOEZpcDFZdnpuMGljZjA3?=
 =?utf-8?B?aEtqTU1MaExvVVVaS3AweWN0Ujh3SUtiNU9WdVFRZXhxejNRSlZ4c3BGZ0Uz?=
 =?utf-8?B?czZsNk1TeUsraFJWaXFEcHlhWHc4MWtlTXp2eTdKdFNlYnFXajBvbmhIdjFy?=
 =?utf-8?B?WTl5MElZSDJEYmx1TlZ4V29Xd2ZjMnRIclJBSFNLdkhwMk11SklFaUpOUWxl?=
 =?utf-8?B?cUtwRXBFa08yak5kMlNGS3NZaVRvOWlkUEpJV2lkek5VT0czamcxRXdnWmM0?=
 =?utf-8?B?UjVGZU9EeUxXaThrUzdsYVBMOE1yMWxOSWVjVFJpaG15RzE1SkwxTzhFeEUw?=
 =?utf-8?B?blRSRzhkYzlmY2VvOFBQcUdzVGRVNWl2L2tOeFVCR3lsUzVtdThQTjVOMDM5?=
 =?utf-8?B?dmI0a2NUeDZ2TXJhU3JFWVljWDBBazFPOHhvTVBKTUxwRjhxUlZlWlFSS25x?=
 =?utf-8?B?Q1Blbmg0Q1NteXZwTXMzeCtDbFdHaEJqbGoxVTJVKzU1a1VYSTl1U2JEUUor?=
 =?utf-8?B?dXdkK3VFUWsvWXNadHVJNEk5OFpOSjBKc3gvUTRQZDgwbzBjMUFFZTZwVkxv?=
 =?utf-8?B?ejZjdHVIdC9ZS3dwSzFHYlg3QTJFSTB6WklOdndnSGdPWEsrUVROcmdscERm?=
 =?utf-8?B?bDV3NCs2di9OZVRrOVlOVnZYcm1yb25FNFZwU25Va0R3T1diR01FRWQ5SmQw?=
 =?utf-8?B?T0hTZzUwNWpvQ0ljNVRhSWNZMklUWmRMcm9JaG01dnY4MGM1ckk4NmtrZnc5?=
 =?utf-8?B?ZVdsbEcvby9uZVFxaGRhNTJUVWJXdWkvTVQrSTdwQ00xRTBPRUNTNGtPdmh4?=
 =?utf-8?B?cDBnNHlUSmExcUhFdXhjM2NUSEZ6OVdpcUZQZk1jS0VkekhXSGdDQVY2eWty?=
 =?utf-8?B?anRjdkRGbXJkMWJEUzJOcFRvMElPcmZoK25FYzlNMmNYQnRZYUFOeGRNd2ll?=
 =?utf-8?B?ZHUveVFzY1lVYURiV2s3Nkl6a0dqRjFVSnlZZDZ5SmxoZDhjTkVIeTNyTHU3?=
 =?utf-8?B?aG5wcUZPTWdwWHFGd0o1RzczbnNlMlQ2ZEc0YktWSnp4MGh4NTk0SDgyNjNY?=
 =?utf-8?B?RC84dU5wZWNCa0RPeUFXT3NVK3JQRHd5Sk1xRDZHUUF6QXpGQm5hYXNMVEFi?=
 =?utf-8?B?dUdwbW5wVllybEgwUTJteGJRd0RULzcwN1I5L08zU0t0cUdaTm5ETWR5UzZP?=
 =?utf-8?B?NVQ0NFE0bWI2YlByU011dTR4U0tUMU1XWXR1SjVqbnJnTFA2clJHemtoa01Y?=
 =?utf-8?B?bE5MT3pPN3IrVjRvZkpiMnZ0SHRFMHRJM2drdTh1OHg2RGh2U3FMWFFldkhU?=
 =?utf-8?B?cXdTMGVvQU5BcGp5ckxCTzBWTUJQVUEvOTU1TDh3RTl3L21ZSUdvV0FQYzhR?=
 =?utf-8?B?cFBUUmJNL2NNY2x1ek05MmphUlU4Q1VGUG5WTDB0RmRkQm5IN01SK3hzekc0?=
 =?utf-8?B?RkpvT3RSOGIzOC9FVUpxVXBMc2FHMWQ3Z2hBUEFGUjZvVktHN0J3U2hQN1pm?=
 =?utf-8?B?RzJxUVFhcGdpdFByM25qZ3RTVVZIekVCYndVOCtFODNqT1BoejJ5dDRMNUps?=
 =?utf-8?B?MUpVYlJ2U2lZbjlhbmZCemVFNEYvd1NjUU5NTlZ1SU1jS21NSTR1K216K09N?=
 =?utf-8?B?OG5mN2RVREg1VHMyZDh0N1V0UGhpVlFESVA5aytuZWtqbG43RlNabkd2ejNW?=
 =?utf-8?B?a2kzaklyeGdlcGVwYS9LMEo4WmV0U3Z4OWdnZG9GOWN5VElvLzM5VitDQ2Ji?=
 =?utf-8?B?NUd1T2lNK3IzVmR0Q09NOUN3OHhNVXZoYWFnMmxJd0VBWFE3dDlkNGc5Wmlv?=
 =?utf-8?B?bXBoNmFGVXRmQVIvdmk2aGNEdjhORzJNNzF2SndwYTZoOC9IS3JsL0FvMFFn?=
 =?utf-8?B?c2FWSit0MkE4a1djU1k5V09MN1Fzazd4bXpYc2Z3M0p0Y085clhHMUFIZnFB?=
 =?utf-8?Q?wVBW+T7Te00SOXFDw+MjmFWmyo7s6mHKzjvyJmnqr3Gl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f12bb6f-bf07-4674-c604-08da594322b1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 20:16:50.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OHLF7QYr0Otdl+b987hCvlnSs34g/FK2V56WXJ4W0mzLG0/04t4a+VnyDu809pUBHlEKi/J+LjQC1PeJqdpHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1330
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-28_11:2022-06-28,2022-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=671 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206280081
X-Proofpoint-ORIG-GUID: dyfU2-6C3GLCnZHjmG_VDYVfMudkhKo-
X-Proofpoint-GUID: dyfU2-6C3GLCnZHjmG_VDYVfMudkhKo-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/30/22 21:46, Barry Song wrote:
> On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> This patch adds basic page table sharing across tasks by making
>> mshare syscall. It does this by creating a new mm_struct which
>> hosts the shared vmas and page tables. This mm_struct is
>> maintained as long as there is at least one task using the mshare'd
>> range. It is cleaned up by the last mshare_unlink syscall.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>   mm/internal.h |   2 +
>>   mm/memory.c   |  35 ++++++++++
>>   mm/mshare.c   | 190 ++++++++++++++++++++++++++++++++++++++++++++++----
>>   3 files changed, 214 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index cf50a471384e..68f82f0f8b66 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -718,6 +718,8 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>>   int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>>                        unsigned long addr, int page_nid, int *flags);
>>
>> +extern vm_fault_t find_shared_vma(struct vm_area_struct **vma,
>> +                       unsigned long *addrp);
>>   static inline bool vma_is_shared(const struct vm_area_struct *vma)
>>   {
>>          return vma->vm_flags & VM_SHARED_PT;
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c125c4969913..c77c0d643ea8 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4776,6 +4776,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>                             unsigned int flags, struct pt_regs *regs)
>>   {
>>          vm_fault_t ret;
>> +       bool shared = false;
>>
>>          __set_current_state(TASK_RUNNING);
>>
>> @@ -4785,6 +4786,15 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>          /* do counter updates before entering really critical section. */
>>          check_sync_rss_stat(current);
>>
>> +       if (unlikely(vma_is_shared(vma))) {
>> +               ret = find_shared_vma(&vma, &address);
>> +               if (ret)
>> +                       return ret;
>> +               if (!vma)
>> +                       return VM_FAULT_SIGSEGV;
>> +               shared = true;
>> +       }
>> +
>>          if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>>                                              flags & FAULT_FLAG_INSTRUCTION,
>>                                              flags & FAULT_FLAG_REMOTE))
>> @@ -4802,6 +4812,31 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>          else
>>                  ret = __handle_mm_fault(vma, address, flags);
>>
>> +       /*
>> +        * Release the read lock on shared VMA's parent mm unless
>> +        * __handle_mm_fault released the lock already.
>> +        * __handle_mm_fault sets VM_FAULT_RETRY in return value if
>> +        * it released mmap lock. If lock was released, that implies
>> +        * the lock would have been released on task's original mm if
>> +        * this were not a shared PTE vma. To keep lock state consistent,
>> +        * make sure to release the lock on task's original mm
>> +        */
>> +       if (shared) {
>> +               int release_mmlock = 1;
>> +
>> +               if (!(ret & VM_FAULT_RETRY)) {
>> +                       mmap_read_unlock(vma->vm_mm);
>> +                       release_mmlock = 0;
>> +               } else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
>> +                       (flags & FAULT_FLAG_RETRY_NOWAIT)) {
>> +                       mmap_read_unlock(vma->vm_mm);
>> +                       release_mmlock = 0;
>> +               }
>> +
>> +               if (release_mmlock)
>> +                       mmap_read_unlock(current->mm);
>> +       }
>> +
>>          if (flags & FAULT_FLAG_USER) {
>>                  mem_cgroup_exit_user_fault();
>>                  /*
>> diff --git a/mm/mshare.c b/mm/mshare.c
>> index cd2f7ad24d9d..d1896adcb00f 100644
>> --- a/mm/mshare.c
>> +++ b/mm/mshare.c
>> @@ -17,18 +17,49 @@
>>   #include <linux/pseudo_fs.h>
>>   #include <linux/fileattr.h>
>>   #include <linux/refcount.h>
>> +#include <linux/mman.h>
>>   #include <linux/sched/mm.h>
>>   #include <uapi/linux/magic.h>
>>   #include <uapi/linux/limits.h>
>>
>>   struct mshare_data {
>> -       struct mm_struct *mm;
>> +       struct mm_struct *mm, *host_mm;
>>          mode_t mode;
>>          refcount_t refcnt;
>>   };
>>
>>   static struct super_block *msharefs_sb;
>>
>> +/* Returns holding the host mm's lock for read.  Caller must release. */
>> +vm_fault_t
>> +find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
>> +{
>> +       struct vm_area_struct *vma, *guest = *vmap;
>> +       struct mshare_data *info = guest->vm_private_data;
>> +       struct mm_struct *host_mm = info->mm;
>> +       unsigned long host_addr;
>> +       pgd_t *pgd, *guest_pgd;
>> +
>> +       host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
>> +       pgd = pgd_offset(host_mm, host_addr);
>> +       guest_pgd = pgd_offset(current->mm, *addrp);
>> +       if (!pgd_same(*guest_pgd, *pgd)) {
>> +               set_pgd(guest_pgd, *pgd);
>> +               return VM_FAULT_NOPAGE;
>> +       }
>> +
>> +       *addrp = host_addr;
>> +       mmap_read_lock(host_mm);
>> +       vma = find_vma(host_mm, host_addr);
>> +
>> +       /* XXX: expand stack? */
>> +       if (vma && vma->vm_start > host_addr)
>> +               vma = NULL;
>> +
>> +       *vmap = vma;
>> +       return 0;
>> +}
>> +
>>   static void
>>   msharefs_evict_inode(struct inode *inode)
>>   {
>> @@ -169,11 +200,13 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>>                  unsigned long, len, int, oflag, mode_t, mode)
>>   {
>>          struct mshare_data *info;
>> -       struct mm_struct *mm;
>>          struct filename *fname = getname(name);
>>          struct dentry *dentry;
>>          struct inode *inode;
>>          struct qstr namestr;
>> +       struct vm_area_struct *vma, *next, *new_vma;
>> +       struct mm_struct *new_mm;
>> +       unsigned long end;
>>          int err = PTR_ERR(fname);
>>
>>          /*
>> @@ -193,6 +226,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>>          if (IS_ERR(fname))
>>                  goto err_out;
>>
>> +       end = addr + len;
>> +
>>          /*
>>           * Does this mshare entry exist already? If it does, calling
>>           * mshare with O_EXCL|O_CREAT is an error
>> @@ -205,49 +240,165 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>>          inode_lock(d_inode(msharefs_sb->s_root));
>>          dentry = d_lookup(msharefs_sb->s_root, &namestr);
>>          if (dentry && (oflag & (O_EXCL|O_CREAT))) {
>> +               inode = d_inode(dentry);
>>                  err = -EEXIST;
>>                  dput(dentry);
>>                  goto err_unlock_inode;
>>          }
>>
>>          if (dentry) {
>> +               unsigned long mapaddr, prot = PROT_NONE;
>> +
>>                  inode = d_inode(dentry);
>>                  if (inode == NULL) {
>> +                       mmap_write_unlock(current->mm);
>>                          err = -EINVAL;
>>                          goto err_out;
>>                  }
>>                  info = inode->i_private;
>> -               refcount_inc(&info->refcnt);
>>                  dput(dentry);
>> +
>> +               /*
>> +                * Map in the address range as anonymous mappings
>> +                */
>> +               oflag &= (O_RDONLY | O_WRONLY | O_RDWR);
>> +               if (oflag & O_RDONLY)
>> +                       prot |= PROT_READ;
>> +               else if (oflag & O_WRONLY)
>> +                       prot |= PROT_WRITE;
>> +               else if (oflag & O_RDWR)
>> +                       prot |= (PROT_READ | PROT_WRITE);
>> +               mapaddr = vm_mmap(NULL, addr, len, prot,
>> +                               MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, 0);
>> +               if (IS_ERR((void *)mapaddr)) {
>> +                       err = -EINVAL;
>> +                       goto err_out;
>> +               }
>> +
>> +               refcount_inc(&info->refcnt);
>> +
>> +               /*
>> +                * Now that we have mmap'd the mshare'd range, update vma
>> +                * flags and vm_mm pointer for this mshare'd range.
>> +                */
>> +               mmap_write_lock(current->mm);
>> +               vma = find_vma(current->mm, addr);
>> +               if (vma && vma->vm_start < addr) {
> 
> and I don't understand why "vma->vm_start < addr" can happen.
> does it mean we have given mshare() an address which is not
> aligned? then we should have return -EINVAL earlier?
> 
Yes, this could potentially be caught earlier. I have rewritten the code to new API based upon mmap() entirely without 
adding new system calls. Much of the above code is no longer needed since mmap takes care of lots of these checks 
already. I am running some final tests on v2 patch series and will send it out shortly.

Thanks,
Khalid

