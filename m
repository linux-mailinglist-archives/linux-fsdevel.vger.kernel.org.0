Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A443A0063
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhFHSm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhFHSkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:40:55 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C0C06178B;
        Tue,  8 Jun 2021 11:39:02 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b5so20549710ilc.12;
        Tue, 08 Jun 2021 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Haq0YPA4rRTEboTMq/srqauEYHmbuV8PWUShNR4iohk=;
        b=PVKsbw60mkC8RpXyNr0BZLkqvkHsBxGq8GBSWhSy+ExzMC+eOXN7KBfCUcSELnIyxo
         bxhjS54o6cTRBHg+QJDLBFQA1rWktVKtbWGTtSoZ5DfMbblpggDcT1KqA8M1+j11D0iS
         AGrTcueRm3xLrQrA1OXFKFnay53nSIVzda4PDjGhZcSSY9cLcWllfmF4u1abhdhaFUZQ
         C9sUfuy8NA4YsZ2Dmi1XFJ7qCWiXimhiav7dTAj82/ebNM/VZc8C/sYLUjCwx1/cBx7x
         3MNwPs/BMRSreLBPMQnbqYGxaBoeFNAC8nI2dt0KLZccr6FnU7kmuxWE0iDB4Y2S5DXt
         dyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Haq0YPA4rRTEboTMq/srqauEYHmbuV8PWUShNR4iohk=;
        b=ikn6gSrwWgN1O8OFENDIONEmu9l0ApnBIKp5oWVo7d0C2IUnfsccRArpgEwVXHtyky
         ziie1ubE0JgG5y/22BeDjxFT2SXg7eW4QZyV6LHp3xWlEASyFrTauCh45EVa2qqzwOqc
         AeOFBZUmmKMbCMp+QJWA/sFNh5zordSkOpMBDvMuXXanpmpa5BmqP1QEQvbcAEp2wM/A
         bzOViPqAtOd+OaH3yBkly9NGE7cgumzC1gzUpZZcwreWglqHjjaqTTwl3i+IZ1T+upvW
         BhNqTDSDiKC8wWgKC6GfiR6M5rdPzgmc6PZGAnrLc4CPRRSSi2bzKzk1QyRqacuF1uj/
         kdbw==
X-Gm-Message-State: AOAM530VR1xSCT2dNvgUOanlqR4jgH2D9j2pJViftQU10Y36btMJzrNa
        CyGcXaylSTcW7yHDy3FfklOZQq6X51Q+IA==
X-Google-Smtp-Source: ABdhPJy5OrUw7426A3b8pznWY7QtD+fdgLZ+j/BDm/DOlGqGSeEsxK/Hs5B55TnNbmUwVM6aTlBMPg==
X-Received: by 2002:a92:c748:: with SMTP id y8mr244887ilp.41.1623177538914;
        Tue, 08 Jun 2021 11:38:58 -0700 (PDT)
Received: from ceo1homenx.1.quietfountain.com (173-29-47-53.client.mchsi.com. [173.29.47.53])
        by smtp.gmail.com with ESMTPSA id e14sm241164ile.2.2021.06.08.11.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:38:58 -0700 (PDT)
To:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com,
        linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        v9fs-developer@lists.sourceforge.net
References: <20210608153524.GB504497@redhat.com>
From:   "Harry G. Coin" <hgcoin@gmail.com>
Subject: Re: [Virtio-fs] [PATCH] init/do_mounts.c: Add root="fstag:<tag>"
 syntax for root device
Message-ID: <8929c252-3d99-8cdb-1c56-5fdb1fd29fc2@gmail.com>
Date:   Tue, 8 Jun 2021 13:38:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608153524.GB504497@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/8/21 10:35 AM, Vivek Goyal wrote:
> We want to be able to mount virtiofs as rootfs and pass appropriate
> kernel command line. Right now there does not seem to be a good way
> to do that. If I specify "root=3Dmyfs rootfstype=3Dvirtiofs", system
> panics.
>
> virtio-fs: tag </dev/root> not found
> ..
> ..
> [ end Kernel panic - not syncing: VFS: Unable to mount root fs on unkno=
wn-block(0,0) ]

Whatever the best direction forward might be for kernel patches
regarding 'not block device as root', it would ease learning curves if
'the patterns that set config issue X' were the same across root 'not
block device options' whether cephfs, nfs, 9p, virtiofs.=C2=A0 All of the=
m
will have to handle the selinux xattr/issue, posix and flock issues,
caching etc.=C2=A0 While by definition virtiofs has to exist only in a vm=

guest, the others could be baremetal or vm guest roots.=C2=A0 (How much 9=
p's
other-than-guest transports are used I don't know).

FYI (though patching the kernel may be the best option)=C2=A0 there is a =
case
that does not have those kernel panics for virtiofs-root and 9p root
using stock fc34.=C2=A0 As 9p, the virtiofs method uses the initrd creati=
on
mechanisms provided by 'dracut' or 'initramfs' to provide the 'sysroot
pivot glue'.

On the fc34 guest a successful 'direct kernel boot' today looks like:

kernel path: /vmsystems/fedora_generic/boot/vmlinuz

initrd path: /vmsystems/fedora_generic/boot/initrd.img

Kernel args: root=3Dvirtiofs:myfs rd.shell rd.fstab


The xml to pass through virtio-fs is:

<filesystem type=3D"mount" accessmode=3D"passthrough">
=C2=A0 <driver type=3D"virtiofs" queue=3D"1024"/>
=C2=A0 <binary xattr=3D"on">
=C2=A0=C2=A0=C2=A0 <lock posix=3D"on" flock=3D"on"/>
=C2=A0 </binary>
=C2=A0 <source dir=3D"/vmsystems/fedora_generic"/>
=C2=A0 <target dir=3D"myfs"/>
</filesystem>

The guest fstab is:

myfs / virtiofs defaults 0 0

HTH

Harry Coin



