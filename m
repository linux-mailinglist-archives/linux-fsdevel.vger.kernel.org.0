Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28078415594
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 04:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbhIWCwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 22:52:12 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36495 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238954AbhIWCwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:52:12 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id E2EEE5C0110;
        Wed, 22 Sep 2021 22:50:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 Sep 2021 22:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        m1z6kaeKcFg9q/fTSiPLIInC9dpxETbY8DVKplWj3p4=; b=IZzug/0pmClEodTc
        rJF2kwNUnd5vbC0LQN2/z4IwHM82ocUf2Y897hpxi9+nO0fnztid5mUiUjLTsEHj
        1X6G4WScKKBTcslXVwelC0mZN25oc8Hz6cvlMSxz+xSWvhhWjFJ7grL9q7Pd9UXl
        6HkC7ix8rlIM3vcFyJ3N9Lfkwu+t/KFFivOeg99pwszVT1qn1eUUnCC8iA5H2GEe
        J0fBUCFB2TYjE2UhqR8n+rjZh6rDaDMTPlnkZgYAINSWe23upn0yUtQDBGgvFwwN
        WpdaO8dRPUPUusUzUufDLuT50yG7BFrLBpAtE4kgvvfXMaAmQv+SFKLB0a1HTNl4
        5hnZtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=m1z6kaeKcFg9q/fTSiPLIInC9dpxETbY8DVKplWj3
        p4=; b=HnU5f7h1klNV9h0b9kzRvNqMwSDRF2RCUXMd4vw4igi2A1siaPEDlBeas
        yym2d5Dp1ACTZGMW8Xvqji3w239Y2k+Q6CZ6Z7kSBYVLgVaX0FjFJE4RrTEXb7dM
        rWFlrxjaAIU+juhwQRX4lKK0Ne+wCIdUB0UIrmbfDTC3vzApzrH1R6EMeSyqP8lE
        nFwW46zwOSpcQL4tEA+QfOiKikhXEk34VdRa9IcNv0D56AcXv35RZdQ+YEo99l+u
        Cxdsq01804zUBalBmtTJ+0uuTawVQHfDjLnpwQhWv6qp7fsLGuBABZ7dn4XFp7vS
        /KSs8dzw1s5QY6Ng8xka9ZwdmS+9w==
X-ME-Sender: <xms:gOtLYa7CVJwtTINI69G9Y8R97T8BOKamV5HEdEn7-F6nBmqG2b-Gow>
    <xme:gOtLYT5UXVtKmQ281qhyY05XLMlubWxnGKXqG1GJYVrXHFvT31mjcRTz-iBeLSe8I
    rkhRlOyVoYd>
X-ME-Received: <xmr:gOtLYZfq9CReaJ8sPYEu7qcUmw0cUcDGWFzD841Sza7JSiCvz83_Rme_f3FNzjL9R3yQmpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeikedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:gOtLYXL4IkErNtke8iNngnk57ZYNmG6VufaECllhhD3MAKpE0DOhDQ>
    <xmx:gOtLYeL4dUi4-V-oRsah9alV7s4XWAFZz6BUvRSJD4m-pUUFy-fTXw>
    <xmx:gOtLYYygFMVazVBpdpHq2axb0CZnseAW8w1d5qgdLxkp5I25ZDv5kA>
    <xmx:gOtLYTEGhkIKqSIlsIPOcnUTGt09vE5jjw-Cn39nHCRErgxotsvFXA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Sep 2021 22:50:37 -0400 (EDT)
