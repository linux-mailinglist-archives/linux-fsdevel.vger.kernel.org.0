Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C392FFE46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 09:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbhAVIfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 03:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbhAVIez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:34:55 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AAEC06174A;
        Fri, 22 Jan 2021 00:33:34 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id v1so4356883ott.10;
        Fri, 22 Jan 2021 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=J8rC8rrBASJfDx11gXKwp/a0LouMg3IPHJEbz9tEkDg=;
        b=KLJ0XR+fFhk8hJ7mZT1Jgw8tZUoIetRAPxe3SLiPml8C+5kM+qGBZI+WeG+pU5wO9Q
         TN1lsN6rTu0BOwD+5EDXKimfBRRZboipUwN1k5eA5aie5dfLEw4AzJ8g3lMLiYtch4nE
         SJG+spCI/H68I6YOs0kIwBtxfRzff1KWnsVYdnZpCBucKZxsrvtIcagihjF0RvWymyGm
         h2zBHJlXdaAVEkUUgkukzGdg4SXVRxPoZ7f/Gi/lqqYKmgT1UJH+koXgMNLHGp3FP9AT
         vv2Q2oCpIdRyTWtxe+d0HjXoiFk758xxtFcyOi5jovggr3g8QeSekPI9/usxZaj6hfIU
         zaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=J8rC8rrBASJfDx11gXKwp/a0LouMg3IPHJEbz9tEkDg=;
        b=nebX+2Xx/O0JhTOgiWTrggd3dcNpi5d0ZDV3Psk4jNUfgTl/K4dmH3NkLbQU7QZVUJ
         fCWqX9hRelDuWrZmIWwNNCg8snNZauz+WUzPld0uqp1+O6pTTX+8cEsfXXj5WTO+K8KM
         Hx2uSkdlhAvboXA0PN24423Id/G1N9BfKC/tGx4PFVfuFxmfPAAVUYMftoonBRoaR0CA
         8LafarCrnpa2wstjtKmj0IMFTHr0+dzkSiUMQiG3ZvZGsuGjbmxmfUetv0B0m9F+JnKB
         HRgaKZQwlKNDurYvQt4ie4bVnIqRp4H2Voc8VeIVKbQce6jczJitvOzOPLfgK1fxJtgK
         w9yA==
X-Gm-Message-State: AOAM533HW5iRYFJqLwzSMZkKxBiFVw4weaJ6KL+CtpOXkt+mtjAYhQRF
        eRLErc/ZaQLZ3YYugJLG5fFVFH69tDCDd9qg9c+H0tiF
X-Google-Smtp-Source: ABdhPJyo6zzzq4+6i2QZN7yh8hsoJkWBV+iCJqDB5Eq8sMkopPWiJxZ+W8WepCldvJQ4z42SiCafJ3Gu9EJ+r+gL+to=
X-Received: by 2002:a9d:5e0f:: with SMTP id d15mr2524566oti.308.1611304412399;
 Fri, 22 Jan 2021 00:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20210121205119.793296-1-mic@digikod.net> <20210121205119.793296-13-mic@digikod.net>
In-Reply-To: <20210121205119.793296-13-mic@digikod.net>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 22 Jan 2021 09:33:21 +0100
Message-ID: <CAKgNAkhe=fx9J7+=qTfkB=8vMDYWba38ongKmRz=JcXmjGF2Mw@mail.gmail.com>
Subject: Re: [PATCH v27 12/12] landlock: Add user and kernel documentation
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel-hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Micka=C3=ABl,

It would be great to have some manual pages for these system calls
before release... Can you prepare something?

Thanks,

Michael

