Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB5433B43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhJSPzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJSPzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:55:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1709AC06161C;
        Tue, 19 Oct 2021 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L/r8W7OeCFbqHVWl3EceBKDkVDU//3rCuUA5Z221DbI=; b=ufmSm0fgCXPpRU3kuJL6vdob+c
        dOnKyAFlfO2R4WNkEkGoEI7LEqthAZgCjqmFPCVpSgu7sZ0uhYyKKU7zAMKZjgHo2IcsDvF6+RsIK
        NKH0zZnEXHfm3rhGzDPvPJ5WlkOsXZmL8r3nSuIJbUjHv4FFIQgu+GsTqi9hDC8euY8KuVBv4af+3
        YA1IjRVCsppJzdoU/+EmIPHhKB+daoMvsOw1r70oh1c1MybrTGUONYdxjYwqB8mMc12zBHLIPtx9Z
        VWvTZafpQrwauVGjebkmX2QrOitVSWVoJbbd63MBMDklA/MX+AvyAqKX+ebIkw7RZZkPU9Rjg0Per
        UN1xQFow==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcrPu-001lY4-22; Tue, 19 Oct 2021 15:52:42 +0000
Date:   Tue, 19 Oct 2021 08:52:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <YW7pynWzRHE+MpTC@bombadil.infradead.org>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
 <20210917182226.3532898-5-mcgrof@kernel.org>
 <YVxhbhmNd7tahLV7@kroah.com>
 <YWR16e/seTx/wxE+@bombadil.infradead.org>
 <YWR4XKrC2Bkr4qKQ@kroah.com>
 <YWS7ABDdBIpdt/84@bombadil.infradead.org>
 <YW3gae4HoUd9izyj@bombadil.infradead.org>
 <YW5irpRIIr0H/tXh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW5irpRIIr0H/tXh@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 08:16:14AM +0200, Greg KH wrote:
> On Mon, Oct 18, 2021 at 02:00:25PM -0700, Luis Chamberlain wrote:
> > On Mon, Oct 11, 2021 at 03:30:24PM -0700, Luis Chamberlain wrote:
> > > On Mon, Oct 11, 2021 at 07:46:04PM +0200, Greg KH wrote:
> > > > >   o By default we now always skip built-in firmware even if a FW_LOADER=y
> > > > 
> > > > I do not understand, why would we ever want to skip built-in firmware?
> > > 
> > > Because it is done this way today only implicitly because
> > > EXTRA_FIRMWARE is empty. Using a kconfig entry makes this
> > > more obvious.
> > 
> > Greg,
> > 
> > The fact that it was not obvious to you we were effectively disabling
> > the built-in firmware functionality by default using side kconfig
> > symbols is a good reason to clarify this situation with its own kconfig
> > symbol.
> > 
> > And consider what I started below as well.
> > 
> > Please let me know why on the other hand we should *not* add this new
> > kconfig symbol?
> 
> Because added complexity for no real good reason?  You need to justify
> why we need yet-another firmware kconfig option here.  We should be
> working to remove them, not add more, if at all possible.

I did, it actually simplifies things more and makes the fact that we
disable the functionality of the built-in firmware by default clearer.

So no, this is not adding complexity.

 Luis
