Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58A9453D12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 01:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhKQASo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 19:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhKQASn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:18:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FBCC061570;
        Tue, 16 Nov 2021 16:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xHzGWTvPEQ1U+gOdlDriApocLa4EZbPbJGHwXbh4KkA=; b=ZN92UcGhwrf0KUiyCgqy9+rzlt
        +WWiE6W7asIJlrVIj9gTMljknHMbpZiMXRw5qGkQ7p4IrNRDdpe+WAEXCPoAgyhgWMd2kctagW9AO
        qZdEDRQnSkAMfUXESSB0LQ9kHV8hYDW2nr8h/RA8uWt4gwnZG1rPmfz/W0NC+JDXsz7bn2kareEiQ
        QmFHd7UZZkiCPwJWjVRcpVIhp/9xmFoeABBG6CzWnRCIOc3eoeL9+Jm0KhD6mcUDvktMW9Yu3xQXd
        XhET3UM0vZ+eFtydGzhvi5iEvPWPPSQ1epwkB3lGsAo8NIqMozdNpN7QIUnAkzW9J7GT3B41bVCDx
        JVbgRA7Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mn8bt-003170-F2; Wed, 17 Nov 2021 00:15:33 +0000
Date:   Tue, 16 Nov 2021 16:15:33 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
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
Message-ID: <YZRJpcZ4LgBzhge0@bombadil.infradead.org>
References: <20211025195031.4169165-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025195031.4169165-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:50:27PM -0700, Luis Chamberlain wrote:
> The only change on this v4 is to fix a kconfig dependency
> (EXTRA_FIRMWARE != "") which I missed to address on the v3 series.

Hey Greg, now that the merge window is closed let me know if you'd like
a resend of this or if you can take it as-is.

  Luis
