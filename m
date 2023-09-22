Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3949F7ABBD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 00:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjIVWfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 18:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjIVWfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:35:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D34BAB;
        Fri, 22 Sep 2023 15:35:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-530bc7c5bc3so3515809a12.1;
        Fri, 22 Sep 2023 15:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695422138; x=1696026938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANlfw49WOxutZxpcO847NYJ7368SzZbTXfVB/LoISLk=;
        b=EZ+VjC4ASdVMSukYJdsLF98YAO8Q1o1BBEdbbIMDcIBe7sjldWPKvjJdp81hneJXma
         YZ3F7VuQaSWDnGcejKUtzggyr8AqaPPC9xTijxqErvMo+n6iCdGwJ+bQGS5dmn8UQKu1
         4btnUTgepOcBB1XR9nNLuXhE4ggOq4tAF4CUvkk8lliXa3XVauABKJD9kFEVuI8eo4Pg
         /eiVX7Fxvwvzz455kKqXbblF43ANLK1rhlIqCa2ljACf4w5Kvjb/zx/aFtl5snc6qVsi
         EV9NzCE8vNbBz/2rTUyx4x9PH687oeBZ+fO09X0FVavlGoT03yDR2rN+mN9YySGJh4Ig
         BKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695422138; x=1696026938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANlfw49WOxutZxpcO847NYJ7368SzZbTXfVB/LoISLk=;
        b=FSElQyLXdAmzjG0MMET6jTmlLTT2lSJ+kPQ+nAFqQSAHy0hhiCIPEQPNGU/H7ygrtp
         GGpVoYFvO3mF0fgFF2vu1AU1FkLC6aMOgY5yDFIcTToCRitLHXDmxsywkJrakRJwQi9e
         BK6CUubTOoH520YgMkxWX4PfTIEyYYAssxDjE3E/Bu4dIuIfIHbvU/Ks3i31mR4PeLOF
         +PJjwiG/Qqf7OSq9Jvu6vFMhVZHmJIpqL3TZWU6kfE10YzlUpx6KzgxJ8iPmsyVrmUHF
         m6KkQx3OZChhNMUzYv5IkSOLRKD3lAs+gZTLsY1A4ouZ0/bkFYepi/2oEWnH6aZmV9VL
         RgXA==
X-Gm-Message-State: AOJu0YwZ0dXAWAJkE/zarIzfPJD2k3Lm75CddisG0cA9XkpXPM7guUt3
        8M4KQRKcsL4pDPfdO760LB/ny6g6tmQVXT0GMm8=
X-Google-Smtp-Source: AGHT+IGRt9P4pULBqqnRwmWXEBaAwgLtV7hFKwoQFHrIHGZmHd2KNH3uImy7HkeJDfkWhL5cMKbpslBkDDw0IQJv1iY=
X-Received: by 2002:a17:907:1de5:b0:9ae:65d6:b882 with SMTP id
 og37-20020a1709071de500b009ae65d6b882mr491799ejc.40.1695422137320; Fri, 22
 Sep 2023 15:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230912212906.3975866-3-andrii@kernel.org> <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
 <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com>
 <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com>
 <CAEf4BzZC+9GbCsG56B2Q=woq+RHQS8oMTGJSNiMFKZpOKHhKpg@mail.gmail.com> <CAHC9VhTiqhQcfDr-7mThY1kH-Fwa7NUUU8ZWZvLFVudgtO8RAA@mail.gmail.com>
In-Reply-To: <CAHC9VhTiqhQcfDr-7mThY1kH-Fwa7NUUU8ZWZvLFVudgtO8RAA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Sep 2023 15:35:25 -0700
Message-ID: <CAEf4BzZ8RvGwzVfm-EN1qdDiTv3Q2eYxBKOdBgGT96XzcvJCpw@mail.gmail.com>
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 3:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Sep 15, 2023 at 4:59=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Thu, Sep 14, 2023 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Thu, Sep 14, 2023 at 1:31=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Wed, Sep 13, 2023 at 2:46=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > >
> > > > > On Sep 12, 2023 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote=
:
> > > > > >
> > > > > > Add new kind of BPF kernel object, BPF token. BPF token is mean=
t to
> > > > > > allow delegating privileged BPF functionality, like loading a B=
PF
> > > > > > program or creating a BPF map, from privileged process to a *tr=
usted*
> > > > > > unprivileged process, all while have a good amount of control o=
ver which
> > > > > > privileged operations could be performed using provided BPF tok=
en.
> > > > > >
> > > > > > This is achieved through mounting BPF FS instance with extra de=
legation
> > > > > > mount options, which determine what operations are delegatable,=
 and also
