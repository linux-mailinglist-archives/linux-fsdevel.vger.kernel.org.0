Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470D44EFBA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352655AbiDAUaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 16:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352752AbiDAU37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:29:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC144281689;
        Fri,  1 Apr 2022 13:28:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231JPY1P017622;
        Fri, 1 Apr 2022 20:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5VhHD7pjMD+T3C2spMZq5JoaTZsiY3zYGNlYP9FtNX4=;
 b=ehX/HCZ0EYtusMExGUbNHvENPfL5Yh4loJVXop9P1ahl5KgIK8Ye2l+4u14d0jtE4iHf
 3j1qkmxfqE33fCajkh1ReS/elBYviBWQ1ke6A2pI3QlcZwz6i7YKRjQskAKNuiYkWuzX
 NDiGHBotpmPvP4mVff81jBg5iUQe8nPQXNXg8c2zh4rbB/Hg9nXd0ptObp9NJbZIqyZX
 Lm0n495rb75Ala6jSqgXMyY/fy4FQRoRjUf60XaFXovMDzAq8HTjx3eZTbtTawjJxqJX
 PiYMwnHbnQRFt4tDjDE1MbkvpwWFb36AvBleR0mIcJ2e/P2VS34/a+9gLFI8eRx7CIZ9 mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1ucu07c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 20:27:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231KFSIp036617;
        Fri, 1 Apr 2022 20:27:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s96vg95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 20:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrWzWX1RbTq6RFh6LvCMKOpN7UMrS0dmoRpuup7yZVSD7Lpkj0pRQEzECuM7W+r1c8ekn/NhH19cBEtKGCzxhAGNZL1exnL2VSLn0aoXY34aQb8SinUvg47ka0C1vBXf9r+aGqQL8GLT8WBXu18ohPu5UGL1LpljWPupPSg+lmzIPQZXz5NrPSp/kAUjz3QwcbjjEyXNEMfWrkzdCxY4G7Tm8YOTfdwhZHOo1Dps5/fKszp3FqBrDXV41myhTRis3EWiX53dXlF62jO1oATkQ7cQhxlYwuZ14KmVgOUE+3M00txvza5XXel9AIQic6JidNjEofCpvsiyX7S5wxWRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VhHD7pjMD+T3C2spMZq5JoaTZsiY3zYGNlYP9FtNX4=;
 b=agdpLiYKTcTisfz8Kgi1W8fyHT3eDDv4eY23mze+Gs4aYAP3fEJRcOd7SiSH5vV2jtIBe5+8J9tv1ySNATt48+RVjYuByozxhEQD3A//s24CETPOFrXz8K8HOMFs1BiH564RghufSuCJP/Qf+4yFl+8BevT8GFC0cGiF9imuRYoxB0g3WJyL+ZCledn4gyLVqMIQOylTX7i+RA459vTprkeKIYdIQ/57GNTrnydwth4yzRe/3dPf5OVLaUDXX/cj9Ih3mjlvLq4TfXD9F6MsoidhZJ1dgV/zso9HWT45RkjU96tWmw876K3SqXP1xUHGZRT3Yg0ns7lo+CwKJcyQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VhHD7pjMD+T3C2spMZq5JoaTZsiY3zYGNlYP9FtNX4=;
 b=bgoc0hX+5teMf7kbHl119oFifjCxasgSr4zuwNizBIKaqBeCahWlVCMCGfYUG5W3GRQQic1v/bbf33FQKrbOIvzKFdDocavSuaZLbUPizGv1Kh68vzFiVcbnWSetGpSES8aouMzIKGj5CpF6hfzWgXliN8qmD4o8PLT2HBW9huM=
Received: from SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 20:27:05 +0000
Received: from SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::25e3:38e5:fb02:34c1]) by SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::25e3:38e5:fb02:34c1%5]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 20:27:05 +0000
From:   Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To:     corbet@lwn.net, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
        ebiggers@google.com, peterz@infradead.org, ying.huang@intel.com,
        gpiccoli@igalia.com, mchehab+huawei@kernel.org, Jason@zx2c4.com,
        daniel@iogearbox.net, robh@kernel.org, wangqing@vivo.com,
        prestwoj@gmail.com, dsahern@kernel.org,
        stephen.s.brennan@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [RFC 0/1] Add sysctl entry for controlling crash_kexec_post_notifiers
