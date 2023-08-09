Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1DB776181
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjHINpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHINpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:45:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01156DA
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 06:45:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 680B36732D; Wed,  9 Aug 2023 15:45:03 +0200 (CEST)
Date:   Wed, 9 Aug 2023 15:45:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] zonefs: fix synchronous direct writes to sequential
 files
Message-ID: <20230809134502.GA31883@lst.de>
References: <20230809113150.702115-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809113150.702115-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

