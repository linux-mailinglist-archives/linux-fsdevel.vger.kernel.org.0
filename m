Return-Path: <linux-fsdevel+bounces-232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAE87C7A8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 01:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192C22811F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 23:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9E32C84A;
	Thu, 12 Oct 2023 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPNJzRXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112B2B5EC;
	Thu, 12 Oct 2023 23:45:37 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12D1BE;
	Thu, 12 Oct 2023 16:45:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo2570399a12.3;
        Thu, 12 Oct 2023 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697154332; x=1697759132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6DcnUjYZaBjd/VglYihkkK6kZBKXa25kMV2/Lt73cQ=;
        b=EPNJzRXW9hwKR1VvnEa4Kc3Kxn2h37Xrq7CcwFeplG2vjrAcp9XOrA/9CAuLMa9Fwo
         TuewqhODvbsMVYLqIe6Mhh3RMwUi8eBmk7ug3Q1wW8ZjpAH68MM/jo4etiV5YXxl5FYJ
         edJltBI0Zl2V9yJGs9sNLKaSj7X19huMdYBrH7oSbNkZiLmfZOohyZc0RH1PWg7rP76f
         5XioA8/FouDPghCve4ErL8SzQypaIDZwpzxbyv6HwxO26LzU9H/67vk96cniph8ecHYS
         LpHoa8u06OKuxdwWYg3i7my/wThFtqD3fvw0pky3lsKU7CPNttHSMXXgy081lWuNn8mr
         SQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697154332; x=1697759132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6DcnUjYZaBjd/VglYihkkK6kZBKXa25kMV2/Lt73cQ=;
        b=X7ZWstJLnsCY1+kdk2hqOs+7v3T7rEyqy2dXqxYdsiWefkto0PvE9wUN1Mt+AMlSaM
         pbXK4pkKepGawdMQxcv7Srtgvs0FesZ6ZIL/SuHxpTeshxM9PeOxvAXeEPfCLB3Av36S
         /Nvgyk2er4YEpKlxJ8VKcJVWT1n6qzv6qgHmFYPiKiqusrhZzTlQkSmEAbXRVHTT5a06
         urQNd9RF5pZn587j5fwKK4FyHEcdK7y59vVYZaOO5TrfMpqdhGdok/wkLjYIpCea1RXx
         JECvTOfXuRGglKYzfXx2zp+qrIUiMg4uySOkoW2jYZ3LG72kgsaZbq5CikZJltFySPic
         14ZA==
X-Gm-Message-State: AOJu0YwKYUZ4JSw6h/YgGyX5HI9PmZZ4/Syo/8iiVfGxEvHDZmGHhgb5
	p6JLVoNofch4omEoNDvo9CbUa/7oRwMO/wQaai8=
X-Google-Smtp-Source: AGHT+IEyrmGmfUG41jq/mqzGZg/mTaDSsoOMRrSKDGLDcSh5USf/IOFZRKNsGHlU6QGMV1C/B4c8C+P1jgo0VVFMkM0=
X-Received: by 2002:a05:6402:134a:b0:534:63e:d0b7 with SMTP id
 y10-20020a056402134a00b00534063ed0b7mr23794659edw.23.1697154331848; Thu, 12
 Oct 2023 16:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927225809.2049655-4-andrii@kernel.org> <53183ab045f8154ef94070039d53bbab.paul@paul-moore.com>
 <CAEf4BzaTZ_EY4JVZ3ozGzed1PeD+HNGgkDw6jGpWYD_K9c8RFw@mail.gmail.com> <CAHC9VhSG4T0LMEuFOqOdmS1KdSy2N9DsrypZL6dTAuDf-pZhZw@mail.gmail.com>
