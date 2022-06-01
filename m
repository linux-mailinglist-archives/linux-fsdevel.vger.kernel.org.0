Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CC6539CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 07:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349633AbiFAFcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 01:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349636AbiFAFcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:32:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3E754683;
        Tue, 31 May 2022 22:32:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E54A68AFE; Wed,  1 Jun 2022 07:32:01 +0200 (CEST)
Date:   Wed, 1 Jun 2022 07:32:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 11/11] fs: add support for dma aligned direct-io
Message-ID: <20220601053201.GE21743@lst.de>
References: <20220531191137.2291467-1-kbusch@fb.com> <20220531191137.2291467-12-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-12-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good with a s/fs/iomap/ in the subject:

Reviewed-by: Christoph Hellwig <hch@lst.de>

