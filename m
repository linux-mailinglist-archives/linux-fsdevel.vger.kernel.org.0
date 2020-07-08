Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F232182F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgGHI5m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 8 Jul 2020 04:57:42 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgGHI5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:57:41 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N6KQZ-1kyzRR3CWX-016ibf; Wed, 08 Jul 2020 10:57:37 +0200
Received: by mail-qk1-f176.google.com with SMTP id k18so40767942qke.4;
        Wed, 08 Jul 2020 01:57:36 -0700 (PDT)
X-Gm-Message-State: AOAM53027UkKuFSJEpIFe4YoybEMyzeBDYSzluqaxufLj7f7VHndtumo
        dEpKxmKeeMg+nSH+0gP+0UtXZ2nBRD3KMuIJQFw=
X-Google-Smtp-Source: ABdhPJzKe0ldZY51vXLPbQLnhFOs4GKMxEtmMtpTYVrKrkHsesQPcdu9/5x/KOYdqQi57WAW7hH524s3eVnRN1t9las=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr57834681qke.352.1594198654977;
 Wed, 08 Jul 2020 01:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200707180955.53024-1-mic@digikod.net> <20200707180955.53024-9-mic@digikod.net>
In-Reply-To: <20200707180955.53024-9-mic@digikod.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jul 2020 10:57:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0FkoxFtcQJ2jSqyLbDCOp3R8-1JoY8CWAgbSZ9hH9wdQ@mail.gmail.com>
Message-ID: <CAK8P3a0FkoxFtcQJ2jSqyLbDCOp3R8-1JoY8CWAgbSZ9hH9wdQ@mail.gmail.com>
Subject: Re: [PATCH v19 08/12] landlock: Add syscall implementation
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:kjH+6vXiogs9pIKFOaZEjKiWABdGeAyzyAwwASv+wWnZdAkXjMN
 nh0yShY138ygGRasKtApmkYsWUu9PrDTplE+DlmjWqEYG7IteOSFVJXxW90jSwidsPbb5O5
 AU2UmQyU1Atx+vxFthc2TnmlTymNTxH3jq0A9gfOvGZr6nCuXDU0y40L+b1XBUD+vNxulhu
 XF3iuS1nLcWdYUbM3g+NQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zt1Lz36YEuw=:RTq6Uk2vDbuvF4k9ovxlM7
 bujqRutXLNJj1LMWz6YfXKGG5EIf47BV95Eo89Ygf1D1DGZj9dcN/PW4vyQ9j++YCVqcFyhrP
 zdLdRjDQwI7xHBpFf8w08SvKZVrQFrMj/qzcVaal5OIVNSqK0vvOEHdDPA6L6Tdt2kY8WBMFv
 ikwxOkjjgXrJEcMRw6vwblXVNvokeVyLKxJjw1lAAvtm1AyRkIwDCZgP1k8LhMUZyCChTs6oV
 +QEjZ6inMHz/jtalysoaJKsGe8nEA/ME72AfoRQmVP20hBXyY4RHfU4hLT+desu+R3iGgRekq
 rzA2ou/Ai1PwW5zGNqeLwYl/msL9aNI7Wpsxahv1tCHmy1EGCsIXUSq3onwsDKk1vH7WEIa8i
 8j70sFrP4wf5I9j/rZNzNusSs6cxvWO7rjSB/+I3Zk4MAtim9K02Nn2lnsSVyrXugOH54ibdf
 8mLilj+KIUbPwVHdzhvyX/VO8uy5vNSN7ZlOHk2zsRrBE5TdmFaAIcJ61Lmp/Y8Fl2sT91WpI
 JBfZAXaQ35duzeuPXN8bEX5etgYk/W8iOrO57WUGGA1ONwSqv2uvlS8ta+GXl2QsRNSVZguAT
 Ji2kroD/hul7biBktrYKjYvNsj/7TNTKyDtHkrZV9V+g63fLVr6C5VwdNF4cmfky0wJ3mG0pZ
 2a1aKLLoGZkxy+Cm05r8PC3IN81vnEU0EFIyt0weAMl1QRtbHjwTqxKWaM+VUjP1Ps+s60A23
 Ek8BBUkj/2w0Ar42xtQmeHx7696qftmo4KU8Ko6keVS1aL50wGb3n8B0F3aJcKVsLycG6Q0Ah
 ZGuqDZw5VyoBemAyr9QMCN17q7aJhbPNxDP9ftICFw1its5nH9i4FRnWMZ31IncGWiDnFbpgl
 UWZbloDbTRczmyrrMa5H5/8340CtdwC9S9fy7Bq09s+SJhz6iMEMdpj/9t8+9fuBQp05nxCNh
 LHahPBZyjtB0nAdM6kAOqDJHxru2Z3ppd9EUpX5b4EwY1JWrrC7te
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic@digikod.net> wrote:
>
> This system call, inspired from seccomp(2) and bpf(2), is designed to be
> used by unprivileged processes to sandbox themselves.  It has the same
> usage restrictions as seccomp(2): the caller must have the no_new_privs
> attribute set or have CAP_SYS_ADMIN in the current user namespace.
>
> Here are the motivations for this new syscall:
> * A sandboxed process may not have access to file systems, including
>   /dev, /sys or /proc, but it should still be able to add more
>   restrictions to itself.
> * Neither prctl(2) nor seccomp(2) (which was used in a previous version)
>   fit well with the current definition of a Landlock security policy.
> * It is quite easy to whitelist this syscall with seccomp-bpf to enable
>   all processes to use it.  It is also easy to filter specific commands
>   or options to restrict a process to a subset of Landlock features.
>
> There is currently four commands:
> * LANDLOCK_CMD_GET_FEATURES: Gets the supported features (required for
>   backward and forward compatibility, and best-effort security).
> * LANDLOCK_CMD_CREATE_RULESET: Creates a ruleset and returns its file
>   descriptor.
> * LANDLOCK_CMD_ADD_RULE: Adds a rule (e.g. file hierarchy access) to a
>   ruleset, identified by the dedicated file descriptor.
> * LANDLOCK_CMD_ENFORCE_RULESET: Enforces a ruleset on the current thread
>   and its future children (similar to seccomp).

