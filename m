Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586E7A56E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfIBNBb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 09:01:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:53196 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbfIBNBa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:01:30 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x82D0CbT029470;
        Mon, 2 Sep 2019 08:00:12 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x82D09fF029469;
        Mon, 2 Sep 2019 08:00:09 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 2 Sep 2019 08:00:08 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Diana Craciun <diana.craciun@nxp.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] powerpc/64: Make COMPAT user-selectable disabled on littleendian by default.
Message-ID: <20190902130008.GZ31406@gate.crashing.org>
References: <cover.1567198491.git.msuchanek@suse.de> <c7c88e88408588fa6fcf858a5ae503b5e2f4ec0b.1567198492.git.msuchanek@suse.de> <87ftlftpy7.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftlftpy7.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 12:03:12PM +1000, Michael Ellerman wrote:
> Michal Suchanek <msuchanek@suse.de> writes:
> > On bigendian ppc64 it is common to have 32bit legacy binaries but much
> > less so on littleendian.
> 
> I think the toolchain people will tell you that there is no 32-bit
> little endian ABI defined at all, if anything works it's by accident.

There of course is a lot of powerpcle-* support.  The ABI used for it
on linux is the SYSV ABI, just like on BE 32-bit.

There also is specific powerpcle-linux support in GCC, and in binutils,
too.  Also, config.guess/config.sub supports it.  Half a year ago this
all built fine (no, I don't test it often either).

I don't think glibc supports it though, so I wonder if anyone builds an
actual system with it?  Maybe busybox or the like?

> So I think we should not make this selectable, unless someone puts their
> hand up to say they want it and are willing to test it and keep it
> working.

What about actual 32-bit LE systems?  Does anyone still use those?


Segher
