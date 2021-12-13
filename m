Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CAE472201
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 08:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhLMH53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 02:57:29 -0500
Received: from verein.lst.de ([213.95.11.211]:46518 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhLMH52 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:57:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5697668AA6; Mon, 13 Dec 2021 08:57:25 +0100 (CET)
Date:   Mon, 13 Dec 2021 08:57:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] vmcore: Convert copy_oldmem_page() to take an
 iov_iter
Message-ID: <20211213075725.GA20986@lst.de>
References: <20211213000636.2932569-1-willy@infradead.org> <20211213000636.2932569-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213000636.2932569-2-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:06:34AM +0000, Matthew Wilcox (Oracle) wrote:
> Instead of passing in a 'buf' and 'userbuf' argument, pass in an iov_iter.
> s390 needs more work to pass the iov_iter down further, or refactor,
> but I'd be more comfortable if someone who can test on s390 did that work.
> 
> It's more convenient to convert the whole of read_from_oldmem() to
> take an iov_iter at the same time, so rename it to read_from_oldmem_iter()
> and add a temporary read_from_oldmem() wrapper that creates an iov_iter.

This looks pretty reasonable.  s390 could use some love from people that
know the code, and yes, the kerneldoc comments should go away.
