Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444A57B8341
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 17:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbjJDPMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 11:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjJDPMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:12:31 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD60993;
        Wed,  4 Oct 2023 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696432338; x=1697037138; i=frank.scheiner@web.de;
 bh=ByYLhXpnCVc0oziLHnEKwRkSwtpuVrnhvzRavzswzdU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NkBLWCu7fOfZn+/PaWN4OZStyodJUU3tPQXi89ieGjOaurIvbbuXi9A/fhzUzhX08bNF972xXOQ
 CBoHTVUQPOFTkLMNwsdbP2yZ8LiS9PbBGVN+UMibY8aUc8HcPF2wrEhkN3uINMORzokTikHTNK1yU
 tmRQN1Qvm2PsIx9bwd8LsfpC/iZUBS8ZhuAe1oXAFDJGNGAAd7qVCW5Ik3dRDb1r/fFySMst1IN9B
 vXoiDYjTiv9JsIQpndPg/XazNu/pHGrKpvDqKpCXcMu+oqDRP2a8LSCQNeC/ePMxAji9OZCtUEBcl
 tCGvOc0yPGuKHXc2P2aBCK/o6K+X6Is6pKXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([217.247.47.162]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovnY-1rOpg40Rt0-00qf4l; Wed, 04
 Oct 2023 17:12:18 +0200
Message-ID: <d43037ee-bb7f-0cdc-a14d-8cddca8bb373@web.de>
Date:   Wed, 4 Oct 2023 17:12:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/7] sysctl: Remove sentinel elements from arch
Content-Language: en-US
To:     j.granados@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>
References: <20231002-jag-sysctl_remove_empty_elem_arch-v3-0-606da2840a7a@samsung.com>
From:   Frank Scheiner <frank.scheiner@web.de>
In-Reply-To: <20231002-jag-sysctl_remove_empty_elem_arch-v3-0-606da2840a7a@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t7i4iRXj7ox8Z/RuUuicukJcy7xvq79AFavFWd524nb4Xnm7o5F
 I8RIut4dhtypXgYqriCKm9tD2/MBfCjX7o0vw3aC8rWh44A1aXnCHC8dLZB+/OZIyxI3t+E
 VUXM3lZBHBofIoQ8AnjX+9kKGwzBF7RRksvy/Bn6D3zn3TN5cU+DskGI6DGRnZOYAxUb1ET
 PdpV2fk2HHaV6NIJajTuA==
UI-OutboundReport: notjunk:1;M01:P0:kd11gdQo25Y=;YvYSXL+cB5uo6ZV2KXmJ8liDLYs
 CFwFCasUfUcPj7WqCtGTKqPh7803BaYtsepK2D5u5+WLuj/LXsXC81UFRPbh/Sy5SNvJ9LNZv
 BrGLiFhwUL2UnSA0soRY1jTHuVqcIwstiX+ij3n2QVsDliFbSSAlu3NnlLu3+BS4BWBsONQ92
 LbZqjJD5YTOkDHNGzDtBU8081+QoVSi+pBbv6GKWrOrAvdQha4zR/+Xx1GtFycPf7g82rFo9/
 8RxpvzoUOUNpwu8pqQbuMnZGsJajJjK15//o8z5KfU8ulNDKc8ymW9RaoyVI6WfC0KNAglycK
 qijyGJ4ew8OgXQdyVOt0V0EC+cpLHZCnuef1KeUHOZCu0sZutH1X4uuDH6lUQQ6Xud1XeWskM
 indEL8kPS3mZECoyzHYxe4KORctXXLQLO9fSpps5B/WkojB62M49j1sn5dFo/mL6idpRXlerj
 CPAFR8lqbcW7WXZ+0z0eXvx6XxE+ozQ6v+bnn/vAI7WhU+TfFYnZ4hAC+J4ZqdTw1XNGv9OwF
 o2Dal6VFGtxM5Uq/+MmqQD9uR6hYnfu2ZN0qNNBItZFQx782TBLywSv4KJWMqjVK3YvyPsUDB
 sE7PLh9SEyaCZJBZxRpvBgkufMxsN3LwpvHmR0aKGurhQPL+M3NhYaTnlcymF4yZhShOKXivk
 RUef8w8fPndFDwftplG5Y7udj3R3lbogyvz9YRGVGLwO3B3BQ3f7DqmVpNhWpRI2af+QwNnui
 vBB6BOtliORraOFfWJK8mnDg7a/UU+y1g/53+X/jnVPGfdfEzmy5O/gZIYX913AdvxYdn0mTT
 EWwn6OvVXq36s2FXz/LpBDZhK3g/jNvYfnrJP6s9zx0F0ceHXs7BdZFunVdvEbnbbocS/Uh4c
 H9rTViPk0pzOuyOQl6w0AmMb9QFptjeMjvZvc7oWx0/M2UR0zt9ZyVl6x+HjIbM0lSe50Pwn+
 +q7jGE+rK7IdHbKZGC2AHjAMGhk=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Joel,

