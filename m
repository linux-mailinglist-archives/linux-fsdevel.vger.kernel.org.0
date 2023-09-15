Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3977A129E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 02:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjIOA4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 20:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjIOAz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 20:55:59 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FCC2701
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 17:55:55 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5925e580e87so17595937b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694739354; x=1695344154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1FlqXUdPjyj6me8kGYUdaY5qmjDeueDC49YLGEFQVY=;
        b=TV3vn+RcDglfLKJG5YlR1DiSFG1c0+WvfHmrvNzoAgv6vzR258kAkotzjLzYcE4Ly4
         N0Af8SyscTDVZ61PQz+5qo2np8tCzqkIQtjXsXmTQYbAAULTRxfuVnMIG575hZWoRFG+
         s7CcgCu0SbW3yeP+5uOLrk1iPUt+NwDHZPWXytEsFbTc4oy/9Od7yzang90LPH9Evc+w
         OWUzW345+ymB9HexrfD2lrmrNgrpSgtao1vxNBZDq1FAc7X3GcdUzbtGBEAc52ziJTo0
         gjMF0Tsvv3MQAmH7J1tyCvBRMSRyhXVO9ijLWZysCamsa8kA1dyT16apBjzwFCnYyIEW
         e77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694739354; x=1695344154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1FlqXUdPjyj6me8kGYUdaY5qmjDeueDC49YLGEFQVY=;
        b=UpfhtdxA8ZQm/3nDzWq2Oq6UWYI3kMhK7+3mNHRybTATigC4US3G6UJWgC4SmJRFtb
         i+MjBFiv1IFKr/DlShtqZPCtFp5ioHU8t0XRnvlxwOsmZkPNCQrzOc+wcJzBzxa+fPQi
         Rn3OROhL3qn71ii67SjeYN6mU70IOMWsjMmsE0rVgKUIpCQ/dvCikQ37gJsjH52DbDzX
         34WWW2pkdeR8CLVpkOGGFXw68csFX2yk7gc4o0T7KYdL9/H6oNSupe2NA6yyDQsQ2VDd
         GU2+QWkBcVN3/j3ooLSZbVmTyV1zasmOlqanS5DOd+/y0+UkiLGfBQcttLwJc/rP+g3z
         v6Ww==
X-Gm-Message-State: AOJu0Yw0zO5VLIgfj/mHqUgfmu+usLrC6P9VEx86AGdTtPyVKZ9+g1IO
        ZAPjDhJ4HGe8snm7xKxuye56X4d/QPK6sDpkknRe
X-Google-Smtp-Source: AGHT+IHTSbiWh8LlDJaKwyJzDpTzWID3S8nIyZTRT2Pt3OfQMXqYzbo2dF6Xlkztbw+zK7O4PM07DWuMBDqKM3nLU/8=
X-Received: by 2002:a81:6c8f:0:b0:59b:e666:1fb4 with SMTP id
 h137-20020a816c8f000000b0059be6661fb4mr365826ywc.9.1694739354487; Thu, 14 Sep
 2023 17:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230912212906.3975866-3-andrii@kernel.org> <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
 <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com>
In-Reply-To: <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Sep 2023 20:55:43 -0400
Message-ID: <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 1:31=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Sep 13, 2023 at 2:46=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Sep 12, 2023 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > > allow delegating privileged BPF functionality, like loading a BPF
> > > program or creating a BPF map, from privileged process to a *trusted*
> > > unprivileged process, all while have a good amount of control over wh=
ich
> > > privileged operations could be performed using provided BPF token.
> > >
> > > This is achieved through mounting BPF FS instance with extra delegati=
on
> > > mount options, which determine what operations are delegatable, and a=
lso
> > > constraining it to the owning user namespace (as mentioned in the
> > > previous patch).
> > >
> > > BPF token itself is just a derivative from BPF FS and can be created
> > > through a new bpf() syscall command, BPF_TOKEN_CREAT, which accepts
> > > a path specification (using the usual fd + string path combo) to a BP=
F
> > > FS mount. Currently, BPF token "inherits" delegated command, map type=
s,
> > > prog type, and attach type bit sets from BPF FS as is. In the future,
> > > having an BPF token as a separate object with its own FD, we can allo=
w
> > > to further restrict BPF token's allowable set of things either at the=
 creation
> > > time or after the fact, allowing the process to guard itself further
> > > from, e.g., unintentionally trying to load undesired kind of BPF
> > > programs. But for now we keep things simple and just copy bit sets as=
 is.
