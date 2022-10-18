Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0421603163
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJRRNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 13:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiJRRNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:13:02 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CFEEE0A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 10:13:01 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 63so17766214ybq.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfdbluYgB5V+LL+aMgFXBt1BUBV2mMzClPRkIMfQtRE=;
        b=WhdKk792ZP3Bo8QTG2ybSRTF7GCOSQK5CET9zQobOLcag9wngcqrnr8EEXdjrZeRBC
         26G/5RkPvu0DeLhAMCt4vwLZoOrm8FUs9emyx69PxMnUTGuKyhV+Ushr1xfYsfbNE8Lm
         uATLgWuJYEaMgH+zflG1skmb4KaHaeM8AlHzW+Bna7phDYjGe9V3HzIxtiYhApidsDRw
         ZCKgtkooC0VQy+YL0ozJlFQb7aS8f7Bqbd5mYyShHfYzKhQV/QSHZRo9qzvL9g2zxpvv
         0Tmq6SRqApzKDt9G5NphBiGsja/OyeffaD6qO4MdrCaby2+4UMDD5Tzym0aSngwEvAJ0
         WPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfdbluYgB5V+LL+aMgFXBt1BUBV2mMzClPRkIMfQtRE=;
        b=5Raw9L0W1YKv2+Ss1JQi16OHTzWMuSogQ/iGGr3YCToNZBgh2BZza5D9cNM/7O6fbG
         J7ap/O1pYzcvxF81RVqJAAQmPD4u8BOpGY04CmcL2pzsRAU5xdXgYVxjNM+tOat5YVax
         g1l1Mpjvnkv4BxvwKuF5SQHSt0Ta7u/H8exf4yie/OOJNb2IUi5HmTPuTn+O5OACWBUW
         Abd6VAkz5Jzab/YeWJndVyZbp2qW4WLKKcJmTyiS+SQ/TkBIisInNReIRiDa2M8drit2
         vaNQ8ghZEn9j3ZmtGXXxcM2lKabmdvYmpWmKGZkci2O7SA/LJtROb/77EHP0iVB35C9a
         JYLQ==
X-Gm-Message-State: ACrzQf072aHYeKtS3MOlhN8/9ZS3hq5DAnDHObtOLo4kip6n7GocLnDe
        jg9Rp98+sNmxC3eL8zTXW7NcrVcYmBENYmOfp6J8
X-Google-Smtp-Source: AMsMyM4RJoLbAjT06kxnuaYzagTk76zFUhPifz7+UGwws+zwn1LFl6s9MLpwlfF3LDDN2f2GmJY2eSEGu+dLJ6O91j8=
X-Received: by 2002:a25:9a88:0:b0:6b9:c29a:2f4b with SMTP id
 s8-20020a259a88000000b006b9c29a2f4bmr3425735ybo.236.1666113179690; Tue, 18
 Oct 2022 10:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221008100935.73706-1-gnoack3000@gmail.com> <b8566973-63bc-441f-96b9-f822e9944127@digikod.net>
 <Y0g+TEgGGhZDm7MX@dev-arch.thelio-3990X> <Y0xJUy3igQXWPAeq@nuc>
 <Y0xkZqKoE3rRJefh@nuc> <ea8117e5-7f5c-7598-5d6a-868184a6e4ae@digikod.net>
In-Reply-To: <ea8117e5-7f5c-7598-5d6a-868184a6e4ae@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Oct 2022 13:12:48 -0400
Message-ID: <CAHC9VhR8SQo9x_cv6BZQSwt0rrjeGh-t+YV10GrA3PbC+yHrxw@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] landlock: truncate support
To:     =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 5:16 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 16/10/2022 22:07, G=C3=BCnther Noack wrote:

...

> > Proposed fix
> > ------------
> >
> > I think the LSM framework should ensure that security blobs are
> > pointer-aligned.
> >
> > The LSM framework takes the role of a memory allocator here, and
> > memory allocators should normally return aligned addresses, in my
> > understanding. -- It seems reasonable for AppArmor to make that
> > assumption.
> >
> > The proposed one-line fix is: Change lsm_set_blob_size() in
> > security/security.c, where the positions of the individual security
> > blobs are calculated, so that each allocated blob is aligned to a
> > pointer size boundary.
> >
> > if (*need > 0) {
> >    *lbs =3D ALIGN(*lbs, sizeof(void *));   // NEW
> >
> >    offset =3D *lbs;
> >    *lbs +=3D *need;
> >    *need =3D offset;
> > }
>
> This looks good to me. This fix should be part of patch 4/11 since it
> only affects Landlock for now.

Hi G=C3=BCnther,

Sorry for not seeing this email sooner; I had thought the landlock
truncate work was largely resolved with just a few small things for
you to sort out with Micka=C3=ABl so I wasn't following this thread very
closely anymore.

Regarding the fix, yes, I think the solution is to fixup the LSM
security blob allocator to properly align the entries.  As you already
mentioned, that's common behavior elsewhere and I see no reason why we
should deviate from that in the LSM allocator.  Honestly, looking at
the rest of the allocator right now I can see a few other things to
improve, but those can wait for a later time so as to not conflict
with this work (/me adds a new entry to my todo list).

Other than that, I might suggest the lsm_set_blob_size()
implementation below as it seems cleaner to me and should be
functionally equivalent ... at least on quick inspection, if I've done
something dumb with the code below please feel free to ignore me ;)

  static void __init lsm_set_blob_size(int *need, int *lbs)
  {
    if (*need <=3D 0)
      return;

    *need =3D ALIGN(*need, sizeof(void *));
    *lbs +=3D *need;
  }

--=20
paul-moore.com
