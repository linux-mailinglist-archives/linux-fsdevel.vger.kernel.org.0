Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A856F750B33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGLOmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 10:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGLOmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:42:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD84BB;
        Wed, 12 Jul 2023 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f3+120nI0qsDe1YJ27JG6TM/bhTy85me+uHT6vnbIBE=; b=zhBomEzAEIF6Wet6D0dCEHoDc9
        okuiGV0HJ0zEb/6g3KT+kSOccac4dHYgXzgmsDXpd5wZ3ei7dOc22BhinkP4+RJ7NCVBTzXcBv0a+
        mkdQEaNEfbsySg6JXBXksLnyMs5HzC1sQyuqHi9VEKswmzd+kYtoaru5bwiCoPxrcZUBp1cO/xy0y
        bCCdNiZ53tTwhsypKPiuSuZw7PiowQJiG+Lccs0ykZtxq9QACS+jqeeBsft5s18KqNPAfTUUX1Wyk
        FGYopr5EI2NQOSV19zN5vF0sLOsQE6sT2ANw/qeJXOTthiv+T/qnW2z43h+s7zvVxmvcr5LASvDU5
        VUeU2pGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJb2z-000EDU-2z;
        Wed, 12 Jul 2023 14:42:29 +0000
Date:   Wed, 12 Jul 2023 07:42:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/amdkfd: use vma_is_stack() and vma_is_heap()
Message-ID: <ZK671bHU1QLYagj8@infradead.org>
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712143831.120701-4-wangkefeng.wang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:38:29PM +0800, Kefeng Wang wrote:
> Use the helpers to simplify code.

Nothing against your addition of a helper, but a GPU driver really
should have no business even looking at this information..

