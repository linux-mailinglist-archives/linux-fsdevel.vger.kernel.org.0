Return-Path: <linux-fsdevel+bounces-3452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD0F7F4DDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 18:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514B41C20AAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C826D56B75;
	Wed, 22 Nov 2023 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mu8nQlYL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="naojmf+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7AEE7;
	Wed, 22 Nov 2023 09:11:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 368C921980;
	Wed, 22 Nov 2023 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700673073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8UQWN8urvKUYRckX3Xlqtm4AGvpGzvpb35HA8d2DQI=;
	b=mu8nQlYLDB7p7sUhCTYd8JDfrfk5R3hTA/eBpNN6S5SWPCcrZneWlcKtg/V7yEfVxwRfh9
	blngk3/E9BjOlyeZYl7zLFTYBS4ayWjat95o/E09UFJ5pTuASrVkFBy5Q+dHmp/uPkq2+G
	Ot6ggJ/PPH9A396RF+DaajasanKQ0Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700673073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8UQWN8urvKUYRckX3Xlqtm4AGvpGzvpb35HA8d2DQI=;
	b=naojmf+wkd6JU6MQq3ItRLNmQOYO0uI2dnMkqdvG1yq3B6LOAPrMWgxUssjhLAJdkDXVpy
	1zpdJ1X+HujdlrDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D957E13461;
	Wed, 22 Nov 2023 17:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pmIINTA2XmUfUgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 22 Nov 2023 17:11:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 696FBA07DC; Wed, 22 Nov 2023 18:11:12 +0100 (CET)
Date: Wed, 22 Nov 2023 18:11:12 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, jack@suse.cz, joseph.qi@linux.alibaba.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] WARNING in ext4_dio_write_end_io
Message-ID: <20231122171112.un5yuwxdcrlswiwe@quack3>
References: <000000000000ce703b060abf1e06@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ce703b060abf1e06@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305];
	 TAGGED_RCPT(0.00)[47479b71cdfc78f56d30];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[dilger.ca,suse.cz,linux.alibaba.com,vger.kernel.org,gmail.com,googlegroups.com,mit.edu];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: *

On Wed 22-11-23 07:10:31, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    98b1cc82c4af Linux 6.7-rc2
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15e09a9f680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
> dashboard link: https://syzkaller.appspot.com/bug?extid=47479b71cdfc78f56d30
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c09a00e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151d5320e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/39c6cdad13fc/disk-98b1cc82.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5a77b5daef9b/vmlinux-98b1cc82.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5e09ae712e0d/bzImage-98b1cc82.xz
> 
> The issue was bisected to:
> 
> commit 91562895f8030cb9a0470b1db49de79346a69f91
> Author: Jan Kara <jack@suse.cz>
> Date:   Fri Oct 13 12:13:50 2023 +0000
> 
>     ext4: properly sync file size update after O_SYNC direct IO
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d0f0c8e80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1430f0c8e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1030f0c8e80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
> Fixes: 91562895f803 ("ext4: properly sync file size update after O_SYNC direct IO")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 4481 at fs/ext4/file.c:391 ext4_dio_write_end_io+0x1db/0x220 fs/ext4/file.c:391

OK, so I could easily reproduce this which is good :). It took a bit longer
to actually debug what's going on. In the end I've confirmed this is a
false positive (the assertion isn't 100% reliable). What happens is that
the IO end completion races with expanding truncate (which is not
synchronized with DIO in any way) and the assertion sees a situation where
i_disksize was updated but i_size not yet. This is mostly harmless but we
better should complete the DIO only once we are sure truncate has updated
the i_size as well. I'll think how to best do this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