> > >
> > > When BPF token is created from BPF FS mount, we take reference to the
> > > BPF super block's owning user namespace, and then use that namespace =
for
> > > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> > > capabilities that are normally only checked against init userns (usin=
g
> > > capable()), but now we check them using ns_capable() instead (if BPF
> > > token is provided). See bpf_token_capable() for details.
> > >
> > > Such setup means that BPF token in itself is not sufficient to grant =
BPF
> > > functionality. User namespaced process has to *also* have necessary
> > > combination of capabilities inside that user namespace. So while
> > > previously CAP_BPF was useless when granted within user namespace, no=
w
> > > it gains a meaning and allows container managers and sys admins to ha=
ve
> > > a flexible control over which processes can and need to use BPF
> > > functionality within the user namespace (i.e., container in practice)=
.
> > > And BPF FS delegation mount options and derived BPF tokens serve as
> > > a per-container "flag" to grant overall ability to use bpf() (plus fu=
rther
> > > restrict on which parts of bpf() syscalls are treated as namespaced).
> > >
> > > The alternative to creating BPF token object was:
> > >   a) not having any extra object and just pasing BPF FS path to each
> > >      relevant bpf() command. This seems suboptimal as it's racy (moun=
t
> > >      under the same path might change in between checking it and usin=
g it
> > >      for bpf() command). And also less flexible if we'd like to furth=
er
> > >      restrict ourselves compared to all the delegated functionality
> > >      allowed on BPF FS.
> > >   b) use non-bpf() interface, e.g., ioctl(), but otherwise also creat=
e
> > >      a dedicated FD that would represent a token-like functionality. =
This
> > >      doesn't seem superior to having a proper bpf() command, so
> > >      BPF_TOKEN_CREATE was chosen.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf.h            |  36 +++++++
> > >  include/uapi/linux/bpf.h       |  39 +++++++
> > >  kernel/bpf/Makefile            |   2 +-
> > >  kernel/bpf/inode.c             |   4 +-
> > >  kernel/bpf/syscall.c           |  17 +++
> > >  kernel/bpf/token.c             | 189 +++++++++++++++++++++++++++++++=
++
> > >  tools/include/uapi/linux/bpf.h |  39 +++++++
> > >  7 files changed, 324 insertions(+), 2 deletions(-)
> > >  create mode 100644 kernel/bpf/token.c
> >
> > ...
> >
> > > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > > new file mode 100644
> > > index 000000000000..f6ea3eddbee6
> > > --- /dev/null
> > > +++ b/kernel/bpf/token.c
> > > @@ -0,0 +1,189 @@
> > > +#include <linux/bpf.h>
> > > +#include <linux/vmalloc.h>
> > > +#include <linux/anon_inodes.h>
> > > +#include <linux/fdtable.h>
> > > +#include <linux/file.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/idr.h>
> > > +#include <linux/namei.h>
> > > +#include <linux/user_namespace.h>
> > > +
> > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > +{
> > > +     /* BPF token allows ns_capable() level of capabilities */
> > > +     if (token) {
> > > +             if (ns_capable(token->userns, cap))
> > > +                     return true;
> > > +             if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns,=
 CAP_SYS_ADMIN))
> > > +                     return true;
> > > +     }
> > > +     /* otherwise fallback to capable() checks */
> > > +     return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_S=
YS_ADMIN));
> > > +}
> >
> > While the above looks to be equivalent to the bpf_capable() function it
> > replaces, for callers checking CAP_BPF and CAP_SYS_ADMIN, I'm looking
> > quickly at patch 3/12 and this is also being used to replace a
> > capable(CAP_NET_ADMIN) call which results in a change in behavior.
> > The current code which performs a capable(CAP_NET_ADMIN) check cannot
> > be satisfied by CAP_SYS_ADMIN, but this patchset using
> > bpf_token_capable(token, CAP_NET_ADMIN) can be satisfied by either
> > CAP_NET_ADMIN or CAP_SYS_ADMIN.
> >
> > It seems that while bpf_token_capable() can be used as a replacement
> > for bpf_capable(), it is not currently a suitable replacement for a
> > generic capable() call.  Perhaps this is intentional, but I didn't see
> > it mentioned in the commit description, or in the comments, and I
> > wanted to make sure it wasn't an oversight.
>
> You are right. It is an intentional attempt to unify all such checks.
> If you look at bpf_prog_load(), we have this:
>
> if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) &&
> !capable(CAP_SYS_ADMIN))
>     return -EPERM;
>
> So seeing that, I realized that we did have an intent to always use
> CAP_SYS_ADMIN as a "fallback" cap, even for CAP_NET_ADMIN when it
> comes to using network-enabled BPF programs. So I decided that
> unifying all this makes sense.
>
> I'll add a comment mentioning this, I should have been more explicit
> from the get go.

Thanks for the clarification.  I'm not to worried about checking
CAP_SYS_ADMIN as a fallback, but I always get a little twitchy when I
see capability changes in the code without any mention.

