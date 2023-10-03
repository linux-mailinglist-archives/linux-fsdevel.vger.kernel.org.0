Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122A97B6EEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjJCQsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjJCQse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:48:34 -0400
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69FB9E
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 09:48:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3F248902A02
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 16:48:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D106C902279
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 16:48:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696351709; a=rsa-sha256;
        cv=none;
        b=q8GeZF+Q52MeyLqF7CMCT/rBAhby5D5F/GpWVdpm4YKf7xSo0h+STo6YC4+us0vw7a5l/q
        z3L9UwDwCQa6sJegBdxZ+Wg9w8Wq9BdGfc3aV4R/l1phKRZY1+g30El/GsXrD2J8rp7Hc9
        HuZncjTwP3GMn9cWfpBrh1FJsUlS/YES1zs80NM9a2fpVXrIvULl2b9SzRYbiUspztjw1t
        gUur4NMatsiUvV94PVPaAPO1aVYP5X3JwgUOsAz0GfU9uso80e8VG6RFePVVKE7FQTvQ06
        ZPA1UnV3uVPRJ1uoR3g+21yzWHgBukZml+rYSl2y+NQhq6sHT4XMBUYj5y2zbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696351709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=8ZwN54k0AS1FkbT6I9f/xqRXKZcXC1uk6boyOe63Xlo=;
        b=BnXh4JMzJrnXvTWptuzyGqfkDJpGM7WJUma7/PJE0JSTKWFTWtZxKFGkgDkeeUoaL1yI61
        aLZ8reBGPQbpNE58YEDsZiHVfnMUzGZORueUsECSWPt+9lqL9JlOzhKYpta2P1YcXOgh47
        oLfcbxj99sCgyWpXJv39azQM0JRNUeOB2BxATAKp7Q5TTzEq+S6xLz1KNRvUPZWkfohoKm
        rgbF9GYtIH+9Usyfl44sakv7jDIBxUSfqQd317y7odoeSAiXHEcn6VcUQrAG+cu5HpfXcR
        wXOcH3ABFnkUK4umvKK9lAjlEulp6b9m57pbK+mNQptcDOnrSPuBlyKPe2dJcQ==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-cwg48;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Ski-Trade: 298f47f17fda8e8c_1696351710098_3267056340
X-MC-Loop-Signature: 1696351710098:4227708804
X-MC-Ingress-Time: 1696351710098
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.191.212 (trex/6.9.1);
        Tue, 03 Oct 2023 16:48:30 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4S0P0F1DQ0z13k
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1696351709;
        bh=8ZwN54k0AS1FkbT6I9f/xqRXKZcXC1uk6boyOe63Xlo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=KZUXVBMeU78Ql0RidjXDN6sORrm3YqQgFoqhG2qSi67vKhjLcQduX5wsLRzPkBAQx
         AnBdWErcB2ZF2o5AFRFJkDuq9Zxc64nzdstP9sAHd80JX9CW2kLBM62bEuJvhw2tPd
         ZreImF4IFaVzRalCiTRHHgq8JhpMm1sZn4megmKX/l/tIvvsk8ai9WHdA3Lew9asb/
         AnDZjlw+nj1VMu0vj0smQfZdclqelch7TtJdlDxdnaRsxPbft5SI2A72d7sBFYAtx9
         t3VoMVg7OBFERy+qwGopqnypp+9Yyi+L7iCPrltcq3FHDPlFxS4BcNtKZYkM2w7R2x
         j1nuzj9tcx23Q==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00c8
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 03 Oct 2023 09:48:23 -0700
Date:   Tue, 3 Oct 2023 09:48:23 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: Re: [resend PATCH v2 0/2] virtiofs submounts that are still in use
 forgotten by shrinker
Message-ID: <20231003164823.GA1995@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <97163cdf-ab2c-4fb8-abf2-738a4680c47f@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97163cdf-ab2c-4fb8-abf2-738a4680c47f@fastmail.fm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 12:18:42AM +0200, Bernd Schubert wrote:
> 
> 
> On 10/2/23 17:24, Krister Johansen wrote:
> > Hi,
> > I recently ran into a situation where a virtiofs client began
> > encountering EBADF after the client / guest system had an OOM.  After
> > reproducing the issue and debugging, the problem is caused by a
> > virtiofsd submount having the nodeid of its root dentry fogotten.  This
> > occurs because it borrows the reference for this dentry from the parent
> > that is passed into the function.
> 
> 
> Sorry, I didn't forget you, just didn't manage to review the 2nd version
> yet. Will definitely do this week.

Thanks; I appreciate the feedback you've provided so far.

> Please also note that there will be merge conflicts with atomic open patches
> from Dharmendra/me. Although probably not too difficult to resolve.

Sure. I'm happy to reparent, resolve those conflicts, re-test, and send
another revision when we're ready.  I suspect there are going to be
additional changes requested on the v2.  With that in mind, I'll hold
off for the moment unless it is going to cause headaches for you.

For the atomic-open-revalidate changes: should I be working from what's
on the list?  This is the most recent patchset I see:

https://lore.kernel.org/linux-fsdevel/20230920173445.3943581-1-bschubert@ddn.com/

I found a 6.5 relative tree of yours on GitHub by following the libfuse
pull request, but nothing that seemed in sync with fuse/for-next.

Thanks,

-K
