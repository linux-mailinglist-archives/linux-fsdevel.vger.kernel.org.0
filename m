Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F325854A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiG2Rkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 13:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiG2Rkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:40:51 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BAC13F4F;
        Fri, 29 Jul 2022 10:40:50 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:50536)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oHTyi-006isz-6z; Fri, 29 Jul 2022 11:40:48 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:39356 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oHTyg-0048ss-85; Fri, 29 Jul 2022 11:40:47 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <YuFdUj5X4qckC/6g@tycho.pizza> <20220727175538.GC18822@redhat.com>
        <YuGBXnqb5rPwAlYk@tycho.pizza> <20220727191949.GD18822@redhat.com>
        <YuGUyayVWDB7R89i@tycho.pizza> <20220728091220.GA11207@redhat.com>
        <YuL9uc8WfiYlb2Hw@tycho.pizza>
        <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
        <YuPlqp0jSvVu4WBK@tycho.pizza>
        <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
        <YuQPc51yXhnBHjIx@tycho.pizza>
Date:   Fri, 29 Jul 2022 12:40:39 -0500
In-Reply-To: <YuQPc51yXhnBHjIx@tycho.pizza> (Tycho Andersen's message of "Fri,
        29 Jul 2022 10:48:51 -0600")
Message-ID: <87h72zes14.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oHTyg-0048ss-85;;;mid=<87h72zes14.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18595RWFXCeZlQueTtAQx1O87M4ImD8yzw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1445 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 10 (0.7%), parse: 1.06
        (0.1%), extract_message_metadata: 12 (0.9%), get_uri_detail_list: 2.0
        (0.1%), tests_pri_-1000: 14 (1.0%), tests_pri_-950: 1.27 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 69 (4.8%), check_bayes: 68
        (4.7%), b_tokenize: 9 (0.6%), b_tok_get_all: 9 (0.6%), b_comp_prob:
        2.6 (0.2%), b_tok_touch_all: 44 (3.1%), b_finish: 0.81 (0.1%),
        tests_pri_0: 1318 (91.2%), check_dkim_signature: 0.68 (0.0%),
        check_dkim_adsp: 3.2 (0.2%), poll_dns_idle: 1.26 (0.1%), tests_pri_10:
        3.2 (0.2%), tests_pri_500: 10 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH] fuse: In fuse_flush only wait if someone wants the
 return code
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


In my very light testing this resolves a hang where a thread of the fuse
server was accessing the fuse filesystem (the fuse server is serving
up), when the fuse server is killed.

The practical problem is that the fuse server file descriptor was being
closed after the file descriptor into the fuse filesystem so that the
fuse filesystem operations were being blocked for instead of being
aborted.  Simply skipping the unnecessary wait resolves this issue.

This is just a proof of concept and someone should look to see if the
fuse max_background limit could cause a problem with this approach.

Additionally testing PF_EXITING is a very crude way to tell if someone
wants the return code from the vfs flush operation.  As such in the long
run it probably makes sense to get some direct vfs support for knowing
if flush needs to block until all of the flushing is complete and a
status/return code can be returned.

Unless I have missed something this is a generic optimization that can
apply to many network filesystems.

Al, vfs folks? 

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fuse/file.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 05caa2b9272e..a4fccd859495 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -464,6 +464,62 @@ static void fuse_sync_writes(struct inode *inode)
 	fuse_release_nowrite(inode);
 }
 
+struct fuse_flush_args {
+	struct fuse_args args;
+	struct fuse_flush_in inarg;
+	struct inode *inode;
+};
+
+static void fuse_flush_end(struct fuse_mount *fm, struct fuse_args *args, int err)
+{
+	struct fuse_flush_args *fa = container_of(args, typeof(*fa), args);
+
+	if (err == -ENOSYS) {
+		fm->fc->no_flush = 1;
+		err = 0;
+	}
+
+	/*
+	 * In memory i_blocks is not maintained by fuse, if writeback cache is
+	 * enabled, i_blocks from cached attr may not be accurate.
+	 */
+	if (!err && fm->fc->writeback_cache)
+		fuse_invalidate_attr_mask(fa->inode, STATX_BLOCKS);
+
+	kfree(fa);
+}
+
+static int fuse_flush_async(struct file *file, fl_owner_t id)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_flush_args *fa;
+	int err;
+
+	fa = kzalloc(sizeof(*fa), GFP_KERNEL);
+	if (!fa)
+		return -ENOMEM;
+
+	fa->inarg.fh = ff->fh;
+	fa->inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
+	fa->args.opcode = FUSE_FLUSH;
+	fa->args.nodeid = get_node_id(inode);
+	fa->args.in_numargs = 1;
+	fa->args.in_args[0].size = sizeof(fa->inarg);
+	fa->args.in_args[0].value = &fa->inarg;
+	fa->args.force = true;
+	fa->args.end = fuse_flush_end;
+	fa->inode = inode;
+	__iget(inode);
+
+	err = fuse_simple_background(fm, &fa->args, GFP_KERNEL);
+	if (err)
+		fuse_flush_end(fm, &fa->args, err);
+
+	return err;
+}
+
 static int fuse_flush(struct file *file, fl_owner_t id)
 {
 	struct inode *inode = file_inode(file);
@@ -495,6 +551,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	if (fm->fc->no_flush)
 		goto inval_attr_out;
 
+	if (current->flags & PF_EXITING)
+		return fuse_flush_async(file, id);
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
 	inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
-- 
2.35.3

