Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FAA2754E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 11:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgIWJ5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 05:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWJ5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:57:01 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D9DC0613CE;
        Wed, 23 Sep 2020 02:57:01 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y13so22998005iow.4;
        Wed, 23 Sep 2020 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mQ0aj960a7RVZHIGZZAGMeUhM0butXCj6YzXOVIy1I=;
        b=sRdg64pRyDDN/T2g0q3D5ISVio8iK5nvZeaNn0anwUyPsOQD0QHf8nARyYUlpA3i5m
         NL+NNP0O72mAzZpPdRXviIJsw0V5oi30JqfXqhnzLRebuRwplEWIzDlYpYiGuzx+wT5y
         hMAWO8NBXGvK6vORNGJXpOxeoI5uDRHKVuzeGgcY47fZ0YK7wvmrcDGPvYamOt6brZj6
         RohyqUVVf1t4M6aP8q6tP7iQs7rgk9ViYMTtwj439PAqJ+y+Ic/dzoevvKkjUm/Vsgwp
         39eDOu2rmNMGm6u8+C/R7WXZT0AUjnxmqBvgMWOU+ez7bDOr4fs166mHvHecRbt2oUfh
         a2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mQ0aj960a7RVZHIGZZAGMeUhM0butXCj6YzXOVIy1I=;
        b=ca9AKME7wbgUcO0MB+fasJenNla5VDj4Mv6swstGzOzFG7ltMpzGcz6Gh//6/CYHZF
         ouHvb/i8jbOP5Pma73F4HnF7wSSgjUXj9V/pQ26fKsvSSid7HI1Wvw9MEIOqB5UsAKeZ
         IIpZZuK9AJIGqjfmXyvDyFR9XOwJAxRX0OaSIg/uGhkEMZe+DKVXMt5LhWZJcemBRh1W
         VAJhYIGPhD+q3qRIqR9eZZgVhS4ZCWf8c5xykbhCx5v0eiLg9oz6OB/yP+0F/6FitZR4
         IDYdKnKyGJIScqLUfwUInAQ46KETOMbO9IoXz69KcONGsFWSe135wSeRQZhDechMZlfx
         IQFA==
X-Gm-Message-State: AOAM533R2J9akY5+RgZhabh72wRabBItH2SYVhnN1YEXRQwc3Tv+7M/k
        WsPbEoD7m/udcu5eCbnybXdprUpLRRuSRp8mNbOKOcdxxE0=
X-Google-Smtp-Source: ABdhPJz/KpbTpVRf47HrMkPmdOW4tzubkRJVeTwGVsKpsZ1Ue3/1zls0KrbCTeU+FFabCd6sd1jj81iOBUAnOAdcb8o=
X-Received: by 2002:a05:6602:2f8a:: with SMTP id u10mr6637527iow.72.1600855020585;
 Wed, 23 Sep 2020 02:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
In-Reply-To: <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Sep 2020 12:56:49 +0300
Message-ID: <CAOQ4uxgKr75J1YcuYAqRGC_C5H_mpCt01p5T9fHSuao_JnxcJA@mail.gmail.com>
Subject: Re: virtiofs uuid and file handles
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Sep 23, 2020 at 4:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I think that the proper was to implement reliable persistent file
> > handles in fuse/virtiofs would be to add ENCODE/DECODE to
> > FUSE protocol and allow the server to handle this.
>
> Max Reitz (Cc-d) is currently looking into this.
>
> One proposal was to add  LOOKUP_HANDLE operation that is similar to
> LOOKUP except it takes a {variable length handle, name} as input and
> returns a variable length handle *and* a u64 node_id that can be used
> normally for all other operations.
>
> The advantage of such a scheme for virtio-fs (and possibly other fuse
> based fs) would be that userspace need not keep a refcounted object
> around until the kernel sends a FORGET, but can prune its node ID
> based cache at any time.   If that happens and a request from the
> client (kernel) comes in with a stale node ID, the server will return
> -ESTALE and the client can ask for a new node ID with a special
> lookup_handle(fh, NULL).
>
> Disadvantages being:
>
>  - cost of generating a file handle on all lookups

I never ran into a local fs implementation where this was expensive.

>  - cost of storing file handle in kernel icache
>
> I don't think either of those are problematic in the virtiofs case.
> The cost of having to keep fds open while the client has them in its
> cache is much higher.
>

Sounds good.
I suppose flock() does need to keep the open fd on server.

Are there any other states for an open fd that must be preserved?

Thanks,
Amir.
