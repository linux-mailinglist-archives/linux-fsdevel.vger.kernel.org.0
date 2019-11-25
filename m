Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B68E8109299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfKYRFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 12:05:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38959 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbfKYRFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:05:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id e10so7611501ljj.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IP1wfK3f8gL3K5of14NSdEE7VLJRLmDh9Mjfd6jLIUg=;
        b=di9eo39CEUbDhJQGDGRbvoBzSIsf4IsJ2vpQB30wyKTQ4oZuoI8I8FAMQktMgORFFP
         8fBVLWpCUhdrhl0hj+dykFizgaSzPbdXAW3q2epeOP6k+UZ1g4c/aPYroPhY+MX/X+vS
         wBXrAbq1U0ohLCJc7HXm2ySYQ4bv4evW0kCik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IP1wfK3f8gL3K5of14NSdEE7VLJRLmDh9Mjfd6jLIUg=;
        b=hpgzTbXHWrMIcNZB3x1BiZJvYLyWbRAc3OOwO7noHBeml4ldYITa1u1FAi8a1RQ9is
         VF70BcPAiDaSuHK/CiYWzXKs3626Hp3kXE3C0UIlD+FRXwcuj+lASKzoDNuIhdyqc65/
         zzLP0OzurcgWU/MdhEjRbdX4l26AhW3r10DaH+zNstPRms2f5L2K1Jh4HJKLmsHw2OoW
         9egpRaeOlvb8uFU1ZeVDN1yCUZwnZuwXurwvieQ3KBfEp4bgzmpaEfaXimjQ/r1/N7Pi
         sLX7TFe3Y3YqNRUrXgEJrGwOYwe/obWFoPiXrgCUwCjvwDfJxEVJ5BDNy/6W//bTODWv
         Wc3Q==
X-Gm-Message-State: APjAAAW8mvGc65kpgh5zxbbqsRpax8t1k3yl6rFgUqG+0ePEZ0N2hdxb
        dbizH701KjFFgsc+WOzIh1yrS9wTSEc=
X-Google-Smtp-Source: APXvYqzzBpLvlVJncw7UaaOyYqSfzreVk9bQ/z6V3ph6ak89XUna4eWVwLQFHt5irAQ/Trf5zIqaRA==
X-Received: by 2002:a05:651c:1059:: with SMTP id x25mr23696128ljm.255.1574701552468;
        Mon, 25 Nov 2019 09:05:52 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f14sm4234369ljn.105.2019.11.25.09.05.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 09:05:47 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id r15so8694534lff.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 09:05:46 -0800 (PST)
X-Received: by 2002:ac2:5a08:: with SMTP id q8mr21390671lfn.106.1574701545622;
 Mon, 25 Nov 2019 09:05:45 -0800 (PST)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
 <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com> <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
 <640bbe51-706b-8d9f-4abc-5f184de6a701@redhat.com> <CAHpGcM+o2OwXdrj+A2_OqRg6YokfauFNiBJF-BQp0dJFvq_BrQ@mail.gmail.com>
 <22f04f02-86e4-b379-81c8-08c002a648f0@redhat.com>
In-Reply-To: <22f04f02-86e4-b379-81c8-08c002a648f0@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Nov 2019 09:05:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRuPkm7zFUiGe_BXkLvEdShZGngkb=uRufgU65ogCxfg@mail.gmail.com>
Message-ID: <CAHk-=whRuPkm7zFUiGe_BXkLvEdShZGngkb=uRufgU65ogCxfg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 2:53 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> Linus, is that roughly what you were thinking of?

So the concept looks ok, but I don't really like the new flags as they
seem to be gfs2-specific rather than generic.

That said, I don't _gate_ them either, since they aren't in any
critical code sequence, and it's not like they do anything really odd.

I still think the whole gfs2 approach is broken. You're magically ok
with using stale data from the cache just because it's cached, even if
another client might have truncated the file or something.

So you're ok with saying "the file used to be X bytes in size, so
we'll just give you this data because we trust that the X is correct".

But you're not ok to say "oh, the file used to be X bytes in size, but
we don't want to give you a short read because it might not be correct
any more".

See the disconnect? You trust the size in one situation, but not in another one.

I also don't really see that you *need* the new flag at all. Since
you're doing to do a speculative read and then a real read anyway, and
since the only thing that you seem to care about is the file size
(because the *data* you will trust if it is cached), then why don't
you just use the *existing* generic read, and *IFF* you get a
truncated return value, then you go and double-check that the file
hasn't changed in size?

See what I'm saying? I think gfs2 is being very inconsistent in when
it trusts the file size, and I don't see that you even need the new
behavior that patch gives, because you might as well just use the
existing code (just move the i_size check earlier, and then teach gfs2
to double-check the "I didn't get as much as I expected" case).

                 Linus
