Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1363E577181
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jul 2022 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiGPVPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jul 2022 17:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPVPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jul 2022 17:15:52 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E96D1C93D
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 14:15:51 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n138so5225001iod.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fasheh-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXwAtYHDLkKJYs4e5FWBe16fehyQkKfM+VbEIEUNjGg=;
        b=qeefqlcFqmL7DZe4LCinIR/1oAjCQcUbVNoh84kUKWyg+y/Nze1zAoDFtkZu+eJ4NS
         xhggHl32+4GrB5vmhFf1qBQqn78iTy97gbr4mrXCK4GxkJHPENlj3O671vZ0iXV/6xHM
         xkZLonpPts5I24wFGWjM5VlkHZS4IHlXNhu7+ultrt5Z8mKWT7F/aq6WtNPbx1xO5tnR
         Gl91U5db/7tkN6VW6Bz9VCgCjeHgQeH6JIdIHp0gsnvaewlr3aew1Wv2VqZtJx0JFZIo
         i3FMHwnwboiKyZYGex0un8JQub5ag4mBJSmkloSMdUx/ZGO0q6gGTACaGQ/OEq+srfrO
         g9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXwAtYHDLkKJYs4e5FWBe16fehyQkKfM+VbEIEUNjGg=;
        b=6LSrLKYtRwfu7sQrh8re4ztKDbnxwmEKHU9UsKBpxjHJxuFlPDMCitIRjSntQJN2Sf
         3nvDQYOQDSyZUgRVr9W5rLSxBGKHKHhM0C7sqOy5FhHI4UOzZTEBvrO/4kc9miR4ickg
         0gMvdkGdeWzuzMnJ3m8PRMm6GrIkwPrdE2QYyEUcETX8Cfts5mYYZQO9HtxlpMlVPDlK
         xi1kstnUg6z27xWtVpC8bujMx+pgJH9ekXn0oN5/QswCH9ilyeLhDBOpEissXXZNawqU
         lT+t6j+GBHZY1HoyXUFtC1edJhkYxAUoWF4X48Ap2il8wNuN1gtStALyGzB7MLYM61gr
         M5HA==
X-Gm-Message-State: AJIora+bkCVkN7QUniA3eRjsZNIysGpJn4iwRP7IsFXNu7RCSb9a3uug
        QEbFkfy77AqCV8WwBbI+RsODdlOdbCPh8KzeqwrU6g==
X-Google-Smtp-Source: AGRyM1vfp6lvN4+fUcAFD9JTwlc9HALcWC8bN5F5MjpZ3UlyFbLFTdYYIfk+x4Un0tnI3Guq6UUEUaYBbmFmrfeJ5dg=
X-Received: by 2002:a6b:e011:0:b0:67b:cf17:ddb8 with SMTP id
 z17-20020a6be011000000b0067bcf17ddb8mr7455772iog.44.1658006150750; Sat, 16
 Jul 2022 14:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain> <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia> <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area> <20220713074915.GD3600936@dread.disaster.area>
 <5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de> <CAHk-=wgw3mWybD3E4236sGjNdnFsR60XHKhQNe0rJW5mbhqUAA@mail.gmail.com>
 <b5805118-7e56-3d43-28e9-9e0198ee43f3@tu-darmstadt.de> <20220714002219.GG3600936@dread.disaster.area>
In-Reply-To: <20220714002219.GG3600936@dread.disaster.area>
From:   Mark Fasheh <mark@fasheh.com>
Date:   Sat, 16 Jul 2022 14:15:41 -0700
Message-ID: <CAGe7X7nODT8bvutnCcZhh1OdaoUvJwHnSPmXsAQkjq-yJ+muyg@mail.gmail.com>
Subject: Re: [PATCH] vf/remap: return the amount of bytes actually deduplicated
To:     Dave Chinner <david@fromorbit.com>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On Wed, Jul 13, 2022 at 5:22 PM Dave Chinner <david@fromorbit.com> wrote:
> e.g. If userspace is looping over a file based on the returned
> info->bytes_deduped value, can this change cause them to behave
> differently?

My memory is a bit fuzzy on all of this but I'm pretty sure that this
is what duperemove does. From what I recall, 'bytes_deduped' got
turned into 'this is how far into the request I went'. Not the
greatest I know, but as you point out, it works and we shouldn't break
it.

Thanks,
  --Mark
