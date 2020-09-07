Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A1125F39C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgIGHLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 03:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgIGHLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:11:18 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C1C061573;
        Mon,  7 Sep 2020 00:11:18 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t76so12745811oif.7;
        Mon, 07 Sep 2020 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=lY1WBId2Rm4ea48tbmZf/xPyulKCoJ/TY3fQpMzbS0U=;
        b=YrBAJBseY5e/BE4XD1m/i1DvGEmtfu958yRHHYhhcp21YCf+w/2/oOFsgtTbvIMy21
         4sY4+6jG3kHvRVwQDLIbN0Emummfx88T2NGYCKUKDt/ptO5X3FKOsSwK88prAyYmixqF
         yc5fUGEJ0BUu25AxHczFWZux7bhkS1iGB83vWIkwUwIQFLq0mXKsoYljpwsBac19/y1l
         /5mLv0uGnDmUImVbOU9sNrKjYWRwO5UjZqrQ06FhZl27kqFBxhhzgH0+vL+MXj6NDYfW
         SHF36egluNFmtehf8R9G8/uuvchY0mnJ+CZJzlJmBOgKgYQyTeqtPWlbeJBU4K18CJSu
         ZgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=lY1WBId2Rm4ea48tbmZf/xPyulKCoJ/TY3fQpMzbS0U=;
        b=sVBaKZ3MWuT3sGl1wlfrY2UokyF90bqbWXVcjm3Y82DLQ5EbBFqqKg5bLFXkQ8dG1w
         zmG3B8wnPxaV87ea5/aOXwMoaVtBc5pCkGM+Zz3I6nbpGbfqQQpfW+AwMvRBCqLRJ9Eh
         P1OdBqIVSeanmLiIWnwy1tC5OsoY2E/4Odvg4bDs4X5h+5NSskrpr3/tuhHSZl7s+s1x
         SDksA+37Ury9aqn/kyVNKSwwVzirVFAdfvkQHmyiKFL7wf+kru8RzN4mBhMwQYXgZaJj
         4nsQ+goz69/73VqTpFhqKZxg0nx4RvyYbObKFGTZ2LsTN5RNxtTwHCZhH1qq4LCMO7uy
         eJtQ==
X-Gm-Message-State: AOAM5307Gfw0s3EjJ7kTsPnVnDmE0ZtsjmW6DhjojhR7l69rtf99XOMk
        d64gKhwJCjzbiG9aYzuVUD1KQkJzwZpB5QM5Ds426mIrzlM=
X-Google-Smtp-Source: ABdhPJyKgL/p/+i7g0vi+h5u4j5367KBoxYXCX3EcCCCR+HHDEBhqjJ8PVim79xKCGK2UyVfmLsktGWAT1KGuAopMl4=
X-Received: by 2002:aca:100b:: with SMTP id 11mr4616262oiq.177.1599462677494;
 Mon, 07 Sep 2020 00:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
In-Reply-To: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 7 Sep 2020 09:11:06 +0200
Message-ID: <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
To:     milan.opensource@gmail.com
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Widening the CC to include Andrew and linux-fsdevel@]
[Milan: thanks for the patch, but it's unclear to me from your commit
message how/if you verified the details.]

Andrew, maybe you (or someone else) can comment, since long ago your

    commit f79e2abb9bd452d97295f34376dedbec9686b986
    Author: Andrew Morton <akpm@osdl.org>
    Date:   Fri Mar 31 02:30:42 2006 -0800

included a comment that is referred to in  stackoverflow discussion
about this topic (that SO discussion is in turn referred to by
https://bugzilla.kernel.org/show_bug.cgi?id=194757).

The essence as I understand it, is this:
(1) fsync() (and similar) may fail EIO or ENOSPC, at which point data
has not been synced.
(2) In this case, the EIO/ENOSPC setting is cleared so that...
(3) A subsequent fsync() might return success, but...
(4) That doesn't mean that the data in (1) landed on the disk.

The proposed manual page patch below wants to document this, but I'd
be happy to have an FS-knowledgeable person comment before I apply.

Thanks,

Michael

On Sat, 29 Aug 2020 at 09:13, <milan.opensource@gmail.com> wrote:
>
> From: Milan Shah <milan.opensource@gmail.com>
>
> This Fix addresses Bug 194757.
> Ref: https://bugzilla.kernel.org/show_bug.cgi?id=194757
> ---
>  man2/fsync.2 | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/man2/fsync.2 b/man2/fsync.2
> index 96401cd..f38b3e4 100644
> --- a/man2/fsync.2
> +++ b/man2/fsync.2
> @@ -186,6 +186,19 @@ In these cases disk caches need to be disabled using
>  or
>  .BR sdparm (8)
>  to guarantee safe operation.
> +
> +When
> +.BR fsync ()
> +or
> +.BR fdatasync ()
> +returns
> +.B EIO
> +or
> +.B ENOSPC
> +any error flags on pages in the file mapping are cleared, so subsequent synchronisation attempts
> +will return without error. It is
> +.I not
> +safe to retry synchronisation and assume that a non-error return means prior writes are now on disk.
>  .SH SEE ALSO
>  .BR sync (1),
>  .BR bdflush (2),
> --
> 2.7.4
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
