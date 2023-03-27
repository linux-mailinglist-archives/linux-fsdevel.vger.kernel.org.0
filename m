Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89C26CB03B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 23:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjC0VBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 17:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC0VBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:01:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A0812F;
        Mon, 27 Mar 2023 14:01:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 20so10485522lju.0;
        Mon, 27 Mar 2023 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fgkDasYPMzaBbgNL+DqfU6jbIrTRjZPA7BY9S1xa4jY=;
        b=buhGNkCzJU577oYyFubhiOOgwekEvLD3Exu1r4Ax/65utihU2sccc0WWlkHRy3ZUt/
         0Z425iEFB/QHddim7/J2/y8lxK3lks42lOj3HgCWHJOoAvjDpndZvhAjCWxf21wl32BT
         6zkjh5l84C1u5Pmt9+LBnli3V7fEpc3pqu+D8IllrCl5LqfwrY3d6Vrl3b02VbTyEhp5
         JHGYFyXabsu6XtM8xQ6qtNm2kLC77gE7ObrhXuarKoWKZaAZExtqwGpTAsNsR7Uw4xsz
         59AidY9SjEnLweOSNLxQL2d//2H43cbZA4IWWBTAnMXV+7kb2ww00gFSoIvLp0zJyquQ
         junQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgkDasYPMzaBbgNL+DqfU6jbIrTRjZPA7BY9S1xa4jY=;
        b=R/2+AOVd5dt3k+Ap5OTz0h483fN32j4dpLy7O2+bZwzad82usaA4a8BY64C+7QFi8c
         EaMN81clowhfBwE9q8C6wZlsknZvqXPaL1hYjhydQ03CPXx1xTQEfG7VWOMGxGr4U5cm
         DlG40lsosVxv0ba5vVjh2zWA/efxJ4efAgBsbWytwrTtUyTGC0qr2EMNGdPng2sV+cBA
         yml0H1RadwGeqUMjrA/Pr1efOneGN7ZUjjWpipy2Iqdu/zxJR4tVrJY8J5uVbRHgOnS/
         siBrNCRE+fLJuHu2FhnUF3zBrek//TDJGXNHGzcb7pxFS1OzOWT+hALkU46aP3SZGRMX
         pu2w==
X-Gm-Message-State: AAQBX9cFFZQZgzdxudPfJqqkKUUYnzsD19HUjqTmo1kV35JG8TVed8yk
        3+2gwF7SeWM+iPzrAiKkMqid/nzPMKE=
X-Google-Smtp-Source: AKy350bdQOG5ybFFh9LJzYSc6zXxEoX9RGfivIawJ42vOrw8T5lGt3DWwetPCE0dzHm+3bb6uHyX4Q==
X-Received: by 2002:a2e:8785:0:b0:2a5:ff82:178a with SMTP id n5-20020a2e8785000000b002a5ff82178amr350287lji.33.1679950879210;
        Mon, 27 Mar 2023 14:01:19 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:9d6a:15a4:c7d1:a0f0])
        by smtp.gmail.com with ESMTPSA id r10-20020a2eb60a000000b002945b851ea5sm4784219ljn.21.2023.03.27.14.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:01:18 -0700 (PDT)
Date:   Mon, 27 Mar 2023 23:01:13 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <brauner@kernel.org>,
        landlock@lists.linux.dev,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Does Landlock not work with eCryptfs?
Message-ID: <20230327.bddbc828c0ec@gnoack.org>
References: <20230319.2139b35f996f@gnoack.org>
 <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
 <20230320.c6b83047622f@gnoack.org>
 <5d415985-d6ac-2312-3475-9d117f3be30f@digikod.net>
 <e70f7926-21b6-fbce-c5d6-7b3899555535@digikod.net>
 <20230321172450.crwyhiulcal6jvvk@wittgenstein>
 <42ffeef4-e71f-dd2b-6332-c805d1db2e3f@digikod.net>
 <ZB4p4DXwgByYCt5O@sequoia>
 <fbaa6222-255d-57fa-c2fe-f69752a4cb35@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbaa6222-255d-57fa-c2fe-f69752a4cb35@digikod.net>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Sun, Mar 26, 2023 at 11:19:19PM +0200, Mickaël Salaün wrote:
