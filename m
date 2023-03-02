Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F3B6A8BD7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 23:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCBWbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 17:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCBWbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:31:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4684FA9D;
        Thu,  2 Mar 2023 14:30:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6crM009073;
        Thu, 2 Mar 2023 21:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=rAcq3c53XTnCppjBYHNkv4hDu0yCo7aTLQP0ipObY/Q=;
 b=tLV8OfyFvzR1FXbqe5hfhvzAm6A2svwJAliMk1RhQZoI/E//U7dUj7yPp69Qh/PtYUQc
 K2N7ytEQZtcDEzssF0JuVk+u8AA08itL8uHjC6kZeEW3eBFb0YeIb3qNrYenWtSXmqM4
 rb2pXEYZ9HHcHlZ57LN481uCEEPqA4AMmaiWXFP8YRmo9dTzRwt5R7tRcLnMaFvsM0Av
 JGh6WfsAoWMthuX1254hxDI1yb1RfDee0KC8nOJVGt7+gRjeCLmJTkQ1KAgJwRTNc3wj
 1Qp/NFPIv6NciPDcgM2DpWoxiWGGtISmZ/52iwq5ygmQEIDd2hdnyxF6e0VyZf6mE0W1 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9an06q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KcamW031307;
        Thu, 2 Mar 2023 21:18:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8shf3fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT9LQRoRMLAEK3POKX7VgnbX9v3bM9vg6VuzpDAL16HfR5w9BphB9JjprkYGwo92xlPT9ppuulSlpiiuDZANOAkSDVKIfcqNY7g4y1NJqUMs11oamRHd+s/zRq4E78W18/bLQXdIrLGpvEC8q0T7/A2IDARnkDpFtldVm1iYFq8xk/luIQC8bsaeUaL3QV1K9zLS4MzsGf+vjLYB4AryyIH1Sxvx4gZYZ7iVaJD/1Z0Zby6bpWm8ZewuSRkeWERmUVX8LTEV/YawI0mJoyMsKu3pJx0jkDKM13y9XdFEs1V4T2n4JEsPhnyY76Bw8/j1ZU0D2ei1a1nkWH9DJfrsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAcq3c53XTnCppjBYHNkv4hDu0yCo7aTLQP0ipObY/Q=;
 b=e6lrIgDrASDX4yyJmTc/hL2pfdjlb6VkG4p/xzdRkarJ8Cg9slt8EudW4MUwOhVLU41xvBIEafz8/jRAb0YnWrI/p7cImthsNhTeqV0Fm8uyhkL3AfhfW2Zx3nj95IC2heg4+noT/r+v45t6vUD76mP3R83vyokv0RMMbiWsa59Bx2lQIkwKob/rvBxaCpVpOJwQB5Hl6TwWOFWhpCiX/ymiqlVmjafC9gN0oiXMearPMhYCruQCzJH8Pp+fmhwJWoobXz4Yyn/ZrxWFpQpMhkMCFtUYo898DnJw3oiIc+PM63D0RC8qAKwVjBpMO7uTbaLB6zdYGw99atOq2ihHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAcq3c53XTnCppjBYHNkv4hDu0yCo7aTLQP0ipObY/Q=;
 b=k98uXSQznhO3wpL/El9fpgF3mmGN3NUol6iO/3FQkwv15ZnIQh9aBMCf/oj/luUSJFDejD//hWDHg/ftay09Kilzlz/E1IDO41V9hkstiEbzYWDGz73C7YWTepN9lsly5K1hxx1vQNSb3PpNrBN7QLflDL+uRLYws22IGbOVX80=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:12 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:11 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org, x86@kernel.org
