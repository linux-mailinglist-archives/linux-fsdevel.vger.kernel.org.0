Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EDE1FA8B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 08:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgFPGRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 02:17:13 -0400
Received: from mout.web.de ([212.227.15.4]:34903 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgFPGRL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592288223;
        bh=ACXYZeFxWRE0RGvg9PW+hPhazAc01bWhLukxSaDqy/k=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=gJc720/2TwpDT3KQHLHnPE3NxSf36+NEdnJ+SGgnzbinquzonpyqxVNGsBvv6S/oI
         BooOFGV3m0Ti+6wkJPvQKxE2xj/It1pCxkAqrymomFrSUQPkpnSIH/lGvpHoS/YVNk
         C2OOm5pk+1ky3DmCIEQ44WOXu2kMPvzbi/8Cr74I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.138.51]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McnaL-1jTgTe2Y7N-00HxKF; Tue, 16
 Jun 2020 08:17:03 +0200
To:     Tetsuhiro Kohada <kohada.t2@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>,
        Takahiro Mori <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        Hirotaka Motai <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a63b3032-a8e7-f1fe-d4de-1cee4be54a9a@web.de>
Date:   Tue, 16 Jun 2020 08:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K+wErj4jk9X+FeW6iUjy62kScOMkkjCj+9xJM1IHBJ9UNvZIfAq
 Au46dyJnR5NfuKjQwP4w2d1Jh5pftD/mGUmPug0gr7ZnXvq58yt/jyeleJ1xPpWwSEFQOPi
 AtnmMsl7iCqAkIl40ZLOgHDhjWjOrPwqSUk10gakB0tw7LmDvMUQL3q0327X6S39Oa84GM/
 VQVJ6i3zY3iwkmf/D1Yrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7XWmtR3b1so=:rz9p5QqmzDxCEcccsKjlWn
 3w8ysJEP3Y8m46oNHj3eXzxM8jrYkROtOPcec7VewuYwbxKbjPt+D/pVN/rf3VG7EHValA6wv
 gGmZoj4+9UYdgPITVoJsSlnt0dP/lSYiJHw96CvV2eJz0VDYnI5uiXiImrMIbuihCQ/9/K0P7
 nIs8y52qH6/KG5qxAp6qNOSu2kq9MTsJdKAXMVzdBz9H9Q7cCTvYx09jQIWiOvFZDWgqqbaoV
 8LRs9/hAyvWcPQc9Y2qHYt3OEFfy4GrFaKIAt3+F7mEFaqt3BBWGVhdV9ChS1H6sum3Faihmc
 ms6aP6rYwMH/fZA+uVinGWU7UeN5rMNG+Cs0qJGgJj+pU2c6BmFH+ZnGzaiNWxbydMcV6sCgm
 cr+uoTBBFXeCCg5AFr3FQNgjFqbuQI6ojyj2JLr0VVTLicN5TzvUtUVQwOwzXfPMOqtLneMpZ
 ozQ9HSLgOG6+Z7mHMOhJz1gz9jSvPQeplRBQ8oHlzkoghIrKQGq09DNndnkZLOTBXibO19JEw
 lQs0cv0v1MqoNMK6K27RzR8IEOsu7g4Hh4eTCNU7+TWTj/4w9MlEktnxa41ZWuTqUf9FWkihL
 Kl+utagWdxoTQ0pnjRBJZkfcW3j/hjiB+rl516rH8jUwe4AMwrO08cSGw75ga/rKMM6HtYAzM
 N6ZD2Gk4SGVZqlRobEphxHJBHNyfhA6wHYnJbMna916WDjrCkjQZwSWfHVvH6nMeAzlGiryio
 cC/oRmAL7y7bDanm5X/JaRlsPje/Ku/lsE+ayZKyhJ8IU5R24MJGzUBn2zLHJmLAePaA3Ekyx
 OTS7b7LSS0x87YvqQti0L9PUA5EdPw+M/qgIp3cG602wWkzwJnYdFZdKmIZHmgfLbVGGGCzzi
 GDfzfJpfoDEXoQSIXxzVF+uG4rzo1k4dW0rbWSc9GVvEUKpD7DBy5Df4HZlEWPZhKKLbpP9Nf
 rpMc0Rddjd9Sq2rqUzgRYsVC67Snhhd1ocY0mYZAFlwindBM0BHFZEwwkN9vk56jcwevP+Z28
 lw/ha5GRVUpTS9EjNaiAljHA4Jfliy0gEzGc0BxJTQqq7aq7bCsU24wsbT8JV+Eioe+49LqE6
 ZgIJW0kA7gRJkiCsWuTMwhIZQuZmkxNhHq26q2FPNXOW2k8XmeAyS+u6d43qXdFINGELaAAbn
 qf3gRzgHojSDtU/lNskUMaixbid+0tSI1zaHJzmpqrrblsx5EjZh4/yE9dri9+ZjYDPaM+FY8
 bzkAzIZXXbF4VDpEg
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> remove EXFAT_SB_DIRTY flag and related codes.

I propose to omit this sentence because a similar information
is provided a bit later again for this change description.


> If performe 'sync' in this state, VOL_DIRTY will not be cleared.

Please improve this wording.
Do you care to avoid a typo here?


Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit message=
?

Regards,
Markus
