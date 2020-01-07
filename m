Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14EA13218D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 09:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgAGIk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 03:40:28 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46243 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGIk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:40:28 -0500
Received: by mail-wr1-f54.google.com with SMTP id z7so52824867wrl.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 00:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6vtnhErXU14gq8vIIPShe7GLcTSR4DoBqwo7dTmfag=;
        b=VQko0t8cjs8pDjVYYhPYjk4lMZkQEdosVWNM8Pb/Nrl1x6OS2a17TdcL1WZXaGHiQN
         79m1AndpFssbjdeMAFfjveD4DRnBcr//e/EGDPeiLzGzO9vljS9r82YA2/KkYla33xZQ
         UCmnT9fD0G4TiA/bTNhsBWQTArk3ZO6SniNXWM+HTaDmm4EXsP4y1BiMsIE7bc7JehDu
         GgUq+CcQZV4CasXbLqDpJeRMsIB7Jq3a6KmGCnUZ6aryVg1MoZ/lVeZeQt6Vi7OwJfrm
         +0kW2l6gZnTZVznHPYqA3/YZ7BWe0VDO28tnuvUTIuon0RdKpPQXyaSxMd3xoQYbYwo8
         3vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6vtnhErXU14gq8vIIPShe7GLcTSR4DoBqwo7dTmfag=;
        b=iw2RB7e0Ot+hBfxRdcKH4/d4U3YU1BxdfGNN6bCxH2Vf4tcvlZmkY3643Cblgp9qfE
         1mXAkI73UMslD//tSlTvh/roy6SzVJnAsOBXnBgQnHd9AASK9iC2Y1xNbea4NL0f/9YL
         0wBXaCabIteSenM3+HyQ7dQyWQsUnqU8kyCDOBnrOflUPSd6C/TkvzudHsI8hYs3I6Li
         TXcD7+UEoiTHd4iQNesilI/LI6KI2rvQ4NhQG9XwBoCuAPde+SewCf292sqBOmLN6drz
         MG8pMU5x9vqXZjPQbZ1qfA4Rly4bPLm25JNFBWEpLtgvqiW9veJaE9uIaDIeoASa5CFI
         JTvQ==
X-Gm-Message-State: APjAAAUroG/gdYSB/D5eG8l3xds1Sek7e9WkvyYB7XV/KJwEMewGJFms
        giTr/wlSdJVz51ODr/AEgcuD2fQMwQ1AQXsZlZQ=
X-Google-Smtp-Source: APXvYqx4pCUAuW1LqnabBOT6TobNrNhcD3tlLk+c58v2Yi2PzODgxrrhI24g+ZN2EfQX4/sZvY5bp+Q1HEnkgnrlcfM=
X-Received: by 2002:adf:fc03:: with SMTP id i3mr110320364wrr.306.1578386426054;
 Tue, 07 Jan 2020 00:40:26 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
 <20200106101518.GI23195@dread.disaster.area>
In-Reply-To: <20200106101518.GI23195@dread.disaster.area>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Tue, 7 Jan 2020 08:40:00 +0000
Message-ID: <CALjAwxgzsZTBBCQYqCBoMeYtMs3jHSqGMBPQ32KrmaQr50dPAg@mail.gmail.com>
Subject: Re: Questions about filesystems from SQLite author presentation
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, drh@sqlite.org,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Jan 2020 at 10:16, Dave Chinner <david@fromorbit.com> wrote:
>
> Hence AIO_FSYNC and now chained operations in io_uring to allow
> fsync to be issues asynchronously and be used as a "write barrier"
> between groups of order dependent IOs...

Thanks for detailing this.

> > For 3. it sounded like Jan Kara was saying there wasn't anything at
> > the moment (hypothetically you could introduce a call that marked the
> > extents as "unwritten" but it doesn't sound like you can do that
>
> You can do that with fallocate() - FALLOC_FL_ZERO_RANGE will mark
> the unused range as unwritten in XFS, or you can just punch a hole
> to free the unused space with FALLOC_FL_PUNCH_HOLE...

Ah!

> > today) and even if you wanted to use something like TRIM it wouldn't
> > be worth it unless you were trimming a large (gigabytes) amount of
> > data (https://youtu.be/-oP2BOsMpdo?t=6330 ).
>
> Punch the space out, then run a periodic background fstrim so the
> filesystem can issue efficient TRIM commands over free space...

Jan mentions this over on https://youtu.be/-oP2BOsMpdo?t=6268 .
Basically he advises against hole punching if you're going to write to
that area again because it fragments the file, hurts future
performance etc. But I guess if you were using FALLOC_FL_ZERO_RANGE no
hole is punched (so no fragmentation) and you likely get faster reads
of that area until the data is rewritten too. Are areas that have had
FALLOC_FL_ZERO_RANGE run on them eligible for trimming if someone goes
on to do a background trim (Jan - doesn't this sound like the best of
both both worlds)?

My question is what happens if you call FALLOC_FL_ZERO_RANGE and your
filesystem is too dumb to mark extents unwritten - will it literally
go away and write a bunch of zeros over that region and your disk is a
slow HDD or will that call just fail? It's almost like you need
something that can tell you if FALLOC_FL_ZERO_RANGE is efficient...

-- 
Sitsofe | http://sucs.org/~sits/