On Thu, 21 Jan 2021 at 21:51, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wr=
ote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> This documentation can be built with the Sphinx framework.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
> ---
>
> Changes since v25:
> * Explain the behavior of layered access rights.
> * Explain how bind mounts and overayfs mounts are handled by Landlock:
>   merged overlayfs mount points have their own inodes, which makes these
>   hierarchies independent from its upper and lower layers, unlike bind
>   mounts which share the same inodes between the source hierarchy and
>   the mount point hierarchy.
>   New overlayfs mount and bind mount tests check these behaviors.
> * Synchronize with the new syscalls.c file and update syscall names.
> * Fix spelling.
> * Remove Reviewed-by Jann Horn because of the above changes.
>
> Changes since v24:
> * Add Reviewed-by Jann Horn.
> * Add a paragraph to explain how the ruleset layers work.
> * Bump date.
>
> Changes since v23:
> * Explain limitations for the maximum number of stacked ruleset, and the
>   memory usage restrictions.
>
> Changes since v22:
> * Fix spelling and remove obsolete sentence (spotted by Jann Horn).
> * Bump date.
>
> Changes since v21:
> * Move the user space documentation to userspace-api/landlock.rst and
>   the kernel documentation to security/landlock.rst .
> * Add license headers.
> * Add last update dates.
> * Update MAINTAINERS file.
> * Add (back) links to git.kernel.org .
> * Fix spelling.
>
> Changes since v20:
> * Update examples and documentation with the new syscalls.
>
> Changes since v19:
> * Update examples and documentation with the new syscalls.
>
> Changes since v15:
> * Add current limitations.
>
> Changes since v14:
> * Fix spelling (contributed by Randy Dunlap).
> * Extend documentation about inheritance and explain layer levels.
> * Remove the use of now-removed access rights.
> * Use GitHub links.
> * Improve kernel documentation.
> * Add section for tests.
> * Update example.
>
> Changes since v13:
> * Rewrote the documentation according to the major revamp.
>
> Previous changes:
> https://lore.kernel.org/lkml/20191104172146.30797-8-mic@digikod.net/
> ---
>  Documentation/security/index.rst         |   1 +
>  Documentation/security/landlock.rst      |  79 ++++++
>  Documentation/userspace-api/index.rst    |   1 +
>  Documentation/userspace-api/landlock.rst | 306 +++++++++++++++++++++++
>  MAINTAINERS                              |   2 +
>  5 files changed, 389 insertions(+)
>  create mode 100644 Documentation/security/landlock.rst
>  create mode 100644 Documentation/userspace-api/landlock.rst
>
> diff --git a/Documentation/security/index.rst b/Documentation/security/in=
dex.rst
> index 8129405eb2cc..16335de04e8c 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -16,3 +16,4 @@ Security Documentation
>     siphash
>     tpm/index
>     digsig
> +   landlock
> diff --git a/Documentation/security/landlock.rst b/Documentation/security=
/landlock.rst
> new file mode 100644
> index 000000000000..244e616d3d7a
> --- /dev/null
> +++ b/Documentation/security/landlock.rst
> @@ -0,0 +1,79 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright =C2=A9 2017-2020 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> +.. Copyright =C2=A9 2019-2020 ANSSI
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Landlock LSM: kernel documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Micka=C3=ABl Sala=C3=BCn
> +:Date: January 2021
> +
> +Landlock's goal is to create scoped access-control (i.e. sandboxing).  T=
o
> +harden a whole system, this feature should be available to any process,
> +including unprivileged ones.  Because such process may be compromised or
> +backdoored (i.e. untrusted), Landlock's features must be safe to use fro=
m the
> +kernel and other processes point of view.  Landlock's interface must the=
refore
> +expose a minimal attack surface.
> +
> +Landlock is designed to be usable by unprivileged processes while follow=
ing the
> +system security policy enforced by other access control mechanisms (e.g.=
 DAC,
> +LSM).  Indeed, a Landlock rule shall not interfere with other access-con=
trols
> +enforced on the system, only add more restrictions.
> +
> +Any user can enforce Landlock rulesets on their processes.  They are mer=
ged and
> +evaluated according to the inherited ones in a way that ensures that onl=
y more
> +constraints can be added.
> +
> +User space documentation can be found here: :doc:`/userspace-api/landloc=
k`.
> +
> +Guiding principles for safe access controls
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* A Landlock rule shall be focused on access control on kernel objects i=
nstead
> +  of syscall filtering (i.e. syscall arguments), which is the purpose of
> +  seccomp-bpf.
> +* To avoid multiple kinds of side-channel attacks (e.g. leak of security
> +  policies, CPU-based attacks), Landlock rules shall not be able to
> +  programmatically communicate with user space.
> +* Kernel access check shall not slow down access request from unsandboxe=
d
> +  processes.
> +* Computation related to Landlock operations (e.g. enforcing a ruleset) =
shall
> +  only impact the processes requesting them.
> +
> +Tests
> +=3D=3D=3D=3D=3D
> +
> +Userspace tests for backward compatibility, ptrace restrictions and file=
system
> +support can be found here: `tools/testing/selftests/landlock/`_.
> +
> +Kernel structures
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Object
> +------
> +
> +.. kernel-doc:: security/landlock/object.h
> +    :identifiers:
> +
> +Ruleset and domain
> +------------------
> +
> +A domain is a read-only ruleset tied to a set of subjects (i.e. tasks'
> +credentials).  Each time a ruleset is enforced on a task, the current do=
main is
> +duplicated and the ruleset is imported as a new layer of rules in the ne=
w
> +domain.  Indeed, once in a domain, each rule is tied to a layer level.  =
To
> +grant access to an object, at least one rule of each layer must allow th=
e
> +requested action on the object.  A task can then only transit to a new d=
omain
> +that is the intersection of the constraints from the current domain and =
those
> +of a ruleset provided by the task.
> +
> +The definition of a subject is implicit for a task sandboxing itself, wh=
ich
> +makes the reasoning much easier and helps avoid pitfalls.
> +
> +.. kernel-doc:: security/landlock/ruleset.h
> +    :identifiers:
> +
> +.. Links
> +.. _tools/testing/selftests/landlock/:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree=
/tools/testing/selftests/landlock/
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/usersp=
ace-api/index.rst
> index acd2cc2a538d..01f1748ab569 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -18,6 +18,7 @@ place where this information is gathered.
>
>     no_new_privs
>     seccomp_filter
> +   landlock
>     unshare
>     spec_ctrl
>     accelerators/ocxl
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/use=
rspace-api/landlock.rst
> new file mode 100644
> index 000000000000..06c16f2b038b
> --- /dev/null
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -0,0 +1,306 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright =C2=A9 2017-2020 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> +.. Copyright =C2=A9 2019-2020 ANSSI
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Landlock: unprivileged access control
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Micka=C3=ABl Sala=C3=BCn
> +:Date: January 2021
> +
> +The goal of Landlock is to enable to restrict ambient rights (e.g. globa=
l
> +filesystem access) for a set of processes.  Because Landlock is a stacka=
ble
> +LSM, it makes possible to create safe security sandboxes as new security=
 layers
