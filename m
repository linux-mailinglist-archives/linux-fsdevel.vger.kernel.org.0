Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F542B5AB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 09:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKQIHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 03:07:35 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:38321 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725771AbgKQIHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:07:34 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kew1O-001xdB-Lp; Tue, 17 Nov 2020 09:07:26 +0100
Received: from p57bd9382.dip0.t-ipconnect.de ([87.189.147.130] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kew1O-0011QE-Dv; Tue, 17 Nov 2020 09:07:26 +0100
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org
References: <20201101170454.9567-1-rppt@kernel.org>
 <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
 <20201117062316.GB370813@kernel.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <d34f431a-288d-82a9-2632-85e8e695df12@physik.fu-berlin.de>
Date:   Tue, 17 Nov 2020 09:07:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117062316.GB370813@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.147.130
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike!

On 11/17/20 7:23 AM, Mike Rapoport wrote:
> There were minor differences only for m68k between the versions. I've
> verified them on ARAnyM but if you have a real machine a run there would
> be nice.

I do have a real machine (Amiga 68060) but it's currently not set up (but it
will be in the near future). So I'm not sure if I can test the change within
a short time frame.

I will certainly report back when I run into issues on real hardware.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

