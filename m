Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE1589903
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 10:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiHDIJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 04:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiHDIJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:09:58 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB5461DA4;
        Thu,  4 Aug 2022 01:09:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0AC4C5C01C1;
        Thu,  4 Aug 2022 04:09:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 04 Aug 2022 04:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1659600594; x=
        1659686994; bh=dPVd4gV1h4qR91/25oTaDRGFw63vpCO4NGp4fr1eceQ=; b=L
        4C5zAJ5GJihpjtPjr+i70KY92QwrHIPm60/rqiDBhOetsO8vTQnPJ4bmUi01qusM
        xe6oKGQRb6tzXNU9Eh+wDY8OSRhNbOC41yLizM1+lP1TBWQqTq+UhBCCpxUdCX9+
        /KYXLHBMNN7oNXWa/SCgRblPuBuC3UasqylTI+thLb4tKsPrGBZMA0WiE5fVICv4
        RWOpPe5PEnTLmPVeuiOodoUShiU91jsbbIUtApJybz36jXo18kHkbm2LMI6DVvxd
        nUDVvSHzUNj2TyW72hivREMsw5h5L7dFEkAOY27aX5+60n926wW6hC6JS/iirE1t
        Tyfi+hVgnY8KWjIFez3vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659600594; x=1659686994; bh=dPVd4gV1h4qR91/25oTaDRGFw63v
        pCO4NGp4fr1eceQ=; b=v7gNwiGp2euhBWd7JCNVz8DAbEteA3Y2KfleVSzfFU8b
        WJDkdspIxWE0JuvNqaC/2UbWji8JAmopZOlTg7d8C6vdd2ym3GBFxzKhekK+WbAl
        mxMa/BuZ3OMPLyzNktTnJHlAb4RDObzNBcHQWBypIdwfhuOpIXSM6sHBL1yANIe/
        fztaH8IAA+zITURn37gLXKt93QYVE0YF1YDd3iFVmOkuTtEvp/8ooc8snBbuRUAZ
        IH+4wLT2fF62lQbibdY3fF/N3NVzzNL2IINLrcBqUDELN7vdwczeKXGojNU2laES
        //07+dWI2cIR1ejbxhJzVcfUqQTaf1N/JKWkyFL0oQ==
X-ME-Sender: <xms:0X7rYsUD7RT-JtCYj0mEIGszbzNjwPLTJ_ZVx0CAd8sHvPrVqImMzw>
    <xme:0X7rYgm133FVbNiY2v-EQ_5m92jX_pYiEBBV2FLO3XVdWo4eHuN5OoKP4oIv7JXfm
    udo-fy7ntMoTZarWjI>
X-ME-Received: <xmr:0X7rYgaDkiKErWlNj4j2qdUEc0Zb4NODb5gHvsDLq4uPJxdsNV7icGH8TEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvkedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhs
    hhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqne
    cuggftrfgrthhtvghrnhepleeljeduiefguedtffejledttdehvdefhffhgfdvieelvddu
    teefkeeuvdelhffhnecuffhomhgrihhnpeeffedrshhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvght
    thdrohhrgh
X-ME-Proxy: <xmx:0X7rYrWZhJxJyP82-X2_eCJdO2kmZA00aguZJJ4XLxPvUUYJx-N17A>
    <xmx:0X7rYmnUrau23hsiPMrZMEU83qhrJiVAKIm4jCjZ9KEQ-fRkkB31Lg>
    <xmx:0X7rYgdjjKUIrevfOBnKTgGyyj4wi0HT9r7kwMCB3gn7jkIRLfdgdQ>
    <xmx:0n7rYrylTb8OaFlub4CgFSZW64moEryMmfCOou0x9XcHtbAzeSV1BQ>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Aug 2022 04:09:53 -0400 (EDT)
Date:   Thu, 4 Aug 2022 01:09:52 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Dump command line of faulting process to syslog
Message-ID: <Yut+0Fg7F99MI48J@localhost>
References: <20220801152016.36498-1-deller@gmx.de>
 <YugGFEjJvIwzifq7@localhost>
 <a0bf15a2-2f9c-5603-3adb-ffa705572a92@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0bf15a2-2f9c-5603-3adb-ffa705572a92@gmx.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 02, 2022 at 09:40:50PM +0200, Helge Deller wrote:
