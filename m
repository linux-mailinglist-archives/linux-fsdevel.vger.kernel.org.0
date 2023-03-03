Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3384D6A9068
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 06:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCCFKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 00:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCCFKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:10:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF33E3B1;
        Thu,  2 Mar 2023 21:10:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so3137373wmb.5;
        Thu, 02 Mar 2023 21:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677820242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvMGk/1/y7tMFOENDbuQEEhLJil8s4fXWuymYjvc6v0=;
        b=SIls4jFCTeO8xXRQQdwEk/0demY/yKjrL8ATq5uApMj9C/Y6vsDCKPcsDtEQjyiE7Q
         dS3HClvtPWfBYHRXaK3r8uYk90nBeq5gaqZf9zLp+SJEo8f8lsHxsfGUfr2vNg928LYf
         LXe+hQpaKWSgOfRwTVzSH3Dx2jvpYzrTPDj8lEfFEWuICeRbPvGcJTlK2vmeM/ITVSJy
         1XwjHBVHMwGmiyq+/0Fp9FC8uWMzC3CMqlWg6DRgmRmliwC4cluRZZ/yxytKejyIx5OZ
         dKjNHIghbneelRAV4S4BA2UDnz87kmJ/ffYhnNyKoOyXcQ51MoAyU3nIgMdjpbjF8bB+
         GB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677820242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvMGk/1/y7tMFOENDbuQEEhLJil8s4fXWuymYjvc6v0=;
        b=Dshh7pclYLSO5YI+1kRBDQr8Os4zk4ArlggNetljSeEnz0GG9mob9zYEAFFGvMaxpY
         l170Q+SD7ihP9tPqhPMRUM/WYv5v+FPxeb0k0qhZ6+KiOjBjscLWtKzkTVzV1rCGd/Yz
         HGDQIw9K3ptFEoJKgC2F5fle8QC29QJYQAOaqgpUKRvaifiyGG7PMoVzJ9Q2fCL0etOg
         ITC2H+Pr4sxUPCAE8D6BLwX9g2SvpmriDwxG9VclAusu0eGXtB8J0t3505Xlvf36NA0W
         BMqwxhl9iq68L5pUpb2tGiQ09YuBe4E8XaIdK1cY7oJnj2zx8+X3baC5lK66DkhLufEO
         +OYw==
X-Gm-Message-State: AO0yUKVDGeCqbpCUo92bKBf5HEZiYVNB7qkewsSd7OWLvd/hzcqm90ES
        TH4NZW++WrD/X4nIsFiVIzA=
X-Google-Smtp-Source: AK7set//woUvWwipcnvRW9cP5r6/N0bXGJjknJu0MHDnlahjjhBKhTGxAWvPZipAfZE1HeQ2FRNWjQ==
X-Received: by 2002:a05:600c:a08:b0:3eb:2e32:72b4 with SMTP id z8-20020a05600c0a0800b003eb2e3272b4mr359769wmp.15.1677820241960;
        Thu, 02 Mar 2023 21:10:41 -0800 (PST)
Received: from suse.localnet (host-95-249-145-60.retail.telecomitalia.it. [95.249.145.60])
        by smtp.gmail.com with ESMTPSA id bi25-20020a05600c3d9900b003e89e3284fasm4683035wmb.36.2023.03.02.21.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 21:10:41 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Fri, 03 Mar 2023 06:10:40 +0100
Message-ID: <2187011.72vocr9iq0@suse>
In-Reply-To: <ZAEkveTgVqKau+ab@ZenIV>
References: <Y/gugbqq858QXJBY@ZenIV> <ZAD6n+mH/P8LDcOw@ZenIV> <ZAEkveTgVqKau+ab@ZenIV>
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

On gioved=EC 2 marzo 2023 23:35:41 CET Al Viro wrote:
> On Thu, Mar 02, 2023 at 07:35:59PM +0000, Al Viro wrote:
> > On Thu, Mar 02, 2023 at 12:31:46PM +0100, Fabio M. De Francesco wrote:
> > > But... when yesterday Al showed his demo patchset I probably interpre=
ted
> > > his
> > > reply the wrong way and thought that since he spent time for the demo=
 he
> > > wanted to put this to completion on his own.
> > >=20
> > > Now I see that you are interpreting his message as an invite to use t=
hem
> > > to
> > > shorten the time...
> > >=20
> > > Furthermore I'm not sure about how I should credit him. Should I mere=
ly
> > > add a
> > > "Suggested-by:" tag or more consistent "Co-authored-by: Al Viro <...>=
"?
> > > Since
> > > he did so much I'd rather the second but I need his permission.
> >=20
> > What, for sysv part?  It's already in mainline; for minixfs and ufs, if=
=20
you
> > want to do those - whatever you want, I'd probably go for "modeled after
> > sysv series in 6.2" - "Suggested-by" in those would suffice...
> >=20
> > > @Al,
> > >=20
> > > Can I really proceed with *your* work? What should the better suited =
tag
> > > be to credit you for the patches?
> > >=20
> > > If you can reply today or at least by Friday, I'll pick your demo
> > > patchset,
> > > put it to completion, make the patches and test them with (x)fstests =
on=20
a
> > > QEMU/KVM x86_32 bit VM, with 6GB RAM, running an HIGHMEM64GB enabled
> > > kernel.
> >=20
> > Frankly, ext2 patchset had been more along the lines of "here's what
> > untangling the calling conventions in ext2 would probably look like" th=
an
> > anything else. If you are willing to test (and review) that sucker and =
it
> > turns out to be OK, I'll be happy to slap your tested-by on those during
> > rebase and feed them to Jan...
>=20
> PS: now we can actually turn
>         kunmap_local((void *)((unsigned long)page_addr & PAGE_MASK));
> into
> 	kunmap_local(page_addr);
>=20
> provided that commit doing that includes something along the lines of
>=20
> Do-Not-Backport-Without: 88d7b12068b9 "highmem: round down the address=20
passed
> to kunmap_flush_on_unmap()"
>=20
> in commit message.

I'll do it for fs/sysv.

Instead there is no need to change anything in my series for fs/ufs (it was=
 =20
made as if we already had 88d7b12068b9 "highmem: round down the address pas=
sed=20
to kunmap_flush_on_unmap()" in place).

Thanks,

=46abio



