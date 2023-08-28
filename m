Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF11578AFEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjH1MTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjH1MSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:18:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550BEA;
        Mon, 28 Aug 2023 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ve4BHXYYDtHmo8gKLNw/Y51LgqpTIonHiBSys2mOFvE=; b=YPhPLM4VvUMqhydvfSNnt3IVIo
        NF6Vq7yPJcJOISvvC4reeQp3n1ILZOteFy3C8qgXMu4BN5F+3Ea5qT5OQQzKjL5vvxaF+OeuArG4/
        9gcwlmXRv0MRBTaMxcRLKff80PQlGThqLFVyU3UU8e1RtbDQ0Rh7Iy1P7qQiz28L2FawNSPOuin+n
        WmjOTHU6a13xRi2ppuVNSsD4Yv/Px1AQcCDqjtRQlyxj38R2gS711V7U+aQIqdfVf7OjwRA4MrYiY
        QQG/IITuIyF6/xLNZ0cI7vhTTlAe7bcUD/i/7EFI5RN69Qp51h1s9P2mRnYh44ewIkXIDkMgD1kBV
        bYvHDEww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qabBw-000BZW-FS; Mon, 28 Aug 2023 12:18:00 +0000
Date:   Mon, 28 Aug 2023 13:18:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xueshi Hu <xueshi.hu@smartx.com>
Cc:     hch@infradead.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        jayalk@intworks.biz, daniel@ffwll.ch, deller@gmx.de,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        miklos@szeredi.hu, mike.kravetz@oracle.com, muchun.song@linux.dev,
        djwong@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] fs: clean up usage of noop_dirty_folio
Message-ID: <ZOyQePmvT6LaJst+@casper.infradead.org>
References: <20230828075449.262510-1-xueshi.hu@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828075449.262510-1-xueshi.hu@smartx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 03:54:49PM +0800, Xueshi Hu wrote:
> In folio_mark_dirty(), it can automatically fallback to
> noop_dirty_folio() if a_ops->dirty_folio is not registered.
> 
> As anon_aops, dev_dax_aops and fb_deferred_io_aops becames empty, remove
> them too.
> 
> Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
