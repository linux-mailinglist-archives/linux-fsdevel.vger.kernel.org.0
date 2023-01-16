Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9397D66BAC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 10:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjAPJoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 04:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjAPJnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:43:13 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88C414EA6;
        Mon, 16 Jan 2023 01:42:09 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pHM0C-000SwE-FH; Mon, 16 Jan 2023 10:42:04 +0100
Received: from p57bd9464.dip0.t-ipconnect.de ([87.189.148.100] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pHM0C-000bYk-5G; Mon, 16 Jan 2023 10:42:04 +0100
Message-ID: <8b4ae2b4-f8c5-fc00-ff6b-41d76cdc0e56@physik.fu-berlin.de>
Date:   Mon, 16 Jan 2023 10:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: ia64 removal (was: Re: lockref scalability on x86-64 vs
 cpu_relax)
Content-Language: en-US
To:     sedat.dilek@gmail.com, Matthew Wilcox <willy@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
 <db6937a1-e817-2d7b-0062-9aff012bb3e8@physik.fu-berlin.de>
 <CAMj1kXEtTuaNFiKWn3cJngR0J2vr0G07HR6+5PBodtr1b7vNxg@mail.gmail.com>
 <CA+icZUXEz7ZxmkV5bw5O2ORjF4bwDXBMyj3Wk_HST98gMPt97g@mail.gmail.com>
 <CA+icZUUhY7-F5Bpw-jxofhw4nMP3nzyfpt9huzeSWwUguguNsA@mail.gmail.com>
 <Y8NIYSMqAk7BhSv5@casper.infradead.org>
 <CA+icZUV6usk0KOsK=xQSVp0TQmrsx_ELkc3tWjCBFFnUjAO_Vw@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <CA+icZUV6usk0KOsK=xQSVp0TQmrsx_ELkc3tWjCBFFnUjAO_Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.100
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/15/23 13:04, Sedat Dilek wrote:
> Exactly, Debian Popularity Contest was what I was looking for yesterday.
> 
> Thanks Matthew.
> 
> [1] says in Inst (204701):
> 
> Name                              || Number  || %
> ==================================
> binutils-x86-64-linux-gnu || 101548  || 49.61%
> binutils-ia64-linux-gnu     ||          11  || 0.01%
> 
> HELP: Inst. is the number of people who installed this package (sum of
> the four categories below)
> 
> There may be more popular packages than binutils.
> ( binutils might tell something about development happening or not. )
> 
> Anyway, I am not a popcon expert and never participated in Debian's
> Popularity Contest.

And that's the point, it's opt-in!

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

