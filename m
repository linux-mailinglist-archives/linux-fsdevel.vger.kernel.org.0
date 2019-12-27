Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D1212B5A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 16:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfL0PdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 10:33:02 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41924 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0PdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 10:33:02 -0500
Received: by mail-il1-f193.google.com with SMTP id f10so22668692ils.8;
        Fri, 27 Dec 2019 07:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9cPm3vqG7hGU4wLY/J1RzTvaKshMDxfqOe3tJcxdms=;
        b=CjaD/9UWaOdGTzJL0ZCIPxTJLTslA4mxVbd8+540q9kUZydT7eevq8oLiC44/qu1/a
         bQNQ2dDLDS5kgiU/Gqmn2ZrmxOG40u3QVwGN45RK+j6tI/hs3u3ADjyrDlXTzdalEr+7
         AHjMsa8bLRNkZBrgoJ5mbkHjP+J7v7sE6xxL8kv0L6BM/e923D+NIgZvnjrGsnhxlYQc
         2SS+z2f6wVZ8Y04/7O7XBhyalGhrXLOJDZjZD+IFZufegBDLjsDnzneFVK/2rUg/NKGS
         zF+1svHrKsPxb3VQ8tAL8Iy8SrpAQ+29ayKnBThOh0aXA7Ydc1Z5ltiPuMsf47zruj2i
         gOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9cPm3vqG7hGU4wLY/J1RzTvaKshMDxfqOe3tJcxdms=;
        b=YQNkZ5z2KzwlvkkFSMq5G5Ld8+umhLYnvQAbAsTikubyQXCfctmHDdM+EJY/D+3/sh
         uDzt0J1s2sjuACrRfBxKxneq53Ppi3RuhHSFjDBHwFiysvMEfcXTCDMehmdmwokCu7qA
         75wRKrjOzV3XmVxSIHYWzkbA3FAMn2oWcrOVl2HKIrCey/4Dp2iTAkRZxl8MaLm95Z8L
         PLlr/2jY7drHwwp4isXb5CfLUjypRYJf5SLkAF0sHEfYPJFqj/RPtjOFQAgvwPD5WhfC
         w7ws3Pb9B8/TkxUMSeX8jDLeUc8D7QulWytbgpM06gMl7eeVVNTOjA0PZcwu77de8BpS
         33Rg==
X-Gm-Message-State: APjAAAXGzArUZrQhPt4GJnC9OuR4hd7diKbfUZTbLzZffey1HXTLpmkF
        H1zAOI82YsXeIR+qI1evgZAAl4hYlCkxHCNWNyq7i0wK
X-Google-Smtp-Source: APXvYqzX2qFVNAxM5G2wHZ/X/+KgKejycb30U1EaIwQ1aIzO5uthpGLDxaXbd5sPkYyzhTl8+7IQR3W1IvRr+dOsPC4=
X-Received: by 2002:a92:88d0:: with SMTP id m77mr47162823ilh.9.1577460781452;
 Fri, 27 Dec 2019 07:33:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577456898.git.chris@chrisdown.name> <28599683653d3fa779442a24b3b643bc395d88d0.1577456898.git.chris@chrisdown.name>
In-Reply-To: <28599683653d3fa779442a24b3b643bc395d88d0.1577456898.git.chris@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 27 Dec 2019 17:32:50 +0200
Message-ID: <CAOQ4uxhLVW3ck_xhXbYgY3xYVOHaKGTht_UYZ4Y9NWL7kXZ1rw@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs: inode: Add API to retrieve global next ino using
 full ino_t width
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 27, 2019 at 4:30 PM Chris Down <chris@chrisdown.name> wrote:
>
> We can't just wholesale replace get_next_ino to use ino_t and 64-bit
> atomics because of a few setbacks:
>
> 1. This may break some 32-bit userspace applications on a 64-bit kernel
>    which cannot handle a 64-bit ino_t -- see the comment above
>    get_next_ino;
> 2. Some applications inside the kernel already make use of the ino_t
>    high bits. For example, overlayfs' xino feature uses these to merge
>    inode numbers and fsid indexes to form a new identifier.
>
> As such we need to make using the full width of ino_t an option for
> users without being a requirement.
>
> This will later be used to power inode64 in tmpfs, and can be used
> elsewhere for other filesystems as desired.
>

Unless I am missing something, I think the fact that get_next_ino()
is a global counter was short sighted to begin with or it was never
intended to be used for massive usage fs.

So I think that introducing another global counter to be used
intentionally for massive usage is a mistake.

I think tmpfs should be converted to use a per-sb ino allocator.
When it's per-sb allocator, implementing the option if ino numbers
are 32bit or 64bit per instance won't be a problem.

Thanks,
Amir.
