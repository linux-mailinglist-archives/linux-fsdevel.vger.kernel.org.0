Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE713D85B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 11:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgAPKvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 05:51:22 -0500
Received: from verein.lst.de ([213.95.11.211]:55329 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgAPKvM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:51:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DE4F68B20; Thu, 16 Jan 2020 11:51:09 +0100 (CET)
Date:   Thu, 16 Jan 2020 11:51:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 00/14] add the latest exfat driver
Message-ID: <20200116105108.GA16924@lst.de>
References: <CGME20200115082818epcas1p4892a99345626188afd111ee263132458@epcas1p4.samsung.com> <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115094732.bou23s3bduxpnr4k@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115094732.bou23s3bduxpnr4k@pali>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 10:47:32AM +0100, Pali Rohár wrote:
> Next steps for future:
> 
> * De-duplicate cache code between fat and exfat. Currently fs/exfat
>   cache code is heavily copy-paste of fs/fat cache code.

As said before I don't think this should be a merge blocker.  I actually
see this more of an experiment as the sharing might make things worse.
But at least it is worth giving it a try.

> * De-duplicate UTF-16 functions. Currently fs/exfat has e.g. helper
>   functions for surrogate pairs copy-paste from fs/nls.

If you looked into that can you post a list of suspected duplicates?

> 
> * Unify EXFAT_DEFAULT_IOCHARSET and FAT_DEFAULT_IOCHARSET. Or maybe
>   unify it with other filesystems too.

For the initial merge I think they should be kept separate, as
referencing other file systems Kconfig variable is confusing.
Investingating if we could a single common one sounds like a good idea,
though.

> * After applying this patch series, remote staging exfat implementation.

I think Greg wants to do that separately.  I still hope we can do that
in the same merge window, though.
