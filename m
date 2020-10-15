Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E8C28F219
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgJOMcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 08:32:04 -0400
Received: from smtp-8fae.mail.infomaniak.ch ([83.166.143.174]:42087 "EHLO
        smtp-8fae.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgJOMcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:32:04 -0400
X-Greylist: delayed 63590 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 08:32:04 EDT
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CBpZB5fPXzlhTQt;
        Thu, 15 Oct 2020 14:32:02 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CBpZ66ymBzlh8V2;
        Thu, 15 Oct 2020 14:31:58 +0200 (CEST)
Subject: Re: [PATCH v21 12/12] landlock: Add user and kernel documentation
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201008153103.1155388-1-mic@digikod.net>
 <20201008153103.1155388-13-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <fc1c5675-034b-bf5b-ba2b-6be06e03b458@digikod.net>
Date:   Thu, 15 Oct 2020 14:31:58 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20201008153103.1155388-13-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 08/10/2020 17:31, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> This documentation can be built with the Sphinx framework.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
> ---
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
>  Documentation/security/index.rst           |   1 +
>  Documentation/security/landlock/index.rst  |  18 ++
>  Documentation/security/landlock/kernel.rst |  69 ++++++
>  Documentation/security/landlock/user.rst   | 242 +++++++++++++++++++++
>  4 files changed, 330 insertions(+)
>  create mode 100644 Documentation/security/landlock/index.rst
>  create mode 100644 Documentation/security/landlock/kernel.rst
>  create mode 100644 Documentation/security/landlock/user.rst
> 
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index 8129405eb2cc..e3f2bf4fef77 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -16,3 +16,4 @@ Security Documentation
>     siphash
>     tpm/index
>     digsig
> +   landlock/index
> diff --git a/Documentation/security/landlock/index.rst b/Documentation/security/landlock/index.rst
> new file mode 100644
> index 000000000000..2520f8f33f5e
> --- /dev/null
> +++ b/Documentation/security/landlock/index.rst
> @@ -0,0 +1,18 @@
> +=========================================
> +Landlock LSM: unprivileged access control
> +=========================================
> +
> +:Author: Mickaël Salaün
> +
> +The goal of Landlock is to enable to restrict ambient rights (e.g.  global
> +filesystem access) for a set of processes.  Because Landlock is a stackable
> +LSM, it makes possible to create safe security sandboxes as new security layers
> +in addition to the existing system-wide access-controls. This kind of sandbox
> +is expected to help mitigate the security impact of bugs or
> +unexpected/malicious behaviors in user-space applications. Landlock empowers
> +any process, including unprivileged ones, to securely restrict themselves.
> +
> +.. toctree::
> +
> +    user
> +    kernel
> diff --git a/Documentation/security/landlock/kernel.rst b/Documentation/security/landlock/kernel.rst
> new file mode 100644
> index 000000000000..27c0933a0b6e
> --- /dev/null
> +++ b/Documentation/security/landlock/kernel.rst
> @@ -0,0 +1,69 @@
> +==============================
> +Landlock: kernel documentation
> +==============================
Cf. https://landlock.io/linux-doc/landlock-v21/security/landlock/kernel.html

I guess this is the good place for kernel API documentation.

> diff --git a/Documentation/security/landlock/user.rst b/Documentation/security/landlock/user.rst
> new file mode 100644
> index 000000000000..e6fbc75c1af1
> --- /dev/null
> +++ b/Documentation/security/landlock/user.rst
> @@ -0,0 +1,242 @@
> +=================================
> +Landlock: userspace documentation
> +=================================
Cf. https://landlock.io/linux-doc/landlock-v21/security/landlock/user.html

Shouldn't this go in Documentation/userspace-api/ instead?

Documentation/security/lsm-development.rst says that LSM documentation
should go to Documentation/admin-guide/LSM/ but this is not (like
seccomp) an admin documentation.
Should the Documentation/userspace-api/landlock.rst be linked from
Documentation/admin-guide/LSM/index.rst too?
