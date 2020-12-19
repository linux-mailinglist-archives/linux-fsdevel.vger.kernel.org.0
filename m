Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E422DF25A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Dec 2020 00:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgLSXx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 18:53:27 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:47843 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbgLSXx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 18:53:27 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9E5C4858;
        Sat, 19 Dec 2020 18:52:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 19 Dec 2020 18:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        oMtxpFqpWr+CQHvqx/VJwXKK0kwl2WotuUEgoJfEbcY=; b=qY8oFQHmXO65Exfr
        +v2X990vj8SObN6u9h0VSkIzAcm4Rwcyi7BiCYsLuv5hDNPq0FhHYG/BpRAXLNIF
        xooa4NFUA0n70tsBmnHaJZSHpfBnqmlJApQtBZhKtDeFykQerSev9SfI8wFl3Gk3
        jqJitqfR8cnLxhwobvDwAzBVZMzC7w2OlcGgT+wQJnjHeojIK9yw8OX7FGHrfTDU
        Fh+T26AjVEPJss6XlqXJ5B516LBdq4ZpYySqZVDRkX/Nw6YBmyg34Hwd/qD0hep0
        fr18prT30EXqf7Q7QPMh3rBbTuZE+py/uRih8EPRY9Wb/Yrdxgo/CQY4kQEB1ATy
        XNcTGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=oMtxpFqpWr+CQHvqx/VJwXKK0kwl2WotuUEgoJfEb
        cY=; b=LrgE5O8ZuzZZooSmw8AHhtx+G/Q7CG4d2YXv9mnEmu29SdNdv95JEQ/bv
        +UyMkG8xLbQh0bb+IPRS7RY+ZvKbPRAYdIeGKMa36YE8f4cXXHdE+w10CbHK2Vi8
        fHkOXrQeDr6V8w6NQhvEQiqas9JoMPXteXhoBOtLbDze2bcvXeSBsjgGDimC8ZK9
        hJ/ySbtq7qLtC/BFznRGm0BWDgqgKxuTSKRnT9JmQ9jOQ4kjpiZD9JxTILjt6oiD
        HZ1Vwi30DsMQMISWeMtB0cBQCJX72UgFKq04xIi5VRCULEgHMHMq40n+TdGNcusj
        nF/SnMOy2BihY724IFUbVHda1j9IQ==
X-ME-Sender: <xms:M5LeX84JE5-vH0xkgs1jXChDezK-UsuEK6vs7CcighZelbmk8vNn5A>
    <xme:M5LeX95cyMvlwfxDoVtZTkBBOmKL-CYlhL6Jm-Dus4fq9unmo94mze9SURK6fMX2n
    6BRdjvkMyvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddtiedrieelrddvgeejrddvtdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:M5LeX7dWx98F0n6wnIPGZ65kJeZpUH30GsOMbFHrh9ry2T5FyuqV_Q>
    <xmx:M5LeXxLCX0cZX9lO0QDedbOWFOZUbGLC9QA964Eoor3dobPTcugSJA>
    <xmx:M5LeXwKS_SxF9IJSm4tIhUPW4vCmjy4O-Af2nuw2N2BRY92ikS7kEw>
    <xmx:NJLeX5rampUuIPT_5o2Bd_Bnx9uxgZqU8qtTOXoVvaX9AzPOJZR3afrw6t0>
Received: from mickey.themaw.net (106-69-247-205.dyn.iinet.net.au [106.69.247.205])
        by mail.messagingengine.com (Postfix) with ESMTPA id 65EC01080057;
        Sat, 19 Dec 2020 18:52:15 -0500 (EST)
Message-ID: <f1c9b0e6699582e69c0fb2e8afb40ddaf17bdf76.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Fox Chen <foxhlchen@gmail.com>, akpm@linux-foundation.org,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        ricklind@linux.vnet.ibm.com, sfr@canb.auug.org.au,
        viro@zeniv.linux.org.uk
Date:   Sun, 20 Dec 2020 07:52:11 +0800
In-Reply-To: <X94pE6IrziQCd4ra@mtj.duckdns.org>
References: <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
         <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
         <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
         <c4002127c72c07a00e8ba0fae6b0ebf5ba8e08e7.camel@themaw.net>
         <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
         <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
         <X9t1xVTZ/ApIvPMg@mtj.duckdns.org>
         <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>
         <X9zDu15MvJP3NU8K@mtj.duckdns.org>
         <37c339831d4e7f3c6db88fbca80c6c2bd835dff2.camel@themaw.net>
         <X94pE6IrziQCd4ra@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-12-19 at 11:23 -0500, Tejun Heo wrote:
> Hello,
> 
> On Sat, Dec 19, 2020 at 03:08:13PM +0800, Ian Kent wrote:
> > And looking further I see there's a race that kernfs can't do
> > anything
> > about between kernfs_refresh_inode() and fs/inode.c:update_times().
> 
> Do kernfs files end up calling into that path tho? Doesn't look like
> it to
> me but if so yeah we'd need to override the update_time for kernfs.

Sorry, the below was very hastily done and not what I would actually
propose.

The main point of it was the question

+	/* Which kernfs node attributes should be updated from
+	 * time?
+	 */

but looking at it again this morning I think the node iattr fields
that might need to be updated would be atime, ctime and mtime only,
maybe not ctime ... not sure.

What do you think?

Also, if kn->attr == NULL it should fall back to what the VFS
currently does.

The update_times() function is one of the few places where the
VFS updates the inode times.

The idea is that the reason kernfs needs to overwrite the inode
attributes is to reset what the VFS might have done but if kernfs
has this inode operation they won't need to be overwritten since
they won't have changed.

There may be other places where the attributes (or an attribute)
are set by the VFS, I haven't finished checking that yet so my
suggestion might not be entirely valid.

What I need to do is work out what kernfs node attributes, if any,
should be updated by .update_times(). If I go by what
kernfs_refresh_inode() does now then that would be none but shouldn't
atime at least be updated in the node iattr.

> > +static int kernfs_iop_update_time(struct inode *inode, struct
> > timespec64 *time, int flags)
> >  {
> > -	struct inode *inode = d_inode(path->dentry);
> >  	struct kernfs_node *kn = inode->i_private;
> > +	struct kernfs_iattrs *attrs;
> >  
> >  	mutex_lock(&kernfs_mutex);
> > +	attrs = kernfs_iattrs(kn);
> > +	if (!attrs) {
> > +		mutex_unlock(&kernfs_mutex);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Which kernfs node attributes should be updated from
> > +	 * time?
> > +	 */
> > +
> >  	kernfs_refresh_inode(kn, inode);
> >  	mutex_unlock(&kernfs_mutex);
> 
> I don't see how this would reflect the changes from kernfs_setattr()
> into
> the attached inode. This would actually make the attr updates
> obviously racy
> - the userland visible attrs would be stale until the inode gets
> reclaimed
> and then when it gets reinstantiated it'd show the latest
> information.

Right, I will have to think about that, but as I say above this
isn't really what I would propose.

If .update_times() sticks strictly to what kernfs_refresh_inode()
does now then it would set the inode attributes from the node iattr
only.

> 
> That said, if you wanna take the direction where attr updates are
> reflected
> to the associated inode when the change occurs, which makes sense,
> the right
> thing to do would be making kernfs_setattr() update the associated
> inode if
> existent.

Mmm, that's a good point but it looks like the inode isn't available
there.

Ian

