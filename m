Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D6494B2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 10:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359675AbiATJzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 04:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359671AbiATJzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:55:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1133CC061574;
        Thu, 20 Jan 2022 01:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=miTZg2pVFmJuzEKwmZN7RGqLaJXxQpzXayXIfG5hwT4=; b=B8jytzy0tMkYJ1DNic83kx/OVa
        rOI38O1V85EZvBqrIOlpU1Vqc0ErYUcgCKTWZO0DQehpEZ2K/vC3dZMl6+gDudWHfh6c6GGyxUHfT
        9mzV+DNQ524FhTt0IDEP1irIm3ivGiiJ894mIEGPTzyD7mEACFxu0oUopl4d/qnR9nPrQUGOLopjx
        m2s9hD1iEcLp0nLi00AoIo7KeeMPx4qbjlau0B4tGWdUwm/2yDzt6zFTeA0VCPCEdiwDddXnI8gag
        inwi+ILJHSES2Kvx+sEC4ByPXyDkEbeTQ8uFZ4fhjiWzpn7EtluQMJZkonkfc/8+b6ht+CmIwHNpR
        OjgBMd5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAU9n-00AOBe-9r; Thu, 20 Jan 2022 09:55:03 +0000
Date:   Thu, 20 Jan 2022 01:55:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 0/7] DAX poison recovery
Message-ID: <Yekxd1/MboidZo4C@infradead.org>
References: <20220111185930.2601421-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111185930.2601421-1-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:59:23AM -0700, Jane Chu wrote:
> In v3, dax recovery code path is independent of that of
> normal write. Competing dax recovery threads are serialized,
> racing read threads are guaranteed not overlapping with the
> recovery process.
> 
> In this phase, the recovery granularity is page, future patch
> will explore recovery in finer granularity.

What tree is this against? I can't apply it to either 5.16 or Linus'
current tree.