> +in addition to the existing system-wide access-controls. This kind of sa=
ndbox
> +is expected to help mitigate the security impact of bugs or
> +unexpected/malicious behaviors in user space applications.  Landlock emp=
owers
> +any process, including unprivileged ones, to securely restrict themselve=
s.
> +
> +Landlock rules
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A Landlock rule describes an action on an object.  An object is currentl=
y a
> +file hierarchy, and the related filesystem actions are defined in `Acces=
s
> +rights`_.  A set of rules is aggregated in a ruleset, which can then res=
trict
> +the thread enforcing it, and its future children.
> +
> +Defining and enforcing a security policy
> +----------------------------------------
> +
> +We first need to create the ruleset that will contain our rules.  For th=
is
> +example, the ruleset will contain rules that only allow read actions, bu=
t write
> +actions will be denied.  The ruleset then needs to handle both of these =
kind of
> +actions.
> +
> +.. code-block:: c
> +
> +    int ruleset_fd;
> +    struct landlock_ruleset_attr ruleset_attr =3D {
> +        .handled_access_fs =3D
> +            LANDLOCK_ACCESS_FS_EXECUTE |
> +            LANDLOCK_ACCESS_FS_WRITE_FILE |
> +            LANDLOCK_ACCESS_FS_READ_FILE |
> +            LANDLOCK_ACCESS_FS_READ_DIR |
> +            LANDLOCK_ACCESS_FS_REMOVE_DIR |
> +            LANDLOCK_ACCESS_FS_REMOVE_FILE |
> +            LANDLOCK_ACCESS_FS_MAKE_CHAR |
> +            LANDLOCK_ACCESS_FS_MAKE_DIR |
> +            LANDLOCK_ACCESS_FS_MAKE_REG |
> +            LANDLOCK_ACCESS_FS_MAKE_SOCK |
> +            LANDLOCK_ACCESS_FS_MAKE_FIFO |
> +            LANDLOCK_ACCESS_FS_MAKE_BLOCK |
> +            LANDLOCK_ACCESS_FS_MAKE_SYM,
> +    };
> +
> +    ruleset_fd =3D landlock_create_ruleset(&ruleset_attr, sizeof(ruleset=
_attr), 0);
> +    if (ruleset_fd < 0) {
> +        perror("Failed to create a ruleset");
> +        return 1;
> +    }
> +
> +We can now add a new rule to this ruleset thanks to the returned file
> +descriptor referring to this ruleset.  The rule will only allow reading =
the
> +file hierarchy ``/usr``.  Without another rule, write actions would then=
 be
