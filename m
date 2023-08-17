Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB56E77FC81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353815AbjHQRHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352730AbjHQRHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4472D7D;
        Thu, 17 Aug 2023 10:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A669160EA7;
        Thu, 17 Aug 2023 17:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C38C433C7;
        Thu, 17 Aug 2023 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292021;
        bh=Cnc5fd/SEme+J61EWpUydnlttURNe7D0+P6ahO3xQc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NyA3MyXj29mNfXON4kkdiiJ8iEEdVRKuJxpFf/okQAHl1Ixm51esprU4w/4xqxdYB
         G53DTRxWeVOISwNDLGmzSmrQZkZvuqnwrzknMCqq/9Wv+v4VQzvDEKw5QXOazQ4JuP
         8SlXP4+QjLaDNKZ0oEYAXJZQSs3npgN5GFaH9DDYDno8CptvBwQ5ls5y7kxuNNTbVf
         slCPiwc/Fj3Txs2KaAX6TH7PpRfVv4TC8o1i5ABuiVbEMJRi4SqYLVXMvC+x7rth1V
         p/+/aCrDV1cVAYFoq7uwgxjiEu92IiSoRDadlCAtH7iHLhwfhSmjvZg1oSvR/EC9wc
         xELPSzYhNCm7Q==
Date:   Thu, 17 Aug 2023 10:06:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v6 0/9] Support negative dentries on case-insensitive
 ext4 and f2fs
Message-ID: <20230817170658.GD1483@sol.localdomain>
References: <20230816050803.15660-1-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816050803.15660-1-krisman@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 01:07:54AM -0400, Gabriel Krisman Bertazi wrote:
> Hi,
> 
> This is v6 of the negative dentry on case-insensitive directories.
> Thanks Eric for the review of the last iteration.  This version
> drops the patch to expose the helper to check casefolding directories,
> since it is not necessary in ecryptfs and it might be going away.  It
> also addresses some documentation details, fix a build bot error and
> simplifies the commit messages.  See the changelog in each patch for
> more details.
> 
> Thanks,
> 
> ---
> 
> Gabriel Krisman Bertazi (9):
>   ecryptfs: Reject casefold directory inodes
>   9p: Split ->weak_revalidate from ->revalidate
>   fs: Expose name under lookup to d_revalidate hooks
>   fs: Add DCACHE_CASEFOLDED_NAME flag
>   libfs: Validate negative dentries in case-insensitive directories
>   libfs: Chain encryption checks after case-insensitive revalidation
>   libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
>   ext4: Enable negative dentries on case-insensitive lookup
>   f2fs: Enable negative dentries on case-insensitive lookup
> 

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
