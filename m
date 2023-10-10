Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63D57BF740
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjJJJZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJJJZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:25:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49C193;
        Tue, 10 Oct 2023 02:25:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 475495C028D;
        Tue, 10 Oct 2023 05:25:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 10 Oct 2023 05:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1696929950; x=
        1697016350; bh=ETNAk+cmNQvtBbCMDyx7O4aQl9NCuOdk+MTBq0tOexg=; b=L
        aGGhGdX5jIFgCzgfyckJUhI8YK/Et3BZ0mlCFi6Tr6ffEiEisO4BFs5X/pR1SkPM
        r9vPdvH79Bz4jCxqYMmrPoz08G2eBT9S7A5sKpHnzC6DUrEjpxhpJMkeJZQ7eWeP
        QcL4jFP2Ak27f5DxCR4+YMGsm0GX1rpzgfEN5Y6A+3ZXL3FFDQrVv9HvHZjAYIj7
        RGC1vCI6gYiIlR43NJXQaPWqbtv4xf29h4Uw+P8w84PGZFYwBqtaYYdxTjnOKuXp
        SdoEfo5UsEfTxNeiRfPclV4tNRboGPk9Q7srCOFCIGdH0hh/zMqUUh+qOVuj29kY
        mRCZUWcOMCe+JcJJQZpow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1696929950; x=1697016350; bh=E
        TNAk+cmNQvtBbCMDyx7O4aQl9NCuOdk+MTBq0tOexg=; b=XFjf2JnJhJ1GbV5vc
        +eMSlrjXafQ2TZOtYl8sBSbg/1WWcYpkZ8PUSt2NygDUVWlrbP1EJ1CvWlftaRKn
        c2xMxeVFFfWZKST3RQF5KIs4AIOQKZtZsegzc+hyPq7lNgfuq+jVE7HsXqFQHxg+
        WVNU2kMt8vm+DaznzASv3x1P/7tVkq8gHhPi3ZQ7T+iYWLAZxakgfCgV9WtHEbjB
        9PEuen+DEk3gRarytbRIAYEhGCYVsaLnEKhKnVd/9YRsbkvwCF7fWPcIXE6NKG2B
        1M9ZJxIrkSWexAqysW91i0zEvrqV6XMnCtJRs5wu02/iIkMGPPxq7JgB8Npz8CSm
        qx14w==
X-ME-Sender: <xms:nRglZReI3jaSIZbcXScNtFd9-157EsnZmmbZaHcw55BCsAgZoKBOyA>
    <xme:nRglZfO3LvpFfvBy_bMwJe2cqBPpbfCXfcgsPDM-TiykMzvy4F7o6jDoLspp4-hHr
    Y7MtO7FglBNSmH2QQ>
X-ME-Received: <xmr:nRglZaj8jMQQ95RfnBxDcyGRbmEnEtJ1gC-Jh0DI5N8NlJZRQ3hOrZZH-oONUc7N7IKltpNKrLH1_z0KcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepjeefhe
    ffheejjefgtdffteektdfgfefgfeejgeffkeejjeegtdevjeelheellefhnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrg
    drihhs
X-ME-Proxy: <xmx:nRglZa_vyTq4lMmqhumyZ_gY9O9ArkhfjxUQ51jGyTYkg6htpvp9oA>
    <xmx:nRglZdsL6mjcPF1-mSy2iCL3A8ts61Oc33OoT4QedBa1GWWV0ei6dQ>
    <xmx:nRglZZFqGEuXUnFrminNouu4j9xdiB1iFwP6Wd2qtQyo_j7CQwJWhg>
    <xmx:nhglZRghaqEpfS22ubj-dZcaWuqGscv92J1AXtMm-ogFbodKarsBgg>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Oct 2023 05:25:49 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
        id D7E29E9F; Tue, 10 Oct 2023 09:25:46 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] exec: allow executing block devices
Date:   Tue, 10 Oct 2023 09:21:33 +0000
Message-ID: <20231010092133.4093612-1-hi@alyssa.is>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As far as I can tell, the S_ISREG() check is there to prevent
executing files where that would be nonsensical, like directories,
fifos, or sockets.  But the semantics for executing a block device are
quite obvious — the block device acts just like a regular file.

My use case is having a common VM image that takes a configurable
payload to run.  The payload will always be a single ELF file.

I could share the file with virtio-fs, or I could create a disk image
containing a filesystem containing the payload, but both of those add
unnecessary layers of indirection when all I need to do is share a
single executable blob with the VM.  Sharing it as a block device is
the most natural thing to do, aside from the (arbitrary, as far as I
can tell) restriction on executing block devices.  (The only slight
complexity is that I need to ensure that my payload size is rounded up
to a whole number of sectors, but that's trivial and fast in
comparison to e.g. generating a filesystem image.)

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 fs/exec.c  | 6 ++++--
 fs/namei.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6518e33ea813..e29a9f16da5f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -148,7 +148,8 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	 * and check again at the very end too.
 	 */
 	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
+	if (WARN_ON_ONCE((!S_ISREG(file_inode(file)->i_mode) &&
+			  !S_ISBLK(file_inode(file)->i_mode)) ||
 			 path_noexec(&file->f_path)))
 		goto exit;
 
@@ -931,7 +932,8 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	 * and check again at the very end too.
 	 */
 	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
+	if (WARN_ON_ONCE((!S_ISREG(file_inode(file)->i_mode) &&
+			  !S_ISBLK(file_inode(file)->i_mode)) ||
 			 path_noexec(&file->f_path)))
 		goto exit;
 
diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..60c89321604a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3254,7 +3254,7 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 		fallthrough;
 	case S_IFIFO:
 	case S_IFSOCK:
-		if (acc_mode & MAY_EXEC)
+		if ((inode->i_mode & S_IFMT) != S_IFBLK && (acc_mode & MAY_EXEC))
 			return -EACCES;
 		flag &= ~O_TRUNC;
 		break;

base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
-- 
2.42.0

