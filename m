Return-Path: <linux-fsdevel+bounces-924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E77D3785
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 15:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866C72813F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF818E2E;
	Mon, 23 Oct 2023 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/1YfaHh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zoQ1NDUK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401914F7E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 13:15:28 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC5C4;
	Mon, 23 Oct 2023 06:15:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CE9621AE4;
	Mon, 23 Oct 2023 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698066924;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uOQPaskcC7n4iiCUTkQQkbtJLmrXJj+rmIAUgG5duTQ=;
	b=G/1YfaHh+O+GXrvxNXvsWZJGiPHD7LEKz4R0zZuyKeQVwnMikP+nYk0istXhqzsMVJLQHF
	I5mSRnQL6vtnt4a5vnWW5Q0SXxU0it1MBlQGzIFB+thH7GtksN9EktPLiF7iUJhwLOln4i
	d5jVFWO3ttZgUVJWVeBeSpnGP0uZbys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698066924;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uOQPaskcC7n4iiCUTkQQkbtJLmrXJj+rmIAUgG5duTQ=;
	b=zoQ1NDUKbAvGBaiZD7n5ud/5Nsbt8eafK4Mdy9UQiNJTn21MdQ4mJpXw6tB+yb+D5/wG3L
	XKt9Dw/x65sGe9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33DEF132FD;
	Mon, 23 Oct 2023 13:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +4XNC+xxNmUsRwAAMHmgww
	(envelope-from <dsterba@suse.cz>); Mon, 23 Oct 2023 13:15:24 +0000
Date: Mon, 23 Oct 2023 15:08:30 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+b2869947e0c9467a41b6@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (4)
Message-ID: <20231023130830.GG26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000d005440608450810@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d005440608450810@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f27cd6e68911e026];
	 TAGGED_RCPT(0.00)[b2869947e0c9467a41b6];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[22.52%];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SUBJECT_HAS_EXCLAIM(0.00)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]

On Sat, Oct 21, 2023 at 07:40:53PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    78124b0c1d10 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1557da89680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f27cd6e68911e026
> dashboard link: https://syzkaller.appspot.com/bug?extid=b2869947e0c9467a41b6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137ac45d680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e4640b680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bd512de820ae/disk-78124b0c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a47a437b1d4f/vmlinux-78124b0c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3ae8b966bcd7/Image-78124b0c.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/d5d514495f15/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b2869947e0c9467a41b6@syzkaller.appspotmail.com
> 
> BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

#syz invalid

This is a frequent warning, can be worked around by increasing
CONFIG_LOCKDEP_CHAINS_BITS in config (18 could be a good value but may
still not be enough).

