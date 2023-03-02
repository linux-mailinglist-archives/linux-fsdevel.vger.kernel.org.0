Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3417F6A810A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 12:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCBLbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 06:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCBLbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:31:51 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2CB231FC;
        Thu,  2 Mar 2023 03:31:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j2so16174454wrh.9;
        Thu, 02 Mar 2023 03:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx+PVsncwZDKHuskc1x0Kqy1fJLkTEStG1WLlrUYmaQ=;
        b=eHcaBjAB8Xy9X/NH4Kj2RIOTbBSKGdswSuCCK1eBdEQdYPmUmSksaMR9PsbxYj+X+o
         6kYhpANIs9moaSPxW1NWx2nLpO9KVuVig6i/p16+UolXvUmsgE/mh/lHJFDMOzLjADZk
         sXSxwzkAkFOXb7BQF3Ik6eHtikKR3GS0Yzx+Gg8IXquGkUi3zmNF0Q/40BxfbxClaTRc
         QitCny6zQCG44rbd9Gf1GHnnvUxM4k6eoAIgYrD5+fKsLoxb64fIAeRbjq6pi5dwzGrL
         QjjqVr9N9co/6rv5e3DwKXfDEUeaVxtvbGP0ym13z5WUj9VmI5JY05F60vpC2KLlTecP
         HfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx+PVsncwZDKHuskc1x0Kqy1fJLkTEStG1WLlrUYmaQ=;
        b=TPF3vu7EzAbaLObuWdmZubnQWNNSkZYPNUvVTd/JRr6V0d3hrFrGQ7INDQMugb22J3
         SVgIb7N2VH5mHe94ClkRCwMZTIcKZcyGC9A96oeUXtHMB8N27E/kakiA4wclbpDZxL8F
         gazIdmHu2AT3F6QrMMPzsOdKwNxru58zu+2if9ajIcFFFaLOkHAoGotHJK4P3PGoMP1J
         rNq6NcHJO73qtVpgqx5XK3jngAoVUcn4PS1R4kHMCHmi4YF9z6dNjgoZZJjcTiNuOcNi
         jMr7hKz9C8Cf6fItWuGG7vYZrw6xSL7TRU3myw1Sw4FlcQ9I16Gg9Mr2o8/d3A0Un6fH
         MuTw==
X-Gm-Message-State: AO0yUKWrWfHtKAfFn7QEhGOAXxl9eduShnMMKyGUEhUQabXT0ZDRB6Ht
        VQYZuArrtlOZrxiRy0WGT+w=
X-Google-Smtp-Source: AK7set9JLbLhbSNQk4Sf9xcHO+93ZUsRLRuD//8wsjVdOqKIcDPzeoFxevwlbxbmiEOM2b5yUCLPdA==
X-Received: by 2002:a5d:5692:0:b0:2c7:1524:eb07 with SMTP id f18-20020a5d5692000000b002c71524eb07mr7235380wrv.67.1677756708612;
        Thu, 02 Mar 2023 03:31:48 -0800 (PST)
Received: from suse.localnet (host-82-61-39-134.retail.telecomitalia.it. [82.61.39.134])
        by smtp.gmail.com with ESMTPSA id v12-20020adfedcc000000b002c5a1bd527dsm15030597wro.96.2023.03.02.03.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 03:31:47 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Thu, 02 Mar 2023 12:31:46 +0100
Message-ID: <9074146.CDJkKcVGEf@suse>
In-Reply-To: <20230302095931.jwyrlgtxcke7iwuu@quack3>
References: <Y/gugbqq858QXJBY@ZenIV> <Y/9duET0Mt5hPu2L@ZenIV>
 <20230302095931.jwyrlgtxcke7iwuu@quack3>
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

On gioved=EC 2 marzo 2023 10:59:31 CET Jan Kara wrote:
> On Wed 01-03-23 14:14:16, Al Viro wrote:
> > On Wed, Mar 01, 2023 at 02:00:18PM +0100, Jan Kara wrote:
> > > On Wed 01-03-23 12:20:56, Fabio M. De Francesco wrote:
> > > > On venerd=EC 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> > > > > 	Fabio's "switch to kmap_local_page()" patchset (originally after=
 the
> > > > >=20
> > > > > ext2 counterpart, with a lot of cleaning up done to it; as the=20
matter
> > > > > of
> > > > > fact, ext2 side is in need of similar cleanups - calling conventi=
ons
> > > > > there
> > > > > are bloody awful).
> > > >=20
> > > > If nobody else is already working on these cleanups in ext2 followi=
ng
> > > > your
> > > > suggestion, I'd be happy to work on this by the end of this week. I=
=20
only
> > > > need
> > > > a confirmation because I'd hate to duplicate someone else work.
> > > >=20
> > > > > Plus the equivalents of minix stuff...
> > > >=20
> > > > I don't know this other filesystem but I could take a look and see
> > > > whether it
> > > > resembles somehow sysv and ext2 (if so, this work would be pretty=20
simple
> > > > too,
> > > > thanks to your kind suggestions when I worked on sysv and ufs).
> > > >=20
> > > > I'm adding Jan to the Cc list to hear whether he is aware of anybody
> > > > else
> > > > working on this changes for ext2. I'm waiting for a reply from you=
=20
(@Al)
> > > > or
> > > > Jan to avoid duplication (as said above).
> > >=20
> > > I'm not sure what exactly Al doesn't like about how ext2 handles page=
s=20
and
> > > mapping but if you have some cleanups in mind, sure go ahead. I don't=
=20
have
> > > any plans on working on that code in the near term.
> >=20
> > I think I've pushed a demo patchset to vfs.git at some point back in
> > January... Yep - see #work.ext2 in there; completely untested, though.
>=20
> OK, I think your changes to ext2_rename() in PATCH 1 leak a reference and
> mapping of old_page but otherwise I like the patches. So Fabio, if you can
> pick them up and push this to completion, it would be nice. Thanks!
>=20

@Jan,

I was sure you would have liked them :-)
I'm happy to pick them up and push them to completion.

But... when yesterday Al showed his demo patchset I probably interpreted hi=
s=20
reply the wrong way and thought that since he spent time for the demo he=20
wanted to put this to completion on his own.

Now I see that you are interpreting his message as an invite to use them to=
=20
shorten the time...=20

=46urthermore I'm not sure about how I should credit him. Should I merely a=
dd a=20
"Suggested-by:" tag or more consistent "Co-authored-by: Al Viro <...>"? Sin=
ce=20
he did so much I'd rather the second but I need his permission.

@Al,

Can I really proceed with *your* work? What should the better suited tag be=
 to=20
credit you for the patches?

If you can reply today or at least by Friday, I'll pick your demo patchset,=
=20
put it to completion, make the patches and test them with (x)fstests on a=20
QEMU/KVM x86_32 bit VM, with 6GB RAM, running an HIGHMEM64GB enabled kernel.

Thanks,

=46abio



