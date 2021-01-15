Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270432F8480
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 19:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733221AbhAOScv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 13:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733246AbhAOScv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:32:51 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75128C061796
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 10:31:30 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id n11so11463536lji.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=doIF7YGiAhKmeiwZI9aWnSI+iqxNbrVvLkiRLdsWXwo=;
        b=WPdEeI0zC9+D3jlTAjWy+d5mggbWi3OY2VUQ/43nSuiyfjKqFEx6T22EPtvWJwurbw
         fS9acjTUgC7Dq6WJkCW/k/wgwuphYGYLEyF3BfOJNEltwyCo294v+jPalogZjNvZM/Rt
         fuasjPtoEWd7gP8cPZRsuacpG2Inn3Lahs0xthzwPh1lzIa+k70BK3/A9+tANStEamhN
         DIQaqnF0NmlcoHX7guomoXZunjHQf6PQqIgKsUwREKXv11OzrhVaS0LjpabOTp10tJDz
         U1YoJdqBnuI8yxikWBi6UrYvxbN7MGFNj8XLbF/o7DGkOk6M3wBWF3De3DfCNlI1N97B
         MTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=doIF7YGiAhKmeiwZI9aWnSI+iqxNbrVvLkiRLdsWXwo=;
        b=Wm4/iU53/XNwxvAFHLdtMMBgyiXzTkLYAgBxJTW8rcWqu+uTXBVe4Lf8bTICCkGM9o
         O0QjSGUHsFVSRM8is8QVReidaPEeGT7YFiTINC5Dq9zS4D1kyon0vo6PT2nlBScZQBLg
         WTFKqqXx7i0Wko3fAIoTza7zxzCdQp17PVr0x83+KovonZNxyckWqWYodAyI1/h8IgzT
         ww/VIPykgoZrnBY5Y5NxcVAdp/yNMQP27gh8MvIJdGPBVinp2LMoWlSXSq3hMnPehVM/
         61DtDZynrFuNxmP02LLviV1aPR9+O/CTs5BZohWa7LNcmzs/8zu3Rl/3Qj3QkIECMIuX
         xLYA==
X-Gm-Message-State: AOAM533NP4sn5jDU6PU6UjTHAt/ZZiApLXjXgIUsMbsImDdEI38heMqZ
        M3OGIFdoLbQxOvDnB6RBRaJPfpp7z/epSJ3OBjZxEQ==
X-Google-Smtp-Source: ABdhPJwgqnHrWWmTgRSWdjUFVb+FJ/p8ce+SLZoErtKGscrYZjJMLxMRJWkdYszsALachIQuW5LMv7rhF3d0xR729W8=
X-Received: by 2002:a2e:9d87:: with SMTP id c7mr5757298ljj.43.1610735487873;
 Fri, 15 Jan 2021 10:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20201209192839.1396820-1-mic@digikod.net> <20201209192839.1396820-8-mic@digikod.net>
 <CAG48ez1wbAQwU-eoC9DngHyUM_5F01MJQpRnLaJFvfRUrnXBdA@mail.gmail.com>
 <aeb3e152-8108-89d2-0577-4b130368f14f@digikod.net> <CAG48ez2HJCFvmFALDYDYnufE755Dqh3JquAMf-1mnzmRrdKaoQ@mail.gmail.com>
 <9be6481f-9c03-dd32-378f-20bc7c52315c@digikod.net>