> +denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with =
the
> +``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with thi=
s file
> +descriptor.
> +
> +.. code-block:: c
> +
> +    int err;
> +    struct landlock_path_beneath_attr path_beneath =3D {
> +        .allowed_access =3D
> +            LANDLOCK_ACCESS_FS_EXECUTE |
> +            LANDLOCK_ACCESS_FS_READ_FILE |
> +            LANDLOCK_ACCESS_FS_READ_DIR,
> +    };
> +
> +    path_beneath.parent_fd =3D open("/usr", O_PATH | O_CLOEXEC);
> +    if (path_beneath.parent_fd < 0) {
> +        perror("Failed to open file");
> +        close(ruleset_fd);
> +        return 1;
> +    }
> +    err =3D landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +                            &path_beneath, 0);
> +    close(path_beneath.parent_fd);
> +    if (err) {
> +        perror("Failed to update ruleset");
> +        close(ruleset_fd);
> +        return 1;
> +    }
> +
> +We now have a ruleset with one rule allowing read access to ``/usr`` whi=
le
> +denying all other handled accesses for the filesystem.  The next step is=
 to
> +restrict the current thread from gaining more privileges (e.g. thanks to=
 a SUID
> +binary).
> +
> +.. code-block:: c
> +
> +    if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
> +        perror("Failed to restrict privileges");
> +        close(ruleset_fd);
> +        return 1;
> +    }
> +
> +The current thread is now ready to sandbox itself with the ruleset.
> +
> +.. code-block:: c
> +
> +    if (landlock_enforce_ruleset_self(ruleset_fd, 0)) {
> +        perror("Failed to enforce ruleset");
> +        close(ruleset_fd);
> +        return 1;
> +    }
> +    close(ruleset_fd);
> +
> +If the `landlock_enforce_ruleset_self` system call succeeds, the current=
 thread
> +is now restricted and this policy will be enforced on all its subsequent=
ly
> +created children as well.  Once a thread is landlocked, there is no way =
to
> +remove its security policy; only adding more restrictions is allowed.  T=
hese
> +threads are now in a new Landlock domain, merge of their parent one (if =
any)
> +with the new ruleset.
> +
> +Full working code can be found in `samples/landlock/sandboxer.c`_.
> +
> +Layers of file path access rights
> +---------------------------------
> +
> +Each time a thread enforces a ruleset on itself, it updates its Landlock=
 domain
