Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B8876DE71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 04:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjHCCqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 22:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjHCCqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:46:44 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57904BA
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 19:46:42 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-583f837054eso4002777b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 19:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691030801; x=1691635601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7rPDjP3w7SFi7WVbOLZnOQv42SK/YK3pgxUtFOJqn8=;
        b=NhqdR98K7bSRKTQ7CDjVRuusX4/Mn2110sFpO+gM2ndRgcP5OGA/FvizImRpEFEI4Z
         PzGJ2fbtz7V+aSAsGKRRX4zdMzG2Ac0+NO8G5LU04GpWmY1oYpNibBULXCfo1KfjeD/Y
         VkGVoJ4W5p9nydWS1OU+rOHdFLg07+H2eJVFgHRBmy669hWJ8MfQyLHxBzHgyNt/2Jk+
         CcwoWKuzcB5rmpv9andPMrMoVDPaHBL3zU3r1fFGqN7x74QhHlDsK1NwpW9SEdncDCRd
         FkoTtcniWlVsCYHVycdjAtMDuJQ9Pfykj7simTA9WCo2OIiEEMeuJSS5RVZpb31IsaiE
         GjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691030801; x=1691635601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7rPDjP3w7SFi7WVbOLZnOQv42SK/YK3pgxUtFOJqn8=;
        b=lnRgBTE0lfCfSi6H1fWvrQ4BPprLXCMbmaI3+dfeYSUs6pCzMdb0AeQFqSAWmQG1FZ
         fPytdiY2sRSsSWyD++GdvDC50ybe1KRpmc6c+YJalPEJ+sl/RtHABTHKZNrQFSM3Nvo7
         /4KupRr54wbj1CVfKu/ds7NFlVtrkiGUlONPZc9sD5reD1J85gVuvHpzWlAhLlJw+JPj
         qasbimtVAzgTK+9z0NFBl29dZxEZnwW8fEj7dXKb49FRAkEfy+1gFd6cIxAOxZzJ3ggc
         CtjVmOiqqcw2P/UrIkYiS8CY4Jk5QoPCYgvRV7bUIXBZkB4aQ4VJwzwEA2S/DXp2OqLf
         PmEA==
X-Gm-Message-State: ABy/qLb6BOb+uCgyUakkfefexKnt3ro2Se+GUGleRvXTEWR/QMGD1LmC
        g1DTKtfmdkY798EN1DQa3g0jm3tD347h6/ce2u7o
X-Google-Smtp-Source: APBJJlFqHlrp0u9AowD2PWwPoxkgbyl77rYK4KODV0+X/B9t9X/ggsV9oR4Jf3avj9eFA1ansLbJ8J91robM9izXfWw=
X-Received: by 2002:a81:7b05:0:b0:56c:e1e0:8da1 with SMTP id
 w5-20020a817b05000000b0056ce1e08da1mr23328025ywc.19.1691030801385; Wed, 02
 Aug 2023 19:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230802-master-v6-1-45d48299168b@kernel.org> <bac543537058619345b363bbfc745927.paul@paul-moore.com>
 <ca156cecbc070c3b7c68626572274806079a6e04.camel@kernel.org>
In-Reply-To: <ca156cecbc070c3b7c68626572274806079a6e04.camel@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 2 Aug 2023 22:46:30 -0400
Message-ID: <CAHC9VhTQDVyZewU0Oiy4AfJt_UtB7O2_-PcUmXkZtuwKDQBfXg@mail.gmail.com>
Subject: Re: [PATCH v6] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 2, 2023 at 3:34=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
> On Wed, 2023-08-02 at 14:16 -0400, Paul Moore wrote:
> > On Aug  2, 2023 Jeff Layton <jlayton@kernel.org> wrote:

...

> > I generally dislike core kernel code which makes LSM calls conditional
> > on some kernel state maintained outside the LSM.  Sometimes it has to
> > be done as there is no other good options, but I would like us to try
> > and avoid it if possible.  The commit description mentioned that this
> > was put here to avoid a SELinux complaint, can you provide an example
> > of the complain?  Does it complain about a double/invalid mount, e.g.
> > "SELinux: mount invalid.  Same superblock, different security ..."?
>
> The problem I had was not so much SELinux warnings, but rather that in a
> situation where I would expect to share superblocks between two
> filesystems, it didn't.
>
> Basically if you do something like this:
>
> # mount nfsserver:/export/foo /mnt/foo -o context=3Dsystem_u:object_r:roo=
t_t:s0
> # mount nfsserver:/export/bar /mnt/bar -o context=3Dsystem_u:object_r:roo=
t_t:s0
>
> ...when "foo" and "bar" are directories on the same filesystem on the
> server, you should get two vfsmounts that share a superblock. That's
> what you get if selinux is disabled, but not when it's enabled (even
> when it's in permissive mode).

Thanks, that helps.  I'm guessing the difference in behavior is due to
the old->has_sec_mnt_opts check in nfs_compare_super().

> > I'd like to understand why the sb_set_mnt_opts() call fails when it
> > comes after the fs_context_init() call.  I'm particulary curious to
> > know if the failure is due to conflicting SELinux state in the
> > fs_context, or if it is simply an issue of sb_set_mnt_opts() not
> > properly handling existing values.  Perhaps I'm being overly naive,
> > but I'm hopeful that we can address both of these within the SELinux
> > code itself.
>
> The problem I hit was that nfs_compare_super is called with a fs_context
> that has a NULL ->security pointer. That caused it to call
> selinux_sb_mnt_opts_compat with mnt_opts set to NULL, and at that point
> it returns 1 and decides not to share sb's.
>
> Filling out fc->security with this new operation seems to fix that, but
> if you see a better way to do this, then I'm certainly open to the idea.

Just as you mention that you are not a LSM expert, I am not a VFS
expert, so I think we'll have to help each other a bit ;)

I think I'm beginning to understand alloc_fs_context() a bit more,
including the fs_context_for_XXX() wrappers.  One thing I have
realized is that I believe we need to update the
selinux_fs_context_init() and smack_fs_context_init() functions to
properly handle a NULL @reference dentry; I think returning without
error in both cases is the correct answer.  In the non-NULL @reference
case, I believe your patch is correct, we do want to inherit the
options from @reference.  My only concern now is the
fs_context::lsm_set flag.

You didn't mention exactly why the security_sb_set_mnt_opts() was
failing, and requires the fs_context::lsm_set check, but my guess is
that something is tripping over the fact that the superblock is
already properly setup.  I'm working under the assumption that this
problem - attempting to reconfigure a properly configured superblock -
should only be happening in the submount/non-NULL-reference case.  If
it is happening elsewhere I think I'm going to need some help
understanding that ...

However, assuming I'm mostly correct in the above paragraph, would it
be possible to take a reference to the @reference dentry's superblock
in security_fs_context_init(), that we could later compare to the
superblock passed into security_sb_set_mnt_opts()?  If we know that
the fs_context was initialized with the same superblock we are now
being asked to set mount options on, we should be able to return from
the LSM hook without doing anything.

Right?

Or am I missing something really silly? :)

--=20
paul-moore.com
