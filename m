Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C8E4A7C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfFRQ6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 12:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbfFRQ6w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:58:52 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F52B206E0;
        Tue, 18 Jun 2019 16:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560877131;
        bh=3vKBeAv0ShrIxat0BRxsGm3sPQZrnnaIEz4l4EoSWqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LE7EIq6eA2PpxpOB1likILRe0O8eGxX/GDvOgCYGT38/kRS9NlSM1Kuz5tGlTlTm0
         wnaCikRm2uhxP3Pv2kbqMbs6aaqTTjd2hbYAt5k4w08SaLKVg8D7DsKU3aBQjBmY56
         Inj4c3YclM86a8bTlmUILWCHPZboeq+XH8FsmLDM=
Date:   Tue, 18 Jun 2019 09:58:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Victor Hsieh <victorhsieh@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 13/16] fs-verity: support builtin file signatures
Message-ID: <20190618165849.GE184520@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-14-ebiggers@kernel.org>
 <20190615152143.GN6142@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615152143.GN6142@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 15, 2019 at 11:21:43AM -0400, Theodore Ts'o wrote:
> On Thu, Jun 06, 2019 at 08:52:02AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > To meet some users' needs, add optional support for having fs-verity
> > handle a portion of the authentication policy in the kernel.  An
> > ".fs-verity" keyring is created to which X.509 certificates can be
> > added; then a sysctl 'fs.verity.require_signatures' can be set to cause
> > the kernel to enforce that all fs-verity files contain a signature of
> > their file measurement by a key in this keyring.
> 
> I think it might be a good idea to allow the require_signatures
> setting to be set on a per-file system basis, via a mount option?  We
> could plumb it in via a flag in fsverity_info, set by the file system.

Perhaps, but this is something that can be added later, so I think we should
hold off on it until someone needs it.

> 
> Other than this feature request, looks good; you can add:
> 
> Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>
> 

I assume you mean "Reviewed-by" :-)

- Eric
