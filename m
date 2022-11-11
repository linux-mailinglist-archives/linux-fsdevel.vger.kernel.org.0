Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F562642C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 23:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiKKWHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 17:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbiKKWHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:07:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A4C50F34;
        Fri, 11 Nov 2022 14:06:48 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLomDa025514;
        Fri, 11 Nov 2022 22:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=grHxMB6fo3nJ+yilwLG4loljxrOwvfJeEPETyErjoHM=;
 b=TFOMD5BReLxYGHpHjipPfz7b1nQgGHwtX5VFkzrBTeQm590dygXkNFQvvVcTCgYemCtC
 IFCRGVfRto0OeigDChDky7X6tYvOeJuLOX/33FNWqvh0K73tHY8fKt+ttRIvUwe08Ae9
 xCc/hsbtnIS1BxLJgwGJUInDxUR+2H2dMxS0pVq72AAYfbAW1262Vh8kGdUCoHUfxgi4
 ylDuN0Fy8jZ5Jrd9qSkHCFY8m/8EXkZqS+T3IjUu1ata8pxOfHmdO3G8Wc2BG95xJUWt
 klwr24Wg2z4pJex2eIVHazYSuGbF+aOJg3IjbVOOqPXlAieVt2mGIboxgNopBewaWX2v Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksxnrr13q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLGI9g021613;
        Fri, 11 Nov 2022 22:06:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq6v6ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJFz+/Ex4x97cD5mB/iQlP3v+lvpGmvtoSsoVGWm0uq+2dnVj6qG6SBfKatDcfCbaPhVaP3c6l6Z/oqZ2YScApk+NZAvVFxRTKeIZ94efMJK7USHPRuRuHvT0RJio9clmK5m1aYBMZXH386fds1tFLNrtKMrNmJ/hKdlWCJSIM15cEVjO/bsvqpriIEX7Yjdn6zLNWd1x5XibixlnGwSBZ9bLVTjlQcSKqe2GhAM1j1L2wa3v5H8pzWM3ABTGGP8mQ07Z5hmeeVGmDuAblm/tRda0g6B9BdmAOT08LxU3aheXukv8AxR3xebw68N0qBoUNQA2dGjLDolmFe12o02pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grHxMB6fo3nJ+yilwLG4loljxrOwvfJeEPETyErjoHM=;
 b=ZUhBBq7UbJQs727/Vo0UFU5+/tHPVH7pheKInyPYjd0aEKAhm1CNS37yTDxk0gNljJEVVTjobjrpMCkYHgV5U7UKkUjDFydvtHcdCPZOo2fyeSJLEYd78lRKg4BMzG8LB+3y/hQVE07K5dpJm7p1a3KVVm0YxlQVx8J0s58ZPkRc2YN/ckGkIh7yCWjrLppEUUbTL71R6r0eDjV4iyNe0dikUlPdmCwAk06vuCya9adiRH0PUWOS7iPfz+yE0n0GHoBsZR5nnY0vVKwZS7oRoZJyzgZpCpVgrYuLwrwhCY6t2+PFaW8na1sZ+Yva1dnOrLG3TmPiThXJc98VZRhVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grHxMB6fo3nJ+yilwLG4loljxrOwvfJeEPETyErjoHM=;
 b=KwofHK8KcWvcTCjHi8mgfpTbOOaI7vkGJIO5KkRTw2yYUFIxS3dBuFv0Futaq4jxykXQt6k/jrhoK89lGH42Gffef5E5mB4+I8EF1jl/+AwnOS7A9Rs+FyumJ+NiuDXU1fruho3UCvIPqWbHBM8FCgy40q0ipecfF1RGwjRCgDE=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 22:06:27 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 22:06:27 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 5/5] fsnotify: require inode lock held during child flag update
