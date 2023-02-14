Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE0695C9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 09:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjBNIPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 03:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjBNIOi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:14:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB71221956;
        Tue, 14 Feb 2023 00:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=RrTaxtcXRDbNW3k675vvTHtqOt
        st6pBH7yFdtYRI3VE4khqxAx04fa450oG1KwupC4oObowv6Q8HwoBdWl13jEz17Mib1VICkI6+D2o
        icDqZoA5e5eiWuT68Q3BxIWAb8iLYNxa6PoxuI4cL91VHDzgg8zzagO6+Bn1WvR+fY6U2LxP0/E7H
        RZul2dzp0UZlxViinpZy9ukBU+yu6laWe6cZ8lPCSvwo7OeCNRXc7QZNW7CfsFjAdGZ/NKAWj7cxQ
        BGWFxHiHZhzYZH8GK/Df24chGvQjNEP2GlcdlqzXc3IinpdYO1Wj/K0wMcnzYTiQfuES1ahOUgaZh
        MSYABzrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRqSM-000V2y-C1; Tue, 14 Feb 2023 08:14:30 +0000
Date:   Tue, 14 Feb 2023 00:14:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs, iomap: ->discard_folio() is broken so remove it
Message-ID: <Y+tC5nxFR93hRSVF@infradead.org>
References: <20230214055114.4141947-1-david@fromorbit.com>
 <20230214055114.4141947-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214055114.4141947-4-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
