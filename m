Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9F3F53BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 01:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhHWXq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 19:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhHWXqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:46:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D22CC061757
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 16:46:11 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so13021872pjv.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 16:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mmb9QhGfp85d1j6oVD2UpQrvT2lgsqs0P3HseXWNRW0=;
        b=i/ncSj+jpCKCXXBFvHyJqUxOlQwwNeb+T68r+CZ19bGK9iOsdtXjrhpHBs2dC5AIVW
         svkvDNuR2R7o76puPQN1vFv38aQNtV0HTYrgFYw+pGt5eIsmlJnekbVy8TYqx2mWEydb
         Vh+umlenb6luwSr8W913wNjfNKYsllIKCp+8HWVZ4uPFMhbxbZ7fOERDSj2m1Q5+YEvo
         /NEHxFxzMirY9xxFG/p52m34EL6fAN8hce9Ix8kvNxcC6mI5J4HYteHykcFySGbhr2wl
         nHqwlPv/1HYTWg99Fz0NpjanJlnXzsWlnxv092sP1uY9HJIeVyKLSzgM2Ta1jj+5LYZP
         IBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mmb9QhGfp85d1j6oVD2UpQrvT2lgsqs0P3HseXWNRW0=;
        b=pZ2IKCPToDRrhvQcE6xgyialG0IZm7SQX55tyqTohNIf6N39/0d5RVlH93SqL6NFF6
         nnG5cEw3Zhrzmss3rhZ9sT+zQRz72778ATcfTsxt9Ml7mxUU4+hyk8HEX5TxxuOOuv2K
         nd1XRd1Z3zD1ev8XKejLdscYR2/BRU0gxKRyXSqxv3NaFJtvk+JSxhntCP/TMBP5ktbb
         066F3s2+geDWiEtdEl/8g7r+PXeE82nITkYQghXG62uoORAdOdiAoXrIfURmdeKaFuKW
         iaQ0APpCDP0+mpUr1VPdV9SaDBxfILFAtuKqsf6EjJiAGvyXPl8vr1hEwoKEVrzfXz1x
         kwqg==
X-Gm-Message-State: AOAM530axoo/jrfS2q8/VdcgPAxXodGOH0JE3SV4Zo3JFBVvwdt1+c9O
        whxVpNh9ibV/rT4Hnb16Mj96KA==
X-Google-Smtp-Source: ABdhPJyRJam+Dk6RoVqEHFVFNafYswiqLRNselBAUirhTVizoAXqhDMNha8bn8f3eNwHOyTmjxzA4w==
X-Received: by 2002:a17:902:9009:b0:12d:8de4:bc2d with SMTP id a9-20020a170902900900b0012d8de4bc2dmr30955096plp.44.1629762370928;
        Mon, 23 Aug 2021 16:46:10 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:40e1])
        by smtp.gmail.com with ESMTPSA id p10sm16296451pfw.28.2021.08.23.16.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 16:46:10 -0700 (PDT)
Date:   Mon, 23 Aug 2021 16:46:08 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v10 06/14] btrfs: optionally extend i_size in
 cow_file_range_inline()
Message-ID: <YSQzQNMLy3qOY9VW@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <a00b59623219c8a07f2c22f80ef1466d0f182d77.1629234193.git.osandov@fb.com>
 <1b495420-f4c6-6988-c0b1-9aa8a7aa952d@suse.com>
 <2eae3b11-d9aa-42b1-122e-49bd40258d9b@gmx.com>
 <YR/wQPJcv25vPIp7@relinquished.localdomain>
 <d7e302f9-7230-0065-c908-86c10d77d738@gmx.com>
 <YSPl/psinnRhev4x@relinquished.localdomain>
 <5a35da37-1504-361a-46bc-3fe1c1846871@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a35da37-1504-361a-46bc-3fe1c1846871@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 07:32:06AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/24 上午2:16, Omar Sandoval wrote:
