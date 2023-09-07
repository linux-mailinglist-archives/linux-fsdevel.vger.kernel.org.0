Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F081797D56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjIGUUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIGUUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:20:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF1E47;
        Thu,  7 Sep 2023 13:20:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387KEeth026291;
        Thu, 7 Sep 2023 20:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=5Ov8Knhjgspw2qmAmkRP2UfJo4x8fbmIKvT0ENRqmJM=;
 b=ct+GfvMvj7s/UbzO+xs9Y3HpnCnawR+SDdTyxYA78n6qY60AVlGDd1OZM6o0kKSMJiOj
 YR/P15JBzbnaYWkt2DfoyQYJ3pJ4O5wnIs13UPuD3XcSHF62Loo5Bvpd5F11G/i6Yz56
 4ctXN1Jwr0aP1QuJ9uAfh5jMBFhbyYanZ3zQfj4hDW11jBtHdgmIyap1KUp1orprl8aH
 R1hhc4EDuHHxbgsULJ5KXpqiqrem2vKACSJbbpzuv/U3ohqYMD/AGi1v9L0TNAbN3b+x
 vDnUCrliEqVYN+lsdsqcd+BEsFeTG+MLngajunEVbVRn/Y59oQg42xZ8krMW2vgm5s4+ VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3synaa80r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:19:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387J6UUc013242;
        Thu, 7 Sep 2023 20:19:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugefja7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ4KL46kByK7mgUKZ+qpNlBopxXpZiVFU29L9CBBfIuPAflRzmuQgjPTw6KXBu9L5ed3lkWbHiPkIrLgtOdBte8J6VP58V/qPuYl0JzHXfa+rOkFbiDHUFdyxZ9sIa/fBrziGtMx43TLLut5IZ2o9lEZwPcDuKPsC/ksQ2HtffQt6EVLAhb1AgjI1+PCEx/2x5/opVi+CT3RfJobIuky4AJN0AOOv+1Hmas58ImleWh6a/SgVtrlQ2M1q+zGi3bJ0MCaPJyPe1jJ03+cqWzC2E8Pp1YfprZPnGQcw5iQxMBH003Ube2aSreii9obZyCJd1CVQhdTapSzelSOQcquoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ov8Knhjgspw2qmAmkRP2UfJo4x8fbmIKvT0ENRqmJM=;
 b=HQ3MN/knq65DEjS1A+MOioKKnG5e2V4W/hhkn4kOGLBbnfG2RB5D0GexHhS/Nj6hM1CC//LiqdLRxVx/BYhJ+r4+gyY0CLXM1MHFhdaDoslPphfRylhVUGzcGi9OyigZb8zsO5Vj9XdSNeS0T5QKfBBBXPs+Tg6w47dd/MnNBwLpogX7vB152JMIWEJo2cVJqYr6cI9FEwNl1sJvzq4jPiMzZ0zCXxiqF1QZ/CLqF12ue3L46btJzxuRXkKdKXP1FybN1zUWvZ3VdoWUi4VNVP/u2oI4oWfKoDXrv19WbKF2Njis4eqxEfbRbMuhEs3jvSUB21x8iqVMgaYq8Z+m4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ov8Knhjgspw2qmAmkRP2UfJo4x8fbmIKvT0ENRqmJM=;
 b=e1dOEoJKlloCQzzId6UNRmYQf2dV0CtoAmZTiDE3hYyVYxUXqMZvw3WIkYP/bAPD4mUyCm1NGgZvtUGlsXxJYnt0m/Ja2k3asgKS2jETseprJ9pxCap5aAKM3o4vl5zsx7VBKBREHUOwUMyEIqvzyVI/QWkdKdItQlRMkrUVnsc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 20:19:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 20:19:55 +0000
Date:   Thu, 7 Sep 2023 16:19:51 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Introduce __mt_dup() to improve the performance
 of fork()
