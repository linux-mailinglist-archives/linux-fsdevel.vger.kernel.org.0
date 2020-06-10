Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304F91F4E28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgFJGZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 02:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJGZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:25:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8609C03E96B;
        Tue,  9 Jun 2020 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yhUUkblZBtIukb8ZaU1o3no72vgZVuofYFqFK3m4UNw=; b=iom6R2+I5PdVq8+x/wIT8g6Yps
        niFdA5pa7du8cSCNo2jTBZC/6ucxC4ER1TSBm7chhc8Wq5BCJxxKNk51jYjeQ7Tm5LsX18T5gQDik
        mqjD/mKEqlCuSvttI4HMhXs1yuzXIC/IEokWBLce2V33R5tGYzI6jRO39LkT/x5i3R91TSVF3bEj1
        rXgM4/moMEH2csodYQyhNIPsyQOY6p1nQcLFKgMeX+KpYyi3cfd1MtA3OMDzkWVamJU39bcJG3gQj
        xr01uOJ+hYNpbuhbNxVcP7/cE2t7XSuEqguD9NEyHMpy9650uuPLmepXDIvYFVXsMs+u3WC9MWLKs
        YZoGw4TQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiuB8-0000hr-LI; Wed, 10 Jun 2020 06:25:38 +0000
Date:   Tue, 9 Jun 2020 23:25:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com, tytso@mit.edu,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
Subject: Re: [PATCHv2 1/1] ext4: mballoc: Use this_cpu_read instead of
 this_cpu_ptr
Message-ID: <20200610062538.GA24975@infradead.org>
References: <534f275016296996f54ecf65168bb3392b6f653d.1591699601.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534f275016296996f54ecf65168bb3392b6f653d.1591699601.git.riteshh@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 04:23:10PM +0530, Ritesh Harjani wrote:
> Simplify reading a seq variable by directly using this_cpu_read API
> instead of doing this_cpu_ptr and then dereferencing it.
> 
> This also avoid the below kernel BUG: which happens when
> CONFIG_DEBUG_PREEMPT is enabled

I see this warning all the time with ext4 using tests VMs, so lets get
this fixed ASAP before -rc1:

Reviewed-by: Christoph Hellwig <hch@lst.de>
