Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94061509898
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 09:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385381AbiDUG4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 02:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385379AbiDUG43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:56:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1E418350;
        Wed, 20 Apr 2022 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=e3Har+rE46oN9tVjkAakWJYHtW
        OE12i0bttnBLRZvoim2RjDmKYMhJU6CdbbkaxcamE92w072N9viXb0rmwsbceO+WfuChRoR/Wnmad
        G5ms2QSGlpBKVMq2Pw2eVSnnUrSy2ULzARQAvnS54YpP9CQN1Q2QidrDiQRGY5gEHcDEyZR5/8oTC
        1EohFfCdTUl2kAImUgj7b1lJ2fjrYdFiMnfbXydn36owPdYfkvh2YPX2IfX9zxZ8ZUjD8liueYU7y
        I1cSRM4gdJEoT3d8zqAgirt3CCWvXJ9OFOWc0BVrtm5niA4GZ87nGGMhJigTFOY/ohwCYDlyLIbDh
        +ux3nKJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQfT-00BsA0-CB; Thu, 21 Apr 2022 06:51:55 +0000
Date:   Wed, 20 Apr 2022 23:51:55 -0700
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
Subject: Re: [PATCH v8 3/7] mce: fix set_mce_nospec to always unmap the whole
 page
Message-ID: <YmD/CwS8AsbiC3af@infradead.org>
References: <20220420020435.90326-1-jane.chu@oracle.com>
 <20220420020435.90326-4-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420020435.90326-4-jane.chu@oracle.com>
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
