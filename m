Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F84115866
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 22:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLFVEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 16:04:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44952 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFVEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:04:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19so9047582lji.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 13:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=N5jNUqI0VTnKojC60LXRRrRCF9Kd4ozDJywm8qVH48M=;
        b=T+F3Xq2tjKRjrpZcEc6t7v18sftYeucO7ZyPfPqQ7tM6q9iFLFGbCuoWlfRY2Hzk+l
         and8v+JEwpmdnyVjXGn1FM2unB92WIhz/EloPMLQdj9o+Xf4HI4y417R0xUXJs8RO1y7
         xFw7J7L1qfI8JtZHgrkuKl3lKoLBh5eEnA5I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=N5jNUqI0VTnKojC60LXRRrRCF9Kd4ozDJywm8qVH48M=;
        b=bmr09qRFdCWI5oANr+ypFvI1h/Hv3a5tdzIU1r6EhDx+ExvUSe15ghI34zjzuolgCW
         oW06MN5BYH7ssD6tZLDvoNF9HcypBUEUX9uIWKM8S1EnDtoMVuU5CxXf8G942ozaFiUe
         EmYYcI0X2oEN2jEOO7ivw3+tTNG7MpNY6n09blyUDYtsed4coIWEiaqwtRN+LVYdWaEo
         ShU6cBHPrTYELtw9BmYIEcMh6FysL2LmzL1hqqkzEDrdn7A3AiH5vQ/RVS2m4+9sk3J7
         RzkC7THkDsrk2L/gUip6zHCzSWW5ZIrIc8OZtqkVlJ3TtdOHdfbZeJJNl5Bkv5uP7RCW
         YkXA==
X-Gm-Message-State: APjAAAWqaWSr1MZ7TMevH8IJ8cyiwQrpLc3bp4XlN1HkJ9ZExF1y+vUq
        nF2W/D76wl5mbTeg5Y1QETMt489v/Bs=
X-Google-Smtp-Source: APXvYqxcmcw83t1k2a8inl6flAqNScEVf6c7zwAW476mAfX8JSfK7lQ9rzebh3tUChPTYfM0AtCmRw==
X-Received: by 2002:a2e:9755:: with SMTP id f21mr9991348ljj.23.1575666259233;
        Fri, 06 Dec 2019 13:04:19 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id n3sm7062007lfk.61.2019.12.06.13.04.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 13:04:18 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id z17so9041470ljk.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 13:04:18 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr7532335ljn.48.1575666257943;
 Fri, 06 Dec 2019 13:04:17 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 13:04:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
Message-ID: <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 6, 2019 at 12:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think I found it.
>
> TOTALLY UNTESTED patch appended. It's whitespace-damaged and may be
> completely wrong. And might not fix it.

Well, it compiles, and it's obviously correct, so I've committed it.

It doesn't fix my "kernel compiles go single-threaded" issue. Which is
not surprising - make doesn't use splice(), it just reads and writes
single characters (the main make server writes a "+" character for
each available job, and parallel sub-makes will read one for each job
they start and write one when done - or something very close to that).

I think that is related to the other pipe changes, though - there were
some wakeup changes in there too. The btrfs problem was bisected to
the original commit, which is what I think my patch fixes.

                  Linus
