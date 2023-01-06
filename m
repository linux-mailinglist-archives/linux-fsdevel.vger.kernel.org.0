Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1A16602C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 16:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjAFPJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 10:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjAFPJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:09:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BAE777EB
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 07:09:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D20B26EF0;
        Fri,  6 Jan 2023 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673017779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Zd85SVwkBWr7NmT7ou7PFX1pGSxY7jBQ7FDpgfItSU0=;
        b=SIGL5HNO7PQpwS9CUmYsooQ36tNB7CD+p0kvoWyFzVa0nswkNJ8Q4lZCf/prkuLLM9XfC9
        Hv+S/kod5YwC05CHqzxJk2jC91NeABhNiCrwcxD57T2sgSZux9HE1USMkJuVGS+rPRw3uv
        tbGlmbmhBez4P51Rvo553JFzjQXtBDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673017779;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Zd85SVwkBWr7NmT7ou7PFX1pGSxY7jBQ7FDpgfItSU0=;
        b=L3d47+HptXxjc1Sn424bjMt1bRLayo6Lav8em1LhWE47DArd85EGigM9piXD2oXP231IWM
        2NThJSHaZjFSiBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ADD9139D5;
        Fri,  6 Jan 2023 15:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2hbgIbM5uGNwDwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 06 Jan 2023 15:09:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2BB17A0742; Fri,  6 Jan 2023 16:09:39 +0100 (CET)
Date:   Fri, 6 Jan 2023 16:09:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] UDF fixes for 6.2-rc3
Message-ID: <20230106150939.ox6rrzbrbu3fhvhn@quack3>
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

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v6.2-rc3

to get two fixups of the UDF changes that went into 6.2-rc1.

Top of the tree is 23970a1c9475. The full shortlog is:

Jan Kara (1):
      udf: Fix extension of the last extent in the file

Tom Rix (1):
      udf: initialize newblock to 0

The diffstat is

 fs/udf/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
