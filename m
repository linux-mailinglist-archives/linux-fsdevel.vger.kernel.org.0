Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AA25FB0F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 13:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJKLHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 07:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKLHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:07:23 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94617DF58;
        Tue, 11 Oct 2022 04:07:22 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id q83so6453633vkb.2;
        Tue, 11 Oct 2022 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c7fuac57pyjpCxT69ZprcuJLhTm8TX8ks8Xrw2HTqTg=;
        b=jI4q+Bo4ANbghOH9U8SJn28IM5POyRkH0hHb/eozn1Zz10r+tBRMc/fnol3uAHnqIf
         e2s2T9eA3dLeuI8XDagF6KVjrcuY9tU5Ve7G/kIg1EBy3Vq4kXwO3SThKtlBfrkyxxtp
         kz9tCujos2E+dBW/7fheNxEqAc1s0Xjm4QXpGiTjzqvp9Kiw/UAWwfL0RYZ2cJ9TZyoA
         Vn5nLddWQMSlf/fAe3CSp2H1IbuJ6A9L7NNLABzcT9G7mylnsYMVjVZ+NHgM+Mo6xp4b
         1esERsK/XHrXlS1xilqzPoVZ7lL1N1sGusisFtkUVhgJa+zVHcPy/X65TqZJnhtF07Hr
         E9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7fuac57pyjpCxT69ZprcuJLhTm8TX8ks8Xrw2HTqTg=;
        b=flzA3kEKwYTz/vds4QujzwAbPMT42nkk+7vYvFZdInuuoTAt2i0l8DRFm3tN9qpsba
         qnFT/I/aIbsgOBwKPyZVPV3yN9ooIAOn8wdOfuguYSD9QxTl2BThSoTSq4Oah4gk3oqN
         LXahmW3Lafgl5X0WBwBQYG5chne3baepZl+TUPLxiIoJgrq4Oa0ZB2pwigG78sYFhk4s
         f3G6yZE33FthpnlJ41+JLutAf7IPsOBXetoJpZltFNZNKgPw6bSHUZPCaLz+AWeW+hOW
         t8HYTl58TUn+OZdLan0jd7SWRG03s3SO+GGmq/n+wYUTRDDVFwYjcHr6HaxBI7yfnwI1
         munA==
X-Gm-Message-State: ACrzQf0UzafwJywAnEb+zY4HDsi54+ZO0Qp2Act1+PB26UhtkR9Gg7pl
        3wfpiZpUDDvq0H2IFFlFhgmFXrflhh4z2GfxVM4xeTBZphg=
X-Google-Smtp-Source: AMsMyM4uHAmUv1l/GRy5FCNfnAgputZqe85Qdaq9jdrxzHbjznt06vjNyvykFQ2DDTdt6e5bpyYxw+8ofM/GI0aUwC8=
X-Received: by 2002:a1f:60cd:0:b0:3ae:da42:89d0 with SMTP id
 u196-20020a1f60cd000000b003aeda4289d0mr420939vkb.15.1665486441778; Tue, 11
 Oct 2022 04:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221007140543.1039983-1-brauner@kernel.org> <20221007140543.1039983-4-brauner@kernel.org>
 <CAOQ4uxggKnsyi2DvVOCUQQ8hEZJjioing_H-M4y_Hq-wvRk0nA@mail.gmail.com> <20221011085634.2qp2ragzcdzub6oq@wittgenstein>
In-Reply-To: <20221011085634.2qp2ragzcdzub6oq@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 Oct 2022 14:07:10 +0300
Message-ID: <CAOQ4uxhGqCkzsugEd_TZ+s3FEKiAxQtBy1rm3KP4KS=hzTsf4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] attr: use consistent sgid stripping checks
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

> > > @@ -721,10 +721,10 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
> > >                 return -EINVAL;
> > >         if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
> > >                 return -EINVAL;
> > > -       if (!S_ISDIR(inode->i_mode))
> > > -               newattrs.ia_valid |=
> > > -                       ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_KILL_PRIV;
> > >         inode_lock(inode);
> > > +       if (!S_ISDIR(inode->i_mode))
> > > +               newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
> > > +                                    should_remove_sgid(mnt_userns, inode);
> >
> > This is making me stop and wonder:
> > 1. This has !S_ISDIR, should_remove_suid() has S_ISREG and
> >     setattr_drop_sgid() has neither - is this consistent?
>
> I thought about that. It'very likely redundant since we deal with that
> in other parts but I need to verify all callers before we can remove
> that.
>
> > 2. SUID and PRIV are removed unconditionally and SGID is
> >     removed conditionally - this is not a change of behavior
> >     (at least for non-overlayfs), but is it desired???
>
> It looks that way but it isn't. The setgid bit was only killed
> unconditionally for S_IXGRP. We continue to do that. But it was always
> removed conditionally for ~S_IXGRP. The difference between this patchset
> and earlier is that it was done in settattr_prepare() or setattr_copy()
> before this change.
>
> IOW, we raised ATTR_KILL_SGID unconditionally but then only
> conditionally obeyed it in setattr_{prepare,copy}() whereas now we
> conditionally raise ATTR_KILL_SGID. That's surely a slight change but it
> just means that we don't cause bugs for filesystems that roll their own
> prepare or copy helpers and is just nicer overall.
>

Yes, that sounds right.

The point that I was trying to make and failed to articulate myself was
that chown_common() raises ATTR_KILL_SUID unconditionally,
while should_remove_suid() raises ATTR_KILL_SUID conditional
to !capable(CAP_FSETID).

Is this inconsistency in stripping SUID desired?

According to man page (I think that) it is:

"When the owner or group of an executable file is changed by an
 unprivileged user, the S_ISUID and S_ISGID mode bits are cleared.
 POSIX does not specify whether this also  should  happen  when  root
 does the chown(); the Linux behavior depends on the kernel version,
 and since Linux 2.2.13, root is treated like other users..."

So special casing SUID stripping in chown() looks intentional,
but maybe it is worth a comment.

The paragraph above *may* be interpreted that chown() should strip
S_SGID|S_IXGRP regardless of CAP_FSETID, which, as you say,
has not been the case for a while.

"...In case of a non-group-executable file (i.e., one for which the
 S_IXGRP bit is not set) the S_ISGID bit indicates mandatory locking,
 and is not cleared by a chown().
 When the owner or group of an executable file is changed (by any user),
 all capability sets for the file are cleared."

This part sounds aligned with the code.

Thanks,
Amir.
