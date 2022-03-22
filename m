Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971DB4E3AD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 09:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiCVIm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 04:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiCVImZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:42:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B962313CF6;
        Tue, 22 Mar 2022 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/NmC01N3JvtvFUOOHkfjZBbXiJu6Ht33d+DqM28OQjQ=; b=rJ9Ly2kbGsEib6Dqq36DIfmdfV
        i+XI3dFmUgfuD/aGQHoWFIgUeAVLyTZjCJ+omMMV0iETJaBeOcIABp+40IVM4CJ+etUXdxc4q0fHJ
        NZAA5jJIbkIPobLGx7ZFqxioEvYZ+FgZOpEiA/iFD3u0R17FIl1PJNWCUjX5Ms7dwF8674YSqaWQ7
        NO9i10AvgHrFeA88WtbNR2lSUbQIG2X0fxlhm5zMlDaoPDt2ZzIhDC2YK/ahc55hi17Owrr0zN7/d
        hqxLNwZnbJG9c+yg0+d2J042/0YzcHGf4p3JtlaT+YSIsjTRKS0hQPDKSVlhS6FgTFVrQLR68K9fM
        6o9rZQWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWa4N-00ARy0-D1; Tue, 22 Mar 2022 08:40:47 +0000
Date:   Tue, 22 Mar 2022 01:40:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 1/6] x86/mm: fix comment
Message-ID: <YjmLj78jjoieT2nm@infradead.org>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
 <20220319062833.3136528-2-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319062833.3136528-2-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 19, 2022 at 12:28:28AM -0600, Jane Chu wrote:
> There is no _set_memory_prot internal helper, while coming across
> the code, might as well fix the comment.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
