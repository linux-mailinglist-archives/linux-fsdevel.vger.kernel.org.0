Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3C1B8491
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDYIO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 04:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgDYIO7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:14:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D30C2071C;
        Sat, 25 Apr 2020 08:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587802498;
        bh=M/mbF7EtEsrt+Ekl8CDrUxehtR6wkl9tYW3cNKGfgHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q44T9fiNBYMX0iT5oV7P/Ty1WF9StvtGtMfuGCx5GIJ7WO5SLeGhuTgGaJbHtJ/0t
         F/mdUQKudvKz01efde2WiEcLHvK9E8f2AaHr82zZ2O237nF0/Qtz3m2OCCeGMkPITc
         wM/7G8bNniycF2bs06Ft2R6CoslrkW/HLVY7/X4E=
Date:   Sat, 25 Apr 2020 10:14:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, josh@joshtriplett.org,
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
Subject: Re: [PATCH v2 1/2] firmware_loader: revert removal of the
 fw_fallback_config export
Message-ID: <20200425081455.GA2049758@kroah.com>
References: <20200424184916.22843-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424184916.22843-1-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 06:49:15PM +0000, Luis R. Rodriguez wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Christoph's patch removed two unsused exported symbols, however, one
> symbol is used by the firmware_loader itself.  If CONFIG_FW_LOADER=m so
> the firmware_loader is modular but CONFIG_FW_LOADER_USER_HELPER=y we fail
> the build at mostpost.
> 
> ERROR: modpost: "fw_fallback_config" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> 
> This happens because the variable fw_fallback_config is built into the
> kernel if CONFIG_FW_LOADER_USER_HELPER=y always, so we need to grant
> access to the firmware loader module by exporting it.
> 
> Revert only one hunk from his patch.
> 
> Fixes: 739604734bd8e4ad71 ("firmware_loader: remove unused exports")

Fixes: 739604734bd8 ("firmware_loader: remove unused exports")

No need to be over-eager with the number of digits...

I'll fix this up when I apply it, thanks.

greg k-h
