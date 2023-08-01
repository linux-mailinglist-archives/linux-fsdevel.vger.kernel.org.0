Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F5476A9DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 09:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjHAHTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 03:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHAHTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:19:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCFDDA;
        Tue,  1 Aug 2023 00:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 774B7612FB;
        Tue,  1 Aug 2023 07:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3C9C433C7;
        Tue,  1 Aug 2023 07:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690874348;
        bh=jnyy5lbqh8mKeSlCJwRDU0YAxsEpR+81SdigSgifSek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5orV3In/o/+my1+x2Cl/d7BP+kFQ6XA9J9sj8S/DFdXrRcfYpvKbwXyp8i1vU59h
         VC5nODiveAkHwtveFBxKHjWTOBy/g7o74VbVJo0ZhLR979cpgmdAsSSDYc8098H6CQ
         yIUGGKbD8uNNwUHjVlEkhyLIdi9jMWtSJAjNdP9se0sLZ89Q4ZO20CkVRdtviyYdL9
         r0HjGEgwwUinapusUiDfhJMOqzec+Zx9je6YYlZewQhVy6wpu5DaH76yMI+91xW3E0
         dn7dErk4xOEai9r2u5JiNvv+/IiqP9FSXdiuiXLID90dYJCQ/kOvNdkEG39KIqLSoI
         vTueQME4V9HEA==
Date:   Tue, 1 Aug 2023 09:19:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] erofs: drop unnecessary WARN_ON() in erofs_kill_sb()
Message-ID: <20230801-halbe-bankgeheimnis-792a18bdc440@brauner>
References: <20230731-flugbereit-wohnlage-78acdf95ab7e@brauner>
 <20230801014737.28614-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801014737.28614-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:47:37AM +0800, Gao Xiang wrote:
> Previously, .kill_sb() will be called only after fill_super fails.
> It will be changed [1].
> 
> Besides, checking for s_magic in erofs_kill_sb() is unnecessary from
> any point of view.  Let's get rid of it now.
> 
> [1] https://lore.kernel.org/r/20230731-flugbereit-wohnlage-78acdf95ab7e@brauner
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> will upstream this commit later this week after it lands -next.

Thanks,
Acked-by: Christian Brauner <brauner@kernel.org>
