Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7363ACA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 03:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfFJBMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jun 2019 21:12:03 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43221 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbfFJBMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jun 2019 21:12:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D905444A;
        Sun,  9 Jun 2019 21:12:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 09 Jun 2019 21:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=fe120Davi0T3Sjl5YLfPWyocg7C
        ao7t/LQjsjCRH0lU=; b=d6t8jFSZevacgPIZUzoP50IQXqsA55IR0OudGjTn3lm
        hDUlRxV/3cdMiN4nLp5Z967BrAUt5Ud3jcA7VKV4lx1eBuAHiChgHM4+To+OoSON
        r5b0ANqXHUGHxokQskqp9lFjIzn4wcEXdg5P/JSkAr3CqaoR6I94RTg2y7/oEr/i
        Ai0G7tfZEsSIJId3QuZYdosvqpeK7VK1uYj2wbGW/xMGA4JAuoaVYAuUuK0rQruD
        UxwU1d2NmigbgLJk2r5FHiZFck/h/yIhcrw2DWhIzO2/NE+P69n8A+Cq/fyg9+WZ
        LTnwwr3c1EJ8VnbJH9wwcXQBqqgXHbrSJzM9j17CzPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fe120D
        avi0T3Sjl5YLfPWyocg7Cao7t/LQjsjCRH0lU=; b=H1IZduQRvo0WIm/CU1Mz/i
        7BudZwbDvx5M7oJe7sPwy9IY4kvjH/4aJPXE2+tGoZBkqN2pTN8TuozXtrcmgZDC
        Nv/pvNwJP7fnu0mwjkL7+B3o0Tm3Wa9apgkUybGxqMURUppPrGBTM5PPTeJmWmDT
        mCbMbMviuT0MOTrSQe49JPSG/u8mnmgNvD5niaFTOaT2bxYZg8GaaO0dXpJv4jDK
        VoBdoBpTr/cCzzsuvH78W6sOh3jGYm90UfeVfLUvgTDMwp7QYNchdjTL11PbcFe3
        i+0zOR2kxHfDVs/620EyZrWlu98muHaWDD+0MZmuO+b0TBwsnQyVe9Bi6cCJARHw
        ==
X-ME-Sender: <xms:YK79XNTKxStsUgsqyZBtk-QZzbz5HitfbyVxpCW6Qf5aRlKFiVwBPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudehuddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppedvuddtrddvfedrfedrleenucfrrghrrghmpehmrghilhhf
    rhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:YK79XAmZQVccUpEAxclDJ-hf66vneQBtvQIiY88vdg7TheWrGXY-Sg>
    <xmx:YK79XPbGGQWeuyPHG9hZccOyz3dudVlQJSpP9OSa6eodnt-3VZaVgw>
    <xmx:YK79XCY1yyvMDSgBSOuqEzdQTfpTQB-qZzeD26N38MOJ-c6SbT2osg>
    <xmx:Ya79XI18SokR_XETjHXhVy01npYJIOJ8i5qlPvo1WqHwx4wmPMHbUw>
Received: from localhost (unknown [210.23.3.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52E768005C;
        Sun,  9 Jun 2019 21:11:59 -0400 (EDT)
Date:   Mon, 10 Jun 2019 11:11:55 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: vfs: Render method descriptions
Message-ID: <20190610011155.GB2469@caerus>
References: <20190604002656.30925-1-tobin@kernel.org>
 <20190606094628.0e8775f7@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606094628.0e8775f7@lwn.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 09:46:28AM -0600, Jonathan Corbet wrote:
> On Tue,  4 Jun 2019 10:26:56 +1000
> "Tobin C. Harding" <tobin@kernel.org> wrote:
> 
> > Currently vfs.rst does not render well into HTML the method descriptions
> > for VFS data structures.  We can improve the HTML output by putting the
> > description string on a new line following the method name.
> > 
> > Suggested-by: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> > 
> > Jon,
> > 
> > As discussed on LKML; this patch applies on top of the series
> > 
> > 	[PATCH v4 0/9] docs: Convert VFS doc to RST
> > 
> > If it does not apply cleanly to your branch please feel free to ask me
> > to fix it.
> 
> There was one merge conflict, but nothing too serious.  I've applied it,
> and things look a lot better - thanks!

Awesome, cheers mate.

	Tobin
