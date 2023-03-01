Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91026A6CF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 14:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCANWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 08:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCANWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:22:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED63803F;
        Wed,  1 Mar 2023 05:22:00 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j2so13176434wrh.9;
        Wed, 01 Mar 2023 05:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xH27c6PB6eaK2D5EVE3XoZo9oIw+ZJPl2P+qZoXStIA=;
        b=O/us3s6pvazLvmuUCLNjowPcx0qhCz9szJBQdSNWbHOT6KdfvIpo/24jU9Mv5zBtqI
         BT4heWL9fH/VPOhleSfBt3/qU4QasZ7tpzy3h6avSxnU+vvFmuz3FG8QMGUnGieokTa8
         GBh2ryOEeg1+TtcmhBDz/lo1dq8iQWgsMxAQPxmVhjF/OC57znwCkYRob28oaDivffr4
         27xBnsas2UWrjb/Ba+qmhkFPS41wsv1/FozWxwv6ODJFPxF1pSbHs2woJXioc9+pM7Cc
         Qbv9+U6zBhUiw3PnIsUhb5RgBiD2NPzcvsEph8vQhYQndvJDmEcAyqnvP0hxOZ9UQwT1
         F7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xH27c6PB6eaK2D5EVE3XoZo9oIw+ZJPl2P+qZoXStIA=;
        b=ZQptjabwts6GW2oPqr0SqaO3YIaisYS99qnuNHlVXjcwGwLxfHlFLEr71nOTqUJWT4
         h1Oodsgthl0rn5MU0nBeUdq12e8zuuKU7ZMZ9+jD9+UyjiKmuCevI2XUMxh/Jx1gt9DJ
         co8FX6s8N+ghGIhm39u2WmjDkBUwu93WUIcI2NM9Z3fib5yYxpmVYAJ9GxaRGbV5HlfN
         7qf1T3FicI5Fhk0G5yYfLVhXW83oHVgX7wzF6bajGWreryjd3WCQmk+l9T8oA98JLjvZ
         ViTids3a4pPYawrWoI08zQdo/zq8++EaemZ1tZrWOUmHGWwXjKLv/N7gW1Krhp8LVv5A
         FfoQ==
X-Gm-Message-State: AO0yUKW+TbzqWm9Cijjg3EEMP9OGLUvjK0CAnqb/U9SRIoK8efEauQGH
        cr/E32kg9n9OJda7wI5ifr0U9rqIIDsdHA==
X-Google-Smtp-Source: AK7set9NbLbS8PZNitbIdX85/e51auBrsZgwxIifSceiLAhCNIthGYfCrlqONGG84EHBuNKB6KQ++Q==
X-Received: by 2002:a05:6000:1006:b0:2c7:b89:36f0 with SMTP id a6-20020a056000100600b002c70b8936f0mr4532969wrx.8.1677676919111;
        Wed, 01 Mar 2023 05:21:59 -0800 (PST)
Received: from suse.localnet ([212.216.157.254])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002c5a790e959sm12775568wrp.19.2023.03.01.05.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 05:21:58 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Wed, 01 Mar 2023 14:21:56 +0100
Message-ID: <8187743.T7Z3S40VBb@suse>
In-Reply-To: <20230301130018.yqds5yvqj7q26f7e@quack3>
References: <Y/gugbqq858QXJBY@ZenIV> <13214812.uLZWGnKmhe@suse>
 <20230301130018.yqds5yvqj7q26f7e@quack3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On mercoled=EC 1 marzo 2023 14:00:18 CET Jan Kara wrote:
> On Wed 01-03-23 12:20:56, Fabio M. De Francesco wrote:
> > On venerd=EC 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> > > 	Fabio's "switch to kmap_local_page()" patchset (originally after the
> > >=20
> > > ext2 counterpart, with a lot of cleaning up done to it; as the matter=
 of
> > > fact, ext2 side is in need of similar cleanups - calling conventions=
=20
there
> > > are bloody awful).
> >=20
> > If nobody else is already working on these cleanups in ext2 following y=
our
> > suggestion, I'd be happy to work on this by the end of this week. I only
> > need
> > a confirmation because I'd hate to duplicate someone else work.
> >=20
> > > Plus the equivalents of minix stuff...
> >=20
> > I don't know this other filesystem but I could take a look and see whet=
her
> > it
> > resembles somehow sysv and ext2 (if so, this work would be pretty simple
> > too,
> > thanks to your kind suggestions when I worked on sysv and ufs).
> >=20
> > I'm adding Jan to the Cc list to hear whether he is aware of anybody el=
se
> > working on this changes for ext2. I'm waiting for a reply from you (@Al=
)=20
or
> > Jan to avoid duplication (as said above).
>=20
> I'm not sure what exactly Al doesn't like about how ext2 handles pages and
> mapping but if you have some cleanups in mind, sure go ahead.

Hi Jan,

I might explain here and now what Al is referring to I'd prefer to show the=
=20
code :-)

In brief I had made the conversions of fs/ufs and fs/sysv from kmap() to=20
kmap_local_page() by porting what had been done for ext2. At that point Al=
=20
suggested a much cleaner and elegant approach.=20

Therefore, I threw away the port from ext2 and sent a series of 4 patches=20
according to a long list of suggestions that Al kindly provided to me.

Now he is asking for somebody doing the same changes in ext2 too.

Thanks for the immediate reply.

=46abio  =20

> I don't have
> any plans on working on that code in the near term.
>=20
> 							=09
Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR




