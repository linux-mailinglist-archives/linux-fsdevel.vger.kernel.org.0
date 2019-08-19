Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA91C92853
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfHSP1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 11:27:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45380 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfHSP1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:27:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id l1so2143241lji.12;
        Mon, 19 Aug 2019 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzhnd/NgWWbF1n6qQYdEPf3DMaCqwz6w2KWcI54F4xw=;
        b=bL8RajdzINCDTNJd556aiA1a1hywhD2wofkFUBlK2ey0iTsL4vJoq7v2htihsXCBOp
         H7IchW2FiKTPe+DY711s23VkPXxwU06x6G5+WDNI9kaNYj3dbQXzPnEgg3mXOaA2sN5T
         60OpvNb3hLEb4BKgpn65PVOxEniZKrTsxvgRmmWzyc4kvGATsolcEUAX3MQDWmnT3GoZ
         vlLBZoc2Oe3MwXz3t2tc0ITUJmNucxOr992TZvJoSIlKfUrBmx1/ajsfXKc/qt1JfJqM
         3SrIikXcP4W4dqnlqEvsCcjfNvTHfvxf75DZiybW3HAIQ7b2HfkNdIXgtJghIYiiqWxH
         i9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzhnd/NgWWbF1n6qQYdEPf3DMaCqwz6w2KWcI54F4xw=;
        b=PTzzfm7fRCauJBRA9YQsali0dvm/eGZYQemwLpx6RWjmwQSggaEHQCWjttliPvpaIV
         9lGND5vTLt00nNC3vU9kvn9w7J46YpenMrUzhvikzyz3sopfqfdg1WoiCk52nLSN2RPD
         klT7chzB0e8MlilnpoBedGzST8ZIt3bJi4TpP22a5QbHQNpHeL5MB9FrAS5r6yB+T/AJ
         KJostnhTZdwOA9d42dGUwFVfiB8W7i58aPgLUcA2emGkFURowCe/0n/GnR0181aDTacM
         RA0Vh1HPaLRL2o6YCdmuBragDIHUpWdtFKbabzdj0oAk17/UDW6LN/hWYVyserFCDTyD
         RlvQ==
X-Gm-Message-State: APjAAAXNf0magj5JDwhiW9prDotzz1rOgXJkZjdWOc3bE5r0u83cmLDn
        1X7Ci9EuJ8d9yRdhO0AZqlGpT5LS4Jks+MWYqS5ZGamL
X-Google-Smtp-Source: APXvYqxqV1P8WjGmVBMQPRR8Ea2ssckOGKhnvRYGTuez+x5pJMX7rPhFgc/NSjCMts8zP+KcL4SCg/V3HKEmiBFqOvc=
X-Received: by 2002:a2e:4601:: with SMTP id t1mr1402539lja.102.1566228421044;
 Mon, 19 Aug 2019 08:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com>
 <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de>
 <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com>
 <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de>
 <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com>
 <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
 <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com>
 <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de>
 <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com> <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Mon, 19 Aug 2019 20:56:49 +0530
Message-ID: <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com>
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi Tglx,
> But for the above scenario:
>
> ktime_get()
>         do {
>                 seq = read_seqcount_begin(&tk_core.seq);
>                 base = tk->tkr_mono.base;
>                 nsecs = timekeeping_get_ns(&tk->tkr_mono);
>
>         } while (read_seqcount_retry(&tk_core.seq, seq));
>
> So if the interrupt which updates the timekeeper hits in the middle of
> timekeeping_get_ns() then the result is discarded because the sequence
> count changed and read_seqcount_retry() returns true. So it takes another
> round which will be perfectly aligned with the updated time keeper.
>

Do you mean to say the timekeeper  updates always happen from ktime_get?
My point was, when one thread is in ktime_get other thread/isr updates
timekeeper from different flow.

Regards,
Arul
