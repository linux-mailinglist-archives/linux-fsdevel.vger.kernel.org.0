Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACD6BCCCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 11:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCPKap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCPKal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:30:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7731ACDD;
        Thu, 16 Mar 2023 03:30:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so721495wmb.3;
        Thu, 16 Mar 2023 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678962623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfUOGEcUsPIbqoNVCg/Priz7vEmgv1M8q2srv6SMdbc=;
        b=LJ221I8m/urMvPZHjqm2jufspCPDS3/I/BvnxicwsfOfaHKkLlxX83u0Cr3i1lz42O
         M0IsvUKicBwb8Iu88ycVozAZvs94FdihL9XvGLdAlbLF9daGaR3mxn1tivZr5KAWKfaD
         ouHEnDycHVSbffAE/CegSSI7VdODA1F0vlFDgt7b973FAhXO8+KUwvcRO+yd8ip7fC4b
         tNGgcZg63hWdq5nqFxAdukUavHyyUnlTpLLVIUx5u61qU+x6fFlvaZV853AiM9kBax0m
         X6vra9qjgjAz3Q/lSCoBRBIAuPs5PLXhNel+zyXMFr9P3bv4dQNrs7L05WLlHdDkLOmM
         T+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678962623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfUOGEcUsPIbqoNVCg/Priz7vEmgv1M8q2srv6SMdbc=;
        b=kAmbx19bNgn4U7V/+mpScy7t6AFMFrRNrXsfiXOC0dBp1QToAcXI1yzjx5UtAsmJwi
         oMJwEXI06naeA7rSYsJC4Bp4xqsj3QYr9W5DIKmrXe4jO6WLwVgdfBgHn9svs6yed1mP
         +ESoD2DtjgU08BD50+bLgzUD7YrIoHkLTnxWynnEPyVfp1b4dSMosYt8l0exIeBBubMb
         PavBEOLKVk3hy1JcDWwCCLbJPNjM3SYXzPbN+V/dgBRnafHhj60E9uGpLKMjtLINyN9L
         r42hfLoaibDaj6T0nXrff66n8ZQ4OW6mAZz7Bx/jqmcTnHuInayZj57HMgJngJD8n7qC
         z+xA==
X-Gm-Message-State: AO0yUKXF0/ep3mb/q92J0NEjOpiHSxLV2qUNy7n+gTIn8bNN//GbblfS
        jeAQucu4+uGXSDJZoM043LoOaV1dkQlBQA==
X-Google-Smtp-Source: AK7set9JyHfluYgtg7tkLEm4tYr4nIO9pGagQcY4F3Z6sUIlJ4PWSrVBwQs4e+MowIT0O3uilSKzGA==
X-Received: by 2002:a05:600c:4f55:b0:3ed:454d:36ab with SMTP id m21-20020a05600c4f5500b003ed454d36abmr2551281wmq.16.1678962623350;
        Thu, 16 Mar 2023 03:30:23 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id c18-20020a7bc012000000b003ed2d7f9135sm4504017wmb.45.2023.03.16.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:30:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Thu, 16 Mar 2023 11:30:21 +0100
Message-ID: <2766007.BEx9A2HvPv@suse>
In-Reply-To: <20230316090035.ynjejgcd72ynvd36@quack3>
References: <Y/gugbqq858QXJBY@ZenIV> <3019063.4lk9UinFSI@suse>
 <20230316090035.ynjejgcd72ynvd36@quack3>
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

