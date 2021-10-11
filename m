Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD61F4295E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhJKRku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 13:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhJKRku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:40:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124DC061570;
        Mon, 11 Oct 2021 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fqo0bOo+F5lZRYgiET0CW5nvyhKmvaEXp+bcdf+ccbw=; b=1LWqsMn801DWb+NcykVCpYJY65
        0gD0wExbtScZBgSvPDhyfg887T8q5b+g+3/gx7GdjUzptBSwMtH4pmoP8ydx/yrJmr2zq4TAc0JRo
        bzDCPuBXcpj/flwzflb/t/KbKlM9Pqx9NmSYuTVxf7L0CZBH37aVXUlbtM9pkaYVgxxM67sSAEfZd
        PL2d4diZe13nFvt8BpGy2d1BZpOmdXrLGQAxcDYGmNqKgWlacyqS/XRBtnWVtuGGaoZelbNXRN0Ji
        bItlljvIQPD7JGI5g/oenwVX0nhNuVKTf4V2NoMg5TnrOD0jk4MyZRxgzaDeOhNi1xNI6xwIeYHq1
        BbOBcLlw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZzG9-00AFsC-6i; Mon, 11 Oct 2021 17:38:45 +0000
Date:   Mon, 11 Oct 2021 10:38:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, akpm@linux-foundation.org, minchan@kernel.org,
        jeyu@kernel.org, shuah@kernel.org, bvanassche@acm.org,
        dan.j.williams@intel.com, joe@perches.com, tglx@linutronix.de,
        keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/12] selftests: add tests_sysfs module
Message-ID: <YWR2pSIC96Dw8nRn@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-4-mcgrof@kernel.org>
 <YVxeTvKkYs938g94@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVxeTvKkYs938g94@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 04:16:46PM +0200, Greg KH wrote:
> On Mon, Sep 27, 2021 at 09:37:56AM -0700, Luis Chamberlain wrote:
> > --- /dev/null
> > +++ b/lib/test_sysfs.c
> > @@ -0,0 +1,921 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> > +/*
> > + * sysfs test driver
> > + *
> > + * Copyright (C) 2021 Luis Chamberlain <mcgrof@kernel.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the Free
> > + * Software Foundation; either version 2 of the License, or at your option any
> > + * later version; or, when distributed separately from the Linux kernel or
> > + * when incorporated into other software packages, subject to the following
> > + * license:
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of copyleft-next (version 0.3.1 or later) as published
> > + * at http://copyleft-next.org/.
> 
> Independant of the fact that I don't like sysfs code attempting to be
> accessed in the kernel with licenses other than GPLv2, you do not need
> the license "boilerplate" text at all in files.  That's what the SPDX
> line is for.

Sure, I'll remove the boilerplate, sorry for missing that again, I
thought I had removed it.

  Luis
