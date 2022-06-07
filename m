Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4F353F52E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 06:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiFGElU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 00:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiFGElS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:41:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C0CBD6A
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 21:41:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ECB7D68AFE; Tue,  7 Jun 2022 06:41:13 +0200 (CEST)
Date:   Tue, 7 Jun 2022 06:41:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/9] No need of likely/unlikely on calls of
 check_copy_size()
Message-ID: <20220607044113.GA7887@lst.de>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk> <Yp7Pc2PFBke5FyWa@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7Pc2PFBke5FyWa@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:09:23AM +0000, Al Viro wrote:
> it's inline and unlikely() inside of it (including the implicit one
> in WARN_ON_ONCE()) suffice to convince the compiler that getting
> false from check_copy_size() is unlikely.

Looks good, I also really like getting rid of the totally pointless
elses.

Reviewed-by: Christoph Hellwig <hch@lst.de>
