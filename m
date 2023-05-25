Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE607119F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 00:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbjEYWEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242090AbjEYWEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 18:04:32 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CFBCC;
        Thu, 25 May 2023 15:04:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af290cf9b7so518001fa.3;
        Thu, 25 May 2023 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685052270; x=1687644270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BsY/WgiwAnYCALQVm6Bp47qhqPyD/a7vg0rsgz10LlE=;
        b=TUo2WvnfP9OGI1VxpWw2n8J8rt9QR+/8yVLJTqcGcnMZdpcc9kBW0J7Mtb/3X4/jr0
         7ar5NHR0CD6CBCWzyR+DQFLXlGfqwndERiv1vZXjEu4e4eiGkqvBRDI9pSkZuhmYlzjE
         nuF/jwfkacKlSSspRImeupNYWJ/p0Y5U6DLX6oauxGRFLkVhsbpdQHj961elAUzWnvQN
         SeDh3NrzNsl99rlHKcJa6ZWNGeLt4vSyBZycxW+fNpGXuIFWlX8eo7O3Gy99Lvp+ikfI
         g8JA8Tdj4/sU2Z4RWsADxYZEEMfGlO/jP9JPBw3dQclGKNdWlxeu08IehtQRB1gSqdOH
         5YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685052270; x=1687644270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsY/WgiwAnYCALQVm6Bp47qhqPyD/a7vg0rsgz10LlE=;
        b=j0kD13X0eFvOAs4tth3I8TAMLYf/rVJY9JC24bvWd0swqjUJlX3LL8N/fA9ZGmk1cv
         oICgdAQfpKR6LJ+njLfv9/YEScbo270XuCfrsoC+9Gz0F9CvGNoEtor9YyAKq2VqVtbX
         ymCQdpAZbak6ieGeQMVXN6QkjSrdJcSLmUqFoRCNB+L/FsJ8P90VpqPSUG5PaQSuuRWQ
         RNTPuh/S+CLtgu6AsJGRnskohhpdCXu9TlkK0ThODGnaqnzLrQr959h6GiHltwdelxpr
         xrsH5RncisDyiHRWbUDy6jsCcK+X6qOceRYHMTlXlFw2MyRo6exFr9fkKWTInZtsQYxs
         an2A==
X-Gm-Message-State: AC+VfDz+cvAeKZGoNatGYq3rqsPwXpUy3letMuOMvmYtPWUPTafSbCbw
        G1Mi6IP+wyLKc4sutxiJHRD8ADwADZCtlBhI7Bg=
X-Google-Smtp-Source: ACHHUZ6atKuSW0mxmBEyZwRwKLDLYOhQEiYiF6zIejDH2dcPtMDsGBAsJ15ONxXwAJhKNJsWeD9VDTirPe6qiM6rveg=
X-Received: by 2002:a2e:3005:0:b0:2ac:6038:ece5 with SMTP id
 w5-20020a2e3005000000b002ac6038ece5mr1292743ljw.49.1685052269350; Thu, 25 May
 2023 15:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev> <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan> <20230523133431.wwrkjtptu6vqqh5e@quack3>
In-Reply-To: <20230523133431.wwrkjtptu6vqqh5e@quack3>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 26 May 2023 00:04:18 +0200
Message-ID: <CAHpGcMLdPAcFJnMii0eq=hyK2UX1L9E19wRKKp7LMr971nnL7w@mail.gmail.com>
Subject: Re: [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
To:     Jan Kara <jack@suse.cz>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>, dhowells@redhat.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 23. Mai 2023 um 15:37 Uhr schrieb Jan Kara <jack@suse.cz>:
> On Wed 10-05-23 02:18:45, Kent Overstreet wrote:
> > On Wed, May 10, 2023 at 03:07:37AM +0200, Jan Kara wrote:
> > > On Tue 09-05-23 12:56:31, Kent Overstreet wrote:
> > > > From: Kent Overstreet <kent.overstreet@gmail.com>
> > > >
> > > > This is used by bcachefs to fix a page cache coherency issue with
> > > > O_DIRECT writes.
> > > >
> > > > Also relevant: mapping->invalidate_lock, see below.
> > > >
> > > > O_DIRECT writes (and other filesystem operations that modify file data
> > > > while bypassing the page cache) need to shoot down ranges of the page
> > > > cache - and additionally, need locking to prevent those pages from
> > > > pulled back in.
> > > >
> > > > But O_DIRECT writes invoke the page fault handler (via get_user_pages),
> > > > and the page fault handler will need to take that same lock - this is a
> > > > classic recursive deadlock if userspace has mmaped the file they're DIO
> > > > writing to and uses those pages for the buffer to write from, and it's a
> > > > lock ordering deadlock in general.
> > > >
> > > > Thus we need a way to signal from the dio code to the page fault handler
> > > > when we already are holding the pagecache add lock on an address space -
> > > > this patch just adds a member to task_struct for this purpose. For now
> > > > only bcachefs is implementing this locking, though it may be moved out
> > > > of bcachefs and made available to other filesystems in the future.
> > >
> > > It would be nice to have at least a link to the code that's actually using
> > > the field you are adding.
> >
> > Bit of a trick to link to a _later_ patch in the series from a commit
> > message, but...
> >
> > https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/fs-io.c#n975
> > https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/fs-io.c#n2454
>
> Thanks and I'm sorry for the delay.
>
> > > Also I think we were already through this discussion [1] and we ended up
> > > agreeing that your scheme actually solves only the AA deadlock but a
> > > malicious userspace can easily create AB BA deadlock by running direct IO
> > > to file A using mapped file B as a buffer *and* direct IO to file B using
> > > mapped file A as a buffer.
> >
> > No, that's definitely handled (and you can see it in the code I linked),
> > and I wrote a torture test for fstests as well.
>
> I've checked the code and AFAICT it is all indeed handled. BTW, I've now
> remembered that GFS2 has dealt with the same deadlocks - b01b2d72da25
> ("gfs2: Fix mmap + page fault deadlocks for direct I/O") - in a different
> way (by prefaulting pages from the iter before grabbing the problematic
> lock and then disabling page faults for the iomap_dio_rw() call). I guess
> we should somehow unify these schemes so that we don't have two mechanisms
> for avoiding exactly the same deadlock. Adding GFS2 guys to CC.
>
> Also good that you've written a fstest for this, that is definitely a useful
> addition, although I suspect GFS2 guys added a test for this not so long
> ago when testing their stuff. Maybe they have a pointer handy?

Ah yes, that's xfstests commit d3cbdabf ("generic: Test page faults
during read and write").

Thanks,
Andreas

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
