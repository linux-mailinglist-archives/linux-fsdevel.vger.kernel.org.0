Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850E8561FAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiF3Psv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbiF3Psu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:48:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19FD220F4;
        Thu, 30 Jun 2022 08:48:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UEsTEX009821;
        Thu, 30 Jun 2022 15:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JLWwS/m8sRq9fDmubAA0VIFlByWKniewsJH1B+PTD4U=;
 b=KCNdphqIZR2oN7GbVVngVSyojVtQzp5qJ/fOUZpxUI/bvo5koXkL7iqvi/fvS++X693X
 M96e44dDsQ+NHaYDyMqYQrCUPuhfl8hNsYBviawWRY2fr86p5olzswAp4qX1eGm1pfWb
 TEbDNqpJP0KSqtrJvLZ2V9lHm9u3953ivayA/uD4KV4whfuVtP7uBUtuscy4wt+9xxY1
 rliEU7iG2L7oTxMAN9sTCVEFkNYmFEG5MgeB/Kn224Tac4q5Zj/Vfv2ZVXQBeK1qjZnw
 TWeB99pDVNBm63qyBlrxBrmXzoPiB2Pw1TalQVm6vzggOaTMg/fC5tdmwroG6LbAGMqV /g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwucug4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 15:47:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UFb9YZ018938;
        Thu, 30 Jun 2022 15:47:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt4k23m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 15:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUEO+HQSV2ZcgtzcZYcj9T/fMjVNF3wX3xghbV2uUHReNsiCsVJz9v00jMd0kvPhftbFnx7Vtz3mL1dnP37spcUkHRkr9wzV4poemZtkw1132wPVBaqR2twdm5mcAhV/XAgxaS1yUcgYEAqYRN1PBBi9F0Is7m35F50SAGI8RWlMWr9UOwnY4N9qDnOLtiSq30plGehm6nZznIK9pSxKRN/IGnTiwe4LeO2qVqlm1pmc9g3tZM8+UssoMOdZwczvWxBTPYV7UthjEsNOEzK174k2r789StIEzyDGFHLSXQw0V9ChPdiExrnXo9GnsoyLwTV8WxPs+hmpIKJKOKnuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLWwS/m8sRq9fDmubAA0VIFlByWKniewsJH1B+PTD4U=;
 b=IUvt+PcISSBKGI7W00b8R8kDRZg3FiYu5V+p9CQLXYNnUbig6lXfJN+qvxoCqqlasrOa7HPA9dR+NaSRwr3F5KqktVy0SRWprEeHGgKLqCfLmC7rQSoCRPxarXDYdC3jAetvrGxR7TyLCrjGXCsMlqJp5yPjYtba/+ewH4eJdLEvumgjrTD1cZoFgk8zuZd0gsGUegwLnkw6mmmTvh9jhXi9xy55It39J/l7qadXLO8AQ0SxfLND2EtA9EeQiozRb36vs66nh1OFubd8zVKxL5OiQfteSppkvogI3m8j8FVsYKOgqNdJesm0Kb7zEB+CBwkLC+DXirUk+uzBYaKpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLWwS/m8sRq9fDmubAA0VIFlByWKniewsJH1B+PTD4U=;
 b=ZkXE+MJZvRx8mrZjdQ9eFL5oSnquYvg5ZUoY+F+15yB62benR3lvK1L2r4amSHvWUJtJSImbkWEbJBo87OYHbmHiZ5JIYipwOfVjGqjFewTsvvC/On3a02zhJSy15rzpAKLBcip06K8z3mGGABMspyjCB2/7Nr8VZBvaf/G+QK8=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CY4PR10MB1925.namprd10.prod.outlook.com (2603:10b6:903:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 15:47:01 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.022; Thu, 30 Jun 2022
 15:47:01 +0000
Message-ID: <63d8437e-5e33-5d83-de86-779f5d334ba3@oracle.com>
Date:   Thu, 30 Jun 2022 09:46:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/9] mm/mshare: Add vm flag for shared PTE
Content-Language: en-US
To:     Mark Hemment <markhemm@googlemail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        Kees Cook <keescook@chromium.org>, kirill@shutemov.name,
        kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        luto@kernel.org, pcc@google.com, rppt@kernel.org,
        sieberf@amazon.com, sjpark@amazon.de,
        Suren Baghdasaryan <surenb@google.com>, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <e7606a8ea6360c253b32d14a2dbde9f7818b7eaf.1656531090.git.khalid.aziz@oracle.com>
 <CANe_+Uh--cJvG=N4KEkg63AF2FTtYz9e-Z8N=uwWpuTHMNtwLw@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CANe_+Uh--cJvG=N4KEkg63AF2FTtYz9e-Z8N=uwWpuTHMNtwLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::28) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bab0faee-e3b9-479c-df00-08da5aafc5a4