Date:   Fri, 11 Nov 2022 14:06:14 -0800
Message-Id: <20221111220614.991928-6-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111220614.991928-1-stephen.s.brennan@oracle.com>
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH0PR10MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 544f64f8-738e-41b5-e518-08dac430fad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nG2/8HQTsvcJMIw/trqpW3i7AddqYrSvCiWPBJSvy7ZSK2KKutd64fzO0g92GhMjJQd0Q0Pfxu8Xjt6vpvGL7Iog8gv0dEMiKuKuEIESn5v+oMCUFKtmhiCNEIrU3dkTGVhAESw82Yl9ztBzny1lOuibkpnJmLgdDaRixRfLe5/iG5fAh7H1oqR7ogsXxhzNOQxb+4NawMB5AU1vioueAweaqA9H9Ge+nluSTZLbE0/tS3GJfUixH9l5VS8YwzngNChaRW2Q9onYzNnfWaq/tuLJEep4IGnHmFuGY32DLHVqg/7SHtnbz+k22bP3tO/sKbiyGDSWTt9dSUsUQVzfrT1Ds0fHRn5s5yhblV/+oW7fqCyKq+ajzpBHaMMDosFoNiBdPTaG/JCruAf4LsvjIdeQYfnShu2bhO8QoRo2zkVP/4O0aZ5BIavlrb47S2j0s41Bj7MsCQA4aGaeqYU3En1IMhw1ObDKFq2Ng2a+RfjfaM2cDTZKXuAskLrhD4dYj2rTge3oQKHf9LQqICgAzt5Rd0NTJ0z6P+YCdg1yhsiwQf+ZYRnIj7RQL8wHLXO2RR+3BJPeMqgWURPqmsZ+GiXd8fnLyRDFr92Td/wZd7yZsMMNYWdBESW4XQP6iR13zUYd/mSDuSlUofPj0qnWJdBAhZvXrjK1nvgKcjOv7gvF3heimVfoqW/x++tXFu+sb7cVLEIKoc7Vend9HZFeAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(86362001)(83380400001)(103116003)(38100700002)(66946007)(2906002)(15650500001)(8936002)(5660300002)(4326008)(8676002)(66476007)(41300700001)(186003)(6506007)(26005)(1076003)(66556008)(6512007)(6666004)(54906003)(2616005)(6916009)(316002)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oIW4ZQQEQSPatLs+VOyNFcZ7q34Ozc7tqOu9ZmRlyYe//OKlNS4F4goUc6k4?=
 =?us-ascii?Q?ERoqrZNkimPnb01ICpzwdVMxKBRJbMH5G1we9qyugJtNuyq8vFI6Uyv9zJel?=
 =?us-ascii?Q?vnvSCDBXjr1gVBAaETgmDlpZDVsEtaGzapAd19PmlMQ8XNpumrZZQVS3giMx?=
 =?us-ascii?Q?zIq8JwiMdSYS84xvWgkCpfo86/zUZxf9d87vUgR+yjkf42KDDNe+a9Ba9vCZ?=
 =?us-ascii?Q?bW44FchG8omei0Fm9uCiMzh1MYkuJOvHMCKZbYuazssw/8zd/NNaTkicfgMw?=
 =?us-ascii?Q?EWSq54B4c6lGMNNaznxCw4bo/xagQ5JDiOh5Rggjrct8LVnz+w19FQqwV2NR?=
 =?us-ascii?Q?UXURsZ6vzoPjTCa9CVY4qy9CB/+cvD6ugv+Wzznn042L66FYYFnSpWNJfCUQ?=
 =?us-ascii?Q?QPePVAMUwBubIu8UyIqVpR8icaDW7gsmH2rVpeUoxMnlHs2/fVJpWg5n0fJq?=
 =?us-ascii?Q?C3z5gLpSFyZ7QaTWXz3OdL0qiPJzxGKvhmpPSDHUCTPY/s+h4gKfPUIP3pSH?=
 =?us-ascii?Q?1sYtDPKdf+1RbaS3AomlB1CBZi8au4BMCTH/i84QzpLl4L1xkmHVnq3NFW+V?=
 =?us-ascii?Q?HCbBWr7dr4LeeDjgKeIBeoalTP9U3n5kw51bTXxIJREGqjGpdx0OMlpgXt4d?=
 =?us-ascii?Q?dqPPs4OdyzLY17Um17QrZ3NAni/X1VcQcwIIzXbsKeg5WNdScZSA4Hx0usBN?=
 =?us-ascii?Q?d3TS3dLeljv43yf3NfMV6vKxhsHTLPpLTNiuTTkEfqkj9R1PpjKzvlIVVcGS?=
 =?us-ascii?Q?YaQWl1B6Wi+ijOx5KH2YaNGz+Ywlj3AFHkYd+Zda4SL4YaiGu1PLxEZrnUAF?=
 =?us-ascii?Q?LCHQK+G9Lhio+1EtSUyZ6KOQlafKhk6DLyTILlPlfJZMeuj3nMj05ook3Efb?=
 =?us-ascii?Q?IqXzeBCuiMI689HDU5U2Cczm2OeXLYDXq9+YTJmJy5veqArumA5d8cszdIxg?=
 =?us-ascii?Q?ccus+eJWKwMKi7+YHh0q6moO+yxFZm5ClNO5xCn79ETO0YBiC3K7wHumfsRc?=
 =?us-ascii?Q?g2I/8hd5Kngogorkh29Qz70n/dvbXNZxV0BKSVYkRMCr9QpgayLDt6fujz9z?=
 =?us-ascii?Q?xPr8XN8Ch+hAgM+xxPWU7Kc7rZMEPdxUL+DWBqC838FoXB5oYqdv/+Sv5q93?=
 =?us-ascii?Q?5kckR2LwgZf3mMgklALtU+v75cjAbxOhoiDb7IvyClakazZ3yZRK4Re103nl?=
 =?us-ascii?Q?iYuPGTPz82oh0oFzEFZaBsG70YGpQbAlutyX3FDz2n0kuqRAqr1vkyUAapRU?=
 =?us-ascii?Q?eUxyT04lpNmH8F1wbeaPbQN03G8VZTdgJaItwRS9Ylch3lQtOP9TT8Kl06o1?=
 =?us-ascii?Q?9uxNkHzc/SXZMg+/K78aB/Hrzvhb6snc0dYZPzLMAayDq12iZi+r78Tv61Xp?=
 =?us-ascii?Q?lfwQT8cZIP7BzDz978mLObrIdNmPbwcBBaJcWJHxjYt8yKGRutv4EpPLrtk+?=
 =?us-ascii?Q?Rs27yyORqLIMIrUsc+lXQzlTCwpu7GP6LIEulaHezucjYD568ASVaPRSP4kY?=
 =?us-ascii?Q?LltWIqk2BFzo/1sk8mjLw+AHed2zNcB5XYSJFMh7o4bIYNCXsNGkHJ/f82vA?=
 =?us-ascii?Q?8EqnBz0XlbN8zR7O8i4VfWAZ/0ZZSHuu18njV86PLYnnpFHSZsk+cw8OAm2D?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ERR566wigci8SddhBxDTim2rClU2xoyOMjdAVE3Ap4iBYsax0qNbKKLaZ+KKoFwGCtJDDZoXXOMt97ol4atXxESdVdGyTs+QonZ9lnC5N74ZnFTWh3XdBh6yObN6TCCI5X7U/Y3+34hbAsR+aC2BxeMywZzNHUVYmm0MAJLxDEdMQa/7mh754AocSaLLeSbg9dXElVAyAQ3ptrKlz6kGKb4j8l+P9uyvYvuuDGWHG1UC4S6lq1O0P2qV98MqB0OTOYOV7IWik4RoonW1YAQgmc3W3AC2Q/UrH24604OSJNtjSIlH3U1q2hmb36gZgDYKRcI6OKyacL7pi0O89+Y5u1yezlG5Hks5PG2AwbazBBLt9HYqHnRurscYvOS37bD7rfUFm2za4xjsr6L0fswB7oJKkjk5K8jFTIjzapUfrG7logBFHxu45DykQGGmBIdmxDJuBFA15ELXgrnLfQ8xbD3V4i+VQz4VP2jJNiQcVURpkqQD7cIfNDe9qd3suNt/h+b9/AFzACO16mZdF7s898c4Nk+9HDXe+87DVltqtZulxqsiDsyEuemP+/DvqRPA0QEYt/SFEhEJqEdMIYGSIk2H8hzFYg6SyGLbs++EQ2jv85uVfupnwKwO8MzrzuhkeNgWKghPHnIxBYaLdf8Jpa1FmXfzZc7h9W/2t2qNI9xWhxSSGdxSyaK6ufYFgq50847Jjgzum3tTxAqttvHhpDphXenGfHwPo3d/A5HhLMmr56Nkdfy6xvoMAKRm96EJlKiPhSdhu7q7jbtA/HHRuNUNLrHKyUAs5+LKKjiF8/I0P8eXhmDwZaNqzz2yZ9TksOnoPDlw5Ss2cnIyMPBxtfnDXjhN+hRwFBlf/IMrDV6R6tDEECFpRS4+xss7dtD66ogvq0o1MHfL/kXiSvNNbQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544f64f8-738e-41b5-e518-08dac430fad4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 22:06:27.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gaz0czNXxvtwQfP58V1BKZ3Syo5lNGrGBNSr9xo/TEDYf8lAZ3wb12bsA07HGYwFWY5galK9zC4r2DKnNoNgd589FPR6sqimncAUmqfn4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110149
