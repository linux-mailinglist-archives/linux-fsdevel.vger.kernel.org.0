Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056FA742003
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 07:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjF2Foo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 01:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjF2Fod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:44:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED1D2D51;
        Wed, 28 Jun 2023 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZH2LZio22mQexeVRx+H7ULNKh+Hfj2iXIK15cwYlRjg=; b=hIR4hN4B74sge6G08Zg+Qjk1rl
        ISOCFeylq83bOt3snrPFKtcEmAHmeq57aNIRevl11V5CG9cN5G/XN8YBGCXEP83isYLUD2qV2WANo
        amlrQRjGmkV4ldL/Fqa9U1yIjq2WzqAOlo3RbDOQNiKon1Z4Scqgwn57t4s05mxtfB2WJtCqRUpPx
        ZHfokhkLhi4p0z1GxvwIoL5GKrQIMCZ/LqSzrqQNx/8fLld2gkijRbVCoLt9dzym4n//fQ6IhQIho
        HJI/2Jn+Q9/wkpolyqxIV2DVhpJLbuyBG28eV1Qq8jhTp5+bqppW+d82eUZvxXOiMUUYAa5QAjexj
        HPq2bJ6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEkRt-0001dI-0L;
        Thu, 29 Jun 2023 05:44:09 +0000
Date:   Wed, 28 Jun 2023 22:44:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/7] block: add queue_logical_block_mask() and
 bdev_logical_block_mask()
Message-ID: <ZJ0aKU2w9xwS/vg1@infradead.org>
References: <20230628093500.68779-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628093500.68779-1-frank.li@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

What is the value add of this series?