A mention in the commit description is good, and you could also draft
up a standalone patch that adds the CAP_SYS_ADMIN fallback to the
current in-tree code.  That would be a good way to really highlight
the capability changes and deal with any issues that might arise
(review, odd corner cases?, etc.) prior to the BPF capability
delegation patcheset we are discussing here.

> > > +#define BPF_TOKEN_INODE_NAME "bpf-token"
> > > +
> > > +/* Alloc anon_inode and FD for prepared token.
> > > + * Returns fd >=3D 0 on success; negative error, otherwise.
> > > + */
> > > +int bpf_token_new_fd(struct bpf_token *token)
> > > +{
> > > +     return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops, =
token, O_CLOEXEC);
> > > +}
> > > +
> > > +struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> > > +{
> > > +     struct fd f =3D fdget(ufd);
> > > +     struct bpf_token *token;
> > > +
> > > +     if (!f.file)
> > > +             return ERR_PTR(-EBADF);
> > > +     if (f.file->f_op !=3D &bpf_token_fops) {
> > > +             fdput(f);
> > > +             return ERR_PTR(-EINVAL);
> > > +     }
> > > +
> > > +     token =3D f.file->private_data;
> > > +     bpf_token_inc(token);
> > > +     fdput(f);
> > > +
> > > +     return token;
> > > +}
> > > +
> > > +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd=
 cmd)
> > > +{
> > > +     if (!token)
> > > +             return false;
> > > +
> > > +     return token->allowed_cmds & (1ULL << cmd);
> > > +}
> >
> > I mentioned this a while back, likely in the other threads where this
> > token-based approach was only being discussed in general terms, but I
> > think we want to have a LSM hook at the point of initial token
> > delegation for this and a hook when the token is used.  My initial
> > thinking is that we should be able to address the former with a hook
> > in bpf_fill_super() and the latter either in bpf_token_get_from_fd()
> > or bpf_token_allow_XXX(); bpf_token_get_from_fd() would be simpler,
> > but it doesn't allow for much in the way of granularity.  Inserting the
> > LSM hooks in bpf_token_allow_XXX() would also allow the BPF code to fal=
l
> > gracefully fallback to the system-wide checks if the LSM denied the
> > requested access whereas an access denial in bpf_token_get_from_fd()
> > denial would cause the operation to error out.
>
> I think the bpf_fill_super() LSM hook makes sense, but I thought
> someone mentioned that we already have some generic LSM hook for
> validating mounts? If we don't, I can certainly add one for BPF FS
> specifically.

We do have security_sb_mount(), but that is a generic mount operation
access control and not well suited for controlling the mount-based
capability delegation that you are proposing here.  However, if you or
someone else has a clever way to make security_sb_mount() work for
this purpose I would be very happy to review that code.

> As for the bpf_token_allow_xxx(). This feels a bit too specific and
> narrow-focused. What if we later add yet another dimension for BPF FS
> and token? Do we need to introduce yet another LSM for each such case?

[I'm assuming you meant new LSM *hook*]

Possibly.  There are also some other issues which I've been thinking
about along these lines, specifically the fact that the
capability/command delegation happens after the existing
security_bpf() hook is called which makes things rather awkward from a
LSM perspective: the LSM would first need to allow the process access
to the desired BPF op using it's current LSM specific security
attributes (e.g. SELinux security domain, etc.) and then later
consider the op in the context of the delegated access control rights
(if the LSM decides to support those hooks).

I suspect that if we want to make this practical we would need to
either move some of the token code up into __sys_bpf() so we could
have a better interaction with security_bpf(), or we need to consider
moving the security_bpf() call into the op specific functions.  I'm
still thinking on this (lots of reviews to get through this week), but
I'm hoping there is a better way because I'm not sure I like either
option very much.

> But also see bpf_prog_load(). There are two checks, allow_prog_type
> and allow_attach_type, which are really only meaningful in
> combination. And yet you'd have to have two separate LSM hooks for
> that.
>
> So I feel like the better approach is less mechanistically
> concentrating on BPF token operations themselves, but rather on more
> semantically meaningful operations that are token-enabled. E.g.,
> protect BPF program loading, BPF map creation, BTF loading, etc. And
> we do have such LSM hooks right now, though they might not be the most
> convenient. So perhaps the right move is to add new ones that would
> provide a bit more context (e.g., we can pass in the BPF token that
> was used for the operation, attributes with which map/prog was
> created, etc). Low-level token LSMs seem hard to use cohesively in
> practice, though.

Can you elaborate a bit more?  It's hard to judge the comments above
without some more specifics about hook location, parameters, etc.

--=20
paul-moore.com
