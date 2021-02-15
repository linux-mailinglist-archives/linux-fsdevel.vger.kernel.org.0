Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A048B31B55C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 07:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhBOGM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 01:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhBOGMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 01:12:55 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594EFC061574;
        Sun, 14 Feb 2021 22:12:15 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id o15so4608944ilt.6;
        Sun, 14 Feb 2021 22:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIfzBFyCNv86KZ5EeKdCATv8zV74pSszmiyVwnpE6Nc=;
        b=k0IBTbrK0ESj9dqk3Z3e4KEyh1g/vcsSuFVfp1fSer/oIilr0RdHix+c2QAgcoPE9p
         QMFfuNTMqtPcZncO6cLPA9nlKIOr6rqGaPVVlKM1g/mUpgATLpepq4fnrX7xlzlWoPO6
         CaChIG7Up1dRFW+7LgvDOVR97E91Tw4aJgHMErvwWBwVhW0lqJ2U6pvkK/t2TbBMyZWu
         jaPIJhV7jBgD8aiJTU9PbiOrZry46KkC8ROXITo1ZFVVRA06KabcbK2Hi3tbxQ765Oqj
         Y101ZFwTzkwnuv89UxKYAoTwqEcYVsnwCINgnzWXiaLKS43NZR1W3NknAr3CfzMPQUpW
         NHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIfzBFyCNv86KZ5EeKdCATv8zV74pSszmiyVwnpE6Nc=;
        b=gk1OlE1lQVCP9lusdKStgu6VTU0YDuUyq03ApKLUOZTYYziSFYbA9R0Ndt5jA+Qfzy
         UCeZR7QvukbnnY4xAs4iu4FjmZnPBAkPPRkOs5nW2nACAoEzOIBp1X0g+qspug4PyTys
         5EJdKPC+lAMyFh5+0WMdHjdLoilwwMABApUe4I4O+y/UikK9gX6Ix6fYpzuJGSPfGlQj
         t8ed0igp5mQbv8kIyjwHSA0IKpgJT+xFZ8D4o+btHEP3Ro73fof90f3hcTeCkqAjwmh+
         7lW7YswQhOqeloDZ3Lg4RbL0ILcY4XiTTRJFQV0G/uCYsMePeVMsQm5crHvW2H+yb4Je
         BLOg==
X-Gm-Message-State: AOAM533JE7JWzidYX338mTERhbblEf72BkgwbVlaCzaLSeoDF7gsFoJM
        MnmOt0KPvkZJyRT2sOkdcQeDiDs3C3H/Wu8WNcI=
X-Google-Smtp-Source: ABdhPJyb23eBt7g724jOrO2qq+oMbkHZIz8bp0GNBdYcDx3Cy3rmgj4gyvL7c1Co5feWV7tFpRi2Qd/lsAnw+J53Hp8=
X-Received: by 2002:a92:8e42:: with SMTP id k2mr12099589ilh.250.1613369534723;
 Sun, 14 Feb 2021 22:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com> <CAOQ4uxhovoZ4S3WhXwgYDeOeomBxfQ1BdzSyGdqoVX6boDOkeA@mail.gmail.com>
 <YCY+tjPgcDmgmVD1@kroah.com> <871rdljxtx.fsf@suse.de> <YCZyBZ1iT+MUXLu1@kroah.com>
 <87sg61ihkj.fsf@suse.de>
