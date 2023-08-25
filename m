Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7B788636
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbjHYLod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243103AbjHYLoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CEB2102;
        Fri, 25 Aug 2023 04:44:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49E436248A;
        Fri, 25 Aug 2023 11:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A50C433C8;
        Fri, 25 Aug 2023 11:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692963844;
        bh=plPhJwNAILPedp/4xhPGYcWv/GNH030YRAJOFv7vvxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sak3PHVVG/k3TXAFL4H/LUFpnCBLJ3JFp/yh4go4O+MHL7l3hrHcOKQsqwhpqkFkW
         6HVWNlVSsvEoN5NGyuUqi/baD7ld0e9SAa9iNQDKhCKHfDyoMoqV5h4c5E3skPXA0d
         4o8Me023r2/JA24+KpaU4HEzUHq1uM7RQthWwX0CLJUyhq6qwtQGey8Z1/8CKPoyhm
         QRpjlbtSm2XoUmL5eBzjeGjDLE7H8z1V4cOJR2N521nGBntf1Tk9F4U8TQD3xe0EyC
         Q+Zr46wYlexcV0wjSAbWG/G5M/41fOgFVfJ/Pz64/5aPU3G683M8mEEokbyU1K/xko
         rzxxJuVOiawJw==
Date:   Fri, 25 Aug 2023 13:44:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/29] block: Provide bdev_open_* functions
Message-ID: <20230825-mithelfen-anregen-1275c7750d9f@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:12PM +0200, Jan Kara wrote:
> Create struct bdev_handle that contains all parameters that need to be
> passed to blkdev_put() and provide bdev_open_* functions that return
> this structure instead of plain bdev pointer. This will eventually allow
> us to pass one more argument to blkdev_put() (renamed to bdev_release())
> without too much hassle.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
