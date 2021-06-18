Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C023AD3A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhFRUf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 16:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhFRUfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:35:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E2EC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 13:33:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i34so3126434pgl.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dBupA0cw4fGlGHNhQTeiFf/7oeykwehM09DA//j5e80=;
        b=p7YzoDzkMk1aefCeei3yHDw+EPcyoaLrxZant/piLqfdVMyXLD0OUDe1FfO0kP4lBJ
         6s23x0AdwT0euuDaUP00XlN5ZzdLH2CJF41ICFzwG9UaEXtyOsoLzKQfyORIo4VDTNoi
         iOLsEH/M7d6uYcJXO1g+z8oR+JMf+otrcMskpBJEfcqDXA5sdwcG4F/iK3HGQ/Gx+/7p
         MWwgGC73aW9yB1fsqujKxxHv57lcDbWq3rVoaAJdUuTIaaivDnMKL68fnTk4HG4zTQLs
         oU+5CVBVmmd29TodWdKSTS+DKwJhfqsn+O+Sw1e/TxEMPXwr7tSB8uMrc/bQTunM5Y6o
         Oz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dBupA0cw4fGlGHNhQTeiFf/7oeykwehM09DA//j5e80=;
        b=I9ort1tsSx3TAuMVOimgpGfemvM4ni4vE9eIhCghlU5KvLZ9YBx6ilcObqUKfRWQXT
         70YKrU5BrYhadT3V2SFeXalcW8Pe268Yg/speMdtQ+BVJ79/e5d93d/ukqjXKDlfXpKp
         MUqx6wzwGeAUZvQR4QQdSLo4qnxjarr3c25l1cm5nVVhxRnizRvoJ1IFIUjse1VlzAOq
         /mEIVcK5dWP6/fIlYnbEzJ3WP2uCAIMP1XhI16tlpoN+GqH0Uy01+yIog27+AT7/K9c6
         JwZZY/z+U4g7UBiV0LebIy/Q6yMgMvxprDY/9eIDNRJftIKGSgyZwP4yBNZpHm4UDwVZ
         /eag==
X-Gm-Message-State: AOAM531u5rpa7f8CiI9nmjG82MkKrua1lBuaXsRsv3CyPeaLFyzwu9YL
        Pc3K2kCvAQtgJbmqcZEdlNNgltc6ZY4vYw==
X-Google-Smtp-Source: ABdhPJxUpD4js+w4MnYq1QQkw8BD839hhy3h9W1qVAit6f8xvXVDJhrmLqPIcsX8Uj4y4m/n2vmG8Q==
X-Received: by 2002:a05:6a00:7ca:b029:2fc:daf6:d0f0 with SMTP id n10-20020a056a0007cab02902fcdaf6d0f0mr6832895pfu.15.1624048395531;
        Fri, 18 Jun 2021 13:33:15 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:41cb])
        by smtp.gmail.com with ESMTPSA id g17sm2245281pfv.62.2021.06.18.13.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:33:15 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:33:13 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YM0DCRMz0dktOvQn@relinquished.localdomain>
References: <cover.1623972518.git.osandov@fb.com>
 <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
 <YMz44XVVIlQw2Z6J@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMz44XVVIlQw2Z6J@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 07:49:53PM +0000, Al Viro wrote:
> On Fri, Jun 18, 2021 at 07:42:41PM +0000, Al Viro wrote:
> 
> > Pipe ones are strictly destinations - they can't be sources.  So if you
> > see it called for one of those, you've a bug.
> > 
> > Xarray ones are *not* - they can be sources, and that's missing here.
> > 
> > Much more unpleasant, though, is that this thing has hard dependency on
> > nr_seg == 1 *AND* openly suggests the use of iov_iter_single_seg_count(),
> > which is completely wrong.  That sucker has some weird users left (as
> > of #work.iov_iter), but all of them are actually due to API deficiencies
> > and I very much hope to kill that thing off.
> > 
> > Why not simply add iov_iter_check_zeroes(), that would be called after
> > copy_from_iter() and verified that all that's left in the iterator
> > consists of zeroes?  Then this copy_struct_from_...() would be
> > trivial to express through those two.  And check_zeroes would also
> > be trivial, especially on top of #work.iov_iter.  With no calls of
> > iov_iter_advance() at all, while we are at it...
> > 
> > IDGI... Omar, what semantics do you really want from that primitive?
> 
> And for pity sake, let's not do that EXPORT_SYMBOL_GPL() posturing there.
> If it's a sane general-purpose API, it doesn't matter who uses it;
> if it's not, it shouldn't be exported in the first place.
> 
> It can be implemented via the already exported primitives, so it's
> not as if we prevented anyone from doing an equivalent...

Fair enough, I'll fix that.
