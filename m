Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C877045F142
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 17:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354276AbhKZQGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 11:06:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56336 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378278AbhKZQEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:04:42 -0500
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 11:04:42 EST
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7401F622BA;
        Fri, 26 Nov 2021 15:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBDEC93056;
        Fri, 26 Nov 2021 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637942071;
        bh=WOOQ113ctzMnTFkP8ZcZnIHdwNH/Fb3G9USm0u/hRg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GC6v97BD/K/gXkBdZOHGCwLSjuKV4ZaxQHwBRwqkB34IWgVkBxKvzfwB0nebvz6u2
         F7yMi4CWcY8NL6NMOl7Nr8IhBfbLkueBjbZyALnqd1/8FWXANJ4Kc//zBlDf622bRE
         aKvPO13iQjlhN/YvwfgekiPv9FnLMl1oCKbZYb7o=
Date:   Fri, 26 Nov 2021 16:54:29 +0100
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
Subject: Re: [PATCH v4 0/4] firmware_loader: built-in API and make x86 use it
Message-ID: <YaEDNa7Vhse7t41a@kroah.com>
References: <20211025195031.4169165-1-mcgrof@kernel.org>
 <YZRJpcZ4LgBzhge0@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZRJpcZ4LgBzhge0@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 04:15:33PM -0800, Luis Chamberlain wrote:
> On Mon, Oct 25, 2021 at 12:50:27PM -0700, Luis Chamberlain wrote:
> > The only change on this v4 is to fix a kconfig dependency
> > (EXTRA_FIRMWARE != "") which I missed to address on the v3 series.
> 
> Hey Greg, now that the merge window is closed let me know if you'd like
> a resend of this or if you can take it as-is.

All now queued up, thanks.

greg k-h
