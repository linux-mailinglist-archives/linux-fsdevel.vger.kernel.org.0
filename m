Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB484F1B28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379462AbiDDVTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380639AbiDDUqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:46:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7619713E9A;
        Mon,  4 Apr 2022 13:44:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234IsfJ7000752;
        Mon, 4 Apr 2022 20:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+TKFxFAQJo+5O5mPo0UcDTX19wiJC0HX9Ic0l9u6fDk=;
 b=NCPLxLHFPhRm7HwykbLDsHy/yjoDhbh8OTXbhgmzJiBjBl3eYlL7c5cbxKqqbtMYU9t3
 PHTzm32+RgtdAfYN+vBuhQR38C97JGEUMyVSpyJX1Ef7xm/dJnOHYsgsDE0PtZgiyL0e
 HKYN9tDA4TwRKlhxfeItxLF8/44x+76XY1Jsa/zwl13zjmV9ela5tcFDgkUUqFtFPY9Y
 kcWRaHGhhABY+HT/mBt5EITHlaAoTNHtHVxAJ6v3y/XgYHvT9Ms06UKxM0w8fMc4q72p
 TZdB2/XQSaDBKD0zbEtH+FxKvTPRCQ21dNFg68I7Tv0GAy6v2Jv5aUOGBmR968SrzTZ3 Ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3smbxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 20:43:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234KZXf0014519;
        Mon, 4 Apr 2022 20:43:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2s38m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 20:43:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auuas6q5MjzsaMlzj9qgZLk1i7+FQAQ6ZvScBd/r8l3lSXW6wp09lqILaAoc8aCzBZDp9eDm6vrLYMCNgjSa03ZjqPbbyzfai5FQRt3K6x8Nsd5bib93izDdTMaWAAt2EkZRh/Bp7beHgpicJvg4n4z6rHQvFAERRAARUYXwG7w0wak0rp5lpZvpVdUkpRtEms8QQUL6DS+2cPZyMZ4bPIw26XlFUdBUOWEWzSSbPK2b8pc+3ZZMfI90zbCXAsTr6At7cgWMmdc22RsTMf42IJRZWO9YhX+9igU3YoTBkPqePVjXjUAjOpeGmxG7X6V5ab87Jm0JmbiBStdewsAc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TKFxFAQJo+5O5mPo0UcDTX19wiJC0HX9Ic0l9u6fDk=;
 b=TJx3xebQDOhDOeyB4eYg99V4Aek8JOc+Lx46HAPFWyjgmk3sMnP73StLYISS2AB3H4pu7s9b4Lk8NCsz3HSdvOkHnSpfV9Zg+tvI+2vIdekwZ95qCz+zrbBIrnxLB/wRql+jln8BykIHl6eoYM2U4w5woy/f0bZ1eGC4mdoJfLO7I6O6rzLKcwlpx9PLH1jITzPd0a8x/udTl4MJ9MXXsxbUL8ve/VB6+KNQcZCQ5bixXHrAsA5JFer8kWTpvE1IR/uGbR1Kq7W06SSE8pkcZNGKv4pKUhASc5HFEpakb37yp/PEqNMBZdjO/ncv6dFM5W1BXwFZsIoJnMWmxmwSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TKFxFAQJo+5O5mPo0UcDTX19wiJC0HX9Ic0l9u6fDk=;
 b=BcR0B8tOnqzH4LOhKYVdhK9caqra1pf6tAR/NE2HkAUUF+zgI9dpYqoKDVEoaVhZ8O4/LMEUvBHKsoFfeF+S/IIIoA6mvPTAynBj3gg0cRw9cG07jFpipDeuWcDW2+mmOymeFioaVfdtkvvYQV3PQ5cdNOHRIG3mNnz6AQ0jzzM=
Received: from SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19)
 by CY4PR10MB1317.namprd10.prod.outlook.com (2603:10b6:903:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 20:43:38 +0000
Received: from SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::25e3:38e5:fb02:34c1]) by SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::25e3:38e5:fb02:34c1%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 20:43:38 +0000
Message-ID: <d6d05430-aa55-6317-0916-b60232dde339@oracle.com>
Date:   Mon, 4 Apr 2022 16:43:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/1] Add sysctl entry for controlling
 crash_kexec_post_notifiers
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, corbet@lwn.net,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
        ebiggers@google.com, peterz@infradead.org, ying.huang@intel.com,
        mchehab+huawei@kernel.org, Jason@zx2c4.com, daniel@iogearbox.net,
        robh@kernel.org, wangqing@vivo.com, prestwoj@gmail.com,
        dsahern@kernel.org, stephen.s.brennan@oracle.com