In-Reply-To: <87sg61ihkj.fsf@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Feb 2021 08:12:03 +0200
Message-ID: <CAOQ4uxi-VuBmE8Ej_B3xmBnn1nmp9qpiA-BkNpPcrE0PCRp1UA@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 2:40 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> Greg KH <gregkh@linuxfoundation.org> writes:
>
> > On Fri, Feb 12, 2021 at 12:05:14PM +0000, Luis Henriques wrote:
> >> Greg KH <gregkh@linuxfoundation.org> writes:
> >>
> >> > On Fri, Feb 12, 2021 at 10:22:16AM +0200, Amir Goldstein wrote:
> >> >> On Fri, Feb 12, 2021 at 9:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >> >> >
> >> >> > On Fri, Feb 12, 2021 at 12:44:00PM +0800, Nicolas Boichat wrote:
> >> >> > > Filesystems such as procfs and sysfs generate their content at
> >> >> > > runtime. This implies the file sizes do not usually match the
> >> >> > > amount of data that can be read from the file, and that seeking
> >> >> > > may not work as intended.
> >> >> > >
> >> >> > > This will be useful to disallow copy_file_range with input files
> >> >> > > from such filesystems.
> >> >> > >
> >> >> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >> >> > > ---
> >> >> > > I first thought of adding a new field to struct file_operations,
> >> >> > > but that doesn't quite scale as every single file creation
> >> >> > > operation would need to be modified.
> >> >> >
> >> >> > Even so, you missed a load of filesystems in the kernel with this patch
> >> >> > series, what makes the ones you did mark here different from the
> >> >> > "internal" filesystems that you did not?
> >> >> >
> >> >> > This feels wrong, why is userspace suddenly breaking?  What changed in
> >> >> > the kernel that caused this?  Procfs has been around for a _very_ long
> >> >> > time :)
> >> >>
> >> >> That would be because of (v5.3):
> >> >>
> >> >> 5dae222a5ff0 vfs: allow copy_file_range to copy across devices
> >> >>
> >> >> The intention of this change (series) was to allow server side copy
> >> >> for nfs and cifs via copy_file_range().
> >> >> This is mostly work by Dave Chinner that I picked up following requests
> >> >> from the NFS folks.
> >> >>
> >> >> But the above change also includes this generic change:
> >> >>
> >> >> -       /* this could be relaxed once a method supports cross-fs copies */
> >> >> -       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> >> >> -               return -EXDEV;
> >> >> -
> >> >>
> >> >> The change of behavior was documented in the commit message.
> >> >> It was also documented in:
> >> >>
> >> >> 88e75e2c5 copy_file_range.2: Kernel v5.3 updates
> >> >>
> >> >> I think our rationale for the generic change was:
> >> >> "Why not? What could go wrong? (TM)"
> >> >> I am not sure if any workload really gained something from this
> >> >> kernel cross-fs CFR.
> >> >
> >> > Why not put that check back?
> >> >
> >> >> In retrospect, I think it would have been safer to allow cross-fs CFR
> >> >> only to the filesystems that implement ->{copy,remap}_file_range()...
> >> >
> >> > Why not make this change?  That seems easier and should fix this for
> >> > everyone, right?
> >> >
> >> >> Our option now are:
> >> >> - Restore the cross-fs restriction into generic_copy_file_range()
> >> >
> >> > Yes.
> >> >
> >>
> >> Restoring this restriction will actually change the current cephfs CFR
> >> behaviour.  Since that commit we have allowed doing remote copies between
> >> different filesystems within the same ceph cluster.  See commit
> >> 6fd4e6348352 ("ceph: allow object copies across different filesystems in
> >> the same cluster").
> >>
> >> Although I'm not aware of any current users for this scenario, the
> >> performance impact can actually be huge as it's the difference between
> >> asking the OSDs for copying a file and doing a full read+write on the
> >> client side.
> >
> > Regression in performance is ok if it fixes a regression for things that
> > used to work just fine in the past :)
> >
> > First rule, make it work.
>
> Sure, I just wanted to point out that *maybe* there are other options than
> simply reverting that commit :-)
>
> Something like the patch below (completely untested!) should revert to the
> old behaviour in filesystems that don't implement the CFR syscall.
>
> Cheers,
> --
> Luis
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 75f764b43418..bf5dccc43cc9 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1406,8 +1406,11 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
>                                                        file_out, pos_out,
>                                                        len, flags);
>
> -       return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -                                      flags);
> +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> +               return -EXDEV;
> +       else
> +               generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> +                                       flags);
>  }
>

Which kernel is this patch based on?

At this point, I am with Dave and Darrick on not falling back to
generic_copy_file_range() at all.

We do not have proof of any workload that benefits from it and the
above patch does not protect from a wierd use case of trying to copy a file
from sysfs to sysfs.

I am indecisive about what should be done with generic_copy_file_range()
called as fallback from within filesystems.

I think the wise choice is to not do the fallback in any case, but this is up
to the specific filesystem maintainers to decide.

Thanks,
Amir.