> > > > > > constraining it to the owning user namespace (as mentioned in t=
he
> > > > > > previous patch).
> > > > > >
> > > > > > BPF token itself is just a derivative from BPF FS and can be cr=
eated
> > > > > > through a new bpf() syscall command, BPF_TOKEN_CREAT, which acc=
epts
> > > > > > a path specification (using the usual fd + string path combo) t=
o a BPF
> > > > > > FS mount. Currently, BPF token "inherits" delegated command, ma=
p types,
> > > > > > prog type, and attach type bit sets from BPF FS as is. In the f=
uture,
> > > > > > having an BPF token as a separate object with its own FD, we ca=
n allow
> > > > > > to further restrict BPF token's allowable set of things either =
at the creation
> > > > > > time or after the fact, allowing the process to guard itself fu=
rther
> > > > > > from, e.g., unintentionally trying to load undesired kind of BP=
F
> > > > > > programs. But for now we keep things simple and just copy bit s=
ets as is.
> > > > > >
> > > > > > When BPF token is created from BPF FS mount, we take reference =
to the
> > > > > > BPF super block's owning user namespace, and then use that name=
space for
> > > > > > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_=
ADMIN}
> > > > > > capabilities that are normally only checked against init userns=
 (using
> > > > > > capable()), but now we check them using ns_capable() instead (i=
f BPF
> > > > > > token is provided). See bpf_token_capable() for details.
> > > > > >
> > > > > > Such setup means that BPF token in itself is not sufficient to =
grant BPF
> > > > > > functionality. User namespaced process has to *also* have neces=
sary
> > > > > > combination of capabilities inside that user namespace. So whil=
e
> > > > > > previously CAP_BPF was useless when granted within user namespa=
ce, now
> > > > > > it gains a meaning and allows container managers and sys admins=
 to have
> > > > > > a flexible control over which processes can and need to use BPF
> > > > > > functionality within the user namespace (i.e., container in pra=
ctice).
> > > > > > And BPF FS delegation mount options and derived BPF tokens serv=
e as
> > > > > > a per-container "flag" to grant overall ability to use bpf() (p=
lus further
> > > > > > restrict on which parts of bpf() syscalls are treated as namesp=
aced).
> > > > > >
> > > > > > The alternative to creating BPF token object was:
> > > > > >   a) not having any extra object and just pasing BPF FS path to=
 each
> > > > > >      relevant bpf() command. This seems suboptimal as it's racy=
 (mount
> > > > > >      under the same path might change in between checking it an=
d using it
> > > > > >      for bpf() command). And also less flexible if we'd like to=
 further
> > > > > >      restrict ourselves compared to all the delegated functiona=
lity
> > > > > >      allowed on BPF FS.
> > > > > >   b) use non-bpf() interface, e.g., ioctl(), but otherwise also=
 create