> > On Sat, Aug 21, 2021 at 09:11:26AM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/8/21 上午2:11, Omar Sandoval wrote:
> > > > On Fri, Aug 20, 2021 at 05:13:34PM +0800, Qu Wenruo wrote:
> > > > > 
> > > > > 
> > > > > On 2021/8/20 下午4:51, Nikolay Borisov wrote:
> > > > > > 
> > > > > > 
> > > > > > On 18.08.21 г. 0:06, Omar Sandoval wrote:
> > > > > > > From: Omar Sandoval <osandov@fb.com>
> > > > > > > 
> > > > > > > Currently, an inline extent is always created after i_size is extended
> > > > > > > from btrfs_dirty_pages(). However, for encoded writes, we only want to
> > > > > > > update i_size after we successfully created the inline extent.
> > > > > 
> > > > > To me, the idea of write first then update isize is just going to cause
> > > > > tons of inline extent related prblems.
> > > > > 
> > > > > The current example is falloc, which only update the isize after the
> > > > > falloc finishes.
> > > > > 
> > > > > This behavior has already bothered me quite a lot, as it can easily
> > > > > create mixed inline and regular extents.
> > > > 
> > > > Do you have an example of how this would happen? I have the inode and
> > > > extent bits locked during an encoded write, and I see that fallocate
> > > > does the same.
> > > 
> > > xfs_io -f -c "pwrite 0 1K" -c "sync" -c "falloc 0 4k" -c "pwrite 4k 4k"
> > > 
> > > The [0, 1K) will be written as inline without doubt.
> > > 
> > > Then we go to falloc, it will try to zero the range [1K, 4K), but it
> > > doesn't increase the isize.
> > > Thus the page [0, 4k) will still be written back as inline, since isize
> > > is still 1K.
> > > 
> > > Later [4K, 8K) will be written back as regular, causing mixed extents.
> > 
> > I'll have to read fallocate more closely to follow what's going on here
> > and figure out if it applies to encoded writes. Please help me out if
> > you see how this would be an issue with encoded writes.
> 
> This won't cause anything wrong, if the encoded writes follows the
> existing inline extents requirement (always at offset 0).
> 
> Otherwise, the read path could be affected to handle inlined extent at
> non-zero offset.
> 
> > 
> > > > > Can't we remember the old isize (with proper locking), enlarge isize
> > > > > (with holes filled), do the write.
> > > > > 
> > > > > If something wrong happened, we truncate the isize back to its old isize.
> > > > > 
> > > [...]
> > > > > > 
> > > > > > Urgh, just some days ago Qu was talking about how awkward it is to have
> > > > > > mixed extents in a file. And now, AFAIU, you are making them more likely
> > > > > > since now they can be created not just at the beginning of the file but
> > > > > > also after i_size write. While this won't be a problem in and of itself
> > > > > > it goes just the opposite way of us trying to shrink the possible cases
> > > > > > when we can have mixed extents.
> > > > > 
> > > > > Tree-checker should reject such inline extent at non-zero offset.
> > > > 
> > > > This change does not allow creating inline extents at a non-zero offset.
> > > > 
> > > > > > Qu what is your take on that?
> > > > > 
> > > > > My question is, why encoded write needs to bother the inline extents at all?
> > > > > 
> > > > > My intuition of such encoded write is, it should not create inline
> > > > > extents at all.
> > > > > 
> > > > > Or is there any special use-case involved for encoded write?
> > > > 
> > > > We create compressed inline extents with normal writes. We should be
> > > > able to send and receive them without converting them into regular
> > > > extents.
> > > > 
> > > But my first impression for any encoded write is that, they should work
> > > like DIO, thus everything should be sectorsize aligned.
> > > 
> > > Then why could they create inline extent? As inline extent can only be
> > > possible when the isize is smaller than sectorsize.
> > 
> > ENCODED_WRITE is not defined as "O_DIRECT, but encoded". It happens to
> > have some resemblance to O_DIRECT because we have alignment requirements
> > for new extents and because we bypass the page cache, but there's no
> > reason to copy arbitrary restrictions from O_DIRECT. If someone is using
> > ENCODED_WRITE to write compressed data, then they care about space
> > efficiency, so we should make efficient use of inline extents.
> > 
> Then as long as the inline extent requirement for 0 offset is still
> followed, I'll be fine with that.
> 
> But for non-zero offset inline extent? It looks like a much larger
> change, and may affect read path.
> 
> So I'd prefer we keep the 0 offset requirement for inline extent, and
> find a better way to work around.

Ah, okay. I didn't get rid of the 0 offset requirement and I have no
plans to. In fact, this patch kind of does the opposite: it gets rid of
the start parameter to cow_file_range_inline() because it doesn't make
sense for it to ever be anything other than 0 (and we're already
checking that start == 0 in the callers).
