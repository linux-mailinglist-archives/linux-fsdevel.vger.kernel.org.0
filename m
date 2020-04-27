Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100E91BA9F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgD0QSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 12:18:49 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:40249
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgD0QSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588004327; bh=63tDCXQ4d3+61/OGW3S7mVOWRy3GargmMKYOqYpaPWo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=RzNX4KUf6BZIfe4sMw7mm/PaJvF1QUtBAGzCUyDPL+YOD1oI0AZRsJ9RwuejZBtOeeZVRcBumKaACT6UU2L22udsX4DQIlZgED34UO5Fg3GBf9pWdKkFXvs3GkI2ncteaDnwADThOE5H7DpnAQu2uLsEcQEeoq9SFz/cqODerVqCsQ+nifoVY0aJ+NieBfc+P3quyr/JD5H7lPDDNHd+creOE6IUirTEGsrNrh6TGt5FYjMo+dn8BqHWCPPMRdq5Sy/BdFI0muiF6X2Q6yAYrtErUCWM2E05YUIA8gmvMMPZpykog2b1n1LhXeAFCpHJHryRXdTYamH/7RKh8FStvA==
X-YMail-OSG: GZ1qFv8VM1lloMwOeiuwS_DLZMlZS596z_T5Ezam5JVYK16xQKQqGgbpCWLb2nw
 dJEvdcljCn0NiQ6ginYhlcMXj5NvyGh1fiJBTE0_ILqLT5lkHR_lLmj9fs_T5xGazvv7dad.dBKH
 629bTpGIgztRfTBAONGXm9sWvrBH6IGWenZF4jT4hI9AwmBqZii70US34pgShjXO9fmAMkwh5qAX
 kFbLNnLB_PywIzJygwsu2ts59DVgAU5BTxXdh4nS6B7nDOj84phyL3Jietqqe5SIyA_nd.PO8p42
 sOfsmUZRg1c.kS4lqMXGGFId1g5t30fyhj816egHJn0NnYxQdHZ56PxwUrY50E16Cnel50aETquU
 WF1KRaWFFmeU2gh5oIZzoV421i2bpe5DmLBG7ilCQyZCHn5Q3uoVPrAu1Us8.hRQZ6ZlNA2m7ai3
 Bk6tPkCDzrSthL8iH9F8h.CKnYSMNgZrzJePQDKz5sv0nmVAEEHsYMqtsC7_CcLPBk4zcpeS1Wca
 DplINAdBgrydIVgCuHT3uk0IN0ItvEthNy3mt83cPM2l6X6XhnYm.mrjIiykR5ZNqgFeoTAr0HC7
 3R_nve23tPOh7bLsISYqNxi1PyRrvSRDmbpebY9_oLgeLe235P_iBUCn.zmmxx8nJJTJAvJ_mYgN
 q4pDzc3opQFpZmNWtYA1c3OFDbEB6qhCLzu4AyY6C2Kl.QOSkQatVdTwSn3LMOU6DbLzUIa_W.Ie
 tzt2IOZIKFF.HdCz1efogWd9GQWJwfTeKs_IlMo5Bn0sxmATPTq.0zTMzWqvnn2cZnLX0fQi077k
 TJbItAkMMuwDRUEOoegATu5cRz4m2c7WwKYVky10R6inprsdCzeLO4.rvp3B8HrrLR3QSc.c6n2j
 gO.3wEwFNn.zLB1LNY1ocEd_XPO3DVvsX_0xsunAiLb8MMeDDfaeVfVK.MZmjKxr0KHRelOJId5e
 OVfFn4yVt9EDY5H2.88VVkc8p2ial9NJv6VUPdAESIbuIdglKY91PZ4Da9kMlrXubptTPSbv7Qg1
 OUe7aIWREJ4_F597pMzKGplgaXdgE91RfZ1Mm2m0QTgwfjNIG0KU2NPIIBAitrWHRqEdDudvIzDH
 orNscbu.BIIJRLwn2c19VAp6VS7Nr9XUas4Hfe8ask8TZ3yFC05oVdSzmnVSd.sCFOIabuzqztjk
 Wz00Xj377CdA6eyi2YWp3Mz1LEScGoR_O.enIIAyjCLQglN.iixKo.hN.TFrjlb9UyEOhLQBUiiE
 BFQiZwg48QzGhEtvPwCiqqwZ6wCgaRz25LTyDHPJDJ0ktyMGXVbfUQr2LrpjPrOZL9t4tFL8DnZ2
 YIIJUmHu.TWdXohpmQe6Pdlgxd9SSi0Nk4QkThj2aAQssPBnwiYvJ3SB._hPpGxCfqtj7Zv728EE
 xzVPL01cyTSytuTx2zLMhhQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Apr 2020 16:18:47 +0000
Received: by smtp431.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 990e53893286a3d1e8f5702abe246841;
          Mon, 27 Apr 2020 16:18:43 +0000 (UTC)
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     Daniel Colascione <dancol@google.com>
Cc:     James Morris <jmorris@namei.org>,
        Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200326200634.222009-1-dancol@google.com>
 <20200401213903.182112-1-dancol@google.com>
 <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
 <alpine.LRH.2.21.2004230253530.12318@namei.org>
 <6fcc0093-f154-493e-dc11-359b44ed57ce@schaufler-ca.com>
 <3ffd699d-c2e7-2bc3-eecc-b28457929da9@schaufler-ca.com>
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
Message-ID: <8bef5acd-471e-0288-ad85-72601c3a2234@schaufler-ca.com>
Date:   Mon, 27 Apr 2020 09:18:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3ffd699d-c2e7-2bc3-eecc-b28457929da9@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15756 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/23/2020 3:24 PM, Casey Schaufler wrote:
> On 4/22/2020 10:12 AM, Casey Schaufler wrote:
>> On 4/22/2020 9:55 AM, James Morris wrote:
>>> On Mon, 13 Apr 2020, Daniel Colascione wrote:
>>>
>>>> On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
>>>>> Changes from the fourth version of the patch:
>>>> Is there anything else that needs to be done before merging this patch series?
> Do you have a test case that exercises this feature?

I haven't heard anything back. What would cause this code to be executed?


