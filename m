Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31661B96DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 07:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgD0F51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 01:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgD0F51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 01:57:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A80CC061A0F;
        Sun, 26 Apr 2020 22:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7zElAvoUBkSCcndQ+mZNHBtIxRc2td7Rq7fW1hfPztY=; b=OapiYWlEmna+aaE+vjReoQWnqh
        iYK6z5lAmhnykIOVbybn3iQ7hHeZ53/ShWroCls3IXOv0Zkpm2ec/U1vJWXxjV71Er8ji6/VOdnLW
        GeMvGb9SXY0U02rDNufTmoxsudBnfQf/uQeaavGwnxdR6Doec19IkDbdZ2WNcAkGFPMWGQdbDWkIO
        mfwNXtLL2RPBr1w4pd095jmkbhFhUlOhn2IA51vxSP9LtpIP+ePK847OhKMisZdOWHlYssJakjm0c
        4qeHj/EZoNtju88tdV77lACF1hENIN95TnuoY3G8rQSc2vjycDMu4/txj+7fVgVWEyc6KbLGEikuA
        c4aNa4DQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSwlj-00082h-5q; Mon, 27 Apr 2020 05:57:27 +0000
Date:   Sun, 26 Apr 2020 22:57:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH 6/9] iomap: use set/clear_fs_page_private
Message-ID: <20200427055727.GA30480@infradead.org>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-7-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426214925.10970-7-guoqing.jiang@cloud.ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FYI, you've only Cced the xfs list on this one patch.  Please Cc the
whole list to everyone, otherwise a person just on the xfs list has
no idea what your helpers added in patch 1 actually do.