Message-ID: <20230907201951.lfrbxd2wsrst6mso@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0392.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA2PR10MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5e1a6c-0dfc-4914-e62c-08dbafdfccca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkgZUKplLm5DOxinumYaostLZ3SKrUO14Tq33prpJuYCI3OTTJiIZP5xJJOJjDf9tM87NEUB9A1PRcRUh3hr0lBEoqq/QeR8DGWuGDaQoan81KWKiMzeh+G3z8lghhYlD4mq4etCA3StoYGY4oexlpaR2xxBHOu6bCKwOqhN/COcIJQikNVgQptXv8h+ycOoGvIsdNuX7CqkXrqcIGuCYa5c6nC62iUs+70k3HgrJssgAvk702f1YoC2+hHQPoZceSywOF7/dDamaRO9sruUKVQgRODKQ+7wW+ZfFZG0s6KaGCQ2swPMglcyYTUZUU6W4cyggDY9tKF/sIrYis5WU2rWUJHkB9RP+zEO11xycMa5iKJqAlxdSwxNL8l5eHNfjXrXuYAxbmtzt1QlgcGtIgs4WQXH9aobNrvmRDSv4iyJR12tmzrTeLmbAnlIm7B3sWTQBzgmpn2/ajOw4v+lTtJLE8sNzMdRI45ukZXWMXrJ9iZ1oq8FA9btZyc7nqbhOxvc5sTA3DOCebYBdt0ydnUtOmJ7W3PyOR+HU08pOft8pRjrsgKImtwVjkhx/fxDWzM4ZRM87BMtdTH4r72MXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199024)(1800799009)(186009)(66476007)(6916009)(316002)(1076003)(6666004)(86362001)(66946007)(66556008)(2906002)(8676002)(41300700001)(4326008)(8936002)(7416002)(5660300002)(38100700002)(66899024)(966005)(478600001)(40140700001)(33716001)(6512007)(9686003)(26005)(6506007)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GypJtqQbgdbcV9wiMd7E2htLeSWGMTm1W1BQOQfY4TuzTmIMpGwyDLJp4QEX?=
 =?us-ascii?Q?yYWKZ8VCloH0DbRHd60RiuhhSzyl0qsjerv+RXYiMcmk6qvaUnoG+wo50j7r?=
 =?us-ascii?Q?WvgcRY50pMEhfK0DPnrGymGXKzEUpwExFa200g9uPG05TRfRPcZYK8zgBRYl?=
 =?us-ascii?Q?ipwK5sbt1hpKs9Lr197DKaPxpONK74eJA9eeHhuBtJrkw1lS10UL8FIzoY5p?=
 =?us-ascii?Q?7INws6fyPywoslLGLWK4ecSQ+kz9kykQcgz0/thf1oNO7fhJw28gE5FPU9hs?=
 =?us-ascii?Q?uQXnZVDmdFMlhj1lpwOGUTQ79PmJo7tQVw5qoCfl7xLJPrbYDNNtmwDAlCzl?=
 =?us-ascii?Q?dGZKcy/VlFKBmNquUt16mz4EegM1Ho3okyhnND5Y3FrmOziAzkIPsQ3+/et5?=
 =?us-ascii?Q?AGDkqS9DHQEVe1jt2kbssWJSW5hFHr+Yaa0V7Q+WoHnrIx6wj6CDMVw85qw3?=
 =?us-ascii?Q?PxP6FcxMD7wDRgigSA2UylCyi7gmhwdneDk7n2fxhOvijjCUu30gpIERZL71?=
 =?us-ascii?Q?ya5gzIFqk3zOu4SiDQM4/KvV2rX0RTLpUUOniG+Dk5RncJ8L3lGdqGhCMU6n?=
 =?us-ascii?Q?yWj2nQrBSAoILh6u5DNrHUzJ8PcMU1bvdZCm6DU6hXXgm8bJrGRBAiXrtiUt?=
 =?us-ascii?Q?2YDVySUG/7W6plQ3dSZC4q+mzwhgzf1G7IiZsHZkVUuEdZ7TzZGMJtsKqJAL?=
 =?us-ascii?Q?ZH0Wfh2iAfzMBBDBHC53ZYzMiTfGWZqN9FfPm+Rs9KtenYGW338XUMCGLeen?=
 =?us-ascii?Q?xDY5VungSfqCv47pQz4L0+78wcYun2bUp9KYjJdm92gHdCpiL+ndZtBl36KQ?=
 =?us-ascii?Q?c9a9bUNZ8XYdRDjqegmaw4Vd9k63h+/b2ia58M1nA12J9/zHsqZjdf4gGvOv?=
 =?us-ascii?Q?jE+CqcApaGZD7XnhGheWnjbwpuC/HKXRKQdm05JYQ5FDyTJET3q5tSEQi4H+?=
 =?us-ascii?Q?fe3GPHrECiXaHXTaFFBAtbMSDoftCn528TkwsxXa6IfmvUGfKSPCIzXrIxDz?=
 =?us-ascii?Q?6baChNolOR36KRLzlPukq/2Rj864SbbhoDFKNOP/1VEaRUoBpkAoHPdpAsv0?=
 =?us-ascii?Q?ZdccfxJhEKAQ4qfaEvn4Sy2kDe74GTqcxIf6fq+9Fm82AEE4J98ExShTdHhu?=
 =?us-ascii?Q?7N4Cg0cS812iOaaFEze6EObx0O4JBouPYNMZXYX+I1+UB9R15p19IEdhQ9pU?=
 =?us-ascii?Q?beg+YWnHb0HFtwU3JhrP8fzkFTspzgYVoQRENg3yelWN4y5uYwLj7W6Y16DW?=
 =?us-ascii?Q?ELPOQ1WWR2oiDVb4+r8Swcx3ooRfL0nTLMRbByoSz6wDPI79denUR9ztvf61?=
 =?us-ascii?Q?NB542c5IgMSqE3yTwgKpYlm2w+CBzZe0okL9IBhMrhntvB98u45+mgG+EtRM?=
 =?us-ascii?Q?PPXjq68mJdKKCIdrWw5fE45F7dmdzll4gE6TdJuXE4YAXclH23Z76iWpWwQL?=
 =?us-ascii?Q?3CnajApAm3xDk4nCYRXS/Rrgm626EHSas4muh/L+dILTMDVDXOKC9hDzNQM8?=
 =?us-ascii?Q?iNqpYxDUDUUzIIL8l9OHrnJveAYrWNn8ZI4D07VtgOh5qVKJYpuVPELSMUEM?=
 =?us-ascii?Q?yuJiop8ZaklwDCRqtVdaUAcApRIZwmdVT12PF/cS+BtK2H9ExzUjVoUeAOkq?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ntpTuweR5gC0JR4LYHwLqAEWxgpDvQm1ok0b4DpU0EF+/F5UM3slIUJwIBWO?=
 =?us-ascii?Q?B19PDikBMIH9m8nMnVjKZ9+8rNl89tcQJ1ZTPLhwMC61pqJakLz1rPQhTP/K?=
 =?us-ascii?Q?MRfh3jDNw2AnPcI9QzcWtg9J3bbzszH61y5ylwa5Ba2g9QW6S2mABg6+WSer?=
 =?us-ascii?Q?x5d8n+V2fT0Q4fKfRu4qQqG3rRSbtAal7d4YgLXug10ztuUwVKy36K8JTChH?=
 =?us-ascii?Q?EjKusRPTmKK33JHudPQkrxoVy8g3xlCFwARg2HIpJCTr0uG18WjBvhnx4f0L?=
 =?us-ascii?Q?KT1qMz5Qb0Doh+vl/JB5Ha9p3wfh0RQJStt/zYydSmvY53ER24PXyZRFnAHL?=
 =?us-ascii?Q?jH+fCdwaEfrylNPq4qYERYD/ToRLhuXVoTavcGbz35ws7M3QXXXjo8HH70xi?=
 =?us-ascii?Q?AKdHDd1ZF9FgoxoscRzqpIvbH89E/mgCASIkngRPnM7J4xbaHCzYgUYS2b0q?=
 =?us-ascii?Q?RJo34ODlm3ioF0tk5ZRUsIhKhMydJByJ/AwDeiqCuoFvwNaiIu9W5CdfI2js?=
 =?us-ascii?Q?M2HomXOOV6FYf4mBgIMMX/ltEm3vSXvDfIfcvzm+1+e4Z3wpnZX8sY419RD6?=
 =?us-ascii?Q?X0GlFpP5bl7kRqX5ZZxIhl4i+5+icAwUbRdw51n8XWo+KdRX1O6LFJDcOYvr?=
 =?us-ascii?Q?+uPiDJ8qO+OAhUGl7Z4njaz88GZ/w4vcZktnhCr/8dGj6n/l6jnPH5e+WJaL?=
 =?us-ascii?Q?ia7L0jPvXc7lc+zOabnJ+YQGWtdppLFzSO/iUdNgv97Zm7/XXAOhjv273PxJ?=
 =?us-ascii?Q?buLgf46jO9VJDuG/IZPbw80KTj6GzJX8e3JoWi+fJIXz7gCQCoovaySY8WXi?=
 =?us-ascii?Q?wzQ7Edzv0QQCjZBB/GKieQBpwIpYYcYzIkafBEzNBjCcgmhqawHUdMGxYDT9?=
 =?us-ascii?Q?4EeIYVMoPR0GBOOx7bq1EM/ZSoBWPaojiRg/HnGVYFnzcmJt7A7FtSxKMSCl?=
 =?us-ascii?Q?TdYTSwSLKno59zHHkO9XPkygCFBLgEE2+8iX2TxePhqB+FJMkOQBQFEPrzbL?=
 =?us-ascii?Q?Y3wTLwB+wtP2UKIDexetgpYgl5gjGPpVy2xu8k4fQ7Rn2l7j47Dtj7B2sYhv?=
 =?us-ascii?Q?nrWSEOx5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5e1a6c-0dfc-4914-e62c-08dbafdfccca
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:19:55.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRydYU/5e724VS3Iu2DbtOmsRlMchiR2q1EtEr8kkwGqFrF9lxE25kv7lE5lc4LlGvW/Cwx5GlwKc9ZzCE9nDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=631 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070180
X-Proofpoint-ORIG-GUID: uvtiGR029RDboh39npHRrmK0vag8QVqL
X-Proofpoint-GUID: uvtiGR029RDboh39npHRrmK0vag8QVqL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230830 08:57]:
> In the process of duplicating mmap in fork(), VMAs will be inserted into the new
> maple tree one by one. When inserting into the maple tree, the maple tree will
> be rebalanced multiple times. The rebalancing of maple tree is not as fast as
> the rebalancing of red-black tree and will be slower. Therefore, __mt_dup() is
> introduced to directly duplicate the structure of the old maple tree, and then
> modify each element of the new maple tree. This avoids rebalancing and some extra
> copying, so is faster than the original method.
> More information can refer to [1].

