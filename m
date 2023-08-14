Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440C877BAD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjHNOAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjHNOAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:00:31 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6C810DD;
        Mon, 14 Aug 2023 07:00:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3528C5C0189;
        Mon, 14 Aug 2023 10:00:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 14 Aug 2023 10:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1692021626; x=1692108026; bh=V4Mqsvn0mkFBlxGUCbEghrLXs9l8NfuTuHH
        E9sQ4L48=; b=avjl7gmH89v1HjLkGteWjWMg0ALJ3xJWEi1SFm3+qBT3D8OWrLy
        T5k4KlAs/xKVrhz4kEiRFF5C0RADWMgp+JDEh3XC5xMB0q4X1P8R11KDlMAPZ1D2
        +6tSrgeS8ojMFmvUV07hPAF1pAvA3i0GBQY2lsOIvuCZfjcnSntlBNZn5qkyoyfC
        iyVN/V2MGub6Ve5a3MyvvsfpY5csEqGZZHauJIDAhQy0UoZ8AQzai+EUdtZT511r
        xkB0CL8IyEtouxqpE9acZU6VraTDrAg6poLVBznB8VZK3nQd/iSdltHIo2sbcmjX
        3wGGu4QqQYmmAqIxC0LloCrNN9ozEIEVTJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692021626; x=1692108026; bh=V4Mqsvn0mkFBlxGUCbEghrLXs9l8NfuTuHH
        E9sQ4L48=; b=zUI+0irwTXuT11zSktr7ZXVi7c1ZMTv2YUkNpRZigW5Tb5rSbm5
        srV0m6y9y8zB7wQUJcfZYx2qKKY9kGdpwyPmbG63u7xfLWOFEu5jymTQFQtltfZx
        3MHwbnllyxBvD5+1oENVpGMARWLNn6uzailF3QHMeI7ErsRWchbd/XKMRsC/LDCF
        vlKUPgZWF8nYpYwPRBdyya7aSpQ6Yg/ZuF3MyMX3DB4rPleU/xbv4NGe4hwqtoCP
        +qPDa7leperHaBhgZhfdN6wj09dY1XBhxPXGrHphFfg5DJ2iNnCrguduXKiwgzbX
        MbCMvbrQKglURjOBoSXvatagtRIwXWKZZrQ==
X-ME-Sender: <xms:eTPaZD-nG9Q1TBizUrOaQ6xpU_t0LCCurgH1xN22qkQ58r2e2uJAlQ>
    <xme:eTPaZPvrEkC0f--0tnDIwIdH8inDIJi4SFuJWE9jnDd8hFXqWU8qqiprQreDwB0Uv
    G7aQ-iulehN1wUUXx8>
X-ME-Received: <xmr:eTPaZBBU1nSdXOO8PgyAMhyPhmc4_wa7mf3kbcX5DaTiG2u1WWX7SfLLVmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtgedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeortddttddunecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeevffehhfetteeffeelgefhffetueefhedtieekleefgeegtedutddt
    lefhhfetieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:eTPaZPeWa_IDgWNNBgNBIaKBadfs-5JMfssKbG4oYbTJDqvON2op0w>
    <xmx:eTPaZIP1aHvhQxblm1yBRLSMlNzGWY1sXHmsJUEf3W03Gn6mH1vkCg>
    <xmx:eTPaZBnX7kdiH3vEC_Uyfp6vmveqJDmEJCwhdTopnhBrr9YXMm0dwA>
    <xmx:ejPaZFqG1TxeYKup4hFxWr6hhvu0QIh4yHYoQMX_V8PF6Ldj9rVSHA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 10:00:24 -0400 (EDT)
Date:   Mon, 14 Aug 2023 08:00:22 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async
 fuse_flush
Message-ID: <ZNozdrtKgTeTaMpX@tycho.pizza>
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:02:35PM +0200, Miklos Szeredi wrote:
> On Mon, 14 Aug 2023 at 08:03, Jürg Billeter <j@bitron.ch> wrote:
> >
> > Since v6.3-rc1 commit 5a8bee63b1 ("fuse: in fuse_flush only wait if
> > someone wants the return code") `fput()` is called asynchronously if a
> > file is closed as part of a process exiting, i.e., if there was no
> > explicit `close()` before exit.
> >
> > If the file was open for writing, also `put_write_access()` is called
> > asynchronously as part of the async `fput()`.
> >
> > If that newly written file is an executable, attempting to `execve()`
> > the new file can fail with `ETXTBSY` if it's called after the writer
> > process exited but before the async `fput()` has run.
> 
> Thanks for the report.
> 
> At this point, I think it would be best to revert the original patch,
> since only v6.4 has it.

I agree.

> The original fix was already a workaround, and I don't see a clear
> path forward in this direction.  We need to see if there's better
> direction.
> 
> Ideas?

It seems like we really do need to wait here. I guess that means we
need some kind of exit-proof wait?

Tycho
