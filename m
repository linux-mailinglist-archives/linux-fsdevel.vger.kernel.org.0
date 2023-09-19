Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E899C7A5FDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjISKnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjISKnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:43:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A3FEA
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:43:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso6487701e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695120184; x=1695724984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5yuOXi27S5/JaRY7L/3NTPX48JpWUyvTfzVQyvQwVE=;
        b=O/4h9jJjo8SX0P6Y0Fqlc7bU4DqYkTKyn4Fw6OYCvrZrDpSRWvzfySAo76CmgYvmBC
         r+WelFu+BvvtUk/PIP0GodlNUYhnuTb5qOakRuRqC2lw7qsZy5tt8/LL2et65IFc/BRr
         V4+Uu9DmRDMLzyra4SN5XqEjYPnye1hiuCyeA1dvdOBTaW64qq+Zq2D90YzaLLSUiZ36
         UiYJiR/gj1cJvmNvJsz9S5frMqPePB5hl4jxVWUEUCeaq+eiFo0gL9ikj7jxL3g8s7kG
         uY1Ipz3j2isqOxfkVuB95ZGl2bEjzd3mngtocpmlKTYXGsOKPAtdKY44IHBVradX8mij
         9T6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695120184; x=1695724984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5yuOXi27S5/JaRY7L/3NTPX48JpWUyvTfzVQyvQwVE=;
        b=hqIGbz6LHqUT9y4eQLMMsptS8yLPWCb8tkuoKjplMdKZ8KNiTewPLSO5E13Zlus0p5
         1Av9VI4pkjVsqtPRoIrUO/gTH1p3/BQYU9pjr7mOa8Xb8zDBRc0ELw17oJ7HaemoNbn8
         RGiYZehZk+pyKdnxGnSGhJRUUtVSDcaeA1IkrAlheOTC/uYw85YPsYTVQQiuX81vy6PK
         40N2zbsqJzNvZsN0Ihh1VMW3wYo3niD1ms6oiJeMymcByGghJFPj24gOGxdh9lrHT72V
         gRNpPCKr8EI2YExPTXZz9bB+5DADW2R6iO6iosBBjIFjW5/DxypL8t0VP7RbfxhpN6Bw
         xLMg==
X-Gm-Message-State: AOJu0Yy1k72A+J0r92aGJyyZFo3OW8CqjUg1Cx0HjjNuBialODp7yKbw
        yyR2n2koZg6hS4hA0Z+CqQ6HKOPKzYyPb6s5s3sE3w==
X-Google-Smtp-Source: AGHT+IFQsa+wMBs9sorEo9MC83c63cX/EaHDeTTb+L/duO02yWI9SbsaEB7mtlrH3+e2X82XbH0lItxfmzG/xkbKjLE=
X-Received: by 2002:a05:6512:3d29:b0:502:d973:3206 with SMTP id
 d41-20020a0565123d2900b00502d9733206mr1009096lfv.6.1695120183820; Tue, 19 Sep
 2023 03:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com> <20230919100112.nlb2t4nm46wmugc2@quack3>
In-Reply-To: <20230919100112.nlb2t4nm46wmugc2@quack3>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 12:42:52 +0200
Message-ID: <CAKPOu+-apWRekyqRyYfsFkdx13uocCPKMzYJqmTsVEc6a=9uuA@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> So with inotify event, you get back 'wd' and 'name' to identify the objec=
t
> where the event happened. How is this (for your usecase) different from
> getting back 'fsid + handle' and 'name' back from fanotify? In inotify ca=
se
> you had to somehow track wd -> path linkage, with fanotify you need to
> track 'fsid + handle' -> path linkage.

The wd is a simple "int" which is the return value of the system call,
and it's part of "struct inotify_event". One system call for
registering it, one system call fo reading it.

From fanotify, I read a "struct fanotify_event_metadata", and then
check variable-length follow-up structs, iterable those follow-up
structs, find the one with "info_type=3D=3DFAN_EVENT_INFO_TYPE_FID", now I
have a "fsid" of type "__kernel_fsid_t" (a struct containing two
32-bit integers) and a "file_handle" (a variable-length opaque BLOB).
What do I do with these?

The answer appears to be: when I registered, I should have obtained
the fsid (via statfs()) and the file_handle (via name_to_handle_at()).
That's three extra system calls. One statfs(), and twice
name_to_handle_at(), because the first one is needed to get the length
of the buffer I need to allocate for the file_handle (and hope my
filesystem supports file_handles, because apparently that's an
optional feature). Just look at the name_to_handle_at() manpage for
some horrors of its complexity.

Imagine how much more complex the data structure for looking up the
modified file is: inotify has an int as the lookup key, and fanotify
has two integers plus a variable-length BLOB.

> But if you want to monitor multiple filesystems

I can monitor multiple filesystems with inotify.

> or if you have priviledged process that can open by handle

Getting an already-opened file descriptor, or just the file_handle, is
certainly an interesting fanotify feature. But that could have easily
been added to inotify with a new "mask" flag for the
inotify_add_watch() function.

> or a standard filesystem where handles are actually persistent, then ther=
e are benefits.

Same here: that could have been an (optional) inotify feature, instead
of making the whole complexity mandatory for everybody.

Max
