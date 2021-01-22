Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965DD30108D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 00:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbhAVXCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 18:02:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56876 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbhAVXBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 18:01:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MMt2f1046469;
        Fri, 22 Jan 2021 22:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=oQaCgFr07ErL9O4RN7K+jvz+UJndRmk2E1Tydv/RO5A=;
 b=klwpE54CCpcZiLNZyl/yZIZY4JbUwqoKRUyxSv0qRtdGwFVuExUpof/cQXGCZBAbD8DP
 +rvFOW/sMJUGNXeKdVIAin8RWYJXER/Bph6n1dv8Bvbg4TRcxEdgMvKq50IlgHqx5WK+
 Ta32cIX5h+bZbtPn+o9G3gPEPxmpQWGUyEp3RbSBo/004Mq7Ma9vujU6KSjOTz+BMr7V
 zgGD4smOVys91hu9cvX4MsKSi/cF8Vgdj/ZCpi2ZvFaqFZLJNchhaxezWDvg+Nbtx0Bx
 tjZ7hwgyswZU/3ZOcjyVEPw5imnnhBIETNZ6HNJEUIs2QrrtKT51FssbrOw+97YasgMF 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3668qn6j2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 22:59:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MMxrpg103184;
        Fri, 22 Jan 2021 22:59:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3668rhjuse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 22:59:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdhG3XYkR+Hx/ot9r6c86kiN5pT7JkACLblPIzFgRB+KkbdBP0jjkjWUzGQBLZsBES7r93x1KgNYUJPSRWUD8VECLPH296RVV/+p9cA4Vm61Cd04iJC1/HA031sPCvb27yt2iB1DtJbqe0qMQ0koLE8XkgbhBFpX8fv1tmIojzuu8rR9cXL1tJaOnktLZICnCt6lYPTbCH+/ahu8XlK4manDC4V61Tdh+IkDMkzfUDCj5XzMxkL8YnZgwkP+EOWcxSais4Vea0iemvxAfNFLla5W1gOjXMZOckssjlJdHNUM/XNuxnAXSngwjla+70OqHRC/UWe0jpNJvtnclOcGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQaCgFr07ErL9O4RN7K+jvz+UJndRmk2E1Tydv/RO5A=;
 b=Fo89Nxp7ua7oOWTotdeKdasEw63bemk7Sfd8qGopzrUn5NXi2V47ED1HXR2NlQUS9ZN2J30xhP7OuMJrpvidubT3IsyzJPGloqVxMLQ84ZKpoWYzLWdjj9ixACOfsCMB4Mrk8t40nlNNpdrftaklcrxRZur5fQbhq9DeVFUDxFKX8yMNNymN/7nv4pQ4BeA8S/6nwjzHl8XyYSn9CjLvJSOkkLWVBg6rFy+8/T24JK6lmNqhPdwZkWVsF5c/jDwQLCHn51+PHHDG8LIRoagpH6OjQj8ODpG6L41Yfd+tEOASist85lyHpejoP9PbxEjLUNMB0PxV4hKAJmjMNS27vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQaCgFr07ErL9O4RN7K+jvz+UJndRmk2E1Tydv/RO5A=;
 b=xIKV6N2nvqrZpVvT3QPe2z/r6jIp2tv/L1ux7QIzTy9BMBswwMiL7jQTgMex1kMJxCxqF8RjclW/0dkMN7cECvisklMqxPPUAF4gwhEQKWgoFcmyXzouIqT+uVOY7ILdgwR8s5pGvfMMZtCqUvrLEnvj9cgBgKjWF6Dqx31FNlY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 22 Jan
 2021 22:59:40 +0000
