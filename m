Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C355C20225F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgFTHbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFTHbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:31:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4777DC06174E;
        Sat, 20 Jun 2020 00:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=FR99eJE//6fW3aLXO2AHinA8kj
        eZqnmEzDaddgDb2H5U9SxfT8slW2Ksc9vB+3k5v+aHof8AX4PGi+CElZJ3ujZC1vud4RoxM+CQD2+
        hHtjXrJ7mF5QRslOTo5+fw3/jjjTBcjwfUiY6wd+E1fZjvxsHt/m7Y+ZPKeSr/PEpaFtjzbIF97km
        /l43QyUN7BnWYmpuD5atCV7Ip4DBo/2Oytv1Xg6CfivuhcoU+WKTtKYqpplJwzaZOkwfuTyUcO3I8
        cmJ98qZIBwk4NIYCR9O5krgfYe65vY8ypBzF8c9+oMrxGa4UMTP23GlG+Q8r9S+X6pe2TiWjenaxH
        DPTksyCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXxh-0003rT-6X; Sat, 20 Jun 2020 07:30:49 +0000
Date:   Sat, 20 Jun 2020 00:30:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] block: create the request_queue debugfs_dir on
 registration
Message-ID: <20200620073049.GC3904@infradead.org>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-9-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619204730.26124-9-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
