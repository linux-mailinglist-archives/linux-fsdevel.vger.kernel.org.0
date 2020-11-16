Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E050F2B440C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 13:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKPMwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 07:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKPMwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:52:45 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB0EC0613CF;
        Mon, 16 Nov 2020 04:52:44 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id l12so15149425ilo.1;
        Mon, 16 Nov 2020 04:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYFJfhD9+VGk5nB7KbHVQM1w8ftiWzI/nrysZat4Oco=;
        b=iPJyEoEB9JjFXgK3r31SOJYjb1GuVwe6a82sv9F/5KfSXi+S+lxL6Q6x6sGNX8cOWf
         /tCrNCYoUXX+ppvhVeRZf2z5ppt6p7ZbPKZzWWDJencUwz3Slw7Frw7rs4ip3idnpdC3
         at5mx412ZAHTTyqP9bTnLpIpvhjGMIUpZJT7yksFmi1+Luo94pR6RYmuxRxvUSAEM4lV
         yzZxcmpgd5bXDXYG1DfDhyODBSCpfEj09Cif196pheLDFavZEfg6coHZjhP61g8HGl05
         firNTuq9nqYGtBD4WyNWCC+hfnq/yPczUHFXLuvri7dGHq5CM+Uy+piu1ZvSBl2lbkTZ
         JcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYFJfhD9+VGk5nB7KbHVQM1w8ftiWzI/nrysZat4Oco=;
        b=icPZVu+zO+LDE81jLi58vmrWVnMxc5giEknQQzt8ubsW1LdQyJbYNGySj1dnUnVne7
         3N9JSbhsV8NxRyRcUollqvlDfwjsE5W1X8WodzTumtA+qCBpJgm0yYzrK/0GJKKQDKBt
         gSCXIs7cvzQ8etVBqLaHSejXupTFbh/c/ThmKXcDHUTRPNeqX+0tSjSuRKvXMNYh0o9D
         Cp1APezcdw5mWgu3sp925mriLw3DftDGY2nSmh/gGCWEB3aS9/Vow347B3xQZJ2EqUcY
         q8KkWplbNAaIMwkTi4zQ+V0k3DZPnkqdaAt5uRxwDa8+h6S48urUAD7etFmdjxRVYm7Q
         7Duw==
X-Gm-Message-State: AOAM533g8darhXm7AtEA0a2t7yR1eTMefnuXkDdgtl27jyrtN69nTXG6
        SF/pAVTaW37UjMhwUJ8G2SjhPHerf43XfBbaVZiYzwEe9Sw=
X-Google-Smtp-Source: ABdhPJx7AV56jp+TY+Lgxq5Hw4KHNz9wMT73gxT6YicwMEweQJWmHetO6gtLzsmu60AbF5KMUVdEbpjahbkjXbjJVZM=
X-Received: by 2002:a92:8541:: with SMTP id f62mr8506494ilh.9.1605531164238;
 Mon, 16 Nov 2020 04:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20201116045758.21774-1-sargun@sargun.me> <20201116045758.21774-4-sargun@sargun.me>
 <CAOQ4uxh9oa5TWNY4byNyeBGUe7wyON2NJ2_rj5GiYD_0wBOXGA@mail.gmail.com>
 <20201116103013.GA13259@ircssh-2.c.rugged-nimbus-611.internal> <CAOQ4uxjmKewbdwCQgGb4ERJXX_oA+dyOjc9M-Y0AWdNo73Xz-A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjmKewbdwCQgGb4ERJXX_oA+dyOjc9M-Y0AWdNo73Xz-A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Nov 2020 14:52:33 +0200
Message-ID: <CAOQ4uxgGCQ1UCMZRP0OsUQFuttAX5=Uzy2VKD05AKonYdKzYXw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 1:17 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > +       inode_lock_nested(d_dirty->d_inode, I_MUTEX_XATTR);
> > >
> > > What's this lock for?
> > >
> > I need to take a lock on this inode to prevent modifications to it, right, or is
> > getting the xattr safe?
>
> No. see Documentation/filesystems/locking.rst.
>
> >
> > > > +       err = ovl_do_getxattr(d_dirty, OVL_XATTR_VOLATILE, &info, sizeof(info));
> > > > +       inode_unlock(d_dirty->d_inode);
> > > > +       if (err != sizeof(info))
> > > > +               goto out_putdirty;
> > > > +
> > > > +       if (!uuid_equal(&overlay_boot_id, &info.overlay_boot_id)) {
> > > > +               pr_debug("boot id has changed (reboot or module reloaded)\n");
> > > > +               goto out_putdirty;
> > > > +       }
> > > > +
> > > > +       if (d_dirty->d_inode->i_sb->s_instance_id != info.s_instance_id) {
> > > > +               pr_debug("workdir has been unmounted and remounted\n");
> > > > +               goto out_putdirty;
> > > > +       }
> > > > +
> > > > +       err = errseq_check(&d_dirty->d_inode->i_sb->s_wb_err, info.errseq);
> > > > +       if (err) {
> > > > +               pr_debug("workdir dir has experienced errors: %d\n", err);
> > > > +               goto out_putdirty;
> > > > +       }
> > >
> > > Please put all the above including getxattr in helper ovl_verify_volatile_info()
> > >
> > Is it okay if the helper stays in super.c?
> >
>
> Yes.
>
> >
> > > > +
> > > > +       /* Dirty file is okay, delete it. */
> > > > +       ret = ovl_do_unlink(d_volatile->d_inode, d_dirty);
> > >
> > > That's a problem. By doing this, you have now approved a regular overlay
> > > re-mount, but you need only approve a volatile overlay re-mount.
> > > Need to pass ofs to ovl_workdir_cleanup{,_recurse}.
> > >
> > I can add a check to make sure this behaviour is only allowed on remounts back
> > into volatile. There's technically a race condition here, where if there
> > is an error between this check, and the mounting being finished, the FS
> > could be dirty, but that already exists with the impl today.
> >
>
> If you follow my suggestion below and never unlink dirty file,
> the filesystem will never be not-dirty so it is safer.
>

To clarify, as I wrote, there are two options.
The first option, as your patch did, removes the dirty file in
ovl_workdir_cleanup()
and re-creates it in ovl_make_workdir().

The second option, which I prefer, is to keep the dirty file, because until
syncfs was run these workdir/upperdir are dirty and should not be reused
should a crash happen after the dirty file removal.

But the second option means that ovl_workdir_cleanup() returns with
"work" directory not removed and ovl_workdir_create() is not prepared
for that.

My suggestion is to return 1 from ovl_workdir_cleanup,{_recurrsive}
for the case of successful cleanup with remaining and verified
work/incompat dir.

ovl_workdir_cleanup() should not call ovl_cleanup() which prints an
error in case ovl_workdir_cleanup_recurse() returned 1.
ovl_workdir_create() should goto out_unlock in case ovl_workdir_cleanup()
returned 1.

Hope I am not forgetting anything.

Thanks,
Amir.
