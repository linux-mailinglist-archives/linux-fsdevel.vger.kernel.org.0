Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282B788784
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbjHYMdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244936AbjHYMdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17747271B;
        Fri, 25 Aug 2023 05:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2A2A67B8E;
        Fri, 25 Aug 2023 12:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C784C433C9;
        Fri, 25 Aug 2023 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966785;
        bh=uPQVrJ2Qp0hlL77UOYpeG97O16LbNdtmeShJK8cwyNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYWxUt80JpgGffwLQ55XwQC2Q56DyVYtEXUo+SMtG/JBC1t891NEmQdJSl46mOrtp
         hb4x910PIcu0tWEwBlLx9OxhvzIyBzi+eJNQXgTu3UYWOZVzOEK9KxoXZX0zoWWA9P
         Isujbveq/sJcLHRarh2CzQpEarWFX3Nu36A1WglFIcsWVSlWaB3cdVxG7R0BOw+r/U
         PZQutTdDvE7svMdBtfgDP9fozcjrBkbtzkVJrP92VU/PdIa26nxWHQR2ROXBSDrL2Z
         zUg7+RSlHbo9jjl2X6ReAt8myKGG1Y5uJme6noqxNn3XMNOxygEua3zi0uyM37oY5f
         RsWNfA4+f2tmQ==
Date:   Fri, 25 Aug 2023 14:33:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 25/29] nfs/blocklayout: Convert to use
 bdev_open_by_dev/path()
Message-ID: <20230825-metaphorisch-leerung-cb3617f35ab1@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-25-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-25-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:36PM +0200, Jan Kara wrote:
> Convert block device handling to use bdev_open_by_dev/path() and pass
> the handle around.
> 
> CC: linux-nfs@vger.kernel.org
> CC: Trond Myklebust <trond.myklebust@hammerspace.com>
> CC: Anna Schumaker <anna@kernel.org>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