Received: from BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::adef:30b8:ee4e:c772]) by BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::adef:30b8:ee4e:c772%3]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 22:59:40 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5] proc: Allow pid_revalidate() during LOOKUP_RCU
Date:   Fri, 22 Jan 2021 14:59:25 -0800
Message-Id: <20210122225925.152845-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8301:1041::19]
X-ClientProxiedBy: DM5PR21CA0062.namprd21.prod.outlook.com
 (2603:10b6:3:129::24) To BYAPR10MB2823.namprd10.prod.outlook.com
 (2603:10b6:a03:87::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8301:1041::19) by DM5PR21CA0062.namprd21.prod.outlook.com (2603:10b6:3:129::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6 via Frontend Transport; Fri, 22 Jan 2021 22:59:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb15d148-8317-4375-2acf-08d8bf29664e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4736:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4736253D790D09FA7B5358E3DBA09@SJ0PR10MB4736.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScVXhR/da4R1jzBkb1aKX/bVOIr6VB3dFC55MDL5asnAHzs7jx7GgX2FIkfvGaD1p5EmDcpGKpBCoNVAC/6Oa1pyhEIjO+wC6RM0BOU2j75QS/gaVD2ADv3ta2xafVb5JB0u3Ux+H2EFBjuUoVPzASDMaHzIJuCVs17iNISLewYiI+Kj+v/lUBENO0+HbQzRszFw+9eDVQlEYdEdKvu6ACMkTHusUMOC53b+2KIfdloN6H+4sqP5v8Z9egxVau0HfCZencTmgyobA0gUbSfpA1nbQSrNcoTxaDmMrsaJgRfVTHWzmsoYbsCNRz27NO/haN4qxFYEH4TwcrbuBas8G4/dXQl6bHyRP+sFlWAfR1DNfMcVHyunpwoF3xAlo719pzReZvTcU+bb/m19wQnvC3MX+lbn7W8qkhdDVOWFC/Aei43IN80FPwrLvPuVsMQT0QUlkAbtJODbDueq/DMpEA9xptB3SwUsHV3M13XA/d6FP/4rqP4pSER99Vod6x/9MZumpKA05JcnTkgLQFZwAsVo5ioz1Ts2Mvz/t1Ujzujw8+7l1qfwhVEAJ/WAnkWuOK4BTEWg2j2S6vKCN4YYm7ah27ZIb9Y8zkC5seGR+kyRx9N86RXcVEc8/RSRr0cJbIizjZwyTkfql0HhYWCIBNu2ss3AgE2Fyl8qM5UsH2+xX1SSi95CgfTIKAOfKOba2fDrGlCQOJ/BwXsaNzIcWoULl/UoFoOO+x5/XpK+Vc5CrDUmjHXXQbn/1OSr7RXoqF1UheryGy57P24XCPyD4Yrc6HWd20J7kmERroC6aSKX67c4Oj3Q2nUryOvr1jyO05h7x4oe9WnvwYhZxFsQjZE1dW/MKsU2lYnDvLlB2fXz9xlCKscyZTTurxKvv6+L36ATTIzR9BcAsz/pilYv7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BYAPR10MB2823.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(136003)(39860400002)(396003)(376002)(346002)(66556008)(186003)(66476007)(36756003)(16526019)(478600001)(2616005)(103116003)(6666004)(86362001)(7416002)(1076003)(66946007)(6486002)(2906002)(6916009)(8936002)(316002)(83380400001)(54906003)(4326008)(8676002)(52116002)(5660300002)(6496006)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GZUcjLCVY64VMDTeSOrk3T+OK7Y9YB+OFVVQPu4vyGBRghAQZjoPExRoEazi?=
 =?us-ascii?Q?0L56XLIu2F0fCD4BgM+7T6BE2m6M0rP5tK+ntX2wZyeJ7buF/Pzs235K/Q2Z?=
 =?us-ascii?Q?mwvU16/VGccBYtl2ZcUcbho96TbURggBLRWpcS+6zpFyLjHuYZaw84wz1OpL?=
 =?us-ascii?Q?AnuA1KZ9+8PJMUMUi4UXRPNwWvgNgwg1MXRcN21ioK0B/hhcywZh60LBdfqs?=
 =?us-ascii?Q?E/7umnO3sAs+nH5XALDbZov4m+u7yuD/mTSvUee/vzmWtahx0Cv67bY9+7Hm?=
 =?us-ascii?Q?4k0LaqDrfq444A5CwMcgZ7zJyUbjhWe2fchvr1BJAzhK92Xg3UNCYJ7o7e1n?=
 =?us-ascii?Q?Q/lof4s8u1FBdPccPN3wbwEXgWzyBQtpWrF96G0/mbqrw4d7TLI+1bR6+uYT?=
 =?us-ascii?Q?XREcRZq3VD8P0O/PNZgxwZDujHAw5TQeEauG9bjGY72PK/eE6A8kD8a7IaCt?=
 =?us-ascii?Q?OJEhuveEeMCB/e8n1qSqCHNxkkN7jQeIyGDk9d+30mJzrmSPcSjEaVt2iOkF?=
 =?us-ascii?Q?32X4/YfHw4+0RMxruxoHTwcRzUHEW5mP5hk5kTEPKYZalmA289Ld7A4uoTaf?=
 =?us-ascii?Q?t1qfoAOp/WrbsrCKUszr9vVETS4u4LM4HOGqCOBm34pI+0YjkK0IwZV0AvH+?=
 =?us-ascii?Q?tuNfWShXIbTX8v+ASt1MA8phP5SudI966woHPq4MfI7l9blFvKoyvaASnldx?=
 =?us-ascii?Q?0byxpfEeiwy+mOerifPueehw05jGpjDCem4b/0kaC+N4T48NkhEwnwka9h+n?=
 =?us-ascii?Q?heJ7e3PB/E8bq+Tt1dOUEgA96wseimidmqKRbfyzPxAPUOXG5T7owznyE5qJ?=
 =?us-ascii?Q?Ju7bvWr8zeRUdxwL5NvP9DlmBkNDB6uyK8RcCkVQQcdC9c10TAA73TYdXfmw?=
 =?us-ascii?Q?0Uxkseyjbdup8iYJczhGY3zWde3XZkVR6yQVVpakflcNAQcuSvIIPQ2TUAyk?=
 =?us-ascii?Q?0ckvkeL4yCftzGKfPvqJ+ml0dwKGweFUHBgldgUqxByb/lE/ljFQ7IArNE9e?=
 =?us-ascii?Q?EqER3e6PbTJDx0NIJjnyLm+I0OM6lsPSrU/fcal/CEJHBhgdONlDw+80t8Vx?=
 =?us-ascii?Q?DLXOQoz9w5+zW3foSxFDvuPQJUfF0Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb15d148-8317-4375-2acf-08d8bf29664e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2823.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 22:59:40.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ya2K5TzOyB1LcdrrrCv63hjUS0sxHzfHjn9JwvJpxq2v3ss/5DC5XqEdA39W3+ZlXcReUB1+7fos6Cv69hyR5ZvsvvbPlDbmipbgzSSY3Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220119
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pid_revalidate() function drops from RCU into REF lookup mode. When
many threads are resolving paths within /proc in parallel, this can
result in heavy spinlock contention on d_lockref as each thread tries to
grab a reference to the /proc dentry (and drop it shortly thereafter).

Investigation indicates that it is not necessary to drop RCU in
pid_revalidate(), as no RCU data is modified and the function never
sleeps. So, remove the LOOKUP_RCU check.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

When running running ~100 parallel instances of "TZ=/etc/localtime ps -fe
>/dev/null" on a 100CPU machine, the %sys utilization reaches 90%, and perf
shows the following code path as being responsible for heavy contention on
the d_lockref spinlock:

      walk_component()
        lookup_fast()
          d_revalidate()
            pid_revalidate() // returns -ECHILD
          unlazy_child()
            lockref_get_not_dead(&nd->path.dentry->d_lockref) <-- contention

By applying this patch, %sys utilization falls to around 60% under the same
workload. Although this particular workload is a bit contrived, we have
seen some monitoring scripts which produced similarly high %sys time due to
this contention.

As a result this patch, several procfs methods which were only called in
ref-walk mode could now be called from RCU mode. To ensure that this patch
is safe, I audited all the inode get_link and permission() implementations,
as well as dentry d_revalidate() implementations, in fs/proc. These methods
are called in the following ways:

* get_link() receives a NULL dentry pointer when called in RCU mode.
* permission() receives MAY_NOT_BLOCK in the mode parameter when called
  from RCU.
* d_revalidate() receives LOOKUP_RCU in flags.

There were generally three groups I found. Group (1) are functions which
contain a check at the top of the function and return -ECHILD, and so
appear to be trivially RCU safe (although this is by dropping out of RCU
completely). Group (2) are functions which have no explicit check, but
on my audit, I was confident that there were no sleeping function calls,
and thus were RCU safe as is. However, I would appreciate any additional
review if possible. Group (3) are functions which might be be unsafe for some
reason or another.

Group (1):
 proc_ns_get_link()
 proc_pid_get_link()
 map_files_d_revalidate()
 proc_misc_d_revalidate()
 tid_fd_revalidate()

Group (2):
 proc_get_link()
 proc_self_get_link()
 proc_thread_self_get_link()
 proc_fd_permission()

Group (3):
 pid_revalidate()            -- addressed by my patch
 proc_pid_permission()       -- addressed by commits by Al
 proc_map_files_get_link()   -- calls capable() which could audit

I believe proc_map_files_get_link() is safe despite calling into the audit
framework, however I'm not confident and so I did not include it in Group 2.
proc_pid_permission() calls into the audit code, and is not safe with
LSM_AUDIT_DATA_DENTRY or LSM_AUDIT_DATA_INODE. Al's commits[1] address
these issues. This patch is tested and stable on the workload described
at the beginning of this cover letter, on a system with selinux enabled.

[1]: 23d8f5b684fc ("make dump_common_audit_data() safe to be called from
     RCU pathwalk") and 2 previous

Changes in v5:
- Al's commits are now in linux-next, resolving proc_pid_permission() issue.
- Add NULL check after d_inode_rcu(dentry), because inode may become NULL if
  we do not hold a reference.
Changes in v4:
- Simplify by unconditionally calling pid_update_inode() from pid_revalidate,
  and removing the LOOKUP_RCU check.
Changes in v3:
- Rather than call pid_update_inode() with flags, create
  proc_inode_needs_update() to determine whether the call can be skipped.
- Restore the call to the security hook (see next patch).
Changes in v2:
- Remove get_pid_task_rcu_user() and get_proc_task_rcu(), since they were
  unnecessary.
- Remove the call to security_task_to_inode().

 fs/proc/base.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..3e105bd05801 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1830,19 +1830,21 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	struct task_struct *task;
+	int ret = 0;
 
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-
-	inode = d_inode(dentry);
-	task = get_proc_task(inode);
+	rcu_read_lock();
+	inode = d_inode_rcu(dentry);
+	if (!inode)
+		goto out;
+	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 
 	if (task) {
 		pid_update_inode(task, inode);
-		put_task_struct(task);
-		return 1;
+		ret = 1;
 	}
-	return 0;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 static inline bool proc_inode_is_dead(struct inode *inode)
-- 
2.27.0

