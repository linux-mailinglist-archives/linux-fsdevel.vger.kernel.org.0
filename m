Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84D50970C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 07:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384592AbiDUF57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 01:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384587AbiDUF56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:57:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2CE64F3;
        Wed, 20 Apr 2022 22:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PDPyNefwFTnQFkVxZr1As8+DuLwtBUhU/XlRcJQNYMI=; b=siphIxP1DS6IkuiurROIaxgmqo
        ZAYdv2E2MCNs3VA4IZqPLE71MYsZcFkGn4AswSfXtohbHKXNjqhoPa5H6JzuPWdyvMKPzokOK+tr8
        oPmRk+clL9ITZGvjyjHhGFIYongd4N9S/6rxbdjSA4rlb0fOK+arIA4ihDMXQPmGPNFmV7RG6bqbN
        h9ivQ1Q/fifUrosUuR+KI0mhmasZyWh79wAqYrhOXKwp3ehpdIyL6mI0oINHn0G2riNFJYurJZF8E
        3SG0uGeREez8uPIFfFpWl3sudYe+ZFztfp9w0gDTz54HR2PmDW4TLgXnc7roxp+VYiacwEqIwmCio
        CH58+arw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhPmN-00BcFk-Rs; Thu, 21 Apr 2022 05:54:59 +0000
Date:   Wed, 20 Apr 2022 22:54:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v13 0/7] fsdax: introduce fs query to support reflink
Message-ID: <YmDxs1Hj4H/cu2sd@infradead.org>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220421012045.GR1544202@dread.disaster.area>
 <86cb0ada-208c-02de-dbc9-53c6014892c3@fujitsu.com>
 <CAPcyv4i0Noum8hqHtCpdM5HMVdmNHm3Aj2JCnZ+KZLgceiXYaA@mail.gmail.com>
 <20220421043502.GS1544202@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421043502.GS1544202@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 02:35:02PM +1000, Dave Chinner wrote:
> Sure, I'm not a maintainer and just the stand-in patch shepherd for
> a single release. However, being unable to cleanly merge code we
> need integrated into our local subsystem tree for integration
> testing because a patch dependency with another subsystem won't gain
> a stable commit ID until the next merge window is .... distinctly
> suboptimal.

Yes.  Which is why we've taken a lot of mm patchs through other trees,
sometimes specilly crafted for that.  So I guess in this case we'll
just need to take non-trivial dependencies into the XFS tree, and just
deal with small merge conflicts for the trivial ones.
