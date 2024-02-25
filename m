Return-Path: <linux-fsdevel+bounces-12712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE5A8629F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 11:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3181F21563
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA43F9DB;
	Sun, 25 Feb 2024 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QdyL4hhh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE24A50;
	Sun, 25 Feb 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708856035; cv=none; b=beY53SHuBGbot85Q5/kD9gN3vGgqVj9ZQBACGxW0zvi9pb4s5OktqVgWD4vKoA6cjL49d519vpdlfjBkrL1hi5+2bAmhRD46OCZV4Z8HubGdQDDH2wl3cFEXL2DbkMEIRz4iH/ki0RD0Ae5gFg1qempgMHPWM8NC2FCz9FvoVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708856035; c=relaxed/simple;
	bh=k16FhWqxIkb2YTFkDE1/tF23+cqblBHTs3vx4rzzstw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d+/QO9AXRKja9uT1jmQj22+jaqq1tu+3C6Tw/6fRwXEcmR0PuXHEzWJLhztvsqBarFDnmdrffVVYPzsxeQIJtomSSX+9yfVfDX9zbaEbGTV5u65SwkL2iOc37RJiDEA58GOlHVZFzb4y1gHQHl3uDBThxfDu2vQVfzy5f7SxEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QdyL4hhh; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1708856027; x=1709460827; i=wahrenst@gmx.net;
	bh=k16FhWqxIkb2YTFkDE1/tF23+cqblBHTs3vx4rzzstw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=QdyL4hhhIcyAi70n2oU1P8iQhO9yCosK2tzjp1VBrUJbeP8HleXQ4/HoaUlqaI94
	 DhPrL7m4jTH3vNTNSuVJI41p1raZwsawO2dHnkQtwel08ePOJF+tdJRr30+6c9Pye
	 xGsQs5GUxeY5Q3HjV+XLTfvE1yva5lbp2qsUxus9ItqEWJb7NhfhiILdUAiYolW0w
	 0DWpCCHR6cisl1SNFzEQbURg39V+iTBcrV/2oMsEH/WMki4+HchSjj3+bNnkKJdlu
	 vF1cIziL0RodjkJZyGJsajUsJ+d3Xa8/xgeYs9J5m+mWl8uzDrKXHNOBfvScJ/WM5
	 d2nNcUuiykzGQXGPWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1rGsOk2mNR-00Pci2; Sun, 25
 Feb 2024 11:13:47 +0100
Message-ID: <f55f2edc-d612-40c0-9822-7d86a940e44e@gmx.net>
Date: Sun, 25 Feb 2024 11:13:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: fs/proc/generic.c:173 __xlate_proc_name
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org
References: <39fe95cb-aa83-4b8b-8cab-63947a726754@gmx.net>
In-Reply-To: <39fe95cb-aa83-4b8b-8cab-63947a726754@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jpOtRrxw+106IrW6klknzVTTu/LI1xSk7yCnXebeBBqzU2NtyvT
 i3URaB/2aZASJGvM85830xfTcFmuD8nnUNHZ04yKdBxcioy1hhK7oeDpjZhzP+F+52X1tGM
 YrMMxYBSsJedmuS8MxWBEZ7FONrbgDh7i6D7ltAFWN/hXPw2CSXE6YvXXgwsVEC0PJuQKw8
 PpHalja3G067s+XUILp/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7bPerityJsM=;jgVBouNgjDbPishgnt3wYrYMRiz
 cO2/gd1Up7p1NC1U5020LyHcNxywwIoOPCaaidIyMUYaHa5XRdAgkaSjNQ7cKHvheaVUbQ1IH
 0skt7ehJEi7usgVIbINp7ugat/6r9Rsu3hZ/xbk41srz1ESyKeHn3w7mj8oAT7WaDB2jJeQHn
 cCwmrw8XSqQGK+eMn3UmklIMeWuIs0oEIpDRbW2Nd8kVF9tdRls1wt+pwLkZ2bnz32OILR6kw
 eikX1cYGmCCTBcK1Pn8RR7hZM/XubgU6uALlsSwl/1UCwet7fEj09XBtjAUU4QswGInvLvQCd
 ZnC/mNqTpHufljhdOG4b24PBUo8mVjeaQUE1d6Wx/7H5ou5QRu4h9deecSBvcK6zsoAgZi5LI
 pHK6XK6DR+lR0WzWgQMhfFu9DZULQYF81HmvOOUGezgL782qHFWdFuNH0ymO0vBBiCYFXFBYv
 nkhe5roTBVdpYrudSVgSq9NBFpNa4Yw20q2BuDpHRHfNyGROC3Q3oiaVhYajLMUsUE6R0TzdR
 Cx0DUCu4ktNFXOgyfu1zKQhgso3NHhfsRThnwAU2DvYZ3mGHlAyb9i2eE1OVKRsNdvhB22aFP
 f2Q+8YQyAeL1xhEAiH3L+hVtZbEsGH44BmqoE0wXxTmil4PWw7wiKuXe7D8f2KOGjBwt06Q3R
 TOaoZFwFq8f6V7N/98LdtNrkX0iIXECXQEjAL5MHMSAy1rI0WpXWN1PwHWKOHKj4fKUiMozJE
 9bP4vL7PiIP7n5kmzhNAHNj51cZPIDFxTgrkTTrx5WdISbk9NMSILLPIlZf7w0UpUZ1T6Z00o
 R7ujKjnHBSe9aRClMdn/jxOy8sQjxi/0pWYOl0/kpIHZ4=