> > > > > >      a dedicated FD that would represent a token-like functiona=
lity. This
> > > > > >      doesn't seem superior to having a proper bpf() command, so
> > > > > >      BPF_TOKEN_CREATE was chosen.
> > > > > >
> > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > > ---
> > > > > >  include/linux/bpf.h            |  36 +++++++
> > > > > >  include/uapi/linux/bpf.h       |  39 +++++++
> > > > > >  kernel/bpf/Makefile            |   2 +-
> > > > > >  kernel/bpf/inode.c             |   4 +-
> > > > > >  kernel/bpf/syscall.c           |  17 +++
> > > > > >  kernel/bpf/token.c             | 189 +++++++++++++++++++++++++=
++++++++
> > > > > >  tools/include/uapi/linux/bpf.h |  39 +++++++
> > > > > >  7 files changed, 324 insertions(+), 2 deletions(-)
> > > > > >  create mode 100644 kernel/bpf/token.c
> > > > >
> > > > > ...
> > > > >
> > > > > > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..f6ea3eddbee6
> > > > > > --- /dev/null
> > > > > > +++ b/kernel/bpf/token.c
> > > > > > @@ -0,0 +1,189 @@
> > > > > > +#include <linux/bpf.h>
> > > > > > +#include <linux/vmalloc.h>
> > > > > > +#include <linux/anon_inodes.h>
> > > > > > +#include <linux/fdtable.h>
> > > > > > +#include <linux/file.h>
> > > > > > +#include <linux/fs.h>
> > > > > > +#include <linux/kernel.h>
> > > > > > +#include <linux/idr.h>
> > > > > > +#include <linux/namei.h>
> > > > > > +#include <linux/user_namespace.h>
> > > > > > +
> > > > > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > > > +{
> > > > > > +     /* BPF token allows ns_capable() level of capabilities */
> > > > > > +     if (token) {
> > > > > > +             if (ns_capable(token->userns, cap))
> > > > > > +                     return true;
> > > > > > +             if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->u=
serns, CAP_SYS_ADMIN))
> > > > > > +                     return true;
> > > > > > +     }
> > > > > > +     /* otherwise fallback to capable() checks */
> > > > > > +     return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable=
(CAP_SYS_ADMIN));
> > > > > > +}
> > > > >
> > > > > While the above looks to be equivalent to the bpf_capable() funct=
ion it
> > > > > replaces, for callers checking CAP_BPF and CAP_SYS_ADMIN, I'm loo=
king
> > > > > quickly at patch 3/12 and this is also being used to replace a
> > > > > capable(CAP_NET_ADMIN) call which results in a change in behavior=
.
> > > > > The current code which performs a capable(CAP_NET_ADMIN) check ca=
nnot
> > > > > be satisfied by CAP_SYS_ADMIN, but this patchset using
> > > > > bpf_token_capable(token, CAP_NET_ADMIN) can be satisfied by eithe=
r
> > > > > CAP_NET_ADMIN or CAP_SYS_ADMIN.
> > > > >
> > > > > It seems that while bpf_token_capable() can be used as a replacem=
ent
> > > > > for bpf_capable(), it is not currently a suitable replacement for=
 a
> > > > > generic capable() call.  Perhaps this is intentional, but I didn'=
t see
> > > > > it mentioned in the commit description, or in the comments, and I
> > > > > wanted to make sure it wasn't an oversight.
> > > >
> > > > You are right. It is an intentional attempt to unify all such check=
s.
> > > > If you look at bpf_prog_load(), we have this:
> > > >
> > > > if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) &&
> > > > !capable(CAP_SYS_ADMIN))
> > > >     return -EPERM;
> > > >
> > > > So seeing that, I realized that we did have an intent to always use
> > > > CAP_SYS_ADMIN as a "fallback" cap, even for CAP_NET_ADMIN when it
> > > > comes to using network-enabled BPF programs. So I decided that
> > > > unifying all this makes sense.
> > > >
> > > > I'll add a comment mentioning this, I should have been more explici=
t
> > > > from the get go.
> > >
> > > Thanks for the clarification.  I'm not to worried about checking
> > > CAP_SYS_ADMIN as a fallback, but I always get a little twitchy when I
> > > see capability changes in the code without any mention.
> > >
> > > A mention in the commit description is good, and you could also draft
> > > up a standalone patch that adds the CAP_SYS_ADMIN fallback to the
> > > current in-tree code.  That would be a good way to really highlight
> > > the capability changes and deal with any issues that might arise
> > > (review, odd corner cases?, etc.) prior to the BPF capability
> > > delegation patcheset we are discussing here.
> >
> > Sure, sounds good, I'll add this as a pre-patch for next revision.
>
> My apologies on the delay, I've been traveling this week and haven't
> had the time to dig back into this.
>

No worries, lots of conferences are happening right now, so I expected
people to be unavailable.

