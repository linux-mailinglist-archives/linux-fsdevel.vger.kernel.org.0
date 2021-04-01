Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CAE3517A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhDARmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbhDARk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FCAC061A2D
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 05:28:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b16so1742172eds.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhDaOseZ+6YnQA/A1swsQLNYw4MXMhXhVabFMVkbjsA=;
        b=Huc1ofURHM43skrOi931cdfPIghsMc/UJJso8gLcpGYz/BYZJIJFofrkcTCO06yxS/
         Y/nrFId9rEJUUEW6rzoc7EAutYg8Wj0uDJQTDIFw+olxunApDdoizOFQDHP4jE3UUtJH
         TrTDNt2BxKtTOCGJbTVHwEUAbdJuioWYtRARFfilgfKqRlC8jSnSCc5qKlPv7JlojJ8m
         gE/MJC6XP601XHYgUcC7CwK0h5oQsphdiJaY+ORgc86Xy9i/tCIMgGSNj6s5E5tN9Nf4
         xFy6mmr2fr4ST6KL3YVoBZrbWzHgF6S+SHioERYOWOBHQFYos09lJwuZSX2Hw3QgES5M
         3anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhDaOseZ+6YnQA/A1swsQLNYw4MXMhXhVabFMVkbjsA=;
        b=cAL6Dqqt1mRicMW4ZVn/K50AwPZLzq02sm3+iyN32jn3ON0sbg9Q7jlnN9edKSDHbZ
         lGwjVrHZyf/xh4A6fQzJ4KZTsHIsQoBTTKN+gXKGtEdH0Qu5yKozbyHdGtMYvWKUbN8K
         WVGkYJCyKjYM2j7lnx/jBEHLwz653SBdNVoX3t5UDUH97JdGvRmX6maEOSCYTT7NIOB8
         QdSZlKhILY3hPj9R+m62uDiUklRRQI6dQ38dn2rj9cjgid5kBfXAZ4crOdWOKkaorqcn
         hfcfaL5U/5okpnwsK6liDzzKNaT9ime/GGmYQQkgBfQd4+USel3Gu1sz8SzAw2bBEAKv
         jsNA==
X-Gm-Message-State: AOAM532bmSc7uIZW1WbQj7lD1Y1RCT5ZOaTFGW8JklQ69Qxk47sfbMme
        x1fh74afd2CEIuTBCJJpGgjPUoxKfZLcIROefRgY
X-Google-Smtp-Source: ABdhPJy5wc63iGkmdpqsjqOAfxya/hW3WYIP6tNPKgTBYcPo6Q4Gyz4h8P7GJv9ljRe98jVMVm7NGJxJLm2zypBnC8A=
X-Received: by 2002:aa7:d687:: with SMTP id d7mr9399671edr.118.1617280093796;
 Thu, 01 Apr 2021 05:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210401090932.121-1-xieyongji@bytedance.com> <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com> <CACycT3ux9NVu_L=Vse7v-xbwE-K0-HT-e-Ei=yHOQmF66nGjeQ@mail.gmail.com>
 <YGWjh7qCJ8HJpFxv@kroah.com> <CACycT3uEGRiDuOj2XBwF2PmnGXsQgrLDemJDFRytsJiJMyRWDw@mail.gmail.com>
 <YGWvbAXQO2Vsiupo@kroah.com>
In-Reply-To: <YGWvbAXQO2Vsiupo@kroah.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 1 Apr 2021 20:28:02 +0800
Message-ID: <CACycT3vNaDg5twEpKtnZTjbyD=0FhZKJLzH+uBNQuyCmxFaeww@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH 2/2] binder: Use receive_fd() to receive file
 from another process
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jason Wang <jasowang@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christoph Hellwig <hch@infradead.org>,
        Hridya Valsaraju <hridya@google.com>, arve@android.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        maco@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 7:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 01, 2021 at 07:29:45PM +0800, Yongji Xie wrote:
> > On Thu, Apr 1, 2021 at 6:42 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Apr 01, 2021 at 06:12:51PM +0800, Yongji Xie wrote:
> > > > On Thu, Apr 1, 2021 at 5:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Apr 01, 2021 at 05:09:32PM +0800, Xie Yongji wrote:
> > > > > > Use receive_fd() to receive file from another process instead of
> > > > > > combination of get_unused_fd_flags() and fd_install(). This simplifies
> > > > > > the logic and also makes sure we don't miss any security stuff.
> > > > >
> > > > > But no logic is simplified here, and nothing is "missed", so I do not
> > > > > understand this change at all.
> > > > >
> > > >
> > > > I noticed that we have security_binder_transfer_file() when we
> > > > transfer some fds. I'm not sure whether we need something like
> > > > security_file_receive() here?
> > >
> > > Why would you?  And where is "here"?
> > >
> > > still confused,
> > >
> >
> > I mean do we need to go through the file_receive seccomp notifier when
> > we receive fd (use get_unused_fd_flags() + fd_install now) from
> > another process in binder_apply_fd_fixups().
>
> Why?  this is internal things, why does seccomp come into play here?
>

We already have security_binder_transfer_file() to control the sender
process. So for the receiver process, do we need the seccomp too? Or
do I miss something here?

Thanks,
Yongji
