Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819DD2DF2A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Dec 2020 02:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgLTBii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 20:38:38 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57189 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726570AbgLTBii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 20:38:38 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A992E580280;
        Sat, 19 Dec 2020 20:37:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 19 Dec 2020 20:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        wYkrXGX5bqF3rN0X4kPI6tvW8uypdLSLd/RGKSp8NGI=; b=AW9vxUFmmnUjjRM1
        sAhFm/AOebjHh093xhh+CDRhXmvAhwfPOTAA4tcMCaDOBixt3OMgoFhudOqN/Ndb
        mnTLQmw3uhldFVfaSklFx9ckadObbRNU3CTuBKK3d/a7xsjngyYUMhRjrZETid6V
        0QvPgYDWvf/eA038pabT+Gx9uoCBxiHjHb3NW5KTamkqINpQrUcWOnWhZSv0glKX
        UHxXTeYFgWehTYggAkRR5kExGAjbAC6aZrynHI7MX2onz5vuy2ygk70YG4y24eKf
        /PM9Fy6WR2xin/SwcW+jZpWQtwu6H1qtygYdPYX6vvvqkvEuIEC0/7WNbZ45m7ZU
        VyrQhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=wYkrXGX5bqF3rN0X4kPI6tvW8uypdLSLd/RGKSp8N
        GI=; b=VITYEP9H1vPEW464PbO8MypkDAT+WN11nSzfbm17OsBedsFk6CdFh98Oc
        994R8KCqkaYTnZqeCJcsZOvPiw0cYFKa4UPOAl6iodZk9wtJOD+0YOqix+lpOLjT
        /dEQwUEwoVrhS8jHrQjqjiJByJan8JslIc1CdDNiI+XLKrcZoNf3DSEN/Bb+OAO4
        K28vNzJEoYZAoML0oLmS2NK7iYF/VVJOCRA1CDejdMWBm8CpltJE+6x3XipI2gBg
        BN80JB/aqpt3z9GAML+7nda9hN2sTJf01MfJkdRtcWaqrZ/KhAkNT7Dh+0TlO3xn
        UYfPAGtv1nq1hpouOT8kY/3UVMV4w==
X-ME-Sender: <xms:7qreXyBr5KXkkbAcxcESLEU8mBeYDmWRr1l-46fSqIuA_fsGAlGMPw>
    <xme:7qreX8h49qPcbPxAJhnCUIJekLU3xexKt3s4v4kH-BfzbHoIr-68Gisy58DKw-N4m
    lAKiRK8Z2oD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddtiedrieelrddvgeejrddvtdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:7qreX1l1NQAbtKLHW-GMcYkN6snv90bcDcpLJhkp_F_GiXeOlxiT6A>
    <xmx:7qreXwxZIL_rFsgIC5Dq1r1Z_KLFlcakYlioSHSF0a4XPabPa_SecA>
    <xmx:7qreX3R2Gizs4L7Oetz2lUgHufbW8KlYz1lLS_z_V51lKZVkGS-5BA>
    <xmx:76reXwTFjztl4m-cCdGxnyUfEresqmRwD1fWETNFzDPiVAXGEypZWw>
Received: from mickey.themaw.net (106-69-247-205.dyn.iinet.net.au [106.69.247.205])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3E51224005B;
        Sat, 19 Dec 2020 20:37:45 -0500 (EST)
Message-ID: <352f587fe4e24a8bea5f841b5f93df92164072d0.camel@themaw.net>
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
Date:   Sun, 20 Dec 2020 09:37:42 +0800
In-Reply-To: <f1c9b0e6699582e69c0fb2e8afb40ddaf17bdf76.camel@themaw.net>
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
         <f1c9b0e6699582e69c0fb2e8afb40ddaf17bdf76.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-12-20 at 07:52 +0800, Ian Kent wrote:
> On Sat, 2020-12-19 at 11:23 -0500, Tejun Heo wrote:
> > Hello,
> > 
> > On Sat, Dec 19, 2020 at 03:08:13PM +0800, Ian Kent wrote:
> > > And looking further I see there's a race that kernfs can't do
> > > anything
> > > about between kernfs_refresh_inode() and
> > > fs/inode.c:update_times().
> > 
> > Do kernfs files end up calling into that path tho? Doesn't look
> > like
> > it to
> > me but if so yeah we'd need to override the update_time for kernfs.

You are correct, update_time() will only be called during symlink
following and only to update atime.

So this isn't sufficient to update the inode attributes to reflect
changes make by things like kernfs_setattr() or when the directory
link count changes ...

Sigh!

