Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64BC7BF0FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 04:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441906AbjJJCfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 22:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441891AbjJJCfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:35:21 -0400
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8603EA4
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 19:35:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7B66C9016E5
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 02:35:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1C92A901925
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 02:35:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696905318; a=rsa-sha256;
        cv=none;
        b=WoUEhC7HaMKXTOHUpKZfjr8o0ihPE7I8ckkbIxNs8ZnhFxu8Betcrl6vxsRnilA8WtGGnC
        /A9op85w1zDb+y6tx5sX/Wcnf66keQaf9KJWmjK72GyxHe5qo8weNhqJuQ5Ykj1N4wK+oz
        OmT9SsXci3i3QKDMNvrL8wVl7UI7fxASPgvjfCUgpCXniSQnDuZMQSxMW+TdB+mOKYAKKE
        3EJw6+alfnEa6XR/aIPo23TpK8KTRottky5R+foEFhN/zfeF4wopN17HgerzPTb4Mnz1co
        deT5l1G+GteSzZn9hGWI4Yd5x5QpxRCoWae5by/mrTZDevp8Gl03Iwzpyq/Lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696905318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=1JVOiXTXOZdbi2lb57a4eTH6VFOz8zWW7VpahK0e+lI=;
        b=NrJdzve6TmjWpdk6NoGnSPnYyNf+H7EprkdnyQVn+6PoAViVu7IBFSdtw4C9YZ1wMcrUXK
        zbXcEIO1Clq7IH2qmDCW+eEqUWkanf7lqB1LBBTEBjFBR408+bVZDoFNy112ypGnV7F29q
        amO6l0m4XfhqRLUZxlrw/Hr1KABjwxf5H9pSZGuwTs0pqtw0OzGvEIFDcVwkq94lFeLAVh
        Kbbwr39ss2nKG13J/yXTl9Ib+rdgdzQ6IQwC/PS0Okk79La4kidJlSfXKrMTboMYQIfOdN
        gxSnzuVzJTZLH1j/Gd8DOIeDGzi33X6CwYcVGTKLKkcwOFImmEw7Dmek/6dBig==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-n4jpv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Soft: 0e0d3ebd149463da_1696905318328_1766937770
X-MC-Loop-Signature: 1696905318328:841988970
X-MC-Ingress-Time: 1696905318328
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.41.173 (trex/6.9.1);
        Tue, 10 Oct 2023 02:35:18 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4S4KkY2fxGz10m
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 19:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1696905317;
        bh=1JVOiXTXOZdbi2lb57a4eTH6VFOz8zWW7VpahK0e+lI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Nokg/ZsKA47dB1+MZhw8eHTIA0xzSOvIGoHWMdSozdnUnX+7DceMMaKgdjlAVTK1c
         nj54Z+kS0EpzvLFBp5hb2FlGOXiebgCK8HnvwRA8H0UknkqOtTzlCkQwKSuwK1C8BN
         tNVlbt/fXXvCkQRTwaH3RWb1Ys9LCpe2+NOvlm5mwbedJLjY3KL24nsA2pwML30eZZ
         45cQqrAVEABS3n0FWulSbKp/olZmtNDssWAf0GKKxgcgWErMVMuTF9SEIqYptDKFL3
         1QU5HbKgIjXuuHWeCHJKARrJ7qqI9Pa74O0/eyN6XDcB43HJd6YzxC2W1fqLKmtez5
         50Ip4+IoewrXQ==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00f8
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 09 Oct 2023 19:35:12 -0700
Date:   Mon, 9 Oct 2023 19:35:12 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their
 parent
Message-ID: <20231010023512.GB1983@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <3187f942-dcf0-4b2f-a106-0eb5d5a33949@fastmail.fm>
 <20231007004107.GA1967@templeofstupid.com>
 <968148ad-787e-4ccb-9d84-f32b5da88517@fastmail.fm>
 <20231009171525.GA1973@templeofstupid.com>
 <f5a431f8-fad9-4b1b-a3ae-86b6cff65b9b@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a431f8-fad9-4b1b-a3ae-86b6cff65b9b@fastmail.fm>
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

On Mon, Oct 09, 2023 at 08:43:02PM +0200, Bernd Schubert wrote:
> On 10/9/23 19:15, Krister Johansen wrote:
> > Thanks, I had forgotten that d_make_root() would call iput() for me if
> > d_alloc_anon() fails.  Let me restate this to suggest that I account the
> > nlookup to the parent if fuse_dentry_revalidate_lookup() or fuse_iget()
> > fail instead.  Does that sound right?
> 
> Hmm, so server/daemon side uses the lookup count to have an inode reference
> - are you sure that parent is the right inode for the forget call? And what
> is the probability for such failures? I.e. is that performance critical?
> Wouldn't be much simpler and clearer to just avoid and doubt and to send an
> immediate forget?

Yeah, the server / daemon side need to track the lookup count so that it
knows when it can close the fd for the file on the server-side. (At
least for virtiofsd, anyway.).

The reason I had avoided doing the forget in the submount code is that
it needs a forget linkage in order to call fuse_queue_forget().  One of
these is allocated by fuse_alloc_inode().  A well formed parent should
always have one.  However, if the fuse_iget() for the submount root
fails, then there's no linkage to borrow from the new inode.  The code
could always call fuse_alloc_forget() directly, like is done elsewhere.
I thought it might be hard to get the memory for this allocation if
fuse_iget() also can't allocate enough, but I could move the allocation
earlier in the function and just free it if it's not used.

I'm not confident that would reduce the amount of code in the function,
but if you'd find it clearer, I'm happy to modify it accordingly.

-K
