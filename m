Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC0732F2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 12:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345172AbjFPKzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 06:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345103AbjFPKzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F4E72A6;
        Fri, 16 Jun 2023 03:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2CD160F8D;
        Fri, 16 Jun 2023 10:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF3EC433C0;
        Fri, 16 Jun 2023 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686912421;
        bh=crjNkV2z+AlpUaVbgQbAAeV/DkzGupaXDS1SVFAwJ5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dolzeXfSTOWVvj8nRg+5vIsB49VlOFDT6puRPXTeAGwMRFG50cLgeA2wladA/J1X+
         a7S3yJbEwFv7XnAoixsezqm4xWOj+wqc72gBkOErjoR0yUCA8wY3CrOqt6cglEwyTa
         7eUY9oBdf3Pghs3kQ4ahn1rrFw9B5MYKnizok5/e1jlw+Uzc1fukbTy9uzyOTjZXjR
         b04oeOCXwvUHBNX5I+YHCCwIB0mSLtp6NtU5e+Tc1lGPUADa+XivIKk/OR6aOcFPRg
         0Z2DbTNGNPKKdANkCFCcStXCLQjTf13Nn1e4o6lnbvlhdm41p9Bi0TmxNElzyqWPw+
         Sql6XDPjK/ahA==
Date:   Fri, 16 Jun 2023 12:46:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] splice: simplify a conditional in copy_splice_read
Message-ID: <20230616-nordmanntanne-lecken-a1b987397892@brauner>
References: <20230614140341.521331-1-hch@lst.de>
 <20230614140341.521331-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614140341.521331-3-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:03:39PM +0200, Christoph Hellwig wrote:
> Check for -EFAULT instead of wrapping the check in an ret < 0 block.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
