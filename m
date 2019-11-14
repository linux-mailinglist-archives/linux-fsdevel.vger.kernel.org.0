Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E62FC953
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 15:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfKNO4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 09:56:15 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39410 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKNO4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:56:15 -0500
Received: by mail-il1-f194.google.com with SMTP id a7so5577194ild.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 06:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtNC3DCT1+p+B/9UUHW4/yZiHAI0wPUVZr+uFA8Etkg=;
        b=PwZpjfZXbQCzjCPSLznOzq/afrnTnJF7lnnV0Nsi8jKcZcEMyLaRNPdqKann2L5t/R
         7F+5Eue/xaV2aERKiMQxYmS2vsqFwBGhUl3cxuCE+8NlewV+46HvnynfU0qbwE0htPAM
         rrysoHv2rRf7mTEwjgoYgftxQ+UMYadNJneK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtNC3DCT1+p+B/9UUHW4/yZiHAI0wPUVZr+uFA8Etkg=;
        b=k/aKF5BVLo6jPErQIVYJd/DgUuy2rHN5N1TcmYOol4/VWwqB/ptcZYnVj9C6BxRsoR
         pMVAPvCYPmJRQYdwIZ0flMmeGc1DuPBr7E32awHtD7qDSp6ZBQLa9WDRk9LX4WHAcbzW
         YWA7x1W+VsZOk+8KH0UhfjC6K7vOEXzLhGJt7UAvgMZXTen3uocjGD9CrqPtjLflY2dN
         5NQrxYo5ejGNL9JRLJ3O3ZCAcAXO7tbya7Jpr5212SZIcbWgr8yOwETfryGE4E4RVhyq
         YEcKyUVc8tKlzDnm0S0j7mEmmlaxRC1C1YJGyDKSY0FfuDsHSMvPvtz4x39wfMityno8
         Sqyg==
X-Gm-Message-State: APjAAAWEoWqk9ZjSZkmNFoEUPYsUuT1gtNFDw6mgNaK/gAPzSuTGJkng
        hO0mffP/ZjLV9xa8vnLo9R+bWsyrdDFbe+1Gye8e0Q==
X-Google-Smtp-Source: APXvYqxEFGlkuYg0qko+FzksrbzDuAF0iP16PMh2OjeSsEUnRxtKxBmoSu6MVj8gNYORjLjR5GP7YhCYIFKb19KL514=
X-Received: by 2002:a92:6407:: with SMTP id y7mr9935528ilb.285.1573743374206;
 Thu, 14 Nov 2019 06:56:14 -0800 (PST)
MIME-Version: 1.0
References: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
 <20191024023606.GA1884@infradead.org> <20191029160733.298c6539@canb.auug.org.au>
 <514e220d-3f93-7ce3-27cd-49240b498114@plexistor.com>
In-Reply-To: <514e220d-3f93-7ce3-27cd-49240b498114@plexistor.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Nov 2019 15:56:03 +0100
Message-ID: <CAJfpegtT-nX7H_-5xpkP+fp8LfdVGbSTfnNf-c=a_EfOd3R5tA@mail.gmail.com>
Subject: Re: Please add the zuf tree to linux-next
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 3:02 PM Boaz Harrosh <boaz@plexistor.com> wrote:

> At the last LSF. Steven from Red-Hat asked me to talk with Miklos about the fuse vs zufs.
> We had a long talk where I have explained to him in detail How we do the mounting, how
> Kernel owns the multy-devices. How we do the PMEM API and our IO API in general. How
> we do pigi-back operations to minimize latencies. How we do DAX and mmap. At the end of the
> talk he said to me that he understands how this is very different from FUSE and he wished
> me "good luck".
>
> Miklos - you have seen both projects; do you think that All these new subsystems from ZUFS
> can have a comfortable place under FUSE, including the new IO API?

It is quite true that ZUFS includes a lot of innovative ideas to
improve the performance of a certain class of userspace filesystems.
I think most, if not all of those ideas could be applied to the fuse
implementation as well, but I can understand why this hasn't been
done.  Fuse is in serious need of a cleanup, which I've started to do,
but it's not there yet...

One of the major issues that I brought up when originally reviewing
ZUFS (but forgot to discuss at LSF) is about the userspace API.  I
think it would make sense to reuse FUSE protocol definition and extend
it where needed.   That does not mean ZUFS would need to be 100%
backward compatible with FUSE, it would just mean that we'd have a
common userspace API and each implementation could implement a subset
of features.    I think this would be an immediate and significant
boon for ZUFS, since it would give it an already existing user/tester
base that it otherwise needs to build up.  It would also allow
filesystem implementation to be more easily switchable between the
kernel frameworks in case that's necessary.

Thanks,
Miklos
