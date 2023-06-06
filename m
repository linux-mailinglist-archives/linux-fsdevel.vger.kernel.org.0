Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E5723E7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbjFFJ4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbjFFJ42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:56:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38C1E4F
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 02:56:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A7F381FD69;
        Tue,  6 Jun 2023 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686045385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iOIpsoLLoIqNNpFPjp/fwViiba/oSVl/szkAoa7GUac=;
        b=rkw/7HkS8KOqcVwYTAZ0cwYiXqf1zSed+NFAsEhONAr6/pXsL0f7bwjsGYFXd827vAejpt
        Ju7DXxPg3OlRqmLGvMUjPNtYiWd5i0pqRyKe9ql0oJb8sHi96e7BM9QVJmt/X7wJtKrYY8
        j8kHqTgG9aoHBfs0lVH7j1ES5hf8Mes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686045385;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iOIpsoLLoIqNNpFPjp/fwViiba/oSVl/szkAoa7GUac=;
        b=mvDr3XDt8LYUd/Cdjh1uA2i4aHWyN7XIBP8MzQ5NNgw8mrraHgZNlY7BjeLNU7XxoO/G2q
        BKE9SvkFchXXxpBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AC8C13519;
        Tue,  6 Jun 2023 09:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dYXAJckCf2R/YgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Jun 2023 09:56:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1E581A0754; Tue,  6 Jun 2023 11:56:25 +0200 (CEST)
Date:   Tue, 6 Jun 2023 11:56:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [bug report] fs: Restrict lock_two_nondirectories() to
 non-directory inodes
Message-ID: <20230606095625.zowqbpfi7hktfbwh@quack3>
References: <ZH7vNQSIVurytnME@moroto>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikfgebcr72mdsmf4"
Content-Disposition: inline
In-Reply-To: <ZH7vNQSIVurytnME@moroto>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ikfgebcr72mdsmf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 06-06-23 11:32:53, Dan Carpenter wrote:
> Hello Jan Kara,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch afb4adc7c3ef: "fs: Restrict lock_two_nondirectories() to
> non-directory inodes" from Jun 1, 2023, leads to the following Smatch
> complaint:
> 
>     fs/inode.c:1174 unlock_two_nondirectories()
>     warn: variable dereferenced before check 'inode1' (see line 1172)
> 
>     fs/inode.c:1176 unlock_two_nondirectories()
>     warn: variable dereferenced before check 'inode2' (see line 1173)

Indeed, thanks for spotting this! Luckily there are currently no in-tree
users passing NULL. Attached patch fixes this. Christian, can you please
add this to your branch or squash it into the fixed commit? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--ikfgebcr72mdsmf4
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fs-Fixup-unlock_two_nondirectories-for-NULL-inodes.patch"

From 4afde047fb4408553b9d2c548ebe355db7c95f0f Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 6 Jun 2023 11:52:33 +0200
Subject: [PATCH] fs: Fixup unlock_two_nondirectories() for NULL inodes

When inode is NULL, we cannot WARN on S_ISDIR(inode->i_mode) as that
would be a NULL ptr dereference. Move the warnings below the NULL
checks.

Fixes: afb4adc7c3ef ("fs: Restrict lock_two_nondirectories() to non-directory inodes")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index e2707ee88459..53ae3b76d232 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1169,12 +1169,14 @@ EXPORT_SYMBOL(lock_two_nondirectories);
  */
 void unlock_two_nondirectories(struct inode *inode1, struct inode *inode2)
 {
-	WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
-	WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
-	if (inode1)
+	if (inode1) {
+		WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
 		inode_unlock(inode1);
-	if (inode2 && inode2 != inode1)
+	}
+	if (inode2 && inode2 != inode1) {
+		WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
 		inode_unlock(inode2);
+	}
 }
 EXPORT_SYMBOL(unlock_two_nondirectories);
 
-- 
2.35.3


--ikfgebcr72mdsmf4--
