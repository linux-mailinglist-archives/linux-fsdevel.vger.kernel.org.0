Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4623158297D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiG0PVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiG0PVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:21:46 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30A13205F;
        Wed, 27 Jul 2022 08:21:45 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:50902)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oGir0-0090TO-Cz; Wed, 27 Jul 2022 09:21:43 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:43796 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oGiqx-00Dpqe-Sq; Wed, 27 Jul 2022 09:21:42 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     wangboshi <wangboshi@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Qinchao(OS Kernel Lab)" <qinchao15@huawei.com>,
        "Likun(OSLab)" <hw.likun@huawei.com>,
        <linux-fsdevel@vger.kernel.org>
References: <5e404aede1284bacbcd96fa180e4fdf6@huawei.com>
Date:   Wed, 27 Jul 2022 10:21:07 -0500
In-Reply-To: <5e404aede1284bacbcd96fa180e4fdf6@huawei.com>
        (wangboshi@huawei.com's message of "Wed, 27 Jul 2022 04:26:06 +0000")
Message-ID: <87fsimeg4c.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oGiqx-00Dpqe-Sq;;;mid=<87fsimeg4c.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18KXeXrD3pQyo27Lcl1OMlu3YCAANdc67I=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;wangboshi <wangboshi@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1966 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.0 (0.2%), b_tie_ro: 2.9 (0.1%), parse: 1.12
        (0.1%), extract_message_metadata: 9 (0.5%), get_uri_detail_list: 1.68
        (0.1%), tests_pri_-1000: 3.9 (0.2%), tests_pri_-950: 1.15 (0.1%),
        tests_pri_-900: 0.84 (0.0%), tests_pri_-90: 1603 (81.5%), check_bayes:
        1597 (81.2%), b_tokenize: 6 (0.3%), b_tok_get_all: 7 (0.4%),
        b_comp_prob: 1.81 (0.1%), b_tok_touch_all: 1578 (80.3%), b_finish:
        0.93 (0.0%), tests_pri_0: 333 (16.9%), check_dkim_signature: 0.41
        (0.0%), check_dkim_adsp: 1.97 (0.1%), poll_dns_idle: 0.17 (0.0%),
        tests_pri_10: 1.71 (0.1%), tests_pri_500: 6 (0.3%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: fs: An unexpected ACL pass
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Adding fsdevel where some of the people involved in the implementation
might see the question.

wangboshi <wangboshi@huawei.com> writes:

> Hi, everyone.
>
> We want to talk about a detail about ACL. In `acl_permission_check` function, when file modes don't contain any group permissions, the ACL check is bypassed. 
> ```
> static int acl_permission_check(struct user_namespace *mnt_userns,
> 				struct inode *inode, int mask)
> {
> 	unsigned int mode = inode->i_mode;
> 	kuid_t i_uid;
>
> 	/* Are we the owner? If so, ACL's don't matter */
> 	i_uid = i_uid_into_mnt(mnt_userns, inode);
> 	if (likely(uid_eq(current_fsuid(), i_uid))) {
> 		mask &= 7;
> 		mode >>= 6;
> 		return (mask & ~mode) ? -EACCES : 0;
> 	}
>
> 	/* Do we have ACL's? */
> 	if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
> 		int error = check_acl(mnt_userns, inode, mask);
> 		if (error != -EAGAIN)
> 			return error;
> 	}
>
> 	/* Only RWX matters for group/other mode bits */
> 	mask &= 7;
>
> 	/*
> 	 * Are the group permissions different from
> 	 * the other permissions in the bits we care
> 	 * about? Need to check group ownership if so.
> 	 */
> 	if (mask & (mode ^ (mode >> 3))) {
> 		kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
> 		if (in_group_p(kgid))
> 			mode >>= 3;
> 	}
>
> 	/* Bits in 'mode' clear that we require? */
> 	return (mask & ~mode) ? -EACCES : 0;
> }
> ```
> It causes that users or groups can get permissions by the other-permission bits even if ACL explicitly restricts that they have no permission.
> For example, we(1000) create a file and set its ACLs which give owner, user(2000), group(3000) and other all permissions with no mask permissions.
> ```
> $ echo data > test
> $ setfacl -m u::rwx,g::rwx,u:2000:rwx,g:3000:rwx,m::-,o:rwx test
> $ getfacl test
> # file: test
> # owner: 1000
> # group: 1000
> user::rwx
> user:2000:rwx                   #effective:---
> group::rwx                      #effective:---
> group:3000:rwx                  #effective:---
> mask::---
> other::rwx
> ```
> Let user(2000) and group(3000) access the file.
> ```
> $ sudo capsh --gid=2000 --uid=2000 -- -c 'cat test'
> data
> $ sudo capsh --gid=3000 --uid=3000 -- -c 'cat test'
> data
> ```
> We can see these successful accesses. It is unexpected. In contrast, according to the ACL access check algorithm described in POSIX 1003.1e draft 17 23.1.5 section, accesses should be denied, because user(2000) and group(3000) are explicitly specified by us and we restrict the permission of the specific users and groups via no mask permissions. And the getfacl tool tells us that all effective permissions of user(1000), group(3000) and owner group contain nothing too.
>
> What's more, if we add x permission to mask permissions, read accesses are denied. It's counterintuitive that we can do something with no permission and are denied with more other permissions.
>
> We want to trace the original of the design. We find similar implementations in earlier version where ext2 ACL was introduced. The design looks like an optimization, but it should base on an assumption that there is no other-permissions if no group-permissions. Is the assumption always valid?

Eric
