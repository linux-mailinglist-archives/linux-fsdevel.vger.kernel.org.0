Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A43A4BC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 02:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFLApX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 20:45:23 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56769 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229584AbhFLApW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:45:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4AED0580932;
        Fri, 11 Jun 2021 20:43:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 11 Jun 2021 20:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        FxEV9iata6R86LklafTZvkJMZtuSkpOtZknlBZ5CHkc=; b=rrFAnW00dEQ00Mg6
        AkIrxeBA63am+tsme2lHFhTchg7ZTuO0VBjVWuQ2yVoAFGvaBzUOwLsbCsi6kPtI
        KySqME5ycW1V5nS4hznOZJTO3n1+UwpIWT/SzEEuW10qXt/C7OmXICBB1Dv239Wo
        wuwolmaNbbbpnHLZggEOu/OdxnCZpCFWLLY4jhTtCMz99TfD7nxDjJhn1ehUf00d
        npy5Dd3RTU55o9rsTsuaUakK//AgVhM9BFQCowfmNtVwqXzqaBy5VIp/LzYOvlPW
        IMsce+ePeKEt7FiVpjxfNyxFQQvWmQQ40kRhPoyBk4Iyyzgd5hnzp3KsFmXwLTS4
        FrlBrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=FxEV9iata6R86LklafTZvkJMZtuSkpOtZknlBZ5CH
        kc=; b=USsl5TdGjX14fRPAXNWPO+81QkDcJbdV65io9DbEBomP2PwVC5Q25ke6I
        CwAH1Cd7nvP3Rf4MUZbd0pdLv8Z8OZRUWgXI+6YVIuo70bSG7o0zUD1EfVdcIqcS
        kmNVL5ja3TCoYz1Rt4iLrqYvn5b5TU14wGIBFM0NmNhPQ671Z5Znx6A2ifxID+U+
        l0+aD4xWYqT6Z+vfQj+4IdGEi/8EEaTBiH740zcp3sbGAriTcvEVJVohxdQFQGU3
        bONj3E4TEp2BKLyj1YeicFNhDSwHCT3NDSjfR9/jHVtJuzUj51cDNa3T+XN40Hlo
        gQSSzt8zjsmxY+IHfxOw50LmJ06yg==
X-ME-Sender: <xms:KgPEYPfib8foW0jS6tXGBZK5NDwm05xsEf2NUSJAwQy7DpGXnIHVhg>
    <xme:KgPEYFOpNyYi428fwNq5zHiPeB1sJnj_UcPNAyREZ4nnCtmmVWsQNQuPxcAxDVQ9L
    0MAKpVexCy9>
X-ME-Received: <xmr:KgPEYIgCuFGa6gMwWdENOayoi990kQdYBieY2fxH8YxShkJfhXoAGA6Ahw8HWXBHmVh2eexd-Aq1w8lM6dBQuQuLCSdp3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduledgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:KgPEYA-w4qfdMghNDtfVpaVIfXK3Fqqc4MrHyPre-r_dY3g2UTslBA>
    <xmx:KgPEYLs0yrGDeciehE-6XVInogNP4LDmUQMgKHfIbmJ6KDp6HJzUIA>
    <xmx:KgPEYPERw6XH4X6n7mt4cWB8a8BBHJ6e5rNNYTwzLhe5kPXRRdFYEw>
    <xmx:KwPEYPGCdVxZm6fTnr0KX65ERJCehwJfm_2bYPj7hBQKxlIi2eLHJA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jun 2021 20:43:17 -0400 (EDT)
Message-ID: <2ee74cbed729d66a38a5c7de9c4608d02fb89f26.camel@themaw.net>
Subject: Re: [PATCH v6 3/7] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 12 Jun 2021 08:43:13 +0800
In-Reply-To: <YMP6topegaTXGNgC@zeniv-ca.linux.org.uk>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
         <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
         <YMP6topegaTXGNgC@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-06-12 at 00:07 +0000, Al Viro wrote:
> On Wed, Jun 09, 2021 at 04:50:27PM +0800, Ian Kent wrote:
> 
> > +       if (d_really_is_negative(dentry)) {
> > +               struct dentry *d_parent = dget_parent(dentry);
> > +               struct kernfs_node *parent;
> 
> What the hell is dget_parent() for?  You don't do anything blocking
> here, so why not simply grab dentry->d_lock - that'll stabilize
> the value of ->d_parent just fine.  Just don't forget to drop the
> lock before returning and that's it...

Thanks Al, I'll change it.

> 
> > +               /* If the kernfs parent node has changed discard
> > and
> > +                * proceed to ->lookup.
> > +                */
> > +               parent = kernfs_dentry_node(d_parent);
> > +               if (parent) {
> > +                       if (kernfs_dir_changed(parent, dentry)) {
> > +                               dput(d_parent);
> > +                               return 0;
> > +                       }
> > +               }
> > +               dput(d_parent);
> > +
> > +               /* The kernfs node doesn't exist, leave the dentry
> > +                * negative and return success.
> > +                */
> > +               return 1;
> > +       }


