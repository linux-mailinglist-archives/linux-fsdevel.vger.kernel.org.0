Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37410240A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 13:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfKSMPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 07:15:38 -0500
Received: from mout.web.de ([212.227.17.12]:56913 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfKSMPi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574165721;
        bh=A+QcktrnUs67QbMy7V2ZH7T30B11Ybb1wxgOdhsf8EM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QQ5LhMKRK/TrgyYYfDQ7vNMi5FuKyw8oW1YqnABWE/Sjo6S5IsCokHfP2qxySA/pw
         LypvtSvtPCn8ITA3zrlchHImPksmReDbdV2dUqBQfG0wjwI8XlxbN/g1Cj8/Jc8HSB
         hmm03vNan5CfcfP6EqVDjd/ZRDxYV35tYVtK9tJg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.93.164]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHXxg-1iaKCS3XuG-003Ku7; Tue, 19
 Nov 2019 13:15:21 +0100
Subject: Re: [PATCH v3 00/13] add the latest exfat driver
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <CGME20191119094019epcas1p298d14fcf6e7a24bee431238279961c5b@epcas1p2.samsung.com>
 <20191119093718.3501-1-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2cc05215-3b44-06f0-b34a-eb841476b329@web.de>
Date:   Tue, 19 Nov 2019 13:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119093718.3501-1-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6xuJWpKUb+evdtanfk9Bdypa5YDmYHl2ha3GbO3o6gW1KYGJ0pj
 o31iK/A0LwWB2yO8eWkZbCHprjyrkiElhfQoYoJOGiAN8HlUgrYdLhRpDhAVXq5evD0YrmL
 QhOlhvQqrLhl4VFpTO/ZQ25Ud2np5KqoZSI3FvRrSqlxHSxY0/4EbwafPH6n5i+Pd5osH9q
 rQL4wgfYBqe+sBbf0AIew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YMsg8I3vjKw=:gOZvpdM7pv7QOz4tv7U79S
 fxeoOo9MLMxMSWiWTtuEv+by3Shp22yyQFaXXQ7zOc6MK1ycBrQr+7gL7K0zmACJjvC2+4rgs
 uvg5sJvBVTTwMH4HEvvIJtjzFA1fBhaDcQqVWe2wCI7ig7PWCqUthqYLnEI9GUTSmd76ufdBD
 wn1NsCHtD8yeESaGuUVftpznixZ0NcadGFfLyU2X/raT9F+XkNrRI18DYYIjO0/eEo6tUwqwg
 tiFqUZwjpmlkkKXv0VLSFPqNLWStrQkTpKwsEc5/VI/C/kVE1bmF3UV7kGsHtEiu2hnyaFiQV
 FiaPkwDNvEW+uuBywM4kdjv+C4R6bcoagHIPXcKgJdu+w/DCZvOEJ6xdL5WqBZ7AmPZpfn4hb
 SLGsOvTtBVNEGP/mwYzm5CcDzR2v7h6vhyYZNwHAdKBXpP71s8EJTZ3ijO1FCMdmmC+gJ+bqa
 Z10nAEcYioAVE3uoi4ezH8tsjl2DaVZ8NDDvynGJdhip1fjBkd+hjqQLYGC7JlSAbRz0u7g21
 FgLRSqyymNJQAkPJd3uW6wAem95yXfqDFUsBainjdnACj9ksd+bY9E0g0UPwXgxR001fHTq/N
 DgBrl46WWKSh+jYDF3daZ/aO2i2ZCIh3XPrh5EIjCenGuX3Xyk4o3sR9/AotpBAcq5zJWwP2X
 nS0IBr6rzrRu5qq/2D6kugYFpICDc8YgBJYuy3vWWX473PN58RcI132psETQLOlc7MMqT+ESh
 uto9Ll8gigCYafgethWIa4CEJPF1Rp7jsDGeNx5JQeKEXIx+AQRJverJqQexNxdy1BLmgn61m
 H0SnbA3UctFyTLRHYg9+25G4MSJvbQURbQ6JXI9Lt/f1jRPp3uj2UhvNqcD6FzulgIqYbHEKl
 KlGolTxrmgZh2dRyfbPFYtLlgdSryVUOemTXzboYJxIC+NbbaQxIdTm3PS+CIRcIZFbET0fdY
 Ce4hX20pdJSP3KHncELlKwl8i99p5btC/FkkImUxGfL2GZGB01a5J9TJt6SMbuZ+N7hQCvokP
 3k1P+6+eToVEqooTt/jT/VWZoBF15bI33VUs0Gb59Elw64zSLm34bE3oHYFBEVqC3wZy2FBxp
 BLsJ/xT3MsbE1rLhgJ72jcowLrA4tIRHl1nOGCYJJYQ4OrS+kize0pCncdIUopuU1TA5b3p4T
 hKlrGDuurWT/fbDCBA2HOC9Z6lG8LbBivdTIJ/jXxuZ6b98VbY23jp0lJeNym1EiTpUC5G/qs
 TENQvH4x4ES0Ilg5xDN/PnBw4+9oLWbLRlS0ymMjXjs5u3WrS3yQ1QPBqEhM=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> =E2=80=A6, an a random previous

Does this wording contain a typo?


> We plan to treat this version as the future upstream for the code base
> once merged, and all new features and bug fixes will go upstream first.

Were the following mentioned issues occasionally reviewed already
by other developers before?


> v3:
>  - fix wrong sbi->s_dirt set.
>
> v2:
>  - Check the bitmap count up to the total clusters.
>  - Rename proper goto labels in seveal place.

Would you like to avoid further typos in such change descriptions?


>  - Change time mode type with enumeration.

How do you think about to increase the usage of enumerations
at any more source code places?


>  - Directly return error instead of goto at first error check.
>  - Combine seq_printfs calls into a single one.

Please refer to the correct function name.


Thanks for your positive feedback.

Regards,
Markus
