Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB3B43820E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 08:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhJWGqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 02:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhJWGp7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 02:45:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 184206108B;
        Sat, 23 Oct 2021 06:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634971421;
        bh=gHoao8gzTpde/kTuKW+WnuidInzBHlhdtiTqnneEWSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+61LErIRpavg+8PyPK1q1zjGE+LJkvkYUxw1hgheKU5U6zkGukw59g88Olt0TCzZ
         dqDsutPMNVv9Xwp0RI/hBI8+gtSSRYl+8agw0XZta/oIKeXQsB7uzXl9hSwU6L36VG
         Dk+oNUCiYsEUKC1tZc6tkn2MvlpUvQFZ+jXB7Vpo=
Date:   Sat, 23 Oct 2021 08:43:37 +0200
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
Message-ID: <YXOvGX1O69s0Qaoe@kroah.com>
References: <20211022174041.2776969-1-mcgrof@kernel.org>
 <20211022174041.2776969-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022174041.2776969-2-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:40:38AM -0700, Luis Chamberlain wrote:
> Now that we've tied loose ends on the built-in firmware API,
> rename the kconfig symbols for it to reflect more that they are
> associated to the firmware_loader and to make it easier to
> understand what they are for.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

This patch has the same bug I pointed out the last time I reviewed it :(
