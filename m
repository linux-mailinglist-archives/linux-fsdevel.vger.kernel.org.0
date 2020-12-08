Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31452D370C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 00:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgLHXlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 18:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbgLHXlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:41:36 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA7C061794
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Dec 2020 15:40:56 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id jx16so303567ejb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Dec 2020 15:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFLKQRkZoww23XEL7PXOxhhtdWSbzprjYliTkriku9g=;
        b=Jntq7/6SNEMUM+eYiV7G1myyo+nAu2Zf/Ui7zyVN8Rx9JmZzQSKOZqkFrGDz2HKzIx
         ompHPIdlRCYp+RD+MWBTTOhJrYrPGgnm6FvSJkQ4hVoL2ssKEkAF+zV2AqkBpaqwQf1L
         6KDbKsmFu0PuNmu0YProuT3VQdw7k2jl/7PzhJiGqIAcMDDBmL5Ec350EZ+jcnng1WDY
         q5SxN7JIbfpUCSkAeFvg3Azyk+kELpLE6khv6dGODjlbUnNFy9sd4viKNgatXVk3Gx3A
         cxLQrKvJMCMfZTJByzYEXAlFPEin3M8KQL9Jh520h+nPnlomi4pTcOhw0/Iu6YbmJMy4
         OeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFLKQRkZoww23XEL7PXOxhhtdWSbzprjYliTkriku9g=;
        b=Vy7ILEqaUL3w4kA+5LTg9auxkBAmcdb23P+q2t2/xgJUTkchLokoW6qQ0FICNfgmQT
         9NGyLKY2HI3Rbnx+1Haw8H/iRTLys0wtkXRxQcXM7nXW3Yiaku/FKS7XgKsNrX8oydx5
         P39Myo8agwKEedG8mZhAbxb3fZGYfljpfBqFeCZoqtG19EXEuPaRunYPeO3tVhDRuvzM
         OyEof4FVPOJgN79jsZXy1JcTWLyo633teXNwD9Ro7+RKoWDr0nkvqei629oo8gD+7eH6
         jUA1sPlcvOFa5OWEZp9TcFW5c1PvB+snnKIyTS+YFpTJ1MK2fBO2PJegJiUJcOcoyn/L
         gkyA==
X-Gm-Message-State: AOAM532bNSbnXB6ftbZeqH6rxp3AMMckha/siELOYgB225sHZCfHmCnh
        J8YRnzTLW1mOWGtPwLEoTlCXJlS3+M4JlLcvZG184w==
X-Google-Smtp-Source: ABdhPJwlgMQbj1gq6mP6kKfYjuwAl+ty/SxoFyiYcdC1W4w7ngUFi1kqfZfhHd3aFaQ+dqp4EipB37tPTiaBbuvqFIE=
X-Received: by 2002:a17:906:518a:: with SMTP id y10mr77069ejk.323.1607470854865;
 Tue, 08 Dec 2020 15:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20201207225703.2033611-1-ira.weiny@intel.com> <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201207232649.GD7338@casper.infradead.org> <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
 <20201207234008.GE7338@casper.infradead.org> <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com> <20201208215028.GK7338@casper.infradead.org>
 <CAPcyv4irF7YoEjOZ1iOrPPJDsw_-j4kiaqz_6Gf=cz1y3RpdoQ@mail.gmail.com>
 <20201208223234.GL7338@casper.infradead.org> <20201208224555.GA605321@magnolia>
In-Reply-To: <20201208224555.GA605321@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Dec 2020 15:40:52 -0800
Message-ID: <CAPcyv4jEmdfAz8foEUtDw4GEm2-+7J-4GULZ=6tCD+9K5CFzRw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 8, 2020 at 2:49 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
[..]
> > So what's your preferred poison?
> >
> > 1. Corrupt random data in whatever's been mapped into the next page (which
> >    is what the helpers currently do)
>
> Please no.

My assertion is that the kernel can't know it's corruption, it can
only know that the driver is abusing the API. So over-copy and WARN
seems better than violently regress by crashing what might have been
working silently before.
