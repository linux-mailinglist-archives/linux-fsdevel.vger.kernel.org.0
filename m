Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA66763BEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGZQEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGZQEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:04:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85E1BF6;
        Wed, 26 Jul 2023 09:04:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QFnA7J025744;
        Wed, 26 Jul 2023 16:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Vl0EDgU1iY4eX/vTjPqlZJv9rmezVLDsgHKX74aNlEk=;
 b=qi5sgKCbGdIyR1NV2ilRT2XMBYNvnvEKav8mrfZfDYheD+5Y1s1JWHWyKQ9rcwNfHP4T
 zvBfpIXw3aFCYOx5IKAdjZqq+F66ZDIWK+5SJTnCswjOUnMqGROySGuSFgBDyG1RwvXP
 h1PJXSctnfspTz/1PWe+ZU19itjDESlvEVADQtQI4lR0Lipr+ENj9mjmpUMrdZ4nZc0m
 SPGBSZwDjed78XrQmEJ1IKMi06SzrXIlgxbB8pzJiDe7c7R3XGFWMPKbOoGZueJHzh9i
 xFxfUEpR32LbG4IIiT0mNtnZIR4hOI9YcjyNLQv1kg+w2Wtr8pQdQ8h7GkjwCN0yNWhR OA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d7wy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 16:04:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QFWZXk011864;
        Wed, 26 Jul 2023 16:04:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j6ngpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 16:04:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImiShUCjBEsWUMVRVqDQiVvXnNSy/NZBjToFgSRs1ZJItd+Du24I94K9m6nlXukJvO9AAtSHlf4daJcHEPLsRxz5tsC+zMkMZjQxgeVXX6fLuGYyUcwHemD9lN1K7sJ9BpuWNWoMXZEKMjWe+jXgSIIFblZqXGyWm3ePe9pGA0iZe/6qKrPid7A9+oqoiFJL2vWnZxAVELCE5pU6mjwa3WXIz4ymOMfeYvrcQN+d2PN6nwf0B4zV0mjz+ti9xWlY6GjMFncIGrtGzkSOXvufB8f5DOAWSwBHaA34kr9t1zwjPOVdHBeYelyQwwUeq3UcNkK+xXlK3l4KQN5ZxgBEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl0EDgU1iY4eX/vTjPqlZJv9rmezVLDsgHKX74aNlEk=;
 b=K3vEdZYpdjV/TKtet9dZJfo2+tXhoMTNR1MY1ms1MLWN6djyN15+Y6IAiz+9NQYIJak5STuG0jMzt1m/1euu8GWARgboxmXAAqs1b+MGrDkEP5aMqZ/29aHuZLtBcJGmiVyM9I/ZDQJ2q5fepPxVxDa+Cxxli3KxK4QKYKojcma4D8fbYukskQvhR4/vV4dJfXtlRawbei9H2O2aiSvpm3+OltIUO/loslJHNJugxSm0YKH0FKrkRwgi0DoLp49+tEUSjNNQsUYifzrSHokRGjkODF4Zv1Do66fkwUK+DAzMF01gaYDYwtstWucNEXXKlAr8KKS/OHX6/rlJw4oscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl0EDgU1iY4eX/vTjPqlZJv9rmezVLDsgHKX74aNlEk=;
 b=JQG9NXonyJos/9Ty/TX/Tzb64VYL3n2N8n+sRFYvQ2v8sWWNywTQRbQZbgsrZMol0TQMnrMTOW4KOHSxF30Flzveb90fQiai4zhzYIuGl/kavhglEJpNnkMpkjIbXBRvXic9JcD8Q9fKpQw8L7DF5l7ULf8D5IQFY9hkZVyc8Sw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7668.namprd10.prod.outlook.com (2603:10b6:208:492::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 16:03:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 16:03:58 +0000
Date:   Wed, 26 Jul 2023 12:03:54 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/11] maple_tree: Introduce interfaces __mt_dup() and
 mt_dup()
