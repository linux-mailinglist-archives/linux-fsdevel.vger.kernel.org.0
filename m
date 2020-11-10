Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0232ACBE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgKJDdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgKJDds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:33:48 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B074BC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:33:48 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id i186so10305121ybc.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 19:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eq2K5OkFTuLSqgbW/r7s9fYviyZwt+wOFnNmsM9kDM=;
        b=RdY0BrLv2rcJfINrmZOIsjJ2PNqDlE3CDSTe5inbaIG9Tv5brko4Zxir1QF00/dZGH
         JTXRA7pP5IjKat2fq/7DkIg1Fh9W4ViC1kMo+HQOmfRQyq7xtRtkcAStc4SrOyeXRAYO
         l/lhEpFfue6b91RSRSefICGjTxhEJ9uuQGjTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eq2K5OkFTuLSqgbW/r7s9fYviyZwt+wOFnNmsM9kDM=;
        b=NKRfuAQTRpwertL/wRBzu0gBXj+1MfyQy9YHaXzjAIUHeFX6m31m8ZS43UHoL48byh
         ezEaav2KGlm/eN8avgmg/jol5OPIMJJ3cakazqhEMDXjteTavWlpuE5Io103soJqxDOd
         n5WnQ+A4kQLP9+OQgbGVjp039u+CnBP45+VF9TDqJZjOT3Ut66QywxE4C3M2fe+pdVvv
         5pfmFfH5LBmLQR7LwBpHkxPuHgh2EyxvkD8Ls1AKSTYvCO1XAJdcnNbQJ0LSLdcZwMB6
         stXzCsx3RFyF4sMVI2J3WxjaH4Zh3q9OPDSJkpZGzZdrosJMf7qbc3kPijasf2kRcGbI
         zL+Q==
X-Gm-Message-State: AOAM531T/9OHX/dsgywudo+KTosk9sRQDgX/gjJmiMpgPM2XJxCAvh8T
        WxCSYSUK5Zs5w5SKc8oGMIZ94680iRLVK2/lgt2EFw==
X-Google-Smtp-Source: ABdhPJzch7yd8ZHEHV64qJOxtwKyPAaYMceg9MrdYl9cFpzrY17sIR6zoAu8kyMfgPGz6iRDdcIO229qzdWu8S0hC3w=
X-Received: by 2002:a25:10c5:: with SMTP id 188mr23957298ybq.181.1604979227745;
 Mon, 09 Nov 2020 19:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20201109100343.3958378-1-chirantan@chromium.org>
 <20201109100343.3958378-3-chirantan@chromium.org> <CAJfpegv5DdgCqdtSzUS43P9JQeUg9fSyuRXETLNy47=cZyLtuQ@mail.gmail.com>
In-Reply-To: <CAJfpegv5DdgCqdtSzUS43P9JQeUg9fSyuRXETLNy47=cZyLtuQ@mail.gmail.com>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Tue, 10 Nov 2020 12:33:36 +0900
Message-ID: <CAJFHJrqZMg6A_QnoOL3e5gNZtYquUPSr4B0ZLZMSKQH6o7sxag@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 9, 2020 at 8:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Nov 9, 2020 at 11:04 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
> >
> > Implement support for O_TMPFILE by re-using the existing infrastructure
> > for mkdir, symlink, mknod, etc. The server should reply to the tmpfile
> > request by sending a fuse_entry_out describing the newly created
> > tmpfile.
> >
> > Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> > ---
> >  fs/fuse/dir.c  | 21 +++++++++++++++++++++
> >  fs/fuse/file.c |  3 ++-
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index ff7dbeb16f88d..1ab52e7ec1625 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -751,6 +751,26 @@ static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
> >         return create_new_entry(fm, &args, dir, entry, S_IFDIR);
> >  }
> >
> > +static int fuse_tmpfile(struct inode *dir, struct dentry *entry, umode_t mode)
> > +{
> > +       struct fuse_tmpfile_in inarg;
> > +       struct fuse_mount *fm = get_fuse_mount(dir);
> > +       FUSE_ARGS(args);
> > +
> > +       if (!fm->fc->dont_mask)
> > +               mode &= ~current_umask();
> > +
> > +       memset(&inarg, 0, sizeof(inarg));
> > +       inarg.mode = mode;
> > +       inarg.umask = current_umask();
> > +       args.opcode = FUSE_TMPFILE;
> > +       args.in_numargs = 1;
> > +       args.in_args[0].size = sizeof(inarg);
> > +       args.in_args[0].value = &inarg;
> > +
> > +       return create_new_entry(fm, &args, dir, entry, S_IFREG);
> > +}
> > +
> >  static int fuse_symlink(struct inode *dir, struct dentry *entry,
> >                         const char *link)
> >  {
> > @@ -1818,6 +1838,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
> >         .listxattr      = fuse_listxattr,
> >         .get_acl        = fuse_get_acl,
> >         .set_acl        = fuse_set_acl,
> > +       .tmpfile        = fuse_tmpfile,
> >  };
> >
> >  static const struct file_operations fuse_dir_operations = {
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index c03034e8c1529..8ecf85699a014 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -39,7 +39,8 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
> >         FUSE_ARGS(args);
> >
> >         memset(&inarg, 0, sizeof(inarg));
> > -       inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
> > +       inarg.flags =
> > +               file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY | O_TMPFILE);
>
> Why did you add this?   At this stage O_TMPFILE should not be in the
> flags, since that case was handled via the ->tmpfile() path.
>

That's not the behavior I observed.  Without this, the O_TMPFILE flag
gets passed through to the server.  The call stack is:

- do_filp_open
    - path_openat
        - do_tmpfile
            - vfs_tmpfile
                - dir->i_op->tmpfile
            - finish_open
                - do_dentry_open
                    - f->f_op->open

and I didn't see O_TMPFILE being removed anywhere in there.

Chirantan
