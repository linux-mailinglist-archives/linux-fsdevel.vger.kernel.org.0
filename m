Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF8F7B225C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjI1Qax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 12:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjI1Qaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:30:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8AC1A8;
        Thu, 28 Sep 2023 09:30:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29238C433C7;
        Thu, 28 Sep 2023 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695918650;
        bh=1ekqDyl7lHDdlq8/HskoVf76rK2FPc0mVQF0NCvk5Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwVVii8zRE31KxqZmoIkS05nUAtTg8bJNMmnZP8QdWx1qXQ9TAk5Xpt15FAfxXCBI
         9vKW9AgLcjTKWYZtQgpJfnfXVP3Dm+iEBYBXGIWz41fXqlMqx7/rDWRzZmv5q5ySU/
         8XvWQ/U+PqJXEM7ojp662CnGtipEe4Ws0LOS40QHMZF4kpXX4ikxXhQ8xFvU5JIBh1
         4mF+WqUu4iJaeRbG5FP+mFCZrKJYhaGFDA3btQvUVa7ozosv7sHJ3gRTvXnWBGVgg/
         gDDfrmXn8sm1jS1rmAqrfG4ogX8GRX0u5EUrPWodZ7yLno6IvuEi7cpEB6L44yBC1j
         X+cOV1jc10Fsw==
Date:   Thu, 28 Sep 2023 09:30:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Spelling s/preceeding/preceding/g
Message-ID: <20230928163049.GH11439@frogsfrogsfrogs>
References: <46f1ca7817b5febb90c0f1f9881a1c2397b827d0.1695903391.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f1ca7817b5febb90c0f1f9881a1c2397b827d0.1695903391.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 02:17:18PM +0200, Geert Uytterhoeven wrote:
> Fix a misspelling of "preceding".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 644479ccefbd0f18..5db54ca29a35acf3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1049,7 +1049,7 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>  
>  /*
>   * Scan the data range passed to us for dirty page cache folios. If we find a
> - * dirty folio, punch out the preceeding range and update the offset from which
> + * dirty folio, punch out the preceding range and update the offset from which
>   * the next punch will start from.
>   *
>   * We can punch out storage reservations under clean pages because they either
> -- 
> 2.34.1
> 
