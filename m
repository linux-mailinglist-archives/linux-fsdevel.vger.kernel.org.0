Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2504A60B535
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiJXSPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 14:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiJXSPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:15:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD0B1B2310
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 09:56:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k2so6502471ejr.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N33tA1h/IRjXrkT6lpoWyfnJnHpsAoJvT6eHEU0dsow=;
        b=qiPhI4dYlX1X5daFqqTIRve+kXWJdxkZ/jbUiNjN2VEIV0FpVclydiXwlAn9+VAW8D
         XDRhB5k6xnR4WXbPKmEa/ggcuCKNjyQ5FWOLLlY1oXGLA4TTclhzsUEAkCzs/rT8qWfT
         P1TxT/DGUtNxFtOi/gzhGmqZf2uKxS48SKM1/aU+SgxftKtBMiHbqjLsDPKY+ti6lf8I
         fpFYBWWWkWeF0gidLxBmClK0QW9/46igEZBocpabhZHwnKzFiAi8vEoAY2jlW1eY6NLS
         fdICQztHyu/B8meluunUNGwgENQCcLVTpQ4D9hJnukrG64FU4rtuG3ec6izVRFnXGIYe
         p4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N33tA1h/IRjXrkT6lpoWyfnJnHpsAoJvT6eHEU0dsow=;
        b=oH5EHisaLFuL6KJHyt30ZjGE8MaiQ844DQbwUGwPHFhhFcA4EE5vccTkjdFeKfbWvJ
         S09RrdPrUd0sb/vDo1N2qt48WORWeboJLQULmNqkJreSir4j1CowI9kiJ9z2YHleS8e+
         8lidQE5LZQiXI5Stp5su93mZMHE3bGvzY+9quJFKRNErWWtyGqLiEIE4BvtRT2HD2MLN
         oWVf6HyaFI37zz2RlQA+Ktwc1cFjuHo/HtxIDCYZXcGn5wzooUEIxPeGV42iMJRj2Bj8
         b5/xlOhXK8k8mkPhzS0wk7SA7hxJKrSXhvqgoaRdv4NQRApIwsjJu7kpof3ETUnx4MDm
         0pfg==
X-Gm-Message-State: ACrzQf2JacuS9sqbOTswQXJefwt80x96jPqWWi6uD6+mndLPBoiT61XA
        PJl5ZjYF7J7CCaNoqsPEzfGa6gcc1tMHQt/mdyIUN4nn
X-Google-Smtp-Source: AMsMyM6svfJgcTiFTphfKAKuTixFW2iwUHcLo8vo4T4Lgk8GpPhvJ35nTjaioPGgP6TOg47tZhehdSLCEN3hSPvP3dk=
X-Received: by 2002:a17:907:2d0b:b0:78e:674:6b32 with SMTP id
 gs11-20020a1709072d0b00b0078e06746b32mr27976259ejc.226.1666630426670; Mon, 24
 Oct 2022 09:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221020201409.1815316-1-davemarchevsky@fb.com>
 <20221021080902.cshha2dja73wuojr@wittgenstein> <CAEf4Bzbp6cMiSWBLxzXT5AT=X-cidnnx9GU6op_MnXvRH+7T3w@mail.gmail.com>
 <20221022133043.acwmqowig2civ2mu@wittgenstein>
