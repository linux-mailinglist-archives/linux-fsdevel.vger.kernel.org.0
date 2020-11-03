Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B702A4F4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 19:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgKCSsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 13:48:18 -0500
Received: from verein.lst.de ([213.95.11.211]:38682 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCSsS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:48:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F29A6736F; Tue,  3 Nov 2020 19:48:15 +0100 (CET)
Date:   Tue, 3 Nov 2020 19:48:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: support splice reads on seq_file based procfs files
Message-ID: <20201103184815.GA24136@lst.de>
References: <20201029100950.46668-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029100950.46668-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping?

On Thu, Oct 29, 2020 at 11:09:47AM +0100, Christoph Hellwig wrote:
> Hi Al,
> 
> Greg reported a problem due to the fact that Android tests use procfs
> files to test splice, which stopped working with 5.10-rc1.  This series
> adds read_iter support for seq_file, and uses those for all proc files
> using seq_file to restore splice read support.
---end quoted text---
