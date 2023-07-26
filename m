Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8A07639BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjGZO7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGZO7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:59:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431F410F3;
        Wed, 26 Jul 2023 07:59:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q80YM5019208;
        Wed, 26 Jul 2023 14:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=E6NcZrrb5rl1/0Td9hhcOjPkhg88G58jDK/I829aQ8Q=;
 b=hStoubNjzpWb3PiHFzHH/ZSHyDt8h12Lnt4Pgxu/RBne/IaQmIQMM3/YaB3hrTyFhh92
 b03ttZUkn0LY8IlKnm9JsG1T//602vh+931UPfMa/MDh/WrHovfzwZta+CAO6CJF7lPM
 X3Vt7l/1UlPfONeFtGIoMu/N0ydw5sqiktzKKNWRZG9lWmMvBYOldc9B8iFnjPxt8JLF
 Sjpnwam4SPqKwtlhfLEraxW1CFB1WWJ+1Twql1f2Voky6XJUXMa2qMkenPuLWQ6l0CO6
 6hLJ4yNRonJD3jAyqhZChmruBUNApQFztZ/oyYWiQf2QtSXIKZe35vW625w87bBbQxz8 HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070ayner-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 14:58:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QEDGnm033437;
        Wed, 26 Jul 2023 14:58:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jcm0f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 14:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG/O1WmDtlclEZZZ6Qu7akrHkAMMWbyujSC0wdbNJsiY+Vyz2uBO2dCQhl+3VWq7j2EYzBX2JASNhdVYwvGpvBQrM7HNzof/KHk/yofF5Qmnr7YlV1wfSZJw/kKy09N0f1PX96+yNp2PumtOrZ/CjgSHTA8eE5GGu77zdR7I6msTekNg37hAnYZhe8OGPesnF2M2ToAbBlTkY23T40snLlPldbZp8WNflBXRyPhACUhHy+sdhz0tdda5QIXv2XtVEep0K5gTn08REnYcbJcrQMHPYYiGwA509eXiiMrtp7HyULlKPAqlGlyjez1dZJWY8S3JqUpI1s7c+HIezKsJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6NcZrrb5rl1/0Td9hhcOjPkhg88G58jDK/I829aQ8Q=;
 b=aWOKlO7iHa1yBIeyuP3qGAYIInu3sSXPNQcNgu07qA37e7vQrpfRPc841v/auKSvKQUbpXDcLQKe+uP/xqn+59xQ7n+2XNHkaoX7L2PZPHpKGNpGUhzKOh8zBqUaPBGZC+BhENPUgqxwt0lJNbIhgqnwJcZpKitUbU0k+gqQ8MhhtQH8cqp184Cuk0qkFfTeTiJrElPCiST9MrVIZRTvZmt4BQJlD0yS21wD0FaGtfeIkjv6NOv0s3pNHDtHUHcvpxAiGN2sBy7lG7zmorF9k+axoSYduIXwoXGzkm4XwCEHWejq4hKZxm+JDmgvQN+OEehHW8DnkejVgboivGCb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6NcZrrb5rl1/0Td9hhcOjPkhg88G58jDK/I829aQ8Q=;
 b=KMz7M8pT4p7wxFGc860QtaTvyTn/mIWG1piI3p6lYJ6bqyFiUg6t4rKjj90S9bV1i/OicZCd2EVw8Eslcj5P6aYKR1YM4C+pN3t9XZdVRbVMznSusGDlHcyAxBK+eBHLqPZrhI+4RHBKmJu7DDBJXq8gNY3fiaqSRPQVddXyUwg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4638.namprd10.prod.outlook.com (2603:10b6:a03:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 14:58:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:58:28 +0000
Date:   Wed, 26 Jul 2023 10:58:25 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/11] maple_tree: Introduce
 ma_nonleaf_data_end{_nocheck}()