Subject: [PATCH 00/17] MODULE_LICENSE removals, sixth tranche
Date:   Thu,  2 Mar 2023 21:17:42 +0000
Message-Id: <20230302211759.30135-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::29) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e7bbf8-f8c2-416e-7593-08db1b63a0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eoe/ZubK6XMS0uEveKAsPn+RS1jbpum5ljjmxtintZL/aiAJzYgYASk5GIrD9UU9UTxLMs2Uz8X83i3z8ERNYUKIzly49Iq3RSppt9lcXW5aqkHZi4KHcldggYTxMDK9AuiK/JUqYhpfsqlpVXvIZlT0FE5jasM/QHrRUelljxnpxJjtnIVVwdUa2oVNciaOKLItF/JOI88XhZcAozCSunlFpPqqSxzhkVoDruMUH8NJc5aot9mjoLhFJ0TH6btVfplaraAr1OEFgB5kyHjUblKhb3DoWTlBk8l6ymIX5KDuXACjKhw3og5+al8XL7CJ4HxThyUbPzRfEd9pCKq8+yemZTTgDgXEBop5z5+WG1+EdYIA8bpY4rrDxz7dTxHoHN7in2h18hBUYuhCJHcqMF2DmQ0uyTeoCM8TMJp+zovMTATI9dBFr+Hn1f3TVGvmODn4UTXSjzqgXfmNszepgABeMa7180fPly0d/QLN7wa/4s400UR6Qa8s7v262jKEPIxE2dipnxDjQTfgIvjUeEWFI6zuXyXeNtac7ibLYRr+oOFm95CGVH8f9L9rpLtZBKBB1PgdzyaAubiWCGr7iv619xBavcvu/NQndDwhw0Bod+CwCiIH8dednEuCyxBc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(966005)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWQxaVcrRVE0SFF5cW82bVZCTTk3WlVIVXVlYWZCUms2blk1ZFdQOVRRczg0?=
 =?utf-8?B?WFQwTnpiMEpLYldJdSsyZkFiZlJlSFhTVk9HNGgrcUI4R2tIcFhLbTJ5S1Ay?=
 =?utf-8?B?dGtuOW4wRC9xb3JDbTFSNGg3OUdQek44ajJGVHhLcE95NVdnejBjSUF4U1lz?=
 =?utf-8?B?Z25CYVFvWUdsK1cwV0FBNTVGenJSVkppc1N1MmpoMDROaVI4Y2hrbTFwb1J5?=
 =?utf-8?B?c3pFb1Q1anRHcU53Q1piTXZtdGVnVmVFYmMxcmI5UWtaQVBneVlsd2NWM3ZL?=
 =?utf-8?B?bWl4RURvaGR6SGxHbElObkxqR2hHejFZRnN6UFBJYU16L29HSmoxb2hpTFhu?=
 =?utf-8?B?bGZLdFRBOGUxUllteDZXMkdkZmQ3V3Z3N3M0SXZvcWR3VE1jREw5a0JneUJB?=
 =?utf-8?B?NjNTRHorL0lNMURqOFUyWk5uUkxiN1A0NEZpaW1mQmZBaWt2MGhUM0ZiRXVv?=
 =?utf-8?B?bG9Ndld4MGcySHRqTjI4aEhoeFRScmFpWVFEVzA0dUswNzU4QWI5Z2I1ZjVK?=
 =?utf-8?B?NkpGQnVQWmdFcVNwSFFnSWF4MmZCL3hCZjVwVGZrZGNXVEhmd1cwL2ZIQnZp?=
 =?utf-8?B?NXFjQWJpcHJWd0ZxcUYwUkVicnI5Q1NPVUkrK3hPT3ExTW1GcG5CM0EyNHJO?=
 =?utf-8?B?VTBkUGhYTVRxdk93WFMrRkdnMC9ONmJ5dzRvREI3aUh2cElwYWlvT002OG00?=
 =?utf-8?B?d1BoMWRRRFBiMjJKQUZlV1d1V2VVRnZGYk9HMGxKaG43UDc3T1ViT3hkUzlK?=
 =?utf-8?B?R3JGN0VmQ3NZb0kyWFFxWUIyMHJtanZJc2J6QThnUWEyNzFlK1E4SWRaTkph?=
 =?utf-8?B?aWVHS0NDemlERk1McWJoYmZGREZ3aGNLd2lzOVN5Vk5CQ0VoeGVFVlQ3ZGRw?=
 =?utf-8?B?U3Joc1ZWMlp5cG8reUpJNXMycFpJREl3MVlieUg3eU9pdXhHWlhXVUg3eGtE?=
 =?utf-8?B?cmlvSkFwczlTYjRnQ1BFclFaV3gyVkl6bElLZWRWblZlV3kxaEQxZFM0Y2VO?=
 =?utf-8?B?RlJZZnNMRkRqeGNRR0x4T09HcTU2OVZkU25oNGhvSXFEbEhoUkVGZzFTekFH?=
 =?utf-8?B?Y0tqaFB6eG5KOHhHZm1WS2NNQnRJeE9yMUkyYXJFdFV1Sk9FbXRZT0xCeVJi?=
 =?utf-8?B?VXYyRTBtWWdVOHg3cy9qbGFtNkxBcXFBK2tDNWQ5Vnh4M3huMEVUeDU5bTBl?=
 =?utf-8?B?ZjUrSGdpTjc4U3U1cjY5UWVoQ01nTWxXMFpyUzFld0hmU0pCb1puN2FWT0hn?=
 =?utf-8?B?MmV6R2VSaEY3YVJCbzhvNFlqU1R5WXVXbUZ2L0R5MklCM3FKbk95c2NIdjFo?=
 =?utf-8?B?RUtoZjhSY0RaWnlsSWkzOWVvM25EcVdPRkhURmo4c2dUQXBqS3dObTVnOTM1?=
 =?utf-8?B?bzZKSENQU1lMaHVUUjRBWU5LVXhQZGpsb3JqL2R4T2JXVUZ4OHpkRzJFSFRC?=
 =?utf-8?B?WGlURUMzTFNGT3pjenpVbUpHbWltTW9VNnlRNkJSbjAvek4zcTVFVENvcCs2?=
 =?utf-8?B?MTY4eC8rb1NQdHVGdk5RV3V2UG10R2xwN29CTHJRcEpnQnhiWXZXUEVSR0xW?=
 =?utf-8?B?SjY1YWVGZnBXTWZEQms3VFYxbTdtL0JKcGFUQmZNRVFBRUsxeExqRVNNS09m?=
 =?utf-8?B?VnYrMGh2WTk0bmlweUdEVUtJLzZ5TzJZbDkzUkQ5Zmt1dXdKOG8yQmswMUVK?=
 =?utf-8?B?dHN5Z2lBamhGV3NhV1FIaWR3QjB0NzBUUlJ5R0lpOUxwL2RXN0gyam5XNTJv?=
 =?utf-8?B?TlVOa3R2Sm1ZdjFuRnUrK1A5QXNudC8wS204LzVrdCt0YU9UR2dxK2daaU5X?=
 =?utf-8?B?LzNvYzBVd0lDVkdPUndGamJEZVB4RHJDaERIKy81RUMwMlArbERmakZLUUVv?=
 =?utf-8?B?QmFQWldwT0NscjBWcXpCSStHMFM3UzJCczArZXpJTnRHQXRldWY0TVoxUkhx?=
 =?utf-8?B?ajYxdkZHclFiNjNuM3MreGdDbU5qajFudWQyVk9PamtwaElnZ0FFSUhTRkJR?=
 =?utf-8?B?dVNoTVBGeUJDc1I5cURab3FZS2Y5MytibHg0K2lxYzIrbjlqQVNOVHl6ODIw?=
 =?utf-8?B?VzdoV2szK3Rxb2lobG8xdDAyZG5UT1lrUnF1Y3o0bFM5SUEyOFJEMWMvTlIv?=
 =?utf-8?B?RUorUEVUanM1TzR0UWI0S0hjcUYvSnoxY0RHTE9RdWp2cXJjMDhEUmFQUmRz?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lQGzW2EN3F6xbjPng53mTdImDFsv5OjcgN/A0LmXFit7ZB3FMSKHpGnaDgGh2hcUBcYm2xupohjTdEB1u/L6zVR5dWbP/WGSzYGuZWmkvNDxUYK45URIwnfVI/UbJL7QsVqcn7wtQVTCgEV8CU93Z69Fo+hoA5RyfmM8Ua2jV0zCpfddKybLihFhSGTXm6Dn19SEswDY1j/9iIerlUSAeQQmgX/6NA83b4sCsj0NEnFo7E2XsUuHvOPGWqtoIAVvIgqGwcPKBPHetHpPoFDwSXEX4WcMz4mylev6/EhIgTYxu3lAMcCP8oWPepJGLoV8tPEPJRJ04u4HUm59rxfYq21TEzvP9AyYebAjnjQrfWokM1mOyWJGiH8aMj9gSnxh/EZ0GLPpVpijLF5Kc2uipsS3xrG/A6W94Ff1tHllaWvaK3Xfboe/7r4DZFcSbyy9IXN6+6mc85qZ1QUfXnaRIiKSkz4FUX2K2xg7lk+nfGa44mNPXholVumuFhCSvIP9vUEK3aPHq6asFEk3sfhhd/iCKg1/bHsizx4NrM3fsNN3JH+uWC6CNXNF9rjzO49CnAVofYKM7ujBPhhguY3QWa7iVgpbsMnCsPXyiinpQE6v2Tu/tGnxEonnmbRwLeQBew7PwH1J2O+KFvXEIw+b/nH0YUEZ6LonABJXrmSrG44x6MWrn48v5x3aiDRIOBrOOD9ozoLEohXrqivsvxV5/tE9B88vyYg7pF7bzx8PwRorhHBdqMhj2VaVSVJuQgFwoIC6TyiAIez1kfwQo9pf835HKGDnXHBI/SZPQ+KERzgld1Y16KdQTcz4K4y7WKRu//DENHM1yPu+/2kQxI0RXSJkKZntOljHugUqDfVhWA1UXAOBPWtp+27k6ulFfenv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e7bbf8-f8c2-416e-7593-08db1b63a0c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:11.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJgz5ssmDtnkVkXId2YGZqcA+ENRrd8KLHUlmRtHeLT5iT8ZKLxzcCphczYLt3ThX2A1V01wghqcJ6xbdVMQ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=798 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020183
