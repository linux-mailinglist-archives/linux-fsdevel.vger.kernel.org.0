Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 025B1108A58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 09:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfKYIwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 03:52:22 -0500
Received: from mout.web.de ([212.227.17.11]:46879 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfKYIwV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574671838;
        bh=Kq+S1TT4adcCxr8FXs/G4mW64ugL+cP9hch+gUzTAVU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PeDYzvWogVGOUhRzg63oMYEOdSRvtX7Pd6twiyL4Bg/NFuQuQvdFc56PqPASCWFRb
         Mdg4C359JgAqqYNLVFqQLySNabFwSdEr6ESAr9pjMnClOx9Em9um6VtJVKfgnvKjc8
         zEOH0ElgBmtezhPOWzGo+nh3SzuAqA0+1ZlQzK5Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.130.213]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfHfy-1iATW01K4Q-00OoLR; Mon, 25
 Nov 2019 09:50:38 +0100
Subject: Re: [PATCH v5 10/13] exfat: add nls operations
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
 <CGME20191125000633epcas1p1bce48f6e0fdd552fe74dbdb7976d5182@epcas1p1.samsung.com>
 <20191125000326.24561-11-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <147eac54-5846-ffe1-4b6b-ebf611d1252b@web.de>
Date:   Mon, 25 Nov 2019 09:50:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125000326.24561-11-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/HAxp5Hi2+LXL7djNxBVTw2h1efwLp6Dsoq7Y6hEwtOcVxYK0pu
 X36kilJx31la+QJXOm9jeVp6PNG+xk/pB7KnLyL3vzCiZP0itip+I2hLg/p2dU33jF0hred
 Tv4yxS81vKoFkikpyICxr8SwSsWqpGM7wtbJDd8x7M6UM4xavPnNr0sP2fWb59SrwU5g721
 LZPaRPZkHTTlcw3spg6kQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5krfiDZGBJA=:wtZ+Vli/ALoyU3kFqp1K/O
 PTTxKWb1HMm8J17U3DURmi8flEg+ERtdrIuJrIXW9gF2iZTMZGbNGQDnut2Cn7MtN5wmclEHd
 vc37Iq8UD4xXWNBDzmvtATt/AFyZlthfVk9gcPym4gVeI3yb8O862DkKhl6Znyc2g+k9GrPvb
 Fho2uezhA2OJsXuECeQxHTb2uab80um81CBnuigVnZ8udtYbL/MvK2Q3n1TsGK6wKnZBVLPwY
 6xYwfbhzgTJ0Gq0QRET7E5iuFT06NC+0mf6ZHlBAegcQn3RUz8NnecNm8YS30lqyV1QTWuZX+
 wYyC0ystDYonc4KFXV27Fvm7YQ82ergoEI9i+JHbj5G1cnxUQb9TbzbpdfuXo6TwqDjBtv9Ax
 GiI+viQ0zzjFDORb0KvTXcQOlG0dhdTE1aGSqsQkothCXIxjVa1+sVDLiizXwuP+ApTtMs7iW
 nYeT5ct0LbrvTFKEAQZczQdtuV9tV7EtvAda7IZ7dkMoztLHWAOLvDYYBbVutSnrf7tmLo1Nj
 BPFDhzrprhj8ZvcjiZoqem8DoxN+paGfz+ySSIeo/ZEyTUl88ORTO9N5e+q0W+n6WkYQk5dpC
 +LkPAuodSmuz2eT9xv160P5faD25sDiSpQHkTPzOIlaRo0C5TY20EgJpN4mV1ZNXAeLsgkgdV
 tKZo75KDIhz2mBLSArkq6IYK3Z41lGaSVyW8rB1LyZeCFYy1pRQ5uUhnF3XygXSxGj1XFjlIw
 39TsgSS6PjeEf8k4Lodg+EWXVHxRzmZB6M/O6YiwcteajxU0m7t2pyenj1QTBRW9CQWufSej0
 rpd13n7dF33aLFhqXEUNQ4ilH9ISfG6aimmxXPW2GRhWS7Q8Hnl/WszUaBgbWZha7p4z3mb3J
 jGLtuLLpZRK7b0lid3zmUjuAJTSQ+kB1axWvQth+H9r9mzaOPGR/r1FbYTHuNKmmmbuhuy1wz
 Bd1kPgaR7dTp2hqe14+D9cszOrH1MI3/SfvUKx/HZxUd3X5deIJultQf4xkeUwuZQlWX1e6Cl
 5fYrKy2Hd3niyU8kyxuvobcNzLz71MktQ+EjRtHPkDcmDZL66EGJTzXTepPj6w4fwNJMNr5yk
 q2iTHVWABt10gd6WZOCAfR5hYS4AdvXDuS35jGzFRC1oNUOSxTD9lbSnj2NogpkOSZLcAcnsw
 c++sEnPOnzIjdwnTQu1ddiF/QQifoJpD49C/X666kLgHJyXf8Ulg/BOLGnGylQbAl7nL6FIW4
 o8bo/OheF17AA7qMlqTQXrcWBcVV2tQ+8Wh9ChvAtFKrIP9stTgBxkWEBcO4=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/nls.c
=E2=80=A6
> +static int exfat_load_upcase_table(struct super_block *sb,
> +		sector_t sector, unsigned long long num_sectors,
> +		unsigned int utbl_checksum)
> +{
=E2=80=A6
> +	unsigned int i, index =3D 0, checksum =3D 0;
=E2=80=A6
> +			checksum =3D ((checksum & 1) ? 0x80000000 : 0) +
> +				(checksum >> 1) +
> +				*(((unsigned char *)bh->b_data) + (i + 1));
=E2=80=A6
> +	if (index >=3D 0xFFFF && utbl_checksum =3D=3D checksum)
> +		return 0;

* Can it be that a type other than =E2=80=9Cint=E2=80=9D would be more por=
table
  for the desired data processing at these source code places?

* How do you think about to use more meaningful identifiers for
  two of the shown literals?

Regards,
Markus
