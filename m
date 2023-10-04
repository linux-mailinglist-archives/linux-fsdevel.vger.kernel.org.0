Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F917B817F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242705AbjJDN6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 09:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjJDN6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:58:24 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19AEA1
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 06:58:20 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EBECF761D6E
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 13:58:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BB43E7615FA
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 13:58:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696427898; a=rsa-sha256;
        cv=none;
        b=b47w0uikzKD5aXNEAoF1erdxGTzPbkGJgB2+PpwZ99CccHK/9+Gx6GZ31DkjBK1qmt6eLq
        YJnk7mN9qgz2xaGFLs8nwusJ9kjV8+fsTKHWYXjGPfNKyrcVkrclnRgnXfV17SGt2pPT8+
        4gebbs+p2wftTqPj3gwtSnTCRFjTEyDGWXy/fPSfnOGlHVNvIQ7Iy9y1H6AQPEareD8nOO
        qEF9q1XUrCaQ/2sRChxve+S7xEqqOf15jljZY0NmIDki6HapXP8QTi/GYY0UuuvKpFm7Et
        3L8OdSMxpp0wiif50viDYT6xRgrSHlBDwNF8/qJnlfn4IBiUpMDL9Bs73rLhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696427898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=kADOC6162V5NCcVVMP9gX8MPZmEiYTw9JdB0/cprF7Y=;
        b=RSISFzoQ5bLYA/xdH9kUUGYMzPT3j4D92p0Wj0rhl3rTGgbZzcOmnF1mVHd6SWDpwqEZdB
        E83ZFOhkHIczoxNuUF+41JUOMpMyobShl3mbBsCUh9mAPBOWcrhQpm+tpeyJklY24591fR
        Z6gCPeYOHvpsvpn0Iuaz/dvJ8/1KcQ3T3ToakLPGgATPoEe6q0ytv+yNCtGYL5qQ5U6qVO
        rWH7Wcbn/xjbapE4FO3qcDnP/Fcf5fUYgNUxHcAhV2ba8iqZH4NhtFTEM/G8ClUOSVj5up
        W6E4FS5JaehQ6IYTnTTCvEtGJaRbsQFr8EGvhNNYhYhT1RbsBFD8xsaMR7TmPA==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-l6jz7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Army-Battle: 08040f361998cecc_1696427899772_2181876005
X-MC-Loop-Signature: 1696427899772:3185551450
X-MC-Ingress-Time: 1696427899772
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.159.71 (trex/6.9.1);
        Wed, 04 Oct 2023 13:58:19 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4S0x9Q3H6Hz4B
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1696427898;
        bh=kADOC6162V5NCcVVMP9gX8MPZmEiYTw9JdB0/cprF7Y=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=S4fhHYhp4gEL1RaIuHV620uZhsqzqrdJ3GIwlu1drzYjj3/Gk11iIEAxgaXaA3b9f
         G9NYQrPshq+55QGsCTzfTIq+tNy1xiy/ack0oQmG4W67wXxrB5+43ucl3kWLYR41ls
         hajJToc9PfyqC51ALG966BHGInqgfy3II0J8l9Wu3K2aY1OxPSUWW8vqcCnMEvAoFi
         GLxvgyAU3USAjr1Wtv+96wlGCbsjqVqd914kOdKToLji30kqT9ZnNTwHFDudc5VL/F
         HDRgKYtzcjkUVDWajFR9Ry6qXeHE9MB1tiAnNKcED6XYqn2xFNm/svNzScw13npuss
         DSo/uUFVDbWXQ==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0100
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 04 Oct 2023 06:58:14 -0700
Date:   Wed, 4 Oct 2023 06:58:14 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: Re: [resend PATCH v2 0/2] virtiofs submounts that are still in use
 forgotten by shrinker
Message-ID: <20231004135814.GA2051@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <97163cdf-ab2c-4fb8-abf2-738a4680c47f@fastmail.fm>
 <20231003164823.GA1995@templeofstupid.com>
 <18552fc7-184c-4bc7-9154-c885fae06d31@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18552fc7-184c-4bc7-9154-c885fae06d31@fastmail.fm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 04, 2023 at 12:54:49AM +0200, Bernd Schubert wrote:
> 
> 
> On 10/3/23 18:48, Krister Johansen wrote:
> > On Tue, Oct 03, 2023 at 12:18:42AM +0200, Bernd Schubert wrote:
> > > 
> > > 
> > > On 10/2/23 17:24, Krister Johansen wrote:
> > > > Hi,
> > > > I recently ran into a situation where a virtiofs client began
> > > > encountering EBADF after the client / guest system had an OOM.  After
> > > > reproducing the issue and debugging, the problem is caused by a
> > > > virtiofsd submount having the nodeid of its root dentry fogotten.  This
> > > > occurs because it borrows the reference for this dentry from the parent
> > > > that is passed into the function.
> > > 
> > > Please also note that there will be merge conflicts with atomic open patches
> > > from Dharmendra/me. Although probably not too difficult to resolve.
> > 
> > Sure. I'm happy to reparent, resolve those conflicts, re-test, and send
> > another revision when we're ready.  I suspect there are going to be
> > additional changes requested on the v2.  With that in mind, I'll hold
> > off for the moment unless it is going to cause headaches for you.
> 
> I certainly also didn't mean that you should check for merge conflicts, it
> was more an annotation that it might come up - depending on the merge order.
> Please don't stop to do improvements, resolving merge conflicts shouldn't be
> difficult.
> I'm going to add you to the atomic open patch series to keep you updated, if
> you don't mind.

Thanks, no objections from me.  I'm willing to help with any conflict
resolution or retesting tasks, if anything turns out to be non-trivial.
My goal is to get these patches to the state where they're acceptable.
I'm happy to make additional changes, or work against a different
branch.


-K
