Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EAF1E670A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 18:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404849AbgE1QEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 12:04:15 -0400
Received: from mout.web.de ([212.227.15.4]:56869 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404688AbgE1QEK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 12:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590681845;
        bh=WF8t3qfTbXpIhenHywPzgwEX9tbGimI9zcibEVfQI3A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iryYm0Q8wJ4JmZf/laKrq0brNsNLGUWrtbXfZe3Dt6FJM4+Yuqd58EogAOZPzxR8O
         Pg1lf69Ib7MEyrpK+YzGxRlfINyK34fS4fH3omHD2B/tqi2WWFsWIJ5ckKOrMkg7Uz
         Zrs3oiXNrvyrhGU+CaLiDsO54QDBzXzN09IbxmVs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.30.242]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMZck-1jev6Z15TC-008Gwz; Thu, 28
 May 2020 18:04:05 +0200
Subject: Re: proc/fd: Remove the initialization of variables in seq_show()
To:     Tao pilgrim <pilgrimtao@gmail.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <e218bc34-b8cf-cf0d-aaf1-e1f259d29f7c@web.de>
 <CAAWJmAYox7VNCzj7FnRdiX450wd=DtZAcZv3_2JiPmBuLvUMeQ@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <826fc010-5002-c9f0-1af6-36346e922cdb@web.de>
Date:   Thu, 28 May 2020 18:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAAWJmAYox7VNCzj7FnRdiX450wd=DtZAcZv3_2JiPmBuLvUMeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:le3kD2sakBsATxt5j2a9jE6nOaygsLR+1cIE/AQmJMlNJEy6Mec
 E1GDYoaAriKndNohTI18I71Rh6mczk8XvIqw1cSkYtJAr+FIYv9EPM3w2RyUF7vU3xROA5Y
 X3sGFFaejChf0WptS2OJJO9HAxt+kjps67UkTRTW7nTd8QR4NxQhb+ch/XFm8R+E1kpYGPc
 TbPsGQfc3ERTJZaNqywCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ag6QytpkC0=:F0iNzaB/GOsJyPCYy2+r8T
 TWQRa6ouemXZcW829tPcHS1gbStLedigicfHq/tmSiVuC+7WuCya6XCg+sDp/vCjwKpnTS85r
 1UnRNjF+TxT7j2LhPcNHlGNoqExK/nQPAWOq6qqVAw2AN2JV4ZHm5mIrLW7Mfje/FSQnjAbNu
 Z73+aEaFVH0Z7C6m1cyClv1G1nZIubr/GE1k0W30/GPYyNB+7B+HYrPCIStIi7v50nfYmqoWI
 Nadg0dFW9L/WT6snJ+Diflw+Nc6msDErBEJ1zYBTBGI/C6WfPJ1Uowb2XXR/iaHi/XGja0EPR
 w0c65axxy3gSuz0ULP40ThA1586heOT49Dtjd4cnwprKu8+nU+K6+doGUKCGFwhRRDXORb+Xe
 yUGp6JxrKIx0DCbRxx1A1zFGi2+c9WPe6pafbzHC15GRlDjNg0/AOeIBSAj1WYO/tPzT9GUxF
 oMvUxcXGP5/pT86c5IVlnyuzr6331Yt6YDn0vEOFzYcAjtiLBVUEn4mNSWi0gK/6K8QQ9eozR
 x828HS72b7IGfpZQvkgwvzVRzbocFZPOehuvKJa74D/vTcd0v9eLvo8sKHIuM3ptg4l30kMjK
 BDVhRkhPxDDkdkhcNhcbwIkLpvyU/D3SRizOWR9MTTTOyD+xbJx1hazWEDn0MUZZLDF7x64uV
 8/tZ90N3tiJpQb24g6FH4O2LoHrls8U/yMLLYteMCO49SPL4yqCDf3ify/O7MPHALHqPvtuN3
 58qEyPlThgr5ESD1Bqdfv1OpzvNXOmgiooGXLZ3lf5absRKLy9OobLZWhAopswXPHjt+KP6XA
 IYocbYXkPB8XZx3MpTXe9GkxYRd8Tssy7vMHxxqMLIW5EewNLhMd4ioddq5jOzPtuPFNn0DPj
 4Bm13GIE3dUc1TbMu2bL/aKly23Vw0RvxnEAW8C52x0RPUVf4ZGjt7Jk7u2YNVuGz98Y7EA4d
 wu96fBJAyuPMYaDLf4+i52OoR2yN6xzbnwZ+M0aSwLmyjqvOxbVHXis/iVApuN/EJIhlc3cGZ
 P17i4dQuHMYo0t2+Zbu/4coEL7fLYsFfysqGRuC0W1E/FmJ+MDBa7G3s+64zENWSOnuVKWzAg
 8fzI4zZ9BqeGYrMtCF9FZO4aPg7FgIDdnTq4W0qeEl9XXNO67pYCGsxquRrFXn7MX3nMieLrf
 1fs+IYg9Q+otF01gOPfV5qDcVofWCpow29vmVr16t7mk3BBdguR2xKkjGw06X3H9DZrgwpqH5
 z3mX4chLr6TTNnP4z
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>> The variables{files, file} will definitely be assigned,
>>
>> I find an other specification nicer for these identifiers.
>>
>>
>>> so we don't need to initialize them.
=E2=80=A6
> We don't need to initialize the variable =E2=80=9Cfile=E2=80=9D.

I can agree to this interpretation of the software situation
because there is a precondition involved for the variable =E2=80=9Cret=E2=
=80=9D.
https://elixir.bootlin.com/linux/v5.7-rc7/source/fs/proc/fd.c#L20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs=
/proc/fd.c?id=3Db0c3ba31be3e45a130e13b278cf3b90f69bda6f6#n20


> I don't find the programming concerns around the handling of the null
> pointer for the variable =E2=80=9Cfile=E2=80=9D.

I find the initial change description too terse and therefore incomplete.


> If you have other suggestions, please elaborate on the details.

I propose to extend the patch.
How do you think about to convert initialisations for the variables
=E2=80=9Cf_flags=E2=80=9D and =E2=80=9Cret=E2=80=9D also into later assign=
ments?

Regards,
Markus
