Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3A276AA4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 09:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjHAHve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 03:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjHAHvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:51:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAACFE49;
        Tue,  1 Aug 2023 00:51:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 56FCF68AA6; Tue,  1 Aug 2023 09:51:29 +0200 (CEST)
Date:   Tue, 1 Aug 2023 09:51:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] erofs: drop unnecessary WARN_ON() in erofs_kill_sb()
Message-ID: <20230801075129.GA23838@lst.de>
References: <20230731-flugbereit-wohnlage-78acdf95ab7e@brauner> <20230801014737.28614-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801014737.28614-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:47:37AM +0800, Gao Xiang wrote:
> Previously, .kill_sb() will be called only after fill_super fails.
> It will be changed [1].
> 
> Besides, checking for s_magic in erofs_kill_sb() is unnecessary from
> any point of view.  Let's get rid of it now.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
