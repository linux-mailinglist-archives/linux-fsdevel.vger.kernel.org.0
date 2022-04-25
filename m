Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D235050DE1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 12:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiDYKqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDYKqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:46:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61603ED25;
        Mon, 25 Apr 2022 03:43:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q8so2904860plx.3;
        Mon, 25 Apr 2022 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTrK70Twcs08QgBKFyv5m+b+8I/8wCwb0qiPupCK5OQ=;
        b=gnKliS7ciy37lTRRjbpPb/Iiw7ITRcI47u2KZuyUJIPHWDRA0kn0coWTCC3IX7LIaA
         /o88IL99rC+JvsC3cEWtEUo0OOPC9e15o8c+J4HjwFTQwwEtIahHi90zniV5itbwaaaJ
         rxPHKw73WnX48FWTpeeNfEjpNXd+/3o3RGF/0qxB+io+PMZ8ALrRy0OBmQXA4oQUbu6j
         UVs/oAMginJc/yhgTy9xYuVZvUENenPU+XEcQT2elEJW3r7eohneqWT5FI+ggh5zCcMx
         LbGlt+5Pc12lW731cxq0kTmbxsYzvR82vwJn4Z8+dVtFkFGdN4qmLthboSzKyiWK1acu
         KJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTrK70Twcs08QgBKFyv5m+b+8I/8wCwb0qiPupCK5OQ=;
        b=sJu7RurhlThiHO2EWDLgr9NFgpCa0IodAgfAnGqmrFlPQYcgFACQbo4WyFyNQezicV
         xF9ZBwaGhbjAP4OIwcmiX89mdqggk6Xs3Ch1A5ZOwQL2mBsldHj4cqA/18Ls3nKaloG7
         HefAG65tZOIsmbtlTwFWh4ghw3Qg2PA7CdAviRhdkGOcPYAujNEgUqTz8IhbZrpqQWIW
         wyTjtFviC41hab8uXMaqJrWw7jKMCkCYkc50cFhEuzKgKUsAVT8X3d+7qIiNIEpHtQp+
         7B6oi2Gc2oaPrqldXQdy9fVF3M9j0ngHgvl0sGTtegNql5FuR03IPIHsn/V64vWx/puV
         AtMw==
X-Gm-Message-State: AOAM53085y4mPpdGfpXb62DmotGb/QOW3zqBEd9muDTgktvBKh286iQu
        uv8vhI48pWbqmQNduMSZa6P6P74xVy6nFfIufPU=
X-Google-Smtp-Source: ABdhPJwcY6DMfS3ZQrjLoYI1XA8XORJeOTaLCEfIpadXXpfdDdvnBZsPk2W5i9cJxOOh6kJRseNCISwV+ZKMMNVUMWs=
X-Received: by 2002:a17:90a:a509:b0:1ca:c48e:a795 with SMTP id
 a9-20020a17090aa50900b001cac48ea795mr30696207pjq.165.1650883394119; Mon, 25
 Apr 2022 03:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220322115148.3870-1-dharamhans87@gmail.com> <20220322115148.3870-2-dharamhans87@gmail.com>
 <CAJfpegtunCe5hV1b9cKJgPk44B2SQgtK3RG5r2is8V5VrMYeNg@mail.gmail.com>
 <CACUYsyGmab57_efkXRXD8XvO6Stn4JbJM8+NfBHNKQ+FLcA7nA@mail.gmail.com> <CAJfpegt5qWE4UepoDj9QBuT--ysT6+7E-6ZQvNeZ+bODRHHCvg@mail.gmail.com>
In-Reply-To: <CAJfpegt5qWE4UepoDj9QBuT--ysT6+7E-6ZQvNeZ+bODRHHCvg@mail.gmail.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Mon, 25 Apr 2022 16:13:02 +0530
Message-ID: <CACUYsyFrP5UDOJKCLOr+PeHjnh9RV=wWOBRFN31-Fr-gi1d2WA@mail.gmail.com>
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

On Mon, Apr 25, 2022 at 1:08 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 25 Apr 2022 at 07:26, Dharmendra Hans <dharamhans87@gmail.com> wrote:
> >
> > On Fri, Apr 22, 2022 at 8:59 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Tue, 22 Mar 2022 at 12:52, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> > > >
> > > > From: Dharmendra Singh <dsingh@ddn.com>
> > > >
> > > > There are couple of places in FUSE where we do agressive
> > > > lookup.
> > > > 1) When we go for creating a file (O_CREAT), we do lookup
> > > > for non-existent file. It is very much likely that file
> > > > does not exists yet as O_CREAT is passed to open(). This
> > > > lookup can be avoided and can be performed  as part of
> > > > open call into libfuse.
> > > >
> > > > 2) When there is normal open for file/dir (dentry is
> > > > new/negative). In this case since we are anyway going to open
> > > > the file/dir with USER space, avoid this separate lookup call
> > > > into libfuse and combine it with open.
> > > >
> > > > This lookup + open in single call to libfuse and finally to
> > > > USER space has been named as atomic open. It is expected
> > > > that USER space open the file and fills in the attributes
> > > > which are then used to make inode stand/revalidate in the
> > > > kernel cache.
> > > >
> > > > Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> > > > ---
> > > > v2 patch includes:
> > > > - disabled o-create atomicity when the user space file system
> > > >   does not have an atomic_open implemented. In principle lookups
> > > >   for O_CREATE also could be optimized out, but there is a risk
> > > >   to break existing fuse file systems. Those file system might
> > > >   not expect open O_CREATE calls for exiting files, as these calls
> > > >   had been so far avoided as lookup was done first.
> > >
> > > So we enabling atomic lookup+create only if FUSE_DO_ATOMIC_OPEN is
> > > set.  This logic is a bit confusing as CREATE is unrelated to
> > > ATOMIC_OPEN.   It would be cleaner to have a separate flag for atomic
> > > lookup+create.  And in fact FUSE_DO_ATOMIC_OPEN could be dropped and
> > > the usual logic of setting fc->no_atomic_open if ENOSYS is returned
> > > could be used instead.
> >
> > I am aware that ATOMIC_OPEN is not directly related to CREATE. But
> > This is more of feature enabling by using the flag. If we do not
> > FUSE_DO_ATOMIC_OPEN, CREATE calls would not know that it need to
> > optimize lookup calls otherwise as we know only from open call that
> > atomic open is implemented.
>
> Right.  So because the atomic lookup+crteate would need a new flag to
> return whether the file was created or not, this is probably better
> implemented as a completely new request type (FUSE_ATOMIC_CREATE?)
>
> No new INIT flags needed at all, since we can use the ENOSYS mechanism
> to determine whether the filesystem has atomic open/create ops or not.

Yes, it sounds good to have a separate request type for CREATE. I
would separate out the patch into two for create and open.  Will omit
INIT flags. Also, I would change libfuse code accordingly.
