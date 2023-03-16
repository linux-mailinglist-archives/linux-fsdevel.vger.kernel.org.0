Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186466BCA39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 10:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCPJAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCPJAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:00:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED7A6BDC;
        Thu, 16 Mar 2023 02:00:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D878321A2F;
        Thu, 16 Mar 2023 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678957235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=76bGzfFjq00n72sGWbMCzxVH+UbOKseM9/VAFoGPmf4=;
        b=fUzBqLFluW0qQFlf7QjlSHAUV+P3kt6Rz1Cfo5IeZSyC6MiEGB6moJlQagrIpt7RYWxBqn
        hB97tfl49nW6/513sRSnERfQZUcO5b3ixe1ErPscAyMWcYLHpQu6CT75o4Hh1s9x8Viy/1
        g2zmFSj/RLqnm4Vm2RwO6NrsNqrRk1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678957235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=76bGzfFjq00n72sGWbMCzxVH+UbOKseM9/VAFoGPmf4=;
        b=zrq+eNF8EoTfV2Q1CKC2yYXVCXxoEn8wUjqYUOAbgCfxbYpQNy2P1+dCUiqRsaA+6gwidF
        kMzOPRq3UZ8x/yDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9E5713A2F;
        Thu, 16 Mar 2023 09:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FCRAMbPaEmTGMwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 16 Mar 2023 09:00:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 56114A06FD; Thu, 16 Mar 2023 10:00:35 +0100 (CET)
Date:   Thu, 16 Mar 2023 10:00:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Message-ID: <20230316090035.ynjejgcd72ynvd36@quack3>
References: <Y/gugbqq858QXJBY@ZenIV>
 <20230301130018.yqds5yvqj7q26f7e@quack3>
 <Y/9duET0Mt5hPu2L@ZenIV>
 <3019063.4lk9UinFSI@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3019063.4lk9UinFSI@suse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-03-23 19:08:57, Fabio M. De Francesco wrote:
> On mercoledì 1 marzo 2023 15:14:16 CET Al Viro wrote:
> > On Wed, Mar 01, 2023 at 02:00:18PM +0100, Jan Kara wrote:
> > > On Wed 01-03-23 12:20:56, Fabio M. De Francesco wrote:
> > > > On venerdì 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> > > > > 	Fabio's "switch to kmap_local_page()" patchset (originally after the
> > > > > 
> > > > > ext2 counterpart, with a lot of cleaning up done to it; as the matter 
> of
> > > > > fact, ext2 side is in need of similar cleanups - calling conventions
> > > > > there
> > > > > are bloody awful).
> > > > 
> 
> [snip]
> 
> > 
> > I think I've pushed a demo patchset to vfs.git at some point back in
> > January... Yep - see #work.ext2 in there; completely untested, though.
> 
> The following commits from the VFS tree, #work.ext2 look good to me.
> 
> f5b399373756 ("ext2: use offset_in_page() instead of open-coding it as 
> subtraction")
> c7248e221fb5 ("ext2_get_page(): saner type")
> 470e54a09898 ("ext2_put_page(): accept any pointer within the page")
> 15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with page_addr")
> 16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need page_addr 
> anymore")
> 
> Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks!

> I could only read the code but I could not test it in the same QEMU/KVM x86_32 
> VM where I test all my HIGHMEM related work. 
> 
> Btrfs as well as all the other filesystems I converted to kmap_local_page() 
> don't make the processes in the VM to crash, whereas the xfstests on ext2  
> trigger the OOM killer at random tests (only sometimes they exit gracefully).
> 
> FYI, I tried to run the tests with 6GB of RAM, booting a kernel with 
> HIGHMEM64GB enabled. I cannot add my "Tested-by" tag.

Hum, interesting. Reading your previous emails this didn't seem to happen
before applying this series, did it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