> +with a new layer of policy.  Indeed, this complementary policy is stacke=
d with
> +the potentially other rulesets already restricting this thread.  A sandb=
oxed
> +thread can then safely add more constraints to itself with a new enforce=
d
> +ruleset.
> +
> +One policy layer grants access to a file path if at least one of its rul=
es
> +encountered on the path grants the access.  A sandboxed thread can only =
access
> +a file path if all its enforced policy layers grant the access as well a=
s all
> +the other system access controls (e.g. filesystem DAC, other LSM policie=
s,
> +etc.).
> +
> +Bind mounts and OverlayFS
> +-------------------------
> +
> +Landlock enables to restrict access to file hierarchies, which means tha=
t these
> +access rights can be propagated with bind mounts (cf.
> +:doc:`/filesystems/sharedsubtree`) but not with :doc:`/filesystems/overl=
ayfs`.
> +
> +A bind mount mirrors a source file hierarchy to a destination.  The dest=
ination
> +hierarchy is then composed of the exact same files, on which Landlock ru=
les can
> +be tied, either via the source or the destination path.  These rules res=
trict
> +access when they are encountered on a path, which means that they can re=
strict
> +access to multiple file hierarchies at the same time, whether these hier=
archies
> +are the result of bind mounts or not.
> +
> +An OverlayFS mount point consists of upper and lower layers.  These laye=
rs are
> +combined in a merge directory, result of the mount point.  This merge hi=
erarchy
> +may include files from the upper and lower layers, but modifications per=
formed
> +on the merge hierarchy only reflects on the upper layer.  From a Landloc=
k
> +policy point of view, each OverlayFS layers and merge hierarchies are
> +standalone and contains their own set of files and directories, which is
> +different from bind mounts.  A policy restricting an OverlayFS layer wil=
l not
> +restrict the resulted merged hierarchy, and vice versa.
> +
> +Inheritance
> +-----------
> +
> +Every new thread resulting from a :manpage:`clone(2)` inherits Landlock =
domain
> +restrictions from its parent.  This is similar to the seccomp inheritanc=
e (cf.
> +:doc:`/userspace-api/seccomp_filter`) or any other LSM dealing with task=
's
> +:manpage:`credentials(7)`.  For instance, one process's thread may apply
> +Landlock rules to itself, but they will not be automatically applied to =
other
> +sibling threads (unlike POSIX thread credential changes, cf.
> +:manpage:`nptl(7)`).
> +
> +When a thread sandboxes itself, we have the guarantee that the related s=
ecurity
> +policy will stay enforced on all this thread's descendants.  This allows
> +creating standalone and modular security policies per application, which=
 will
> +automatically be composed between themselves according to their runtime =
parent
> +policies.
> +
> +Ptrace restrictions
> +-------------------
> +
> +A sandboxed process has less privileges than a non-sandboxed process and=
 must
> +then be subject to additional restrictions when manipulating another pro=
cess.
> +To be allowed to use :manpage:`ptrace(2)` and related syscalls on a targ=
et
> +process, a sandboxed process should have a subset of the target process =
rules,
> +which means the tracee must be in a sub-domain of the tracer.
> +
> +Kernel interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Access rights
> +-------------
> +
> +.. kernel-doc:: include/uapi/linux/landlock.h
> +    :identifiers: fs_access
> +
> +Creating a new ruleset
> +----------------------
> +
> +.. kernel-doc:: security/landlock/syscalls.c
> +    :identifiers: sys_landlock_create_ruleset
> +
> +.. kernel-doc:: include/uapi/linux/landlock.h
> +    :identifiers: landlock_ruleset_attr
> +
> +Extending a ruleset
> +-------------------
> +
> +.. kernel-doc:: security/landlock/syscalls.c
> +    :identifiers: sys_landlock_add_rule
> +
> +.. kernel-doc:: include/uapi/linux/landlock.h
> +    :identifiers: landlock_rule_type landlock_path_beneath_attr
> +
> +Enforcing a ruleset
> +-------------------
> +
> +.. kernel-doc:: security/landlock/syscalls.c
> +    :identifiers: sys_landlock_enforce_ruleset_self
> +
> +Current limitations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Ruleset layers
> +--------------
> +
> +There is a limit of 64 layers of stacked rulesets.  This can be an issue=
 for a
