Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1946A9061
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 05:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCCE6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 23:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCCE6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 23:58:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B2D16AD8;
        Thu,  2 Mar 2023 20:58:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so574443wmq.2;
        Thu, 02 Mar 2023 20:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677819519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okIuR+jOtAkcpAdugTMAKmbCdW30B6kTcaQvaFarjWQ=;
        b=hqaE33WONkk3VY1AiBsz/+tW0mVh0Zf3rPEXxaR803ZI85WvhovbVSyGSvSE4e8I0W
         Gl/4ZZfztCpxTUzLL03haCwxIaryRx/9jQmxTsRb+vf45xbynU7YfPyfai22VbjD90ab
         w0VjPDt7c+9OL7xLS8FdKGz5Z5kXY2NzVZ/DswsBa65s8+d8d1Y/3v+Yt7Dk8sAp/hfK
         5cEqLrNTbLwMlMq2Tv36RGsVKpaHjzUmPL2reEajEw55kixv0sR1VaUVqXQOmXVA1Boa
         nh/L4h7r+v1RkvdhaAlpSaGiONge8tdIuG5vUr54cUVe5RhlonwKvknInJYMLocT/WTR
         F97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677819519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okIuR+jOtAkcpAdugTMAKmbCdW30B6kTcaQvaFarjWQ=;
        b=k95jLu8pGWIEEl7AhkHqjNZfTzv6LdI6+LDMbadTHp9pDZVrlh2A+ywzceanrfneDZ
         U9uY6XkKYo6YrsRA5Z5EDKvss5X1xHZH4RzbXiFZgaGzNWlEFCeUKgJ2seUjrxOnekJu
         jJSDXB7wPhmcdr0tvh3gN29PfYBR9aXJD1v1thSBMM3yJ2Fr4ESswFdLPI7wZ1GcmkUm
         ABD2SC61+v/7GqpJfuLDgMb4hpBSZ1nC7y5yNdwEjWb4f//t7CkBlzO5zRuS9Gk9MS4O
         ZyQYkoLTnao8CXkG/tKad/K1s3gEaoif4RUb/T6uJrhJp3bpGG7IgEactNl9UKbD4DLA
         EH3g==
X-Gm-Message-State: AO0yUKXPSR1NHMa6QfTpfwWZp+ZtMcCttbwEX2DPSYN5TWc8fiuNvuE8
        OD6RKpevfZqBfhuLWEVg2GQ=
X-Google-Smtp-Source: AK7set/FcasRNTZEwaTRB4ujEgKdyB0dz4/JImcSAlr+A1XFXrJhbNM08El0ZSJqVfdWD/S9mIuJZg==
X-Received: by 2002:a1c:f714:0:b0:3dc:433a:e952 with SMTP id v20-20020a1cf714000000b003dc433ae952mr295807wmh.33.1677819519282;
        Thu, 02 Mar 2023 20:58:39 -0800 (PST)
Received: from suse.localnet (host-95-249-145-60.retail.telecomitalia.it. [95.249.145.60])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c15d200b003e20a6fd604sm1277270wmf.4.2023.03.02.20.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 20:58:38 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Fri, 03 Mar 2023 05:58:37 +0100
Message-ID: <3188909.AJdgDx1Vlc@suse>
In-Reply-To: <ZAD6n+mH/P8LDcOw@ZenIV>
References: <Y/gugbqq858QXJBY@ZenIV> <9074146.CDJkKcVGEf@suse> <ZAD6n+mH/P8LDcOw@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On gioved=EC 2 marzo 2023 20:35:59 CET Al Viro wrote:
> On Thu, Mar 02, 2023 at 12:31:46PM +0100, Fabio M. De Francesco wrote:
> > But... when yesterday Al showed his demo patchset I probably interprete=
d=20
his
> > reply the wrong way and thought that since he spent time for the demo he
> > wanted to put this to completion on his own.
> >=20
> > Now I see that you are interpreting his message as an invite to use the=
m=20
to
> > shorten the time...
> >=20
> > Furthermore I'm not sure about how I should credit him. Should I merely=
=20
add
> > a
> > "Suggested-by:" tag or more consistent "Co-authored-by: Al Viro <...>"?
> > Since
> > he did so much I'd rather the second but I need his permission.
>=20
> What, for sysv part?  It's already in mainline;

Yes, I know this. In fact this thread started with the pull request you sen=
t=20
to Linus on Feb 23. My patches to fs/sysv already credited you with the=20
"Suggested-by:" tag.

Sorry if I have not been clear about what I was talking about.

> for minix and ufs,

My series of patches for fs/ufs (again all with the "Suggested-by: Al Viro=
=20
<...>" tags - it's only missing in the cover letter) are at the following=20
address since Dec 29, 2022. I don't know why they haven't yet applied to th=
e=20
relevant tree:

https://lore.kernel.org/lkml/20221229225100.22141-1-fmdefrancesco@gmail.com/

As far as fs/minix is regarded I submitted nothing for it. I'm not sure abo=
ut=20
who wants to work on the patches for that filesystem.

> if you
> want to do those - whatever you want, I'd probably go for "modeled after
> sysv series in 6.2" - "Suggested-by" in those would suffice...

I know nothing about how fs/minix is designed and I don't yet know whether =
or=20
not I can easily model the patches to it after sysv and ufs series. I'll ta=
ke=20
a look in the next days. =20

> > @Al,
> >=20
> > Can I really proceed with *your* work? What should the better suited ta=
g=20
be
> > to credit you for the patches?
> >=20
> > If you can reply today or at least by Friday, I'll pick your demo=20
patchset,
> > put it to completion, make the patches and test them with (x)fstests on=
 a
> > QEMU/KVM x86_32 bit VM, with 6GB RAM, running an HIGHMEM64GB enabled=20
kernel.
>=20
> Frankly, ext2 patchset had been more along the lines of "here's what
> untangling the calling conventions in ext2 would probably look like" than
> anything else. If you are willing to test (and review) that sucker and it
> turns out to be OK, I'll be happy to slap your tested-by on those during
> rebase and feed them to Jan...

Sorry for the confusion about ext2. I think I have not been clear about my=
=20
intentions. Please let me summarize:

1) You sent the pull request for sysv. In that email to Linus you wrote=20
"Fabio's "switch to kmap_local_page()" patchset (originally after the
ext2 counterpart, with a lot of cleaning up done to it; as the matter of
fact, ext2 side is in need of similar cleanups - calling conventions there
are bloody awful).  Plus the equivalents of minix stuff..."

2) I replied by asking whether someone else were already working on ext2 as=
=20
you suggested above. I asked for that information because I thought I could=
 do=20
the work modeling after sysv and ufs.

3) You wrote about a "demo patchset" somewhere in one of your trees.

4) Jan replied that he likes your "demo patchset" (I haven't yet taken a lo=
ok=20
at those because I supposed they were modeled after the suggestions you=20
provided to me for sysv and ufs, so I thought I have no reasons to take a l=
ook=20
at them) and asked me to "pick your demo patches and put them to completion=
".

Now I'm confused about what you want to be done with your "demo patchset"=20
because I don't know what you mean by "demo" and why you showed you have th=
at=20
patchset.

I mean... do you want them only tested and reviewed? Any other task to be d=
one=20
on them?

Thanks,

=46abio


