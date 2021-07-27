Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8143D73D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhG0K4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 06:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236169AbhG0K4k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:56:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DE1B610D0;
        Tue, 27 Jul 2021 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627383400;
        bh=My1hFxLIoL4zor/pxnwa2g6fPZpcl3gYwOFmxyTl808=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEYY/HQWnsepYjtPabJ/8erELdc20SDqE/qqmc09h8wzHAJnLlp1ge58zbU+qCiQ8
         W9aoI5CgryfjIoNJRK73bPePlCBU75NvPrdnxzPTuWjxQyLH1Jc9p9Jx0PRE83E3va
         itofSS7nISMER2McCtVu+lJ2R6EP1dT1ZkG+X9lA=
Date:   Tue, 27 Jul 2021 12:56:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jordy Zomer <jordy@pwning.systems>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] fs: make d_path-like functions all have unsigned size
Message-ID: <YP/mZjsOVsvTmV11@kroah.com>
References: <20210727103625.74961-1-gregkh@linuxfoundation.org>
 <YP/k0Nn/UnaKiKq2@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP/k0Nn/UnaKiKq2@lx-t490>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:49:52PM +0200, Ahmed S. Darwish wrote:
> On Tue, Jul 27, 2021, Greg Kroah-Hartman wrote:
> >
> > Resolve all of the abuguity by just making "size" an unsigned value,
> > which takes the guesswork out of everything involved.
> >
> 
> Pardon my ignorance, but why not size_t instead of an unsigned int? I
> feel it will be more clear this way; but, yes, on 64-bit machines this
> will extend the buflen param to 64-bit.

I have no objection moving it to size_t, but as you say, I don't think
it's needed to make the buffer get that big.

thanks,

greg k-h
