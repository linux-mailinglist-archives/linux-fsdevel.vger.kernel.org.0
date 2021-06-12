Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F7E3A4BCA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 02:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFLAt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 20:49:27 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33153 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229942AbhFLAt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:49:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BAFFE580B33;
        Fri, 11 Jun 2021 20:47:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 11 Jun 2021 20:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        pUHyicE+xVETwF9BHn/R9zG86J8cj32XPjWTRMM+Dxo=; b=OWnFYSJ0m6zKboQZ
        FoXrPwTf5vKk2D0uZ7OijBK5DKfyqgA7JAQKsOrRDOZ7dAosHivf0YJ5Q7HRUWDd
        pZ/+FEB8f5ArUzhSwlJqDvRgzEx1qaGOLC9JOGECTxQktpe1xDzjGd15krYZZXhH
        pFcx86sYuXoO47hfvfZlA+5aywu1CBJmBTSCAvJQ9KbyR3eL8TCku/QNNi1nmCrm
        OB30BAQ/Nllg7sPUJc50FQZSLFPkGJ0pB1dlJV7dLkde48Sgmn8vjxJj9g7C7Rcr
        3Xw57nNFBmgEDEMvUZJszHitiiKj3oxgpxOeSMNxFl+OYK3tFUOp54DeiLU2QxDC
        rxkfhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=pUHyicE+xVETwF9BHn/R9zG86J8cj32XPjWTRMM+D
        xo=; b=BJiSdG3cpKe/+7Xhr43xs77HwYN2RPyhWkeCsPFDKMxWgFeUTIM/diRNl
        YtkogJaTy8lhjoHdm73cfBVWrCwiZwgOHe6FxAXk2/GV/Z+TVwQMsfvUZ/mvRtPb
        fDyhslQKtCnewFUAAVoqyIAcXegFtxuy6pdLOhv1kO0/iqGa26jRfE37UG3RnBPt
        etqV7KE2tHhMe16AP6ACMzQMUeehaOmoBkQl9nbRsnDZdMVUDvrhQgzKI8bulLHh
        nOTC6yn6jbOuDPLFSxeTHlMcEWY9o+lRIQ04spZk8MCWUHacG9L7ifhIgG5rWD/Z
        E0EufHck483zWA2Gz1wPbrf22WQDw==
X-ME-Sender: <xms:HgTEYBUztaWuiIB8qfe8zT4viPPj4B_bpWjyUWBg1hiAJNKLq6DSKA>
    <xme:HgTEYBm6Xe_JgZX6t_4veXkrwXeoj-OiMffoimdUZOdv1LM5BUxCeacd5W0ZJiTs1
    XnNvNqTw9TX>
X-ME-Received: <xmr:HgTEYNYKh1Tq6vUTEHZJ-N0euvC4354wfngkzmEAumKRqtlz1_ZYmllCkrzHMVJWL9wg9-pgyJE_1Jg48HrBJy_7UwY4sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:HgTEYEVNZyemw1mPnNaDdWfzpOuNyJuOH5rWj1Y_a7YURJlXyE8yyg>
    <xmx:HgTEYLmoR-TEQy93g0dFIUOaWfdK3iBwQtWtIxKZHhy2Cp5of1KNbQ>
    <xmx:HgTEYBepiw0IEzyvx6_afZ_96fHIqimfh_uNy3sFNT6AreyL-KMFtA>
    <xmx:HwTEYJcvygQXiRM_7sUvIXW_TCZwTypzzrfmSSp1bOoEyP-ogi_11g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jun 2021 20:47:21 -0400 (EDT)
Message-ID: <ca79f8feb8ac6b506e7fdf249dfede832ce45a22.camel@themaw.net>
Subject: Re: [PATCH v6 3/7] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 12 Jun 2021 08:47:17 +0800
In-Reply-To: <CAJfpegunvr-0b1SW2FDNRdaExr=A9OFH1K-g7d0+UiS+9j5V_w@mail.gmail.com>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
         <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
         <CAJfpegunvr-0b1SW2FDNRdaExr=A9OFH1K-g7d0+UiS+9j5V_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-06-11 at 15:07 +0200, Miklos Szeredi wrote:
> On Wed, 9 Jun 2021 at 10:50, Ian Kent <raven@themaw.net> wrote:
> > 
> > If there are many lookups for non-existent paths these negative
> > lookups
> > can lead to a lot of overhead during path walks.
> > 
> > The VFS allows dentries to be created as negative and hashed, and
> > caches
> > them so they can be used to reduce the fairly high overhead
> > alloc/free
> > cycle that occurs during these lookups.
> > 
> > Use the kernfs node parent revision to identify if a change has
> > been
> > made to the containing directory so that the negative dentry can be
> > discarded and the lookup redone.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/dir.c |   52 ++++++++++++++++++++++++++++++++-----------
> > ---------
> >  1 file changed, 32 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index b3d1bc0f317d0..4f037456a8e17 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -1039,9 +1039,28 @@ static int kernfs_dop_revalidate(struct
> > dentry *dentry, unsigned int flags)
> >         if (flags & LOOKUP_RCU)
> >                 return -ECHILD;
> > 
> > -       /* Always perform fresh lookup for negatives */
> > -       if (d_really_is_negative(dentry))
> > -               goto out_bad_unlocked;
> > +       /* Negative hashed dentry? */
> > +       if (d_really_is_negative(dentry)) {
> > +               struct dentry *d_parent = dget_parent(dentry);
> > +               struct kernfs_node *parent;
> > +
> > +               /* If the kernfs parent node has changed discard
> > and
> > +                * proceed to ->lookup.
> > +                */
> > +               parent = kernfs_dentry_node(d_parent);
> > +               if (parent) {
> > +                       if (kernfs_dir_changed(parent, dentry)) {
> 
> Perhaps add a note about this being dependent on parent of a negative
> dentry never changing.

Which of course it it can change, at any time.

> 
> If this was backported to a kernel where this assumption doesn't
> hold,
> there would be a mathematical chance of a false negative.

Isn't this a cunning way of saying "in thinking about the move case
you've forgotten about the obvious common case, just put back taking
the read lock already, at least for the check"?

Ian

