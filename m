Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A31A78C497
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjH2M5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 08:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjH2M5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:57:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C41BD
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 05:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DA0764976
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 12:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7FEC433C7;
        Tue, 29 Aug 2023 12:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693313821;
        bh=/YsoHGMXrAJJgbTvV/tpchNzSAnlk2yVO2g2LonD7dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVZqerjsYIwnr6PA5h70tF06XxKKcCC56/vVFXeLQPz6pSWGEf719SKKWFYiSn5Ch
         41n9bOjADgNxln+ZGiSyWCfXVhXICfQVtF9AMUM8gd4Bu/Pu4swEIEtYsvIi+Kt+Zo
         4+yUVgkqIBZ/cuve5hWVoJsh3j5dWyu5Ck31RfCXufMW4ekZbgwmWgDpe5/A/OTEUE
         Sc56CaS0rKVqE+CnShhPLGjazx7Eo46NUk2PqaKAuzFLG1jXu9cuaWEfMQK2zs3PZm
         3zDcML4jX4fap39K52mtwDj1t+Q08/jAyJ1sFO5cfN1YH2FG1A0ohyP5gHIKzFXb2i
         cR2qoOXqVH2Qg==
Date:   Tue, 29 Aug 2023 14:56:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: mtd
Message-ID: <20230829-erzeugen-verruf-6c06640844b0@brauner>
References: <20230829-weitab-lauwarm-49c40fc85863@brauner>
 <20230829125118.GA24767@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829125118.GA24767@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:51:18PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 29, 2023 at 01:46:20PM +0200, Christian Brauner wrote:
> > Something like the following might already be enough (IT'S A DRAFT, AND
> > UNTESTED, AND PROBABLY BROKEN)?
> 
> It's probably the right thing conceptually, but it will also need
> the SB_I_RETIRED from test_bdev_super_fc or even just reuse
> test_bdev_super_fc after that's been renamed to be more generic.

I'll rename it and use it. Let me send a patch.
