Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1398069AA5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 12:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBQLaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 06:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBQLaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:30:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27748656BE
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 03:29:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB20622752;
        Fri, 17 Feb 2023 11:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676633379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=BnC9TtMt/gcKFvA8VlNcVY9WJKZvqy97UDpbINZB5z8=;
        b=EixBahnoAqIEh73fqnVlO1Rr4v0iG6UcFpusMl6FxVLlvk2zVsNokcqRJmrq079fSci94u
        LfF/XL/uXyaRVPSIfmqTsPhd8mS85utM0U1auLdb1kyix+rqxV++/KJOGitVfTg6c4Ai/J
        q9RSPhVa/+k81zybxvhmhUTZrFMSHIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676633379;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=BnC9TtMt/gcKFvA8VlNcVY9WJKZvqy97UDpbINZB5z8=;
        b=ULO6VcdpKaIOGGqUtgSV/SklmyozRBtw6lXy4KfAZlCsLvbiW5B6DicBUx9EXjC1hLmGe1
        mWVZI2F49Kv1P0Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 967A5138E3;
        Fri, 17 Feb 2023 11:29:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O2GvJCNl72NkSwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 11:29:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1AF3BA06E1; Fri, 17 Feb 2023 12:29:39 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:29:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for 6.3-rc1
Message-ID: <20230217112939.daimrvd7uivov5eu@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  since I'm on vacation next week I'm sending my pull requests for the
merge window a bit earlier. Could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.3-rc1

to get support for auditing decisions regarding fanotify permission events.

Top of the tree is 032bffd494e3. The full shortlog is:

Richard Guy Briggs (3):
      fanotify: Ensure consistent variable type for response
      fanotify: define struct members to hold response decision context
      fanotify,audit: Allow audit to use the full permission event response

The diffstat is

 fs/notify/fanotify/fanotify.c      |  8 +++-
 fs/notify/fanotify/fanotify.h      |  6 ++-
 fs/notify/fanotify/fanotify_user.c | 88 ++++++++++++++++++++++++++++----------
 include/linux/audit.h              |  9 ++--
 include/linux/fanotify.h           |  5 +++
 include/uapi/linux/fanotify.h      | 30 ++++++++++++-
 kernel/auditsc.c                   | 18 ++++++--
 7 files changed, 131 insertions(+), 33 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
