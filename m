Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FA242F99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHLTuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgHLTut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:50:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B744C061384
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 12:50:49 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b11so1792441lfe.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0LPNTEWbU2mq6BgRpzsioeNr4RPYOF2TnDOgMD6NIs=;
        b=U1hdSpOUSLOjOrO72XqzG+q96d1pIF0cv/aZqt7kBp+fkvgL9591I+FRTAk0LrnIxR
         8JT4UZPZRO/zc5YAudhwHewQ4vDe1rgRhtOdIJf44K3wQIjkVGrwuKfqWiz5aOBB7xzw
         NmuJO1e6+UoXEurWxTmy0lrzQtpRHAgwv0Dgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0LPNTEWbU2mq6BgRpzsioeNr4RPYOF2TnDOgMD6NIs=;
        b=jLZiFUvjqMbsuEp6XJbxeWArfAX0zIGKugOd91S+99J1/OOlCsHxx5txzPCSx40ASB
         4+8B2zcfMkRJ6ltNXbrB05IKcbAnRZ1mmq4SwDmpiVdk+QZnMeehSLmjzK9r7oF6ySnD
         OCKmxDlTSLPvnIjcm2v1eTVXMKMwL8l1tNmA6e3jEQf8FGTBm1zDEOYBGpHzpu6BxRlH
         NdbO8rpuxuAhkGV7BZ08C46Nq84O+B0P28jNVwka6IUsNdOEaxG7ob3Kh2zj0AIiSarH
         Qwyyhs3742Ez6Qw+qrVMeuyB/27tTw2Wv+mpoWySrFZqn5d8fRDRlum3rKqPaqK8GDAr
         J0pw==
X-Gm-Message-State: AOAM532rnOPwzUywrOJly+1yaXkbboT4XMK1eZviViJ6HvUV3K6hBAiJ
        +P0MoYU+uAPDXXTmpVsqNB4bMUeHIgk=
X-Google-Smtp-Source: ABdhPJy3efwaV7LA49Za/X6p0DbR5Fl8cs0xROR1feXqB+uhNaIEMs67++ZFaUUYypjzMWEMB5aNpg==
X-Received: by 2002:a19:8957:: with SMTP id l84mr471584lfd.66.1597261847287;
        Wed, 12 Aug 2020 12:50:47 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id t16sm650321ljo.27.2020.08.12.12.50.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 12:50:46 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id j22so1816750lfm.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 12:50:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr500353lfp.10.1597261845653;
 Wed, 12 Aug 2020 12:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
In-Reply-To: <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 12:50:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Message-ID: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:34 PM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> The point of this is to give us the ability to monitor mounts from
> userspace.

We haven't had that before, I don't see why it's suddenly such a big deal.

The notification side I understand. Polling /proc files is not the answer.

But the whole "let's design this crazy subsystem for it" seems way
overkill. I don't see anybody caring that deeply.

It really smells like "do it because we can, not because we must".

Who the hell cares about monitoring mounts at a kHz frequencies? If
this is for MIS use, you want a nice GUI and not wasting CPU time
polling.

I'm starting to ignore the pull requests from David Howells, because
by now they have had the same pattern for a couple of years now:
esoteric new interfaces that seem overdesigned for corner-cases that
I'm not seeing people clamoring for.

I need (a) proof this is actualyl something real users care about and
(b) way more open discussion and implementation from multiple parties.

Because right now it looks like a small in-cabal of a couple of people
who have wild ideas but I'm not seeing the wider use of it.

Convince me otherwise. AGAIN. This is the exact same issue I had with
the notification queues that I really wanted actual use-cases for, and
feedback from actual outside users.

I really think this is engineering for its own sake, rather than
responding to actual user concerns.

               Linus
