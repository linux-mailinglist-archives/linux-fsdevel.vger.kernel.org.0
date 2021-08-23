Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DE93F5042
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhHWSRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 14:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhHWSRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:17:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B76BC061757
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 11:16:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mq3so12485062pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 11:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T/e63Wf9ypRN+awlAfBRrCYYd/VbmaKsvsurvbA7wIc=;
        b=m1nJ6UQpUZMQZEXws4qV4EMMw/Piswr/u1pJ1Yds/EbyDZvmhzmYhDnNG1D84SOJaB
         78Kf8ONJYlrhYKgoB5+PnpGVNxiPK3D9sR0rDkjCqi/uXNXD6T7wIUuqRjXCPHiC6EZg
         PBSYAMLhvYeDJ6rgS9H0bDc9UQ24GFEatSu/wckPceE31k9hf6xIlZPptBe95SwFBhLG
         eHGehbY0VXNnu7PROw0pOrH8ifZ+gICUyN3DT7Dsbu1yPDX7wKm7kj+MhHwF4VPoP85H
         IxHdXlNflBQfbmLa3FBfLXDzNVSW+9j6i2MgwQ7hbwsZA4zEuPkjf39LYfsLMveA02QO
         Bm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T/e63Wf9ypRN+awlAfBRrCYYd/VbmaKsvsurvbA7wIc=;
        b=kQBieyD9+CuHaHxf+JDBkk7mZl95HZ9gPPn91D0sBbGVF3Pg/BLJUzXoUfKPnFnbDK
         jbL4pvLbAlC7RqQhR4UQP6Psv014mWgfwyipsUoIOiVc7yNdgmcQYFIYm90TK0jEQypm
         gC37pO55OtkKPrWrNnWnEb+i0GNg2/ikc9VOBkiBN+f4JLeSqTiFpuclaxDtS8hb+LJI
         cf2HfhMptJRl2OPEiWe1RMUgH6SR5YZf4PPaIyIbO1RKdiWmr9aK9qDSlTKDmHRQd6/e
         EYOEhZl47163XieXPLqLMjsjJlb6nXFfWUsYciDUptiADC1ifOvn9OkyVLbFRQwoxeAV
         e/hA==
X-Gm-Message-State: AOAM531ABpYMKMPt6Lfw7o/XujM0Zux3OM4KqH90xA+Bc7dVOqfBdcsv
        9yBZ/k1wNkDq8+pS7X7+ybQftA==
X-Google-Smtp-Source: ABdhPJwZTTW2hZHD7QyizDV9IFI2swHkdvV9me5AhDi2mpH2G8+f2xJkz+ELwp8qyk9MSBYX7j1pPw==
X-Received: by 2002:a17:902:c94b:b0:130:ad84:990a with SMTP id i11-20020a170902c94b00b00130ad84990amr16825171pla.1.1629742611714;
        Mon, 23 Aug 2021 11:16:51 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:40e1])
        by smtp.gmail.com with ESMTPSA id t5sm16892169pfd.133.2021.08.23.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 11:16:51 -0700 (PDT)
Date:   Mon, 23 Aug 2021 11:16:30 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v10 06/14] btrfs: optionally extend i_size in
 cow_file_range_inline()
Message-ID: <YSPl/psinnRhev4x@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <a00b59623219c8a07f2c22f80ef1466d0f182d77.1629234193.git.osandov@fb.com>
 <1b495420-f4c6-6988-c0b1-9aa8a7aa952d@suse.com>
 <2eae3b11-d9aa-42b1-122e-49bd40258d9b@gmx.com>
 <YR/wQPJcv25vPIp7@relinquished.localdomain>
 <d7e302f9-7230-0065-c908-86c10d77d738@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7e302f9-7230-0065-c908-86c10d77d738@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 21, 2021 at 09:11:26AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/21 上午2:11, Omar Sandoval wrote:
> > On Fri, Aug 20, 2021 at 05:13:34PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/8/20 下午4:51, Nikolay Borisov wrote:
> > > > 
> > > > 
> > > > On 18.08.21 г. 0:06, Omar Sandoval wrote:
> > > > > From: Omar Sandoval <osandov@fb.com>
> > > > > 
> > > > > Currently, an inline extent is always created after i_size is extended
> > > > > from btrfs_dirty_pages(). However, for encoded writes, we only want to
> > > > > update i_size after we successfully created the inline extent.
> > > 
> > > To me, the idea of write first then update isize is just going to cause
> > > tons of inline extent related prblems.
> > > 
> > > The current example is falloc, which only update the isize after the
> > > falloc finishes.
> > > 
> > > This behavior has already bothered me quite a lot, as it can easily
> > > create mixed inline and regular extents.
> > 
> > Do you have an example of how this would happen? I have the inode and
> > extent bits locked during an encoded write, and I see that fallocate
> > does the same.
> 
> xfs_io -f -c "pwrite 0 1K" -c "sync" -c "falloc 0 4k" -c "pwrite 4k 4k"
> 
> The [0, 1K) will be written as inline without doubt.
> 
> Then we go to falloc, it will try to zero the range [1K, 4K), but it
> doesn't increase the isize.
> Thus the page [0, 4k) will still be written back as inline, since isize
> is still 1K.
> 
> Later [4K, 8K) will be written back as regular, causing mixed extents.

I'll have to read fallocate more closely to follow what's going on here
and figure out if it applies to encoded writes. Please help me out if
you see how this would be an issue with encoded writes.

> > > Can't we remember the old isize (with proper locking), enlarge isize
> > > (with holes filled), do the write.
> > > 
> > > If something wrong happened, we truncate the isize back to its old isize.
> > > 
> [...]
> > > > 
> > > > Urgh, just some days ago Qu was talking about how awkward it is to have
> > > > mixed extents in a file. And now, AFAIU, you are making them more likely
> > > > since now they can be created not just at the beginning of the file but
> > > > also after i_size write. While this won't be a problem in and of itself
> > > > it goes just the opposite way of us trying to shrink the possible cases
> > > > when we can have mixed extents.
> > > 
> > > Tree-checker should reject such inline extent at non-zero offset.
> > 
> > This change does not allow creating inline extents at a non-zero offset.
> > 
> > > > Qu what is your take on that?
> > > 
> > > My question is, why encoded write needs to bother the inline extents at all?
> > > 
> > > My intuition of such encoded write is, it should not create inline
> > > extents at all.
> > > 
> > > Or is there any special use-case involved for encoded write?
> > 
> > We create compressed inline extents with normal writes. We should be
> > able to send and receive them without converting them into regular
> > extents.
> > 
> But my first impression for any encoded write is that, they should work
> like DIO, thus everything should be sectorsize aligned.
> 
> Then why could they create inline extent? As inline extent can only be
> possible when the isize is smaller than sectorsize.

ENCODED_WRITE is not defined as "O_DIRECT, but encoded". It happens to
have some resemblance to O_DIRECT because we have alignment requirements
for new extents and because we bypass the page cache, but there's no
reason to copy arbitrary restrictions from O_DIRECT. If someone is using
ENCODED_WRITE to write compressed data, then they care about space
efficiency, so we should make efficient use of inline extents.
