Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6EC5F7837
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJGMsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 08:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJGMsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:48:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A9DF473E
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 05:48:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2884218F8;
        Fri,  7 Oct 2022 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665146914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=5+NH8NdNs8w6shgUyx8gIAwBfzBFfqJUDCwaM+gIF8E=;
        b=CVaH6bjgNi6Vd/NfAfGMVcZ2pzVFNPF4fMSqOnEhz3CoKFG3/zUjBFsUkwMbzIpMSLziqF
        OX6hv8KMMLWdXjeMKAub3RrnPI1WBoc1ZULE+APNrwFkyy9HSShvc5Ck6l2bwSSGVOyAA7
        8QQQ3GTsZfIsPpLf6tVV+S6Xqnpps8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665146914;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=5+NH8NdNs8w6shgUyx8gIAwBfzBFfqJUDCwaM+gIF8E=;
        b=IR57zf6CIsmZz2YM28WCRWZPVMNwfRfVVWEHaC7ZGjm7St4adQ1ptsk11n9UxG/Q8SLXbE
        A3oevJVfj6zAYsCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE90313A9A;
        Fri,  7 Oct 2022 12:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WQidKiIgQGMKZwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 07 Oct 2022 12:48:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3B5B5A06E9; Fri,  7 Oct 2022 14:48:34 +0200 (CEST)
Date:   Fri, 7 Oct 2022 14:48:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for v6.1-rc1
Message-ID: <20221007124834.4guduq5n5c6argve@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify-for_v6.1-rc1

to get two cleanups for fsnotify code.

Top of the tree is 7a80bf902d2b. The full shortlog is:

Gaosheng Cui (2):
      fsnotify: remove unused declaration
      fanotify: Remove obsoleted fanotify_event_has_path()

The diffstat is

 fs/notify/fanotify/fanotify.h | 6 ------
 fs/notify/fsnotify.h          | 4 ----
 2 files changed, 10 deletions(-)

							Thanks
								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
