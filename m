Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4A02BBFF4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgKUOiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgKUOiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:38:01 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA185C0613CF;
        Sat, 21 Nov 2020 06:37:59 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so13872614wrx.5;
        Sat, 21 Nov 2020 06:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uWjggj2LgaDrTK7OTDqfKMOswwqFU3ZQPnsfVGvdxbM=;
        b=Ac060P5tBTf+vUKMrW4iyigJdsXRU7ihwsUjBcObS3prY6E2sgL3MmPl/gSjHq+qD7
         g9tBOKepZTy0NqLNaEVgB50p/1X++o8Ew6p2mtbGgHpaXXFwMVr5qm7Yz688rKYpgKRp
         7bXmERniLFvOgNCYS0DlamsEFaZ7givkcIzVwXu6pPDttwXWCgi9llbpBwqfUfHfvRM5
         Sn0FPDnbi6J8CTz6MTTq9PZ0NrejGoxQj+dwxB3RDH8U4cA/DJ4haHDAKlRV8tU1Fgos
         cSkCGYDsyFXMu5WVZxfH4KvBts4+VJGxbUcf8VaI55BHbfqlyq0MNIE7s/jxaAvYXiEi
         DCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uWjggj2LgaDrTK7OTDqfKMOswwqFU3ZQPnsfVGvdxbM=;
        b=aw4VY2aU3AqlwlFf8M3cFo8Nw8dXvd+Ht0Ehsp1Kjz4tuZKk4Gt0smex/Zdd4VAf3Q
         RdxpV40oMssrUYhKQ8cBRG1Qf8PoZ4ASi+TPWos67qbfdFJzLB42J9ktmjjVVbtSvonr
         ceE3fDbM4/gjz2ZY/pSJjJpPKGaL+WRrs0g3nlMN9MI9JTCIk5UCdL3gn5C6IvP3S/Qx
         Ux+thK/Cm4mraYrCBZlbXuJxpwbGEH15rNdvewmqDKn9YF8nD9YM3TBR/pEflp5x+H6F
         GRJM6bsgTpC41t73bLyl6+iN5/2QVg5sqR2WK7QECRlRFh8SLfM+gUvFSIyp7EdBqMm1
         BKAQ==
X-Gm-Message-State: AOAM532hMQVl3Wqq0sQmO3QGCd7VZ/42osnPwfI8lWPK3QGr5DtCvK9e
        rG0vaidsMkBwz1bp9l5KPOyIlyFoJ6c=
X-Google-Smtp-Source: ABdhPJwS6khJVWhhtBIAjCngM3jmeEZzsBedBNdC0rBX3mI1ECByMZtHcijWO6PZvdF30OZ+SOMupg==
X-Received: by 2002:adf:e512:: with SMTP id j18mr22941758wrm.390.1605969478130;
        Sat, 21 Nov 2020 06:37:58 -0800 (PST)
Received: from [192.168.1.173] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id i5sm9228795wrw.45.2020.11.21.06.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 06:37:57 -0800 (PST)
Subject: Re: [PATCH 00/29] RFC: iov_iter: Switch to using an ops table
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <4a277f64-e744-34cc-a4ec-16636f23b13a@gmail.com>
Date:   Sat, 21 Nov 2020 14:34:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/11/2020 14:13, David Howells wrote:
> 
> Hi Pavel, Willy, Jens, Al,
> 
> I had a go switching the iov_iter stuff away from using a type bitmask to
> using an ops table to get rid of the if-if-if-if chains that are all over
> the place.  After I pushed it, someone pointed me at Pavel's two patches.
> 
> I have another iterator class that I want to add - which would lengthen the
> if-if-if-if chains.  A lot of the time, there's a conditional clause at the
> beginning of a function that just jumps off to a type-specific handler or
> to reject the operation for that type.  An ops table can just point to that
> instead.
> 
> As far as I can tell, there's no difference in performance in most cases,
> though doing AFS-based kernel compiles appears to take less time (down from
> 3m20 to 2m50), which might make sense as that uses iterators a lot - but
> there are too many variables in that for that to be a good benchmark (I'm
> dealing with a remote server, for a start).
> 
> Can someone recommend a good way to benchmark this properly?  The problem
> is that the difference this makes relative to the amount of time taken to
> actually do I/O is tiny.

I find enough of iov overhead running fio/t/io_uring.c with nullblk.
Not sure whether it'll help you but worth a try.

