Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61444FC54F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 21:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349733AbiDKTzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 15:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349727AbiDKTzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:55:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0346275CC;
        Mon, 11 Apr 2022 12:53:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BHOt4R022836;
        Mon, 11 Apr 2022 19:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vg5pLD57yQsHwsl1nHImwnlbBzcs+R3a/R2V9QWe6z8=;
 b=AfRwd9Th8mC/hTBTNVSu495XBEgqx3Z5wxK/uJj1MQs9z7SsSatNzD99QTlCOC4m2CgI
 KvMy/Jhff9Mmz2A0h+ShhvHrqeQzxxJq9TRY/Uoro6ealyjLRcHM88qfDi93hetXyDoM
 +1kmTdKQeif2jp+bR8WTIQm6guCLJtgaFDJj75DcNoLqRdzRybI3E34BfmtA000+aiGV
 JyuD/V1Ypu4elYTLU2okZD8iw4jMNddqhhhDFxzFYi+jtS6sseKHHrYz/4qVXYHSmETQ
 DimsdjVfjioEQs0dleViiAfPrpKVmseOfw5pt3CRLU8kbVy7IiGz6c6C/0QKx5JGXpG/ lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd4r9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 19:52:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BJjh76034745;
        Mon, 11 Apr 2022 19:52:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k26rjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 19:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmuG2Tfu1N04O53bcEkaF2Ppuc/SytYXRlHC+0/cjpuzQ4w1pBc7a0eogt2QYYD8kwh44IBW2KZ41YMQx57SYxsPZjjG/TaIIWgGV5W2r944+pWrky1W1Pq/dywpoRwc8u17qaWWZ3iIpxOGeRiEvXf3enPGC0ToHphPBnzV4ofJVe8i57MqslnapM2JEIqm/+VQApR2seOpD4TnIzsN8ILVyKvT2Mdsnw0FlF05DMcyutDqGVjkYoBCh/VmfRdzGIRTZVS8DGUgzr0+EfaNMyosISarOEko/2tMjrLWmkLpAjQtEMoDdcP9OfnvulgkUieNwQ7gmdro3PH1d1h0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg5pLD57yQsHwsl1nHImwnlbBzcs+R3a/R2V9QWe6z8=;
 b=K5NATJhnr00ppwazpmDrw5YCkkTxGvChI+EmAhNr5PjKPr3VPGy87t3RnThCAY0tgXrqYNEbNwi0hQX4gnC2jr7rd7rkV2MMJ/N/DL5Ix90Yux6RKzfrfKwgiuewxPG4lnU1qSScDGhxxe9NBT9VP+OOkWPfLAs+mAbGOItjKwSbjf2+yN/kUexm0NXu1FwaF+kHy9shjy0Ijgu3+j0WNlp9hnFA8pogvKby1GfKZUG9bkeu85ncvZ/sGmh3+ddY0rHH2QL8msf5waWIoF5swW3yPQDeNR3lYmDf2PrslgZ4AMp733O2vyE3YvKlB9nuHk14qFjs+EayH+nsXPoTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg5pLD57yQsHwsl1nHImwnlbBzcs+R3a/R2V9QWe6z8=;
 b=DEIaziVCAlGksg8Gll4xm2o7hk2vhWnzqbV+OdcHZrDqe4WF0C8Z19Iwu6ovNNMvb5LMUcDs/yTBfl4WuWpr3eI9VyMgiox0SSUKccf5YVEYcglB7xbdLNC1O3wH6wF+Jb0VJ+Sk2s9mSKLhaIj3yG7o8gVIrUVLIu3QW66KW0U=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by MWHPR1001MB2159.namprd10.prod.outlook.com (2603:10b6:301:2c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 19:52:37 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 19:52:37 +0000
Message-ID: <fe797b58-bd46-754d-17d2-a19e7ce1bf40@oracle.com>
Date:   Mon, 11 Apr 2022 13:52:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <YlRnPstOywJzxUib@casper.infradead.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <YlRnPstOywJzxUib@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e9d910b-f63a-4edf-6279-08da1bf4d418
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2159:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2159321AF8948B6602AC604286EA9@MWHPR1001MB2159.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIjC1TZpSlHIGuiDNpZSpw8SZlsCjj5lS2LI64cnwy9DmZ/BVqr5XFBmbr3IVvM++Ck9BnUvxCYlOfq4STliA9CneR/pg7vYKzcOfeCBDY9ZDPpZOGT/YOC7QcfUlgAuaHVjPTiBSha4dkTd5olApPH6yt2OVe+IoDKaQTLAZJVaTF6h4JGNpOOcwaRnt1in57SylKewQtidnqfPnYrrjVyvD/2hHPca1yfz/OzBhDwNaWlXCZaNGMcuGNAUnCDjXRlC0/tcJLTXLSo59WjdStRIntappXLFF5NTalzjuONprtxdqs1G1fWtPKlJEJ4tC0FPyEXAYfBpbgT+lsoF0NIdkMHe6pWsw22gT8L8jST5cHM0ed+v7I8q+4kGPXFsKisXgror0utg5d/v/euDMt/C/p/KcYfakalfSuPxX8d6Ly1s+c0NapXLRy7pxptVMV8L3x2oJ1hPo4eSQhKfEpucISEWqf8mEl4UpDG82DYyBDDdFfAg+g/gSS6bAm9ASkjvRejYTZ05vLK/neGxDmOyFZHOVECoBcdsdx+vMOWEOfDDWoJyo0eP3Hx0kfudUA/DeBZnryKMompldyHSy+uJztjG77LGY58C9KzFgln/U+7g//6HTv/PSRsOf+boucmAbnrhWvJgO4+73B6MtgWFRZ5pHf9mfjs5M3X6Wr6uZYFEczUOyiedIqkynh/GEVPe1Ctan9iFeo10IedU9BzSr25NYgEAtppwJEetv9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(6666004)(508600001)(6486002)(83380400001)(86362001)(31686004)(31696002)(36756003)(38100700002)(6506007)(2616005)(53546011)(6512007)(44832011)(2906002)(5660300002)(7416002)(66556008)(186003)(66476007)(66946007)(8936002)(4326008)(8676002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDc3MlMxNU1qeUVzbnA1eE8wbmJrdmhOdVFJYUplUXk4NitsZU0wMnNBcVpr?=
 =?utf-8?B?NDlqdDVoeVVGK29VM2R5YWdPOVJQWXNVdTZSMEdqa0tRNE1ScjdKS3VTMXVs?=
 =?utf-8?B?dUdwcUY1OXQzTkQwcm84RS94cmh5cFUwV1ZEcmpmeWhma25mOGJXVjFBY3R3?=
 =?utf-8?B?azgvNEdDN2kvRjN1cmhMTEV4dEx1cGVSclhyU2ZJMThES0tWeUt2OEo3ZEt4?=
 =?utf-8?B?YUV5NEhTSzZtQU1OazN4Unp5SGdQRm8zb2VKL3d1L1pqVzRqRGR1SjB1VEFD?=
 =?utf-8?B?TFJmNCs2Q2ZkN2F6NGtNekl2NnVVSGVZL0xKeldPbmVBTldiaXdTWVYyUTlm?=
 =?utf-8?B?SHNma3Bva1ZRY0oxMTRwalBkTGgyTHhjMHk2ZlY1Nm1OUzEvYmNSRkdLV1Fy?=
 =?utf-8?B?ZjBBN2J0TVBWNCtxSWdOS0RjYjFpbDQ2cXp3Vmg1UEdudHdhTHB6a1VWdFJY?=
 =?utf-8?B?SkZZeHozaHpCaDh0OERBSWxnRzlyUTB5U2w5VmhjVm9iQk92YWFEUW9GSUFF?=
 =?utf-8?B?Rk5CL0xxd3NkUXRrdWpzRE9ZN0NKYmxmWTdaWVp6bFlkSmFoRElXVVRtSXZC?=
 =?utf-8?B?MHdSa0praHRHcVdTY3c0TnhYZXhCOEJRdmFMbVdLdzBpa21oUWZjMHVlZElM?=
 =?utf-8?B?Qm1ZVnJrWVVGSklEaGtLbDBPWlJDb2ovTzllZjQ1a3BJL1BmekJlUFJTcDh3?=
 =?utf-8?B?VVIvdnJ2dXY5cmUyM0x2S2hIemdnWXVYd0xSOWxxdW56YUl2OHB6RGlnRjUv?=
 =?utf-8?B?SVhPWXJNSitPbVp5cUlaeGVtVDVzc0lGVUJLWFpLdWVNVzUwOGNQU21CMEt2?=
 =?utf-8?B?TEVkaHVLZzJqdnBPTnZtTkRHNDBnaS9KdFYxazRGZmF0ZjRaSWFnZ1JOWGxq?=
 =?utf-8?B?ZXF2TnlzcW9mK1NoVy9vbURRTndnR3pnTFp6UUxjZjFCRm4yMFRYT2JYQmpM?=
 =?utf-8?B?dzI3dURWc2Q1OFNCc0VMck91Q2djMis1YXFzTit4MnhmdHhCbG9kL3h0YmRI?=
 =?utf-8?B?akNpSk9sQnNoOXRQeTh1Q3gyY2szajFlK2Q3RC9DQmo2amd4eXhxUnliN0Fs?=
 =?utf-8?B?NVlmMEtFNXFkVFljcmhiRFdTRFhIdGMyR3A1UFB0VWUra1RvRW5rVmdSYnZs?=
 =?utf-8?B?bk1NalJzVE9ZWG16VjZ0WnRBbFlId1lzeUF5L3dQYWpqQmIyNUpobHlIUkps?=
 =?utf-8?B?WWNxY3d6Sms4U2xBQzVPZnBpbjVsMUZUYXJYVTlaY0RhTU5GL1BKcCtvSWNT?=
 =?utf-8?B?cGxvVkxFdDI5TW5xb1NTZ0tmL1crL0hSOVQxV29pTVYxd1RnR25Ib0xXLzVI?=
 =?utf-8?B?NUZjbXBiQWlWMXBzQkJzamQzbXF3eHJSY2Z0TnRjZGJrM0h4dmlSQ3llbi9B?=
 =?utf-8?B?K1FOZFljTnVKMTgySjhRYjBjcnZZa2k2RmljYnZMbGg3ZGdyaEoxU00yZ1cz?=
 =?utf-8?B?UVdocCt4aWdiUkEyNjQ3TkJ3Rk1QSWQraDlnc3plOXZDN29VbXNZSVA0dlFY?=
 =?utf-8?B?anRLTDdpT1VuUTRTRTZCemhVSWJ0UHBHREJkSjlLcmdzdXVhNmN4WjZrOUVQ?=
 =?utf-8?B?OXRRdVI5VGl3WE82NlA2bTgrZC9SazFhc1BpZENYRFhVNEZEczhXUExtYzlw?=
 =?utf-8?B?Tk5UdWFkNGpCVlAvVFpUNUFxTlE0a3RsdElLb21DcnRQZlNhR1ZvTXI5eHMw?=
 =?utf-8?B?cjhKQ01qNUM5bnhSUHhwL1BISm93UG5LckdLcUdkSXBxN3lRMEtzNUJzSlZT?=
 =?utf-8?B?bUJ5TExVM1M4QTArL25XRDI1M290MW12VkU2VmU1WW1IZ2hKUHZkb1ZlRHpI?=
 =?utf-8?B?NFY5dHo2dWNjcWcwMzI1YjJsR2hyVEhaSjRJM3dpbFpTVlhiT2JlVGVyc3V1?=
 =?utf-8?B?TVBObUl0Q0l5d2FaSVdJOUgxbU8weFVMMURzZ1FPckhyMjQ3ZTY1U1Y2S1NR?=
 =?utf-8?B?S2REdEM1S3V0ZGNBNHpMQjVOZkxNOG9tZ3I0VTVGOHh5VXNaN3ZhK2xhMnc1?=
 =?utf-8?B?aXl4ZDNlQ1Z0TGR1cVNlZDdUSmRVOGZFNTNETUlIWUU5M3ZvRVQvQkRzRjZX?=
 =?utf-8?B?djBUVEMvMFBTT01rN0VrSDd0cUxqblR4TjBramJleUlFTVdRendjNXN5Sk1m?=
 =?utf-8?B?WHdnZktJMGxmLzE4dXFPZzRMQ2VGTFRoWUo4QUQ2bk5JS0VpQmFLWlNaVHdQ?=
 =?utf-8?B?c1dDcVRxckI2SHB0RkV2N05TSzdVSzQrUTltY2FiUDV6QjNMRTcwZzZrMExQ?=
 =?utf-8?B?T1F1Z3lhdUFLeXB2WFBwQU40eXJrTFpPdWVTbHRlN01YTis2d2FFNU43SlR5?=
 =?utf-8?B?dXVFUXlIVjJMaTVnVGsxeXRBWVhXZDhXSlkvdEFQd0FEUXlWa01DbTdoTUR5?=
 =?utf-8?Q?vS/2Az6ZVlt0b/II=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9d910b-f63a-4edf-6279-08da1bf4d418
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 19:52:37.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H9ZYs+OjDHNp4/rVIgsobbdgKI8AmVtaKLQ+smLxlaifuIJhAxNkNp2d0byDXEs33riQv5fc7klXcG4inuFcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2159
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_08:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=988 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110110
X-Proofpoint-ORIG-GUID: YW4OHrEMqfoKlDqNCmFW0yIangeyi5jI
X-Proofpoint-GUID: YW4OHrEMqfoKlDqNCmFW0yIangeyi5jI
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/11/22 11:37, Matthew Wilcox wrote:
> On Mon, Apr 11, 2022 at 10:05:44AM -0600, Khalid Aziz wrote:
>> Page tables in kernel consume some of the memory and as long as number
>> of mappings being maintained is small enough, this space consumed by
>> page tables is not objectionable. When very few memory pages are
>> shared between processes, the number of page table entries (PTEs) to
>> maintain is mostly constrained by the number of pages of memory on the
>> system. As the number of shared pages and the number of times pages
>> are shared goes up, amount of memory consumed by page tables starts to
>> become significant.
> 
> All of this is true.  However, I've found a lot of people don't see this
> as compelling.  I've had more success explaining this from a different
> direction:
> 
> --- 8< ---
> 
> Linux supports processes which share all of their address space (threads)
> and processes that share none of their address space (tasks).  We propose
> a useful intermediate model where two or more cooperating processes
> can choose to share portions of their address space with each other.
> The shared portion is referred to by a file descriptor which processes
> can choose to attach to their own address space.
> 
> Modifications to the shared region affect all processes sharing
> that region, just as changes by one thread affect all threads in a
> multithreaded program.  This implies a certain level of trust between
> the different processes (ie malicious processes should not be allowed
> access to the mshared region).
> 
> --- 8< ---
> 
> Another argument that MM developers find compelling is that we can reduce
> some of the complexity in hugetlbfs where it has the ability to share
> page tables between processes.

This all sounds reasonable.

> 
> One objection that was raised is that the mechanism for starting the
> shared region is a bit clunky.  Did you investigate the proposed approach
> of creating an empty address space, attaching to it and using an fd-based
> mmap to modify its contents?

I want to make sure I understand this correctly. In the example I gave, the process creating mshare'd region maps in the 
address space first possibly using mmap(). It then calls mshare() to share this already-mapped region. Are you 
suggesting that the process be able to call mshare() before mapping in address range and then map things into that 
address range later? If yes, it is my intent to support that after the initial implementation as expansion of original 
concept.

> 
>> int mshare_unlink(char *name)
>>
>> A shared address range created by mshare() can be destroyed using
>> mshare_unlink() which removes the  shared named object. Once all
>> processes have unmapped the shared object, the shared address range
>> references are de-allocated and destroyed.
>>
>> mshare_unlink() returns 0 on success or -1 on error.
> 
> Can you explain why this is a syscall instead of being a library
> function which does
> 
> 	int dirfd = open("/sys/fs/mshare");
> 	err = unlinkat(dirfd, name, 0);
> 	close(dirfd);
> 	return err;

mshare_unlink can be simple unlink on the file in msharefs. API will be asymmetrical in that creating mshare'd region is 
a syscall while tearing it down is a file op. I don't mind saving a syscall slot. Would you prefer it that way?

> 
> Does msharefs support creating directories, so that we can use file
> permissions to limit who can see the sharable files?  Or is it strictly
> a single-level-deep hierarchy?
> 

For now msharefs is single-level-deep. It can be expanded to support directories to limit visibility of filenames. Would 
you prefer to see it support directories from the beginning or can that be a future expansion of this feature?

Thanks,
Khalid

