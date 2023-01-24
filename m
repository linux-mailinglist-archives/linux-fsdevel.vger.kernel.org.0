Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7D67993C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjAXNZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjAXNZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:25:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1055B10DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X5WX/K0dg/F13I8YPHnVeYgzxWSHPGu0D56asVzZS10=; b=mBVf+rEOW+kgKP1hS414ynWiF2
        aQfjLwixGJJptTDlmdFzUlX1isRbiXKFQy4ROFk1Zf9dwi2S8d0YA8MRPm3NzGLwmsoZ8kj2Hsvz0
        Qq+DwCU6ose+EcICt8C7BN+hQknTvhlZSUvs/uzE0ZHyp/z6G3pgBR2VxVU6k5eZgwJ6TI+2W6Syp
        38O/isnoUGZTSkvTM/Ra4AqvQFYiKJUbRGj25osgf/VVVvU/7J3awtghen0TtTDnhLq+JQB9L+dpe
        Ku0fYcCOmPlDgxs+gwwTsHJwZIkBw6YmUGCShZszEi6ExLI3vDr3V1KTydgJlei9d/bH3fUS+eIvg
        760xqUiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJIz-003yMq-G5; Tue, 24 Jan 2023 13:25:41 +0000
Date:   Tue, 24 Jan 2023 05:25:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/10] udf: Convert in-ICB files to use udf_direct_IO()
Message-ID: <Y8/cVbtbIfVdSLWH@infradead.org>
References: <20230124120221.31585-1-jack@suse.cz>
 <20230124120628.24449-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124120628.24449-3-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:06:14PM +0100, Jan Kara wrote:
> Switching address_space_operations while a file is used is difficult to
> do in a race-free way. To be able to use single address_space_operations
> in UDF, make in-ICB files use udf_direct_IO().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
