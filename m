Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E74453AF46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 00:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiFAUwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 16:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiFAUwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:52:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08E139CAA
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 13:50:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251KKtMS025649;
        Wed, 1 Jun 2022 20:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BxGLkAbFR1jrOJPU8LGZcYhWqPdirkwCrsp4Oi8pm7o=;
 b=ouZJRFuUMq4okSNG7Iy+PLjto/3TAb3/WyofmASlubcP1PrIkZrmlAbA+5fNBFdQ/G5X
 buNsQn+uEmnk0rY0TeG8nYp7EL7fCx8ZEn2uUpyvsLxX/gFlTIyxFAJdGubjz/S4K6kc
 HBdVkOAbyH0QBcdvSA4jym6Rpj8Tk4Wr9eHoSONpeM3qxAoepv8opPeNkKeiNG6q4Jba
 YFmjvAI9RLuASQM9R+u6oDRuAJa5afhoUBBw24nx+ef2YVubn5cGFQkRJK13nIQyWDuW
 Z7tFQ/RvfE1+eCs9kBe+MwCmsQtpiK5Ao4NhRmD17e5d4fm5C3Oe9BWuh1D0JJDlS4zJ Ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc7krk1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 20:50:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 251KUMra023398;
        Wed, 1 Jun 2022 20:50:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p48cjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 20:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9stVhNilP354PjMPWYOLEqTfjl7j+WC+sxdPU+mD4ehxdAkZFM+iz1tWXVcTmitaAEBtiAvhWTxyBSdmFS91DP2s/51XYSNq1kaS3kBwFyGYosHB7R55npi4JCwnAcAeBIPQxte6n+/yKD8yT0bIDj2A0yjrhaqw5p1x2f9J7TtvSunJr+jJ4mhgF89HCZKiUz0DLkm1LPRWngynLrUiOxcWlKLPEPAtjD7P0posC48voezU/j2qKneobsTq4jn2726QmXElcczEAWNVOj44Sp5HYROXDVSF4Cm/TL0BpZ0iCHAzFfWrCP2UPfb9Fcl5h352tI85ncwjXRzQ5NeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxGLkAbFR1jrOJPU8LGZcYhWqPdirkwCrsp4Oi8pm7o=;
 b=GeZWRG5GHP72dGkxc7XcmgRBjEjj6+cVqqb69fO9Y3xrQFvekoYq/yxw9/49duyyIoEUzh/IvYpZNxQ75ACGaR+/gtL9q89SsO6m5sq5c0OiceKWq5ccnb+k2lvVT8cusxyt3KKG3jEGcZFZXpNZOMSJljuDr4hIaFlSAvmCP0y2LZddclpmk0V4sGceyCQ3vL3YvhAKWlpTVXSURwGkafVp0WUIPcXhFMox5UwiAKdnxj9iJqeeyDnYr5YmWt8pCDSBgBHVCoQQiigbcywK9+1o2T71mavldu+8T+BwlLYSiXNXycL7sdXa1CR1NvClSxJGPjerqsTrd5WBtEf/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxGLkAbFR1jrOJPU8LGZcYhWqPdirkwCrsp4Oi8pm7o=;
 b=hoRgZU1e+1oQNvyyZsAE14aOABsjfDOAlEayX4ONTsqcuS9urkQiEsFDDo5vtEB5Y26NZ3JbkYTfowlLU2lj2q2UkaFON0bsnFvuEufjDKqvPzCARS5pELWrl8KXBhl1E+qCqMQKXDvYSvYM75s4A3a255f3ye2Qbm2hVtTzmDM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4743.namprd10.prod.outlook.com (2603:10b6:510:3e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 20:50:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 20:50:30 +0000
Message-ID: <2d3c2f0e-c6f3-cf54-e042-9bac242c4892@oracle.com>
Date:   Wed, 1 Jun 2022 13:50:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] hugetlb: Convert huge_add_to_page_cache() to use a
 folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20220601192333.1560777-1-willy@infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220601192333.1560777-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0343.namprd04.prod.outlook.com
 (2603:10b6:303:8a::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35b9af47-1d9a-48a2-7c15-08da44105d70
X-MS-TrafficTypeDiagnostic: PH0PR10MB4743:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4743925DF69DE9D5A2AE1278E2DF9@PH0PR10MB4743.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyPhc+lS5sh+RG1OCUTJZxVRDjxI4P2VS1Vnhb9eW2bJ08Br8bu2YYxljKEh8fE8Pj9fzAbNXGozVQj0xbzmbWgKhqJdxNfAfRBhtV43fVi66kmhWI5ORxpEDJFKw9JWCJ++w5RQHclxeiAoYrYYAeNIeacaFhDlcxHFjKOBnYH/e8g7eZc77N1JFwwK5rq1eWu1AAURKQk5IrhUZ5XaGp2jOV3q4f7z08ycSYtYMTkbBEkha289v5rpyGY4PS8FMODBIafmx+5eLZ4/8ynkfe0gzL8FHoaUvQvc4LyY/ptew/k1wBlXkI4UOcTGrV7BBQP9thIS1z20TkF46zfLit08WfaG8EsxNLH6TEnB83he0hYEsLq2PmPjHGQNJHnlacgqduWUhdtPWgAsNyDl5WI3Us1kIggbA1eazrgI8PNV+nX1nvEj228z5EedKwEkAbfyPGE72pY8CM2SdLB3/NR8h4uzs9HMq1zYOQHMPUycyDLNXhD2BsV0EOQXEjimVzIx52TtEtFVIOU57zFv6eRBPj9H/BiPdVwdeLoZ0BNN2gVGN1cTsX8ZAKie+965/UgvOJ3O442tHLgjQdytg+GEBFSZcg6+cBhGY/cQaEAjpLR7E+u9CVAa9Q33SkdrJOeyKABWn2enN97h44ttQSjTXu0d0uYorUnPZZo8oqBlHKsLTsu+jrqZkVRPWQ2lOoHn9UwcoLc3KOdVhpg33rWI+FW5/oUm59JUF2PSYKZ7x/y22T7cI84VjxfJ1TTYptv8QVNR2/cQiRcLaKQUnzW0H3r+DKzdpf8aI0PcCbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(6512007)(26005)(316002)(66556008)(186003)(83380400001)(6486002)(53546011)(6506007)(508600001)(2616005)(31696002)(66946007)(8936002)(4326008)(86362001)(36756003)(52116002)(2906002)(38350700002)(38100700002)(4744005)(31686004)(5660300002)(8676002)(44832011)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2FQbmFJcC9LWUpRVUZYNENrRlB4STZ1S2J3YVdKZXdPSWtuV3ZhTzBGdEdV?=
 =?utf-8?B?M2EzbmY5d3BvcmNqNzJwRThGREZ1VUU2R09aS3l4WmtuVDJGWXYzUTJKZUZZ?=
 =?utf-8?B?V0VvM2pYdVBUR3B6VTVrWG1PdDFvQ1FaR3J4emVzUjJwZmVTekova0hBdlNY?=
 =?utf-8?B?S1dEVCtNOHNBbmw0TnNHME9VMHE2OXRhbVpwZjk3dlhSbkx4WEs5WHh2a2Vz?=
 =?utf-8?B?NlBQRlZJb28ySFZsQ2I5bkZRd2JmRGFTRS8ySW1wMElBd0dEbmpBdXJGU2FT?=
 =?utf-8?B?c0FCQmtTd0YyT0I2dVZGYmxJN1BLK2pISUJkdXlHM2lZZUpzYS8xZmZ6RmF0?=
 =?utf-8?B?eVlZV1VuZDdtRWZ5b0ZpOXIvMzBNYkhuTjZKeUZVQXZuL3JzQlJFUktBQjFH?=
 =?utf-8?B?YWNsOGYzRFViV0xvemh6WHo1T214ekxoNFRQSzkzVytlWmxGS2JQM2VyTE5S?=
 =?utf-8?B?ZHdMSnNWVnlidkh3NXNyZmZGNzFWZlJLUmhpRGVqelBQNHYyQWc5K0pIL2xp?=
 =?utf-8?B?a2FyMmtkNlU0anJyblVvRm1MYVRWRGU4c09pQm1YZEN4SnN2am1YUG9jbXEv?=
 =?utf-8?B?WUJQaHRLc2ZMR1BDODdaZEdjRVpTVHhVcXgvZkRYbW1WU1hUU3ZwUkVOcXhz?=
 =?utf-8?B?U3dlajg5MSt5RTRUQjFPYTJGMVVjQWhVU3Rldkg4a04rdFdONTRKNy9QZlFW?=
 =?utf-8?B?UHdROWlRZmpRN2s4WmlhZmlaSElCN2dkNHJZcWF6VUlVYUs0dW0xS09PRmZz?=
 =?utf-8?B?ZlYyS2dUNXlmMWV5SUduVThONjNaSzdaa29UN0ExSkZLTjZmSHpZOEdIQ3ZI?=
 =?utf-8?B?WDQvTjIyYVc5MDJURjdJSUN0K0pROWRDdjRUcDN1N292ZEpnaXhFNmpZckNI?=
 =?utf-8?B?UG81ZlFkZVR5YnV0MXVYK2lITGNZckQySHdseE90RXVjc0RuMHlkNTNoN0hz?=
 =?utf-8?B?UWZxRjJXeTJURjVLMTh0bTQzdkJxbVc1RUdlNTRMQ1JqbDVQUUpRL2tBSFdV?=
 =?utf-8?B?b1FPWGw4MWVYWXU4anNBamRsZm5oREpqSXJ0NTBJM253Vy9HSWZJWUdNamZ6?=
 =?utf-8?B?RjBYL01qc3JwSjE1cC9MdUQ0QTBCSElIeVZFTnFFSXFsZWZWOFA0cWE0NDJr?=
 =?utf-8?B?WU0zTVp6WFE3ejdsQUcrc29BZ3kxSmsyazNUenZqNmxueWdncHg0eFptWTNM?=
 =?utf-8?B?TXhERi9XNklFZFE3cXducjNJbjBGT2plKzlYQ09ubWp3enZKKzdRSUw1ZS9k?=
 =?utf-8?B?MGxBM2dXcWJhRHRDMTBiVzZWemJYK3NKWUxVN1VjOVVkaElUaGdpc2UyU3dT?=
 =?utf-8?B?SGZwRS9LWGU1NWpCOGhFdmtEaU5RL0xLWjdKYS90MkVCMTkyamwzMytCclU0?=
 =?utf-8?B?ZDJlN21rMCtCbjNodXZ3Q09JR2VnTUJpOGFwdmVTNlpNWEE0UmlyZGowYS9z?=
 =?utf-8?B?TFBObkYzREkvc25qR3hWamxtLzFzZE00dTgwQWdJa0FyVDRLdTNialU1VEJO?=
 =?utf-8?B?aWI4VE1xWHZzbjFKYnIrSmxQZ2FNMkNVL0pZbDhLRlE2UlBGYWxKck9rOFhw?=
 =?utf-8?B?MWM0T1lZZTJTekkwK0QxcUNpQ3JDSjdTWEJqSDRlUFVIZWQvYzNFWEZuMFpy?=
 =?utf-8?B?MDJJOVZJaFFESVRpV0Jmb2pVNGFpZWEzV0NaSEpNOVB2ZllYaUNxVDh6MHA5?=
 =?utf-8?B?Vm5wdTVHWmJzWE5uUFd6cFZDWDR5a3lHdkhub1VXa3ByRzVybFpLcUNsa1pI?=
 =?utf-8?B?ZjJzVFoxTEVvK2pLZm5ZL21FM1F1THdOM0djV1V2blA2QUN4QjZBdExTUE9l?=
 =?utf-8?B?NlJrRFZmcFN4RGg1VGJkdGxHdzNLM2VWZ3NNdGR0dm1nYXNKSXRpYkRpS2ZS?=
 =?utf-8?B?eE9nbG9qSEJMNFpTRFlhY1l0aFJ3eUp0U0ZrQlNlOGhwSXNZVTViUHZtUnRO?=
 =?utf-8?B?WVoxbDYyZGVuMFZidVpTN2RuL3lpd0RCdXhVOG93ejIwdnJMWTlkdFlzaXVI?=
 =?utf-8?B?clBab0lZckNDVG5KK0NMcXkyZUgzTzI0ck15YmFZYk52R1NTR3Nqc1RsOFdK?=
 =?utf-8?B?V0h6alNzTW1lL25xRnkyNHQrWXlGUnc0bGdNam93bk9TbFFmbjFDd0t1ZDNy?=
 =?utf-8?B?cEJDSmhBczVkY25wNDZyS1VYSFY4SFphR25vWjhyMHEzanhOck1kRTQwaUMv?=
 =?utf-8?B?ZjU0bzdKS0lKdk1Jd2ZXMzhkcWRNOC9MZkZUL2YxV1BvRFZqZXp3TUt6OVh4?=
 =?utf-8?B?dHBOK1JPa1E1Q0pMRHo2SDhVU0ljMkpQOWZ4eGlQeE5lNXdBcGF0UHV4NWM5?=
 =?utf-8?B?TFVXTUxRTUxFRUEyNzBNT015K293dzRiR2EvK055YURUbmdPYU5GbXl2UFI3?=
 =?utf-8?Q?Ch03vlpPDUIPNHgk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b9af47-1d9a-48a2-7c15-08da44105d70
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 20:50:30.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iS6OLJYg6LztNxMcDGdqUD3apiwqc6thh+5qXm3T1mSk4mfAq0FGdu7ORgzglq74JaEmvVyzzvF/YkUbsxXt3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4743
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_08:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010083
X-Proofpoint-GUID: Ir1Nl1lAYH_o13L48414qr-4eAJeIrgy
X-Proofpoint-ORIG-GUID: Ir1Nl1lAYH_o13L48414qr-4eAJeIrgy
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/1/22 12:23, Matthew Wilcox (Oracle) wrote:
> Remove the last caller of add_to_page_cache()
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/hugetlbfs/inode.c |  2 +-
>  mm/hugetlb.c         | 14 ++++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
