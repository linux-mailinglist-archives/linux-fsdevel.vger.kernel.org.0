Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC54A2AAECB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 02:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgKIBoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 20:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgKIBoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 20:44:18 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F33C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 17:44:18 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id i18so7480968ots.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 17:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zx0c9QjdSSJdv5cZelIQSpfHvvwpNT84JqxZReYCE4M=;
        b=mX3ChUCPcgEEO3MiehfN9/V0VDmBhN8v2Ss/9rR8R3DbEx2mKz1k1qh1wUp4tJ5KZd
         OGolOOhZaswj3nHQ6YpNm6MPOSZrbkW3OGiyPfXuTcXjmymal0YsHvJNT0SVWaXCgOVM
         Mzr++RGC2PC0DviZ+paYAiZzXymYRejVCznkc871IGNAFESrqseKEHLQu+95F6BjOioT
         iXHw1kDO8HUDxg8/2Ie2kw8sCKCLm4cEP3hESJHQ0F/3gGcQs8XFqdOD6fX/godHbj4n
         KvMydU7y0F8zFH9DB7oxfKJgkNY8xRhNo2kuGF7gJx6BQ/87RDo0qpZ4bokM5gqiRPcE
         MRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zx0c9QjdSSJdv5cZelIQSpfHvvwpNT84JqxZReYCE4M=;
        b=LmzWi08H4catJApaksglEAJhun01bQGCyFPG6KYmuTg2grVFyPyEtcyERj2Ioswhsm
         31Mo+L2qnlje14k5h2fePdEksYjUYqJNPW5NjQcEQ8yQnTccb2+RDDNbIUMr4M3ggqeS
         zkCgNOH1vGFBNnTXcURXgejOkJNv0Fq63sidtOxF/qxIiv70nIF3C6rtd6Me0s7aDkXA
         xaOxdtoCT0DRuIqCmILTSifN4+pwDXLNnTYp+CMCrKxSifYfOONEE5cwxf6fwXC6M5V4
         Fjxfi9FEPILLY8fKGcfc89FU0F6rMUoA1BeO0iwIfQzR6LHNNYMyxcxGl17nYy+OWgr7
         cdRw==
X-Gm-Message-State: AOAM533Dt7RVBAg4wa2BARkckAOUn6mnIGA1YpqJGUBJzvPS+v9VBv2n
        sLCC3LIEhNOxHIvsIIytQpSb2JF1hHO2Pj8dPzI=
X-Google-Smtp-Source: ABdhPJyKVhaUESLtlsP92cqSh9d/N0HYJVtvO4iu/WankSFdIidQyQrvCJ/s8TtjX+BrlTg37YJQoHBBKlNOHxaTTSk=
X-Received: by 2002:a9d:694e:: with SMTP id p14mr8056410oto.254.1604886257849;
 Sun, 08 Nov 2020 17:44:17 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
 <20201109013322.GA9685@magnolia>
In-Reply-To: <20201109013322.GA9685@magnolia>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Sun, 8 Nov 2020 17:44:07 -0800
Message-ID: <CAE1WUT4RV3rd8YRQdh0dRqATRhP3DUNe4X=ZC8DopqBo74dJyA@mail.gmail.com>
Subject: Re: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Matthew Wilcox <willy@infradead.org>, dan.j.williams@intel.com,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 8, 2020 at 5:35 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Sun, Nov 08, 2020 at 05:15:55PM -0800, Amy Parker wrote:
> > I've been writing a patch to migrate the defined DAX_ZERO_PAGE
> > to XA_ZERO_ENTRY for representing holes in files.
>
> Why?  IIRC XA_ZERO_ENTRY ("no mapping in the address space") isn't the
> same as DAX_ZERO_PAGE ("the zero page is mapped into the address space
> because we took a read fault on a sparse file hole").
>
> --D

Matthew recommended that we use a single entry here instead of adding
extra unnecessary definitions:
> Right now, fs/dax.c uses a bit -- DAX_ZERO_PAGE --
> to represent a hole in the file.  It could equally well use a single entry,
> and we already have one defined, XA_ZERO_ENTRY.  I think a patch to
> convert it over would be a great idea.

In practice, it works perfectly fine - ran a qemu instance with a 20 GiB
NVDIMM, set up a standard namespace and ran XFS with DAX enabled
on it, and then passed over it with xfstests. Nothing changed versus
the current effect.
