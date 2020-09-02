Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F725AF87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgIBPkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgIBPBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:01:35 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B97C061244;
        Wed,  2 Sep 2020 08:01:33 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w16so655041oia.2;
        Wed, 02 Sep 2020 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=nJe4bseURKFlSbOPv7F3NIQsZoqm5FYsgLr0QZUs55k=;
        b=s+mAMeELwz+mjnmSPT3Zj6IVhbRc6v9DjE4m0Xbm+6ZuyynublUKEyZ7uAGImlVD/v
         hvWGvgfkJV8LYZ30EvV8n1YN14fdkFmrBNoXGJljpY+0YaHsr31K392JhbyNnku5b/tv
         sU9Tn88lvEMYCuk/+NlLaPtooFhkdwUQAJVMn4+GOkzi5tYPRsZuSS+mPfSj/EwXWKV4
         pQSUsfw3YeJwbpGID5609rp6rdSmGKszfPM5CjpxZoUuh3JdwZ1wmBHyXvVB5T1FkFzC
         2qUxvC9ZMKC70/Nc6hBV4y1pm71Fcp50MkEGf8t9e+i25q7t9CCsvRdT+AcbjLtANyLU
         jX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=nJe4bseURKFlSbOPv7F3NIQsZoqm5FYsgLr0QZUs55k=;
        b=mclaPPKu9RulT0vnSine7oTnscct7i0w3bQYuZGsRnTxjtnViecDkWOPtE6+obHy18
         we37SgRQGGVt/mpBJveCgc/e0S0XJMUq7AVxO8DDuyYxVfX+o/2gSvU8evBLosRDFmYf
         6TF2lfcdFTD1gjM0Bkl++QWC9xluIdYlv1G/QLGA9iOcCio+J9SsW2EIZPuaNS7xNLGL
         Y7/7S7oExGEyu6LeHjuU2V16umCmXSZ3ncK6a6Y5s5VsXc3msSJilhlu6xznnNmTWTxs
         5mJFaBF7rZckVsWXINBBSAz1plM8VsxRA/pG+7XSbtDVcsHM5T1xXbVbBocLp+VAPzws
         jK9g==
X-Gm-Message-State: AOAM530kYEMkTXg+hRmYNFIwmnyK1FSWOX3SffYG+rz/pnH4x2xba20M
        +zv51IAud9PwuFbyI0F1IZV9xuBryhAzGp8UpRw=
X-Google-Smtp-Source: ABdhPJx/mXwElQ9ceRtlLkNMe4EmP2VKMWxpRmh+9jLPadSxEg/xZ12/Z1JM/YjWMx/YjFp+H/WaIu4DAIHja8b/REQ=
X-Received: by 2002:a54:4117:: with SMTP id l23mr2346042oic.177.1599058892842;
 Wed, 02 Sep 2020 08:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
 <159827190508.306468.12755090833140558156.stgit@warthog.procyon.org.uk>
In-Reply-To: <159827190508.306468.12755090833140558156.stgit@warthog.procyon.org.uk>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 2 Sep 2020 17:01:21 +0200
Message-ID: <CAKgNAkho1WSOsxvCYQOs7vDxpfyeJ9JGdTL-Y0UEZtO3jVfmKw@mail.gmail.com>
Subject: Re: [PATCH 4/5] Add manpage for fsopen(2) and fsmount(2)
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

One further thought...

> +++ b/man2/fsopen.2
[...]
> +.BR fsopen ()
> +creates a blank filesystem configuration context within the kernel for the
> +filesystem named in the
> +.I fsname
> +parameter, puts it into creation mode and attaches it to a file descriptor,
> +which it then returns.

The term "filesystem configuration context" is introduced, but never
really explained. I think it would be very helpful to have a sentence
or three that explains this concept at the start of the page.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
