Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C3602A05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJRLTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJRLTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:19:40 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31961A38C
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 04:19:37 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id a17so7279844ilq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAhbWS2r+kZh1CW1h6OenJ9QjBTytqKLyQ/pXA2P2K0=;
        b=EIk/Kpc4vGn1CCgUwxqJ0g9qrIF8uy+2DQFZx6/0JpAeX9DYMTx5JXVkPBYtgQPrZD
         w5ckB2FyJECCFZ7TR5oVdLKM3JLtg8LbrnuzoEXxcJQrlWrBJhDOqqunlGUkyYiYusmg
         4pZkzmwM+9f/7V2lVghKTwiM+YaQh3cp9ZZvUSDOsWutc4janERggmG80EYtDBsmm5FR
         3Qexg8CkIUzBKrmcgVunCJJTsDfpAftOZMfOV1FpySB9PQZpPxpWdrR2KhN6f8f5sev9
         BOvCNSY0IU2n3X0trRvB4A9oGJsk1h0bFLOBqjFDLcPxyl2bl058Kyw+oCFBFADmeDKL
         3t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAhbWS2r+kZh1CW1h6OenJ9QjBTytqKLyQ/pXA2P2K0=;
        b=Gu5579N3ya/lbA0Iq5iNvKfA4JCnQgaj7c0bVx9L9YW5tZNSPoIXfvjYE5YQkQrnYL
         csaJ1g2NmhXZLIAQBxmEKtYNMsGXt8Qc0lhs3azf2Q+ZSeBKUFTtxbzINBowJF3fjjuS
         vVMvvKnYCUquMZJ1i6eUafpFwhzwkIvd+XsKIB9LNfYRiY4cjAEY8yKYI59ZH30ZKVwG
         rcKp+LCOfdeyAbbvDOF6JN6RFMMv47Rf1wjwXund1YC9DHPMtQ+zmyX0JdND/zyJvuGm
         r2Euojb7SeYAHql5bP2nyN6ZQvT7R1gHLAf2fuSvjj9F6rJpHRUlleD6tO42cVNNaR2p
         JA7Q==
X-Gm-Message-State: ACrzQf0IXFesaQpNq1/bpzxcOL9Row5wfJ7HGD0NUBIklXMD4Bzjf4Nv
        9OKqnm8gDAWHJLGrIQ1UHIheNIyMJSzkIBILnrJwog==
X-Google-Smtp-Source: AMsMyM5JK/czEGcdqbcmVXAa+iPQxFN5IfdfeKyvqXfD69WzM51dWHMxMw0qfiz3oZW7DVcBpgcr/vJENhoNl1bXbqk=
X-Received: by 2002:a05:6e02:930:b0:2f9:9d1b:2525 with SMTP id
 o16-20020a056e02093000b002f99d1b2525mr1392129ilt.173.1666091977094; Tue, 18
 Oct 2022 04:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
 <2032f766-1704-486b-8f24-a670c0b3cb32@app.fastmail.com> <CAG48ez3hM+-V39QpFaNfRJxVrQVBu2Dm-B-xFN2GEt9p81Vd2Q@mail.gmail.com>
 <202210172359.EDF8021407@keescook>
In-Reply-To: <202210172359.EDF8021407@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 18 Oct 2022 13:19:00 +0200
Message-ID: <CAG48ez1xqguRrWT+KrjkyUHGZPVFDbMM3f__71VE-L38kQri9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 9:09 AM Kees Cook <keescook@chromium.org> wrote:
> On Fri, Oct 14, 2022 at 05:35:26PM +0200, Jann Horn wrote:
> > On Fri, Oct 14, 2022 at 5:18 AM Andy Lutomirski <luto@kernel.org> wrote=
:
> > > On Thu, Oct 6, 2022, at 7:13 AM, Jann Horn wrote:
> > > > On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel.o=
rg> wrote:
> > > >> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
> > > >> > The check_unsafe_exec() counting of n_fs would not add up under =
a heavily
> > > >> > threaded process trying to perform a suid exec, causing the suid=
 portion
> > > >> > to fail. This counting error appears to be unneeded, but to catc=
h any
> > > >> > possible conditions, explicitly unshare fs_struct on exec, if it=
 ends up
> > > >>
> > > >> Isn't this a potential uapi break? Afaict, before this change a ca=
ll to
> > > >> clone{3}(CLONE_FS) followed by an exec in the child would have the
> > > >> parent and child share fs information. So if the child e.g., chang=
es the
> > > >> working directory post exec it would also affect the parent. But a=
fter
> > > >> this change here this would no longer be true. So a child changing=
 a
> > > >> workding directoro would not affect the parent anymore. IOW, an ex=
ec is
> > > >> accompanied by an unshare(CLONE_FS). Might still be worth trying o=
fc but
> > > >> it seems like a non-trivial uapi change but there might be few use=
rs
> > > >> that do clone{3}(CLONE_FS) followed by an exec.
> > > >
> > > > I believe the following code in Chromium explicitly relies on this
> > > > behavior, but I'm not sure whether this code is in active use anymo=
re:
> > > >
> > > > https://source.chromium.org/chromium/chromium/src/+/main:sandbox/li=
nux/suid/sandbox.c;l=3D101?q=3DCLONE_FS&sq=3D&ss=3Dchromium
> > >
> > > Wait, this is absolutely nucking futs.  On a very quick inspection, t=
he sharable things like this are fs, files, sighand, and io.    files and s=
ighand get unshared, which makes sense.  fs supposedly checks for extra ref=
s and prevents gaining privilege.  io is... ignored!  At least it's not imm=
ediately obvious that io is a problem.
> > >
> > > But seriously, this makes no sense at all.  It should not be possible=
 to exec a program and then, without ptrace, change its cwd out from under =
it.  Do we really need to preserve this behavior?
> >
> > I agree that this is pretty wild.
> >
> > The single user I'm aware of is Chrome, and as far as I know, they use
> > it for establishing their sandbox on systems where unprivileged user
> > namespaces are disabled - see
> > <https://chromium.googlesource.com/chromium/src/+/main/docs/linux/suid_=
sandbox.md>.
> > They also have seccomp-based sandboxing, but IIRC there are some small
> > holes that mean it's still useful for them to be able to set up
> > namespaces, like how sendmsg() on a unix domain socket can specify a
> > file path as the destination address.
> >
> > (By the way, I think maybe Chrome wouldn't need this wacky trick with
> > the shared fs_struct if the "NO_NEW_PRIVS permits chroot()" thing had
> > ever landed that you
> > (https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.=
1327858005.git.luto@amacapital.net/)
> > and Micka=C3=ABl Sala=C3=BCn proposed in the past... or alternatively, =
if there
> > was a way to properly filter all the syscalls that Chrome has to
> > permit for renderers.)
> >
> > (But also, to be clear, I don't speak for Chrome, this is just my
> > understanding of how their stuff works.)
>
> Chrome seems to just want a totally empty filesystem view, yes?
> Let's land the nnp+chroot change. :P Only 10 years late! Then we can
> have Chrome use this and we can unshare fs on exec...

Someone should check with Chrome first though to make sure what I said
accurately represents what they think...
