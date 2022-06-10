Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF90546536
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347832AbiFJLL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 07:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349093AbiFJLLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41256149D96
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 04:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9769620B7
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 11:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E1CC34114;
        Fri, 10 Jun 2022 11:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654859475;
        bh=ooOoD44Z7wLmW5ZMMjkAbNg+D+0hs4vOoFuhhqnxKnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pro+SDNcS+7Ehe9SNTdG5IIglRCBMXIlrHKMo1tQFi8RBXISkfzgwz0MfftoEkuzW
         RmCxcTfa8WmNboQXOjWpgoz/HUkRltva9YDIoE8FwTWatbBSgldOzYp1MGx09Mdf+Z
         p58FrW3FaLwa11BqMzzEOFsoG4imfdec5r/Vb1hcFe8j7L51/lztoPw+k65y6XBrnr
         csoXd+Bd/ClnOh//CGW2EjxcWHCp5+c5ToRmEr4VDczUNUOV7E5zv5tD9cBrS31R73
         ka6SuE5bXCN1QJQHAIZCu822OQ49Ak72GZqZo3+CxNrWjgCNuNNYGcmU9jsr8T43ZU
         3Mx5/WCKB71NQ==
Date:   Fri, 10 Jun 2022 13:11:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 09/10] switch new_sync_{read,write}() to ITER_UBUF
Message-ID: <20220610111110.dnlmhhbs6kdxq62n@wittgenstein>
References: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk>
 <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
 <20220607233143.1168114-9-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607233143.1168114-9-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:31:42PM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
