Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD78DAAE3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 00:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbfIEWOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 18:14:39 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:42477 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbfIEWOi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:14:38 -0400
Received: by mail-lj1-f180.google.com with SMTP id y23so4089238lje.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2019 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+bS8S77AzTpTBzzxsdlLs0HnCbtRjNnmkiZK0MPy0c=;
        b=LbASCsGx0k6udtd2AsgFeBhmCaCLrlsklx+62iSSE5Gkytkq0WN1acnDpFn5oCNEQS
         KMkfsxyWBngO5Ing5S64rk5RN/Socr904CmKtCx01r5GqFjCKXQfIr7B9uXv9DslB2br
         7qADnXCimEFjoVvgCL5m3EkgAFlL+VHV2J5FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+bS8S77AzTpTBzzxsdlLs0HnCbtRjNnmkiZK0MPy0c=;
        b=C/PK8LG8OA1mBCJcGe+oqogPb7wiQ/18qi/vjIJbYf+IBqBNg5xgc0qQiUogdW8ff/
         kR5Kf5qiljlZaQ9j3tlArXvkFbW2kTX6aqE8ujZEniSpCDUnPvNAWvYNqfcEKfdz5TAd
         XDfKg80BChoInMYQPOmKfnbq1lN0bQb88NqTRyfiPo7IfXx2gVJcUHl7nMAABMVM4REs
         M8392umrgh26bFR/F7rz87oGsJFO56fGUUPU6w4dxUmDi6au1W53snjY2nm5P+hxm+kj
         pXNZ99/N1OSgQ+hlvOnxslwVN96PLinEwlw4s830wBbltHyWd+LfTMUrgYBHo7F/FffC
         pD1Q==
X-Gm-Message-State: APjAAAVmXiYHqVnlEuC/jE6bQ3ka3DH5GON8eXC533Zv0lmkEEBAVZTZ
        CSRcqxST2nSbNzgJub3OMyu/1qBWMSw=
X-Google-Smtp-Source: APXvYqxTE0Rn2UwMp44134rpXTASR6Cvf0Sg6vY7I7u7WWoOKj4SiqvdhsmVPO5tq6DDT1pI05oumw==
X-Received: by 2002:a2e:898d:: with SMTP id c13mr3733797lji.164.1567721676396;
        Thu, 05 Sep 2019 15:14:36 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id e62sm603892ljf.82.2019.09.05.15.14.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 15:14:36 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id l11so3327251lfk.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2019 15:14:35 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr3910741lfh.29.1567721338167;
 Thu, 05 Sep 2019 15:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
 <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com> <5396.1567719164@warthog.procyon.org.uk>
In-Reply-To: <5396.1567719164@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Sep 2019 15:08:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
Message-ID: <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     David Howells <dhowells@redhat.com>
Cc:     Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 5, 2019 at 2:32 PM David Howells <dhowells@redhat.com> wrote:
>
>  (1) /dev/watch_queue just implements locked-in-memory buffers.  It gets you
>      no events by simply opening it.

Cool. In-memory buffers.

But I know - we *have* one of those. There's already a system call for
it, and has been forever. One that we then extended to allow people to
change the buffer size, and do a lot of other things with.

It's called "pipe()". And you can give the writing side to other user
space processes too, in case you are running an older kernel that
didn't have some "event pipe support". It comes with resource
management, because people already use those things.

If you want to make a message protocol on top of it, it has cool
atomicity guarantees for any message size less than PIPE_BUF, but to
make things simple, maybe just say "fixed record sizes of 64 bytes" or
something like that for events.

Then you can use them from things like perl scripts, not just magical
C programs.

Why do we need a new kind of super-fancy high-speed thing for event reporting?

If you have *so* many events that pipe handling is a performance
issue, you have something seriously wrong going on.

So no. I'm not interested in a magical memory-mapped pipe that is
actually more limited than the real thing.

                  Linus
