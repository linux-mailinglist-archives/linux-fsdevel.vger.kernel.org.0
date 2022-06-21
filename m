Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D471552C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347505AbiFUHuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 03:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347349AbiFUHuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:50:01 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1532240B0;
        Tue, 21 Jun 2022 00:50:00 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id k25so5168918vso.6;
        Tue, 21 Jun 2022 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXNeBNF83PtYk6DX8EoSy1f1uR6DI2ssYRx5Bnm+qQ4=;
        b=ea/bYbJvVmhMRiOaXAJl4vGuoD4gJR/8Dz8Lukx2cPkrSKaH9wQ/mGx1lwOk77g/7T
         vHRaRktQOaRNOUOnoF4hXiDjhE4akGotNpnhdHYwA119B5eRQ9JnhyjkZyI+8EnDPLWJ
         3Envgo9j07I039OV2fkqnAyYO6t49f0Pi5alO8zX/NCAdmfgJizGZztI7OOwPnYTjM/d
         dxOx3vOmtEsMRvSYR9ujycErKnguqWPrz8SKhfmS1lADSKRLPynTX3Zr/H0f6q+F7IAh
         wk2zZK9TqCC5wa+zhtjR0p4mzZfT/Ias5kyvFQIVwZ0z197bscrILIT6/66ain3Zso/i
         fkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXNeBNF83PtYk6DX8EoSy1f1uR6DI2ssYRx5Bnm+qQ4=;
        b=4jdFY+74tjlbnhH3RFBHal0RMA3bCG2MEE0BsT2Qe3U91LTvL5HGiUTsoRGBprXejE
         YbCc4QjnT61hoxGT0Sz5NxPlxFDfOHcGCH8khHsucNUDe1OYFdPeTigR6uGr4c2IalJ3
         VQ3pa9/mPPuZpWkUZXDIpLjZfGRIXDsHi5+lmAkQEW4V7iGkYJdL1tqBnx+WJWg+6yRF
         elk7sagohLAMbvAqkEF1pG5FCgawZKnR80pVlIrMq2uvFTTAVOYhzxEAIkXnhZMUqbgR
         E+vKmfeKKxpH/W31l9mscX1T4GbJN0H6qfRuKULCPcbeWWfJmzS+HROZEWkgEOonYBgb
         KIfw==
X-Gm-Message-State: AJIora//q5D8LW/ba181gcPNJaR3FJToQm1VodJOVJoPkRaIYqySAigW
        vplZew6tNdLBIh0oVg2N22RcXoDx01k+UE3YsSw=
X-Google-Smtp-Source: AGRyM1tshnqAXFKi+/I71r/oij6D6cYxHiGfwggbeSTKiEFNzXUpKQ7eRK3Hq53JxG8b6BiQKqXk7hwnAqcyLedM/IA=
X-Received: by 2002:a05:6102:1489:b0:354:24ba:1478 with SMTP id
 d9-20020a056102148900b0035424ba1478mr4652514vsv.72.1655797799915; Tue, 21 Jun
 2022 00:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190404211730.GD26298@dastard> <CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com>
 <20190407232728.GF26298@dastard> <CAOQ4uxgD4ErSUtbu0xqb5dSm_tM4J92qt6=hGH8GRc5KNGqP9A@mail.gmail.com>
 <20190408141114.GC15023@quack2.suse.cz> <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz> <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3> <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan>
In-Reply-To: <20220620091136.4uosazpwkmt65a5d@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jun 2022 10:49:48 +0300
Message-ID: <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw workload
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > > Hi Jan, Dave,
> > > >
> > > > Trying to circle back to this after 3 years!
> > > > Seeing that there is no progress with range locks and
> > > > that the mixed rw workloads performance issue still very much exists.
> > > >
> > > > Is the situation now different than 3 years ago with invalidate_lock?
> > >
> > > Yes, I've implemented invalidate_lock exactly to fix the issues you've
> > > pointed out without regressing the mixed rw workloads (because
> > > invalidate_lock is taken in shared mode only for reads and usually not at
> > > all for writes).
> > >
> > > > Would my approach of pre-warm page cache before taking IOLOCK
> > > > be safe if page cache is pre-warmed with invalidate_lock held?
> > >
> > > Why would it be needed? But yes, with invalidate_lock you could presumably
> > > make that idea safe...
> >
> > To remind you, the context in which I pointed you to the punch hole race
> > issue in "other file systems" was a discussion about trying to relax the
> > "atomic write" POSIX semantics [1] of xfs.
>
> Ah, I see. Sorry, I already forgot :-|

Understandable. It has been 3 years ;-)

>
> > There was a lot of discussions around range locks and changing the
> > fairness of rwsem readers and writer, but none of this changes the fact
> > that as long as the lock is file wide (and it does not look like that is
> > going to change in the near future), it is better for lock contention to
> > perform the serialization on page cache read/write and not on disk
> > read/write.
> >
> > Therefore, *if* it is acceptable to pre-warn page cache for buffered read
> > under invalidate_lock, that is a simple way to bring the xfs performance with
> > random rw mix workload on par with ext4 performance without losing the
> > atomic write POSIX semantics. So everyone can be happy?
>
> So to spell out your proposal so that we are on the same page: you want to
> use invalidate_lock + page locks to achieve "writes are atomic wrt reads"
> property XFS currently has without holding i_rwsem in shared mode during
> reads. Am I getting it correct?

Not exactly.

>
> How exactly do you imagine the synchronization of buffered read against
> buffered write would work? Lock all pages for the read range in the page
> cache? You'd need to be careful to not bring the machine OOM when someone
> asks to read a huge range...

I imagine that the atomic r/w synchronisation will remain *exactly* as it is
today by taking XFS_IOLOCK_SHARED around generic_file_read_iter(),
when reading data into user buffer, but before that, I would like to issue
and wait for read of the pages in the range to reduce the probability
of doing the read I/O under XFS_IOLOCK_SHARED.

The pre-warm of page cache does not need to abide to the atomic read
semantics and it is also tolerable if some pages are evicted in between
pre-warn and read to user buffer - in the worst case this will result in
I/O amplification, but for the common case, it will be a big win for the
mixed random r/w performance on xfs.

To reduce risk of page cache thrashing we can limit this optimization
to a maximum number of page cache pre-warm.

The questions are:
1. Does this plan sound reasonable?
2. Is there a ready helper (force_page_cache_readahead?) that
    I can use which takes the required page/invalidate locks?

Thanks,
Amir.
