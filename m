Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B4A3776F4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 May 2021 16:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhEIOVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 10:21:45 -0400
Received: from out20-61.mail.aliyun.com ([115.124.20.61]:45091 "EHLO
        out20-61.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhEIOVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 10:21:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1785249|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0585677-0.000373755-0.941059;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.KAhBuP0_1620570039;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KAhBuP0_1620570039)
          by smtp.aliyun-inc.com(10.147.40.2);
          Sun, 09 May 2021 22:20:39 +0800
Date:   Sun, 9 May 2021 22:20:38 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 0/3] bcachefs support
Message-ID: <YJfvtvBCqA4zU0xf@desktop>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427164419.3729180-1-kent.overstreet@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:44:16PM -0400, Kent Overstreet wrote:
> A small patch adding bcachefs support, and two other patches for consideration:

As bcachefs is not upstream yet, I think we should re-visit bcachefs
support after it's in upstream.

OTOH, I have some minor comments go to patch 1.

Thanks,
Eryu

> 
> Kent Overstreet (3):
>   Initial bcachefs support
>   Improved .gitignore
>   Use --yes option to lvcreate
> 
>  .gitignore         |  3 +++
>  common/attr        |  6 ++++++
>  common/config      |  3 +++
>  common/dmlogwrites |  7 +++++++
>  common/quota       |  4 ++--
>  common/rc          | 31 +++++++++++++++++++++++++++++++
>  tests/generic/042  |  3 ++-
>  tests/generic/081  |  2 +-
>  tests/generic/108  |  2 +-
>  tests/generic/425  |  3 +++
>  tests/generic/441  |  2 +-
>  tests/generic/482  | 27 ++++++++++++++++++++-------
>  tests/generic/558  |  2 ++
>  13 files changed, 82 insertions(+), 13 deletions(-)
> 
> -- 
> 2.31.1
