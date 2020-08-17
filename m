Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF89246D8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgHQRCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 13:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbgHQRCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:02:44 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9BDC061389
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 10:02:44 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r13so10719485iln.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/xTApNuRmjuImNJLZt8rI74ilUKCgdSz9ipdIgPFX0=;
        b=n+86zwrZeFVQCUKh7JBN5laccODgw3J+MomGCsfVlbwdODvilUKwGQuqFmGQ8Vcdoo
         IhMkdyR2tzipWt/BIXHxt5jPKr97MZoIDlL2jAcQuuo3eg4DAiAQu2/NoId0fbBF0WvN
         sIZaz84WZMFZaQgvZ9Aljz70os6NJO/7iKpkbbHZ5ygvQCu9x7bZfgkKMij7ZNXctEZ3
         x3JUvlVXHEj+yCq/ta4h47xpw6lTyO9Wd5eNNqhlEiQeDCDO8sXMg+iFNUnu15cVE6WF
         UhMkULBHghKCk8xTQKA5ujE9HGO49Z8DkZBeiHVDDI6RJfBewAOPdhmW/dNMnnNKZy6m
         WDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/xTApNuRmjuImNJLZt8rI74ilUKCgdSz9ipdIgPFX0=;
        b=ALGx5uDNmN+Jak9YTWbxiU7TfThA6RqqS0Hv78MIY4SG6da7azYc1aEHS846ctYN4/
         bcXeRo17u2gAg1yWcyhoheM3QV5YN8PuscCM7U/g4IQ+nR6Fj5plX7we2eJ2ErBbMgRs
         7C/uVKwoVwoGQxgPf0OHP+hEiO8+NhbPHpK8SvKVJY5aq9G4Hti//3hfszdE4kd+msWh
         BenBNiawzGVvn2s+D0pv7acmtVyzYpv46lMsbgHKGsAazCGZv1FS7XLgl7vAUITyF0IQ
         PV94Ql4uhnE5n4W5Tao7QPoUyYPmK5C+JmjP4b5CImzZokNcfvY1NrHtjwjVn6qs/QOX
         9agw==
X-Gm-Message-State: AOAM530nqql4f4SfEf/JvhwUDfLgxXmFMJyOBX66+LfDeZ9m5/TAt8K2
        R2/rz4B5SZC+8KLdIqabBtE+jBryofR6OPJOqC4=
X-Google-Smtp-Source: ABdhPJx2QTk6Qu49gkIfZnWEPIY5Rnax1nDLj645UuNFDh4JdyKq9M4YkGcyDUFrwf6qXlxxkjpOhdFMjJM4/Xg8Emo=
X-Received: by 2002:a05:6e02:dc3:: with SMTP id l3mr14916147ilj.137.1597683762528;
 Mon, 17 Aug 2020 10:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <dde082eb-b3eb-859e-b442-a65846cff6fa@mail.de>
In-Reply-To: <dde082eb-b3eb-859e-b442-a65846cff6fa@mail.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Aug 2020 20:02:31 +0300
Message-ID: <CAOQ4uxjEm=vj5Be5VoUyB9Q+YVq=+aO_4PfXp-iEYZA7qzO1Gw@mail.gmail.com>
Subject: Re: fanotify feature request FAN_MARK_PID
To:     Tycho Kirchner <tychokirchner@mail.de>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 7:08 PM Tycho Kirchner <tychokirchner@mail.de> wrote:
>
> Dear Amir Goldstein,
>

Hi Tycho,


> Dear Matthew Bobrowski,
>
> Dear developers of the kernel filesystem,
>
> First of all, thanks for your effort in improving Linux, especially your
> work regarding fanotify, which I heavily use in one of my projects:
>
> https://github.com/tycho-kirchner/shournal
>

Nice project!

> For a more scientfic introduction please take a look at
> Bashing irreproducibility with shournal
> https://doi.org/10.1101/2020.08.03.232843
>
> I wanted to kindly ask you, whether it is possible for you to add
> another feature to fanotify, that is reporting only events of a PID or
> any of its children.
> This would be very useful, because especially in the world of
> bioinformatics there is a huge need to automatically and efficiently
> track file events on the shell, that is, you enter a command on the
> shell (bash) and then track, which file events were modified by the
> shell or any of its child-processes.

I am not sure if fanotify is the right tool for the job.
fanotify is a *system* monitoring tool and its functionality is very limited.
If you want to watch what file operations a process and its children are doing,
you can use more powerful tracing tools like strace, seccomp, and eBPF.
For starters, did you look at bcc tools, for example:
https://github.com/iovisor/bcc/blob/master/tools/opensnoop.py

[...]

> I imagine e.g. the following syscalls:
>
> 1.
> Use fanotify_mark to restrict the fanotify notification group to a
> specific PID, optionally marking forked children as well.
> fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_PID, FAN_EVENT_ON_CHILD,
> pid, NULL);
> // FAN_EVENT_ON_CHILD -> additional meaning: also forked child processes.
>

Technically, it is quite easy to filter out events generated by
processes outside
pid namespace (which would report pid 0), but I doubt if the use case you
presented justifies that. Maybe there are other use cases...

> 2.
> Use fanotify_mark to remove a PID from the notification group.
> fanotify_mark(fan_fd, FAN_MARK_REMOVE | FAN_MARK_PID, 0, pid, NULL);
>
> 3.
> When reading from a fan_fd, which is marked for PID's which have all
> ended or were removed, return e.g. ENOENT.
>
>
> Independent of that it would be also useful, to be able to track
> applications, which unshare their mount namespace as well (e.g.
> flatpak). So in case a process, whose mount points are observed,
> unshares, the new mount id's should also be added to the same fanotify
> notification group. To preserve backwards compatibility I suggest
> introducing a new flag FAN_MARK_MOUNT_REC:
> fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT |
> FAN_MARK_MOUNT_REC, mask, AT_FDCWD, path);
>

The inherited mark concept sounds useful.
I also thought of a likewise flag for directories.
The question is if and how you clean all the inherited marks when program
removes the original mark. It's an API question. Not a trivial one IMO.

The thing is, with FAN_MARK_FILESYSTEM (v5.1), you can sort of implement
what you want in userspace with the opposite approach:
1. Watch events on filesystem regardless of which mount
2. When getting an event with an open fd, resolve the mount
3. If you are NOT interested in that mount add a FAN_MARK_IGNORED
    mask on that mount
4. Soon, you will be left with only the events you care about
5. When mount is unshared, you will get the events generated on that mount

But that will only work if the unshared mount is visible in the mount namespace
of the listener, so it is not a complete solution, but maybe it works for some
of your use cases.

Thanks,
Amir.
