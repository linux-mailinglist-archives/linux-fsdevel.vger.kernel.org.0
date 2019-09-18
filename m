Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF97B6208
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfIRLFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 07:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfIRLFv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:05:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F02021920;
        Wed, 18 Sep 2019 11:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568804750;
        bh=cfR8cp9RXeCZCrpG8ViPCQUuSx8Z3CiXOPGljSApjEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0YZh2szIeQm27pXuTKLTHYih2e1HECMwYocnHTSG9EoPMofO3/COjdSNlWDhwV1tJ
         m8rytbtGAGoOHCTrH8gziPc9Ms+RY7KfdFmcqxaLBjr0cUv3Kc2eGEFQpgnE+BAzFA
         u2rg867+6ogshkqIuzNJLXQuGaDpWN2vuBZnyWco=
Date:   Wed, 18 Sep 2019 13:05:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ju Hyung Park <qkrwngud825@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        sj1557.seo@samsung.com
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190918110548.GA1894362@kroah.com>
References: <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
 <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
 <20190918061605.GA1832786@kroah.com>
 <20190918063304.GA8354@jagdpanzerIV>
 <20190918082658.GA1861850@kroah.com>
 <CAD14+f24gujg3S41ARYn3CvfCq9_v+M2kot=RR3u7sNsBGte0Q@mail.gmail.com>
 <20190918092405.GC2959@kadam>
 <CAD14+f1yQWoZH4onJwbt1kezxyoHW147HA-1p+U0dVo3r=mqBw@mail.gmail.com>
 <20190918100803.GD2959@kadam>
 <CAD14+f1yT2_d8RP2a2NqAVYAkmB4ti6KjSsV2sM8SVCOQ_M=RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD14+f1yT2_d8RP2a2NqAVYAkmB4ti6KjSsV2sM8SVCOQ_M=RQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 07:46:25PM +0900, Ju Hyung Park wrote:
> On Wed, Sep 18, 2019 at 7:09 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > Use Kconfig.
> 
> Not just that.
> There are a lot of non-static functions that's not marked ex/sdfat-specific.
> (which we would have to clean it up eventually)

Then clean them up :)

> Even with sdFAT base, there are some non-static functions named as exfat.

Then just force both filesystems to only be built as a module and all
should be fine, right?

> Figuring out a solution for this is pretty pointless imho when one of
> the drivers will be dropped soon(ish) anyways.

Given we only have one filesytem that is submitted in patch form, I
think people are making a lot of noise over nothing :)

thanks,

greg k-h
