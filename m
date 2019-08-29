Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3780A1D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfH2Or3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 10:47:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42316 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfH2Or3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:47:29 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so5453021iod.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kmZfKphmPDJyPhB1aEwSutJQo/nVZHIpGqlV62NkC0=;
        b=CQYTV7T/6dptI2gBfu2uXwU4RqC1UIrULXwa1LcNs212HPvwiKRj5wzH9w17HNj1/S
         xgABLrdaMQrQKih8MZ3en05XSPZ6cYtpvN8zEPBJT0wL6K+HI44uIDZofAFjGDHjjwcZ
         LWo+0RcMIe0icmrDfhi9RpZ6cZJmo1ANKTqLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kmZfKphmPDJyPhB1aEwSutJQo/nVZHIpGqlV62NkC0=;
        b=ECHRsL+/0hU55NxyIw1zeMqZnSBdyrsQ2Xlm08ZYrjs6CBQVJgHhERgy0UfpeR5bGc
         KTbHx2ONvGWiiHlBzDw1GTQvQltHvobNP5o+YhPHpOGMLSzdJz9zZp0sFpqCbw9ik347
         o32xArXnYcZKzedJP1KKQIRVQA7Pa6VXyxBxWYLoHSYpFCpWu0gWASrqFnHVURD1+/5e
         gvmw3Ilmdr54vdl5/h3z+w9l6MzkAh+UPAkgSzq5CvddajtbQ38lri+DxJ3b3r8O7Gw7
         mwcOqFe5Q/o2qRxTTUX89w526dPyQSOuerJjRWea29PSS1jYvmmTyFK7VHTAoHP0ixeb
         gq9g==
X-Gm-Message-State: APjAAAWulKkSSKEdmP4k5Ui/yyqhdshdvls7mUhoadxfBuKxxeZFamMG
        hBUQ+/FpWe38ACX0ZLYDLgSPz/r8U4aqEfvwII/d+g==
X-Google-Smtp-Source: APXvYqzC9sQXggpAZSpx4nKtBi8MjQ5jIGvf78c61EYJdJ7tngwSYacvoloREplBdZk2eAZlmMR9aiBXIUXMXSL2oBM=
X-Received: by 2002:a05:6638:627:: with SMTP id h7mr11129076jar.33.1567090048417;
 Thu, 29 Aug 2019 07:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com> <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
 <20190829132949.GA6744@redhat.com> <CAJfpegtd-MQNbUW9YuL4xdXDkGR8K6LMHCqDG2Ppu9F_Hyk2RQ@mail.gmail.com>
 <20190829143107.GB6744@redhat.com>
In-Reply-To: <20190829143107.GB6744@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Aug 2019 16:47:17 +0200
Message-ID: <CAJfpegtOC8dHofLmpYpryKv9+93KHwn9Xb-NCyvgg0rG8XspTw@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual machines
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 4:31 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> Cool. That works. Faced another compilation error with "make allmodconfig"
> config file.
>
>   HDRINST usr/include/linux/virtio_fs.h
> error: include/uapi/linux/virtio_fs.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
> make[1]: *** [scripts/Makefile.headersinst:66: usr/include/linux/virtio_fs.h] Error 1
>
> Looks like include/uapi/linux/virtio_fs.h needs following.
>
> -/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */

Fixed and pushed.

Thanks,
Miklos
