Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927A04157E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 07:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbhIWFn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 01:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhIWFnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 01:43:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4206C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 22:42:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f129so5232854pgc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 22:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIeswu2kPZeMqIRSa83Ms0km/4F7Tf+r++V3y3fcOFU=;
        b=jsLYrvv0vM8Vx25YhzrFK8nZMFePboSHvbJoHCUZ19pahlhDV37JwulIOJIUBjsOoY
         IwxouG8cTRfy6bqzI2MyOmlwJQU5iH6tZn9a/kUd8bEuTIugm3BISsT7DmR7DQQVN0d2
         Hp8noekCagVPbEmOl+agCcQFzy41Eu4Vp+M+APf6DZCWgYpxwTDTUgVFiSSblFbOrOD5
         7RsKAN13lcl8S0a83epRtQPgSBawOQorSdxyyZ39K6M8bMb/Owd0yeEKMKrdEVhWZqei
         IfJi/AyLjEumWr9i6eEhRiVkY3aNzdXBpvDkHpmCjte5KL1pjbMrVPaFSpn33KMDrxgH
         MmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIeswu2kPZeMqIRSa83Ms0km/4F7Tf+r++V3y3fcOFU=;
        b=10Ma7PMOOflEkIZDWOFCXQ1stEXLBFGYC9hiik1CKwcae5Cr52jaG+aBGwkifab+YU
         bRzu++xwxt65Qd/Bo4K/qdxMLVs3xu1b6s8bIp+uNU+MAiOtGS0YLe7McQWLiNJ17seF
         gJr6OFEKd2AArj4nlDrFOMffDE9DGmdh/wI/zkzzpVhEffwmTCnlXlwsLpY+5oEwFl+B
         3T9N0uZPvWhQu7ewkMoTgkO9VX6w/biyVSpsNKbyt0BcksTusXFZ5oqqMrxStyeOJWuy
         fi9idUrfMkqlcReTbgBHqqyacDtoCOeEfdxJGso38K/r+SpxZlWK4bvS+daeufRVnkoR
         T4Aw==
X-Gm-Message-State: AOAM531mRKxId9YmXQPTTFGABAEXNK7RIh3vQeKQC/bfTHPHWqbnZhgq
        sNzoLnD5De73FfCLVsaZoTqJfjdc0hKKzI+FKz1pxQ==
X-Google-Smtp-Source: ABdhPJwYgyp6Mh9HCnuRK/sKHAPHJlmd78V8lsW+htD76tFuXvFRyisy4kC6BMOY/ncY7vO4Ehu8wlbqufVEXgR0Xsc=
X-Received: by 2002:a62:7f87:0:b0:444:b077:51ef with SMTP id
 a129-20020a627f87000000b00444b07751efmr2693613pfd.61.1632375744469; Wed, 22
 Sep 2021 22:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <163192866125.417973.7293598039998376121.stgit@magnolia>
 <20210921004431.GO1756565@dread.disaster.area> <YUmYbxW70Ub2ytOc@infradead.org>
 <CAPcyv4jF1UNW5rdXX3q2hfDcvzGLSnk=1a0C0i7_UjdivuG+pQ@mail.gmail.com>
 <20210922023801.GD570615@magnolia> <20210922035907.GR1756565@dread.disaster.area>
 <20210922041354.GE570615@magnolia> <20210922054931.GT1756565@dread.disaster.area>
 <20210922212725.GN570615@magnolia> <20210923000255.GO570615@magnolia>
 <20210923014209.GW1756565@dread.disaster.area> <CAPcyv4j77cWASW1Qp=J8poVRi8+kDQbBsLZb0HY+dzeNa=ozNg@mail.gmail.com>
In-Reply-To: <CAPcyv4j77cWASW1Qp=J8poVRi8+kDQbBsLZb0HY+dzeNa=ozNg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 22 Sep 2021 22:42:11 -0700
Message-ID: <CAPcyv4in7WRw1_e5iiQOnoZ9QjQWhjj+J7HoDf3ObweUvADasg@mail.gmail.com>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 7:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Sep 22, 2021 at 6:42 PM Dave Chinner <david@fromorbit.com> wrote:
> [..]
> > Hence this discussion leads me to conclude that fallocate() simply
> > isn't the right interface to clear storage hardware poison state and
> > it's much simpler for everyone - kernel and userspace - to provide a
> > pwritev2(RWF_CLEAR_HWERROR) flag to directly instruct the IO path to
> > clear hardware error state before issuing this user write to the
> > hardware.
>
> That flag would slot in nicely in dax_iomap_iter() as the gate for
> whether dax_direct_access() should allow mapping over error ranges,
> and then as a flag to dax_copy_from_iter() to indicate that it should
> compare the incoming write to known poison and clear it before
> proceeding.
>
> I like the distinction, because there's a chance the application did
> not know that the page had experienced data loss and might want the
> error behavior. The other service the driver could offer with this
> flag is to do a precise check of the incoming write to make sure it
> overlaps known poison and then repair the entire page. Repairing whole
> pages makes for a cleaner implementation of the code that tries to
> keep poison out of the CPU speculation path, {set,clear}_mce_nospec().

This flag could also be useful for preadv2() as there is currently no
way to read the good data in a PMEM page with poison via DAX. So the
flag would tell dax_direct_access() to again proceed in the face of
errors, but then the driver's dax_copy_to_iter() operation could
either read up to the precise byte offset of the error in the page, or
autoreplace error data with zero's to try to maximize data recovery.