References: <20220401202300.12660-1-alejandro.j.jimenez@oracle.com>
 <f2fe220f-70c9-7b95-a9cb-4709752e4bdc@igalia.com>
From:   Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f2fe220f-70c9-7b95-a9cb-4709752e4bdc@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0125.namprd05.prod.outlook.com
 (2603:10b6:803:42::42) To SA1PR10MB5866.namprd10.prod.outlook.com
 (2603:10b6:806:22b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56fe2840-1ecf-48c3-846b-08da167bcbbd
X-MS-TrafficTypeDiagnostic: CY4PR10MB1317:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB13171CAB424DD000CC052DE2C7E59@CY4PR10MB1317.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCrfKADTufALI9gUZ/R3v2tQnXTdtANScWpbd9av6g+wCHp1sjKvJzFydWjXlAo+fxtP8Biy34kneX8xu7WNVhaalhBuEHL8zLEaxZ7tSDme9KhdaLh0ggNCwajXmIquTBvSiC1xUfOGi5umD4beB/A3GMq8aQKBeRf9IC+bsMGy3Ey3E0jHvAMBTcxka1Fj4W3lQ3k/xtgw6DJOW8WeIPAT1pj/Lw5hTypSX8P4Mi1mzIUwJ0/FUxbQ8+ImfWX5Fb8rMEgWZDV19RmnmoLsBsayhFzQspZJhkrUobce5lyUjSo3Zx241xXeTodqLix+x42bRy9o5CBbvT2KpPFNVXESMykP6MFJ09lp8tCzgfrSactoN9FskhdYsXFf2dB3G3dYICU9KjF4Trhd5rfAOS+HhmA0bPHRqr7+o9eFFN8iA2OY1o34q7EYIk+N8K9e7BYL6KQkq0ceetkiHE+jySgloiZtHdNGSUZgWe8bztYZyYmy2Lv9v1HAdr/5yAjV/P8Jparj9bvJ0b+fSdeefQhk1G2Byq9PJiwzjYMhZfE9UGjrMfEPIbw56wyDFfPvH8SOTqFS4Iq+njW4n+ZYUnx0V/ct/+BXirzmyEz8Umm70BzTQffvtd8NxkgvHdiiLBKajZcfG5YeohrO2GJXf/d99cqS09wckjFGggbcVQml1m46LDbt73e1NE24klYWdD0es7pqDWsrnMhXi7u7PClL8FoBEoCslvRlBTWz5kKkm1ei9T3GFNVIT1su73kKRhZrqz39iL/US48j0fJAT7y3WWAJPTXLND32MjOmtHrfrWn3JzaDKZrcfAP2EAgx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5866.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6512007)(316002)(53546011)(31686004)(6506007)(86362001)(36756003)(31696002)(36916002)(6666004)(107886003)(2616005)(8936002)(966005)(6486002)(8676002)(7416002)(4326008)(508600001)(186003)(26005)(66946007)(66556008)(66476007)(38100700002)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhIWTd3T2g5elVLOCtiT0h2d2dzNGpya1pLMXR1NmlKeFNxZlp0dkw3dmkw?=
 =?utf-8?B?RWNVc0ZsK2ZiRjBGSzV2REw4eWRWbnB4T29OUHFObVZkUUJaWWFOdmt5Y1Iz?=
 =?utf-8?B?eHkyY2JxRzA5c2Zrc2UvazJuMVo0THV5eWJXdmNiMkZERDhxWVJZS2piN0NJ?=
 =?utf-8?B?K2l4MTRWNTBQUjhFMlY1YjdiSThBRjhKcDF6amEwT1FtSXhYWVpXc2lzcXZr?=
 =?utf-8?B?QVFvS25QSjNvQks1eTZERCt2MUduTGtobUFOOGZGRE1RaUN3cFVNMmljZGFR?=
 =?utf-8?B?SUNyL2tJZDBBRFN0dG9MeWFkaWgzb0RpZWlWbWExekE3WnFoMngwTm9ZWTdD?=
 =?utf-8?B?cU5UMEd6LzJrNmJ1UVc2VGJEWVpyTnJTRHZCNEY4aFRONWh4bGRGWmNiTzI0?=
 =?utf-8?B?KzUxbkZxZmNNNW9Jdk1uUEd4VUdNTWh1Z2FoZ2R5SDhWNENrY0dHZk0zclFS?=
 =?utf-8?B?QzRvTG5keHUvZEFRU090azIrVlViRlV5YWdyQ1FnTDFqV1ZySisrS2piZ0JI?=
 =?utf-8?B?QjFYNFdCbGo4UVVXazdIUVJjVDZVMSt6VkFodXBTZ0U5d29yblJCSTBzdTA2?=
 =?utf-8?B?a1ROZHY1ZUhTNzdlV3RDQkYrS0o5Y2lnaGUxSDhFbDRxaVg1aGtwTU50UUNV?=
 =?utf-8?B?aXBnUlhVZWxMaWdMdU5vdm5pc1p1V3lJVU94MTRndE4vQmM5NmRyckJxcSty?=
 =?utf-8?B?UVdteWpaOC9pbmZ2MEdmRkJsdzd0T21CVSsrY0FpMlZQWWVpMnUwekdJZWZF?=
 =?utf-8?B?T2lNeWJHYkxjQ2FrMjVFMDdrTWVZV3I4c1dST1dsTHl0bVFvWjJvZ0hWMGZ5?=
 =?utf-8?B?ZlpKQWgvSW51WTY5NnRWVWQ0Q3dxSUxwWElvUkhRbVhhN25IMmMwQU5lajlZ?=
 =?utf-8?B?NnBFZ3FLZUZOeSttMzdvM2dVaHYyaDJjRm1IaFEwUE9TRmJtVXF1T29vQlpI?=
 =?utf-8?B?SXF2dE1FZGtKaUFZOXhZWk1sdmRSQUVGT29pcVpVWXBzZnJPQkxCSnJSS25O?=
 =?utf-8?B?Q2R2dDNCYTExOFJzN3JUYktFUERqUFYvdUE2bFhPNXlsOW9pbWowYjVveXR5?=
 =?utf-8?B?QjRXQ0hoVnZFZUZLNnBlaDJOWC9jWkZTMXdZTUxmYmE0cVBoaWF0dGg0dTgx?=
 =?utf-8?B?MnpuMmQrdC9Ub2tWUklSYmN2a0NNMUx4YUlkZGdGeGxHSkM1cWxuR3puTFUy?=
 =?utf-8?B?QXhBRUUzRGFhYmxOWXYwRDBaQkhPblRBMUhaQi96c1ZmSjBEd01uWTRwYTZr?=
 =?utf-8?B?ZGQ2M0dXSWRzQmcvcmpTUGFvS25RTXN0c0VzZWVHVHd3RjZ0Z2JkZW5TMzhJ?=
 =?utf-8?B?YnVaOFNCbmJOdWcxelhMMDZ0dHJqSCtzWWJvZk52NnI0bkJYcjZEV0IxVnBy?=
 =?utf-8?B?N0hNOEtjR09CMnhNa2sxSkgvMWoybm9aS2swMnIzUVM5c0xZRVdFSG1IWThB?=
 =?utf-8?B?R3pyb3RET0RTUWRIVEdTTGZyV2k4Nkd4UG1lSXpsSjNMdVE3YlUzdVcwS3hT?=
 =?utf-8?B?SXZ5N0phZ1FjdmJmTi92WmRoWmJNZDlxUW9VRUs0MGhIV3ByWjB3bnpXZ1E1?=
 =?utf-8?B?V09jMFQ2Wmk3VnJZdnJtL1RabjlqUEFJaGwzMDV3bnhSZm9hMHF4eGRyWTdQ?=
 =?utf-8?B?WWU3d3R1UmlMQUdlencxWEVZMXpCL3pnbUk4YzF3R1VSR08xa0srQmZiNFZM?=
 =?utf-8?B?dFcrSVd0aDFkNlhidTlLZDJnVFJ6OGNsVHVTUEEyYjBOck9Jb3pOcElFbUF2?=
 =?utf-8?B?MWhsVE9zekxXNmJIVkgvUTIzZHhweXpLTVRMVDV6MkVVSFVYTEkvTFhoQkFr?=
 =?utf-8?B?SjBjWkE2NjdhMGtJSDJYd2paakhtWlI4cWVqOFNiTnh1b1RIQVAwZTBqc2VI?=
 =?utf-8?B?dldZQld1aHZJdjEyTk1meVIwYysyUEw4OEVJV0MwN0R2azZzTnBCckRJejF2?=
 =?utf-8?B?MytsMHdaaTEyT2dxb082RENUZ09jbGJPTHd5QVI1dCt4bHZVN1dmRU03WnV3?=
 =?utf-8?B?WkE0WUc2Q3JCR0Z1TEZHZDBLdGRFN1ZjY2s4OXJoZE5kK0x6Wjl5T084d2ov?=
 =?utf-8?B?RGhKODE2MjErQTMxQW9hZXlmd0VuV3lJQ20xTU1KTDRDRE0wNG9WakpRZGEy?=
 =?utf-8?B?Mk8vOW1MQWFXVFBNMTNiQnRwOUQ1clpSQ1J2OWRWMnFyakwyeXJZczRMT3ho?=
 =?utf-8?B?RGViVnJYdzVlcnhZL3l3MlVDVy9QZnVDRHc0Q2prTUJ0OW5lNERZNHhZYytD?=
 =?utf-8?B?UzVOOXlQcDUvMDdaTzBsNU1nUnZMZlBRWUpmRTFFRkd0WWNGeVlYei9sL2Q3?=
 =?utf-8?B?Vk10VjlQQ09hMktkSmtzWlFTTjdBb2N5bXhZWHdaQUhlUCtPdkhlWkFNbUdP?=
 =?utf-8?Q?xcyIfCiYASGcmhuU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fe2840-1ecf-48c3-846b-08da167bcbbd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5866.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 20:43:38.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25imOyJCKqhAFJqD4VVGX2/24GP75k6Oe41eAFdxlQqfFCEs6BG0BWEwjnJHDh6HXd2X+hFzMuks2nz6VeOmsKoaRdJmZglXlro6WQFv+ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1317
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_09:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040117
X-Proofpoint-ORIG-GUID: 4TNzhfDhBDQbEObJj7ixPBaZOYrgCe1H
X-Proofpoint-GUID: 4TNzhfDhBDQbEObJj7ixPBaZOYrgCe1H
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Guilherme,

