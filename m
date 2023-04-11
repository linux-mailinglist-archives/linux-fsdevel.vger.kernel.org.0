Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64776DD1D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDKFio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDKFin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:38:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DACC26AB;
        Mon, 10 Apr 2023 22:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wdjx0PzS8xymLv6V2DZoByQwCNONkYBPrVTslqWkC1A=; b=zAusoAFh2XMcpSwwXL3MEkMcu7
        Xj1oSdkF/wpKDaVA9/ijVxJ3R2zTgfN5VRSQKn6+CrqM3Eh2Q7X3alR28o/5krCxZEjZYdWzzP0/r
        YbA+BQ8PdNq1+4l35cH2F6+7F0/Pj6DW/VmUQWXaEKRNupQOUOriwuguaWwZ/2DoIP5Bv4bY6/Ywg
        qI74eVnfuSSrwCb2pAdbN4PUQftLzlVzNnm4XND4ERebRG1BAMqtsjEn1vEyJuh7BydIjEFAgSExv
        BfOnzxa9My4ShATNT1ynIG8JWZ8GOSwLNVBxKwLxMVteB3NPIfEoPuYlJikt05r7FymlF/l/aSlus
        GaSLvs/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pm6iE-00GU6N-2t;
        Tue, 11 Apr 2023 05:38:38 +0000
Date:   Mon, 10 Apr 2023 22:38:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 8/8] ext2: Add direct-io trace points
Message-ID: <ZDTyXr6EB+pEgS1G@infradead.org>
References: <cover.1681188927.git.ritesh.list@gmail.com>
 <f9825fab612761bee205046ce6e6e4caf25642ee.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9825fab612761bee205046ce6e6e4caf25642ee.1681188927.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:51:56AM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds the trace point to ext2 direct-io apis
> in fs/ext2/file.c

Wouldn't it make more sense to add this to iomap instead?
