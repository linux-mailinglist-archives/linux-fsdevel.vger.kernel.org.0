Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A87E7D55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 00:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfJ1X5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 19:57:43 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:50035 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbfJ1X5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:57:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0205F1EC;
        Mon, 28 Oct 2019 19:57:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 28 Oct 2019 19:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        CGVPASuZRFHDMF5MO5orcFiCcg7SbWl1Kh7m8GPvzps=; b=con/xvIvJt8ee1lE
        YSvM18Ud3lmamaVK+4wDWSaJa3P3EfZvGs0bLh2I7G+jZyWyDlDoB07Hkp/Aj4pP
        je2T+5z+wobG/Hkv8EECp8vL8bZeV32CXJjr15DlexOo8d4/Jj3Jkq0FKdr4TJvI
        tlk8X7xBnBQ6KU455X3D37qsAU5J/M5VyTxgE4sD+T6mY7EAX27FNoMgBXq2Afs4
        gabssJNTcX7W+vexsganfgCsABztYL7gtKFdVhaHsde+pwfBhceb/qfiCVEjudnW
        qgSStdOEHwabdKAQawyB3+Q1j1QEz6zg5bBvXW8Cza02TudBMV6Qurzk/w0igb9/
        XuFyEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=CGVPASuZRFHDMF5MO5orcFiCcg7SbWl1Kh7m8GPvz
        ps=; b=wiNJta5wyceI8IgsK5pbqxgnJBJTGU4U6X4o7jyo972K4DXqUJfmVfIxd
        n1aixQtX7cqeAGqIIIQi9tSzYaH269vsxuWzSnZCKmEe9zhTSFZMLPAveDjSyR/P
        IHetzg1N+AiljKtq++GoMx91gT5oLN7KdsJclpZ7yruudnEN7XMa3zh6SKyG7/+9
        lRQ49iUkYo9vW3l7X3/EHNxBtq9snU+ItmlxYmkJDhh3QYDgCng88egMVfgHK16U
        VQgXnkNmKjjBxoGRBKlddkcloDlBhzyDf7XG1dR72PiD1Uk8G/f1iIGKvnZtZUNQ
        LPMC2O5r1R9B6Zj95JbmJHWROdxKA==
X-ME-Sender: <xms:cYC3XbBSi5WIrnc1IRkuMYbxSVylSs5nNX99Rh9BqOi0ZIySoaQuFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddttddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtke
    drudekjedrfedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgr
    fidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:c4C3XYQ_PHD7fcBWILMflEZGi005z2fZZPb6lVADvpkJPuEi-t1nkQ>
    <xmx:c4C3XeuXGdbH9G9XLFYgGKD1_UJ2JeLPUmkBzmjVEdR0lEEYOICN-A>
    <xmx:c4C3Xen2gmTBVUHmGnl3bqfPkTUU5IC-XjFSduXKrgOeY0mvpvqnmg>
    <xmx:dYC3XZAQWEPA6FLfYqzY6Ua5g8OPIUTi7V2gH9g7qHJU63W37okO2A>
Received: from mickey.themaw.net (unknown [118.208.187.32])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8DB6D60063;
        Mon, 28 Oct 2019 19:57:34 -0400 (EDT)
Message-ID: <2dcbe8a95153e43cb179733f03de7da80fbbc6b2.camel@themaw.net>
Subject: Re: [RFC] Don't propagate automount
From:   Ian Kent <raven@themaw.net>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     viro@zeniv.linux.org.uk, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 29 Oct 2019 07:57:28 +0800
In-Reply-To: <20191028162835.dtyjwwv57xqxrpap@fiona>
References: <20190926195234.bipqpw5sbk5ojcna@fiona>
         <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
         <e5fbf32668aea1b8143d15ff47bd1e4309d03b17.camel@themaw.net>
         <d163042ab8fffd975a6d460488f1539c5f619eaa.camel@themaw.net>
         <7f31f0c2bf214334a8f7e855044c88a50e006f05.camel@themaw.net>
         <b2443a28939d6fe79ec9aa9d983f516c8269448a.camel@themaw.net>
         <20190927161643.ehahioerrlgehhud@fiona>
         <f0849206eff7179c825061f4b96d56c106c4eb66.camel@themaw.net>
         <20191001190916.fxko7vjcjsgzy6a2@fiona>
         <5117fb99760cc52ca24b103b70e197f6a619bee0.camel@themaw.net>
         <20191028162835.dtyjwwv57xqxrpap@fiona>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-10-28 at 11:28 -0500, Goldwyn Rodrigues wrote:
> Hi Ian,
> 
> On 10:14 02/10, Ian Kent wrote:
> > On Tue, 2019-10-01 at 14:09 -0500, Goldwyn Rodrigues wrote:
> <snip>
> 
> > Anyway, it does sound like it's worth putting time into
> > your suggestion of a kernel change.
> > 
> > Unfortunately I think it's going to take a while to work
> > out what's actually going on with the propagation and I'm
> > in the middle of some other pressing work right now.
> 
> Have you have made any progress on this issue?

Sorry I haven't.
I still want to try and understand what's going on there.

> As I mentioned, I am fine with a userspace solution of defaulting
> to slave mounts all of the time instead of this kernel patch.

Oh, I thought you weren't keen on that recommendation.

That shouldn't take long to do so I should be able to get that done
and post a patch pretty soon.

I'll get back to looking at the mount propagation code when I get a
chance. Unfortunately I haven't been very successful when making
changes to that area of code in the past ...

Ian

