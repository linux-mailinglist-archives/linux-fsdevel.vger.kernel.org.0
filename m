Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A54AD33C56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 02:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfFDAHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 20:07:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34533 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfFDAHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 20:07:15 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 577242226D;
        Mon,  3 Jun 2019 20:07:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 03 Jun 2019 20:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=EN4T2pbClCMyoiYhMs2a/McIgLH
        XpYnfzzLo8H03ZDU=; b=FsY5axEOzebsP3UUQlR6D2B+6dzE/Bw3N8eXYS0JEa2
        MvxyCxMNudMU5DsV6pqHeMacej8+1sLLsOnPwL0R2Wrexdh72TfS6P7hZtAzEtfM
        jpIO2pOuoAagYOamYfsD8/McGhbDuLKFw0jnF9ZH0zh3E2oCGcDUfo1XWNT7H8Gr
        t5pC0TEB/1uYYAmQKe8LIXVFFSVKPKGfr5Zsl8UxyIRSyckcUNmtEy8srMqj78sX
        OIopNde3Cszszxqpx1D+AruO4lZ++O883jEuai7wv8uWiScm9Z6XJbvbDorn1B95
        iAk+JH5IuPE2mzY0QFzDLeS7mnG70MwTVkit497/2CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EN4T2p
        bClCMyoiYhMs2a/McIgLHXpYnfzzLo8H03ZDU=; b=Zf3zWqtiUfLVdN4aqeqUOl
        Om6hXruGxzy6hwhMcXNDgjgmv11zu34J7NO1ozdQ/7+fSNFUTqHbB20ACZJxuCMN
        9f1meig9O0Q506V31mBX8bKcuLlarNV+sxzvnFQaG129R0awEJMw+mG8VBZqK4pv
        LH7LsAHt+7QCJywj/1BI8Frg0GTs8UsEpInbQ7p7VqXacYZNZC20DBRJ8QENqcry
        RhlUWMgr44ZHKjUo/m7j1FnCxU8NO3HGFzTXKmIl/R/NcqRMuubNR4ygr8ZoE4QX
        x8pUdGwqxgwrdzbvOmGhqxlFrzyW3zGqts//dQ6xkAXgRNFVi+nP1lSdWNJqvH3w
        ==
X-ME-Sender: <xms:Mbb1XOHjdFB9m2D3HOK1DR9CGrcc33WaPS8nrCBm1RYyzIY7rgnwgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefkedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvdeffedrvdeggeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Mbb1XLmHA4z56axMCyDnaPbHYhun95pOlzX4HUyC4dCmY1hZa8InFw>
    <xmx:Mbb1XOa9lCNqpJ8XybNZf5-5Lx5Kdj8GEGkltnr073ip02CB0FkymA>
    <xmx:Mbb1XFsgrap7H5cUlWvSpOGvZfLOTnuyrf1-K-56yFQsRnHSwqKBRg>
    <xmx:Mrb1XHBIW5oE_Fa8juiYI2lwONwHo7v5VWlcdrUA69SetBDnBIbz8w>
Received: from localhost (ppp121-44-233-244.bras2.syd2.internode.on.net [121.44.233.244])
        by mail.messagingengine.com (Postfix) with ESMTPA id AAAF680059;
        Mon,  3 Jun 2019 20:07:12 -0400 (EDT)
Date:   Tue, 4 Jun 2019 10:06:30 +1000
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
Message-ID: <20190604000630.GD13575@eros.localdomain>
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

I was doubting you at first, this renders **way** better :)


	Tobin
