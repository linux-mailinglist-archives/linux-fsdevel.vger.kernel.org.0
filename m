Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413AFC03B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfI0KwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 06:52:01 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44793 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbfI0KwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 06:52:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7AE672216E;
        Fri, 27 Sep 2019 06:51:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 27 Sep 2019 06:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        YufqVygReVMnC7P9cwXPmzEcJ9xlx5PgCOb+cwF6Hcs=; b=bYFVNvQ4Yki3DcR0
        xqXi1V/h/HuE0NWrPbD7aq45Vdrvulm94fp814sajoLhZq49zGPqcpohUYFO1BiJ
        wV7SSn/UgjD/nJC4muIZjpFEoXuWxIuTKF16LA5Na89XvGsVHNCd5onvnn1qe8Yg
        Tp6Tj9mYFLwjDXYmtz99JrCnF82b82LIU3DODjwOz+TtdyAWJjaNnema1DxYp4si
        s+bOuxYzsI4ABAdl9T4sLTIEnbNF2tVGEDufVRp/hSZzbJR8ZLpaxowHKKACZrGg
        N7NpthVsPEcBRhiSLAjxo3+BMGOaSIOt/brKeBPYNPyAbWTLlAKI5rbYXoU3cqDe
        +f1kaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=YufqVygReVMnC7P9cwXPmzEcJ9xlx5PgCOb+cwF6H
        cs=; b=MmUmINK2jm4uT3+9juBh60VC/LrdOEIEUyiWpAlKsWTzYxJUAzp4J5Rtk
        ygfvjVG5PuqNrDPYQPA+Xlf6KZariD/MJAlxhwU+DlilC1zQjOfZGQ1vfFmYUbYI
        UfzfJ7KmmSMLb6PChMd9OsLZSuZ3EoVTd+dkfRWFswG9LtbA1IPPFqduhXKUWr43
        G+AFXhKgqzhkmQtei7hW+Q37BrhP74kj1+grWCIJrd0VvV3h3a9jOIu5LHM9Sjoh
        5Q4tADZ7uMI9U2YzGdOpdiHfBAM3be3RrqywFpa17bCFQkh6VIFzfb8zar4k5Moy
        E0ZDFXLgED82blqyOENIGVwOxPGdA==
X-ME-Sender: <xms:zumNXUfHsaG-53-pYdR_wrEjY8ZWHEMdUAIQ92NOIQs2paMSj87KxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucfkphepuddukedrvddtledrudeikedrvdeinecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:zumNXa6KvkfE87FyOPQWw2GApVaIMrs3HWNZOsvhgB-5F88zk89sYA>
    <xmx:zumNXdZCkrSlX1zgr6eiy4g4aR3VfYle3PKwCIVAE91F3a7ArLSR2A>
    <xmx:zumNXdvlTa5tsfZBchr7OciUTeuiPX_-5F1OIF3B2S8yAQKMIyluOA>
    <xmx:z-mNXXVBkeZxuUS1156zkzOxOqGeHX74OOu1p7dlnjh_8DWFlrL6Hw>
Received: from mickey.themaw.net (unknown [118.209.168.26])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5D32D6005D;
        Fri, 27 Sep 2019 06:51:56 -0400 (EDT)
Message-ID: <b2443a28939d6fe79ec9aa9d983f516c8269448a.camel@themaw.net>
Subject: Re: [RFC] Don't propagate automount
From:   Ian Kent <raven@themaw.net>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, viro@zeniv.linux.org.uk
Cc:     autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 27 Sep 2019 18:51:52 +0800
In-Reply-To: <7f31f0c2bf214334a8f7e855044c88a50e006f05.camel@themaw.net>
References: <20190926195234.bipqpw5sbk5ojcna@fiona>
         <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
         <e5fbf32668aea1b8143d15ff47bd1e4309d03b17.camel@themaw.net>
         <d163042ab8fffd975a6d460488f1539c5f619eaa.camel@themaw.net>
         <7f31f0c2bf214334a8f7e855044c88a50e006f05.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-09-27 at 15:41 +0800, Ian Kent wrote:
> 
> > > I initially thought this was the result of a "fix" in the mount
> > > propagation code but it occurred to me that propagation is meant
> > > to occur between mount trees not within them so this might be a
> > > bug.
> > > 
> > > I probably should have worked out exactly what upstream kernel
> > > this started happening in and then done a bisect and tried to
> > > work out if the change was doing what it was supposed to.
> > > 
> > > Anyway, I'll need to do that now for us to discuss this sensibly.
> > > 
> > > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > > 
> > > > > diff --git a/fs/pnode.c b/fs/pnode.c
> > > > > index 49f6d7ff2139..b960805d7954 100644
> > > > > --- a/fs/pnode.c
> > > > > +++ b/fs/pnode.c
> > > > > @@ -292,6 +292,9 @@ int propagate_mnt(struct mount *dest_mnt,
> > > > > struct
> > > > > mountpoint *dest_mp,
> > > > >  	struct mount *m, *n;
> > > > >  	int ret = 0;
> > > > >  
> > > > > +	if (source_mnt->mnt_mountpoint->d_flags &
> > > > > DCACHE_NEED_AUTOMOUNT)
> > > > > +		return 0;
> > > > > +
> > > > 
> > > > Possible problem with this is it will probably prevent mount
> > > > propagation in both directions which will break stuff.
> > > > 
> > > > I had originally assumed the problem was mount propagation
> > > > back to the parent mount but now I'm not sure that this is
> > > > actually what is meant to happen.

Goldwyn,

TBH I'm already a bit over this particularly since it's a
solved problem from my POV.

I've gone back as far as Fedora 20 and 3.11.10-301.fc20 also
behaves like this.

Unless someone says this behaviour is not the way kernel
mount propagation should behave I'm not going to spend
more time on it.

The ability to use either "slave" or "private" autofs pseudo
mount options in master map mount entries that are susceptible
to this mount propagation behaviour was included in autofs-5.1.5
and the patches used are present on kernel.org if you need to
back port them to an earlier release.

https://mirrors.edge.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.5/autofs-5.1.4-set-bind-mount-as-propagation-slave.patch

https://mirrors.edge.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.5/autofs-5.1.4-add-master-map-pseudo-options-for-mount-propagation.patch

It shouldn't be too difficult to back port them but they might
have other patch dependencies. I will help with that if you
need it.

Ian

