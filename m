Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECDC275267
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 09:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIWHoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 03:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWHoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:44:18 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E01C0613D1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 00:44:18 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id z46so6328677uac.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 00:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rl19lI+kzmvLV+RTaRC2uHmkNHy2s32s2TlrNNmSXiI=;
        b=EDFoI7PiyIzC8lWlUiL1PpQxuozqM9FpybG0HWP7YEbQj8TOWbMzvV7mNyiz4I44kY
         V0a3gByPJEx+VHK9ovn7jeb2B6qKvNFlpva2wWMCVQK39wQ8SajNBxmUvCC5oxcN+a7K
         96/dG58Y2X5+z6Bl+UC7Pt11ameOiROtv5wZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rl19lI+kzmvLV+RTaRC2uHmkNHy2s32s2TlrNNmSXiI=;
        b=tTqcEGBvwBzX4/gl9q/vCwYL1OzNgBgS0739SG24QHgYUZaXkOl+FGPlLqstGz4Gtn
         P+4OZ+jWw2GiycR32iewXCieDcpjj6rMvQqmZ/EExafrKRj8zZE+WZX/246cLpxY3VYk
         QcmiwK9rJZApZ4tqHBDVrDKe0IfPIyrfIPNUbXii1uMuVK5Jk7PAINzgDG4TgLE5PyX4
         zxGNz0hmuws437C+hD7NHuLnNFmtrB0v48NsoZIBGd5A7rZmsV2JG2UDmoL+T9jK8eZp
         kfWPx9F9OIfv6kD5gXUkrky8gaqmoU8vrNXiUNMlelS0TNwddaPoBmDhfJgWDLR3CJkN
         zo6w==
X-Gm-Message-State: AOAM532GBa7+5Hb+N4CBGZL6fDmZo+CGy7+vzkYMM4BnbeLQMpu6vNdz
        A+TwYlc9rNQhiUhbPJ3JdyZYRRXUVHOQFxDqKNAo7g==
X-Google-Smtp-Source: ABdhPJxfmBPlZ+telSSrlZN0qAwufcsB4ufZxJNuUCefdCwzZZ5LDOhEUknY1T4dPkEPWXD4hRf2kao3fkIKF9qMcm4=
X-Received: by 2002:ab0:6298:: with SMTP id z24mr6015411uao.105.1600847057500;
 Wed, 23 Sep 2020 00:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
In-Reply-To: <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Sep 2020 09:44:06 +0200
Message-ID: <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
Subject: Re: virtiofs uuid and file handles
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 4:49 AM Amir Goldstein <amir73il@gmail.com> wrote:

> I think that the proper was to implement reliable persistent file
> handles in fuse/virtiofs would be to add ENCODE/DECODE to
> FUSE protocol and allow the server to handle this.

Max Reitz (Cc-d) is currently looking into this.

One proposal was to add  LOOKUP_HANDLE operation that is similar to
LOOKUP except it takes a {variable length handle, name} as input and
returns a variable length handle *and* a u64 node_id that can be used
normally for all other operations.

The advantage of such a scheme for virtio-fs (and possibly other fuse
based fs) would be that userspace need not keep a refcounted object
around until the kernel sends a FORGET, but can prune its node ID
based cache at any time.   If that happens and a request from the
client (kernel) comes in with a stale node ID, the server will return
-ESTALE and the client can ask for a new node ID with a special
lookup_handle(fh, NULL).

Disadvantages being:

 - cost of generating a file handle on all lookups
 - cost of storing file handle in kernel icache

I don't think either of those are problematic in the virtiofs case.
The cost of having to keep fds open while the client has them in its
cache is much higher.

Thanks,
Miklos
