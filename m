Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F5EB46A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 06:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbfIQE4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 00:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbfIQE4q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 00:56:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F490216C8;
        Tue, 17 Sep 2019 04:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568696204;
        bh=Deta3mLDOjrS9MA60qe/1+TynhvYp3GzPvxWWxB81ZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrxoadVByuVpgM40BAinFxCJkZ6eNEBhWtJ1X/FBcFtfRuOaHFxqD8UOlzzsySvee
         Ur++qDaVoLWg9Rv/AzTPiXIKDmmtFzs44ba/4vGgYgYkNPEXPUFOt1tk1wp+jIZjHm
         o762u14M0QLQ19CCnKYc3R7QGjXqqHJu3I4elIn0=
Date:   Tue, 17 Sep 2019 06:56:40 +0200
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     devel@driverdev.osuosl.org, Namjae Jeon <linkinjeon@gmail.com>,
        'Valdis Kletnieks' <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190917045640.GA2055638@kroah.com>
References: <CGME20190917025738epcas1p1f1dd21ca50df2392b0f84f0340d82bcd@epcas1p1.samsung.com>
 <003601d56d03$aa04fa00$fe0eee00$@samsung.com>
 <003701d56d04$470def50$d529cdf0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003701d56d04$470def50$d529cdf0$@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 12:02:01PM +0900, Namjae Jeon wrote:
> We are excited to see this happening and would like to state that we appreciate
> time and
> effort which people put into upstreaming exfat. Thank you!
> 
> However, if possible, can we step back a little bit and re-consider it? We
> would prefer to see upstream the code which we are currently using in
> our products - sdfat - as this can be mutually benefitial from various
> points of view.

What is "different" in it from the code that is currently in linux-next?
What is supported "better"?  The code we have today seems to work for
people, so what are we missing here?

Also, submitting patches for this codebase to bring it up to the level
of functionality you need would be wonderful, can you do that?

thanks,

greg k-h
