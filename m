Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE22D1E7AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgE2KmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:42:02 -0400
Received: from smtp83.ord1c.emailsrvr.com ([108.166.43.83]:56853 "EHLO
        smtp83.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgE2KmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1590748452;
        bh=yCvom2D8fKO5776dLtgDe8lzDpNDp9f5XRzVAQRn91c=;
        h=Subject:To:From:Date:From;
        b=RGK3MXyjUZtTMTEu67x3IDhRpoMQs+cgWWY+ZT67qWTlYQa859jSGvN8Oj0qsojJZ
         MN9ZyBZ5YlEvm09Z/xRh40MJ+3mD4BeezxRsQnsCF6SQIXnFZv51cCiZ3eN6gTg5hs
         5Rws+O21VGb4UZGBdboDC6yl6N52FpswBsIdzKAE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp19.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 7DF3EA012D;
        Fri, 29 May 2020 06:34:11 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 29 May 2020 06:34:12 -0400
Subject: Re: [PATCH 01/10] comedi: move compat ioctl handling to native fops
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200529003419.GX23230@ZenIV.linux.org.uk>
 <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <a1372fdf-8549-bb62-88bb-adb829bba4d0@mev.co.uk>
Date:   Fri, 29 May 2020 11:34:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 1550f170-823d-4ee1-915e-9e4ad594f501-1-1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/05/2020 01:35, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> mechanical move
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   drivers/staging/comedi/Makefile          |   1 -
>   drivers/staging/comedi/comedi_compat32.c | 455 -------------------------------
>   drivers/staging/comedi/comedi_compat32.h |  28 --
>   drivers/staging/comedi/comedi_fops.c     | 451 +++++++++++++++++++++++++++++-
>   4 files changed, 448 insertions(+), 487 deletions(-)
>   delete mode 100644 drivers/staging/comedi/comedi_compat32.c
>   delete mode 100644 drivers/staging/comedi/comedi_compat32.h
> 

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
