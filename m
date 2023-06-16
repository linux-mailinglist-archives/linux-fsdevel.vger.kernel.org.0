Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B63732F2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 12:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbjFPK4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjFPKzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C43768D;
        Fri, 16 Jun 2023 03:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E962363861;
        Fri, 16 Jun 2023 10:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFE7C433C9;
        Fri, 16 Jun 2023 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686912453;
        bh=1OsNVW6dmfZVZ5/KisSfPWg/TytGKk/p9FQ33yPckTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuJqlQaDE/LWEAS3//0SJwYS5ollfei1PsPdfQmiIHH0OnNvrVEIurkQDzQNI2Vsh
         jGqlkg73z3tTkdH9lPlT9szYJhbcCnySVuf6zEXu+xTg9vitQ8LmVF5HdtEeB36qlv
         0ArZNixzaJvnsqZXSIlozgozKLo225Q0TYUpUqDuNi1y8m5KP+cS7yjxVl8IDMbXIV
         FKQgWvTunLrQjEsskxQHyx5Dm12xu+/iT6WXd0MnY0XdjI17hv55f/rzex2Ni2CPI6
         h/Y7hecnSpSBU0hSMYN5LuA2HdE45aApRIBfn2vN/9R+jlgKBjo+NtkOxZz6VgKfgh
         VyQTCMxbGa4Wg==
Date:   Fri, 16 Jun 2023 12:47:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] block: remove BIO_PAGE_REFFED
Message-ID: <20230616-beackern-allesamt-e391d3c800b1@brauner>
References: <20230614140341.521331-1-hch@lst.de>
 <20230614140341.521331-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614140341.521331-4-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:03:40PM +0200, Christoph Hellwig wrote:
> Now that all block direct I/O helpers use page pinning, this flag is
> unused.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