On gioved=EC 16 marzo 2023 10:00:35 CET Jan Kara wrote:
> On Wed 15-03-23 19:08:57, Fabio M. De Francesco wrote:
> > On mercoled=EC 1 marzo 2023 15:14:16 CET Al Viro wrote:
> > > On Wed, Mar 01, 2023 at 02:00:18PM +0100, Jan Kara wrote:
> > > > On Wed 01-03-23 12:20:56, Fabio M. De Francesco wrote:
> > > > > On venerd=EC 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> > > > > > 	Fabio's "switch to kmap_local_page()" patchset (originally=20
after
> > > > > > 	the
> > > > > >=20
> > > > > > ext2 counterpart, with a lot of cleaning up done to it; as the
> > > > > > matter
> >=20
> > of
> >=20
> > > > > > fact, ext2 side is in need of similar cleanups - calling=20
conventions
> > > > > > there
> > > > > > are bloody awful).
> >=20
> > [snip]
> >=20
> > > I think I've pushed a demo patchset to vfs.git at some point back in
> > > January... Yep - see #work.ext2 in there; completely untested, though.
> >=20
> > The following commits from the VFS tree, #work.ext2 look good to me.
> >=20
> > f5b399373756 ("ext2: use offset_in_page() instead of open-coding it as
> > subtraction")
> > c7248e221fb5 ("ext2_get_page(): saner type")
> > 470e54a09898 ("ext2_put_page(): accept any pointer within the page")
> > 15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with=20
page_addr")
> > 16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need=20
page_addr
> > anymore")
> >=20
> > Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
> Thanks!
>=20
> > I could only read the code but I could not test it in the same QEMU/KVM
> > x86_32 VM where I test all my HIGHMEM related work.
> >=20
> > Btrfs as well as all the other filesystems I converted to=20
kmap_local_page()
> > don't make the processes in the VM to crash, whereas the xfstests on ex=
t2
> > trigger the OOM killer at random tests (only sometimes they exit
> > gracefully).
> >=20
> > FYI, I tried to run the tests with 6GB of RAM, booting a kernel with
> > HIGHMEM64GB enabled. I cannot add my "Tested-by" tag.
>=20
> Hum, interesting. Reading your previous emails this didn't seem to happen
> before applying this series, did it?
>
I wrote too many messages but was probably not able to explain the facts=20
properly. Please let me summarize...

1) When testing ext2 with "./check -g quick" in a QEMU/KVM x86_32 VM, 6GB R=
AM,=20
booting a Vanilla kernel 6.3.0-rc1 with HIGHMEM64GB enabled, the OOM Killer=
=20
kicks in at random tests _with_ and _without_ Al's patches.

2) The only case which does never trigger the OOM Killer is running the tes=
ts=20
on ext2 formatted filesystems in loop disks with the stock openSUSE kernel=
=20
which is the 6.2.1-1-pae.

3) The same "./check -g quick" on 6.3.0-rc1 runs always to completion with=
=20
other filesystems. I ran xfstests several times on Btrfs and I had no=20
problems.

4) I cannot git-bisect this issue with ext2 because I cannot trust the resu=
lts=20
on any particular Kernel version. I mean that I cannot mark any specific=20
version neither "good" or "bad" because it happens that the same "good"=20
version instead make xfstests crash at the next run.

My conclusion is that we probably have some kind of race that makes the ran=
dom=20
tests crash at random runs of random Kernel versions between (at least) SUS=
E=20
6.2.1 and Vanilla current.

But it may be very well the case that I'm doing something stupid (e.g., wit=
h=20
QEMU configuration or setup_disks or I can't imagine whatever else) and tha=
t=20
I'm unable to see where I make mistakes. After all, I'm still a newcomer wi=
th=20
little experience :-)

Therefore, I'd suggest that someone else try to test ext2 in an x86_32 VM.=
=20
However, I'm 99.5% sure that Al's patches are good by the mere inspection o=
f=20
his code.

I hope that this summary contains everything that may help.

However, I remain available to provide any further information and to give =
my=20
contribution if you ask me for specific tasks.=20

=46or my part I have no idea how to investigate what is happening. In these=
=20
months I have run the VM hundreds of times on the most disparate filesystem=
s=20
to test my conversions to kmap_local_page() and I have never seen anything=
=20
like this happen.

Thanks,

=46abio=20

> 							=09
Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR




