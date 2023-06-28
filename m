Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C474173E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjF1Rdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjF1Rdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3E02102;
        Wed, 28 Jun 2023 10:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93AE76120E;
        Wed, 28 Jun 2023 17:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DBDC433C0;
        Wed, 28 Jun 2023 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687973613;
        bh=O1MO0FX7r5ETJgeXa3FWAKYrIQbVEKXsUnp7T291ICo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQcefN3gtbUOatt4oQZ6m6ELSB2icWLaDiniHanCBJ+kAl+be6BLUpBsf3gY5G3DQ
         CaFDcH2wCrkscgcBSec/NPgdodCRiLOdtbsWP7n1yxK/9rSe8HPFW79PrsWMgZsE40
         SRg8qVqog442A4wS/3Sv4crws8bmxIV/XE0ArcftKdXZscy2pODQIm3U+Sx+FTH1pX
         u5E7njr5glPHJJtP0IIoMa5m8dr8gJ+a1YlNMGL4Pe2XgktdzAPnBW9d0JINOkg7eZ
         4fIJApPZc0TVV/KFrFWjmC0UERaK79P+JXMnWTkabXdPPtRxdVfa2uRfzIg+pP40GV
         DtQv//b+0aG5w==
Date:   Wed, 28 Jun 2023 19:33:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230628-global-gewebe-c7491691d780@brauner>
References: <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:57:02AM -0600, Jens Axboe wrote:
> On 6/28/23 8:58?AM, Jens Axboe wrote:
> > On 6/27/23 10:01?PM, Kent Overstreet wrote:
> >> On Tue, Jun 27, 2023 at 09:16:31PM -0600, Jens Axboe wrote:
> >>> On 6/27/23 2:15?PM, Kent Overstreet wrote:
> >>>>> to ktest/tests/xfstests/ and run it with -bcachefs, otherwise it kept
> >>>>> failing because it assumed it was XFS.
> >>>>>
> >>>>> I suspected this was just a timing issue, and it looks like that's
> >>>>> exactly what it is. Looking at the test case, it'll randomly kill -9
> >>>>> fsstress, and if that happens while we have io_uring IO pending, then we
> >>>>> process completions inline (for a PF_EXITING current). This means they
> >>>>> get pushed to fallback work, which runs out of line. If we hit that case
> >>>>> AND the timing is such that it hasn't been processed yet, we'll still be
> >>>>> holding a file reference under the mount point and umount will -EBUSY
> >>>>> fail.
> >>>>>
> >>>>> As far as I can tell, this can happen with aio as well, it's just harder
> >>>>> to hit. If the fput happens while the task is exiting, then fput will
> >>>>> end up being delayed through a workqueue as well. The test case assumes
> >>>>> that once it's reaped the exit of the killed task that all files are
> >>>>> released, which isn't necessarily true if they are done out-of-line.
> >>>>
> >>>> Yeah, I traced it through to the delayed fput code as well.
> >>>>
> >>>> I'm not sure delayed fput is responsible here; what I learned when I was
> >>>> tracking this down has mostly fell out of my brain, so take anything I
> >>>> say with a large grain of salt. But I believe I tested with delayed_fput
> >>>> completely disabled, and found another thing in io_uring with the same
> >>>> effect as delayed_fput that wasn't being flushed.
> >>>
> >>> I'm not saying it's delayed_fput(), I'm saying it's the delayed putting
> >>> io_uring can end up doing. But yes, delayed_fput() is another candidate.
> >>
> >> Sorry - was just working through my recollections/initial thought
> >> process out loud
> > 
> > No worries, it might actually be a combination and this is why my
> > io_uring side patch didn't fully resolve it. Wrote a simple reproducer
> > and it seems to reliably trigger it, but is fixed with an flush of the
> > delayed fput list on mount -EBUSY return. Still digging...
> 
> I discussed this with Christian offline. I have a patch that is pretty
> simple, but it does mean that you'd wait for delayed fput flush off
> umount. Which seems kind of iffy.
> 
> I think we need to back up a bit and consider if the kill && umount
> really is sane. If you kill a task that has open files, then any fput
> from that task will end up being delayed. This means that the umount may
> very well fail.

That's why we have MNT_DETACH:

umount2("/mnt", MNT_DETACH)

will succeed even if fds are still open.

> 
> It'd be handy if we could have umount wait for that to finish, but I'm
> not at all confident this is a sane solution for all cases. And as
> discussed, we have no way to even identify which files we'd need to
> flush out of the delayed list.
> 
> Maybe the test case just needs fixing? Christian suggested lazy/detach
> umount and wait for sb release. There's an fsnotify hook for that,
> fsnotify_sb_delete(). Obviously this is a bit more involved, but seems
> to me that this would be the way to make it more reliable when killing
> of tasks with open files are involved.

You can wait on superblock destruction today in multiple ways. Roughly
from the shell this should work:

        root@wittgenstein:~# cat sb_wait.sh
        #! /bin/bash
        
        echo "WARNING WARNING: I SUCK AT SHELL SCRIPTS"
        
        echo "mount fs"
        sudo mount -t tmpfs tmpfs /mnt
        touch /mnt/bla
        
        echo "pin sb by random file for 5s"
        sleep 5 > /mnt/bla &
        
        echo "establish inotify watch for sb destruction"
        inotifywait -e unmount /mnt &
        pid=$!
        
        echo "regular umount - will fail..."
        umount /mnt
        
        findmnt | grep "/mnt"
        
        echo "lazily umount - will succeed"
        umount -l /mnt
        
        findmnt | grep "/mnt"
        
        echo "and now we wait"
        wait $!
        
        echo "done"

Can also use a tiny bpf lsm, fanotify in the future as we plans for
that.
