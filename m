Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7590514173
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 06:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbiD2Ehg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 00:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiD2Ehf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:37:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247CA8A9FD;
        Thu, 28 Apr 2022 21:34:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so7583477pjb.3;
        Thu, 28 Apr 2022 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evyUHOqOn3TXKm02pc1sLqPIBDCTJ+500dIEM+PwO1Q=;
        b=Xbr0A4/YrpGb8LHdyrQj7Uvb273qfk6dEk+N6FmUaLsp9XdYkONWGAZxnE53NyrrG2
         TjTRbMuxublHgZAmC/DK4+MTdVRbaGOO5SSvAt8jNuxEfBE189aLZT8Z4K+STordTbN0
         KdP6DaFtYLoOJKmEyV0yvkfMozHG7hmtZERXkriUcDPGAaAc/MtnJaajcb8yM8LXe3AI
         FLv8ewTJ/zdfqf2SDfN91k3qeGs7EgUT66+TnsqhOx1kH0zFIzRDd8ezVOA/nzAHNOP3
         RXSCbhi6QM86Xkei0TbKBRwzBAerdyXK7/TMmAhMZ3agjlL0y8f+arA7arBD9jwSvopS
         4h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evyUHOqOn3TXKm02pc1sLqPIBDCTJ+500dIEM+PwO1Q=;
        b=eYijC940CsO2LBTle9UEInmjlhPUcq3KoPfMQOhaphSITuCAdA1CnL5UTig5s5PedH
         bUC993ws1nXkIM4WvzYH52K3K8lL209b07/G6DSXlOqRkQHeYdC5sLDNQBjoS1T2J0Qj
         xMPjvaOJVB/EsO87/ZqmG9VKrQ3dc15OzBNCWJur+UTEerrZiJBR+bSFKHeIzxS6i7kj
         RzfhQijegoAUlInCtjt2L2213I/C5r2jCdXbU5uOHcXzQsZ63wmVk4fYd444hlM1sxy9
         xuPCbkvBMIKNExHhbhiLD4iRrvEA9nS5Pbejunu5wQEiSCH8j+Bkvs2sYtFVN1CUWIpr
         qpXw==
X-Gm-Message-State: AOAM5308evTJ10Kcij/m2DO1l8Dxl3u4PTGoyocGi01x+wmohsfINFWW
        Qf5RUiT5HZDFAegXhwgOx2dFnRHiFjhHsWYreVg=
X-Google-Smtp-Source: ABdhPJz+N6SLkD7HusZ2PQAqngkmUnrQp6p3IGUSpB0v/dVKrkW6Qn4I/U1uv89fGoPc1oW58LodLZVIyMg4jqJ1AM8=
X-Received: by 2002:a17:90b:4d86:b0:1da:3cba:bd56 with SMTP id
 oj6-20020a17090b4d8600b001da3cbabd56mr1871622pjb.116.1651206856476; Thu, 28
 Apr 2022 21:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220322115148.3870-1-dharamhans87@gmail.com> <20220322115148.3870-2-dharamhans87@gmail.com>
 <CAJfpegtunCe5hV1b9cKJgPk44B2SQgtK3RG5r2is8V5VrMYeNg@mail.gmail.com>
 <CACUYsyGmab57_efkXRXD8XvO6Stn4JbJM8+NfBHNKQ+FLcA7nA@mail.gmail.com>
 <CAJfpegt5qWE4UepoDj9QBuT--ysT6+7E-6ZQvNeZ+bODRHHCvg@mail.gmail.com> <CACUYsyFrP5UDOJKCLOr+PeHjnh9RV=wWOBRFN31-Fr-gi1d2WA@mail.gmail.com>
In-Reply-To: <CACUYsyFrP5UDOJKCLOr+PeHjnh9RV=wWOBRFN31-Fr-gi1d2WA@mail.gmail.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Fri, 29 Apr 2022 10:04:04 +0530
Message-ID: <CACUYsyGuHEM8U6qsqEE_=mUcAgAFzCYuCLcCtiBf1CGirLE95Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] FUSE: Implement atomic lookup + open
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 4:13 PM Dharmendra Hans <dharamhans87@gmail.com> wrote:
>
> On Mon, Apr 25, 2022 at 1:08 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 25 Apr 2022 at 07:26, Dharmendra Hans <dharamhans87@gmail.com> wrote:
> > >
> > > On Fri, Apr 22, 2022 at 8:59 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Tue, 22 Mar 2022 at 12:52, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> > > > >
> > > > > From: Dharmendra Singh <dsingh@ddn.com>
> > > > >
> > > > > There are couple of places in FUSE where we do agressive
> > > > > lookup.
> > > > > 1) When we go for creating a file (O_CREAT), we do lookup
> > > > > for non-existent file. It is very much likely that file
> > > > > does not exists yet as O_CREAT is passed to open(). This
> > > > > lookup can be avoided and can be performed  as part of
> > > > > open call into libfuse.
> > > > >
> > > > > 2) When there is normal open for file/dir (dentry is
> > > > > new/negative). In this case since we are anyway going to open
> > > > > the file/dir with USER space, avoid this separate lookup call
> > > > > into libfuse and combine it with open.
> > > > >
> > > > > This lookup + open in single call to libfuse and finally to
> > > > > USER space has been named as atomic open. It is expected
> > > > > that USER space open the file and fills in the attributes
> > > > > which are then used to make inode stand/revalidate in the
> > > > > kernel cache.
> > > > >
> > > > > Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> > > > > ---
> > > > > v2 patch includes:
> > > > > - disabled o-create atomicity when the user space file system
> > > > >   does not have an atomic_open implemented. In principle lookups
> > > > >   for O_CREATE also could be optimized out, but there is a risk
> > > > >   to break existing fuse file systems. Those file system might
> > > > >   not expect open O_CREATE calls for exiting files, as these calls
> > > > >   had been so far avoided as lookup was done first.
> > > >
> > > > So we enabling atomic lookup+create only if FUSE_DO_ATOMIC_OPEN is
> > > > set.  This logic is a bit confusing as CREATE is unrelated to
> > > > ATOMIC_OPEN.   It would be cleaner to have a separate flag for atomic
> > > > lookup+create.  And in fact FUSE_DO_ATOMIC_OPEN could be dropped and
> > > > the usual logic of setting fc->no_atomic_open if ENOSYS is returned
> > > > could be used instead.
> > >
> > > I am aware that ATOMIC_OPEN is not directly related to CREATE. But
> > > This is more of feature enabling by using the flag. If we do not
> > > FUSE_DO_ATOMIC_OPEN, CREATE calls would not know that it need to
> > > optimize lookup calls otherwise as we know only from open call that
> > > atomic open is implemented.
> >
> > Right.  So because the atomic lookup+crteate would need a new flag to
> > return whether the file was created or not, this is probably better
> > implemented as a completely new request type (FUSE_ATOMIC_CREATE?)
> >
> > No new INIT flags needed at all, since we can use the ENOSYS mechanism
> > to determine whether the filesystem has atomic open/create ops or not.
>
> Yes, it sounds good to have a separate request type for CREATE. I
> would separate out the patch into two for create and open.  Will omit
> INIT flags. Also, I would change libfuse code accordingly.

Actually when writing the code, I observe that not having INIT flags
works fine for atomic create but it does not work well for atomic
open case considering specially 3rd  patch which optimises
d_revalidate() lookups.
(https://lore.kernel.org/linux-fsdevel/20220322115148.3870-3-dharamhans87@gmail.com/,
 we did not receive any comments on it so far).
So it looks like we need INIT flags in atomic open case at least
considering that 3rd patch would go in as well.
