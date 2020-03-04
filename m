Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850411794C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgCDQQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:16:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDQQk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p1fGfBNWSAsTiZjh+6A1Y3Vp0yNK0hm9DzZrJQURvpw=; b=C8xWf5NGbIVN9T0mcaAsK69l+J
        NLlhI7FXSixgmAPqGLg82aMXGIHqtmuWsSk7xHK7SStSA7K7R5elwfkT73SrV1YP6j1NgrhNLiIBn
        pceh4ASlFNADx9Z9+6cOUqyjtQHXHPJy7ubT1QVWKJ10UWbnsYnYXs3p7TYt0VwUJjYYTKdRMW6AP
        +o3qb7/kHiYfzlprWbPdjfUtp0zVmwsnBOr8AgOWdpEyPxpzRNgg5YFe/fdQNGKfJ/rSTBH30VM9Y
        8J6jx7iNoRsNdlUB/o509eTvX9eRhxm2zGpH4BKfiaDLN6rFmLW1Z0RIEAsQp8EfBKPlPXLUU5FXt
        q+X939zA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9WhJ-0005Qk-3b; Wed, 04 Mar 2020 16:16:37 +0000
Date:   Wed, 4 Mar 2020 08:16:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, hch@infradead.org,
        dan.j.williams@intel.com, david@fromorbit.com, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 1/6] pmem: Add functions for reading/writing page
 to/from pmem
Message-ID: <20200304161637.GA16390@infradead.org>
References: <20200228163456.1587-1-vgoyal@redhat.com>
 <20200228163456.1587-2-vgoyal@redhat.com>
 <CAM9Jb+gJWH_bC-9fgGdeP5LaSVjJ3JgTnjBxpRJMfe6vbTPOTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9Jb+gJWH_bC-9fgGdeP5LaSVjJ3JgTnjBxpRJMfe6vbTPOTA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 09:04:00AM +0100, Pankaj Gupta wrote:
> > +       phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
> 
> minor nit,  maybe 512 is replaced by macro? Looks like its used at multiple
> places, maybe can keep at is for now.

That would be the existing SECTOR_SIZE macro.
