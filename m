Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EF87492E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 03:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjGFBKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 21:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGFBKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:10:47 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B986B1995;
        Wed,  5 Jul 2023 18:10:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6f943383eso1152661fa.2;
        Wed, 05 Jul 2023 18:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688605844; x=1691197844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjwBdXF1omyqPra/29ms0Vi+bZo8i0ip6SKqToNp0PU=;
        b=LtiEwjeo7A4AxPIu5X1SdLlGwHl6arlOHkl1ovK6lx9cew/YSsxEBzMObSEly4sRd1
         0HRM/RmsTPW5+uiQ/hiUYda0KGJvGO8EMW4H0O+AGhWoyyrizYB5dAruupp82X+73DlT
         Xez5SNgqH4fGnYb98Ov8Ca1gAqvDRCqElrxcHPJcKfc/YndH2wpCyjSsPRJ4HlP2Ax/d
         QvIEdgnvlsEQo5e4tghY7in5tvjsHdAqVFh9QDyHO1YsPU4Xajeaw3IV6+iQ35gFYzib
         k70MGNZBRlFmGN28Zpv/prbtnbRFj7y5K0Zt2Zc6st7yLyh8O3fN8jlB9jdZ4cWxxFzS
         wruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688605844; x=1691197844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjwBdXF1omyqPra/29ms0Vi+bZo8i0ip6SKqToNp0PU=;
        b=P7W5HLW/I9lKV0doy/lz2JQnEJbyloJBWg79BGuQYCMOjv5UGGfHp3FAmpwJ0F+/O/
         /R0WIr3LAPCSvB3zBZC/mJOQF2jKMU9oRyd0jFeJeDazSPnIKUGOKLeF08kD866YIB8X
         YrZyT9QUz7RN4wpAGJV0kykz5bYdyrGSynZPK/s2LUYT4lJ7YpkPRvFKaHFEVzdA1zZS
         2cD/A+B2XTpOHpcpMAJU5fMQzoH+/lq0pMXmH9Z3gXlS5l5X7jdEimCSMgVJ0pHEJ+wc
         TTabl/5m4hGVao0a8njjXKahWZE/nlrkTRcF7s/4/YKwDiMIwXA7S/0OzplyfLxSKdQm
         Cesw==
X-Gm-Message-State: ABy/qLa5BgEugcKyN3BHx9hGzYDiN0CcxNcbRrSKHOc0wqTFOPtLeR6a
        hR+1Svc0WsygKvOaDykXP2fq+XTW8GHe8+ysyVPL9rlu5qY=
X-Google-Smtp-Source: APBJJlGpZnNx3Rr5Mhu3UgNSB4U3aY/o++mEbnMSFgvHz5GTZvONS6sD+RjI0haxyxDq5f00Bpfvx8rSylYNYo3W1dc=
X-Received: by 2002:a2e:9dd5:0:b0:2b6:f8d0:7d3d with SMTP id
 x21-20020a2e9dd5000000b002b6f8d07d3dmr184173ljj.49.1688605843533; Wed, 05 Jul
 2023 18:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
 <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com> <20230704-anrollen-beenden-9187c7b1b570@brauner>
In-Reply-To: <20230704-anrollen-beenden-9187c7b1b570@brauner>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 5 Jul 2023 18:10:32 -0700
Message-ID: <CAADnVQLAhDepRpbbi_EU6Ca3wnuBtSuAPO9mE6pGoxj8i9=caQ@mail.gmail.com>
Subject: Re: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
To:     Christian Brauner <brauner@kernel.org>
Cc:     Hou Tao <houtao@huaweicloud.com>,
        Alexey Gladkov <legion@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 4, 2023 at 6:01=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > > +/**
> > > + * bpf_is_idmapped_mnt - check whether a mount is idmapped
> > > + * @mnt: the mount to check
> > > + *
> > > + * Return: true if mount is mapped, false if not.
> > > + */
> > > +__bpf_kfunc bool bpf_is_idmapped_mnt(struct vfsmount *mnt)
> > > +{
> > > +   return is_idmapped_mnt(mnt);
> > > +}
...
>
> I don't want any of these helpers as kfuncs as they are peeking deeply
> into implementation details that we reserve to change. Specifically in
> the light of:
>
>     3. kfunc lifecycle expectations part b):
>
>     "Unlike with regular kernel symbols, this is expected behavior for BP=
F
>      symbols, and out-of-tree BPF programs that use kfuncs should be cons=
idered
>      relevant to discussions and decisions around modifying and removing =
those
>      kfuncs. The BPF community will take an active role in participating =
in
>      upstream discussions when necessary to ensure that the perspectives =
of such
>      users are taken into account."
>
> That's too much stability for my taste for these helpers. The helpers
> here exposed have been modified multiple times and once we wean off
> idmapped mounts from user namespaces completely they will change again.
> So I'm fine if they're traceable but not as kfuncs with any - even
> minimal - stability guarantees.

Christian,
That quote is taken out of context.
In the first place the Documentation/bpf/kfuncs.rst says:
"
kfuncs provide a kernel <-> kernel API, and thus are not bound by any of th=
e
strict stability restrictions associated with kernel <-> user UAPIs. This m=
eans
they can be thought of as similar to EXPORT_SYMBOL_GPL, and can therefore b=
e
modified or removed by a maintainer of the subsystem they're defined in whe=
n
it's deemed necessary.
"

bpf_get_file_vfs_ids is vfs related, so you guys decide when and how
to add/remove them. It's ok that you don't want this particular one
for whatever reason, but that reason shouldn't be 'stability guarantees'.
There are really none. The kernel kfuncs can change at any time.
There are plenty of examples in git log where we added and then
tweaked/removed kfuncs.

The doc also says:
"
As described above, while sometimes a maintainer may find that a kfunc must=
 be
changed or removed immediately to accommodate some changes in their subsyst=
em,
"
and git log of such cases proves the point.

The quote about out-of-tree bpf progs is necessary today, since
very few bpf progs are in-tree, so when maintainers of a subsystem
want to remove kfunc the program authors need something in the doc
to point to and explain why and how they use the kfunc otherwise
maintainers will just say 'go away. you're out-of-tree'.
The users need their voice to be heard. Even if the result is the same.
In other words the part you quoted is needed to make kfuncs usable.
Otherwise 'kfunc is 100% unstable and maintainers can rename it
every release just to make life of bpf prog writers harder'
becomes a real possibility in the minds of bpf users.
The kfunc doc makes it 100% clear that there are no stability guarantees.
So please don't say 'minimal stability'.

In your other reply:

> we can look at the in-kernel users of is_idmapped_mnt(),
> convert them and then kill this thing off if we wanted to.

you can absolutely do that even if is_idmapped_mnt() is exposed as a kfunc.
You'll just delete it with zero notice if you like.
Just like what you would do with a normal export_symbol.
The doc is pretty clear about it and there are examples where we did
such things.
