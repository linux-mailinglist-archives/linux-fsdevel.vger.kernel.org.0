Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F8527FE7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbgJALek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 07:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbgJALek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:34:40 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A53C0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 04:34:40 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so6226064ior.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FhZCRnorfntLK1kfvWwzZ5IWtH5hTk+2zSmGcGKnwU=;
        b=GO2FKvDW9RBo0iO4fSY0zKQIbYCBgTBsvylWVCJefxuPHYWkqHknlWtvCqze7MimET
         gDh7zZcL4t3SglWae8A7G27LKpobRKVRhYK4C+nVBQ979dZ183dFoJ2jtJofTQmHnLmD
         bRHXIab+Yhb9mnmxFKzYjPf9hxCdUQbZSd+NYrfwBc9VCI0BFbbPQyyHzIDzQo2nN7Ef
         BjqrFsBChJoXjpuWnfyuEkDQ/0Xk4SZAQnps6+xam3nooV1NlVHkOv6ERMLZLeBkivqh
         LGaTT2NG5teYhsgYwbScCR0yBKXepyBC2xlfP7EKXQKCqMc9i2smjuVcXcSuywtyIZ8W
         FT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FhZCRnorfntLK1kfvWwzZ5IWtH5hTk+2zSmGcGKnwU=;
        b=oZTP0xSAWktxJ3alAc5Jx1vh7/9H74bqorQNaFzqlcvbF6bZx0AL01ioIZhoIqB9th
         em7oyDImUB1/nRA3si9l6/6JEZuuNNbhV5iqN5ShAF74oZEiV6sy+mWshi3W2zE2LPZn
         UvkFpudpBsPQAiuLhqHAdkoalxa6z2gy+1k104R8+DLol5wals34rXJhmMiz6dps/y59
         U5iHbRZ0doXqTi8SGLBzXqN+2rTNToVEp/ziKtS871BTtcNPW7TxWFjxuksWgMllWgps
         uOppVC2xzYYRyDQY4MawK5zC+Ia3tRgAJOCoM7/cO+2lUbLWJmeE5d4pOpu2H6aBA5Gw
         KiBw==
X-Gm-Message-State: AOAM530kvPksVyKYPpexJs+4OOQNCbVRZyIWu6wwVhAPoFHM4xgIkdp5
        ND0br5LsGoNKlYdJOoy31iz5yxy4Bw24UE4zB+JMoWQN
X-Google-Smtp-Source: ABdhPJxvHNbXjho1jt/H6IqPByxkftI1w+csup+4q8Qqi0djV8JXbvqoMAeNpy+RHc6+lRxNoo16WDaTwPoN8b5TCuc=
X-Received: by 2002:a05:6638:d46:: with SMTP id d6mr5832134jak.20.1601552078625;
 Thu, 01 Oct 2020 04:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANT5p=pvumVCNCLbSCaxgmfFLR-ifeQJrUETfG4ALxzfTRRxew@mail.gmail.com>
In-Reply-To: <CANT5p=pvumVCNCLbSCaxgmfFLR-ifeQJrUETfG4ALxzfTRRxew@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Thu, 1 Oct 2020 21:34:27 +1000
Message-ID: <CAN05THTANbmogCk6pXx7RtbKfb_OpUzNbvg5JyJdee5osJVDCw@mail.gmail.com>
Subject: Re: Error codes for VFS calls
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        Steve French <smfrench@gmail.com>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 1, 2020 at 8:59 PM Shyam Prasad N <nspmangalore@gmail.com> wrote:
>
> Hi developers,
>
> I seek your opinions about the error codes returned by the Linux
> filesystem for the I/Os triggered by users. In general, each VFS
> system call (open, read, write, close, stat) man page defines a
> limited set of error codes returned by the call, and the meaning of
> the error, in the context of that call.
>
> But in many cases, especially in network based filesystems, this
> limited set of error codes may not be sufficient to indicate the exact
> problem to the user. For example, in case of SMB3, where things like
> authentication or actual mount of the filesystem may be delayed to the
> point of first I/O by the specific user on the mount point, having a
> limited set of error codes could end up confusing the user, and not
> indicate the actual error to the user.
>
> So my questions here:
> 1. Should the error codes be specific to the filesystem in question,
> and not just specific to the VFS system call?
> 2. Do we have any other mechanism of returning a custom error message
> to the user (the one that tells the user about the exact problem in
> more detail), other than to print this in the logs?

In short.
We are limited by what the manpage lists as valid errno values in the manpages.
This is what applications and glibc is coded against.

Other mechanisms/side-channels may be possible.
dmesg or /var/log/messages comes to mind.
But we cant break the userspace api.

>
> --
> -Shyam
