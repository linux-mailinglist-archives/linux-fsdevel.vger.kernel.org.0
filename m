Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1C0788678
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbjHYL6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 07:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbjHYL5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD0310FF;
        Fri, 25 Aug 2023 04:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26AA661CFE;
        Fri, 25 Aug 2023 11:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C591DC433C7;
        Fri, 25 Aug 2023 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692964661;
        bh=0oBCfRCkdN9zn5fZXIJByG7SawkZf3x+xFFUDBNkkqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWkwCaaMypYmVniN0r9wIs9iX0wEmHZoh5fHoXia8QrP2HgvC6KwQ6lsyJnsYFzvg
         MnAFsDthK0TDIWExf8YRkSBv7+vM8hcNJSVz9NbFaOof4YPJHQfj0QEZ5p9A2HicJs
         aUJrac9oCAkUQtVqWbK0Rqwd0tH+s+s78PWE6m6ZU5qG22qgxkPBezq6r83r2PhV9C
         L7beZTO8ZntoCE3pIz+CdMWCjljqT9Y6Oe4h+mw+kXHKgFxEk7Kwo4psqIlJVOUkSW
         wgpFfq9WSc7zQ68vc9sFsDqypZ73ymx4q29w24i4yTBrAEQovh511P73DMB3zkoWG6
         IJIlPK13MTxeg==
Date:   Fri, 25 Aug 2023 13:57:36 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/29] zram: Convert to use bdev_open_by_dev()
Message-ID: <20230825-messtechnik-wahlweise-311b5b5c47a2@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-8-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:19PM +0200, Jan Kara wrote:
> Convert zram to use bdev_open_by_dev() and pass the handle around.
> 
> CC: Minchan Kim <minchan@kernel.org>
> CC: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