> 
> I've tried TCP transfers using the following sink program:
> 
> 	#include <stdio.h>
> 	#include <stdlib.h>
> 	#include <string.h>
> 	#include <fcntl.h>
> 	#include <unistd.h>
> 	#include <netinet/in.h>
> 	#define OSERROR(X, Y) do { if ((long)(X) == -1) { perror(Y); exit(1); } } while(0)
> 	static unsigned char buffer[512 * 1024] __attribute__((aligned(4096)));
> 	int main(int argc, char *argv[])
> 	{
> 		struct sockaddr_in sin = { .sin_family = AF_INET, .sin_port = htons(5555) };
> 		int sfd, afd;
> 		sfd = socket(AF_INET, SOCK_STREAM, 0);
> 		OSERROR(sfd, "socket");
> 		OSERROR(bind(sfd, (struct sockaddr *)&sin, sizeof(sin)), "bind");
> 		OSERROR(listen(sfd, 1), "listen");
> 		for (;;) {
> 			afd = accept(sfd, NULL, NULL);
> 			if (afd != -1) {
> 				while (read(afd, buffer, sizeof(buffer)) > 0) {}
> 				close(afd);
> 			}
> 		}
> 	}
> 
> and send program:
> 
> 	#include <stdio.h>
> 	#include <stdlib.h>
> 	#include <string.h>
> 	#include <fcntl.h>
> 	#include <unistd.h>
> 	#include <netdb.h>
> 	#include <netinet/in.h>
> 	#include <sys/stat.h>
> 	#include <sys/sendfile.h>
> 	#define OSERROR(X, Y) do { if ((long)(X) == -1) { perror(Y); exit(1); } } while(0)
> 	static unsigned char buffer[512*1024] __attribute__((aligned(4096)));
> 	int main(int argc, char *argv[])
> 	{
> 		struct sockaddr_in sin = { .sin_family = AF_INET, .sin_port = htons(5555) };
> 		struct hostent *h;
> 		ssize_t size, r, o;
> 		int cfd;
> 		if (argc != 3) {
> 			fprintf(stderr, "tcp-gen <server> <size>\n");
> 			exit(2);
> 		}
> 		size = strtoul(argv[2], NULL, 0);
> 		if (size <= 0) {
> 			fprintf(stderr, "Bad size\n");
> 			exit(2);
> 		}
> 		h = gethostbyname(argv[1]);
> 		if (!h) {
> 			fprintf(stderr, "%s: %s\n", argv[1], hstrerror(h_errno));
> 			exit(3);
> 		}
> 		if (!h->h_addr_list[0]) {
> 			fprintf(stderr, "%s: No addresses\n", argv[1]);
> 			exit(3);
> 		}
> 		memcpy(&sin.sin_addr, h->h_addr_list[0], h->h_length);
> 		cfd = socket(AF_INET, SOCK_STREAM, 0);
> 		OSERROR(cfd, "socket");
> 		OSERROR(connect(cfd, (struct sockaddr *)&sin, sizeof(sin)), "connect");
> 		do {
> 			r = size > sizeof(buffer) ? sizeof(buffer) : size;
> 			size -= r;
> 			o = 0;
> 			do {
> 				ssize_t w = write(cfd, buffer + o, r - o);
> 				OSERROR(w, "write");
> 				o += w;
> 			} while (o < r);
> 		} while (size > 0);
> 		OSERROR(close(cfd), "close/c");
> 		return 0;
> 	}
> 
> since the socket interface uses iterators.  It seems to show no difference.
> One side note, though: I've been doing 10GiB same-machine transfers, and it
> takes either ~2.5s or ~0.87s and rarely in between, with or without these
> patches, alternating apparently randomly between the two times.
> 
> The patches can be found here:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-ops
> 
> David
> ---
> David Howells (29):
>       iov_iter: Switch to using a table of operations
>       iov_iter: Split copy_page_to_iter()
>       iov_iter: Split iov_iter_fault_in_readable
>       iov_iter: Split the iterate_and_advance() macro
>       iov_iter: Split copy_to_iter()
>       iov_iter: Split copy_mc_to_iter()
>       iov_iter: Split copy_from_iter()
>       iov_iter: Split the iterate_all_kinds() macro
>       iov_iter: Split copy_from_iter_full()
>       iov_iter: Split copy_from_iter_nocache()
>       iov_iter: Split copy_from_iter_flushcache()
>       iov_iter: Split copy_from_iter_full_nocache()
>       iov_iter: Split copy_page_from_iter()
>       iov_iter: Split iov_iter_zero()
>       iov_iter: Split copy_from_user_atomic()
>       iov_iter: Split iov_iter_advance()
>       iov_iter: Split iov_iter_revert()
>       iov_iter: Split iov_iter_single_seg_count()
>       iov_iter: Split iov_iter_alignment()
>       iov_iter: Split iov_iter_gap_alignment()
>       iov_iter: Split iov_iter_get_pages()
>       iov_iter: Split iov_iter_get_pages_alloc()
>       iov_iter: Split csum_and_copy_from_iter()
>       iov_iter: Split csum_and_copy_from_iter_full()
>       iov_iter: Split csum_and_copy_to_iter()
>       iov_iter: Split iov_iter_npages()
>       iov_iter: Split dup_iter()
>       iov_iter: Split iov_iter_for_each_range()
>       iov_iter: Remove iterate_all_kinds() and iterate_and_advance()
> 
> 
>  lib/iov_iter.c | 1440 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 934 insertions(+), 506 deletions(-)
> 
> 

-- 
Pavel Begunkov
