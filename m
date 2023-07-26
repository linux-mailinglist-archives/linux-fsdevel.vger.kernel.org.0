Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A22763CA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjGZQkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGZQkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:40:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D881226B9;
        Wed, 26 Jul 2023 09:40:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QGEKNh017717;
        Wed, 26 Jul 2023 16:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=hkIRTuo7KbVSLLVWs5msstgZV9M+097rwl6Cs39rYaQ=;
 b=eadIIswwGEIlqHEclx2va7+LGMOwbBmLLMAesojoBqBdwkSWQSat0x5nUBRFotwfwhV8
 V6nD5V8uH6bagfxFZMv3ctUdTfTQpMlI9hXGpBOGYAvUBsZq/SMPiuCfoLjuwvNA5qq0
 oMOwhO8/kwz7nnqBwRauDyYf8PUmPlJ5A3n+/ZyXKa9MDYyatZO4DFVcE1scVJqbBdSD
 hynX8u5gXyIW80KjgLZiDetk4Up95C+Jsv6wdz1ZWmOKzOLx8z3FUXxCgTgNIL+2Kex/
 kBjWE9PKZLNN5lKyWR2PDKKM0O+SQcRDe6V22pc1do7se9El6WcixRUK+HndC3nQ1HPt NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c7yv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 16:40:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QFZWNh025271;
        Wed, 26 Jul 2023 16:40:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j6xxkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 16:40:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibDN3jfnW4DJiYlpekfH3dNMULFnFPGTx5s3av9X/JfKhQ2FOHgGmT5Rkk+23PAOsjmjeeIvHxBlfRjw8f3h4ETrqTb8YqTZVRMsbEiX8z6SbGK7+lUWAg1ePw2BFg+/q2Z6eDQpX3B0QITHdoQzohghdhkLLcpiYsAUJL3a7qu8szJ5Zopos8BVp3uW6Ehh5sQh/di1n0aEQx5W9svRbD8Ne927Et/n9J2tf4j3IHHgQCIIWjFvoeOH0Vaj02fYtbyF4xj6CQWOYkNWhYXl+wu86tt1H/nDUyKCOUL9TIHFigvUCeV4DOZzYH51CxwJ9B4P8k2NA+kPBSX2PiRQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkIRTuo7KbVSLLVWs5msstgZV9M+097rwl6Cs39rYaQ=;
 b=P2hR/18f3xZhnLxaMYeXryfgUBzuXFrobragRgFSokVIviDF75rJoJ/KL4oJbzaQohGMrlNWmkOgiLxVAif06S77SYWOvkoMc2DIIblztvrYeqnwUJETktnjGLnLFuelhUrabEPqK41tDAjcmXYMzpuBEKsos5JvQlRd4fCTlGZyKKVIHj/0pab9KKxNLRBGbzALdrXn0NMrgVmnifoLk/850K3J5DCB22bJ3BfKhJr3fXibWUtzY/rwiB1iXmAZSOsn2DjG2M+ryqk7WFOR24Ik1ETOdrZ/T4fe0NuDNij5QI4w84EyzcU5a5fVsaY6xZkKKaQaH1divVbgMsH18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkIRTuo7KbVSLLVWs5msstgZV9M+097rwl6Cs39rYaQ=;
 b=ppR/BJT324dvfHvtdLFHDDx+Es0IuwjUXHwgt+aDcDJBzT11/biscRpK3lwbmtNNtQp5AhiYZs98hptYkBQo7YrEzMxRUsYBPlL9DZJZW5akEhaL6r1y3a4SRefXjgKy2sbED8pMazho8yCXcuhL1fTIa4k/IAT5QWhPFkyPxgc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB7411.namprd10.prod.outlook.com (2603:10b6:610:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 16:39:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 16:39:58 +0000
Date:   Wed, 26 Jul 2023 12:39:55 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/11] MAINTAINERS: Add co-maintainer for maple tree
Message-ID: <20230726163955.r47vbkgjrcbg6iwv@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-11-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726080916.17454-11-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aaf7d44-0f0a-4027-ac18-08db8df6f306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPo3QIYngoI+8MZNmz2tq8zkg5jgpwM4W8DWF5Ewzo1k91nUG12EhjnvfzcJ64cnw+60DsDgydM2+p73GRp52bOQclDQPzE3RR6ucwKz/uWSLSP3AkSr+BU7Cbfhztdro6X/O8X3FzfAhN86d5yEkzNCp8b9BcoBY4mSHyZFWXCJ9zR6Yl8S4rbQocSqwokMcrLAvthBNxgSQwBJd2tHsLRuLADRw+OK/Jg+m8oviS/i2MYFgBdgFOyYIA4id1fyv+f8gVZFs2ixn5PzI89myOL83leyVWoEr3mCPCVEyYMNTrVMs8D4z7eVYLUHpIwZXQZ9ZpzuO28Y0Cxi0VIbDiBaE1QloBOhlZRQnGCumKdYYDzcvAsyC2T6TOny5BGsrw8fEZ7AArHoVPIsJi6Oui4wCn46auTkvdNqHLXqeDd5Bf4wAUwlwKTCX8uGDhdBxjq0xS4+lSAEie9ln8GZLcntUZzTr87LZA7mzM0YqYiRMnq8WAfSXA9W1y6/EKUMUj7y29la3x6cuxcW8mwIWi5e6E+CQ9dqwFjmHixMuo3Qql6PFvPqBQToQMigJ99m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(86362001)(33716001)(2906002)(4744005)(7416002)(186003)(6506007)(1076003)(26005)(9686003)(6512007)(6486002)(38100700002)(478600001)(6666004)(66556008)(8936002)(8676002)(66946007)(66476007)(6916009)(316002)(4326008)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tbgSfOukiPWiF9Zkcwu2dwKyCenQpHYomYkeUOm3Ljz40NA2NNXJipZ/EtMe?=
 =?us-ascii?Q?D19KTEbUh+kawLpiF6PoD7S+tmrH55uW/GH6hftVn2Vl2+tMGiouq7Eire4v?=
 =?us-ascii?Q?4CsYl+InXQrLbwdG65hzPX8EEP76ib0PeSCnVqUozjS8JhX2/iSSjj5rQQDZ?=
 =?us-ascii?Q?jirCCx9/8qXGv8K5yE7g3lt8RyADK5hBHu1giaucfxo2Hw67Fu+b8XrG0LjE?=
 =?us-ascii?Q?sir1wrEn0v9/us0LHVYn9W8eY/bgSuLAGim+SGcY6yIcz6nMPaCqIiytgczV?=
 =?us-ascii?Q?bn/2eO7nZkjY4KRxZuVail1LdtmGn4kcpKgpjaIvtJRNRDC20SGvUjBb/Ox6?=
 =?us-ascii?Q?afgkUQmpTfhebFPqv+QHFm7j6B2a6glINYMFsqk5ABOOlAXmFohms7ez9r4Q?=
 =?us-ascii?Q?2O+mNcOTVZyDGlEpHdfCpoZWNs+lFjvCOFY24C7QH40HhZawOop6U31KAjyy?=
 =?us-ascii?Q?Lt0kgvVDy2B3wtQYJlNSdhXiKLfycElMpknPSJ/n1IXhkcDyqGN/taDRGxXU?=
 =?us-ascii?Q?ebN0dzBD0fz1h6mRBbMBZK11kM6I+bIee+tsnj4GtiBJFtj1dfHB3wczBDyf?=
 =?us-ascii?Q?G9wIolmxGJow1pQMHKokivqbeQT5BvPfNTBJooVMVxImZPwM2vAIZ7Ycxz7p?=
 =?us-ascii?Q?Ssm+LVmPMPMIjw9HsJFO25xsNfm/BjAoau+smrHyt5lbLC0DBl4dhm03BS91?=
 =?us-ascii?Q?xkS1o3VXYUZWYyHIVbcAKIwRiludxL1ktExprCQaUPOhbWmdxUT45woGTvxY?=
 =?us-ascii?Q?+D7tBf4xYxew7BTPTfoWJ/k8HsvXquOP2nYxu8BN9V2Khc/jUpie3sC8aDvI?=
 =?us-ascii?Q?PIdNdyy30fu5l2edAvlFhPqZ62cbg4iQM0qa6VzyUGc3XfeQfV8FVdN9CAaB?=
 =?us-ascii?Q?ZWgT1uSZsk+tcf2LIt/swSujSVr8vmTUGk5sfU/z8aOKArnn30ZcFkI/OGI3?=
 =?us-ascii?Q?xGFWmKtr4lrFEQbD5Y1xNVYKHatDnON7lu/eBQX/krVs1+aQL1U/E9ZJbrdb?=
 =?us-ascii?Q?oActSjmG5f4XO3GF4Bk4Djj9lMtxzsXSMUDF4O1GyUDt6a/GtAnMOT9oFQZc?=
 =?us-ascii?Q?jHDsUssqnFgxaVtnq680qZ/7WW78H1eLAtzA7fv5+jgEwAl0+IHNCL8YJUzp?=
 =?us-ascii?Q?AbTJl095X/lEQu3PN6EX+7pQROaB7eNG+ckjT+DiW7Bjj34H5VBekHzXNODP?=
 =?us-ascii?Q?MChHPnzTMsvLrmdNohF2r4nu8MqtByvBH4NIF9u3hPHtLpQfCgNPdKMnHO+r?=
 =?us-ascii?Q?3LkfXoFCenbnu39hTvL0WdLr3i2h/FrG4VS4yCNJt/d/sWOZSYifIwONkEfN?=
 =?us-ascii?Q?b/ItE4w/0gYvLtXWkToqBP7M0w1OX2RlWPbUgd0ov7sjW5WtlaDFBEDRfS4c?=
 =?us-ascii?Q?psXsZsJqQZ8EAmHKAnV1afijpLHf7U2pYLLErZO68UmXHqCUZOVzlb1C9QI4?=
 =?us-ascii?Q?HlOxmN8tvAqoEm4N70nGgQ6tddQft/35yRRGsaWv+93o67RiDp4/+F4BgUHM?=
 =?us-ascii?Q?jf0MAH7TlYENTyBDptQEWY682kpM9F5lB+1uRQ56G5QNzMIREmr2YskAnAoS?=
 =?us-ascii?Q?9Du1aeOuHq/JKlNdMlYPAdiGzhi0O7EjA2f3i7gD0woHDRBzeBf4tJCi4TQJ?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1Pu6LnWKd+5PDPMFbhuVPUoAPB6q8GQNbpm2XS/2icW9yZc2sxl5EMkvmek1?=
 =?us-ascii?Q?9SzAVqrzEKu4ZLsYo/rNxl6Wh4nlrZLpCVyeDYwjxrLhG3DyOEqiZ6PJHDdw?=
 =?us-ascii?Q?3AsGbpRTHGKz/CECYmlQfjagSavU5wn3dHs78oiSH503u/dUQkJePJZfJOxV?=
 =?us-ascii?Q?QXDV0kunBGm5JqfdMyq3p0hBDr6O4xBStLzep0V53hOeE87VzQaflGc+pRDW?=
 =?us-ascii?Q?4ejhNgrr7e3sHFHAY/1gjNgEtDgPGdYdUTsxmCTQpE8B3ojl5t2hZPcAvpxF?=
 =?us-ascii?Q?XUeTjKdb6yb0ZJL8LgcqXYh5fyM3OJaHvOoBEbVGmQUrYyUCCNgj1nH7MeR9?=
 =?us-ascii?Q?eVBPzDztQcsRLq9XEskLCCO2o35lA5BN0gY7huuIITLJycM1+m6ek4xnOSTx?=
 =?us-ascii?Q?KZkRcxMBYibkgiuNncj4+X4WD+paHxY9vW8IX6qOZ8RxIaIwwUjnJIaxSp3T?=
 =?us-ascii?Q?NgdA1rk7zgdZB5hLNl4XimyFuXW5p7l8x9Ep0zf4d4bOZeV+2+cuOE4XJljW?=
 =?us-ascii?Q?P5mNzoJnfW78fszAF1qEcJTwWekcg74i9a64+6mO1hfZaKIeC2SSqiWukco8?=
 =?us-ascii?Q?uk62rBCfi4/njK7HTtbg4YmRtq+Vb09HvegmMczIsD2GPXAD8E1KvpouHpyT?=
 =?us-ascii?Q?vg47EDSkVwowk4zTOjTiuDww/MRzxI+EnOgw5Y/c8EUDhtvUwf8FtTCizi4H?=
 =?us-ascii?Q?XGmr3iaHT1lGX9jjnQDPx1E1MdrJFieLj3MM+yeIR8AzRtNrxXDZau4ZmqiW?=
 =?us-ascii?Q?X80YbeA+UnUVcogXBxuHhCJwevfaNmrx4eZsQeDnKb31YREV6j/xiQBaIkna?=
 =?us-ascii?Q?Hhn5CaiRDzyfPvdTTD0I87JRM5cfrVsldo8oRoifaO9a20fYbQyJjFijYPi0?=
 =?us-ascii?Q?Be8p9va4KTQKDl/Gbyfhum8otgOZC+1D3QBbujWqgjYMQy2YUKh8ottaubMe?=
 =?us-ascii?Q?n297S4JpM9NBa5wrAUR405RaHHc3lMA6uWE3Zt8rfuXj0EocTlDKnMNFDh0T?=
 =?us-ascii?Q?HXY//kQbIvh4eKJXXioWMq0UuQ3gCpChLyA2g2R2tFM/Sm8/jiHrp4NMoPcn?=
 =?us-ascii?Q?KvyzdwNN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaf7d44-0f0a-4027-ac18-08db8df6f306
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 16:39:58.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OSM51ZOZoAcj7Ax11bBjn3aw2m1IcM+6n99vkQ/EvL3rAmKjQhpXYouAMF0u4anR+B2rb9d0QL3JOua2nN2PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260148
X-Proofpoint-ORIG-GUID: iqhqqJ2KOt1lBw-eisdjjClDDV8HW4nx
X-Proofpoint-GUID: iqhqqJ2KOt1lBw-eisdjjClDDV8HW4nx
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
> Add myself as co-maintainer for maple tree. I would like to assist
> Liam R. Howlett in maintaining maple tree. I will continue to contribute
> to the development of maple tree in the future.

Sorry, but no.

I appreciate the patches, bug fixes, and code review but there is no
need for another maintainer for the tree at this time.

Thank you,
Liam

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddc71b815791..8cfedd492509 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12526,6 +12526,7 @@ F:	net/mctp/
>  
>  MAPLE TREE
>  M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +M:	Peng Zhang <zhangpeng.00@bytedance.com>
>  L:	linux-mm@kvack.org
>  S:	Supported
>  F:	Documentation/core-api/maple_tree.rst
> -- 
> 2.20.1
> 
