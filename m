Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0F6168E15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 10:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgBVJtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 04:49:36 -0500
Received: from mout.web.de ([212.227.15.4]:40259 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgBVJtg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 04:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582364919;
        bh=+OCqJaC9VSi5jYFd0OMBqy/FP0oCti8itkG6PGX9JtY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pLB24Dr93tOsYble4NG7RqXdpZcL/ObDjaBmAY49e6w+yLOxEwNQzlUtjKhz6a//D
         UVbvyihRTz/VlVH6MZ3MfPybKynqULWo6cFwnTYQGjBtaJ+eu9Eb80cEGVhB7oMnTy
         xHdZ1qHfEj245z/Z3lZrfcb9DKdqAq8JkJhLZxXo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.58.94]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LshGz-1jY45v2t0T-012Hx5; Sat, 22
 Feb 2020 10:48:38 +0100
Subject: Re: [for-next][12/26] Documentation: bootconfig: Add a doc for
 extended boot config
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Bird <Tim.Bird@sony.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
References: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
 <20200220221340.2b66fd2051a5da74775c474b@kernel.org>
 <5ed96b7b-7485-1ea0-16e2-d39c14ae266d@web.de>
 <20200221191637.e9eed4268ff607a98200628c@kernel.org>
 <5ade73b0-a3e8-e71a-3685-6485f37ac8b7@web.de>
 <20200222131833.56a5be2d36033dc5a77a9f0b@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <370e675a-598e-71db-8213-f5494b852a71@web.de>
Date:   Sat, 22 Feb 2020 10:48:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200222131833.56a5be2d36033dc5a77a9f0b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mhg9VuD6Ipk/Vdz21w/DGpsBNX3j8BfC/6m6vkf7qbb3JBrSbz9
 LkD3aK3Yo71GwwLS8jzHbbYKF5vTYM14dO8C1W+tkqu5aDKnTjcBqxtihbV25NOPpQvGHV4
 Tdi6qrLXQb45MUl+pQZu6HKkgSB329SCa9z69uYcYJf1F1yerD0fzvnxqavxmpdlV3VElvZ
 rurxGuqV8VhvLTv88vzEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ejzhsp9ICUs=:T/12jmPRl6LsCLfb2uvTht
 RbOaNiEnfPP6IImrFT/aeE+hBMpBl/xtnZ1Xgpr5tybmB5C7g2LVErpRDOxb9W/56U9LAQKpM
 qtCDx8i5sWmuNyU90PlWAi6PNIeLQdPsQ9kaLZLp4fzfwT984/2bFB/k7Yl/kYpDvrVZIPSQS
 4zneR5MuyPfmZrkZ7+7bqhluFASR+1GG2H3QQomSBZPBwJDOQWBSCTdk458ei1CoIlG77qBzd
 9zoa9s4rkAJLV6JcnPKhew4B0IiMkFL+NYdOwvAbJtAE6F0gDTiWRefjoL1ELhqf+BSzpZzap
 wtnS3sMn90hGoDhtl/0V12QtT8wJ42949Qi9oY0uvZg4dkiVG9O+ELIrPQ1NoWzelU1UDckyC
 PQH83s5JGhoi/iWzHKDtYSDxykXbD0/Y+tL765RuUSvMCppfrsBMz0q0/NKHekyQbU+2dQZft
 AsUpq3qhr9AicDmY0Xz2pit8+kafhJq2cyWFvDO+dKmC3kIAI/I6xvYa/Lt+sJK9stHVpInVL
 OamBhcAnNXM5ePXmKQMoKq+R278MFc+yu39mICMoZGnVFME7MaozNYnLMyY8ZdFSM146HJfcK
 o8dVajpVF31j8u2tdl+0HjkQJv3OCQXIoE3mtAQsKxbp/5RMh4VxuRiyu7Kdw2fvUI4C5QZ74
 DElQyPRTaXG3sbIpUlj909KzXMmu3EVlxdQbyXBSkxdND3xgQu9Z4AmhF+04FZ5nbNZ/PKAJf
 qMoxJEEbrinr7fOALBXkxAJkb3ecDQC8xlj1N1ssc51dNm1YAAHDMbhMU6HJQ5eS8zrXOmK1w
 UdAZwYr3kEjSJw/evHOmznfWWC15U9f4LB/wdHMO9mkcpCPi7EdwVaTsrTHR/jZvERqrTlGbW
 CYC5luuqe/NZRmG9vpijaH5aSeuVnnKPhoRpzcTbEN6E9VQ0pqgz6ADOldRIBg31atbiJCFFO
 /Sh4a8tlZZDkIh0CK7Y1mT3dnITvTWwk3eHysy6sDp465WiGgCeDLs6xW22wSdapHnUVdQeDG
 U5PLHBwPkF36HKGlzTL20NPQw2ocGcN4ftUlesX/A92r2oieQ8BG+2ZHTYpaWcN2smjQ85qjV
 F33VYBGYKLVrDYb3ntA81uF+rEUPFXIZex9/JHi6gobrxYZgD5W2GJEsYkdUzQyV7p67rTaEU
 ZYAsS4VLh0LZDpO5y8EboEpRZxjH8nvUkh0dvNUPTFe9ou9ViMX7l72nZBcNSMYgy9FuljXxC
 I2YovZK/o2QB9wsb+
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> * Will a file format description become helpful in the way of
>>   an extended Backus=E2=80=93Naur form?
>
> Good suggestion! Let me try to write an EBNF section.

Is there a need to provide two format descriptions as separate files
(so that they can help more for different software users)?

* RST
* EBNF


Will it matter to adjust another wording?

-/proc/bootconfig is a user-space interface of the boot config.
+The file =E2=80=9C/proc/bootconfig=E2=80=9D is an user-space interface to=
 the configuration
+of system boot parameters.

Regards,
Markus
