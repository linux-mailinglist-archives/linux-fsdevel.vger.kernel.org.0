Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5891BAEAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgD0UEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 16:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgD0UEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:04:16 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CEEC0610D5
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 13:04:15 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u10so14927761lfo.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ig0NUX5kJIpuTm2W6H1lYIHC2tCxuWQTcZ1L/FAlQw=;
        b=P0lEmfaVBDBQj2/xcLo7J/fvkALqOpxlaLdS9iSPvFT6JQMUL427crYWrJV4dVTPCz
         mQN6N9TP/xg0huhsNsZaIB5jR9oMHxxZR6sX4P8kCKs9x97O/Z6g3JyEJw2agytDyP1E
         61s4EOcNoa9uWswJBtNHMYsmROQCt3RV77YPgbTosLMTqk68vB0G1flOU42hlWSCEyqU
         dEXMb+vHrXkXwpacYZQnDXR0xIkIk7icEdDHyQ/qpHiRekm78Ke90Q2aMZItkDQlqdpY
         UbZtjJtWJwc31VvRXknNXD0aaB0e3VHhepxL66H3rYJZgYelbhM56jXk9DKabYpi+2/4
         LoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ig0NUX5kJIpuTm2W6H1lYIHC2tCxuWQTcZ1L/FAlQw=;
        b=e8RF55FbhUpsPicS+GRlCB4lO0CEKGn85oo4BCJeiDjKLEqMVpDFyW5uHhFT/CTBlp
         pR/QiqBZwIwJ17MVhqtFj/I7YaRk07+O6qu+isr0Kb5smntnJf1lm33M6Co8LO6KxIKJ
         LSt3geMOQMgr2YguEMk9pMarGLfac67SDAaipbqPjtV4XUb7hUBvfWszvL+AUk2KvgyE
         G/vai5XQoXMhBkKMzQIyGCv/ZtoSyguxu4qJjcRlDEv/SWePUzRso9gr7sSW7govaXbv
         E4DALPJuLhqVyu0S8D23hKVI/Q3dsENWJJMgvcXbBrqXy8wrrTMVbxp3IkU+pjmLf6kJ
         hoqg==
X-Gm-Message-State: AGi0Pub5iWQeeNkAql2gx6b3WNVY0HjpAbRZC//xN6ouaciv+yPj3rcm
        F598AZD7JU3KhiPYyh4TcHcrmxfJq+O/B0hHsw5KGg==
X-Google-Smtp-Source: APiQypKIqA91+cfb1u+Egv8yWyKiIHz+TmM1jPts4SZbZZXDBwewxBDIJxMQqfCR6EBk13dcrtaFM58WqTiDIWe2XoI=
X-Received: by 2002:ac2:4a76:: with SMTP id q22mr16573900lfp.157.1588017853847;
 Mon, 27 Apr 2020 13:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAObFT-S27KXFGomqPZdXA8oJDe6QxmoT=T6CBgD9R9UHNmakUQ@mail.gmail.com>
 <f75d30ff-53ec-c3a1-19b2-956735d44088@kernel.dk> <CAG48ez32nkvLsWStjenGmZdLaSPKWEcSccPKqgPtJwme8ZxxuQ@mail.gmail.com>
 <bd37ec95-2b0b-40fc-8c86-43805e2990aa@kernel.dk> <45d7558a-d0c8-4d3f-c63a-33fd2fb073a5@kernel.dk>
In-Reply-To: <45d7558a-d0c8-4d3f-c63a-33fd2fb073a5@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 Apr 2020 22:03:47 +0200
Message-ID: <CAG48ez0pHbz3qvjQ+N6r0HfAgSYdDnV1rGy3gCzcuyH6oiMhBQ@mail.gmail.com>
Subject: Re: io_uring, IORING_OP_RECVMSG and ancillary data
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andreas Smas <andreas@lonelycoder.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 9:53 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 4/27/20 1:29 PM, Jens Axboe wrote:
> > On 4/27/20 1:20 PM, Jann Horn wrote:
> >> On Sat, Apr 25, 2020 at 10:23 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>> On 4/25/20 11:29 AM, Andreas Smas wrote:
> >>>> Hi,
> >>>>
> >>>> Tried to use io_uring with OP_RECVMSG with ancillary buffers (for my
> >>>> particular use case I'm using SO_TIMESTAMP for incoming UDP packets).
> >>>>
> >>>> These submissions fail with EINVAL due to the check in __sys_recvmsg_sock().
> >>>>
> >>>> The following hack fixes the problem for me and I get valid timestamps
> >>>> back. Not suggesting this is the real fix as I'm not sure what the
> >>>> implications of this is.
> >>>>
> >>>> Any insight into this would be much appreciated.
> >>>
> >>> It was originally disabled because of a security issue, but I do think
> >>> it's safe to enable again.
> >>>
> >>> Adding the io-uring list and Jann as well, leaving patch intact below.
> >>>
> >>>> diff --git a/net/socket.c b/net/socket.c
> >>>> index 2dd739fba866..689f41f4156e 100644
> >>>> --- a/net/socket.c
> >>>> +++ b/net/socket.c
> >>>> @@ -2637,10 +2637,6 @@ long __sys_recvmsg_sock(struct socket *sock,
> >>>> struct msghdr *msg,
> >>>>                         struct user_msghdr __user *umsg,
> >>>>                         struct sockaddr __user *uaddr, unsigned int flags)
> >>>>  {
> >>>> -       /* disallow ancillary data requests from this path */
> >>>> -       if (msg->msg_control || msg->msg_controllen)
> >>>> -               return -EINVAL;
> >>>> -
> >>>>         return ____sys_recvmsg(sock, msg, umsg, uaddr, flags, 0);
> >>>>  }
> >>
> >> I think that's hard to get right. In particular, unix domain sockets
> >> can currently pass file descriptors in control data - so you'd need to
> >> set the file_table flag for recvmsg and sendmsg. And I'm not sure
> >> whether, to make this robust, there should be a whitelist of types of
> >> control messages that are permitted to be used with io_uring, or
> >> something like that...
> >>
> >> I think of ancillary buffers as being kind of like ioctl handlers in
> >> this regard.
> >
> > Good point. I'll send out something that hopefully will be enough to
> > be useful, whole not allowing anything randomly.
>
> That things is a bit of a mess... How about something like this for
> starters?
[...]
> +static bool io_net_allow_cmsg(struct msghdr *msg)
> +{
> +       struct cmsghdr *cmsg;
> +
> +       for_each_cmsghdr(cmsg, msg) {

Isn't this going to dereference a userspace pointer? ->msg_control has
not been copied into the kernel at this point, right?

> +               if (!__io_net_allow_cmsg(cmsg))
> +                       return false;
> +       }
[...]
> @@ -3604,6 +3635,11 @@ static int io_sendmsg(struct io_kiocb *req, bool force_nonblock)
[...]
> +               if (!io_net_allow_cmsg(&kmsg->msg)) {
> +                       ret = -EINVAL;
> +                       goto err;
> +               }
[...]
> @@ -3840,6 +3877,11 @@ static int io_recvmsg(struct io_kiocb *req, bool force_nonblock)
[...]
> +               if (!io_net_allow_cmsg(&kmsg->msg)) {
> +                       ret = -EINVAL;
> +                       goto err;
> +               }
> +
