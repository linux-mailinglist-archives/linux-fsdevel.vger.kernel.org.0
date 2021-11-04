Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B981445905
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 18:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhKDR4H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 13:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhKDR4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:56:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F2C061714;
        Thu,  4 Nov 2021 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Wm7HH7oeUOYnXc3PtTYetZcfrk
        Nu0z4OEjT5QscgmkSbjP7OW5shwWG52n3nyGWqhDRazp2ncYeBJ+GISxHsAlaG5yNJYpSTcFYslh0
        Uo+KYvslb6PEFyIaZNa9fln6usRC2VmwyS8muOWIYztwN055cq81UvbdJQpm2TOobrPSrwX+QFKAM
        Jnb8300AR49JE2khtwTmKXFEQIwEs+BWcIkjxnF86GutadiM0EjX8FHPZh9RGacd/MM4Fxe+/TNfC
        SH9MvC0TlLKzI+UrPZq4BPqhCT5q3G98Z25l2gog5+x6YJS55hVJPmCxrXOCWV/V16IlbW9cQarst
        ZHMEpG5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1migvE-009iuC-7t; Thu, 04 Nov 2021 17:53:08 +0000
Date:   Thu, 4 Nov 2021 10:53:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, jack@suse.cz, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] dax: introduce dax_operation dax_clear_poison
Message-ID: <YYQeBM40BaZZGARU@infradead.org>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <20210914233132.3680546-2-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914233132.3680546-2-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
