Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29F2711A20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 00:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjEYWZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 18:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEYWZp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 18:25:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0A90;
        Thu, 25 May 2023 15:25:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af28a07be9so708331fa.2;
        Thu, 25 May 2023 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685053543; x=1687645543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GAN3Cx1p5MyYzQJb5sHRi3vQVVygdiuaCzAmsMhMUvA=;
        b=jHS1x1a7b/nDLh+CMl39k4FkY9/0/WNnNJPzkTaLu0HsnjE75KwMxKXJd0/ikaE7zA
         0R0hpfq4G90Fq1oYyNAIZPol6ugM7J73buCxqmc80t0Mk3ZMljI+/sz0dM81wFfpK08C
         GAL0NsaEFi9GhA6EBczAENpIR3OYblW4iZ6JrITaAf9NoULq2r2FScBpwuIcr1zYcCxw
         eLc9alcN641yZ34di6wspk/HrBSfp4FtJSdUqeW9UdCNC5VqPEDwhmukSOYzJR9ikVVQ
         46TRc8xH0nU4RmfSZXNKY21XV66lHrSdTM71Ed2HbzxWsbFuZjqlr3pgwObIhzgNyA+R
         8+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685053543; x=1687645543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAN3Cx1p5MyYzQJb5sHRi3vQVVygdiuaCzAmsMhMUvA=;
        b=BIHJ3DkJmTL04QCe2lHdjEAoCUcGopjS/Kk0/VIGWBz/iEU6Mu5E9qIjaC8NCAJqjl
         1ySTlVKdga++H7+8rc0aEeK7ertuGsdT9APxkQFvBhCGk3pXv9v3Fsf2ttaLPn9iX7+o
         QelLFqwbHxSnYVpu1YE5t/6cnKTkLA8C5RNfAeOaHgu5DDzGwPZMWo5yZtUmT4cUJgor
         Ic0jl2aZXc0syWWFwcElaXgY6nlhlBihbRxm1hEq3PuaeX7K1yLgg9qSdTcwouwG+yaT
         lDWUE8iC/de24V8igxj4nukoaCxQyQ3EUxtzj7Ajn8cAxrpyaq4J0UUila13G6Vd7Yvb
         o3fQ==
X-Gm-Message-State: AC+VfDx9xp3qoQ5k3lvVRbe30LAaxXAWymNI/tqHXbE3l3y1JxLq8hPN
        vU2f7pjIthEI+IgI//bZpKNTyPVZwRWdqdqEkHQ=
X-Google-Smtp-Source: ACHHUZ5OfQoDE18eXEchfzDFmKhoCe5IbXcKRUwu/cv5RMad8zV4eDRaJslLDqpqQjkKowHsPpaWzhKXbs/S/3x0bw4=
X-Received: by 2002:a2e:7c14:0:b0:2a8:a93d:7b41 with SMTP id
 x20-20020a2e7c14000000b002a8a93d7b41mr23093ljc.8.1685053542390; Thu, 25 May
 2023 15:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev> <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan> <20230523133431.wwrkjtptu6vqqh5e@quack3> <ZGzoJLCRLk+pCKAk@infradead.org>
In-Reply-To: <ZGzoJLCRLk+pCKAk@infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 26 May 2023 00:25:31 +0200
Message-ID: <CAHpGcML0CZ1RGkOf26iYt_tK0Ux=cfdW8d3bjMVbjXLr91cs+g@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        cluster-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 23. Mai 2023 um 18:28 Uhr schrieb Christoph Hellwig <hch@infradead.org>:
> On Tue, May 23, 2023 at 03:34:31PM +0200, Jan Kara wrote:
> > I've checked the code and AFAICT it is all indeed handled. BTW, I've now
> > remembered that GFS2 has dealt with the same deadlocks - b01b2d72da25
> > ("gfs2: Fix mmap + page fault deadlocks for direct I/O") - in a different
> > way (by prefaulting pages from the iter before grabbing the problematic
> > lock and then disabling page faults for the iomap_dio_rw() call). I guess
> > we should somehow unify these schemes so that we don't have two mechanisms
> > for avoiding exactly the same deadlock. Adding GFS2 guys to CC.
> >
> > Also good that you've written a fstest for this, that is definitely a useful
> > addition, although I suspect GFS2 guys added a test for this not so long
> > ago when testing their stuff. Maybe they have a pointer handy?
>
> generic/708 is the btrfs version of this.
>
> But I think all of the file systems that have this deadlock are actually
> fundamentally broken because they have a mess up locking hierarchy
> where page faults take the same lock that is held over the the direct I/
> operation.  And the right thing is to fix this.  I have work in progress
> for btrfs, and something similar should apply to gfs2, with the added
> complication that it probably means a revision to their network
> protocol.

We do disable page faults, and there can be deadlocks in page fault
handlers while no page faults are allowed.

I'm roughly aware of the locking hierarchy that other filesystems use,
and that's something we want to avoid because of two reasons: (1) it
would be an incompatible change, and (2) we want to avoid cluster-wide
locking operations as much as possible because they are very slow.

These kinds of locking conflicts are so rare in practice that the
theoretical inefficiency of having to retry the operation doesn't
matter.

> I'm absolutely not in favour to add workarounds for thes kind of locking
> problems to the core kernel.  I already feel bad for allowing the
> small workaround in iomap for btrfs, as just fixing the locking back
> then would have avoid massive ratholing.

Please let me know when those btrfs changes are in a presentable shape ...

Thanks,
Andreas