I never paid attention to the patch series so far, so I'm sorry if this
has all been discussed before, but I think the syscall prototype needs
to be different, with *much* less extensibility built in.

> Each command has at least one option, which enables to define the
> attribute types passed to the syscall.  All attribute types (structures)
> are checked at build time to ensure that they don't contain holes and
> that they are aligned the same way for each architecture.  The struct
> landlock_attr_features contains __u32 options_* fields which is enough
> to store 32-bits syscall arguments, and __u16 size_attr_* fields which
> is enough for the maximal struct size (i.e. page size) passed through
> the landlock syscall.  The other fields can have __u64 type for flags
> and bitfields, and __s32 type for file descriptors.
>
> See the user and kernel documentation for more details (provided by a
> following commit): Documentation/security/landlock/

System calls with their own sub-commands have turned out to be a
bad idea many times in the past and cause more problems than they
solve. See sys_ipc, sys_socketcall and sys_futex for common examples.

The first step I would recommend is to split out the individual commands
into separate syscalls. For each one of those, pick a simple prototype
that can do what it needs, with one 'flags' argument for extensibility.

> +/**
> + * DOC: options_intro
> + *
> + * These options may be used as second argument of sys_landlock().  Each
> + * command have a dedicated set of options, represented as bitmasks.  For two
> + * different commands, their options may overlap.  Each command have at least
> + * one option defining the used attribute type.  This also enables to always
> + * have a usable &struct landlock_attr_features (i.e. filled with bits).
> + */
> +
> +/**
> + * DOC: options_get_features
> + *
> + * Options for ``LANDLOCK_CMD_GET_FEATURES``
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + * - %LANDLOCK_OPT_GET_FEATURES: the attr type is `struct
> + *   landlock_attr_features`.
> + */
> +#define LANDLOCK_OPT_GET_FEATURES                      (1 << 0)

