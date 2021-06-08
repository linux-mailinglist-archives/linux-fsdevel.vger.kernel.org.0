Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0CA3A04A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhFHTvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbhFHTvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:51:21 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229FC061574;
        Tue,  8 Jun 2021 12:49:15 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b5so20975314ilc.12;
        Tue, 08 Jun 2021 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Y/Ff8rqADy27tdtG8Art5Dx6DPCBrcW/tL3HXgpktt0=;
        b=psno8ePBY5SfkME9n0gSPekyG3CTH7C9VbepesuY7XZUMK+DCgVLMDRRCKaamLLvfS
         Jkyjm9BiSuCbsmJm0zYjsQ0jbpkej/ack9VweHIiUgoh6nzgAHSsx7yhXpfW/P95bpRv
         7LTOxrYCXUn9tMeBnM4fuCK2hB3/b0ezZ2MDkiSxGqHZWfTyOEC2ZzFqpQApEYph8H1E
         hVZxhurAZLsNDUvLZ4HksdvMQNMZYTxLy0NtMhJT/KFxGbeaqxdYJ+Zwfts/98XgygJG
         7sMVwEKvRNqAYo505TeE+ioCTXsX3tOo3vGdIx9ZBJYQd5AUZ9gb+IS3+zFRScBSSEBL
         UH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y/Ff8rqADy27tdtG8Art5Dx6DPCBrcW/tL3HXgpktt0=;
        b=bOencN+37CDi4pc5Ps53sVYiDyHsTSJ5SYU6aDV3YswG379LvNKnPCjuVjF/vvOSd+
         NsaOEqVbqUYGOisjAgF6FymMmTv0fB00KT8sQj/+fJJEuXF464kvo4yuh3cgzkmgX9Xl
         fcTLF+/tHnzX6pcA6/hCjDpfB6yR88GplUQ7O+yJCB5lvh+rTYXpZFDfKmtCgSxz9atG
         K0aKi7IYqPLP0uqNTMOy9lex0H2sTAM1++OSxYgSJ4Lf8XEAlt2diL4ykHG/rJ8kMDhc
         m0imZvykIUrdav7YnMnmbEpMQMS5oS7peIMd1ndrvec9qwW96aJzirQbK2Eu4whe9/Zj
         8UPQ==
X-Gm-Message-State: AOAM531mGzOhWxHDXd7BPJDyXk01/2ynf05hrRTTb/B7Kt762Qwk63YM
        km0pIKq1R8sJ5r9CMHUzDl4=
X-Google-Smtp-Source: ABdhPJy+PMyhEWpXEpsvNpPGCVQBatHIrvzsSdUKrFLqHRLAMNNa2f8WzoBxPSs7YBtnXew2RT4+Hg==
X-Received: by 2002:a05:6e02:521:: with SMTP id h1mr3281929ils.295.1623181755154;
        Tue, 08 Jun 2021 12:49:15 -0700 (PDT)
Received: from ceo1homenx.1.quietfountain.com (173-29-47-53.client.mchsi.com. [173.29.47.53])
        by smtp.gmail.com with ESMTPSA id p18sm345041ilg.32.2021.06.08.12.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:49:14 -0700 (PDT)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        v9fs-developer@lists.sourceforge.net
References: <20210608153524.GB504497@redhat.com>
 <8929c252-3d99-8cdb-1c56-5fdb1fd29fc2@gmail.com>
 <20210608192617.GC504497@redhat.com>
From:   "Harry G. Coin" <hgcoin@gmail.com>
Subject: Re: [Virtio-fs] [PATCH] init/do_mounts.c: Add root="fstag:<tag>"
 syntax for root device
Message-ID: <97078f1e-0267-5ddf-15c0-51423e738487@gmail.com>
Date:   Tue, 8 Jun 2021 14:49:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608192617.GC504497@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/8/21 2:26 PM, Vivek Goyal wrote:
> On Tue, Jun 08, 2021 at 01:38:56PM -0500, Harry G. Coin wrote:
>> On 6/8/21 10:35 AM, Vivek Goyal wrote:
>>> We want to be able to mount virtiofs as rootfs and pass appropriate
>>> kernel command line. Right now there does not seem to be a good way
>>> to do that. If I specify "root=3Dmyfs rootfstype=3Dvirtiofs", system
>>> panics.
>>>
>>> virtio-fs: tag </dev/root> not found
>>> ..
>>> ..
>>> [ end Kernel panic - not syncing: VFS: Unable to mount root fs on unk=
nown-block(0,0) ]
>> Whatever the best direction forward might be for kernel patches
>> regarding 'not block device as root', it would ease learning curves if=

>> 'the patterns that set config issue X' were the same across root 'not
>> block device options' whether cephfs, nfs, 9p, virtiofs.
> I think achieveing same pattern for all non-block options is pretty
> hard. There are too many varieits, mtd, ubifs, nfs, cifs, and you
> just mentioned cephfs.
>
> It would be nice if somebody can achieve it. But that should not be
> a blocker for this patch. Goal of this patch is to take care of virtiof=
s
> and 9p. And any other filesystem which can work with this pattern.
>
> I think ubi and mtd should be able to work with "root=3Dfstag:<tag>"
> as well. Something like "root=3Dfstag:ubi:foo". And then ubi:foo
> will should be passed to ubifs. I think only thing missing is
> that current code assumes there is one filesystem passed in
> rootfstype. If we want to try mounting device with multiple
> filesystems then one can modify the code to call do_mount_root()
> in a loop from a filesystem list.
>
> Right now I did not need it, so I did not add it.
>
>> All of them
>> will have to handle the selinux xattr/issue, posix and flock issues,
>> caching etc.
> Filesystem specific flags will be passed by rootflags=3D.
>
>> While by definition virtiofs has to exist only in a vm
>> guest, the others could be baremetal or vm guest roots.=C2=A0 (How muc=
h 9p's
>> other-than-guest transports are used I don't know).
>>
>> FYI (though patching the kernel may be the best option)=C2=A0 there is=
 a case
>> that does not have those kernel panics for virtiofs-root and 9p root
>> using stock fc34.=C2=A0 As 9p, the virtiofs method uses the initrd cre=
ation
>> mechanisms provided by 'dracut' or 'initramfs' to provide the 'sysroot=

>> pivot glue'.
>>
>> On the fc34 guest a successful 'direct kernel boot' today looks like:
>>
>> kernel path: /vmsystems/fedora_generic/boot/vmlinuz
>>
>> initrd path: /vmsystems/fedora_generic/boot/initrd.img
>>
>> Kernel args: root=3Dvirtiofs:myfs rd.shell rd.fstab
> Does it work with upstream dracut or you have modified dracut to
> parse "root=3Dvirtiofs:myfs" option.

It works with dracut and stock fs34 kernel right now by exactly the
three files 9p upstream works with dracut to root fs boot, except
'virtiofs' instead of '9p' in the dracut.conf.d files.=C2=A0 Note it requ=
ires
the virtiofs: in the root=3D line, but not in the fstab and qemu configs.=


re: cephfs Here's a cephfs approach to the problem:=C2=A0
https://github.com/jurashka/dracut-ceph-module




