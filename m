Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6B56DDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 17:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfFZPim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 11:38:42 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33436 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZPim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:38:42 -0400
Received: by mail-yw1-f66.google.com with SMTP id v15so1405594ywv.0;
        Wed, 26 Jun 2019 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jscs/NQhsMJm3Bz4L0VMCmJ2D5+l4QjLlMm6PSR1V2I=;
        b=UIiGXEh5lSb6iCtsVtOddFNaeyNxnMvdYe6T4bX6HK0x52zq+/9znF7RyeGLBBLmea
         gXbccmvAa0zg5mSffcpl7AE7tfVY+CRVBRKWE9B6QGRkuVmnFAUCyjvEB1RppnQL05uD
         1A5HG9ZRoxq3R2s2xNPb1tq9rcsWdnuSwGhgfMhVL6OG4E/4B52drKr29+8JnlJPFlKD
         XSj633lg8iwNLMHfdVpZaXYTUaE8x8ICgijPGbMyLaOYrLbkUbozu47g1HaPGZ5owlx0
         QJQOVkStBcAxtmyFLPh+dANVTYLGWXAfCh1ORaXLLI2IuCtsAk6LPBTFMWvOyJ7ncZyl
         s84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jscs/NQhsMJm3Bz4L0VMCmJ2D5+l4QjLlMm6PSR1V2I=;
        b=GGfwRGKo6aYhh6Il4JRLhAcUhpyrvKNXCIFrL5EeRerRVwalpgz7UcTOrhvz2Yi1EB
         cixS+qF2mx8dIXWaKb99X9WSziyzSdHp+I7OjybJDsH/uNT64y7H8NL1foLawNqfHhEM
         QoE6xfNiABQ1HkY2bxgd+mEMIkkVCnDsywjnKKbIBmIoKvkP0BfRqi2us57gFkQy1csi
         0Ow/re2wA4tLZVwbdEZYXHTqlf/DeRjSWhjHPhs8xAqwo5qI9jd6tOGNH2vW/uW5vFNc
         gEyFvEzRNb+espvrEsVwbz4Nx9I+10BerGv+RGyKgeWWx8fvRC2buylEYsWQM9QxxNPu
         R/MQ==
X-Gm-Message-State: APjAAAUuz8piZo7t/Txc0xCkR+Mr/AwKR1jPfGhU9+qIj4z2Pau62Dnp
        Z9ORcRrHi1B0JfatpZqWxfU4AX1Wk/qFz2TKQ6ea3lgm
X-Google-Smtp-Source: APXvYqymBq+5A2guU+KvAiclUBlSZAqqQzxlJMz2nUKT8xQxrqA0jjfXbPqOvhVVVGwBQQkf3oSC2gedWKW0aK5g5dE=
X-Received: by 2002:a0d:f5c4:: with SMTP id e187mr3058555ywf.88.1561563521428;
 Wed, 26 Jun 2019 08:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <987759a8-0b0b-f74e-4a0e-b3570d9a888f@linux.ibm.com>
In-Reply-To: <987759a8-0b0b-f74e-4a0e-b3570d9a888f@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 26 Jun 2019 18:38:29 +0300
Message-ID: <CAOQ4uxhYEHTQKX5Obm2iCYcp2XihXxr6+y=0eB0W0V6Kssk+Aw@mail.gmail.com>
Subject: Re: New glibc-testfail io/tst-copy_file_range with kernel-next.
To:     Stefan Liebler <stli@linux.ibm.com>
Cc:     GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 4:57 PM Stefan Liebler <stli@linux.ibm.com> wrote:
>
> Hi,
>
> as information, I had the chance to run the glibc-testsuite on a
> kernel-next from today on s390x and recognized a new failing test:
> io/tst-copy_file_range

Thanks for the detailed report!

[cc: linux-api and linux-fsdevel]

>
> It seems as the patches from Amir Golstein are changing the behaviour of
> copy_file_range. See two of the series:
> -"vfs: allow copy_file_range to copy across devices"
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5dae222a5ff0c269730393018a5539cc970a4726
> -"vfs: add missing checks to copy_file_range"
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=96e6e8f4a68df2d94800311163faa67124df24e5
>
> A quick look into the verbose output (see attached file) shows at least
> the following changes:
>
> - writing at a position past the maximum allowed offset with "write"
> fails with EINVAL (22) whereas "copy_file_range" is now returning EFBIG
> (27). The test assumes that the same errno is set for "write" and
> "copy_file_range". (See <glibc>/io/tst-copy_file_range.c in
> delayed_write_failure_beginning() with current_size=1 or the second copy
> in delayed_write_failure_end())
> According to http://man7.org/linux/man-pages/man2/copy_file_range.2.html
> and http://man7.org/linux/man-pages/man2/write.2.html EFBIG seems to be
> the correct error.
> Should "write" also return EFBIG in those cases?

I'm not sure.
I think it makes sense for copy_file_range()  to behave very similarly to
"read"+"write" that is what I was aiming for. However, copy_file_range()
can be called with or without pos/offset. When called with offset, it would
be better to try and match its behavior with pread/pwrite. Note the EINVAL
case in http://man7.org/linux/man-pages/man2/pwritev.2.html
when offset+len overflows ssize_t.

Also, please see planned changes to copy_file_range() man page:
https://github.com/amir73il/man-pages/commit/ef24cb90797552eb0a2c55a1fb7f2c275e3b1bdb

>
> - For delayed_write_failure_beginning() with current_size>=2
> copy_file_range is started at a valid offset, but the length is beyond a
> valid range. copy_file_range is now copying the "valid" bytes and
> returning the number of copied bytes. The old behaviour was to return
> EINVAL without copying anything.
> In find_maximum_offset() a test sets maximum_offset_hard_limit to
> true/false depending on the behaviour of "write" in such a situation
> and the tests in delayed_write_failure_beginning() are assuming that
> "copy_file_range" behaves like "write".
> Should "write" perform the same partial copies as "copy_file_range" or
> how to determine the setting of maximum_offset_hard_limit?
>
> - In cross_device_failure it is assumed that copy_file_range always
> fails with EXDEV. Amirs patches are now allowing this case if possible.
> How could the testcase determine if the kernel supports cross device
> copies or not?
>
>

Florian's response:

> There's been a previous thread here:
>
>  <https://sourceware.org/ml/libc-alpha/2019-06/msg00039.html>
>
> I can back out the emulation, as discussed, then there wouldn't be
> anything left to test in theory (although I think our tests caught one
> or two bugs in XFS backports downstream, that as before fstests covered
> copy_file_range).

I agree that sounds like the best option.

Thanks,
Amir.