On 4/2/2022 10:01 AM, Guilherme G. Piccoli wrote:
> On 01/04/2022 17:22, Alejandro Jimenez wrote:
>> I noticed that in contrast to other kernel core parameters (e.g. kernel.panic,
>> kernel.panic_on_warn, kernel.panic_print) crash_kexec_post_notifiers is not
>> available as a sysctl tunable. I am aware that because it is a kernel core
>> parameter, there is already an entry under:
>>
>>    /sys/module/kernel/parameters/crash_kexec_post_notifiers
>>
>> and that allows us to read/modify it at runtime. However, I thought it should
>> also be available via sysctl, since users that want to read/set this value at
>> runtime might look there first.
>>
>> I believe there is an ongoing effort to clean up kernel/sysctl.c, but it wasn't
>> clear to me if this entry (and perhaps the other panic related entries too)
>> should be placed on kernel/panic.c. I wanted to verify first that this change
>> would be welcomed before doing additional refactoring work.
>>
>> I'd appreciate any comments or suggestions.
>>
>> Thank you,
>> Alejandro
> Hi Alejandro, thanks for you patch. I have a "selfish" concern though,
> I'll expose it here.
>
> I'm working a panic refactor, in order to split the panic notifiers in
> more lists - good summary of this discussion at [0].
> I'm in the half of the patches, hopefully next 2 weeks I have something
> ready to submit (I'll be out next week).
>
> As part of this effort, I plan to have a more fine-grained control of
> this parameter, and it's going to be a sysctl, but not
> "crash_kexec_post_notifiers" - this one should be kept I guess due to
> retro-compatibility, but it'd be a layer on top oh the new one.
It would be great to provide finer control and isolate the riskier 
modifiers.

I am using crash_kexec_post_notifiers to control behavior of pvpanic and 
pstore and there is not an urgent need for my change, so I don't mind 
waiting for the new interface to evolve. Please copy me if possible on 
future submissions.

Thank you,
Alejandro

> With that said, unless you have urgent needs for this patch to be
> reviewed/merged , I'd like to ask you to wait the series and I can loop
> you there, so you may review/comment and see if it fits your use case.
>
> Thanks,
>
>
> Guilherme
>
>
> [0] https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp@alley/

