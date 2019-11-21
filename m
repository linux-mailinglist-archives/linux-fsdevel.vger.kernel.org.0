Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79EC10537B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 14:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKUNqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 08:46:44 -0500
Received: from mout.web.de ([217.72.192.78]:56623 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKUNqo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574343913;
        bh=SNdi8SUvR/OK4MEe7DQ6cdvM9KRA9MnYswRn5kDoBGc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fOlPnxgZhf+zORQIIQD4ae0+j8QKTwzoZPwbPoExxdCtv+A9oQ8PCEzv//dblvXKA
         YVyfboMrbm9pBOv/L3dwX3PExnryelJsXfuDzVKpPZsj84hbmHZknRxWbuTzDOKJYt
         iQiP04bXqzPyXB6N2/ZbUzdolPGYYoI6a4rTUPl8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.172.213]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcPf8-1i5dDL1zBG-00jn0H; Thu, 21
 Nov 2019 14:45:13 +0100
Subject: Re: [PATCH v4 05/13] exfat: add file operations
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
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
 <CGME20191121052917epcas1p1f81875dcc2d1a64dc3420bedc68fb3ba@epcas1p1.samsung.com>
 <20191121052618.31117-6-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e648740d-1bf0-21f6-7073-f66e0947cc58@web.de>
Date:   Thu, 21 Nov 2019 14:45:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121052618.31117-6-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4j8N1FYEyXJj9o4Yhn0qfN+0CdTdgh8vWN58VB5cZ3Y1kobBbEV
 P+vNMnW/KcMMqEDWDe644g4hjtUHYd/vly1uLXexaCuPt/Iz4dg2FF2gcyxltgj7UDm/BX4
 aJMeqb6zZZQT6fAt/uQTs2wxwtBMp8Fp/TYaKG3hQTYUoa6jQA10P8OXx543PYtJ8tLz1y4
 HuUrYvBaqpff0fkXBknwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:toB7bn8OiUc=:gteXsXYfs0qpJSHwPtPnqx
 jKmzbTKHKNrNbqosaq1oUZl8oD7VY1P7umrQUdziQ1ZguI9XnhMm0J2F6s4Eem8RGdoIZYosj
 XiAW+1HCLSNLELinxrnSeCNFFoqX+j3Dp9e04IT/2M55gPVGPFIxdwWcXm4SKFTUk9n2fy3xh
 WWPPwMGWqmH0ch6UWKZd31snlTnb0wfD5/OrYNOwDpsbKhIz85byv6ZiW7f704H5oGvOxfXj4
 ILg+NEuhhKGqgnUEwJBScfNzmU3UALHzy7QyAcJhSo7YJAhsO5Oq0jlmoQbPfsNL1+j93W3D/
 Cc8UTNQ3tFU8NBYCc1i+opyDUkv99/9UyYq+U0HCwncfqDxz/4pq85YHF2hCEjrvsmrSemUr+
 AKxVeDKZMa2iJp0hZXvHfnGc5e4ZlT7W0E/67gp4xSltKCG3Zih3sccfCAcCdmGDb0FYkCe3x
 mo/X5KUBXJwBogLzOe9ZF++oy1Eo0Yxrt5vqi5WnjNUmiQJ9x0sRFtFG98DlB5QbD3989Cbqw
 /Z2IuomN1RAeCFdJYfPUbplb0ZvCyvT6CNE3YdAQoYJZ7isOA5pGrXen38JYq72VjzBUvlc+A
 XJb6H/Yqs7T17Ny1Uv6FoOwVbCePeKyPa8GtVKF7o+UR6UCTAFR6n/gsC+3aIQmb4oXVo44jy
 kNhwcz03trUKNpA7Hyqv8MtzV2G5LuQG0IDKPnw+fmcKvc8vwEUI7yGZkkpGFXR6O1XjNVRH5
 waBIidcYUG0CSDyV1vgZFGdRjp27ApbjZOI/69BaHccWufs62U5oJ/7PQTOCwMUF00zuBe6l2
 PsLgLDrFjpVEAgm7Mis7Bxlgz1gMFaIUyZ1n2+mvlbRuaILsFKd5S8l3GGDyFrMR7HBHxFJwp
 HRNYaEO+prgxh2zEwM6npa6Dod2TKhVGizh0onNyXweC2gmkQWDEGhsyR6BkeuvmEEj4PwqRM
 h755cqWpMTJeehaJ3erHFvAkwwxZBEKEC5sNvb8RDj+CJrMez+BRt7+iR8Pzl0dGmM7cM/shF
 4bySYG7XVrX7JZmXLeY/0U5/L9AJRz6SuM2jeay8KyZOcZ93MBovVSH1skeVgv6d7cJKu04b3
 2rXq12iMAmses7ejJp8t4qrDTW3EmeqCjEud5URtmDHW4oB6m24U4WFmbRoAYlhX4DCJoZsmw
 j8sW5FlzZY+OBB6buSR9PLKBDdYopVehc09w2ymV9afbuRBYMVododG0ifxk6xp6YZs2xA2TB
 bfyi9CDYxywzHemupT8CmoAIxsmGO0Ui3sAvai+mDeEYdI/hZ6sanZfgp2CM=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/file.c
=E2=80=A6
> +void exfat_truncate(struct inode *inode, loff_t size)
> +{
=E2=80=A6
> +out:
> +	aligned_size =3D i_size_read(inode);

Can a label like =E2=80=9Cread_size=E2=80=9D be more helpful?

Regards,
Markus