In-Reply-To: <9be6481f-9c03-dd32-378f-20bc7c52315c@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 15 Jan 2021 19:31:01 +0100
Message-ID: <CAG48ez1O0VTwEiRd3KqexoF78WR+cmP5bGk5Kh5Cs7aPepiDVg@mail.gmail.com>
Subject: Re: [PATCH v26 07/12] landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:10 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> On 14/01/2021 23:43, Jann Horn wrote:
> > On Thu, Jan 14, 2021 at 7:54 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >> On 14/01/2021 04:22, Jann Horn wrote:
> >>> On Wed, Dec 9, 2020 at 8:28 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.=
net> wrote:
> >>>> Thanks to the Landlock objects and ruleset, it is possible to identi=
fy
> >>>> inodes according to a process's domain.  To enable an unprivileged
> >>>> process to express a file hierarchy, it first needs to open a direct=
ory
> >>>> (or a file) and pass this file descriptor to the kernel through
> >>>> landlock_add_rule(2).  When checking if a file access request is
> >>>> allowed, we walk from the requested dentry to the real root, followi=
ng
> >>>> the different mount layers.  The access to each "tagged" inodes are
> >>>> collected according to their rule layer level, and ANDed to create
> >>>> access to the requested file hierarchy.  This makes possible to iden=
tify
> >>>> a lot of files without tagging every inodes nor modifying the
> >>>> filesystem, while still following the view and understanding the use=
r
> >>>> has from the filesystem.
> >>>>
> >>>> Add a new ARCH_EPHEMERAL_INODES for UML because it currently does no=
t
> >>>> keep the same struct inodes for the same inodes whereas these inodes=
 are
