Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3067F2C1791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 22:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgKWVUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 16:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgKWVUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:20:01 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697EAC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 13:20:01 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id t6so9684465lfl.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D4j9ipcYfkgbYW3IfC3r3VIMquqoN+L6cwpP+cS0BfI=;
        b=fbC4IE3Ma5k4BEntewlv8v44ErN69EIIdl+LZnfvxK31fInFQJfwmWF2sg7nACKjA9
         I6b6ZNKtoWl64a5fVPHAmoBsBsZ6nToMj+Obly0NP8Ez97fTOJgdkj7137/mnilNhpEh
         BqN/AIpYIzPy50MtZSNUjDDXyHutg+qwuyV4uGBbMumFfpKVEfROV/wlL9zO6wHExM4K
         moZZ3tIvtcR81IIWpQIx6JoA2Jqcw0URh9PDkR4MFHcyap+48kzcU5s1UCS3OtJ7ukUf
         tIaKNvwoxdNVe3mpc7VFjd4B+mci1IQXbzUjkulToK+KErFEffmZ/hPOqt64fX6Z14DN
         s4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D4j9ipcYfkgbYW3IfC3r3VIMquqoN+L6cwpP+cS0BfI=;
        b=dRGJAz3Qh6bJYor776jLsnPTSLBC0N7i6HBx5X3a+tsy3ZpP5IBwD66wkC7stuCRs+
         I1w9lieTKdguZPqapy6s9YnCjR1lfpbYDVjLtotj9De/IITPGcxu4u1vsFKTK7jRn4g8
         vCNXb/g75HjlCFMnaRT33Z9KexeZtk+8evDGB3bxC3zvWvqjvP2xdYG5nICyL2up3Wgv
         ZPEeH8hekCNV3k/Brs9xXifvMC9XDCQKKv8+b+ESE5Q808v3+B2WgjTuXD0CxvXhMuu7
         45ytLoY3CzqezyuK2hte9qdaCvUUHqT1IRK8T+32McT0EndnjxmsfeCjutYQirxlL1Hr
         cdkA==
X-Gm-Message-State: AOAM532qnMgRQ9iSrXsOqiple7+d4qtEnnWjikhjxJjNAb1jYrt7bRdv
        HBKY8PmjANAO30ELNBen2SfHc3EMakiq1EabnwHHTQ==
X-Google-Smtp-Source: ABdhPJyZNIPvvHuqqE5lpIUT0dScn3UUr49Bfga2lpEazQCiXcQJAC/sc7oZqgLOpkGR6U56kkuVO/8yEnsIFrrECV4=
X-Received: by 2002:ac2:5a49:: with SMTP id r9mr381970lfn.381.1606166399488;
 Mon, 23 Nov 2020 13:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20201112205141.775752-1-mic@digikod.net> <20201112205141.775752-8-mic@digikod.net>
 <CAG48ez3HA63CX852LLDFCcNyzRGwAr3x_cvA1-t8tgDxfF1dOQ@mail.gmail.com>
 <1d524ea9-85eb-049c-2156-05cad6d6fcfd@digikod.net> <CAG48ez2cmsrZbUEmQmzPQugJikkvfs_MWmMizxmoyspCeXAXRQ@mail.gmail.com>
 <7831e55d-34ef-cf74-3d47-15e2e1edf96c@digikod.net>
In-Reply-To: <7831e55d-34ef-cf74-3d47-15e2e1edf96c@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 23 Nov 2020 22:19:32 +0100
Message-ID: <CAG48ez2V-eSH2+HL9zrYYD4QMpP4a5y8=mTQtk20PB0wUz_4Tw@mail.gmail.com>
Subject: Re: [PATCH v24 07/12] landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
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

