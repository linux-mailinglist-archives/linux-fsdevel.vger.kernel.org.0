Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36E8432DF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhJSGS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233786AbhJSGS2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:18:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACB4E6115B;
        Tue, 19 Oct 2021 06:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634624176;
        bh=FeG/qotMCAtt11mlzDTQUemMTc8grksOYH2YcYkz2NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lg0afarjb/JXs+cYDe2ZtQnrFJR3J8h/C9seWBF8QOrfPEm6YSKILrheQecQ13sp/
         XtQ4Ld/FMCpATfvZLaqjxSeTlpDtgQ8S3F31aewNRcQsifzyG9A+PBe5rqNWMcDdqS
         kp4IF8+D53rd5pQi/7eTWLdwt6Z90NX9npx8yWn8=
Date:   Tue, 19 Oct 2021 08:16:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/14] firmware_loader: add built-in firmware kconfig
 entry
Message-ID: <YW5irpRIIr0H/tXh@kroah.com>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
 <20210917182226.3532898-5-mcgrof@kernel.org>
 <YVxhbhmNd7tahLV7@kroah.com>
 <YWR16e/seTx/wxE+@bombadil.infradead.org>
 <YWR4XKrC2Bkr4qKQ@kroah.com>
 <YWS7ABDdBIpdt/84@bombadil.infradead.org>
 <YW3gae4HoUd9izyj@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW3gae4HoUd9izyj@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 02:00:25PM -0700, Luis Chamberlain wrote:
> On Mon, Oct 11, 2021 at 03:30:24PM -0700, Luis Chamberlain wrote:
> > On Mon, Oct 11, 2021 at 07:46:04PM +0200, Greg KH wrote:
> > > >   o By default we now always skip built-in firmware even if a FW_LOADER=y
> > > 
> > > I do not understand, why would we ever want to skip built-in firmware?
> > 
> > Because it is done this way today only implicitly because
> > EXTRA_FIRMWARE is empty. Using a kconfig entry makes this
> > more obvious.
> 
> Greg,
> 
> The fact that it was not obvious to you we were effectively disabling
> the built-in firmware functionality by default using side kconfig
> symbols is a good reason to clarify this situation with its own kconfig
> symbol.
> 
> And consider what I started below as well.
> 
> Please let me know why on the other hand we should *not* add this new
> kconfig symbol?

Because added complexity for no real good reason?  You need to justify
why we need yet-another firmware kconfig option here.  We should be
working to remove them, not add more, if at all possible.

thanks,

greg k-h
