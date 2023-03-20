Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7076C1099
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 12:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCTLTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjCTLS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:18:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757B283F9;
        Mon, 20 Mar 2023 04:18:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t15so9953084wrz.7;
        Mon, 20 Mar 2023 04:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P1mfuxmwL/NgGsryTeFYSGRcT3s8+9JXPoWEdBiB0g=;
        b=kfSClvjcH4k0hOumd+Ntao0HpPMM8Yc8zkmd9k9/qM0zeaUf4z2PhrKUF95u6rZpNU
         V0WFRTWm6Dt5EDQA37uKJSKnSyBKXRuhl54Fp1a8odXm1lOoPQ9fxXi5PrYLYrv1imBj
         FPl68yNa5MV5H69VdPwOHNeVUehe11J2Ivwl3+9mk4G0uJA1aqKe5hi7NdwuMeQkC/cz
         3PmRJ6g8TseezbmH3V+1ChIeNWd1z7TGzbuDZAINhZoKEmqfdkmpZy7xFilLL1kbvQzT
         HUR3zzj1MTnfHAd3jQV8YEofxdhh7Dg/2z9/53Ft0VvepHDAqCVwnrN/WjFKhM66tR0E
         PQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P1mfuxmwL/NgGsryTeFYSGRcT3s8+9JXPoWEdBiB0g=;
        b=Ww9QRYAutD88ZZpyNW7ExTHCcKVmUhn6+1nVgMA2etJV4jxDNxmzPlV6jVOb7rsoXd
         LG5OH+Ty8C9aM9ODTUsFMKsE+RnlcQ7j486o0bfvIKHUnq1ka+TQX4SxS1d6O9+svCV4
         c+mAAscJy3c77fZOq/2n9m7GUCKcshsXio9le3r9+x+klJGIwdfDA+YL8SOdeyz7TU2q
         F2lfGaBZ5BnU89Lx2BgO33gCsQX0fD3tGGdIvOHT9ceh8kLNql/55zapoyNCmWP7ZeDK
         4NZAGO/pkpfn1aWroaY9BJRRinfDjC9eqSD2O/3F4Zq2NrRTqOAWItlxl4shxzJf6P6X
         U0ow==
X-Gm-Message-State: AO0yUKXOoyn7hh8ECkQwR0GOIrAgrbM1DQnDxbHovuYBirLDnJ0IkRrR
        yPZR7uWUvnQtD3VrALUoaLc=
X-Google-Smtp-Source: AK7set9g9kEZ38MKg7IdqGb0uoWbWe0uGaAHt2aHbrFCxxOszFYKLGbwlUqXvuHJDgR+jmvBeBFIMg==
X-Received: by 2002:adf:f1ce:0:b0:2d7:3cd3:85b2 with SMTP id z14-20020adff1ce000000b002d73cd385b2mr2029124wro.23.1679311120105;
        Mon, 20 Mar 2023 04:18:40 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000050a00b002d78a96cf5fsm1450356wrf.70.2023.03.20.04.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:18:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Mon, 20 Mar 2023 12:18:38 +0100
Message-ID: <4214717.mogB4TqSGs@suse>
In-Reply-To: <2766007.BEx9A2HvPv@suse>
References: <Y/gugbqq858QXJBY@ZenIV> <20230316090035.ynjejgcd72ynvd36@quack3>
 <2766007.BEx9A2HvPv@suse>
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

