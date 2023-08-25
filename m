Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DAC788717
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjHYMWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbjHYMWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CD026BD;
        Fri, 25 Aug 2023 05:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4356616CE;
        Fri, 25 Aug 2023 12:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3C8C433C8;
        Fri, 25 Aug 2023 12:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966059;
        bh=7Y6grj2FT5GOvbo1bOI6MQEx58HQdkXQfXY6hSmbcJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYOG+rNPzpZBD0bluZ7wyyOBNXC9m88X1i1HVXbYuVBytMarc0lcr8XXw54EvSs0h
         6PUaMbGkSr3UsdhclEpQOdPfvreUB/enfmdivhzO9Gy5fV5conOZcCb3vh7MZOK9u8
         SpUGdGiQcy30Kj1IqM6eM9XRlkBfcZDC1Pbx3RA09G2gXrXAhp1Vz0JriqrspPQTMY
         Cx4jiKiLa1yDyQPDopC8FjAWxZbKDV01LDqDFNcJi0V5UrikwTxZ33VAHdxI1ydmES
         y57Lg/5LWdpXxISrPvybxh1sQcM+6HeamL6mS+QRBgoAQ0I1BR1Ac5dhwtppSd7aw4
         1K/nvglgYkkbg==
Date:   Fri, 25 Aug 2023 14:20:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 19/29] fs: Convert to bdev_open_by_dev()
Message-ID: <20230825-kennwort-errichten-5bbe46573831@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-19-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-19-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:30PM +0200, Jan Kara wrote:
> Convert mount code to use bdev_open_by_dev() and propagate the handle
> around to bdev_release().
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
