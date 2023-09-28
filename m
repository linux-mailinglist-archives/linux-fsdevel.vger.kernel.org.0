Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7FE7B2056
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 17:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjI1PET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjI1PEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15388195
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695913409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4bUPrdIKvWj+SjiVEtURjGS7hdKH8izlAOVqPCBjbUo=;
        b=cR7eBCj95ZqIMgQpC3LyDM0H651XEtmiGm5+ntxfnXYM+24mP0O7bMhtE5+ZUzlguTZ931
        ngFid+H25IgKR+/+sAqxo9criYLeINlgWNvOoGNppcC1met3vnIhbxm+aN0/4nl7PkBYzM
        jn0U0M90E1xqXtJ78jBWTOFDtd2SpUM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-LyjH_8K-MK-Uh8CbeOwP3Q-1; Thu, 28 Sep 2023 11:03:23 -0400
X-MC-Unique: LyjH_8K-MK-Uh8CbeOwP3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3155811E88;
        Thu, 28 Sep 2023 15:03:22 +0000 (UTC)
Received: from redhat.com (unknown [10.22.10.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE27940C2064;
        Thu, 28 Sep 2023 15:03:22 +0000 (UTC)
Date:   Thu, 28 Sep 2023 10:03:21 -0500
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Spelling s/preceeding/preceding/g
Message-ID: <ZRWVuQc7Fl+RKUeW@redhat.com>
References: <46f1ca7817b5febb90c0f1f9881a1c2397b827d0.1695903391.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f1ca7817b5febb90c0f1f9881a1c2397b827d0.1695903391.git.geert+renesas@glider.be>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 02:17:18PM +0200, Geert Uytterhoeven wrote:
> Fix a misspelling of "preceding".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

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

