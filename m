Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ACF6FE6DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 00:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjEJWGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 18:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjEJWGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 18:06:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C712C98
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 15:06:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50C141FD6B;
        Wed, 10 May 2023 22:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683756404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=nvCBjxqbiHcvAso3Nh2R5p/BgVsie/1wwqAWsy6cWsY=;
        b=OWtiWCILMezcBuCudAx8Ww/9NLgIl2xaa0DdEVwP0Vwp7LcjgTI109ephkXQH0F2sgV0aS
        GATGI0uZEQ4Au4vbRhQ1RKLf48YqQ42O0C+jARqdZ1AMf1arA9HUQMf2qTi0wwMJw/uKt1
        6YA4FRW4/eIuGcAkSmIdHYLPv6vD/Ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683756404;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=nvCBjxqbiHcvAso3Nh2R5p/BgVsie/1wwqAWsy6cWsY=;
        b=JZDp9zXbo09dsKqu6x14aUPGOZCarnXEdFNXZVLM1yn3KKboLPfaNVwBUgnIm+RG2ckyHK
        HMFr7nJuMgRdG5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1987513519;
        Wed, 10 May 2023 22:06:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YJErBnQVXGRxBAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 10 May 2023 22:06:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 38249A074D; Thu, 11 May 2023 00:06:42 +0200 (CEST)
Date:   Thu, 11 May 2023 00:06:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] inotify fix for 6.4-rc2
Message-ID: <20230510220642.4srw4ajhpbjzd7t7@quack3>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.4-rc2

to get a fix for possibly reporting invalid watch descriptor with inotify
event.

Top of the tree is c915d8f5918b. The full shortlog is:

Jan Kara (1):
      inotify: Avoid reporting event with invalid wd

The diffstat is

 fs/notify/inotify/inotify_fsnotify.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
