Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0D1CB9F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 23:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgEHVh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 17:37:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:37759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHVhz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 17:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588973856;
        bh=WKXXYzFFxdzyYo6IHb1/GDCVJXoS8xMLgI8O9ZwqPOM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W+7cQS3XoSaK8Mh7JgXfIn8XS0J3twN9FO8MZzxw1+nLGCiRohdHclhjWRJumCl92
         3zi+Fa2iqDz9CXOR4kTH7BCkWIz/QL2t9KnjG6mowaqQGPLLdooWTGHQAcKKFdgXke
         MNAK4qxIIABJW9n7R19FkBUVhkNDLditsBPUrmU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.155.246]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1in8gt0hCd-00pcgE; Fri, 08
 May 2020 23:37:36 +0200
Subject: Re: [PATCH] parisc: add sysctl file interface panic_on_stackoverflow
To:     Xiaoming Ni <nixiaoming@huawei.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        James.Bottomley@HansenPartnership.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-parisc@vger.kernel.org, wangle6@huawei.com,
        victor.lisheng@huawei.com
References: <1586610379-51745-1-git-send-email-nixiaoming@huawei.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <e43deb0d-d01e-dde7-b8dc-7988ae38f1b0@gmx.de>
Date:   Fri, 8 May 2020 23:37:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1586610379-51745-1-git-send-email-nixiaoming@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DcAAyHTgrFYd4JxFUyC/egffrU3rAT8QFaZO73P4a2cOpADPFYA
 yc9nQjFVQm6StL3jGxvANz+RjSsZMPvbg8AElCvNEgnjE6aaXzZ6rVPuG7dCphcqpxxjfZ4
 JshwbvrMZB8WfWZpGh6Qq+zWBpYW1wID+hFaRWFT1aalEPGA1i3ZuA+jU8MnLeoqxxkTHgE
 eF5GXL/lA8yRVd1Jvxn+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gowYXBUdlRU=:symO9DH33cb1rA1WMPNKlM
 OQgbIpCk655fBpOMgIxWJJaHt5PECkzFPY2w5Eh4ZlZx80Ew5dZR0sxTgGi/OpBhftpOEQdkF
 Z5dOSQpvtOF12ct/QLmKdjz9bGv6OwCf0CJBObk/ZZJqlJPHq4TWRx+feLPwYAK7OKcG/TnR2
 akFR40Tog5z4xtuHRYP5JXYRVwcOqi44bl8JeTCGqLdQkconyZdiTUETu7EVP2wrCbRiXlkRe
 3Fqa6b//+BWBKKbkj9jvdq8wNOkwKYz3uK5v2r4p0UOjhMg82HSvjlgTOVZTUkAjd42CX+nbH
 X8+LE7UgLlex9OsRy2Z/FykJkh+Sxp0BYDTuUsR5fGOi54M09ddKBmcqiQClSjgdoIehHyJTR
 o6v5HZ/M95bGNOq3kMzkvfQIE2yMwI60Oi1KX7bq5TqatVrPzl6aA3Q5tbLLWN5PVntgz5F8w
 G6xv4HNc1iJ0W52azFi45Pum+Z2Y2qnZ2CWk5jAYheWe7NBxdeu1cExjOopPlMcytYmietbaJ
 rXAwpp7gP9hQJX8UnOr0ov4nTWkEThlXhVJFGw9PVOQZljbtQwTnoCe3By63geKDv1Yr2ikxw
 9NW4qVP8UFV9cNTAXSjuzYda+SvL+8BgfrcBNYT7wNMx3jCGBQTjZcwPkoG8JdUGiDA/KIZWi
 7D3ZIjvzha0XselzXUf8eATq0MYa08upPTeufs6OiWnxvYfg91oIzgtC2hu7cmmtKOXxJ8U6g
 b89w0szykSnWkgc5NYdWmdVMdhIf/NGLH/RFzJ2sD7eAjazhcYAVNJXMNc87tAHKQsEGC3nn7
 EwHNnrINluuvdqTLzE8LFZY4xlDzX4F+5Bk7445qaGUrRhZEUbkys4dTQDSdm9O8fsLLxS53L
 ku6c/aiZKZrY7U/y86Ynhw3VxwZmjLChRrinL9Xk0Ny26xTeSbPh1GqSnBuVXkfAXDpW/vkEX
 uQ4UBuNBpMccVkAt66k78z63oRZ292wa3rDW4oSd6vgzEdV0o9IZbcEDg2L5G6whxwyYPakN4
 /AqfGyi1RXBi8wvL+MD8JeOqkHQvzouw1DcSRi5Fr9joXCafEC2pUmIwoV1CcBFpYMzhfjPOu
 ++rNbGg/+qgZu9QeLO+rDpMGdEjom0/8R53cMWOzt1BmV4nHoadcoXbyG/dwKJyzX59or3qze
 baopV8sx1HpDIuZUudpf2h9uilIWz4A918YGmFwyjqgIho0k/g8NOFyigvPPdQkZV10sAvsxD
 qiTV9FHaQNMdA3ooj
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.04.20 15:06, Xiaoming Ni wrote:
> The variable sysctl_panic_on_stackoverflow is used in
> arch/parisc/kernel/irq.c and arch/x86/kernel/irq_32.c, but the sysctl fi=
le
> interface panic_on_stackoverflow only exists on x86.
>
> Add sysctl file interface panic_on_stackoverflow for parisc
>
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Acked-by: Helge Deller <deller@gmx.de>

Helge


> ---
>  kernel/sysctl.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8..b9ff323 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -994,30 +994,32 @@ static int sysrq_sysctl_handler(struct ctl_table *=
table, int write,
>  		.proc_handler   =3D proc_dointvec,
>  	},
>  #endif
> -#if defined(CONFIG_X86)
> +
> +#if (defined(CONFIG_X86_32) || defined(CONFIG_PARISC)) && \
> +	defined(CONFIG_DEBUG_STACKOVERFLOW)
>  	{
> -		.procname	=3D "panic_on_unrecovered_nmi",
> -		.data		=3D &panic_on_unrecovered_nmi,
> +		.procname	=3D "panic_on_stackoverflow",
> +		.data		=3D &sysctl_panic_on_stackoverflow,
>  		.maxlen		=3D sizeof(int),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dointvec,
>  	},
> +#endif
> +#if defined(CONFIG_X86)
>  	{
> -		.procname	=3D "panic_on_io_nmi",
> -		.data		=3D &panic_on_io_nmi,
> +		.procname	=3D "panic_on_unrecovered_nmi",
> +		.data		=3D &panic_on_unrecovered_nmi,
>  		.maxlen		=3D sizeof(int),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dointvec,
>  	},
> -#ifdef CONFIG_DEBUG_STACKOVERFLOW
>  	{
> -		.procname	=3D "panic_on_stackoverflow",
> -		.data		=3D &sysctl_panic_on_stackoverflow,
> +		.procname	=3D "panic_on_io_nmi",
> +		.data		=3D &panic_on_io_nmi,
>  		.maxlen		=3D sizeof(int),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dointvec,
>  	},
> -#endif
>  	{
>  		.procname	=3D "bootloader_type",
>  		.data		=3D &bootloader_type,
>

