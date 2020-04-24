Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E380A1B6B2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 04:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDXCOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 22:14:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45445 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgDXCOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:14:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id s18so1212555pgl.12;
        Thu, 23 Apr 2020 19:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M1F8V/lQi2dXJLzkHN7r8+PIAY8isTqYFnnwe0dwlNw=;
        b=kIOurenDXq+n0uVpWe1b6wJGWRaUCOrTEERcilNdBx0aUjhxzOik2Oj2fwUrZG7Frn
         Nclx1eUMY6Z06rmqZqd0QasO5Uqoywp7f2ePhCUEe0JxyHZToNYIpBbMka+koGett9M/
         oP4e9I4At9dP8UBjjcD0jnL656kQI9mj4Hx4z4fhzB+hQrjn/F6K2nTH3LUCo2NZmJQZ
         hrlniBnt7RpSX5NDAOqxlzbT30/lycifs04SckNEoqqpbzf+VETuW4o1MyW+yc/rUUR+
         weDpT5D27Lo2gpm2ogb02NtrkKNOq+BgmOwsvNpokAE17WMNr1RoyuIoKN4kgJT745Xm
         F9ow==
X-Gm-Message-State: AGi0PuZwCLuN8qaH1jfG3n3eAEFmfbEo51/Qr/stf4v26YBDKY8sRodC
        L/enh4hXBVTCCTicz+10hUQ=
X-Google-Smtp-Source: APiQypLCHWYVgjIyNhq18B8HX2SVUoSxZIeHK3EVSBOMwo6jLrgIE7YBN7by02GrbM3k16FZMxMzrg==
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr7070390pfs.104.1587694463022;
        Thu, 23 Apr 2020 19:14:23 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h12sm3983291pfq.176.2020.04.23.19.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 19:14:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D5BDE402A1; Fri, 24 Apr 2020 02:14:20 +0000 (UTC)
Date:   Fri, 24 Apr 2020 02:14:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jakub Kicinski <kubakici@wp.pl>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        josh@joshtriplett.org, rishabhb@codeaurora.org, maco@android.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linux-wireless@vger.kernel.org,
        keescook@chromium.org, shuah@kernel.org, mfuzzey@parkeon.com,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com,
        pali.rohar@gmail.com, tiwai@suse.de, arend.vanspriel@broadcom.com,
        zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] firmware_loader: re-export fw_fallback_config into
 firmware_loader's own namespace
Message-ID: <20200424021420.GZ11244@42.do-not-panic.com>
References: <20200423203140.19510-1-mcgrof@kernel.org>
 <20200423180544.60d12af0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423180544.60d12af0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 06:05:44PM -0700, Jakub Kicinski wrote:
> On Thu, 23 Apr 2020 20:31:40 +0000 Luis R. Rodriguez wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Christoph's recent patch "firmware_loader: remove unused exports", which
> > is not merged upstream yet, removed two exported symbols. One is fine to
> > remove since only built-in code uses it but the other is incorrect.
> > 
> > If CONFIG_FW_LOADER=m so the firmware_loader is modular but
> > CONFIG_FW_LOADER_USER_HELPER=y we fail at mostpost with:
> > 
> > ERROR: modpost: "fw_fallback_config" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> > 
> > This happens because the variable fw_fallback_config is built into the
> > kernel if CONFIG_FW_LOADER_USER_HELPER=y always, so we need to grant
> > access to the firmware loader module by exporting it.
> > 
> > Instead of just exporting it as we used to, take advantage of the new
> > kernel symbol namespacing functionality, and export the symbol only to
> > the firmware loader private namespace. This would prevent misuses from
> > other drivers and makes it clear the goal is to keep this private to
> > the firmware loader alone.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Fixes: "firmware_loader: remove unused exports"
> 
> Can't help but notice this strange form of the Fixes tag, is it
> intentional?

Yeah, no there is no commit for the patch as the commit is ephemeral in
a development tree not yet upstream, ie, not on Linus' tree yet. Using a
commit here then makes no sense unless one wants to use a reference
development tree in this case, as development trees are expected to
rebase to move closer towards Linus' tree. When a tree rebases, the
commit IDs change, and this is why the commit is ephemeral unless
one uses a base tree / branch / tag.

  Luis