> I do see that you've posted another revision of this patchset with the
> capability pre-patch, thanks for doing that.

Yep, hopefully networking folks won't be opposed and we can streamline
all that a bit.

>
> > > > > > +#define BPF_TOKEN_INODE_NAME "bpf-token"
> > > > > > +
> > > > > > +/* Alloc anon_inode and FD for prepared token.
> > > > > > + * Returns fd >=3D 0 on success; negative error, otherwise.
> > > > > > + */
> > > > > > +int bpf_token_new_fd(struct bpf_token *token)
> > > > > > +{
> > > > > > +     return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_=
fops, token, O_CLOEXEC);
> > > > > > +}
> > > > > > +
> > > > > > +struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> > > > > > +{
> > > > > > +     struct fd f =3D fdget(ufd);
> > > > > > +     struct bpf_token *token;
> > > > > > +
> > > > > > +     if (!f.file)
> > > > > > +             return ERR_PTR(-EBADF);
> > > > > > +     if (f.file->f_op !=3D &bpf_token_fops) {
> > > > > > +             fdput(f);
> > > > > > +             return ERR_PTR(-EINVAL);
> > > > > > +     }
> > > > > > +
> > > > > > +     token =3D f.file->private_data;
> > > > > > +     bpf_token_inc(token);
> > > > > > +     fdput(f);
> > > > > > +
> > > > > > +     return token;
> > > > > > +}
> > > > > > +
> > > > > > +bool bpf_token_allow_cmd(const struct bpf_token *token, enum b=
pf_cmd cmd)
> > > > > > +{
> > > > > > +     if (!token)
> > > > > > +             return false;
> > > > > > +
> > > > > > +     return token->allowed_cmds & (1ULL << cmd);
> > > > > > +}
> > > > >
> > > > > I mentioned this a while back, likely in the other threads where =
this
> > > > > token-based approach was only being discussed in general terms, b=
ut I
> > > > > think we want to have a LSM hook at the point of initial token
> > > > > delegation for this and a hook when the token is used.  My initia=
l
> > > > > thinking is that we should be able to address the former with a h=
ook
> > > > > in bpf_fill_super() and the latter either in bpf_token_get_from_f=
d()
> > > > > or bpf_token_allow_XXX(); bpf_token_get_from_fd() would be simple=
r,
> > > > > but it doesn't allow for much in the way of granularity.  Inserti=
ng the
> > > > > LSM hooks in bpf_token_allow_XXX() would also allow the BPF code =
to fall
> > > > > gracefully fallback to the system-wide checks if the LSM denied t=
he
> > > > > requested access whereas an access denial in bpf_token_get_from_f=
d()
> > > > > denial would cause the operation to error out.
> > > >
> > > > I think the bpf_fill_super() LSM hook makes sense, but I thought
> > > > someone mentioned that we already have some generic LSM hook for
> > > > validating mounts? If we don't, I can certainly add one for BPF FS
> > > > specifically.
> > >
> > > We do have security_sb_mount(), but that is a generic mount operation
> > > access control and not well suited for controlling the mount-based
> > > capability delegation that you are proposing here.  However, if you o=
r
> > > someone else has a clever way to make security_sb_mount() work for
> > > this purpose I would be very happy to review that code.
> >
> > To be honest, I'm a bit out of my depth here, as I don't know the
> > mounting parts well. Perhaps someone from VFS side can advise. But
> > regardless, I have no problem adding a new LSM hook as well, ideally
> > not very BPF-specific. If you have a specific form of it in mind, I'd
> > be curious to see it and implement it.
>
> I agree that there can be benefits to generalized LSM hooks, but in
> this hook I think it may need to be BPF specific simply because the
> hook would be dealing with the specific concept of delegating BPF
> permissions.

Sure. As an alternative, if this is about controlling BPF delegation,
instead of doing mount-time checks and LSM hook, perhaps we can add a
new LSM hook to BPF_CREATE_TOKEN, just like we have ones for
BPF_MAP_CREATE and BPF_PROG_LOAD. That will enable controlling
delegation more directly when it is actually attempted to be used.

