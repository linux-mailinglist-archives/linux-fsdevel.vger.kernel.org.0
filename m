Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D6474B10E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 14:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGGMlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 08:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGGMlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:41:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E21BF4
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 05:41:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 307F7218DF;
        Fri,  7 Jul 2023 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688733693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=FKZflhIKDb+EW/SUmn/J99mkdlUqwtCnQNrybGexVEM=;
        b=pZ3S/vx3m56H/vVkgfXG0Fslo8oJA1GtlFHNI1rsH+TTTOnLqf/52F3IZBX/siW6hZ4MCY
        4MO7yRrSP9+0fsabXvLsBewwKfaUwkfr0ckc0NZj6mhCjJqMOcAqBkeSauP23yFk80Amcv
        ESQk8dhKqYu8Zs7tM1XjmlKDy1mpL6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688733693;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=FKZflhIKDb+EW/SUmn/J99mkdlUqwtCnQNrybGexVEM=;
        b=XSFufVJg/8vQ3UbehHxxblo+Bue/mELM6G7rZjEsMOxveBSI7o3+skXmpLoEzVZiqZfUxe
        jO4Fdwvb0PaZxqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D19F139E0;
        Fri,  7 Jul 2023 12:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p9cAB/0HqGQtQAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 07 Jul 2023 12:41:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8327FA0717; Fri,  7 Jul 2023 14:41:32 +0200 (CEST)
Date:   Fri, 7 Jul 2023 14:41:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: [GIT PULL] Fsnotify fix for 6.5-rc2
Message-ID: <20230707124132.ixcwe6xhelmauh3h@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.5-rc2

to get a fix for fanotify to disallow creating of mount or superblock marks
for kernel internal pseudo filesystems.

I'm sending the pull request early because I want to get the fix merged
for this cycle and I will be on vacation with my family for next three
weeks. Amir will be taking care of fsnotify subsystem during that time if
anything comes up.

Top of the tree is 69562eb0bd3e. The full shortlog is:

Amir Goldstein (1):
      fanotify: disallow mount/sb marks on kernel internal pseudo fs

The diffstat is

 fs/notify/fanotify/fanotify_user.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
