Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890883A4261
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhFKMuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 08:50:24 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:42952 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhFKMuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:50:19 -0400
Received: by mail-pj1-f42.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so5930651pjb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFlFByvy1p9feA/SL91FCXebbZayQ4inesD3pTRuEf8=;
        b=VvorC3aueDnMkW0WJzcn3o0/VAtQcWegfftCewHkuwx0n8gKV4b3TkF09rVHSmrRga
         4GoJC9owksKho8oExoYoDnkshn/KRk4ILdi1fd39+UKM7Y/246dQWSW4uA5D4iu3tLUa
         tBuu8CHO4+OwJhnGcbll3Ie+RbtBb5tfjEhccZxutH9Y3meOp8IXJclOFz6LqIIzIUgD
         rO04Qh9kx7OJwufFpmbp6DZoG+qy1T3Sfzw95lIy6Kh1JuAwV1yIDQHCAY6Q+eXl4jfK
         72Ic8FXIhVLm6AXr5Tx4UL0IX2bu8fnCV4vW3He1b5bbOGPSwNZaon79lRZkyKVOhBv7
         MUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFlFByvy1p9feA/SL91FCXebbZayQ4inesD3pTRuEf8=;
        b=CqFaK9PmJPo7sm06HbXdjWOz2okvBriU6alD0F52VK3J2LS43ah53AW1tLY8yUkXCP
         OjJZjXHWshvjBvXY84qXpKisBCS7SuV6s+00zAhFltUc3+cjyQJvJdOZNS3Qd+SkhKYy
         WI32ihdVHD/gxdh5P+QRl4fe6p5wewxJVGPBI6rfKJuBLBVf5Vk39ftFGjwtUNBmBvHs
         mw6gG7enzFpiuFEzabQ9/zyJc2yTm9+VHoOL3VTwWJHafv7EWOAI9Mysf7DFxRZ0kG2E
         EXmFmZgp0LJaKD5UuNqMHCyn52CMtPVF+i1Cs6otNitMfS54ueXVPwJ47Q+VYKT2Gj2o
         rVJg==
X-Gm-Message-State: AOAM5333d6olzzdWPU6o0EJhKJfmSFYGxWGH9REG9mz2iobos8tVr30K
        VG5C+SYElnENeK+d1gQN8mevTLdlDYC1vqNpI4Y=
X-Google-Smtp-Source: ABdhPJy2LQfwYBlz/vvqH159Fo1cfOZL/VpY9nvELcGQ/xwOtqP3sZ9kr69eVZCGDrPUhup5CCFNQ0eDp+ybr0ASE8I=
X-Received: by 2002:a17:90b:1b44:: with SMTP id nv4mr8935890pjb.223.1623415627762;
 Fri, 11 Jun 2021 05:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com> <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
 <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com>
 <429fc51b-ece0-b5cb-9540-2e7f5b472d73@metux.net> <CA+a=Yy6k3k2iFb+tBMuBDMs8E8SsBKce9Q=3C2zXTrx3-B7Ztg@mail.gmail.com>
 <295cfc39-a820-3167-1096-d8758074452d@metux.net>
In-Reply-To: <295cfc39-a820-3167-1096-d8758074452d@metux.net>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Fri, 11 Jun 2021 20:46:56 +0800
Message-ID: <CA+a=Yy7DDrMs6R8qRF6JMco0VOBWCKNoX7E-ga9W2Omn=+QUrQ@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 9, 2021 at 11:16 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 08.06.21 14:41, Peng Tao wrote:
>
> Hi,
>
Hi,
> > The initial RFC mail in the thread has a userspace example code. Does
> > it make sense to you?
>
> Sorry, I had missed that, now found it.
>
> There're some things I don't quite understand:
>
> * it just stores fd's I don't see anything where it is actually returned
>    to some open() operation.
The FUSE_DEV_IOC_RESTORE_FD ioctl returns the opened fd to a different process.

> * the store is machine wide global - everybody uses the same number
>    space, dont see any kind of access conrol ... how about security ?
>
The idea is that anyone capable of opening /dev/fuse can retrieve the FD.

> I don't believe that just storing the fd's somewhere is really helpful
> for that purpose - the fuse server shall be able to reply the open()
> request with an fd, which then is directly transferred to the client.
>
Could you describe your use case a bit? How does your client talk to
your server? Through open syscall or through some process-to-process
RPC calls?

Cheers,
Tao
-- 
Into Sth. Rich & Strange
