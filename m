Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54F8549E1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 21:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbiFMTwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 15:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbiFMTvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:51:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692FE47044
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 11:21:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n28so8327104edb.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BzeXpCM4ReKsI5zQ7urLDZfvilwEec3KAzsN+SXuRdw=;
        b=MYNMwwHSIcpI2t5a+4280tjfXkBtcj4ACYkPiBKxj/LdNtEKOjClbjibttwOTOEElT
         Wgp89Sm7AX3IjtsyWWYgLPovY2tmPDLcASiLbhvaCpTNJ4PO2YPt/akBmQl/jqDWM0Um
         SgbXoTLwA65bwBOat/08nWlUnBvN3jqnHIp3758pDGn2lrNdR4fAA6maqUcPzIEWBzQf
         9FxL3BBTkhKzw4XalR4O8gy6E/yLShWTDJMJMHrqrbaj5lM1WDpwssKc6/w4uosuzik2
         a91M/tqVyAFXHvBgO/3bthtgDOEYhhEcwfn6sUI086VdstTqrf2jsYi5rBB9OrIJyvLt
         zjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BzeXpCM4ReKsI5zQ7urLDZfvilwEec3KAzsN+SXuRdw=;
        b=SOKRs9qn9qTAH+FtPtb6Vvtyng3kpZ2kdV0NuA4eRGTqptMCawal9iRU68ftNiztqL
         5+9HYSCp+KmenrVDqeNjnanzihPGilzbk/8QflawFnBXHitpQ99ySkK/N/OJUSTgPnot
         5sFPJRHQReFwbyRyZoq6wcHOpFZcnHh4QJIcKhOjrT8DSJ1JAAbGRuWXPmLFJoSQmLQq
         00kKjbHID9wn/lFh6d/5VqrGukhA2VqQD5cbQi/MC6F4+GmZX8lF7fuljnZJdyMPiOZh
         yLpb/4F403JUC0KOAHpXhGCSHoT1kzD6Dq3QFyQHxjOQfygLmrOk0nGS7xhVK8Y8qlgx
         M9gw==
X-Gm-Message-State: AOAM532kSfIgiIKUElO/rByGlvYNiV9J5jZIx4uJ1sUSGDi54LF/kczQ
        ZFhlZBelMLBS7loq2BvFRcoyNvY15/btaj+VWlQ=
X-Google-Smtp-Source: ABdhPJzAqQbtUKDMtdR+3t8EUlcSnbnMlu/FhoTZzXsHQcK10sGrMu93KI+O4+sgpYTikZeFJ7bfSkDVDHOyYG9ZcbY=
X-Received: by 2002:a05:6402:27cf:b0:431:54d9:28ed with SMTP id
 c15-20020a05640227cf00b0043154d928edmr1177058ede.81.1655144496701; Mon, 13
 Jun 2022 11:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220601184407.2086986-1-davemarchevsky@fb.com>
 <20220607084724.7gseviks4h2seeza@wittgenstein> <e933791c-21d1-18f9-de91-b194728432b8@fb.com>
 <CAJfpegssrypgpDDheiYJS13=_p14sN4BK+bZShPG4VZu=WpSaA@mail.gmail.com>
 <20220613093745.4szlhoutyqpizyys@wittgenstein> <CAJfpegu0Aj65rrPN_TtN8ugQNCP2d2LEB47zSDLy7H6aqd-HuA@mail.gmail.com>
In-Reply-To: <CAJfpegu0Aj65rrPN_TtN8ugQNCP2d2LEB47zSDLy7H6aqd-HuA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Jun 2022 11:21:24 -0700
Message-ID: <CAEf4BzaqfkfTgjbE2bEzELsTRpofv1Bstz2cPL8bGKS7jXvYTg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Add module param for non-descendant userns
 access to allow_other
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Chris Mason <clm@fb.com>, Andrii Nakryiko <andrii@kernel.org>
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

On Mon, Jun 13, 2022 at 3:34 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 13 Jun 2022 at 11:37, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Jun 13, 2022 at 10:23:47AM +0200, Miklos Szeredi wrote:
> > > On Fri, 10 Jun 2022 at 23:39, Andrii Nakryiko <andriin@fb.com> wrote:
> > > >
> > > >
> > > >
> > > > On 6/7/22 1:47 AM, Christian Brauner wrote:
> > > > > On Wed, Jun 01, 2022 at 11:44:07AM -0700, Dave Marchevsky wrote:
> > >
> > > [...]
> > >
> > > > >> +static bool __read_mostly allow_other_parent_userns;
> > > > >> +module_param(allow_other_parent_userns, bool, 0644);
> > > > >> +MODULE_PARM_DESC(allow_other_parent_userns,
> > > > >> + "Allow users not in mounting or descendant userns "
> > > > >> + "to access FUSE with allow_other set");
> > > > >
> > > > > The name of the parameter also suggests that access is granted to parent
> > > > > userns tasks whereas the change seems to me to allows every task access
> > > > > to that fuse filesystem independent of what userns they are in.
> > > > >
> > > > > So even a task in a sibling userns could - probably with rather
> > > > > elaborate mount propagation trickery - access that fuse filesystem.
> > > > >
> > > > > AFaict, either the module parameter is misnamed or the patch doesn't
> > > > > implement the behavior expressed in the name.
> > > > >
> > > > > The original patch restricted access to a CAP_SYS_ADMIN capable task.
> > > > > Did we agree that it was a good idea to weaken it to all tasks?
> > > > > Shouldn't we still just restrict this to CAP_SYS_ADMIN capable tasks in
> > > > > the initial userns?
> > > >
> > > > I think it's fine to allow for CAP_SYS_ADMIN only, but can we then
> > > > ignore the allow_other mount option in such case? The idea is that
> > > > CAP_SYS_ADMIN allows you to read FUSE-backed contents no matter what, so
> > > > user not mounting with allow_other preventing root from reading contents
> > > > defeats the purpose at least partially.
> > >
> > > If we want to be compatible with "user_allow_other", then it should be
> > > checking if the uid/gid of the current task is mapped in the
> > > filesystems user_ns (fsuidgid_has_mapping()).  Right?
> >
> > I think that's doable. So assuming we're still talking about requiring
> > cap_sys_admin then we'd roughly have sm like:
> >
> >         if (fc->allow_other)
> >                 return current_in_userns(fc->user_ns) ||
> >                         (capable(CAP_SYS_ADMIN) &&
> >                         fsuidgid_has_mapping(..., &init_user_ns));
>
> No, I meant this:
>
>         if (fc->allow_other)
>                 return current_in_userns(fc->user_ns) ||
>                         (userns_allow_other &&
>                         fsuidgid_has_mapping(..., &init_user_ns));
>
> But I think the OP wanted to allow real root to access the fs, which
> this doesn't allow (since 0 will have no mapping in the user ns), so
> I'm not sure what's the right solution...

Right, so I was basically asking why not do something like this:

$ git diff
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 74303d6e987b..8c04955eb26e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1224,6 +1224,9 @@ int fuse_allow_current_process(struct fuse_conn *fc)
 {
        const struct cred *cred;

+       if (fuse_allow_sys_admin_access && capable(CAP_SYS_ADMIN))
+               return 1;
+
        if (fc->allow_other)
                return current_in_userns(fc->user_ns);


where fuse_allow_sys_admin_access is module param which has to be
opted into through sysfs?

>
> Maybe the original patch is fine: this check isn't meant to protect
> the filesystem from access, it's meant to protect the accessor.
>
> Thanks,
> Miklos
