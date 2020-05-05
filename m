Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75781C6235
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 22:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgEEUnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 16:43:02 -0400
Received: from verein.lst.de ([213.95.11.211]:37315 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgEEUnB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 16:43:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1513E68C4E; Tue,  5 May 2020 22:42:59 +0200 (CEST)
Date:   Tue, 5 May 2020 22:42:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove set_fs calls from the coredump code v6
Message-ID: <20200505204258.GA24277@lst.de>
References: <20200505101256.3121270-1-hch@lst.de> <20200505203446.GZ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505203446.GZ23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 09:34:46PM +0100, Al Viro wrote:
> Looks good.  Want me to put it into vfs.git?  #work.set_fs-exec, perhaps?

Sounds good.