For each command, you currently have one attribute that is defined
to have a name directly corresponding to the command, making it
entirely redundant. I'd suggest just check the 'flags' argument for
being zero at syscall entry for future extension if you think there may
be a need to extend it, or completely leave out attributes and flags.

> +static int syscall_create_ruleset(const void __user *const attr_ptr,
> +               const size_t attr_size)
> +{
> +       struct landlock_attr_ruleset attr_ruleset;
> +       struct landlock_ruleset *ruleset;
> +       int err, ruleset_fd;
> +
> +       /* Copies raw user space buffer. */
> +       err = copy_struct_if_any_from_user(&attr_ruleset, sizeof(attr_ruleset),
> +                       offsetofend(typeof(attr_ruleset), handled_access_fs),
> +                       attr_ptr, attr_size);
> +       if (err)
> +               return err;
> +
> +       /* Checks content (and 32-bits cast). */
> +       if ((attr_ruleset.handled_access_fs | _LANDLOCK_ACCESS_FS_MASK) !=
> +                       _LANDLOCK_ACCESS_FS_MASK)
> +               return -EINVAL;
> +
> +       /* Checks arguments and transforms to kernel struct. */
> +       ruleset = landlock_create_ruleset(attr_ruleset.handled_access_fs);
> +       if (IS_ERR(ruleset))
> +               return PTR_ERR(ruleset);
> +
> +       /* Creates anonymous FD referring to the ruleset. */
> +       ruleset_fd = anon_inode_getfd("landlock-ruleset", &ruleset_fops,
> +                       ruleset, O_RDWR | O_CLOEXEC);
> +       if (ruleset_fd < 0)
> +               landlock_put_ruleset(ruleset);
> +       return ruleset_fd;
> +}

It looks like all you need here today is a single argument bit, plus
possibly some room for extensibility. I would suggest removing all
the extra bits and using a syscall like

SYSCALL_DEFINE1(landlock_create_ruleset, u32, flags);

I don't really see how this needs any variable-length arguments,
it really doesn't do much.

To be on the safe side, you might split up the flags into either the
upper/lower 16 bits or two u32 arguments, to allow both compatible
(ignored by older kernels if flag is set) and incompatible (return error
when an unknown flag is set) bits.

> +struct landlock_attr_path_beneath {
> +       /**
> +        * @ruleset_fd: File descriptor tied to the ruleset which should be
> +        * extended with this new access.
> +        */
> +       __s32 ruleset_fd;
> +       /**
> +        * @parent_fd: File descriptor, open with ``O_PATH``, which identify
> +        * the parent directory of a file hierarchy, or just a file.
> +        */
> +       __s32 parent_fd;
> +       /**
> +        * @allowed_access: Bitmask of allowed actions for this file hierarchy
> +        * (cf. `Filesystem flags`_).
> +        */
> +       __u64 allowed_access;
> +};

> +static int syscall_add_rule_path_beneath(const void __user *const attr_ptr,
> +               const size_t attr_size)
> +{
> +       struct landlock_attr_path_beneath attr_path_beneath;
> +       struct path path;
> +       struct landlock_ruleset *ruleset;
> +       int err;

Similarly, it looks like this wants to be

SYSCALL_DEFINE3(landlock_add_rule_path_beneath, int, ruleset, int,
path, __u32, flags)

I don't see any need to extend this in a way that wouldn't already
be served better by adding another system call. You might argue
that 'flags' and 'allowed_access' could be separate, with the latter
being an indirect in/out argument here, like

SYSCALL_DEFINE4(landlock_add_rule_path_beneath, int, ruleset, int, path,
                           __u64 *, allowed_acces, __u32, flags)

> +static int syscall_enforce_ruleset(const void __user *const attr_ptr,
> +               const size_t attr_size)

Here it seems like you just need to pass the file descriptor, or maybe

SYSCALL_DEFINE2(landlock_enforce, int, ruleset, __u32 flags);

if you need flags for extensibility.

      Arnd
