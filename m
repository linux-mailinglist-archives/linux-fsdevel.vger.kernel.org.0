Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982A93AE5DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 11:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFUJWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhFUJWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:22:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CB2C0617A8
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 02:20:25 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q64so22302313qke.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Thh2opi8YGKKCEfU6ECwo8lT/xNy33vFpN+m6aUkk70=;
        b=Sfu8uTdvW0jrc71YyHyh5FMxfTEEBAQndnCmL6dQ9ergOHCUENc4bR+FFIUDYLUhx3
         6MVCVL4fiUOi7VRwE8zX6GW59jCNTh1AdczkRBo10bRNom0MTrH+WE708COsy07lfGFW
         H8+VH1OBwO59X7fKIzk1lSwPLEQa8KDVqe0l7VQeQRw/GW27lrUnjv09l6yqP9hnId9w
         EMoVCF2OFTsozX5VTg56eaz8EEo8oChfisqzr7XClOLrGkZpTcY9hlznx5PpTbpPFzNs
         G7Y6GDl4k78MujFJ/riPoKEavpNecta+tgHkI3yPE9JF6XmS0wrwp5Dxi8ePB9uHRAXq
         XVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Thh2opi8YGKKCEfU6ECwo8lT/xNy33vFpN+m6aUkk70=;
        b=E0dox4ls1TLPIUa/XPlg0SVg7IyGOiin2/aebzYMf/ypfKmaY6LIDEqnYkF7neUThp
         9pyyYcXTys67mf83/Ch+xrTLpiSvSDm+mqJIxQCD26dSrrXEqBoQLdaGhmrEgL+qrubh
         ooPqpdE2q14x8tB6/27fWohziH63Fe/+UciuKj7vVVwnQP4Re5oT1nPVf/SEnizT233t
         fcBerBsjXPtEdmiMmvcEzLaG9vjIeAmZip5zhaba0xFNdDbH10sz7B07eQW1Y9sMRe5f
         TLNiQ8s/box8LY1XxhIDiyJuBqD8DC88fdFq5TFEHqteG062uRItQnzlLgbK4a22nBk7
         uXMA==
X-Gm-Message-State: AOAM531hWPf9/35HmzhW8GsH5LY7m5ZtzSORtszfttPnyiralHYMKZ8b
        fBSoWDynhECd3pk2WOm4MErnMf8cBa/T5mqYGdCO4Q==
X-Google-Smtp-Source: ABdhPJweQq+krXsUDsoeOuS4izGdW2bpWPGAcnA8SsKmxmctBiSz3y8JmTYbQnPZ+PkDcdOM5HQzhkzgI3dU7uno8zA=
X-Received: by 2002:a25:2351:: with SMTP id j78mr30757910ybj.391.1624267221792;
 Mon, 21 Jun 2021 02:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210617095309.3542373-1-stapelberg+linux@google.com>
 <CAJfpegvpnQMSRU+TW4J5+F+3KiAj8J_m+OjNrnh7f2X9DZp2Ag@mail.gmail.com>
 <CAH9Oa-ZcG0+08d=D5-rbzY-v1cdUcuW0E7D_GcwjDoC1Phf+0g@mail.gmail.com> <CAJfpegu0prjjHVhBzwZBVk5N+avHvUcyi4ovhKbf+F7GEuVkmw@mail.gmail.com>
In-Reply-To: <CAJfpegu0prjjHVhBzwZBVk5N+avHvUcyi4ovhKbf+F7GEuVkmw@mail.gmail.com>
From:   Michael Stapelberg <stapelberg+linux@google.com>
Date:   Mon, 21 Jun 2021 11:20:10 +0200
Message-ID: <CAH9Oa-YxeZ25Vbto3NyUw=RK5vQWv_v7xp3vHS9667iJJ8XV_A@mail.gmail.com>
Subject: Re: [PATCH] backing_dev_info: introduce min_bw/max_bw limits
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Roman Gushchin <guro@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Miklos

On Fri, 18 Jun 2021 at 16:42, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, 18 Jun 2021 at 10:31, Michael Stapelberg
> <stapelberg+linux@google.com> wrote:
>
> > Maybe, but I don=E2=80=99t have the expertise, motivation or time to
> > investigate this any further, let alone commit to get it done.
> > During our previous discussion I got the impression that nobody else
> > had any cycles for this either:
> > https://lore.kernel.org/linux-fsdevel/CANnVG6n=3DySfe1gOr=3D0ituQidp56i=
dGARDKHzP0hv=3DERedeMrMA@mail.gmail.com/
> >
> > Have you had a look at the China LSF report at
> > http://bardofschool.blogspot.com/2011/?
> > The author of the heuristic has spent significant effort and time
> > coming up with what we currently have in the kernel:
> >
> > """
> > Fengguang said he draw more than 10K performance graphs and read even
> > more in the past year.
> > """
> >
> > This implies that making changes to the heuristic will not be a quick f=
ix.
>
> Having a piece of kernel code sitting there that nobody is willing to
> fix is certainly not a great situation to be in.

Agreed.

>
> And introducing band aids is not going improve the above situation,
> more likely it will prolong it even further.

Sounds like =E2=80=9CPerfect is the enemy of good=E2=80=9D to me: you=E2=80=
=99re looking for a
perfect hypothetical solution,
whereas we have a known-working low risk fix for a real problem.

Could we find a solution where medium-/long-term, the code in question
is improved,
perhaps via a Summer Of Code project or similar community efforts,
but until then, we apply the patch at hand?

As I mentioned, I think adding min/max limits can be useful regardless
of how the heuristic itself changes.

If that turns out to be incorrect or undesired, we can still turn the
knobs into a no-op, if removal isn=E2=80=99t an option.

Thanks
Best regards
Michael
