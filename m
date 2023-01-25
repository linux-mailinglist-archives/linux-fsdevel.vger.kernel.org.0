Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67EB67B686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjAYQDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 11:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAYQDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:03:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2579740;
        Wed, 25 Jan 2023 08:03:15 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFQ1QA028041;
        Wed, 25 Jan 2023 16:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=saFD4DzkqiAr5h47onbY+I2Ylu6WEFKeZQsDaAEUvDw=;
 b=CHZd9n4mVCpRnxjSWK7zfJ7IGnFPRqZIkVdWvLNRUson3wplzt5UQUOR4ZeC4e2wNP5O
 miL8kB6+yPwUVbGL/l0FHHqX6xAOamdRPC8VEPOroS0P84n2Wh2Ts8ULAEW0dohJbw/f
 jiMkjDexDRrA/lbrXvb9wC/Iq/T/e06YygjvHabM/sQXbydyGezp/+97mhK1hJlJDpey
 BAo5ZnyRSHtV55aB96AuMYfvuMZBkva7ANRBN45AkthoffNNhEkbEBfYT9CDPE82HSFY
 683UzhUGKqjozblVSyId4Impr3qgp+l15JQRJia2hltUekGXGKWS/vnJ/tMqdMSR9EJC yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ku07vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 16:01:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PEtuOu019389;
        Wed, 25 Jan 2023 16:01:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gd2e84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 16:01:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5l8eR6HLTJQF/h70CJWEWgdZlJ3eDDKfTika3H7ZvMgoPgnd5w19vn7XQ9KvHwx1u0nRudCK2ZYAfDiEMq+suOkS/bm5ZIl/Dk9kmQg5rAtjkpFNgoYto9uKlH7JqGiLkiT0chn22zrncTz0jUZl7pQh9QvxvtGzUzuEtQ2ZOjuZKQiyRDu+hXccaKVLwFqOSDWVYQqfXXNW9Dh531MNHThOZo6hXkRtvqrqpbT9vsMW7cahupEKVymuKgOSixlx28DdERev0KdMUdNrDwi8qhMDhvNVwbf4JqWaenyiojb+/XttzPP48QxQtHxfI//jnZ24nF/n0A4Jp3+JOj8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saFD4DzkqiAr5h47onbY+I2Ylu6WEFKeZQsDaAEUvDw=;
 b=L0uzoRlFmsvnUaFoCc4NWj2xy8bVgU0eJIRegy/fIlv7YfX4Zb0F8h4+Sz1bR8lIQ+TWbWrkUDAQNlGD6UDFY69m/0p10t3ajmk1G63EacrwSYjxWjgPDDciGqaB0mG43VTRc/tcISZDH6Hwtw14ojJ1O0ybwdFS0IFbW9OceDZyR3iaKyJzwdT8jXQP1siQXz+qEzat73Q3AgEe2JBabAxFT6wd7KGWMoUS7qwB2N/yXp20zw+CZdprbMxJ+8SGmaFaE2RJCFbjDnZAwabnRfBz7Y1Y2G6ukzfrTCmM3OIl3BzTj7MAP+BdsyhomePNy0DtlTIY23k6ouaQcxYhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saFD4DzkqiAr5h47onbY+I2Ylu6WEFKeZQsDaAEUvDw=;
 b=B4RO2G6fj248eldGDI2+HbX54KDFJ6xykRmmrktF6ReInoIIsJUDWAIoOCkxlcromKOC9PwlwBkoqybJEeCgof4cIn6oHJVCifjAv8JFGXckTyTRCRRcH7EICEidvDF0t00qsNeCepDPSAB9REEGmpU0BrpG98CY1/6N/uLIFQc=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Wed, 25 Jan
 2023 16:01:18 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::1316:4a15:2f17:cadf]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::1316:4a15:2f17:cadf%7]) with mapi id 15.20.6043.020; Wed, 25 Jan 2023
 16:01:17 +0000
Message-ID: <5193efe2-7c49-2490-7d17-030088fe6f55@oracle.com>
Date:   Wed, 25 Jan 2023 16:01:05 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com, Liam Merwick <liam.merwick@oracle.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <48953bf2-cee9-f818-dc50-5fb5b9b410bf@oracle.com>
 <Y9B1yiRR8DpANAEo@google.com>
 <20230125125321.yvsivupbbaqkb7a5@box.shutemov.name>
