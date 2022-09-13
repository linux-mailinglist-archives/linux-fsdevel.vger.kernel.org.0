Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC25B7C3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiIMUd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIMUdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:33:55 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB40346DAF
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 13:33:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id cb8so9731867qtb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=zB6KpH+W5IcDfljEG5nHIundo6n/sYRzjc18WH1pavA=;
        b=jUnWqRzYATUUl+AL2RCz63AmCnWw1cIp3MmSBd8ckZ1hc78bAMmhhbpTjOust+O5Xu
         +Pw7CQLIo91wk65MU8sp1rUfyKYMozWqXgyee5JqWu2Cp79Th9UtpaCASwypyu1R+f5u
         jIgoOoYMhGd0cBbdQhl2xmHLLGqR8dWCwFK+Hv2MY0m5PfrRMAMXFExFkxuSt7gV40dQ
         h7F1X8MHZmes95OGtvBrxtGPwmPfQVmkqL/HHDo393JAn2lUe0lDH4aLQDSbrD7r6fql
         U8LnUVMh0BXC8D/2lW6v7AY2L59DNghkq/ZvElFtzCwHpZtTcOivDAMb/lbmecFLtJHR
         SHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zB6KpH+W5IcDfljEG5nHIundo6n/sYRzjc18WH1pavA=;
        b=Rvg9g8foUz63K5AJI4DI94Ud4MBEie4SvO2EYbI8pggsiAiyq9oiwd+lVGA6HkuWnq
         ah3TnUCceR69XEcFa6z3XdfVfk/hCrw24OnE2OxryysoNWbm1I3LCtAFDvLHstcmqlZg
         y4pa/mi4hGgNAo0rqdsUjA+tE6FeZM9Ys9bt0W+twaFumDXJcx3Qytpl1pxjbi/2ollJ
         iuIpeX2kes6idY33Yz8X3+BDSuMaKKC5ndClde6H+saMOAKvkykpqTkp9NesQlHMpnvc
         7iyNqUcJuoDA8uuFolUI4DnNUPRIywQnjfAGNUH3mJ0GuMjEp/VSecq1eTpQrE3XUnv6
         bLfw==
X-Gm-Message-State: ACgBeo3csXZeYS8Fl5K3IpnrKtrB4LREVT5qH9sJNwEtDFG2ArayoOAr
        nhvX7bhgXuQvRQ7vEorpUxPCjMMBqX9wLHwh+bFsR4MC1YrQ+Q==
X-Google-Smtp-Source: AA6agR5l+Aj8ArjIQKPLM5Rbqnfw3IHt4p5dnjIzwA8ElcbsJJoPqUtkbnL9NdccoX4YJftZxary6Flvm39hMTwrSP8=
X-Received: by 2002:a05:622a:190e:b0:35c:199:b001 with SMTP id
 w14-20020a05622a190e00b0035c0199b001mr4271835qtc.168.1663101233774; Tue, 13
 Sep 2022 13:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
 <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com>
 <CAOQ4uxh2OZ_AMp6XRcMy0ZtjkQnBfBZFhH0t-+Pd298uPuSEVw@mail.gmail.com>
 <CAJfpegt4N2nmCQGmLSBB--NzuSSsO6Z0sue27biQd4aiSwvNFw@mail.gmail.com>
 <CAOQ4uxjjPOtH9+r=oSV4iVAUvW6s3RBjA9qC73bQN1LhUqjRYQ@mail.gmail.com>
 <CA+khW7hviAT6DbNORYKcatOV1cigGyrd_1mH-oMwehafobVXVg@mail.gmail.com>
 <CAOQ4uxjUbwKmLAO-jTE3y6EnH2PNw0+V=oXNqNyD+H9U+nX49g@mail.gmail.com>
 <CA+khW7jQ6fZbEgzxCafsaaTyv7ze58bd9hQ0HBH4R+dQyRaqog@mail.gmail.com> <CAOQ4uxjP0qeuUrdjT6hXCb5zO0AoY+LKM6uza2cL9UCGMo8KsQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjP0qeuUrdjT6hXCb5zO0AoY+LKM6uza2cL9UCGMo8KsQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 13 Sep 2022 13:33:42 -0700
Message-ID: <CA+khW7h907VDeD1mR2wH4pOWxPBG18C2enkZKSZgyWYrFP7Vnw@mail.gmail.com>
Subject: Re: Overlayfs with writable lower layer
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 11:54 AM Amir Goldstein <amir73il@gmail.com> wrote:
> OK. IIUC, you have upper fs files only in the root dir?

Sorry, no, the upper fs files need to be in subdir.

> And the lower root dir has only subdirs?

There could be files.

> Can you give a small example of an upper a lower and their
> union trees just for the sake of discussion?
>

For example, assume lower has the following layout:
$ tree lower
.
=E2=94=94=E2=94=80=E2=94=80 A
    =E2=94=9C=E2=94=80=E2=94=80 B
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower
    =E2=94=94=E2=94=80=E2=94=80 lower

I can't create files in the fs in the lower.
$ touch A/B/file
touch: cannot touch 'A/B/file': Permission denied

The upper is initially empty.

I would like to overlay a writable fs on top of lower, so the union
tree looks like
$ tree union
.
=E2=94=94=E2=94=80=E2=94=80 A
    =E2=94=9C=E2=94=80=E2=94=80 B
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower
    =E2=94=94=E2=94=80=E2=94=80 lower
$ touch A/B/file
$ tree union
.
=E2=94=94=E2=94=80=E2=94=80 A
    =E2=94=9C=E2=94=80=E2=94=80 B
    =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 file
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower2
    =E2=94=94=E2=94=80=E2=94=80 lower1

Here, 'file' exists in the upper.

Further, directory B could disappear from lower. When that happens, I
think there are two possible behaviors:
 - make 'file' disappear from union as well;
 - make 'file' and its directory accessible as well.

In behavior 1, it will look like
$ tree union
.
=E2=94=94=E2=94=80=E2=94=80 A
    =E2=94=94=E2=94=80=E2=94=80 lower1

In behavior 2, it will look like
$ tree union
.
=E2=94=94=E2=94=80=E2=94=80 A
    =E2=94=9C=E2=94=80=E2=94=80 B
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file
    =E2=94=94=E2=94=80=E2=94=80 lower1

IMHO, behavior 1 works better in my use case. But if the FS experts
think behavior 2 makes more sense, I can work around.

>
> If that is all then it sounds pretty simple.
> It could be described something like this:
> 1. merged directories cannot appear/disappear
> 2. lower pure directories can appear/disappear
> 3. upper files/dirs can be created inside merge dirs and pure upper dirs
>
> I think I have some patches that could help with #2.
>

These three semantics looks good to me.

> Thanks,
> Amir.