In-Reply-To: <20221022133043.acwmqowig2civ2mu@wittgenstein>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Oct 2022 09:53:34 -0700
Message-ID: <CAEf4BzbnU4pwkW0anBTZBC7sRooaMZ7okopJR6rToX1FG=AGkw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Rearrange fuse_allow_current_process checks
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Sat, Oct 22, 2022 at 6:30 AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Oct 21, 2022 at 09:02:30AM -0700, Andrii Nakryiko wrote:
> > On Fri, Oct 21, 2022 at 1:09 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Thu, Oct 20, 2022 at 01:14:09PM -0700, Dave Marchevsky wrote:
> > > > This is a followup to a previous commit of mine [0], which added the
> > > > allow_sys_admin_access && capable(CAP_SYS_ADMIN) check. This patch
> > > > rearranges the order of checks in fuse_allow_current_process without
> > > > changing functionality.
> > > >
> > > > [0] added allow_sys_admin_access && capable(CAP_SYS_ADMIN) check to the
> > > > beginning of the function, with the reasoning that
> > > > allow_sys_admin_access should be an 'escape hatch' for users with
> > > > CAP_SYS_ADMIN, allowing them to skip any subsequent checks.
> > > >
> > > > However, placing this new check first results in many capable() calls when
> > > > allow_sys_admin_access is set, where another check would've also
> > > > returned 1. This can be problematic when a BPF program is tracing
> > > > capable() calls.
> > > >
> > > > At Meta we ran into such a scenario recently. On a host where
> > > > allow_sys_admin_access is set but most of the FUSE access is from
> > > > processes which would pass other checks - i.e. they don't need
> > > > CAP_SYS_ADMIN 'escape hatch' - this results in an unnecessary capable()
> > > > call for each fs op. We also have a daemon tracing capable() with BPF and
> > > > doing some data collection, so tracing these extraneous capable() calls
> > > > has the potential to regress performance for an application doing many
> > > > FUSE ops.
> > > >
> > > > So rearrange the order of these checks such that CAP_SYS_ADMIN 'escape
> > > > hatch' is checked last. Previously, if allow_other is set on the
> > > > fuse_conn, uid/gid checking doesn't happen as current_in_userns result
> > > > is returned. It's necessary to add a 'goto' here to skip past uid/gid
> > > > check to maintain those semantics here.
> > > >
> > > >   [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other")
> > > >
> > > > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > ---
> > >
> > > The idea sounds good.
> > >
> > > > v1 -> v2: lore.kernel.org/linux-fsdevel/20221020183830.1077143-1-davemarchevsky@fb.com
> > > >
> > > >   * Add missing brackets to allow_other if statement (Andrii)
> > > >
> > > >  fs/fuse/dir.c | 14 +++++++++-----
> > > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > > index 2c4b08a6ec81..2f14e90907a2 100644
> > > > --- a/fs/fuse/dir.c
> > > > +++ b/fs/fuse/dir.c
> > > > @@ -1254,11 +1254,11 @@ int fuse_allow_current_process(struct fuse_conn *fc)
> > > >  {
> > > >       const struct cred *cred;
> > > >
> > > > -     if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> > > > -             return 1;
> > > > -
> > > > -     if (fc->allow_other)
> > > > -             return current_in_userns(fc->user_ns);
> > > > +     if (fc->allow_other) {
> > > > +             if (current_in_userns(fc->user_ns))
> > > > +                     return 1;
> > > > +             goto skip_cred_check;
> > >
> > > I think this is misnamed especially because capabilities are creds as
> > > well. Maybe we should not use a goto even if it makes the patch a bit
> > > bigger (_completely untested_)?:
> > >
> > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > index bb97a384dc5d..3d733e0865bf 100644
> > > --- a/fs/fuse/dir.c
> > > +++ b/fs/fuse/dir.c
> > > @@ -1235,6 +1235,28 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
> > >         return err;
> > >  }
> > >
> > > +static inline bool fuse_permissible_uidgid(const struct fuse_conn *fc)
> > > +{
> > > +       cred = current_cred();
> > > +       return (uid_eq(cred->euid, fc->user_id) &&
> > > +               uid_eq(cred->suid, fc->user_id) &&
> > > +               uid_eq(cred->uid,  fc->user_id) &&
> > > +               gid_eq(cred->egid, fc->group_id) &&
> > > +               gid_eq(cred->sgid, fc->group_id) &&
> > > +               gid_eq(cred->gid,  fc->group_id))
> > > +}
> > > +
> > > +static inline bool fuse_permissible_other(const struct fuse_conn *fc)
> > > +{
> > > +       if (current_in_userns(fc->user_ns))
> > > +               return true;
> > > +
> > > +       if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> > > +               return true;
> >
> > This needs to be checked regardless of fc->allow_other, so the change
> > you are proposing is not equivalent to the original logic. It does
>
> Thanks for spotting this. I missed that. I'm not opposed to gotos it
> just seems a bit ugly in this case and I'd prefer sm like (again,
> completely untested):
>
> int fuse_allow_current_process(struct fuse_conn *fc)
> {
>         const struct cred *cred;
>         int ret;
>
>         if (fc->allow_other)
>                 ret = current_in_userns(fc->user_ns);
>         else
>                 ret = fuse_permissible_uidgid(fc);
>         if (!ret && allow_sys_admin_access && capable(CAP_SYS_ADMIN))
>                 ret = 1;
>
>         return ret;
> }
>
> but I'm not fuzzed about it.

Me neither as long as it allows kernel to avoid unnecessary capable()
calls :) LGTM, thanks.
