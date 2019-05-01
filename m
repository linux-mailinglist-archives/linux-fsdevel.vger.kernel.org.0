Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F3910478
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 06:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfEAEVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 00:21:21 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57477 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbfEAEVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 00:21:20 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 May 2019 00:21:20 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2E8CD36F;
        Wed,  1 May 2019 00:15:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 May 2019 00:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=tPTIwsSH/Mbsu/RozuiLKuxTxTv
        dQ6Dz+jLYGeUDbEc=; b=RWfTuU1ThtWbOAfggQ+Cy1ZXh8FbeACE9rOQQP4p5F2
        7hi2Mbetp/495yeu3f3/zBbUrfXVBgQYEsmFa9yAm8Cp7rntoDwuYhiIZpNmW8Fo
        m4ajdoRj1lY4l6Du6HDEGzS0MdWIhNe8ZKOzTr9Y50/DGoSwLY/i7ij/atHEOwYV
        AmFVDiUjz6N4JL5tfFmlGcpusG14AUoHFprjxLYuALg/0nicvVCaaoRpLd6BV3BO
        JAnQAllthpHstXPcXRaxJvMzj23CCIir7c8gI6IQfVBtYBKmt+m5r9DRX2urokF5
        GBXl52Z2VDVPBPAolsEO4A+aXNgvJFJa1DNwVt9dVZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tPTIws
        SH/Mbsu/RozuiLKuxTxTvdQ6Dz+jLYGeUDbEc=; b=r1QvKvFfklPNUDYbWivobf
        DyXZwydG8juKogd/TJDnvyUfrcW2g6OmxppsIV8APJdDpkuU43PTXagjQ5510gBp
        Ebd5ejY8MlTdzuNM1sWZXJgCTxYsnRXPrk85uYfpHgCS0KB/S+NtBwmGs5jsAkF8
        1w+vcDI5WY15n0RpBw7k0cQzbY9xRvyCcKNEOk0jYcjV0OMqlZPFjo5xwTk746vO
        dpgLrIMddSCz1Pe7IIxQ+9Tbc9irCklnsJwptLqFIknd+Qmel2NdSzqBqJGcHugJ
        DtDm6fpySN72LilpMWbg+/z7RUeVUtyduhO/E80bCSdppRm9E0q3452e5JDiFyNQ
        ==
X-ME-Sender: <xms:dh3JXARFYydSOQUl4VTovDGOEivFOGESOIfR7ZC_INdglfyl2BTHTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieeigdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvuddrgeegrddvtdegrddvfeehnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:dh3JXNfPfUPD_iHcOIjTAjshctx_5sTL51s6DxgsJxJ01LTcYTyw5g>
    <xmx:dh3JXIruWiTPegQwJvWLMAV7omuYj-m2pP7srMwqSwLERiuHHG46pw>
    <xmx:dh3JXGdIkN4uU1Y4W2DzGEgg9jOHcyjAAP8zn5w5c7IAP2r34eNTpQ>
    <xmx:dh3JXLDt-erbuL4s6BXbmJe0MW36QrSA_X_XNbLbP237l2Vlk_WnPA>
Received: from localhost (ppp121-44-204-235.bras1.syd2.internode.on.net [121.44.204.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 87E2F103CB;
        Wed,  1 May 2019 00:15:49 -0400 (EDT)
Date:   Wed, 1 May 2019 14:15:15 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH 0/4] vfs: update ->get_link() related documentation
Message-ID: <20190501041515.GA9149@eros.localdomain>
References: <20190411231630.50177-1-ebiggers@kernel.org>
 <20190422180346.GA22674@gmail.com>
 <20190501002517.GF48973@gmail.com>
 <20190501013649.GO23075@ZenIV.linux.org.uk>
 <20190430194943.4a7916be@lwn.net>
 <20190501021423.GQ23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501021423.GQ23075@ZenIV.linux.org.uk>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 03:14:23AM +0100, Al Viro wrote:
> On Tue, Apr 30, 2019 at 07:49:43PM -0600, Jonathan Corbet wrote:
> > On Wed, 1 May 2019 02:36:49 +0100
> > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > > Thought I'd replied; apparently not...  Anyway, the problem with those
> > > is that there'd been a series of patches converting vfs.txt to new
> > > format; I'm not sure what Jon is going to do with it, but these are
> > > certain to conflict.  I've no objections to the contents of changes,
> > > but if that stuff is getting massive reformatting the first two
> > > probably ought to go through Jon's tree.  I can take the last two
> > > at any point.
> > > 
> > > Jon, what's the status of the format conversion?
> > 
> > Last I saw, it seemed that you wanted changes in how things were done and
> > that Tobin (added to CC) had stepped back.  Tobin, are your thoughts on
> > the matter different?  I could try to shoehorn them in for 5.2 still, I
> > guess, but perhaps the best thing to do is to just take Eric's patch, and
> > the reformatting can work around it if need be.
> 
> I can certainly apply Eric's series (or ACK it if we end up deciding to
> feed it through your tree).
> 
> Rereading my replies in that thread, I hadn't been clear back then and
> I can see how that could've been created the wronng impression. 

Yes, I had stepped back.  I thought from Al's comments that he didn't like
the current content of vfs.txt

Since the conversion set I did did not fundamentally change the content
but just moved it to the source files it seemed like this set was a dead
end.

FWIW I don't think that a _simple_ conversion for vfs.txt to vfs.rst is
useful if the VFS is to be re-documented.  It isn't trivial to do if we
want to make any use of RST features and if we do not want to then why
bother converting it?

> I do have problems with vfs.txt approach in general and I hope we end up
> with per object type documents; however, that's completely orthogonal to
> format conversion.  IOW, I have no objections whatsoever to format switch
> done first; any migration of e.g. dentry-related parts into a separate
> document, with lifecycle explicitly documented and descriptions of
> methods tied to that can just as well go on top of that.

I'd like to work on this but considering I don't know what I'm talking
about and have to learn as I go this is a long project ...

> I don't think that vfs.txt will survive in recognizable form in the long
> run, but by all means, let's get the format conversion out of the way
> first.  And bits and pieces of contents will survive in the replacement
> files when those appear.

IMO vfs.txt is so outdated the conversion really needs to be done by
someone that knows the VFS inside out.

I am more than happy to take directions on this if there is something
useful I can do.

Cheers,
Tobin.