Message-ID: <20230726160354.konsgq6hidj7gr5u@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-5-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726080916.17454-5-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0003.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: b57b4c98-a3f4-463d-f1c4-08db8df1eb55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWlUKrNPfC74ImWryo4rFgirmfccHa5gloM1gfMPVAZx6Meq88m2y5GQKL9ZxuKzr1qRvIsMz1CXhzu70B8uPK0O5c+ye++kguw0vI8A+5833o5cGN4lz8Ztiyfnry9y8rFVlBfYS8wsijQfVOfI0Ve6CnUUvf62h3W8jMqduurkxDRHlnO5QfNU277p5O1w+voPdorFGR2woKzTulzqeBeGOQwRYRRJsiKPch1YSabXbOH8Hx4RqF5uyx7w1hd82QwFWc8njvqm1ite2PuDJFulZ+nKl3IKsX+U+Z37CkzBa9MjBrgYnql8qyFo8SjgzbGxp17fhu4+anNB1YtRixYqu7IeCDoh9cu/69iLS5vCgnBkXOnga52bQY6YEAJnBHAAr7m8xS7cV3A9cMnms+zthBBX6/5M50VS3Q3dnpX+9MTYe7LF1OM6FGbs6o2liRoJxQ3oSfhVLHGZ4LChl/MkDhYFJTFnOdWMuA7f6RxzCB977mF5JxZLqxx/ly3FrEYgwA1zzUAWdNSpPNZpLEBQeMJTPcxz/rcURAetAv+j0Mp41XRKxdm7FmrRcmVN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(86362001)(38100700002)(33716001)(478600001)(2906002)(186003)(26005)(1076003)(6506007)(8936002)(6512007)(5660300002)(41300700001)(8676002)(6666004)(316002)(4326008)(83380400001)(7416002)(66476007)(66556008)(66946007)(6916009)(6486002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKiGUDPzi44uNdPrdBYC5zdxrg/zy+JHP1bEoDJZg9pqrBRglEuKjM7kzYPc?=
 =?us-ascii?Q?8HliKQfKiJX++xmpZfoeOOZ5dQ7Kpcd86ZHpWbwZarvBY7sNKb+gJo722Vp9?=
 =?us-ascii?Q?r2G/tDGHbIQRUpVNjxiudN/tZPA+rtd+ojHmYyqci7tKoyr+VYD11wG56gTT?=
 =?us-ascii?Q?ebh/AEYzaccdfX+HWmtUvf8dHHHHshmL5HicwvDt8Kz6T9pn36TYJksYBTmj?=
 =?us-ascii?Q?RGVFNNVPFOOFtXVy7GGmzcPAmQhlTGaWV7yUhP5k1rqbvZcV2ASGv0dWEkkO?=
 =?us-ascii?Q?eW25YG20gA3wWDlqquDMPFerz36ypN4Cg3Fyv5r+4lInhOMBtmyrseOT4Lcs?=
 =?us-ascii?Q?0QDoGPhuflcV2a5ponS/hVcCuXNDp8RXHfZTHPRPN/QGKUu0pbQV3ePO3WVN?=
 =?us-ascii?Q?2+KGVjLWmU8wrgZ5z4i/YBk082uZ8jSCOD7uQFcj8uYDWcuNaWzwCH5A2jLH?=
 =?us-ascii?Q?Dj20TTGooQAbSNXF+gVwUufhIqv63JX8SMlf+BtsVP1wR/RXmgE8NuOSJTDf?=
 =?us-ascii?Q?TfdksgahHLKKmLNoIzwT6aLuIt3Ob5B7InLsL6yW1cVEcU8M/g+UHsp/fvJp?=
 =?us-ascii?Q?+MOIeVthY6qiLPFRsiF0fMH/+aOvVOTvEyi2BjuBqO4iR6/bjjtiedCzBm+v?=
 =?us-ascii?Q?t+TE6TlVq//dAtwrp6M4M7lJYN53OIzv9iE2sn2QKHsyrjmYSgVnF8kO5910?=
 =?us-ascii?Q?yySYZp4UWHbdYcvEzmS8ysY9HsNcwW7HsOSWD/aD2ieqwupuQ9/SB2WQWowI?=
 =?us-ascii?Q?urqEwisBcKxt3UiBCE91yZg8U9N7DbbVXJzwvnpPPaZfHjIlL7ZB1V4KwiQw?=
 =?us-ascii?Q?5fPeHlthV8y15YpXoHmrplNQO9rIqJayGxlZMi3V9eLdyX3HLN7zQ15Kr83m?=
 =?us-ascii?Q?TYs95Ws6lT94dlMcyNVtt/nQaLJgiG4Yc4tgjdwHTjl2bVSS1wM3+7Deeuh5?=
 =?us-ascii?Q?D7wA3ZR/GpnUDRsoB6weS61fddSNMkr8ksgW+qttV3R1TCg3RCWkRIe0iLp/?=
 =?us-ascii?Q?oQGZu2kMIDtU8alELpWSsy24nafW7yHuDGi731++FMpQiL2VlHCatdURoK01?=
 =?us-ascii?Q?n565E3IAolyYIik/Pqeb1o7JxuYF4eFN2C1P+QW9hST8xrxPughVZNXyMYd0?=
 =?us-ascii?Q?6Zi4/+T7ME1rQUBc9j7RDT4xhXqQ8ELaXxbLt9bTzmEKQkuTO216UJhCddFt?=
 =?us-ascii?Q?KwhMtay8FgyimLAD1+Cr7NxxlIZcSJ+BD3XqCZS87OchB7JPQIZCKYTJDh/R?=
 =?us-ascii?Q?vhV1DrDLDxkYe9CAQjldr7sYxDzfrqwy9vGQNNvfTSf1gShVOoyGYITzSsnU?=
 =?us-ascii?Q?dx6X90RXHhyEugpngFeSQC6+uzWjC4bRgJZeLSATfYipFP4dYQAK18kOZJlB?=
 =?us-ascii?Q?N2C6QkSOS/2XZf1zHT5z9fKMBDb/NLFvbCYivdoxQJPhkFM5BnZ0X4WR+Eal?=
 =?us-ascii?Q?vkvpw3sKouqVpHp1vEMpAOrWtfXIzwSdb1fCIITDAUsikV2qTD8G1oUrX8O1?=
 =?us-ascii?Q?XaAYGOGPe4aH8nrzgJDmxpssWFeOFRSBvC8aKaUPYReUnsD6wCHfCQKMJGAw?=
 =?us-ascii?Q?CNtwcHZEIUkANwvQpCCXPTNT4pE8x5VJkHNXAqJbTujKkIuXw14fGFW9IALh?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?agiweP2+tR0+VNdM4PUnbV3s6Lw6fhx0PGLsgVLR2OjrOhKS8trjMebZLIVS?=
 =?us-ascii?Q?NTCrTK4DxN9MzlK5EYnNr4o3P5mAQx/a9QOUfMXIiDq87r7+vFjluLBpKVSl?=
 =?us-ascii?Q?IhPgM4DW0Ix0sszipKXroEYBUmALkcuTPGyrl4LE0wCsBZdpsiR++1BIQT81?=
 =?us-ascii?Q?rwVeiSOtOuWEQUkImI5z1Idaa5pIaB8uV42CS2yhb5NcdHwrNP3c5KgjKDJb?=
 =?us-ascii?Q?0sr6gtWUsIBqRqwLuMBoH3myLbiqijaKd6N4ZXIaAbAISpv23kvBsSEZS/iZ?=
 =?us-ascii?Q?UROaBV0O2bN9OSNtTr0op0EANQChRhbCM9H0qLWE+RyBxmLWjjJx11COrpS4?=
 =?us-ascii?Q?hOVUh4KGRbB7Wt4AtRrLyRjwvimU3dEgnUeu+Nf6JYOxh6fH4MPNi0tbV3kl?=
 =?us-ascii?Q?0uKj+cEZ2AELZ3t4dhm3QmX/Oftu5KREgTPy29LxzJEckLSqjMPWEvpN4LH0?=
 =?us-ascii?Q?A+yHFoJpGMya/ckKzPhxKqiFjgGq3+9jB2MuK9mOzxS1iLgpJQooBlTzH8fs?=
 =?us-ascii?Q?Idujq3ao0lb2yfGjDZQOWIxes+5YnED0LNIBu6MtBfBYk3y+amao75ubuPNK?=
 =?us-ascii?Q?dI/hLjZIMbRzITLC9NuLB8z6Ifd8NcjKUFv9x86x56zNYNsDqj61frbUp3vJ?=
 =?us-ascii?Q?cttrHtWiKU+juB0vvgIKO2hKL//6AvBhE9MczUPmfZ1ZdEmS/4VNApcBavGX?=
 =?us-ascii?Q?Ts2D/jpNETwgDRHT71DRsxiPv2oCu1LKEVUaSw65Wdo97hmXqkZVB1ywxDDz?=
 =?us-ascii?Q?WN+4+9a8KmcLTNT1q5qsJu/s0923zhD62xC7iKL/qRNCPh3VB159EsW4ZxrP?=
 =?us-ascii?Q?cDFJN7AjcihlcFEtgYTSNQ/4bIAHyrnG6yHtOpqDO5xamQNSndUmlqqK1VAJ?=
 =?us-ascii?Q?Ci71nK3AFXqj29odaeIldBiwrQPIpbUTKUHjRic70S2ZoB0xdkq6o+Hvw1Zl?=
 =?us-ascii?Q?0Hrj9IXctY6JjYM2r8aRc0OroOoWVl/uIj2iuIQlJnWK2oQC3dUzYcBlvVuO?=
 =?us-ascii?Q?7VH3sPNCnMi57dlPE1kljze+Z/X1EBLrpV/7A8msZvcbhAKj60cfD/HtTsMh?=
 =?us-ascii?Q?fiHC7sYZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57b4c98-a3f4-463d-f1c4-08db8df1eb55
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 16:03:58.1506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJYGT07D8PBc7dbCTylhzMaqk1zxeJLPjPfOedSQ3iCUOgPZ68q+mdOmiRTPl85ZZV1G18e8ftUkwWmQjzZ12A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260143
X-Proofpoint-ORIG-GUID: Nl0TdaM04PIzxi7X757Jywki5oyxUEiw
X-Proofpoint-GUID: Nl0TdaM04PIzxi7X757Jywki5oyxUEiw
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
> Introduce interfaces __mt_dup() and mt_dup(), which are used to
> duplicate a maple tree. Compared with traversing the source tree and
> reinserting entry by entry in the new tree, it has better performance.
> The difference between __mt_dup() and mt_dup() is that mt_dup() holds
> an internal lock.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  include/linux/maple_tree.h |   3 +
>  lib/maple_tree.c           | 211 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 214 insertions(+)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index c962af188681..229fe78e4c89 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -327,6 +327,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
>  		void *entry, gfp_t gfp);
>  void *mtree_erase(struct maple_tree *mt, unsigned long index);
>  
> +int mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
> +
>  void mtree_destroy(struct maple_tree *mt);
>  void __mt_destroy(struct maple_tree *mt);
>  
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index da3a2fb405c0..efac6761ae37 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6595,6 +6595,217 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
>  }
>  EXPORT_SYMBOL(mtree_erase);
>  
> +/*
> + * mt_dup_free() - Free the nodes of a incomplete maple tree.
> + * @mt: The incomplete maple tree
> + * @node: Free nodes from @node
> + *
> + * This function frees all nodes starting from @node in the reverse order of
> + * mt_dup_build(). At this point we don't need to hold the source tree lock.
> + */
> +static void mt_dup_free(struct maple_tree *mt, struct maple_node *node)
> +{
> +	void **slots;
> +	unsigned char offset;
> +	struct maple_enode *enode;
> +	enum maple_type type;
> +	unsigned char count = 0, i;
> +

Can we make these labels inline functions and try to make this a loop?

> +try_ascend:
> +	if (ma_is_root(node)) {
> +		mt_free_one(node);
> +		return;
> +	}
> +
> +	offset = ma_parent_slot(node);
> +	type = ma_parent_type(mt, node);
> +	node = ma_parent(node);
> +	if (!offset)
> +		goto free;
> +
> +	offset--;
> +
> +descend:
> +	slots = (void **)ma_slots(node, type);
> +	enode = slots[offset];
> +	if (mte_is_leaf(enode))
> +		goto free;
> +
> +	type = mte_node_type(enode);
> +	node = mte_to_node(enode);
> +	offset = ma_nonleaf_data_end_nocheck(node, type);
> +	goto descend;
> +
> +free:
> +	slots = (void **)ma_slots(node, type);
> +	count = ma_nonleaf_data_end_nocheck(node, type) + 1;
> +	for (i = 0; i < count; i++)
> +		((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
> +
> +	/* Cast to __rcu to avoid sparse checker complaining. */
> +	mt_free_bulk(count, (void __rcu **)slots);
> +	goto try_ascend;
> +}
> +
> +/*
> + * mt_dup_build() - Build a new maple tree from a source tree
> + * @mt: The source maple tree to copy from
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + * @to_free: Free nodes starting from @to_free if the build fails
> + *
> + * This function builds a new tree in DFS preorder. If it fails due to memory
> + * allocation, @to_free will store the last failed node to free the incomplete
> + * tree. Use mt_dup_free() to free nodes.
> + *
> + * Return: 0 on success, -ENOMEM if memory could not be allocated.
> + */
> +static inline int mt_dup_build(struct maple_tree *mt, struct maple_tree *new,
> +			       gfp_t gfp, struct maple_node **to_free)

I am trying to change the functions to be two tabs of indent for
arguments from now on.  It allows for more to fit on a single line and
still maintains a clear separation between code and argument lists.

> +{
> +	struct maple_enode *enode;
> +	struct maple_node *new_node, *new_parent = NULL, *node;
> +	enum maple_type type;
> +	void __rcu **slots;
> +	void **new_slots;
> +	unsigned char count, request, i, offset;
> +	unsigned long *set_parent;
> +	unsigned long new_root;
> +
> +	mt_init_flags(new, mt->ma_flags);
> +	enode = mt_root_locked(mt);
> +	if (unlikely(!xa_is_node(enode))) {
> +		rcu_assign_pointer(new->ma_root, enode);
> +		return 0;
> +	}
> +
> +	new_node = mt_alloc_one(gfp);
> +	if (!new_node)
> +		return -ENOMEM;
> +
> +	new_root = (unsigned long)new_node;
> +	new_root |= (unsigned long)enode & MAPLE_NODE_MASK;
> +
> +copy_node:

Can you make copy_node, descend, ascend inline functions instead of the
goto jumping please?  It's better to have loops over jumping around a
lot.  Gotos are good for undoing things and retry, but constructing
loops with them makes it difficult to follow.

> +	node = mte_to_node(enode);
> +	type = mte_node_type(enode);
> +	memcpy(new_node, node, sizeof(struct maple_node));
> +
> +	set_parent = (unsigned long *)&(new_node->parent);
> +	*set_parent &= MAPLE_NODE_MASK;
> +	*set_parent |= (unsigned long)new_parent;

Maybe make a small inline to set the parent instead of this?

There are some defined helpers for setting the types like
ma_parent_ptr() and ma_enode_ptr() to make casting more type-safe.

> +	if (ma_is_leaf(type))
> +		goto ascend;
> +
> +	new_slots = (void **)ma_slots(new_node, type);
> +	slots = ma_slots(node, type);
> +	request = ma_nonleaf_data_end(mt, node, type) + 1;
> +	count = mt_alloc_bulk(gfp, request, new_slots);
> +	if (!count) {
> +		*to_free = new_node;
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < count; i++)
> +		((unsigned long *)new_slots)[i] |=
> +				((unsigned long)mt_slot_locked(mt, slots, i) &
> +				 MAPLE_NODE_MASK);
> +	offset = 0;
> +
> +descend:
> +	new_parent = new_node;
> +	enode = mt_slot_locked(mt, slots, offset);
> +	new_node = mte_to_node(new_slots[offset]);
> +	goto copy_node;
> +
> +ascend:
> +	if (ma_is_root(node)) {
> +		new_node = mte_to_node((void *)new_root);
> +		new_node->parent = ma_parent_ptr((unsigned long)new |
> +						 MA_ROOT_PARENT);
> +		rcu_assign_pointer(new->ma_root, (void *)new_root);
> +		return 0;
> +	}
> +
> +	offset = ma_parent_slot(node);
> +	type = ma_parent_type(mt, node);
> +	node = ma_parent(node);
> +	new_node = ma_parent(new_node);
> +	if (offset < ma_nonleaf_data_end(mt, node, type)) {
> +		offset++;
> +		new_slots = (void **)ma_slots(new_node, type);
> +		slots = ma_slots(node, type);
> +		goto descend;
> +	}
> +
> +	goto ascend;
> +}
> +
> +/**
> + * __mt_dup(): Duplicate a maple tree
> + * @mt: The source maple tree
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + *
> + * This function duplicates a maple tree using a faster method than traversing
> + * the source tree and inserting entries into the new tree one by one. The user
> + * needs to lock the source tree manually. Before calling this function, @new
> + * must be an empty tree or an uninitialized tree. If @mt uses an external lock,
> + * we may also need to manually set @new's external lock using
> + * mt_set_external_lock().
> + *
> + * Return: 0 on success, -ENOMEM if memory could not be allocated.
> + */
> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)

We use mas_ for things that won't handle the locking and pass in a maple
state.  Considering the leaves need to be altered once this is returned,
I would expect passing in a maple state should be feasible?

> +{
> +	int ret;
> +	struct maple_node *to_free = NULL;
> +
> +	ret = mt_dup_build(mt, new, gfp, &to_free);
> +
> +	if (unlikely(ret == -ENOMEM)) {

On other errors, will the half constructed tree be returned?  Is this
safe?

> +		if (to_free)
> +			mt_dup_free(new, to_free);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(__mt_dup);
> +
> +/**
> + * mt_dup(): Duplicate a maple tree
> + * @mt: The source maple tree
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + *
> + * This function duplicates a maple tree using a faster method than traversing
> + * the source tree and inserting entries into the new tree one by one. The
> + * function will lock the source tree with an internal lock, and the user does
> + * not need to manually handle the lock. Before calling this function, @new must
> + * be an empty tree or an uninitialized tree. If @mt uses an external lock, we
> + * may also need to manually set @new's external lock using
> + * mt_set_external_lock().
> + *
> + * Return: 0 on success, -ENOMEM if memory could not be allocated.
> + */
> +int mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)

mtree_ ususually used to indicate locking is handled.

> +{
> +	int ret;
> +	struct maple_node *to_free = NULL;
> +
> +	mtree_lock(mt);
> +	ret = mt_dup_build(mt, new, gfp, &to_free);
> +	mtree_unlock(mt);
> +
> +	if (unlikely(ret == -ENOMEM)) {
> +		if (to_free)
> +			mt_dup_free(new, to_free);

Again, is a half constructed tree safe to return?  Since each caller
checks to_free is NULL, could that be in mt_dup_free() instead?

> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mt_dup);
> +
>  /**
>   * __mt_destroy() - Walk and free all nodes of a locked maple tree.
>   * @mt: The maple tree
> -- 
> 2.20.1
> 
> 
