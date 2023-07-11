Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2638674F055
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 15:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjGKNiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 09:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKNiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FED10DD;
        Tue, 11 Jul 2023 06:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C447614F6;
        Tue, 11 Jul 2023 13:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA99C433C7;
        Tue, 11 Jul 2023 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689082700;
        bh=MjkY+PryFAt8G+OdjO9LolQHYDzlX27UqcYtpMYnVwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4rG0DrQuYuh1KI2SaGRXPxMUodnyuoYxdgPkn1OMlHHieR1kS9r/CQh42NQdCEvi
         jezSVyuSCMeYDxZrU2qgssSXxMITcDN0wrI2LdTTXRxdvNf91UYOmZ/oeiA0SkLMOm
         ToPJ01f8m0qnXoBuvUPupXyZM8q39wgUuDsJ0IPd2i86nWZO8OaQ0Z1yj2zbd4H3fH
         d4apNZ3SHU+N4XnwC2YHNvSjMrA6Ly/31Wexx13nYBwFVH2whpKLnzaVfdu9jfzTjD
         b8h/GZBzFq03hxHoLJ1T4mgHcoT1KaxayCxO/eDkShAdahq/1VQ+nx1L6a75mBKsMI
         HsKJyRD7qNvow==
Date:   Tue, 11 Jul 2023 15:38:03 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, James.Bottomley@hansenpartnership.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        axboe@kernel.dk, benh@kernel.crashing.org, borntraeger@de.ibm.com,
        bp@alien8.de, catalin.marinas@arm.com, christian@brauner.io,
        dalias@libc.org, davem@davemloft.net, deepa.kernel@gmail.com,
        deller@gmx.de, dhowells@redhat.com, fenghua.yu@intel.com,
        firoz.khan@linaro.org, geert@linux-m68k.org, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, heiko.carstens@de.ibm.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru, jhogan@kernel.org,
        kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, luto@kernel.org, mattst88@gmail.com,
        mingo@redhat.com, monstr@monstr.eu, mpe@ellerman.id.au,
        namhyung@kernel.org, palmer@sifive.com, paul.burton@mips.com,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Subject: Re: [PATCH v3 5/5] selftests: add fchmodat4(2) selftest
Message-ID: <ZK1bOxynxdVHR1Fu@example.org>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
 <cover.1689074739.git.legion@kernel.org>
 <c3606ec38227d921fa8a3e11613ffdb2f3ea7636.1689074739.git.legion@kernel.org>
 <87pm4ybqct.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pm4ybqct.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:10:58PM +0200, Florian Weimer wrote:
> * Alexey Gladkov:
> 
> > The test marks as skipped if a syscall with the AT_SYMLINK_NOFOLLOW flag
> > fails. This is because not all filesystems support changing the mode
> > bits of symlinks properly. These filesystems return an error but change
> > the mode bits:
> >
> > newfstatat(4, "regfile", {st_mode=S_IFREG|0640, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
> > newfstatat(4, "symlink", {st_mode=S_IFLNK|0777, st_size=7, ...}, AT_SYMLINK_NOFOLLOW) = 0
> > syscall_0x1c3(0x4, 0x55fa1f244396, 0x180, 0x100, 0x55fa1f24438e, 0x34) = -1 EOPNOTSUPP (Operation not supported)
> > newfstatat(4, "regfile", {st_mode=S_IFREG|0640, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
> >
> > This happens with btrfs and xfs:
> >
> >  $ /kernel/tools/testing/selftests/fchmodat4/fchmodat4_test
> >  TAP version 13
> >  1..1
> >  ok 1 # SKIP fchmodat4(symlink)
> >  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> >
> >  $ stat /tmp/ksft-fchmodat4.*/symlink
> >    File: /tmp/ksft-fchmodat4.3NCqlE/symlink -> regfile
> >    Size: 7               Blocks: 0          IO Block: 4096   symbolic link
> >  Device: 7,0     Inode: 133         Links: 1
> >  Access: (0600/lrw-------)  Uid: (    0/    root)   Gid: (    0/    root)
> >
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> 
> This looks like a bug in those file systems?

To me this looks like a bug. I'm fine if the operation ends with
EOPNOTSUPP, but in that case the mode bits shouldn't change.

> As an extra test, “echo 3 > /proc/sys/vm/drop_caches” sometimes has
> strange effects in such cases because the bits are not actually stored
> on disk, only in the dentry cache.

tmpfs
syscall_0x1c3(0xffffff9c, 0x7ffd58758574, 0, 0x100, 0x7f6cf18adc70, 0x7ffd58756ad8) = 0
+++ exited with 0 +++
l--------- 1 root root 1 Jul 11 16:36 /tmp/dir/link -> f
=== dropping caches ===
l--------- 1 root root 1 Jul 11 16:36 /tmp/dir/link -> f

ext4
syscall_0x1c3(0xffffff9c, 0x7ffedfdb4574, 0, 0x100, 0x7f7f40b45c70, 0x7ffedfdb3ae8) = -1 EOPNOTSUPP (Operation not supported)
+++ exited with 1 +++
l--------- 1 root root 1 Jul 11 16:36 /tmp/dir/link -> f
=== dropping caches ===
l--------- 1 root root 1 Jul 11 16:36 /tmp/dir/link -> f

xfs
syscall_0x1c3(0xffffff9c, 0x7ffcd03ce574, 0, 0x100, 0x7ff2f2980c70, 0x7ffcd03cdd38) = -1 EOPNOTSUPP (Operation not supported)
+++ exited with 1 +++
l--------- 1 root root 1 Jul 11 16:36 /tmp/dir/link -> f
=== dropping caches ===
l--------- 1 root root 1 Jul 11 16:36 /tmp/dir/link -> f

btrfs
syscall_0x1c3(0xffffff9c, 0x7fff13d2e574, 0, 0x100, 0x7f9b67f59c70, 0x7fff13d2ca88) = -1 EOPNOTSUPP (Operation not supported)
+++ exited with 1 +++
l--------- 1 root root 1 Jul 11 16:36 /tmp/dir/link -> f
=== dropping caches ===
l--------- 1 root root 1 Jul 11 16:36 /tmp/dir/link -> f

reiserfs
syscall_0x1c3(0xffffff9c, 0x7ffdf75af574, 0, 0x100, 0x7f7ad0634c70, 0x7ffdf75ae478) = 0
+++ exited with 0 +++
l--------- 1 root root 1 Jul 11 16:43 /tmp/dir/link -> f
=== dropping caches ===
l--------- 1 root root 1 Jul 11 16:43 /tmp/dir/link -> f

-- 
Rgrds, legion

