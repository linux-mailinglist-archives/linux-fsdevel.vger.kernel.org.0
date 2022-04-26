Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5E50F923
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 11:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbiDZJre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 05:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347372AbiDZJp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:45:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB48F1E0671
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 02:01:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD41D210E8;
        Tue, 26 Apr 2022 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650963682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGgZDwDl7W6PnuL1QzL7ssw3fl4EypHE5EADwhe1+Yg=;
        b=PiHqdaio73qe6c+QRqAdwx3m1NgG0QaEtnMp+6BPFhC5M41vlKHSG6xpQth0e/GgDKA5bZ
        aUyd+9M9kvnZtZXwKWoK/6UXbN+6B55eaD2RmjQ3Qyjon01gTzQv9UICJMZfaJcs8dXzUZ
        x0+/4Jm1+Wq48igVcTtzsHcMjb7r5jQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650963682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGgZDwDl7W6PnuL1QzL7ssw3fl4EypHE5EADwhe1+Yg=;
        b=GCvKQGb3hGna1jxZoZPjdyEwMbJkB1OvXekwC5lBSu/IY4C+kWHG+ZISlhp+ecVYgDzSJA
        mkGB+lHpSdmDsfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B52C413AD5;
        Tue, 26 Apr 2022 09:01:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AKXiKuK0Z2K1KAAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 26 Apr 2022 09:01:22 +0000
Date:   Tue, 26 Apr 2022 11:01:19 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org
Cc:     viro@zeniv.linux.org.uk
Subject: Re: [PATCH v7 0/6] initramfs: "crc" cpio format and
 INITRAMFS_PRESERVE_MTIME
Message-ID: <20220426110119.39e823f5@suse.de>
In-Reply-To: <20220404093429.27570-1-ddiss@suse.de>
References: <20220404093429.27570-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping...

@Matthew: "crc" archive support was added following your suggestion in
https://lore.kernel.org/all/YYwBzj0isuKOjjUe@casper.infradead.org/ -
I'd really appreciate some feedback on those patches.

On Mon,  4 Apr 2022 11:34:24 +0200, David Disseldorp wrote:

> This patchset does some minor initramfs refactoring and allows cpio
> entry mtime preservation to be disabled via a new Kconfig
> INITRAMFS_PRESERVE_MTIME option.
> Patches 4/6 to 6/6 implement support for creation and extraction of
> "crc" cpio archives, which carry file data checksums. Basic tests for
> this functionality can be found at
> Link: https://github.com/rapido-linux/rapido/pull/163
> 
> Changes since v6 following feedback from Andrew Morton:
> - 3/6: improve commit message and don't split out initramfs_mtime.h
> - add extra acks and sob tags for 1/6, 2/6 and 4/6
> 
> Changes since v5:
> - add PATCH 2/6 initramfs: make dir_entry.name a flexible array member
> - minor commit message rewording
> 
> Changes since v4, following feedback from Matthew Wilcox:
> - implement cpio "crc" archive creation and extraction
> - add patch to fix gen_init_cpio short read handling
> - drop now-unnecessary "crc" documentation and error msg changes
> 
> Changes since v3, following feedback from Martin Wilck:
> - 4/4: keep vfs_utimes() call in do_copy() path
>   + drop [PATCH v3 4/5] initramfs: use do_utime() wrapper consistently
>   + add do_utime_path() helper
>   + clean up timespec64 initialisation
> - 4/4: move all mtime preservation logic to initramfs_mtime.h and drop
>   separate .c
> - 4/4: improve commit message
> 
> 
>  init/Kconfig        | 10 +++++
>  init/initramfs.c    | 76 ++++++++++++++++++++++++-------------
>  usr/gen_init_cpio.c | 92 +++++++++++++++++++++++++++++++++------------
>  3 files changed, 127 insertions(+), 51 deletions(-)

