Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF3956A70A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiGGPfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 11:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiGGPfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:35:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1D26575;
        Thu,  7 Jul 2022 08:35:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EguoX032331;
        Thu, 7 Jul 2022 15:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=c4FaWbc+sybBEmWkdrIzJQDpBgrmFveWhHTuLfwJ5UI=;
 b=fWREjY1ufSdaYtB4XRVMKhFtGAAZnHc57MFT9889mMcEXjAid3nD43/7EiZ+dt52b2G1
 iUI65Spgyy7knYtHUvoP0QW8LyVyN7NvP1nkSSq/vW9hY6KSKKuePyzUa3GCBly4d9Lb
 hRClDlHF1VWfnsE20Mnbfyhc9sD6cTixSfgu0I1hkI9t0fX//DeccEG82t3ZXy7xnqfl
 /rCLYuuZ+h4XjXZdNWT36zw36AbrQkS7b66aWcuQ7hHxXCkPSFqZNK8bQOjznU3iQ+V9
 SeMuFlTz86UQAPxBE4jxzN++6o0XhRdCIcwHdpxe8HF75xWQ6xMFtVHIFcFqojXk2HP1 iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubydkgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 15:34:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267FFWP8001718;
        Thu, 7 Jul 2022 15:34:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud91rg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 15:34:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asnL3WysXqvd7f1JxNpPaHzx5gIRY0dL6kt6VzM8PXYWW4mRCuXrEitk5ivek+toeITNyMQjwzx+pXcu/yRDh/YdFoHtRsb998gMCIxLpXkF7lwnloPuJwr/GW9JRUpHjmSTV9nXvva4czq5N68WldK8cCBVwfb+nUu1KHr+uLAoAMa62MrK4rXOE6DCi13tC6gvjT7TjmM8mDZCqQ3ZrXOF+dJrJEpOHH0ABlybtkuW30ggcxrtspTMdP4BsSOHb018GlLOf/4ImPAmNDF3wXld2DIrZk23msJ80Isgza3ps1P9y/mZHj/tSEH6roByghU3mz1NjPA+NKDg92t9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4FaWbc+sybBEmWkdrIzJQDpBgrmFveWhHTuLfwJ5UI=;
 b=LohNplDfQe/sA9pvbw6BgoMkm7PwR4KgiFg7LcghnfPBNLJrWeRTKwfLoAljPK9t4syT98NN94oNCYp9q8PR+ufUQJcW9tTbBycGfdR1j40waIXucDPGkKL4YttUyp1JRu+rDneIvpNu2RLWaVpbZK6wY9CaI64qXGaMGp3YsMJ7a7kk7kmyAppZmevDWFxuk0Rc8Zjt/jN3fWjs0u9Xst3qE95N5Mo7ycYr3BpwzPbQU8yUkpPr42yQahT4JdjpkadSsAtGq3TfM1I9kTacItwfICF86Bju0YEzmI27pwdzhlMtzm6iA2zIGziN0SmKB6xoRg8mMviNi0i0baLTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4FaWbc+sybBEmWkdrIzJQDpBgrmFveWhHTuLfwJ5UI=;
 b=FJ3LBXMXWgNn1o6U7De5p/tuxSYUS1gLoNQjWF3yI2DjWa7kyUeXw1kXmAoJWHAWb809OnagHVsSw167WLzdCVLskp/+mK1ftLDsA/YqvPGG71rOJxbW5nKwbwKWL0cIFyUOdJ1g+8giqF2ES/1et9RnfMNuLNfjQoX4e+0VzxI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 15:34:01 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::71ec:3c08:c336:cc55]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::71ec:3c08:c336:cc55%5]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 15:34:01 +0000
