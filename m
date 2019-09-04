Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB1A945D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfIDVA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 17:00:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIDVAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1C4yzaFGm2dwE00FHfKi5dL3sc9qq3Dq1frkLdiVUqw=; b=smx+9n2brd7Qen+GYWPQQhIKw
        LsHXOmj6SJXN6ngq2DhawrUsC2Js4WfXdX4ZCTTqAZpLgAXuwwv2iT7jrmJ5neLvsb4eJAcXkjrNL
        AjcV2dvIxzryFJAMSCU0CqPtwgVNzjJzkFqk8pl+N02nYRjfbk78ICCZGJxX+THHzwwK2RqinrIdD
        9yxD1/vsztHWf3zNok/bRboi810c1iXKTUCmtyphRgggRgYvXeuRTiAcxecMn7/DvwvvWuYJeSpQm
        cVgxdDB+FARin5F4v3LjFiWqWLAFNLSXU9BsExHoAQR6AFxACk2w46ZMfB7yt+5oa4qMhcZIdJav2
        nmnU8O9PQ==;
Received: from [2601:1c0:6200:6e8::e2a8]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5cO6-0002LK-Qx; Wed, 04 Sep 2019 21:00:23 +0000
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Eric Biederman <ebiederm@xmission.com>,
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
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-12-cyphar@cyphar.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e31b450-75b8-f037-dca7-b1bd547cf339@infradead.org>
Date:   Wed, 4 Sep 2019 14:00:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904201933.10736-12-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
just noisy nits here:

On 9/4/19 1:19 PM, Aleksa Sarai wrote:

> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 1d338357df8a..479baf2da10e 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -93,5 +93,47 @@
>  
>  #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
>  
> +/**

/** means "the following is kernel-doc", but it's not, so please either make
it kernel-doc format or just use /* to begin the comment.

> + * Arguments for how openat2(2) should open the target path. If @resolve is
> + * zero, then openat2(2) operates identically to openat(2).
> + *
> + * However, unlike openat(2), unknown bits in @flags result in -EINVAL rather
> + * than being silently ignored. In addition, @mode (or @upgrade_mask) must be
> + * zero unless one of {O_CREAT, O_TMPFILE, O_PATH} are set.
> + *
> + * @flags: O_* flags.
> + * @mode: O_CREAT/O_TMPFILE file mode.
> + * @upgrade_mask: UPGRADE_* flags (to restrict O_PATH re-opening).
> + * @resolve: RESOLVE_* flags.
> + */
> +struct open_how {
> +	__u32 flags;
> +	union {
> +		__u16 mode;
> +		__u16 upgrade_mask;
> +	};
> +	__u16 resolve;
> +};


-- 
~Randy
