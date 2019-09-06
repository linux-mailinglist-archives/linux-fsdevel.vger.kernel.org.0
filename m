Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86602ABC88
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394808AbfIFPb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 11:31:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56480 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392183AbfIFPb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:31:56 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-96.corp.google.com [104.133.0.96] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x86FVlN0017116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Sep 2019 11:31:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7F13142049E; Fri,  6 Sep 2019 11:31:47 -0400 (EDT)
Date:   Fri, 6 Sep 2019 11:31:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Colin King <colin.king@canonical.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicode: make array 'token' static const, makes object
 smaller
Message-ID: <20190906153147.GA2819@mit.edu>
References: <20190906135807.23152-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906135807.23152-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 02:58:07PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array 'token' on the stack but instead make it
> static const. Makes the object code smaller by 234 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    5371	    272	      0	   5643	   160b	fs/unicode/utf8-core.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    5041	    368	      0	   5409	   1521	fs/unicode/utf8-core.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Nice, thanks!

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
