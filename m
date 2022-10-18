Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800FA60232B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 06:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJREMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 00:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJREMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:12:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5E38A1DB;
        Mon, 17 Oct 2022 21:12:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNY6Yp015929;
        Tue, 18 Oct 2022 04:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=511SacntyxyUU7tgivFYEUnraqHlRYbCAseq8KWBv3I=;
 b=pO8fOEwBJwWqhfznKHjOrXV45Yoqsi/o2VLWabXWkmh/QzWW4AqQVN5WkMJFJZRM1rsz
 lNiEYqN4EN4gyu4o7X+Y0vOFSWRoMDcK9H5IXiohGS7ZzrLAEXrrOclh7DW86jBcfEAY
 VoD+Q3TCgh6lBOJN+TyaWbNO/Za/3V8HzF4YYQ811c+81gplZcgMM9ZW2wEs20v7yOnU
 4qm2Pb6k5EiWKmyh5VruX4oauXXN6v25fG4TyFd+MczoSH2O+Dy68pvITpM+asHpB3Mr
 jCzGeXLcTIH6Q/fuRv4z5lLDBll48X/zRKaLcY8zYQF5yzwKa3njsPaeHKSj7kaRlF3f 5g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3daya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 04:12:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29I3puF6015903;
        Tue, 18 Oct 2022 04:12:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hqy6fdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 04:12:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgvNqKOLRJKgD9wmZvXezMfqbCp4unWucJKXKw5BY5sah2BfSBEkrX+8CGaUu95dsJ8Jggl1Rgo3jMS+vXmYoVpLmuujuh8+tl01z4gBkwUlG3oes3LOf6pkaPNzO6exLz9zr9DHYeduYpmHyPaSpzTRXzSdzvLYfsFu/vMjRpu6OjrgnDsDyQQ91obEOW+iQ5KEyZYVjVX/NdOcd7GU41fps2l4A8ldsB0X44zQjEGdIpS4Bb4Xt0bBl103CkNS+8nhE7dDkbEV3XFEIxaSrPpYeYBn9EAPySIKqEzL9gZUvr6COQ5qA1CfPxgw1hxFg9TSbwGjwBJNW2rlONnlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=511SacntyxyUU7tgivFYEUnraqHlRYbCAseq8KWBv3I=;
 b=NiP3gw6YlFkG3XgopTbuGuzRxVUk0cna+L9D+m/pSeMGL6hprOoUXHVq1YldYsXU8g2WYHEVU1xJBeEsiKGbAP0A8Z9Q66fesW4TXy6VnmA3zxtykf389zODgUx8iFLQKmYnJuZveHsYIni9p267VnR80Gj5i795tfAshVBNcykBKqkyfNrGa+Dz3EyreADyRO1DXjG0XJhnRnKn7lF+JKt7Bvb9rXmPhtFUC6jMkbQalM2I1pZyBTot0LR//pVMOR69pG+46tWiDFDzSNFg1Zb2cwGgPxZvqhhBrRC2u0aqwwoqqBO5XN2ozSDz3H9Z1ws34FGO4pN9wfEmJfc1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=511SacntyxyUU7tgivFYEUnraqHlRYbCAseq8KWBv3I=;
 b=aw2VOFh/CL0sjt3fusP38AOsvi3jjcgE2ZB/LGhQMTnDg7W95AOOAYExYEkdIkw9IrMchWawkpQ2YJhdk1wLHKclaRXLjnd3y3tf7EzivvA6pENKXxlfHm2C0Z6pgtw+MET1M46UW+LbgnEUpzEFuTPCHHqK83fw7v0BL+vQKGY=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH0PR10MB4567.namprd10.prod.outlook.com (2603:10b6:510:33::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 04:12:34 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 04:12:34 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fsnotify: fix softlockups iterating over d_subdirs
Date:   Mon, 17 Oct 2022 21:12:31 -0700
Message-Id: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH0PR10MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: da74a9cb-a302-470e-e5a3-08dab0befc07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvN1TYukfAvd75C2Kt9S9ganOaRyxpHupIWb2oylc24rz5fhvpX00AnVTR6NQXEZBiSJERv3du45ki0ZEV/nmPbd4PZQJAtIsyQUjo4+AtlKJgJbijUef5tQGa9KFUl3/+OEQOIJQc/qLpGXvxS2ajBDngVSec4owaH8xZPj8/U0UblWkQt2J8ZmdoM68Mh2YCHftJ6tobH35o5fkZ6PZ/1xaCfmsMZYzaiw9XYWBH6FIf1MXe6Vw1jhlvEQYLNrQSAasZPAvvEpHu81c5oY5s3cpQ+Rpb8xoFSYTYFZ8Cy1mVlKDugyeInif2faFJMRjkWZjGgQkubMDJI5irmuq4S9HIvHNHtAohG5DhfkclqBwyyqdGPilNmvfE+I1IjEgf8V942MSmH5lFVaZ+ATQU9JT2brAwwILHuh5Fbogyay9nUFZ4SuXPgspbHE/ixXnHJVU7YErbJVbWcG+tmCHKcMTZQewmPJd0rDPkJ7DMBjjWCiTiRA20q5jLXopH/taY93b8DcYdF+nkGpJRgWaI6M+0HsnKuDraYxoTdPQP6titaTOlDZ/kZ9jG6/toKseqirz9JCZdX82s3+Kp6RHdEI6+QJkn/6kht0A9dLHfM5wwVWBUxsoJDHqNQfYyQETAAAVWH8qU4ArSMNQ14taLbTNFoqSwEiWe4O0Xjn+kAdFVu1qQixxpIQ6b6ATsvQubE0x35e7QHnH8zgrjMsgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(110136005)(66476007)(66556008)(4326008)(66946007)(8676002)(6666004)(2616005)(316002)(1076003)(186003)(2906002)(103116003)(86362001)(83380400001)(41300700001)(5660300002)(6506007)(36756003)(26005)(8936002)(6486002)(478600001)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EtugbzTMJ/2NSMfos6aA0heY+es0LZZxh0OhymWNlH6AAeTl8SRTgq/2hiYu?=
 =?us-ascii?Q?RN1JPIpmDiBvimEQsD8ly0jLDej+BgSTh4zpFNgY3RYNQ6A0DCz028wZzYN5?=
 =?us-ascii?Q?taAcq8VZQBWv6JLx8+WOVlaEuutuKX2qPXdGYSfrynAOYz8g3k4BgDiP3A7a?=
 =?us-ascii?Q?SBECtSzVlJUwQmBZft8yw3ogNojQxGNJNKXp/8Eo5OC93XKB8JXn60gtBkrP?=
 =?us-ascii?Q?Kpsc51Vb+WVP775/Ppi4S7H8RY9dzuhJufIkyPgUG/PQfRINz31QyAvOz+ld?=
 =?us-ascii?Q?bt0kuD9PNtAxbcQAPusAM8osqgZ/QJmA7rz/CQC34mHEX7MWDcaOq5OIrq6e?=
 =?us-ascii?Q?Ep9d1pyocgvvPA54qPMXzl9qOQ/JeLidJAfQvexGqI1DIs0KHp/H8XZJZ3uz?=
 =?us-ascii?Q?gTyaSjtSe8f9fg6HdSuezDD5IWNCVlglYhOJLl3qB+HW6iNEYDNspU4xYZIp?=
 =?us-ascii?Q?uawmILHKLTuZ7S6/FJmzjXHEAdbvax/wbfiBdYSWF3Y6TeAC745ekFSwy2PH?=
 =?us-ascii?Q?XJagHmOCsPj27x22DS0O1s6GdpYqsW33H1nav1TOfPBozWAtxTnlGeTXqD93?=
 =?us-ascii?Q?+oOvIy0YcFxtbrNTEZN57YyfDFCw2llmUx7F6a3293QSAsuRz5af4tIgDeG/?=
 =?us-ascii?Q?OYtiNC5225MQ/BnfxLrJcu8TpnF5kWgRcWmOPCMBwJ0RPPKC22oj27mP+XsT?=
 =?us-ascii?Q?mi/aix8f+1qch+kLEb8BD1tZWV1d6Z+QEEUc9y/ZEzqyzCAa87GpdjCTFpQc?=
 =?us-ascii?Q?FtZaPbWtWXKM5tYAHZikFI+WLdLC1RHQoHxJ25cy5NkQGFhaguHqsacxzq+c?=
 =?us-ascii?Q?eP6QqL+wZL+i6d8lqCHSRD6gJ0XWIGQaltldYcE96sWw22c07K3Uv2EjnWBl?=
 =?us-ascii?Q?t+qrFt4Hw0S5gQ7Kc+KXLHdDb3uKtwUzZ5gMa+MU7jEYLLlzGp6lYwU83Urt?=
 =?us-ascii?Q?eilmgn/zHdzXTrFsf/nIzjUiyCBe+CfXJV8D4GP43W5Zxri8NjoEfgTlkSLh?=
 =?us-ascii?Q?cnY12+EYBMD5Hgho1//iYXPKR+INZaUxNNJWRjT4lZhh4D+ZpyO8FXSwh4tk?=
 =?us-ascii?Q?LgIZJpCQtnwltTS/QweFaZfOZ3KsiCx/d510wySoScI03jbkssqxFUDq1fTe?=
 =?us-ascii?Q?q9YmVPLq58dt/GDCGnuZ0ctRNCOYSO38/L48w64S1jK9wHi9urg5qY35x50u?=
 =?us-ascii?Q?uA9qSepYjL/7qaUTMiQNLCDgkJAgRGjB1Mth8ak7A79IWOBEv/YV16xBrFzs?=
 =?us-ascii?Q?d8UlCFZEEpiLCzW+4zdl08jcFWmmY1m4aU+Xz7ECJbkP2MtMFXvlEOHKSzf4?=
 =?us-ascii?Q?kgsTWYaagDVjvZtR8zT/Qr6OIzVpUHukA0Akvp/mV+VE9tgVkKZkSK0SAsFx?=
 =?us-ascii?Q?hVcij6ETnihDv/M6nJ5ZuIexBt8P7TlWDmx2s8WKABIpCCiYJbNvd3g7YQ1Z?=
 =?us-ascii?Q?H0ym/uw0tVRIs5S+HXI3hWGaARKRBWsjXTtsOlKxjRcLjiyQhhEw9yoIUlZ4?=
 =?us-ascii?Q?hZfT4xDzn3h7dWLbjrWwCNv8SPN1umMHsjTwwOUiRWIih4GpxFL14/Y4EQp9?=
 =?us-ascii?Q?roShbbRSJXE2B3VMs0asPjyywmS/i2Qk8LbUQlqeEza3Bs7FtC5xECr/avgI?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da74a9cb-a302-470e-e5a3-08dab0befc07
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 04:12:34.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqYhD6zKv3PwzxxKRj/9qXyJkii7FcY322Y2flgvnMbkut96p+G5AzfJH2bXTvxEpKP0jXD7vsY8rX04zjjnt8/kwrZLCZgx+XXqbdycZRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180022
X-Proofpoint-ORIG-GUID: wKKcWA8bcF1MbkxVvXx1I5e9-8zA-rRH
X-Proofpoint-GUID: wKKcWA8bcF1MbkxVvXx1I5e9-8zA-rRH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan, Amir, Al,

Here's my first shot at implementing what we discussed. I tested it using the
negative dentry creation tool I mentioned in my previous message, with a similar
workflow. Rather than having a bunch of threads accessing the directory to
create that "thundering herd" of CPUs in __fsnotify_update_child_dentry_flags, I
just started a lot of inotifywait tasks:

1. Create 100 million negative dentries in a dir
2. Use trace-cmd to watch __fsnotify_update_child_dentry_flags:
   trace-cmd start -p function_graph -l __fsnotify_update_child_dentry_flags
   sudo cat /sys/kernel/debug/tracing/trace_pipe
3. Run a lot of inotifywait tasks: for i in {1..10} inotifywait $dir & done

With step #3, I see only one execution of __fsnotify_update_child_dentry_flags.
Once that completes, all the inotifywait tasks say "Watches established".
Similarly, once an access occurs in the directory, a single
__fsnotify_update_child_dentry_flags execution occurs, and all the tasks exit.
In short: it works great!

However, while testing this, I've observed a dentry still in use warning during
unmount of rpc_pipefs on the "nfs" dentry during shutdown. NFS is of course in
use, and I assume that fsnotify must have been used to trigger this. The error
is not there on mainline without my patch so it's definitely caused by this
code. I'll continue debugging it but I wanted to share my first take on this so
you could take a look.

[ 1595.197339] BUG: Dentry 000000005f5e7197{i=67,n=nfs}  still in use (2) [unmount of rpc_pipefs rpc_pipefs]

Thanks!
Stephen

Stephen Brennan (2):
  fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
  fsnotify: allow sleepable child flag update

 fs/notify/fsnotify.c | 84 +++++++++++++++++++++++++++++++-------------
 fs/notify/mark.c     | 55 ++++++++++++++++++++++-------
 2 files changed, 103 insertions(+), 36 deletions(-)

-- 
2.34.1

