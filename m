Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3877112F1FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 01:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgACAIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 19:08:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33596 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgACAIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 19:08:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so34312967lji.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2020 16:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXQQH9TITRlriLDkmnMSZfR2BNB1iw10HsF91le2H5M=;
        b=NQ/D9k51K2Q5WjCrOcvwHMQ6Bkynk3X0IxmvWi1leEorgHVHUExOWHrJt0/8tKG5YT
         p+ycspJpzQnogk3WSvbVxbCKtQqutbkohf/T8FeHpGiW8lXcerHNgQXBanB/ZyM4j+hr
         9pJrx4bqh2BRKEW+Km3eRUdDwJRWz3k0UIwkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXQQH9TITRlriLDkmnMSZfR2BNB1iw10HsF91le2H5M=;
        b=rz2JfBdwnf6sebmmQlunLBD/Xr3RXFN/HxwJJY2pZj7pCDwnQrkFM61+168NNKwS6A
         rxtmBFxPOA5B/MvsEdnCMi6WgCu0r1xHACcEpY309WKEl5xItCYZxDngrrlku/ZcXcOB
         4EqVE9B57AafgMKi6McsP55Mfj3RBBHdNUn+sJ+p2wfRcV3rDxqhr0NsDh/OgupeGAON
         uKR/SN3i5H18UeqXxCpvGUY7pw+gGWxJTTfkEwQoDkwy9uV9yYWggUi+dbYiFehR6xc9
         vwYy5owddM/m1f4nvXt5jv70qEe/v3RxXxj27hmuBru7LMBYdwtE62P72mLWuNku83uM
         D+uQ==
X-Gm-Message-State: APjAAAVRYRV7OeobUEz7JWdoXl5ri9wvN0/2J1emrLeTYCjoW/kamoce
        fLQDJexEnbVFH8Jvwi5rUAjt3Y6oKbU=
X-Google-Smtp-Source: APXvYqy9NEzlZ2qP2K/s17sp5K/kAA+AUO8eVMNoFzEmKK7vwZMudj86KspeOndHH6OrGOBUTJ0JHw==
X-Received: by 2002:a2e:974b:: with SMTP id f11mr50380700ljj.173.1578010108102;
        Thu, 02 Jan 2020 16:08:28 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id a15sm24051691lfi.60.2020.01.02.16.08.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 16:08:26 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id j1so34944765lja.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2020 16:08:26 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr50911509ljn.48.1578010105946;
 Thu, 02 Jan 2020 16:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20191224020615.134668-1-damien.lemoal@wdc.com>
 <20191224020615.134668-2-damien.lemoal@wdc.com> <20191224044001.GA2982727@magnolia>
 <BYAPR04MB5816B3322FD95BD987A982C1E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB58167AD3E7519632746CDE72E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB58160982BF645C23505BA085E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20200102213612.GD1508633@magnolia>
In-Reply-To: <20200102213612.GD1508633@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jan 2020 16:08:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaTKptXbcP9OXaj9KRzuU5pd+aiTEEzy+Q88mMKMrK2A@mail.gmail.com>
Message-ID: <CAHk-=wiaTKptXbcP9OXaj9KRzuU5pd+aiTEEzy+Q88mMKMrK2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: New zonefs file system
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 2, 2020 at 1:36 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> /me shrugs, I guess we're not supposed to use S_* in code.  Sorry about
> the unnecessary churn. :/

The S_* constants are useful for things like file types etc - so you
very much _are_ supposed to use them for things like

    switch (mode & S_IFMT) {
    case S_IFREG: ...

etc.

But no, the permission _names_ are complete and utter garbage. Whoever
came up with them was just being silly and they are not to ever be
used. Yes, POSIX specifies them, and yes, if you are outside of Unix
environments maybe they can have some relevance, but in a Unixy
environment, the octal codes are a *lot* more legible.

So if you want "owner read-write, group/world read", you use 0644.
That can actually be parsed. And 0777 matches that pattern, unlike the
insane jumble of letters that is "S_IRWXUGO".

Seriously, anybody who thinks "S_IRWXUGO" is easier to read than 0777
is just wrong. It's just shorthand for S_IRWXU|S_IRWXG|S_IRWXO, which
is _also_ a complete and utter mess and insane.

Just say no to the permission names. They don't even cover all the
cases anyway (unless you start or'ing in the individual bits and make
them even less regible), and by the time you parse all the random
letters (and know enough to parse them right), you inevitably find the
octal representation a lot easier to parse anyway.

And if you don't know how the unix permission bits work, then neither
the symbolic names _nor_ the numbers make any sense, so just give up.

So use the octal numbers for the three groups of three bits - aka the
low 9 bits aka the "UGO" bits, and use the symbolic names for the
other bits. Everybody will be much happier.

                   Linus