From:   Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <20230125125321.yvsivupbbaqkb7a5@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::11) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c5729b-dee7-41b9-6e13-08dafeed6464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQI1tQpCb3zNimJuMCUGL2JKI/hI4cEnj8YsM1+XHkhPQNHU8i1737wPq0Rwbmk/5+29U3HsULhp89Y+f7zQlyBvGDqze3LisjiMjU6jnjCqxGyrasRLA747ovnvN1plqQuAdqKWr42Eu3QvrkbExSqqoZhGu/X8RbtbA24qnRDsM2877+2HsOzUQlaPDpmabnvvivfQ4XlS4FQRW5UHt5NSAJkiXYfaTkTdtYhBlLvHKyFKmBX0OINPiTzPbNB29eceEwPmNM/pU5tXTGtxwUoMjbLQXErnboSYJy/bditHqMfBKNNH9P0u8V9WMzv44y8JuNkyHsAlXrU00U95dtwM9EDueQoBZbjPOtV9NrdmcTt/a1PJ1V37L70YwAuflMn8kBzjmzwyvlameXGu+1XVOtVlB4GGDJ1230sRBlEeLylRlxUWNy7CK37MjHM5ZHm3p092h2YwEaruS/0F8Dpuu/DiWmpdrBTzbxaBE/BQxNM78Kmz0nKPHbpq4xv5Q5PSUvUJrIOX3bq1UOS2icJDuY6zVXz1B/6ZBps6JDLPNN90s3mmwehBeLysr4O7RBp724z6sSGopxl/Quq4TPvABPbbDxXDxu1/r6FeMLSjn32zEhi6v+8it/wx+99SOyE8Qla+kTwPc5EMNM8Djk+qsg3VmOSAWepwKJuCZrlFrPc3Y38gSU4x2SjMFOs3ZSszAs+sWorRgN3xjT5IHVWQqYnywb+rYeSG+4YEjX92mm3Sq7391cLVe0mdplA4HcPZWB0erB9TIrxsrMZrXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199018)(5660300002)(2906002)(7366002)(478600001)(7406005)(8936002)(6512007)(53546011)(4326008)(31696002)(86362001)(41300700001)(31686004)(36756003)(38100700002)(110136005)(54906003)(316002)(44832011)(26005)(186003)(7416002)(6486002)(6666004)(6506007)(66556008)(8676002)(66946007)(66476007)(2616005)(83380400001)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1JkcnU2YURKK1p1U01hZU1DSzEvTk1zWWxhekpJb3VzSExGN3F3RGt1cFd5?=
 =?utf-8?B?NzJYME9PZXB1b3d1VXJQRFVtQ0s1elU4WGhMNnlQdWE2L1Jjbkl4RlhRb1ZK?=
 =?utf-8?B?M2NOS3FBWmFNREZQd0RLcUREQUpyZ1BqYWtsV0pWQzkrL2tjaEpZK1hCdnJJ?=
 =?utf-8?B?MmdLNC8rOFpiRC9zMUIrVVRWRGFaeTBGTUFBdzQxdjFiWUVTKzhZN0FibXZx?=
 =?utf-8?B?U2R6TzVERTkrYWE4MzYyVEhLZmlqTEoyOUNzWEZXR0xmVHRWdnNFY2tHUDJz?=
 =?utf-8?B?QXQ3Y0ltMFdzVXZMaUpZK3l2NGlldHU5VnY5NWNsaW1sdkl6anN1bTh0WHBL?=
 =?utf-8?B?aE9CMS9kSnhYSXhFREJHM2JaVFRVcjQ1cHo3SHhVdWlxa0ZyeGFOLzA2cHdv?=
 =?utf-8?B?WTJ0QmdxTEVkUWJ6VzQxN0VJMnhjVkxndlJ0Y1ZKMzJoZHQ5Nnk0NHZucmcr?=
 =?utf-8?B?bGxSTVREaGlHRlNyTTViLzNrYVpURWRPaVRjYzdFU1hPd2d6TDBZQzBYd3l4?=
 =?utf-8?B?anZ5c2RGQTlPSlF5T0NRQlhRaGJMTWRsRW1WVVdkNllyaTkrdnR0U1Noc25v?=
 =?utf-8?B?M210UUFGK2k4Q2VvR25sOEYzUUtXRk82VGQ5QmVFVzRxaHkwM1dXRHdaODhh?=
 =?utf-8?B?ZFF3WVIzMm84bitsOVdzdmVlMXlOamFQMTM5VWprYUNsLzVYRUNaZEdpOXNP?=
 =?utf-8?B?c0NFTFc0L1NiTGZLM0p6YTlZSm5FLzRMMmlpV3BkYzBtY3BDR1JXdnZzUjBO?=
 =?utf-8?B?RTdNenRoZGZCSWdaY0NySzFaVEZEb3NJTHJRMy9DZEh6T1JSMFpNUUo2TUFj?=
 =?utf-8?B?Y0l3ZEZFbWFkdW5heXZNZ1Y5bTBqajJBdkJ0SDNoWlplZTFraWhmWEVpbDJy?=
 =?utf-8?B?TEEvNWNnbTZtdDVDQ3BZWXZsUDBYRVJDY0xPTVY4UGxvaHY0QS9aMHczRWFW?=
 =?utf-8?B?aklVUUxZVnlmSU5kcnNPejYzSWd3SDhOT28xSHJrKyswUE5tSU1hQjNBQk9h?=
 =?utf-8?B?dUIweGV5cEVTZHlxM3l2SDlKajkvVUw3SHRmU243OW5YMlhoZk0vNjdJc0dG?=
 =?utf-8?B?TW5GMlRpSmZXaWcyOVVTeWttamw1dFZ3bFczdVY5YTFWNCsrQnIrMUtlT01l?=
 =?utf-8?B?bDBOcDBIMWw2dU91U0c2Vk43b3NnZzQxZnRsVGxjUFpMUGZzbzJYcGIvUmxs?=
 =?utf-8?B?SnlaUm4weUl5eWhTZDJuajdBVXNMV08vdHZhNlk5L2ZHVlNMczF1dXRDS0VW?=
 =?utf-8?B?SmFNT0FoNlkxdS9uM1Rld1NDRGF1NVE5dENtSDdyQitOdURhSTBMbDFtVmJR?=
 =?utf-8?B?WVNITGZ5cG9Xc3ZmclVxeUpKOUNvNHBOSEU2S2NnRjFwWVAvTkd6cnE5WDRZ?=
 =?utf-8?B?TGdkSDR2N3ZBc29nejZoNGhVZUU2RWVPVnE5TUZVM1BjU1k3M281blFrdDBW?=
 =?utf-8?B?NXR3TXVkc3BLRExhcXJJaHB5RVZOZ2MydEh5M0hydS8rQUdrd3gvMWV3MUFF?=
 =?utf-8?B?eStFMnMwN2xhNG5KZVhLUFc3eVpMVXcrSkpOZXB5NHNxcExQcEdYTjJmTEti?=
 =?utf-8?B?SzJVYWs1KytxNG5NRHU2VW9uN2tTeWFGekJWZmV3N1RmUmd3V0llK2oxOU1s?=
 =?utf-8?B?Z003dC9YLzQvcno1VTlKQjZ6TG1PUlRXSXppeWd0dUhJTjZyeHNFcXR2MjFa?=
 =?utf-8?B?d2JTa0lGRzJHMTV0TmkzZzBFVkY1UWVDakhkU1N1S1RJSmlzRHFIZXhyMER4?=
 =?utf-8?B?Vzh0eFFSTmtJSEIzOEpmaERQUXJRenR3ZkdiU1hQYlhicGVFbUswdGljdXY4?=
 =?utf-8?B?WmsyU0VlMCtjdXZwcUxsM3BUWkhLNFZkZjhraTk0Y0VnaGMwNHc0YU8vNm1U?=
 =?utf-8?B?V0VaaXBuRUJrRjN3cVB0aGlvUmdzbHh1dXA0NmxPT2k2MU1GSHBvVFpBU212?=
 =?utf-8?B?dDNJZDU3bjNieVRXN0liWDE4eWtIVDR1UEtrSVpvSit5WUppM2wxNGt2UmJw?=
 =?utf-8?B?Z0VsNklwOG4vNTl4T1dzMU1MK0VlRHhIL2VCbVZLSlloQlhuUXZQRlZlU3Ra?=
 =?utf-8?B?MUprbmR4VW10NTBRQk5NS3liWGRTdjdHWDk0MkVvWENYN08zSW0zemlzeFRn?=
 =?utf-8?B?cldUL1hWQzNPaDdNTnhjRG5jK0M1VHB3RGpnOWlsMXdydzVMS1M2OUYraTg3?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bFpRMlUyNDBvdElVcHo3QzF3SVExMm1NSy9sV2NoWHpRYWZMZXhZT3JYeFpB?=
 =?utf-8?B?WEE0TzUzYzVzdHlMTGdJaEc4K0ZWWHJ0ZVlITjBVZEh6ZTNBY24wNEdkQjFt?=
 =?utf-8?B?RzFYemxtcitTb242VXdyalZ4K2ZTVFZoNFE1bzhkeHE0SXpkaTZPdVhTQlZk?=
 =?utf-8?B?a0s0d3FhSVFKa1k4Lzd1Q2QvWkJIWGxDeWM5VW5JQXNyaU5pRElrQjcxYzZz?=
 =?utf-8?B?blY2d2kvS0V3a3pZN2lwNDFKN1o0L3BvZmMySFBmTUoySDh4MDhmNHlObEIz?=
 =?utf-8?B?U0g3OUVJaFJ1bDFjeXNzMjFiTXFiYzliKysxTGxmY2FIY012Z3ZUYjE0SHRx?=
 =?utf-8?B?bzZFaDhlK1RWN3FyZTFjMnRhcEJGME1KdDJ3QjZDWGlXR0tHWU94bjhsNlIr?=
 =?utf-8?B?SThCQk5jZkFVWXg3Wkp0MVlra210WGJXZGJDZWhvbzF5ckFpdzJRem9lVmxS?=
 =?utf-8?B?S0VONy90eWMyR3pvTDI5djlOVW9QdVNpbHQ0Q3RvNS81UzFqdDZHVVJJakE5?=
 =?utf-8?B?TWljbkQ4SXYvSzZ4MU5pcjQzTTRzcUlvbjl0T1ltL1BISjdMZkp6TUVLZDZW?=
 =?utf-8?B?ZGY1ZzNTM1p5VWU2WXh4bllETmRXWUpqV1ZHTWRET1h6YVFza2FNdWQwZDFm?=
 =?utf-8?B?aEZkdEUvUnFGM2xIVzdNSnFGRDVFUUdXWW5VRHdRYmNVaXRiRFVybG83ZnRG?=
 =?utf-8?B?SW11bTVqZURaWWhIRXhDZUNXZUpJTUhEM05jNDNHWnFQbjN6MWQ1blk3RXpN?=
 =?utf-8?B?emFBYk04WTIrU3M4dmpycFFEc0czWmtSdHJEZ0Q2RVg5MDdzUE1lUHFTMU8w?=
 =?utf-8?B?aTIwYVJBOG4yaDBTVXV3d3dEZlB1cURMOTE4L25yeG5yc2ZpRXg1VVY2NDlV?=
 =?utf-8?B?TmZpbTJ4R1EvbU9jTEs3aWZpZTR2RHZJSHFQdlRhcFdXdlVJaVZYblgvUEYx?=
 =?utf-8?B?VUI3M1lGTGVWZWJzZmNMc0lqeGphTHFiamNVKzhkZDRnNG8wNzlLci8zRVY1?=
 =?utf-8?B?RTMrV0I3amt2M29XQXQvOENWOTlNSkNYK2ZDWGxKY2lqSFc3dkxQSjlaeG9y?=
 =?utf-8?B?OGl1aVl1MUNPQjA5Y1Z5N1g2UFZQbkRIeVNKcngyUzdpUUd4WkhVNGV1YTJv?=
 =?utf-8?B?azdZNSthbUx3UkJiZnFqbThCckZLdWdwRzRWdy9NZmVTTEVvR0M4ay9kaWR1?=
 =?utf-8?B?MEw3eUhTc3pYdys1ZmxHK1hOWkZyUXZ5bkJUbVJ0aVBqSDlEYkV0U1ZSMnpj?=
 =?utf-8?B?ejVCOTF6ZE80UnhvVlVLN2o3b3pYdy9ud0p6aTl6WTlSLzdGK3YyZG5JYlNv?=
 =?utf-8?B?ZnVNL0JSUnpuUmUvVE5mcGhTL3ZjeWdDTnJPUzNZN2o5cFk3dEdGZ203bStq?=
 =?utf-8?B?NG4vSHE2V0ZxeWVSWk1VaHlGQ0FIOEFhQWhQM2k3ZFhIS1JYRzIwV3Q0a2p0?=
 =?utf-8?B?QlpDQ2YrUCtrblJFc25DQkRQQm9iRjFhbWVmSW9oVjdwaFRvWmNxVUorZVpk?=
 =?utf-8?B?QktnSmdsL1YrbTQ0WjM3OCtRREdnUk4xNVJMUVFxK2tHY3orRTZsbEFjRndu?=
 =?utf-8?B?eDQvUU9jQUoyUXlqYWNSeW9sUkt2Tk05cGtud210bjl3Zkt4L0FMRlBIbDVu?=
 =?utf-8?B?bE4zYWVFS09KVjZqekdMbEtZMjBKbENPdERIempmak1Bc1pKMzcybjBscS9Q?=
 =?utf-8?B?dmpROE82VmZCT3BMNVFTVnpyVThHMUpjaHBVQ3d3Zk1RdnV2SEJYbVRSL1Ji?=
 =?utf-8?B?bTg5bmRVUWdzR3BZWklRSmhMQ2thR3h6N1Z5cElsdC9QZUU5TTNZVXJ4TFJj?=
 =?utf-8?B?V2VGSm1FUnRhSVFxeE1aNFZUU0hhY2FIVjZQdXlybitZVFplblNnb2RMWkJV?=
 =?utf-8?B?cUJoNWxYN2kyWmZpWk1FTXpnN2pYenVucG40UFNGaXpzSmV5RzJXUjZ4NzJR?=
 =?utf-8?B?ZmpOSUR0eDcvUTlkanMrZnhUbDB1WHB2dmlIMU1ndlFoTTRsRVpNb1l3dVdk?=
 =?utf-8?Q?RDsTCPjTmd4TcnGcRAoEXJE3DEJrrM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c5729b-dee7-41b9-6e13-08dafeed6464
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 16:01:17.4947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkBtNn406g47yCfIhpCPSdQlN3C7ebfj5WbaQOb6G/MqPXiM5pcrhRL2P+ssjgcnUtMRiu0OkKvtGIRzdYcEDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_10,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250143
X-Proofpoint-GUID: w751XtEoQ50sDGPrHmiILrayNAx7g2ok
X-Proofpoint-ORIG-GUID: w751XtEoQ50sDGPrHmiILrayNAx7g2ok
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/01/2023 12:53, Kirill A. Shutemov wrote:
> On Wed, Jan 25, 2023 at 12:20:26AM +0000, Sean Christopherson wrote:
>> On Tue, Jan 24, 2023, Liam Merwick wrote:
>>> On 14/01/2023 00:37, Sean Christopherson wrote:
>>>> On Fri, Dec 02, 2022, Chao Peng wrote:
...
>>>
>>> When running LTP (https://github.com/linux-test-project/ltp) on the v10
>>> bits (and also with Sean's branch above) I encounter the following NULL
>>> pointer dereference with testcases/kernel/syscalls/madvise/madvise01
>>> (100% reproducible).
>>>
>>> It appears that in restrictedmem_error_page() inode->i_mapping->private_data
>>> is NULL
>>> in the list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list)
>>> but I don't know why.
>>
>> Kirill, can you take a look?  Or pass the buck to someone who can? :-)
> 
> The patch below should help.

Thanks, this works for me.

Regards,
Liam

> 
> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> index 15c52301eeb9..39ada985c7c0 100644
> --- a/mm/restrictedmem.c
> +++ b/mm/restrictedmem.c
> @@ -307,14 +307,29 @@ void restrictedmem_error_page(struct page *page, struct address_space *mapping)
>   
>   	spin_lock(&sb->s_inode_list_lock);
>   	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> -		struct restrictedmem *rm = inode->i_mapping->private_data;
>   		struct restrictedmem_notifier *notifier;
> -		struct file *memfd = rm->memfd;
> +		struct restrictedmem *rm;
>   		unsigned long index;
> +		struct file *memfd;
>   
> -		if (memfd->f_mapping != mapping)
> +		if (atomic_read(&inode->i_count))
>   			continue;
>   
> +		spin_lock(&inode->i_lock);
> +		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}
> +
> +		rm = inode->i_mapping->private_data;
> +		memfd = rm->memfd;
> +
> +		if (memfd->f_mapping != mapping) {
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}
> +		spin_unlock(&inode->i_lock);
> +
>   		xa_for_each_range(&rm->bindings, index, notifier, start, end)
>   			notifier->ops->error(notifier, start, end);
>   		break;