On 02.10.23 13:30, Joel Granados via B4 Relay wrote:
> [...]

I successfully "Build-n-Boot-to-login" tested the following patchset
(together with the ia64 patch from V2 changed to:

```
diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index 88b3ce3e66cd..65b0781f83ab 100644
=2D-- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -232,7 +232,6 @@ static struct ctl_table kdump_ctl_table[] =3D {
  		.mode =3D 0644,
  		.proc_handler =3D proc_dointvec,
  	},
-	{ }
  };
  #endif

```

...) on top of v6.6-rc4 on my rx2620. I also applied the measurement
patch (commented the printk in `new_dir` and uncommented the if
conditional).

I used a bash arithmetic expression (`accum=3D$(( accum + n ))`) in your
script to calculate the total memory savings, because `calc` is not
available as package for Debian on ia64.

There are no memory savings for this configuration.

But using the measurement patch with the printk in `new_dir` uncommented
and the if conditional also uncommented I see the following savings (I
assume this is the same as your measurement patch because the other
configuration didn't yield any savings):

```
root@rx2620:~/bin# ./check-mem-savings.bash
64
[...]
64
5888
```

> Joel Granados (7):
>        S390: Remove now superfluous sentinel elem from ctl_table arrays
>        arm: Remove now superfluous sentinel elem from ctl_table arrays
>        arch/x86: Remove now superfluous sentinel elem from ctl_table arr=
ays
>        x86/vdso: Remove now superfluous sentinel element from ctl_table =
array
>        riscv: Remove now superfluous sentinel element from ctl_table arr=
ay
>        powerpc: Remove now superfluous sentinel element from ctl_table a=
rrays
>        c-sky: Remove now superfluous sentinel element from ctl_talbe arr=
ay
>
>   arch/arm/kernel/isa.c                     | 4 ++--
>   arch/arm64/kernel/armv8_deprecated.c      | 8 +++-----
>   arch/arm64/kernel/fpsimd.c                | 2 --
>   arch/arm64/kernel/process.c               | 1 -
>   arch/csky/abiv1/alignment.c               | 1 -
>   arch/powerpc/kernel/idle.c                | 1 -
>   arch/powerpc/platforms/pseries/mobility.c | 1 -
>   arch/riscv/kernel/vector.c                | 1 -
>   arch/s390/appldata/appldata_base.c        | 4 +---
>   arch/s390/kernel/debug.c                  | 1 -
>   arch/s390/kernel/topology.c               | 1 -
>   arch/s390/mm/cmm.c                        | 1 -
>   arch/s390/mm/pgalloc.c                    | 1 -
>   arch/x86/entry/vdso/vdso32-setup.c        | 1 -
>   arch/x86/kernel/cpu/intel.c               | 1 -
>   arch/x86/kernel/itmt.c                    | 1 -
>   drivers/perf/arm_pmuv3.c                  | 1 -
>   17 files changed, 6 insertions(+), 25 deletions(-)
> ---
> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
> change-id: 20230904-jag-sysctl_remove_empty_elem_arch-81db0a6e6cc4

Tested-by: Frank Scheiner <frank.scheiner@web.de> # ia64

Cheers,
Frank
