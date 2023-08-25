Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6EA788703
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjHYMUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244775AbjHYMTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5E7272B;
        Fri, 25 Aug 2023 05:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C05DE6146E;
        Fri, 25 Aug 2023 12:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509F0C433C8;
        Fri, 25 Aug 2023 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692965838;
        bh=DRP+MwyDiwzoSnCHsUAnFI1QPHwF+zkSyUk6n+Nxf4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vj0yH6wyZv5E3G/MSN9jq6dGTIZdbSsL3WZ0RewbskJKdStKRf5eH/9Q7gv+qmJZW
         vDwKmwmO7ZLs0O+3ZCAgsFzHhS2QkCD1MCv1NtUDS5EW3hivNMwWjzI8/6GiAafkY8
         VskwCOmXjqSGpd6zRMSE+TCPN2wQBVEKFt0IZGIZ8/5je6nODj8aM8f0EznmkLd8nJ
         fVzRuIjxbWII6n7Sx+o/IruzTQvgeMS+YraYzzFJFiB650ngWrySo3IW838Hgeu+e1
         Is7oJ8pOV04Qi2g732se8XovYqn23x2nJ5BafmQuqoW7c7KUxcg4eB6zPfXrhBgWDE
         HnoRv8LJa6Ilw==
Date:   Fri, 25 Aug 2023 14:17:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 16/29] PM: hibernate: Convert to bdev_open_by_dev()
Message-ID: <20230825-limitieren-badeunfall-9819911f83c1@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-16-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-16-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:27PM +0200, Jan Kara wrote:
> Convert hibernation code to use bdev_open_by_dev().
> 
> CC: linux-pm@vger.kernel.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
