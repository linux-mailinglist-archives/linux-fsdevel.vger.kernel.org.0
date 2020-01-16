Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7455513F8CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437044AbgAPTVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 14:21:08 -0500
Received: from mout.web.de ([212.227.17.11]:48103 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbgAPTVH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1579202451;
        bh=QW5hSC3fJXqK3Kd8XDbBzP6sr3B0des9/YeSiqHXMX4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qWDj0fuP2NMPIX3PEXxha7knY+obGETIa3wOa6Y18pVB9UPvP6ubZWEoHDIw8HNeh
         ot6OWrxGhlT82Q99qlGqvwWclYrIGaUwjSOaTSRnHZGJDQ30JGF68UTEbn2ZnIBirU
         52XWijFsleSxSOUS1JIKKSppFtuGmrv0bHvLcEfE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.6.163]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPYNR-1iwpOM1QB7-004kD5; Thu, 16
 Jan 2020 20:20:51 +0100
Subject: Re: [v10 00/14] add the latest exfat driver
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <c4fdc6af-04c2-81a5-891d-5a3db4778caa@web.de>
 <20200116102041.i52l3eoas7xrhlxv@pali>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <60a5e7d9-8fda-3a44-857f-20cd3a31873e@web.de>
Date:   Thu, 16 Jan 2020 20:20:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116102041.i52l3eoas7xrhlxv@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aAnCrSvmvb4GLOiZxgNA6+I7OmfseAdx3E3i11AWAjTIFkmwZp1
 UgSAD/WBuhPxQPg6IiWAPvKViEU/eihN4uSpHxgqBLVmKL1vP+N4b7ckFEYqsVxTKY2GnpM
 VrvR80rAZg6K0R6CbeUxS9aYIOuRddik9grwEoips66rbxj+7fobQd2PwVLIBkT7Mx/mHj7
 iwmNamCYugf2U77ZlBpDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OEvvgJJHVkc=:egiIhncP/dACesPTfU3dfj
 mFcEtIfIJ/zWN2uIdlHosepawJxygypkFn+nu52rSsPrxY2TB81opDHzBbf28ztHIzbjl+nmx
 2+w6DegTHBYjM3YMuL2Ko6cf/cddhtIlCFlEUD7HXKDwRuX2By9PJ0hxRWIdZjFp6vS9vthK1
 T5+XDGtm7mQ2TywRtuxwhPxsGNrKU8iCW6OzZPMBkKzUhLl/VE0F6vYgfbXH06hCskeVLoVOF
 roL7/WNsVz9qywxwD4Thhra0C4jkP61vMKE1oQ0AhzUDfifc+h8RQK9PZBNlR/ydl8I7HQqzT
 rNKjKXNVzqJr496ugWV5jpYhkUkvFxGMM5jutifOm88+GTjdeFbWa22HIqbwhjmUHCTpYwVHk
 cNN1Qpi9ZKDKuZ8zfDYTNp/Gf8hseic4hHVLMpw6MuF0CkmnwHJV43YCEz2f95fbyaeTrfUmK
 OZyZpBlmhFrNve/VfswCw3oqioJdNZG7Lzgwv8ZGRiVfYogNe08r16olQ+CgKNmotNKZxIMXv
 hLlhlu6BUV3h4ADBNIKM2By1tOMaD0J4V6Xnq2AhWwriGDTdmYZ9XHE9PbB1zUTw0b0940Wtf
 9QpxUSs8kEKCHsQwDVQEmt2aBO4cnYelWba2PfHdVbglqJIyzSUrIUb1LqqVugjBeo03vfvTw
 xDiM4wJ9l+9OxKl8z5g3ydGs9Ed4mp5kmDwJLv6yncyBDgL4rpptJVFHIPXi2tGtZYZkfMvXk
 z5n/ioHpLEZ+sDjRc9I+hhVz90a5vqyYGPJC6mmmcs6eTh7WCJ01MGUEsvuMOGap3neqRu6IY
 N6AUTPHoHRk784Bo+CDSAkJUUNWAiFdC6+KxWVZFeaioXIh8mJevUH8xx5rILZ7UWH8o4eZMb
 7Hmpxrm/lpWh85LFn886lhGK/Z6QrYXGjTKTCyROhYR45B1Qb/yLoEb+Pkq3JZuM0q0GlBx59
 6bj7eXXHJ1cv03S/8fmx2Hq3BzmaEWKfmBTIOmXVpWGIk1y5PAtAZ6K+Mfn5zui8wBxBB+hHf
 od9mRL0LdKzvNJo/gteY3NsQoVsJs32zcnU02wVIobC95bryfWrn20GlCmTLynvjtV9c5ptbS
 f+2NvBvuX0Xta+kYia/V7a+pqaNqdpYN8EZaagSpndrkwBmnZaP5RclKERjMX4T9X7ikzZ+1Q
 xCHu87Ip71mW8k2TZiM8ZRIRLhaV7N2AhPXBUKF9/M5QHq1vlNpdeMSqjc7ZQc1IkJB0c6alL
 Ij2KjoqsB761O21cXb7StCEOodA9yBroQ0A/GmLGyIV6+zkN7RWd16W69DZo=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>> Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>>>
>>> Next steps for future:
>>
>> How does this tag fit to known open issues?
>
> Is there any list of known open issues?

I got the impression that your recent feedback contained a small one.


> Or what do you mean by known open issues?

I guess that some contributors would like to achieve further improvements
for this software module.

Regards,
Markus
