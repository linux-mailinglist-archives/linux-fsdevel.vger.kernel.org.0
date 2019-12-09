Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2511E117340
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 18:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLIR5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 12:57:19 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:32976 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIR5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:57:18 -0500
Received: by mail-yb1-f193.google.com with SMTP id o63so6480785ybc.0;
        Mon, 09 Dec 2019 09:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qei/AYQXNst4gEgpnVYA7NFVSVcsDop3iCvV2R7BSTI=;
        b=P1IBwsVG1cGn0KRwtBdlP3FE3DN2EeipMvaoqqKHAet50Iw67U1scaq6LSIRaWKvP+
         ygNvJNgjxAt/ShEVFQR8sw6h2ndKba+pN0ImbQAIJ6c7oGl8zcC3HUbr+MGczk20QGSc
         Te8aYt+Q8vnExT6yJn3VqclBTk0jwOcFANGgX6zs3y3O/WuXOe6ecy3E73uv0m6jw9yZ
         eYY7HOS5UF7+ZtTfMUo2uWSiYouXuX3bT8jJ5w7EWkcMyRauTr3ZNVwmlAtl58VY56Un
         MxfxyrQU1CCaGofz24MkVyO73u04Sk/hjpWM5/2U6KW+ZgW7DPP45m6jZwbeqgL1zvzx
         fhgQ==
X-Gm-Message-State: APjAAAX/NN+9+p1X7c8PSZnpyyanv50BZNL5PJnc3KeOeozWIrK2gstV
        NpGjCwJpMmf8poC2h2/+MUW36fHMJVgsJnz3HOE=
X-Google-Smtp-Source: APXvYqz4DjmgUMCLAs/3U0LVrQER9vKVWUuTTZiInvynh57cPM6y1wIzI/89XHRRaXx6krX4w4Mo8IH1dWtwVlg6oGE=
X-Received: by 2002:a25:5f4d:: with SMTP id h13mr21799718ybm.390.1575914237631;
 Mon, 09 Dec 2019 09:57:17 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com> <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
In-Reply-To: <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
From:   Akemi Yagi <toracat@elrepo.org>
Date:   Mon, 9 Dec 2019 09:57:06 -0800
Message-ID: <CABA31DqGSycoE2hxk92NZ8qb47DqTR0+UGMQN_or1zpoGCg9fw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Mon, Dec 9, 2019 at 9:49 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Added DJ to the participants, since he seems to be the Fedora make
> maintainer - DJ, any chance that this absolutely horrid 'make' buf can
> be fixed in older versions too, not just rawhide? The bugfix is two
> and a half years old by now, and the bug looks real and very serious ]
(snip)
> But sadly, there's no way I can push that fair pipe wakeup thing as
> long as this horribly buggy version of make is widespread.
>
>                  Linus

In addition to the Fedora make-4.2.1-4.fc27 (1) mentioned by Linus,
RHEL 8 make-4.2.1-9.el8 (2) is affected. The patch applied to Fedora
make (3) has been confirmed to fix the issue in RHEL's make.

Those are the only real-world examples I know of. I have no idea how
widespread this thing is...

Akemi

(1) https://bugzilla.redhat.com/show_bug.cgi?id=1556839
(2) https://bugzilla.redhat.com/show_bug.cgi?id=1774790
(3) https://git.savannah.gnu.org/cgit/make.git/commit/?id=b552b05251980f693c729e251f93f5225b400714
