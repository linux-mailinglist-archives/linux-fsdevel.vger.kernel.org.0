Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA627D11A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 16:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgI2OaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 10:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2OaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:30:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E406CC0613D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 07:30:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so5061576wmi.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uFKLSPWDwm3eYZd6YdR+/hX/HXeA1BnZbw8cxB8l5tM=;
        b=WLRfbKRyHsDE1KbYQsDpufajswYgeVpkZCRZM2rE14Jx7ciTmLPeGxQab+NzzN1k4g
         X38WvCMV7E6erCcNfmdeLauHb9a0J2yy59NWFf7U4SB4Nn5QQLSnv62rv02144hynjG1
         FC2+vhsot7ySsIfREUOKkn6m84xWWEHKFkGxbh5DUhhIyCgeCACveM1dRvWE2Z/W52gS
         rehupa2hgU+q9dKjrg1/rS7wAZi18abSfFEBZlkig2QH6c3KhY+Jk4QZ3PdJX7AnJ4L4
         zTuPzu5OqmGNZxTG8L5M8dcP8kULVBC1icpmpqxdIdcUf5m3qdvNnjdNjePEG0NJoGYg
         TFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uFKLSPWDwm3eYZd6YdR+/hX/HXeA1BnZbw8cxB8l5tM=;
        b=EhSgjfHsSN+QbcJxzP2OoevroauHllkFByoB/qcNpuzY0R0EyRYGJz6G/LDSNZQrEs
         6cXnRsFpzweMniPj8YUaXDei83BtM1yXnh/tEThAlQQxuF23qwYaGUhIuWk/Ruz/kCf1
         IE735h1E47VnSQvVXUm+fUO4Qf+KCRwQn/zvqR8E5x1JMndRRyyNUCCjYBjHSBd7K8Qu
         ONFLa6WsdXjWiga7rBtncyW23iHgiENXkdCPrCfIfyOOjBt/l0oTTyiVw7yPwp6mpoDD
         8pPKs45ePp50os1HV50zfywC+9Iji2hkaR9mAVb1QiyKU/5PjzCuYffLlghrDNbC0RLw
         8qVA==
X-Gm-Message-State: AOAM531ED9PwEgA1wMtmNvYZFRSkmuZT9TJ7P+7bbYoqpu1jgZWhpihJ
        XgTFnYe7+6bxCtLBaAA+2rK6nQ==
X-Google-Smtp-Source: ABdhPJykPpWjvgERiuRHSP5oeS8qkCVKd3aWFFRAg7EnL8L6Ivoa6wZFihmDj+vUefS/lJFiUhefWw==
X-Received: by 2002:a1c:f716:: with SMTP id v22mr4675565wmh.183.1601389813562;
        Tue, 29 Sep 2020 07:30:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id n10sm6012031wmk.7.2020.09.29.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 07:30:12 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:30:11 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 1/3] fuse: Definitions and ioctl() for passthrough
Message-ID: <20200929143011.GA1680101@google.com>
References: <20200911163403.79505-1-balsini@android.com>
 <20200911163403.79505-2-balsini@android.com>
 <CAOQ4uxiWK5dNMkrriApMVZQi6apmnMijcCw5j4fa2thHFdnFcw@mail.gmail.com>
 <20200918163354.GB3385065@google.com>
 <CAOQ4uxhNddkdZ5TCdg6Gdb9oYqNVUrpk25kGYxZNe-LDsZV_Ag@mail.gmail.com>
 <20200922121508.GB600068@google.com>
 <CAOQ4uxjFjpbVBQ6zAhtVfjB=+_T48m1c-cdA-Qr+O=2=6YmW3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjFjpbVBQ6zAhtVfjB=+_T48m1c-cdA-Qr+O=2=6YmW3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:08:48PM +0300, Amir Goldstein wrote:
> 
> I am hearing about a lot of these projects.
> I think that FUSE_PASSTHROUGH is a very useful feature.
> I have an intention to explore passthrough to directory fd for
> directory modifications. I sure hope you will beat me to it ;-)


It's awesome that you mentioned this, something similar is already in my
TODO list, suggested by Paul (in CC). I'll start working on this and will
be glad to discuss as soon as this FUSE_PASSTHROUGH extension will
hopefully get accepted.


> 
> > I'm not directly involved in the Incremental FS project, but, as far as I
> > remember, only for the first PoC was actually developed as a FUSE file
> > system. Because of the overhead introduced by the user space round-trips,
> > that design was left behind and the whole Incremental FS infrastructure
> > switched to becoming a kernel module.
> > In general, the FUSE passthrough patch set proposed in this series wouldn't
> > be helpful for that use case because, for example, Incremental FS requires
> > live (de)compression of data, that can only be performed by the FUSE
> > daemon.
> >
> 
> Ext4 supports inline encryption. Btrfs supports encrypted/compressed extents.
> No reason for FUSE not to support the same.
> Is it trivial? No.
> Is it an excuse for not using FUSE and writing a new userspace fs. Not
> in my option.


I started exploring the FUSE internals only in the last months and had the
feeling this compression feature was a bit out of context or at least very
use-case specific. But I'll start thinking about this.


> 
> > The specific use case I'm trying to improve with this FUSE passthrough
> > series is instead related to the scoped storage feature that we introduced
> > in Android 11, that is based on FUSE, and affects those folders that are
> > shared among all the Apps (e.g., DCIM, Downloads, etc). More details here:
> >
> 
> sdcard fs has had a lot of reincarnations :-)
> 
> I for one am happy with the return to FUSE.
> Instead of saying "FUSE is too slow" and implementing a kernel sdcardfs,
> improve FUSE to be faster for everyone - that's the way to go ;-)


Yes! This is exactly what we are trying to achieve and this patch-set is
the first piece of a bigger picture which, among others, includes the
direct directory access that you mentioned before.
I hope the community appreciates these improvement attempts :)

As you may have noticed, I recently shared the v9 of the patch-set.
Thanks to the feedback I received, what we have now has a completely
different than the initial proposal.

Thanks again everyone for the suggestions!

Alessio
