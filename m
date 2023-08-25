Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2D378878D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244855AbjHYMfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244903AbjHYMe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD3D3;
        Fri, 25 Aug 2023 05:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4AA167B90;
        Fri, 25 Aug 2023 12:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A815C433C8;
        Fri, 25 Aug 2023 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966867;
        bh=ZlEtYeJ0Fb4cCq2rLpnhrjiWpGTm+FzeZW7Lh9WCQ9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0IR5tRkz+8mkQgM6lZUzi35j5J06dsoOsY0dPCEwuwcm23dyhtkOtmVKwh+Ftcxv
         Yq2Qet7XazOTjFLuekBRapj0gDrmOuHJK51Wnx3YLKgYlrh8DeNvWO3NAgABNnmv2K
         5oZp4uocqguVoRF5Hgzg9b1QL4FGz93kyWp6lr71kv9UANt88vemP0qnA8q6d4wPjG
         gji+/78hAerAz9l2M6lsXPcyQPe9UnK3gtqg9WNMCkQpIgE1DCX58dVIyQZEjsd6w5
         f/672T/Hh7rrBGOafGMwoABZN9KI+QvQD4dK/70m3sGD8tAv/6BZB/ALqtFmAa67Oj
         jx4PfcwG2Hqzg==
Date:   Fri, 25 Aug 2023 14:34:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 26/29] ocfs2: Convert to use bdev_open_by_dev()
Message-ID: <20230825-jenen-seminar-93ace481efa2@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-26-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-26-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:37PM +0200, Jan Kara wrote:
> Convert ocfs2 heartbeat code to use bdev_open_by_dev() and pass the
> handle around.
> 
> CC: Joseph Qi <joseph.qi@linux.alibaba.com>
> CC: ocfs2-devel@oss.oracle.com
> Acked-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
