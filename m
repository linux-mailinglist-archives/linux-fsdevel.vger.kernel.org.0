Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0F2CA838
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 17:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLAQ01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 11:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgLAQ00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:26:26 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672ADC0613D4
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Dec 2020 08:25:46 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id w18so1209619vsk.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Dec 2020 08:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TSk1vwx+XFxuih5Bd8H5Ea3HBM6hqPjb9TDOhTGQmo=;
        b=jpT1aWaiqOgizoyAZBIATAbYMdKhM6A/qqrnSp07v34MSpynap0zkaMbOp6/54BzYH
         qUf3nhjyXarOdD98bNceJuoagcsWJ8AWZzCfshmiu5bMQKNm6YI9KiUEpS5imIfZslRU
         c84R6mq6j+4faBSPvj4vLCjkJh4yyhDKTjWDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TSk1vwx+XFxuih5Bd8H5Ea3HBM6hqPjb9TDOhTGQmo=;
        b=Cb1TpMgSjDi5JUkowhhQ/C7lXUug6ynTR1zofQU9VF+RaCDJ2y66KkOsWdcDZaGKzO
         /lmkswJap61D+etn8grnqxaRufMf/7AcRKqw7jGaXnM7p/h45yROMqTyvyVZug55wngT
         dB5BlgMFCuN+PM454bYGU0KjZZSPynhOHNAJTRRTGcVssJFSwDNtF+9VWMZnSQY6Nxx+
         o1mWpu8IsPNhu5RHEEbviS99gh+y0ZjiN7DxFn3GlkKXEgwrpLjUk8oAwq9DJlPqDpi5
         4RhFD1uf5+wkw8edQn2/ErKKU/LA2axfgg9zFKe55i4u/L9oBXLus1/6k3+kzBYg3Qw5
         zPig==
X-Gm-Message-State: AOAM530wTH91dadE5GhX3pNew6XM3YwnI/vCfBVFwvnKliZzQ0o4/KIp
        sCFo9vT367u7OGcpxo558JuHEzaxLnxPbhRyhC1Peg==
X-Google-Smtp-Source: ABdhPJyycpr7Id26HenCHy+3gZWPbEFWI8KfDPa9CNpSYZofFpUwnd5L/18aqm9zuAr9RP71h5VLbgAH2hjDhDupTbg=
X-Received: by 2002:a67:f883:: with SMTP id h3mr3217269vso.47.1606839945590;
 Tue, 01 Dec 2020 08:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20201125212523.GB14534@magnolia> <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
 <1942931.1606341048@warthog.procyon.org.uk> <eb47ab08-67fc-6151-5669-d4fb514c2b50@sandeen.net>
 <20201201032051.GK5364@mit.edu> <f259c5ee-7465-890a-3749-44eb8be0f8cf@sandeen.net>
 <20201201153927.GL5364@mit.edu>
In-Reply-To: <20201201153927.GL5364@mit.edu>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Dec 2020 17:25:32 +0100
Message-ID: <CAJfpegttnxUQP4sPDMCAxmy+Cq=1Vb618iyJJT-df64XgyUBbA@mail.gmail.com>
Subject: Re: Clarification of statx->attributes_mask meaning?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 1, 2020 at 4:42 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Nov 30, 2020 at 09:37:29PM -0600, Eric Sandeen wrote:
> > > We should be really clear how applications are supposed to use the
> > > attributes_mask.  Does it mean that they will always be able to set a
> > > flag which is set in the attribute mask?  That can't be right, since
> > > there will be a number of flags that may have some more complex checks
> > > (you must be root, or the file must be zero length, etc.)  I'm a bit
> > > unclear about what are the useful ways in which an attribute_mask can
> > > be used by a userspace application --- and under what circumstances
> > > might an application be depending on the semantics of attribute_mask,
> > > so we don't accidentally give them an opportunity to complain and
> > > whine, thus opening ourselves to another O_PONIES controversy.
> >
> > Hah, indeed.
> >
> > Sorry if I've over-complicated this, I'm honestly just confused now.
>
> Yeah, I'm honestly confused too how applications can use the
> attributes mask, too.

If the meaning is "the flags value is valid" then the use case would be:

 - look in mask if set, if yes, then can use the corresponding flag

 - if mask is not set, then ignore flag, and try to find out the value
of the property some other (possibly more expensive) way.

For STATX_ATTR_DAX it makes sense, since the value can be determined
in alternative ways on old kernels, so application can fall back if
DAX is not in the mask.

As noted upthread any other use would be ambiguous.

Thanks,
Miklos
