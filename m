Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A836A6B9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 12:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCALVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 06:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCALVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:21:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7363B206;
        Wed,  1 Mar 2023 03:21:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id g3so3959428wri.6;
        Wed, 01 Mar 2023 03:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8uupGhWT0cJC0ZGi7m3ZW+QzCETbdp0XGrBXIt1ZcA=;
        b=UeKStxeQM6igNrDtDNhX8o/3pbMFhVpjB0OwFwCmJArgJ+183mXSa5HIx6l9QG53uO
         J+fwkfDV0o14bJ8o9tYjG21bCp8gDDD5R2U9nDbukZQcFiSZL/DrG0SkFtfgTT0+fFTz
         egN4k8D4QxBNFhi4WIatG02YjoFJKr1VZ2Hzft01uwJfXIMThEt0w9ZSjRRGQa3+38X5
         nlSe6yy3ipwfnRsFEeXeHlJ1s8NgaeMA+vp9NaAcFyoHBqK7JdtmeFDVi/fyb5OXAdYR
         iXtQ9oPGdAdW8BHLzYVmbak8ozGU3IWzal4JFOcWlBT+9iOWBJiBM18I2T1zl+mVuSpa
         NssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8uupGhWT0cJC0ZGi7m3ZW+QzCETbdp0XGrBXIt1ZcA=;
        b=G6zUVynCKkqUMpDw625YR/GD3y5BVx6mBvKqw5AAJVARdxKu8VUhxbUnTKSdZkIlOm
         u1b442MMZyO2inRwiqksg65CR29NrGWwetHLg8we12PpnKORdlVOQCIzKz36o1GFQgkX
         9Xts44TlVmqOVjWTvnPUJqPKXeKJvisoimkDv6CYI0sWVyylOC8GtWpwjU4ULVtuzLO9
         mQE/50il4J0UOU9ursC+7SSQJD1U/8hAwOhmphlWYlSn3EsaOMjQShw86wtT+iAvLgmp
         laZwOdTT/+kAp0VCB/NdoeTWCGFLZRbMZWRaRzfTtytPsvkNIsbiW1bzc23jEDTguEJt
         JJpQ==
X-Gm-Message-State: AO0yUKXEyVZa5PTzvkw0DB4eN0PtUSysizKXgwV2MJAxHiDzmfGo7Zsr
        FiWfAaH/q9ZZnkixOjHxupyYcB88oavEWA==
X-Google-Smtp-Source: AK7set+AD1MK8ZoaDoS6r5V32Q28cTiJuQJyQzbNRXTftxp3gvoky39QOWsJllrQttt0aUZrLwgDpw==
X-Received: by 2002:a5d:6686:0:b0:2c7:1d60:f34e with SMTP id l6-20020a5d6686000000b002c71d60f34emr4935591wru.6.1677669671530;
        Wed, 01 Mar 2023 03:21:11 -0800 (PST)
Received: from suse.localnet ([212.216.157.254])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b002c58ca558b6sm12473328wrs.88.2023.03.01.03.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 03:21:10 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Wed, 01 Mar 2023 12:20:56 +0100
Message-ID: <13214812.uLZWGnKmhe@suse>
In-Reply-To: <Y/gugbqq858QXJBY@ZenIV>
References: <Y/gugbqq858QXJBY@ZenIV>
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

On venerd=EC 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> 	Fabio's "switch to kmap_local_page()" patchset (originally after the
> ext2 counterpart, with a lot of cleaning up done to it; as the matter of
> fact, ext2 side is in need of similar cleanups - calling conventions there
> are bloody awful).

If nobody else is already working on these cleanups in ext2 following your=
=20
suggestion, I'd be happy to work on this by the end of this week. I only ne=
ed=20
a confirmation because I'd hate to duplicate someone else work.

> Plus the equivalents of minix stuff...

I don't know this other filesystem but I could take a look and see whether =
it=20
resembles somehow sysv and ext2 (if so, this work would be pretty simple to=
o,=20
thanks to your kind suggestions when I worked on sysv and ufs).

I'm adding Jan to the Cc list to hear whether he is aware of anybody else=20
working on this changes for ext2. I'm waiting for a reply from you (@Al) or=
=20
Jan to avoid duplication (as said above).

Thanks,

=46abio=20

> The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c2=
62:
>=20
>   Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sysv
>=20
> for you to fetch changes up to abb7c742397324f8676c5b622effdce911cd52e3:
>=20
>   sysv: fix handling of delete_entry and set_link failures (2023-01-19
> 23:24:42 -0500)
>=20
> ----------------------------------------------------------------
> Al Viro (1):
>       sysv: fix handling of delete_entry and set_link failures
>=20
> Christoph Hellwig (1):
>       sysv: don't flush page immediately for DIRSYNC directories
>=20
> Fabio M. De Francesco (4):
>       fs/sysv: Use the offset_in_page() helper
>       fs/sysv: Change the signature of dir_get_page()
>       fs/sysv: Use dir_put_page() in sysv_rename()
>       fs/sysv: Replace kmap() with kmap_local_page()
>=20
>  fs/sysv/dir.c   | 154
> ++++++++++++++++++++++++++++++++------------------------ fs/sysv/namei.c =
|=20
> 42 ++++++++--------
>  fs/sysv/sysv.h  |   3 +-
>  3 files changed, 111 insertions(+), 88 deletions(-)




