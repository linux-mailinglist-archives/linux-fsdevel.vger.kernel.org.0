Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B137A779C90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 04:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjHLCRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 22:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHLCRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:17:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95258C5;
        Fri, 11 Aug 2023 19:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CBD16119B;
        Sat, 12 Aug 2023 02:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B424C433C8;
        Sat, 12 Aug 2023 02:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691806622;
        bh=KkGApD2bQBxfwXufVKLzvLsVh2fjASCPPP51XodQzmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eiqzcNxrOSSQ6E1KFA9DV6ukfVf+hhsy6F7f35fibpb/sM5K4u7TIKc+zRzG+7Amz
         a46A6f6madZHz3QvqjVmICvvtecgVmsGW4cbw3jWzxtFhcGC6/1U7LRkvyL4pgtj3A
         RWrko0n9QCv/riiYjqTm3OZLGcTR8skwaMF0wPgeiJb5dcJoUTMWQaCutHGtQ9cGil
         RDRu0HY6Bdzxr3jDhVwlwgiHIWIkk0GoTbwr+2uMjDyznB3rf1BeKbnj6jY7iK+EEk
         wqJB4n2Fx/C5zx7BH/DrMtOMd/gStCfj3+cZdm0AxUKCbjToPkdvZOe3Xo8C6XqTWH
         v9qSqu6rjHJvw==
Date:   Fri, 11 Aug 2023 19:17:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v5 05/10] fs: Add DCACHE_CASEFOLDED_NAME flag
Message-ID: <20230812021700.GC971@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-6-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812004146.30980-6-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 08:41:41PM -0400, Gabriel Krisman Bertazi wrote:
> +void d_set_casefolded_name(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	dentry->d_flags |= DCACHE_CASEFOLDED_NAME;
> +	spin_unlock(&dentry->d_lock);
> +}
> +EXPORT_SYMBOL(d_set_casefold_lookup);

s/d_set_casefold_lookup/d_set_casefolded_name/

- Eric
