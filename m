Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3274068BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhIJIyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 04:54:49 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37489 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231731AbhIJIys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 04:54:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2276932009F0;
        Fri, 10 Sep 2021 04:53:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 Sep 2021 04:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:content-type:content-transfer-encoding:mime-version:subject
        :message-id:date:cc:to; s=fm2; bh=iJpONL4AqPRFYodHgX8qaQC1HnvrTc
        94YdA+uyxnPf8=; b=mQ5ldECQEBEzzCoBTinbYAjksN5nd8qSsFS/c7KJQhBX1N
        tzmxA0Au9Bcs9870f9iUPk6Hv8j3ntGnqnufqorKB4oLeRvDAhDXIRNQyC1bvbxt
        LG2n0I0bRea/O+Z3mRd7XQUFg7Mh7+R6YkYFIQ4wGGjIWhyyqsIxAKpywxJnaB62
        C+i75kWws3OIe/x7vh7ETITut96bkJgXRSPv1GuLuv6cWV8C6N55nR1U1vUp6XvT
        cnkCpRAPUFNPTuaxSIA2yXy394PunOsK1ha+ig29LEcWtlHfZoyT0sXLOoDIxwbQ
        X3L7IDJznrNhayu7fIr2DMs53WnnjG0DCxm+cGgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=iJpONL
        4AqPRFYodHgX8qaQC1HnvrTc94YdA+uyxnPf8=; b=ZT3xy/EXTIEe2oA3YPkwEz
        qIlR6s2YAsHgtvcP21pArgWt8FLLpRiOd5gshyMns7ny0lr5Pro1ZoVldtwyJYjc
        psPgoQDW1lT9/EeBxcCJN37FYRxj4K4NYFNvyFuCptOhHHfoywGcvfspCVrbZKtL
        cgRIQGESoPGjb2TB6v8mcnfl4GONUz7NbpelbQZBmxNy/d6BakL2uHNuelsigzee
        HN/MnCcAeytynCdms0IWGxGrMzocGpAmyqI3l1PGTXQf+dK56DWgS1l5AsNxwiBZ
        xxgA6nQ1jD/y03UWlgqlDg6oecKIbqA+4X8oPzEE3Y/8Dv6S618aDffmLZJ88i0Q
        ==
X-ME-Sender: <xms:EB07YZD9OJXvlAhPc59AuamRyRfPtMC6kA8R1KXs5Qkv2i3vCqTvjQ>
    <xme:EB07YXhyyaX1CW5RMoRd5QeYwEtpiutc3qOLY-Q0G3NZlhVVxs4qad2EaSBijoIQM
    00oGIoM3KNW7i7KY1A>
X-ME-Received: <xmr:EB07YUnlnSEN-e9IdFR116QG3IwTLAqmSbOUo0mPkiIGLMNTV-LMeyrvea3slZ3u9vo4iKnBM6oRIWO_MCboaHO-UiscjpFn1jbQ5qb3qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeguddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfgtgfgguffkfffvofesthhqmhdthhdtvdenucfhrhhomheptehlvgigvghi
    ucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtthgvrh
    hnpeevieegjefhuefggfdtgeekjeeljeduvdehvdeuueegleegteevheegiedvueelfeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgvsehilhgrmhhmhidrnhgvth
X-ME-Proxy: <xmx:EB07YTyiaR6LDt2geVNE3zZLfaWuUl9TxittDwLG2-GjeJ8GjHw9dg>
    <xmx:EB07YeS_T648pxOvGaxBuLvNyxdpjZWlECHkuwDcy5QyuGxkK59Mhw>
    <xmx:EB07YWYocv11-jGR3i6hxfB7TXhPdXyY-eWQwQ5vVXI4JwDWAtdRsA>
    <xmx:EB07Ycf0NKkAk9rpMNpxO8e-Yl17HGGhcw8FgW5e6DM7JICzXzsbGw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 04:53:34 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: /proc/stat interrupt counter wrap-around
Message-Id: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
Date:   Fri, 10 Sep 2021 17:53:28 +0900
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A monitoring dashboard caught my attention when it displayed weird
spikes in computed interrupt rates. A machine with constant network
load shows about ~250k interrupts per second, then every 4-5 hours
there's a one-off spike to 11 billions.

Turns out, if you plot the interrupt counter, you get a graph like this:

                                     ###.                          =20
                                  ###   | ####.              #######
                  #####.     #####      ##    |     #########      =20
             #####     |   ##                 ######               =20
            #          ####                                        =20
        ####                                                       =20
       #                                                           =20
    ###                                                            =20

