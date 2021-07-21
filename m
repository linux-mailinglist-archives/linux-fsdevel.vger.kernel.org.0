Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F63D0920
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 08:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhGUGDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 02:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbhGUGDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 02:03:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450A4C0613E6;
        Tue, 20 Jul 2021 23:43:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b26so1620907lfo.4;
        Tue, 20 Jul 2021 23:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yScSiVlrT7uuBYr0A0fKZlvdo+1Nk40dqOsnX8Hctkk=;
        b=ecOTEGbNLLFz2y6GiZbCEf2DsTpcUuOEqjf8x29vCj2OsZlQAc1WwbFFneJ7vKksXy
         IMRgblsvaK0KF0Z6z8WChNYTN9gxlcrd8VmLrp89b/cUvpzKvGn7juD/0wmg9OpVDmLf
         z1BFq0cDr1ARrHD1MbasOq0rDBDV31vRq8ciW5TDYTVNxI39qehx/mHzLpjHjGWq5quL
         5HEUuD5OPVRPJJZxPCn+JmuNkrXEuZ0cDqQ0kbfRTlX+Y+mwFkO/E5diy+HQ6z2VuqOF
         TyNK4OWt+dYSiwCuJb8Fht5ddpe2BfIb/kJV1pcT1Udg4NFJbdSTvf8oD9ruS8KGucyP
         o+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=yScSiVlrT7uuBYr0A0fKZlvdo+1Nk40dqOsnX8Hctkk=;
        b=goEb6KeqO4ptJP4048xNhDHVtrUdP2bX6NnhjNNF2N2QUAbIfBoDHEQMCl5U7zBbgA
         t7S4LyMIBBVu97GvqnX1XQ6FRKWpqoPNQ3hDKk3k3k5wnKKxplDKPPs7V60jXcwHvZ52
         w4cpDqEExFbUKztF1APbnzXL8cWoEpEvxQPl1P8zDcsD1F2il6MYbEkr5yCF28S72f0v
         EAz2wDhAt54iV8P+mcUeVsYF6ZSjmITiVZQl2aTrgOU6zTY2QjpkAPoO5aApUIFojCk7
         4Iu2L71JnAVh621QC75aQLFc0N9lMzeZYoeGlp5Mti5kUgjzZhH1qjW2gBAM50O+EY29
         r28Q==
X-Gm-Message-State: AOAM533dElZ9HdKkiePXt4RtE3npT8+rpI8WudIAlko42h09FYlTF29w
        W7XJgs3U93nHSiqwrbsMvWpDTPAgCqaKRom9nuw=
X-Google-Smtp-Source: ABdhPJxxZrS1hLgC5AylmXUMWG461QjehxNs5N9XXF+wghnstGUAe7F/ABISs12JRz+m0SwCOKgJWWh3BXeCuJkJH1U=
X-Received: by 2002:ac2:5482:: with SMTP id t2mr24806101lfk.135.1626849793424;
 Tue, 20 Jul 2021 23:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia> <YPc9viRAKm6cf2Ey@casper.infradead.org>
 <YPdkYFSjFHDOU4AV@B-P7TQMD6M-0146.local> <20210721001720.GS22357@magnolia>
 <YPdrSN6Vso98bLzB@B-P7TQMD6M-0146.local> <CAHpGcM+8cp81=bkzFf3sZfKREM9VbXfePpXrswNJOLVcwEnK7A@mail.gmail.com>
 <YPeMRsJwELjoWLFs@B-P7TQMD6M-0146.local>
In-Reply-To: <YPeMRsJwELjoWLFs@B-P7TQMD6M-0146.local>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 21 Jul 2021 08:43:00 +0200
Message-ID: <CAHpGcMJg5TOhexLdN8HgGoFhB8kbn1FdAD8Z2XEK9C7oHptFwA@mail.gmail.com>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
To:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mi., 21. Juli 2021 um 04:54 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> Hi Andreas,
>
> On Wed, Jul 21, 2021 at 04:26:47AM +0200, Andreas Gr=C3=BCnbacher wrote:
> > Am Mi., 21. Juli 2021 um 02:33 Uhr schrieb Gao Xiang
> > <hsiangkao@linux.alibaba.com>:
> > > > And since you can only kmap one page at a time, an inline read grab=
s the
> > > > first part of the data in "page one" and then we have to call
> > > > iomap_begin a second time get a new address so that we can read the=
 rest
> > > > from "page two"?
> > >
> > > Nope, currently EROFS inline data won't cross page like this.
> > >
> > > But in principle, yes, I don't want to limit it to the current
> > > EROFS or gfs2 usage. I think we could make this iomap function
> > > more generally (I mean, I'd like to make the INLINE extent
> > > functionity as general as possible,
> >
> > Nono. Can we please limit this patch what we actually need right now,
> > and worry about extending it later?
>
> Can you elaborate what it will benefit us if we only support one tail
> block for iomap_read_inline_data()? (I mean it has similar LOC changes,
> similar implementation / complexity.) The only concern I think is if
> it causes gfs2 regression, so that is what I'd like to confirm.

iomap_read_inline_data supports one inline page now (i.e., from the
beginning of the file). It seems that you don't need more than one
tail page in EROFS, right?

You were speculating about inline data in the middle of a file. That
sounds like a really, really bad idea to me, and I don't think we
should waste any time on it.

> In contrast, I'd like to avoid iomap_write_begin() tail-packing because
> it's complex and no fs user interests in it for now. So I leave it
> untouched for now.

I have no idea what you mean by that.

> Another concern I really like to convert EROFS to iomap is I'd like to
> support sub-page blocksize for EROFS after converting. I don't want to
> touch iomap inline code again like this since it interacts 2 directories
> thus cause too much coupling.
>
> Thanks,
> Gao Xiang
>
> >
> > > my v1 original approach
> > > in principle can support any inline extent in the middle of
> > > file rather than just tail blocks, but zeroing out post-EOF
> > > needs another iteration) and I don't see it add more code and
> > > complexity.
> >
> > Thanks,
> > Andreas

Andreas
