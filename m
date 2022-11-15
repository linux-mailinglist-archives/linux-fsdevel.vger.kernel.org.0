Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3043D62935E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiKOIiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiKOIiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:38:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54116435;
        Tue, 15 Nov 2022 00:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5vCcwl29PSArbono2ikLYztt4pBAHs43SJyJlHvILkA=; b=qYx6GsQHldPtT4+J30UZxcu/mr
        TDjjLO6SsSlvWKSWeCcatRXYlL4trOu+FmORZBhYULxusMk9yaRdDBHAvhF1Z61H2qM6jw0j3QQur
        1950i78xDQQLg5OI762ykf4nO2WuL1Dj08ks50FOVtB/7q/IwIndCtK7Tj3+sRH6TjgwY2yWjrJQd
        /8vRLtjp8nQw7NYfz4571YgHHdqhsj81U9ZP+m9ZLx1mgv85Y7O01/J7of6+uiNbp5a09gla9tens
        3VbrxHoz925bXmfHALWQe3WGODNwHzZ9LHGzaiqtAyt8F5FltH14L07PEu7YDU6HnHyBuVQTIeUO/
        TbU8uKkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourSG-008yim-8u; Tue, 15 Nov 2022 08:38:04 +0000
Date:   Tue, 15 Nov 2022 00:38:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH 11/14] xfs: move the seq counters for buffered writes to
 a private struct
Message-ID: <Y3NP7BoI19dxqmOk@infradead.org>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
 <166801780645.3992140.5437978046181951687.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166801780645.3992140.5437978046181951687.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This looks reasonable, but needs to be folded into the patch
introducing the sequence validation.
