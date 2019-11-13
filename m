Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1162AFA66C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 03:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfKMC3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 21:29:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39700 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfKMC3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:29:43 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUiP4-0000ox-FH; Wed, 13 Nov 2019 02:29:06 +0000
Date:   Wed, 13 Nov 2019 02:29:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 7/9] open: introduce openat2(2) syscall
Message-ID: <20191113022906.GD26530@ZenIV.linux.org.uk>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191105090553.6350-8-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105090553.6350-8-cyphar@cyphar.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 08:05:51PM +1100, Aleksa Sarai wrote:
  
> +/*
> + * Arguments for how openat2(2) should open the target path. If @resolve is
> + * zero, then openat2(2) operates very similarly to openat(2).
> + *
> + * However, unlike openat(2), unknown bits in @flags result in -EINVAL rather
> + * than being silently ignored. @mode must be zero unless one of {O_CREAT,
> + * O_TMPFILE} are set, and @upgrade_mask must be zero unless O_PATH is set.
> + *
> + * @flags: O_* flags.
> + * @mode: O_CREAT/O_TMPFILE file mode.
> + * @upgrade_mask: UPGRADE_* flags (to restrict O_PATH re-opening).

???

> + * @resolve: RESOLVE_* flags.
> + */
> +struct open_how {
> +	__aligned_u64 flags;
> +	__u16 mode;
> +	__u16 __padding[3]; /* must be zeroed */
> +	__aligned_u64 resolve;
> +};
