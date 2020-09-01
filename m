Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402B6259045
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgIAOXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 10:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgIAOXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:23:06 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31EAC061245
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 07:23:01 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m14so582961qvt.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=quGUUOQsnj0nKT/WAhfV3HFgb488kDC45KlIYy9fT78=;
        b=O0pbfkrVuvQ4XtDJpgLpDmNnmE7fpzdPhbPtODDcNRuOTd7dD9b/IE1b1Yswybf6qj
         D/YFwkpRHt4DVKimrawcJUEkLYpQUUIDlT99IliwA9/5m8P386SBoNgcgkmaudXxTTAA
         GJabKO16qNKZbL7s0NOhwCch5ZboTDNI9GW55gLOUpT5060bPcFb1aK5RzwAql9n7n5K
         X2s8KZ+HbCkls1mOyXkhonS5x8JlslmxnvT6wRpmB3Po87xN3c8ql+EejD83nZdTtBta
         Sb7BI67+oUQmVwSmhuUp7dzlIj3PrURiQtEEsHaGxqNfF5OwnVZbDZBabUvgI8GrwW2Q
         977w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=quGUUOQsnj0nKT/WAhfV3HFgb488kDC45KlIYy9fT78=;
        b=lKnTXWJ5AhA5ZgIe1ic9NhaFx0apYfKzJMac3HgdXZ9ysu3vrxz19ZECnlAEyosqUA
         PxIJCbURYMrqS65yD7TjFtK8TzBrt1Umx9A5ekYfVidZTaVymf+H67BpDkaLFN08O4rT
         EnRsLAcb2Zznez3s5udlhxKfEOwya76y1G7O+6P421BoXL5OZZjhoxwStxkevV63KfpX
         5Y4P/cWZfKl3fCV0oKGM7YE+cODh0Q1JKXVBmSFehMFc+shY4wQjTzDl+9h9Bx/k30z+
         +FfAXbJduejwbDwU8wXUTlxlj8gJcvEf3t/Qd7Ib/WA8GrRDKHssz3F0ntxGCWJywkIH
         3uVQ==
X-Gm-Message-State: AOAM533GRzmDfjq3HSGD0d39eOAW/or3KGZcQ6thbE9R/By4kU/AB21T
        mW9amA2QamTLUcU2aEok56Igyg==
X-Google-Smtp-Source: ABdhPJxbWFRugHWiabXaS77unc1r6Z088JNJumB5tBlF+LPd46BUhC4ACcO50gK5UD8mdIdk1S2MkQ==
X-Received: by 2002:a0c:9b85:: with SMTP id o5mr2285567qve.11.1598970181201;
        Tue, 01 Sep 2020 07:23:01 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r6sm1782341qkc.43.2020.09.01.07.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:22:57 -0700 (PDT)
Date:   Tue, 1 Sep 2020 10:22:51 -0400
From:   Qian Cai <cai@lca.pw>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@canonical.com>, paulmck@kernel.org
Subject: Re: splice: infinite busy loop lockup bug
Message-ID: <20200901142251.GA16065@lca.pw>
References: <00000000000084b59f05abe928ee@google.com>
 <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
 <20200807122727.GR1236603@ZenIV.linux.org.uk>
 <d96b0b3f-51f3-be3d-0a94-16471d6bf892@i-love.sakura.ne.jp>
 <20200901005131.GA3300@lca.pw>
 <CACVXFVNy+qKeSytvDduCuH3HV02mB7i88P27Ou+h=PC22hqwHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVNy+qKeSytvDduCuH3HV02mB7i88P27Ou+h=PC22hqwHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 09:10:05AM +0800, Ming Lei wrote:
> On Tue, Sep 1, 2020 at 8:53 AM Qian Cai <cai@lca.pw> wrote:
> >
> > On Fri, Aug 07, 2020 at 09:34:08PM +0900, Tetsuo Handa wrote:
> > > On 2020/08/07 21:27, Al Viro wrote:
> > > > On Fri, Aug 07, 2020 at 07:35:08PM +0900, Tetsuo Handa wrote:
> > > >> syzbot is reporting hung task at pipe_release() [1], for for_each_bvec() from
> > > >> iterate_bvec() from iterate_all_kinds() from iov_iter_alignment() from
> > > >> ext4_unaligned_io() from ext4_dio_write_iter() from ext4_file_write_iter() from
> > > >> call_write_iter() from do_iter_readv_writev() from do_iter_write() from
> > > >> vfs_iter_write() from iter_file_splice_write() falls into infinite busy loop
> > > >> with pipe->mutex held.
> > > >>
> > > >> The reason of falling into infinite busy loop is that iter_file_splice_write()
> > > >> for some reason generates "struct bio_vec" entry with .bv_len=0 and .bv_offset=0
> > > >> while for_each_bvec() cannot handle .bv_len == 0.
> > > >
> > > > broken in 1bdc76aea115 "iov_iter: use bvec iterator to implement iterate_bvec()",
> > > > unless I'm misreading it...
> >
> > I have been chasing something similar for a while as in,
> >
> > https://lore.kernel.org/linux-fsdevel/89F418A9-EB20-48CB-9AE0-52C700E6BB74@lca.pw/
> >
> > In my case, it seems the endless loop happens in iterate_iovec() instead where
> > I put a debug patch here,
> >
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -33,6 +33,7 @@
> >                 if (unlikely(!__v.iov_len))             \
> >                         continue;                       \
> >                 __v.iov_base = __p->iov_base;           \
> > +               printk_ratelimited("ITER_IOVEC left = %zu, n = %zu\n", left, n); \
> >                 left = (STEP);                          \
> >                 __v.iov_len -= left;                    \
> >                 skip = __v.iov_len;                     \
> >
> > and end up seeing overflows ("n" supposes to be less than PAGE_SIZE) before the
> > soft-lockups and a dead system,
> >
> > [ 4300.249180][T470195] ITER_IOVEC left = 0, n = 48566423
> >
> > Thoughts?
> 
> Does the following patch make a difference for you?
> 
> https://lore.kernel.org/linux-block/20200817100055.2495905-1-ming.lei@redhat.com/

Yes, it does. I could no longer be able to reproduce the soft lockups with the
patch applied.
