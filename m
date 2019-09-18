Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D861B5F47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 10:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfIRIdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 04:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfIRIdX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:33:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0600621907;
        Wed, 18 Sep 2019 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568795602;
        bh=NqU0W2Yzv3UbIZ/LoZ5afKn1xMHhi3IOmFcr8fQlT/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Bi1ciZS8CADVRReo5sJsAAq3cfNvE7TBoaPAUcDiz5vLuo5ufwdRY30aDUrPbKGB
         UKIetcpxGcOJ1IfpmBLOb8J5VqnbOSjPRkKFpfuB6e9Fh6OGgL1uE6aeeSwmhd1g2B
         k4IScLKYJHA5uV8wlAwGZfsHGokNYE/Y2pNxwcgY=
Date:   Wed, 18 Sep 2019 10:26:58 +0200
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        'Ju Hyung Park' <qkrwngud825@gmail.com>,
        'Valdis Kletnieks' <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        sj1557.seo@samsung.com
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190918082658.GA1861850@kroah.com>
References: <8998.1568693976@turing-police>
 <20190917053134.27926-1-qkrwngud825@gmail.com>
 <20190917054726.GA2058532@kroah.com>
 <CGME20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a@epcas2p4.samsung.com>
 <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
 <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
 <20190918061605.GA1832786@kroah.com>
 <20190918063304.GA8354@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918063304.GA8354@jagdpanzerIV>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 03:33:04PM +0900, Sergey Senozhatsky wrote:
> On (09/18/19 08:16), 'Greg KH' wrote:
> [..]
> > > Note, that Samsung is still improving sdfat driver. For instance,
> > > what will be realeased soon is sdfat v2.3.0, which will include support
> > > for "UtcOffset" of "File Directory Entry", in order to satisfy
> > > exFAT specification 7.4.
> >
> [..]
> > If Samsung wishes to use their sdfat codebase as the "seed" to work from
> > for this, please submit a patch adding the latest version to the kernel
> > tree and we can compare and work from there.
> 
> Isn't it what Ju Hyung did? He took sdfat codebase (the most recent
> among publicly available) as the seed, cleaned it up a bit and submitted
> as a patch.

He did?  I do not see a patch anywhere, what is the message-id of it?

> Well, technically, Valdis did the same, it's just he forked a slightly
> more outdated (and not anymore used by Samsung) codebase.

He took the "best known at the time" codebase, as we had nothing else to
work with.

thanks,

greg k-h
