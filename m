Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3830F972
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 18:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhBDRTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 12:19:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38072 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbhBDRSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:18:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114H904I093139;
        Thu, 4 Feb 2021 17:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=oQaCgFr07ErL9O4RN7K+jvz+UJndRmk2E1Tydv/RO5A=;
 b=Pb+T2P3Nkn9Bfpt4FfzWwwGRqJ1siWLQDEhxpsAjrJUJTwaneCsg77gfhibw3+y3PLsi
 dFTMe5UD0qIa8VmFd2dpPaPSoujKAEyNCjAd6lmY3GYDszNuslS3/I5jFGczsftYPptB
 WhjwJ7yXtLMsjkW8dW/o0B7rdrpYlVLvFUFFmbfmnjb/IXl8uUdwxzDB55FE/+w6waWi
 pjvhhFmF/RzVD5x8XbMVZwHOqJBxt6F33NYYpeZzrJ7FgxGoLi2gcyyN+rQNJQeyJba3
 eFeUDz+/2vRAE8DFsWk3uoxDZkxDRF8P3JFdVKZT3rkcdWpH5HlEZP3/v3tQjAzdC+G5 pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydm69bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 17:17:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114HGKcI178161;
        Thu, 4 Feb 2021 17:17:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 36dh7veshe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 17:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsJ4LF6Qm+OikHOXSmatcHaxJT3gq+5mKP4ASwVhBCaG7264OPIWuMnKkqG3EA04W2d8CcFAqvpNcyVvHQM4hJLMF4wpE1rqLfSy/xt2ZpHEtCWAtLTiauAe5DPB2ztJn0WLoxBS8d2xZpcoOU1b1c11mkQu54hUz4YmWocUN/e22+aX+/bwKGdwafViNQQ1Ri8ni+NMkl+0XQsUjVAlNMunIfpJqd2NYZB3jI/qJODoIHNOunUVS7bFzb+1FagQLQKFGiyBOkMuoO1crStf1CVCVRbFVf56zCSr1U1tzAaecmu3WR+iBK0ceOXtpKVbrq3F7HwK3hux6xSd09kWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQaCgFr07ErL9O4RN7K+jvz+UJndRmk2E1Tydv/RO5A=;
 b=NWtKsuiP8oMiausQP0gVd138HgLo4i8EygiI1rJMfXNe8b5IqGLqZXktn1tpHU413q2SzIMAtW2vyzpWf493J3uXIEX/Yad05NGbYMMvZyFsS3yAgMZ3ALdpYcLqhcc7hn+8bVpGYHG16kbQqdrTMVT8wEELAdumxCOP8FyOVV566tkPSekYOjgsf+r+VIs8hrf7AUoDpWBC1o1gru2s8xKEiKEt1mxe3QsbqVp7a86nqBkYhvv7Y482k8yKkWOba0C+xjqforKxO/vaka6RG8IL5SmhzvZ/htKFUMkKZ8YSBV9Z/c7fFosFm/lRarPRFTz8DbjcBPEBVrNGy1Cx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQaCgFr07ErL9O4RN7K+jvz+UJndRmk2E1Tydv/RO5A=;
 b=WkQX7LmhCsGp7s4DbEtjnwN9Rs6QEpJHbzEsdfO8MSv8Jg9ujteWFKRybuWJqTgdyfA0GHTrzg+4sQFzMTwcI2BPgz7LihKFhxlG345K7Es0tDl4ocjXuqR1yxM9IZ8P339bMpZ9fvrCPeVUIQJlyeRXKnNXGsejwi3doMAklys=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.21; Thu, 4 Feb
 2021 17:17:40 +0000