X-Proofpoint-GUID: 8NBkfdG0vipuzKxhFkrbn5UuyPQtb_l3
X-Proofpoint-ORIG-GUID: 8NBkfdG0vipuzKxhFkrbn5UuyPQtb_l3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series, based on current modules-next, is part of a treewide cleanup
suggested by Luis Chamberlain, to remove the LICENSE_MODULE usage from
files/objects that are not tristate.  Due to recent changes to kbuild, these
uses are now problematic.  See the commit logs for more details.

(The commit log prefixes and Cc lists are automatically determined.  I've
eyeballed them, and they seem reasonable: my apologies if they are not.)

This is the last tranche of patches in this series. (In total, there are 121
patches in this series.)


The series at a whole can be found here:
  https://github.com/nickalcock/linux module-license

(This is a respin with kbuild: prefixes dropped.  The previous series,
used in the mailouts of tranche 3 and earlier, is in the
module-license-kbuild-prefix branch.)

Cc: dri-devel@lists.freedesktop.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-modules@vger.kernel.org
Cc: x86@kernel.org

Nick Alcock (17):
  irqchip: remove MODULE_LICENSE in non-modules
  bus: remove MODULE_LICENSE in non-modules
  braille_console: remove MODULE_LICENSE in non-modules
  arm-cci: remove MODULE_LICENSE in non-modules
  drivers: bus: simple-pm-bus: remove MODULE_LICENSE in non-modules
  watch_queue: remove MODULE_LICENSE in non-modules
  btree: remove MODULE_LICENSE in non-modules
  lib: remove MODULE_LICENSE in non-modules
  fprobe: remove MODULE_LICENSE in non-modules
  tty: remove MODULE_LICENSE in non-modules
  unicode: remove MODULE_LICENSE in non-modules
  udmabuf: remove MODULE_LICENSE in non-modules
  regulator: stm32-pwr: remove MODULE_LICENSE in non-modules
  mm: remove MODULE_LICENSE in non-modules
  xen: remove MODULE_LICENSE in non-modules
  zpool: remove MODULE_LICENSE in non-modules
  zswap: remove MODULE_LICENSE in non-modules

 arch/x86/mm/debug_pagetables.c                  | 1 -
 drivers/accessibility/braille/braille_console.c | 1 -
 drivers/bus/arm-cci.c                           | 1 -
 drivers/bus/bt1-apb.c                           | 1 -
 drivers/bus/bt1-axi.c                           | 1 -
 drivers/bus/simple-pm-bus.c                     | 1 -
 drivers/dma-buf/udmabuf.c                       | 1 -
 drivers/irqchip/irq-ti-sci-inta.c               | 1 -
 drivers/irqchip/irq-ti-sci-intr.c               | 1 -
 drivers/regulator/stm32-pwr.c                   | 1 -
 drivers/tty/n_null.c                            | 1 -
 drivers/xen/grant-dma-ops.c                     | 1 -
 drivers/xen/xenbus/xenbus_probe.c               | 1 -
 fs/unicode/utf8-core.c                          | 1 -
 kernel/watch_queue.c                            | 1 -
 lib/btree.c                                     | 1 -
 lib/glob.c                                      | 1 -
 lib/test_fprobe.c                               | 1 -
 mm/zpool.c                                      | 1 -
 mm/zswap.c                                      | 1 -
 20 files changed, 20 deletions(-)

-- 
2.39.1.268.g9de2f9a303

