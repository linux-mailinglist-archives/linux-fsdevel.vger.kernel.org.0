Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCEA311718
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 00:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBEX0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 18:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhBEJy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:54:58 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F53C06178B;
        Fri,  5 Feb 2021 01:54:17 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z9so3480322pjl.5;
        Fri, 05 Feb 2021 01:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/X9CJlDkoOIfI0Y5y9ePsW+DeUp4U5M1t+e2JHC7CP0=;
        b=a5hP/xTQKHmtI3ZtlvLYkzOY3kBsSZew2riwJtUsqthJhVWs6bcctqmFLeNjj0FOep
         qBFjLotCqbAMa2G1SSmW5BNtnfQswrwcglbDgvqAttlKiI78nLogy6k5LA2mXzDfslJ0
         +dKnFGGIAbe7HaD2dY7AA9MxlyfXzxjkOGDT6SlBlZ0Q+nL97wDpiBOyOLdhQpGa22wL
         KuoAFXuriPms3pzgxSZjjcwX6k9yneRwo2ZvKcLcWoIAzAiZBrKoWxQT0jF4+9ecNC+c
         nqVSyietaHUe7zIBcbEYxUnbb0/cybLdwXOeEICHQUjX/0sARWHst5KhV0Y4smlYSMPS
         RL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/X9CJlDkoOIfI0Y5y9ePsW+DeUp4U5M1t+e2JHC7CP0=;
        b=qThQwLhGDh8CrPuwkBcmQBLswJZjB5XbGwN6+zYMe76tdqNuscaC0yOPbmE8EIJhdj
         kibLA1zXSMGCg5xPOvFhYt9ow+Qx5Wg3bU4NiE58dmlc9Ju9h9SSJm1Mw50I79mh7Vwh
         yKKyeoVa+AJYf/Mi6GRi5JOzpSMTk6UxFIEhrqMcbXA2mscEQZCagiyafD6Rk2dgn25F
         T/GYryp8IoF7M7iq6JzB4v3G6RCxzXDJIMJ54SaS70h8zGrdJs1BNx6yra5xozwe13LK
         JNzSsQ2/du+eBkU8sCWR2B43aq9b0lKixuHP43GCo0rX9XtyeBxgP/76kMng685BfN0/
         lHKQ==
X-Gm-Message-State: AOAM533byRG8hFPJj5/Wfw4ra0D2gWLKMSdjkJPBTlR/8iQPD5iaIoX8
        ynyimXtquRimspNnljuImy37a4PwmPOOmbLUUlg=
X-Google-Smtp-Source: ABdhPJxNMZrxFFQEf68XA/GyMuapZ8cq5r90fcNh658Gft6kTAaqIONB72alZsTZcnsJzrxb612h6J7MPwYdB3pespk=
X-Received: by 2002:a17:902:cec3:b029:de:901b:d0be with SMTP id
 d3-20020a170902cec3b02900de901bd0bemr3453431plg.26.1612518856867; Fri, 05 Feb
 2021 01:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-3-balsini@android.com>
 <CAMAHBGzkfEd9-1u0iKXp65ReJQgUi_=4sMpmfkwEOaMp6Ux7pg@mail.gmail.com>
 <YBFtXqgvcXW5fFCR@google.com> <CAMAHBGwpKW+30kNQ_Apt8A-FTmr94hBOzkT21cjEHHW+t7yUMQ@mail.gmail.com>
 <YBLG+QlXqVB/bo/u@google.com>
In-Reply-To: <YBLG+QlXqVB/bo/u@google.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Fri, 5 Feb 2021 17:54:05 +0800
Message-ID: <CA+a=Yy7gfKbpgOd3+9HPGxvyU821p8yxkjz6cbOKJd_hN5Nekg@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 2/8] fuse: 32-bit user space ioctl compat for
 fuse device
To:     Alessio Balsini <balsini@android.com>
Cc:     qxy <qxy65535@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:15 PM Alessio Balsini <balsini@android.com> wrote:
>
> Hi all,
>
> I'm more than happy to change the interface into something that is
> objectively better and accepted by everyone.
> I would really love to reach the point at which we have a "stable-ish"
> UAPI as soon as possible.
>
> I've been thinking about a few possible approaches to fix the issue, yet
> to preserve its flexibility. These are mentioned below.
>
>
>   Solution 1: Size
>
> As mentioned in my previous email, one solution could be to introduce
> the "size" field to allow the structure to grow in the future.
>
> struct fuse_passthrough_out {
>     uint32_t        size;   // Size of this data structure
>     uint32_t        fd;
> };
>
> The problem here is that we are making the promise that all the upcoming
> fields are going to be maintained forever and at the offsets they were
> originally defined.
>
>
>   Solution 2: Version
>
> Another solution could be to s/size/version, where for every version of
> FUSE passthrough we reserve the right to modifying the fields over time,
> casting them to the right data structure according to the version.
>
>
>   Solution 3: Type
>
> Using an enumerator to define the data structure content and purpose is
> the most flexible solution I can think of.  This would for example allow
> us to substitute FUSE_DEV_IOC_PASSTHROUGH_OPEN with the generic
> FUSE_DEV_IOC_PASSTHROUGH and having a single ioctl for any eventually
> upcoming passthrough requests.
>
> enum fuse_passthrough_type {
>     FUSE_PASSTHROUGH_OPEN
> };
>
> struct fuse_passthrough_out {
>     uint32_t type; /* as defined by enum fuse_passthrough_type */
>     union {
>         uint32_t fd;
>     };
> };
>
> This last is my favorite, as regardless the minimal logic required to
> detect the size and content of the struct (not required now as we only
> have a single option), it would also allow to do some kind of interface
> versioning (e.g., in case we want to implement
> FUSE_PASSTHROUGH_OPEN_V2).
>
Usually a new type of ioctl will be added in such cases. If we want to
stick to the same ioctl number, it might be easier to add a `flags`
field to differentiate compatible passthrough ioctls. So in future, if
a new interface is compatible with the existing one, we can use flags
to tell it. If it is not compatible, we still need to add a new ioctl.
wdyt?

struct fuse_passthrough_out {
    uint32_t flags;
    union {
        uint32_t fd;
    };
};

This somehow follows the "Flags as a system call API design pattern"
(https://lwn.net/Articles/585415/).

Just my two cents.

Cheers,
Tao
-- 
Into Sth. Rich & Strange