> On 24/03/2023 23:53, Tyler Hicks wrote:
> > On 2023-03-21 19:16:28, Mickaël Salaün wrote:
> > > If Tyler is OK with the proposed solutions, I'll get a closer look at it in
> > > a few months. If anyone is interested to work on that, I'd be happy to
> > > review and test (the Landlock part).
> > 
> > I am alright with using the mounter creds but eCryptfs is typically
> > mounted as root using a PAM module so the mounter is typically going to
> > be more privileged than the user accessing the eCryptfs mount (in the
> > common case of an encrypted home directory).
> > 
> > But, as Christian points out, I think it might be better to make
> > Landlock refuse to work with eCryptfs. Would you be at ease with that
> > decision if we marked eCryptfs as deprecated with a planned removal
> > date?
> 
> The only way to make Landlock "refuse" to work with eCryptfs would be to add
> exceptions according to the underlying filesystem when creating rules.
> Furthermore, to be consistent, this would need to be backported. I don't
> want to go in such direction to fix an eCryptfs issue.

Here is an example where the Landlock LSM can't detect eCryptfs:

  mkdir -p /foo/bar/baz /foo/secret
  landlock-restrict -ro / -rw /foo/bar -- /bin/bash
  
  # finally, in a different terminal:
  mount.ecryptfs /foo/secret /foo/bar/baz

The shell is supposed to have access to /foo/bar and everything below
it, but at the time of creating the Landlock ruleset, it can't tell
yet that this directory will contain an eCryptfs mount later.

Admittedly, the example is obscure, but it's strictly speaking
supposed to work according to the Landlock documentation.  (Only the
landlocked process can't use mount(2) any more, but other processes
still can.)

Note on the side: Even when mount.ecryptfs happens before the Landlock
restriction, the Landlock LSM would have to traverse the existing
mounts to see if there is an eCryptfs mount *below* /foo/bar.

> Doing nothing would go against the principle of least astonishment because
> of unexpected and inconsistent behavior when using Landlock with eCryptfs.
> Indeed, Landlock users (e.g. app developers) may not know how, where, and on
> which kernel their sandboxed applications will run. This means that at best,
> developers will (potentially wrongly) check if eCryptfs is available/used
> and then disable sandboxing, and at worse the (opportunistically) sandboxed
> apps will break (because of denied access). In any case, it goes against
> user's interests.

I agree, I also believe that a kernel-side fix is needed.

I don't think this is feasible to do in a good way in userspace, even
if we want to resort to "falling back to doing nothing" in best effort
mode if eCryptfs file hierarchies are affected.

I have pondered these userspace approaches how to detect eCryptfs, but
they are both lacking:

* Looking for eCryptfs in /proc/mounts might not work
  if we are layering multiple Landlock rulesets.

* stat(2) also does not give away whether a file is on eCryptfs
  (the device number is just a generic kernel internal one)

Finally, it all falls apart anyway if we want to support the case
where eCryptfs is mounted after enabling the sandbox.  (Obscure, but
possible.)

> Even if eCryptfs is marked as deprecated, it will be available for years (a
> lot for LTS) and (legitimate) bug reports will keep coming.
> 
> Instead, I'd like to fix the eCryptfs inconsistent behavior (highlighted by
> Landlock and other LSMs). I think it's worth trying the first proposed
> solution, which might not be too difficult to implement, and will get
> eCryptfs closer to the overlayfs semantic.

+1. As you also said: I think it's important to fix it in the LTS
releases, so that we can tell people to use Landlock without having to
think about these corner cases.

–Günther
