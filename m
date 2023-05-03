Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D617C6F5E34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjECSkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjECSk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:40:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1237A85;
        Wed,  3 May 2023 11:40:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Howef000742;
        Wed, 3 May 2023 18:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=AQvDg1liQbNOtuYUZl4IaQQMOjhe/UlgPCUM5z64+z4=;
 b=N0caaX22K3+PVDb9bbTCfmDP7XlCiJU4cEbQVXzaT/Wgbydq+o3FIxX2N4fWuLXl9e+H
 e7vutHiTlIe4pPkd7swYJhEzGYw1nvrOMOEvjs7CazFh9vubejp/pE7JUR48cRAuigYw
 I3lwHKnrkwztsM4fZO4oG4toQTtkwRe+29UhHMLIcV1V+CqaS1Y3SjfjOoD8z0jwNq3Z
 X5wrMJqcv+gr5VPcvrkS4UB2Ym0CjqDvqpM0rS06dKcq3VxhIE9E8y4smU7KOtTjEjnl
 XOjYyVOA1wcoDpjUyoe5wUXjr8ah8dGM534c3bAcaJSEvubSxUrMdwgPOSK5ASTLgOHm LQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv017t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HSegC009977;
        Wed, 3 May 2023 18:39:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp805ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6wvXOaWlIosgzyJkzsd6UsbrZ/lI4fT6X8/Gw5nqxdT3OQ0WMLnL6tp2B9QpZm7P0vasHUuL0nQyxFT8Vw360isHBd0MOULt3ONc15UuM4McSOAR93ZO0tmLH33R2qFgue1h4ypqqWyAkb8Iw4TkXkk9QprkHIYIw9NGq2VcCz5iZng1U2L201dJdBqhVT+5S73LtNv7iXppVi5K6y9oJ3Dsm7bcU5HbaVGvqom+a7b2MWTheQQ4YnoSK7xawyYPjShMqHPXRqI9Zep4zzCmK0i5P1QgnwJYqY0ej3Mz3U4cxZDcMxNOu3gj5J6VU7zcWYh9m8MMPlr0d3XBa14bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQvDg1liQbNOtuYUZl4IaQQMOjhe/UlgPCUM5z64+z4=;
 b=aWbdOXyH60FctabYFIZ9MOUjfxlmnaDxKz4PIgi7L3+SqseyGMXbExmsiwrb+wPSTbkljSF1+eg83JSoHN7V+d0I+BbqZGntZGxgiFQjSGHL04Hnf7rm/sQ5kP1kjGweFdon5FDNKeOE+goB61VjKTq/dz26j4hMpplZHgCdIjF8qivUCjTlXEbhbNbvtICmTugTdVKj0FPh4uqOPl5b696NfChc3snnWu6xGHCs3WMjmjsyArr0z+fW4VJicvurn/vF9l7qIIOb7lFwpZO5Uf8JP4olUrIOj8zsiG/bkS+GWzyFrbHMSR6TNykKl+ng3u/c+E5qnZ3Wr3I9NaBwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQvDg1liQbNOtuYUZl4IaQQMOjhe/UlgPCUM5z64+z4=;
 b=KPGVUwtLogpeBjbCe8WYa2fKgH2iTEO9M8P8EHp7QrnnrHGcXLoERvDdjvX4rqGrzHoBMu16EcKZSltSaczfQvsRTwQA0pvjNyleMQgMpgIQk2z4UXqGGuRafHf78U0YVa+MtSl+3VODQ+cghdsH1/pzlYoUcB9TamtYJVnJ9+U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5677.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 18:39:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:29 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 01/16] block: Add atomic write operations to request_queue limits
