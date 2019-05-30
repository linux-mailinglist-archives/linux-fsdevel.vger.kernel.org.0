Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F54C2F757
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 08:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfE3GBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 02:01:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39903 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbfE3GBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 02:01:37 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B2ABE220C3;
        Thu, 30 May 2019 02:01:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 30 May 2019 02:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=eCakL384zMTCpVZkURCZ5qsUo9h
        k+pUOlpeRS6gbT+U=; b=TN/YiQjQWUsoQU0Ha08Nx01TZQhDPqY4mOo08RR3wKL
        14s9bOMTOOAUcLSR9X5MNwkhrucp921SgYt8eKIlPpvoARbRjLSQfencP+c0Kv0e
        HTfP1aMUZggm4zPrbd3Qyli58WikqV8Dsu+MqIE5Xd8481jUx/4eNaDaejPdIvM7
        /HL2GzL6nZWp6nr2lWe5GfmgK3S0YV2LiIH7naZcf3pr+BxJ5Qv2cqEYHNtlVunn
        7rc0+BaePmGZyY7E68wVYJBnCOEa/PqbrzSxz2KIyEgMpJgX7qPRFZUt7dnZCYGo
        Xcd7YeB1k2tIWZRN4mITb61wny8b90bZtt2uXCuFgaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eCakL3
        84zMTCpVZkURCZ5qsUo9hk+pUOlpeRS6gbT+U=; b=py0C4DD0GGD8+o80IIh4uo
        IgLnWHuzqpiNJWiZICIAW/ZZ3LLUnCYeiM8zsxwItBc7/+7sxcKQmbms64CFzmka
        X0SCSUk/NAE1f8a01KMjYsDKIGDlWIsYg5qN4Dfv860bmA2D1jtZqxF/U/AQjo9a
        kc7RsDDXoVSoNveVRKPsHS+f8Hplv52aQx2a0ZGp4SyJCne5pKjBI3unScFwkZut
        FFySNOtUd20q3OL/QxosrODigq35dClXGSqhmIX55Aql+CQjBvIPBLEiG3nIIxxq
        F0pSix0+p/pQnIWC/ZV/K0UKVZ8oePtzePDrFJhkFMEMWvLYKFGNSkvPYNuLPL4w
        ==
X-ME-Sender: <xms:v3HvXKLfe7nhbx7utOcf5lvo3wQXgHRhBPyJT-pv_1vGXu_S-r1MzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvkedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttder
    tdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesth
    hosghinhdrtggtqeenucfkphepuddvgedrudejuddrfedurddugeegnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:v3HvXKQBKsR03OmxOLM97vnrKFC1ITG7c-hWGZLSDhhCVoFZsR6oIg>
    <xmx:v3HvXDRuJsPWMYIjrpe62IUEgbLL2WCT-qkS5EmxkEsOaF00rv-OrQ>
    <xmx:v3HvXK4cRJ1jMdSJTqBJEUKXuiViDyLuEFXcU4c56N5sOLvJSb2VYQ>
    <xmx:wHHvXAnGM5HD9n3U86goR9McOHwIl9nJwZzGvyQ-7Rrjd7fXa2Y6-w>
Received: from localhost (124-171-31-144.dyn.iinet.net.au [124.171.31.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4EF6F8005B;
        Thu, 30 May 2019 02:01:34 -0400 (EDT)
Date:   Thu, 30 May 2019 16:01:30 +1000
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
Message-ID: <20190530060130.GB11021@caerus>
References: <20190515002913.12586-1-tobin@kernel.org>
 <20190529163052.6ce91581@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163052.6ce91581@lwn.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Ouch!  Yes I knew this was sub-optimal, I thought the HTML looked ok.
I'll fix them up as suggested.

> There are, unfortunately, a lot of these to fix...  I bet it could be done
> with an elisp function, but I don't have time to beat my head against that
> wall right now.

oh really?  That would actually make doing this much more enticing, I've
already done all these multiple times manually - learning nothing, some
elisp games would actually teach me something.  Cheers.

> Any chance you would have time to send me a followup patch fixing these
> up?  I'll keep my branch with this set for now so there's no need to
> rebase those.

Sure thing, patches to come.

Cheers,
Tobin.
