Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013205210F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiEJJgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 05:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbiEJJgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 05:36:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F8A28F7F2;
        Tue, 10 May 2022 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G7+t/cAdYkqhs1QKuzowXwkwfS2OErx0X9UCnaiTRWU=; b=VgR1nQ1NVLWRbOgBvrbdCW/4tg
        ychxbwVZwl2wzAJjDn82fADKlUzvqITtssspoU+g2VDWJfuI9SKZDpw4BVKWlWrDTU0XfqXhbQrYZ
        WKsLZ/tHz1Oj9CIASd5pspPSEvR6ACnPwg6AFRYXHa3oDOfrd5yuWvTM17QxpTXCOioNjdDjldZ6d
        vyJ2XQVtb61LMMqHRwqmMMmqq8uttx8xIsYIvQWU3SR3NetOIhVS0qBwW4byGtvMzw6EzmDwGsyuN
        QHgviNlvIN8gesVdFW+7rdefORH7XD1/y3kq+w19jJFGCFb2ZW8B+r+RVhAarU07kW0L4Y5OwN5Ss
        mMbcdJaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noMER-000qQy-Rm; Tue, 10 May 2022 09:32:39 +0000
Date:   Tue, 10 May 2022 02:32:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com, rgoldwyn@suse.de, viro@zeniv.linux.org.uk,
        willy@infradead.org, naoya.horiguchi@nec.com, linmiaohe@huawei.com
Subject: Re: [PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink
Message-ID: <YnoxN0T/RBbxsqI7@infradead.org>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch numbering due looks odd due to the combination of the
two series.  But otherwise this looks good to me modulo the one
minor nitpick.
