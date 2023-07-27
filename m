Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32310765118
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjG0K21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 06:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjG0K15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D0B3C1F;
        Thu, 27 Jul 2023 03:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDA6761DED;
        Thu, 27 Jul 2023 10:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B3AC433C7;
        Thu, 27 Jul 2023 10:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690453633;
        bh=R/FYmp9MZEn+gyMq0ULNxE++Cfcy5PFI0h0gHoMCEaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIRxzFuZRUpzkkFGKnnORGNBJ80AiPRF99WZpuM+vb47BufRaRCX0nIyujfGYNZQe
         NeYMFGrUe3lvpoUWfgZe9pK/BpocYz7rTImYpnueNbLJ8q5lyHeeW1TAJF5SI/w+Zt
         VsP5DmcMZq6gKczQX/HTSDSpbLUYeJemvT+46ZRPtId5YN+FAuc5U7zjXDXBTiUhES
         KLHJnbCE6Y8IrNHY5cY5wkkgFPDXeJZi3CjVnYPpYgTUMnxr2+kPa96nXV92DuNGtT
         2wPdCtmvz6aPl0zP7CxK5fM5OA63Ga+2qGCzHv/Dp/yIidvhBQEYCQ8rZQpRIqiDJP
         d13GHDccbk2Cg==
Date:   Thu, 27 Jul 2023 12:26:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        James.Bottomley@hansenpartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, fweimer@redhat.com,
        geert@linux-m68k.org, glebfm@altlinux.org, gor@linux.ibm.com,
        hare@suse.com, hpa@zytor.com, ink@jurassic.park.msu.ru,
        jhogan@kernel.org, kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, namhyung@kernel.org,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v4 2/5] fs: Add fchmodat2()
Message-ID: <20230727-mitkommen-deck-2db8197421bd@brauner>
References: <cover.1689074739.git.legion@kernel.org>
 <cover.1689092120.git.legion@kernel.org>
 <f2a846ef495943c5d101011eebcf01179d0c7b61.1689092120.git.legion@kernel.org>
 <njnhwhgmsk64e6vf3ur7fifmxlipmzez3r5g7ejozsrkbwvq7w@tu7w3ieystcq>
 <ZMEjlDNJkFpYERr1@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMEjlDNJkFpYERr1@example.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I think it'd be much neater to do the conversion of AT_ flags here and
> > pass 0 as a flags argument for all of the wrappers (this is how most of
> > the other xyz(), fxyz(), fxyzat() syscall wrappers are done IIRC).

I've fixed that up in-tree.
