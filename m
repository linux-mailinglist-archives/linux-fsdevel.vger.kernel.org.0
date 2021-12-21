Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DA347BBDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 09:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhLUIaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 03:30:22 -0500
Received: from verein.lst.de ([213.95.11.211]:45837 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhLUIaU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:30:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 62DCD68B05; Tue, 21 Dec 2021 09:30:17 +0100 (CET)
Date:   Tue, 21 Dec 2021 09:30:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] vmcore: Convert read_from_oldmem() to take an
 iov_iter
Message-ID: <20211221083017.GC6008@lst.de>
References: <20211213143927.3069508-1-willy@infradead.org> <20211213143927.3069508-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213143927.3069508-4-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:39:27PM +0000, Matthew Wilcox (Oracle) wrote:
> Remove the read_from_oldmem() wrapper introduced earlier and convert
> all the remaining callers to pass an iov_iter.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