>
> I haven't taken the time to write up any hook patches yet as I wanted
> to discuss it with you and the others on the To/CC line, but it seems
> like we are roughly on the same page, at least with the initial
> delegation hook, so I can put something together if you aren't
> comfortable working on this (more on this below) ...

I'd appreciate the help from the SELinux side specifically, yes. I'm
absolutely OK to add a few new LSM hooks, though.

>
> > > > As for the bpf_token_allow_xxx(). This feels a bit too specific and
> > > > narrow-focused. What if we later add yet another dimension for BPF =
FS
> > > > and token? Do we need to introduce yet another LSM for each such ca=
se?
> > >
> > > [I'm assuming you meant new LSM *hook*]
> >
> > yep, of course, sorry about using terminology sloppily
> >
> > >
> > > Possibly.  There are also some other issues which I've been thinking
> > > about along these lines, specifically the fact that the
> > > capability/command delegation happens after the existing
> > > security_bpf() hook is called which makes things rather awkward from =
a
> > > LSM perspective: the LSM would first need to allow the process access
> > > to the desired BPF op using it's current LSM specific security
> > > attributes (e.g. SELinux security domain, etc.) and then later
> > > consider the op in the context of the delegated access control rights
> > > (if the LSM decides to support those hooks).
> > >
> > > I suspect that if we want to make this practical we would need to
> > > either move some of the token code up into __sys_bpf() so we could
> > > have a better interaction with security_bpf(), or we need to consider
> > > moving the security_bpf() call into the op specific functions.  I'm
> > > still thinking on this (lots of reviews to get through this week), bu=
t
> > > I'm hoping there is a better way because I'm not sure I like either
> > > option very much.
> >
> > Yes, security_bpf() is happening extremely early and is lacking a lot
> > of context. I'm not sure if moving it around is a good idea as it
> > basically changes its semantics.
>
> There are a couple of things that make this not quite as scary as it
> may seem.  The first is that currently only SELinux implements a
> security_bpf() hook and the implementation is rather simplistic in
> terms of what information it requires to perform the existing access
> controls; decomposing the single security_bpf() call site into
> multiple op specific calls, perhaps with some op specific hooks,
> should be doable without causing major semantic changes.  The second
> thing is that we could augment the existing security_bpf() hook and
> call site with a new LSM hook(s) that are called from the op specific
> call sites; this would allow those LSMs that desire the current
> semantics to use the existing security_bpf() hook and those that wish
> to use the new semantics could implement the new hook(s).  This is
> very similar to the pathname-based and inode-based hooks in the VFS
> layer, some LSMs choose to implement pathname-based security and use
> one set of hooks, while others implement a label-based security
> mechanism and use a different set of hooks.
>

Agreed. I think new LSM hooks that are operation-specific make a lot
of sense. I'd probably not touch existing security_bpf(), it's an
early-entry LSM hook for anything bpf() syscall-specific. This might
be very useful in some cases, probably.

> > But adding a new set of coherent LSM
> > hooks per each appropriate BPF operation with good context to make
> > decisions sounds like a good improvement. E.g., for BPF_PROG_LOAD, we
> > can have LSM hook after struct bpf_prog is allocated, bpf_token is
> > available, attributes are sanity checked. All that together is a very
> > useful and powerful context that can be used both by more fixed LSM
> > policies (like SELinux), and very dynamic user-defined BPF LSM
> > programs.
>
> This is where it is my turn to mention that I'm getting a bit out of
> my depth, but I'm hopeful that the two of us can keep each other from
> drowning :)
>
> Typically the LSM hook call sites end up being in the same general
> area as the capability checks, usually just after (we want the normal
> Linux discretionary access controls to always come first for the sake
> of consistency).  Sticking with that approach it looks like we would
> end up with a LSM call in bpf_prog_load() right after bpf_capable()
> call, the only gotcha with that is the bpf_prog struct isn't populated
> yet, but how important is that when we have the bpf_attr info (honest
> question, I don't know the answer to this)?

Ok, so I agree in general about having LSM hooks close to capability
checks, but at least specifically for BPF_PROG_CREATE, it won't work.
This bpf_capable() check you mention. This is just one check. If you
look into bpf_prog_load() in kernel/bpf/syscall.c, you'll see that we
can also check CAP_PERFMON, CAP_NET_ADMIN, and CAP_SYS_ADMIN, in
addition to CAP_BPF, based on various aspects (like program type +
subtype). So for such a complex BPF_PROG_CREATE operation I think we
should deviate a bit and place LSM in a logical place that would
enable doing LSM enforcement with lots of relevant information, but
before doing anything dangerous or expensive.

For BPF_PROG_LOAD that place seems to be right before bpf_check(),
which is BPF verification. By that time we did a bunch of different
sanity checks, resolved various things (like found another bpf_program
to attach to, if requested), copied user-provided strings (e.g.,
license), etc, etc. That's tons of good stuff to be used for either
audit or enforcement.

This also answers your question about why bpf_attr isn't enough.
bpf_attr has various FDs, data pointers (program instructions),
strings, etc, etc. All of that might be a) inconvenient to fetch (at
least from BPF LSM) and/or b) racy (e.g., FD can get changed between
the check and actual usage). So while bpf_attr is useful as an input,
ideally we'd augment it with bpf_prog and bpf_token.

