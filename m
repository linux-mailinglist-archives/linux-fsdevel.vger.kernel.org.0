Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985B851DCE3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383588AbiEFQJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443416AbiEFQJV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:09:21 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98186EC5E
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 09:04:59 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id z144so7603686vsz.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 May 2022 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TD85c6gvCuUPWLjy+YVzYqQmgRz1AI6Bgv200edN8i4=;
        b=ZR7IAgc0gCuvwOo+j7bPtlXxNkBUp7A8uX0IJgAWvyvahlN+goyBhqkXphvGOOUmTq
         f022KPI/ciPfGA9ibcKZizYGOwWybxVQKDPnQGkMBPHW0ZZjpcpWwAO8+z+/RnHG42U5
         vDd9+JEffXwBGD7LhP9gCV6zw3jcs6D4fmvMRrs6CW9j+tdiCmhlFqmL1aCGQyTy7tjf
         l6V5j5nmfdU5E1iXU5S/gbT0ARTLZKXFR21SEiXRKuf7hMR3wTnkJBHy1f8a/V3TjO7I
         UYKMGRhq42ru8RLgdDC2TYPPs8eheHPyIUEMxOhhh+BHgJJ6pwdKcYumY0eimw/La1OP
         k2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TD85c6gvCuUPWLjy+YVzYqQmgRz1AI6Bgv200edN8i4=;
        b=t3x7RUm5hfze8ddtOZyKkL5YcAtyVARThUW3h8Pv+T9hwvgViGhy9oEAkQiX7F+7MQ
         JKoY218jmx5UPDKvadl4miS/nPXaLdA+YdFCLUIgSglO+74kJIePfXRJ8RyXb0rQJDH0
         euS3/zLv6WyTQFfm9j4Ejjvb598AQTOsOs5MwEtBmDucEl5URtgZIf7VvGJFuHttVdHn
         boz8REGLsuAM2kQwDNNrZVSipS/rg973e1mwxjDgzkKcAnAgvp03nY1Eg+TrIhV5idPA
         PDEfLG9B5KiB4giSF/DKIPUf8DxJ/TDiAtT4wirdRl0rnz5It3kTCJUSTWr2rKW+RnfB
         AOMg==
X-Gm-Message-State: AOAM532tV4oPnO4chNNBDNhzJ6yrELEKrLSRO6vPT6dTr7Tpa76bHdtM
        ItxM5O1yucYAmhdlGJSprUJkLD0HbT4+mScoWOE=
X-Google-Smtp-Source: ABdhPJzZhlfrNzHcoTJ0m6WHCP468WUq/793WSz6cvOqc3930rKAR9k0HmLG2cd/YKps8MMpkSMJAlMfP90SXGukuCg=
X-Received: by 2002:a67:c218:0:b0:32d:19b:b482 with SMTP id
 i24-20020a67c218000000b0032d019bb482mr1359108vsj.40.1651853098891; Fri, 06
 May 2022 09:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220504143924.ix2m3azbxdmx67u6@quack3.lan> <20220504182514.25347-1-sunjunchao2870@gmail.com>
 <20220504193847.lx4eqcnqzqqffbtm@quack3.lan> <CAHB1Naif38Cib5xMLa1nK7-5H4FeLgPMLbBCi-Ze=YNna8ymYA@mail.gmail.com>
 <20220505090059.bgbn7lv2jsvo3vu3@quack3.lan>
