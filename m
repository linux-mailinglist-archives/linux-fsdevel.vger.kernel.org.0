Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF565763D3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjGZRHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGZRHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:07:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124E51BE3;
        Wed, 26 Jul 2023 10:07:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QG8FV2014607;
        Wed, 26 Jul 2023 17:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=277mTBisfH1vYp5MW5GOcQNMf/zagQpkixePcFQKYJU=;
 b=eQiAi9HOaZIvHQCJ/28gIL07etr9i3moZni3bmHSXobISrerDq1OxjsJqocBpPnycxpJ
 bgZ0H5ZH0z9Rms/PuG5OQRGtwIspe/FdUdDVfd+QRD/pKrFTJCG/tiWRRCxUCyUMHuH5
 pvmYk5qXis1364u4R2R0NZUKBcNBYfZVEaB5CgH0MWx91cvD8osM+UVKaCFiOGX0CgUR
 xoZg82F2m3lTCJNwqbeSr/sAK8B+WZMefUxRE7E87+VtVUZf7uFkWJnCZteRdahGAuJD
 ulJujGZB9E21uIt9BiKliITzMuqHwnGgDkCV0kmZr6bpaeZs7Fzv8qK/nMhBKYY0OlP8 PA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3r09r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 17:06:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QH1A6c029431;
        Wed, 26 Jul 2023 17:06:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j6g7w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 17:06:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2heJNcFIa+q35+T2QWCRxbcLEAFsb2z3WBomVTASHU32C55pR+Iq3bO/Hw2UbkKc/ba8p4287qQDZpiW5kQBTangJJ4vqgI4tapfkjIVuZXsCIt2NozdO07TQHlYRlp/B2hH3nMPH/dKKKSbUQyM8qHRn1171/VBop5zhNBooomP1HFuQZ2Ubkfdq8iW08KMU6eSiNhvZBx9Fk3Bp+ozmGKRwLzaVwY7gV//rIPyYenZtzjjdjgvB4lPmTnfndNYx++2JGXAj58wp8LGBWHvXrVqGoBuTyHFULKHVA/sMcKJkDJtURB3acfuLW5ocVxNGKq4Lz1jBdbezLtyuTn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=277mTBisfH1vYp5MW5GOcQNMf/zagQpkixePcFQKYJU=;
 b=WXiiqG0vxgg+ITQImZrWVDTPA4gi4MwAbHu6YHK2RYV734ETzlI/3n566W1zKw2Hx2XwPqGg4i2ywplq7hj5AGIe93+cFgf5mNwql0BJtGMFTfWsmfOwGQDzfw+dWbLtJx1SHmFI8uuKEWkWwp+l39eEBflI+rmBQSPMoT9eg/bUfoWmOL6H6aFglDK2W2m0SV//aisHqNwxQy5lP7ODvj20Msuhr6kgZ3iY/EZwto0mzR2srrDKiudcGPV+p19HlOnFozx/L51KO2oRd5jdRNk3l+xpHMp8XTwtOZ3kaBs9n99ctVlW+ylikD+I5TbMXWd1V4mWbsHEh/sFrUCL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277mTBisfH1vYp5MW5GOcQNMf/zagQpkixePcFQKYJU=;
 b=DtS/dhemt5aXSKEoCU/84b3zOyxBzFf1ojwgYK42D6kXck2oTA+Q5eX4Y9fZmSQtKBDRpdG9jNY2UD0+h0T8x8am5NETqhsJ7G0lUWokBWm1Bf7RWiQF7LnIcxQzi2SbZsSKql9sEEcH7S0txB3Hvju9z+iNH6i2MvQS2OzZiBU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB4993.namprd10.prod.outlook.com (2603:10b6:208:334::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 17:06:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 17:06:48 +0000
Date:   Wed, 26 Jul 2023 13:06:45 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/11] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Message-ID: <20230726170645.2m2rbk325dy727eo@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-12-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726080916.17454-12-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0501.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 57185eda-0aa0-445f-ae1a-08db8dfab2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQ8ZxDjU5+PnBG0CZFdIsWaCC+XQ2BMkwEfu2bnG0S1fYmzrV7W5/xi0uj6pv3Lu/wItLoBdDEEgJvQixU8bt0StlIiq4B89Yjl7c654A+lTxKoYipgfyPl1ksnz9B8xEzNaF91tax+t+pzAHX7UnJcpt8LLUeXDqlERZP7USqoG+xB5ilWOaDBIxDAX1KQCw4U5dLeiSG5nVXtkaE7stHRw2cCHjZ+ZUFdmK3DS8PhwV8/LvYIlz9g0Nhpj0XGNWelml0yP2x9yXpZ1DK8DNnOPZhsO6uE7euin76gXYNqgJFj8ewTZKzzHlKC0oR6d2SDaG+p5393A+gCL7toONOCK5sokPeFMNRh9aND4eAyfTuPW7VhxVR91i4uTXNOwGozWXCkBgqFFEqbUv3cAWNtun9STS2YPH7YBN7vuxjVBRkHpTthJZANOONLb3dppoSYhDxsRQHwBna15qH6Y1lq45P7zRlP3XyEkpFd/B/lRxoaK4zAv483xTl50ot9tvszlnhlnXXomzpEOras+OFQZ7hZvPEg6D7SlkZo8+rSCyKtzQOcugen8ZVEHIpzztv7OWmbujP5BOHF2ry6pKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(8676002)(8936002)(5660300002)(7416002)(186003)(316002)(26005)(6506007)(1076003)(86362001)(33716001)(4326008)(66556008)(66476007)(6916009)(6486002)(966005)(6512007)(66946007)(9686003)(6666004)(41300700001)(83380400001)(478600001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AO8US2YbCC6KFTRi4fgHMvX5+OdkrpjnrXKaV4DQvaAjMindFGGIzSfwBskF?=
 =?us-ascii?Q?PaBOq2cwZKkvpOVOhX5U9mrvhf3MtayWYEDoD1mUPEL0XjbJLlOQzcv6X0ja?=
 =?us-ascii?Q?uWddaOXyh8SemUNpMBogT5NkZFCwEiZ3ItdivJ9vrOMrtYIKOoNd+IbH1/Yx?=
 =?us-ascii?Q?jypE2qIAv+N6W1PvDC8zqeHhaPpPfs48LW8aTVi3MGxtt7pdPJxrXsJNEMva?=
 =?us-ascii?Q?zsx7KhvngoQ3Jnzs6cOfSUOrRjsbf/cFyKin8+F/oKJZPm+hsZkIPARyy1+9?=
 =?us-ascii?Q?Abx34m57ZycPnZ8klCh0LQtA8ULbC9krIsXHiwPBgdZvVQueZge+gI24XT7x?=
 =?us-ascii?Q?qEAVThZRTgz6bRxUxraD2TfTGwJYDtnEsT9CbXAdYeq5IW7G7gI1IthZWjg4?=
 =?us-ascii?Q?9OQwVrObNJXNJMXEV8NStRBDVH2yFNuNnxmaLOM/gcb49X/WtHtl5xwLGGkO?=
 =?us-ascii?Q?a+Csf5LxWxzf3gNgAvFTLGMPSWrOHETcNeheGTsqBy90zGyCG0CzcYS+LYim?=
 =?us-ascii?Q?8Buu6ID7c5NZnW1JX3JxJLRlUnZI2FBpg94i9PgHZpmsN8xqhG4+KEk/T+Lf?=
 =?us-ascii?Q?Mxcmsu8rz8Itg79CoLM8NOkPdJhv3FAJPyUiGiJm8DOgD+s2nLcbA2pWOwXH?=
 =?us-ascii?Q?8e/lSRkOUU+7NHQ8hTbdUajLZh3/6weC3PEOQK7+vPQgU17EYcyTImFWVWcA?=
 =?us-ascii?Q?u13kyQy9uRgF6LiQD2ypFWQGz6KoN0kUpx5WjvngmkqYmW7wIPtmmU5NEev6?=
 =?us-ascii?Q?P9Zq/zNW7Myzp/A8fgC5AXw7WydqZAcEL9UNazcoNF0eGrb+tua33wfdMler?=
 =?us-ascii?Q?fCItdHk2bT/WOnjnLi6gaVhqq/g1zq3qLxUYfxN3C4gO3YGcOuNe6P3BkD8c?=
 =?us-ascii?Q?hC+srIEs4fEpxHTV29SZ75Rze/OjQfEb6Ae0B2pK5rgkm5jR8mYhZufE5Yp9?=
 =?us-ascii?Q?zD+YskBZb4ZpCz4bnevacr+SLgxU5cxwzi3wblgL6p6O97fCQjZXWeT+eql7?=
 =?us-ascii?Q?rm9fNYlD6PzNytcBgVqQWRww6TN/WOtDNM8owECN07Cr8qcNnabjOTJeoe2/?=
 =?us-ascii?Q?f5xFBjBMkMvpMrH/lX7hS8TBrokhkYTNeSZ7lldiNZPykIattY7AQBoVEiLk?=
 =?us-ascii?Q?U3AhOwEiqUqEg0b25m6fbbJkCBCMY1GqruOrk00c1b8V0pNZMUvbjMQt3aHP?=
 =?us-ascii?Q?O7UNAiiLbOhXjOzYd/9S36VZH7UIhjgN0lgiq/NnfvY3Ygi/Mtm7yeZVhVP7?=
 =?us-ascii?Q?c6jELObiJR588NHkprzmxwV/NezmAXyrgyTavJ9MVXS53M4YtqI9VxULr6J/?=
 =?us-ascii?Q?xOw2Y+4TqaZeTt488qE8UN+34kdu2fYTT5CUWQMmKSlNAiK/ZWNg6BE5mLH/?=
 =?us-ascii?Q?H9O1YwTcSFNLRnxIBqfMymEb85Vkg7imdbTLpO6NBF1lLuS1LmZKRWcwZxho?=
 =?us-ascii?Q?1lHW7Pv3Hwz+4eIC8arcNacEHtwVxLI+UVZHRDT4YALaQiUtM+Aox0OtXp/4?=
 =?us-ascii?Q?UJerkK2+UCH++/11NtkYfmCIFHj0/V4y9mLwns9fqIPx0tvSIDwLpadCMCDy?=
 =?us-ascii?Q?q2cb/5PzhWnUWFzwOQbi2bDiVNQCNWpqlPlgBGqIWW8JN3e+ThU/fg63OBcx?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yivnZJBc8GoAOl8On3/gNo49UQN76c5kN9PRkD5jwh6j9fKFcnSvSji0TaK1?=
 =?us-ascii?Q?DfXmhTlWcEHIm6FkMkgnfjfg9GthVKokIgqYwrZCrVrwoblHM7d8XYkH7hcs?=
 =?us-ascii?Q?K1JmXF260Qwt4uYM4Fs94rRAl3wnLS5AvOE50uMXdfBrpKcFBpDaCzMMY41Z?=
 =?us-ascii?Q?G72pRrKbxIfcclCYHK/EsSFFxkdVtMhid8/ETTzOQZMp/tYHgGPCYCEfsCEm?=
 =?us-ascii?Q?zjAPs0l6gqsx2S8NzL73MSCE53taX9BaPQB5F17ncs10qm2KMEeFe/JmLsd0?=
 =?us-ascii?Q?abuqYqIFLvcxWSzs+Z/I8/bPVX5UxU4YmC5Hehp+9lc6ms4qphBUwgv4zEao?=
 =?us-ascii?Q?jYbi2tyjGml9+iKLVHtm2taambLhWo8UdSRXc9dNsXH9VqJ/S5P1xIplcmSE?=
 =?us-ascii?Q?8pb2qWkPsZqn+pWhBa47iSlDY+Ce/HVHusZSFNncOnAFI9xA5Pvv3+Apgm9C?=
 =?us-ascii?Q?fuq4FD88OmlhlIHMxlhmT/rNV+MuzU6IbHH/eocoU53q2AXR/ld9OseGQz9Y?=
 =?us-ascii?Q?0BUtk5mMjNMUymxXkKW/AdIqdfHcwJJuOAW8Kskj2qX6vIPklc/c3EP+9T7d?=
 =?us-ascii?Q?qaAhVVWSU2778QdnKfA6gMrkvGYzK7dZPrRtHW7qDmF7ATxQzOGutPsy81oJ?=
 =?us-ascii?Q?YkSiJNuPJ6OPCkd0+KG4bTmaGl772h5pEf7Z72Su6RUuWyX7lkAOYT669rV6?=
 =?us-ascii?Q?Tvy252yaDe9S2jZIwIXLiAD9BZpEtrL5jC0Z0UU7g04y7KHnYJpSFs23p3/6?=
 =?us-ascii?Q?4E+CrVF3OL70WnCNAJV00eZLoY57cQyy+MZqvsQqXF1vkeWyi9hPRdw808CK?=
 =?us-ascii?Q?3tf4Yog+3Qmb8s8FPL23ZEYYZGoxwPdxfqa8cMBSO+/nGlzUMzZH37QZcmVV?=
 =?us-ascii?Q?YZUjqrHjj2/kOBKLGea8OgdwRVAOweHPhpBcs5E8549p64ZYo1bCJNBuBODa?=
 =?us-ascii?Q?F0TaYWqPot3FIhXdm+R+wSmr1aIqOdbTeEMKP3ETHBzxtpiFcvpAeiOiGLdN?=
 =?us-ascii?Q?ks3zJ0cPA4n1TDp/98cbilBh2aycoyf50UhDp/Y2kQ2ybLeH51c7geH/d8qE?=
 =?us-ascii?Q?RYk10+nu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57185eda-0aa0-445f-ae1a-08db8dfab2be
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 17:06:48.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Wv+QpbOzQ8sCj/yrS+ASEW//WtBX+oIyFTV67zCTdSt/AYsHq2Q0PVeD8IfPeXJf+rCaR+8eREy/FaXtt9ZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=741 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260152
X-Proofpoint-GUID: hKPaw3_j6EH8wIcxty_R4COYU5L9LaFf
X-Proofpoint-ORIG-GUID: hKPaw3_j6EH8wIcxty_R4COYU5L9LaFf
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
> Use __mt_dup() to duplicate the old maple tree in dup_mmap(), and then
> directly modify the entries of VMAs in the new maple tree, which can
> get better performance. dup_mmap() is used by fork(), so this patch
> optimizes fork(). The optimization effect is proportional to the number
> of VMAs.
> 
> Due to the introduction of this method, the optimization in
> (maple_tree: add a fast path case in mas_wr_slot_store())[1] no longer
> has an effect here, but it is also an optimization of the maple tree.
> 
> There is a unixbench test suite[2] where 'spawn' is used to test fork().
> 'spawn' only has 23 VMAs by default, so I tweaked the benchmark code a
> bit to use mmap() to control the number of VMAs. Therefore, the
> performance under different numbers of VMAs can be measured.
> 
> Insert code like below into 'spawn':
> for (int i = 0; i < 200; ++i) {
> 	size_t size = 10 * getpagesize();
> 	void *addr;
> 
> 	if (i & 1) {
> 		addr = mmap(NULL, size, PROT_READ,
> 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 	} else {
> 		addr = mmap(NULL, size, PROT_WRITE,
> 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 	}
> 	if (addr == MAP_FAILED)
> 		...
> }
> 
> Based on next-20230721, use 'spawn' under 23, 203, and 4023 VMAs, test
> 4 times in 30 seconds each time, and get the following numbers. These
> numbers are the number of fork() successes in 30s (average of the best
> 3 out of 4). By the way, based on next-20230725, I reverted [1], and
> tested it together as a comparison. In order to ensure the reliability
> of the test results, these tests were run on a physical machine.
> 
> 		23VMAs		223VMAs		4023VMAs
> revert [1]:	159104.00	73316.33	6787.00

You can probably remove the revert benchmark from this since there is no
reason to revert the previous change. The change is worth while on its
own, so it's better to have the numbers more clear by having with and
without this series.

> 
> 		+0.77%		+0.42%		+0.28%
> next-20230721:	160321.67	73624.67	6806.33
> 
> 		+2.77%		+15.42%		+29.86%
> apply this:	164751.67	84980.33	8838.67

What is the difference between using this patch with mas_replace_entry()
and mas_store_entry()?

> 
> It can be seen that the performance improvement is proportional to
> the number of VMAs. With 23 VMAs, performance improves by about 3%,
> with 223 VMAs, performance improves by about 15%, and with 4023 VMAs,
> performance improves by about 30%.
> 
> [1] https://lore.kernel.org/lkml/20230628073657.75314-4-zhangpeng.00@bytedance.com/
> [2] https://github.com/kdlucas/byte-unixbench/tree/master
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  kernel/fork.c | 35 +++++++++++++++++++++++++++--------
>  mm/mmap.c     | 14 ++++++++++++--
>  2 files changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f81149739eb9..ef80025b62d6 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	int retval;
>  	unsigned long charge = 0;
>  	LIST_HEAD(uf);
> -	VMA_ITERATOR(old_vmi, oldmm, 0);
>  	VMA_ITERATOR(vmi, mm, 0);
>  
>  	uprobe_start_dup_mmap();
> @@ -678,17 +677,40 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		goto out;
>  	khugepaged_fork(mm, oldmm);
>  
> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
> -	if (retval)
> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_NOWAIT | __GFP_NOWARN);
> +	if (unlikely(retval))
>  		goto out;
>  
>  	mt_clear_in_rcu(vmi.mas.tree);
> -	for_each_vma(old_vmi, mpnt) {
> +	for_each_vma(vmi, mpnt) {
>  		struct file *file;
>  
>  		vma_start_write(mpnt);
>  		if (mpnt->vm_flags & VM_DONTCOPY) {
>  			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
> +
> +			/*
> +			 * Since the new tree is exactly the same as the old one,
> +			 * we need to remove the unneeded VMAs.
> +			 */
> +			mas_store(&vmi.mas, NULL);
> +
> +			/*
> +			 * Even removing an entry may require memory allocation,
> +			 * and if removal fails, we use XA_ZERO_ENTRY to mark
> +			 * from which VMA it failed. The case of encountering
> +			 * XA_ZERO_ENTRY will be handled in exit_mmap().
> +			 */
> +			if (unlikely(mas_is_err(&vmi.mas))) {
> +				retval = xa_err(vmi.mas.node);
> +				mas_reset(&vmi.mas);
> +				if (mas_find(&vmi.mas, ULONG_MAX))
> +					mas_replace_entry(&vmi.mas,
> +							  XA_ZERO_ENTRY);
> +				goto loop_out;
> +			}
> +
>  			continue;
>  		}
>  		charge = 0;
> @@ -750,8 +772,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  			hugetlb_dup_vma_private(tmp);
>  
>  		/* Link the vma into the MT */
> -		if (vma_iter_bulk_store(&vmi, tmp))
> -			goto fail_nomem_vmi_store;
> +		mas_replace_entry(&vmi.mas, tmp);
>  
>  		mm->map_count++;
>  		if (!(tmp->vm_flags & VM_WIPEONFORK))
> @@ -778,8 +799,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	uprobe_end_dup_mmap();
>  	return retval;
>  
> -fail_nomem_vmi_store:
> -	unlink_anon_vmas(tmp);
>  fail_nomem_anon_vma_fork:
>  	mpol_put(vma_policy(tmp));
>  fail_nomem_policy:
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bc91d91261ab..5bfba2fb0e39 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3184,7 +3184,11 @@ void exit_mmap(struct mm_struct *mm)
>  	arch_exit_mmap(mm);
>  
>  	vma = mas_find(&mas, ULONG_MAX);
> -	if (!vma) {
> +	/*
> +	 * If dup_mmap() fails to remove a VMA marked VM_DONTCOPY,
> +	 * xa_is_zero(vma) may be true.
> +	 */
> +	if (!vma || xa_is_zero(vma)) {
>  		/* Can happen if dup_mmap() received an OOM */
>  		mmap_read_unlock(mm);
>  		return;
> @@ -3222,7 +3226,13 @@ void exit_mmap(struct mm_struct *mm)
>  		remove_vma(vma, true);
>  		count++;
>  		cond_resched();
> -	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
> +		vma = mas_find(&mas, ULONG_MAX);
> +		/*
> +		 * If xa_is_zero(vma) is true, it means that subsequent VMAs
> +		 * donot need to be removed. Can happen if dup_mmap() fails to
> +		 * remove a VMA marked VM_DONTCOPY.
> +		 */
> +	} while (vma != NULL && !xa_is_zero(vma));
>  
>  	BUG_ON(count != mm->map_count);
>  
> -- 
> 2.20.1
> 
