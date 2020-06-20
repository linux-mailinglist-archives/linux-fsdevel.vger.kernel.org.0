Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F02202258
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgFTHaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgFTHaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:30:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4BC06174E;
        Sat, 20 Jun 2020 00:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=m/c650G9eOsNGFfYISwrX7Y5kF
        ISlAhYiJg5QBOJZPhKLWCFpVQF4emfGvJEI3/JoDjKYNDSnHRtrIgp5yg0KftCcOL+3Ofb7Qwt3Iq
        rlLZD+ySuZR3Oe7S+YJmfJlUNXeBecnu9oMp+LXcKDH0wmqwPEvo+ugc5+hBs/LHKO2zg1zZx8d/V
        B+P/ZBwJYMDfuHLUTUTBrU4T9pRfumSdDPF9Y9hmZf8dqN24BmgSLsRSmHeYfiFyu1RQCBFXhyqyL
        /m+NKEClkxl3xBHl/m4l8cVBEz1vfKy5ZBJdlCTZuldFsMbOgktDj2LDyKXfhUZD35XliOfRo5qx1
        /kCaxIxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXwJ-000184-S3; Sat, 20 Jun 2020 07:29:23 +0000
Date:   Sat, 20 Jun 2020 00:29:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/8] blktrace: ensure our debugfs dir exists
Message-ID: <20200620072923.GB3904@infradead.org>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619204730.26124-8-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
