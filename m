Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E4B7B6C03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjJCOqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbjJCOqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:46:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B459B0
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 07:46:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50444e756deso1291804e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344394; x=1696949194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0M0A0m7NwR/DVfuhY9o5ZbLIefyMsuc6SdkSxdRQM4k=;
        b=X1qt2p10MYTTjuWP0ECD6FIpWo548LQBGnOGDDn8YfpsSlWR5X4BDhWlU5a5MFZhxg
         ct+atzZ3Rrn2ICPfXvLW31QqAH58InXq+4fQfKiqjNg1wBUjPMJOcpi/LN2H07rWq+5x
         +i/KA6qD5runw7/n2NS2LrTc2VuRwj9I+FN4/bc755vmLJyugfBhKgbC722jNsa/NTfr
         u5mR8iFl7f0ZX8XX8y7az82pifVDwHJC8vZgbgUvdKXlmCcIM78dN0UzZuaKd4+9J47K
         /1NwATGnaPqbQBfbWYy/59Y7xqWhccoFjUwMTRgGrcnxFRc/NIh9hiORYpWbeUhJW2+Y
         B3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344394; x=1696949194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0M0A0m7NwR/DVfuhY9o5ZbLIefyMsuc6SdkSxdRQM4k=;
        b=wbbzBDWKED3/vCWcQlIcb+TE7shEiBayOSYN3wOnApWDwqycn8wff2qAGZzhwKLZnn
         4G6zloGEapU9JCXCRGoT1KkQEyVdFAEjKoN7DRIitxSmrSE2ZN/OhZc6Z9i0blhC2Mms
         u5lxe39Hh67SgV8p8zsu1aNRAYf+K3C/lxDvnsa8DMB90UL5GK98VC3D2p2zjR1TaQT4
         4sSOuA5s9xISwJpVYlm6zpBCmgX3TWGBJjlFGT+0fZqfEhQI1xkZo1RtnMvAtZmBGc8v
         OlvckFcyeR9i6Q8C9MZoNByaq2uIKrim2O0/Yb4RxD/VNcfmG9sbHo+EJEl3mQksv7Au
         8iqA==
X-Gm-Message-State: AOJu0YxUxsXTeYT63ea5+n7hEXhKYpyiBeUP2ZoUOohVGP3QCXkTdh6a
        QxMfEdj5z9vfebRz4y01SPkLjE/eKOQ5ZQVHM9+Tj/vGN8Y=
X-Google-Smtp-Source: AGHT+IE+pCDk0XQzZmpCKFPCauZS1xzHKL4xySOZEJ2FkKdzTaLJbe+3V/mpqj3vU7ydVNCSCB9Q5xIYkaX7oLToohE=
X-Received: by 2002:a19:f818:0:b0:503:778:9ad2 with SMTP id
 a24-20020a19f818000000b0050307789ad2mr11480619lff.19.1696344393397; Tue, 03
 Oct 2023 07:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV>
 <20231002023344.GI3389589@ZenIV> <7f422261-92ef-32df-6640-dab9d68e1023@redhat.com>
 <20231002125946.GW800259@ZenIV> <20231002141610.GX800259@ZenIV>
In-Reply-To: <20231002141610.GX800259@ZenIV>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 3 Oct 2023 16:46:21 +0200
Message-ID: <CAHpGcMJPzPhe5KvxB5Tu+DPTHeMjEBG-utdLTna53Hbu7NntZw@mail.gmail.com>
Subject: Re: [PATCH 08/15] gfs2: fix an oops in gfs2_permission()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mo., 2. Okt. 2023 um 19:09 Uhr schrieb Al Viro <viro@zeniv.linux.org.uk>:
> On Mon, Oct 02, 2023 at 01:59:46PM +0100, Al Viro wrote:
> > On Mon, Oct 02, 2023 at 06:46:03AM -0500, Bob Peterson wrote:
> > > > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > > > index 0eac04507904..e2432c327599 100644
> > > > --- a/fs/gfs2/inode.c
> > > > +++ b/fs/gfs2/inode.c
> > > > @@ -1868,14 +1868,16 @@ int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
> > > >   {
> > > >           struct gfs2_inode *ip;
> > > >           struct gfs2_holder i_gh;
> > > > + struct gfs2_glock *gl;
> > > >           int error;
> > > >           gfs2_holder_mark_uninitialized(&i_gh);
> > > >           ip = GFS2_I(inode);
> > > > - if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
> > > > + gl = rcu_dereference(ip->i_gl);
> > > > + if (!gl || gfs2_glock_is_locked_by_me(gl) == NULL) {
> > >
> > > This looks wrong. It should be if (gl && ... otherwise the
> > > gfs2_glock_nq_init will dereference the null pointer.
> >
> > We shouldn't observe NULL ->i_gl unless we are in RCU mode,
> > which means we'll bail out without reaching gfs2_glock_nq_init()...
>
> Something like
>         if (unlikely(!gl)) {
>                 /* inode is getting torn down, must be RCU mode */
>                 WARN_ON_ONCE(!(mask & MAY_NOT_BLOCK));
>                 return -ECHILD;
>         }
> might be less confusing way to express that...

Looking good, thanks. I'll queue it up.

Could you please send such fixes to the filesystem-specific list in
the future (scripts/get_maintainer.pl)?

Thanks,
Andreas
