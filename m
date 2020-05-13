Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2F1D0F5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbgEMKJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 06:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729917AbgEMKJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 06:09:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7881BC061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v2SXhXVatlB7a+b3FDUeckFCgAFekDkvjA6oOG3RO+c=; b=qASbPmyEp7Nq1BJ9mUmLifN/tb
        jeCQSaGh2hXE5zEDa3gyFHBBaaIFjmpMS8wl6314ah0AOdviyIr5pHyDCy2j/hb748CAFf09wMdXu
        Mpr1oMQ9ubBvOMNN5YjoQnQNoyScUIdL/3MnhHVMNcRWcAEKSo6J3YrKIm1w3r0XaxTbXol5N+0or
        il/KUI621X4K1eXla6Pxv4f2x55QOn+rWm3DOhQcahiPdhr8Zd31haPPoTrLNJLpgPtxmFniEXkOZ
        3W5PPDrrwIQChWhSpWD+bwMSz/ka8anmURuqYVFwMUgRxM13lEylullREddRxTeFxqDQ7BW8GkzP0
        LWJeJKCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoKk-000644-Oj; Wed, 13 May 2020 10:09:50 +0000
Date:   Wed, 13 May 2020 03:09:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [13/12 PATCH] vfs: add faccessat2 syscall
Message-ID: <20200513100950.GK7720@infradead.org>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200513074537.1617-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513074537.1617-1-mszeredi@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Needs a Cc to linux-api and linux-man.

Can you split the access_override_creds refactor into a separate prep
patch?  Also please drop the pointless externs for functions prototypes
in headers while you're at it.

Otherwise this looks sane to me.
