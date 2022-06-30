Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8345856163E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 11:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiF3JXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 05:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF3JXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:23:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F8C32050
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 02:23:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3155B1F9F2;
        Thu, 30 Jun 2022 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656581022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=516uJ3tZmX7krPAiZrfKar/CI7p/G/D5WqPmnjQ7zDo=;
        b=C/sgRIVW3g0WGyh2YoXlFRR7pShuHG+synIJGd1G0Y4A9Xkgsld/sraeX4JeLcWxW4XWgQ
        KntOgk33YsS4KNd/k5p9EeWAG2glNRs7KbeGhoBNLRYSi/Nlfk+LW2HrfgzRHq8vsmE8iK
        9UeJLgxCtpaSEfHKZ3qQ3//jrWpD+Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656581022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=516uJ3tZmX7krPAiZrfKar/CI7p/G/D5WqPmnjQ7zDo=;
        b=4291nSw4leszMNl+69kp7L3xckj9DUm2fZ5UfCuirQZj/MizDa3kVqn3+ZGb5CHCgjNDy0
        A1vhXfxzM12//CBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 227E12C142;
        Thu, 30 Jun 2022 09:23:42 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BC346A061F; Thu, 30 Jun 2022 11:23:41 +0200 (CEST)
Date:   Thu, 30 Jun 2022 11:23:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fanotify fixup for 5.19-rc5
Message-ID: <20220630092341.qseqfhjgcndaupns@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.19-rc5

The pull contains a fix for recently added fanotify API to have stricter
checks and refuse some invalid flag combinations to make our life easier in
the future.

Top of the tree is 8698e3bab4dd. The full shortlog is:

Amir Goldstein (1):
      fanotify: refine the validation checks on non-dir inode mask

The diffstat is

 fs/notify/fanotify/fanotify_user.c | 34 +++++++++++++++++++---------------
 include/linux/fanotify.h           |  4 ++++
 2 files changed, 23 insertions(+), 15 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
