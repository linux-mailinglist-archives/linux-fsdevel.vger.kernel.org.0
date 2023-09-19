Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2195B7A606F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 12:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjISK7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 06:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjISK7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:59:20 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A641172D
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:59:05 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49032a0ff13so2339804e0c.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695121144; x=1695725944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te8rgsk//8HF6XVdzgc7ALCPbkT05UvewwUP7DJmjhw=;
        b=mX94Z+oLOvf1JojJFSWrwpfe+ZvbQCWG5Z1/GVRfoYIrJM5qEwSeDZUt0kMhazYSzY
         KTrDLUHHk66Ae0gnmNBQdueSyzkLUkvDzsF0x4rFfkTtB3XyXXPTrdHcn7NxuU8m0Pod
         sEuUKDB0MlQHcxZ7Jr/OYV1eIHkNaVDGfg8+RWR8TpJ2dSRk0+7lAPHSwjTIoZfWSHBV
         nCvyF0T4shGmOzX8jnCqjVf8tmBcwJKpPzSEmrdlMmliOUVi30Amui5hJdbJaVak9LCw
         Tn22VE+Y24HvCYEgOXwAiqe0ChbFg6oCHf1Bzg93zyq/DNLtZWIKzKuLhUwU0gDcRnmu
         tnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695121144; x=1695725944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te8rgsk//8HF6XVdzgc7ALCPbkT05UvewwUP7DJmjhw=;
        b=iQDOUgkfyA7/UIrYY0p2ruwXJ8l5+w4ksACTWGPc4njzfbe0Xo/iSueUR2Jy+TrlZL
         RuewOuQOpbr+50ZEKOyHuhVTLune42fbFYvG1tpFR134p9eUxkuenOa3ZY/dHr4KxliZ
         aEzJNRYf21fsXfODaCcIQM08VgsHZJhyehyXa5xejVn4pjw1x+W7dVUV5SXSR1PuEEhf
         P4rpkvd4hGusR6BOt6GHsBldvRgkmQapQ2gxoylIaFF+RubkFGH01f3Jj5SVQtpFVsGD
         4RUeZtt2LDUAJniKpKnfyJv3+Efa9PtTJTr0/LuyWkYY2g6p3Oo4xh+TvqlxaAMtfTnr
         4e8A==
X-Gm-Message-State: AOJu0YxaLsX0X4cCRHaHXknNkuVgsEPflebbLNR9yuWUSjU6zjnsaPAG
        5iC578FWvrezXoe+Wfd9Y1nZ4TucMOHGMYv/3wQ=
X-Google-Smtp-Source: AGHT+IGFbuFhX6M++nkvq8eFpy1ZjPaf94mpH5kVCcaEJlyiV0jAObKxDZX7VQvB/q+R9Awft055fVWpRG5fZ2u6uG4=
X-Received: by 2002:a1f:e741:0:b0:495:f061:f2c7 with SMTP id
 e62-20020a1fe741000000b00495f061f2c7mr9417123vkh.3.1695121144361; Tue, 19 Sep
 2023 03:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
 <20230919100112.nlb2t4nm46wmugc2@quack3> <CAKPOu+-apWRekyqRyYfsFkdx13uocCPKMzYJqmTsVEc6a=9uuA@mail.gmail.com>
In-Reply-To: <CAKPOu+-apWRekyqRyYfsFkdx13uocCPKMzYJqmTsVEc6a=9uuA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Sep 2023 13:58:53 +0300
Message-ID: <CAOQ4uxgG6ync6dSBJiGW98docJGnajALiV+9tuwGiRt8NE8F+w@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 1:43=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Tue, Sep 19, 2023 at 12:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > So with inotify event, you get back 'wd' and 'name' to identify the obj=
ect
> > where the event happened. How is this (for your usecase) different from
> > getting back 'fsid + handle' and 'name' back from fanotify? In inotify =
case
> > you had to somehow track wd -> path linkage, with fanotify you need to
> > track 'fsid + handle' -> path linkage.
>
> The wd is a simple "int" which is the return value of the system call,
> and it's part of "struct inotify_event". One system call for
> registering it, one system call fo reading it.
>
> From fanotify, I read a "struct fanotify_event_metadata", and then
> check variable-length follow-up structs, iterable those follow-up
> structs, find the one with "info_type=3D=3DFAN_EVENT_INFO_TYPE_FID", now =
I
> have a "fsid" of type "__kernel_fsid_t" (a struct containing two
> 32-bit integers) and a "file_handle" (a variable-length opaque BLOB).
> What do I do with these?
>
> The answer appears to be: when I registered, I should have obtained
> the fsid (via statfs()) and the file_handle (via name_to_handle_at()).
> That's three extra system calls. One statfs(), and twice
> name_to_handle_at(), because the first one is needed to get the length
> of the buffer I need to allocate for the file_handle (and hope my
> filesystem supports file_handles, because apparently that's an
> optional feature). Just look at the name_to_handle_at() manpage for
> some horrors of its complexity.
>
> Imagine how much more complex the data structure for looking up the
> modified file is: inotify has an int as the lookup key, and fanotify
> has two integers plus a variable-length BLOB.
>

You are not describing a technical problem.
Any API complexity can be hidden from users with userspace
libraries. You can use the inotify-tools lib if you prefer.

I assure you that the added complexity to the API was not
done to make your life harder.
inotify API has several design flaws and fanotify API extensions
were designed to address those flaws.

> > But if you want to monitor multiple filesystems
>
> I can monitor multiple filesystems with inotify.
>
> > or if you have priviledged process that can open by handle
>
> Getting an already-opened file descriptor, or just the file_handle, is
> certainly an interesting fanotify feature. But that could have easily
> been added to inotify with a new "mask" flag for the
> inotify_add_watch() function.
>

"could have easily been added" is not a statement that I am willing
to accept.

You are saying that because you do not understand the complexity
involved and that is fine - you can ask.

The things that you are complaining about in the API are the exact
things that were needed to make the advanced features work.

Beyond that, it is a matter of API consolidation -
We prefer to maintain a single unified API that can cover all
the use cases over maintaining several overlapping APIs.

The complexity added to the API for simple use cases can
be mitigated with user libraries - it is not a good reason IMO
to keep maintaining an old limited API in parallel to a new
improved one.

Thanks,
Amir.
