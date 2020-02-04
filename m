Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6261520E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 20:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBDTQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 14:16:52 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40022 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgBDTQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:16:51 -0500
Received: by mail-il1-f193.google.com with SMTP id i7so16884321ilr.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 11:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9/6XU2LpZWsBgzTzP/hhFG+SEvjhrm1Akh+4LB2jFQ=;
        b=a+K+LZWcvBn/Qen+mTbm7223lprh5qcBn4n03M+j1wt01jaRqnWZdiVfg8OXtoJRuv
         jsFJk1c/r2LP7mJnsYPJCuY09T0w7SMu45sZvs8mlUdxbkANMu9bUNkqywhtzLwrWCUH
         Y5I3ZpOtvK5+VQCI2CCizK69Gkl6kx/0lPYyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9/6XU2LpZWsBgzTzP/hhFG+SEvjhrm1Akh+4LB2jFQ=;
        b=tbamXL6BW+5OGGoWJtenXFIHknH3z2y2L+ymLpfrMlUTI/XX+DVZyzATFfPyE9+VwU
         y66u+IJRWCVVAUEX+0NRnAn0U7jCXxWZdI/ysVXKdmcA65MpICUrTFaQT/BsD4MrNBkw
         cAl/y0Y1OpZDjx/bepQa/nsNSXVWo3dR32R6n5ewRCc9cGQH8IJxI8HxX8Qfcn4YGhVm
         Z1I5X5mRXakvfAcnjScTV46nbYzAy5VPrA4EB6yC5a22M8lRF1XamnrVokZsPpdJLWVV
         SB6FkJOZdTwafYanlhmNCJz7SXE52s26rIOyj7bnfqp3+LQZ9E1+CNIVhn1jkCvjNAUz
         eRCw==
X-Gm-Message-State: APjAAAWOixuZAWPfWvJ//8mGONDp8IpAOavF2V0Bx54Oz7cVBHeAFTK6
        NeWvXWhtM3Mp30hsQMrl2wUz/3g1UhGd3B0g5F00QQ==
X-Google-Smtp-Source: APXvYqwBCrb0c3k8/h5XEMaUEVvPRrRnwM6U/8qzM3bVAInIClMbhx20heV2frId/eht16ldh1qeEDwL4qHGTjKjEIg=
X-Received: by 2002:a92:3c93:: with SMTP id j19mr20659572ilf.63.1580843809908;
 Tue, 04 Feb 2020 11:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com> <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
 <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com>
 <20200204184221.GA24566@redhat.com> <CAOQ4uxhfV++XvO17ywftnhLoryYsynF=Y-pHCwmPdymc6naOFg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhfV++XvO17ywftnhLoryYsynF=Y-pHCwmPdymc6naOFg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Feb 2020 20:16:39 +0100
Message-ID: <CAJfpeguHjd2PMPxgbzFbdGM_7F6L4v+UGorjp2sMFtykR71QaA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 4, 2020 at 8:11 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Feb 4, 2020 at 8:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> > So as of now user space will get -ESTALE and that will get cleared when
> > user space retries after corresponding ovl dentry has been dropped from
> > cache (either dentry is evicted, cache is cleared forcibly or overlayfs
> > is remounted)? If yes, that kind of makes sense. Overlay does not expect
> > underlying layers to change and if a change it detected it is flagged
> > to user space (and overlayfs does not try to fix it)?
> >
>
> I looks like it. I don't really understand why overlayfs shouldn't drop
> the dentry on failure to revalidate. Maybe I am missing something.

I don't remember the exact reason.   Maybe it's just that it makes
little sense to redo the lookup on remote change, but not on local
change...

Note:  I'm not against detection of changing underlying layers and
redoing the lookup in that case.  Maybe we can do it optionally
(because it could be expensive), but first there needs to be a use
case and we seem to lack that.

Thanks,
Miklos
