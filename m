Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50649464F08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 14:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349669AbhLANxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 08:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349653AbhLANxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:53:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89040C06175B;
        Wed,  1 Dec 2021 05:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OA3C6eAJyO11mJisGgWVf58QA2xEZ0yk0l6SQUd5O5A=; b=bM+BGcNpPjSN9k9h+9Pt6NHnOU
        +heQDNEKhBhhWMRKk8b8okcq0C0DJSqUs+RbaZJR3uoosOKnlyazlnUFzvwlgP9ipSwDdDVNfvtBe
        B83t0kL5FKdIjdzIjJGOWjsxxW2vMaBwm/EAouQQK7BMerdU+BVkFUJey7Ktesi8/XAj3s3bg9Q2D
        I5pHbdJ7PinjKOwYI3rs0xy4dKBfy+XSJ5D2JKaPJZllhi3+UAS4bzbMJN0ZKlC0TnRuZgwwrGKt8
        nrtO9jLFqTURtOeXnt2buU9Lh2aiQV6nEehD+Cl67pImcm6fY9006PUHnNSNdCU3iypqvbSLxZBBi
        ObTGxaLw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msPy7-008szk-0m; Wed, 01 Dec 2021 13:48:19 +0000
Date:   Wed, 1 Dec 2021 05:48:18 -0800
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
Message-ID: <Yad9Iu8K9k/NvKJj@bombadil.infradead.org>
References: <20211130164525.1478009-1-mcgrof@kernel.org>
 <YacfULGI1mhE/0iv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YacfULGI1mhE/0iv@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 01, 2021 at 08:08:00AM +0100, Greg KH wrote:
> On Tue, Nov 30, 2021 at 08:45:25AM -0800, Luis Chamberlain wrote:
> > The firmware loader fallback sysctl table is always built-in,
> > but when FW_LOADER=m the build will fail. We need to export
> > the sysctl registration and de-registration. Use the private
> > symbol namespace so that only the firmware loader uses these
> > calls.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Fixes: firmware_loader: move firmware sysctl to its own files
> 
> Have a git id for this?

I thought it would be ephemeral at this point since it was on
linux-next, so had not provided one. If it is a static commit
then I suppose this is 5cc0fea09ee52c9bcb6c41456bea03ca1b49602d

  Luis
