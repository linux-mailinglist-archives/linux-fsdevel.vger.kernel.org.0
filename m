Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B421A6C123E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 13:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjCTMrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 08:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjCTMrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:47:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBCF1449F;
        Mon, 20 Mar 2023 05:47:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97A4D1F85D;
        Mon, 20 Mar 2023 12:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679316446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oV8n86ezE3PDuESxSyzDj8V5HvxjQXuG2gXNZlLh2k=;
        b=W7FuxtZKswgPfhF2X4ZAQGI304brinRgKfzkZS/EkyoTPkg/dOy3jZS+6jH4DvJxzL9LkC
        V011yHOL9H2cmWI0Z6qKRgvXSGKa87/nnSghlt97EJ5vr164eizMgramgoGHFT7hkComCo
        GbCutZCsr4kYevk6qUDvBOigjSNtx4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679316446;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oV8n86ezE3PDuESxSyzDj8V5HvxjQXuG2gXNZlLh2k=;
        b=GqtUi8yRoTwkqfIrCl/GRY++xtu4GBzluATScvLcp3xOEuERstepm41uMn3eDGnSEI7sRV
        kHyf8/j1VHXHgKAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8867A13A00;
        Mon, 20 Mar 2023 12:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6u1DId5VGGTyZgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 20 Mar 2023 12:47:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E380AA0719; Mon, 20 Mar 2023 13:47:25 +0100 (CET)
Date:   Mon, 20 Mar 2023 13:47:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Message-ID: <20230320124725.pe4jqdsp4o47kmdp@quack3>
References: <Y/gugbqq858QXJBY@ZenIV>
 <20230316090035.ynjejgcd72ynvd36@quack3>
 <2766007.BEx9A2HvPv@suse>
 <4214717.mogB4TqSGs@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4214717.mogB4TqSGs@suse>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 20-03-23 12:18:38, Fabio M. De Francesco wrote:
> On giovedì 16 marzo 2023 11:30:21 CET Fabio M. De Francesco wrote:
> > On giovedì 16 marzo 2023 10:00:35 CET Jan Kara wrote:
> > > On Wed 15-03-23 19:08:57, Fabio M. De Francesco wrote:
> > > > On mercoledì 1 marzo 2023 15:14:16 CET Al Viro wrote:
> > > > > On Wed, Mar 01, 2023 at 02:00:18PM +0100, Jan Kara wrote:
> > > > > > On Wed 01-03-23 12:20:56, Fabio M. De Francesco wrote:
> > > > > > > On venerdì 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> > > > > > > > 	Fabio's "switch to kmap_local_page()" patchset (originally
> > 
> > after
> > 
> > > > > > > > 	the
> > > > > > > > 
> > > > > > > > ext2 counterpart, with a lot of cleaning up done to it; as the
> > > > > > > > matter
> > > > 
> > > > of
> > > > 
> > > > > > > > fact, ext2 side is in need of similar cleanups - calling
> > 
> > conventions
> > 
> > > > > > > > there
> > > > > > > > are bloody awful).
> > > > 
> > > > [snip]
> > > > 
> > > > > I think I've pushed a demo patchset to vfs.git at some point back in
> > > > > January... Yep - see #work.ext2 in there; completely untested, though.
> > > > 
> > > > The following commits from the VFS tree, #work.ext2 look good to me.
> > > > 
> > > > f5b399373756 ("ext2: use offset_in_page() instead of open-coding it as
> > > > subtraction")
> > > > c7248e221fb5 ("ext2_get_page(): saner type")
> > > > 470e54a09898 ("ext2_put_page(): accept any pointer within the page")
> > > > 15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with
> > 
> > page_addr")
> > 
> > > > 16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need
> > 
> > page_addr
> > 
> > > > anymore")
> > > > 
> > > > Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > 
> > > Thanks!
> > > 
> > > > I could only read the code but I could not test it in the same QEMU/KVM
> > > > x86_32 VM where I test all my HIGHMEM related work.
> > > > 
> > > > Btrfs as well as all the other filesystems I converted to
> > 
> > kmap_local_page()
> > 
> > > > don't make the processes in the VM to crash, whereas the xfstests on 
> ext2
> > > > trigger the OOM killer at random tests (only sometimes they exit
> > > > gracefully).
> > > > 
> > > > FYI, I tried to run the tests with 6GB of RAM, booting a kernel with
> > > > HIGHMEM64GB enabled. I cannot add my "Tested-by" tag.
> > > 
> > > Hum, interesting. Reading your previous emails this didn't seem to happen
> > > before applying this series, did it?
> > 
> > I wrote too many messages but was probably not able to explain the facts
> > properly. Please let me summarize...
> > 
> > 1) When testing ext2 with "./check -g quick" in a QEMU/KVM x86_32 VM, 6GB 
> RAM,
> > booting a Vanilla kernel 6.3.0-rc1 with HIGHMEM64GB enabled, the OOM Killer
> > kicks in at random tests _with_ and _without_ Al's patches.
> > 
> > 2) The only case which does never trigger the OOM Killer is running the 
> tests
> > on ext2 formatted filesystems in loop disks with the stock openSUSE kernel
> > which is the 6.2.1-1-pae.
> > 
> > 3) The same "./check -g quick" on 6.3.0-rc1 runs always to completion with
> > other filesystems. I ran xfstests several times on Btrfs and I had no
> > problems.
> > 
> > 4) I cannot git-bisect this issue with ext2 because I cannot trust the 
> results
> > on any particular Kernel version. I mean that I cannot mark any specific
> > version neither "good" or "bad" because it happens that the same "good"
> > version instead make xfstests crash at the next run.
> > 
> > My conclusion is that we probably have some kind of race that makes the 
> random
> > tests crash at random runs of random Kernel versions between (at least) SUSE
> > 6.2.1 and Vanilla current.
> > 
> > But it may be very well the case that I'm doing something stupid (e.g., with
> > QEMU configuration or setup_disks or I can't imagine whatever else) and that
> > I'm unable to see where I make mistakes. After all, I'm still a newcomer 
> with
> > little experience :-)
> > 
> > Therefore, I'd suggest that someone else try to test ext2 in an x86_32 VM.
> > However, I'm 99.5% sure that Al's patches are good by the mere inspection of
> > his code.
> > 
> > I hope that this summary contains everything that may help.
> > 
> > However, I remain available to provide any further information and to give 
> my
> > contribution if you ask me for specific tasks.
> > 
> > For my part I have no idea how to investigate what is happening. In these
> > months I have run the VM hundreds of times on the most disparate filesystems
> > to test my conversions to kmap_local_page() and I have never seen anything
> > like this happen.
> > 
> > Thanks,
> > 
> > Fabio
> > 
> > 
> > Honza
> > 
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> 
> I can't yet figure out which conditions lead to trigger the OOM Killer to kill 
> the XFCE Desktop Environment, and the xfstests (which I usually run into the 
> latter). After all, reserving 6GB of main memory to a QEMU/KVM x86_32 VM had 
> always been more than adequate.
> 
> So, I thought I'd better ignore that 6GB for a 32 bit architecture are a 
> notable amount of RAM and squeezed some more from the host until I went to 
> reserve 8GB. I know that this is not what who is able to find out what 
> consumes so much main memory would do, but wanted to get the output from the 
> tests, one way or the other... :-(
> 
> OK, I could finally run my tests to completion and had no crashes at all. I 
> ran "./check -g quick" on one "test" + three "scratch" loop devices formatted 
> with "mkfs.ext2 -c". I ran three times _with_ and then three times _without_ 
> Al's following patches cloned from his vfs tree, #work.ext2 branch:
> 
> f5b399373756 ("ext2: use offset_in_page() instead of open-coding it as 
> subtraction")
> c7248e221fb5 ("ext2_get_page(): saner type")
> 470e54a09898 ("ext2_put_page(): accept any pointer within the page")
> 15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with page_addr")
> 16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need
> 
> All the six tests were no longer killed by the Kernel :-)
> 
> I got 144 failures on 597 tests, regardless of the above listed patches.
> 
> My final conclusion is that these patches don't introduce regressions. I see 
> several tests that produce memory leaks but, I want to stress it again, the 
> failing tests are always the same with and without the patches.
> 
> therefore, I think that now I can safely add my tag to all five patches listed 
> above...
> 
> Tested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks for the effort! Al, will you submit these patches or should I just
pull your branch into my tree?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
