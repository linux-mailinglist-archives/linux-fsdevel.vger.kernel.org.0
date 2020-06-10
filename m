Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A41F5801
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgFJPlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:41:39 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:41476
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727819AbgFJPli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591803696; bh=dtxSqtVPY2ybgT5BhPPLQbUsOUVJW6lssrSsJKQm8b0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=FpdH7o52UjwD1GIAcGfWT/vMjrPdAYIM5ygEDNh0wsXTzvlGspmFr4lj1CGnHDJvs2rl0s+uoAOSv/wzeBC6Zy9pGUziZzgxSj86pwO0BofLbmCDUtashifdUmh4UzROjOPYcHSVqprKi9W9Fma1fave5RI5aRXUVEVGTuvZkD4fhFfEX9BtcKb9EglOSEkaCKp4DXRtHeh+DOpWYfvh6wDcgEAZAFsEK8Yr2tXveOMF4lUNfdF4jpQYdH0gS9wWPPn+KYR7ZVWEav0XGcHCpNfsWs/c+cHot5fPZKtLr73QPYODYUCDHmPdcc2m1tMt5FA5QagthRDWTTHWVdsASA==
X-YMail-OSG: 4GDb1_UVM1l48d7LU09Q7Rv2NO94pXpOcS2aMO3jhv9wnYVYdR0xRV2rQ8D2vj7
 MZvRVHRwDY7UKAEn87V9TFqAc7PZF1Ar2sN8_oRRBjhwxSx1Jty9nX_ga4QwoVHujHReHeeH5zM.
 W64TXimg24_tjQS3bCnHBy3pXHm_.ig0mxsgDNZ9pWBLYWupBysOgYNz3aTj0LcL9m49p80jDGR2
 yv81Nz21X1mxf8KQBFOva04VGTEshNMVsH5qt3XE2fTFpjWAJv7nxy6Q.TWHuwHgt7DxNhSDaijY
 jm4YSPT._NbcutCM7dGN4aT.oJf6tRir4fbyZQYprIzC97OKDWlUFA.hve_XNMbUS7kt_XICpjzN
 36rweFfvM.tDuf2b3ahWJo_cAt4vA7BB1H9fw6vpMojZgEB00MJcZjs_8jlIxUB1vxKQElKR8ApM
 m50PXlvAeIw0VSUBXREtnTGZkk2B.FLkETElURcoyF2fT1gNMjAQV4oRhp.EZSm0TUChOqM07YQt
 wRWQ9VK0gsB2PC.q05PtwPAa7xBDpr0AECHLgwNz5JcOpRulFszv9WqkPjssR2LOjOAwRng9CxYH
 DpO4hLTMuaevfrfm_SJJaV0o0r3fR6KThfhlzqWBdyMgRNnkvvTn0W2B3F00CF_JJk6EfLoKI26M
 aoi5FfvRkPV97sOSiBYe6gEWwmSl9Q.KtfobSVK2ldPJNTDOiACzb0nMNLb1Wy0itI0VC9.nEjX9
 OlvVlxrMQXUB5RPAexbazl3DxBAeKURDvwdPCluFCkpORm0E2QuVZpT_rr7O0JdBRtZYLz04rncb
 x1gXC8yUwmCbxVfEutOkvj3jt1vdpeP9J5CM8EmVthAjQwzQqhvIesdVWi3yxkLTxfBXg_jtsZoX
 g65gL5NyaESD1SapuyRxMGLXxIv2BcN3i7z5OJD2vM4kLncNDzNVc7NjMuE2AHnhfiCUpoDtnOmO
 UErP5Mu0uT7obx4vLcHWbTyNx6Cm3Js6aT.VH9R90gBWNfyOrf7VMTiEq2goKCRoYlqsHbkpTU8v
 gyxT7tO7BWAhFc0gOTVQn2SBdtZ9u0u_jZ7_6tindXMlgUeI2C7cTcABdodBaekfW9_sPVVViQA.
 2_HuRUBp9J43BnaNYm1ZXkU5zCmRd8V_IBNcKPdgFBQ36TSMD1kNA_uLi2LtE3tG5E2tQaY7zlAh
 evCaikN4.al5VlVSypOBAx.aXJxU048WL90bqTlmG6RBURicHeUMsqftJMe9GVjWmSx13adspbrH
 tp4nPaceZTsUppw7TUkhF8a43S54tPKh2nS7hWmXtgshOVMNAsvxZhpp9X_N9WcmxK_7BguBfjIk
 FLT9DneNJXVeUxQMnVT7z51n9Xb63CscpD2ge6QgaHJstLiICGFHbROn3ILwZb.ApWlKvEiBV4jz
 TOaeXyH4YLsNahtORTpX6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jun 2020 15:41:36 +0000
