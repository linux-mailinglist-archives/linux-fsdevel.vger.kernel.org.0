Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12834B010C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 00:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiBIXOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 18:14:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbiBIXOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:14:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0EE04FF12;
        Wed,  9 Feb 2022 15:14:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KHBeB013543;
        Wed, 9 Feb 2022 23:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Fbv57XCFOh/NLtiwOFrBhwGoKiNYyK7jHBz6SqSu4nQ=;
 b=usu3rZGCQtDUOEG4v2cMTJx7xvh36xpXt2JeWz+1in0rXPmsNMDtncjS4fU1eKW7P0BI
 9iZO1LpOedwB/nFwx5w5jbYN8+3/c4d6Z/wNwOlaalwx8lBNWNMS3YhLYbT+pbMWgLtu
 Nl6u9pq2shKIywqr+KSjiHXJ7ge0wIR01O5Gf+NJ/1t1hhnUNB01kQxeTdG+Hfw6RTm9
 1lJGF5j8OU5+PIDfrNJ23vdtJDwG3XwzqgMZMQxYEd8kM1FDPeLFSflQCtoXynFROQRA
 zQMj+bLyzALosCEsFdpNMLeBIjbwTfYmnrdChFbboJ0TneT4IGmu0WSDo5NU78oTQX/t fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sr036-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:14:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NAAZ7141612;
        Wed, 9 Feb 2022 23:14:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3030.oracle.com with ESMTP id 3e1f9j6sr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:14:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkGJTPRzlmluYqE4DidhyP1PD6nUoI9ytGDOi3K3zAWL03H1GCvhFZj+ZTv+/ylkvPzFjOawbKGXAVYzSr+5r/+5+fh+yUK8ncafbvLx9pYLiUE74RKBKHkLGd9J/JKKkmwkVM9VqcbI66Yl8syH5fPvALmJULRJ8AZmvJa0yqPKocWg6HPdJhnHQmUCh2As4yA47CSMHqDY5zDMtF5GkcMtfyHQ9rEPXSeF1xFSWIDcb/xEqFG1lAnzEH64ksZs+Uh4vYLHEpsK8CGskLiPXKdFSWDLWTqJWNFXoU5cWjX6OHShgyb9qYu21Mqzuczi70WmqeHnO3kWuTbJ57kz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fbv57XCFOh/NLtiwOFrBhwGoKiNYyK7jHBz6SqSu4nQ=;
 b=OAgLLDEjfzL/Nsx0RqIGZGMLU98LPWNRxbjcfc97mMUNOFGu8kkES1cDSnSr1KO9QUjAvcsJmX5Q1P43g8jNbyxaraCLEhmkZm5AAs7swtpJorttC25KwB8p1yxYcmhIp4MZB/ibQPpPInbnOa6YAb0Tf5j6fpw9x088iUJ/J3ddBWmIqlx6hhYLbIFzNvRDu4CCvS7CXpe4TfzNsGKw7Pcme2LhkH7JkRCBv41aWqgEJpcORTBMiDGSa/RtjGvb7gSWn2Po33jaZGUPihICoxtS/771PQRBDoH30ap4vcpkmcGEt8TigOXyjLBGJ2qennyMTDilJEUWRejjR4XZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbv57XCFOh/NLtiwOFrBhwGoKiNYyK7jHBz6SqSu4nQ=;
 b=KzF89FwQJhn0W3Hw1So+9yFiLFPy2TMnpzT6jXhipjFbnlWxaGTHhoT2sBLSHFvBRPPBouyuZlifkrdb+gEQWB82gciSP3Reqb5nlvQnOjj+Vw7bM8Islm+PEUp/aTl2reWHhgkWujSQJrip60TMI/rBRE92iCHLuk9uKBJf6BE=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB4884.namprd10.prod.outlook.com (2603:10b6:208:30c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 23:14:13 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 23:14:13 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 2/4] fsnotify: stop walking child dentries if remaining tail is negative
