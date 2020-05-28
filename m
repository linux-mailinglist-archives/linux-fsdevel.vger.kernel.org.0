Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F245E1E6D89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 23:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436597AbgE1VUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 17:20:50 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:37847
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436579AbgE1VUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 17:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590700845; bh=/Y6kvn26R6KuOwls+YEs880336Z/uTDdfmbnMi9WL6Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=TnEx76dqdGv8r4Qw0dXW5fcr04glYFvxJBD6inBqOURB48o02jb8uZMQKbXfj2pV3LJhURA1zgKxU0DoGyW6Jf3tEGDGhCP5RZnr4uiOjRjcKtQkbTQxhs9XVPhZ/qNr5F82IjMHaapGQ6g5Ym4o+567qxXXvnoASbuJyHuvhHOaiyQvOAR3FpTT4AEA9sPsAIE9ri9bIx/4GXtN13z2rS76e1g7UX0W9cjjYzN3XA7iRMOnL0q3B4foElr/0oAEAp+g42WQit8PBlOz7Y1oFeuhwlXa+OQdkCelVj84Y+BM5Q1adILElToDHIaSapfWKyjhnYwyJ+UfdKXUIYkcGg==
X-YMail-OSG: EY9Q6cUVM1nk0iX9QI3k9HiPe3uK07pL8WEXShBeOHtBEEOAq0_tW9nIfqlNhT3
 LsbZCQVU9rvRzcv13Xq1O7BPus1zTZaMDDIrlEXJn5AcqoeoFhL6_291D41TRMpWRh23KQj1RryD
 4frSRhIWDc..X6lh7Gy23sv8JqFMMMO27.UiG1FNxIPXLcnyzd6HzAbttZhbEhuxFUs8eZ7VQNWz
 IerwASrWcjn6OQ3xFaxGPPvSje0dCl8x.Qxxp5C6UFwUgBOPNZ9_PJ91yaBBlTqGQT4NHjJ8QRIe
 ISjCljhJSLREGNDS1CK__0jnf7wn_p1Axct73iC15s0Ymlf0FUqW6OwsPva5uLHFnASVlSUMNBPt
 5T4M3z_apQaZNPNHwCnDzHH8bGXieqMPLSzTRBsRUnKONwXOjYLoumA.dSylIE0v84JqU9xF69Ot
 c6sEq0_Z27UCuTyIYV5JWqzBI_7ZA2Im8X5MEhonbXVR0Xx7YBnsk3qlQf0TIfQwWjHQbWwvbzOQ
 Rl6U6eL4smVucUmxSYkvs90Fm7C.jMOn9F9Nb76CJA8GBKOgAHzDvidaI_uSNr9Mvq63AvjZtsLY
 QxbB4vvNb2b.2EwKQSkc4M00qfFl6GYXy56aFpwFPMgSomc4G8VYmNmrJDZYJmLeG.0lANXvof7O
 ceMbc2Wcm0R5ctlr_CNqz1ikCn1djyhHGBcG4RDjNy_tDQs9lk9rJTOEx3tldV0KK797pH7Smod3
 B_U9OoYNWtz25ncIm94AKQjweCZtHoShPNrYDz0wf0kKaZRVWeAnlS636vy6vomKyHd2S43yfzJC
 VmJMN0A84V9FCvV8ascI4gb6R.n.RmLHq7tB5GxFb8y7bLpkczktDMuqk_l0zmaRZg.z0KVZK2Ac
 dU89JdaRHIybeOdKpdeftfjNoDZekqaQqsIMB6c7EHg4b9EHfAb5h_pejAczh_lKspX13tx99SUl
 FpEvzXDk3pKOcL97xJMEseIUF_RVJb4ClNfU4zy7SeMICGOOISSvg_ZngkKbVr5PU4tQ3hKd.h7y
 fVXD4uTWHFvy3StK.jvO_ni8vYafbhEhQDq7tTLQi38oyieS3F4ypjy4XyF8Jd1QUCSE81Dz9l35
 fPqCMRY41WtIi48TLJqr_QAdb920Um4mPyst_uOE7oG8gZwLB4J4dX.3QH96PZ_e8d3lZv54QCHh
 5O3PaKkuQsNVGMHcWHAHec.Rz8DtiYKpUR07Bdj2hU3H6Cj6spC.W0FiSiWtB7l18FCXINMsuMGG
 E3hdK5SBHbIG7Xt4uhYqY1UxU82QcUghUN2Jrc9oBElvVCcKVnvY50AsOCPIajwaV4n1I4AaSkJ2
 SmDb9s9Yl5c9peIP_FOJ1MIETOOOIfw.nHx5SxIkJ6Xo0Dk.Ys6NHuxH0mVGPjOMUmKNPR7p0Jb4
 4yDG2uedoKBQmF5VaocMcnjhF_Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 28 May 2020 21:20:45 +0000
Received: by smtp414.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2db00e875b7cb25914502ab27765bf73;
          Thu, 28 May 2020 21:20:43 +0000 (UTC)
Subject: Re: clean up kernel_{read,write} & friends v2
To:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
References: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
 <20200528054043.621510-1-hch@lst.de>
 <22778.1590697055@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <f89f0f7f-83b4-72c6-7d08-cb6eaeccd443@schaufler-ca.com>
Date:   Thu, 28 May 2020 14:20:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <22778.1590697055@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15959 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/28/2020 1:17 PM, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> Or maybe make it check for something more reasonable, like 100 charact=
ers.
> Yes please!

No, thank you!

C is a symbolic language, not a text language. Encouraging newbies to dec=
lare

	int iterator;

instead of

	int i;

does the language a disservice.

It's true, nobody uses a TTY33 anymore. Those of us who have done so
understand how "{" is preferable to "BEGIN" and why tabs are better than
multiple spaces. A narrow "terminal" requires less neck and mouse movemen=
t.
Any width limit is arbitrary, so to the extent anyone might care, I advoc=
ate
80 forever.

> David
>

