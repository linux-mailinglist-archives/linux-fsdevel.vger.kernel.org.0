Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC872464F83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 15:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349871AbhLAOYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 09:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhLAOXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:23:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A07C061574;
        Wed,  1 Dec 2021 06:20:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A70B3B81F6F;
        Wed,  1 Dec 2021 14:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E25C53FAD;
        Wed,  1 Dec 2021 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638368430;
        bh=SVDEPqtuMwrD/a4lMbcM2PLLJvtp7TFaglXBQE8xrpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMS7CKCKeIhOXVjPlFpNRx/GXeYJVayxe42eChPAB5gaEfkjVtVpQh8DtuNqBjGn1
         02EhPDPjiqqv+Sl+GpV0CYcR/HtBxoTBs5pDPqR13OeTIuHZ8y/TpEWhsUAoKPO9v4
         /uvUN4LH1qkpqyzLsgo4n+lVl3sjRfFap5UMu1V8=
Date:   Wed, 1 Dec 2021 15:20:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <YaeErF5h+SQkxBXC@kroah.com>
References: <20211130164525.1478009-1-mcgrof@kernel.org>
 <YacfULGI1mhE/0iv@kroah.com>
 <Yad9Iu8K9k/NvKJj@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yad9Iu8K9k/NvKJj@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:48:18AM -0800, Luis Chamberlain wrote:
> On Wed, Dec 01, 2021 at 08:08:00AM +0100, Greg KH wrote:
> > On Tue, Nov 30, 2021 at 08:45:25AM -0800, Luis Chamberlain wrote:
> > > The firmware loader fallback sysctl table is always built-in,
> > > but when FW_LOADER=m the build will fail. We need to export
> > > the sysctl registration and de-registration. Use the private
> > > symbol namespace so that only the firmware loader uses these
> > > calls.
> > > 
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Fixes: firmware_loader: move firmware sysctl to its own files
> > 
> > Have a git id for this?
> 
> I thought it would be ephemeral at this point since it was on
> linux-next, so had not provided one. If it is a static commit
> then I suppose this is 5cc0fea09ee52c9bcb6c41456bea03ca1b49602d

Depends on where it came from.  If -mm then yes, it's not a valid id.
If someone else, it might be a real id.

thanks,

greg k-h
