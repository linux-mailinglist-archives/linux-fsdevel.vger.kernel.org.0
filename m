Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4854E3E1A95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 19:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhHERmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 13:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhHERl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:41:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5E7C061765
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Aug 2021 10:41:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u3so12637297lff.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Aug 2021 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLBGjAGYdbfgo2Z8OZ3loqXJqEwCws0dhJPDNyGfdvc=;
        b=LlyqKDTzU91dVzuBzjKzze9w6NZKpTVSZie2qpcdCcKXU4FK/ONoA7OanBuzsE8a1M
         DL/iaIq53EHJCIaYMXrsDgNiXDE4vNbRSDIsyMH8lvTomE/QZjsK8VyBDK9Dk93smC6q
         btHDlyWBEu3pZ9AyhBJ3n2f0JSd96MQj6AOIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLBGjAGYdbfgo2Z8OZ3loqXJqEwCws0dhJPDNyGfdvc=;
        b=jy25lsTyORQK1tFv30atMfr59EBW63GcbfRDACpEDzRP49/Rhl9iqvyljsTQ/JRQoy
         OXnKLj20BCJmmvu2aqgqxqF2tu6vJ43M9JAHuw9QedvylbzP1OJRJ1K5KkeL/OHZ/t5b
         gobpNgrsfRDKMaHMblGNEQHWy4gYN8mvlr/P83eGOzUTYiwJM/fY51mMlTe68R3n0tkp
         w+MtyqkQB148wjMCmdN2f5b4NUgpGklrw4ORyG8qmvQzzbsTNdwVnfj8mCVjwQK/HjVB
         HTcQ+xOHtTs2ar7i+R9lZV6FTarhCvpyzViycEmnDjjYpjte+an0bbJk1uqryZgXHP5z
         mNNQ==
X-Gm-Message-State: AOAM533Yyn22pSkDn2jjOGiU1vH9Uz8ONwgOhAQ/B/fbW4rsY/9CgY1z
        hylZNdqneKomx4vk+14ZAKwb6cPv6SRLRW40hxg=
X-Google-Smtp-Source: ABdhPJw0q1QMr6cERit3raYe6qpX0mh3/DpATRUXA5NLysblDfG+xyIifINNHq/zn6KLikeK7nTeRA==
X-Received: by 2002:ac2:5458:: with SMTP id d24mr4627403lfn.228.1628185302636;
        Thu, 05 Aug 2021 10:41:42 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h11sm579023lfc.4.2021.08.05.10.41.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 10:41:40 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id n6so8145874ljp.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Aug 2021 10:41:39 -0700 (PDT)
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr3750528ljg.251.1628185299608;
 Thu, 05 Aug 2021 10:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210805000435.10833-1-alex_y_xu.ref@yahoo.ca>
 <20210805000435.10833-1-alex_y_xu@yahoo.ca> <YQuixFfztw0RaDFi@kroah.com> <1628172774.4en5vcorw2.none@localhost>
In-Reply-To: <1628172774.4en5vcorw2.none@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Aug 2021 10:41:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgE4XwB2E0=CYB8eqss6WB1+FXgVWZRsUUSWTOeq-kh8w@mail.gmail.com>
Message-ID: <CAHk-=wgE4XwB2E0=CYB8eqss6WB1+FXgVWZRsUUSWTOeq-kh8w@mail.gmail.com>
Subject: Re: [PATCH] pipe: increase minimum default pipe size to 2 pages
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.or>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 5, 2021 at 7:18 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> I tested 5.4 and it exhibits the same problem as master using this
> non-racy program. I think the problem goes back to v4.5, the first
> release with 759c01142a ("pipe: limit the per-user amount of pages
> allocated in pipes").

Yeah, our pipe buffer allocation strategy has been fairly consistent,
although the exact locking details etc have certainly changed over
time.

I do think the behavior goes back all the way to that "limit to one
single buffer if you hit the pipe size soft limit" commit, because the
thing that example program tests has been true for the whole time,
afaik: first fill up the first pipe buffer completely, then (a) read
everything but one byte, and then (b) try to write another byte.

Doing (a) will leave the pipe buffer still allocated and in use, and
then (b) will fundamentally want to allocate a new buffer for the new
write.  Which will obviously not then be allowed if we have said "one
pipe buffer only".

So a lot of the code around pipe buffers has changed over the years,
and the exact patterns and timing and wakeups has been completely
rewritten, but that buffer allocation pattern is pretty fundamental
and I don't think that has changed at all.

(A long LONG time ago, we had only one pipe buffer, and it was a
single circular queue, and you never had this kind of "used up one
buffer, need to allocate a new one" issue, so it's not like this goes
back to Linux 0.01, but the pipe buffers go back a _loong_ time).

Allowing two buffers obviously doesn't change the basic pattern at all
- but it means that we will always allow having at least PIPE_BUF
bytes in the pipe. So you can obviously still trigger that "cannot
write any more, will block any future writes", but at that point it's
a clear user bug in thinking that pipes have some infinite buffer
size.

In contrast, expecting pipes to be able to hold 2 bytes at a time is
quite reasonable, with POSIX guaranteeing PIPE_BUF of at least 512
bytes.

I've applied Alex's patch.

                 Linus
