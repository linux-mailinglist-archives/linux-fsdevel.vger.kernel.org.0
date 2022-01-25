Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1ED49B5CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 15:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578113AbiAYOOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 09:14:23 -0500
Received: from iota.tcarey.uk ([138.68.159.189]:41324 "EHLO iota.tcarey.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385990AbiAYOLT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:11:19 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 09:11:16 EST
Received: from kappa (unknown [IPv6:2a02:c7e:82c:6a00:a723:ff23:8e33:a24d])
        by iota.tcarey.uk (Postfix) with ESMTPSA id 5786A24F8E;
        Tue, 25 Jan 2022 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tcarey.uk; s=iota;
        t=1643119398; bh=d3dqljjzMtihzfzHZx940rE3jMAaU35i9VLf6eor8n0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAWD9LwLe/ApzSEPkI0CufjOilLwawjW3Vnr7iQXuJynwLRX2FhUS+sH3vKJuItw4
         O1nklv2LwO7GMywHLWq0Wv+qmk08yPACEGZ1/Fm3poQTq2Zv+V3EqRtXMAu1Xdt9Zq
         hkQj8MtacnzAwo6yysRKMMTbBis2zAPK52D7r0DhAYedmHs1WsrDZCBMD14A+ozNUx
         pFfbuP7/uo0TQwCLHgwxBbxDBfdfM9OVglKwrl5GtR/1jEi4ghLYR74y0ptU5QSOn/
         em/J2s6t0sVC207G4yzon36BKao5J++HAHHg7OpPN0K7X+VK4aMFPe73eEYKSyqGum
         wRbHne54TMf7Q==
Date:   Tue, 25 Jan 2022 14:03:16 +0000
From:   Torin Carey <torin@tcarey.uk>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        keescook@chromium.org, adobriyan@gmail.com,
        jamorris@linux.microsoft.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use kmalloc instead of __get_free_page() to alloc
 path buffer
Message-ID: <YfADJHY7Fy8S9Tl4@kappa>
References: <20220123100837.GA1491@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123100837.GA1491@haolee.io>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:08:37AM +0000, Hao Lee wrote:
> It's not a standard approach that use __get_free_page() to alloc path
> buffer directly. We'd better use kmalloc and PATH_MAX.

If we're allocating PATH_MAX sized buffers for names, wouldn't it be
suitable to use the name slab names_cachep declared in
include/linux/fs.h using __getname() and __putname()?

Best,
Torin
