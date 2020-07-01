Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF121103C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgGAQIK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 12:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730645AbgGAQIJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:08:09 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F64E207BB;
        Wed,  1 Jul 2020 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593619689;
        bh=rKlFbyXow7krvfPu19nW4SgQi5tpEc/I/oNA9viF45g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRKJBDc8JRl65S0w4WRf8lyH1aW2b2orXnXo13pT7/weuTEVdSHJdxNz7/MDlJFpH
         /17FJwp8e9z2RiTAHYj/QbR4k3McRBUP/L32p6MQaYzw1n8vkQryv99mDhiR244edy
         Pp0Ot3MoLSnZEnyFazgqyUNlrps4mdeltbxhEjFE=
Date:   Wed, 1 Jul 2020 09:08:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     lampahome <pahome.chen@mirlab.org>, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org
Subject: Re: Fwd: Any tools of f2fs to inspect infos?
Message-ID: <20200701160808.GA1704717@google.com>
References: <CAB3eZfsO0ZN_79oaFpooJ32WNZwwyaS4GBb+W6jR=buU-VczAA@mail.gmail.com>
 <20200701091622.GA5411@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701091622.GA5411@xiangao.remote.csb>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/01, Gao Xiang wrote:
> (cc linux-f2fs-devel, Jaegeuk, Chao.
>  It'd be better to ask related people and cc the corresponding list.)
> 
> On Wed, Jul 01, 2020 at 03:29:41PM +0800, lampahome wrote:
> > As title
> > 
> > Any tools of f2fs to inspect like allocated segments, hot/warm/cold
> > ratio, or gc is running?

# cat /sys/kernel/debug/f2fs/status ?

> > 
> > thx
