Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7A682C56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 13:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjAaMO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 07:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAaMO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:14:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB69B3F29D;
        Tue, 31 Jan 2023 04:14:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33B42225E1;
        Tue, 31 Jan 2023 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675167264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7CV3uj2kDSVI4fanE/KCToyJxqPWzb+HHyIaNLOcff0=;
        b=hS3vFGOeOYOeHEzN8r1tg06sON5BlQiZf6cvQxRs2ksL6eevMAofKAsR11sNKSFP9V0Jjb
        Tb6kZ/Ab2PExoc3kOLr4r8GxQDK0O2msKB5u2ypju6totpu9q/Kaxun4/UTzHDMybRdSLA
        g7h3tyn7LbK2YTwBtf6UPE11VQVNIQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675167264;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7CV3uj2kDSVI4fanE/KCToyJxqPWzb+HHyIaNLOcff0=;
        b=ilMt3zUfeFK7nbjagjX2p8Y3AtRLyZwBL0tWTYLajp9z/H9os7AxwK5BUbghz8f52sbudZ
        GvzUS4shzykNL9Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20C0C138E8;
        Tue, 31 Jan 2023 12:14:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uQTpByAG2WMeBQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Jan 2023 12:14:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 361E8A06D5; Tue, 31 Jan 2023 13:14:23 +0100 (CET)
Date:   Tue, 31 Jan 2023 13:14:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+707bba7f823c7b02fa43@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
        dchinner@redhat.com, hirofumi@mail.parknet.co.jp, jack@suse.com,
        jfs-discussion@lists.sourceforge.net, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, shaggy@kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: [syzbot] [hfsplus?] [udf?] [fat?] [jfs?] [vfs?] [hfs?] [exfat?]
 [ntfs3?] WARNING in __mpage_writepage
Message-ID: <20230131121423.pqfogvntzouymzmv@quack3>
References: <0000000000006b2ca005f38c7aeb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006b2ca005f38c7aeb@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 31-01-23 02:05:58, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e2f86c02fdc9 Add linux-next specific files for 20230127
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=156b2101480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=920c61956db733da
> dashboard link: https://syzkaller.appspot.com/bug?extid=707bba7f823c7b02fa43
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118429cd480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ccb1c1480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ff04f1611fad/disk-e2f86c02.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/67928a8622d3/vmlinux-e2f86c02.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b444a3d78556/bzImage-e2f86c02.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/99c5e7532847/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+707bba7f823c7b02fa43@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5085 at fs/mpage.c:570 __mpage_writepage+0x138b/0x16f0 fs/mpage.c:570

This is the warning Willy has added as part of "mpage: convert
__mpage_writepage() to use a folio more fully" and that warning can indeed
easily trigger. There's nothing that serializes writeback against racing
truncate setting new i_size so it is perfectly normal to see pages beyond
EOF in this place. And the traditional response to such pages is "silently
do nothing" since they will be soon discarded by truncate_inode_pages().

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
