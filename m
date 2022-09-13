Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DB85B79F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 20:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiIMSq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiIMSpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:45:54 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F2D7D1FE
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 11:26:19 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l5so9841776qvs.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2lXvMyo7eNpingqrtM1pHnhzh4QvfSbnYwv0x3JtGYo=;
        b=eGXsA1zJBe2k5uUsbsxdK+6LU4+Vg6CiIMo6m2chdM/oEScMjKF1QQJgLoOpPZPR4l
         NSFzprV+6I3FOWu8CJQPuOWS6qfKQfo/5Bf54rosI1PO+3Adn2/9HhLh8w8GQTF/rCm4
         p6BTmzsZQ/iVG3vq1iKx8RPEhop3RuBwRklc01LaS2QSOSZVe7q3dUokH4r01bonrLLW
         HzP4aFiM/Q4vygLygPlOx7SwhgQcZIoPMYhvSZBMC7YjkDSs+XNcbGwzXBQgEF2ylyZx
         0lweOD/pr6CeywtwsipnuB76lDJ5WKF7C3WKVnMXRDGhPSDNmzVGlskz0By/RDcwvwpt
         toTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2lXvMyo7eNpingqrtM1pHnhzh4QvfSbnYwv0x3JtGYo=;
        b=OZJ2vUPWQrh6OQf5JsNOMtMpz8+WM9HWW88x8MFkRONLoazgW4ZwXFfSJ0s8C/H1XG
         EA8Dv2sXqE01JLIyiPl5idjxrPeMBS1zyfuGbOAik826xe6uUsbuskVP5F9/f3h3w0wo
         H6mnGbJLXMD2KNFgChIfalauxi8KH1R/Vozd3WkSltixBhlOBd2NUIGg5qofW/FIRVq9
         PEWP0/cnnCR4Pz+qDVS9YzGHmFyFri+0EIUefWoYaq5BTUP+UAg7Ile0vQNbDj/3CxDv
         4SwhVZ8sHqREI50vYn4CqadMIoC5a35a0XTzU9LAD5e8QhLzUCXJtpRZZ2uLq+sNn0+G
         HxTQ==
X-Gm-Message-State: ACgBeo17RZaS21BzHIeOniytVi0mDbWOAYCpnMO8DPOShboV8u5VUjG6
        soF4O8LZHqsSQSfIDRm/RZIXIf+nBoRIG8etgsG/7iyUEknPoQ==
X-Google-Smtp-Source: AA6agR5DO/gxHVRcu9FS0IsY8RQcXQe2BdtEi6cmPxdC76loAntP8nC4CBAqLhawGLzG1Hn8Ty9cleUiEkj4v3X1X4M=
X-Received: by 2002:a0c:c547:0:b0:4ac:9897:543f with SMTP id
 y7-20020a0cc547000000b004ac9897543fmr14837353qvi.17.1663093578184; Tue, 13
 Sep 2022 11:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
 <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com>
 <CAOQ4uxh2OZ_AMp6XRcMy0ZtjkQnBfBZFhH0t-+Pd298uPuSEVw@mail.gmail.com>
 <CAJfpegt4N2nmCQGmLSBB--NzuSSsO6Z0sue27biQd4aiSwvNFw@mail.gmail.com>
 <CAOQ4uxjjPOtH9+r=oSV4iVAUvW6s3RBjA9qC73bQN1LhUqjRYQ@mail.gmail.com>
 <CA+khW7hviAT6DbNORYKcatOV1cigGyrd_1mH-oMwehafobVXVg@mail.gmail.com> <CAOQ4uxjUbwKmLAO-jTE3y6EnH2PNw0+V=oXNqNyD+H9U+nX49g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjUbwKmLAO-jTE3y6EnH2PNw0+V=oXNqNyD+H9U+nX49g@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 13 Sep 2022 11:26:07 -0700
