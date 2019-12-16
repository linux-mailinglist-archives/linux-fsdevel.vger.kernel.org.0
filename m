Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACF21209A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 16:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfLPP0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 10:26:53 -0500
Received: from mout.web.de ([212.227.17.11]:46573 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbfLPP0w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576509998;
        bh=bX6ezpgPKnZz7gXv6Z70uAvDUPR/OQwEjr37+ely8/4=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=oRZSc2g27iG8oOUDh5xGeaHdgEhX8L5cBKVPu7AjFVKUsVhx0jyZ/UPdvHJy0SsUr
         +9VKPAkBTW0ycfBJHsCax6rXGRrDKmYY1yqMLlPET4NYA3ftq7fTNGk/YD2fdf222W
         u/LJEVrX3nUKcjjiim+OX6nubcIEhbePYmxPUzYY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.181.202]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrJse-1hiHx42Amq-0137js; Mon, 16
 Dec 2019 16:26:38 +0100
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
References: <20191213055028.5574-2-namjae.jeon@samsung.com>
Subject: Re: [PATCH v7 01/13] exfat: add in-memory and on-disk structures and
 headers
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Message-ID: <4aedc5e0-17e3-f0c5-9c47-8d1300e0af3f@web.de>
Date:   Mon, 16 Dec 2019 16:26:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213055028.5574-2-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:33DO9kAi1XCUVZ6W1UO14ulKknd/vu8psU5mBGNcHnJL8PUFSzT
 WPcc62OcJOilaM69r69WqHLU0sdTe6C1FFZjbixRELf4ub2TSnawkjYd3HTRRp+s3WDKle8
 GJOOgWwwEKNoF+UGqoVM9UULkVbJDk3ASkFPRbMMKd79AX8TzXczcAC+f4W1Lpz/b7DJ4W8
 61YfuEWIl94ow4WuUoV6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uwE6IeKaNFY=:8qCfO7melHxdnpPgUaOQSb
 1N0wnoAUZW/bvKSlms+w5evBLiIy0VZ2WB7hA0frgX9eJvo1cGeNnEv+rGxCTYRLsCLNWrAus
 0oftlMROZaXC0GUko6dK+Y7lqi/rJGvsNVMOMPPEKNEsRgrtic70LpS0P/29LczbyFRwA3b+R
 FF4EbJL1yTyKRTsnQhEIeW+0q6qvhmwfR2GlQ4Z5jyJWwqVXEBADhP/THCS6AeP70ZTnfB9u9
 ++uuevNg5KE0aTROrokH8Mh/H9yntIcyD5PHGAuOxvi3ZKZwWMZGWlyYkZnBpcdOaOSO1buda
 QDfpoZ9XjgRp17b4cFlJkG93bVHfhWORFMTO5P4jMg5oF9o+l5o7SZBrFF9hG7Rse7p/Y2kU9
 sAlRkCiD7KDF0oaTCs6I81suiXxelKp3hQc8VdnZZsifijiKwuPeNemvxL9ul6P41mcebVWyt
 uq0gp8uI9RAz8euB9keaIyeaxBwpk4gMPtQ9dZLobnZVVFc2zgy5Wxghy2Ck0LP3SAdWS62qN
 9jiVUC8p5QBUO16Cd0aFwDtsd4ViWcyWrj/GDEYMAu73huFsoZ091sCpLSV1OfEvZGHnV1xBE
 XVfRpfNbv3SKeGslxbokzoKfJRxa3xLu8O4bFR1GJcA60blrd3IFTPzB9i1PfbTFkTic2Il3V
 BeMh35NAqD06Ouxi2x/Huh38kpBzTwOdLW5vv/wY6bkyButCFMA+smSbKtGWMaul+gzOaIhYk
 H01Vsb9l6fSrafaIyBU6x1ZAvrAF39jbWaGiVfg8vgUQ9HpBUdHTviAH8bsv1TgnwlOuvgEeC
 LjdtVNGcCaqKL9tCSQcbDz3haVjUX64sAiJkkvCJVhgJNARL8IGDtbJLYEbZXpskbKPJ22bau
 yIL/xFv8hpxg+DehHq3ojGkBX6Sd90kU+ZukhvjToqkyQX34/rOfSbQ3gjMJmwwdB2xVkkwPz
 CooblE7vTam/beFR/B6b1C/1Ci2JlgFBg6Ds2eGupYjBw8CMkqYRjKRf6KFEjiOG7NB6nKdg6
 75sSqkQrvQja5HBw3Ujs+hG7epy5HdeapoUffNG08jf2vxi+h5GUVsvGQQg/12BW6H5PoV/6y
 X3nH8TCGryZ0bYrHPCYhT9D2mUvAe6hnfEtGf1vPv3JeUHmPrph3ybeLy+hioLbhPNLdkWxO7
 WwIV9isHy0K9ztEn3C1UlgJHBPvlQ7gZrCZNx2aAdiUS+wD8BoLQv5Ujm4Q1u6+dfHSIhF/ZM
 pH9/0b1XVtjyzI18Anjk45hbEr3z/C7ODGQoxFb/dQkISZNzoLwePcHctq+4=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/exfat_fs.h
=E2=80=A6
> +/* type values */

How do you think about to convert the specification =E2=80=9C#define TYPE_=
=E2=80=A6=E2=80=9D
into enumerations?

Regards,
Markus