Message-ID: <f210bf7b-d353-91bf-d34f-51387fc7f00c@oracle.com>
Date:   Thu, 7 Jul 2022 09:33:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 8/9] mm/mshare: Add basic page table sharing support
Content-Language: en-US
To:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        willy@infradead.org
Cc:     aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
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
 <7b768f38ad8a8be3aa35ac1e6316e556b121e866.1656531090.git.khalid.aziz@oracle.com>
 <bc5ac335-a08f-a910-fc59-cdcbd86ea726@linux.alibaba.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <bc5ac335-a08f-a910-fc59-cdcbd86ea726@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR12CA0032.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::45) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eea29f1-d7a2-44f9-ddfd-08da602e1dce
X-MS-TrafficTypeDiagnostic: PH0PR10MB4679:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZYfZofnBOYDWyNvpPCSt5DkTxVj0lf26fkjYPE3PqPqWvwg1on7PNw2S6gddb8mGomEkZhEOkYUuOi06mYTChezOHeZQhZuU7bTWuyI9eYTdnLIiP5emBtn0/ORT6NYfjojdth7ZqiIKXm6OlqFko8969AMLRaDxnvFc+2qrKWE7fHh76dj7BxM5YoaLHJqc/ohFulMUoaDo3aNhKRZ36gcc40mBy7rMlDmAYnhiVUX9fGi2I4jc9QKgcYRDEOqW8YvJdK8PX2XPG0pTZEIFRXftDJWFxkW1uDk3aKHfDFKj8QDf3BZXbyDxJHjKPVwZj8PcvWoPCIjCkDqiEtTV8flBZpXrmtF7a34w3K050K9aJT8YFZGPI3eRCqjaSqGLnoUEh7DL3ND2Z93563NahqF5KdeSYne83vGZNrAHJfivDJEr4nIT/MjimQdbkYs+IM/3ZEQxACcPhseP95wrCaSdzihFBVC57hg5YQf0C6OZXDkUMxTWow1ikhu/PJPZuWF37zRPSAXE0f09320WRFYGCS2UAYB+CrB1qDMAnehSlGAqKT9G7LmoKB4SAdNmG8bfoGNcMUOYLG6pg+vDX6W4J9HmPnQnb7CZ7W2WXamfZ+5nTyOnZoSLmQdV9Xb3FCVuhif8b/r5uPptfD0Bg3DmlLaCdAP1s5uqa52GhfM/CF4xlRb5gupoSgZmbXAxxln88tWecDMNjOuTJcIfhprImtYHlPgT5Mc/CNELOwW6M5XWET9d9cXccKk8ScHLi8xu0c5cNnBijkMg/s4lEaQfb/22uN2Dxz2bTRHucpt+Eh5mCHp6TfWws6nGH0jL4WQOVqqiQn7UgPiJsPsZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(346002)(376002)(136003)(316002)(44832011)(31696002)(8936002)(5660300002)(86362001)(7416002)(83380400001)(66476007)(8676002)(26005)(66556008)(6512007)(4326008)(66946007)(2616005)(478600001)(6486002)(38100700002)(53546011)(6666004)(2906002)(186003)(6506007)(36756003)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjVScnp2eDNSWFFPOGozT2QxdmNUWW83TXN6ZkFJd2hrMXNjdVhiV21WbWtQ?=
 =?utf-8?B?QzVsdHNoQzBRSzcyMjdQYk5IdE8rMjJ3QzJJOHM5MGYySVJPUENEZzZOYTdW?=
 =?utf-8?B?STh5b2YzMTVpQUVaT1psR2N6RUMzc0VNYjhLQWdBSEdSb2ptK2NaMDJBWS9t?=
 =?utf-8?B?c2tZN2V3NzZhS002aW5jK2VsdG5JRUdEME1WVFNiaW1GSTVpREdyU0Iwb1FW?=
 =?utf-8?B?eXg0UFRjRVFIem5Sb0h4b0NYaDhUb1p4Q2RTTmJFSVdKa0dMSDF2bzdYUVl6?=
 =?utf-8?B?ZFVYMDN0ellvN1l5SEo5UGZ4VklxQ3BnTjdiM0ZBVlE5c1VNeWxBMXFoL0Vm?=
 =?utf-8?B?QWMwZGxxODhLOFQxYjZQVW1kWU4ybVl4L2RBN1JJSEhXYnY4NXVzK3BnSVV4?=
 =?utf-8?B?NWNIRjlOOEphSHZKQ2R0YjFTZFZmeUdPVnJEQnJOY0szVGdVQXZ4R1N2Ynpj?=
 =?utf-8?B?cU43Nml5TXI3SlhaSWpQaHFtUmdSclhjWXpUQUFXNnB3VDQxNWVXd3lvVWps?=
 =?utf-8?B?TWNac0ZDb1U2bnlQMWJXbURCcy9EcDQ2K0FPb3dLai9OUVFvTlRyTW1JUTR3?=
 =?utf-8?B?NDNNR0pQZGIvQmZodEIyMmhOd0lwL3pjMnZwYTFYOTFGN1dEK1ZNTXVWd0ow?=
 =?utf-8?B?SlI3S0hBUVVMYk9NNlM1N3pFK1lxWEgyc0dUNzY4dWF2bGQ1bk1MYUZyRnZO?=
 =?utf-8?B?TWdGSWh5TTd2UjVPc293aUgwVHY3Z1BOV1B6Y2xZUVZxcWZ2bEJsNlIxc20v?=
 =?utf-8?B?UDBVa0kyTGpuSElPeGFFVnZFemFmVU5JdjdBSjlwRHRvN3Q4YmEyTERMMjdy?=
 =?utf-8?B?VHlOZ0JSOVJXbGZ3TUFIWFhQRERFSVdXZlpJZkh6aW5zd2dQSmtzdUFCbys5?=
 =?utf-8?B?SW1NUk5lWDZYaUtCRmdYd21iNlVEOGJ1UGd2ek91cTNIaXQzSDQwdG1NOTBo?=
 =?utf-8?B?MEp6c2tMWm9jeFZlMlY0OHRCVmRoUlI4b0hiQmdBdkxLTDcwdFl3ZVZJd0gy?=
 =?utf-8?B?a3JSKy9FSzRNRDIxMGlXaXRXOEdnNlljZVdpUUpWWmkzTnRpQkt2QXNZbnVZ?=
 =?utf-8?B?SGxvdmdERkRMTGtpRWhMbTdDZGlDQVNiZlNjc3ZQNHhoSUFjZG8vcUFHQUhT?=
 =?utf-8?B?ZGpvemoxd2JaUGJqL1lrcVNLeldoSERCZ1FvMTAwdkt2L09rZ3VudXozUnhR?=
 =?utf-8?B?YXNGR3BNZ2RqSUdHcjZ5NXpjS1VtNXdjdS9kOHBxaEZ2czJuQlVpMHNSSlJK?=
 =?utf-8?B?SWdDUDdUcjEzcXJhRWNjVjN2UlFrVFFjV3VYV2o3Qndwai9wYnVPbkVYTGUx?=
 =?utf-8?B?dEk2UUVxL0lwR0docVNITGkwZzFwbkNZTkwycHdwY3FJR2VJdTZxTS94bVlZ?=
 =?utf-8?B?cVpOOWU5V3NSRUNKaVc3eHVSdUI1WTNtY0xrT1l2b214cyt4Nk00dXJoUjky?=
 =?utf-8?B?VnpORFZQVFdGNmNJTXAxcERjV3ovVlFJa2VjbFN3UGJDYWFneTJlWEZ2TTVm?=
 =?utf-8?B?VXlkVjFwTTNBSHFlL3RSVGFEUzhzTk1oTVFoa0RScXZuSTlycXN4NU03clNY?=
 =?utf-8?B?b0lzVUdyOXAxTXNpd3RpREJmb2FYMWxEd3pXenNGb0l1NWQrbWkzLy9EK1VH?=
 =?utf-8?B?eTlxaENXdndiSVYrSDVSUUZRRitMWUl1ZzVmenpnZEFZTnpvUThrSUZmYlBh?=
 =?utf-8?B?Qk1PQUQrSWxTVzArb1Z1a0F6Ly9QWnpaek4yaUpPMjliaEN5b1dPbUhxWUkw?=
 =?utf-8?B?YlhUNWpnOExZUWFLRytwcUJRdWM5ZDJaY282UHd0aVlXYVFad0huQkF4NTNr?=
 =?utf-8?B?VzNsN0ZaeVNpbVo5cnlaOExqdEdGWFEyWitrTngwOW5JYjYwcEZsRzhpcWkr?=
 =?utf-8?B?ZnNyck15dVFVUWMrWTVicW40TWxVOUFReUc3eUdBL01XSHRVbVlJUTNDL0Qw?=
 =?utf-8?B?V090Y1czVjhOaG4xRHJDK0NuNVpCclBnRmZFYXJidXd2Vk1WREFCTHNyL3VX?=
 =?utf-8?B?Q1ZtYlVteFNhempaT1pGMGF3aktYemNic3dsMkhreUIyVmRaYzZUeUFqMkJV?=
 =?utf-8?B?VEdVZXkraEVrdWl2NDJDVEw4Um10MkZ4V0hlSlU1b0pHT3l3WDk0NThUOExT?=
 =?utf-8?Q?VaFGX+K9DOkuNpv/ZYNk9gvnq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eea29f1-d7a2-44f9-ddfd-08da602e1dce
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 15:34:01.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ha7yGVj7sDMb9l6bOwMQs2qXKM3DyUzSHr13j41G6dOjlXGbY2J6sjtdEwgJ6An84maYsXj/hQ5gGoX56EDs3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_12:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070061
X-Proofpoint-ORIG-GUID: 38MMWQ8Th-CMWE6lkDs70Wtlt18mKfai
X-Proofpoint-GUID: 38MMWQ8Th-CMWE6lkDs70Wtlt18mKfai
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/7/22 03:13, Xin Hao wrote:
> 
> On 6/30/22 6:53 AM, Khalid Aziz wrote:
>> Add support for creating a new set of shared page tables in a new
>> mm_struct upon mmap of an mshare region. Add page fault handling in
>> this now mshare'd region. Modify exit_mmap path to make sure page
>> tables in the mshare'd regions are kept intact when a process using
>> mshare'd region exits. Clean up mshare mm_struct when the mshare
>> region is deleted. This support is for the process creating mshare
>> region only. Subsequent patches will add support for other processes
>> to be able to map the mshare region.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>   include/linux/mm.h |   2 +
>>   mm/internal.h      |   2 +
>>   mm/memory.c        | 101 +++++++++++++++++++++++++++++-
>>   mm/mshare.c        | 149 ++++++++++++++++++++++++++++++++++++---------
>>   4 files changed, 222 insertions(+), 32 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 0ddc3057f73b..63887f06b37b 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1859,6 +1859,8 @@ void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>>           unsigned long end, unsigned long floor, unsigned long ceiling);
>>   int
>>   copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
>> +int
>> +mshare_copy_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
>>   int follow_pte(struct mm_struct *mm, unsigned long address,
>>              pte_t **ptepp, spinlock_t **ptlp);
>>   int follow_pfn(struct vm_area_struct *vma, unsigned long address,
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 3f2790aea918..6ae7063ac10d 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -861,6 +861,8 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>>   DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>> +extern vm_fault_t find_shared_vma(struct vm_area_struct **vma,
>> +                    unsigned long *addrp);
>>   static inline bool vma_is_shared(const struct vm_area_struct *vma)
>>   {
>>       return vma->vm_flags & VM_SHARED_PT;
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 7a089145cad4..2a8d5b8928f5 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -416,15 +416,20 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>           unlink_anon_vmas(vma);
>>           unlink_file_vma(vma);
>> +        /*
>> +         * There is no page table to be freed for vmas that
>> +         * are mapped in mshare regions
>> +         */
>>           if (is_vm_hugetlb_page(vma)) {
>>               hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
>>                   floor, next ? next->vm_start : ceiling);
>> -        } else {
>> +        } else if (!vma_is_shared(vma)) {
>>               /*
>>                * Optimization: gather nearby vmas into one call down
>>                */
>>               while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>> -                   && !is_vm_hugetlb_page(next)) {
>> +                   && !is_vm_hugetlb_page(next)
>> +                   && !vma_is_shared(next)) {
>>                   vma = next;
>>                   next = vma->vm_next;
>>                   unlink_anon_vmas(vma);
>> @@ -1260,6 +1265,54 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>>       return false;
>>   }
>> +/*
>> + * Copy PTEs for mshare'd pages.
>> + * This code is based upon copy_page_range()
>> + */
>> +int
>> +mshare_copy_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>> +{
>> +    pgd_t *src_pgd, *dst_pgd;
>> +    unsigned long next;
>> +    unsigned long addr = src_vma->vm_start;
>> +    unsigned long end = src_vma->vm_end;
>> +    struct mm_struct *dst_mm = dst_vma->vm_mm;
>> +    struct mm_struct *src_mm = src_vma->vm_mm;
>> +    struct mmu_notifier_range range;
>> +    int ret = 0;
>> +
>> +    mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
>> +                0, src_vma, src_mm, addr, end);
>> +    mmu_notifier_invalidate_range_start(&range);
>> +    /*
>> +     * Disabling preemption is not needed for the write side, as
>> +     * the read side doesn't spin, but goes to the mmap_lock.
>> +     *
>> +     * Use the raw variant of the seqcount_t write API to avoid
>> +     * lockdep complaining about preemptibility.
>> +     */
>> +    mmap_assert_write_locked(src_mm);
>> +    raw_write_seqcount_begin(&src_mm->write_protect_seq);
>> +
>> +    dst_pgd = pgd_offset(dst_mm, addr);
>> +    src_pgd = pgd_offset(src_mm, addr);
>> +    do {
>> +        next = pgd_addr_end(addr, end);
>> +        if (pgd_none_or_clear_bad(src_pgd))
>> +            continue;
>> +        if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
>> +                        addr, next))) {
>> +            ret = -ENOMEM;
>> +            break;
>> +        }
>> +    } while (dst_pgd++, src_pgd++, addr = next, addr != end);
>> +
>> +    raw_write_seqcount_end(&src_mm->write_protect_seq);
>> +    mmu_notifier_invalidate_range_end(&range);
>> +
>> +    return ret;
>> +}
>> +
>>   int
>>   copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>>   {
>> @@ -1628,6 +1681,13 @@ void unmap_page_range(struct mmu_gather *tlb,
>>       pgd_t *pgd;
>>       unsigned long next;
>> +    /*
>> +     * No need to unmap vmas that share page table through
>> +     * mshare region
>> +     */
>> +    if (vma_is_shared(vma))
>> +        return;
>> +
>>       BUG_ON(addr >= end);
>>       tlb_start_vma(tlb, vma);
>>       pgd = pgd_offset(vma->vm_mm, addr);
>> @@ -5113,6 +5173,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>                  unsigned int flags, struct pt_regs *regs)
>>   {
>>       vm_fault_t ret;
>> +    bool shared = false;
>> +    struct mm_struct *orig_mm;
>>       __set_current_state(TASK_RUNNING);
>> @@ -5122,6 +5184,16 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>       /* do counter updates before entering really critical section. */
>>       check_sync_rss_stat(current);
>> +    orig_mm = vma->vm_mm;
>> +    if (unlikely(vma_is_shared(vma))) {
>> +        ret = find_shared_vma(&vma, &address);
>> +        if (ret)
>> +            return ret;
>> +        if (!vma)
>> +            return VM_FAULT_SIGSEGV;
>> +        shared = true;
> if  shared is true,  so it mean the origin vma are replaced, but the code not free the origin vma ?

The original vma is not replaced. Only the pointer for the vma to be used for processing mm fault is updated. Original 
vma continues to be part of vma chain for the process and should not be freed.

Thanks,
Khalid
