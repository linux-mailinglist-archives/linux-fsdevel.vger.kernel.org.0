Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C9B3F1524
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 10:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhHSI0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhHSI0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:26:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF82C061575
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 01:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=pvOkUlJaoZrkxY2Gp33wi1zgWz
        fnxFBIK4uQqSioq16ivOY7xmZpudXBLXcbvq549Gu5nmZfs0iZeNy1ojemfjwdTfwdRzPmN4cLkKc
        uSgTE0TQ+nnIy0bSHTIzOgo4WHjdoJitTTLKMzhrs41Jim0L8qW7DrlKY2lXnvXkhs+cRIiUEChHQ
        gQo3CEK9lPd53mAwGTrYAMbHxLrZP6dpKn0tjzF/BsJaeleKWI8RlTQ4+Y5tlqhQYfvZnwaB1xNxZ
        SSJBur5DgaOUrxA0jGut/xpCfImmVxtJh02Xdt8iszrPouYPhRZdhD/vLHiC/Dx1jpos70BgD/x3H
        LjOWA2uQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGdMR-004oi0-Dm; Thu, 19 Aug 2021 08:25:21 +0000
Date:   Thu, 19 Aug 2021 09:25:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Xu Yu <xuyu@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, djwong@kernel.org, riteshh@linux.ibm.com,
        tytso@mit.edu, gavin.dg@linux.alibaba.com
Subject: Re: [PATCH v2] mm/swap: consider max pages in
 iomap_swapfile_add_extent
Message-ID: <YR4Va6NsuquTH5QZ@infradead.org>
References: <6dac22b2a8a22254fc538054cb42a32e53d2482b.1629355682.git.xuyu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dac22b2a8a22254fc538054cb42a32e53d2482b.1629355682.git.xuyu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
