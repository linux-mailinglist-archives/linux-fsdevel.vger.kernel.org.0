Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1743D2779FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 22:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIXUNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:13:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D18C0613D7;
        Thu, 24 Sep 2020 13:04:52 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q21so102109ota.8;
        Thu, 24 Sep 2020 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Tv5RKEoF0aMWHOO4n1MHZmdoXrH+ybg4QJPlVc/Da88=;
        b=IOV1CI0YJbXIFnn9fJWIqHa23G64xNUjX9edUOsgX3U8Ob7yki08ikjarFXaBwpC7y
         TZp6h6A5Y1FyL3ZHjV/pCS8PLX2ur620kpLVzqjCPWsS71e5YQCR2hrNZvnE+MrGzNCS
         2e0n4NW+P5Xh+nI7KTVraBTmBGd3bHC33j5tTnPz7s1vA+TuhcBnQpkWrrv3B7XL8oJV
         vVHxyRVLurKfc76TxAvzpLqEstCw58n+633N3eE1MFlv7KHWszWtx+Cq9ko9RfFZdi5S
         ctMvIl61qDmO8VwcoS0FkzzZr0bjuAUf9Njp/8k9LCeMxlUOTUpAaxMyM5KpcV/TpEjT
         FTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Tv5RKEoF0aMWHOO4n1MHZmdoXrH+ybg4QJPlVc/Da88=;
        b=bo8RyNPBR2Yvvx+49BCdGYeUbNt1R9ll6g+udTM4mgwHzd6dObEVx3ql7eVD/huhdz
         LJZaeKVoKlmNfC+PeIHUWB9TiCwxbpxmpteb8NHy6HKlcexx5KMTluQztOQwYpDL74D0
         TsoWP0h7rt0krl/N8BbhpzeFqKCLJwCL/bkfPmndENzVKRnPDpp4bntsVUS4dTcDGsZG
         oyVgShbxGBpKlmUrvpmIYIx8EzZeXwY78DFoc6Z+ZGqtFWdwT9mY5VvKHKZ+2mhyHh6O
         1n1tiJN2oATwlVm6J2Aibd7keM40uFI0DnvovdHVrF9vDEHGvIZcp2M09rLBFcV1oE9A
         CvVQ==
X-Gm-Message-State: AOAM5332eTfROVYFXywNPLW5ak0CxMlUNVYWmH01w4fPZuVgIDhoyPIf
        nhZk6EuLMqMfpikHDbliZvbyd6EN3/bOGAmlL4U=
X-Google-Smtp-Source: ABdhPJyMfT0kBCPafavfI3sD+MuQZtwQsREpdq11JaWA0TWTOX4eXMbFA+SQ6Y5sfvUK9T/fE14J0+dTcsBVSW+vMBE=
X-Received: by 2002:a9d:67c3:: with SMTP id c3mr628890otn.9.1600977892337;
 Thu, 24 Sep 2020 13:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200924125608.31231-1-willy@infradead.org> <CA+icZUUQGmd3juNPv1sHTWdhzXwZzRv=p1i+Q=20z_WGcZOzbg@mail.gmail.com>
 <20200924151538.GW32101@casper.infradead.org> <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
 <20200924152755.GY32101@casper.infradead.org> <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
 <20200924163635.GZ32101@casper.infradead.org> <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com> <20200924200225.GC32101@casper.infradead.org>
In-Reply-To: <20200924200225.GC32101@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 24 Sep 2020 22:04:40 +0200
Message-ID: <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 24, 2020 at 09:54:36PM +0200, Sedat Dilek wrote:
> > You are named in "mm: fix misplaced unlock_page in do_wp_page()".
> > Is this here a different issue?
>
> Yes, completely different.  That bug is one Linus introduced in this
> cycle; the bug that this patch fixes was introduced a couple of years
> ago, and we only noticed now because I added an assertion to -next.
> Maybe I should add the assertion for 5.9 too.

Can you point me to this "assertion"?
Thanks.

- Sedat -
