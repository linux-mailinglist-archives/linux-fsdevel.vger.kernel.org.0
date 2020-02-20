Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1DF16621B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 17:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgBTQRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 11:17:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTQRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q6BSWjM65+xsI6RMc+4ahg0/DV1eL9zz/PZWUf5jLtY=; b=dcHiV43sjKmZrUNsXebdzPuUQl
        mlPFSTKgiaSvfuhuGidj/lmSot9z4loj/Lqce7qkL8BrWqT9g+ExQr5HDOkFhg6mNsWr6/vzG4HdI
        ArHYKYCMnonmJKis3eCd7+z7BouVVz4q8lgMjmn7VdW4NcAoruXu29VoAKtwJ4AAHMD6IeRvEtJtJ
        mEwKozwa87eKYd8wsKnRrUPd49vkdmeCV1cv/CfSEIlfTcC8hXSubYbJoz8/+vhC6vEbF1ybcr1cS
        NJwmzL3GKQN0kmLxYtHRozpEAwPDi1Poy9GWuvTZ1zmW+9pkiRO9PFmDYDX8EDVvh48O2ACmIBMNs
        kF1Rcrsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4oW4-0008HH-K2; Thu, 20 Feb 2020 16:17:32 +0000
Date:   Thu, 20 Feb 2020 08:17:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v5 3/8] pmem: Enable pmem_do_write() to deal with
 arbitrary ranges
Message-ID: <20200220161732.GB31606@infradead.org>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218214841.10076-4-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:48:36PM -0500, Vivek Goyal wrote:
> Currently pmem_do_write() is written with assumption that all I/O is
> sector aligned. Soon I want to use this function in zero_page_range()
> where range passed in does not have to be sector aligned.
> 
> Modify this function to be able to deal with an arbitrary range. Which
> is specified by pmem_off and len.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
