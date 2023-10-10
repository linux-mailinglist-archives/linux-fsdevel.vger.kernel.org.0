Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32F37BF10D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 04:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441928AbjJJCol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 22:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441879AbjJJCok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:44:40 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70339E
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 19:44:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DB9C4C0BCF
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 02:35:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 79DC5C01EA
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 02:35:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696905313; a=rsa-sha256;
        cv=none;
        b=1CuQQthUo5lhf10/eAERvO/EEmo03eJVjTe8IYyhNuQ9mAM8VMygoyUSg48H3h/2bCgaS+
        eVfjz9+jjz+Dw5rGwfboX3+CHm10QvTwGd5a/61m0zhaJO5Fp3Ins/5lXFzKah1DmfumGQ
        YxDJxcISF3b1wpM6T/YZ+6ma2DDx1JVv+vZEUDqvdS4cqxPMI69TE49t4vrUq0XTYra2y7
        AwhvMGJkBsEPY36L8v66hwZW/r3p6BORQIv3Cqz3Gbknrvny5dQjGGt+W9f4ojoDTbHEkX
        VKfEe2VHwu71r17/4yhEDcrVDB1LinSxwOnWkJFpgTqEWVJGT4y4OGdH042RSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696905313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=xyZKQenYRQfPV3HkbW0HMcmJoCLR1EYq/kl2VTJ5kGY=;
        b=a2oYYmHtoqPcLgATnV/WBdpQ4fsOm2YV6xD7ycfh4T3JzbJUTocrgGjPLGj4N4F98jcST5
        tlZU/fFqqMs9N3I/q97D9FoJEM2BQ33/wTPYpin4yjW+VDwds7CbScWKwcMdfgRprUbiWv
        FoiAWAEGrZLEwSWWO554MrN9KPMVGwWbtGR4naeZPJNLLkV81wAi3ghVpdOttLBmUfEdvB
        9Jeq4H9G5LOYUoaL7p4ba4oNC2kiXtzAMZc/BQCGLk1t0eWaG2sO/sW8BN7Bf0SsosKbqH
        jZecZEIAVIbwYTZ5IvN5a5cFtO3CIZ3UDjs7LLQSnNMpa1H5chy0jSh9G1yDGg==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-fbs8v;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Society: 038cbec90c1fd270_1696905313723_559050958
X-MC-Loop-Signature: 1696905313723:194828367
X-MC-Ingress-Time: 1696905313723
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.167.74 (trex/6.9.1);
        Tue, 10 Oct 2023 02:35:13 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4S4KkS3QGZz121
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 19:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1696905312;
        bh=xyZKQenYRQfPV3HkbW0HMcmJoCLR1EYq/kl2VTJ5kGY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Gz4+YCPH8gWGbdsM5tW0e1zMNSYkCKT6kf8n6zqZnYmweLdaS86uPIAR+JrR9NKgO
         PfLmqzeQ29F9aDxc68PbeQU1E8oXcEOv8HTTm2cHcl6kbrii1Dc2u+wBzuo6aWY5nc
         CufqboT88NPUgsh4LWok1gtPGyYM6EAw6TgC+Mxa18fhPmMPzhliDxK3KAoDCEBZXM
         Pp0a5kZAu2h9NM05eJ8awzfLe8aG7YNeNeD6tiJnT2RRHk1VlETOnb5U1ysRTnHBkE
         GuuJNCCCQ+x3CKOpg4YGaEmmjpPq+TkJqQlH9PMcetoppc9Z6dzug7y1YkeqB40WZJ
         ND/xiBJkSNpRA==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00f8
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 09 Oct 2023 19:35:07 -0700
Date:   Mon, 9 Oct 2023 19:35:07 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their
 parent
Message-ID: <20231010023507.GA1983@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:45:08PM +0200, Miklos Szeredi wrote:
> On Mon, 2 Oct 2023 at 17:24, Krister Johansen <kjlx@templeofstupid.com> wrote:
> >
> > The submount code uses the parent nodeid passed into the function in
> > order to create the root dentry for the new submount.  This nodeid does
> > not get its remote reference count incremented by a lookup option.
> >
> > If the parent inode is evicted from its superblock, due to memory
> > pressure for example, it can result in a forget opertation being sent to
> > the server.  Should this nodeid be forgotten while it is still in use in
> > a submount, users of the submount get an error from the server on any
> > subsequent access.  In the author's case, this was an EBADF on all
> > subsequent operations that needed to reference the root.
> >
> > Debugging the problem revealed that the dentry shrinker triggered a forget
> > after killing the dentry with the last reference, despite the root
> > dentry in another superblock still using the nodeid.
> 
> There's some context missing here.  There are two dentries: a mount
> point in the parent mount and the root of the submount.
> 
> The server indicates that the looked up inode is a submount using
> FUSE_ATTR_SUBMOUNT.  Then AFAICS the following happens:
> 
>  1) the mountpoint dentry is created with nlookup = 1.  The
> S_AUTOMOUNT flag is set on the mountpoint inode.
> 
>  2) the lookup code sees S_AUTOMOUNT and triggers the submount
> operation, which sets up the new super_block and the root dentry with
> the user supplied nodeid and with nlookup = 0 (because it wasn't
> actually looked up).
> 
> How the automount gets torn down is another story.  You say that the
> mount point gets evicted due to memory pressure.  But it can't get
> evicted while the submount is attached.  So the submount must first
> get detached, and then the mount point can be reclaimed.   The
> question is:  how does the submount gets detached.  Do you have an
> idea?

Apologies for not stating this clearly.  The use case is a container
running in a VM, and the container's root is provided to the guest via
virtiofs.  I believe the submount is getting detached as part of the
container setup, either via a umount2(MNT_DETACH) of the old root
filesystem, or as part of pivot_root() itself.  By the time I'm able to
inspect the dentry associated with the submount in the initial mount ns
(case #1) its d_lockref.count is 0, and /proc/mountinfo doesn't show an
active mount for the submount in that mount namespace.

If I manually traverse the path to the submount via something like cd
and ls from the initial mount namespace, it'll stay referenced until I
run a umount for the automounted path.  I'm reasonably sure it's the
container setup that's causing the detaching.

I'm happy to go debug this some more, though, if you're skeptical of the
explanation.

-K
