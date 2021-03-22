Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1876B344653
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 14:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhCVN5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 09:57:51 -0400
Received: from verein.lst.de ([213.95.11.211]:55847 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCVN5Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:57:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A71868BEB; Mon, 22 Mar 2021 14:57:18 +0100 (CET)
Date:   Mon, 22 Mar 2021 14:57:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        hyc.lee@gmail.com, viro@zeniv.linux.org.uk, hch@lst.de,
        hch@infradead.org, ronniesahlberg@gmail.com,
        aurelien.aptel@gmail.com, aaptel@suse.com, sandeen@sandeen.net,
        dan.carpenter@oracle.com, colin.king@canonical.com,
        rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <20210322135718.GA28451@lst.de>
References: <20210322051344.1706-1-namjae.jeon@samsung.com> <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com> <20210322051344.1706-4-namjae.jeon@samsung.com> <20210322081512.GI1719932@casper.infradead.org> <YFhdWeedjQQgJdbi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFhdWeedjQQgJdbi@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 06:03:21PM +0900, Sergey Senozhatsky wrote:
> On (21/03/22 08:15), Matthew Wilcox wrote:
> > 
> > What's the scenario for which your allocator performs better than slub
> > 
> 
> IIRC request and reply buffers can be up to 4M in size. So this stuff
> just allocates a number of fat buffers and keeps them around so that
> it doesn't have to vmalloc(4M) for every request and every response.

Do we have any data suggesting it is faster than vmalloc?
