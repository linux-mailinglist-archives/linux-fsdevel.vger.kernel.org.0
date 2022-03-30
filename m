Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5254EC776
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347665AbiC3OzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347618AbiC3Oyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:54:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49BE4D27A
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BDxJtMRg+nrhRfWCkACJ+mG3zncRypTBq91LVvgBIwU=; b=ATHUvpCUHeK6lnHG7odC0HPJqH
        PRg/eXWFY83190SI9GxpeCBe23csLJvkYe2ce0PcKfyFTaha70vUEEXd7/569sK2bTD+x6fDXJJO0
        jG806n2CvtaUhWUb3+q31Zu/WkP2nRFa1rgxtpY/hUeUtgdrsYL6lhZ/5cQ4R+o/GicTYOGeIUT1M
        PJNrht+WpkJIh7eSnoC/LwRD1YMm17WWvn2Gr0rUK3sJgO1c/UdCK/cr6ZnxLsc+y6m5QKR1IZbH8
        sLRBb9yj650vy6gY7J1uN/VRqkDRztBNWVVFLA5OWRNZ4LbaNgP4aZk+o7r/tKd7OcSCE1iLHzys5
        9T2pRO0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZgn-00GJnK-Sv; Wed, 30 Mar 2022 14:52:49 +0000
Date:   Wed, 30 Mar 2022 07:52:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/12] filemap: Remove AOP_FLAG_CONT_EXPAND
Message-ID: <YkRuwao11f/J80hD@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
 <20220330144930.315951-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330144930.315951-8-willy@infradead.org>
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

On Wed, Mar 30, 2022 at 03:49:25PM +0100, Matthew Wilcox (Oracle) wrote:
> This flag is no longer used, so remove it.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
