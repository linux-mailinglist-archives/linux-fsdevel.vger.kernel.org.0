Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1680788666
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 13:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbjHYLyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 07:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244433AbjHYLyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC391FD7;
        Fri, 25 Aug 2023 04:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 451A8611F8;
        Fri, 25 Aug 2023 11:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42623C433C7;
        Fri, 25 Aug 2023 11:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692964442;
        bh=7vYvDv53Qfsc9lztqKf86jQkrjyx/7WVIDUOIPkuswE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7o5EiQLdvRYz+qYxbX/TROFT3dSdXMKpHI6qJwQgp1SLwejltkLCqZzx/a7w6rFd
         CNEYT5ScHWTc7veElEyP0lnhWhHknSgNeMbkgTpNxjK+BMkD37e5va62NSWzMQZgit
         /uEtlKgZkry1aO2gFUcasl/NjRO74JUo4hhmznHZX37hwCYTmt/HMhK9rkzuIxEdfV
         FqgU6IUVeugesKRjY2NwslpRus56ybS/zJ3Sf1qiR0R2RtAbBlLQOtWxpbRWSYW/7N
         zRv/J3Pm/FFzfnoPDv0+34NqYuJe6qUomjWFFPYAgBCmOl4CqjPOup3WzXYtiC6H/0
         E9RidzIOfTQfQ==
Date:   Fri, 25 Aug 2023 13:53:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/29] pktcdvd: Convert to bdev_open_by_dev()
Message-ID: <20230825-identisch-herzhaft-1fa19d1706b3@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-5-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:16PM +0200, Jan Kara wrote:
> Convert pktcdvd to use bdev_open_by_dev().
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
