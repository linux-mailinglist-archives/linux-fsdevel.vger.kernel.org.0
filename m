Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF0040BEC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 06:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhIOEZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 00:25:36 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37697 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhIOEZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 00:25:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 30FAD320046E;
        Wed, 15 Sep 2021 00:24:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 Sep 2021 00:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        content-type:mime-version:subject:from:in-reply-to:date:cc
        :content-transfer-encoding:message-id:references:to; s=fm2; bh=2
        AVN+cTJbsiNWMcAjwSymE3wRt30wf/yR8jdCKIGuCU=; b=Sg1501P8p7wWLtwyo
        UJ0KldLzFlW1unKnFrMzOhtpeOh/2FGRbV+ZioOCVVDDpuwiRCSCOliE+yuwXads
        8sr1pBa57UY8DTXaubBmnxrazaIotYfkYFC5/9EV5GuZKcWB4WAddW5N+arzQhSY
        wgv7hKsbort+wALZghKPkX8/0LgwNOPtb05YDy7YpKUFip5ubcyZEJE8bOJsjIrb
        AtEm8MAn2kSDxcOFL7M1BQ+KwF1x/y9j/q5OUIMc5NqzaKJZQPjyPX6oLl/+wuB1
        nkW79gMpDpaaO+T0r8O9h7eJc4DPYVfUF5tonHaR9DpaA2kdLHLQ/W3ljJct5QXR
        aQR9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=2AVN+cTJbsiNWMcAjwSymE3wRt30wf/yR8jdCKIGu
        CU=; b=evSMNx0tf8fBTUwAuHhcpKdA75XLiPykkOJGxncrNFl0H2CMh6qLqQEg9
        uq+gxEBiP7sSvn144wlC+SCvy1HWRzzLhLk9EWs+/XC8s1nKz/5zwjG5KNsrxCPM
        WtVk8xXOWM6jK4CnDEOwouagmsX7TwX1Yg5NtunteHqPfNdg7UgVJsJSo+z6yu57
        CTrrXqVBC3hcSciIIuKgiXQPH2gcEc0Xs2k5n7jyaso3ZT8VhkCaITC0S6i4RaEy
        NYXLOfPib96nZiiQ63Lx4NAgpKWx7Y7Tyq2J13zNRViqAAG5nGvROMDOyDdYS1nj
        tbtDhz2w8Jn4Q7HAl1/LEtfK2UW8A==
X-ME-Sender: <xms:cHVBYTCOPDVQRKNouA4wL4HIzcqMGF1Ru5g5YOO2wJaL7wI89mJKrg>
    <xme:cHVBYZjGvQ5Jn0Cah0EeTOqaUWjLpHCoCsAj2l_t0qEN1NCL0SUwESqVdgK5jIYk6
    fDPgWlgVIyHMmHuJRA>
X-ME-Received: <xmr:cHVBYel2uqIZN92-Q268WgMYpwQjQVIXbWg12MlsEBQUS1UUFFJoba_dzjUSH1tQckRvsKuuhBhS_bqeLWGY3jQgg2btuk9MILzcN8lGyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehtddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthejmhdthhdtvdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpefhteffvdelgedtleevgfeivdetieeitdevhfekgeehfeetffejveefkeeviedv
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:cHVBYVxj6cGg-_JZdcPF-vYswwMP4qUFfvIWODwkMj19LkXLpmdTIg>
    <xmx:cHVBYYS6t9y2ol9O6xUVFtzGimKE50yoHwRwhc5npReFetzuO3Pk7Q>
    <xmx:cHVBYYaeY_az1a3Vxww8Putu1psoJCXEW-ZaCFMb-LgyEck5aF4cwg>
    <xmx:cHVBYecOU6sSIMPYoNGhrAvZHrFfl5pv9R2apm_DVkYVusK0HFffpg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 00:24:15 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/7] proc/stat: Maintain monotonicity of "intr" and
 "softirq"
From:   Alexei Lozovsky <me@ilammy.net>
In-Reply-To: <87y27zb62e.ffs@tglx>
Date:   Wed, 15 Sep 2021 13:24:11 +0900
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <44D2E875-33FF-4756-9FAB-7F2E1ED56139@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
 <YT3In8SWc2eYZ/09@localhost.localdomain>
 <44F84890-521F-4BCA-9F48-B49D2C8A9E32@ilammy.net> <87y27zb62e.ffs@tglx>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for vetting my ideas!

On Tue, Sep 14, 2021, at 23:11, Thomas Gleixner wrote:
> On Sun, Sep 12 2021 at 21:37, Alexei Lozovsky wrote:
>> On Sun, Sep 12, 2021, at 18:30, Alexey Dobriyan wrote:
>>> How about making everything "unsigned long" or even "u64" like NIC
>>> drivers do?
>> 
>> I see some possible hurdles ahead:
>> 
>> - Not all architectures have atomic operations for 64-bit values
> 
> This is not about atomics.

Yeah, I got mixed up in terminology. As you said, atomic
read-modify-write for increment is not important here, but what
*is* important is absence of tearing when doing loads and stores.

If there is no tearing we don't need any barriers to observe counters
that make sense. They might be slightly outdated but we don't care
as long as they are observed to be monotonically increasing and
we don't see the low bits wrap before the high bits are updated
because 64-bit store got split into two 32-bit ones.

That said, I believe this rules out updating counter types to u64
because on 32-bit platforms those will tear. However, we can use
unsigned long so that platforms with 64-bit native words get 64-bit
counters and platforms with 32-bit words stay with 32-bit counters
that wrap like they should.

I've checked this on Godbolt for a number of archs and it seems that
all of them will emit single loads and stores for unsigned long.
Well, except for 16-bit platforms, but those would certainly not use
PPC or x86 and procfs in the first place, so I think we can ignore
them for this matter.

> On 32bit systems a 32bit load (as long as the compiler does not emit
> load tearing) is always consistent even when there is a concurrent
> increment going on. It either gets the old or the new value.

Regarding tearing, I thought about wrapping counter reads in READ_ONCE()
to signal that they should be performed in one load. __this_cpu_inc()
should probably do WRITE_ONCE() for the sake of pairing, but that
should not be too important.

Is it a good idea to use READ_ONCE here?
Or just assume that compiler will not emit any weird loads?

(READ_ONCE does not strictly check that reads will not tear. Right now
it allows unsigned long long because reasons. But I guess it will enable
some extra debugging checks.)
