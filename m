Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB5169718
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 10:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBWJ7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 04:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgBWJ7A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:59:00 -0500
Received: from localhost (95-141-97-180.as16211.net [95.141.97.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B47206ED;
        Sun, 23 Feb 2020 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582451939;
        bh=KbIp2h1itndb8z8A7NFO2UKLvzKKoatt6JPF3Z8iWH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wj6i3CnOU/UxRc9Gl6oVN572WYzmf8ExSiIZ4FizVa/YVIntNylwYCANktAmTPa9t
         eq4H9yWmoP9ujzXJ0ilBaOzEEqjLoe6R6qMFGcvixZeU9Pwnpn6eLiX3oqCZUx1Nre
         Q34Ik+ayab2YxxBg6aDIGK9egB+nT5vr0P4XkMDQ=
Date:   Sun, 23 Feb 2020 10:58:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Sanderson <kyle.leet@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        michael+lkml@stapelberg.ch
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
Message-ID: <20200223095856.GA120495@kroah.com>
References: <CACsaVZJ7V8hefM+dxY7Rgf8RR7jqcnJgZt+zgT+KM+UQwT7U2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsaVZJ7V8hefM+dxY7Rgf8RR7jqcnJgZt+zgT+KM+UQwT7U2g@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 22, 2020 at 11:29:59AM -0800, Kyle Sanderson wrote:
> Greg: can we take take this to stable for 5.4.22?

It needs to be in Linus's tree first.  Let me and stable@vger.kernel.org
know the git commit id of this when it lands there.

thanks,

greg k-h
