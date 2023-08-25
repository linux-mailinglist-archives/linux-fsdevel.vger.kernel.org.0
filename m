Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FA7788707
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbjHYMVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbjHYMUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DDE2105;
        Fri, 25 Aug 2023 05:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB42563933;
        Fri, 25 Aug 2023 12:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF83C433C7;
        Fri, 25 Aug 2023 12:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692965891;
        bh=lPULMvZpyv2CV2PfY0kJaSAKtdROfn4DLtK7DAQ3cdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uP/PEWcNjV4El06ZRUg+wuowefCdp7ujx5aFWcGYYoL+SmemBoU2gAwtwlqNIEu+Q
         DrSLsPrHVxq4I08yWDUNk+VC7EA6wmBTdb9IbQyKhkaEalMQAlttTNyF1omaCqlSUh
         SCKfswaz9n7D6cQNkFJocXpad3F3X3m5yyVllzVnaPO7WijNvIy/CDPABd1+RoXq/l
         Go2EJwRHPPhwSn1hqpi4oJeaXpk0rXpNBoUB0W1KjfYoBjtGnG9qFx0Zn2zKgpheS/
         qP4WWnEpoT27UGoHZ7izb+Sk4lUdgzNzcJPA82/hNG0iSfwEYonpnx8A+SWNUnrp2e
         4UfVev132OZzQ==
Date:   Fri, 25 Aug 2023 14:18:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 17/29] PM: hibernate: Drop unused snapshot_test argument
Message-ID: <20230825-zugegangen-zeigen-45d79c8506d4@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-17-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-17-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:28PM +0200, Jan Kara wrote:
> snapshot_test argument is now unused in swsusp_close() and
> load_image_and_restore(). Drop it
> 
> CC: linux-pm@vger.kernel.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
