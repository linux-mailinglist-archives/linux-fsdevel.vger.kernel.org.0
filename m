Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12FDB9FC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 23:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfIUVLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Sep 2019 17:11:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38953 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfIUVLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Sep 2019 17:11:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id 72so7397928lfh.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2019 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VikouSUKYvwFg2+XEm8bvkjMMwZXxxDQFHovYtl61ic=;
        b=PnY4kn5XmbgED9iceT6TSWjBnG9pXS5XREES+T0YGoH5www99WGfRxB4nKs6lXcUSL
         rM4FUCx5sr3nPGdmvXUd5YMoxETp+TJ4hnz253/POayI8dnDDSV9ZtG3icE4pKpN2N4X
         qxlGkQAbcb6qZ8YfgAt3Qce29gfJEnad0gqkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VikouSUKYvwFg2+XEm8bvkjMMwZXxxDQFHovYtl61ic=;
        b=oJPTaazRkfPtrJk4rl9H7DBFuztOLuzpFxDQc2Q/TKvH+HRcJf0LqqSUs4Oz1SqALN
         spJKewJfhKggTBWBiEAYwDFK28ubGedC1WV+4doFDE7ep0XdAZmZ1kvLRrw0wDoVhhGr
         XREzeAOYjcHc4PDaL6ioKHe9tnWgSsJNdB7D0kLXO7tocNA6iN1pDtfJZfV7+AKH6WiT
         GQ0ByVS21pxI+YIioZsuom+JkAj2u3olnw6Q21p2x9YTkBMUZQyGS3mzwBy0zTVC34KN
         V/oDwGnAraGqzmXwxb4RHLbv0eJUF3cHCS3EKEgthJwy76PdqhRt/7FKcn00aXnmtmpY
         s65Q==
X-Gm-Message-State: APjAAAWbUnxiu3rWqOV12fwwK+zX16qtE5iGZpVh7JpV2GEotObJJuzA
        5QURJIdnwoWUpJWj1u/WU6vBU3sErsA=
X-Google-Smtp-Source: APXvYqyaq2d0bR8VFdXGzV6qri9SwbUCIZXpnCBH6NBHI9rLa+z/u381bHvlfvsyBhBPtNDVuWNTiw==
X-Received: by 2002:ac2:4853:: with SMTP id 19mr11861519lfy.69.1569100270377;
        Sat, 21 Sep 2019 14:11:10 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id q13sm1244465lfk.51.2019.09.21.14.11.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2019 14:11:08 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v24so10221218ljj.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2019 14:11:08 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr13128116ljj.72.1569100268485;
 Sat, 21 Sep 2019 14:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190920110017.GA25765@quack2.suse.cz>
In-Reply-To: <20190920110017.GA25765@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Sep 2019 14:10:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgr6kuKo76xcaUa-TSw83N+nbHJn9AkVJ9Zzv8b0feHQg@mail.gmail.com>
Message-ID: <CAHk-=wgr6kuKo76xcaUa-TSw83N+nbHJn9AkVJ9Zzv8b0feHQg@mail.gmail.com>
Subject: Re: [GIT PULL] fanotify cleanup for v5.4-rc1
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 20, 2019 at 4:00 AM Jan Kara <jack@suse.cz> wrote:
>
>   could you please pull from

Pulled and then unpulled.

This is a prime example of a "cleanup" that should never ever be done,
and a compiler warning that is a disgrace and shouldn't happen.

This code:

        WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);

is obvious and makes sense. It clearly and unambiguously checks that
'len' is in the specified range.

In contrast, this code:

        WARN_ON_ONCE(len >= FANOTIFY_EVENT_ALIGN);

quite naturally will make a human wonder "what about negative values".

Yes, it turns out that "len" is unsigned.  That isn't actually
immediately obvious to a human, since the declaration of 'len' is 20+
lines earlier (and even then the type doesn't say "unsigned", although
a lot of people do recognize "size_t" as such).

In fact,  maybe some day the type will change, and the careful range
checking means that the code continues to work correctly.

The fact that "len" is unsigned _is_ obvious to the compiler, which
just means that now that compiler can ignore the "< 0" thing and
optimize it away. Great.

But that doesn't make the compiler warning valid, and it doesn't make
the patch any better.

When it comes to actual code quality, the version that checks against
zero is the better version.

Please stop using -Wtype-limits with compilers that are too stupid to
understand that range checking with the type range is sane.

Compilers that think that warning for the above kind of thing is ok
are inexcusable garbage.

And compiler writers who think that the warning is a good thing can't
see the forest for the trees. They are too hung up on a detail to see
the big picture.

Why/how was this found in the first place? We don't enable type-limit
checking by default.

We may have to add an explicit

   ccflags-y += $(call cc-disable-warning, type-limits)

if these kinds of patches continue to happen, which would be sad.
There are _valid_ type limits.

But this kind of range-based check is not a valid thing to warn about,
and we shouldn't make the kernel source code worse just because the
compiler is doing garbage things.

              Linus
