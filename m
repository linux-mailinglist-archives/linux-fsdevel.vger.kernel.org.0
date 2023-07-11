Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D91774EED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 14:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGKMaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjGKM3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:29:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6471919A8;
        Tue, 11 Jul 2023 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hu/F5cIunoMaT6a9kqfbZcMI7NNurFOLxchc3V/T840=; b=Gyep6a1gLgAdGC/Vi+oGeCj6t2
        IKyL5/1RD8Tt4FNIzAW4j/atfGUaAPjhcTyA3GXH97IiwjxIU7Y/8B0fe9w8Muqivjaw/yL4bo5D4
        5ZB6Z3jktax9ZhaYYlnpZ/6Oq2ASsc4zeolrABZ2MM6Kdwl61InYH3P9Iq/clR9bEshpkcTPgt83a
        HcgfknEVHsZHsbDQUQVwhK7+voDCXknT2H10c2k4CU3PIKN/myEz2CoJrRiGA1cFSqntUv8vLlRLZ
        MsgcNgtIOxR6kAkYIn3W2vzZiImwsqNNg3I5cIwMsUw6LmokGgjjMBQXCL8w1O5cla/0aNYRbdjkx
        RH8+Ud9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJCTM-00FiF8-9q; Tue, 11 Jul 2023 12:28:04 +0000
Date:   Tue, 11 Jul 2023 13:28:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Palmer Dabbelt <palmer@sifive.com>,
        James.Bottomley@hansenpartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, firoz.khan@linaro.org,
        fweimer@redhat.com, geert@linux-m68k.org, glebfm@altlinux.org,
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
        namhyung@kernel.org, paul.burton@mips.com, paulus@samba.org,
        peterz@infradead.org, ralf@linux-mips.org, rth@twiddle.net,
        schwidefsky@de.ibm.com, sparclinux@vger.kernel.org,
        stefan@agner.ch, tglx@linutronix.de, tony.luck@intel.com,
        tycho@tycho.ws, will@kernel.org, x86@kernel.org,
        ysato@users.sourceforge.jp
Subject: Re: [PATCH v3 2/5] fs: Add fchmodat4()
Message-ID: <ZK1K1BOf43JOJWMx@casper.infradead.org>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
 <cover.1689074739.git.legion@kernel.org>
 <d11b93ad8e3b669afaff942e25c3fca65c6a983c.1689074739.git.legion@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d11b93ad8e3b669afaff942e25c3fca65c6a983c.1689074739.git.legion@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 01:25:43PM +0200, Alexey Gladkov wrote:
> -static int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
> +static int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int lookup_flags)

This function can still be called do_fchmodat(); we don't need to
version internal functions.

