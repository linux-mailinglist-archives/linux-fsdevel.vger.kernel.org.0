Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA86775C4A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 12:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjGUK0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 06:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjGUKZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8141FED
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 03:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 268DD60959
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 10:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B9FC433C9;
        Fri, 21 Jul 2023 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689935143;
        bh=PmU6TNptH/4YslZ3T2DXgS0PyWo4kREKL3HWj/QV/0I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KRyxHSSC4ptVPthlqaeRS8QkPve1DUXnSRmLWjHVwPiFbEislYhgAQAh8hoaZmCSO
         KLuOcDzwJeknxkxopzI1Hp83qAq24Rta6/nGeRY/EGYdj7eWwZpr5i4Cdas/R1Jxur
         4l58eKFplSXT9/rXSUEnWBvm1MXg1clU9RfXyhtXWs6kLaYFKU4FEHR1ixSadMhViT
         wDybqhpav0MRCk4xej0+hv0Cs4e/TG2GWpAenq00bI/KagOxNLHOXxaI6rZoikGqyF
         hUoV+TBtis+jHNwI3i0vN4zbV6tbjryAcIsFrnBHcDhTQjKUax6vwJLJgmbAZAg1uj
         yh/f8tUOZMR8A==
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, Jakub Wilk <jwilk@jwilk.net>
Cc:     linux-fsdevel@vger.kernel.org
In-Reply-To: <20230721092147.6009-1-jwilk@jwilk.net>
References: <20230721092147.6009-1-jwilk@jwilk.net>
Subject: Re: [PATCH] fs/locks: Fix typo
Message-Id: <168993514301.9557.2222461409698438372.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 06:25:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Fri, 21 Jul 2023 11:21:47 +0200, Jakub Wilk wrote:
> 


Applied, thanks!

[1/1] fs/locks: Fix typo
      commit: f9d742d5b7e808776aa5f0fd31c6b7ce41174bb7

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