Date:   Wed,  3 May 2023 18:38:06 +0000
Message-Id: <20230503183821.1473305-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0159.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c5b909-9843-47f8-a187-08db4c05ba47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkFv0iPlU7XDHKcW7YN6dVKZhGW1nag2lNVtoNuaJ/fvoOUU16sz8YM8Hca6/5ikep5eRZv3ZL1fRUG7HYJoMq9nrVTnQOeTcm+B+6SbmEOba16mSfxeVRcJ0CKcxivtWBrRIHDm2oxZcUzzauF/aV/o7kwwh0o5MsKBeGe2zu+2dbXbgPkpZfvMhhJyM03Rxu5jiWd9QFWRgUt+RmsBEx8se5GqwjNmam7ozLVMdC33l19N6RwWrLLHU5hf+Pf7Gkuwj8ITK4BpYTVcb8wfxWpmQx7wzHvzG3Iu+biLPfICjVJHRH42wQL+agpyB+RFJyKflgbB0C6G1BrxYSilLeH+iXBo6MKlhfurmzSCBtG0dLRfiTMI6kex7KbJrVvPZfV9I0FOcEa5cvV3xsNMMioBeJXu8uiIA6pBrZMu3USBs+cEfy3y5hXWmpRyGfT9jnXxjbB/6Z0ix/nG+ks2onIsRti5ICSWD9E2tFLYvXpdZuyBzYzVjkz41D9tEu674f7A6hoUFKckung16kMTyN3015LkkZxcK3EK0+GLSeQfkRfB8HL95gm1xZJpWi3NVXHv2Zs6wcRw/nH+VHSXeaLqJ4tZre6cxScimFsQ3wc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(107886003)(6512007)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(54906003)(66556008)(921005)(4326008)(316002)(66476007)(5660300002)(66946007)(2906002)(7416002)(8676002)(36756003)(86362001)(103116003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zgXp/2vZaUzJDJSZU76KLXptBRHgM/UWwId6dFZoFxJKRHwj7sb+WOoKazn0?=
 =?us-ascii?Q?FyAJAXP4k02EXFdLRn0n6cVj1+kQB6Xu90di5plT7Iqv6RQpLRubQDcE1LrH?=
 =?us-ascii?Q?bq6PTDoREAdzl6IrONDODeFmXHButoFL7ElKZTEpQDphF3RurCz/1CDw8stg?=
 =?us-ascii?Q?PtikxrbnM1ZYJzPo5K+TrBP1G8kSsQtZ9urmTLNMnNLDOmHEsOtgXrECZg4H?=
 =?us-ascii?Q?1r8BaBKndOXro4GMzoUjBFOY0EhCB+1qF0M2+lR1g/POsXpH+1b2m4vUiDii?=
 =?us-ascii?Q?3pYG2Y3OSFi/EkHCORX9kqsd5arN4uUOvNMVWMnnR+zWT0GPL7UylwoQ8W+/?=
 =?us-ascii?Q?V7E3VLIwQCJC2CPLSIUEDZRNxJqt/5F39I9aq3jAKNblP2Kt/xB4HgQZtQ0Z?=
 =?us-ascii?Q?LXjVs5tV7ZZxlCUg/bR0i3wXn21VtI9ibm78OxMZM+N29MjHUdxEM003Fgbh?=
 =?us-ascii?Q?gyuLkitd4JWQLWOBx5DAH7sagFbrHJmSb3oz2xPWKypl1OPXApqPQeX/JgWS?=
 =?us-ascii?Q?AARYRNtvfv6u82lHRfjM29ad6VDmF+osXnw1DYcfCme+fXjF2AxIEQ+fM9sW?=
 =?us-ascii?Q?+DQ8gIkAGBCAvZ8KG4vA6JPjbu7bUZru9llz7+oJIo1uItuUK0Z2xEKaNL6C?=
 =?us-ascii?Q?7gUFG3drakxBLEtb0YJ5EdDyWHD94P9F3KarrvdLc4O9kPoeRUdUGt3zavr1?=
 =?us-ascii?Q?nEvQo7z79rayh7pUolmrHmKaOcKilzAv3z1EBWyhqI4BvFTXPTuDN7AIMs35?=
 =?us-ascii?Q?2wDK1/IZebEHA+/FjEpFQX/q+v0aUrL8ZmX5SC6quIk2qUn+yM3sTp7RWGkJ?=
 =?us-ascii?Q?/aVPxEfTD0RmF0JjgeXRCf5ZA50JHdhVfQtoCvW5jaKL2+c+cfAuy1obDboP?=
 =?us-ascii?Q?IdyJj2VkomJqLLJNVnzxLweEMJT/W1tSPehDbhzZC5kaABIx0jyPsjHuz8CW?=
 =?us-ascii?Q?DosLLX/R7VbnxbkxTNcZgu33oWY/8Yfxue2iMYndpbNSZD53lMoadmYD+Rsz?=
 =?us-ascii?Q?6iHgmRpjI4liYtRTj+W0Iuv429WYy2Y1bzIGEQyfxu5TOV21h1Y9OcP1IAQs?=
 =?us-ascii?Q?6b5nZd1LSlOsIQWfFLZb7Hp4UoN7pkuMlgvT4Fd9bLXHTSEE077oWhj1ty17?=
 =?us-ascii?Q?OxZJtWc1dY/J4t9lYSZUupKv9/SQi2ASx0hQbYCeyuCS95+g8wiMlRvc2hrF?=
 =?us-ascii?Q?ZdVL90KeqHOEE+dYyUXd1bcF0HEVepdDSZkkPd4JzmNx8krEQCpmGjN9wUFZ?=
 =?us-ascii?Q?RQNGHeZjR1sc3GjQvuB55UPVOgKwGLZ08+UqgLOf5GVSk9j0RecImAYC7f8T?=
 =?us-ascii?Q?wiiGtCg/BVCoSgMy/Tyi85PUKiBWF7bx99ZkVOBrN3/7Hm2czeeitRyIagX6?=
 =?us-ascii?Q?vyY0APP66ejNcwMGjHm4t1niAmFOn1oHs6Go9yW0qcPQXGY3Nc2WBZCba2uY?=
 =?us-ascii?Q?B8HbyH0d8PNMGOp9fCI92bgux4ntOW63UtuRxCyA2WjR3z/Lmke24x2PJaOI?=
 =?us-ascii?Q?WDB9hC+y2C/PcM8nnWNjEeZvvEXnceN/r4FlrAgkFrtNlb+Fif2Y81swlrQt?=
 =?us-ascii?Q?bWV7Q6p4C3Uh1yEuiJp8I6emP5V9/1HzZOMaxLlQWZNmWBdsf/kmyYe0bpZ4?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZpyVcC56VoxXG9SuWk8o+TFRoSeuMJHsAiBOgeqZh8HppbVXdeq3go2y1kUY?=
 =?us-ascii?Q?bZiQOc2dDlURR2Yzl3VbDby5y9+cqiIMX0ogrhQTxeJ5sVqH1clhyJKHbTWy?=
 =?us-ascii?Q?zWzEZafLMRgwr10JyJQI4EkwphjNl+DoWTR0083QPRsqDw8qmscIaABszEqv?=
 =?us-ascii?Q?6Ard4lHgEb5RnaBcILTei6SXT5/QeWF08ahZGTxIScpsmyhcVmJSa1PiGl44?=
 =?us-ascii?Q?6PFtZLqmjzZpxYF6OdrrulIBTANp5HPkN5WykKx6EmUdKdLpi/jmQxyJ0D7a?=
 =?us-ascii?Q?kzFFnVUVta/ZP8iw5rHXfN5AxmwIw/p02H67Tn9Y/O7S5RpprCJhzLKN8WDb?=
 =?us-ascii?Q?R5sWMNVUPr/PCYrJR4RB+bJgHwx34FfFyvtIcDqxf/mdvVQdF5OVl33aUtsd?=
 =?us-ascii?Q?w+/k2B5n9KfWzVqUKbfURiuyCJSbjRFdV6gzaZQeEHAVpNj8hC/mghYlVOcH?=
 =?us-ascii?Q?3Q11x3dY3iqx9jVwrlc/XtF5zFqSCU38Q0CIT0bPYHNqEQbKT0lq/BSqY7o3?=
 =?us-ascii?Q?nDNOnrnV/pVDHpnr1Wy/vdABeyymSs2ONsDAS+FQt/lcEPOYIjSrG6PmQPqO?=
 =?us-ascii?Q?5GpF9LbE+0+ynR2c4TvBrmRZt0T3j1W1+NhI3TjE5pKHMmQ4K0L/wNSPLtXy?=
 =?us-ascii?Q?O2jK3BV6D5s9FPVlaIlyPhTFAhRQ3IeL7IMWrEdr2tq1hfY1h4JKPWFESLXS?=
 =?us-ascii?Q?RIY9F/E8BOKoDJvbA+tCgWIqq69dZqexTMG/V0kYqcaqvBSvEAtKg5QgfJBt?=
 =?us-ascii?Q?fTdonU34opsgAg5CyYxZz4w4s08rvIJVODpgeO8V18pkPKZkQ6p09kYfaNTE?=
 =?us-ascii?Q?G+gU18ILSlNHDhzr1JDA/g1iTbQKycKWvULhNtEEyfuFAZx/z++Xsx0N3ZaQ?=
 =?us-ascii?Q?c5CNi9F62NU5imtDQhWFDxxEssWJo3zH+jJvj8oH8jCWeT3Mbss76jqcO3uw?=
 =?us-ascii?Q?rYbVK4E85IAAMvDv0oqtu6RRZxFT1YSEL7QsoEEshobfW+BgW4zHphn9hcJh?=
 =?us-ascii?Q?ZaVDNPNmluXf5C03SryrdobmAND5nImt8Ryoa7yzQr4Ed19mM4MGV7a7DVkP?=
 =?us-ascii?Q?cPGWDT+nZMcjEiqB2TrGsSVOVYGI6X3T9unVATiHAcmyH5mQ7BnU9XWNtGxg?=
 =?us-ascii?Q?EY1nnc/oHvTw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c5b909-9843-47f8-a187-08db4c05ba47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:28.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwpIBmjXhT5Z69Mz9kOIDaNUoO8fnsAKB/928zTy1hBdFtpZ6tbBBlFdi9fFxi2shPXTscaqvxLpDCX/gFmapA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-ORIG-GUID: p7XqqkWTccMA7iPMXgI6LSfRrlJFliuW
X-Proofpoint-GUID: p7XqqkWTccMA7iPMXgI6LSfRrlJFliuW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add the following limits:
- atomic_write_boundary
- atomic_write_max_bytes
- atomic_write_unit_max
- atomic_write_unit_min

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/ABI/stable/sysfs-block | 42 +++++++++++++++++++++
 block/blk-settings.c                 | 56 ++++++++++++++++++++++++++++
 block/blk-sysfs.c                    | 33 ++++++++++++++++
 include/linux/blkdev.h               | 23 ++++++++++++
 4 files changed, 154 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 282de3680367..f3ed9890e03b 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -21,6 +21,48 @@ Description:
 		device is offset from the internal allocation unit's
 		natural alignment.
 
+What:		/sys/block/<disk>/atomic_write_max_bytes
+Date:		May 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter specifies the maximum atomic write
+		size reported by the device. An atomic write operation
+		must not exceed this number of bytes.
+
+
+What:		/sys/block/<disk>/atomic_write_unit_min
+Date:		May 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter specifies the smallest block which can
+		be written atomically with an atomic write operation. All
+		atomic write operations must begin at a
+		atomic_write_unit_min boundary and must be multiples of
+		atomic_write_unit_min. This value must be a power-of-two.
+
+
+What:		/sys/block/<disk>/atomic_write_unit_max
+Date:		January 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter defines the largest block which can be
+		written atomically with an atomic write operation. This
+		value must be a multiple of atomic_write_unit_min and must
+		be a power-of-two.
+
+
+What:		/sys/block/<disk>/atomic_write_boundary
+Date:		May 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] A device may need to internally split I/Os which
+		straddle a given logical block address boundary. In that
+		case a single atomic write operation will be processed as
+		one of more sub-operations which each complete atomically.
+		This parameter specifies the size in bytes of the atomic
+		boundary if one is reported by the device. This value must
+		be a power-of-two.
+
 
 What:		/sys/block/<disk>/diskseq
 Date:		February 2021
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 896b4654ab00..e21731715a12 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,6 +59,9 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->atomic_write_unit_min = lim->atomic_write_unit_max = 1;
+	lim->atomic_write_max_bytes = 512;
+	lim->atomic_write_boundary = 0;
 }
 
 /**
@@ -183,6 +186,59 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
+/**
+ * blk_queue_atomic_write_max_bytes - set max bytes supported by
+ * the device for atomic write operations.
+ * @q:  the request queue for the device
+ * @size: maximum bytes supported
+ */
+void blk_queue_atomic_write_max_bytes(struct request_queue *q,
+				      unsigned int size)
+{
+	q->limits.atomic_write_max_bytes = size;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
+
+/**
+ * blk_queue_atomic_write_boundary - Device's logical block address space
+ * which an atomic write should not cross.
+ * @q:  the request queue for the device
+ * @size: size in bytes. Must be a power-of-two.
+ */
+void blk_queue_atomic_write_boundary(struct request_queue *q,
+				     unsigned int size)
+{
+	q->limits.atomic_write_boundary = size;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_boundary);
+
+/**
+ * blk_queue_atomic_write_unit_min - smallest unit that can be written
+ *				     atomically to the device.
+ * @q:  the request queue for the device
+ * @sectors: must be a power-of-two.
+ */
+void blk_queue_atomic_write_unit_min(struct request_queue *q,
+				     unsigned int sectors)
+{
+	q->limits.atomic_write_unit_min = sectors;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_unit_min);
+
+/*
+ * blk_queue_atomic_write_unit_max - largest unit that can be written
+ * atomically to the device.
+ * @q: the reqeust queue for the device
+ * @sectors: must be a power-of-two.
+ */
+void blk_queue_atomic_write_unit_max(struct request_queue *q,
+				     unsigned int sectors)
+{
+	struct queue_limits *limits = &q->limits;
+	limits->atomic_write_unit_max = sectors;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_unit_max);
+
 /**
  * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
  * @q:  the request queue for the device
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f1fce1c7fa44..1025beff2281 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -132,6 +132,30 @@ static ssize_t queue_max_discard_segments_show(struct request_queue *q,
 	return queue_var_show(queue_max_discard_segments(q), page);
 }
 
+static ssize_t queue_atomic_write_max_bytes_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(q->limits.atomic_write_max_bytes, page);
+}
+
+static ssize_t queue_atomic_write_boundary_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(q->limits.atomic_write_boundary, page);
+}
+
+static ssize_t queue_atomic_write_unit_min_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_unit_min(q), page);
+}
+
+static ssize_t queue_atomic_write_unit_max_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_unit_max(q), page);
+}
+
 static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(q->limits.max_integrity_segments, page);
@@ -604,6 +628,11 @@ QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
 QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
+QUEUE_RO_ENTRY(queue_atomic_write_max_bytes, "atomic_write_max_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_boundary, "atomic_write_boundary");
+QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max");
+QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min");
+
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
@@ -661,6 +690,10 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_atomic_write_max_bytes_entry.attr,
+	&queue_atomic_write_boundary_entry.attr,
+	&queue_atomic_write_unit_min_entry.attr,
+	&queue_atomic_write_unit_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 941304f17492..6b6f2992338c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -304,6 +304,11 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned int		atomic_write_boundary;
+	unsigned int		atomic_write_max_bytes;
+	unsigned int		atomic_write_unit_min;
+	unsigned int		atomic_write_unit_max;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -929,6 +934,14 @@ void blk_queue_zone_write_granularity(struct request_queue *q,
 				      unsigned int size);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
+extern void blk_queue_atomic_write_max_bytes(struct request_queue *q,
+					     unsigned int size);
+extern void blk_queue_atomic_write_unit_max(struct request_queue *q,
+					    unsigned int sectors);
+extern void blk_queue_atomic_write_unit_min(struct request_queue *q,
+					    unsigned int sectors);
+extern void blk_queue_atomic_write_boundary(struct request_queue *q,
+					    unsigned int size);
 void disk_update_readahead(struct gendisk *disk);
 extern void blk_limits_io_min(struct queue_limits *limits, unsigned int min);
 extern void blk_queue_io_min(struct request_queue *q, unsigned int min);
@@ -1331,6 +1344,16 @@ static inline int queue_dma_alignment(const struct request_queue *q)
 	return q ? q->limits.dma_alignment : 511;
 }
 
+static inline unsigned int queue_atomic_write_unit_max(const struct request_queue *q)
+{
+	return q->limits.atomic_write_unit_max << SECTOR_SHIFT;
+}
+
+static inline unsigned int queue_atomic_write_unit_min(const struct request_queue *q)
+{
+	return q->limits.atomic_write_unit_min << SECTOR_SHIFT;
+}
+
 static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
 {
 	return queue_dma_alignment(bdev_get_queue(bdev));
-- 
2.31.1

