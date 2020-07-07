Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F321747F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 18:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGGQyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 12:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgGGQyo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:54:44 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 093B82073E;
        Tue,  7 Jul 2020 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594140883;
        bh=fEhHujOWT36+OabKkCVMgT4sNk+uKrQIrQGXIHydFwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bCjJrygyiPww6kUU1HIhiqvAtUoYFZgfBZLacoL8WWlEnNSpxyNTKSWWnE02wur3W
         la5/xoBE/rrYn79OqHMEZyKCfnR6at4ysqt7OgZQRTEXFhQbzmvGlABsaWFhTozrLN
         BqSDAWIbImu3SzXMGQyAzxLupyTh6IKQ7SJyzEyA=
Received: by mail-lj1-f169.google.com with SMTP id 9so50699453ljv.5;
        Tue, 07 Jul 2020 09:54:42 -0700 (PDT)
X-Gm-Message-State: AOAM532rgQKXqcBIdGCeHf8QecpU1j5vH9V3UU/6OPlWF6T+TIUFoJcS
        AsZD2F1O3HX9nCJG3uQJ69Cg+fdnoJ1iVUnefGU=
X-Google-Smtp-Source: ABdhPJzFOzMDLXjZKmd6F6Pp7vLuJIA+Ucm855pm5b8NKZ5A6EYoeTZy9JfFcYYbEy+B8rG0uxCxsGAeLu6NZEkIV/4=
X-Received: by 2002:a2e:9eca:: with SMTP id h10mr31940794ljk.273.1594140881295;
 Tue, 07 Jul 2020 09:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200615125323.930983-1-hch@lst.de> <20200615125323.930983-2-hch@lst.de>
 <CAPhsuW6chy6uMpow3L1WvBW8xCsUYw4SbLHQQXcANqBVcqoULg@mail.gmail.com> <20200707103439.GA2812@lst.de>
In-Reply-To: <20200707103439.GA2812@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 7 Jul 2020 09:54:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6CvKMPEuUEFfZhxyyU2ke9oiYOuCwkM+NM2=bo_o_MFw@mail.gmail.com>
Message-ID: <CAPhsuW6CvKMPEuUEFfZhxyyU2ke9oiYOuCwkM+NM2=bo_o_MFw@mail.gmail.com>
Subject: Re: [PATCH 01/16] init: remove the bstat helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 7, 2020 at 3:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 02, 2020 at 04:25:41PM -0700, Song Liu wrote:
> > Hi Christoph,
> >
> > On Mon, Jun 15, 2020 at 5:53 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > The only caller of the bstat function becomes cleaner and simpler whe=
n
> > > open coding the function.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Thanks for the set. md parts of the set look good to me.
> >
> > How should we route this set, as it touches multiple subsystems?
>
> Good question as there is no really applicable tree.  One option
> would the vfs tree as it touche=D1=95 some VFS stuff, and the follow on
> series that depends on it is all about VFS bits.  Alternatively I
> could set up a tree just for these bits.  The important bit is that
> it doesn't go into the -mm tree as the usual catchall, as I have
> more stuff that depends on it and requires a git tree.

Would this official mm tree work?

T:      git git://github.com/hnaz/linux-mm.git

If not, I am OK with either vfs tree or a dedicated tree.

Thanks,
Song