> On 8/1/22 18:57, Josh Triplett wrote:
> > On Mon, Aug 01, 2022 at 05:20:13PM +0200, Helge Deller wrote:
> >> This patch series allows the arch-specific kernel fault handlers to dump
> >> in addition to the typical info (IP address, fault type, backtrace and so on)
> >> the command line of the faulting process.
> >>
> >> The motivation for this patch is that it's sometimes quite hard to find out and
> >> annoying to not know which program *exactly* faulted when looking at the syslog.
> >>
> >> Some examples from the syslog are:
> >>
> >> On parisc:
> >>    do_page_fault() command='cc1' type=15 address=0x00000000 in libc-2.33.so[f6abb000+184000]
> >>    CPU: 1 PID: 13472 Comm: cc1 Tainted: G            E     5.10.133+ #45
> >>    Hardware name: 9000/785/C8000
> >>
> >> -> We see the "cc1" compiler crashed, but it would be useful to know which file was compiled.
> >>
> >> With this patch series, the kernel now prints in addition:
> >>    cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 -quiet @/tmp/ccRkFSfY -imultilib . -imultiarch hppa-linux-gnu -D USE_MINIINTERPRETER -D NO_REGS -D _HPUX_SOURCE -D NOSMP -D THREADED_RTS -include /build/ghc/ghc-9.0.2/includes/dist-install/build/ghcversion.h -iquote compiler/GHC/Iface -quiet -dumpdir /tmp/ghc13413_0/ -dumpbase ghc_5.hc -dumpbase-ext .hc -O -Wimplicit -fno-PIC -fwrapv -fno-builtin -fno-strict-aliasing -o /tmp/ghc13413_0/ghc_5.s
> >>
> >> -> now we know that cc1 crashed while compiling some haskell code.
> >
> > This does seem really useful for debugging.
> 
> Yes.
> 
> > However, it's also an information disclosure in various ways. The
> > arguments of a program are often more sensitive than the name, and logs
> > have a tendency to end up in various places, such as bug reports.
> >
> > An example of how this can be an issue:
> > - You receive an email or other message with a sensitive link to follow
> > - You open the link, which launches `firefox https://...`
> > - You continue browsing from that window
> > - Firefox crashes (and recovers and restarts, so you don't think
> >   anything of it)
> > - Later, you report a bug on a different piece of software, and the bug
> >   reporting process includes a copy of the kernel log
> 
> Yes, that's a possible way how such information can leak.
> 
> > I am *not* saying that we shouldn't do this; it seems quite helpful.
> > However, I think we need to arrange to treat this as sensitive
> > information, similar to kptr_restrict.
> 
> I wonder what the best solution could be.
> 
> A somewhat trivial solution is to combine it with the dmesg_restrict sysctl, e.g.:
> 
> * When ``dmesg_restrict`` is set to 0 there are no restrictions for users to read
> dmesg. In this case my patch would limit the information (based on example above):
>     cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 [note: other parameters hidden due to dmesg_restrict=0 sysctl]
> So it would show the full argv[0] with a hint that people would need to change dmesg_restrict.
> 
> * When ``dmesg_restrict`` is set to 1, users must have ``CAP_SYSLOG`` to use dmesg(8)
> and the patch could output all parameters:
>      cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 -quiet @/tmp/ccRkFSfY -imultilib . -imultiarch hppa-linux-gnu ....
> 
> That would of course still leave few possible corner-cases where information
> could leak, but since usually programs shouldn't crash and that
> people usually shouldn't put sensitive information into the parameter
> list directly, it's somewhat unlikely to happen.
> 
> Another different solution would be to add another sysctl.
> 
> Any other ideas?

I don't think we should overload the meaning of dmesg_restrict. But
overloading kptr_restrict seems reasonable to me. (Including respecting
kptr_restrict==2 by not showing this at all.)
