Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47572B636
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 05:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjFLDty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 23:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjFLDtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:49:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF1C5;
        Sun, 11 Jun 2023 20:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kyJKnbCUH7e9M4jkex7lERd255OqVBeiSs4l8Marj68=; b=UuetIcJzELE1oMx8UiT/9AGQvS
        ipmZ9bb4s0HwrmE4bGLQ5PTRXFbMIAF49d2I77L2/fdmbkHUwCbwIITB4/kmdNjiNSAsulMDNE95t
        owFFbdGOVp5LoTehwiL09162EJwSU8+H8qXEB8HVa/RwnlnNEv9olAD6BpT9mNihblBuahU5Ivz+9
        EyTwLkAuplsccfEQqb0mt8k++I9mdCWbMWzYVjm+xw4hjDh82aPRzogVh/4fNRjBvm67KouvpHAjr
        GOCbauiwS8Ja2dPt8Bq2SsV5TWWuJLIJq/yHskY618+DBgbOjCiLPDyb5/QlDVqIWSYF+agzGeBmV
        xJMxR6hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8YYh-002TFR-2j;
        Mon, 12 Jun 2023 03:49:35 +0000
Date:   Sun, 11 Jun 2023 20:49:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        willy@infradead.org, dlemoal@kernel.org, wsa@kernel.org,
        heikki.krogerus@linux.intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] blksnap - block devices snapshots module
Message-ID: <ZIaVz62ntyrhHdup@infradead.org>
References: <20230609115206.4649-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609115206.4649-1-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sergei,

what tree does this apply to?  New block infrastructure and drivers
should be against Jen's for-6.5/block tree, and trying to apply the
series against that seems to fail in patch 1 already.

