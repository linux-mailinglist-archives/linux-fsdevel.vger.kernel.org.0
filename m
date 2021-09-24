Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C65417D62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 00:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbhIXWCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 18:02:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46217 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344195AbhIXWCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:02:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3CF555C01A5;
        Fri, 24 Sep 2021 18:00:31 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute4.internal (MEProxy); Fri, 24 Sep 2021 18:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7Vv/8P
        v+UZoAhI3w3k5if5V+rn7G4D18VN5pDtkN3Qg=; b=N2UmUo9W40cwEwygwyGGTg
        fP7JZEorFQZAgaz9xxC4qqbSo4UML4Sd3CUm6j5qmGVDn5R61q0cZOQsdYqgl2pU
        6zx7wiDBxvUgXlQpDR2D8triuTCm9DrNmVHerUND4i0MXOs5Hh4w8qjwvZzNj2Vp
        O8H9Enf+MzsytWLmdxhPgXn41owI13tAua5eJSO7MN9Wuu8TBrKmp+/AegLxOcsB
        pBZ5fpYscSjjQsHuJ/F6Wg9OzVd1E6lfooyJcxhJjGTqf2HkLcJAO06gdVYGSc2+
        fTx0VcyK9bTTLHNSLPm1wGlRaxlzjmaeGvfGsnYCiDh5xWe3qvIgOUbfAsD6qVIg
        ==
X-ME-Sender: <xms:fkpOYepZbCtQFJR9TVYG3irXpC5CacbnxBz82FbQpz0qhXWdIhncIg>
    <xme:fkpOYcqgmO1rnjrQqfNnSNs4cY_OTyRjwTMs25H01qd92hfj2XMuddRU6hoFhxiNy
    lGe7Fi3pl3N5gPy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejvddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevohhl
    ihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheegheehieeludegleelteekieejheeuteetgefgiedvkedugefh
    hfeuffelvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhg
X-ME-Proxy: <xmx:fkpOYTNKCqjZojDk2FePUHJBy0fiuv1fuoY5bYq2JykCnTZdJ8yZEA>
    <xmx:fkpOYd7V8rAFKCAcD7vxmJDeZfz7yyWrJipvFfoq0Ufp3dvZooljuw>
    <xmx:fkpOYd5HdmzaBqd10ESMzRRoBMNutKBoUfZSHyZ5sm2x83wUAqRezw>
    <xmx:f0pOYbTAZn6Vrw9fhrENoguuH_z-e5NXTwBv--2fs8OEp6fAIbXcqg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E3F7C1EE0070; Fri, 24 Sep 2021 18:00:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <a02d3e08-3abc-448a-be32-2640d8a991e0@www.fastmail.com>
In-Reply-To: <20210924192442.916927-3-vgoyal@redhat.com>
References: <20210924192442.916927-1-vgoyal@redhat.com>
 <20210924192442.916927-3-vgoyal@redhat.com>
Date:   Fri, 24 Sep 2021 18:00:10 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Vivek Goyal" <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, selinux@vger.kernel.org,
        "LSM List" <linux-security-module@vger.kernel.org>
Cc:     chirantan@chromium.org, "Miklos Szeredi" <miklos@szeredi.hu>,
        stephen.smalley.work@gmail.com,
        "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Fri, Sep 24, 2021, at 3:24 PM, Vivek Goyal wrote:
> When a new inode is created, send its security context to server along
> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SYMLINK).
> This gives server an opportunity to create new file and set security
> context (possibly atomically). In all the configurations it might not
> be possible to set context atomically.
>
> Like nfs and ceph, use security_dentry_init_security() to dermine security
> context of inode and send it with create, mkdir, mknod, and symlink requests.
>
> Following is the information sent to server.
>
> - struct fuse_secctx.
>   This contains total size of security context which follows this structure.
>
> - xattr name string.
>   This string represents name of xattr which should be used while setting
>   security context. As of now it is hardcoded to "security.selinux".

Any reason not to just send all `security.*` xattrs found on the inode? 

(I'm not super familiar with this code, it looks like we're going from the LSM-cached version attached to the inode, but presumably since we're sending bytes we can just ask the filesytem for the raw data instead)