In-Reply-To: <CAHC9VhSG4T0LMEuFOqOdmS1KdSy2N9DsrypZL6dTAuDf-pZhZw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 16:45:20 -0700
Message-ID: <CAEf4BzZUsFvz2ESu_jCkRHa31CFcWFhHKuBJw9dz=ixg6znXKA@mail.gmail.com>
Subject: Re: [PATCH v6 3/13] bpf: introduce BPF token object
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 4:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Oct 11, 2023 at 8:31=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Tue, Oct 10, 2023 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Sep 27, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > > > allow delegating privileged BPF functionality, like loading a BPF
> > > > program or creating a BPF map, from privileged process to a *truste=
d*
> > > > unprivileged process, all while have a good amount of control over =
which
> > > > privileged operations could be performed using provided BPF token.
> > > >
> > > > This is achieved through mounting BPF FS instance with extra delega=
tion
> > > > mount options, which determine what operations are delegatable, and=
 also
> > > > constraining it to the owning user namespace (as mentioned in the
> > > > previous patch).
> > > >
> > > > BPF token itself is just a derivative from BPF FS and can be create=
d
> > > > through a new bpf() syscall command, BPF_TOKEN_CREAT, which accepts
> > > > a path specification (using the usual fd + string path combo) to a =
BPF
> > > > FS mount. Currently, BPF token "inherits" delegated command, map ty=
pes,
> > > > prog type, and attach type bit sets from BPF FS as is. In the futur=
e,
> > > > having an BPF token as a separate object with its own FD, we can al=
low
> > > > to further restrict BPF token's allowable set of things either at t=
he creation
> > > > time or after the fact, allowing the process to guard itself furthe=
r
> > > > from, e.g., unintentionally trying to load undesired kind of BPF
> > > > programs. But for now we keep things simple and just copy bit sets =
as is.
> > > >
> > > > When BPF token is created from BPF FS mount, we take reference to t=
he
> > > > BPF super block's owning user namespace, and then use that namespac=
e for
> > > > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMI=
N}
> > > > capabilities that are normally only checked against init userns (us=
ing
> > > > capable()), but now we check them using ns_capable() instead (if BP=
F
> > > > token is provided). See bpf_token_capable() for details.
> > > >
> > > > Such setup means that BPF token in itself is not sufficient to gran=
t BPF
> > > > functionality. User namespaced process has to *also* have necessary
> > > > combination of capabilities inside that user namespace. So while
> > > > previously CAP_BPF was useless when granted within user namespace, =
now
> > > > it gains a meaning and allows container managers and sys admins to =
have
> > > > a flexible control over which processes can and need to use BPF
> > > > functionality within the user namespace (i.e., container in practic=
e).
> > > > And BPF FS delegation mount options and derived BPF tokens serve as
> > > > a per-container "flag" to grant overall ability to use bpf() (plus =
further
> > > > restrict on which parts of bpf() syscalls are treated as namespaced=
).
> > > >
> > > > The alternative to creating BPF token object was:
> > > >   a) not having any extra object and just pasing BPF FS path to eac=
h
> > > >      relevant bpf() command. This seems suboptimal as it's racy (mo=
unt
> > > >      under the same path might change in between checking it and us=
ing it
> > > >      for bpf() command). And also less flexible if we'd like to fur=
ther
> > > >      restrict ourselves compared to all the delegated functionality
> > > >      allowed on BPF FS.
> > > >   b) use non-bpf() interface, e.g., ioctl(), but otherwise also cre=
ate
> > > >      a dedicated FD that would represent a token-like functionality=
. This
> > > >      doesn't seem superior to having a proper bpf() command, so
> > > >      BPF_TOKEN_CREATE was chosen.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  include/linux/bpf.h            |  40 +++++++
> > > >  include/uapi/linux/bpf.h       |  39 +++++++
> > > >  kernel/bpf/Makefile            |   2 +-
> > > >  kernel/bpf/inode.c             |  10 +-
> > > >  kernel/bpf/syscall.c           |  17 +++
> > > >  kernel/bpf/token.c             | 197 +++++++++++++++++++++++++++++=
++++
> > > >  tools/include/uapi/linux/bpf.h |  39 +++++++
> > > >  7 files changed, 339 insertions(+), 5 deletions(-)
> > > >  create mode 100644 kernel/bpf/token.c
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index a5bd40f71fd0..c43131a24579 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -1572,6 +1576,13 @@ struct bpf_mount_opts {
> > > >       u64 delegate_attachs;
> > > >  };
> > > >
> > > > +struct bpf_token {
> > > > +     struct work_struct work;
> > > > +     atomic64_t refcnt;
> > > > +     struct user_namespace *userns;
> > > > +     u64 allowed_cmds;
> > >
> > > We'll also need a 'void *security' field to go along with the BPF tok=
en
> > > allocation/creation/free hooks, see my comments below.  This is simil=
ar
> > > to what we do for other kernel objects.
> >
> > ok, I'm thinking of adding a dedicated patch for all the
> > security-related stuff and refactoring of existing LSM hook(s).
>
> No objection here.  My main concern is that we get the LSM stuff in
> the same patchset as the rest of the BPF token patches; if all of the
> LSM bits are in a separate patch I'm not bothered.
>
> Once we settle on the LSM hooks I'll draft a SELinux implementation of
> the hooks which I'll hand off to you for inclusion in the patchset as
> well.  I'd encourage the other LSMs that are interested to do the
> same.

I posted v7 ([0]) a few minutes ago, please take a look when you get a
chance. All the LSM-related stuff is in a few separate patches.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D792765&=
state=3D*

>
> > > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > +{
> > > > +     /* BPF token allows ns_capable() level of capabilities */
> > > > +     if (token) {
> > >
> > > I think we want a LSM hook here before the token is used in the
> > > capability check.  The LSM will see the capability check, but it will
> > > not be able to distinguish it from the process which created the
> > > delegation token.  This is arguably the purpose of the delegation, bu=
t
> > > with the LSM we want to be able to control who can use the delegated
> > > privilege.  How about something like this:
> > >
> > >   if (security_bpf_token_capable(token, cap))
> > >      return false;
> >
> > sounds good, I'll add this hook
> >
> > btw, I'm thinking of guarding the BPF_TOKEN_CREATE command behind the
> > ns_capable(CAP_BPF) check, WDYT? This seems appropriate. You can get
> > BPF token only if you have CAP_BPF **within the userns**, so any
> > process not granted CAP_BPF within namespace ("container") is
> > guaranteed to not be able to do anything with BPF token.
>
> I don't recall seeing any capability checks guarding BPF_TOKEN_CREATE
> in this revision so I don't think you're weakening the restrictions
> any, and the logic above seems reasonable: if you don't have CAP_BPF
> you shouldn't be creating a token.

Right, there was none based on the assumption that you have to have an
access to BPF FS controlled through other means. But it does seem
right to use ns_capable(CAP_BPF) in addition to all that, so that's
what I did in v7.

>
> > > > +static struct bpf_token *bpf_token_alloc(void)
> > > > +{
> > > > +     struct bpf_token *token;
> > > > +
> > > > +     token =3D kvzalloc(sizeof(*token), GFP_USER);
> > > > +     if (!token)
> > > > +             return NULL;
> > > > +
> > > > +     atomic64_set(&token->refcnt, 1);
> > >
> > > We should have a LSM hook here to allocate the LSM state associated
> > > with the token.
> > >
> > >   if (security_bpf_token_alloc(token)) {
> > >     kvfree(token);
> > >     return NULL;
> > >   }
> > >
> > > > +     return token;
> > > > +}
> > >
> > > ...
> > >
> >
> > Would having userns and allowed_* masks filled out by that time inside
> > the token be useful (seems so if we treat bpf_token_alloc as generic
> > LSM hook). If yes, I'll add security_bpf_token_alloc() after all that
> > is filled out, right before we try to get unused fd. WDYT?
>
> The security_bpf_token_alloc() hook isn't intended to do any access
> control, it's just there so that the LSMs which need to allocate state
> for the token object can do so at the same time the token is
> allocated.  It has been my experience that allocating and releasing
> the LSM state at the same time as the primary object's state is much
> less fragile than disconnecting the two lifetimes and allocating the
> LSM state later.

You'll be able to see what I did in v7, but I don't think separate
lifetimes are a concern, because all these alloc/free hooks are called
just as bpf_{prog,map,token} are created or right when they are freed,
so in that regard everything is good.

But based on our discussion to rework bpf_prog_alloc/bpf_map_alloc
into bpf_prog_load/bpf_map_create, it would be inconsistent between
prog/map and token. Anyways, the code is out, take a look. If you hate
it, it's just a matter of adding one extra LSM hook for token, map,
and prog each.

>
> > > > +int bpf_token_create(union bpf_attr *attr)
> > > > +{
> > > > +     struct bpf_mount_opts *mnt_opts;
> > > > +     struct bpf_token *token =3D NULL;
> > > > +     struct inode *inode;
> > > > +     struct file *file;
> > > > +     struct path path;
> > > > +     umode_t mode;
> > > > +     int err, fd;
> > > > +
> > > > +     err =3D user_path_at(attr->token_create.bpffs_path_fd,
> > > > +                        u64_to_user_ptr(attr->token_create.bpffs_p=
athname),
> > > > +                        LOOKUP_FOLLOW | LOOKUP_EMPTY, &path);
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > > > +     if (path.mnt->mnt_root !=3D path.dentry) {
> > > > +             err =3D -EINVAL;
> > > > +             goto out_path;
> > > > +     }
> > > > +     err =3D path_permission(&path, MAY_ACCESS);
> > > > +     if (err)
> > > > +             goto out_path;
> > > > +
> > > > +     mode =3D S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
> > > > +     inode =3D bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
> > > > +     if (IS_ERR(inode)) {
> > > > +             err =3D PTR_ERR(inode);
> > > > +             goto out_path;
> > > > +     }
> > > > +
> > > > +     inode->i_op =3D &bpf_token_iops;
> > > > +     inode->i_fop =3D &bpf_token_fops;
> > > > +     clear_nlink(inode); /* make sure it is unlinked */
> > > > +
> > > > +     file =3D alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_N=
AME, O_RDWR, &bpf_token_fops);
> > > > +     if (IS_ERR(file)) {
> > > > +             iput(inode);
> > > > +             err =3D PTR_ERR(file);
> > > > +             goto out_file;
> > > > +     }
> > > > +
> > > > +     token =3D bpf_token_alloc();
> > > > +     if (!token) {
> > > > +             err =3D -ENOMEM;
> > > > +             goto out_file;
> > > > +     }
> > > > +
> > > > +     /* remember bpffs owning userns for future ns_capable() check=
s */
> > > > +     token->userns =3D get_user_ns(path.dentry->d_sb->s_user_ns);
> > > > +
> > > > +     mnt_opts =3D path.dentry->d_sb->s_fs_info;
> > > > +     token->allowed_cmds =3D mnt_opts->delegate_cmds;
> > >
> > > I think we would want a LSM hook here, both to control the creation
> > > of the token and mark it with the security attributes of the creating
> > > process.  How about something like this:
> > >
> > >   err =3D security_bpf_token_create(token);
> > >   if (err)
> > >     goto out_token;
> >
> > hmm... so you'd like both security_bpf_token_alloc() and
> > security_bpf_token_create()? They seem almost identical, do we need
> > two? Or is it that the security_bpf_token_alloc() is supposed to be
> > only used to create those `void *security` context pieces, while
> > security_bpf_token_create() is actually going to be used for
> > enforcement?
>
> I tried to explain a bit in my comment above, but the alloc hook
> basically just does the LSM state allocation whereas the token_create
> hook does the access control and setting of the LSM state associated
> with the token.
>
> If you want to get rid of the bpf_token_alloc() function and fold it
> into the bpf_token_create() function then we can go down to one LSM
> hook that covers state allocation, initialization, and access control.
> However, if it remains possible to allocate a token object outside of
> bpf_token_create() I think it is a good idea to keep the dedicated LSM
> allocation hooks.
>
> You can apply the same logic to the LSM token state destructor hook.

Yes, so that's what I went with: combining allocation and access
control. And no, there is no way to get a prog/map/token without
having a respective alloc/control hook.

I also called out the fact that we might be having a memory leak when
using multiple LSMs together and them disagreeing on alloc hook
return. You'll see in the v7 what I mean, I mention that in the commit
messages.

>
> > For my own education, is there some explicit flag or some
> > other sort of mark between LSM hooks for setting up security vs
> > enforcement? Or is it mostly based on convention and implicitly
> > following the split?
>
> Generally convention based around trying to match the LSM state
> lifetime with the lifetime of the associated object; as I mentioned
> earlier, we've had problems in the past when the two differ.  If you
> look at all of the LSM hooks you'll see a number of
> "security_XXXX_alloc()" hooks for things like superblocks, inodes,
> files, task structs, creds, and the like; we're just doing the same
> things here with BPF tokens.  If you're still not convinced, it may be
> worth noting that we currently have security_bpf_map_alloc() and
> security_bpf_prog_alloc() hooks.

It's not like I'm convinced or not, I'm trying to keep things
consistent without breaking anything or causing a mess, but also
hopefully not add too many unnecessary hooks. Let's continue on
respective patches in v7, I'm curious to hear your comments based on
the code I posted.

>
> > > > +     fd =3D get_unused_fd_flags(O_CLOEXEC);
> > > > +     if (fd < 0) {
> > > > +             err =3D fd;
> > > > +             goto out_token;
> > > > +     }
> > > > +
> > > > +     file->private_data =3D token;
> > > > +     fd_install(fd, file);
> > > > +
> > > > +     path_put(&path);
> > > > +     return fd;
> > > > +
> > > > +out_token:
> > > > +     bpf_token_free(token);
> > > > +out_file:
> > > > +     fput(file);
> > > > +out_path:
> > > > +     path_put(&path);
> > > > +     return err;
> > > > +}
> > >
> > > ...
> > >
> > > > +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_c=
md cmd)
> > > > +{
> > > > +     if (!token)
> > > > +             return false;
> > > > +
> > > > +     return token->allowed_cmds & (1ULL << cmd);
> > >
> > > Similar to bpf_token_capable(), I believe we want a LSM hook here to
> > > control who is allowed to use the delegated privilege.
> > >
> > >   bool bpf_token_allow_cmd(...)
> > >   {
> > >     if (token && (token->allowed_cmds & (1ULL << cmd))
> > >       return security_bpf_token_cmd(token, cmd);
> >
> > ok, so I guess I'll have to add all four variants:
> > security_bpf_token_{cmd,map_type,prog_type,attach_type}, right?
>
> Not necessarily.  Currently only SELinux provides a set of LSM BPF
> access controls, and it only concerns itself with BPF maps and
> programs.  From a map perspective it comes down to controlling which
> applications can create a map, or use a map created elsewhere (we
> label BPF map objects just as we would any other kernel object).  From
> a program perspective, it is about loading programs and executing
> them.  While not BPF specific, SELinux also provides controls that
> restrict the ability to exercise capabilities.
>
> Keeping the above access controls in mind, I'm hopeful you can better
> understand the reasoning behind the hooks I'm proposing.  The
> security_bpf_token_cmd() hook is there so that we can control a
> token's ability to authorize BPF_MAP_CREATE and BPF_PROG_LOAD.  The
> security_bpf_token_capable() hook is there so that we can control a
> token's ability to authorize the BPF-related capabilities.  While I
> guess it's possible someone might develop a security model for BPF
> that would require the other LSM hooks you've mentioned above, but I
> see no need for that now, and to be honest I don't see any need on the
> visible horizon either.
>
> Does that make sense?

I'll reply to your second email :)

>
> --
> paul-moore.com

