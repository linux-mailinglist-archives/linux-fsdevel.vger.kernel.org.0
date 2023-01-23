Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB726782D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjAWRSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjAWRSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:18:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39355A7;
        Mon, 23 Jan 2023 09:18:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E2AC71F749;
        Mon, 23 Jan 2023 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674494291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCsZoF8K5x/BHYzYzNwgB5+MVCHaBtUXtLrBn1pBPvk=;
        b=PWd2EWaEzn5YeSQwfyVFeATvYcS0q+VjyGr9dVgBSxAMBakjoHIxImRXDTrAbR+OBzUhXM
        6duV6bQ3VBvGupta3by0Dx81pHaSIreAQN38wIdv0a30nZvzPzt7qcWxIz7oZU0zuPORjM
        AcmoEwsBJZiBaS3KCjOLh914MLZGRtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674494291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCsZoF8K5x/BHYzYzNwgB5+MVCHaBtUXtLrBn1pBPvk=;
        b=sV0pQZO+Fgy4DIMVu1d2rX9zsppc9uYA4iT9J+y+phoyAjzSkpKmVCB1l1OUZ2qu53Vkls
        dc0AwcBMAXPkQUAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9E3F1357F;
        Mon, 23 Jan 2023 17:18:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L5ZEMVPBzmNLFgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 23 Jan 2023 17:18:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E3B5CA06B5; Mon, 23 Jan 2023 18:18:10 +0100 (CET)
Date:   Mon, 23 Jan 2023 18:18:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, jack@suse.com, jack@suse.cz,
        linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: [syzbot] [udf?] BUG: unable to handle kernel NULL pointer
 dereference in __writepage
Message-ID: <20230123171810.mgzdqaeqjdjmvb3y@quack3>
References: <0000000000003198a505f0076823@google.com>
 <0000000000009cfc1705f2a07641@google.com>
 <20230123073609.GA31134@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123073609.GA31134@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 23-01-23 08:36:09, Christoph Hellwig wrote:
> I looked into this and got really confused.  We should never end
> up in generic_writepages if ->writepages is set, which this patch
> obviously does.
> 
> Then I took a closer look at udf, and it seems to switch a_aops around
> at run time, and it seems like we're hitting just that case, and the
> patch just seems to narrow down that window.
> 
> I suspect the right fix is to remove this runtime switching of aops,
> and just do conditionals inside the methods.

Interestingly for me it crashes like:

[  338.085616] general protection fault, probably for non-canonical address 0x40
00000000002068: 0000 [#1] PREEMPT SMP PTI
[  338.086959] CPU: 4 PID: 31292 Comm: syz-repro11 Not tainted 6.1.0-xen+ #705
[  338.087941] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1
.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[  338.089470] RIP: 0010:bio_associate_blkg_from_css+0x31d/0x860
[  338.092626] RSP: 0018:ffffc90003bb7958 EFLAGS: 00010202
[  338.093274] RAX: 0000000000000001 RBX: 4000000000002030 RCX: 000000005d6692ad
[  338.094149] RDX: 0000000092c5763f RSI: ffffffff81eb2e65 RDI: ffffffff81ec3d71
[  338.095023] RBP: ffff888100c98cc0 R08: 0000000000000001 R09: 0000000000020022
[  338.095953] R10: 0000000000000000 R11: ffff888108da2fe8 R12: ffffffff831db0e0
[  338.096884] R13: ffff888100c98cc0 R14: ffffea0004692380 R15: ffffffff831da338
[  338.097760] FS:  00007f9c59cc0700(0000) GS:ffff888fffd00000(0000) knlGS:00000
00000000000
[  338.098755] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  338.102194] Call Trace:
[  338.102496]  <TASK>
[  338.102757]  ? bio_associate_blkg_from_css+0x2d2/0x860
[  338.103390]  bio_associate_blkg+0x68/0x130
[  338.103955]  ? bio_associate_blkg+0x9/0x130
[  338.104538]  bio_init+0x7f/0xd0
[  338.104926]  bio_alloc_bioset+0x1f5/0x320
[  338.106364]  __mpage_writepage+0x4dc/0x780
[  338.110045]  write_cache_pages+0x113/0x470
[  338.111635]  mpage_writepages+0x5b/0xb0
[  338.112854]  do_writepages+0xd3/0x1a0
[  338.113782]  filemap_fdatawrite_wbc+0x84/0xb0
[  338.114793]  __filemap_fdatawrite_range+0x58/0x80
[  338.115374]  udf_expand_file_adinicb+0xfa/0x420 [udf]
[  338.116109]  udf_file_write_iter+0x1a9/0x1d0 [udf]

which is actually inside:
bio_associate_blkg_from_css+0x31d/0x860:
__ref_is_percpu at include/linux/percpu-refcount.h:174
(inlined by) percpu_ref_get_many at include/linux/percpu-refcount.h:204
(inlined by) percpu_ref_get at include/linux/percpu-refcount.h:222
(inlined by) blkg_get at block/blk-cgroup.h:322
(inlined by) bio_associate_blkg_from_css at block/blk-cgroup.c:1938

so bdev_get_queue(bio->bi_bdev)->root_blkg is bogus (0x4000000000002030).
Likely the request_queue is already dead. Not sure how this could be caused
by any problem in UDF.

Anyway, I tend to agree with you that switching aops is hairy and we should
probably get rid of it in UDF. But this particular crash seems to be
related to something else...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
