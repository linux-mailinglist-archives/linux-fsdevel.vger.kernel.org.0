Return-Path: <linux-fsdevel+bounces-4056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2A17FBF7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 17:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2051C20D2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283B45E0D6;
	Tue, 28 Nov 2023 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A7ED5D;
	Tue, 28 Nov 2023 08:47:28 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 067CB219A1;
	Tue, 28 Nov 2023 16:47:27 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D1EA6133B5;
	Tue, 28 Nov 2023 16:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uh4GM54ZZmUUXgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 28 Nov 2023 16:47:26 +0000
Date: Tue, 28 Nov 2023 17:40:10 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: syzbot <syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com>,
	clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_use_block_rsv
Message-ID: <20231128164010.GM18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0000000000004d4716060af08a45@google.com>
 <531f8f07-6c4c-66bb-1d8e-7637222154af@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531f8f07-6c4c-66bb-1d8e-7637222154af@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: ++++++++
X-Spam-Score: 9.00
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: 067CB219A1
X-Spamd-Result: default: False [9.00 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(0.00)[40.64%];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.984];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305];
	 TAGGED_RCPT(0.00)[10d5b62a8d7046b86d22];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Sun, Nov 26, 2023 at 06:59:41AM +0800, Anand Jain wrote:
> 
> 
> On 25/11/2023 10:08, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit a5b8a5f9f8355d27a4f8d0afa93427f16d2f3c1e
> > Author: Anand Jain <anand.jain@oracle.com>
> > Date:   Thu Sep 28 01:09:47 2023 +0000
> > 
> >      btrfs: support cloned-device mount capability
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1446d344e80000
> > start commit:   d3fa86b1a7b4 Merge tag 'net-6.7-rc3' of git://git.kernel.o..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1646d344e80000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1246d344e80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
> > dashboard link: https://syzkaller.appspot.com/bug?extid=10d5b62a8d7046b86d22
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1431040ce80000
> > 
> > Reported-by: syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com
> > Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> 
> It is completely strange that this issue bisects to the commit
> a5b8a5f9f835 ('btrfs: support cloned-device mount capability').
> I am unable to reproduce this as well.

I think it's because of changed timing or it can be an inconclusive
bisect. Things around space handling depend on timing, the test would
need to be run a few times to be sure.

The report provides an image so it may be good to analyze if it's scaled
properly or if the reproducer does something strange.

> -------------------
> WARNING: CPU: 1 PID: 58 at fs/btrfs/block-rsv.c:523 
> btrfs_use_block_rsv+0x60d/0x860 fs/btrfs/block-rsv.c:523
> <snap>
> Call Trace:
>   <TASK>
>   btrfs_alloc_tree_block+0x1e0/0x12c0 fs/btrfs/extent-tree.c:5114
>   btrfs_force_cow_block+0x3e5/0x19e0 fs/btrfs/ctree.c:563
>   btrfs_cow_block+0x2b6/0xb30 fs/btrfs/ctree.c:741
>   push_leaf_left+0x315/0x4d0 fs/btrfs/ctree.c:3485
>   split_leaf+0x9c3/0x13b0 fs/btrfs/ctree.c:3681
>   search_leaf fs/btrfs/ctree.c:1944 [inline]
>   btrfs_search_slot+0x24ba/0x2fd0 fs/btrfs/ctree.c:2131
>   btrfs_insert_empty_items+0xb6/0x1b0 fs/btrfs/ctree.c:4285
>   btrfs_insert_empty_item fs/btrfs/ctree.h:657 [inline]
>   insert_reserved_file_extent+0x7aa/0x950 fs/btrfs/inode.c:2907
>   insert_ordered_extent_file_extent fs/btrfs/inode.c:3005 [inline]
>   btrfs_finish_one_ordered+0x12dc/0x20d0 fs/btrfs/inode.c:3113
>   btrfs_work_helper+0x210/0xbf0 fs/btrfs/async-thread.c:315
>   process_one_work+0x886/0x15d0 kernel/workqueue.c:2630
>   process_scheduled_works kernel/workqueue.c:2703 [inline]
>   worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
>   kthread+0x2c6/0x3a0 kernel/kthread.c:388
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> -----------------
> 
> btrfs_use_block_rsv()
> <snap>
>          /*
>           * The global reserve still exists to save us from ourselves, 
> so don't
>           * warn_on if we are short on our delayed refs reserve.
>           */
>          if (block_rsv->type != BTRFS_BLOCK_RSV_DELREFS &&
>              btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
>                  static DEFINE_RATELIMIT_STATE(_rs,
>                                  DEFAULT_RATELIMIT_INTERVAL * 10,
>                                  /*DEFAULT_RATELIMIT_BURST*/ 1);
>                  if (__ratelimit(&_rs))
>                          WARN(1, KERN_DEBUG
>                                  "BTRFS: block rsv %d returned %d\n",
>                                  block_rsv->type, ret);
>          }
> ----------