Message-ID: <20230726145825.2fufoujgc5faiszq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-2-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726080916.17454-2-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4638:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abfa5cb-cd38-46e5-2d5f-08db8de8c559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXNz26SZ1ZiSCN9UyBW5a1MNEa+Lw1W9ffnHwL6jEsZtPdn2E5Ao0r4s4LKTfG1u5uALud1pwm1me8zqArnmvYdd2WPwzPD9ueyTC+G1Uj3eg15MPvz87yVMyztKg42qtD3v24wKNoQveXuGz1TaebA5sMZXCsaVJbjgsfEHoQ1p5aCP+J1SIq3z7b9ZigaSwRhQawHWKcpvTTi0pPDOOcZIDRLTG57doWFjPpQjZZjwKnqT93fIgTfNRcqTHoMxbCnyWJTEYfoy1iP4wyU3cCWK2kgK8fi3zqn2dqV7NxwgB7p55k1zlbYO8NxZxQsqwV5p1xf8VxBkeV1q+Z7jjq7iwWWGsIP2lXwI9e75E42cWPcKqGDrIIvK2u8LXJL5v+KXRdRoI8BKn5VT9opiezxJb3nhARoccs2oMqo5ke1PYM1a7vAekmuZX1XmDzuinOnQPy/Vnj30c7a+ubzz6IdUQ5fQoHTYf59g7etRxurf2Um8a8udJ+2NzBYxISZysAKdZF9wwbEJIpUXLm7Aosx8O2dyFSUMH3F53IrSieRAYknc5vlLL+V5nHX2jyyI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(41300700001)(5660300002)(86362001)(7416002)(8676002)(8936002)(38100700002)(2906002)(6666004)(9686003)(6512007)(478600001)(186003)(26005)(1076003)(6506007)(4326008)(6916009)(66476007)(66946007)(66556008)(316002)(6486002)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wJ9Ff9Gy5H+tMxOG1eB8CV/pOgsWlwLqF4NVfSgGs/7ZeQBZFwyWwXHQGpEJ?=
 =?us-ascii?Q?UO5o/kLroo9C/othYo958y+DKRMRevgx3PeM2/CKK+X8YhhmI8rxjAHYqwSt?=
 =?us-ascii?Q?qXaR9TZv4n0rJKrb3xFuJm7fdwtIMrfZbngJEgPyFrr9O5h2ZeSibneCz8CT?=
 =?us-ascii?Q?frR7WbF82VGwjUJu/dMMXY785xL7mGjsQJU4eG7DSE2gkgdJdzKzsQcDaqqM?=
 =?us-ascii?Q?1qeXt2u0gISF7GP26qzcvL0LKmtcJTq78aLQOSUpMHESWIEMGjrXZMMIunoE?=
 =?us-ascii?Q?fqWkCQ3m+9/fVuE1FJD+DtpLWhJuj3zPUUL7POqM7IKdmx8j4bz9mB3xvK4Y?=
 =?us-ascii?Q?b4jEZCJINVISAlxNGiNPj7aZXRPCfidN32/4DvruKsT/UZK3dB6wlN7TLqK8?=
 =?us-ascii?Q?F4cPKOz9qqOEXMUbe9jZhEq0mUD2Ufqo6D/8lHfG52ppys/I2FlA6XhXIYiX?=
 =?us-ascii?Q?5+YTtTxV3k+PHAEjvw8qtDwSj8fywCs4h77ZmX/Xchz2/XiVRAvsL6HpZZ+O?=
 =?us-ascii?Q?SS0mSoZqmGWGHdQn3rMAQunSp4SH99kGwBDt37f/6FgkkuTtlarSWlVeYoO1?=
 =?us-ascii?Q?hM3CwYhloi6rH5EWqJ+psvWldnwvwzs6uc/1ZS4sOVFI0t3rlniQUvKa4pqj?=
 =?us-ascii?Q?7w/LfF3dsEZnOg12hD52Y0BltIUGwzhf8x1kqM84GHgjftqy70//BJJ+mnax?=
 =?us-ascii?Q?5Bj9S1Gz0T/if95obsEKz8DrVZpGGiHXOjplQAVOfSM62e88cUM9LfWhzkXv?=
 =?us-ascii?Q?my4fyZpKMNEszYaeyyN3MQfMf0Zz2xrOqTKI2ePyhGMh+E3eSDc+ixgnMxz9?=
 =?us-ascii?Q?AkuhB0EhG7qxu0hC4MfmtjX6ngSMSXnuqR96av8MzRLc9fWhOsFEwnKv/Zyn?=
 =?us-ascii?Q?ONNU7hL9vvqKSikodpAwgDae1p+Dc8C+GF5v5CwhUlRLESC2wfVv7yxidmxu?=
 =?us-ascii?Q?N8a2SimDLX3hG7go9U781zUGAGJh25gLuyU8AHj6xQ5eI8+F+UD/MmrttAP2?=
 =?us-ascii?Q?gdnPEISmxQcwSWEyz+m5lxLOEcpYEnEp5397pVAnEZ+p+CzD+HLAOTm51Gal?=
 =?us-ascii?Q?1M8u8d7DzkTouG5/gNuvIQ6WQrcjS/cilfKlhJdpP5OHRd3KxiwkYIvguDoA?=
 =?us-ascii?Q?p9pb7xlsY/rr1pqc/EiKuTRGqqrAVIyjDxCTJypAX50iwfT8X117eLyb6JKq?=
 =?us-ascii?Q?95Y6lfnJFx1Wlsu+w/PDSOMhdGUhohlqi/0s/u6gerRRulu1DCQ4n6AX/GhU?=
 =?us-ascii?Q?od09kxoX70jM5Oc7ymm0ZsF3UJTG+Xtr+6hmT+kmNxzFAMrQsWekY51NFy95?=
 =?us-ascii?Q?MscXsuq75PXQc3BAMdcm+6tW+wXko//ThKWS+UkJ+0Pug6K2jJlBsU30uRv1?=
 =?us-ascii?Q?6hIUm0XWeTU/fB+xYy6mjfHgXYDRNEZTA3qBSi10OKrgthoSrX7UdmL+cw3s?=
 =?us-ascii?Q?bEep9AkmtI7c5Htxq2UY9BPrIxksig0jbq6ii4fS6j2PSVMVMkfQnczOEorc?=
 =?us-ascii?Q?8OkHJw7fjlDLBgEtsKxxMOIj6wNxO+vh3VFqwZwuYvt8RGg0pk38YwfPEFo4?=
 =?us-ascii?Q?xMj8R7mgdiSbcwU5PiXAPFHyY8mX2ydbLkqqDok4obDnrFF/o5Bqlm6TFiM4?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eW3KPkfwPjPEniSvaaKoxueZV+g1D2NMAVwoCo6vEirHfPWDgHfn+qwHv6HR?=
 =?us-ascii?Q?cIJTbhAhEPzd2XamE/Z71eOoOX7e66Abm7nzNhNTvJVO0QkzaMRlbiRVWR6U?=
 =?us-ascii?Q?mZjNMxX60zjDB4x2+2gXP6PMkTOVNRxMNygl0B/fyJN1PrXUR8vjXFM3hz8p?=
 =?us-ascii?Q?qC9DB1x1mi+RkDjA9mncrzUt/O1C+h9gbXJTeiMe7ExRUSeQFB91OuSFlWni?=
 =?us-ascii?Q?dtqB8cf3UAF6yJ4kW0nzRbTNxCIN7aNjID/EfppaGf8aO3nH3zIUBQdmRh7n?=
 =?us-ascii?Q?YzqYXVEy9Q5ZkipCzMNorNAvBnL+M1k41ZASnyocvcVv9jKia9kNQu5xH2hm?=
 =?us-ascii?Q?edhZJ5L93E2Rpkbp5T9zBUc7vBKwS4lNHE1y9wIp7jbrdTQxZYe8vQrBIwym?=
 =?us-ascii?Q?MY6DJsk850UhpAjU8/mfC+Xn2uFnQ7Do6TpsonTvp7boMcwPO9u5MduISK3F?=
 =?us-ascii?Q?bMXSUs8j/B+elgsquJkDrJJBHS4A5wEnvvn8GOobSw1DMuqVABye4ZC2plwP?=
 =?us-ascii?Q?xEanlLvNn1jIkFeI7yrlx3HQCCdJa1g4RjpuwA6xADnl1XGbB1Ui3C7yY4QS?=
 =?us-ascii?Q?8yK/69PJuLYSt84STZ0Eqis66V+uslo/J9ezCvJyv4nVzeUqns/yEdlIQFPr?=
 =?us-ascii?Q?kUXom4vy/mg7QK9+qiecETla1BtT+JZ9Fedqlm5fsKEWQeRWoOZBiRprh/wP?=
 =?us-ascii?Q?AUnd3og62/wI8VOty5CXX4dCNh34N7FV/XssCBNQD3K8i9q2OR72OHBBvfDJ?=
 =?us-ascii?Q?pm5UDnpdoLzzeQ6ylWhM+aoYUzsck17Str8b2kGka0WWdfJq4DuriGlD+db4?=
 =?us-ascii?Q?GR/iOKpONS3N1sh7lXu88jHprcMSo3nEgJE3aBPwulA0+3YOpNa7hPTtn0KQ?=
 =?us-ascii?Q?0A9lUKdcnJHUOc+grztbgP4IWhqeN5AgqkKUQInUtG/Hjdr53bSDBFm8WvmF?=
 =?us-ascii?Q?V1aO0K3Qkes8A4i9RS50Hai57yIhyjzJue41b9IThPA3ZNfoEV6xJe793q8v?=
 =?us-ascii?Q?T5xl/ad6gbCtLwhANJVTwHbOGNa21zY9Dx5zjz0RCc8wrfpB9Ln1N2Wk3jvW?=
 =?us-ascii?Q?p3I4gJbp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abfa5cb-cd38-46e5-2d5f-08db8de8c559
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:58:28.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxsFr2ikWsX0vXL75QJ+GkwC+mXi5qT7cI5FPndU3NDkbKxi6mxsobwl5c1nt/VJKCkxHIVOS8YEUMZgcx7QNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260133
X-Proofpoint-GUID: dyOOy04ttLXH_dLo7n8TSckpGPSvAl_Z
X-Proofpoint-ORIG-GUID: dyOOy04ttLXH_dLo7n8TSckpGPSvAl_Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> Introduce ma_nonleaf_data_end{_nocheck}() to get the data end of
> non-leaf nodes without knowing the maximum value of nodes, so that any
> ascending can be avoided even if the maximum value of nodes is not known.
> 
> The principle is that we introduce MAPLE_ENODE to mark an ENODE, which
> cannot be used by metadata, so we can distinguish whether it is ENODE or
> metadata.
> 
> The nocheck version is to avoid lockdep complaining in some scenarios
> where no locks are held.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index a3d602cfd030..98e4fdf6f4b9 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -310,12 +310,19 @@ static inline void mte_set_node_dead(struct maple_enode *mn)
>  #define MAPLE_ENODE_TYPE_SHIFT		0x03
>  /* Bit 2 means a NULL somewhere below */
>  #define MAPLE_ENODE_NULL		0x04
> +/* Bit 7 means this is an ENODE, instead of metadata */
> +#define MAPLE_ENODE			0x80

