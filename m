Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E80274F42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 04:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgIWCtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 22:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgIWCtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:49:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31888C061755;
        Tue, 22 Sep 2020 19:49:41 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id l16so5932695ilt.13;
        Tue, 22 Sep 2020 19:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iitp+6G6CV8dBY09hArmbnqdeh71WtAbwtN/C393QxQ=;
        b=NqyhVs+/rqSEVLUUutMcC5znSda0KfzAW3N3C38ITH8a6he30nFJXY4DayGvkm9Pff
         cPlIQgCSRSoir9gJNs86Q5feA/dS9kZYXu+MWJY4g6W1H9UjxQaqa//r2Ars1J91kOTS
         MydyaEeQmpa74paNHyM2uY+6LB8qTwC1wxs7OdHu8BOWzufViGRo7iaymL00Y14tD0CJ
         c1Qi0B15yGD6hNhB1iFb+HoKGpgpdiijC5k5WVKPmlgEb5y5V7pT3Sa4sMhHL560aSXk
         uS0uXVFnSkLcuygleH6Li1xC9g1Pbm51H6Noe5rifDU0j+/HUx3xq6x4FZH7ETSzDowY
         Q4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iitp+6G6CV8dBY09hArmbnqdeh71WtAbwtN/C393QxQ=;
        b=SO0RL+ur0bM8zZoQAs1YPcJYqonUGkD/gwTJMVVJ1THSVeYfAqwT7tzkCo/8oMFBJs
         OYrpM7MDT6/8fpxIaDx7nsM0CBb31qQzhqsQInEGwzKzMo+6aEPQ2sx7B48OH6vcohzC
         ogy8o07xk/XCCdAgK5Jeu9+w3fC2NBvjvAY370OZrFaPINwi0occtmmvTE7CoNXLHWff
         G8HUbWVqefYw9c2iA8zmXX2KXr8aC+M66RJp+LB4icPYLv+mWtPo4bVRMPIrAoKoxXYO
         krp+Uz7/aNtTqdnTFUzBGFl+V/5/GN27RvTfB0r9a1gLIVA7kOrbg3DMNFvzmDSRzHZc
         pAvw==
X-Gm-Message-State: AOAM530A5My3fR6Bd8t0rLQet5olLYv7ZWg3ioQS1HJWCRbEIGa9d0rp
        W9fhtAtN8RMvCveSE7HzRBixw5s02GRO0Yu0c0DXwZpH
X-Google-Smtp-Source: ABdhPJzCPiO6Pt1MAv16dOGUfbykWWMajBTBTPLREFJTwlsSIxSOkmR5cxY2sO3zNi5vAKCdjpa9vBMbQOVcLdVPFq4=
X-Received: by 2002:a92:8b41:: with SMTP id i62mr7228764ild.9.1600829380413;
 Tue, 22 Sep 2020 19:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com>
In-Reply-To: <20200922210445.GG57620@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Sep 2020 05:49:29 +0300
Message-ID: <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
Subject: Re: virtiofs uuid and file handles
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:04 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
...
> > Note that if all overlayfs layers are on the same fs and that fs has
> > null uuid, then the "disk copy" use case should just work, but I never
> > tested that.
> >
> > So far, there has been no filesystem with null uuid that could be used
> > as upper+lower layers (even xfs with option nouuid has non null s_uuid).
> >
> > Recently, virtiofs was added as a filesystem that could be used for
> > upper+lower layers and virtiofs (which is fuse) has null uuid.
>
> I guess I never paid attention to uuid part of virtiofs. Probably we
> are not using index or any of the advanced features of overlayfs yet,
> that's why.
>

I don't expect you should have a problem enabling index because
of null uuid when all layers are on the same virtiofs.
That setup is allowed.
We only ever start checking for null uuid on lower layers that
are NOT on the same fs as upper layer.

What you are expected to have a problem with is that FUSE support
for file handles is "problematic".

I found out the hard way that FUSE can decode NFS file handles
to completely different object than the encoded object if the encoded
inode was evicted from cache and its node id has been reused.

Another problem is that FUSE protocol does not have complete
support for decoding file handles. FUSE implements decode
file handle by LOOKUP(ino, ".") to server, but if server is proxying
a local filesystem, there is not enough information to construct
an open_by_handle_at() request.

I wrote a fuse filesystem whose file handles are persistent and
reliable [1], but it is a specialized server that uses knowledge
of the local filesystem file handle format and it requires that the
local filesystem has a special feature to interpret a file handle
with 0 generation as ANY generation (ext4 does that).

I think that the proper was to implement reliable persistent file
handles in fuse/virtiofs would be to add ENCODE/DECODE to
FUSE protocol and allow the server to handle this.

Thanks,
Amir,

[1] https://github.com/amir73il/libfuse/commits/cachegwfs
