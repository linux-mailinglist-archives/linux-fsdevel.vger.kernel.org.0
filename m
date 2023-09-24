Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD697AC726
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjIXIeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 04:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXIeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 04:34:46 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43F1EE;
        Sun, 24 Sep 2023 01:34:39 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7740729ae12so301638385a.1;
        Sun, 24 Sep 2023 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695544479; x=1696149279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gna2reU7RFoFiox5XzjS7B8W5YuzttqF7wlldDBsONA=;
        b=i22mThoYkQSU1Tjk5syLU9ITbuhKQ6PPCzuEY5ajtvf0BN6BqYHCYD35a6dHQgFQu5
         sD+Ry/hEKHdpF05oiIUusAAFG4+dggK22yspeB2wUvR2MQ5I2WEDzlgu2+d3a13kwUVY
         ieu7fhhw+9BBeHOujjSCUbEoYrn2ZVvLafYXaxonSIabCtmvFZd8ubK2rkphXAqP0eM/
         kuqp5KlPjJPxzDiTcrYa01+MlqGfWUW67oirIZ0HhzCsTQ08cTpf4Su1H2/e8e0KK1x2
         mBvJ82HgShmbqU0k11phsZlOqBPUb2xESmpMwndBgbkMQrqoxcVClqkxX/zshO7n9nK3
         0X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695544479; x=1696149279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gna2reU7RFoFiox5XzjS7B8W5YuzttqF7wlldDBsONA=;
        b=jJ6Og68fM0yfY3iHJsJm2KNxM0dQxA2Qc1Znvo2kh0yjgLYZKWNvlrGEhYNncHjIuC
         p4v0QtGo9XoRqDnk7MfxlnjS5AUxb/m//eaXgL0aJv7fGrfuYKN/7B7oMjaWrEEFu5HF
         5W15Rci/koqGvglaeRjNDJaXA8nfh4dBSCDVdPS2A6/KTjeK34OcYx7eBxvUbEMOM/KN
         YI4nMzPaf5PdC4SvC5SuevW9XsgPu61mMz/SDf+EhPlC2Ke0JR7QkpBDT8+16kOIS28i
         cW0YFQwh3tBpowDZaHsY3vTvGr1Q4Md36lmEV8eZiGJi4k+7O4sW6iAHrID7LtlaodoJ
         tONQ==
X-Gm-Message-State: AOJu0YyLCuXmIDGr9ud6A0zGQ03KW7B7QwuIy4dOSHVz6jWQKKgTXn2u
        c78F1RKl4t4fZ2WxnAPXCKUYAscEdXEhuL2VXLEd1eli9yw=
X-Google-Smtp-Source: AGHT+IHJRCiRok3zs9e47KJhpE4yv0RKpsC2BbmyKQ7XPE4rrPa08guJ1txwjT2zZNM/BwHM5NFJ+eGuubNBzypkC3I=
X-Received: by 2002:a05:620a:4593:b0:76a:eee2:cd09 with SMTP id
 bp19-20020a05620a459300b0076aeee2cd09mr5165182qkb.9.1695544478919; Sun, 24
 Sep 2023 01:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com> <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
In-Reply-To: <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 24 Sep 2023 11:34:27 +0300
Message-ID: <CAOQ4uxi=377CcOLf4ySoZWVMRkGPdnxhL-Vw4OM28mz_xeK97w@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 10:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Thu, 2023-09-21 at 11:24 -0700, Linus Torvalds wrote:
> > On Thu, 21 Sept 2023 at 04:21, Christian Brauner <brauner@kernel.org> w=
rote:
> > >
> > >   git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-=
rc3.vfs.ctime.revert
> >
> > So for some reason pr-tracker-bot doesn't seem to have reacted to this
> > pull request, but it's in my tree now.
> >
> > I *do* have one reaction to all of this: now that you have made
> > "i_ctime" be something that cannot be accessed directly (and renamed
> > it to "__i_ctime"), would you mind horribly going all the way, and do
> > the same for i_atime and i_mtime too?
> >
> > The reason I ask is that I *really* despise "struct timespec64" as a ty=
pe.
> >
> > I despise it inherently, but I despise it even more when you really
> > use it as another type entirely, and are hiding bits in there.
> >
> > I despise it because "tv_sec" obviously needs to be 64-bit, but then
> > "tv_nsec" is this horrible abomination. It's defined as "long", which
> > is all kinds of crazy. It's bogus and historical.
> >
> > And it's wasteful.
> >
> > Now, in the case of i_ctime, you took advantage of that waste by using
> > one (of the potentially 2..34!) unused bits for that
> > "fine-granularity" flag.
> >
> > But even when you do that, there's up to 33 other bits just lying
> > around, wasting space in a very central data structure.
> >
> > So it would actually be much better to explode the 'struct timespec64'
> > into explicit 64-bit seconds field, and an explicit 32-bit field with
> > two bits reserved. And not even next to each other, because they don't
> > pack well in general.
> >
> > So instead of
> >
> >         struct timespec64       i_atime;
> >         struct timespec64       i_mtime;
> >         struct timespec64       __i_ctime;
> >
> > where that last one needs accessors to access, just make them *all*
> > have helper accessors, and make it be
> >
> >         u64  i_atime_sec;
> >         u64  i_mtime_sec;
> >         u64  i_ctime_sec;
> >         u32  i_atime_nsec;
> >         u32  i_mtime_nsec;
> >         u32  i_ctime_nsec;
> >
> > and now that 'struct inode' should shrink by 12 bytes.
> >
>
> I like it.
>
> > Then do this:
> >
> >   #define inode_time(x) \
> >        (struct timespec64) { x##_sec, x##_nsec }
> >
> > and you can now create a timespec64 by just doing
> >
> >     inode_time(inode->i_atime)
> >
> > or something like that (to help create those accessor functions).
> >
> > Now, I agree that 12 bytes in the disaster that is 'struct inode' is
> > likely a drop in the ocean. We have tons of big things in there (ie
> > several list_heads, a whole 'struct address_space' etc etc), so it's
> > only twelve bytes out of hundreds.
> >
> > But dammit, that 'timespec64' really is ugly, and now that you're
> > hiding bits in it and it's no longer *really* a 'timespec64', I feel
> > like it would be better to do it right, and not mis-use a type that
> > has other semantics, and has other problems.
> >
>
>
> We have many, many inodes though, and 12 bytes per adds up!
>
> I'm on board with the idea, but...that's likely to be as big a patch
> series as the ctime overhaul was. In fact, it'll touch a lot of the same
> code. I can take a stab at that in the near future though.
>
> Since we're on the subject...another thing that bothers me with all of
> the timestamp handling is that we don't currently try to mitigate "torn
> reads" across the two different words. It seems like you could fetch a
> tv_sec value and then get a tv_nsec value that represents an entirely
> different timestamp if there are stores between them.
>
> Should we be concerned about this? I suppose we could do something with
> a seqlock, though I'd really want to avoid locking on the write side.

As luck would have it, if my calculations are correct, on x86-64 and with
CONFIG_FS_POSIX_ACL=3Dy, CONFIG_SECURITY=3Dy (as they are on
distro kernels), __i_ctime is exactly on split cache lines and maybe even
worse (?), __i_ctime.tv_nsec and the QUERIED bit are on the same
cache line with i_lock :-/

If we reorder the inode timestamps with i_size, we improve the situation
for this specific and very common configuration. Maybe.

Thanks,
Amir.