Thanks for this patch set, it's really coming along nicely.

> 
> There is a "spawn" in byte-unixbench[2], which can be used to test the performance
> of fork(). I modified it slightly to make it work with different number of VMAs.
> 
> Below are the test numbers. There are 21 VMAs by default. The first row indicates
> the number of added VMAs. The following two lines are the number of fork() calls
> every 10 seconds. These numbers are different from the test results in v1 because
> this time the benchmark is bound to a CPU. This way the numbers are more stable.
> 
>   Increment of VMAs: 0      100     200     400     800     1600    3200    6400
> 6.5.0-next-20230829: 111878 75531   53683   35282   20741   11317   6110    3158
> Apply this patchset: 114531 85420   64541   44592   28660   16371   9038    4831
>                      +2.37% +13.09% +20.23% +26.39% +38.18% +44.66% +47.92% +52.98%

Can you run this with the default 21 as well?

> 
> Todo:
>   - Update the documentation.
> 
> Changes since v1:
>  - Reimplement __mt_dup() and mtree_dup(). Loops are implemented without using
>    goto instructions.
>  - The new tree also needs to be locked to avoid some lockdep warnings.
>  - Drop and add some helpers.

I guess this also includes the changes to remove the new ways of finding
a node end and using that extra bit in the address?  Those were
significant and welcome changes.  Thanks.

