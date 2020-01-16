Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24C2613D725
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 10:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgAPJoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 04:44:06 -0500
Received: from mout.web.de ([212.227.15.4]:46951 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgAPJoF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1579167831;
        bh=gXzqrAxVoB+YWau3W+2D4V6kmgfTuKXCv8JWZpAPTYo=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=FitTeWw9QpEZDbfO0QhA7rcVk+WLy1nQqNPvG9nebo3OBU7fn/s15/+MxKBKFZmXX
         CvsuPiUKSvVi3V7boRs0wvVnEXz8y/+W1fbG+KYrP5dIiKaDpg3pRlhktSlRYjieBP
         m3bxd+x1+rOPJMzF9/7qCqS4hyWqBUq4AG04XiG0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.6.163]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEER6-1ipmdr2zcW-00FSjV; Thu, 16
 Jan 2020 10:43:51 +0100
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [v10 00/14] add the latest exfat driver
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c4fdc6af-04c2-81a5-891d-5a3db4778caa@web.de>
Date:   Thu, 16 Jan 2020 10:43:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d7vfc2/pYgtWSs9bNVihsxKNk/dFmwI1KQvsetej4Vcnc1Y2ccW
 oJqOkCgMdVmAYtWxEvsWwME/O0bfXr5/z1hbr3z6Nghj/tnCBiAegpHJmhgu6wLAqxzwKsH
 ChIpn4x575vcfKbyF86wmV+n3SJkifAmXqpjC2GT8+sBxJhAYD05d/Oqf9rfc0l0i08DEeC
 bi9nxTYXX26gCo8Qt+rqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3yaBn5Qz1KU=:qO0dh4FAPfx0e+F4+BJx86
 edeJouyEyLO5VQ9GMf2ffRUxEDE2K5Ah1/ccsEoHI7PNXH78lZpBG1fJv5cFKgQKYe2blTbyU
 b94aitRoZY7vCUORafr1rirMzXN7aybShCjficf6CZhSioXZguXt7gjuapFltxaLkiDM+/dc6
 KQiv5DUe7v/oYQ1+a51mcoaD51n5WJaZ6Fe0MENFY9SWTvVKGT9OdZBEFOU3ZnIJ/acp+V2Yw
 FSXQBqoColrYY+v4/qHp1RDvSjQ3QJcDw0xNNWWza3UHjCN6Fz8XQRerxoz0c5qapHgERZDdy
 l85Hhudw9fAieIWNIMY1lixbohXxMvQXRbKGz2rd1xJXRub15tEV17iF8ipJfPTyHsyNnwyNl
 irn/+vYSLi7FNJxKJ/HWP4NsXUt7DqRRoLL1mGihaOgSM4H7tO7I59t051j3oC1eGeUoLQXbk
 CNy9/N0eK7NjZLV84BrtWAdbBNvbaE4+Z4PNFaMo6s28f3xabXEXco8s9sDyVASj30Hh7Xm+u
 2Avz8YvGgjpErtWIhc9Qo1atuyiziJJBwDuyi+2OveZUE+wZcVRxkOE48KbFfcfVhbM99POt9
 vY+GN519/mkerxwifLqiPAzgw3DcwXw4mhWTIaakuAeWzC3iiT8SD8/zhx5r/NvYPxzwEwaWJ
 hSQTbLYJnKfLKC4koPIB9dr9KzkjHmVSjNntcvcrPYL8YKe8d4w4kq1wf/VGNpIlUQjLIpx3n
 qVubmRlFwEFTKqReSguo5N0XdfpZd6L/LLw5YBabncp/ljJWX5C3f0EgKWaDmB+q40AdVKEWm
 oSjMIWl7giRlImeCGzM6ogyRh3+GRRZ8SIDCpnv30LAu0kVeCtrgccBJoKlA0JMRnan1cHBEA
 +f4e+C3bI7do7uqEX2KfDi5s1fGiHod321P+dWWdaC1KOytOuM/xE77W5B7pdb2BL48/KBq8v
 al4zJL6iSRwUS6YSRiGqYCAGMEqkSYixmP/Rd40U4VwG7kpjp/BQKQVMifEqU3Zs8jHNOamju
 3vs8U+12zil5i9ggspes61qLsLXZ0p1oH7QiwVQLYQn4mMZxrWjvRTy2sQPLMTPSougAXKydv
 u2cwgiJWhCHXyXZH+WrZWy9LGC3NkZSd+45yoYiC7v4LoUzTLmL1hHCSQKSQq1/RTJiWN/u55
 /kadYd9Iv0gvoPsyT5m+maKFkPiBMq+Tc6hwPg0USXaw2sO1RBxPTmqG8mNyUEY/UX9KdQY6M
 Kc8faejdWIKc1CScQ9cSlJHt2QTFxQli0nR92UkSSUvjxMDBqVlf/B/0OV0Q=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>
> Next steps for future:

How does this tag fit to known open issues?

Regards,
Markus
