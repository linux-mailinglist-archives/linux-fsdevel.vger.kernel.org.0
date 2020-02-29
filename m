Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842B4174649
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 11:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgB2Kot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 05:44:49 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40188 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgB2Kot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 05:44:49 -0500
Received: by mail-il1-f194.google.com with SMTP id g6so3873850ilc.7;
        Sat, 29 Feb 2020 02:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HS7ztuzh2BqQBQpmiC2ldOUNPcEghbC3hm9/CwArk8=;
        b=BV2VCG7xY1cHoSJQXUawO1Jn5fjQ/f2a+BJqaBZ7uklC2vgMwUkWk73peg8x9MTleH
         PK/VT/Bv/UYeb97zF4jKPApKPqPWbm0bHTcaken5Z/5qVuokXPnNVF+354oDEM1F+rBG
         MQN2JT5uDVuOf4DMFJ8gShiNnTpiIjoBhIcuzlxd1Ka0EOf5jqRqOMAU8dRkH5augo8c
         2LVJ8HAIoy+5SoaihcYVjI4kMdUR4glqXL5yDFZKDDgAnQoU1tVgFrpKtGBcANgFP3ez
         SPx7O7Y9kBloTGOxtcox5RmYvEXTCnuD05cD1FqUrtClijCuDEBwh49FOFD6ccINX1PD
         KBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HS7ztuzh2BqQBQpmiC2ldOUNPcEghbC3hm9/CwArk8=;
        b=nnLfrFqEscqBmB8rhRJnzWKbfqV+J0x97w9MfvswxBF9HOcmORQ2xBysj9ZRgpt0Ep
         RpzkH30pmAh/+4ktINgJ9v/bFbjksE7qA14XT3ae0Gj+kpL4rX/ubYE3OaYCiVISWZJv
         489aigdQ70mICDxe7L9DjqPuRfXe8t69Z0v0/yHJ27fwrHypgK5+pPxgThQTLuEQ2U0X
         xaU3aWMm6b5E864fwfoYqC7o9bgMM5JYnsepr09w3ASXZJFgamYy4Fh9ebGQSICP2d61
         3c19x2FKYo0vvPfgxCtp9MYOpWqrTOUStBVih85OqKO5/UwqL7uodBFRf5Xpfm3HEJNj
         iYEA==
X-Gm-Message-State: APjAAAWwWVoGzSMkJfkatGZVu8J7YBxgBky8Y9v6ryHNNpt3lMjn0kvx
        SPnDYOxoAnhI+V9lP+Rr230GA0SCMiIsqmTzhnY=
X-Google-Smtp-Source: APXvYqwsKB1pyCBf2wFgfD6pKiOO4Fa49e6pn0I55/sGIyOC7iwurRtReDDtI3hxPKkWsK4hCy1Nd6oFFLeBPbxixeo=
X-Received: by 2002:a92:6f10:: with SMTP id k16mr8238494ilc.275.1582973088687;
 Sat, 29 Feb 2020 02:44:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582930832.git.osandov@fb.com> <6d67d097e295ddfe0b9a6499f4ddf00bfdb46789.1582930832.git.osandov@fb.com>
In-Reply-To: <6d67d097e295ddfe0b9a6499f4ddf00bfdb46789.1582930832.git.osandov@fb.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 29 Feb 2020 12:44:37 +0200
Message-ID: <CAOQ4uxjAvgjWmSA28CrzX6E-O_nVW0P-X422LdCd2LpME2ZAHg@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] fs: add O_ALLOW_ENCODED open flag
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 1:14 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> The upcoming RWF_ENCODED operation introduces some security concerns:
>
> 1. Compressed writes will pass arbitrary data to decompression
>    algorithms in the kernel.
> 2. Compressed reads can leak truncated/hole punched data.
>
> Therefore, we need to require privilege for RWF_ENCODED. It's not
> possible to do the permissions checks at the time of the read or write
> because, e.g., io_uring submits IO from a worker thread. So, add an open
> flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> fcntl(). The flag is not cleared in any way on fork or exec; it should
> probably be used with O_CLOEXEC in most cases.
>

So let's be more proactive and disallow setting O_ALLOW_ENCODED without
O_CLOEXEC, shall we?

> Note that the usual issue that unknown open flags are ignored doesn't
> really matter for O_ALLOW_ENCODED; if the kernel doesn't support
> O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.
>

And for that matter, setting O_ALLOW_ENCODED without O_CLOEXEC
won't do any harm with old kernels - even better, it can serve as a fast
test for kernel RWF_ENCODED support using only the openat() syscall.

Thanks,
Amir.
