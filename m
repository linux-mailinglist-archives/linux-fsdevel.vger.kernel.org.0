Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2BF342EB1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 18:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCTRyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCTRyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 13:54:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC5C061574;
        Sat, 20 Mar 2021 10:54:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso6938408wmi.0;
        Sat, 20 Mar 2021 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qgObIPVC0DDu2pZlwcFEo19FvPdLb2+hTSKV0uAyM80=;
        b=vhpFAVzzgybgVIM8dUO0oz+c0b+1CeGAP0B2+BIdKOLn98OwnUYDTZgYWeuTDbqYZg
         cTXqw2ohBif5FuSEa10bAQBCSw7NWYYXKIU+2lJ5EtLy2lj7QkXKxcHCCGh7yj0HRF4D
         8YYjIprC4vXUZqLduVbukyWLjmOxKuDXplz5jvg4bi7ISt3M2cMm3ud92KlrbhSlrOc6
         1jM6X1fthdQwCf2zNdca+QC9qsAoOx6bLtJBJpqlFr/O8l9lpzF8PI/5lwoVxOetdcrP
         9WPjlN8OvrfTWzoCyzkpN8y+GFnArTCaEr5zOvLupkyOvrNmr5vQgdlEpP35anfS2gwb
         s2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qgObIPVC0DDu2pZlwcFEo19FvPdLb2+hTSKV0uAyM80=;
        b=PJnkmrb2WU1gJ8YxN46YnUDVaoe9zGDeF8l0AvvLGLs6i0VhrLm35P10KrH8i6CtRu
         4gSOHTiDZaLzP+EXNMPD4Px5iAwVsHum18U2NZXdm1QC3167dCOXPgRArdr+GOwoD07I
         /mkvN0w/i6o/m1tn6ln56f3cKRwUAILEzq9ma67Obn1ZAzYUQMC6U+0kJlwOZOLrXq9V
         IIfmV6+wPfUHLsQQrzmMhkCOE6YzFsEIq4gEqp5sFGaWFo1j/VQB5w2124I4q7LjmdFq
         BurjN74yr+pyPlugbJ2JSL+GxrMfpBo7lxYGO945WlPyvxfpIPIm3KY2LGdpbgsnMhm8
         VVxQ==
X-Gm-Message-State: AOAM53178SMXjW5p92QMkG32lrXuVwIZRbEAaZ6g7VCNimrYVRwpKKa0
        sZCCjmVWuHK2J4tEf5As700=
X-Google-Smtp-Source: ABdhPJw3ZjHoj7J9ukepH3bCi3eiCr+lukbNT6eDqb+IAfOZQrcgRC5SHhwBjE0DZ7TChU31WqiOLA==
X-Received: by 2002:a1c:e482:: with SMTP id b124mr8433377wmh.70.1616262873472;
        Sat, 20 Mar 2021 10:54:33 -0700 (PDT)
Received: from example.org (ip-94-113-225-162.net.upcbroadband.cz. [94.113.225.162])
        by smtp.gmail.com with ESMTPSA id u2sm14329095wrp.12.2021.03.20.10.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 10:54:33 -0700 (PDT)
Date:   Sat, 20 Mar 2021 18:54:29 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: test subset=pid
Message-ID: <20210320175429.qdms75wvben6cg6p@example.org>
References: <YFYZZ7WGaZlsnChS@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFYZZ7WGaZlsnChS@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 06:48:55PM +0300, Alexey Dobriyan wrote:
> Test that /proc instance mounted with
> 
> 	mount -t proc -o subset=pid
> 
> contains only ".", "..", "self", "thread-self" and pid directories.
> 
> Note:
> Currently "subset=pid" doesn't return "." and ".." via readdir.
> This must be a bug.

Ops. Good catch! Looks good to me.

Acked-by: Alexey Gladkov <gladkov.alexey@gmail.com>

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  tools/testing/selftests/proc/Makefile          |    1 
>  tools/testing/selftests/proc/proc-subset-pid.c |  121 +++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
> 
> --- a/tools/testing/selftests/proc/Makefile
> +++ b/tools/testing/selftests/proc/Makefile
> @@ -12,6 +12,7 @@ TEST_GEN_PROGS += proc-self-map-files-001
>  TEST_GEN_PROGS += proc-self-map-files-002
>  TEST_GEN_PROGS += proc-self-syscall
>  TEST_GEN_PROGS += proc-self-wchan
> +TEST_GEN_PROGS += proc-subset-pid
>  TEST_GEN_PROGS += proc-uptime-001
>  TEST_GEN_PROGS += proc-uptime-002
>  TEST_GEN_PROGS += read
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/proc/proc-subset-pid.c
> @@ -0,0 +1,121 @@
> +/*
> + * Copyright (c) 2021 Alexey Dobriyan <adobriyan@gmail.com>
> + *
> + * Permission to use, copy, modify, and distribute this software for any
> + * purpose with or without fee is hereby granted, provided that the above
> + * copyright notice and this permission notice appear in all copies.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
> + * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> + * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
> + * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
> + * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> + * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> + * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> + */
> +/*
> + * Test that "mount -t proc -o subset=pid" hides everything but pids,
> + * /proc/self and /proc/thread-self.
> + */
> +#undef NDEBUG
> +#include <assert.h>
> +#include <errno.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mount.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <dirent.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +
> +static inline bool streq(const char *a, const char *b)
> +{
> +	return strcmp(a, b) == 0;
> +}
> +
> +static void make_private_proc(void)
> +{
> +	if (unshare(CLONE_NEWNS) == -1) {
> +		if (errno == ENOSYS || errno == EPERM) {
> +			exit(4);
> +		}
> +		exit(1);
> +	}
> +	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
> +		exit(1);
> +	}
> +	if (mount(NULL, "/proc", "proc", 0, "subset=pid") == -1) {
> +		exit(1);
> +	}
> +}
> +
> +static bool string_is_pid(const char *s)
> +{
> +	while (1) {
> +		switch (*s++) {
> +		case '0':case '1':case '2':case '3':case '4':
> +		case '5':case '6':case '7':case '8':case '9':
> +			continue;
> +
> +		case '\0':
> +			return true;
> +
> +		default:
> +			return false;
> +		}
> +	}
> +}
> +
> +int main(void)
> +{
> +	make_private_proc();
> +
> +	DIR *d = opendir("/proc");
> +	assert(d);
> +
> +	struct dirent *de;
> +
> +	bool dot = false;
> +	bool dot_dot = false;
> +	bool self = false;
> +	bool thread_self = false;
> +
> +	while ((de = readdir(d))) {
> +		if (streq(de->d_name, ".")) {
> +			assert(!dot);
> +			dot = true;
> +			assert(de->d_type == DT_DIR);
> +		} else if (streq(de->d_name, "..")) {
> +			assert(!dot_dot);
> +			dot_dot = true;
> +			assert(de->d_type == DT_DIR);
> +		} else if (streq(de->d_name, "self")) {
> +			assert(!self);
> +			self = true;
> +			assert(de->d_type == DT_LNK);
> +		} else if (streq(de->d_name, "thread-self")) {
> +			assert(!thread_self);
> +			thread_self = true;
> +			assert(de->d_type == DT_LNK);
> +		} else {
> +			if (!string_is_pid(de->d_name)) {
> +				fprintf(stderr, "d_name '%s'\n", de->d_name);
> +				assert(0);
> +			}
> +			assert(de->d_type == DT_DIR);
> +		}
> +	}
> +
> +	char c;
> +	int rv = readlink("/proc/cpuinfo", &c, 1);
> +	assert(rv == -1 && errno == ENOENT);
> +
> +	int fd = open("/proc/cpuinfo", O_RDONLY);
> +	assert(fd == -1 && errno == ENOENT);
> +
> +	return 0;
> +}
> 

-- 
Rgrds, legion

