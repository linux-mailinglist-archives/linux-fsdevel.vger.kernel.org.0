Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CB06F969C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 04:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjEGCgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 22:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGCgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 22:36:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C4213C0C;
        Sat,  6 May 2023 19:36:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3472QWef012664;
        Sun, 7 May 2023 02:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=SzvAI4qe40+adXNSVdcwVPW68+jo8xKJakB0HNDCH5U=;
 b=2XX5WnkOsD/bt/jK//nudtbUjLLKfd69KzPJpdGgpo+iaqThvBsNvdmCqiL9OHLY3KUC
 s+lhbVlE81WITSkM+xm0kNyVnUx7CIzmh8yvuUyC/qtHiUV5ieLGOXf+FIMZwi+ao22K
 qqaFlR5OGQXZCXqoxVKlFS4pEWZd2tROMhY6frsxuARMc2TzgwTephQ6P8FyuXSV/xxo
 zsHPtaul2LpSXLkaRDnfkxHv9NkHIx5xpJ6ux/t3vccC7Rw8DTxEZ8pupnAB3cLKJ7jL
 v8zHrcWq2Pq2x3j92IekIMbPpZylWWcJ5oZjubyBDe2t75+BvzNOYiOEispE+wgPuGyr sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qdegu9366-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 May 2023 02:35:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 346LCwuR011384;
        Sun, 7 May 2023 02:35:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb3pggy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 May 2023 02:35:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmmOe9zSE8/izQcIZoIh2/MWP/GfsaMJ9fWN45JhuvED1zN+8Xi/jms6DpR9lot6C5b/m65H8XI0ZsPG5D0y3mnwt/qkpUiNP5WD5uRncaA95pYRAI/hAZPBLzzkzHxiTY1A7FTWN28ZLX84U1eFr3K8LP4QLPcjFYOQ+WulL2fiPwk07FHRMbmaq6NZcx7zMmfbk63lYfIki962UgLXvM82jJF8k0Xk03+BcLb7pMRLE0ECs8c91vxhnhGxdCh7TtBswdY2W4Fx0Mt5/noICkRlJfOkH5b0GovPBLzSry682YiqfJSjMhIfaIraqK6Bleni+cp4GOLaMOkOP8kvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzvAI4qe40+adXNSVdcwVPW68+jo8xKJakB0HNDCH5U=;
 b=jqn+Kwm0fXugH9ne9Yagn6c/qNACMU7Op9pbkURq7G6wbLE86Jb6YeIwMAE2JKiLowC24AM9dYjS6kjcgzePlcJi/bYVl1ycS9M+y9KwLRwoiwhnr9RfJxLbnaTjmzBUjBWWUA97s05iKs01dkxfrqyaxAua0Ubyebs2rXhuCFNLuDp1e/E0Tnmkc99Glk+VfhUv3VXtRZjQ5eE2RygHdS6Ov+pCFXZbGU4eXdEeZdC97gSZmCsEyHQDQcA+XRD0oxLHCP06AzhChIqt/eirVNI2kWCYHxuzlSueoTN7W+ta/RZ9Ve926Y51i8Z1dBbFwg8mQSTwykkbRLXq1DUnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzvAI4qe40+adXNSVdcwVPW68+jo8xKJakB0HNDCH5U=;
 b=Ve5LDjtaroo2SkoQjRJX2WNgKxhCkcaKHTe1jF8ZRD5oAbfspFE7zn1JtCYgQoeu7GmmOGvv75aOuxAWNPDfhqMBjIyYBXVjBo+9bBygKL+k7Q0Q58i00770PbY12T2zOJmaOmSr/aSx8pewpCAu8VNw0e433cIlL8j1JVYetgQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sun, 7 May
 2023 02:35:35 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6363.030; Sun, 7 May 2023
 02:35:35 +0000
To:     Dave Chinner <david@fromorbit.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfc8296b.fsf@ca-mkp.ca.oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
        <20230503183821.1473305-2-john.g.garry@oracle.com>
        <20230503213925.GD3223426@dread.disaster.area>
        <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
        <20230504222623.GI3223426@dread.disaster.area>
        <90522281-863f-58bf-9b26-675374c72cc7@oracle.com>
        <20230505231816.GM3223426@dread.disaster.area>