Right now we have `security_bpf_prog_alloc(prog->aux);`, which is
almost in the ideal place, but provides prog->aux instead of program
itself (not sure why), and doesn't provide bpf_attr and bpf_token.

So I'm thinking that maybe we get rid of bpf_prog_alloc() in favor of
new security_bpf_prog_load(prog, &attr, token)?

>
> Ignoring the bpf_prog struct, do you think something like this would
> work for a hook call site (please forgive the pseudo code)?
>
>   int bpf_prog_load(...)
>   {
>          ...
>      bpf_cap =3D bpf_token_capable(token, CAP_BPF);
>      err =3D security_bpf_token(BPF_PROG_LOAD, attr, uattr_size, token);
>      if (err)
>        return err;
>     ...
>   }
>

See above, I think this should be program-centric, not token-centric.


> Assuming this type of hook configuration, and an empty/passthrough
> security_bpf() hook, a LSM would first see the various
> capable()/ns_capable() checks present in bpf_token_capable() followed
> by a BPF op check, complete with token, in the security_bpf_token()
> hook.  Further assuming that we convert the bpf_token_new_fd() to use
> anon_inode_getfd_secure() instead of anon_inode_getfd() and the
> security_bpf_token() could still access the token fd via the bpf_attr

wouldn't this be a race to read FD from bpf_attr for LSM, and then
separately read it again in bpf_prog_load()? That seems like TOCTOU to
me? As I mentioned above, I think bpf_token should be provided as an
argument after it was "extracted" from FD in one place.

> struct I think we could do something like this for the SELinux case
> (more rough pseudo code):
>
>   int selinux_bpf_token(...)
>   {
>     ssid =3D current_sid();
>     if (token) {
>       /* this could be simplified with better integration
>        * in bpf_token_get_from_fd() */
>       fd =3D fdget(attr->prog_token_fd);
>       inode =3D file_inode(fd.file);
>       isec =3D selinux_inode(inode);
>       tsid =3D isec->sid;
>       fdput(fd);
>     } else
>       tsid =3D ssid;
>     switch(cmd) {
>     ...
>     case BPF_PROG_LOAD:
>       rc =3D avc_has_perm(ssid, tsid, SECCLAS_BPF, BPF__PROG_LOAD);
>       break;
>     default:
>       rc =3D 0;
>     }
>     return rc;
>   }
>
> This would preserve the current behaviour when a token was not present:
>
>  allow @current @current : bpf { prog_load }
>
> ... but this would change to the following if a token was present:
>
>  allow @current @DELEGATED_ANON_INODE : bpf { prog_load }
>
> That seems reasonable to me, but I've CC'd the SELinux list on this so
> others can sanity check the above :)

doesn't seem like using anon_inode_getfd_secure() should be a big deal

