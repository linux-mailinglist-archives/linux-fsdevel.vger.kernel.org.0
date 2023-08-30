Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6844D78DACB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbjH3ShL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243235AbjH3K1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:27:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB8C0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 03:27:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3870021835;
        Wed, 30 Aug 2023 10:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693391259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=w4aLwpCReE8LKIe7UkPjykgLPZ9BQAORNTFO6C1relw=;
        b=vYtdZ1RQI+ZLkDLlv2VfL2lJsoXMh3e+Zc6hd+shfsO81HhtWnA11ip99MUohwvjmZKCU4
        V3f/KzxDxktedOBr07m6lUebNZWVKBwoAA7jsulK1pgFF7DLLiDfBiA6sxwRduPe84X4y/
        vd7rIlbFhjRjR2cigjEIA+5gSaogbL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693391259;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=w4aLwpCReE8LKIe7UkPjykgLPZ9BQAORNTFO6C1relw=;
        b=WL0mqU7eO9bYob3Yv8KSuMTUHtvBJbsO6bOU8HURf5UHYubON0mxImIEXRpx1yjWHqBxZF
        0vsXgJvgurWfU8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AAD11353E;
        Wed, 30 Aug 2023 10:27:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id laljCpsZ72SZYgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Aug 2023 10:27:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 91290A0774; Wed, 30 Aug 2023 12:27:38 +0200 (CEST)
Date:   Wed, 30 Aug 2023 12:27:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify cleanup for 6.6-rc1
Message-ID: <20230830102738.e2qg3odqvxjzmpbl@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.6-rc1

to get just a small fsnotify cleanup this time.

Top of the tree is a488bc16225e. The full shortlog is:

YueHaibing (1):
      fanotify: Remove unused extern declaration fsnotify_get_conn_fsid()

The diffstat is

 include/linux/fsnotify_backend.h | 3 ---
 1 file changed, 3 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
