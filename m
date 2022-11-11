Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7916C626425
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 23:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiKKWGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 17:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiKKWGf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:06:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0292831214;
        Fri, 11 Nov 2022 14:06:34 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLomD8025514;
        Fri, 11 Nov 2022 22:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=3yrv6I6Gy849InlmcC+R+QpZCaxpqBZ/IFHX6Kqy7z4=;
 b=V0ep9cOFNP2GkNY5p/BOnc/mV2SqfDMHCmaIIxFOlgrSEUbjtOOo8P125Q5AjyQRYTh6
 BM1iP1Cd84jnln3qHlk2or8o+24eXKKVHk375lpuqjQzFcNGUkNHLNHWANEuHDQwOmvR
 DVhVpTl970Yu6UGZdq1mTsVXMmT6fCBDDUKW9Sj0SojLwY2mbUJxMvaA+8AGKCidQ/8v
 CAEyVEikrqM2ZB+9koaIXx4r09gJ2bGlaybhU+b0vT1YQO68Pm7jW4IX0lDIQ/Ps1qr3
 5QiQ8ah8soytiqlZ5nYkat9y0AP5/ior5zvl0maBp4jRbU1LJnm5AxjzT6JUVkS+YUUh WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksxnrr133-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLQB9a021585;
        Fri, 11 Nov 2022 22:06:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq6v66y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m08OGeZeIxEniCWgdOELjB2ALWinXFiQE8B0u/kQd2mK49RwVzTqECt7VU3iHPiiJoj6kgP8+EIygPHAPc+BMo/JIfX3ucZrfYOzZMytFryK7hGrdvOBQFiRb8kbq7IV7nKBTWlX7oxMuwOPbGAy01Sma//fI1CI6DeAiG8v0sVKr8mFTe2PCq3ZgnSsdQ9H+NKec2RA38MqC078yt4Bd2U+IsEmTt5z1zQbHX6VrSZlB07c20e4/CG7bokEmJMuEOoN6AzBB/0JlkDsVGLc4bBEGsFCVkCLj+Y1/+VEtUTaMI1h/K6SrHFwAysQRq/wRdk1eC42z3tWkVCg0JjJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yrv6I6Gy849InlmcC+R+QpZCaxpqBZ/IFHX6Kqy7z4=;
 b=iFga3xWIVT9GLHO2J5o6kkgiIP1nTXPHtOdgPHzx0BPiD6Y5wW0czOf/5+XgmC97MtKiXfIISOFxopORv9BFNm1DsJtL9C3ogi0oXoDOkb0ekSYF5Zg63TgJjlitGtmCU5ekEYxX2mNS9pMq23IsFQy9Hc/qHNy81vwbTRh1guymMOqer52fJ0a+RTEilToGlCl6PSlUyqCYTgqP8/X4SS73GRsNaaDfzbCxAnpF2y9S0zvmGQETXo0Er7x9QlkLJjW+hPcYS2d2tZjd9BpjGG1rt8soeuCBW51OAYbvN3uQF/Rc/a6wRFjxBOhh49CUlbJig2/iDVhkxVm4PJrQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yrv6I6Gy849InlmcC+R+QpZCaxpqBZ/IFHX6Kqy7z4=;
 b=fgPMZiK0CaZjZ9gg4Dpn8PmD1Gtv3X+R/bLvlYYXnhuPilzog76HISmYrhLNCSFLqtKHjaIp9Fl0IkIb6M3oE1k+ybX9Wi0a811+kqZh2iiqIZy+NX8epj4tn7X6GcLlAZcMoFFfBm2x9Kez2yydVn2uhhvDBM8WN6dKUyqf/Ek=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 22:06:19 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 22:06:19 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 1/5] fsnotify: clear PARENT_WATCHED flags lazily
