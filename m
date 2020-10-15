Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93EA28EE83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgJOIbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 04:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgJOIbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:31:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AF3C061755;
        Thu, 15 Oct 2020 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=E8Q3SkJQ/vqyhGuwYI2tHfkFa2
        zGK/xqwu3gYuxOVCJ0QO+URUX7zt1l3Pd/2Z/4X0RpaiYGg3p7zP2+s/xGMIA8efwraJelhEHMA63
        GzSv1UKdTFTrWii0hPgHsKaR3zTPjr/LvnLKVqixYtFqiht1qA7ec5MU+1BqbuQ4QXmx4ONXYj6YN
        WxBa5nqyojZanGMHMqlJXZTAgJWNl4zwHfxpW/fWB0GtbRXhNoqlDcWkKjfBwvkW3HBdAtDiNthxm
        0I8D0o4n589oIbN7ff/FmlOOK8WBhiXqvFm6ZyYRU95rRvxta/4NId9ohSjfcYlVPLGnGzEWlcHf8
        WKBikrQg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSyfN-0001Wg-MT; Thu, 15 Oct 2020 08:31:17 +0000
Date:   Thu, 15 Oct 2020 09:31:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 2/2] xfs: avoid transaction reservation recursion
Message-ID: <20201015083117.GF4450@infradead.org>
References: <20201009125127.37435-1-laoar.shao@gmail.com>
 <20201009125127.37435-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009125127.37435-3-laoar.shao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
