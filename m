Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AEF29EF2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 16:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgJ2PGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgJ2PGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:06:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCBBC0613D2;
        Thu, 29 Oct 2020 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=oLnrkzzkOg8xIxCI+JUEsyADYG
        Pxa1ggxs6yCwsdnDGdrwp3kLOjrGQRbPL4UILahjHwZ3ZI59uIu35NMs90TNajduo5gmFWrJN60/h
        XFU1OMaMkopb5Fsj7z1yPL0dEhWo8hRIXXM6wnXHV1fZML5WTi1iXrHjvxBV2wfGuJBjI1iM4IhOJ
        /DIpJyouY7JaBPMOQiZ7gnE0naTmUk2qKig/9SfVBJ/H9VtXz3vZJcxVZZ9JouV04z+RO9hHglFC2
        f3gpJXU4oLds1cD1qyC+mnUQaDpEFJvuMRNSllCL/YfnmH/ZC2qHRgs4kDaCXwzODfPVdEMptzEM2
        zxL+58Ow==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY9VN-0005o8-Q1; Thu, 29 Oct 2020 15:06:21 +0000
Date:   Thu, 29 Oct 2020 15:06:21 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iomap: support partial page discard on writeback
 block mapping failure
Message-ID: <20201029150621.GB21018@infradead.org>
References: <20201029132325.1663790-1-bfoster@redhat.com>
 <20201029132325.1663790-3-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029132325.1663790-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
