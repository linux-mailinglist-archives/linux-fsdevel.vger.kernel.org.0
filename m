Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53D65426A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiFHGn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 02:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352496AbiFHGQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:16:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7306E3B571
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 22:50:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 66C1867373; Wed,  8 Jun 2022 07:49:58 +0200 (CEST)
Date:   Wed, 8 Jun 2022 07:49:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/3] zonefs: fix zonefs_iomap_begin() for reads
Message-ID: <20220608054958.GA7022@lst.de>
References: <20220608045627.142408-1-damien.lemoal@opensource.wdc.com> <20220608045627.142408-4-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608045627.142408-4-damien.lemoal@opensource.wdc.com>
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