Message-ID: <077362887b4ceeb01c27fbf36fa35adae02967c9.camel@themaw.net>
Subject: Re: [PATCH] kernfs: fix the race in the creation of negative dentry
From:   Ian Kent <raven@themaw.net>
To:     Hou Tao <houtao1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Cc:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 23 Sep 2021 10:50:33 +0800
In-Reply-To: <e3d22860-f2f0-70c1-35ef-35da0c0a44d2@huawei.com>
References: <20210911021342.3280687-1-houtao1@huawei.com>
         <7b92b158200567f0bba26a038191156890921f13.camel@themaw.net>
         <6c8088411523e52fc89b8dd07710c3825366ce64.camel@themaw.net>
         <747aee3255e7a07168557f29ad962e34e9cb964b.camel@themaw.net>
         <e3d22860-f2f0-70c1-35ef-35da0c0a44d2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-09-23 at 09:52 +0800, Hou Tao wrote:
> Hi,
> 
> On 9/15/2021 10:09 AM, Ian Kent wrote:
> > On Wed, 2021-09-15 at 09:35 +0800, Ian Kent wrote:
> > 
> Sorry for the late reply.
> > I think something like this is needed (not even compile tested):
> > 
> > kernfs: dont create a negative dentry if node exists
> > 
> > From: Ian Kent <raven@themaw.net>
> > 
> > In kernfs_iop_lookup() a negative dentry is created if associated
> > kernfs
> > node is incative which makes it visible to lookups in the VFS path
> > walk.
> > 
> > But inactive kernfs nodes are meant to be invisible to the VFS and
> > creating a negative for these can have unexpetced side effects.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/dir.c |    9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index ba581429bf7b..a957c944cf3a 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -1111,7 +1111,14 @@ static struct dentry
> > *kernfs_iop_lookup(struct inode *dir,
> >  
> >         kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
> >         /* attach dentry and inode */
> > -       if (kn && kernfs_active(kn)) {
> > +       if (kn) {
> > +               /* Inactive nodes are invisible to the VFS so don't
> > +                * create a negative.
> > +                */
> > +               if (!kernfs_active(kn)) {
> > +                       up_read(&kernfs_rwsem);
> > +                       return NULL;
> > +               }
> >                 inode = kernfs_get_inode(dir->i_sb, kn);
> >                 if (!inode)
> >                         inode = ERR_PTR(-ENOMEM);
> > 
> > 
> > Essentially, the definition a kernfs negative dentry, for the
> > cases it is meant to cover, is one that has no kernfs node, so
> > one that does have a node should not be created as a negative.
> > 
> > Once activated a subsequent ->lookup() will then create a
> > positive dentry for the node so that no invalidation is
> > necessary.
> I'm fine with the fix which is much simpler.

Great, although I was hoping you would check it worked as expected.
Did you check?
If not could you please do that check?

> > This distinction is important because we absolutely do not want
> > negative dentries created that aren't necessary. We don't want to
> > leave any opportunities for negative dentries to accumulate if
> > we don't have to.
> >     
> > I am still thinking about the race you have described.
> > 
> > Given my above comments that race might have (maybe probably)
> > been present in the original code before the rwsem change but
> > didn't trigger because of the serial nature of the mutex.
> I don't think there is such race before the enabling of negative
> dentry,
> but maybe I misunderstanding something.

No, I think you're probably right, it's the introduction of using
negative dentries to prevent the expensive dentry alloc/free cycle
of frequent lookups of non-existent paths that's exposed the race.

> > So it may be wise (perhaps necessary) to at least move the
> > activation under the rwsem (as you have done) which covers most
> > of the change your proposing and the remaining hunk shouldn't
> > do any harm I think but again I need a little more time on that.
> After above fix, doing sibling tree operation and activation
> atomically
> will reduce the unnecessary lookup, but I don't think it is necessary
> for the fix of race.

Sorry, I don't understand what your saying.

Are you saying you did check my suggested patch alone and it
resolved the problem. And that you also think the small additional
dentry churn is ok too.

If so I agree, and I'll forward the patch to Greg, ;)

Ian
> 
> Regards,
> Tao
> > I'm now a little concerned about the invalidation that should
> > occur on deactivation so I want to have a look at that too but
> > it's separate to this proposal.
> > Greg, Tejun, Hou, any further thoughts on this would be most
> > welcome.
> > 
> > Ian
> > > 
> > .
> 


