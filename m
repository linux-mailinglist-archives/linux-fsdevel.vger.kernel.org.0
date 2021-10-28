Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B0943E486
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhJ1PFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhJ1PFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:05:36 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A7C061570;
        Thu, 28 Oct 2021 08:03:07 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j3so7215817ilr.6;
        Thu, 28 Oct 2021 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTWh4Okm1+p/YQAesadMe8LIMp+KQN7lDMfYNMC59vk=;
        b=I49wb6nTPYEiCcPmqQj2n46yc6VDg5xJgv+Od4DeshlfH84fQ3GMV4aaWszeHc5rdm
         uJDqP1NyNCGpOdtxQFuEAF5aghmyjwERCNz9Y+UFgSNvFDl1ne81cjxI3abKWSImzohh
         ggt95mbS0NdwPCb4NHlpHTYQ7eZI2UHW9xgzltEdBdtbbhBW+TPAV/6qfA50qIznebpP
         VlnKLs9+jwZ6e5K5b5AgL7Qy+a6G0e4e0jlUPKZxvg2TpmdKJf8juQBpIE2gokpYyaHY
         N4Mi4dRdfg5JLmO6F3QXg152B7uyzrKHjfLyPfszJ5xTNp3QTCiXEpcBhpBNUqxQ7LGi
         njrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTWh4Okm1+p/YQAesadMe8LIMp+KQN7lDMfYNMC59vk=;
        b=mvDmMUIBv1GJQzg5y8Fuk/szCxEbrIQUNY3XVcKZXBoAKHTK05vbr+N7VzZtfkSEA2
         4e0g9c3yJgf1V/hWk8+72FPiRvtA/RxNgkFCK6zj7eoS0bj4JSf9YiMCHjBeZVMC9QNo
         4gGkLpF4etvAg7L9cRRCoeFhEN4/ELxtd/UXKWjTTfh0xWJmWkfYNcjgEpMUyhner3Gg
         aizUrXBK9GKSbMrhRYMCsASvXVbSojmLHOI3tgIiTI0uLdCymgli/uDlahOp/bJVA5tI
         ZffWglVCiWg86r/+GY10vUGkGP5SE0Ypwu0elFbWS+STBoe8hmSXzby60tIZzFB6FljM
         SlxQ==
X-Gm-Message-State: AOAM531mNQboerjkfB4wtl5vb7IKKa+hB00+NHNbN5a9fMBq1gGp4Czz
        WGg881mxxwIv23WPUS+h30gD+PTFEHsxWcAm6zE=
X-Google-Smtp-Source: ABdhPJwm7cZOSkD4PDVjAKfDvpzMKJHc86x0QxxDtkB6D7ZEBvFKVv7YgkT+HMOK7q7M6BWeZYGIgOl3bBCrMNO7ds8=
X-Received: by 2002:a05:6e02:2169:: with SMTP id s9mr3630226ilv.27.1635433386956;
 Thu, 28 Oct 2021 08:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
 <20211020173729.GF16460@quack2.suse.cz> <CAOOPZo43cwh5ujm3n-r9Bih=7gS7Oav0B=J_8AepWDgdeBRkYA@mail.gmail.com>
 <20211021080304.GB5784@quack2.suse.cz> <CAOOPZo7DfbwO5tmpbpNw7T9AgN7ALDc2S8N+0TsDnvEqMZzMmg@mail.gmail.com>
 <20211022093120.GG1026@quack2.suse.cz> <CAOOPZo7E8uw3s0d+XwQnKsq1CC4SuLe6hxEDD-v=cDThwmsMww@mail.gmail.com>
 <20211025155713.GD12157@quack2.suse.cz>
In-Reply-To: <20211025155713.GD12157@quack2.suse.cz>
From:   Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date:   Thu, 28 Oct 2021 23:02:55 +0800
Message-ID: <CAOOPZo4Chk-Ac8f=gKa3jQZgYjt3CC6x5+Ff=zaAEPLHG==_+g@mail.gmail.com>
Subject: Re: Problem with direct IO
To:     Jan Kara <jack@suse.cz>
Cc:     viro@zeniv.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>,
        tytso@mit.edu, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org,
        =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:57 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 23-10-21 10:06:24, Zhengyuan Liu wrote:
> > On Fri, Oct 22, 2021 at 5:31 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > > Can you post output of "dumpe2fs -h <device>" for the filesystem where the
> > > > > > > problem happens? Thanks!
> > > > > >
> > > > > > Sure, the output is:
> > > > > >
> > > > > > # dumpe2fs -h /dev/sda3
> > > > > > dumpe2fs 1.45.3 (14-Jul-2019)
> > > > > > Filesystem volume name:   <none>
> > > > > > Last mounted on:          /data
> > > > > > Filesystem UUID:          09a51146-b325-48bb-be63-c9df539a90a1
> > > > > > Filesystem magic number:  0xEF53
> > > > > > Filesystem revision #:    1 (dynamic)
> > > > > > Filesystem features:      has_journal ext_attr resize_inode dir_index
> > > > > > filetype needs_recovery sparse_super large_file
> > > > >
> > > > > Thanks for the data. OK, a filesystem without extents. Does your test by
> > > > > any chance try to do direct IO to a hole in a file? Because that is not
> > > > > (and never was) supported without extents. Also the fact that you don't see
> > > > > the problem with ext4 (which means extents support) would be pointing in
> > > > > that direction.
> > > >
> > > > I am not sure if it trys to do direct IO to a hole or not, is there any
> > > > way to check?  If you have a simple test to reproduce please let me know,
> > > > we are glad to try.
> > >
> > > Can you enable following tracing?
> >
> > Sure, but let's confirm before doing that, it seems Ext4 doesn't
> > support iomap in
> > V4.19 which could also reproduce the problem, so if it is necessary to
> > do the following
> > tracing? or should we modify the tracing if under V4.19?
>
> Well, iomap is just a different generic framework for doing direct IO. The
> fact that you can observe the problem both with iomap and the old direct IO
> framework is one of the reasons why I think the problem is actually that
> the file has holes (unallocated space in the middle).
>
> > > echo 1 >/sys/kernel/debug/tracing/events/ext4/ext4_ind_map_blocks_exit/enable
> > > echo iomap_dio_rw >/sys/kernel/debug/tracing/set_ftrace_filter
> > > echo "function_graph" >/sys/kernel/debug/tracing/current_tracer
>
> If you want to trace a kernel were ext4 direct IO path is not yet
> converted to iomap framework you need to replace tracing of iomap_dio_rw
> with:
>
> echo __blockdev_direct_IO >/sys/kernel/debug/tracing/set_ftrace_filter

Sorry for the late reply, because it is hard to reproduce when enabling ftrace.
I'll post here right after getting useful data.

> > > And then gather output from /sys/kernel/debug/tracing/trace_pipe. Once the
> > > problem reproduces, you can gather the problematic file name from dmesg, find
> > > inode number from "stat <filename>" and provide that all to me? Thanks!
>