Date:   Sat, 06 May 2023 22:35:28 -0400
In-Reply-To: <20230505231816.GM3223426@dread.disaster.area> (Dave Chinner's
        message of "Sat, 6 May 2023 09:18:16 +1000")
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0229.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: b9743ae1-e1f7-4c58-2be0-08db4ea3bc6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5Mp2P3uZFE1UANFyP/MYAv4+zxe9r3Yowr/DvEUxibrvbe5VsH54gbrqb+EhCBrtesaacR0eAHx/qRBkTpyN+2HYjCcSyZFVgregWmAny2Mo5rSzJse+OuZE2z0XbLY6BNsPOoT9clBQNY6GBLFy2eESsJ8bCDW5j9mnGw5GzEXPxqUN1SVczXcrxgPCJaXpfko6YJ26o9tpDqrakMaGQMQAWPs0iivkEfuiIEYiUEbA45cRjeMjIVrBBsLEVHV4SgHGua4a0fqODd9s05LJU7QAkav+z/lmJjg8aUS74wiHusV0It9tU9n1ZNOwz2ewqqGFb9/ozWugdSidorZLlGu6Dag/F2BLvFWaRHBUB6H8Ce8fSnscVbUb9s46KkRPMYmptsi43qSjlOLCVd99Kw+7flAMmbSLspm91gNnUb8B0p6mVLXAiEnToRTsA5UusEIZGShTq6Dzp/3IALZjmIuuoxc/t7xePxsgiHsiEzdtMT/eLlmyBnnNuqOLf5QEQKacvzPzobVDzD1KSrjeIyaFHrkX4cFSU6VG4sSyZVlubiaak86jiRPdf4ALDVI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(6666004)(83380400001)(36916002)(6486002)(186003)(86362001)(38100700002)(6506007)(107886003)(26005)(6512007)(2906002)(4326008)(66556008)(66946007)(66476007)(6916009)(54906003)(7416002)(8676002)(41300700001)(5660300002)(8936002)(316002)(478600001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFWh/73XHX0DeptayWMzHz5u1TNATI+wlrK3jw2JPpCVDtu3YWMrdbiA8pQZ?=
 =?us-ascii?Q?NbYVfn6pFCLMxSl/JYQvn9f+RuYpi2o086Sect1tPRPU7ldzD6cc2isixVTx?=
 =?us-ascii?Q?BAB1ccdqNkIr7Y6StMFoqHE9BP9gOKgOuBmMujHfC/RwVFqC0uVVixOjz+0G?=
 =?us-ascii?Q?UMmRTSPls5fH7eMNE4QTHZnK4IHTiSSOmP/4DuxdIAxGKgiW8KZC1CsrEMFx?=
 =?us-ascii?Q?1rmjc5lU2C7revCNiBuc9A7R6j1PTK99m2c0/cl1VFFHxe4rrY2/xZudompL?=
 =?us-ascii?Q?XgPo5MFHQtIuVzFyOxNvgrhhLpv10PM6gKxaFugDI0htiYoYyyVX9hpxGMmo?=
 =?us-ascii?Q?mY3ZaQ/gTz3AyWQlDLdOyVeS99fI4EC4eda13Ll2J4zS5BdcGA1/yj2gwQyD?=
 =?us-ascii?Q?EfK2CTeYZeIaTb9rFOZOngTDo8D3Wv295h1E6w1VeXvaJCK9R+YkxfBaJ4vU?=
 =?us-ascii?Q?jZRyL6XcU+1OIaV29FTIwUN0iQmnADWBI+6xHn2E3wsrbVZgRfgFvwxpFG8V?=
 =?us-ascii?Q?hdRtdL9JVjMQdVmrowiMgZ0Dh3gRusW9//Ehvpr1vz4bE55yYILeer4W99xj?=
 =?us-ascii?Q?agOCTb+GClnw4MhB4IFImrkOWY+95ZHNykVhUVSVn6ZxPySju0nTvBJDXl9C?=
 =?us-ascii?Q?n71nEhBrRXB/wF4lk75OGxBCsUQml26pQYMxKMYcE8clqQw86sWfqjGjum9m?=
 =?us-ascii?Q?fR0Pa9yvjqPq02/MoRvzLTnYIsEF5rW5A4S1ZB62J9PsxYnoqvrSW8njvD4Y?=
 =?us-ascii?Q?J0N5ahQBKxGuQtz2SoiIAY2FzjKlQLfkzrb4YGNA58pJ4jQczX2eq59bY1v/?=
 =?us-ascii?Q?5zYXPkaM1hZ5y4RlbLERUKe/JGPaIRJKlSbxoSIESglvQ9EqyH+01obwLje6?=
 =?us-ascii?Q?aQ4kbtZ5M88xYx5WsbCOKnTh50JRcCiakdJp48p8oE0w2PXNKZPNa6jQPR2L?=
 =?us-ascii?Q?4lmzYTZTdH4qWMpFaNm6x+JNiGVbpxMvIKL3mgHschBL2AJIiS1PpHDaR8xS?=
 =?us-ascii?Q?cNT36nEGbc98HPsasXPIXNFvaDSZh5SpevteX4MHvsj3vaue1XbbORwwDQpU?=
 =?us-ascii?Q?inVphQp2WONlKIp3MiTluZjo++NE2SPHXhne6GAFXB2+680pBEZuSGfrhi6A?=
 =?us-ascii?Q?PTTxzRMcpg5OW4FxwwQmteOTjZfD/M+Im5m3RvjsXC76t88ztKp4wb6M7ANL?=
 =?us-ascii?Q?DzUyHDJ8dHbmSZzOvhcFuoDGSZIXFTzpkFqelJWLzWr6ROZ7EDRwVm7oEjJM?=
 =?us-ascii?Q?Ep6Zmk6vcZO8KSEx6hWnyyiDhSfnSG6K6Kj+lwj8Wa+RsfzMafFivakBEvWu?=
 =?us-ascii?Q?QUcQzIfjwrs7ZfbkpsDLiC8E5PL9c+QqpYqEpck0EgVym4bmtAk6X6PwJvS/?=
 =?us-ascii?Q?kGW1mMYbn4WznXuxFD63OFod5oj2/3FM50jRZHJaIDA+ejUWN36HOA2ZLoo9?=
 =?us-ascii?Q?e/Dx8s/l4nn6HCwrbzWncuSluyZct7PbRldrp260V95v+MDYVa6ydJv+YX2q?=
 =?us-ascii?Q?PCM1bKeSHExZr2Lx7llOlbQY9AgvQd6rddwEyoEXPgovN+dKfpQwCkZrETLG?=
 =?us-ascii?Q?9h96bVQMX6GhTIj0IxBvjeGm1cty1cdJW5vTfB0jquD+ZVfs7U552bSUSMhf?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5yVaOOZuk5kaudMrN5iyhqImkVLa5uZjafXemnA4LIaolADN4paiyQxjzanu?=
 =?us-ascii?Q?tcwkk+sDWIsTlVOtP5ICwXyTLGfC6pvWC2YeagAC1fi4DeIXsZAzJd8ZiutT?=
 =?us-ascii?Q?eD1HlQXyYVJ1RFLEIgKpU6aYgWlqiQctkwlWlNPxXRmAznUJH27NbS5jny/v?=
 =?us-ascii?Q?Wj42Hw2DA/YDp+AgPfaDRQYU2BG9AsGj0tdRiOhzVxYHqjBEAwCxrQJJeyTx?=
 =?us-ascii?Q?qLR8bRknt+4GXO42FFQpsvSWrJme6PDqQ1AbXSgVkANhRlP2Y4LiW8w0wJW7?=
 =?us-ascii?Q?3AV0PlDGVnd+fX5t9ddwQ20Ke/vy8ZUJtA3qGNSQoc+E9lv0wvZ7utEtxmgZ?=
 =?us-ascii?Q?ubo0hfsDLYQVm/HtWaKYJEmmC6ltm8y9nEuv4ny4n9tPl54tIcZx/jPZQ3Ka?=
 =?us-ascii?Q?UX9b2XoyeF8xmMmZolbz4qTcnSbeoBXdbLaeBKQwuey0PDvlX07zgLAm+Fc+?=
 =?us-ascii?Q?Eaq2JNksmw31GaW/WtQqUErCw2omA574NoZGywVHba4EK0LLTOJwKuKchjnm?=
 =?us-ascii?Q?kru/I7rrtNwAXl8dThhWPN5M5dPUEhFWkxcm4/8UhFmi/tPlgQEF719K8k/F?=
 =?us-ascii?Q?nud8bQgYBjPOw2IBxRaibBYCCuBtZZCAvoNWlsmIXuNL3sEVXfB6kkkUzbrR?=
 =?us-ascii?Q?rcgJh8ocgn1AWXU0sKNQXCpJW9oHfK2heWNpc10kr0bYz1n7NLBh+ddu/khK?=
 =?us-ascii?Q?TZ6uvt4I1r6x3tV6TkpxK0fBZTeZqWk8djXZ0N6VEfZcvw02rcT4sR9DTc3o?=
 =?us-ascii?Q?8VJ96IHlvbkq8uT+biehFmC1LbZV7LaPLj1YuMJMb6Eki0ul8klT+mnFgefA?=
 =?us-ascii?Q?1h+SPglFSMTY7hme4i1wjdTrR/BlwAd/UW2l+tptgi7qsoazPlE7DBskyYpt?=
 =?us-ascii?Q?5keIZweo/DUJB9u8t2db3AnXly5MTgG5uTasG3Kvbq1soVe/5fEjP5KjI0Yw?=
 =?us-ascii?Q?UtTAaRJAgGjN66liCmkdkqPr2U9gYNM2tLkX7El4sz0R03UCuLthqmOiKgA8?=
 =?us-ascii?Q?0ZDVh2LxDKgHOk+8c6rgt82mysKRbcIuq+KqhbxlIgBcx3vvx8oCHRg/N+7Q?=
 =?us-ascii?Q?cOfdJZ4h5Zc8B1h0tC9dCGlrKcXjUPgHGg6Q5Sqezegwn1nSOuk+sIPlptaM?=
 =?us-ascii?Q?Z1m+3p3Mm6CmYpo8gcQLAHmOtRyAEcMhST6xsSfN02fWMO0hpXorJCY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9743ae1-e1f7-4c58-2be0-08db4ea3bc6d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2023 02:35:35.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uu7PjKO0udvkbqA+L+fq77xg0BZ3/PfSyAs+rGLXPvE3U0hh7raOPaUhjD7ROwlnnGd769ozHYPyDuadXNrsjR1GaQU/ZEWyij93VeZmFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-06_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=584
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305070019
X-Proofpoint-GUID: YtMD_Nzs0Ps_x_a9lSyc8cB3BEvz1zId
X-Proofpoint-ORIG-GUID: YtMD_Nzs0Ps_x_a9lSyc8cB3BEvz1zId
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Dave,

> But if the application is limited to atomic_write_unit_max sized
> IOs, and that is always less than or equal to the size of the atomic
> write boundary, why does the block layer even need to care about
> this whacky quirk of the SCSI protocol implementation?

Dealing with boundaries is mainly an NVMe issue. NVMe boundaries are
fixed in LBA space. SCSI boundaries are per-I/O.

> In what cases does hardware that supports atomic_write_max_bytes >
> atomic_write_unit_max actually be useful?

The common case is a database using 16K blocks and wanting to do 1M
writes for performance reasons.

> There are many well known IO optimisation techniques that do not
> require the kernel to infer or assume the format of the data in the
> user buffers as this current API does. May the API simple and hard
> to get wrong first, then optimise from there....

We discussed whether it made sense to have an explicit interface to set
an "application" block size when creating a file. I am not against it,
but our experience is that it doesn't buy you anything over what the
careful alignment of powers-of-two provides. As long as everything is
properly aligned, there is no need for the kernel to infer or assume
anything. It's the application's business what it is doing inside the
file.

-- 
Martin K. Petersen	Oracle Linux Engineering
