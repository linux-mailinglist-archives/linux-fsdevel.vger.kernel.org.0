Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC444FC7A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 00:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350493AbiDKWY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 18:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350446AbiDKWYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:24:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE26C1260A;
        Mon, 11 Apr 2022 15:22:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BLtMNK029741;
        Mon, 11 Apr 2022 22:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7yQxWSZr6CA+S56o7AZavkWUkm9ZAavcgrz1ApewKnE=;
 b=avpGzkUNmiRXOfqEqD5TibGp+hwQ6kD6PV3YYdygG+4XMbHczMGDzMTzruGrQQ6W8eP5
 6ZuaZvBV2hyo3plWSNpjMzG8z78HhpyJe1lG2lMyeGb7h4BLNzpwR62MOe6rc07PlECm
 PWaU2WqQcjDKUeA+Jn+9JwsxfXHjzm55w+DOp+gWN10ElqxACOq8Lvzt8j1peI9fv4W2
 Bzl/XhzEIlMp7Ts3Ys5IKjq8xCnCe7jTOtRCTKFmJwGt01IM2cfphVSR/ttvMvCWscQY
 DW5ELkkWO7WM3NaHFwcOJisF3w+4IijXnvJ9F8K2gDhWcON3HL9/M4qFtNpTnYKcI7ee Sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd516a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 22:21:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BMBgl8030770;
        Mon, 11 Apr 2022 22:21:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k2a2t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 22:21:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV8STGb7tmDMGfV21HYCudbuspMODe82sLHbqLJYn8hHUk532aVzijxubePVsOBuRrUOuPiPA+FCTfi49yVMJLneZS78gPBX16hKduoYY1Zm6q44Pwweu6sN3gS+JUAh6Dct4HaZ6vEwMjvf7VJHJjSA2xcIr9K1WYYBdHScGJlwFkXF5tPoPjZFVlu6QR8gulV8JbGzPXRijE4n+DrYM0fTWfc1jwyJGyQMmYrT3y7S+7eq4VX3datjLnZtsAw/8QOAQEV4TFXGABVwokqr1d6kCh610m2dZiWKrGpBEKyB8Ut4raTgy5mXpuXEamyy7Y23RpRSzSg93ESlTWmt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yQxWSZr6CA+S56o7AZavkWUkm9ZAavcgrz1ApewKnE=;
 b=ah2uDGftCyxrQpHk7EVoJqcGlkl70YdCLZYuu1oPkwRBH8h67RDyl3DAiOr0YMKn0y3Lx+MP0BIBdIhj+8pcuz5awIgpEtGGTbQpMr/aSazcSWG1trGUFNrZAkS28SQMhP15BIRX1ub02V89SBJFK7Vnl2iNOomCb3ZZuH0qSgJl3GYKwQg057gFng9iar1PCXrRDWaYPEXZiu48+m3srDNuGyFCJFo84ekjt/lYEvdBk7lJe9go+EHrcjj/WfFSMlF6Hn2Of6EtmOygQ7W56kdBjqP/CqzfgWZrEZ664w0yJ51gkzLMRDrIABppHRCdx6rHvqM5gCuI6cgJtpLiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yQxWSZr6CA+S56o7AZavkWUkm9ZAavcgrz1ApewKnE=;
 b=ooYkFuO5J8OkEz9KCqMKdsz4zHBNRqdgZa+bcBjpS8kHsC40wqqMWz8VOEBlht20zUxVpMyEXQvMz3FMIQmV7/8Pb+DW5wHHVjP0dYRPhD8hbPzt1oV9Bq2aj0FkMa+Nj7uRNbKEuBneKNKxvknu30jEyIwzOSbp/1ICkOTpc/E=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1339.namprd10.prod.outlook.com (2603:10b6:3:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 22:21:34 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 22:21:34 +0000
Message-ID: <7639efe0-a066-1d18-d407-39a9cc1d062b@oracle.com>
Date:   Mon, 11 Apr 2022 16:21:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        hagen@jauu.net, jack@suse.cz, keescook@chromium.org,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, longpeng2@huawei.com, luto@kernel.org,
        markhemm@googlemail.com, pcc@google.com, rppt@kernel.org,
        sieberf@amazon.com, sjpark@amazon.de, surenb@google.com,
        tst@schoebel-theuer.de, yzaikin@google.com
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <87tuazwfcx.fsf@email.froward.int.ebiederm.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <87tuazwfcx.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:806:d2::32) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c32d881-bfd0-49c9-2351-08da1c09a2e1
X-MS-TrafficTypeDiagnostic: DM5PR10MB1339:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1339E19706B87B8B06E0731C86EA9@DM5PR10MB1339.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqOKmHWceyuIZnSJjt2Ankstq5YVYOIbz9LdPiEXdYYKG80NAqHHwkRL8lBqsaYVi4tCVmej0yaZby1mzDs5fAkxPnS7VLatdKfIEpmIFNV4WaC0cNduagAHQ3izQW7CnWjLA/QpBi8TJnm8bCanOVuPXbE3uTfRre9AQ8IjSOMzgiuZdDBBjUimk/fmigetYvR09xfY3oujg0hRNFYdmfxArX2pRJ5UX2j6PH4O/eNlerJk9uO6lx9wqTrwS7iNY766H3ZeeOWP4Mpbr8roGc3wzBq//4NGbleYnrTt5hfOQlNa1e5ifswaHsfPZ8TkmNyEApXt3Ta7qqHhTppgDskB8InZDoO/Cp5WLoWE6byumP3hlkp1iI0aON7NBLmiixDGgpDhSyzpHKJeM/Ph7mGvV+bi6RhrDsPUxzZtQNOhSyuS4o8ejNQo6Aykvj/BaGMK6XFn4lGLjZ7scct9W4CnM1b6LiU5MlN1KwegPUhdsGu1dVbZiXYXZGsxPYFwEzayT+xDUf1D/f4OO9DE5tQaHZzpdhEBcixGu4RoAvEZtjAgczadfpmDjVmu3Rr/+s2MaKZFUM+QmKOHHdIN9w23NVh1eVJeB/exgYwg7f1iqDDgfUMLmlhbzg1I00QQfKhcXhuF3rik//I57WZ6SI6OG39jWeF/PNyA/5+lBm9NkOhDGGzVht0sHtVc+AiaHU/Zx2kKGGH7KT7R+4aHPJJDAk7vtl8zRRMp1EJqjg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(66556008)(83380400001)(38100700002)(36756003)(44832011)(2906002)(316002)(31696002)(4326008)(8676002)(6916009)(508600001)(66476007)(6486002)(5660300002)(8936002)(7416002)(53546011)(26005)(6506007)(186003)(6512007)(31686004)(2616005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlprTDZFSE1ubW5FcTl1V2hHNVpQa3R5VE9UcUk0SE0rZzFkSEpBdUYyRkpp?=
 =?utf-8?B?U1BlVzlyeFJPQzZsTkxRSTJhWWREdnhIMFFzeXRQREdyRXNlQnJuUlBxVU1I?=
 =?utf-8?B?K04zWW01NnFheUFRM29FR3d6WjVDRmg2Y21JTGRNWkRxYWZZZHo4R0R1b3B5?=
 =?utf-8?B?KzdQbkJxZ2N0ZTZaeko3SU5xZjk4enNMYkJ4dDMvTjd5S29VVDhhb0lJbGYy?=
 =?utf-8?B?anUzYU1uRGt6SkNGU1ZxWUc5bUxsOVVZeUNIeGhLQWpwNDdwRFpxSG1xek8y?=
 =?utf-8?B?TkR3ZEtVNFhrRm1BMFhkMkZCTmpHdmhiM0xSdU1HRUVhWkxQMThxQnFpL0Z4?=
 =?utf-8?B?SGJpODREL0JyTUFDRVFpbSt6MUxsbE9oYUphSDQ0dnRuOEk3a1JpQkFpRG43?=
 =?utf-8?B?WGg1V3FSYWtZNlVaMnBOVTlhNjl1THhQNGdldVZQM3dVVmJCcEM5b25VSXo0?=
 =?utf-8?B?Q081TmRxN1oyTXQxWVB1d2FtWk52TGtMNGNPT3VsTVhyOVIyQ0ZoVTZwOVBm?=
 =?utf-8?B?K1AvWlRrOHJWVnZFeVdGbkt1cld5Q1h0b0ltanZCdjMzRXErbHZ1djJjS3RS?=
 =?utf-8?B?aDRUZTZ4WVZZc1loeVB5aWlsdWF6cXIvWWoxOVFWL2Rtemk0T0dTa0UwbjFt?=
 =?utf-8?B?N09DUkl4QVljU1FidVAvRCtlc01oU2huWmR1Y1RwOHdiTzNqMEtzeDZlYXFj?=
 =?utf-8?B?THNQYWF5WE54VC9ZN29LbjVWbDZMQnM2bjI5Um44cjBHbzFIenpTcFZRWnFB?=
 =?utf-8?B?NmQ5TmNIR1MvaW9Yc1BQeWVMMlhwd1dxMEFNNjNsczB4YjZ0Q3hhOFl6U1Er?=
 =?utf-8?B?cnpSUk1UcENEdm9KRGVBKzhURUlKN1Q0WVpSMm9rM3VieWZKSy9SdjVsRHRy?=
 =?utf-8?B?azBRSFBVYWErNjliTkxXMFp0L3hFTHhxNEFGNGVZUGYxcjhqLytPQk5xRHQy?=
 =?utf-8?B?Y3IzSmpCSGlZRVVmZlFvMXB5aTMyWVB6Zy96TmZPRXFVbnE2WFBya2RLd3hK?=
 =?utf-8?B?V0RiTFNDU3lVM0lrU2tmZHY1OExLdXRBQm5GUFhpcWd2dWJXR2NXYmdydmhj?=
 =?utf-8?B?d1dqTzRQa09QTmwxVnFHTXdNVnFZS084aDQrRHdibXVWdXVqOWlOOS8xMC9s?=
 =?utf-8?B?U3o5MFRBdk0wZzBKTkhhLzVIeERFUjJlTy8wcTNlbndkc0NrWUNoY3RldUdn?=
 =?utf-8?B?MTlMVEVjNDduM3pWOXZ0SXBRRzkxd1lKdnhHVVVqNjl1K24waTdLSGNUVjY1?=
 =?utf-8?B?NmFrOXJ2SU5MTGhBbmdEeTFQWFJPRXVVM2k5ZHh1clY4RnQ2bDk4LzlmMmVx?=
 =?utf-8?B?dm4vcGtkQmJ1cksxNVVORWhQS1FlUzFGcHNLQW5YK2VhN2dvRGx5V1Y0WVRH?=
 =?utf-8?B?ZG5sMjVnaEhXWFJ6bkxrZUlnc00wYy9uNmRWSjVWdkRIa09ja1kzYUg5NWla?=
 =?utf-8?B?bUxtUUkrUUxQamJtNkNaTXBhSWswNVdKVFNaeW54WlBsQ1Rqb29RTlNjWXhB?=
 =?utf-8?B?eHJXa0twK2pCR00yekxCcCtrTzhLdkxna2JQbDNpTXhHVWhGMUgvL0s5aC9J?=
 =?utf-8?B?bzh3OTY4UmlUMzZ6OGdDQVd4VHhJb3Z4Z3N0V21CZ3RUNEZPUjlublo4a2Jt?=
 =?utf-8?B?WEM0Y0FvMStYRU5taklvOW5iSU1OZkFQd1I2L0NUQWJZSDZlRWdLbDlPVStu?=
 =?utf-8?B?ZGxVZE1CaHVlTnhWbHI1UEdPRitoQzhHSGlZbTZVTkQzS2ZiYUJwOGZ0MHVJ?=
 =?utf-8?B?alY3elJicFVQSVkweStzSldTKy9XTFJCNlBtT2FFK2lFQ00zOTFBU0xPUXJk?=
 =?utf-8?B?WC9DdkVoQ09keW1mSkU1S3hqblpCUEE4bnN1bDFlTjRCbW1zd1NIcmpaWXJ4?=
 =?utf-8?B?UmVYU3JGOVVCN2phRUhaUklLY0w2S0hYbzI3NUYrRjIzbUNHZmpNSzRXYlkz?=
 =?utf-8?B?aDJkWXZ2MERIN0RsTlNQNHBaaElLSlAzMVVHdHdHMFJ1cVdLKzhCbXBLeTBY?=
 =?utf-8?B?TXV2MTFGb1AxYWhod2V3dW5vV0hieG5md0hrYkd1UHVmWmhMT3F0QSt3VEFi?=
 =?utf-8?B?bWlMUFc4emN5Vmw1M2JGMDd1a3RYK2lwT1E3NmRJSHZrOW16NC8yM2ZjUE9a?=
 =?utf-8?B?eW5FNVNidWlWemxSVjZ2NmtnaVJVNXU5eVJ0am9jb0J6SUFPaTNnajFQcDMw?=
 =?utf-8?B?Tk5DNThBczFrblM3bkhHRVA3aGlyalU5ejI1bTJTZXhPU1A5MDRrWFJNMW1C?=
 =?utf-8?B?YlBidHIrTUFZRVFlMzhZZDB0VlJOOXFjUFpKOFZPQjZ2TWtqMG9OeG4yMUU4?=
 =?utf-8?B?WFNMNjJzVHpsZmFIaXJIV3ZkdENLRlZuTGdNQ2wxUndINU55NmVUZmovOUp5?=
 =?utf-8?Q?1jJm6jMIo0Zk3wDo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c32d881-bfd0-49c9-2351-08da1c09a2e1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 22:21:34.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPhrdR3eC86pin83eWOjb5INbhXcz688cLX0imkC3NSV2LG7WYTQB4dKpPbQRtmdBMAGr7qsaMxSbu3uETrCww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1339
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_09:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110121
X-Proofpoint-ORIG-GUID: 4kmOrMfWRcfI_ysxMbz-1Sqi8kSNGdsL
X-Proofpoint-GUID: 4kmOrMfWRcfI_ysxMbz-1Sqi8kSNGdsL
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/11/22 14:10, Eric W. Biederman wrote:
> Khalid Aziz <khalid.aziz@oracle.com> writes:
> 
>> Page tables in kernel consume some of the memory and as long as number
>> of mappings being maintained is small enough, this space consumed by
>> page tables is not objectionable. When very few memory pages are
>> shared between processes, the number of page table entries (PTEs) to
>> maintain is mostly constrained by the number of pages of memory on the
>> system. As the number of shared pages and the number of times pages
>> are shared goes up, amount of memory consumed by page tables starts to
>> become significant.
>>
>> Some of the field deployments commonly see memory pages shared across
>> 1000s of processes. On x86_64, each page requires a PTE that is only 8
>> bytes long which is very small compared to the 4K page size. When 2000
>> processes map the same page in their address space, each one of them
>> requires 8 bytes for its PTE and together that adds up to 8K of memory
>> just to hold the PTEs for one 4K page. On a database server with 300GB
>> SGA, a system carsh was seen with out-of-memory condition when 1500+
>> clients tried to share this SGA even though the system had 512GB of
>> memory. On this server, in the worst case scenario of all 1500
>> processes mapping every page from SGA would have required 878GB+ for
>> just the PTEs. If these PTEs could be shared, amount of memory saved
>> is very significant.
>>
>> This patch series implements a mechanism in kernel to allow userspace
>> processes to opt into sharing PTEs. It adds two new system calls - (1)
>> mshare(), which can be used by a process to create a region (we will
>> call it mshare'd region) which can be used by other processes to map
>> same pages using shared PTEs, (2) mshare_unlink() which is used to
>> detach from the mshare'd region. Once an mshare'd region is created,
>> other process(es), assuming they have the right permissions, can make
>> the mashare() system call to map the shared pages into their address
>> space using the shared PTEs.  When a process is done using this
>> mshare'd region, it makes a mshare_unlink() system call to end its
>> access. When the last process accessing mshare'd region calls
>> mshare_unlink(), the mshare'd region is torn down and memory used by
>> it is freed.
>>
> 
>>
>> API
>> ===
>>
>> The mshare API consists of two system calls - mshare() and mshare_unlink()
>>
>> --
>> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>>
>> mshare() creates and opens a new, or opens an existing mshare'd
>> region that will be shared at PTE level. "name" refers to shared object
>> name that exists under /sys/fs/mshare. "addr" is the starting address
>> of this shared memory area and length is the size of this area.
>> oflags can be one of:
>>
>> - O_RDONLY opens shared memory area for read only access by everyone
>> - O_RDWR opens shared memory area for read and write access
>> - O_CREAT creates the named shared memory area if it does not exist
>> - O_EXCL If O_CREAT was also specified, and a shared memory area
>>    exists with that name, return an error.
>>
>> mode represents the creation mode for the shared object under
>> /sys/fs/mshare.
>>
>> mshare() returns an error code if it fails, otherwise it returns 0.
>>
> 
> Please don't add system calls that take names.
>   
> Please just open objects on the filesystem and allow multi-instances of
> the filesystem.  Otherwise someone is going to have to come along later
> and implement namespace magic to deal with your new system calls.  You
> already have a filesystem all that is needed to avoid having to
> introduce namespace magic is to simply allow multiple instances of the
> filesystem to be mounted.

Hi Eric,

Thanks for taking the time to provide feedback.

That sounds reasonable. Is something like this more in line with what you are thinking:

fd = open("/sys/fs/mshare/testregion", O_CREAT|O_EXCL, 0400);
mshare(fd, start, end, O_RDWR);

This sequence creates the mshare'd region and assigns it an address range (which may or may not be empty). Then a client 
process would do something like:

fd = open("/sys/fs/mshare/testregion", O_RDONLY);
mshare(fd, start, end, O_RDWR);

which maps the mshare'd region into client process's address space.

> 
> On that note.  Since you have a filesystem, introduce a well known
> name for a directory and in that directory place all of the information
> and possibly control files for your filesystem.  No need to for proc
> files and the like, and if at somepoint you have mount options that
> allow the information to be changed you can have different mounts
> with different values present.

So have the kernel mount msharefs at /sys/fs/mshare and create a file /sys/fs/mshare/info. A read from 
/sys/fs/mshare/info returns what /proc/sys/vm//mshare_size in patch 12 returns. Did I understand that correctly?

> 
> 
> This is must me.  But I find it weird that you don't use mmap
> to place the shared area from the mshare fd into your address space.
> 
> I think I would do:
> 	// Establish the mshare region
> 	addr = mmap(NULL, PGDIR_SIZE, PROT_READ | PROT_WRITE,
> 			MAP_SHARED | MAP_MSHARE, msharefd, 0);
> 
> 	// Remove the mshare region
>          addr2 = mmap(addr, PGDIR_SIZE, PROT_NONE,
>          		MAP_FIXED | MAP_MUNSHARE, msharefd, 0);
> 
> I could see a point of using separate system calls instead of
> adding MAP_SHARE and MAP_UNSHARE flags.

In that case, we can just do away with syscalls completely. For instance, to create mshare'd region, one would:

fd = open("/sys/fs/mshare/testregion", O_CREAT|O_EXCL, 0400);
addr = mmap(NULL, PGDIR_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
or
addr = mmap(myaddr, PGDIR_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, fd, 0);

First mmap using this fd sets the address range which stays the same through out the life of region. To populate data in 
this address range, the process could use mmap/mremap and other mechanisms subsequently.

To map this mshare'd region into its address space, a process would:

struct mshare_info {
         unsigned long start;
         unsigned long size;
} minfo;
fd = open("/sys/fs/mshare/testregion", O_CREAT|O_EXCL, 0400);
read(fd, &minfo, sizeof(struct mshare_info));
addr = mmap(NULL, minfo.size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

When done with mshare'd region, process would unlink("/sys/fs/mshare/testregion").

This changes API significantly but if it results in a cleaner and more maintainable API, I will make the changes.

> 
> What are the locking implications of taking a page fault in the shared
> region?
> 
> Is it a noop or is it going to make some of the nasty locking we have in
> the kernel for things like truncates worse?
> 
> Eric

Handling page fault would require locking mm for the faulting process and host mm which would synchronize any other 
process taking a page fault in the shared region at the same time.

Thanks,
Khalid