>  - Add test for duplicating full tree.
>  - Drop mas_replace_entry(), it doesn't seem to have a big impact on the
>    performance of fork().
> 
> [1] https://lore.kernel.org/lkml/463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com/
> [2] https://github.com/kdlucas/byte-unixbench/tree/master
> 
> v1: https://lore.kernel.org/lkml/20230726080916.17454-1-zhangpeng.00@bytedance.com/
> 
> Peng Zhang (6):
>   maple_tree: Add two helpers
>   maple_tree: Introduce interfaces __mt_dup() and mtree_dup()
>   maple_tree: Add test for mtree_dup()
>   maple_tree: Skip other tests when BENCH is enabled
>   maple_tree: Update check_forking() and bench_forking()
>   fork: Use __mt_dup() to duplicate maple tree in dup_mmap()
> 
>  include/linux/maple_tree.h       |   3 +
>  kernel/fork.c                    |  34 ++-
>  lib/maple_tree.c                 | 277 ++++++++++++++++++++++++-
>  lib/test_maple_tree.c            |  69 +++---
>  mm/mmap.c                        |  14 +-
>  tools/testing/radix-tree/maple.c | 346 +++++++++++++++++++++++++++++++
>  6 files changed, 697 insertions(+), 46 deletions(-)
> 
> -- 
> 2.20.1
> 
