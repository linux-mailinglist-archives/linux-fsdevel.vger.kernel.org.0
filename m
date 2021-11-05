Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820C4445D58
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Nov 2021 02:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhKEBh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 21:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKEBh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:37:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9315C061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Nov 2021 18:35:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u11so10138474plf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Nov 2021 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+r8LSqikMIilQXxN0nyoS2okHlFhIR7lspEguCYFa0=;
        b=KLVm3GA6EsbW5lEpuwpZ3bWD6edBgWdpThXC4PmysSycODxJwt5aPWM1XdIVyt70zu
         zZIHLob5VTFB9bMKtsocBIHuMWtEGqLgep6Tbyo0WB13vQk+cj0f3t+LvnnrI8N70mw0
         RscuxQHCCpaQ8++RuGokESm1xDmRYn5KNzgEU+yZ5WdY0lvEDWGa9+kubM4yGg9feP2j
         bNpHUGc8OzE5F5KOK1fwG0rEzCe6coKb2u4symBRKNTBmRihxTEtYbKfFmvBvRPRT4L8
         7O43kfBZEMbQCJxm4+KrWJq/mnjFySFMlWS+pBDNe2DMB/vMhyBzkrBZEcat78XUaQE0
         EW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+r8LSqikMIilQXxN0nyoS2okHlFhIR7lspEguCYFa0=;
        b=swerRZdq89jXTLoWnlin/FAO67338wZV8kZ8ZXuAJH2XyRAO4iolYfTnNpI1jeeYs3
         hDBwTpEreWzFY6KvapoSppTNG8IUjUdYIxy16vud+wo93GiiEg5LHYb/b1p34hfcBOox
         WxSLF/I5mLPam8InPmZ8jeGsgsFCaCJ7JDWmwvQxKWCuNrGCmzqVsk2KRx9XLELtyjc3
         RhxjplnZncl1Rpn8JpN+ImCkYXIPUtB2HRnYWFclLoPhhKPJ2OqOYuXfm40yWRsnpPLb
         i4Aa139J86zx2311mn/n/sJxtKJ+lmakMREMq/iJrV67FXf3l/NYTuOuum36McJzbWjp
         l2FQ==
X-Gm-Message-State: AOAM531Z49PW0opumlvCL5Z7A75BOUuurQMNyIUQBFsQuQ8VpY/FNJfn
        W9XvvCmOFjU+QlH70iWuJ6m4uOOn1xOJoC4e7DH/9Q==
X-Google-Smtp-Source: ABdhPJz1em1qltzKGt1ubVwIZtwjqPkj5fokslj5L/imxnRNQj9GTwkrfgkmhMUWrwfqIVtIAQM1IvqAgAXnAyo/9a8=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr3596462pjb.220.1636076119266;
 Thu, 04 Nov 2021 18:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <YXFPfEGjoUaajjL4@infradead.org> <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org> <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org> <20211028002451.GB2237511@magnolia>
 <YYDYUCCiEPXhZEw0@infradead.org> <CAPcyv4j8snuGpy=z6BAXogQkP5HmTbqzd6e22qyERoNBvFKROw@mail.gmail.com>
 <YYK/tGfpG0CnVIO4@infradead.org> <CAPcyv4it2_PVaM8z216AXm6+h93frg79WM-ziS9To59UtEQJTA@mail.gmail.com>
 <YYOaOBKgFQYzT/s/@infradead.org> <CAPcyv4jKHH7H+PmcsGDxsWA5CS_U3USHM8cT1MhoLk72fa9z8Q@mail.gmail.com>
 <6d21ece1-0201-54f2-ec5a-ae2f873d46a3@oracle.com> <CAPcyv4hJjcy2TnOv-Y5=MUMHeDdN-BCH4d0xC-pFGcHXEU_ZEw@mail.gmail.com>
 <342eb71c-0aff-77e5-3c71-92224d7d48e0@oracle.com> <CAPcyv4hVu+A0PXgXTwWj3SBimP5pjX_97g+sfGeT47P0-SJkiQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hVu+A0PXgXTwWj3SBimP5pjX_97g+sfGeT47P0-SJkiQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Nov 2021 18:35:08 -0700
Message-ID: <CAPcyv4gLiaFEJW6W8XtDBH_Z4OPgHabdcWedmzy-_0Tqtjv5=A@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA flag
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 4, 2021 at 5:46 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Nov 4, 2021 at 1:27 PM Jane Chu <jane.chu@oracle.com> wrote:
> >
> > On 11/4/2021 12:00 PM, Dan Williams wrote:
> >
> > >>
> > >> If this understanding is in the right direction, then I'd like to
> > >> propose below changes to
> > >>     dax_direct_access(), dax_copy_to/from_iter(), pmem_copy_to/from_iter()
> > >>     and the dm layer copy_to/from_iter, dax_iomap_iter().
> > >>
> > >> 1. dax_iomap_iter() rely on dax_direct_access() to decide whether there
> > >>      is likely media error: if the API without DAX_F_RECOVERY returns
> > >>      -EIO, then switch to recovery-read/write code.  In recovery code,
> > >>      supply DAX_F_RECOVERY to dax_direct_access() in order to obtain
> > >>      'kaddr', and then call dax_copy_to/from_iter() with DAX_F_RECOVERY.
> > >
> > > I like it. It allows for an atomic write+clear implementation on
> > > capable platforms and coordinates with potentially unmapped pages. The
> > > best of both worlds from the dax_clear_poison() proposal and my "take
> > > a fault and do a slow-path copy".
> > >
> > >> 2. the _copy_to/from_iter implementation would be largely the same
> > >>      as in my recent patch, but some changes in Christoph's
> > >>      'dax-devirtualize' maybe kept, such as DAX_F_VIRTUAL, obviously
> > >>      virtual devices don't have the ability to clear poison, so no need
> > >>      to complicate them.  And this also means that not every endpoint
> > >>      dax device has to provide dax_op.copy_to/from_iter, they may use the
> > >>      default.
> > >
> > > Did I miss this series or are you talking about this one?
> > > https://lore.kernel.org/all/20211018044054.1779424-1-hch@lst.de/
> >
> > I was referring to
> >
> > http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dax-devirtualize
> > that has not come out yet, I said early on that I'll rebase on it,
> > but looks like we still need pmem_copy_to/from_iter(), so.
>
> Yeah, since the block-layer divorce gets rid of the old poison
> clearing path, then we're back to pmem_copy_to_iter() (or something
> like it) needing to pick up the slack for poison clearing. I do agree
> it would be nice to clean up all the unnecessary boilerplate, but the
> error-list coordination requires a driver specific callback. At least
> the DAX_F_VIRTUAL flag can eliminate the virtiofs and fuse callbacks.

Although, if error management is generically implemented relative to a
'struct dax_device' then there wouldn't be a need to call all the way
back into the driver, and the cleanup could still move forward.
