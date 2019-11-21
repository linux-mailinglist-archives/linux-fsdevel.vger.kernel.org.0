Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F15104E8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 09:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKUI5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 03:57:40 -0500
Received: from mout.web.de ([212.227.15.14]:45053 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfKUI5k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574326562;
        bh=649bNPQUd2HELGXn+AIHga+NRhYE3k2ynq96C6itO7Y=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bqI9VoDCEA2KgibwK7yHMB1vHAyybuk8sF7fbYuR7tmuiJsQ05JZPWQSGLvicuc3w
         AXW2MXLO4p8gO0h1v1rzmcgSDdNi9F5cUkGOjAaIiZ9qpPXjxkME8t5yW0XYVu08Fk
         kZwcqMr9Q03fkhxPz+V7UuYWZWWJLo90wJvN49ZI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.172.213]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQ8vL-1iT1Qg3mUd-005KM3; Thu, 21
 Nov 2019 09:56:02 +0100
Subject: Re: [PATCH v4 00/13] add the latest exfat driver
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <CGME20191121052913epcas1p1b28d2727dca5df42a6f2b8eb6b6dbcbb@epcas1p1.samsung.com>
 <20191121052618.31117-1-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dcbf6d35-b550-53bc-0c8a-2e54497173e2@web.de>
Date:   Thu, 21 Nov 2019 09:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121052618.31117-1-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3BjI0+iOq89U5n3SkmqNOAaf86FUTrjXBtfV9lgSFLkDymAZ4vo
 xaSJGg8nVnPaAnD4tGnoeopYMeb/7LgEYj8s9/15zP1Xx2P7K5lmqKbHMLERfNe+FWeKpZi
 Kc+N4SUN/2TwGQGnV2LWnjX1/FMQp63x8to9wpB7/e4QyEejw3D4NXuwEWlEQz2LJWR1dno
 eQJ120vharO21VMAglrDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mWPHXbAlWhQ=:2Jswr3DWk1C7Wd1iO2wwSr
 05YVSYaLXf6kExXzJEPo7JtAUaJb5kSIZ2yGbYA0aCd7+Cooel8SW43oX+OXDJ/cacp1ZN4Lw
 PZ3mrRhqAPh3V/f5kP5PKAMHs/Rdbyrqz6sSLP/ZzdZOORsFpfvs0bkMfXz/1EFbsXPAVX2En
 TVJun44FieaQVsJVhew4OP3NGUT6hyO8z2t5A3CgoHORd1uLo6xq7hXP7r8W+Q6Lrwf1f0XNu
 R0sLW3ASNjdnt5xkbyBzjaJaProaOVNqJburgNuNY9QllDrofqa7md5nDE3CYB/x8/UYswq5V
 IlGb8Uu8F8K91fCyhAFAvPOHW3cyIWFdz8hWoKX3UTnDsUPfYje1lKttxOSqQzhzct144gqGF
 AmtKBY45QlGaqCEMLCM7tAl7ZBE6L5Lp/4/d03Aakbf8VYMSO5xZQ5MMMPDSdXb66/rPNCrR+
 ppKBSEzAGxCp4UArfhYGBFSq+iHZeRIlRVBN41yAHPMUk/zHkQUbrBkoZsN4LhlXtIzlsrpbs
 WnLHcDOvZH31K4jUym1lmGRo6UML2pLrx8kjgsEgKr6So0VCmaL8dIZfP2HENzm5Ap2RNOQ+y
 bJSIaVrWoSAm+SoBPwNXYoRqn75vhT16H/S94rSCJMY8igAzS8ZnUxMdIn2wCAqrAaiyySqCG
 iizIKqfmE/NJ0U0qgn+T4O1ElIlZbSHPM5BueYBKLI9g1NjSlPktPzkecgAYl0tj2ag72Eiqn
 Fgro04v87/1s9Cw2lohA8FjB4ax7hO+NRR+JsjlGZQR8LKziI+lOO2CeZKz7q4h9PPwBf5um8
 441zrRMu5YRClICAIgNWRfv9G13M3PwF4zA9zbsOjmohk3ff+eAPh81/pvrXX3aKHNxbW4LMU
 3ZRLIrjqHWQEwViYjpaVf/eWKCibrDUaT7o6w57+UD9u50rrfIpGXzaAiDwZ49431O5oixVdQ
 qBCCBHf/mXQt3UV78Qwa57nYAolMEvAipQypHJF2b6FXyPxMOzYxHt/0/1ln/Jcm3EusRwUdr
 a5Sn41oankdKP6baG2g2q20I7Wm9WurxXaIUFWq7HkqUXAtGyEeuYcNcS+MglZYubRW53vUel
 bC/yuvAuc7xxeCwIbVeel7NSNHlREmovRGUcdzGr8znHBZSXvKQU7ULjoz47KY03NswkzJf9P
 LC3vFI5eYYRh8FVXe5VeKrPDpOQSG3RDEeJ7HjUoKRXpF/WVYV5ZF2F7UO4WeZMnuj0isUNyQ
 zx8dVLzmSecUE9mpze0jPX48z1hpi17e3QQU4+oc3SCIJA2vuTvkqC/QQ4IM=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> v2:
=E2=80=A6
>  - Rename proper goto labels in several places.

I find an other wording more appropriate.
A renaming would have not been needed if these identifiers were =E2=80=9Cp=
roper=E2=80=9D before.

Were any update candidates left over according to this change pattern?

Regards,
Markus