> +task willing to enforce a new ruleset in complement to its 64 inherited
> +rulesets.  Once this limit is reached, sys_landlock_enforce_ruleset_self=
()
> +returns E2BIG.  It is then strongly suggested to carefully build ruleset=
s once
> +in the life of a thread, especially for applications able to launch othe=
r
> +applications that may also want to sandbox themselves (e.g. shells, cont=
ainer
> +managers, etc.).
> +
> +Memory usage
> +------------
> +
> +Kernel memory allocated to create rulesets is accounted and can be restr=
icted
> +by the :doc:`/admin-guide/cgroup-v1/memory`.
> +
> +File renaming and linking
> +-------------------------
> +
> +Because Landlock targets unprivileged access controls, it is needed to p=
roperly
> +handle composition of rules.  Such property also implies rules nesting.
> +Properly handling multiple layers of ruleset, each one of them able to r=
estrict
> +access to files, also implies to inherit the ruleset restrictions from a=
 parent
> +to its hierarchy.  Because files are identified and restricted by their
> +hierarchy, moving or linking a file from one directory to another implie=
s to
> +propagate the hierarchy constraints.  To protect against privilege escal=
ations
> +through renaming or linking, and for the sack of simplicity, Landlock cu=
rrently
> +limits linking and renaming to the same directory.  Future Landlock evol=
utions
> +will enable more flexibility for renaming and linking, with dedicated ru=
leset
> +flags.
> +
> +Filesystem layout modification
> +------------------------------
> +
> +As for file renaming and linking, a sandboxed thread cannot modify its
> +filesystem layout, whether via :manpage:`mount(2)` or :manpage:`pivot_ro=
ot(2)`.
> +However, :manpage:`chroot(2)` calls are not denied.
> +
> +Special filesystems
> +-------------------
> +
> +Access to regular files and directories can be restricted by Landlock,
> +according to the handled accesses of a ruleset.  However, files that do =
not
> +come from a user-visible filesystem (e.g. pipe, socket), but can still b=
e
> +accessed through /proc/self/fd/, cannot currently be restricted.  Likewi=
se,
> +some special kernel filesystems such as nsfs, which can be accessed thro=
ugh
> +/proc/self/ns/, cannot currently be restricted.  For now, these kind of =
special
> +paths are then always allowed.  Future Landlock evolutions will enable t=
o
> +restrict such paths with dedicated ruleset flags.
> +
> +Questions and answers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +What about user space sandbox managers?
> +---------------------------------------
> +
> +Using user space process to enforce restrictions on kernel resources can=
 lead
> +to race conditions or inconsistent evaluations (i.e. `Incorrect mirrorin=
g of
> +the OS code and state
> +<https://www.ndss-symposium.org/ndss2003/traps-and-pitfalls-practical-pr=
oblems-system-call-interposition-based-security-tools/>`_).
> +
> +What about namespaces and containers?
> +-------------------------------------
> +
> +Namespaces can help create sandboxes but they are not designed for
> +access-control and then miss useful features for such use case (e.g. no
> +fine-grained restrictions).  Moreover, their complexity can lead to secu=
rity
> +issues, especially when untrusted processes can manipulate them (cf.
> +`Controlling access to user namespaces <https://lwn.net/Articles/673597/=
>`_).
> +
> +Additional documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* :doc:`/security/landlock`
> +* https://landlock.io
> +
> +.. Links
> +.. _samples/landlock/sandboxer.c:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree=
/samples/landlock/sandboxer.c
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 572e4288c60f..68276c73c33e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9942,6 +9942,8 @@ L:        linux-security-module@vger.kernel.org
>  S:     Supported
>  W:     https://landlock.io
>  T:     git https://github.com/landlock-lsm/linux.git
> +F:     Documentation/security/landlock.rst
> +F:     Documentation/userspace-api/landlock.rst
>  F:     include/uapi/linux/landlock.h
>  F:     security/landlock/
>  K:     landlock
> --
> 2.30.0
>


--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