Received: by smtp417.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b1c42b13e2ba96e7a3e09345eb0d59fe;
          Wed, 10 Jun 2020 15:41:32 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
To:     Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com>
 <20200609034221.GA150921@gmail.com>
 <20200609074422.burwzfgwgqqysrzh@wittgenstein>
 <20200609160627.GA163855@gmail.com>
 <20200609161427.4eoozs3kkgablmaa@wittgenstein>
 <20200610075928.GA172301@gmail.com>
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
Message-ID: <37b47c7d-a24e-c453-5168-c383e6c36c9f@schaufler-ca.com>
Date:   Wed, 10 Jun 2020 08:41:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610075928.GA172301@gmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16072 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/10/2020 12:59 AM, Andrei Vagin wrote:
> On Tue, Jun 09, 2020 at 06:14:27PM +0200, Christian Brauner wrote:
>> On Tue, Jun 09, 2020 at 09:06:27AM -0700, Andrei Vagin wrote:
>>> On Tue, Jun 09, 2020 at 09:44:22AM +0200, Christian Brauner wrote:
>>>> On Mon, Jun 08, 2020 at 08:42:21PM -0700, Andrei Vagin wrote:
> ...
>>>>> PTRACE_O_SUSPEND_SECCOMP is needed for C/R and it is protected by
>>>>> CAP_SYS_ADMIN too.
>>>> This is currently capable(CAP_SYS_ADMIN) (init_ns capable) why is it
>>>> safe to allow unprivileged users to suspend security policies? That
>>>> sounds like a bad idea.
> ...
>>> I don't suggest to remove or
>>> downgrade this capability check. The patch allows all c/r related
>>> operations if the current has CAP_CHECKPOINT_RESTORE.
>>>
>>> So in this case the check:
>>>      if (!capable(CAP_SYS_ADMIN))
>>>              return -EPERM;
>>>
>>> will be converted in:
>>>      if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))
>>>              return -EPERM;
>> Yeah, I got that but what's the goal here? Isn't it that you want to
>> make it safe to install the criu binary with the CAP_CHECKPOINT_RESTORE
>> fscap set so that unprivileged users can restore their own processes
>> without creating a new user namespace or am I missing something? The
>> use-cases in the cover-letter make it sound like that's what this is
>> leading up to:
>>>>>> * Checkpoint/Restore in an HPC environment in combination with a resource
>>>>>>   manager distributing jobs where users are always running as non-root.
>>>>>>   There is a desire to provide a way to checkpoint and restore long running
>>>>>>   jobs.
>>>>>> * Container migration as non-root
>>>>>> * We have been in contact with JVM developers who are integrating
>>>>>>   CRIU into a Java VM to decrease the startup time. These checkpoint/restore
>>>>>>   applications are not meant to be running with CAP_SYS_ADMIN.
>> But maybe I'm just misunderstanding crucial bits (likely (TM)).
> I think you understand this right. The goal is to make it possible to
> use C/R functionality for unprivileged processes.

Y'all keep saying "unprivileged processes" when you mean
"processes with less than root privilege". A process with
CAP_CHECKPOINT_RESTORE *is* a privileged process. It would
have different privilege from a process with CAP_SYS_ADMIN
(the current case) but is not "unprivileged".

>  And for me, here are
> two separate tasks. The first one is how to allow unprivileged users to
> use C/R from the root user namespace. This is what we discuss here.
>
> And another one is how to allow to use C/R functionality from a non-root
> user namespaces. The second task is about downgrading capable to
> ns_capable for map_files and PTRACE_O_SUSPEND_SECCOMP.
>
> Thanks,
> Andrei