Date:   Fri, 11 Nov 2022 14:06:10 -0800
Message-Id: <20221111220614.991928-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111220614.991928-1-stephen.s.brennan@oracle.com>
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::29) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH0PR10MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d3b148-cf48-4694-f958-08dac430f5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMXJb07lkUQZNxvXKtX5BYYz7dxzUlmoQMSCwoqhF/kMG6+xCyV05NLeat/ulnq/w50A0LgaAZZqp6+FOYxGmIQh4Y0IQyWm+XPPeO/lTg+tHwviOTGH0F3qhQNrR/PqPkxwS5lDUqxoWnnFvK4R+0NQPhLkENz5HBAZt4ypmbtZ+sV7AghjzkSvxWRcYAEGlnQWRyK11a/Nt6cg7jI4DtxxWy5Z6snHdaoEGA77hfAT1etq3FI7HQSr9To22zFGTWP/zpn8JZduVhBLzkXHTqHb4sLE+6BXnrAzCPZoTp3rNcD0xXCB8Si7dAn9J3kXvQoDb93Yks3aMnkeWq1g+24e0hRjFxv/+Lc0jzhTXXCjFer7yqz3Cp78QQTcwGHUVq7JOSo+h3//QqkcyxEZcT8JsMV/2UPHisegjKH7znp8KjymdstsTsj7V/6w2aH+elRk9P/uQh5/+4yiiMFkAzGZIaay5n/E0J6HwVWH8kb6maEvL9QwYekcLm3CLAA8sW0WYr51cWaQRNOQypLe/OQP9mBJM31I2iqRJ1cO0CGfv5InaU0khguMVwA2f1GvpS8y8umOsMy3spidkmqQQzmsmZnYkuGDlEFAMkCeMJ5vFku1q/dXZwTWB3lEf+Zn8VVVebaFyhu6We30QxMHOhYkcSSztDBck00+3DCiU+TdOUBK+P1SkNFRGSV3BsB9W9kuBruxv9LR5jHGQhumdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(86362001)(83380400001)(103116003)(38100700002)(66946007)(2906002)(8936002)(5660300002)(4326008)(8676002)(66476007)(41300700001)(186003)(6506007)(26005)(1076003)(66556008)(6512007)(6666004)(54906003)(2616005)(6916009)(316002)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q520Cc6u03dgODZf5qTDATRktLdEs4bTgiK1VtxWM9pYlPKs8QmFnpnT1kuH?=
 =?us-ascii?Q?JJYNxejyzs/RkfOZhBvxrIAQRapflwqdYdg1LKe5cmto1PzjG0eYwbNWwTSk?=
 =?us-ascii?Q?Lqk//kSJRuzGFjXwWnWFoHzoBuS/0IbEcY2msJzFT9wGU2uCsltHVGFmx478?=
 =?us-ascii?Q?LBHwwP/30lH90x3cpXTJR3yE1vJN5HDSQAEiurVyxHrzP/SEMaUPb67z9KgR?=
 =?us-ascii?Q?7QEIcUhvqSD8OTlwt8I50umPU95TNaWEt4d2/fwHnwp7XShzQb0ECTG1JlSh?=
 =?us-ascii?Q?65fO5N7X0ffy2SB8mCR4xXPDpBRd+Wn2NKONREQoIWCuivkGoUY1x5CjNu5f?=
 =?us-ascii?Q?MAs7ELZFHLZMqsIs7OzwBu1gA1Fe3cAkW9TQz759MMTcnRNBpZaQaEcwfbjH?=
 =?us-ascii?Q?zyes/34wvOwSj0p5xr6vguo306MYcYatCHIcMzxFaR2ae6hpKK31E2IE7vD+?=
 =?us-ascii?Q?7WRLRVOrYmwwwCKUiwRbji7dqpIMOcBD85yQilvij3nyfcY/fk96Y1GQnbwT?=
 =?us-ascii?Q?TWd5fPhIP9T9TRAEdw6CUk6QU1I2502e8Q93K2i9OxhzoJsRd7IY0kD8n+0x?=
 =?us-ascii?Q?63RgNEK8R+XPkfwEMdWQDOjcaHuKhjMBxQeKkMaffAA1nXs6Yf2M/B3ajq3T?=
 =?us-ascii?Q?RM77DpoUP8Lyyc83qHwUF2fI6WO7u/MktM9w+65dmhGTFBfVHkoz57lNZOTX?=
 =?us-ascii?Q?4cWLCUiKqpKWZGv3vfrvzl0sleIEoYFSgk8SLoL+76+k7fBZLCNxjAbjfKSa?=
 =?us-ascii?Q?6nFyTdA/nEaeWMVRTEGhLTD3aYm+RxAFhrffr2sU2sNfPbUt9TAAPEFGFaON?=
 =?us-ascii?Q?eR/cPYpcLtLTTnwIVTw1dvyUiKmzzLES92TWMWAedYWywd+i+h4fR4RoGMR0?=
 =?us-ascii?Q?QwOsY4Pmsxr/nomAT29M93lA+2RaHoECK+ESSK8O8RHs6DyfDBqEfwun6ZEy?=
 =?us-ascii?Q?/dNXZ0MZuJsN5CKJQAqzRbes1MgLvay2Lxtx0SjgXIRniZTbOq2UD8SVS5BU?=
 =?us-ascii?Q?ifr0avdvji9wFBwhVlORwmIf98ehqggZl34viSxFNx5m+ZL131sXsHGDuT5/?=
 =?us-ascii?Q?aBUXMSA8OQjpUn7A93xnSVNNovX9sv9hanknWelKXu8UIreNJIdhfse4nTIe?=
 =?us-ascii?Q?3uAB/HTFoKxGUQtOZd3PkmnAFgbYi292//CPyypNKBaloCciqHliAVSk0+J/?=
 =?us-ascii?Q?Kb2QteOeDqXAdez06CqlY2s7XoG95Q4ttmqjup0siRMm9Q/cjb0cc6WGYui1?=
 =?us-ascii?Q?DuPaRFdoS3llaeMMvpoEPWXmynF1FK+PlY13fk8BKC5anxhCzptkLmwuVYlx?=
 =?us-ascii?Q?b8aJgUWWeJb2IPR+iFGsm/dI3u6w0F1pi73xPx8cZNpyxtixv0KDls3dXevK?=
 =?us-ascii?Q?AJKDDKzqSRgWnYQkdcU5d++mRLkG1se5t2WcLtpEkoRlhDO6FEOUIK+p61Yg?=
 =?us-ascii?Q?aJ4hAM2gPJK+U705/Zmu9j5RQ7eeNPeTRFRxMezPKe80pDPmfgU/APF3wO+h?=
 =?us-ascii?Q?m+iOMZGm8NJNA3j5yv61XEyqGz3idOAT540f6AyZ+LHiT0y3b/QYYgBIjlIv?=
 =?us-ascii?Q?vv7GQlupKiczkKJeBeSQ89EIvj2jbuLDCPO/j/D/L367o4LzwmdU8Q5VnpAP?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pZLC9PcI6384KPxE56Zzfw/UbIaqj7uHZs0m8JApyxK7694kEy/YTAbP0idXjK8AEmVn5DOFeaLhjDiCPleuRnmIwqn5nNaDG+/qGXO0ZX4ACcqccVM5Yl2VFwAmCr1Vw6++QlIZ2i4vf9SQjrsS6CXaMcZAvkpSB81SSgWo2UQaZvbFbCFJuuPF8Ht2G9zEvfcofBZoUPA1gMY5OOaQm4TY91aLHucQaRZ8RBcC49tyIwPztaC9me4/wcd9TDxTSjYLbiZOZzeivq5vb3smCYe45ZAsAWqKJlcRc7G0oTBvMXHfTsa4kL29Ghup/fDEzFnCtTlu0TquL4ntlZaCm0IbdqLM34mS0hm4n/OWPnvFpc0IxdnIrguDI++oAN3HmeFf1Tan9gAs/9yzCPxH/3pYvuhFV6kA+gl0Qq8lwZWzuiykWyiX5aJjlxhlUAR1LdWkTbpMOz9tg2kDEy7lcvUxiW3UC2LtehkXuJtLLGwhdT+5OQWEPdalU0ZMQpEolBv8CQslTKDe+MbaU7WLdZYb1Yu1kjC2PkK3KJ8Lbbf3Rqs6OZ0Sti3lYuO/wmltZvFR2E0DYNfkYZeXxh/nRE3xqNVsvVPpr4haA5Ni3lZpX5JWLisonwDzLbvH+UuK05YdiI9D2T2F3KnVNcKlSJpSAV0PVAG/dIgAuiTNfJABX/0fokZYaRqJdRX0/fKNcAYU+JgUiCS+zbwEWm+eKRT5k9b7Mszhn9Gius0Ts6w64RgoaB/rQdPiaZtx2+7Nn8JSSmxZDf9QitlFFHvm8sfyrl7nMEA63QYeD1Y5mO2TBHZYj3MPgnUMjyw31fWBwA+jmbo6BY1ewf5aObsf0jFZ0jCX/f0rog38M/GHv8XbhW5Xhmszsey3rmsJFHtms4MbcXIUxN4DXYh/NjGJSw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d3b148-cf48-4694-f958-08dac430f5e9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 22:06:19.1134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3fPDBoGziogybevJFVA+FAOITFP0SHFtG0XyNbTjkivgNYyBr0BweXyZmTU0i4QkzUuDUdQo+He86c97btXSo/PopiKXHthuXsIuk8gfDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110149
