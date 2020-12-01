Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BD32CACD5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 20:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392307AbgLAT4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 14:56:31 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:39955 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388704AbgLAT42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:56:28 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kkBkR-003edd-JW; Tue, 01 Dec 2020 20:55:39 +0100
Received: from p57bd9091.dip0.t-ipconnect.de ([87.189.144.145] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kkBkQ-001scM-TR; Tue, 01 Dec 2020 20:55:39 +0100
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>
References: <20201101170454.9567-1-rppt@kernel.org>
 <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
 <20201117062316.GB370813@kernel.org>
 <a7d01146-77f9-d363-af99-af3aee3789b4@physik.fu-berlin.de>
 <20201201102901.GF557259@kernel.org>
 <e3d5d791-8e4f-afcc-944c-24f66f329bd7@physik.fu-berlin.de>
 <20201201121033.GG557259@kernel.org>
 <49a2022c-f106-55ec-9390-41307a056517@physik.fu-berlin.de>
 <20201201135623.GA751215@kernel.org>
 <4c752ff0-27a6-b9d7-ab81-8aac1a3b7b65@physik.fu-berlin.de>
Message-ID: <ea5bae0e-9f27-355f-d841-cf8b362b0b70@physik.fu-berlin.de>
Date:   Tue, 1 Dec 2020 20:55:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <4c752ff0-27a6-b9d7-ab81-8aac1a3b7b65@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.144.145
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike!

On 12/1/20 4:07 PM, John Paul Adrian Glaubitz wrote:
> This fixes the issue for me.
> 
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

I just booted the kernel from the linux-mm branch and I can't get the hpsa driver
to work anymore. Even if I compile it into the kernel, the driver is no longer
loaded and hence I can't access the disks.

Any idea what could be wrong?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

