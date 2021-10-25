Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D61439E6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 20:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhJYS1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 14:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhJYS1G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:27:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E61A060E0B;
        Mon, 25 Oct 2021 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635186282;
        bh=Rk4jAEvRm4tCYdg8x9ZpLO4Cl5yNhs/uSgts+FPOVWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBQDL1PEDRuIgbJq65UILKgajssXemqThhlTrpaymOISs4FyVKW58yBD04TTC1xAw
         Mgeylrf+uWAupnPo+EWZCYvKynWSoVLa8qbraynt8otYl+1FylZt8ALSIWmZQnew5a
         N81whJm7RzKScyoOYTjfti3XC3O5oYwVhB5tZx4s=
Date:   Mon, 25 Oct 2021 20:24:28 +0200
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
        andresx7@gmail.com, brendanhiggins@google.com, yzaikin@google.com,
        sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] firmware_loader: rename EXTRA_FIRMWARE and
 EXTRA_FIRMWARE_DIR
Message-ID: <YXb2XLiXSNvflVI1@kroah.com>
References: <20211022174041.2776969-1-mcgrof@kernel.org>
 <20211022174041.2776969-2-mcgrof@kernel.org>
 <YXOvGX1O69s0Qaoe@kroah.com>
 <YXbSXSGO3uK7W3IO@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXbSXSGO3uK7W3IO@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:50:53AM -0700, Luis Chamberlain wrote:
> On Sat, Oct 23, 2021 at 08:43:37AM +0200, Greg KH wrote:
> > On Fri, Oct 22, 2021 at 10:40:38AM -0700, Luis Chamberlain wrote:
> > > Now that we've tied loose ends on the built-in firmware API,
> > > rename the kconfig symbols for it to reflect more that they are
> > > associated to the firmware_loader and to make it easier to
> > > understand what they are for.
> > > 
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > This patch has the same bug I pointed out the last time I reviewed it :(
> 
> Sorry I missed it, but I checked and I can't see where, can you point
> that out in the patch?

https://lore.kernel.org/r/YXKsNNONY/TlsK8a@kroah.com

