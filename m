Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0B601597
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 19:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiJQRmv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 13:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiJQRms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:42:48 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C162D72875;
        Mon, 17 Oct 2022 10:42:45 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id h25so4628115uao.13;
        Mon, 17 Oct 2022 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=en+vQFTkLB93s9ztGc7jfYm6FM8zEzJQ59yjzAUaTfs=;
        b=mCv/GOdx4ar4LgN4cW7jD7qt4ucyL9UiHFB/WR6VwryWHjmnSHDyRoc3o3vNmigcoJ
         YnM3BsJqLeNSCcis10q6g498b/Dd1pyoXZyyM7M5FtoJf1A/dBu0moy5+7Cu0gF2rera
         88OpQYH9WbLiTbFYRRF+yJn8KNxD2jQqk8cNQi7aS7aevNRxWxTEhX84aSF99ZrUScqk
         Nf+d5X2kK9+VxuTPhkVjFpwpdA0PpPt1GYhXOMDaIKFokZapD/cuOhrkzEn050DG6wgO
         WXld2s57l++ymWn656+zjTBF5Jx8tLHnRT8d5XqZ94Hl2uWlG25fUobKgVVbLgat6YhR
         +ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=en+vQFTkLB93s9ztGc7jfYm6FM8zEzJQ59yjzAUaTfs=;
        b=U+OGV9kgXg1GD5zLXtLEgTNmzWHlKNR5SfYzyxLeDR+ojKhB6hYfJjbD0f6gLnCUzt
         QCzc6IGl5u45AM/LK9yGidr3vtWmPgqR/HSk8ZoSVKPRScvRQIlTw2ZtOOC9BULy4XHd
         g2za2H26oM2MW4FUlGA1aWnR1zhb9E0FzKkkJ7RFFAM8KVIeb+rfr9JVAInkz63uvtj4
         Yg+U07Wmm/OzSZSuxP8VfZD9hXIORuZ4m1N5i1qNIQ1YmPY247M6QJV+w01lDLYTjIzV
         ny27bx4FxDCPmPFwJiVqNyroiPz5Z3a6IXmqojgQzswCcrv9qwUslRoWjZXBtcFGYEBy
         wmIQ==
X-Gm-Message-State: ACrzQf1pz2R5VBqqZP6hc0NaRBLe+rkLmH1bflu1uqZ8iotZ3fIML2YY
        evDSIc9aSipNnhtuiXd9pBYKmq304fUApA/faFw=
X-Google-Smtp-Source: AMsMyM5WNA4Xb3/jCLw3t7AhjLcSDbtuMiR/yKbb3qpvlBDLv+Bzyj6riCnXrP4zxRWUUlP6Hucf3jQKHkKWxxk15NY=
X-Received: by 2002:ab0:2998:0:b0:3d6:ec8f:e296 with SMTP id
 u24-20020ab02998000000b003d6ec8fe296mr5541667uap.60.1666028564662; Mon, 17
 Oct 2022 10:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <CAOQ4uxiXU72-cxbpqdv_5BC4VdjGx5V79zycfD3_tPSWixtT3w@mail.gmail.com>
 <87o7ua519v.fsf@oracle.com> <CAOQ4uxiamB8zfr=XTrnKA9BB4=B-DtwOim=xcYNc+vcW=WXv9Q@mail.gmail.com>
 <87lepe4c8i.fsf@oracle.com>
In-Reply-To: <87lepe4c8i.fsf@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Oct 2022 20:42:33 +0300
Message-ID: <CAOQ4uxjJZne8LAp-ehxX9TNFendhyGPngUj6aHCh_Wr7RTp70Q@mail.gmail.com>
Subject: Re: [RFC] fsnotify: allow sleepable child dentry flag update
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 8:00 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Mon, Oct 17, 2022 at 10:59 AM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >>
> >> Amir Goldstein <amir73il@gmail.com> writes:
> [snip]
> >> > I think that d_find_any_alias() should be used to obtain
> >> > the alias with elevated refcount instead of the awkward
> >> > d_u.d_alias iteration loop.
> >>
> >> D'oh! Much better idea :)
> >> Do you think the BUG_ON would still be worthwhile?
> >>
> >
> > Which BUG_ON()?
> > In general no, if there are ever more multiple aliases for
> > a directory inode, updating dentry flags would be the last
> > of our problems.
>
> Sorry, I meant the one in my patch which asserts that the dentry is the
> only alias for that inode. I suppose you're right about having bigger
> problems in that case -- but the existing code "handles" it by iterating
> over the alias list.
>

It is not important IMO.

> >
> >> > In the context of __fsnotify_parent(), I think the optimization
> >> > should stick with updating the flags for the specific child dentry
> >> > that had the false positive parent_watched indication,
> >> > leaving the rest of
> >>
> >> > WOULD that address the performance issues of your workload?
> >>
> >> I think synchronizing the __fsnotify_update_child_dentry_flags() with a
> >> mutex and getting rid of the call from __fsnotify_parent() would go a
> >> *huge* way (maybe 80%?) towards resolving the performance issues we've
> >> seen. To be clear, I'm representing not one single workload, but a few
> >> different customer workloads which center around this area.
> >>
> >> There are some extreme cases I've seen, where the dentry list is so
> >> huge, that even iterating over it once with the parent dentry spinlock
> >> held is enough to trigger softlockups - no need for several calls to
> >> __fsnotify_update_child_dentry_flags() queueing up as described in the
> >> original mail. So ideally, I'd love to try make *something* work with
> >> the cursor idea as well. But I think the two ideas can be separated
> >> easily, and I can discuss with Al further about if cursors can be
> >> salvaged at all.
> >>
> >
> > Assuming that you take the dir inode_lock() in
> > __fsnotify_update_child_dentry_flags(), then I *think* that children
> > dentries cannot be added to dcache and children dentries cannot
> > turn from positive to negative and vice versa.
> >
> > Probably the only thing that can change d_subdirs is children dentries
> > being evicted from dcache(?), so I *think* that once in N children
> > if you can dget(child), drop alias->d_lock, cond_resched(),
> > and then continue d_subdirs iteration from child->d_child.
>
> This sounds like an excellent idea. I can't think of anything which
> would remove a dentry from d_subdirs without the inode lock held.
> Cursors wouldn't move without the lock held in read mode. Temporary
> dentries from d_alloc_parallel are similar - they need the inode locked
> shared in order to be removed from the parent list.
>
> I'll try implementing it (along with the fsnotify changes we've
> discussed in this thread). I'll add a BUG_ON after we wake up from
> COND_RESCHED() to guarantee that the parent is the same dentry as
> expected - just in case the assumption is wrong.

BUG_ON() is almost never a good idea.
If anything you should use if (WARN_ON_ONCE())
and break out of the loop either returning an error
to fanotify_mark() or not.
I personally think that as an unexpected code assertion
returning an error to the user is not a must in this case.

Thanks,
Amir.

>
> Al - if you've read this far :) - does this approach sound reasonable,
> compared to the cursor? I'll send out some concrete patches as soon as
> I've implemented and done a few tests on them.
>
> Thanks,
> Stephen
