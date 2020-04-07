Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5FF1A1338
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 19:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgDGR70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 13:59:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39058 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgDGR7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:59:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id m2so3098855lfo.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdWHnkyUOuIQT5df0SRBbcUjsw9tkuNDCfUJgegsx2Y=;
        b=GuMJrA5+OPCrFlqiWIQXdF0sRv1DXcntWrvutmyZqOFRpLpgvLws+UiZLwJA7kK6Sd
         +vwfQHhWYtc8mTZoTJRh3SqPJYbGEQlYNQpReplC+lHRTbAsoBc7dLrK+rxls3EDRoOA
         QbPRBs61u/GOBlZBjbijLCzyGt3+UWROpo2Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdWHnkyUOuIQT5df0SRBbcUjsw9tkuNDCfUJgegsx2Y=;
        b=Uut9tBWIwvtoqsO44gTIesCtKTBYioPwI52cGaHqhPQJzhwoXY2qyYL0IIm0v5IKOz
         +aK7EmdQeNrMF0zy2x6XJ1MyqA4Ne/iY6Hn9XfNrpyYhWZBNgNHJb2stdGfHF4zvGy3h
         t6JoEu6iZVCRVL6gE8oOyu5Bf7Qyf9rywxs3k6kAF29Y1DyOCqSFgOpdBcobEWEehhF2
         RQcvP/3aDAHNUYPdMFe0j6czxsI3qlEFGCbN6PY3D3AOopDoPiQab/Iqs1bN+5jqp+VL
         weFzPTH+ghuwnXG5O21Tr8w70pNy618U/+B3JTvlrU1yipuJUDu4Grmx2/7+HcwzAAxX
         nWEg==
X-Gm-Message-State: AGi0Puad7uEb1U9yIpfAc76sQt1yF0CSHPwDUHrb+WiwzqVy6Ayb+LEh
        oGTBamsZktNO/sRtE8PzW3GxGTr3Hic=
X-Google-Smtp-Source: APiQypI+3cMgwBwqDKujnVITIaAeeIwfaJksJYpA94FF7KYwihoNmhCFHcsQLgZx0GIqUbCtY/QoZA==
X-Received: by 2002:a19:f51a:: with SMTP id j26mr2231772lfb.54.1586282361357;
        Tue, 07 Apr 2020 10:59:21 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v21sm14878854lji.81.2020.04.07.10.59.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 10:59:20 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id m19so1077836lfq.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 10:59:20 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr2247587lfk.30.1586282359598;
 Tue, 07 Apr 2020 10:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200406110702.GA13469@nautica> <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica> <20200407021626.cd3wwbg7ayiwt4ry@l29ah-x201.l29ah-x201>
In-Reply-To: <20200407021626.cd3wwbg7ayiwt4ry@l29ah-x201.l29ah-x201>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 10:59:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE6_L2NnSo82erMHxbP8fa=f_b64G+Muu0JnUEBgDwOg@mail.gmail.com>
Message-ID: <CAHk-=wiE6_L2NnSo82erMHxbP8fa=f_b64G+Muu0JnUEBgDwOg@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.7
To:     L29Ah <l29ah@cock.li>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 6, 2020 at 7:16 PM L29Ah <l29ah@cock.li> wrote:
>
> In fact i would prefer disabling the full reads unconditionally, but AFAIR some userspace programs might interpret a short read as EOF (and also would need to check the logic that motivated the kernel-side looping).

Oh, it's even worse than "might interpret a short read as EOF".

Lots of ad-hoc small tools will basically do something like

     fd = open(name, O_RDONLY);
     fstat(fd, &st);
     buf = malloc(st.st_size);
     read(fd, buf, st.st_size);

and be done with it. Obviously they may have some error handling (ie
imagine the above being written with proper tests for buf beign NULL
and 'fstat()' returning an error), but if they check the return value
of "read()" at all, it might be just to verify that it matches
st.st_size.

I've written stuff like that myself.

Sure, the "real" programs I write would have loops with EAGAIN and
partial reads, and maybe I'd have a helper function called "xread()"
that does that.  And most major applications will do things like that,
exactly because they've seen years of development, they're trying to
be portable, and they might even have hit other network filesystems
that do partial reads or return EAGAIN - or they might have more
complex functionality anyway which allows you to pipe things in from a
buffer etc.

But the above kind of "assume read() gets the whole thing" is not
unusual for quick hacks.

After all, it's a _valid_ assumption for a proper POSIX filesystem,
although it obviously _also_ assumes that nobody else is writing to
that file at the same time.

And some of those quick hacks may end up existing for years in major
code-bases, who knows..

[ Honesty in advertising: the Linux VFS layer itself says "screw
POSIX" for some things.

  Particularly, if somebody tries to do a read larger than 2GB in
size, the VFS layer will just say "POSIX is garbage in this situation,
we _will_ truncate this read".

  So if you deal with huge files, you _have_ to do the proper "loop
until EOF" even for regular files, and POSIX be damned.

  The kernel refuses to do crazy things, and no amount of standard
paperwork matters. ]

But basically honoring full reads for any _reasonable_ situation is
pretty much required for a lot of reasons. Yes, lots of apps will deal
gracefully with partial reads - maybe even most. But "lots" is not
"all".

             Linus
