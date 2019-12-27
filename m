Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E758C12BB33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 22:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfL0VUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 16:20:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46104 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726455AbfL0VUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 16:20:13 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBRLJwwQ022476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Dec 2019 16:19:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 68AFC420485; Fri, 27 Dec 2019 16:19:58 -0500 (EST)
Date:   Fri, 27 Dec 2019 16:19:58 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Filesystem Development List 
        <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] memcg: fix a crash in wb_workfn when a device disappears
Message-ID: <20191227211958.GA154182@mit.edu>
References: <20191227194829.150110-1-tytso@mit.edu>
 <201912280556.y1lprcKe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912280556.y1lprcKe%lkp@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 28, 2019 at 05:16:49AM +0800, kbuild test robot wrote:
> Hi Theodore,
> 
> I love your patch! Yet something to improve:
> 
>    In file included from mm/fadvise.c:16:0:
>    include/linux/backing-dev.h: In function 'bdi_dev_name':
> >> include/linux/backing-dev.h:513:9: error: implicit declaration of function 'dev_name'; did you mean 'getname'? [-Werror=implicit-function-declaration]
>      return dev_name(bdi->dev);
>             ^~~~~~~~
>             getname

Already fixed in the V2 version of the patch.  (Which I also forgot to label as V2, sigh...)

