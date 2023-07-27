Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818C87658E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 18:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjG0QiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 12:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjG0QiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:38:11 -0400
X-Greylist: delayed 552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 09:38:10 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055BA198A;
        Thu, 27 Jul 2023 09:38:09 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4RBbn36YnGz1sClr;
        Thu, 27 Jul 2023 18:28:55 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4RBbn3498Bz1qqlc;
        Thu, 27 Jul 2023 18:28:55 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id L2BxAh51PvpU; Thu, 27 Jul 2023 18:28:54 +0200 (CEST)
X-Auth-Info: /OdUztXMee0ZSkATtsTdHv9aXOABzOIhAtGtPnP68TjAEOXj7HyRSJPLBm2Ue4rD
Received: from igel.home (aftr-62-216-205-232.dynamic.mnet-online.de [62.216.205.232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Jul 2023 18:28:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 19B4B2C1309; Thu, 27 Jul 2023 18:28:54 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Aleksa Sarai' <cyphar@cyphar.com>,
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
        "dalias@libc.org" <dalias@libc.org>,
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
In-Reply-To: <d052e1266bf042f9b4961bbf42261a55@AcuMS.aculab.com> (David
        Laight's message of "Thu, 27 Jul 2023 09:01:06 +0000")
References: <cover.1689074739.git.legion@kernel.org>
        <cover.1689092120.git.legion@kernel.org>
        <f2a846ef495943c5d101011eebcf01179d0c7b61.1689092120.git.legion@kernel.org>
        <njnhwhgmsk64e6vf3ur7fifmxlipmzez3r5g7ejozsrkbwvq7w@tu7w3ieystcq>
        <d052e1266bf042f9b4961bbf42261a55@AcuMS.aculab.com>
X-Yow:  Darling, my ELBOW is FLYING over FRANKFURT, Germany..
Date:   Thu, 27 Jul 2023 18:28:53 +0200
Message-ID: <87ila5jp2y.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jul 27 2023, David Laight wrote:

> From: Aleksa Sarai
>> Sent: 25 July 2023 17:36
> ...
>> We almost certainly want to support AT_EMPTY_PATH at the same time.
>> Otherwise userspace will still need to go through /proc when trying to
>> chmod a file handle they have.
>
> That can't be allowed.

IIUC, fchmodat2(fd, "", m, AT_EMPTY_PATH) is equivalent to fchmod(fd,
m).  With that, new architectures only need to implement the fchmodat2
syscall to cover all chmod variants.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
