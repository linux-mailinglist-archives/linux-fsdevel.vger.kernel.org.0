Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F86696C48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 19:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjBNSEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 13:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjBNSEj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:04:39 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCA5BBB6;
        Tue, 14 Feb 2023 10:04:29 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id v81so8391660vkv.5;
        Tue, 14 Feb 2023 10:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMkf7c8z7/sNRkzcNDwG4/QBxpk3rcjnBNtaol4M2NI=;
        b=akRLYn2Lt+j5KYsXonD7qbup/3PwO3moofYNPBFdWJkVw+5sAX6MrUuFQYDzf+PUtQ
         eOigIsKg1yLWJVJPHlhn3GTB49jK92WJGohpggbYjVVrBMJASp5A4YCSpaKCtfL+wI/h
         fmylS7WYz5GDurB8xcmbeBVZwgorB822MmzkHDaVynW9awqBsolKhtxUwARuwFXuqfzU
         nKtvGRe/xC9+Q0hu/RGEVbWUXzCYjnj5uGruY8dUBZxa+RZPEncqOO9jZ92nyeGiDgs2
         s7XOVJE8z+/PtoBXVcr/apdrA8lXC6ZwdZzoqqn1kgTp70EWoInTtO0C1pg1Tq52P7Ws
         lA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMkf7c8z7/sNRkzcNDwG4/QBxpk3rcjnBNtaol4M2NI=;
        b=nfQn2+JrEKqKQMmRLYcSP7745zOsaxgI6MJtaTPbqnzRdTUR9CV/db9YF7r9VR8EMt
         CRktLaH8QEcdCs1Kc/+cfwQgUR8NihGy4KvpuguAAFy+nXEdQ4X+thfoiNcTnWeRCcGQ
         GP1rXRljIQZMZ2MkF9iUbWGLCtFXX/CVk4lazujvoep+jd5ejfJX5uZ5Q2LXRKvRFomQ
         Ri6qLMg9okiyrBOa7C10bqCrS0AWx0UpXmPh2rGVXJiaQQseokQU24iwzuCpesjkt6OL
         mRennWnt7d/LsQvGfzveUTQooYeP8gsgBRT1fCRGCCBsNFhfuXYSqeomTSkVvHGlu6s2
         qzRQ==
X-Gm-Message-State: AO0yUKW0nDYgzGJQfWCvDycY21r5446XZbBLvdNUslo/Tgds5HMCMR75
        I6SmQ50WX0YeXQDQt+yYYiTHVpfmNwN1w060VwUBfl8H
X-Google-Smtp-Source: AK7set8E3Q1LiRcRuh+0KnT9RilvPri9nHdBF2Z0VeaMoKAPnrKE6kqUGgklozRykcihpkIg/7K/pocG/IuZZ3YSEgk=
X-Received: by 2002:a1f:a681:0:b0:3d5:9b32:7ba4 with SMTP id
 p123-20020a1fa681000000b003d59b327ba4mr482672vke.15.1676397868643; Tue, 14
 Feb 2023 10:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com> <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
 <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
 <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm> <CAOQ4uxiBD5NXLMXFev7vsCLU5-_o8-_H-XcoMY1aqhOwnADo9w@mail.gmail.com>
 <283b5344-3ef5-7799-e243-13c707388cd8@fastmail.fm> <CAOQ4uxjvUukDSBk977csO5cX=-1HiMHmyQxycbYQgrpLaanddw@mail.gmail.com>
 <CAJfpegvHKkCn0UnNRVxFXjjnkOuq0N4xLN4WzpqVX+56DqdjUw@mail.gmail.com>
 <81e010cc-b52b-4b20-8d08-631ce8ca7fad@app.fastmail.com> <CAJfpegsocoi-KobnSpD9dHvZDeDwG+ZPKRV9Yo-4i8utZa5Jww@mail.gmail.com>
 <56d5ac0e-4c54-46b7-85d3-5de127562630@app.fastmail.com>
In-Reply-To: <56d5ac0e-4c54-46b7-85d3-5de127562630@app.fastmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Feb 2023 20:04:17 +0200
Message-ID: <CAOQ4uxhYafABMTYXQjVxaekkwbetwAEZFA42cCVQ-nzMQn4o5w@mail.gmail.com>
Subject: Re: Attending LFS (was: [RFC PATCH v2 00/21] FUSE BPF: A Stacked
 Filesystem Extension for FUSE)
To:     Nikolaus Rath <nikolaus@rath.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        Daniel Rosenberg <drosen@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@android.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
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

On Tue, Feb 14, 2023 at 6:53 PM Nikolaus Rath <nikolaus@rath.org> wrote:
>
> Hi folks,
>
> I've looked into this in more detail.
>
> I wouldn't be able to get the travel funded by my employer, and I don't t=
hink I'm a suitable recipient for the Linux Foundation's travel fund. There=
fore, I think it would make more sense for me to attend potentially relevan=
t sessions remotely.
>
> If there's anything I need to do for that, please let me know. Otherwise =
I'll assume that at some point I'll get a meeting invite from someone :-).
>

Please use the Form in the CFP link to request to attend and specify
that you can
only  attend remotely.

This will get you subscribed to information about relevant sessions
and how to connect.

> If there's a way to schedule these sessions in a Europe-friendly time tha=
t would be much appreciated!
>

Will do my best to take that into consideration :)

Thanks,
Amir.

>
> --
> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>
>              =C2=BBTime flies like an arrow, fruit flies like a Banana.=
=C2=AB
>
> On Fri, 10 Feb 2023, at 10:53, Miklos Szeredi wrote:
> > On Fri, 10 Feb 2023 at 10:42, Nikolaus Rath <nikolaus@rath.org> wrote:
> >>
> >> On Fri, 10 Feb 2023, at 09:38, Miklos Szeredi wrote:
> >> > On Fri, 3 Feb 2023 at 12:43, Amir Goldstein <amir73il@gmail.com> wro=
te:
> >> >
> >> >> > Thanks a lot Amir, I'm going to send out an invitation tomorrow. =
Maybe
> >> >> > Nikolaus as libfuse maintainer could also attend?
> >> >> >
> >> >>
> >> >> Since this summit is about kernel filesystem development, I am not =
sure
> >> >> on-prem attendance will be the best option for Nikolaus as we do ha=
ve
> >> >> a quota for
> >> >> on-prem attendees, but we should have an option for connecting spec=
ific
> >> >> attendees remotely for specific sessions, so that could be great.
> >> >
> >> > Not sure.  I think including non-kernel people might be beneficial t=
o
> >> > the whole fs development community.  Not saying LSF is the best plac=
e,
> >> > but it's certainly a possibility.
> >> >
> >> > Nikolaus, I don't even know where you're located.  Do you think it
> >> > would make sense for you to attend?
> >>
> >> Hi folks,
> >>
> >> I'm located in London.
> >>
> >> I've never been at LHS, so it's hard for me to tell if I'd be useful t=
here or not. If there's interest, then I would make an effort to attend.
> >>
> >> Are we talking about the event in Vancouver on May 8th?
> >
> > Yes, that's the one.
> >
> > I'd certainly think it would be useful, since there will be people
> > with interest in fuse filesystems and hashing out the development
> > direction involves libfuse as well.
> >
> > Here's the CFP and attendance request if you are interested:
> >
> >   https://events.linuxfoundation.org/lsfmm/program/cfp/
> >
> > Thanks,
> > Miklos
