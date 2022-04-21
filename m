Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F23650988D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 09:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385288AbiDUGya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 02:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386045AbiDUGxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:53:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE43E11A21;
        Wed, 20 Apr 2022 23:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=xIQ4+cKb0jI15c9feynfrvB8SD
        n3VRownO+qLC3mcxOyePGnmADH5PAM8LWvtGusg1uq1sM5uP57WiYl/fD2IKJHIzl7kVIzST62/VA
        gby+H5HwXNPnTpZ9/FzG5eMvUnTv/yBf7ynjDH318eknHlsUn4qjLYEqW+ixS7Mbq6mC69b+R5tpG
        1ciFH6LG72HOiGjQZBDdKWGR+3oOAeluqwuGF3No46q0xbOJX2kDbch8dl3//S0tB7kpceriWBZSE
        kr5zjd/cL3A/n3l4N2PvDX42onKn5ZUgdQmWKXpWaTaaGZAV9sjoTdvCKSweDBiFKB4caAc48sjLE
        0tiQM6Ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQeU-00Brh3-6L; Thu, 21 Apr 2022 06:50:54 +0000
Date:   Wed, 20 Apr 2022 23:50:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: Re: [PATCH v8 2/7] x86/mce: relocate set{clear}_mce_nospec()
 functions
Message-ID: <YmD+zgFf9Vih52gZ@infradead.org>
References: <20220420020435.90326-1-jane.chu@oracle.com>
 <20220420020435.90326-3-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420020435.90326-3-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
