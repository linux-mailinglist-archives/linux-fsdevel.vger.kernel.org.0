Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6115A3E87A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 03:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhHKBXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 21:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhHKBXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 21:23:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400E2C0613D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 18:22:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u16so535367ple.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 18:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wvfj8vwrt4A0hMP72Gk0ySr0IJ8+ImiWZtVOCuOcHSY=;
        b=FOYbqCxsoDMlYpiL99q9G3QZnNTKRACL84KDh4Pd2mV9mJP0edv7JgLtbYLZ6lEklU
         JA2IkJUjaAdBTizEGSZJDqQb5LZhTAYnr7E1a1FHQdXxGbaZWWCpjh7xSTidlEIhqvQt
         qPPXXaYbjU1hVypIkXou+BOavFVHcBXLWsUnkOA/d7PDlArzrHpw0dIoVMgUcfDmfYcl
         3gEaVQZsYFysgGE+MwFWUxvzOWk9tpIwH9FuKNygtHMF0h723DADORuHi5ssC6d9mziZ
         u9ScP7taIighsDxLa2+on3U3ifgKi/b9oN4Rkxye5HnEV6UBVwHQfxkHx233ehj8k6Tj
         FDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvfj8vwrt4A0hMP72Gk0ySr0IJ8+ImiWZtVOCuOcHSY=;
        b=S0r7hHrBpmPqEtvwZnyEeb5B8QKxNFJgEQMKXrTKqxlQv/aklW67NtWkp60WE7Tj9Q
         V3CWk/6YuxvWu9hJereNGI1nSBAOEpo/Jam+ykgctFbnsqNB5wadUoysuXQJPCae9Ut5
         MdAnYlVTokUEoF8GJYPlo1Mmr/ZpRANqwbIv4GBZUO96XI59Z6v79Yn7R2DZLC2wrdiE
         lR1w7P8bynPgHK5cFtUEnYgo/n5s4xA4X0xuRW7odpDenlG06id9PWY8ZvdXHoC73VZc
         zAl4Ziaj5Yv9JqCglbjt9PqetTzQcTPW/Ek4Us7WUWssxfBj0xp8xVBeimzSFywenS5C
         xzHw==
X-Gm-Message-State: AOAM531Qr3L5viMrN0h4c/uob80soZhrII3e6LM4eANAR6ZNkcQEc6e2
        EyZ6VOf7ne4Q4zHSAaFqCcbGNQ==
X-Google-Smtp-Source: ABdhPJzHxV8Z/vE0z9m4qpkACUKHoKOzNrr01UnkqxMY7HTWlOa71y7jk7StQ6IstgTzCBNr5feMRg==
X-Received: by 2002:a63:120e:: with SMTP id h14mr410653pgl.215.1628644976557;
        Tue, 10 Aug 2021 18:22:56 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:46f7:f8ea:5192:59e7])
        by smtp.gmail.com with ESMTPSA id 141sm124108pfv.15.2021.08.10.18.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 18:22:55 -0700 (PDT)
Date:   Wed, 11 Aug 2021 11:22:41 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add pidfd support to the fanotify API
Message-ID: <YRMmYWHSno/IGhTN@google.com>
References: <cover.1628398044.git.repnop@google.com>
 <20210810113348.GE18722@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810113348.GE18722@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 01:33:48PM +0200, Jan Kara wrote:
> Hello Matthew!
> 
> On Sun 08-08-21 15:23:59, Matthew Bobrowski wrote:
> > This is V5 of the FAN_REPORT_PIDFD patch series. It contains the minor
> > comment/commit description fixes that were picked up by Amir in the
> > last series review [0, 1].
> > 
> > LTP tests for this API change can be found here [2]. Man page updates
> > for this change can be found here [3].
> > 
> > [0] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhnCk+FXK_e_GA=jC_0HWO+3ZdwHSi=zCa2Kpb0NDxBSg@mail.gmail.com/
> > [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgO3oViTSFZ0zs6brrHrmw362r1C9SQ7g6=XgRwyrzMuw@mail.gmail.com/
> > [2] https://github.com/matthewbobrowski/ltp/tree/fanotify_pidfd_v2
> > [3] https://github.com/matthewbobrowski/man-pages/tree/fanotify_pidfd_v1
> > 
> > Matthew Bobrowski (5):
> >   kernel/pid.c: remove static qualifier from pidfd_create()
> >   kernel/pid.c: implement additional checks upon pidfd_create()
> >     parameters
> >   fanotify: minor cosmetic adjustments to fid labels
> >   fanotify: introduce a generic info record copying helper
> >   fanotify: add pidfd support to the fanotify API
> 
> Thanks! I've pulled the series into my tree. Note that your fanotify21 LTP
> testcase is broken with the current kernel because 'ino' entry got added to
> fdinfo. I think having to understand all possible keys that can occur in
> fdinfo is too fragile. I understand why you want to do that but I guess the
> test would be too faulty to be practical. So I'd just ignore unknown keys
> in fdinfo for that test.

Excellent, for merging these changes!

In regards to the LTP test (fanotify21), at the time of writing I had also
shared a similar thought in the sense that it was too fragile, but wrongly
so I weighed up my decision based on the likelihood and frequency of fields
being changed/added to fdinfo. I was very wrong...

Anyway, I will fix it so that any "unknown" fields are ignored.

/M
