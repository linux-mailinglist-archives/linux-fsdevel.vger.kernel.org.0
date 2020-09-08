Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B535F26136D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgIHPVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbgIHPUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:20:55 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8295C061260;
        Tue,  8 Sep 2020 06:18:40 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t13so15292398ile.9;
        Tue, 08 Sep 2020 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lehgm/Rq7isVWXVQNzNLtCDwhCMjbkLID23x9t0QSo=;
        b=QsMtBJA4wDAM0+eNZBCS8AAytf2a8zJ4Bvi/ltiQqSzkq0OI68bxVecEgPnXVQ3DKa
         SPxgWdvgTmvK/3vG7R75MyQupY6kSTWR3GZk6jgK3sLW6FdBsmz9mheY/wmEdJEjtzcb
         klBrXzYmpDE6aE7OcNF+QFyxcO0e5IdwUsBOZJBWFgBuo0u7rqOvMzscyNQG5zD6mfku
         wRxVRXMqjvN/xHLRDdZ9f6QSVVNIaw1vJyCgoa7XfIEAq3KCbmvfXId6Fxa5O+JUOY61
         337DeOi3ymFN+mzxUBQ+iHDz/8AxWBYN0Oj+iNlN50EuOf48TQw8qDtVnXSbQ8qVhHO0
         3KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lehgm/Rq7isVWXVQNzNLtCDwhCMjbkLID23x9t0QSo=;
        b=VAthukq15bBOzs9EYft4xkaTiE61MxFXBlefxRCIAkGvKXvX6zoyk3igvCQ1e+aVp0
         cmKKDD1P4IFq2SJyt7JIDHfbOIx8fuRkRaTlbRQPGfgi1+3aUqC/WOuqaiPexZfyYJ88
         2ylyQDfhtY5UHhmfK25WXXapjRLER/Jj/cE4bFkMZjU14KYlUjxdMvV1gvvyHNTobJPL
         tMLvyyztUUo/EP2DCqf7ZFdg1q4NICLzjnv3RRxiecuqWLTOA9orvhdX9qwxj0RPrzb6
         eME74XHABNi0oHgmp/lcxZo12U0y1qKOJcmLuGt6dE/U+IbgMw+sjqZRI3d/Yme3edsD
         wnIA==
X-Gm-Message-State: AOAM530SZ6SYAVzvj08VB1H26HOMy1PtgHwXdXYy5YhK3vQ3fRdzSuyY
        OZd5L+dhie2jjXF4D68BZoyxHuJv7RdXMe9Lkwb1/MMX
X-Google-Smtp-Source: ABdhPJwFwQYkncfI9eCpCYuGm9Uout+XFJS9CaqWfrNxMgGxaQgK6+Z0VCKrVf5xph6x30PSKENhBgFbkfQv7frQWbk=
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr23165007ils.72.1599571120307;
 Tue, 08 Sep 2020 06:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
 <CAOQ4uxhejJzjKLZCt=b87KAX0sC3RAZ2FHEZbu4188Ar-bkmOg@mail.gmail.com> <e399cd17-e95e-def4-e03b-5cc2ae1f9708@huawei.com>
In-Reply-To: <e399cd17-e95e-def4-e03b-5cc2ae1f9708@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Sep 2020 16:18:29 +0300
Message-ID: <CAOQ4uxgvodepq2ZhmGEpkZYj017tH_pk2AgV=pUhWiONnxOQjw@mail.gmail.com>
Subject: Re: Question: Why is there no notification when a file is opened
 using filp_open()?
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangle6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 8, 2020 at 3:53 PM Xiaoming Ni <nixiaoming@huawei.com> wrote:
>
> On 2020/9/8 18:06, Amir Goldstein wrote:
> > On Tue, Sep 8, 2020 at 11:02 AM Xiaoming Ni <nixiaoming@huawei.com> wrote:
> >>
> >> The file opening action on the system may be from user-mode sys_open()
> >> or kernel-mode filp_open().
> >> Currently, fsnotify_open() is invoked in do_sys_openat2().
> >> But filp_open() is not notified. Why? Is this an omission?
> >>
> >> Do we need to call fsnotify_open() in filp_open() or  do_filp_open() to
> >> ensure that both user-mode and kernel-mode file opening operations can
> >> be notified?
> >>
> >
> > Do you have a specific use case of kernel filp_open() in mind?
> >
>
> For example, in fs/coredump.c, do_coredump() calls filp_open() to
> generate core files.
> In this scenario, the fsnotify_open() notification is missing.
>

I am not convinced that we should generate an event.
You will have to explain in what is the real world use case that requires this
event to be generated.

Thanks,
Amir.