While monitoring tools are typically used to handling counter
wrap-arounds, they may not be ready to handle dips like this.


What is the impact
------------------

Not much, actually.

The counters always decrement by exactly 2^32 (which is suggestive),
so if you mask out the high bits of the counter and consider only
the low 32 bits, then the value sequence actually make sense,
given an appropriate sampling rate.

However, if you don't mask out the value and assume it to be accurate --
well, that assumption is incorrect. Interrupt sums might look correct
and contain some big number, but it could be arbitrarily distant from
the actual number of interrupts serviced since the boot time.

This concerns only the total value of "intr" and "softirq" rows:

    intr    14390913189 32 11 0 0 238 0 0 0 0 0 0 0 88 0 [...]
    softirq 14625063745 0 596000256 300149 272619841 0 0 [...]
            ^^^^^^^^^^^
            these ones


Why this happens
----------------

The reason for such behaviour is that the "total" interrupt counters
presented by /proc/stat are actually computed by adding up per-interrupt
per-CPU counters. Most of these are "unsigned int", while some of them
are "unsigned long", and the accumulator is "u64". What a mess...

Individual counters are monotonically increasing (modulo wrapping),
however if you add multiple values with different bit widths then
the sum is *not* guaranteed to be monotonically increasing.


What can be done
----------------

 1. Do nothing.

    Userspace can trivially compensate for this 'curious' behavior
    by masking out the high bits, observing only the low
    sizeof(unsigned) part, and taking care to handle wrap-arounds.

    This maintains status quo, but the "issue" of interrupt sums
    not being quite accurate remains.


 2. Change the presentation type to the lowest denominator.

    That is, unsigned int. Make the kernel mask out not-quite-accurate
    bits from the value it reports. Keep it that way until every
    underlying counter type is changed to something wider.

    The benefit here is that users that *are* ready to handle proper
    wrap-arounds will be able to handle them automagically without
    undocumented hacks (see option 1).

    This changes the observed value and will cause "unexpected"
    wrap-arounds to happen earlier in some use-cases, which might
    upset users that are not ready to handle them, or don't want
    to poll /proc/stat more frequently.

    It's debatable what's better: a lower-width value that might
    need to be polled more often, or a wider-width value that is
    not completely accurate.


 3. Change the interrupt counter types to be wider.

    A different take on the issue: instead of narrowing the presentation
    from faux-u64 to unsigned it, widen the interrupt counters from
    unsigned int to... something else:

    - u64             interrupt counters are 64-bit everywhere, period

    - unsigned long   interrupt counters are 64-bit if the platform
                      thinks that "long" is longer than "int"

    Whatever the type is used, it must be the same for all interrupt
    counters across the kernel as well as the type used to compute
    and display the sum of all these counters by /proc/stat.

    The advantage here is that 64-bit counters will be probably enough
    for *anything* to not overflow anytime soon before the heat death
    of the universe, thus making the wrap-around problem irrelevant.

    The disadvantage here is that some hardware counters are 32-bit,
    and you can't make them wider. Some platforms also don't have
    proper atomic support for 64-bit integers, making wider counters
    problematic to implement efficiently.


So what do we do?
-----------------

I suggest to wrap interrupt counter sum at "unsigned int", the same
type used for (most) individual counters. That makes for the most
predictable behavior.

I have a patch set cooking that does this.

Will this be of any interest? Or do you think changing the behavior
of /proc/stat will cause more trouble than merit?


Prior discussion
----------------

This question is by no means new, it has been discussed several times:

2019 - genirq, proc: Speedup /proc/stat interrupt statistics

    The issue of overflow and wrap-around has been touched upon,
    suggesting that userspace should just deal with it. The issue of
    using u64 for the sum has been brought up too, but it did not
    go anywhere.

=
https://lore.kernel.org/all/20190208143255.9dec696b15f03bf00f4c60c2@linux-=
foundation.org/
=
https://lore.kernel.org/all/3460540b50784dca813a57ddbbd41656@AcuMS.aculab.=
com/


2014 - Why do we still have 32 bit counters? Interrupt counters overflow =
within 50 days

    Discussion on whether it's appropriate to bump counter width to
    64 bits in order to avoid the overflow issues entirely.

=
https://lore.kernel.org/lkml/alpine.DEB.2.11.1410030435260.8324@gentwo.org=
/

