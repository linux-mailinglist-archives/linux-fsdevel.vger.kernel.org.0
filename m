Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1001DEBBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgEVPXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbgEVPXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 11:23:45 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910BEC05BD43
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 08:23:44 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z18so13051954lji.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LYLW4XgxCHGQAPyu7jIYDLodYamikRXnpZR2VxGlLA=;
        b=qMpVh1q07AGFsm58/BGvwprcm6g6DdDsidCsRul9NXuvZLs3jt8ZZM1iqhP6j5MuKg
         ArW1dKvi/EtWYZHaQnix+YMSWokoLwshcnE03EnVAaQ5yS/hdSgqAxixwMzBPGXE9GS4
         SYgWFMyxqXU0pYlunlgTPNHhWFz0nQnU8bCAe4rvnPxpddwPPoNBx6NLzdioNse3GoSK
         bwL/OSH1qz92hIZuu1lbkUobRXdtWyoAgWG7uh1yN0OtFHh/UWGuZiaHzRWelCwfB/vO
         eu2RAYJxGrMIDOMY76qm5g2oicRw260OqTDQ7CPRKgmuqlT0N/UxK1bKN+5qlQD7Q1W3
         9syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LYLW4XgxCHGQAPyu7jIYDLodYamikRXnpZR2VxGlLA=;
        b=lB9XbIkYV1rN5ePjLhAlU4UOxL7tvSJZgs6JaNNWCTqu9RxzaMySSH6ivdnjc8Lr8f
         /5t13F88l9NFxG6+/gF/ofZWDkRDzqCaurBLXxld+/1xdHc1kjjnKfZOvgS8WMFgwitH
         lsVylazcMiS7KRIxhqoP+k3JY46P5m1AK1k9c7Yrb2s7DZZOjQgJsswjWSY+aJkwrVbD
         LD0ITVUq/nRrgQxpRM4xK72oF+pW3x+m67wdBpeY8p3EgmJQMyIqty3zLE5hSx93XRkU
         yAG2AsJHPHk886dVH5nehJZ/Qdqsmba76ly8CkkmByflzZJ8R6fq9Kmjdj+FpWBo51+j
         JU0g==
X-Gm-Message-State: AOAM531P9bVbTXupHaDPhW3ATaDH8nsLNshgeRhpDcuXmrNIH6ejH1n9
        jwOwtnNCv9WMTYyWeJjueYnpuS2kh2VfWL5M6EvOZQ==
X-Google-Smtp-Source: ABdhPJxtZ1U8ovB8aF+Rfy6pIrWQwZnDuKL37YEr6vnxv0v/YlOJVdFoP/A2DjZHIcsJdOle+uamDe5EXw6g8lhFxV4=
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr7660654ljj.43.1590161022713;
 Fri, 22 May 2020 08:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz>
In-Reply-To: <20200522144100.GE14199@quack2.suse.cz>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 22 May 2020 17:23:30 +0200
Message-ID: <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
Subject: Re: Writeback bug causing writeback stalls
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        miklos@szeredi.hu, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ dropped android-storage-core@google.com from CC: since that list
can't receive emails from outside google.com - sorry about that ]

Hi Jan,

On Fri, May 22, 2020 at 4:41 PM Jan Kara <jack@suse.cz> wrote:
> > The easiest way to fix this, I think, is to call requeue_inode() at the end of
> > writeback_single_inode(), much like it is called from writeback_sb_inodes().
> > However, requeue_inode() has the following ominous warning:
> >
> > /*
> >  * Find proper writeback list for the inode depending on its current state and
> >  * possibly also change of its state while we were doing writeback.  Here we
> >  * handle things such as livelock prevention or fairness of writeback among
> >  * inodes. This function can be called only by flusher thread - noone else
> >  * processes all inodes in writeback lists and requeueing inodes behind flusher
> >  * thread's back can have unexpected consequences.
> >  */
> >
> > Obviously this is very critical code both from a correctness and a performance
> > point of view, so I wanted to run this by the maintainers and folks who have
> > contributed to this code first.
>
> Sadly, the fix won't be so easy. The main problem with calling
> requeue_inode() from writeback_single_inode() is that if there's parallel
> sync(2) call, inode->i_io_list is used to track all inodes that need writing
> before sync(2) can complete. So requeueing inodes in parallel while sync(2)
> runs can result in breaking data integrity guarantees of it.

Ah, makes sense.

> But I agree
> we need to find some mechanism to safely move inode to appropriate dirty
> list reasonably quickly.
>
> Probably I'd add an inode state flag telling that inode is queued for
> writeback by flush worker and we won't touch dirty lists in that case,
> otherwise we are safe to update current writeback list as needed. I'll work
> on fixing this as when I was reading the code I've noticed there are other
> quirks in the code as well. Thanks for the report!

Thanks! While looking at the code I also saw some other paths that
appeared to be racy, though I haven't worked them out in detail to
confirm that - the locking around the inode and writeback lists is
tricky. What's the best way to follow up on those? Happy to post them
to this same thread after I spend a bit more time looking at the code.

Thanks,
Martijn


>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
