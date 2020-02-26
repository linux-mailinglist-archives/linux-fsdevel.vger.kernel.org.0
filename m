Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8724116FFA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgBZNIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:08:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgBZNIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2IY2GB7i/mwF4XIOgJDt/lQwAFNzsE0mMABE5WbvmUo=; b=AIUiGp2xB8oDNwPH9CLnnSK+Mt
        Ij91K8QhHlgdauRQyycZeFF2KqhqoBDiMYqAci0/1uKmmkEqP9K1pFGOX2vEoY08DO5lbyEwl/Kj3
        0y8cCYNhIRvy/5RPdZhSlsTL/LfT1/7yNhD9L7idGxioeuC9IRPcBYObfxvO/Ocs8n3YoHeREVBQw
        vberjXfNkORkCH2EthTZwsMYwXGnt+VfiIfGV/BAy6wTvOVlAmGnlD2Amm9XOMKy62h+5Zh03arhW
        sMHo/IfgGbstv+JyOcmwYicq2+wQ7gtlymVgVZEmS0WpGxHwuchsm02qtcogs0L440ronFnxDqUR3
        N/YN274g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6wQG-0003fw-W1; Wed, 26 Feb 2020 13:08:20 +0000
Date:   Wed, 26 Feb 2020 05:08:20 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [PATCHv3 0/6] ext4: bmap & fiemap conversion to use iomap
Message-ID: <20200226130820.GZ24185@bombadil.infradead.org>
References: <cover.1582702366.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582702366.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 03:27:02PM +0530, Ritesh Harjani wrote:
> Background
> ==========
> These are v3 patches to move ext4 bmap & fiemap calls to use iomap APIs.

Are you also planning to switch readpages over in the future?  If so,
I think you'll want this patch:

http://git.infradead.org/users/willy/linux-dax.git/commitdiff/2ef99d3d1dd1941cbf9214f2a49b50f8c9e6f021

I haven't done any performance evaluation here; just reading the code.
