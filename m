Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19188586F16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiHAQ6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiHAQ6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:58:02 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438FB6385;
        Mon,  1 Aug 2022 09:58:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D9375C018A;
        Mon,  1 Aug 2022 12:57:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 01 Aug 2022 12:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1659373078; x=
        1659459478; bh=PwwN5504JpT9KHcDb60BwHye95H5oaCrlINKkI5OJ8g=; b=t
        Y2YBXRI24x3/9/oJyx1X66+TpNZnq8AxYeXjM7HBx8Snbbx5l6MGLHuwi81SpUid
        zdwF1M9/OHobo04lrql6uyEe6tgBOgILqIwnuIhCbBKVogc7uiHGX9PS7it9KMLF
        OyNs8g8UxmwZmd4iane0xBOOSaFGNsaY//UmLpWfqlh8wXdIe/oAGFTP0KGWaLXK
        FANVGEiZsyRaMXltMGKSSKVZOnxRw3jxdkWAe2xuGblNBX4W6s7qxJxV9fs+wfsI
        kBO40oM37cNcvYrzAqnFmrE8NZncTZbqvpsd/6i4BroDb4q5UOLFGBdqHnTRHADp
        BPs/dqi4kkFENOuVmO+ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659373078; x=1659459478; bh=PwwN5504JpT9KHcDb60BwHye95H5
        oaCrlINKkI5OJ8g=; b=aK+GuoqHJFVPrEhMUVCNorQmB7AXILjO4f8J9rUFnXl5
        0zZXiWPFvCoWmTxfFYNbKjfai5wkG+MPrnAqYA5zn4qBDho/f202pgWiwqIgQh+3
        zAkBby4K0thW+CefUEHv/Mp2E9iBvd9x+gFLxxeuNR7WmD6k1opkXjVZ5sJwbQT9
        fuN0VvX8WwBWw2JMN+yTCa0wofz54YoMujillSw09X/PfIu+XuuYmPussYKLcxNn
        YYsSY0AigS40cXDs2Sz6m200hTYYREauiRhO76QAGvFxMLwCYFh6DLqTtqDOl+BW
        bUIRGIOWtdscpzX+WwC4LTgc+b/7Z3bVdrXp9PFQ9Q==
X-ME-Sender: <xms:FQboYiJHOZeUrWF0WRD-VPcFXDmqGKeXBzNdbnIg2FHi0qpeJxrhTA>
    <xme:FQboYqLxmTDwAHWcv6r_0YD2QpA5KpOctpTvqdbUyXVmpP_42JufNSnW4BQhCDdtF
    AciumIHwzv6L-mti5Y>
X-ME-Received: <xmr:FQboYivGWzXF3lCuL9HxXSvAThXhBLRUB9ZspczBD_33fG897cKp1KK6XwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvfedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhs
    hhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqne
    cuggftrfgrthhtvghrnhepleeljeduiefguedtffejledttdehvdefhffhgfdvieelvddu
    teefkeeuvdelhffhnecuffhomhgrihhnpeeffedrshhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvght
    thdrohhrgh
X-ME-Proxy: <xmx:FQboYnZupWoLG6ZGtaZir5bAR4yH3-XEafe-3lm6G2rjGqgMCvm-6w>
    <xmx:FQboYpbQuW43SPld-Tkdpe5dSANM-TnTbn59-Ih56BqUbq44Xj2_sA>
    <xmx:FQboYjAws_VlQhBBlPF3EUKZ5jsUyvNFU6h7pUUxXDnaCNSye4TLng>
    <xmx:FgboYoka-rrd0kw93ZNxDURDapg-EwkGTSfW1nFu7WG-U1DJuhdUgw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 12:57:57 -0400 (EDT)
Date:   Mon, 1 Aug 2022 09:57:56 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Dump command line of faulting process to syslog
Message-ID: <YugGFEjJvIwzifq7@localhost>
References: <20220801152016.36498-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801152016.36498-1-deller@gmx.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 01, 2022 at 05:20:13PM +0200, Helge Deller wrote:
> This patch series allows the arch-specific kernel fault handlers to dump
> in addition to the typical info (IP address, fault type, backtrace and so on)
> the command line of the faulting process.
> 
> The motivation for this patch is that it's sometimes quite hard to find out and
> annoying to not know which program *exactly* faulted when looking at the syslog.
> 
> Some examples from the syslog are:
> 
> On parisc:
>    do_page_fault() command='cc1' type=15 address=0x00000000 in libc-2.33.so[f6abb000+184000]
>    CPU: 1 PID: 13472 Comm: cc1 Tainted: G            E     5.10.133+ #45
>    Hardware name: 9000/785/C8000
> 
> -> We see the "cc1" compiler crashed, but it would be useful to know which file was compiled.
> 
> With this patch series, the kernel now prints in addition:
>    cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 -quiet @/tmp/ccRkFSfY -imultilib . -imultiarch hppa-linux-gnu -D USE_MINIINTERPRETER -D NO_REGS -D _HPUX_SOURCE -D NOSMP -D THREADED_RTS -include /build/ghc/ghc-9.0.2/includes/dist-install/build/ghcversion.h -iquote compiler/GHC/Iface -quiet -dumpdir /tmp/ghc13413_0/ -dumpbase ghc_5.hc -dumpbase-ext .hc -O -Wimplicit -fno-PIC -fwrapv -fno-builtin -fno-strict-aliasing -o /tmp/ghc13413_0/ghc_5.s
> 
> -> now we know that cc1 crashed while compiling some haskell code.

This does seem really useful for debugging.

However, it's also an information disclosure in various ways. The
arguments of a program are often more sensitive than the name, and logs
have a tendency to end up in various places, such as bug reports.

An example of how this can be an issue:
- You receive an email or other message with a sensitive link to follow
- You open the link, which launches `firefox https://...`
- You continue browsing from that window
- Firefox crashes (and recovers and restarts, so you don't think
  anything of it)
- Later, you report a bug on a different piece of software, and the bug
  reporting process includes a copy of the kernel log

I am *not* saying that we shouldn't do this; it seems quite helpful.
However, I think we need to arrange to treat this as sensitive
information, similar to kptr_restrict. (It would also be helpful if
there was a way to tell `dmesg` "please give me the redacted version of
the log", and bug reporting software used that by default.)

- Josh Triplett
