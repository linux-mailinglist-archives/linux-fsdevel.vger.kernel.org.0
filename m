Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D5078863B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 13:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbjHYLqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 07:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbjHYLpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266C82105;
        Fri, 25 Aug 2023 04:45:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BDDC60F3C;
        Fri, 25 Aug 2023 11:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8804BC433C7;
        Fri, 25 Aug 2023 11:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692963948;
        bh=C/Pcuu5IG0dThGM4Wom5zG7Nf6knFhfYDojqjl77Sd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GW9D1vEDAkOpnLOtxcn4lydRjlI4IrMmzMtma931K0FSVcj/7mvnvZtkfCoAqfJlX
         1P7o2XTUikhNbmmqeiFLd4ki+eMjmV6c9B3nDIyKBSnPTWgZQYoXRRWreSg/PDqwZd
         AcZh6NhWXut33dKcn0+KUAORMsj3QPwovE6xOoiTZkFo7BO+Lv1mlA6MDCPnGATvMr
         5lmUYgIzRXzygcypcYqqp6+32SRrLmjcppYeFztU+izSBe+X//vCxnVZMPwegdTHyL
         4oW1jhB7Da2PEAl8jynfMT2DTOlcoq//dtrMP9GmF4rFhM9cXkmp1zgEhlIm5dNkSA
         bjVVMlC7eIgZQ==
Date:   Fri, 25 Aug 2023 13:45:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/29] block: Use bdev_open_by_dev() in
 disk_scan_partitions() and blkdev_bszset()
Message-ID: <20230825-ritzen-amtlich-0acf54b013b2@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-3-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:14PM +0200, Jan Kara wrote:
> Convert disk_scan_partitions() and blkdev_bszset() to use
> bdev_open_by_dev().
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
