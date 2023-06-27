Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D574001B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjF0Pw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 11:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0Pwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:52:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56199297D;
        Tue, 27 Jun 2023 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F0YkNdNP4x/79Jg/HNWkUQMe3owuqwhhtLuSc41VQ5Y=; b=qoGyPe5VPadHN0hptR04XWwCM+
        VpQ+9KpV91do6qeKZRjuFlELUhr25Kcv/oA5ru6SB18GxM4BIxx5VrB4f2N9hDjOEj2y4VaUHQ/XG
        r8P7bfLGbEGcK7mH8Xo1ynQBshg1xClg1EKFocDXNf5KiH9xCIuXEWA1aPMy932Tl+uZHX5Z6cvcS
        8K983SPFd/e8hawOFSQq5K2boxKAhSF/8G6dN2616V16b7pfokpgNOBbq6e5mIsc1mF0AM1H03oGe
        y2CL94aOrZwN9kWf9mc9oqxLefbetxwb1ZZGfrsLQAUS4FdbeGZB2FAazn4cl2nYdZYqR5dA3CsPw
        nRErmeRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEAzq-00DZba-1O;
        Tue, 27 Jun 2023 15:52:50 +0000
Date:   Tue, 27 Jun 2023 08:52:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] fs: iomap: Change the type of blocksize from 'int' to
 'unsigned int' in iomap_file_buffered_write_punch_delalloc
Message-ID: <ZJsF0gs9FlNH78rE@infradead.org>
References: <20230627100325.51290-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627100325.51290-1-luhongfei@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 06:03:25PM +0800, Lu Hongfei wrote:
>  	loff_t			start_byte;
>  	loff_t			end_byte;
> -	int			blocksize = i_blocksize(inode);
> +	unsigned int	blocksize = i_blocksize(inode);

Please keep the existing alignment of the variable names.

With that the patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
