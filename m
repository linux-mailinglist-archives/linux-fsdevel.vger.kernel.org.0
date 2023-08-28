Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830B278A5D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 08:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjH1GhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 02:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjH1GhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:37:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34F0126;
        Sun, 27 Aug 2023 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5xtken3ztdTUny1OMfzFaKlaMxo854CajVDA38Kiekk=; b=NcopADFc2/ECJJnc4sPTJV2HCs
        oucoi3FqWUgmmWL2TBAkAp6f5/UWWSPbYwMK2t1FmNf9DCFana51kICNmLtKkXJ761PmFHB0kIciE
        tDPU+fPlvqzYN8rAM/mSYi0biQaE2nJXWR4/LhXs6sXOwn+rDi85UgDnSeFEYvprxuyB0OJDS3X7o
        v2xpNI5oF0c/7+f4qUhZDe9jzBoCkqp/fWoSoiT+ozzUuABOWCY4mt+L1Go7qVWjjcWLM8JX/eIsZ
        5tjE66X7sfMtVGm7PjjSjRMkHZipPHTZVAj/5fkfJ06RMhfPBT227rR2yLfmee/6rVsL/f24aLc1t
        55V7kRVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qaVri-008xc2-1x;
        Mon, 28 Aug 2023 06:36:46 +0000
Date:   Sun, 27 Aug 2023 23:36:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Xueshi Hu <xueshi.hu@smartx.com>,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, jayalk@intworks.biz, daniel@ffwll.ch,
        deller@gmx.de, bcrl@kvack.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, miklos@szeredi.hu,
        mike.kravetz@oracle.com, muchun.song@linux.dev, djwong@kernel.org,
        akpm@linux-foundation.org, hughd@google.com,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: clean up usage of noop_dirty_folio
Message-ID: <ZOxAfrz9etoVUfLQ@infradead.org>
References: <20230819124225.1703147-1-xueshi.hu@smartx.com>
 <20230821111643.5vxtktznjqk42cak@quack3>
 <ZONWka8NpDVGzI8h@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZONWka8NpDVGzI8h@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 01:20:33PM +0100, Matthew Wilcox wrote:
> I was hoping Christoph would weigh in ;-)  I don't have a strong

I've enjoyed 2 weeks of almost uninterrupted vacation.

I agree with this patch and also your incremental improvements.

