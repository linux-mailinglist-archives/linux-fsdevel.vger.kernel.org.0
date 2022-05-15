Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F0752785A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 May 2022 17:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbiEOPKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 May 2022 11:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbiEOPKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 May 2022 11:10:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4621231340;
        Sun, 15 May 2022 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=axvVmi33DeujocKndik/gQGQ5UkNaKJVtqIyJ8nhb3s=; b=TOyNa3FyHcbT/7T+IWvLnXFDeM
        UZM7eijtdy/0swDO9O4WxTHa7Papw4R8anqOvKORTatndT2dCQJ7mHZv4u2Uhov0vDeokf8ijaKtd
        JzgqRtDbEYe4ZxSnc0bUaNuEc/y5ShXfqF08xZseixzXbnu8s1FKrTJtD7F8FAsfg+RN+7Fo1TIy2
        kyiZFAt1FOVbsyHed1TZ9ZxSGcxLSUgTgMsVn+R3h9pvCit1wERY+VlWOrvx6nbZoMapVuhGAId7p
        A/DuHL2TXXZBelXK0Kqo6A2QaZ16Vp0QdaOl9/USPkE30EkNWvuH18/JpMYq0yynnLoPj6wN1GG7F
        ovJ5OZwQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqFtA-004HCU-4k; Sun, 15 May 2022 15:10:32 +0000
Date:   Sun, 15 May 2022 08:10:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        patches@lists.linux.dev, amir73il@gmail.com, pankydev8@gmail.com,
        tytso@mit.edu, josef@toxicpanda.com, jmeneghi@redhat.com,
        jake@lwn.net
Subject: Re: [PATCH 1/4] workflows/Kconfig: be consistent when enabling
 fstests or blktests
Message-ID: <YoEX6BpaEQENFGrv@bombadil.infradead.org>
References: <20220513193831.4136212-1-mcgrof@kernel.org>
 <20220513193831.4136212-2-mcgrof@kernel.org>
 <88a9baff-5654-b5ce-f7ca-a74a832e359a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a9baff-5654-b5ce-f7ca-a74a832e359a@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 07:21:56PM -0700, Bart Van Assche wrote:
> On 5/13/22 12:38, Luis Chamberlain wrote:
> > We have two kconfig variables which we use to be able to express
> > when we are going to enable fstests or blktests, either as a dedicated
> > set of tests or when we want to enable testing both fstests and blktests
> > in one system. But right now we only select this kconfig variable when
> > we are using a dedicated system. This is not an issue as the kconfig
> > is a kconfig symbols are bools which are set default to y if either
> > the test is dedicated or not.
> > 
> > But to be pedantic, and clear, let's make sure the tests select the
> > respective kconfig for each case as we'd expect to see it. Otherwise
> > this can confuse folks reading this.
> 
> Is this patch perhaps intended for the kdevops project? If so, please add a
> prefix to make this clear (git format-patch --subject-prefix) when sending
> kdevops patches to Linux kernel mailing lists.

Yeah good idea for it to go into the [PATCH kdevops]. Thanks!

  Luis