>
> > But I'd like to keep all that outside of the BPF token feature itself,
> > as it's already pretty hard to get a consensus just on those bits, so
> > complicating this with simultaneously designing a new set of LSM hooks
> > is something that we should avoid. Let's keep discussing this, but not
> > block that on BPF token.
>
> The unfortunate aspect of disconnecting new functionality from the
> associated access controls is that it introduces a gap where the new
> functionality is not secured in a manner that users expect.  There are
> billions of systems/users that rely on LSM-based access controls for a
> large part of their security story, and I think we are doing them a
> disservice by not including the LSM controls with new security
> significant features.
>
> We (the LSM folks) are happy to work with you to get this sorted out,
> and I would hope my comments in this thread (as well as prior
> iterations) and the rough design above is a good faith indicator of
> that.

I'd be happy to collaborate on designing proper LSM hooks around all
this (which is what we are doing right now, I believe). I'm just
trying to think pragmatically how this should all work logistically.
This patch set gets the BPF token concept into the kernel. But there
is more work to do in libbpf and other supporting infrastructure to
make proper use of it. So I'm just trying to avoid going too broad
with this patch set.

But if you'd be ok to converge on the design of BPF token-enabled LSM
hooks for bpf() syscall here, I'm happy to implement them. I'm not
feeling confident enough to do SELinux work on top, though, so that's
where I'd appreciate help. If LSM folks would be willing to add
SELinux interface on top of LSM hooks, we'd be able to parallelize
this work with me finishing libbpf and user-space parts, while you or
someone else finalizes the SELinux details.

How does that sound to you?

>
> > > > But also see bpf_prog_load(). There are two checks, allow_prog_type
> > > > and allow_attach_type, which are really only meaningful in
> > > > combination. And yet you'd have to have two separate LSM hooks for
> > > > that.
> > > >
> > > > So I feel like the better approach is less mechanistically
> > > > concentrating on BPF token operations themselves, but rather on mor=
e
> > > > semantically meaningful operations that are token-enabled. E.g.,
> > > > protect BPF program loading, BPF map creation, BTF loading, etc. An=
d
> > > > we do have such LSM hooks right now, though they might not be the m=
ost
> > > > convenient. So perhaps the right move is to add new ones that would
> > > > provide a bit more context (e.g., we can pass in the BPF token that
> > > > was used for the operation, attributes with which map/prog was
> > > > created, etc). Low-level token LSMs seem hard to use cohesively in
> > > > practice, though.
> > >
> > > Can you elaborate a bit more?  It's hard to judge the comments above
> > > without some more specifics about hook location, parameters, etc.
> >
> > So something like my above proposal for a new LSM hook in
> > BPF_PROG_LOAD command. Just right before passing bpf_prog to BPF
> > verifier, we can have
> >
> > err =3D security_bpf_prog_load(prog, attr, token)
> > if (err)
> >     return -EPERM;
> >
> > Program, attributes, and token give a lot of inputs for security
> > policy logic to make a decision about allowing that specific BPF
> > program to be verified and loaded or not. I know how this could be
> > used from BPF LSM side, but I assume that SELinux and others can take
> > advantage of that provided additional context as well.
>
> If you think a populated bpf_prog struct is important for BPF LSM
> programs then I have no problem with that hook placement.  It's a lot
> later in the process than we might normally want to place the hook,
> but we can still safely error out here so that should be okay.
>
> From a LSM perspective I think we can make either work, I think the
> big question is which would you rather have in the BPF code: the
> security_bpf_prog_load() hook you've suggested here or the
> security_bpf_token() hook I suggested above?

I think security_bpf_prog_load() makes more sense, as I tried to lay
out above. But you know, it's not set in stone yet, so let's try to
converge. I tried to elaborate on why security_bpf_prog_load() and
then separately security_bpf_map_create(), etc make most sense. For
BPF LSM, having pointer to struct bpf_prog* and struct bpf_token* is a
huge benefit compared to trying to somehow get them out of union
bpf_attr. Same for map creation or any other BPF object that bpf()
syscall operates on.

>
> > Similarly we can have a BPF_MAP_CREATE-specific LSM hook with context
> > relevant to creating a BPF map. And so on.
>
> Of course.  I've been operating under the assumption that whatever we
> do for one op we should be able to apply the same idea to the others
> that need it.
>

Awesome, yep.

> --
> paul-moore.com
