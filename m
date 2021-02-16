Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A631C793
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 09:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBPIsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 03:48:14 -0500
Received: from verein.lst.de ([213.95.11.211]:40376 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhBPIsL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:48:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 59A2B6736F; Tue, 16 Feb 2021 09:47:28 +0100 (CET)
Date:   Tue, 16 Feb 2021 09:47:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>, Andrey Ignatov <rdna@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc_sysctl: clamp sizes using table->maxlen
Message-ID: <20210216084728.GA23731@lst.de>
References: <20210215145305.283064-1-alex_y_xu.ref@yahoo.ca> <20210215145305.283064-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215145305.283064-1-alex_y_xu@yahoo.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:53:05AM -0500, Alex Xu (Hello71) wrote:
> Since maxlen is already exposed, we can allocate approximately the right
> amount directly, fixing up those drivers which set a bogus maxlen. These
> drivers were located based on those which had copy_x_user replaced in
> 32927393dc1c, on the basis that other drivers either use builtin proc_*
> handlers, or do not access the data pointer. The latter is OK because
> maxlen only needs to be an upper limit.

Please split this into one patch each each subsystem that sets maxlen
to 0 and the actual change to proc_sysctl.c.

How do these maxlen = 0 entries even survive the sysctl_check_table
check?
