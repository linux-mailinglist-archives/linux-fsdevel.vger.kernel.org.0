Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934781552CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 08:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgBGHS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 02:18:28 -0500
Received: from mout.web.de ([212.227.15.4]:37465 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgBGHS1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581059891;
        bh=miGt9Qp5X287HT9kScwGTcZaVamZNwQjWmskx3gp8cs=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=GFzF8AZM95D78trnL3UHSaeL3SiKRoHhufj4SnbgDunMRqdTiUXYSt1IKzGmJeMhv
         n+0LC7EhrZJvKikfD14KzN7q7zs240yJUxAbA+CPiTmphX8rGtXxxPDWnV4I1PJ2Mm
         zzALM+M6ZSVEydgxATNcN6RhJrgc+YSStVBMvaN8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.120.50]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0ML8F7-1izgmo0bpJ-000ND8; Fri, 07
 Feb 2020 08:18:11 +0100
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [v12 1/2] fs: New zonefs file system
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <97fc31e3-94a7-406b-6264-42da5d5b5d0f@web.de>
Date:   Fri, 7 Feb 2020 08:18:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rgDWy9vtNV4rdpU8vQ/zfhAP9RKnOJLlapSK0SwBOBApmKgVacT
 liAu9nRJkMElIHkOiZvIpfrkYDEBMUBn+Kb0NLw1WbBGMO8BCiB8ykU2V0N+g8UP/2GMQcT
 kLAxxL0Cr2/u/fVcHOSqkk8tpJKGB7ULS+U3c/5jAdfmAAcBNj8Ui+HxiXLK9wnpSWMfiO4
 47XdCeznrmAJsuHX08vNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hZyKktlnhzE=:Uy4EpbqWp9dwf6Lxt2WI8c
 eMMgk5FEArvi3qn0X3eCVpLYLR6qXBH9fmmfXACQLcIP8B8PbofLTnvgmFOR8reguYGycDudm
 eAMLBIFUN1xy4MD9pEiFeucyqseCQVycyDiyqpw8bpADHXfzFyt/8uyDKMnJgDztbI3mMHSJW
 w7hmbuKVSbOXwYu8eG1oAkRS4Gp+ADgSrHArg/UOrsw1eB/CPdl47A96pHXg6pGmdvS+QP8uj
 eZ7so1ySAYtt3Ykh5yCgZ/LrBDZkV+36nbYfRK7npscTx30MS1FqtSujBMYIBlG+blrGse4r0
 SRAyCXt4OJS9BSErRexFy25Wn45z/U5DCABO6KJy47A607r20DkEuHoOLXYY7iqE7RoRyLNYC
 7GWryTrsxh8G/wmCooWwibtf8ohGISkHxMU5cr5VQBUabMLxEYTIXsxCJGo9EZ0nlcuCHanAd
 oRGaKEXYTmbdGnPK3T25XEb9YwURZdA/yvqTeXc2OYoWO45UjsvgmGBVa5SGS3qDg9lz+UJuT
 MkpJOkBN+SIFOTino189N8/WTQw9Exa3+FOrkbmK7AccBbOM+RUZ1x7nGFs+EMK4/pCTMd+Pf
 l55QyYGKZrArAkY3vwmDcT9mp84mk5EOqdp+hsEyP+iet5ipYDw3aIs5s/0XRHWabWZs0Yx/J
 hNLNlHZXQF8WcxPV8e1Mkg/xgSC5aTl7J8RTCVXc6Unrg6zJ4Mz0o3zOY16BSa870Nie1F3Xt
 7pPA+fgrQleruga/3/pJJbzvAFADLteZXu3BHgSLFUTgQMHZeDICOP3eaG+G5mq6818UZwIFh
 cuxhf97ykXkrCFsKs92+Uc8j5N8Ri8VAQ3yhc6ItUbqAwCsBBoBFeD+BpA3gGBOrZdSY5AIkb
 WXgM/zqot6Y7chCFWBa8X0+zD8LE2+2/jK0NKMGFwBQ4++yjWZ4NqF9IGmeu0T0gLiA9fmU6u
 0HmwvMJWzA5isuuRLFrZ6ctnsH+t8COE5yMnyud3IWRLB0EAkZ6A1UvnfkY3heUzi7+bgLpYc
 nnYDhNX/sXkyVu/GfYhcVzV4QAladrjHN0KFj640IWm97VK5EHTRB3vJhSI4C2q44jcqEd6G3
 ywIfN1gKCBL2CCvaYD0qq0q3tzjhTa0YbOwsqtVIm+ceMxVAZzD+GlAsyggtMXFMtHzbpN3Dy
 ZfFNgiv+pV5zMJIXeJ/GzOwaZcnuCGvJfh5r6L/09EHUrxClngMz/37sTo94TdL6w+mKbNDOf
 EGa8JL3sKzApIOWWe
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Hmmm. I'm wondering if it would be better to return -EOPNOTSUPP here
> > so that the application knows it can't do non-blocking write AIO to
> > this file.
>
> I wondered the same too. In the end, I decided to go with silently ignor=
ing
> the flag (for now) since raw block device accesses do the same (the NOWA=
IT
> support is not complete and IOs may wait on free tags). I have an idea f=
or
> fixing simply the out-of-order issuing that may result from using nowait=
.

I find this aspect interesting for further clarification.


> I will send a patch for that later and can then remove this.

Should another software improvement be integrated into the initial proposa=
l?

Regards,
Markus