X-Proofpoint-GUID: hfbPWyGWbEGvUlwFYDFWtXmPFsHkiexv
X-Proofpoint-ORIG-GUID: hfbPWyGWbEGvUlwFYDFWtXmPFsHkiexv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

Call fsnotify_update_children_dentry_flags() to set PARENT_WATCHED flags
only when parent starts watching children.

When parent stops watching children, clear false positive PARENT_WATCHED
flags lazily in __fsnotify_parent() for each accessed child.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    This is Amir's patch based on Jan's idea, with no changes or alterations
    from my side.

 fs/notify/fsnotify.c             | 26 ++++++++++++++++++++------
 fs/notify/fsnotify.h             |  3 ++-
 fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h |  8 +++++---
 4 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7974e91ffe13..2c50e9e50d35 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -103,17 +103,13 @@ void fsnotify_sb_delete(struct super_block *sb)
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
  */
-void __fsnotify_update_child_dentry_flags(struct inode *inode)
+void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
 {
 	struct dentry *alias;
-	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
 
-	/* determine if the children should tell inode about their events */
-	watched = fsnotify_inode_watches_children(inode);
-
 	spin_lock(&inode->i_lock);
 	/* run all of the dentries associated with this inode.  Since this is a
 	 * directory, there damn well better only be one item on this list */
@@ -140,6 +136,24 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
+/*
+ * Lazily clear false positive PARENT_WATCHED flag for child whose parent had
+ * stopped wacthing children.
+ */
+static void fsnotify_update_child_dentry_flags(struct inode *inode,
+					       struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	/*
+	 * d_lock is a sufficient barrier to prevent observing a non-watched
+	 * parent state from before the fsnotify_update_children_dentry_flags()
+	 * or fsnotify_update_flags() call that had set PARENT_WATCHED.
+	 */
+	if (!fsnotify_inode_watches_children(inode))
+		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+	spin_unlock(&dentry->d_lock);
+}
+
 /* Are inode/sb/mount interested in parent and name info with this event? */
 static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
 					__u32 mask)
