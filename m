Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC587886A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbjHYMJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243802AbjHYMJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C77CE6B;
        Fri, 25 Aug 2023 05:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEC4562A10;
        Fri, 25 Aug 2023 12:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46318C433C8;
        Fri, 25 Aug 2023 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692965345;
        bh=A9hYoEtdYqPvvNy02Q4vGfdEgKX2NL7HBkrVt5uKT5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gar8v7WHyunX6NafvyoMv21TgpjRySG5wWWwywkvpUoRZuJpohd49KVMQDRcmYLMD
         F+3WFog89JICHgrt5F1T7YcpwwnCnk2E9sIo53QPnQBKUr5auJekEEc4QM6FGgLMv/
         ZU6zT54tilG/KOum1fvDbO8tcTrDNQxqMBTMOo8WZxt47bEU9GZqW7mo3MtAHARdh7
         Ro+Lq72+QI0E4kBdL7SSKNDUONHFYbqeKi3IrQuvSZux3EpQIu4S7X5oX7/CqoUMW4
         LFBiza2Y63pqsYyS3hCxec0c2rw5nvmwylIsqCHUo6l1WdOB1h83LX/sjRocpt14sU
         NTtnbsmHOre4g==
Date:   Fri, 25 Aug 2023 14:09:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/29] md: Convert to bdev_open_by_dev()
Message-ID: <20230825-sandgrube-glasfaser-347ce1a08a9e@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-11-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-11-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:22PM +0200, Jan Kara wrote:
> Convert md to use bdev_open_by_dev() and pass the handle around.
> 
> CC: linux-raid@vger.kernel.org
> CC: Song Liu <song@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
