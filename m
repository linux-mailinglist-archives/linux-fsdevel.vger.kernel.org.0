Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58FE46479F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 08:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347101AbhLAHL2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 02:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhLAHL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:11:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2BC061574;
        Tue, 30 Nov 2021 23:08:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C9C0B81DD9;
        Wed,  1 Dec 2021 07:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABF3C53FAD;
        Wed,  1 Dec 2021 07:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638342484;
        bh=yfIMUIvts+TyrLXbtbjnXJs9LD9n68BaPAB4iOgy3qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7jJU9WIP9DMXDmam/SjhaiuzPS7Ra7/EYXmguLkxqGe5u7VGZnYbFpFWCikUX7KY
         KUIFgXQJaW9plm8jIHkHRWg4gcFgqVwdTl5/SqAOgnoPIsUn/bsTJv8C754OltOW50
         ME2+ljRebs92eTK/rzjKsahTiLe4BpPO4ueGoW3o=
Date:   Wed, 1 Dec 2021 08:08:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        steve@sk2.org, rafael@kernel.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, pmladek@suse.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mcgrof@bombadil.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] firmware_loader: export sysctl registration
Message-ID: <YacfULGI1mhE/0iv@kroah.com>
References: <20211130164525.1478009-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130164525.1478009-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 08:45:25AM -0800, Luis Chamberlain wrote:
> The firmware loader fallback sysctl table is always built-in,
> but when FW_LOADER=m the build will fail. We need to export
> the sysctl registration and de-registration. Use the private
> symbol namespace so that only the firmware loader uses these
> calls.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: firmware_loader: move firmware sysctl to its own files

Have a git id for this?

thanks,

greg k-h
