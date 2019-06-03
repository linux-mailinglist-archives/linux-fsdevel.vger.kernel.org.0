Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0531333C1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfFCXtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 19:49:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56259 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbfFCXtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:49:20 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CB32C2208A;
        Mon,  3 Jun 2019 19:49:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2019 19:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Jim7BdHYS9RK8KAODKzQVSAg1fZ
        oNCKTLGYojHFLSlM=; b=n/MGNySPj2d2OHVK8uoH4PFT57rO9SEcQhHCyxP0Xog
        3YPfXBo01tfTywzzpAuJYrAPEyhHFBy2e2jwz4XyZm2lDPv7URIXl/XS0l5Tl6A7
        hc2TbiW2gF0PXDcQiYO18gJ/CORFMxMYb0YeJypwlpSSDA9KDNLBaz0enHtZE9mj
        LUNF4l/aWcpPbczXs3LvSlaaEjh4OwB7BB9l3ZHIsHMughwJQhl6bEAFyrpMtG0+
        P31zJfKP7P8kelfy4iRowZxVWvAYWk3lSm26oiPWoUBjRt32XDkJnSa15pW6YJwf
        aW57zUIrJG8Z4Hnomg8vx6WE6EJsvPkKNZsNmeE5ShQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Jim7Bd
        HYS9RK8KAODKzQVSAg1fZoNCKTLGYojHFLSlM=; b=RD9n5fuHzdInhhKTz/0l/q
        0OO+yr4axwpReb0AhNvj8yefpEf0gwD1x7IQiTCeu7OGQ3G6rtHhZXDMj8CanRSI
        BTcPuBY5flm5H0uYwjMotp9y2hQ9hc1HXW8rJjeOABsvaifHAFrYLW0+dabzTIym
        ohCnJiZHYNWpipUD8frb/fUW90XdEubCC8VdX5zweqCtHQ+uUB6zAVMLx2KPJzpn
        iR5sEOOJGEnnsri3lY8zuOdm8byJ1rGPFe1pL+KT/feK3iDKo5MySFgdqxE2HHfq
        zqJtQ/AnHh8W3ne2Gyfl0iXdthG30F3eqes8FUyiL6ovcP2gmXbJ1rUvktR2lPNQ
        ==
X-ME-Sender: <xms:_rH1XKra4TaHORNbY6PM5cilPcKjXtyz_imakGvyF5onQ5LoZ520pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefkedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvdeffedrvdeggeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:_rH1XIkXuEjKzWT4lowVRy-KT65nQGBISqeotW1tEpEawV4SCws_iA>
    <xmx:_rH1XKw51OuieiddDEwnkcn1wI6kKw8xrTxps23omkBJzMGskHkb6Q>
    <xmx:_rH1XO1qhcRN_i3qE1EDbi2O9SMDSDZba3NFKYjnhCVMnmXBSAVkFA>
    <xmx:_rH1XDI7CWQc3o6uheK_fNyD4vpzhnRUbzMzuyZbNz1Z6dNyYvGP2Q>
Received: from localhost (ppp121-44-233-244.bras2.syd2.internode.on.net [121.44.233.244])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9EC18380088;
        Mon,  3 Jun 2019 19:49:17 -0400 (EDT)
Date:   Tue, 4 Jun 2019 09:48:34 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] docs: Convert VFS doc to RST
Message-ID: <20190603234834.GB13575@eros.localdomain>
References: <20190515002913.12586-1-tobin@kernel.org>
 <20190529163052.6ce91581@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163052.6ce91581@lwn.net>
X-Mailer: Mutt 1.12.0 (2019-05-25)
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 04:30:52PM -0600, Jonathan Corbet wrote:
> On Wed, 15 May 2019 10:29:04 +1000
> "Tobin C. Harding" <tobin@kernel.org> wrote:
> 
> > Here is an updated version of the VFS doc conversion.  This series in no
> > way represents a final point for the VFS documentation rather it is a
> > small step towards getting VFS docs updated.  This series does not
> > update the content of vfs.txt, only does formatting.
> 
> I've finally gotten to this, sorry for taking so long.  Applying it to
> docs-next turned out to be a bit of a chore; there have been intervening
> changes to vfs.txt that we didn't want to lose.  But I did it.
> 
> Unfortunately, there's still a remaining issue.  You did a lot of list
> conversions like this:
> 
> > -  struct file_system_type *fs_type: describes the filesystem, partly initialized
> > +``struct file_system_type *fs_type``: describes the filesystem, partly initialized
> >  	by the specific filesystem code
> 
> but that does not render the way you would like, trust me.  You really
> want to use the list format, something like:
> 
>     ``struct file_system_type *fs_type``
> 	 describes the filesystem, partly initialized by the specific
> 	 filesystem code
> 
> There are, unfortunately, a lot of these to fix...  I bet it could be done
> with an elisp function, but I don't have time to beat my head against that
> wall right now.
> 
> Any chance you would have time to send me a followup patch fixing these
> up?  I'll keep my branch with this set for now so there's no need to
> rebase those.

Is this branch public Jon?  I'll work on top of this series but if the
branch is public then I can check it applies, save you having problems.

Cheers,
Tobin.