In-Reply-To: <20220505090059.bgbn7lv2jsvo3vu3@quack3.lan>
From:   Jchao sun <sunjunchao2870@gmail.com>
Date:   Sat, 7 May 2022 00:04:45 +0800
Message-ID: <CAHB1NahS0+mxTPXNRDmQV6gzPrOQdnCf=G3CMJnrw2XrO42aSg@mail.gmail.com>
Subject: Re: [PATCH v3] writeback: Fix inode->i_io_list not be protected by
 inode->i_lock error
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, May 5, 2022 at 5:01 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 05-05-22 12:45:56, Jchao sun wrote:
> > > On Thu, May 5, 2022 at 3:38 AM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Wed 04-05-22 11:25:14, Jchao Sun wrote:
> > > > > Commit b35250c0816c ("writeback: Protect inode->i_io_list with
> > > > > inode->i_lock") made inode->i_io_list not only protected by
> > > > > wb->list_lock but also inode->i_lock, but inode_io_list_move_locked()
> > > > > was missed. Add lock there and also update comment describing things
> > > > > protected by inode->i_lock.
> > > > >
> > > > > Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with
> > > inode->i_lock")
> > > > > Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>
> > > >
> > > > Almost there :). A few comments below:
> > > >
> > > > > @@ -2402,6 +2404,9 @@ void __mark_inode_dirty(struct inode *inode, int
> > > flags)
> > > > >                       inode->i_state &= ~I_DIRTY_TIME;
> > > > >               inode->i_state |= flags;
> > > > >
> > > > > +             wb = locked_inode_to_wb_and_lock_list(inode);
> > > > > +             spin_lock(&inode->i_lock);
> > > > > +
> > > >
> > >
> > > > > We don't want to lock wb->list_lock if the inode was already dirty (which
> > > > > is a common path). So you want something like:
> > > > >
> > > > >                 if (was_dirty)
> > > > >                         wb = locked_inode_to_wb_and_lock_list(inode);
> > >
> > > I'm a little confused about here. The logic of the current source tree is
> > > like this:
> > >                        if (!was_dirty) {
> > >                                struct bdi_writeback *wb;
> > >                                wb =
> > > locked_inode_to_wb_and_lock_list(inode);
> > >                                ...
> > >                                dirty_list = &wb-> b_dirty_time;
> > >                                assert_spin_locked(&wb->list_lock);
> > >                        }
> > > The logic is the opposite of the logic in the comments, and it seems like
> > > that wb will
> > > absolutely not be NULL.
> > > Why is this? What is the difference between them?
> >
> > Sorry, that was a typo in my suggestion. It should have been
> >
> >                  if (!was_dirty)
> >                          wb = locked_inode_to_wb_and_lock_list(inode);

1. I have noticed that move_expired_inodes() has the logic as follows:

                      list_move(&inode->i_io_list, &tmp);
                      spin_lock(&inode->i_lock);
                      inode->i_state |= I_SYNC_QUEUED;
                      spin_unlock(&inode->i_lock);
                      ...
                      list_move(&inode->i_io_list, dispatch_queue);

   Neither of the two operations on i_io_list are protected with
inode->i_lock. It looks like that
   do this on purpose, I'm a little confused about this.
   I wonder that is this a mistake. or did this on purpose and there
is something I have missed?
   If the later, why is that?

2. I also have some doubts about the results of testing for xfs with
xfstests.I'll describe my test
    steps later. The kernel version used for testing is
5.18.0-rc5-00016-g107c948d1d3e-dirty,
    and the latest commit is 107c948d1d3e ("Merge tag 'seccomp-v5.18-rc6' of
     git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux")

   <a> First tested without this patch, there are always a few fixed cases
          where it will fail, maybe I got something wrong.  Here is
the testing result.
          Failures: xfs/078 xfs/191-input-validation xfs/252 xfs/289
xfs/293 xfs/514
                                   xfs/515 xfs/544
          Failed 8 of 304 tests

   <b> Then tested with the patch which applied your suggestions. The
result is unstable.
           There is a high probability that there will be more
failures(which will report as follows),
           and a small probability that the test result is the same as
the above test which without
           this patch.

           xfs/206 ... umount: /mnt/test: target is busy.
           _check_xfs_filesystem: filesystem on /dev/loop0 has dirty log
           (see /root/xfstests-dev/results/xfs/206.full for details)
            _check_xfs_filesystem: filesystem on /dev/loop0 is inconsistent(r)
            (see /root/xfstests-dev/results/xfs/206.full for details)
            ...
           Failures: xfs/078 xfs/149 xfs/164 xfs/165
xfs/191-input-validation xfs/206 xfs/222
                          xfs/242 xfs/250 xfs/252 xfs/259 xfs/260
xfs/289 xfs/290 xfs/292 xfs/293
                          xfs/514 xfs/515 xfs/544
           Failed 19 of 304 tests.

           I saw that there is a "fatal error: couldn't initialize XFS
library" which means xfs_repair
           have failed.

   <c>  Lastly tested with the patch which applied your suggestions
and some modifications
           which made operations on i_io_list in move_expired_inodes()
will be protected by
           inode->i_lock. There is a high probability that  the result
is the same as the test in <a>,
           and a small probability the same as <b>

   I think I must be missing something I don't understand yet, do I?

3.   Here are my test steps.
            xfs_io -f -c "falloc 0 10g" test.img
            mkfs.xfs test.img
            losetup /dev/loop0 ./test.img
            mount /dev/loop0 /mnt/test
            export TEST_DEV=/dev/loop0
            export TEST_DIR=/mnt/test
            ./check -g xfs/quick
            reboot after the tests(If don't reboot, following test
results will become more unstable
            and have more failures)

            Repeat the above steps.

I'm sorry to bother you, but the results I got are so weird and I
really want to figure it out. Do you have
any suggestions for this? Looking forward to your reply and I'm happy
to provide more info if needed.


>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