We were saving this bit for more node types.  I don't want to use this
bit for this reason since you could have done BFS to duplicate the tree
using the existing way to find the node end.

Bits are highly valuable and this is the only remaining bit.  I had
thought about using this in Feb 2021 to see if there was metadata or
not, but figured a way around it (using the max trick) and thus saved
this bit for potential expansion of node types.

> +
> +static inline bool slot_is_mte(unsigned long slot)
> +{
> +	return slot & MAPLE_ENODE;
> +}
>  
>  static inline struct maple_enode *mt_mk_node(const struct maple_node *node,
>  					     enum maple_type type)
>  {
> -	return (void *)((unsigned long)node |
> -			(type << MAPLE_ENODE_TYPE_SHIFT) | MAPLE_ENODE_NULL);
> +	return (void *)((unsigned long)node | (type << MAPLE_ENODE_TYPE_SHIFT) |
> +			MAPLE_ENODE_NULL | MAPLE_ENODE);
>  }
>  
>  static inline void *mte_mk_root(const struct maple_enode *node)
> @@ -1411,6 +1418,65 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
>  	return NULL;
>  }
>  
> +/*
> + * ma_nonleaf_data_end() - Find the end of the data in a non-leaf node.
> + * @mt: The maple tree
> + * @node: The maple node
> + * @type: The maple node type
> + *
> + * Uses metadata to find the end of the data when possible without knowing the
> + * node maximum.
> + *
> + * Return: The zero indexed last slot with child.
> + */
> +static inline unsigned char ma_nonleaf_data_end(struct maple_tree *mt,
> +						struct maple_node *node,
> +						enum maple_type type)
> +{
> +	void __rcu **slots;
> +	unsigned long slot;
> +
> +	slots = ma_slots(node, type);
> +	slot = (unsigned long)mt_slot(mt, slots, mt_pivots[type]);
> +	if (unlikely(slot_is_mte(slot)))
> +		return mt_pivots[type];
> +
> +	return ma_meta_end(node, type);
> +}
> +
> +/*
> + * ma_nonleaf_data_end_nocheck() - Find the end of the data in a non-leaf node.
> + * @node: The maple node
> + * @type: The maple node type
> + *
> + * Uses metadata to find the end of the data when possible without knowing the
> + * node maximum. This is the version of ma_nonleaf_data_end() that does not
> + * check for lock held. This particular version is designed to avoid lockdep
> + * complaining in some scenarios.
> + *
> + * Return: The zero indexed last slot with child.
> + */
> +static inline unsigned char ma_nonleaf_data_end_nocheck(struct maple_node *node,
> +							enum maple_type type)
> +{
> +	void __rcu **slots;
> +	unsigned long slot;
> +
> +	slots = ma_slots(node, type);
> +	slot = (unsigned long)rcu_dereference_raw(slots[mt_pivots[type]]);
> +	if (unlikely(slot_is_mte(slot)))
> +		return mt_pivots[type];
> +
> +	return ma_meta_end(node, type);
> +}
> +
> +/* See ma_nonleaf_data_end() */
> +static inline unsigned char mte_nonleaf_data_end(struct maple_tree *mt,
> +						 struct maple_enode *enode)
> +{
> +	return ma_nonleaf_data_end(mt, mte_to_node(enode), mte_node_type(enode));
> +}
> +
>  /*
>   * ma_data_end() - Find the end of the data in a node.
>   * @node: The maple node
> -- 
> 2.20.1
> 
> 