Date:   Wed,  9 Feb 2022 15:14:04 -0800
Message-Id: <20220209231406.187668-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
References: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:20::11) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b58b7fc7-1df4-4f7b-8390-08d9ec21e2f1
X-MS-TrafficTypeDiagnostic: BLAPR10MB4884:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB488420311E93C9F6562CBA15DB2E9@BLAPR10MB4884.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpQXzILnnr8NLYX6yeQr879iX8kzpixgj32XeHwmTPkSFuA0Ln2GIfi3gikp5lxj6EKp11uW9TpiPTtSSC13MAgx56Zc+B4Qr7HqFEaqi6zJTNLB7Abpa6UYr/d8Y8Yk8rif6D9+qb56ud8XXg4IwdS1xcnlQg0P0XcvZcd5s+wdzYpfmUZTqwtDgeevELomWOEvqs4zK7fWWsdEQPmXAXnBg4UNUFD/PhoM35Tv8nIUZYeInxvlHTgzkCiomq/YcsRrD5z122JJ46OYGk/sKzvc23qt2lqPfn7dAP+YTJsFElKGk6j1UVWeLJs99RJiz9C6Z6tOi1bgc4itqCAz3v0Dq44wJjU/ZR9VAjBviE3VdURbFoiet5zG+SPQRozU/9xBUy2WcIS3a08HYIf+WMuBjDAyxegcLxrIek4pxlb0amffED3ZO9kWpHkSahbpNiDXfAKs7OjBMNa6ar8MhV9pgdQyn+C907q1SLB389yKZVGZO68Wpqrb6sZZHYfh8UXkDQCiSmNSfXbUpL056pGxWS6qtUn66k5rtGrWwwrHz+LZvQLvXBxWkA6XSxqBCiGaACpy+9SzpcpexITLmdBQDvA0vfE5L1x75eS+43CDvWEl63Go6EulLapjyugW6F1OjkBduVA56Y09mzp2cCrWDNfdHU9uQgLm0BR1xyXFWsLO+Mc3U+jujsy/p58t5QqqOxzSFe2WXaLCIqdAlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(86362001)(52116002)(8676002)(6666004)(6506007)(8936002)(103116003)(66946007)(83380400001)(66556008)(508600001)(4326008)(2616005)(38100700002)(1076003)(186003)(26005)(54906003)(2906002)(5660300002)(6486002)(38350700002)(6916009)(36756003)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PI51jsMNHwdcu4LXXYP/SEogKXO5iIGDJV0td/RdRNWDT7lhTB4ypiJBogDn?=
 =?us-ascii?Q?gVVvkvK2B26tS1jCOfoZHh1tt89g0K6vQNXppSVZtqLkbXzL0/zOvI8p+CEX?=
 =?us-ascii?Q?yZPpqSRreDRoZ7PMAKVolHMVj2vzvUOmd7rviGZOckc1ATpmE2n9UVrrzpFM?=
 =?us-ascii?Q?OYTK/hMQ9jFyAufsbGOd/Gf2/VqXgcH9yqs0KhfsHzOKlZ3Odj3lxYqRZnWp?=
 =?us-ascii?Q?Ov9IftqTJG43jnrunNaNepAhkmrtvhSP07xCI8W0XoNF9Fb9eoW92ggaCuNo?=
 =?us-ascii?Q?G9XEv8EHe/WVjJXF7ypTAtS9LgdBQBOtZBPxCktHFRH7/fPWeIPTTwcuFii/?=
 =?us-ascii?Q?AbaOPbQWMlg12QKB2QdGpsczdHcm7SMcoVW6wmEAio101cmjV2yee19lKPnP?=
 =?us-ascii?Q?oBqZA3jdAnWHVMuj/IMMaYmKWHTs89+LeN9PO/wgmsKYEfD09hdtKFp3QZUX?=
 =?us-ascii?Q?VVk1u25c6B5VnxZnJUvSkrDFt2eDG3oDXU+iWhEwdCMXuxZZBZ6XwVlECV47?=
 =?us-ascii?Q?djoUEmUm0/wdlgy15GtrkLHcKppTiuTW5OHwxfwrJJwC9b9uHDKT2ngYrBR7?=
 =?us-ascii?Q?VxiJ9LL+5d7+jJX0LhfrMIFS4Z15uTW4TGqedgNVqMkHR5JLWl7o+iMe2s+d?=
 =?us-ascii?Q?DOqQpjtPVwupzbSXMNkjyG31hiKWuDjk02F64cZ1C0lu5zm8Wq/6R7t1sZtO?=
 =?us-ascii?Q?qndOIFFgFWt7vcotFc7s88/ywYY153xVLyzBWxQxtPWbgbxsnuOlZzwSH8B/?=
 =?us-ascii?Q?nw451ezrj3VGB1LJwpIURx+ihgZCb7lBFUw5z19XOQpALHqHe9IbVY7y+f6m?=
 =?us-ascii?Q?O3PNhPexhuZUO7YI8pDxTGZ/fS++RGSZJziNMehpT1D/okr+Bg0ZvewhL60t?=
 =?us-ascii?Q?Ros/7Na62bHPCMS9Y/6DHHQWKabi0ivqVEyAOLrhXMDEQLtBM//dN59ZDzZ4?=
 =?us-ascii?Q?Kp7z0KVgN/O09fAQHRrnhAi8SvfS2eMkGWmTNeCdk9PH1shj9mBFL6hbtsRV?=
 =?us-ascii?Q?zqVdqzsUhmRJhKx7dFQxs1QA6QcjpUUSHLdD1BylDjToyfz8cTL06GXWAU+f?=
 =?us-ascii?Q?1d7fazUkiepKAbtylYqnucNoJtcAYbmugbUiRgH3tCFhXDEqMnkfgPCWordj?=
 =?us-ascii?Q?OGnt6EllmQgNBIFC2DXgw6XbVFhAiOakCpTG70k9m4XtVvBoHkzCeUxbil8n?=
 =?us-ascii?Q?oybtJ4cwc0huccw95WYmRejQgOUa5T4yQKd8dZ8EnwJqn2QY1RibxAWxcPG/?=
 =?us-ascii?Q?oXXf4nD2LDwhsTzbdw056lrgeRv7OaQFgygXPNx/0SyNAIVoHwNWgOymJG2g?=
 =?us-ascii?Q?7+U8oFSYmJKWmmIWLuaFY4s1VdoDMhgmZOqF3W3ddO3x8QvOPWwIwW16GgHt?=
 =?us-ascii?Q?ymtT2+cF1RfXHIZfn+iSb7z+0as6RgAJWRqvl8FJGww/HA7mV/MENu3oSfwM?=
 =?us-ascii?Q?YXOnbHTYKQn/nBGVuuU41brIlKCKeJLs0wRJEOVLNYU/uBLLtrMbaibeCCHB?=
 =?us-ascii?Q?cfU/mONQcEdVdvMi3Avczb9z/W7mG8JaD5EfYHosB3LZzYwAIMsD8e7yhAJn?=
 =?us-ascii?Q?An6szCMbmpNGz82CbUqMoUtagE2wJCaoksIcLppNVHUIn/FxNhAmhJi5uWDU?=
 =?us-ascii?Q?arOAQ9nbJUkGbxPlgQvRK+puxI0TQez9y5eglID6UiY3X4pFMjjoJV5aQP3P?=
 =?us-ascii?Q?D5dZzg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58b7fc7-1df4-4f7b-8390-08d9ec21e2f1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:14:13.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CJnvUJsFpuYQcZ906AvswoKfQLuhhKepBRQiwXC0aUJpzrmuh/lEb9w4ig0+oCZ+QCxb02vzRwQu1Br7DAJiygeMauYSh3tcVAwbpT8ySM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4884
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090121
X-Proofpoint-GUID: x1zn8pvFdr8IKE0YJmCSrFwxKZ_djL33
X-Proofpoint-ORIG-GUID: x1zn8pvFdr8IKE0YJmCSrFwxKZ_djL33
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When notification starts/stops listening events from inode's children it
has to update dentry->d_flags of all positive child dentries. Scanning
may take a long time if the directory has a lot of negative child
dentries. Use the new tail negative flag to detect when the remainder of
the children are negative, and skip them. This speeds up
fsnotify/inotify watch creation, and in some extreme cases can avoid a
soft lockup, for example, with 200 million negative dentries in a single
directory:

 watchdog: BUG: soft lockup - CPU#20 stuck for 9s! [inotifywait:9528]
 CPU: 20 PID: 9528 Comm: inotifywait Kdump: loaded Not tainted 5.16.0-rc4.20211208.el8uek.rc1.x86_64 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.4.1 12/03/2020
 RIP: 0010:__fsnotify_update_child_dentry_flags+0xad/0x120
 Call Trace:
  <TASK>
  fsnotify_add_mark_locked+0x113/0x160
  inotify_new_watch+0x130/0x190
  inotify_update_watch+0x11a/0x140
  __x64_sys_inotify_add_watch+0xef/0x140
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

Co-authored-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Co-authored-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/notify/fsnotify.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index ab81a0776ece..1f314f85f4c1 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -127,8 +127,12 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 		 * original inode) */
 		spin_lock(&alias->d_lock);
 		list_for_each_entry(child, &alias->d_subdirs, d_child) {
-			if (!child->d_inode)
+			if (!child->d_inode) {
+				/* all remaining children are negative */
+				if (d_is_tail_negative(child))
+					break;
 				continue;
+			}
 
 			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
 			if (watched)
-- 
2.30.2

