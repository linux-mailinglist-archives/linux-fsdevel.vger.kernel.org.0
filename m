Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1E1464F9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349907AbhLAO3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 09:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349900AbhLAO3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:29:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D704C061574;
        Wed,  1 Dec 2021 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x7ZhiAQMW7HzLfSI2FX07G540SUWchnOtaaE+4hrTgA=; b=S3NnGzuqjzeMcqo6+7imcJ9T2L
        1H8L3nmxWtpmg/t2ORnauRi7zEvy94Aep7F9T89L/lM61e+d+s2yNa8aZafGg31+uBMntYrT5JhOw
        tzFs+Jd6T4NkXX6bP783HF5bweUQhROPjpakP8viGW9TjeMyKkcOJl6GoEtk6makcG/Mbj6KLkDLr
        /7KGoB4cLC/C+onO8DrXHHUgY9dtR2d5r4Lh6SIFqvDwvFVLSLSrRUJ06ADeWmxFUdRJMZmbu1yVc
        QgP2pEHSkfxqF1znNjZw+ZKhzv1bkdNbt+k0b4bpSxPjq2qWdGzSdHPwgGgbdPXoMBPIeCG5RL+y9
        3hiMHIPQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msQYI-009193-NO; Wed, 01 Dec 2021 14:25:42 +0000
Date:   Wed, 1 Dec 2021 06:25:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        steve@sk2.org, rafael@kernel.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, pmladek@suse.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] firmware_loader: export sysctl registration
Message-ID: <YaeF5tgWA3TDX1+M@bombadil.infradead.org>
References: <20211130164525.1478009-1-mcgrof@kernel.org>
 <YacfULGI1mhE/0iv@kroah.com>
 <Yad9Iu8K9k/NvKJj@bombadil.infradead.org>
 <YaeErF5h+SQkxBXC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaeErF5h+SQkxBXC@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 01, 2021 at 03:20:28PM +0100, Greg KH wrote:
> On Wed, Dec 01, 2021 at 05:48:18AM -0800, Luis Chamberlain wrote:
> > On Wed, Dec 01, 2021 at 08:08:00AM +0100, Greg KH wrote:
> > > On Tue, Nov 30, 2021 at 08:45:25AM -0800, Luis Chamberlain wrote:
> > > > The firmware loader fallback sysctl table is always built-in,
> > > > but when FW_LOADER=m the build will fail. We need to export
> > > > the sysctl registration and de-registration. Use the private
> > > > symbol namespace so that only the firmware loader uses these
> > > > calls.
> > > > 
> > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Fixes: firmware_loader: move firmware sysctl to its own files
> > > 
> > > Have a git id for this?
> > 
> > I thought it would be ephemeral at this point since it was on
> > linux-next, so had not provided one. If it is a static commit
> > then I suppose this is 5cc0fea09ee52c9bcb6c41456bea03ca1b49602d
> 
> Depends on where it came from.  If -mm then yes, it's not a valid id.
> If someone else, it might be a real id.

It came in through -mm.

  Luis
