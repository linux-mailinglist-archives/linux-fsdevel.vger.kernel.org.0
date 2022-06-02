Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED95953B375
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 08:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiFBGU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 02:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiFBGUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:20:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FE280B2F;
        Wed,  1 Jun 2022 23:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D54FB81EC0;
        Thu,  2 Jun 2022 06:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700BEC385A5;
        Thu,  2 Jun 2022 06:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654150821;
        bh=Gn0mmCHssjpDmMOxhtbBTwvuYite/0yMZNqpBs7V2nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAWmwIszHR/E98n1VFJCtqm9AVMJpD5/gp2CyX4Vv5NixDiD++yaQLzJte1lSGNKp
         xuWU6DvmIBmp48RMTO0iZI4wV+Q7MMLEOulO9Jc6txAMg8LocxRjnvBdfi4XDAxWBA
         Um1envM6ziHjyF3c1yHIpv9bv/zIIyurqyzjyWX8=
Date:   Thu, 2 Jun 2022 08:20:18 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Richard Fontana <fontana@sharpeleven.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "joe@perches.com" <joe@perches.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        "copyleft-next@lists.fedorahosted.org" 
        <copyleft-next@lists.fedorahosted.org>,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Message-ID: <YphWomPaMdLCa3Pt@kroah.com>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org>
 <87bkvo0wjd.ffs@tglx>
 <Yo5cxWghV/v2Fnzf@bombadil.infradead.org>
 <BN7PR13MB24998CAFCFB973C80549F308FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <Yo5xTwGLmbsgJhfM@bombadil.infradead.org>
 <BN7PR13MB2499BA2AFAC1C79197734D81FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <871qwhz2aa.ffs@tglx>
 <BYAPR13MB2503DAC31B8B5CC69F8FECD3FDDE9@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2503DAC31B8B5CC69F8FECD3FDDE9@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 02, 2022 at 04:11:16AM +0000, Bird, Tim wrote:
> > -----Original Message-----
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Tim!
> > 
> > On Wed, May 25 2022 at 19:05, Bird, Tim wrote:
> > >> From: Luis Chamberlain <mcgrof@infradead.org> On Behalf Of Luis Chamberlain
> > >> I agree that we want to keep the number of licenses as small as
> > >> possible but we cannot really dictate which dual licensing options a
> > >> submitter selects unless the license is GPL-2.0-only incompatible,
> > >> which copyleft-next is not.
> > >
> > > Um, yes we can dictate that.
> > 
> > No!
> Sorry for the delayed response.  I was on vacation over memorial day weekend
> (holiday in the US.)
> 
> I think that the option to reject a contribution based on its license should be
> available to the community, using criteria beyond those that Luis has mentioned
> (and that you mention below).
> 
> I could create a license that was GPL-2.0-only compatible, and use it to cover a new
> contribution to the Linux kernel (in dual-license format), in order to get exposure
> for the license or to promote it.  We could use the SPDX identifier "Tims-license-0.1".
> I think it would be fair for the community to reject a contribution based
> on those license circumstances, even though it met all the criteria you mention.
> 
> I don't think that the Linux kernel should be used for license promotion, but if it is,
> then it should be used to promote GPL-v2-only.

I agree, and in a way, I feel like that is what is happening here for
this original submission.  See below for more...

> > > There were good reasons that the original BSD dual-licenses were
> > > allowed.  Those same reasons don't apply here.
> > 
> > That's just wrong. The reason why dual licensing is allowed is to share
> > code across licesce preferences. The very same reason applies here.
> 
> I was talking about why dual licensing was originally introduced, which was
> a situation different from what went on in 2016, when the copyleft-next
> dual license was discussed.
> 
> Dual-licensing in the Linux kernel was originally introduced because code was being
> taken from BSD and placed into Linux (under GPL v2), often by someone other than the
> original author.  This created a bit of hard feelings between the BSD community
> and the Linux community.  So dual-licensing was introduced so that derivative works
> (created by Linux developers) of BSD code could flow back into the BSD project.
> 
> This was code that existed before being introduced into Linux, and there was
> no notion of using the kernel to promote the BSD license.

I agree, dual licensed code that is added to the kernel is either done:
	- because the original code had a non-GPL license and it was
	  added so that it could be compatible so that it could be added
	  to Linux.
	- because the code being accepted into Linux can also be used in
	  another non-Linux codebase now or in the future.

The submission here was neither of these.

It was to test core Linux kernel functionality that is ONLY GPL-v2.
That functionality and interactions within the Linux core could never be
used in any non-Linux project as it does not make any sense.  Or if it
could be used in a non-Linux project, that would only be if that project
was also GPLv2 licensed as the kernel core code would have been copied
out of Linux into that other project.

I feel that the dual-license of this code is purely done to support an
additional license and give it attention as it could never be invoked on
this codebase due to the contents of it.  Which makes it not necessary
and has only distracted us from the real technical issues of why I
rejected this code in the first place :(

thanks,

greg k-h
