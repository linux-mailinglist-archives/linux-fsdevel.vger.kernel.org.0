Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC855760057
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 22:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGXUOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXUOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:14:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA5C7;
        Mon, 24 Jul 2023 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QSmDjKcO7yuj6q/7paWhjpYce47kkXPQJEt1KYNR5tg=; b=BQF7qCIGeUxvl1o8XlotEcYh8q
        yPN4SE0x4oyyNgxCukxJ7fYprBJ98re2wANf3o7HUjIUQT/XggquQZ9QYEjxZtFc+NabpyfpQxltS
        blCAmMXCobRY14n+83bMRzWPZL35e+RRbVZn7UOWsQ1RC0gAh5Sqa9vt120cuJ8H+mrfjEp9NnrQu
        Aj1Ageftg0v+PLVnD35Oll8zsUVILkdJc0/pPPMp8P49qtUb1zsC9TY+W/J4M/ijEqVWgdLGYpA7h
        /LwuPPLghnV0vcofEKEIAMSwpCaoGhQ1RhO2IamAgHYGZiWk4WEV1DumiMplshH5TQ2e7G/ksrdFF
        e1DnvKyg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1wz-005Mrc-2i;
        Mon, 24 Jul 2023 20:14:37 +0000
Date:   Mon, 24 Jul 2023 13:14:37 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] block: use iomap for writes to block devices
Message-ID: <ZL7brQfgZoZ2teLP@bombadil.infradead.org>
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720140452.63817-6-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:04:51PM +0200, Christoph Hellwig wrote:
> Use iomap in buffer_head compat mode to write to block devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
