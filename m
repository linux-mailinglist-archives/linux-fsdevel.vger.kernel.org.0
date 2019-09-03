Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDACFA6078
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 07:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfICFVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 01:21:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10698 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfICFVy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:21:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46MwL728ttz9vBn0;
        Tue,  3 Sep 2019 07:21:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jBFEMAcM; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id z_oZM-nQGOxo; Tue,  3 Sep 2019 07:21:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46MwL70zsbz9vBmy;
        Tue,  3 Sep 2019 07:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567488111; bh=qbuG+RUrs+H+R7AEWaZZdUx62SA2ZhQIuC96dqC+GUI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jBFEMAcMs2AHYbs/GpdtbDn7S1VrRGQBB7YEJw9TsnpRgS+AtzCpbQ4eSe3jBkhyx
         Mn/CKCwsDWhlgbLSe0Os7Zs5OnqddxZHdmZB+flZnhK/DFByF7d29SbMSGfWBzi78Y
         2iEoMt5mUBcFzMS+fAwFb5fuF9OciRdNJ3irQjxA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E63A58B79F;
        Tue,  3 Sep 2019 07:21:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sB_vCzEfMRgO; Tue,  3 Sep 2019 07:21:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 213A08B761;
        Tue,  3 Sep 2019 07:21:50 +0200 (CEST)
Subject: Re: [PATCH v7 5/6] powerpc/64: Make COMPAT user-selectable disabled
 on littleendian by default.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
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
References: <cover.1567198491.git.msuchanek@suse.de>
 <c7c88e88408588fa6fcf858a5ae503b5e2f4ec0b.1567198492.git.msuchanek@suse.de>
 <87ftlftpy7.fsf@mpe.ellerman.id.au>
 <20190902130008.GZ31406@gate.crashing.org>
 <87k1aqs19n.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <296c9fce-f38c-cc53-4c1e-306c4dec17bc@c-s.fr>
Date:   Tue, 3 Sep 2019 05:21:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87k1aqs19n.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 09/02/2019 11:53 PM, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
>> On Mon, Sep 02, 2019 at 12:03:12PM +1000, Michael Ellerman wrote:
>>> Michal Suchanek <msuchanek@suse.de> writes:
>>>> On bigendian ppc64 it is common to have 32bit legacy binaries but much
>>>> less so on littleendian.
>>>
>>> I think the toolchain people will tell you that there is no 32-bit
>>> little endian ABI defined at all, if anything works it's by accident.
>                  ^
>                  v2
> 
>> There of course is a lot of powerpcle-* support.  The ABI used for it
>> on linux is the SYSV ABI, just like on BE 32-bit.
> 
> I was talking about ELFv2, which is 64-bit only. But that was based on
> me thinking we had a hard assumption in the kernel that ppc64le kernels
> always expect ELFv2 userland. Looking at the code though I was wrong
> about that, it looks like we will run little endian ELFv1 binaries,
> though I don't think anyone is testing it.
> 
>> There also is specific powerpcle-linux support in GCC, and in binutils,
>> too.  Also, config.guess/config.sub supports it.  Half a year ago this
>> all built fine (no, I don't test it often either).
>>
>> I don't think glibc supports it though, so I wonder if anyone builds an
>> actual system with it?  Maybe busybox or the like?
>>
>>> So I think we should not make this selectable, unless someone puts their
>>> hand up to say they want it and are willing to test it and keep it
>>> working.
>>
>> What about actual 32-bit LE systems?  Does anyone still use those?
> 
> Not that I've ever heard of.
> 

We dropped support from 32-bit LE at least with a1f3ae3fe8a1 
("powerpc/32: Use stmw/lmw for registers save/restore in asm").

Discussion about it can be found at 
https://patchwork.ozlabs.org/patch/899465/

Christophe
