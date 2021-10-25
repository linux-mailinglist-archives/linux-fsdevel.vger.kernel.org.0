Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA355439AD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhJYPxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhJYPx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:53:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010CAC061745;
        Mon, 25 Oct 2021 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sD4M77sMZipbi4n7OfMHOpvymBF2RK3PbnXf7BuorEc=; b=D/mocSywZnf9DStUX7jAO45bDE
        jXrbxJA9a+bFmDHYuO12zo2sZzZKenpvaiEMWVzuTvIY0Rm57D1ERraYjLWtrOT2hWnRVKXN6y1EY
        6SLUmOlCksFsDoErVjp3PEQ3TsJMkMgixCSTFferPs8k7vP3DT7dovCpirZpBYkB05U39AAMdTshZ
        sgmgOr0MctOsL62vIk5oE0OyePZ2tSTJ9YdiLqu8Fy5HRgNHuWwF8HxpngFeg0qm1QDoGs5kHa9qM
        9qqmRtmnUDeHr5O6AUEgrHc85e3EMfJf+j0q7xYxo6A7pcPNp0mVaT2X13rNso1vZr7CX8jt7atLO
        uMa3toqA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf2FR-00GvIH-8r; Mon, 25 Oct 2021 15:50:53 +0000
Date:   Mon, 25 Oct 2021 08:50:53 -0700
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
        andresx7@gmail.com, brendanhiggins@google.com, yzaikin@google.com,
        sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] firmware_loader: rename EXTRA_FIRMWARE and
 EXTRA_FIRMWARE_DIR
Message-ID: <YXbSXSGO3uK7W3IO@bombadil.infradead.org>
References: <20211022174041.2776969-1-mcgrof@kernel.org>
 <20211022174041.2776969-2-mcgrof@kernel.org>
 <YXOvGX1O69s0Qaoe@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXOvGX1O69s0Qaoe@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 23, 2021 at 08:43:37AM +0200, Greg KH wrote:
> On Fri, Oct 22, 2021 at 10:40:38AM -0700, Luis Chamberlain wrote:
> > Now that we've tied loose ends on the built-in firmware API,
> > rename the kconfig symbols for it to reflect more that they are
> > associated to the firmware_loader and to make it easier to
> > understand what they are for.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> This patch has the same bug I pointed out the last time I reviewed it :(

Sorry I missed it, but I checked and I can't see where, can you point
that out in the patch?

  Luis
