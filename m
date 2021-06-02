Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45689398086
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 07:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFBFDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 01:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhFBFDJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 01:03:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8785F611CA;
        Wed,  2 Jun 2021 05:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622610037;
        bh=yMrwYK6CMtahW7OxvqYZ+g+ggUse/aAyvO/k3uWtkjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLatxzD1y4Wp+0NxczqzW5QvpTyf8awvJIy79RgcBu599AhQ9t5ZBIaxm8OeAGXCT
         WFVCmWKhGBkI4mt4T1HOpST0Ubt7IR1EFEv+e9nIBLzUsmUV5RLppYPBOqth34F/ay
         L+FAqIi+Q8V7csfNq7eqcjOIZ4XWuhvQOfm/2Hi8=
Date:   Wed, 2 Jun 2021 07:00:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Eli Billauer <eli.billauer@gmail.com>
Subject: Re: mmotm 2021-06-01-19-57 uploaded (xillybus)
Message-ID: <YLcQc0sHBaYViZIN@kroah.com>
References: <20210602025803.3TVVfGdaW%akpm@linux-foundation.org>
 <d880c052-e3e3-3af7-040d-7abdc97df1d1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d880c052-e3e3-3af7-040d-7abdc97df1d1@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 01, 2021 at 09:03:56PM -0700, Randy Dunlap wrote:
> On 6/1/21 7:58 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2021-06-01-19-57 has been uploaded to
> > 
> >    https://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > https://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > https://ozlabs.org/~akpm/mmotm/series
> > 
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> 
> (on i386)
> 
> CONFIG_XILLYBUS_CLASS=y
> CONFIG_XILLYBUS=m
> CONFIG_XILLYUSB=y
> 
> ERROR: modpost: "xillybus_cleanup_chrdev" [drivers/char/xillybus/xillybus_core.ko] undefined!
> ERROR: modpost: "xillybus_init_chrdev" [drivers/char/xillybus/xillybus_core.ko] undefined!
> ERROR: modpost: "xillybus_find_inode" [drivers/char/xillybus/xillybus_core.ko] undefined!
> 
> 
> Full randconfig file is attached.

Sorry about that, I have a fix in my inbox for this that I will push out
later today...

greg k-h
