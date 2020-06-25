Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C894420A299
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403838AbgFYQGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 12:06:30 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:37334
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389860AbgFYQG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593101188; bh=oDchhMN01CpOJZtCAZO/OHRRs9p+tMsnEbh5aigF5ak=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jlf5bQanE9vuE5d3mm+s5A1aN/b46Ui4U4R4PMKfKgiVqEry5XCl9lJiH+F85oJkyBPT5a3efSqqlY9ModTp7++n/e43gOAXLSxJDQWciryww/ymvA2Ljk9pc//d+64AC9yVZJfe0ITVXM09MDhno8mGKvOcWkaYwBtt1f3+5spHIBpnJNuHw5PjQiqePRr8iAG3NX6Q4aevJ7DEA8rXbQ7BHemX3u/twurVpi3woqNcqLR0e87RwUh5j6qqA6bic1cOR7RXOq00TBXAUKbEWdJiWZ9YL9xaE6S7zDsKUzVlMJ6g3PgQ5OfvMzVo/H0zUacpvA0TsVW2n5xjlPYUKQ==
X-YMail-OSG: 2l4C6zkVM1ll0LGbyMHMFx4ewD933HkMWwtFBPwZ71aw3z769rm_T4k92nbDu1F
 XdMFbPigq0nOJIuxSd18mWOTUesPgcyDbzLlP3ZTDPB1kSi.gNa1tV0dh5wyOfBtSRHCcYkew9ZJ
 1tPNuFNkxEJIPYSKOlcxhdAMenuj2xQ78HznOsTI9MWWarqEJ8CjRbGOKtu3XTpR_ZYAfTSWa7L8
 a.ze6niNFT8XSRWLOflNC49HhBv.QVWrH.vFkqdOjVZrRVcoz_EM1JWjVWBxR40SEJzyqRjycLZx
 ds0SUVO4tCcEtBWCFpm.YZh9Mqbaxj6j9ZHLWch_oYdCY2.hTOP4.WAXTVvTCEfBVDOg0hNO9vJB
 535TI1O6oAKueaS59GPbRpZNSUxP5zbOp9n0c8.LJGSZlYAY1YjfrvYiiSVTxKT9CTtmxGify1ic
 zH6IihDWRs5m54HvhlDATprrCdXIndMk68SqzMgb0AHhaVytlC8UMjW8U7z2PGIjslWmPBQ8D21n
 e3YZ5EyrSmFiA.REUvdJ_HnQby_DD09yGgV1uGohjJp_Q.nhvIb30PSlddwnzRhFrBbEpFLRZX8C
 qDqQmWH1uLISvfILPPMVA1IlM58ypMkfMcKjPRsL4ml1ddPWYYCb9E78P0FskUwK7M0paci1QOn_
 8dFTi3YEZkqjF2qNpXhpqiIKRyRPDZmldb0GCauecahR5k8j_0hHCuL5mtrdPUAqW21vfQOdjIh3
 ZTxscNNsXSaT_QoMAcqcMHiWqB6HgL42OjaoOzVcXtUMInflF0Lvhoys0nSFROlCL7MntmA2AgS.
 OAW_78QDE.xhLvEFg9iKFzl0BKHhKrxts2.GIrF1zlnJKnjtVJrLrnGJI8mdNoToH4gg4ojykn.F
 .yeEYZ5Ky_sZ8HC8l4NtQTjalhKK.nGmHs1dFeVcFls1dt6A08fWaRS5bgkHkAYZxf_57t1qsUG_
 CNP9QQMQzWtRzSTF3_0W9MMwkpKX2EVODHXz_dzURu5HMNdh1SDEwUyJIYwmNmhWXwFE6KmxRrlT
 CvTrQXBpSsZpp3TbH3aNAOAH6pPQmEPoV940KJeVDXgWtwpcC37_.RnnU3Vz_khYIbngankedH57
 PljAllYu9bthWkleFr1DzKvJOJ88wML2NpDJij.aaQxI3S8AhtFsXE6zVw5PD18T5hYNDn5Lrpln
 h_3DVAQgZp6yiaO8AfGW1A9jtKV_WIDm4_1jt7q7qH2_mt8g0ny5eYLSQuBZsVFJAxmpX4x.3eWR
 bOOMYnTV6eBGJlUrOlPQaDcEHf1msBgYeF3c0yIBm7tizBx4cKAS.grMZ1sEbzDkkxmoFn0umuAA
 TJFIEpMF5RSdOhkN58kj8nrU09HA.mmX_.du6e7OFsIdmbCDPB8zh1f33LMgH7Y.t7B2hOUBFJtU
 UhLemXmKNrJrarzduMDZght_7MzVpTA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Jun 2020 16:06:28 +0000
Received: by smtp414.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d87871b7ea49cedfea4258324224237e;
          Thu, 25 Jun 2020 16:06:23 +0000 (UTC)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org>
 <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <CAEjxPJ4e9rWWssp0CyM7GM7NP_QKkswHK7URwLZFqo5+wGecQw@mail.gmail.com>
 <20200625132551.GB3526980@kroah.com>
 <CAEjxPJ6MEb--R=zP_wCh-zgCochgcPhy7Fp7ENTYKB2NH9c6PA@mail.gmail.com>
 <a34cf18a-f251-f4f1-ed7c-fb5e100df91d@i-love.sakura.ne.jp>
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
Message-ID: <a3162d70-ca6c-743a-a542-4112ae9c3da1@schaufler-ca.com>
Date:   Thu, 25 Jun 2020 09:06:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a34cf18a-f251-f4f1-ed7c-fb5e100df91d@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16138 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/25/2020 8:21 AM, Tetsuo Handa wrote:
> On 2020/06/25 23:26, Stephen Smalley wrote:
>> On Thu, Jun 25, 2020 at 9:25 AM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Thu, Jun 25, 2020 at 08:56:10AM -0400, Stephen Smalley wrote:
>>>> No, because we cannot label the inode based on the program's purpose=

>>>> and therefore cannot configure an automatic transition to a suitable=

>>>> security context for the process, unlike call_usermodehelper().
>>> Why, what prevents this?  Can you not just do that based on the "blob=

>>> address" or signature of it or something like that?  Right now you al=
l
>>> do this based on inode of a random file on a disk, what's the differe=
nce
>>> between a random blob in memory?
>> Given some kind of key to identify the blob and look up a suitable
>> context in policy, I think it would work.  We just don't have that
>> with the current interface.  With /bin/kmod and the like, we have a
>> security xattr assigned to the file when it was created that we can
>> use as the basis for determining the process security context.

It should also be noted that Smack uses multiple xattrs. It is also
possible for multiple current security modules to use xattrs, including
capabilities. It's not sufficient to provide "the security xattr", there
would have to be provision for general security xattrs.

> My understanding is that fork_usermode_blob() is intended to be able to=
 run
> without filesystems so that usermode blobs can start even before global=
 init
> program (pid=3D1) starts.
>
> But SELinux's policy is likely stored inside filesystems which would be=

> accessible only after global init program (pid=3D1) started.
>
> Therefore, I wonder whether SELinux can look up a suitable context in p=
olicy
> even if "some kind of key to identify the blob" is provided.

A security module has to have some sort of policy for whatever happens pr=
ior
to "policy load" as it is. That's not unique to this situation.


