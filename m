Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBA8352EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhDBRuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 13:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhDBRuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:50:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EB6C06178A
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Apr 2021 10:50:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso2887653pjh.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Apr 2021 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eYX1VCobuv7ZghRLFjUBUx/jA51U229FVIFeLRu/n6g=;
        b=uZcOrbj95WMDw9eW5IvdUkXZmw+FX3tdBKmnN727c4w+7bNNhnsgltsJ2Fcp/q1DLv
         4LVESOmKbbodSySgHqpal85/8UmxTXG0bLxLQQvNQC59F9FMoYHA9Seobp6cGIG9vbBt
         X92sEDAQLohDGs/j9lfttU1oU7asvzWdGgpa12bBZCK3PuvD6jUy0FadbEcGQG//OKg2
         iSMTaN/qrMGwmUi8DxUQYUhdRP0KTlooSBD6ANyVJGiP0qdLs4EdRjgOC5IwNun0InJN
         rOEf8sFRUKMQa2rgjsDlQskvoSy/yd8SR4gu98w/FIsOLzrBeerzBcUL1oFEGXt+SRvB
         mjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYX1VCobuv7ZghRLFjUBUx/jA51U229FVIFeLRu/n6g=;
        b=iJrTM6NDAY6g0+VEB0lQuTZqJ8wMRzf1671vW2R40dOO8SznjpatMZtFaA974iglJY
         06JN17nWbzaNnQWkIdYVIDGsQJWid/Zuxql/WRt9or9g04nTB7XSKfKnMT0M5/heyce9
         jIRftUtvbs3LIFHGUnXxMqa1xFd6y88Hym5jVKPPHflgPWtAD9AGYT/16S7UQn2whhWE
         yMAyJ+zRRQCkbCT6e2mNuhMc/2B1kwyoWGFFLcPbnX4VXYS7OInSUPPivY4TwQOusVti
         lEkIua97oB0IDL7NF9HnMCRXxiLlAJgOSsVk3aqX59uRGHFVxCR7z827XmIRHjXJ7sO/
         VaKg==
X-Gm-Message-State: AOAM530/ONYtXOBg5MYhfbLPfQ1iG9fmzluCP0ZHJ38/TiP5sFxKa4hw
        9anaSCWHDESJpgH7Gou96ytGaQ==
X-Google-Smtp-Source: ABdhPJwc7UEZ8VNo4bnQIhOq7dyMaBrLDsA+tXAOfWXSiLl0wOd2t0uGD3skjne7xiJ4u5fOgwcx0A==
X-Received: by 2002:a17:902:9345:b029:e7:4853:ff5f with SMTP id g5-20020a1709029345b02900e74853ff5fmr13857339plp.74.1617385852230;
        Fri, 02 Apr 2021 10:50:52 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::16fc])
        by smtp.gmail.com with ESMTPSA id a15sm8751227pju.34.2021.04.02.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:50:51 -0700 (PDT)
Date:   Fri, 2 Apr 2021 10:50:50 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YGdZeh4K3BxQPcGx@relinquished.localdomain>
References: <cover.1617258892.git.osandov@fb.com>
 <0e7270919b461c4249557b12c7dfce0ad35af300.1617258892.git.osandov@fb.com>
 <CAHk-=wgpn=GYW=2ZNizdVdM0qGGk_iM_Ho=0eawhNaKHifSdpg@mail.gmail.com>
 <YGbIwOv0yq0z8i8K@relinquished.localdomain>
 <20210402080423.t26zd34p2oxbzvuj@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402080423.t26zd34p2oxbzvuj@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 02, 2021 at 10:04:23AM +0200, Christian Brauner wrote:
> On Fri, Apr 02, 2021 at 12:33:20AM -0700, Omar Sandoval wrote:
> > On Thu, Apr 01, 2021 at 09:05:22AM -0700, Linus Torvalds wrote:
> > > On Wed, Mar 31, 2021 at 11:51 PM Omar Sandoval <osandov@osandov.com> wrote:
> > > >
> > > > + *
> > > > + * The recommended usage is something like the following:
> > > > + *
> > > > + *     if (usize > PAGE_SIZE)
> > > > + *       return -E2BIG;
> > > 
> > > Maybe this should be more than a recommendation, and just be inside
> > > copy_struct_from_iter(), because otherwise the "check_zeroed_user()"
> > > call might be quite the timesink for somebody who does something
> > > stupid.
> > 
> > I did actually almost send this out with the check in
> > copy_struct_from_iter(), but decided not to for consistency with
> > copy_struct_from_user().
> > 
> > openat2() seems to be the only user of copy_struct_from_user() that
> > doesn't limit to PAGE_SIZE, which is odd given that Aleksa wrote both
> 
> Al said there's nothing wrong with copying large chunks of memory so we
> shouldn't limit the helper but instead limit the callers which have
> expectations about their size limit:
> https://lore.kernel.org/lkml/20190905182801.GR1131@ZenIV.linux.org.uk/

Thanks for the context. So I guess it makes sense to keep the check
"recommended" for both functions.
