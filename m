Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1B117413
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 19:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfLISYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 13:24:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33391 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLISYe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:24:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id 21so16823077ljr.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIXWZyTd39+6esYPe9MmFdMJXzmcp5bMpJnRkNThpb4=;
        b=I5z0RVLWrUPKkPPuZeqHORejsaLh5EEfaCmf/IUxy3Oow1k8FTCGy60JJ0TNIV3r4f
         2P/+8pOUDPgMSUgGxWyl95suJenzD1M7wzFBDWuG6/N9n3g6tJq7RZ0gNcKqdsCA0lQI
         CgpVgkKslfC4ZiS36sJHLjqnWvQ8F/RhgZL3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIXWZyTd39+6esYPe9MmFdMJXzmcp5bMpJnRkNThpb4=;
        b=Y70Mz6mox081H+5AwrwecYg3tyUR4FgUok9zYTiD3vkhgrpajrdFMmW09UUTVjewAo
         fKMUD82CtmqKrDZKss1sGfECiKX2Koe1u4wvotWJh+Jz3BpixORDlCK4rLDKZW5QWhA7
         ZL/8UBUfMEeGRO3/b0glIMHASzCbWC0RST94BGEUuYE+PozT7iBIp38lWFB8igKGDco+
         owuVeICEBYM6yhnx4DRaKp71ZuoHZ+k8R33syDXW/5ZibURu1IiXdjiBdJbIuNzM7pDP
         udq7+DrKXWxvIXr5mfJC1A/TXBmpBgp16HDr5XgKsk//Uz9hMVrJRlCvFaLUV2wbwJl8
         9iyQ==
X-Gm-Message-State: APjAAAVAQ0Nj/Mm4rZNgAiyYA/T14+YLTGR+QuH2g5ZalerFPK/mGKRC
        EgyJz8ZUFMC7b6aYpos+HU4+NYy+wxI=
X-Google-Smtp-Source: APXvYqzislRT1WcmFZCqR0xwCuxYyHynGSIXneAUhLq/166mSA2XCOpsEy7/HHCu45ElmRqZ+wX0zg==
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr17956445ljk.77.1575915871751;
        Mon, 09 Dec 2019 10:24:31 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c8sm97609lfm.65.2019.12.09.10.24.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:24:29 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id s22so16775487ljs.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 10:24:28 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr15574881ljn.48.1575915868556;
 Mon, 09 Dec 2019 10:24:28 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com>
 <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
 <CABA31DqGSycoE2hxk92NZ8qb47DqTR0+UGMQN_or1zpoGCg9fw@mail.gmail.com> <CAHk-=wjnXUUbYikSFba5QqvJoFnO8c_ykXrw9Zz2Lt4SeyeZUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjnXUUbYikSFba5QqvJoFnO8c_ykXrw9Zz2Lt4SeyeZUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Dec 2019 10:24:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizyzWdjkpm_Zm9DY9TzDCB2cbyhf5HUKoWnfJoqSNtuQ@mail.gmail.com>
Message-ID: <CAHk-=wizyzWdjkpm_Zm9DY9TzDCB2cbyhf5HUKoWnfJoqSNtuQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Akemi Yagi <toracat@elrepo.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        DJ Delorie <dj@redhat.com>, David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 9, 2019 at 10:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looks like opensuse and ubuntu are also on 4.2.1 according to
>
>    https://software.opensuse.org/package/make
>    https://packages.ubuntu.com/cosmic/make
>
> so apparently the bug is almost universal with the big three sharing
> this buggy version.

And the reason seems to be is that it's considered the latest "release" version.

In the git tree, I see 4.2.92, but looking at

    https://ftp.gnu.org/gnu/make/

it looks like 4.2.1 is the latest actual "release".

Oh well. I can't find a workaround for the bug, other than perhaps
using "make -LX" instead of "make -jX". Which is not the same thing at
all, of course.

                Linus
