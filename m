Return-Path: <linux-fsdevel+bounces-1316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4775E7D8F13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0254A282338
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566EE947E;
	Fri, 27 Oct 2023 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kqwCA5H/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OkSroYDB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED08F61
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:59:39 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5A9116;
	Thu, 26 Oct 2023 23:59:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 6485D3200B20;
	Fri, 27 Oct 2023 02:59:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 02:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698389974; x=1698476374; bh=LC
	OGIdEAA3K9vSNcOyI1UVHdJVWxI+vzkle3h6ak1Ik=; b=kqwCA5H/YNNXZ6ExP2
	gT1/jTuL5V0O7Xo2qBo52CBgSrj13ts7QJgCGyBN4V9iuJTk7Hz339IXjeyHvBef
	/SOCwgHvy9ltSDOiNRSzKhCBgOC/wWY1GvwHiwIvJwkAiRMxQnD/B639BIZhf0Qj
	PdhEwdd4urZIj8yZakkiKRb14jS0cphiFmKT6/3MlpIOOVe4t0X3SfCuT1bkEpKw
	x7Abe2cq9xRlQYLGARK7Bp738pWYdSOoHjFJY6NXjwgRr9R4Zul0PungSXb05hzj
	dgQ0cHBa07Us4MQqLMCDkzKKGC+n4NGn2cXD3qjSEE9dAyK5/proG8dRIR4iUAsx
	RPoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698389974; x=1698476374; bh=LCOGIdEAA3K9v
	SNcOyI1UVHdJVWxI+vzkle3h6ak1Ik=; b=OkSroYDBiyBePX4B7uIH2e+32IS0X
	4QZRV8PxECdgVB5X4wmpn7w4YS5oXaAliyYur/1zY9zBijYSfrUyZPIerVqkX8Rh
	6wZ1YWy+3YHBNzFREPR4I6vqFMLE4UJp5mkkJzJS6ZC1EAFL4c11uAiCmechIxY1
	FQIIAogF838aUgkrL5zF4ZvY2iAATzNir7WZAxXpH/6uPoAyikT+4QgwM9cIKMTl
	ARscWzHbmCgl4VRNe8bfPobwSVEgwevhm+8/us1WRiOdYScntyR3N3ICzKtpBZQZ
	jPU2Hqsm3ktff8hL4SD4B3NkS7C/AIjzpWWX5aItgvwlyRVNe2y1XYd8w==
X-ME-Sender: <xms:1l87Za_qxOeSCYVYhme02ynv0pIvYg1RN2VXvVWe21syge4Wbae2Fg>
    <xme:1l87ZatC-_zPOcpPHx3omUkOSn3b-5krJKMKNY_61nXg87qy2l-sRndTbvx_45KRy
    C-Lk3dR5bjCRMjpLsI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:1l87ZQBd5SsjxpNSMHjGoF4aj7vhp2yeyjhJ39O7x8Bz7l5CF1I0AQ>
    <xmx:1l87ZScFGsMyyXz5atxiK3W7P0cAX-Rm_isri5VGGiahlw1L0pxiyA>
    <xmx:1l87ZfP_7EA5xL21VCuAfV2rXvfLfqcvYde1RVRjtpktqj30M4U8Bw>
    <xmx:1l87ZUo8efIeOGNQubI6CFhLydtiJlgTy6F8oHSZ70yGaaiqsWNaFw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1BCAEB60089; Fri, 27 Oct 2023 02:59:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4bef4861-d3eb-4d48-bd8f-b31a000c6904@app.fastmail.com>
In-Reply-To: <20231026204540.143217-1-amir73il@gmail.com>
References: <20231026204540.143217-1-amir73il@gmail.com>
Date: Fri, 27 Oct 2023 08:59:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Amir Goldstein" <amir73il@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH] fs: fix build error with CONFIG_EXPORTFS=m or not defined
Content-Type: text/plain

On Thu, Oct 26, 2023, at 22:45, Amir Goldstein wrote:
> Many of the filesystems that call the generic exportfs helpers do not
> select the EXPORTFS config.
>
> Move generic_encode_ino32_fh() to libfs.c, same as generic_fh_to_*()
> to avoid having to fix all those config dependencies.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202310262151.renqMvme-lkp@intel.com/
> Fixes: dfaf653dc415 ("exportfs: make ->encode_fh() a mandatory method 
> for NFS export")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Christian,
>
> Soaking f_fsid in linux-next started to bring goodies.
> Please feel free to apply the fix as is or squash it.

I just confirmed that this fixes all the build regressions I
see with your series, as expected, thanks for the fix

Tested-by: Arnd Bergmann <arnd@arndb.de>

