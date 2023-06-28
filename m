Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44527414BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjF1PS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjF1PSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:18:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E494A1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 08:18:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C9CE2185C;
        Wed, 28 Jun 2023 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687965502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=b8wrNdogjWfdAOHxAbXfqxRZnrWe0F5xRyACzYUD10M=;
        b=12tiIvVD2WWWxCr522DQvi3LFIVoKl2OkIZJxZiQmDwK6tS/djI7sOoxE26yzsf5ul9ys2
        uqBlvzZ/d0L+kTdO7+ZBKaRLZc9xcmeFfk2JXlp7mdve+9euGBpiZM+pj+UgGHAiLvKFNT
        epGlCVzvLEy+eQtdndhTczKQGasIEv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687965502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=b8wrNdogjWfdAOHxAbXfqxRZnrWe0F5xRyACzYUD10M=;
        b=zOPMLSttXizxxKiepyW4DasPiQ4tc+d58ij/jdbF8o2f3S6cjspnGzWPr9jt9LsS05n6oE
        WthQ2KAjNUsh/5DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D4C3138E8;
        Wed, 28 Jun 2023 15:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PEsfBz5PnGQQOgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 28 Jun 2023 15:18:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A7003A0707; Wed, 28 Jun 2023 17:18:21 +0200 (CEST)
Date:   Wed, 28 Jun 2023 17:18:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for 6.5-rc1
Message-ID: <20230628151821.2henh5bzlk77bytp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.5-rc1

to get:
* Support for fanotify events returning file handles for filesystems not
  exportable via NFS
* Improved error handling exportfs functions
* Add missing FS_OPEN events when unusual open helpers are used

Top of the tree is 7b8c9d7bb457. The full shortlog is:

Amir Goldstein (6):
      exportfs: change connectable argument to bit flags
      exportfs: add explicit flag to request non-decodeable file handles
      exportfs: allow exporting non-decodeable file handles to userspace
      fanotify: support reporting non-decodeable file handles
      exportfs: check for error return value from exportfs_encode_*()
      fsnotify: move fsnotify_open() hook into do_dentry_open()

The diffstat is

 Documentation/filesystems/nfs/exporting.rst |  4 ++--
 fs/exec.c                                   |  5 -----
 fs/exportfs/expfs.c                         | 33 +++++++++++++++++++++++++----
 fs/fhandle.c                                | 28 ++++++++++++++----------
 fs/nfsd/nfsfh.c                             |  7 ++++--
 fs/notify/fanotify/fanotify.c               |  6 +++---
 fs/notify/fanotify/fanotify_user.c          |  7 +++---
 fs/notify/fdinfo.c                          |  2 +-
 fs/open.c                                   |  6 +++++-
 include/linux/exportfs.h                    | 18 +++++++++++++---
 include/uapi/linux/fcntl.h                  |  5 +++++
 io_uring/openclose.c                        |  1 -
 12 files changed, 85 insertions(+), 37 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
