Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57CC760CFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 10:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjGYI2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 04:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjGYI2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D0A10C8;
        Tue, 25 Jul 2023 01:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D91B614BF;
        Tue, 25 Jul 2023 08:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7FDC433C7;
        Tue, 25 Jul 2023 08:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690273694;
        bh=88KLsMWz0HJgJ+PfirFGz8ume57SExj7s7YVmhHajTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMf44QlQaBa3FYIxdxL+C3EeocXvkoyPIkSW02naZFG+cm6dEgusyctX4TzzbrXZM
         WO4Y4oNNYaodv0GZgdbqsW8m5A0RZvcudLbyzjBBNFL05LzokcMynYgqvUPyGxkgWh
         7l2MmT4Ga/dj5jIj08WunS/BlqUfSgW0uIn1jtOr0ok+A5JJ9JVvow30gJBwgWyG4X
         ggROF1R/pAoTYzyzi9DtcQilmsw8ooBNiR/SAqEjMxP5dSWJNb9fnvsbN964mwhi/4
         CD8XLXm+GQx1zx2oUpGffyci6Ay9eV+/koHSxYu64EYfnA3plqa8iWMhbSgTdMxgxx
         ivym9k1BswYXQ==
Date:   Tue, 25 Jul 2023 10:28:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [biweekly bcachefs cabal]
Message-ID: <20230725-indiz-hinlegen-0c99aa14ea2d@brauner>
References: <20230710164123.za3fdhb5lozwwq6y@moria.home.lan>
 <20230711-glotz-unmotiviert-83ba8323579c@brauner>
 <20230724171219.ok74izghpoxgtfak@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724171219.ok74izghpoxgtfak@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 01:12:19PM -0400, Kent Overstreet wrote:
> On Tue, Jul 11, 2023 at 09:30:57AM +0200, Christian Brauner wrote:
> > On Mon, Jul 10, 2023 at 12:41:23PM -0400, Kent Overstreet wrote:
> > > Cabal meeting is tomorrow at 1 pm eastern.
> > > 
> > > We'll be talking about upstreaming, gathering input and deciding what
> > > still needs to be worked on - shoot me an email if you'd like an invite.
> > 
> > I can't make it tomorrow but I'll attend the next one.
> 
> Hey, checking in - are you coming to the meeting? It's happening right
> now

I was traveling back from vacation yesterday and worked a bit on the
road. Sorry about missing this. Can you please resend the invite I can
accept. But I also somehow thought it was Tuesday.
