Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B453D7388
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 12:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhG0Koc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 06:44:32 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:34109 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236186AbhG0Koa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:44:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 155F3580ACA;
        Tue, 27 Jul 2021 06:44:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 27 Jul 2021 06:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        hzwP7HziDq3+lShGm+nfs91KpNl05pJCwIUruh9Ju94=; b=pWgsuCA7q3GmjXTE
        FDvgePMxG6kyzXKuN+2QNxiqRQwcA+9aEK+ZNYltcBaKS76VT46ARnMl9VHAO9Ll
        F5Ynu687blGcolvBxiCfWeZ2WhIgcYXEhyL841wPrxg+jlo29GkD//srH4HoxM9U
        8MIEuySboa5mCMksbFCEa/U+g98Fp4xbY7pPpSpl4qK7YO/8+Ffjb9oExIiGdCzg
        48KKFZifSvzrrwzEeZRfEqLH4Tq4BPJoqHpVHaAfLuKPnvZX7qRBLpZBKrmUizrS
        Up8bAmRqybLfIkQAW+mdDe9O/Z2zbg234M30kBKZyuFy+gGYPEssZyeJZQEYfuaJ
        RprK6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=hzwP7HziDq3+lShGm+nfs91KpNl05pJCwIUruh9Ju
        94=; b=KKl3fOo2us0gNYxEpts5gM3+aXz8Y7LShysbJuNQIoTuTKgC05Yu+8nFK
        PrptjfyxleFjpR2o/4HJFTEUndQpWVIgBS/4fdIzhTYOH3AOUZNrzIq8VMER1pKN
        koVXShuqjcPwieOnkKE2vhv5+MfgXVP2V4VGTgOU3uNFTbugsISeTzadbpFCroYo
        BsbT+QMcY38hLoB8xtjbKSGJmxeCQusA73tYWV7DVrQm/G58r+l20Lv1PeERgUGy
        gjdet35hew3YR9FgpKs/vKk7CWN8MZN84RJ/R0iFMdW9R53xidGk3R4Q5K/gThne
        aOYNlT2kQzDNnaAITKbxj2OIleKWw==
X-ME-Sender: <xms:i-P_YH1IG-2kbvfdHrW6CQZ6L_QyrZvjK_DSb_QFOadVFCzyKPmHHw>
    <xme:i-P_YGFH8PhzPS9u1PGabCK4gE4LLgzWpTf02lF6aJ_DcrS5Ry1_vZ6mhtU3-UJIJ
    r3pP04cDvdq>
X-ME-Received: <xmr:i-P_YH7iO8FyTbe7bqIXO6RBdsXw7lx7w1iBEBjR-qNIiW6I3fTBgH5bHMCt9VSMLq1lBfOt4W2s6IhqlwiES8TJoCxvajA079bD7avtNDfEgnyawlhThcVvc6EphQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeejgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:i-P_YM0PCGnoqBoSt-OFaz7Jb4DKEhZt0YsvfwWR2mSYyK7gpjfG2A>
    <xmx:i-P_YKGs4IkMQkOs0zRRMXYlS_V_pw8cm5j2birwO5tLnO_5uSc0YA>
    <xmx:i-P_YN_CFNPjSBhWeG8vE1is8gIuBYU8P5TRo8fq3v6MHre-PRm0Xw>
    <xmx:juP_YF9Lbe0rwNFtXOg7D5qPaiSIVveImQNuYwKbLWAq0fZY1bhmOQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jul 2021 06:44:22 -0400 (EDT)
Message-ID: <2d4b407cad4270952a85951455cb722a4c435c69.camel@themaw.net>
Subject: Re: [PATCH v8 0/5] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Jul 2021 18:44:18 +0800
In-Reply-To: <YP/ZwYrtx+h/a/Ez@kroah.com>
References: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
         <YP/ZwYrtx+h/a/Ez@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-07-27 at 12:02 +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 16, 2021 at 05:28:13PM +0800, Ian Kent wrote:
> > There have been a few instances of contention on the kernfs_mutex
> > during
> > path walks, a case on very large IBM systems seen by myself, a
> > report by
> > Brice Goglin and followed up by Fox Chen, and I've since seen a
> > couple
> > of other reports by CoreOS users.
> > 
> > The common thread is a large number of kernfs path walks leading to
> > slowness of path walks due to kernfs_mutex contention.
> > 
> > The problem being that changes to the VFS over some time have
> > increased
> > it's concurrency capabilities to an extent that kernfs's use of a
> > mutex
> > is no longer appropriate. There's also an issue of walks for non-
> > existent
> > paths causing contention if there are quite a few of them which is
> > a less
> > common problem.
> > 
> > This patch series is relatively straight forward.
> > 
> > All it does is add the ability to take advantage of VFS negative
> > dentry
> > caching to avoid needless dentry alloc/free cycles for lookups of
> > paths
> > that don't exit and change the kernfs_mutex to a read/write
> > semaphore.
> > 
> > The patch that tried to stay in VFS rcu-walk mode during path walks
> > has
> > been dropped for two reasons. First, it doesn't actually give very
> > much
> > improvement and, second, if there's a place where mistakes could go
> > unnoticed it would be in that path. This makes the patch series
> > simpler
> > to review and reduces the likelihood of problems going unnoticed
> > and
> > popping up later.
> > 
> > Changes since v7:
> > - remove extra tab in helper kernfs_dir_changed.
> > - fix thinko adding an unnecessary kernfs_inc_rev() in
> > kernfs_rename_ns().
> 
> Thanks for sticking with this, I've applied this to my testing branch
> and let's see how 0-day does with it :)

That's great news Greg, and thanks for putting up with me too, ;)

Ian