Hi,

[add lkml and linux-fsdevel]

Am 10.02.24 um 11:06 schrieb Stefan Wahren:
> Hi,
> we are using libgpiod-2.0.1 with Linux 6.1.49 on our Tarragon hardware
> platform. Recently we implemented an application which waits for GPIO
> interrupts and we were able to trigger a warning by naming the owner
> of the GPIO as "R1/S1":
>
> WARNING: CPU: 0 PID: 429 at fs/proc/generic.c:173
> __xlate_proc_name+0x78/0x98 name 'R1/S1'
> CPU: 0 PID: 429 Comm: cb_tarragon_dri Not tainted
> 6.1.49-00019-g9dbc76303a17 #147
> Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> unwind_backtrace from show_stack+0x10/0x14
> show_stack from dump_stack_lvl+0x24/0x2c
> dump_stack_lvl from __warn+0x74/0xbc
> __warn from warn_slowpath_fmt+0xc8/0x120
> warn_slowpath_fmt from __xlate_proc_name+0x78/0x98
> __xlate_proc_name from __proc_create+0x3c/0x284
> __proc_create from _proc_mkdir+0x2c/0x70
> _proc_mkdir from proc_mkdir_data+0x10/0x18
> proc_mkdir_data from register_handler_proc+0xc8/0x118
> register_handler_proc from __setup_irq+0x554/0x664
> __setup_irq from request_threaded_irq+0xac/0x13c
> request_threaded_irq from edge_detector_setup+0xc0/0x1f8
> edge_detector_setup from linereq_create+0x30c/0x384
> linereq_create from vfs_ioctl+0x20/0x38
> vfs_ioctl from sys_ioctl+0xbc/0x8b0
> sys_ioctl from ret_fast_syscall+0x0/0x54
> Exception stack(0xe0b61fa8 to 0xe0b61ff0)
> 1fa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 01b019b8 01a9f428 0000000d c250=
b407 beeae888
> beeae880
> 1fc0: 01b019b8 01a9f428 01af7e40 00000036 beeaeb88 beeaeb80 beeaeb58
> beeaeb60
> 1fe0: 00000036 beeae868 b6a88569 b6a01ae6
> ---[ end trace 0000000000000000 ]---
>
> I'm not sure where this should be fixed.
>
since the discussion seems to stuck here [1], i reposted my original
mail to a wider audience.

Regards

[1] - https://lore.kernel.org/linux-gpio/20240213030409.GA35527@rigel/