X-MS-TrafficTypeDiagnostic: CY4PR10MB1925:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIgcynCetD+v3sPfvzGQovo3uLoxfBmmGDPnKhrVGeB2t4h0MKym7qTebmuxE8sVD4bKbys3CF9tQSgWpVKN5UADkg4soQI67+jEv7bWvdPJJT36IomblMs20xcDJbc9o9raTT6/PIxkTPYDG8fG79XPr+YqFKeXLOeZTxvAX+qbghpaLUmVvgaHOgtUo6bLiRHBCzc61j3r87xOmfikjHFGH46lb6W0amtni2DMmLNx4C9pLJtSmVNp0nXnqaSvO17Pu7CiWL/IkpKn8yhUFcpS1emzadfjnKQp+WVmCgAqVv9uq0XyInZn1CHwrFSQ5kzcQsrwjvdwsWb5BGsVb0Wu33fJeHiNPS7oG3+BOap0Rm7z5N9PirssINf+3epUow7U7wF1/2zDdj7VQiA/wnCaZTKR/5Fgr5IKWw3Mx7gW0+RxuvCopWPaHouABsIHnBvI56SSaIfmYd6C+Mp6GEZ2puW1KRiMLL0EUjZ4NSH54ojKbGAv7IhVEW4Q0CySnzIVsDifOMFJMakcN2DmB7Ib+cSkbNHSG7+8oiFvm3Yar5vZjBuqUb3vIv2/5VU2FHhJeoy/diICXcdY4FSyad/cGckVFBIIhd6FixHJmXMqppOh4MUgiSneCRLDcZUd8qyZlPWK/UhT0G1qN60bAHCrqZoJxpRdcjM0HKyExG6AoEF+4fwqLVTHnIDicVtsBRbhgfZgGLNRgF0aqUokWepffcaZscLy5e8yhFvcGp/46Y0C4F/6VSgaaSmS/Yi8WMBz2k4CWX7MrTyJs9izIOdeCut/mXW4VKwlX1y6Mpp7kXvahqKG4lvWrNEzEALs18cLfGO5BjBnB5y41XkBVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(396003)(39860400002)(366004)(186003)(54906003)(44832011)(6916009)(38100700002)(36756003)(31686004)(316002)(2616005)(7416002)(4326008)(86362001)(6486002)(41300700001)(8936002)(6506007)(53546011)(31696002)(5660300002)(6666004)(66946007)(2906002)(6512007)(8676002)(66476007)(66556008)(83380400001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzhiMm10Q1l1RnNOMXR3QnVBRVdMbFR0bkgwMGdoUk5OZElUaFJrMjJ3cHVU?=
 =?utf-8?B?QzFsT3JqbDlBZTJMRC9TUm4vVDFuL2dDbm1tNFFvNGhuQ3FKeEwxZnBXOXFt?=
 =?utf-8?B?dkNaNytmWFFTOWlTZ1p4dU5EN0ZLcUZpTThvNXFsTlpsNExNM3E1c0JBQjNU?=
 =?utf-8?B?Uk5TTmxHaGZvUysxVkYwRmNpQk5mVnlBNzBJYmZqTUFBSTFmWDJPZGI3anRz?=
 =?utf-8?B?NmdQalRsUjdjMzNMa2dSODdYV1hoSkZHWWxtcSt2V2ZGdnoydFZoL1VPcVR4?=
 =?utf-8?B?NGc4Z2g3WElFL1l2aTRHVnkvcDV6VzJEOWRiWWFQS0l6WUorTnlHaFQ2LzNR?=
 =?utf-8?B?L1N1V1RMN3hSb1E1QVM3cVVvZld6ZXVRRmNYV1ptTE0rSXozV3BRWko2czFs?=
 =?utf-8?B?MFZWRWJMb3VGYTVmaDRlNTdFZ0NhcVlMaUxXU0JmampxbmFHRFFIaFJOUUhT?=
 =?utf-8?B?Tm1vQTZtYnV1d0RhZWRhcm9IemxuTTRpWjE1OHBTeEFQUjJQb2ZFMlJ3dENQ?=
 =?utf-8?B?OWhOUmtweWxjeTJadlhydHdxdE8xSFhFWitaVGlPN1RUbVFsaUNpUWhscVNj?=
 =?utf-8?B?SUVjdjVBZUJmUVM3dDNjZEpVQ0plZHphWVRkWWZybzgrQ0VYNGZIajJOYkQr?=
 =?utf-8?B?ZlhCNzFjMkhTRFpjTGhYWXJUZE5TcFZDUHQxbEZ6T3ZRQWFJbi8wNCsxSHdu?=
 =?utf-8?B?emw4dWVDNk94UmQxWldHL2tkMHl6bmtwaCtBUzM3SmFJRHJMVTlzWmc5V09p?=
 =?utf-8?B?WE9sdDdCNDZTMnZDc3NCVjREVnI1VzViMjZHNng3Z1lNZ2ljL3lQZHhLbHpB?=
 =?utf-8?B?OER6amx4aDNHVHF3ZHFXZUxLU3lzQllHQXF5YkE1bjJIUEhaYjBOTnFVamlJ?=
 =?utf-8?B?ZHNaUlk5ZTd5N2h3VnRvQWJ1ZHBDUnM4MnVkRktWemNNUUhuOXErUy9wYk1i?=
 =?utf-8?B?UGl6dm4wcWxPajRITGhuSTh6dUx6aFh6YVNkQ1NYSGErREhZMlYralZMMFFH?=
 =?utf-8?B?VDNpc2FEMyt4NWViR01IZ1F0TnpMV1V5T2phQWlpZURWK3VFeE1BVURkU292?=
 =?utf-8?B?NVprbE9QVm4wYURPZ2h1dW9IWkF6UTJnK01mdkF0ajhGV1p3bVRETXNDT2lx?=
 =?utf-8?B?YVRyVXF0Uzc5SmlqMkw1NG0wTC8ycmNUSVgvVlp0TmRFTXB2cmF4YktoUXF5?=
 =?utf-8?B?aWpHV0V5NWdnMWdvQTAwOStHNHFZSlpMbEJncHVZQmtoSnUvQzBIMVZRbUJz?=
 =?utf-8?B?Qi8xTEhxYU9qWDIrTG1OblNGbnVXenRnUlVqdWZnTWZUSm9IbU5QN1VxRkJw?=
 =?utf-8?B?NDVTczVjT2ZvL0hjWEYydUFmS1IyejlHcU1UTE9FNk5nKzQ3MmRNSlVZczVS?=
 =?utf-8?B?RkpQREQ0bmQ3OVdFZkNSWjR5TlN4elVxRHVmZmZPTUNxY1RuTm9PM2FrSk13?=
 =?utf-8?B?eGZNSCtFbzEra01TQXkvTm9hQmhNU2VEclcraXI2M2hDM0FvQ1RNUktOVDJm?=
 =?utf-8?B?bjF4NUoxTnJCakVmOGtOWDhtdFRMUWpvaWtGdEJYVVRKckJHajloWDlLMWxs?=
 =?utf-8?B?OElRVmNmek9KWFRNQVBBQWJkb2dOclRweGFyRkNmOWl1S1NDOThqS3RWZm1D?=
 =?utf-8?B?a1ZvTFFPOGM5V21qM0JObGRtZWVCZGJEcTNhNllrREZ3ZUtnYnVaaXpuYWVY?=
 =?utf-8?B?SVVsVGFSRGFZeDh2SHh2Y3oxSXFpVll4Z2hNZ1BObThOUGtIVEVhMWF5K0JS?=
 =?utf-8?B?blVzeS9FeldmY0RvbStIOE1PcnpHV1lHVk56Z20ydUhZUm4wdzY4eWJOYTdR?=
 =?utf-8?B?ejNyMmRmQlBVQmpyTGVmWUZQcFJDdGdwcC9lL3lKbXZEME5zZmVQVUtYNCti?=
 =?utf-8?B?UGY5SXJMTUJSSExLdXcrSUxXMzJmbUE3K1Z3a2RaZ1lWSUNrRnZDSnhtdFor?=
 =?utf-8?B?Tmx4QUQvSEZnUnlCL2t1WHFEb2ZEZVBkSVU4dDJSTi9ndUwrS2had3E0aUs1?=
 =?utf-8?B?RnYvdUhzbTRYQWhmaitUOEZFRkxNV2NmNVJqaDlWemFBaU94alBvU2xNQXNu?=
 =?utf-8?B?NC9KbGdsWnpnOXZHTzY3dmRrbGdsQWxJZVkvOXZZanJMSlU3Vm5GS1o5bUJZ?=
 =?utf-8?B?QkdIaFN1ZkZYQ1kzQTZibnhsak02NHBJSk5IWlk1Vm05eUxpUFFPQStuUitt?=
 =?utf-8?B?eUVyYmdKelI3RVlSck5lcXNPNHBOOXZYaUhsYTloS09lcVEySDdod0tUWnY1?=
 =?utf-8?B?TWpHVmZsY09rakV3dmdOVzRTOVhRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab0faee-e3b9-479c-df00-08da5aafc5a4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 15:47:01.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUQ56wvR9TY3O+umAWJv8yu7Mv+fmbjDU73oSAJH3yp1oSLRUxcaF7pH9z1c51RHBUwyZVsUqzZL+fM37NDREw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1925
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_11:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300062
X-Proofpoint-ORIG-GUID: YH1QrYO5UiAD_fTN0fTTsQZTcE9z-lsK
X-Proofpoint-GUID: YH1QrYO5UiAD_fTN0fTTsQZTcE9z-lsK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 08:59, Mark Hemment wrote:
> On Wed, 29 Jun 2022 at 23:54, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
>> a function to determine if a vma shares PTE by checking this flag.
>> This is to be used to find the shared page table entries on page fault
>> for vmas sharing PTE.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>   include/linux/mm.h             | 8 ++++++++
>>   include/trace/events/mmflags.h | 3 ++-
>>   mm/internal.h                  | 5 +++++
>>   3 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index bc8f326be0ce..0ddc3057f73b 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -310,11 +310,13 @@ extern unsigned int kobjsize(const void *objp);
>>   #define VM_HIGH_ARCH_BIT_2     34      /* bit only usable on 64-bit architectures */
>>   #define VM_HIGH_ARCH_BIT_3     35      /* bit only usable on 64-bit architectures */
>>   #define VM_HIGH_ARCH_BIT_4     36      /* bit only usable on 64-bit architectures */
>> +#define VM_HIGH_ARCH_BIT_5     37      /* bit only usable on 64-bit architectures */
>>   #define VM_HIGH_ARCH_0 BIT(VM_HIGH_ARCH_BIT_0)
>>   #define VM_HIGH_ARCH_1 BIT(VM_HIGH_ARCH_BIT_1)
>>   #define VM_HIGH_ARCH_2 BIT(VM_HIGH_ARCH_BIT_2)
>>   #define VM_HIGH_ARCH_3 BIT(VM_HIGH_ARCH_BIT_3)
>>   #define VM_HIGH_ARCH_4 BIT(VM_HIGH_ARCH_BIT_4)
>> +#define VM_HIGH_ARCH_5 BIT(VM_HIGH_ARCH_BIT_5)
>>   #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>>
>>   #ifdef CONFIG_ARCH_HAS_PKEYS
>> @@ -356,6 +358,12 @@ extern unsigned int kobjsize(const void *objp);
>>   # define VM_MTE_ALLOWED        VM_NONE
>>   #endif
>>
>> +#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
>> +#define VM_SHARED_PT   VM_HIGH_ARCH_5
>> +#else
>> +#define VM_SHARED_PT   0
>> +#endif
>> +
> 
> I'm not clear why mshare is using high-vma flags for VM_SHARED_PT.
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS might not be defined, making mshare
> unsupported (or, rather, broken).
> Is this being done as there is a shortage of non-high flags?
> 0x00000800 is available, although it appears to be the last one (quick
> check).
> (When using the last 'normal' flag bit, good idea to highlight this in
> the cover letter.)

It indeed is because of shortage of non-high flag. 0x00000800 is the only non-high flag available and I am inclined to 
leave that last flag for more fundamental features. Then again if we want to move hugetlbfs page table sharing code over 
to mshare base code, it might be necessary to consume that last flag. Nevertheless, mshare code should not break if 
high-vma flags are not available. I definitely need to fix that.

Thanks,
Khalid

> 
>>   #ifndef VM_GROWSUP
>>   # define VM_GROWSUP    VM_NONE
>>   #endif
>> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
>> index e87cb2b80ed3..30e56cbac99b 100644
>> --- a/include/trace/events/mmflags.h
>> +++ b/include/trace/events/mmflags.h
>> @@ -194,7 +194,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,  "softdirty"     )               \
>>          {VM_MIXEDMAP,                   "mixedmap"      },              \
>>          {VM_HUGEPAGE,                   "hugepage"      },              \
>>          {VM_NOHUGEPAGE,                 "nohugepage"    },              \
>> -       {VM_MERGEABLE,                  "mergeable"     }               \
>> +       {VM_MERGEABLE,                  "mergeable"     },              \
>> +       {VM_SHARED_PT,                  "sharedpt"      }               \
>>
>>   #define show_vma_flags(flags)                                          \
>>          (flags) ? __print_flags(flags, "|",                             \
>> diff --git a/mm/internal.h b/mm/internal.h
>> index c0f8fbe0445b..3f2790aea918 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -861,4 +861,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>>
>>   DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>>
>> +static inline bool vma_is_shared(const struct vm_area_struct *vma)
>> +{
>> +       return vma->vm_flags & VM_SHARED_PT;
>> +}
>> +
>>   #endif /* __MM_INTERNAL_H */
>> --
>> 2.32.0
>>