On gioved=EC 16 marzo 2023 11:30:21 CET Fabio M. De Francesco wrote:
> On gioved=EC 16 marzo 2023 10:00:35 CET Jan Kara wrote:
> > On Wed 15-03-23 19:08:57, Fabio M. De Francesco wrote:
> > > On mercoled=EC 1 marzo 2023 15:14:16 CET Al Viro wrote:
> > > > On Wed, Mar 01, 2023 at 02:00:18PM +0100, Jan Kara wrote:
> > > > > On Wed 01-03-23 12:20:56, Fabio M. De Francesco wrote:
> > > > > > On venerd=EC 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> > > > > > > 	Fabio's "switch to kmap_local_page()" patchset (originally
>=20
> after
>=20
> > > > > > > 	the
> > > > > > >=20
> > > > > > > ext2 counterpart, with a lot of cleaning up done to it; as the
> > > > > > > matter
> > >=20
> > > of
> > >=20
> > > > > > > fact, ext2 side is in need of similar cleanups - calling
>=20
> conventions
>=20
> > > > > > > there
> > > > > > > are bloody awful).
> > >=20
> > > [snip]
> > >=20
> > > > I think I've pushed a demo patchset to vfs.git at some point back in
> > > > January... Yep - see #work.ext2 in there; completely untested, thou=
gh.
> > >=20
> > > The following commits from the VFS tree, #work.ext2 look good to me.
> > >=20
> > > f5b399373756 ("ext2: use offset_in_page() instead of open-coding it as
> > > subtraction")
> > > c7248e221fb5 ("ext2_get_page(): saner type")
> > > 470e54a09898 ("ext2_put_page(): accept any pointer within the page")
> > > 15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with
>=20
> page_addr")
>=20
> > > 16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need
>=20
> page_addr
>=20
> > > anymore")
> > >=20
> > > Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> >=20
> > Thanks!
> >=20
> > > I could only read the code but I could not test it in the same QEMU/K=
VM
> > > x86_32 VM where I test all my HIGHMEM related work.
> > >=20
> > > Btrfs as well as all the other filesystems I converted to
>=20
> kmap_local_page()
>=20
> > > don't make the processes in the VM to crash, whereas the xfstests on=
=20
ext2
> > > trigger the OOM killer at random tests (only sometimes they exit
> > > gracefully).
> > >=20
> > > FYI, I tried to run the tests with 6GB of RAM, booting a kernel with
> > > HIGHMEM64GB enabled. I cannot add my "Tested-by" tag.
> >=20
> > Hum, interesting. Reading your previous emails this didn't seem to happ=
en
> > before applying this series, did it?
>=20
> I wrote too many messages but was probably not able to explain the facts
> properly. Please let me summarize...
>=20
> 1) When testing ext2 with "./check -g quick" in a QEMU/KVM x86_32 VM, 6GB=
=20
RAM,
> booting a Vanilla kernel 6.3.0-rc1 with HIGHMEM64GB enabled, the OOM Kill=
er
> kicks in at random tests _with_ and _without_ Al's patches.
>=20
> 2) The only case which does never trigger the OOM Killer is running the=20
tests
> on ext2 formatted filesystems in loop disks with the stock openSUSE kernel
> which is the 6.2.1-1-pae.
>=20
> 3) The same "./check -g quick" on 6.3.0-rc1 runs always to completion with
> other filesystems. I ran xfstests several times on Btrfs and I had no
> problems.
>=20
> 4) I cannot git-bisect this issue with ext2 because I cannot trust the=20
results
> on any particular Kernel version. I mean that I cannot mark any specific
> version neither "good" or "bad" because it happens that the same "good"
> version instead make xfstests crash at the next run.
>=20
> My conclusion is that we probably have some kind of race that makes the=20
random
> tests crash at random runs of random Kernel versions between (at least) S=
USE
> 6.2.1 and Vanilla current.
>=20
> But it may be very well the case that I'm doing something stupid (e.g., w=
ith
> QEMU configuration or setup_disks or I can't imagine whatever else) and t=
hat
> I'm unable to see where I make mistakes. After all, I'm still a newcomer=
=20
with
> little experience :-)
>=20
> Therefore, I'd suggest that someone else try to test ext2 in an x86_32 VM.
> However, I'm 99.5% sure that Al's patches are good by the mere inspection=
 of
> his code.
>=20
> I hope that this summary contains everything that may help.
>=20
> However, I remain available to provide any further information and to giv=
e=20
my
> contribution if you ask me for specific tasks.
>=20
> For my part I have no idea how to investigate what is happening. In these
> months I have run the VM hundreds of times on the most disparate filesyst=
ems
> to test my conversions to kmap_local_page() and I have never seen anything
> like this happen.
>=20
> Thanks,
>=20
> Fabio
>=20
>=20
> Honza
>=20
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR

I can't yet figure out which conditions lead to trigger the OOM Killer to k=
ill=20
the XFCE Desktop Environment, and the xfstests (which I usually run into th=
e=20
latter). After all, reserving 6GB of main memory to a QEMU/KVM x86_32 VM ha=
d=20
always been more than adequate.

So, I thought I'd better ignore that 6GB for a 32 bit architecture are a=20
notable amount of RAM and squeezed some more from the host until I went to=
=20
reserve 8GB. I know that this is not what who is able to find out what=20
consumes so much main memory would do, but wanted to get the output from th=
e=20
tests, one way or the other... :-(

OK, I could finally run my tests to completion and had no crashes at all. I=
=20
ran "./check -g quick" on one "test" + three "scratch" loop devices formatt=
ed=20
with "mkfs.ext2 -c". I ran three times _with_ and then three times _without=
_=20
Al's following patches cloned from his vfs tree, #work.ext2 branch:

f5b399373756 ("ext2: use offset_in_page() instead of open-coding it as=20
subtraction")
c7248e221fb5 ("ext2_get_page(): saner type")
470e54a09898 ("ext2_put_page(): accept any pointer within the page")
15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with page_addr")
16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need

All the six tests were no longer killed by the Kernel :-)

I got 144 failures on 597 tests, regardless of the above listed patches.

My final conclusion is that these patches don't introduce regressions. I se=
e=20
several tests that produce memory leaks but, I want to stress it again, the=
=20
failing tests are always the same with and without the patches.

therefore, I think that now I can safely add my tag to all five patches lis=
ted=20
above...

Tested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Regards,

=46abio







