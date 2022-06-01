Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38A1539C84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 07:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347708AbiFAF2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 01:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348502AbiFAF2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:28:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D615C77C;
        Tue, 31 May 2022 22:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=rdEKTSnrl0a8v4FZIdpOhMWHi2
        PhTQDvS0H+nTa7e6s90Vl2PxgJy1eZBCt40FwNmSueqj9GNLTTOV63vZ77GDuOXZsYtLCJX+YAfAG
        8adVTadSTMZVBsPDIn1kxHAw73DVewfLIGnCU15SAXZ5wfym/79idG2Gdb3S1Wr1H8fX1OQ0I+1ef
        VXFHTVmnKY8oYtGfOuelj14sNApz0P/hpU2xN2mzUiUV/VWYALJ6kMDsHyLsrMJ+X7IaJwHZLDY6J
        qPGSVEG9DkGzXozu/BO0wh89fNY6j3+GqvkED7ou2TkO+RgSeI+hTiQgvVG2jA7bbcTpUZBUG0jRO
        lSe55xwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwGu7-00DvQj-W7; Wed, 01 Jun 2022 05:28:24 +0000
Date:   Tue, 31 May 2022 22:28:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, hch@infradead.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Daniil Lunev <dlunev@google.com>
Subject: Re: [PATCH v4 1/2] fs/super: function to prevent super re-use
Message-ID: <Ypb4905jqmEj26MR@infradead.org>
References: <20220601011103.12681-1-dlunev@google.com>
 <20220601111059.v4.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601111059.v4.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

