Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC42168E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 19:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfEGROD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 13:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfEGROD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 13:14:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1E772053B;
        Tue,  7 May 2019 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557249242;
        bh=FKPYiaoR8KZoQNxUjndvOR95F/ZO5wjILQJE3WvJ030=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vcDUCGRMRaayeNiHCHHcMha9/T7wiVZ/QmBKmFfoSoZiVPbVjUrlWfJ2KjAzt3KO2
         LW/cbeH6Ihpezbz+BmLQX9An+mqwWzNkK5WaO7X9TpcaPcjXLJ5rgMOrm+Xi/17z2m
         b4n0LXGLUIINs+gtKhxxYXno4/5FWZ4zydqaccLY=
Date:   Tue, 7 May 2019 19:13:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ezemtsov@google.com
Cc:     linux-fsdevel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 1/6] incfs: Add first files of incrementalfs
Message-ID: <20190507171359.GA5885@kroah.com>
References: <20190502040331.81196-1-ezemtsov@google.com>
 <20190502040331.81196-2-ezemtsov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502040331.81196-2-ezemtsov@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 09:03:26PM -0700, ezemtsov@google.com wrote:
> +Sysfs files
> +-----------
> +``/sys/fs/incremental-fs/version`` - a current version of the filesystem.
> +One ASCII encoded positive integer number with a new line at the end.

sysfs (no "S" please) documentation goes in Documentation/ABI/, not
burried in a random file somewhere else :)

Also, "filesystem version" does not make much sense, does it?  Why does
userspace care about this, all they really care about is the _kernel_
version.  We do not independantly version the individual components of
the kernel, that way lies madness.

thanks,

greg k-h
