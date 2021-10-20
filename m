Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3859F434E77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 17:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJTPD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 11:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJTPDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:03:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC23C06161C;
        Wed, 20 Oct 2021 08:01:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d3so28078746edp.3;
        Wed, 20 Oct 2021 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wMp6KN4Bl+/16uqAJTSTlwVNnmq+6gMGHhM2eIoSfA=;
        b=fmuQ1cL1GdQSimrx3H9sCqboDYsk+VgaxYKz/UJYH7UGStaXBiW3Si6588drQZ3Dkf
         q+HubfDdEvrLyHoG8F7+oW1PWgFvXlNzgq/wvmnrlRW1qVO6aVpaqX151FxoktfWyGTi
         M1yiY0CLI8lq3WNpFX9CO+moKoFftbseEebm8Pg40W5ctMF2JwG4PgcD6wp5l6o2hNgY
         FH/TY3gK/2aWdNx8zfF2LgyepAQvS+IvAzZOiVGoY63M/mC5XxjEwY1AKvreVgt2wOp0
         uo6VDnR4YM5a6PEo2cI08Rs8RNJMP3IU849PnbcThybJCWGto/vhHfkV/UEw9z0LsH9K
         Y7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wMp6KN4Bl+/16uqAJTSTlwVNnmq+6gMGHhM2eIoSfA=;
        b=k1V8qIxTULgD+h28FHyx9gDFnv9X/Rhu1OHPkBLcq4SPbeib6jR+pRUazQpj8upUDF
         pnCbS51e8xeHPz5UVoEoCRsvRNHIiAMa9pd8FXVoShbAikC6crlkTRVO4fquzJf8pCGD
         wrH1/5bOSJi09o3VglcGv6tHyqbM9evVs/Z2+ayVvyGdbJTrIGOFV80n2E40QEW0zDhB
         WB81pqkEJRuj5yedyCsMgUKBqTcKvYfOb/PDXfkkTr1CQz/i1mcRgeoRVoXksiTqFR33
         FpYwrlND2NF0xzD3+6pFTjhYl/HzXiPYmOx9adZWcnC4GpRBEtYPhDgSQXGMRn4DbIcj
         pZUw==
X-Gm-Message-State: AOAM532ZI66lvvYBDpbx+hHyiQU0lvdO3X8MmFNsVGUEG3ULq/dt2QxQ
        NfjotACjJP+zaEyaRLDlqaWdK0s5t6dFMtAkcJY=
X-Google-Smtp-Source: ABdhPJwyjH71/Vo6YOX6/jcjTOh0kzwHB52ML2RdNItKGmpS3BW9iLetdM5gO10tdQ0IFkcsRbXRJACFfzlBRLxtP3A=
X-Received: by 2002:a50:e009:: with SMTP id e9mr634164edl.254.1634742039339;
 Wed, 20 Oct 2021 08:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211018114712.9802-1-mhocko@kernel.org> <20211018114712.9802-3-mhocko@kernel.org>
 <20211019110649.GA1933@pc638.lan> <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
 <20211019194658.GA1787@pc638.lan> <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
 <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>
 <YXAiZdvk8CGvZCIM@dhcp22.suse.cz> <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>
In-Reply-To: <YXAtYGLv/k+j6etV@dhcp22.suse.cz>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 20 Oct 2021 17:00:28 +0200
Message-ID: <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>
> On Wed 20-10-21 16:29:14, Uladzislau Rezki wrote:
> > On Wed, Oct 20, 2021 at 4:06 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > As I've said I am OK with either of the two. Do you or anybody have any
> > > preference? Without any explicit event to wake up for neither of the two
> > > is more than just an optimistic retry.
> > >
> > From power perspective it is better to have a delay, so i tend to say
> > that delay is better.
>
> I am a terrible random number generator. Can you give me a number
> please?
>
Well, we can start from one jiffy so it is one timer tick: schedule_timeout(1)

-- 
Uladzislau Rezki
