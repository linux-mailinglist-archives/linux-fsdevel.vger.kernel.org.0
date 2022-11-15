Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCFB6293B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiKOI7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKOI7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:59:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491F26412;
        Tue, 15 Nov 2022 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ktcTOBWv1rw46CZkOvqkKbXV/n7CpaECq0w5Jjq06Y=; b=z0pEM15MibHyHlORd6VWGbqEFh
        7+XcKa3MGZqEP9yRggfo2+a42gQU6e3642UczQwfgzQHolzWuGdiJzilswFomRPaOelXvqET7ClUH
        CV8/ko5ScWOek6gE2V8wicM/LzkDw9d8Coh+Z+6cixb5diIyTwgGxrBMT5P51SDyvksqwTP0vEc5T
        sUVmhhZ6Aem9Rd0zPobtgKCVxA05rFuZIgyjTEqgXXQtAfteWya64BcsE/tzA/rQxT3Zd4qlGp7Yk
        WWn18uP+5Ss/PqORtydroGrp0VvwBellibpxTiROsRLeAUHhRI0wXoxXzyxf97xIM+Y/mIPg9Azuk
        jSwkvwOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourn9-0096L3-0x; Tue, 15 Nov 2022 08:59:39 +0000
Date:   Tue, 15 Nov 2022 00:59:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org,
        trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] filelock: remove redundant filp argument from
 vfs_test_lock
Message-ID: <Y3NU+zV8I/XzEze2@infradead.org>
References: <20221114150240.198648-1-jlayton@kernel.org>
 <20221114150240.198648-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114150240.198648-3-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Same nitpck about the extern as for the last one, otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
