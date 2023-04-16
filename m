Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05C26E354A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 07:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjDPF4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 01:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPF4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 01:56:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EACB2D52;
        Sat, 15 Apr 2023 22:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=RG5jdO7pmWPXMlchXZwx5I9Pqj
        R0TEOUMOW0sUDYcA+7vYYFLeyRnqWrB0/07qWC2n6YDbBwPMP96FDNr33vs9Bggg1ovEv3quEF8K+
        kbnYCq3o6o0UjDDtQr0yAwPiwKCYnmqzvZuZeQTr+fFcjN2NLeVzPibuegdk0L2s4ZmJGya2zWO6V
        m7Q62w15Gdi+/NJkzJnrke3ZF21ntqAaZaZ9zxkBYVFJYB9bUhsg8g5+GBm1MoKS3cU1rJupiKf11
        CSSFfLdkpPM2sq6eLDORoiWmojDCRfLQ3m23qg5accgagqTXKG/KuNQodg8D9iznUEh0NW2TQeNwM
        8AKtMCqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnvNc-00DC5k-0d;
        Sun, 16 Apr 2023 05:56:52 +0000
Date:   Sat, 15 Apr 2023 22:56:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv4 2/9] fs/buffer.c: Add generic_buffer_fsync implementation
Message-ID: <ZDuOJCR5dmX8n9gd@infradead.org>
References: <cover.1681544352.git.ritesh.list@gmail.com>
 <5969eb067ad38272a1bb0df516965301ff08a919.1681544352.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5969eb067ad38272a1bb0df516965301ff08a919.1681544352.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