> >>>> in use.
> >>>>
> >>>> This commit adds a minimal set of supported filesystem access-contro=
l
> >>>> which doesn't enable to restrict all file-related actions.  This is =
the
> >>>> result of multiple discussions to minimize the code of Landlock to e=
ase
> >>>> review.  Thanks to the Landlock design, extending this access-contro=
l
> >>>> without breaking user space will not be a problem.  Moreover, seccom=
p
> >>>> filters can be used to restrict the use of syscall families which ma=
y
> >>>> not be currently handled by Landlock.
> >>> [...]
> >>>> +static bool check_access_path_continue(
> >>>> +               const struct landlock_ruleset *const domain,
> >>>> +               const struct path *const path, const u32 access_requ=
est,
> >>>> +               u64 *const layer_mask)
> >>>> +{
> >>> [...]
> >>>> +       /*
> >>>> +        * An access is granted if, for each policy layer, at least =
one rule
> >>>> +        * encountered on the pathwalk grants the access, regardless=
 of their
> >>>> +        * position in the layer stack.  We must then check not-yet-=
seen layers
> >>>> +        * for each inode, from the last one added to the first one.
> >>>> +        */
> >>>> +       for (i =3D 0; i < rule->num_layers; i++) {
> >>>> +               const struct landlock_layer *const layer =3D &rule->=
layers[i];
> >>>> +               const u64 layer_level =3D BIT_ULL(layer->level - 1);
> >>>> +
> >>>> +               if (!(layer_level & *layer_mask))
> >>>> +                       continue;
> >>>> +               if ((layer->access & access_request) !=3D access_req=
uest)
> >>>> +                       return false;
> >>>> +               *layer_mask &=3D ~layer_level;
> >>>
> >>> Hmm... shouldn't the last 5 lines be replaced by the following?
> >>>
> >>> if ((layer->access & access_request) =3D=3D access_request)
> >>>     *layer_mask &=3D ~layer_level;
> >>>
> >>> And then, since this function would always return true, you could
> >>> change its return type to "void".
> >>>
> >>>
> >>> As far as I can tell, the current version will still, if a ruleset
> >>> looks like this:
> >>>
> >>> /usr read+write
> >>> /usr/lib/ read
> >>>
> >>> reject write access to /usr/lib, right?
> >>
> >> If these two rules are from different layers, then yes it would work a=
s
> >> intended. However, if these rules are from the same layer the path wal=
k
> >> will not stop at /usr/lib but go down to /usr, which grants write
> >> access.
> >
> > I don't see why the code would do what you're saying it does. And an
> > experiment seems to confirm what I said; I checked out landlock-v26,
> > and the behavior I get is:
>
> There is a misunderstanding, I was responding to your proposition to
> modify check_access_path_continue(), not about the behavior of landlock-v=
26.
>
> >
> > user@vm:~/landlock$ dd if=3D/dev/null of=3D/tmp/aaa
> > 0+0 records in
> > 0+0 records out
> > 0 bytes copied, 0.00106365 s, 0.0 kB/s
> > user@vm:~/landlock$ LL_FS_RO=3D'/lib' LL_FS_RW=3D'/' ./sandboxer dd
> > if=3D/dev/null of=3D/tmp/aaa
> > 0+0 records in
> > 0+0 records out
> > 0 bytes copied, 0.000491814 s, 0.0 kB/s
> > user@vm:~/landlock$ LL_FS_RO=3D'/tmp' LL_FS_RW=3D'/' ./sandboxer dd
> > if=3D/dev/null of=3D/tmp/aaa
> > dd: failed to open '/tmp/aaa': Permission denied
> > user@vm:~/landlock$
> >
> > Granting read access to /tmp prevents writing to it, even though write
> > access was granted to /.
> >
>
> It indeed works like this with landlock-v26. However, with your above
> proposition, it would work like this:
>
> $ LL_FS_RO=3D'/tmp' LL_FS_RW=3D'/' ./sandboxer dd if=3D/dev/null of=3D/tm=
p/aaa
> 0+0 records in
> 0+0 records out
> 0 bytes copied, 0.000187265 s, 0.0 kB/s
>
> =E2=80=A6which is not what users would expect I guess. :)

Ah, so we are disagreeing about what the right semantics are. ^^ To
me, that is exactly the behavior I would expect.

Imagine that someone wants to write a program that needs to be able to
load libraries from /usr/lib (including subdirectories) and needs to
be able to write output to some user-specified output directory. So
they use something like this to sandbox their program (plus error
handling):

static void add_fs_rule(int ruleset_fd, char *path, u64 allowed_access) {
  int fd =3D open(path, O_PATH);
  struct landlock_path_beneath_attr path_beneath =3D {
    .parent_fd =3D fd,
    .allowed_access =3D allowed_access
  };
  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
          &path_beneath, 0);
  close(fd);
}
int main(int argc, char **argv) {
  char *output_dir =3D argv[1];
  int ruleset_fd =3D landlock_create_ruleset(&ruleset_attr,
sizeof(ruleset_attr, 0);
  add_fs_rule(ruleset_fd, "/usr/lib", ACCESS_FS_ROUGHLY_READ);
  add_fs_rule(ruleset_fd, output_dir,
LANDLOCK_ACCESS_FS_WRITE_FILE|LANDLOCK_ACCESS_FS_MAKE_REG|LANDLOCK_ACCESS_F=
S_REMOVE_FILE);
  prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
  landlock_enforce_ruleset_current(ruleset_fd, 0);
}

This will *almost* always work; but if the output directory is
/usr/lib/x86_64-linux-gnu/ , loading libraries from that directory
won't work anymore, right? So if userspace wanted this to *always*
works correctly, it would have to somehow figure out whether there is
a path upwards from the output directory (under any mount) that will
encounter /usr/lib, and set different permissions if that is the case.
That seems unnecessarily messy to me; and I think that this will make
it harder for generic commandline tools and such to adopt landlock.


If you do want to have the ability to deny access to subtrees of trees
to which access is permitted, I think that that should be made
explicit in the UAPI - e.g. you could (at a later point, after this
series has landed) introduce a new EXCLUDE flag for
landlock_add_rule() that means "I want to deny the access specified by
this rule", or something like that. (And you'd have to very carefully
document under which circumstances such rules are actually effective -
e.g. if someone grants full access to $HOME, but excludes $HOME/.ssh,
an attacker would still be able to rename $HOME/.ssh to $HOME/old_ssh,
and then if the program is later restarted and creates the ruleset
from scratch again, the old SSH folder will be accessible.)
