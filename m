Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA472DDE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfE2NQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 09:16:44 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49189 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE2NQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 09:16:44 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45DWSn5ZnMz1rcqw;
        Wed, 29 May 2019 15:16:40 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45DWSm40vbz1qqkj;
        Wed, 29 May 2019 15:16:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Aho-CC1PN1WD; Wed, 29 May 2019 15:16:39 +0200 (CEST)
X-Auth-Info: heIz6POa976JqLUuwvE+2N83H3Q60nk8KinsJitNukiRlmGYQB/lJSXTXqr9r+Ce
Received: from hawking (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 29 May 2019 15:16:39 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
References: <20190524201817.16509-1-jannh@google.com>
        <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
        <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
        <6956cfe5-90d4-aad4-48e3-66b0ece91fed@linux-m68k.org>
        <7cac8be1-1667-6b6e-d2b8-d6ec5dc6da09@physik.fu-berlin.de>
X-Yow:  FOOLED you!  Absorb EGO SHATTERING impulse rays, polyester poltroon!!
Date:   Wed, 29 May 2019 15:16:38 +0200
In-Reply-To: <7cac8be1-1667-6b6e-d2b8-d6ec5dc6da09@physik.fu-berlin.de> (John
        Paul Adrian Glaubitz's message of "Wed, 29 May 2019 14:32:04 +0200")
Message-ID: <mvma7f5bdu1.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mai 29 2019, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> On 5/28/19 12:56 PM, Greg Ungerer wrote:
>>> Maybe... but I didn't want to rip it out without having one of the
>>> maintainers confirm that this really isn't likely to be used anymore.
>> 
>> I have not used shared libraries on m68k non-mmu setups for
>> a very long time. At least 10 years I would think.
> We use shared libraries in Debian on m68k and Andreas Schwab uses them
> on openSUSE/m68k.

Nope, I don't use non-mmu.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
