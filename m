Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC5C11DD77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 06:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLMFMQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 00:12:16 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40574 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfLMFMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:12:16 -0500
Received: by mail-yw1-f67.google.com with SMTP id i126so782280ywe.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 21:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAcSQtV+tkPGalwjYXUgNlCrTP5A84YpJWuLFMfu9lg=;
        b=kSU/yclGEo7wWgM4JH6g7hAU9MIY7NKKJWBZHHRWuDjikajqsHkPU7rKw8AnQ8uuaO
         L5U0HFTXIRfAQVVb/ATS8ua6lsgWM/VCIp6y9Si1Rhx9DGmxmwWHeoA2YaKQ3LRmggxF
         2stXO2MKVy5LNc+en6AA/1xO+dn8lLLUfJxfF74md0NTvQK2AzFKzLvfEYuNW+L2EtEU
         T7eD25wdaaFKkObfpNgfeIeSiyZNCWc9COwgzO53mLJZ7nzXLsXYbRbfWLLEBA/2+buL
         g0r6Aeg+q2Gg/OHJTl7zVWEQOoH6u6gPYSoJh+bCPG+LYRm7zGKJFjHGB5iTbQAXmEDE
         T4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAcSQtV+tkPGalwjYXUgNlCrTP5A84YpJWuLFMfu9lg=;
        b=UjvAQVdSXSW01DH8oU4H0nGltf14m9O/5aJq1IOZj8AfxpbJtIEzgkM/FQ0P71o7lZ
         6BOKawzyJb+SdTAfHgkaKw7dJMLRCTrAKhIdb7AGK3VDEa4C7InjPYNvD2ygjlAhHs2N
         AYdWJoKC6KRhAXeEJaCcVf1oWkhWkZ2TuVAz6UFPFWW+cS0hEcJLeeKdQmgpN6pJkrr9
         YtQ6HakFzy2HY9mEkv7dK1CUBYIARg7eeHoEl9+WF/39/7tfnMqPbTKIQNm9FMoEYGt5
         d7VpxYQ0ng/1CSTAJ08x1M3ADGSF6kk/3tNnu6uoyJCFxPt9XRy8lXAiUYTGgtPstcZ0
         rZuA==
X-Gm-Message-State: APjAAAXA0AKxr95xKFs+o6Wrh077RZ0jaCEFtShsXQguMrZKn46b5O7r
        BS7hd8sNoex8o4sWeZo31n2b9+yxNzxm1eMLND1kWKsR
X-Google-Smtp-Source: APXvYqysAc+J2VCDGtr85kUGVym/J+Inya+5kSpd1wEPCYRjwokqul8FkXioYn0iPIQzJugNO8rOxd+OE1remmqvg34=
X-Received: by 2002:a0d:e88b:: with SMTP id r133mr601590ywe.379.1576213934707;
 Thu, 12 Dec 2019 21:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20191213014742.GA250928@mit.edu>
In-Reply-To: <20191213014742.GA250928@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Dec 2019 07:12:03 +0200
Message-ID: <CAOQ4uxhxx4EdaAsSPOztbx+0gfhixSi4fhBrhtDji1Dn4hgrow@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] automating file system benchmarks
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 3:47 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> I'd like to have a discussion at LSF/MM about making it easier and
> more accessible for file system developers to run benchmarks as part
> of their development processes.
>
> My interest in this was sparked a few weeks ago, when there was a
> click-bait article published on Phoronix, "The Disappointing Direction
> Of Linux Performance From 4.16 To 5.4 Kernels"[1], wherein the author
> published results which seem to indicate a radical decrease in
> performance in a pre-5.4 kernel, which showed the 5.4(-ish) kernel
> performance four times worse on a SQLite test.
>
> [1] https://www.phoronix.com/scan.php?page=article&item=linux-416-54&num=1
>
> I tried to reproduce this, and trying to replicate the exact
> benchmark, I decided to try using the Phoronix Test Suite (PTS).
> Somewhat to my surprise, it was well documented[2], straightforward to
> set up, and a lot of care was put into being able to get repeatable
> results from running a large set of benchmarks.  And so I added
> support[3] for running to my gce-xfstests test automation framework.
>

Very nice :)
You should post an [ANNOUNCE] every now and then.
I rarely check upstream of xfstests-bld, because it just-works ;-)

> [2] https://www.phoronix-test-suite.com/documentation/phoronix-test-suite.html
> [3] https://github.com/tytso/xfstests-bld/commit/b8236c94caf0686b1cfacb1348b5a46fa1f52f48
>
> Fortunately, using a controlled set kernel configs it I could find no
> evidence of a massive performance regression a few days before 5.4 was
> released by Linus.  These results were reproduced by Jan Kara using mmtests.
>
> Josef Bacik added a fio benchmark to xfstests in late 2017[4], and
> this was discussed at the 2018 LSF/MM.  Unfortunately, there doesn't
> seem to have been any additional work to add benchmarking
> functionality to xfstests.
>
> [4] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=e0d95552fdb2948c63b29af4a8169a2027f84a1d
>
> In addition to using xfstests, I have started using PTS to as a way to
> sanity check patch submissions to ext4.  I've also started

I suppose you have access to a dedicated metal in the cloud for running
your performance regression tests? Or at least a dedicated metal per execution.
I have not looked into GCE, so don't know how easy it is and how expensive
to use GCE this way.
Is there any chance of Google donating this sort of resource for a performance
regression test bot?

> investigating using mmtests as well; mmtests isn't quite as polished
> and well documented, but has better support for running running
> monitoring scripts (e.g., iostat, perf, systemtap, etc.) in parallel
> with running benchmarks as workloads.
>
> I'd like to share what I've learned, and also hopefully learn what
> other file system developers have been using to automate measuring
> file system performance as a part of their development workflow,
> especially if it has been packaged up so other people can more easily
> replicate their findings.
>

Trying to say this carefully, hopefully without starting a mud tossing war -
It is sometimes useful to compare performance benchmark on different
filesystems on the same benchmark/hardware. Not in order to prove that
this filesystem is "better" than the other (we are all for diversity),
but because
it can sometimes point our attention to core issues.

This simple question [1] I posted about a huge difference in fio randomrw
benchmark on xfs vs. ext4 has led to patches being posted to address issues
in both xfs and ext4 [2][3][4] and to discover bugs in other
filesystems as well.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-xfs/CAOQ4uxi0pGczXBX7GRAFs88Uw0n1ERJZno3JSeZR71S1dXg+2w@mail.gmail.com/
[2] https://lore.kernel.org/linux-xfs/20190404165737.30889-1-amir73il@gmail.com/
[3] https://lore.kernel.org/linux-xfs/20190829131034.10563-1-jack@suse.cz/
[4] https://lore.kernel.org/linux-ext4/20190603132155.20600-1-jack@suse.cz/