X-Proofpoint-GUID: iqMfUkqRJA6nKGlwYvPQ58NwXUvJFJnh
X-Proofpoint-ORIG-GUID: iqMfUkqRJA6nKGlwYvPQ58NwXUvJFJnh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the prior changes to fsnotify, it is now possible for
fsnotify_recalc_mask() to return before all children flags have been
set. Imagine that two CPUs attempt to add a mark to an inode which would
require watching the children of that directory:

CPU 1:                                 CPU 2:

fsnotify_recalc_mask() {
  spin_lock();
  update_children = ...
  __fsnotify_recalc_mask();
  update_children = ...
  spin_unlock();
  // update_children is true!
  fsnotify_conn_set_children_dentry_flags() {
    // updating flags ...
    cond_resched();

                                       fsnotify_recalc_mask() {
                                         spin_lock();
                                         update_children = ...
                                         __fsnotify_recalc_mask();
                                         update_children = ...
                                         spin_unlock();
                                         // update_children is false
                                       }
                                       // returns to userspace, but
                                       // not all children are marked
    // continue updating flags
   }
}

To prevent this situation, hold the directory inode lock. This ensures
that any concurrent update to the mask will block until the update is
complete, so that we can guarantee that child flags are set prior to
returning.

Since the directory inode lock is now held during iteration over
d_subdirs, we are guaranteed that __d_move() cannot remove the dentry we
hold, so we no longer need check whether we should retry iteration. We
also are guaranteed that no cursors are moving through the list, since
simple_readdir() holds the inode read lock. Simplify the iteration by
removing this logic.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/notify/fsnotify.c | 25 +++++++++----------------
 fs/notify/mark.c     |  8 ++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 0ba61211456c..b5778775b88d 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -102,6 +102,8 @@ void fsnotify_sb_delete(struct super_block *sb)
  * on a child we run all of our children and set a dentry flag saying that the
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
+ *
+ * Context: inode locked exclusive
  */
 void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
 {
@@ -124,22 +126,16 @@ void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
 	 * over d_subdirs which will allow us to sleep.
 	 */
 	spin_lock(&alias->d_lock);
-retry:
 	list_for_each_entry(child, &alias->d_subdirs, d_child) {
 		/*
-		 * We need to hold a reference while we sleep. But we cannot
-		 * sleep holding a reference to a cursor, or we risk skipping
-		 * through the list.
-		 *
-		 * When we wake, dput() could free the dentry, invalidating the
-		 * list pointers.  We can't look at the list pointers until we
-		 * re-lock the parent, and we can't dput() once we have the
-		 * parent locked.  So the solution is to hold onto our reference
-		 * and free it the *next* time we drop alias->d_lock: either at
-		 * the end of the function, or at the time of the next sleep.
+		 * We need to hold a reference while we sleep. When we wake,
+		 * dput() could free the dentry, invalidating the list pointers.
+		 * We can't look at the list pointers until we re-lock the
+		 * parent, and we can't dput() once we have the parent locked.
+		 * So the solution is to hold onto our reference and free it the
+		 * *next* time we drop alias->d_lock: either at the end of the
+		 * function, or at the time of the next sleep.
 		 */
-		if (child->d_flags & DCACHE_DENTRY_CURSOR)
-			continue;
 		if (need_resched()) {
 			dget(child);
 			spin_unlock(&alias->d_lock);
@@ -147,9 +143,6 @@ void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
 			last_ref = child;
 			cond_resched();
 			spin_lock(&alias->d_lock);
-			/* Check for races with __d_move() */
-			if (child->d_parent != alias)
-				goto retry;
 		}
 
 		/*
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 6797a2952f87..f39cd88ad778 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -203,10 +203,15 @@ static void fsnotify_conn_set_children_dentry_flags(
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
 	bool update_children;
+	struct inode *inode = NULL;
 
 	if (!conn)
 		return;
 
+	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
+		inode = fsnotify_conn_inode(conn);
+		inode_lock(inode);
+	}
 	spin_lock(&conn->lock);
 	update_children = !fsnotify_conn_watches_children(conn);
 	__fsnotify_recalc_mask(conn);
@@ -219,6 +224,9 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	 */
 	if (update_children)
 		fsnotify_conn_set_children_dentry_flags(conn);
+
+	if (inode)
+		inode_unlock(inode);
 }
 
 /* Free all connectors queued for freeing once SRCU period ends */
-- 
2.34.1

