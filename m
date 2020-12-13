Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC39F2D8B32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 04:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392837AbgLMDra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 22:47:30 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58311 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbgLMDr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 22:47:29 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 83D5C5801C1;
        Sat, 12 Dec 2020 22:46:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 12 Dec 2020 22:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        moTTewfAsC7p9pblzgIIIRNlTgzp+HLqas5jF1XSB0U=; b=VqMoU2nQ60Wx7E4+
        5WkteL9vtxIaHY4I213u6YSBYCbskfmNJWQR12NXFD3y4S1jJh71DfA/NPtmudeF
        n8wOCLrrjTxSxeoNbEYxZ4j9czbwogZ7I36/ugUHXsklz1jH3slA90Eu7Dy0x/jV
        fttxXM/NHHqZ9lsYkvOt0w60Cw91g5H7B7hZoVVK3trFwWC1Ng9dP/7JXNzSC9C4
        RXqKHGD3XjPXQxhUkuYlLvDi+IT/VQBIdoVQoqvZeXSIsrGCoeyA2sdbSjwgd66q
        1XOX9IHq1mONuJiZ1OdYf7//CMVLlK9JZkeSX1M7M9Law2eKuVM1te1ro+i+S+1y
        v+X1zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=moTTewfAsC7p9pblzgIIIRNlTgzp+HLqas5jF1XSB
        0U=; b=JaGOx5TRh2TkhIgqbFV9wuC5sEFI1biP9gl9OGrsBq7c8PKe02jTWs7Gg
        JkOKsvK0nAzujdSx37xWSCkY9SNAGDNT3Xwmd1jXUuu/i5caKGClx3APaMgDK6oF
        00/y5W6oC5OXXCoqu8c6XxtZcOzchr48Dcv/pxK5N9MaxLFu3Rz+DJ1IJmb5UqQ8
        WOHsSYqBC1jyHXAC0LUaAjiIgSnrxPiESqN+dVy7bSHSiUXGk8Go7JTcN3GGnR2t
        1NbrKBwGwlf4BkI5dGB8Z41yZN0zcN6gEwh8hFDUcMAUjOpeFi9uhQpVNdxXZsA5
        xIKL650GkYAhlIRvB9fZCtuPjSzCA==
X-ME-Sender: <xms:jY7VX5TNMDEtkUe7GZvFGIQE2gAtAo2g5NO6FtRydW5Vz0DG-rysvg>
    <xme:jY7VXyyc4O4adRZl_8XlimFLdUm3BtAQsNJNTffYLC4fARgHtUPsVh59tb4296Y1f
    Hmnq38rBmeH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekhedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eikeeggeeuvdevgfefiefhudekkeegheeileejveethedutedvveehudffjeevudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddurdeggedrudefhedrudefle
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghv
    vghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:jY7VX-1e4plZyOXtEEBdU3kWLX_t1ImV400Ju81Jpqkp4L4qPE0cnA>
    <xmx:jY7VXxDFCjT74YCTbHJNX5bDQjl902PukoCEZebPR9ieDaK-MGFo1A>
    <xmx:jY7VXygMppy8xgX1rq6CVREp7ZEAmE7Qovf1IuWMIky7kcxATsK7kQ>
    <xmx:j47VX2iJmZ5B8H020RWXkrzKgi7aspjAanCMVnDXNmzfXUxW-zkwdw>
Received: from mickey.themaw.net (unknown [121.44.135.139])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0344E24005C;
        Sat, 12 Dec 2020 22:46:17 -0500 (EST)
Message-ID: <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        ricklind@linux.vnet.ibm.com, sfr@canb.auug.org.au, tj@kernel.org,
        viro@ZenIV.linux.org.uk
Date:   Sun, 13 Dec 2020 11:46:13 +0800
In-Reply-To: <13e21e4c9a5841243c8d130cf9324f6cfc4dc2e1.camel@themaw.net>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20201210164423.9084-1-foxhlchen@gmail.com>
         <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
         <13e21e4c9a5841243c8d130cf9324f6cfc4dc2e1.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-12-11 at 10:17 +0800, Ian Kent wrote:
> On Fri, 2020-12-11 at 10:01 +0800, Ian Kent wrote:
> > > For the patches, there is a mutex_lock in kn->attr_mutex, as
> > > Tejun
> > > mentioned here 
> > > (https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/),
> > > maybe a global 
> > > rwsem for kn->iattr will be better??
> > 
> > I wasn't sure about that, IIRC a spin lock could be used around the
> > initial check and checked again at the end which would probably
> > have
> > been much faster but much less conservative and a bit more ugly so
> > I just went the conservative path since there was so much change
> > already.
> 
> Sorry, I hadn't looked at Tejun's reply yet and TBH didn't remember
> it.
> 
> Based on what Tejun said it sounds like that needs work.

Those attribute handling patches were meant to allow taking the rw
sem read lock instead of the write lock for kernfs_refresh_inode()
updates, with the added locking to protect the inode attributes
update since it's called from the VFS both with and without the
inode lock.

Looking around it looks like kernfs_iattrs() is called from multiple
places without a node database lock at all.

I'm thinking that, to keep my proposed change straight forward
and on topic, I should just leave kernfs_refresh_inode() taking
the node db write lock for now and consider the attributes handling
as a separate change. Once that's done we could reconsider what's
needed to use the node db read lock in kernfs_refresh_inode().

It will reduce the effectiveness of the series but it would make
this change much more complicated, and is somewhat off-topic, and
could hamper the chances of reviewers spotting problem with it.

Ian

