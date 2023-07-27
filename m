Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7DC765A77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 19:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjG0Rgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjG0Rgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579EF2D67;
        Thu, 27 Jul 2023 10:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB42B61EFB;
        Thu, 27 Jul 2023 17:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD2AC433C8;
        Thu, 27 Jul 2023 17:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690479396;
        bh=iU7zvXpvxPSg5KiGe2n535PFFdPoC8EIhqciU1h+3Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxumH8hGN053L+FyKWAl7yNCuep6zB52SgRtI5W/3VmZXm+mmZ4jBeoyIQx8UEPBz
         KB2g3ckpL1rFkA8SxtOo/2sVYVEfDaKNkKBz1lQ8P2ADzxBiSuYz1s4+mgNIaH8PHC
         mgTZjyPGv647aIhCLp9wnBJ2zOHZU59iFOFLNAEflHY4ZPUF7p4ROHHXQAz2E75cTe
         Vin+UGvlA56e4nxESt9X2PQkCsoXkmtj+oV/UF3bLR5Ny1I9LiKjhW+1r+2WJ/O6Yd
         TgUSACO81o4AuGEsdvCy68dJhSXgXujDC+IFg4xwGOBHFACldMWcZVQg7TP9JlZNoG
         348a+hccYCeEA==
Date:   Thu, 27 Jul 2023 19:36:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "dalias@libc.org" <dalias@libc.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        David Laight <David.Laight@ACULAB.COM>,
        'Aleksa Sarai' <cyphar@cyphar.com>,
        Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "glebfm@altlinux.org" <glebfm@altlinux.org>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "hare@suse.com" <hare@suse.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "kim.phillips@arm.com" <kim.phillips@arm.com>,
        "ldv@altlinux.org" <ldv@altlinux.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "tycho@tycho.ws" <tycho@tycho.ws>,
        "will@kernel.org" <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v4 2/5] fs: Add fchmodat2()
Message-ID: <20230727-boxte-wohnviertel-74b8541d27ec@brauner>
References: <cover.1689074739.git.legion@kernel.org>
 <cover.1689092120.git.legion@kernel.org>
 <f2a846ef495943c5d101011eebcf01179d0c7b61.1689092120.git.legion@kernel.org>
 <njnhwhgmsk64e6vf3ur7fifmxlipmzez3r5g7ejozsrkbwvq7w@tu7w3ieystcq>
 <d052e1266bf042f9b4961bbf42261a55@AcuMS.aculab.com>
 <87ila5jp2y.fsf@igel.home>
 <20230727-zerrt-leitmotiv-9e8b60abf690@brauner>
 <20230727171336.GC20050@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230727171336.GC20050@brightrain.aerifal.cx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:13:37PM -0400, dalias@libc.org wrote:
> On Thu, Jul 27, 2023 at 07:02:53PM +0200, Christian Brauner wrote:
> > On Thu, Jul 27, 2023 at 06:28:53PM +0200, Andreas Schwab wrote:
> > > On Jul 27 2023, David Laight wrote:
> > > 
> > > > From: Aleksa Sarai
> > > >> Sent: 25 July 2023 17:36
> > > > ...
> > > >> We almost certainly want to support AT_EMPTY_PATH at the same time.
> > > >> Otherwise userspace will still need to go through /proc when trying to
> > > >> chmod a file handle they have.
> > > >
> > > > That can't be allowed.
> > > 
> > > IIUC, fchmodat2(fd, "", m, AT_EMPTY_PATH) is equivalent to fchmod(fd,
> > > m).  With that, new architectures only need to implement the fchmodat2
> > > syscall to cover all chmod variants.
> > 
> > There's a difference though as fchmod() doesn't work with O_PATH file
> > descriptors while AT_EMPTY_PATH does. Similar to how fchown() doesn't
> > work with O_PATH file descriptors.
> > 
> > However, we do allow AT_EMPTY_PATH with fchownat() so there's no reason
> > to not allow it for fchmodat2().
> > 
> > But it's a bit of a shame that O_PATH looks less and less like O_PATH.
> > It came from can-do-barely-anything to can-do-quite-a-lot-of-things over
> > the years.
> > 
> > In any case, AT_EMPTY_PATH for fchmodat2() can be an additional patch on
> > top.
> 
> From a standpoint of implementing O_SEARCH/O_EXEC using it, I don't
> see any reason fchown/fchmod should not work on O_PATH file
> descriptors. And indeed when you have procfs available to emulate them
> via procfs, it already does. So I don't see this as unwanted

I'm really not talking about the fact that proc is a giant loophole for
basically everyhing related to O_PATH and reopening fds.

I'm saying that both fchmod() and fchown() don't work on O_PATH fds.
They explicitly reject them.

AT_EMPTY_PATH and therefore O_PATH for fchmodat2() is fine given that we
do it for fchownat() already.
