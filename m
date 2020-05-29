Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E561E7ACF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgE2Kls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:41:48 -0400
Received: from smtp64.ord1c.emailsrvr.com ([108.166.43.64]:48984 "EHLO
        smtp64.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726727AbgE2Klr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1590748489;
        bh=tZ37TYCg+AHlbtdGPYkEUTa6JxWrTCxFrppFEuJaYxc=;
        h=Subject:To:From:Date:From;
        b=FTDW2P8vKQbfH4nGpiC6/EHPbg4Ug21vqqNhDqreRifC/f+mSmY4hlWmn+wZZniza
         nWT2Pug9MuRDoCeKKCTXX6yxNq8GQCnJDscDXKVWyRRB7n60BdJgZso/66m4MSBFja
         w5HNwHcLPGIzjxKpx9qxTMzfoHyG/MgItRcWkJ+M=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E9CD2600BE;
        Fri, 29 May 2020 06:34:48 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 29 May 2020 06:34:49 -0400
Subject: Re: [PATCH 02/10] comedi: get rid of indirection via
 translated_ioctl()
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200529003419.GX23230@ZenIV.linux.org.uk>
 <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
 <20200529003512.4110852-2-viro@ZenIV.linux.org.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <acff53af-a75b-6af6-0092-bdf492585a58@mev.co.uk>
Date:   Fri, 29 May 2020 11:34:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529003512.4110852-2-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 41543ff4-19d4-465c-8c5d-fe78962b022e-1-1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/05/2020 01:35, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   drivers/staging/comedi/comedi_fops.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
