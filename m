Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A72323CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgG2Rzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 13:55:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33132 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2Rzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:55:53 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id F0E4120B4908;
        Wed, 29 Jul 2020 10:55:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0E4120B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596045352;
        bh=Nh1awxv8sYMWjyBdKzptNt/99nJiurbGvK4nLo6gXvU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ET55hxg/DBtDrPqMLvEgwflc/o1gjQ4X7Oa3dCnjuCAMmZs7sULLK5HNN8WxJb0i5
         0ANYiCsQDqTi6GijyuIZbLq/tNbFUvpAB5eayNWW4/qmE/6W3Ct1DOBfa73pb1uSap
         kv37tbx4EFhfNrjIQ8YdBDHjoOhsdUZVP47hnYG0=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     David Laight <David.Laight@ACULAB.COM>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <c23de6ec47614f489943e1a89a21dfa3@AcuMS.aculab.com>
 <f5cfd11b-04fe-9db7-9d67-7ee898636edb@linux.microsoft.com>
 <CALCETrUta5-0TLJ9-jfdehpTAp2Efmukk2npYadFzz9ozOrG2w@mail.gmail.com>
 <59246260-e535-a9f1-d89e-4e953288b977@linux.microsoft.com>
 <a159f2e8417746fb88f31a97c6f366ba@AcuMS.aculab.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <98aa9d5e-6eb4-de29-2fc2-06f6dc52086f@linux.microsoft.com>
Date:   Wed, 29 Jul 2020 12:55:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a159f2e8417746fb88f31a97c6f366ba@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/29/20 3:36 AM, David Laight wrote:
> From: Madhavan T. Venkataraman
>> Sent: 28 July 2020 19:52
> ...
>> trampfd faults are instruction faults that go through a different code path than
>> the one that calls handle_mm_fault(). Perhaps, it is the handle_mm_fault() that
>> is time consuming. Could you clarify?
> Given that the expectation is a few instructions in userspace
> (eg to pick up the original arguments for a nested call)
> the (probable) thousands of clocks taken by entering the
> kernel (especially with page table separation) is a massive
> delta.
>
> If entering the kernel were cheap no one would have added
> the DSO functions for getting the time of day.

I hear you. BTW, I did not say that the overhead was trivial.
I only said that in most cases, applications may not mind that
extra overhead.

However, since multiple people have raised that as an issue,
I will address it. I mentioned before that the kernel can actually
supply the code page that sets the context and jumps to
a PC and map it so the performance issue can be addressed.
I was planning to do that as a future enhancement.

If there is a consensus that I must address it immediately, I
could do that.

I will continue this discussion in my reply to Andy's email. Let
us pick it up from there.

Thanks.

Madhavan
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

