Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30D61BC046
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgD1Nyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 09:54:32 -0400
Received: from verein.lst.de ([213.95.11.211]:56361 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgD1Nyc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:54:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 064B668CEC; Tue, 28 Apr 2020 15:54:30 +0200 (CEST)
Date:   Tue, 28 Apr 2020 15:54:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] powerpc/spufs: fix copy_to_user while atomic
Message-ID: <20200428135429.GB2827@lst.de>
References: <20200427200626.1622060-2-hch@lst.de> <20200428120207.15728-1-jk@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428120207.15728-1-jk@ozlabs.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 08:02:07PM +0800, Jeremy Kerr wrote:
> Currently, we may perform a copy_to_user (through
> simple_read_from_buffer()) while holding a context's register_lock,
> while accessing the context save area.
> 
> This change uses a temporary buffers for the context save area data,
> which we then pass to simple_read_from_buffer.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> ---
> 
> Christoph - this fixes the copy_to_user while atomic, hopefully with
> only minimal distruption to your series.

I recognize plenty of sniplets from that :)  Your patch looks good
to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
