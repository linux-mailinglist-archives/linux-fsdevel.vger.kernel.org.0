Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1971173F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 19:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLISTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 13:19:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39639 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLISTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:19:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so16750870ljj.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 10:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZMqRZp9+bilXh0HGL9oR0MxLWgnBMeIphYWvOmpL9Q=;
        b=Yz+/sjhUXKZEs+qhSFKklhR8o2h6HC5lgJKoaBnwRJo1Isv/EBY7iJV3WCU91qirAQ
         rRDf37sKOK/pgKTHy0SWhM3EOI126l1pcn5N4S1fNR+CVqdFzl9hLpVim3R+/okkvArl
         qPaSO1elURSaIoUN1kgalqzaKSAFOCIOmIgKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZMqRZp9+bilXh0HGL9oR0MxLWgnBMeIphYWvOmpL9Q=;
        b=kFqxlW7z5bJDs1bu04gAP35XWYjfhnDMUO5KgeVYF9BT95aixTZDkr/j97nKTc0NlQ
         v3vVQRc8/A+yor2eBVgr7lKoKF/O9r1HlKWGgdghhV4uz9B4n1CKbgZKHpV0Rf4B8ixn
         umNEV/RlmbHKAvdp/FyZL3BCxycgfHGU9DwJ+CNnjL7JKXt6wOIpPCwHyGcVQUUWnIkM
         4Bgo5DQLHqer14hGnzVwuJ696LKlL2UwPEFLd/TB2opslHTn8C321O7xwrYEMTiAhrAT
         oV9+/HJzuV9GZ4T9d1zDNJmhoyTseZIRr0SMCMchLV866kdm3xpXrEH5MElDweomZNg5
         Mwng==
X-Gm-Message-State: APjAAAUCMWjGUq8jEFuXWYa+7QMx08qSAXt/rK1GdX4AEyddfLxRJbGX
        lhOq2AlaTx3JqjdvGqedjPKBO/RMSTc=
X-Google-Smtp-Source: APXvYqy9NToThP+E3HyucnrFU7yA1EZAWCrWHaCbXLh5qMPlxU/TQzLCSHbGYlLLJO3eNTOa413cSg==
X-Received: by 2002:a2e:7005:: with SMTP id l5mr17976933ljc.230.1575915554744;
        Mon, 09 Dec 2019 10:19:14 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id p15sm87562lfo.88.2019.12.09.10.19.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:19:13 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id m6so16786620ljc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 10:19:13 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr15150725ljj.148.1575915553079;
 Mon, 09 Dec 2019 10:19:13 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com>
 <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com> <CABA31DqGSycoE2hxk92NZ8qb47DqTR0+UGMQN_or1zpoGCg9fw@mail.gmail.com>
In-Reply-To: <CABA31DqGSycoE2hxk92NZ8qb47DqTR0+UGMQN_or1zpoGCg9fw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Dec 2019 10:18:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnXUUbYikSFba5QqvJoFnO8c_ykXrw9Zz2Lt4SeyeZUQ@mail.gmail.com>
Message-ID: <CAHk-=wjnXUUbYikSFba5QqvJoFnO8c_ykXrw9Zz2Lt4SeyeZUQ@mail.gmail.com>
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

On Mon, Dec 9, 2019 at 9:57 AM Akemi Yagi <toracat@elrepo.org> wrote:
>
> In addition to the Fedora make-4.2.1-4.fc27 (1) mentioned by Linus,
> RHEL 8 make-4.2.1-9.el8 (2) is affected. The patch applied to Fedora
> make (3) has been confirmed to fix the issue in RHEL's make.
>
> Those are the only real-world examples I know of. I have no idea how
> widespread this thing is...

Looks like opensuse and ubuntu are also on 4.2.1 according to

   https://software.opensuse.org/package/make
   https://packages.ubuntu.com/cosmic/make

so apparently the bug is almost universal with the big three sharing
this buggy version.

               Linus