Message-ID: <CA+khW7jQ6fZbEgzxCafsaaTyv7ze58bd9hQ0HBH4R+dQyRaqog@mail.gmail.com>
Subject: Re: Overlayfs with writable lower layer
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:28 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Sep 12, 2022 at 8:43 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Sep 12, 2022 at 8:40 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Mon, Sep 12, 2022 at 5:22 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > I imagine the "switch" layer for a HSM would be simple enough:
> > > >
> > > > a) if file exists on fastest layer (upper) then take that
> > > > b) if not then fall back to fuse layer (lower) .
> > > >
> > > > It's almost like a read-only overlayfs (no copy up) except it would be
> > > > read-write and copy-up/down would be performed by the server as
> > > > needed. No page cache duplication for upper, and AFAICS no corner
> > > > cases that overlayfs has, since all layers are consistent (the fuse
> > > > layer would reference the upper if that is currently the up-to-date
> > > > one).
> > >
> > > On recent LSF/MM/BPF, BPF developers asked me about using overlayfs
> > > for something that looks like the above - merging of non overlapping layers
> > > without any copy-up/down, but with write to lower.
> > >
> > > I gave them the same solution (overlayfs without copy-up)
> > > but I said I didn't know what you would think about this overlayfs mode
> > > and I also pointed them to the eBPF-FUSE developers as another
> > > possible solution to their use case.
> > >
> >
> > Thanks Amir for adding me in the thread. This idea is very useful for
> > BPF use cases.
>
[...]
>
> Am I to understand that the eBPF-FUSE option currently
> does not fit your needs (maybe because it is not ready yet)?
>

Yeah, mostly because eBPF-FUSE is not ready. I talked to Alessio and
his colleague after LSF/MM/BPF. They were distracted from eBPF-FUSE
development at that time and I didn't follow up, working on other BPF
stuff.

> >
[...]
> Can't say I was able to understand the description, but let me
> try to write the requirement in overlayfs terminology.
> Please correct me if I am wrong.
>
> 1. The "lower" fs (cgroupfs?) is a "remote" fs where directories
>     may appear or disappear due to "remote" events
>

Right. Seems we are aligned on this.

> I think there were similar requirements to support changes
> to lower fs which in a network fs in the past.
> As long as those directories are strictly lower that should be
> possible.
>
> Does upper fs have directories of the same name that need to
> be merged with those lower dirs?
>

No, I don't think so. Upper fs should only have files in my use case.

> 2. You did not mention this but IIRC, the lower fs has (pseudo)
>     files that you want to be able to write to, and those files never
>     exist in the upper fs
>
> That translates to allowing write to lower fs without triggering copy-up
>

Writing to lower is not needed right now.

> 3. The upper fs files are all "pure" - that means those file paths
>     do not exist in lower fs
>
> Creating files in the upper fs is normal in overlayfs, so not a problem.
>

Yes. If used in an expected way, the lower fs won't have file paths
that also exist in the upper.

> 4. Merging upper and lower directory content is usually not needed??
>
> It must be needed for the root dir at least but where else?
> In which directories are the upper files created?
> Which directories are "pure" (containing either lower or upper files)
> and which directories are "merge" of upper and lower children?
>

In my use case, if that's doable, all the directories are "pure",
except the root dir, and they are in the lower. The files are either
from upper or from lower, so no merge. This should be sufficient for
the BPF use case.

> If the answer is that some directories exist both in upper and in lower
> and that those directories should be merged for the unified view then
> this is standard overlayfs behavior.
>
> Once I get the requirement in order I will try to write coherent
> semantics for this mode and see if it can meet the needs of other
> projects, such as HSM with FUSE as lower fs.

Thanks Amir. I want to clarify that with my very very limited
knowledge on FS, I can't say what I am thinking right now is
absolutely correct. Please take my request for features with a grain
of salt and feel free to pick the semantics that you see make most
sense.

Hao
