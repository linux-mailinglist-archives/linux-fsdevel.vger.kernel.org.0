Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5A531475
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiEWPkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbiEWPkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 11:40:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE630556;
        Mon, 23 May 2022 08:40:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 06B071F94B;
        Mon, 23 May 2022 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653320438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q5xW2MKLZ0PrcQXBC+W3LnvI90dAc7ovuM4CkEA4Lvg=;
        b=Y1LwZxCcd+BtLUakYzp4wzLW0BBUNVSub2UJFXcsFvmVouyrkeG9mDeOh5+EjHDfcpGcBJ
        JlBiJa+/r2W2Z7+s354N2eRlzj+ee1oG/kBL5VvoHuI3rISJvM8iRZq+sUR/hA7V0Nd9Us
        OtiB+FSt/599nPDQSa9ZSvr0MOWXvuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653320438;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q5xW2MKLZ0PrcQXBC+W3LnvI90dAc7ovuM4CkEA4Lvg=;
        b=X3mOtteHh3d677lIh5HDjfJ3KW/llpzhi+JtCZyalPmmFdK+HBkSlqi3EZQRtl4UZKxyL2
        TyPIdO2w5R1c9jBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D0A3B2C141;
        Mon, 23 May 2022 15:40:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CFF21A0632; Mon, 23 May 2022 17:40:36 +0200 (CEST)
Date:   Mon, 23 May 2022 17:40:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: fix typo in comment
Message-ID: <20220523154036.uj2lpngyjswgurog@quack3.lan>
References: <20220521111145.81697-32-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-32-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 21-05-22 13:10:42, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Thanks. I've taken the fix to my tree.

								Honza


> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a1074a26e784..a21d8f1a56d1 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -738,7 +738,7 @@ EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);
>   * incorrectly attributed).
>   *
>   * To resolve this issue, cgroup writeback detects the majority dirtier of
> - * an inode and transfers the ownership to it.  To avoid unnnecessary
> + * an inode and transfers the ownership to it.  To avoid unnecessary
>   * oscillation, the detection mechanism keeps track of history and gives
>   * out the switch verdict only if the foreign usage pattern is stable over
>   * a certain amount of time and/or writeback attempts.
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
