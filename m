Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF00D44787E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 03:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhKHCZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 21:25:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:43331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhKHCZG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 21:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636338141;
        bh=D09j6Et2tmoIoG66YxFPqLC9WuMJxc1MY1FDxXcsbRY=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=COWybPKJcH8JnVIDcp6NCaLgRzI1Ggo+bYJRk27teczT/aKElhLZG8qVOdQ/N+OjT
         lJM2IX6gU7iGMg3tnXVuyvAtMk5vVtagFUnREA6BtK2IfFcpexEEkMtxoQB4ulcIil
         Smgr4eUcyPVJgMgi3Z55vnu118/9aPlIFIJY2Dq8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXGr8-1nEGzS1mRy-00YeEZ; Mon, 08
 Nov 2021 03:22:21 +0100
Message-ID: <a5c2941f-b3df-b811-a8a9-860309b03c32@gmx.com>
Date:   Mon, 8 Nov 2021 10:22:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: FUSE: anyway to return different stat::st_dev inside one filesystem?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u2rD58JpA3MhRvGiZCk61wWmYJavPBpVDMJ1lTqg66lox4IbxXa
 XbO8L2suwYch67fRKuB5qvh2zKd+mgHl+XW5GWlETKj5y0l1TqKpfGD5RU1HuMGJ/BpV60V
 UVZJB12MdxGILxwXGbOfOXOHo6R73y8IGVdwkOrc6XL5M3nGgSeOG8zajEGNpsIOLaepxmZ
 LXygInM/4u7KFjL1L5/FA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uHKMBGI7O2Y=:AtZurqP2pWAuRF/mizkNC1
 4EYDB/w2uCXqletidiU2fG44ZczBfKuoGzqsmE0mKDRQeGTenPTGuQS0AuYkbwJzRUAaTfJzb
 XhzKPgq7nrcg+iaNpfjUeOzk9wDS07FXrvbQ8fLSnAE4EVDliLKC1ve9WlB1jr58thhUONH46
 4gzLZPp6N34UUhb3MzSr16x4eTlcOyUJ6h5zV3PL3FXJFdaY5b8bpd7TB77J2Bra6RX690/HA
 EMiYLbBbD5yMH93aBtHXqqsHjauvC8pg1zvb4ixZNk++Gl69h0OOU+GUAhqQzcZRVEY/HxfQQ
 KUjKJc9tpa3lbK0Kf29soqbiw/WlrEzrIHizuBpKMN5zGaYE/hzuy7KRWeS2PiKpnWhEIPH9C
 9IoGc5Zylo9mnY55susQY5PJ68ykL5uzARm77ChJCsemcC7M+WxYxaOqNE6DHZG6apJmoL9Z5
 wtVf7y7AdBqqG1wGat4OgpzjiaKP4TcsjLaFWSDRPhFBJSB3w256cE2VXhWa3ZiN5J9jrEUXT
 cB0/ETE+4SbTLd8+vcL8A0GjCY35wFx/Wodf2wwrNOZQX8r4VZr87+WRCa/p3jcejR2u+uFbG
 rpiUEnLjSWtSs5A3ZrjavZE9zYUPx1D8F8LFrNDOc07SvDROR6xUaea0YH6Q2XR3bOMNTpNnQ
 Uw/ehFIcqaWPBjeznS+UOiwKK2S4sbHkYR5EWH0t1ntYxxqcu2Tf1XZXTEefWgaAuFAPvQdQu
 72ENppaKIiZWzZ9P+dNdU0Fcjp5DL567Wtnq/15Z2/eijxWr5x9ZG1bhx99jhBlIkTvvPnbXL
 51TdDZBspzyjQuqiyBW/g7oki/7W+gke62hoyrIVRQIXBhPgtwyGrJxaJgxeB9/GVW2bP9wx+
 64mjbSaf+pZhYwPUoxf5Up3PcHNGz3QNIYBPMZfsTZ3622wTzyXZo2UmODcC2yenIO5C5tMfY
 Gn7GHFbvEIT1fYghZLaLcdcU4vXCvk0Mw4PTPLgXMksW3yD1km5S8na8nSSctE0ncQu05cF8S
 RX1SKj2/uDWOgE0nAm/0BNvpxTb7GqmfeVxP/ObaWu1aXKYyeBYs1GEb/E6YjiAO/8E6ZK2vW
 Dcx3C7+E6sdnL0=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi FUSE guys,

Normally it's completely sane to let FUSE manage stat::st_dev, and most
FUSE filesystems are fine with that.

But there comes one problem, as I'm working on a FUSE btrfs read-only
implementation (*).

This limitation is getting more user affecting, as btrfs has subvolumes
which are completely different inode spaces.

Furthermore, all subvolume roots shares the same inode number (256),
thus if user space tool like "find" gets a inode number 256 with same
the st_dev number, it will treat it as a known directory, and skip its
content completely.

For kernel btrfs, it's not a big deal, as we will return different
st_dev for each subvolume.

But in FUSE, we don't have such ability, resulting "find" can only work
inside one subvolume, and nothing more.

So is there any limitation why FUSE can't not return different st_dev?


*: The project is here:
https://github.com/adam900710/btrfs-fuse

The reason I created such project is as an educational project, also an
alternative btrfs reference implementation for bootloaders.

Currently one can already explore the directory/files structure, and
proper data read with checksum verification/recovery is WIP.

Thanks,
Qu
