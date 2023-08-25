Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0DD788796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbjHYMgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbjHYMgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:36:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2D22123;
        Fri, 25 Aug 2023 05:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C9261381;
        Fri, 25 Aug 2023 12:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC29C433C8;
        Fri, 25 Aug 2023 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966958;
        bh=WZhoQI4SQ1PkbMB0aQ3u5RKKO+ivrApvlEQUhSgI2bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fb4oA3BIKH0w6JdT8obpdFYBfAKO79ukbitfPKI8nSPsDvooi3n+NuOedn+xWwZxO
         ZLxAv88KK12XJeUexGBxB5y5/9YxYdrtV2Kv9Vc0Ybs+W4AAGuxtMJOy+r0vb9dDsu
         lPcZzngxZtx2dffbxrVHbbLJSv4Ux+nNpZg6GViwVJxGGHV7yneA08Uyxkl4pOEPYt
         45fOoqFJRnaE35hC5muBwEjbJwEy0UVeDD/5fvAXewJWdmaKA4Ywa8nnTKSLk52A1i
         vtLymw/+8tV9nfn1STihYzk1GSY6DNbGKFBYvpa//x/za9HHgOCkdY283bCYa+mPwY
         YgB6SNPb/S+gQ==
Date:   Fri, 25 Aug 2023 14:35:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        reiserfs-devel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 27/29] reiserfs: Convert to bdev_open_by_dev/path()
Message-ID: <20230825-umjubelt-denkmal-692a41dcd900@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-27-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-27-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:38PM +0200, Jan Kara wrote:
> Convert reiserfs to use bdev_open_by_dev/path() and pass the handle
> around.
> 
> CC: reiserfs-devel@vger.kernel.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
