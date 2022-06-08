Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05BC5426B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiFHGpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 02:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354843AbiFHGTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:19:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446305DA5A
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 23:18:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A216A68BEB; Wed,  8 Jun 2022 08:18:27 +0200 (CEST)
Date:   Wed, 8 Jun 2022 08:18:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 03/10] btrfs: use IOMAP_DIO_NOSYNC
Message-ID: <20220608061827.GC7532@lst.de>
References: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk> <20220607233143.1168114-1-viro@zeniv.linux.org.uk> <20220607233143.1168114-3-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607233143.1168114-3-viro@zeniv.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
