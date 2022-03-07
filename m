Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB264D0082
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 14:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbiCGN4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 08:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiCGN4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:56:31 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3DD88786;
        Mon,  7 Mar 2022 05:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646661335;
        bh=5ZcRhIMVWrjtMj1k71UV4kR6JU9XVKWyXSvyLSHdp7Q=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=b49G1xWx6W2iWVGYqeJFzc3kecOtVjbIKlxHSUjIueDdUu/vmaZMSMcW/7ofjVk1g
         z7YZbrpZU1uFht6VVAzxA7dkWvi+pyhlLPfTc9Fr7AUY/alpYgxJ2Hf0R/wt8aX6e2
         vwwmThyFb/w+eBzRP3BH78ty04P4rrBahacB8/Zk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4D7901280F8B;
        Mon,  7 Mar 2022 08:55:35 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QRGc9eIIvEMu; Mon,  7 Mar 2022 08:55:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646661335;
        bh=5ZcRhIMVWrjtMj1k71UV4kR6JU9XVKWyXSvyLSHdp7Q=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=b49G1xWx6W2iWVGYqeJFzc3kecOtVjbIKlxHSUjIueDdUu/vmaZMSMcW/7ofjVk1g
         z7YZbrpZU1uFht6VVAzxA7dkWvi+pyhlLPfTc9Fr7AUY/alpYgxJ2Hf0R/wt8aX6e2
         vwwmThyFb/w+eBzRP3BH78ty04P4rrBahacB8/Zk=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 26C7D1280BC9;
        Mon,  7 Mar 2022 08:55:32 -0500 (EST)
Message-ID: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Javier =?ISO-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Matias =?ISO-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Date:   Mon, 07 Mar 2022 08:55:30 -0500
In-Reply-To: <20220305073321.5apdknpmctcvo3qj@ArmHalley.localdomain>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
         <20220304001022.GJ3927073@dread.disaster.area>
         <YiKOQM+HMZXnArKT@bombadil.infradead.org>
         <20220304224257.GN3927073@dread.disaster.area>
         <YiKY6pMczvRuEovI@bombadil.infradead.org>
         <20220305073321.5apdknpmctcvo3qj@ArmHalley.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2022-03-05 at 08:33 +0100, Javier González wrote:
[...]
> However, there is no users of ZoneFS for ZNS devices that I am aware
> of (maybe for SMR this is a different story).  The main open-source
> implementations out there for RocksDB that are being used in
> production (ZenFS and xZTL) rely on either raw zone block access or
> the generic char device in NVMe (/dev/ngXnY). This is because having
> the capability to do zone management from applications that already
> work with objects fits much better.
> 
> My point is that there is space for both ZoneFS and raw zoned block
> device. And regarding !PO2 zone sizes, my point is that this can be
> leveraged both by btrfs and this raw zone block device.

This is basically history repeating itself, though.  It's precisely the
reason why Linux acquired the raw character device: Oracle decided they
didn't want the OS abstractions in the way of fast performing direct
database access and raw devices was the way it had been done on UNIX,
so they decided it should be done on Linux as well.  There was some
legacy to this as well: because Oracle already had a raw handler they
figured it would be easy to port to Linux.

The problem Oracle had with /dev/raw is that they then have to manage
device discovery and partitioning as well.  It sort of worked on UNIX
when you didn't have too many disks and the discover order was
deterministic.  It began to fail as disks became storage networks.  In
the end, when O_DIRECT was proposed, Oracle eventually saw that using
it on files allowed for much better managed access and the raw driver
fell into disuse and was (finally) removed last year.

What you're proposing above is to repeat the /dev/raw experiment for
equivalent input reasons but expecting different outcomes ... Einstein
has already ruled on that one.

James



