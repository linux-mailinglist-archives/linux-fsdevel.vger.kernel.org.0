Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2467BC78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 21:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjAYUXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 15:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYUXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:23:21 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7AD1CAE4;
        Wed, 25 Jan 2023 12:23:20 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id i185so20979783vsc.6;
        Wed, 25 Jan 2023 12:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FFO2JzP+RgwtR+gLRVfPRorrM96PvpyQ8Xwlt7fNIcI=;
        b=KBwTxWr+ekQAnUYhgg1lcx55aPnPWaaRyazlKof0Kxku17D2FzAli2P1AsHCbY5teK
         yNov5DWUGXRbKfVCtk6Lqm6NrIqL33MBDrEAchi/k08kWwijhfdL2Wrxbp5fmaxvk2YL
         0w7G6ykC19WD3i+eCTUFBmnYxs3t4dxO8UI+vvo5hcubbsLoTPd+d30UyHjtKXdjq9z4
         cjC7doMH9YDeOLrulKeQ0JjOX3qdgV8wm1+703wLSe70K+mM+YNTIc5uxO1U6ePOzalG
         7HjVvft4N8kILE88BCPMt3PURuphAqV8LMTEAZHOAIj3A6S0AqKD+YcJbdzL2xd/OdY5
         Girw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFO2JzP+RgwtR+gLRVfPRorrM96PvpyQ8Xwlt7fNIcI=;
        b=Uy4QlxsmRpWs5yVjffYTQIi1WAHXtF2431bIHtgljMjl62aBCXbRVR1fZgk+Ci5FyB
         RWzwMFCCDrYNDpJnHwxydBu9TRpqyfuoLA7/ZFgu/TA8ctr9zqRbHGOZWz85SCXPddJ1
         /p/SfsLoJ8P1kL25QaR7FMy1fKJYi3wrMFDkVl8CUfYOTCVg3QMmsBGpn8MruE0VgAln
         M50FZiDNqFxN38DHjnErs3ImFCyuGcGRvTBmzfm+UEAIOxsq7Xk581dpxrKIu0AKeKre
         F5uGP5AYYEu8r8Qzt/teo8buuZsAbWKJUXKAR1orkMfFc5wrRKM/PQsO3P158/KNWLZC
         UwAw==
X-Gm-Message-State: AFqh2kowkhAW98fE++xNXD9x8TCupf6bw06lE+xpcNx2QI+gzdL8aztN
        6BWlQM8H/gtRp/yQDc4HXxIGzgPaBPAtTp7j+/w=
X-Google-Smtp-Source: AMrXdXuWP5BxkV14he0BC9U1KBpyNMbnQtKcZGYmpNnJkn/dmCemHFNFdeFBMzePxk8eAfXXPZa2xZkEowhUBdF6W90=
X-Received: by 2002:a05:6102:5587:b0:3d1:2167:11ad with SMTP id
 dc7-20020a056102558700b003d1216711admr4206272vsb.2.1674678199329; Wed, 25 Jan
 2023 12:23:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <20230125041835.GD937597@dread.disaster.area> <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
 <87wn5ac2z6.fsf@redhat.com> <CAOQ4uxiPLHHnr2=XH4gN4bAjizH-=4mbZMe_sx99FKuPo-fDMQ@mail.gmail.com>
 <87o7qmbxv4.fsf@redhat.com> <CAOQ4uximBLqXDtq9vDhqR__1ctiiOMhMd03HCFUR_Bh_JFE-UQ@mail.gmail.com>
 <87fsbybvzq.fsf@redhat.com> <CAOQ4uxgos8m72icX+u2_6Gh7eMmctTTt6XZ=BRt3VzeOZH+UuQ@mail.gmail.com>
 <87wn5a9z4m.fsf@redhat.com>
In-Reply-To: <87wn5a9z4m.fsf@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Jan 2023 22:23:08 +0200
Message-ID: <CAOQ4uxi7GHVkaqxsQV6ninD9fhvMAPk1xFRM2aMRFXQZUV-s3Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 9:45 PM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> >> >> I previously mentioned my wish of using it from a user namespace, the
> >> >> goal seems more challenging with EROFS or any other block devices.  I
> >> >> don't know about the difficulty of getting overlay metacopy working in a
> >> >> user namespace, even though it would be helpful for other use cases as
> >> >> well.
> >> >>
> >> >
> >> > There is no restriction of metacopy in user namespace.
> >> > overlayfs needs to be mounted with -o userxattr and the overlay
> >> > xattrs needs to use user.overlay. prefix.
> >>
> >> if I specify both userxattr and metacopy=on then the mount ends up in
> >> the following check:
> >>
> >> if (config->userxattr) {
> >>         [...]
> >>         if (config->metacopy && metacopy_opt) {
> >>                 pr_err("conflicting options: userxattr,metacopy=on\n");
> >>                 return -EINVAL;
> >>         }
> >> }
> >>
> >
> > Right, my bad.
> >
> >> to me it looks like it was done on purpose to prevent metacopy from a
> >> user namespace, but I don't know the reason for sure.
> >>
> >
> > With hand crafted metacopy, an unpriv user can chmod
> > any files to anything by layering another file with different
> > mode on top of it....
>
> I might be missing something obvious about metacopy, so please correct
> me if I am wrong, but I don't see how it is any different than just
> copying the file and chowning it.  Of course, as long as overlay uses
> the same security model so that a file that wasn't originally possible
> to access must be still blocked, even if referenced through metacopy.
>

You're right.
The reason for mutual exclusion maybe related to the
comment in ovl_check_metacopy_xattr() about EACCES.
Need to check with Vivek or Miklos.

But get this - you do not need metacopy=on to follow lower inode.
It should work without metacopy=on.
metacopy=on only instructs overlayfs whether to copy up data
or only metadata when changing metadata of lower object, so it is
not relevant for readonly mount.

Thanks,
Amir.
