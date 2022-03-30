Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE674EC779
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347726AbiC3Ozd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347581AbiC3OzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:55:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F715469F
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=zvpGE9nKG5fDWiN9Zom6J21Zc7
        4utFz7d3z8VMEba8UABUnL7AyEE/4na+FVuEXx5gYYdzQabT2BBXMnIJa14gBjKWzAxREWu0fC81q
        7uy2HHWCel/ogPXQEr7VLkY+h1bXQwBe8GZrNe5L9fqcQ5gcg6/mXMAtsoFGRJSTLm5AAFPJ9we01
        8HPZ0JvHOSMY/fb5URXT1C2RrGazpqWIVQQ3w7XBX8/NmnGBqjVs0VYI6SaL+HyLHuHcYnP4e8AFe
        oVR9KBueHlSKXTxY6Io1f/R1KQBPAIfKMHeixZ1FMxI47umCtwAQSoSQofD2BbkR/ceGWcib/Bnp1
        vi/jkyUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZh1-00GJxs-SQ; Wed, 30 Mar 2022 14:53:03 +0000
Date:   Wed, 30 Mar 2022 07:53:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/12] ext4: Correct ext4_journalled_dirty_folio()
 conversion
Message-ID: <YkRuz8D3NdomfAGD@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
 <20220330144930.315951-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330144930.315951-9-willy@infradead.org>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