Date:   Fri,  1 Apr 2022 16:22:59 -0400
Message-Id: <20220401202300.12660-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:4:ad::48) To SA1PR10MB5866.namprd10.prod.outlook.com
 (2603:10b6:806:22b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f02fd156-e53c-4d6f-fc9b-08da141dfc76
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5647:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5647999B5928D2531A70E0DBC7E09@SJ0PR10MB5647.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kab1u6Upk8YI7Ham1MHy1O+jDz6g0aGGJDPZg6Y5z04Na9tBiv8/uX1VyIlcNaLzKlAO9WdSOtTa+/6vQm3KB/RdOR1mCxxQkwto0zYuWXu5+uuc/H67bXaJ8GnOO1nogIqMF+BHkPw4yQ5SqsfCySC1KtkKoch9TH5Rls3jtDVYKXZI6JVoKIEybNdOe3BVLIpkgUVDi2bk+Ye5resp5Gj711xhvsMXCQSn9E2DAyw6hcM2QPbKcCDQ/EtKS6/pzcFILvHHyyUiXzTELgTpHQTp8NAIreJOdFMkTkKTC7XYWVJkvbvPuSur8xnXBMz3eLmNKGhtt7XBNNnepob8YHE5nZhI8U9O/aIh7FXOa/UviA9VWQESiCe6hzUHp98oPxQhQfAjo4cZj7/rdtvEhFC3N0jBKH1ZaFmU88E0iDBgc7DfnrugTYixxIxxvQMq4deTKA8SbP1EdJtM6VmR/naifoEzypBE4Kz6CfixJfRcske250+BWQEbbeVVGpdaKNiJ36TwiEMkaubOU38VJRe9w0jU2guoLeSbjSFHNmTsxhIX77F4e+SAqjuhLlGdn5dXqOTT5wS2oeMgn3SrB8DiI0hWSabcceTM655kL+qsHdeZ9tCnXmLG8JK8hEx+uBFVK2PXO8KH+A+AI6I+IBKs9pHsKp7XqFcBEwzXfAj949TF89yzb2DrFOGPDrgR2bPZgrr5pdHX0ZDf1s7BzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5866.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6506007)(52116002)(2616005)(1076003)(26005)(186003)(107886003)(6512007)(103116003)(38100700002)(38350700002)(83380400001)(8936002)(508600001)(316002)(5660300002)(7416002)(86362001)(36756003)(6486002)(8676002)(4326008)(6666004)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rpdBQ5GgVip/R2UWNC1wTwyDWB1iU1HGbtoszrMRTTgJ6Z/CH2BQDbjK+TES?=
 =?us-ascii?Q?/5bQswTE4GOIbEQsk8c0v4toikNBJfdya/A/SWOrAbTdRskE5pPsy5bx1FaU?=
 =?us-ascii?Q?4HN7W7Lgt0LFs6g+4Bnfwkw55sK4VzxeMRCxw4TmyarEewdRwVuKzMOsFrbN?=
 =?us-ascii?Q?GAFVsJFkbOPuJdpQCY5cphsz5knkpFgrsOFVPEyMTPsgYBHuPr7CPAQ/X5LN?=
 =?us-ascii?Q?m5tf7ySRPfRYNu+GzO4ezv/SHsNbpt3/qOXlC6DQ0vEcR9jVapTjIehb/9sJ?=
 =?us-ascii?Q?0xw4t+NRh0mGOAMQij8/7CRjfnCj0/B571Ml3cvHGNPw+pYt4NuGcFKg25Sf?=
 =?us-ascii?Q?AdwQ5Y2oMPW2g+VaUhLe5Uw+lenGdFf1NiFZ/aEwSk92ConrTtPIAlU+BjHR?=
 =?us-ascii?Q?YMQcuWmKzLjZplktVAHuJBsCL3+5oQmAKW7VCfM0gDqQ+VgQSahDEKg1x/T8?=
 =?us-ascii?Q?AXO+FVahrV5lbsRr6FElSoAJKsEGq1B2Ph3iJDCI5admqfMwkj7PC743akpO?=
 =?us-ascii?Q?+BJ3Ga9e43XVt/hf3aylw5trrTC7Fb77gBvlpDFtFBxLghljEgUVIjzXdE4B?=
 =?us-ascii?Q?mnbBKdgHGJL7Qj/aGi2wwyLUgg+yoIG7VBU9ZLnBhyaMN8R/xoWDQdeMubfw?=
 =?us-ascii?Q?UVq7diZQ4VpXX82ON9u/IMukCNrskgJM4jedzpTiXdmlB7yJRVmYYcnnKcKf?=
 =?us-ascii?Q?0YdJe34qBm9ALYBa6K9R/VLhYleOlFtyOUQRtK6iD10By7EKSOztBcYKf8aU?=
 =?us-ascii?Q?dFp6fjmE22UzzUtI0nm32XJcUiHaOzF9rntvjPjEBqsI2aXxPC7IQMzaPVgF?=
 =?us-ascii?Q?U4MZGC7nWwRktRl+yNW4+KBB92cQfIzFcubU5DW5/m8k4v6sYpJMO43mbsZt?=
 =?us-ascii?Q?rjVKu94aAHX1s6ACrbcMKV1vo31LXmRUt7sqmIYEk+tEhVBOTHWuCzXq5NWu?=
 =?us-ascii?Q?w3dE1RhRDQaq2o7v3Cbh2cw8dPv6pjteAE8DI2EUtS+7gOlhtpcFsqBvIx5L?=
 =?us-ascii?Q?h5sPe371STveOkJawoVhjQvAG45Em4tCWJpuUgNKCM+M8y+nlGM46QkRxc2f?=
 =?us-ascii?Q?CQCbaR9rq4LMQOZHGoJ8koXwoA5bCnMburBp5YG3qPm0Qf+MXdLVDhVJF+YA?=
 =?us-ascii?Q?NL47O8MsF9QOcXtCwH/jsxvhwVhejMlG/oNyhLxRoO4ElusnmHvD8py5l58b?=
 =?us-ascii?Q?lDGld5AFbTgDvdn0c87eQdi5iW8kWm5jmzkmMFo4XHlC20AnuXIag89VYVyp?=
 =?us-ascii?Q?aT5UdRn4gVgzZiSmmIbzl2pxLlMHrhLGE1z6Ok/8JmIWnVTGf5v1RU/dGIhk?=
 =?us-ascii?Q?8rHesmZ53jVC8PywRcvb1b5cJEOAi67QYQeDS8P+UzSSPMJJHHJFWIMCa1s0?=
 =?us-ascii?Q?QkDueB87a7qvTibyyX2mIAoMPUU97DKpYoAKBVJF+K8XMQU46aVUQW9bQ0r3?=
 =?us-ascii?Q?6Oqp8j1FmfVaRfyQzNfU0lWwPWKDwmfYf/OaBl1DSvMHot/nFxG8kmqnXGXV?=
 =?us-ascii?Q?6Yuf141Z+UhO2snd6kbdA+RM1YvsK4VsjqYfMA1JhmnMMQvWX+xjQaH09dAr?=
 =?us-ascii?Q?HCBl2Q/A4K27g/bgmLhKB1mhsPhmpXnjoNquSBBadhgoV7PEZmPpl8x31ZWU?=
 =?us-ascii?Q?eFzhK5pLDCzXtxUavvJKsGyLTHPeXlJFilYLFaqukWpGeXEFZ6obO0GDBNE3?=
 =?us-ascii?Q?gJYoDpvhGRtxD1FDhGbnI53OpAysJhg213mAioici0j3k8/Won2hPoykmIxR?=
 =?us-ascii?Q?nx0cGwpgg7AysA0zsudK1FqJp/XIM1Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02fd156-e53c-4d6f-fc9b-08da141dfc76
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5866.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 20:27:05.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKeN2YA5eB/KgzJFxo0anol3MjB1py/SBr0AvUXfgYtzzuz77qECCzcaaCGyBEdAAbuytzPsb/5daCO/xjOZwxo8GSC4x3I954pBX/0EFXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204010097
X-Proofpoint-ORIG-GUID: 7qhiosjQ7KSsRZMPTHiD3N-LCp8pRoRe
X-Proofpoint-GUID: 7qhiosjQ7KSsRZMPTHiD3N-LCp8pRoRe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I noticed that in contrast to other kernel core parameters (e.g. kernel.panic,
kernel.panic_on_warn, kernel.panic_print) crash_kexec_post_notifiers is not
available as a sysctl tunable. I am aware that because it is a kernel core
parameter, there is already an entry under:

  /sys/module/kernel/parameters/crash_kexec_post_notifiers

and that allows us to read/modify it at runtime. However, I thought it should
also be available via sysctl, since users that want to read/set this value at
runtime might look there first.

I believe there is an ongoing effort to clean up kernel/sysctl.c, but it wasn't
clear to me if this entry (and perhaps the other panic related entries too)
should be placed on kernel/panic.c. I wanted to verify first that this change
would be welcomed before doing additional refactoring work.

I'd appreciate any comments or suggestions.

Thank you,
Alejandro

Alejandro Jimenez (1):
  kernel/sysctl: Add sysctl entry for crash_kexec_post_notifiers

 Documentation/admin-guide/sysctl/kernel.rst | 8 ++++++++
 include/uapi/linux/sysctl.h                 | 1 +
 kernel/sysctl.c                             | 7 +++++++
 3 files changed, 16 insertions(+)

-- 
2.34.1