On Mon, Nov 23, 2020 at 10:16 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> On 23/11/2020 20:44, Jann Horn wrote:
> > On Sat, Nov 21, 2020 at 11:06 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.=
net> wrote:
> >> On 21/11/2020 08:00, Jann Horn wrote:
> >>> On Thu, Nov 12, 2020 at 9:52 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod=
.net> wrote:
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
> >>>>
> >>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
> >>>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> >>>> Cc: James Morris <jmorris@namei.org>
> >>>> Cc: Jann Horn <jannh@google.com>
> >>>> Cc: Jeff Dike <jdike@addtoit.com>
> >>>> Cc: Kees Cook <keescook@chromium.org>
> >>>> Cc: Richard Weinberger <richard@nod.at>
> >>>> Cc: Serge E. Hallyn <serge@hallyn.com>
> >>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >>>> ---
> >>>>
> >>>> Changes since v23:
> >>>> * Enforce deterministic interleaved path rules.  To have consistent
> >>>>   layered rules, granting access to a path implies that all accesses
> >>>>   tied to inodes, from the requested file to the real root, must be
> >>>>   checked.  Otherwise, stacked rules may result to overzealous
> >>>>   restrictions.  By excluding the ability to add exceptions in the s=
ame
> >>>>   layer (e.g. /a allowed, /a/b denied, and /a/b/c allowed), we get
> >>>>   deterministic interleaved path rules.  This removes an optimizatio=
n
> >>>
> >>> I don't understand the "deterministic interleaved path rules" part.
> >>
> >> I explain bellow.
> >>
> >>>
> >>>
> >>> What if I have a policy like this?
> >>>
> >>> /home/user READ
> >>> /home/user/Downloads READ+WRITE
> >>>
> >>> That's a reasonable policy, right?
> >>
> >> Definitely, I forgot this, thanks for the outside perspective!
> >>
> >>>
> >>> If I then try to open /home/user/Downloads/foo in WRITE mode, the loo=
p
> >>> will first check against the READ+WRITE rule for /home/user, that
> >>> check will pass, and then it will check against the READ rule for /,
> >>> which will deny the access, right? That seems bad.
> >>
> >> Yes that was the intent.
> >>
> >>>
> >>>
> >>> The v22 code ensured that for each layer, the most specific rule (the
> >>> first we encounter on the walk) always wins, right? What's the proble=
m
> >>> with that?
> >>
> >> This can be explained with the interleaved_masked_accesses test:
> >> https://github.com/landlock-lsm/linux/blob/landlock-v24/tools/testing/=
selftests/landlock/fs_test.c#L647
> >>
> >> In this case there is 4 stacked layers:
> >> layer 1: allows s1d1/s1d2/s1d3/file1
> >> layer 2: allows s1d1/s1d2/s1d3
> >>          denies s1d1/s1d2
> >> layer 3: allows s1d1
> >> layer 4: allows s1d1/s1d2
> >>
> >> In the v23, access to file1 would be allowed until layer 3, but layer =
4
> >> would merge a new rule for the s1d2 inode. Because we don't record whe=
re
> >> exactly the access come from, we can't tell that layer 2 allowed acces=
s
> >> thanks to s1d3 and that its s1d2 rule was ignored. I think this behavi=
or
> >> doesn't make sense from the user point of view.
> >
> > Aah, I think I'm starting to understand the issue now. Basically, with
> > the current UAPI, the semantics have to be "an access is permitted if,
> > for each policy layer, at least one rule encountered on the pathwalk
> > permits the access; rules that deny the access are irrelevant". And if
> > it turns out that someone needs to be able to deny access to specific
> > inodes, we'll have to extend struct landlock_path_beneath_attr.
>
> Right, I'll add this to the documentation (aligned with the new
> implementation).
>
> >
> > That reminds me... if we do need to make such a change in the future,
> > it would be easier in terms of UAPI compatibility if
> > landlock_add_rule() used copy_struct_from_user(), which is designed to
> > create backwards and forwards compatibility with other version of UAPI
> > headers. So adding that now might save us some headaches later.
>
> I used copy_struct_from_user() before v21, but Arnd wasn't a fan of
> having type and size arguments, so we simplified the UAPI in the v21 by
> removing the size argument. The type argument is enough to extend the
> structure, but indeed, we lose the forward compatibility. Relying on one
> syscall per rule type seems too much, though.

You have a point there, I guess having a type argument is enough. (And
if userspace tries to load a ruleset with "deny" rules that isn't
supported by the current kernel, userspace will have to deal with that
in some way anyway.)

So thinking about it more, I guess the current version is probably
actually fine, too.
