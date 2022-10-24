Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECFB60B799
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiJXT1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 15:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiJXTZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:25:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD60963F2A
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 10:58:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u11so1768640ljk.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMrcfhPVahxma5HnXPX+T8hOr/mq3FbHUMqjtPS2bSM=;
        b=ET9I4S0KeUfQKBpOoEoMvy8cv/mYKn/lpwHs1xx9mOLLIJz2xNo4Hw28QTBQMx9Muf
         4/P0aQxbdWWYCFLGNA8BAwhSj5U+BzfUvlGi+WCBByMQ4dIylbY2vLFvRS6g29Ae6I3N
         voinK9RqYFCHIxYj7ZnGpP9YpWlJEAhSGgNVWyxWmsURSZK0UbA6PFj5NK3ro6QkJqW1
         m+UOybF8a58yH+OYag1Z3nhMFV1G8dX3rGAQdgoFhmL73AgDzOiTuYxPAAdlgtuXxfgF
         G5sGViDxKwwTqvVMele/6XKGn9L9vtKmvy8zTqjRqA8LzGgpKFUm9zVDf2yATHOqqlr1
         hrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMrcfhPVahxma5HnXPX+T8hOr/mq3FbHUMqjtPS2bSM=;
        b=3HJ3r3zmvnBMGaLliaxBTRA54I7Vhzxog9d9CH7E+YWofl2m74NW21Benoci4hwdU1
         V2vukF0QS7VryPi/4+bvADSEFXgFxfIEsHVfWBqU9HxpoZOuw8CB4ijo8YXP3JXDdLOd
         iHG2TM3WNQSq3Y031gF30hoHsp077fLA+DX5oOHxVBG+X6UOoVCBFdiHcCccShZh/Tg6
         qRwhIBgBpjTV9UR/aruj1+ndjjSPlvg3QsJ0+9yuX8TbIuU197F8rRgk7ufcOoH22MBb
         JzLFTcMC0MwBb20qpk0zLgoQ5IACFPwlWlPKpqq6LrPdVthBuo+4Upe4o+HNoT4XLdUe
         KriA==
X-Gm-Message-State: ACrzQf1P+/giG/YbGu/CrcV9FVqx5h5q5RoEDhJn8lN4FnZqt5JgMEDW
        B+OUrA+cPtczoQPW0fsx3qH1zZ38uRJCK5yh7+QI5COC
X-Google-Smtp-Source: AMsMyM7iYxPP09cmBaUYZzZdQDK8PO6olHOpaJmh5uQ6wUZNsG4Gb/3mHKZiDIqPLUURV49+2M9kqobLo+wLmmqIr1o=
X-Received: by 2002:a17:907:75e6:b0:7a1:848:20cb with SMTP id
 jz6-20020a17090775e600b007a1084820cbmr11099712ejc.745.1666630373169; Mon, 24
 Oct 2022 09:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221020201409.1815316-1-davemarchevsky@fb.com>
 <CAEf4BzZi4jnyXi1OAVrQ+k0qTJdRViU6-T+oeUUeTZXTF8V5bA@mail.gmail.com> <20221022132213.p7nr2b7whgivl3f5@wittgenstein>
In-Reply-To: <20221022132213.p7nr2b7whgivl3f5@wittgenstein>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Oct 2022 09:52:40 -0700
Message-ID: <CAEf4Bza+gWkjYaGOmwY=nscjhOrJdphh2Y2RVrS1pM3aq_SHhw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Rearrange fuse_allow_current_process checks
To:     Christian Brauner <brauner@kernel.org>
Cc:     Seth Forshee <sforshee@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
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

On Sat, Oct 22, 2022 at 6:22 AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Oct 21, 2022 at 09:05:26AM -0700, Andrii Nakryiko wrote:
> > On Thu, Oct 20, 2022 at 1:14 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > >
> > > This is a followup to a previous commit of mine [0], which added the
> > > allow_sys_admin_access && capable(CAP_SYS_ADMIN) check. This patch
> > > rearranges the order of checks in fuse_allow_current_process without
> > > changing functionality.
> > >
> > > [0] added allow_sys_admin_access && capable(CAP_SYS_ADMIN) check to the
> > > beginning of the function, with the reasoning that
> > > allow_sys_admin_access should be an 'escape hatch' for users with
> > > CAP_SYS_ADMIN, allowing them to skip any subsequent checks.
> > >
> > > However, placing this new check first results in many capable() calls when
> > > allow_sys_admin_access is set, where another check would've also
> > > returned 1. This can be problematic when a BPF program is tracing
> > > capable() calls.
> > >
> > > At Meta we ran into such a scenario recently. On a host where
> > > allow_sys_admin_access is set but most of the FUSE access is from
> > > processes which would pass other checks - i.e. they don't need
> > > CAP_SYS_ADMIN 'escape hatch' - this results in an unnecessary capable()
> > > call for each fs op. We also have a daemon tracing capable() with BPF and
> > > doing some data collection, so tracing these extraneous capable() calls
> > > has the potential to regress performance for an application doing many
> > > FUSE ops.
> > >
> > > So rearrange the order of these checks such that CAP_SYS_ADMIN 'escape
> > > hatch' is checked last. Previously, if allow_other is set on the
> > > fuse_conn, uid/gid checking doesn't happen as current_in_userns result
> > > is returned. It's necessary to add a 'goto' here to skip past uid/gid
> > > check to maintain those semantics here.
> > >
> > >   [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other")
> > >
> > > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > ---
> >
> > LGTM!
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> >
> > But I would also be curious to hear from Miklos or others whether
> > skipping uid/gid check if fc->allow_other is true wa an intentional
> > logic, oversight, or just doesn't matter. Because doing:
>
> Originally, setting fc->allow_other granted access to everyone skipping
> all further permission checks.
>
> When Seth (Cced) made it possible to mount fuse in userns
> fc->allow_other needed to be restricted to callers who are in the
> superblock's userns or a descendant of it. The reason is that an
> unprivileged user can mount a fuse filesystem with fc->allow_other
> turned on. But then the user could mess with processes outside its
> userns when they access the filesystem.
>
> Without fc->allow_other it doesn't matter what userns the filesystem is
> accessed from as long as the uidgid is permissible. This could e.g.,
> happen if you unshare a userns but dont set{g,u}id.
>
> In general, I see two obvious permission models. In the first model we
> restrict access to the owner of the mount by uidgid but also require
> callers to be within the userns hierarchy. If allow_other is specified
> the requirement would be relaxed to only require the caller to be within
> the userns hierarchy. That would make the permission checking
> consistent.
>
> The second permission model would only require permissible uidgid by
> default and for allow other either permissible uidgid or for the caller
> to be within the userns hierarchy (Which is what you're asking about
> afaiu.).
>

Great, thanks for explaining! It does feel the latter is a more
natural behavior, but I was just mostly curious, don't really have any
strong opinion either way.

> I don't see any obvious reasons why this wouldn't work from a security
> perspective; maybe Seth has additional insights. The problem however is
> that it would be a non-trivial change for containers to lift the
> restriction now. It is quite useful to be able to mount a fuse
> filesystem with allow_other and not have it accessible by anything
> outside your userns hierarchy. So I wouldn't like to see that changed.
>
> If so we should probably make it yet another fuse module option or sm.
> But in any case that should be a separate patch with a proper
> justification why this semantic change is needed other than that it
> simplifies the logic.
