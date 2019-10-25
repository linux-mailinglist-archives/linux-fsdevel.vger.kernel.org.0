Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31AE4A0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 13:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfJYLfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 07:35:32 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42881 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfJYLfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:35:32 -0400
Received: by mail-il1-f194.google.com with SMTP id o16so1525276ilq.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 04:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1b1sJRR8uGtQj2FhrTPypk+/a4UxvaBsPLPDsEX5mJs=;
        b=Y1QJCZEWt34OZkweqTGCRXSrS9a3ROOBaXAODcX3a38kZtOAkVMLjl1g/Ux91+Y6mP
         mQk1OwZzJWlAdaZiLPpVIw4uwG2GfWWhpbYgHhSesuRUohORK0Mum2dax/vGVBtc2IlY
         bp5ke93WyeTZBvQRKvZRf/X5EMNps0PxvFmoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1b1sJRR8uGtQj2FhrTPypk+/a4UxvaBsPLPDsEX5mJs=;
        b=uDBk5C49ALa/QFz3e+1MMDWLIa4oUnKU1f9W9yM1svQoIBbyYPxsan8OOrP7gbanCr
         kJmLwYF+9Ig68f1JbMvwvNX6REn3ACcHPgSTgFq2a3IbSVunIIVvUjGrisjWdrMkGMdq
         rCWaIvJKqye6iuRJgTsRRnceA5deyk57myF8YCgXs2mGeoJlyt+G8WYIGSR861ib32Yu
         n9y6Q/rGXrvzgOsb9M64lOgTrgAvUHJh6TcORM4iLn0eIoGZjnpusWRJn76eddQK1mwT
         5elxaMbTkQifXbNtMCZVPkYQTbesPrwTspf3lrL6fn4HReeG2G5uXHL8PyNIuA+SG4vM
         p+kQ==
X-Gm-Message-State: APjAAAWPNytmZyDZMCxcF3KlnSdi/oKEwZNs8/Ruh04Tig780j4Vq8Kk
        l9uYpcUX0xMwRIDpob2HhOcJYYqm4/LEbzeCZbDefw==
X-Google-Smtp-Source: APXvYqxcGpnrVgHOfwUkSRzKsKbaYPJTX2ifjXfnD38ngz8j9EFntIjY8HvgftcIOjcxV9UB9XkiUwlH49BuRJYuNLM=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr3426726iln.285.1572003331734;
 Fri, 25 Oct 2019 04:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191025112917.22518-1-mszeredi@redhat.com>
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 25 Oct 2019 13:35:20 +0200
Message-ID: <CAJfpegv1SA7b45_2g-GFYrc7ZsOmcQ2qv602n=85L4RknkOvKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] allow unprivileged overlay mounts
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 1:30 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Hi Eric,
>
> Can you please have a look at this patchset?
>
> The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
> whether I'm correct in stating that this isn't going to introduce any
> holes, or not...

Forgot the git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#ovl-unpriv

Thanks,
Miklos
