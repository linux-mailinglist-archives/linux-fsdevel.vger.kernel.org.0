Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA87691D4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 11:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjBJKyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 05:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjBJKyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:54:03 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622F11ABC0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 02:54:02 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id dr8so14682715ejc.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 02:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IY4Whe06KZr/dCRKC/k3Pnuiy/Cav2kBFD8hLrrOg8g=;
        b=nY/IGLGNDxwn530xHObj2thmUqHZRExRlPumHRiXuRfiSoGNDPEVEF+L5oTEXv8PcP
         ETbaF/URLWOEk55Yq0H8SNZ5bXxPS/Ze9/GJ9GFYZs9XeTEJ7dl9t9krGUkdAC3wi0WF
         U3t/xZxHsaRWpDmZSXBrwiZnSO7RT+1smDyvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IY4Whe06KZr/dCRKC/k3Pnuiy/Cav2kBFD8hLrrOg8g=;
        b=IKAGQATnUwDiUn0KLJqvmSVFZZPBD2y7Z12GzCpUHqqK/Yv7O6ATcijFOIUtPMlX0o
         hVBDQKbKlIJHuFcGQCbrHiXbPGeCtay3cFcuSmIuVCiYLClXsIE5qq/7jBNADR3HJ6bJ
         gBPH0CEkqRnTwZ0BMBAhP05Een2r8lzN5We6ZSgNJ16GzPqguhoUKj0CBOMaRBu73MWm
         TcVsSXV9iaQSHs4FohnvJYW7A03jXu27elca4sbRXMvHoUsn372jLFPdLHPqMTR/3ZtR
         4Kybq3hlNM3Pb4f8RBcP811u1zdJhre7Ydhj2Rn5zMoW4pQyKsAsvPfje1at99yH1+7A
         0C5Q==
X-Gm-Message-State: AO0yUKV+qPczJmL4p6VzH5uPwA8RvsX8lLG1aJ4ZtRUpzgVDURL4hwn7
        OT0RgoBdR28+HfevpXGxLWzVuktYr0r2isBKeJ6OHg==
X-Google-Smtp-Source: AK7set8xkzxBOD+wDzOrHdqZR4xd8pnPuGMx8oY9OQNbChtJSYSGC6AgESAHznUmU7N13mMocyUpTYWHP03Gt0TCi8c=
X-Received: by 2002:a17:906:7242:b0:889:a006:7db5 with SMTP id
 n2-20020a170906724200b00889a0067db5mr3270379ejk.138.1676026440994; Fri, 10
 Feb 2023 02:54:00 -0800 (PST)
MIME-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com> <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
 <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
 <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm> <CAOQ4uxiBD5NXLMXFev7vsCLU5-_o8-_H-XcoMY1aqhOwnADo9w@mail.gmail.com>
 <283b5344-3ef5-7799-e243-13c707388cd8@fastmail.fm> <CAOQ4uxjvUukDSBk977csO5cX=-1HiMHmyQxycbYQgrpLaanddw@mail.gmail.com>
 <CAJfpegvHKkCn0UnNRVxFXjjnkOuq0N4xLN4WzpqVX+56DqdjUw@mail.gmail.com> <81e010cc-b52b-4b20-8d08-631ce8ca7fad@app.fastmail.com>
In-Reply-To: <81e010cc-b52b-4b20-8d08-631ce8ca7fad@app.fastmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 10 Feb 2023 11:53:50 +0100
Message-ID: <CAJfpegsocoi-KobnSpD9dHvZDeDwG+ZPKRV9Yo-4i8utZa5Jww@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for FUSE
To:     Nikolaus Rath <nikolaus@rath.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        Daniel Rosenberg <drosen@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@android.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 10 Feb 2023 at 10:42, Nikolaus Rath <nikolaus@rath.org> wrote:
>
> On Fri, 10 Feb 2023, at 09:38, Miklos Szeredi wrote:
> > On Fri, 3 Feb 2023 at 12:43, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> >> > Thanks a lot Amir, I'm going to send out an invitation tomorrow. Maybe
> >> > Nikolaus as libfuse maintainer could also attend?
> >> >
> >>
> >> Since this summit is about kernel filesystem development, I am not sure
> >> on-prem attendance will be the best option for Nikolaus as we do have
> >> a quota for
> >> on-prem attendees, but we should have an option for connecting specific
> >> attendees remotely for specific sessions, so that could be great.
> >
> > Not sure.  I think including non-kernel people might be beneficial to
> > the whole fs development community.  Not saying LSF is the best place,
> > but it's certainly a possibility.
> >
> > Nikolaus, I don't even know where you're located.  Do you think it
> > would make sense for you to attend?
>
> Hi folks,
>
> I'm located in London.
>
> I've never been at LHS, so it's hard for me to tell if I'd be useful there or not. If there's interest, then I would make an effort to attend.
>
> Are we talking about the event in Vancouver on May 8th?

Yes, that's the one.

I'd certainly think it would be useful, since there will be people
with interest in fuse filesystems and hashing out the development
direction involves libfuse as well.

Here's the CFP and attendance request if you are interested:

  https://events.linuxfoundation.org/lsfmm/program/cfp/

Thanks,
Miklos