Received: from BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::adef:30b8:ee4e:c772]) by BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::adef:30b8:ee4e:c772%3]) with mapi id 15.20.3805.029; Thu, 4 Feb 2021
 17:17:40 +0000
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
Subject: [PATCH RESEND v5] proc: Allow pid_revalidate() during LOOKUP_RCU
Date:   Thu,  4 Feb 2021 09:17:19 -0800
Message-Id: <20210204171719.1021547-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8301:1041::18]
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To BYAPR10MB2823.namprd10.prod.outlook.com
 (2603:10b6:a03:87::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8301:1041::18) by SJ0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:a03:2c2::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.13 via Frontend Transport; Thu, 4 Feb 2021 17:17:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aee1a8a5-3852-451a-0d54-08d8c930c6cd
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44326066F5E399ECBF798A1BDBB39@SJ0PR10MB4432.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6P5+uE8sXh4Eh57PWmhsUXELnh/vTCkKE3s9RKLD4UL5/mIKWJmM4nLu3u8rbEwb2tKXwczJFbggtl18Rr7WQSO9MEniR1soC1muJmDOF8P36YY2ekR3693A8R96g8qVAwzAbIAsjQK5KetZF9bODO86A4DfBrrc0Z1dpRc2n/Ow6mhmyEo7U0tSJmijbTgDezI/az7LgZpunKuCWDn1DIlrWgPErq80PKQJp2R0ORJFim4rpmRHG3cZiPyQ4b19jqBA2fyqKHR5JUzCjaoIbGwVLribWm+XoxHBOjnDbrYkTgICXG+KFMJhlP9DmGmcenewicKsIoSNFzhKCmIOmvlCJrEjbzevchJPZHnj2aAe4YfKH9Yud932uxQrNclDQ6wtm9CSAXeIU+3emHKVg4IKFJoLzhwEIs4/OstLSKR5ZRP7aQKOytVvQT0l3SveBZrS9sp69zm/m3W44j1FKy2GNMTP267V5kbTDRzTz7ACAS+zfW6nU0cFISPaGj5+CDCm80M6Krpe+ffTKa5Ogus4Yn3jDuwm9RNw6BqFDeDdp8qqQ4l63dhPVPffjjllPxRgFxapDA6HsAlvtGK53zl6d4ZnlPI5y8dh57E7IrjaqHhrSBOyBtYMSDOJqFEZNKy8lJY2D/gV5//ecxAHJfkZVLUy/0v70TkuTd9GkjS+3U0PaFEBe9DAUCiT7moeidgoIcHD+xAMackH6UMmDk7qLTWUKdT/QD031XpMmqUWtCO53JL1ng0N66zvlfgGgpNVS+fVvpsLV+JE6QO89ohWMw6lwoLdQRlvH09k29Je7l3GTqDl35n0vbi5SXTNbNQ8bg68Pa6t1mMT/Gq3KzOULfqBcQU9EmL1+XmhFaI/FUcAaVNaZeR6hnwGioyk0Y/VDIN+FVq2L8GBlIVVfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BYAPR10MB2823.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(396003)(136003)(346002)(376002)(39860400002)(366004)(6916009)(186003)(1076003)(36756003)(7416002)(5660300002)(8676002)(83380400001)(4326008)(103116003)(66556008)(66946007)(478600001)(16526019)(6666004)(66476007)(8936002)(2906002)(6486002)(316002)(86362001)(2616005)(6496006)(52116002)(54906003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: fEYb92sUECuqtaD59w26tbHEhJWmlnaU5gDHhp+O29hEV6wR7mDhLUH6ycB9VwJRXJronO1KOZyAvjDURZPFWKrsXLBaVmayXb8go3lxH2QKAv2Q6WIkMsDZga98HY40ZdKByeZ6hCnNjuzlnOo+P6eVsI2vEvONN56V+Og6KHS7qNnMtnCgKXkRQYatU0f4gqwT+UrI2/kziRnpXDB9Jm0P8ZMTYEu7TCOnwv7YIG/tlzIIh1jq40tdOsJRICRmNOjTw3GJhJo++ZNZqKVrUchoxJUvYfvs6/v9jUM4W5WtGJ/tEsQFX7xc00rT2YcC2BbCZwd0+/MFiM60Gla/PhKerbkTQ3g8fSUg79r9BOR2sbxm1ZJ8BrucO5PqcRobXWwLhRh4ZBxSxhExQeS3bxsPm4Pww8IeAdU3FfSyxGiPNNDWMRodmBc3hh71+aSn8aQCt1cOGVu6VDB1RfU0ICcFb86JOwP+FIoe1rT9BIPM2I/iR/x0qm7gGfqyF/1ulVsI1iDot/H1IJZh/fdKFr9OT0x/YVOO1OXqO3uD0r5L46g/UvTc70NNvDn01mLcwtD/kPgPlKMf3qmbsUWPvUxYB0uYj2Z6F7ulAzGvYZqPFC/VdiIq0PbsT1mH8oqoS7wh8Mgt+lyzXe4NlFMqeW+qg03vvOqNTbwv09MeNt3CpKgktk8HW4aTRU+w3exMfbZbM4AqHJPKM7kHUQkkq/q34vJ4HMZV8NIBuRs+SL+RMXoZki+p9I+h9IbJ5higVUmEkSRXr4KID8yU2inxfg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee1a8a5-3852-451a-0d54-08d8c930c6cd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2823.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 17:17:40.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/I1QOzgMxq9i2xz3m+2GkrSOOMpiiPVsc6FH/9fPv6Q+BecahQJLu4+c1w2UZEUGmh4alYJi/QnPpQfdWsUhhrwuYbyqUmsH6W4ftbQki8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040106
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040105
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

