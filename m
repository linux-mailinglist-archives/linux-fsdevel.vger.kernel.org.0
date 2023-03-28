Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03C96CB3A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 04:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjC1CP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 22:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjC1CPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:15:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3BF26A2;
        Mon, 27 Mar 2023 19:15:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2EB55320024A;
        Mon, 27 Mar 2023 22:15:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Mar 2023 22:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1679969750; x=1680056150; bh=VSoRs4qx31
        DQtHX69enCiD9vEWuY3FDOWU9BPyRADKQ=; b=pCSi51z70vfQIiYPF5Z2HW2KIV
        wgdN8H2gqjkHakQc6TFWUcoZTlCahT+CIy0+eMf0v0mdaqY1QgibuREKwJko419G
        G/138jn6znYMEvLBp4qFGMO+Pxj9yuktt8grhXyNCLjuKEpQna/4FJCeoyQxTKqI
        ymTyGoZxWLicwZVkFOFDXGf1n1xa0ov35/G5IHr6d3/w2bPC4JDXMthIk9SdslI7
        ntrE7zxuVbRIQSnMwmOv7qj7h/T58ahBi43PsslLphRF3H93RgViSHxzab424yJS
        4qAJtcdo9HXlZsuqnsYBTH6XWkpjzlXGiajgF0T2hZvbdeRhZmsNkzmw+y3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679969750; x=1680056150; bh=VSoRs4qx31DQtHX69enCiD9vEWuY3FDOWU9
        BPyRADKQ=; b=IvmlCEWAfUTMyy+re14E5OJOlIckx+q1aRHrEtm9Yvxe4PW1uYx
        ZyB/4SioVTlWZQTgUHEW7yZTR6BfdFwgLPiowT/NIcQjhh2jj2iQDvyVnDXUUXdJ
        bbqP5P8pE1XpgQx1XPkCkIagwl3lDpQFGclO5nHro55Hik6yKqYsmQ7hK2k+iOdk
        OVCu1eVJz2QVSQ3/5ilLiNvXys/SHf9B+548a+ca5xg6d1NIdzHLWoo4ExNd/TOc
        AMrWNF8GZGq8oGelz5cjurXBPBFrCVhQF9LnZhzHsr4gACspDni+gzpKn1FPT5Q+
        IeIdeuvTI3quhY0OAH/XoIKmbj2aW/Xs+Bg==
X-ME-Sender: <xms:1k0iZE-iCoEkelN8O2NMkpYy_otvOHoOREhtDgf35zlrWQtZC4pcKw>
    <xme:1k0iZMsxJOrsIRb5BPcIdDH_xFETWP3R7K9TN6N-xz8i7DYyLUwCEwFNM2605aXn3
    milNz4ucysTJwpwa80>
X-ME-Received: <xmr:1k0iZKDtqR5gmM1RCaKDD9jypzlh2iXYGOYcYHIzTZn1X0rhufXpmCSkOxALJdDjGlO9JrLJ_w4sDR4Qw0zxg-APUmCDf_viUY4u_4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeflohhs
    hhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqne
    cuggftrfgrthhtvghrnhepgeeihfevvdeklefggfejjeeugfduudeggffhjeehkeegheel
    tddujeffjeekheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:1k0iZEdZO86Tv0ffeWGU37_QIGFI6S_aEBax-8WO7lKkaXpPtUROMw>
    <xmx:1k0iZJORMj3IF25mqjkH7k7qucnoGjbvNlYAcT6cL0T41J6waXj7ng>
    <xmx:1k0iZOmpvKt13ndo2DOfUUj-ozfTQTUjOQY5Yw0zFd5jHG4ZnLfBJw>
    <xmx:1k0iZOrqmsKYkRlrvXJOV9QrvGNWpa3iPHuRo6QarwIwwMgjdagXMw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 22:15:48 -0400 (EDT)
Date:   Tue, 28 Mar 2023 11:15:45 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
Message-ID: <ZCJN0aaVPFouMkxp@localhost>
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
 <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:14:29AM -0700, Linus Torvalds wrote:
> On Mon, Mar 20, 2023 at 4:52 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > So before we continue down that road should we maybe treat this as a
> > chance to fix the old bug? Because this behavior of returning -ENOTDIR
> > has existed ever since v5.7 now. Since that time we had three LTS
> > releases all returning ENOTDIR even if the file was created.
> 
> Ack.
> 
> I think considering that the return value has been broken for so long,
> I think we can pretty much assume that there are no actual users of
> it, and we might as well clean up the semantics properly.

If there are no users of this and we can clean up the semantics, is
there a strong reason *not* to make `O_DIRECTORY | O_CREATE` actually
create a directory and atomically return a file descriptor for that
directory? That seems like genuinely useful behavior that we don't
currently have a syscall for. I didn't see any suggestion in the thread
for reasons why we can't or shouldn't do that.

Would that break some existing software? It doesn't *sound* like it
would.

As far as I can tell, that *also* wouldn't cause a problem with
O_TMPFILE, because older kernels will still fail as desired, and we
wouldn't change the behavior of O_TMPFILE on new kernels (it'd still
create a temporary file, not a directory).

- Josh Triplett
