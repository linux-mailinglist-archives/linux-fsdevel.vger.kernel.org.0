Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDB1494A21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359340AbiATIzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiATIzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:55:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95094C061574;
        Thu, 20 Jan 2022 00:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m3ABMTZ0MqErW8PpbsHm9RBDGHUsM/mvFKByXoormFo=; b=SxEy3X14fIKUJuIVsOyebOtHH3
        sCqrNsrU7uE7l+o3d7nKHHDUetnw9U4hDvA6eBMxhiWfpVGpZrqJyRA0tQvp9ijhHmgKxbPW7OJ6w
        FXyUz8QAZRmZiTnwCnNeFfvf3WvAwMJTXYmqVTenYPkw+eKdFbO+WVJO5h2nwBnpsPL/EpbkwnDXd
        oiYjBb+Pv5nCVlHsD2xl6fcXaGkAp6dvS/B8COFSRJSjp0CHovZdCUqJMXgAjKRxeo68YKCsmj919
        ofA6bccFpyXfML557aIivCGOZTab0MieYiVvRV2WV5QCu2thOPA/kElA4+f8IFd8PaXb0oI22Vupu
        dzeu+kaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nATE4-009xcp-3W; Thu, 20 Jan 2022 08:55:24 +0000
Date:   Thu, 20 Jan 2022 00:55:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v9 08/10] mm: Introduce mf_dax_kill_procs() for fsdax case
Message-ID: <YekjfDJOz2bXgKqv@infradead.org>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-9-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226143439.3985960-9-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please only build the new DAX code if CONFIG_FS_DAX is set.