@@ -208,7 +222,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	p_inode = parent->d_inode;
 	p_mask = fsnotify_inode_watches_children(p_inode);
 	if (unlikely(parent_watched && !p_mask))
-		__fsnotify_update_child_dentry_flags(p_inode);
+		fsnotify_update_child_dentry_flags(p_inode, dentry);
 
 	/*
 	 * Include parent/name in notification either if some notification
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index fde74eb333cc..bce9be36d06b 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -74,7 +74,8 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
  */
-extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
+extern void fsnotify_update_children_dentry_flags(struct inode *inode,
+						  bool watched);
 
 extern struct kmem_cache *fsnotify_mark_connector_cachep;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c74ef947447d..6797a2952f87 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -176,6 +176,24 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	return fsnotify_update_iref(conn, want_iref);
 }
 
+static bool fsnotify_conn_watches_children(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return false;
+
+	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
+}
+
+static void fsnotify_conn_set_children_dentry_flags(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return;
+
+	fsnotify_update_children_dentry_flags(fsnotify_conn_inode(conn), true);
+}
+
 /*
  * Calculate mask of events for a list of marks. The caller must make sure
  * connector and connector->obj cannot disappear under us.  Callers achieve
@@ -184,15 +202,23 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
  */
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
+	bool update_children;
+
 	if (!conn)
 		return;
 
 	spin_lock(&conn->lock);
+	update_children = !fsnotify_conn_watches_children(conn);
 	__fsnotify_recalc_mask(conn);
+	update_children &= fsnotify_conn_watches_children(conn);
 	spin_unlock(&conn->lock);
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
-		__fsnotify_update_child_dentry_flags(
-					fsnotify_conn_inode(conn));
+	/*
+	 * Set children's PARENT_WATCHED flags only if parent started watching.
+	 * When parent stops watching, we clear false positive PARENT_WATCHED
+	 * flags lazily in __fsnotify_parent().
+	 */
+	if (update_children)
+		fsnotify_conn_set_children_dentry_flags(conn);
 }
 
 /* Free all connectors queued for freeing once SRCU period ends */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d7d96c806bff..1276de409724 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -563,12 +563,14 @@ static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
 
 static inline int fsnotify_inode_watches_children(struct inode *inode)
 {
+	__u32 parent_mask = READ_ONCE(inode->i_fsnotify_mask);
+
 	/* FS_EVENT_ON_CHILD is set if the inode may care */
-	if (!(inode->i_fsnotify_mask & FS_EVENT_ON_CHILD))
+	if (!(parent_mask & FS_EVENT_ON_CHILD))
 		return 0;
 	/* this inode might care about child events, does it care about the
 	 * specific set of events that can happen on a child? */
-	return inode->i_fsnotify_mask & FS_EVENTS_POSS_ON_CHILD;
+	return parent_mask & FS_EVENTS_POSS_ON_CHILD;
 }
 
 /*
@@ -582,7 +584,7 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 	/*
 	 * Serialisation of setting PARENT_WATCHED on the dentries is provided
 	 * by d_lock. If inotify_inode_watched changes after we have taken
-	 * d_lock, the following __fsnotify_update_child_dentry_flags call will
+	 * d_lock, the following fsnotify_update_children_dentry_flags call will
 	 * find our entry, so it will spin until we complete here, and update
 	 * us with the new state.
 	 */
-- 
2.34.1

