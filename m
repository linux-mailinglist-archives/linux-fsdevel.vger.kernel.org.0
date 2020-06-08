Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD421F1604
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgFHJ6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 05:58:49 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45535 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728745AbgFHJ6t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:58:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 503415C00E7;
        Mon,  8 Jun 2020 05:58:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Jun 2020 05:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        dHXvjsVk7QKN9xSmxFZliOkWW0vYwmyFZklqwFJxZx0=; b=nbuRRuQMMotal5S8
        pTkvN+cmjfx8FXtAQCeuwybBH7S6VVW0ds1kT1qKG/FvjVQYv1yuRNB3eez27HfC
        pFmvpUz9+o3NY2whoy/ZynFDzKKpX5CcbpGCMoUqqNpnjO5zKetMk2SDHB1T9qd9
        /h3Ah3sakw4x1Jx7umnwljUFBfDSnAz1NunymMh2tg9mV8dO2pvf8PPR8WQFWxsd
        bp/Y2GnpF08+DJljBEOGCSwgRNxxoePPv4/zUWhCAw6sr6o6La8GDgh360TW/KW+
        MQZjM/QJoTNciAnM8uXjGYhdK8CppxGSAycOS1JISb1TMuskSNPKFHoROkGpO9Db
        Pp/0SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=dHXvjsVk7QKN9xSmxFZliOkWW0vYwmyFZklqwFJxZ
        x0=; b=ssUoMqNFeqO0sPk0K4AU8jQTyVoHyYwOSKTCca9oiggMmH3ruvzqarQG2
        h0/gmIktox7m6oRVShAo3y0OPfd4rPhzHnUrqwaXupLnII4r29+jyvhafzjilfHW
        tRXAsy3lXN5C13RN2utfyGsdNQxIEG2/cw8rHBgIQGWWa2SJdLlV4bwlZzZARpdy
        aRyfdeBocNubsbdUl+2oHqMD2LQVkOwJLNFBKXHysFDNGRHsoa1vq5fanLTlobqL
        S5+sJV9upS05bTcN9qwF4ehETAFdkNGUkORQEiHBjZLSuY3D1waiWiMw3LwriWGX
        1W8YPQbJmcOaUPlqjiHl2i5iDo6uA==
X-ME-Sender: <xms:1wveXlbewY_jy9ezRxmkWMcR87fu-vrQ4CjlxOXZxRIi39HgJZe0YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehuddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepheekrdejrddvvddtrdegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:1wveXsYKizYNVLq2lZTLheMgS5o9B3B1EKyz7f4ORP5MBkWo-fkKVg>
    <xmx:1wveXn_Syb7GHMQLazflaIlzOS4KTuTq_3txw1SoYiGsaI0qyxUDqg>
    <xmx:1wveXjomBAOCSmjMy1qCAZXrA6_L0IZibgcjNabBz7Ms_7k129GUOw>
    <xmx:2AveXlDiIflgmGfYQdGT-ls72uCwU2CvI7FiNYXvahMnw8ky_V-m_w>
Received: from mickey.themaw.net (58-7-220-47.dyn.iinet.net.au [58.7.220.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F41D328005E;
        Mon,  8 Jun 2020 05:58:43 -0400 (EDT)
Message-ID: <6e408041ae9bedb2269cf607d7313a414c7cead3.camel@themaw.net>
Subject: Re: [PATCH 1/4] kernfs: switch kernfs to use an rwsem
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        l Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 08 Jun 2020 17:58:39 +0800
In-Reply-To: <36e2d782d1aea1cfbe17f3bfee35f723f2f89c0d.camel@themaw.net>
References: <159038508228.276051.14042452586133971255.stgit@mickey.themaw.net>
         <159038562460.276051.5267555021380171295.stgit@mickey.themaw.net>
         <36e2d782d1aea1cfbe17f3bfee35f723f2f89c0d.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-06-07 at 16:40 +0800, Ian Kent wrote:
> Hi Greg,
> 
> On Mon, 2020-05-25 at 13:47 +0800, Ian Kent wrote:
> > @@ -189,9 +189,9 @@ int kernfs_iop_getattr(const struct path *path,
> > struct kstat *stat,
> >  	struct inode *inode = d_inode(path->dentry);
> >  	struct kernfs_node *kn = inode->i_private;
> >  
> > -	mutex_lock(&kernfs_mutex);
> > +	down_read(&kernfs_rwsem);
> >  	kernfs_refresh_inode(kn, inode);
> > -	mutex_unlock(&kernfs_mutex);
> > +	up_read(&kernfs_rwsem);
> >  
> >  	generic_fillattr(inode, stat);
> >  	return 0;
> > @@ -281,9 +281,9 @@ int kernfs_iop_permission(struct inode *inode,
> > int mask)
> >  
> >  	kn = inode->i_private;
> >  
> > -	mutex_lock(&kernfs_mutex);
> > +	down_read(&kernfs_rwsem);
> >  	kernfs_refresh_inode(kn, inode);
> > -	mutex_unlock(&kernfs_mutex);
> > +	up_read(&kernfs_rwsem);
> >  
> >  	return generic_permission(inode, mask);
> >  }
> 
> I changed these from a write lock to a read lock late in the
> development.
> 
> But kernfs_refresh_inode() modifies the inode so I think I should
> have taken the inode lock as well as taking the read lock.
> 
> I'll look again but a second opinion (anyone) would be welcome.

I had a look at this today and came up with a couple of patches
to fix it, I don't particularly like to have to do what I did
but I don't think there's any other choice. That's because the
rb tree locking is under significant contention and changing
this back to use the write lock will adversely affect that.

But unless I can find out more about the anomalous kernel test
robot result I can't do anything!

Providing a job.yaml to reproduce it with the hardware specification
of the lkp machine it was run on and no guidelines on what that test
does and what the test needs so it can actually be reproduced isn't
that useful.

Ian

