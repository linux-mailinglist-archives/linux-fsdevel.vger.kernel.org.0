Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51596148E95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbgAXTRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 14:17:01 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50874 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbgAXTRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:17:01 -0500
Received: by mail-wm1-f46.google.com with SMTP id a5so541059wmb.0;
        Fri, 24 Jan 2020 11:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVgy0lYIavDAsk5TdKFdtxlyaFip4mNRyTLE6SI9Fts=;
        b=gl9/rgpsy8UyFX7QflBl7HRfvvG9waAhSa2dwgafLLG1xX7317546Kqz0ashea/4jw
         B4aF8fiAt98Oh2ju1g7cN76Xad3pmYy3g34krm2TI6gzO2JExn8pNAOdqJ0D9QGnDJtV
         r1a558CBRM66lgx6RREyHqdmfRGFPUBCCwZae0b70nFJBENHMwJqK6PlccDyuDqKRZLG
         BRtB+2y+KsI710VbZSQhr6f4H8VIz2Sk8y9ispGobD0lmpavjfi0324f9yhClerOeqJL
         LeX4+KFGlRyrJL552GrWfZ6i4am40XjH/eitVKJ3qVabXSXGNimWkIykuVsSWl8kwLu/
         lyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVgy0lYIavDAsk5TdKFdtxlyaFip4mNRyTLE6SI9Fts=;
        b=PkcCp1zh/WNPbmcXH4b18ioFjbk6R4yPq/kqPbeuAJVUntIawaA2nH9KBZmZfmAgZP
         FCrCa8BOqiaJNFkHu36bx1ibRh0zS91bKoTu0MxFxAtOY/kdmn34J21EAkPppaDVFNeF
         SZoOPINUtkjQbaZwMis/xqz/WHCwm10nAYnKospdA1Boga5sqZHY7EG3bre6F9wV6bta
         BZYibSz4agwA5F7gTYm7rwnhLS72r7h75IV07pS9WFbptbp5lc+5Id1YY5jIOUDiEyXS
         Qwdkni2GBG5PDPMBYc7aF98wfwYOT5lsJTw8i4skS3e5Bew4wjzTaMm5rdFp4b+fQlYU
         SDEw==
X-Gm-Message-State: APjAAAUzqYYTDm16ioCCrOKiAVNn15wNsCzMNT57jeN9R3V6/4cA8sj5
        WYPMPHRx68t0Z1B13R+3ndkZmFRSGDVmxqXcelg=
X-Google-Smtp-Source: APXvYqwIaMBIgp9u4RBMFgNgjHfrbGRQFCndgTcnJptndGTaMsCl9tAyrSKd5hD8JMWls3/97IqKPZvNHLXBGL18K1Q=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr622251wmc.9.1579893419173;
 Fri, 24 Jan 2020 11:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20200121105711.zzeeolydlivqnik7@ws.net.home>
In-Reply-To: <20200121105711.zzeeolydlivqnik7@ws.net.home>
From:   Carlos Santos <unixmania@gmail.com>
Date:   Fri, 24 Jan 2020 16:16:47 -0300
Message-ID: <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.35
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Karel,

On Tue, Jan 21, 2020 at 7:59 AM Karel Zak <kzak@redhat.com> wrote:
>
>
> The util-linux release v2.35 is available at
>
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.35/
>
> Feedback and bug reports, as always, are welcomed.
>
>   Karel
>

That's great. Thanks!

--8<--
> Changes between v2.34 and v2.35
> -------------------------------
--8<--
> docs:
>    - Fix adjtime documentation  [Pierre Labastie]
>    - add GPLv3 text  [Karel Zak]

That's a problem. It makes hwclock hard to include in embedded systems
due to the GPLv3 restrictions.

I noticed that it comes due to sys-utils/hwclock-parse-date.y, which
was taken from gnulib. Would it be possible to take the file from an
previous version of gnulib that was still under GPLv2?

An alternative approach would be porting a similar code using a more
liberal license, e.g. BSD.

What do you think?

-- 
Carlos Santos <unixmania@gmail.com>
