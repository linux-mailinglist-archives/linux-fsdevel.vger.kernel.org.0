Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF22358CA13
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbiHHOCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 10:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiHHOCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:02:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B2E0AF;
        Mon,  8 Aug 2022 07:02:15 -0700 (PDT)
Received: from mail-ej1-f46.google.com ([209.85.218.46]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mwfj2-1nSnnA0iPS-00y8yM; Mon, 08 Aug 2022 16:02:14 +0200
Received: by mail-ej1-f46.google.com with SMTP id i14so16780530ejg.6;
        Mon, 08 Aug 2022 07:02:14 -0700 (PDT)
X-Gm-Message-State: ACgBeo1ziLCAzM7ozxXEF1rdjbouTD7Z22m3whQlKpDi7UzfxX30WDUN
        n39TE7T53yVKulLPa6tdu+pZn1dkRUMJQx1pouM=
X-Google-Smtp-Source: AA6agR5qgiyoSGZBBKVGGI6L8F9F58ARv8LUPdh3d+FcET/dzkcrREdLKsYZsK1B6EvOzT85cd8K4aaK1HO7s1uRGvQ=
X-Received: by 2002:a17:907:7395:b0:730:b636:2c89 with SMTP id
 er21-20020a170907739500b00730b6362c89mr13943270ejc.547.1659967333768; Mon, 08
 Aug 2022 07:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <163410.1659964655@warthog.procyon.org.uk>
In-Reply-To: <163410.1659964655@warthog.procyon.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Aug 2022 16:01:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ZNbmND-TPLEmc-37ZmK31pOT2+hDhQD+HWQZyXFZX8Q@mail.gmail.com>
Message-ID: <CAK8P3a3ZNbmND-TPLEmc-37ZmK31pOT2+hDhQD+HWQZyXFZX8Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] uapi: Remove the inclusion of linux/mount.h from uapi/linux/fs.h
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1reflZM1aKn3EqKV2wtpAFNNyOuaYsSRArZwiFPIJiG2MRgtBgZ
 pKnqPzexya65U7wThtAsuWNVQUTcKwP3VgWZGINf1iAEhgRBChXvXTmctN0XHgLp/i7v52H
 Cfw/xMhzLSMBZJGKcFlrhf3JUJTGXwiOJladLDaUk3fCXi1FdSokdjlYJm/K2WvDf5B6YwX
 CN3LchDPQdgnmNhrGxufg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bIGL7TTs/Dw=:ALnb+EAd32wsDMBtVCqNB5
 5IpF+pVJvEOLFeYzryC8lo3wfPJjHVP4eyq9iKhtXW9QGjA1hJDRmipPaAraDJScB2IixGG9R
 CJm1C45YWeMEuxHhvj7osYyAowo//cQrIkQAQ0No4MnO7tCTnQNDnL4w05updue12zRDpBJgB
 HbOx9Q45PhWLVg903VO6A+MSqzyP7CcSIwrcWohUYaEodkgwfK0a94HGQRHCRjteaGs/RJvQ+
 C9jR/dCiBif19Ofi1zBgOewi/J4poghpPVSmoRlDwg10H5QhC7Fh69VcNjeUT9Qb7B8/52BJ/
 HST3GWnIZFo9+D6hNiRRGchB5VE5iuflT6518nSslD1rci0g8Wj7LPQ1myxTck4TPJmKGJc4b
 rVAs7jkfwID120dp8hzD+7kwya5GOP/HWUY5L2m3oFyurv/+GyP00qKa7AXgrKC0eVA/YmsGu
 7v1P2lHzUldW8lX3iORu1qinPyfcECj9twgcsgUTJvWDHLEwSGZo1xupx5329lhAQoezRDygg
 mM2jED/ye+a4I+ucIkroUFJGZDgHw+uVyOpLniY17Hu5/4pWDpqv7Ntbp72364MAmV6aOIjmz
 1pqPqkxXCRywPjm0QVz88mVfAzJxgNZaDUFMmPdZWaBTNFPUWriOpUt/2rKnjNB/bdt02RXB7
 ATLbW+MQSOwHPQ3WTUg2A63wOBrieEQMSyeEMhPpJJEpa0KjO1HquksYGj9JArZQUTpper+oC
 WRp45cdgxHmm8rp0r/0nuP+jd370ZeHMZxqrFQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 8, 2022 at 3:17 PM David Howells <dhowells@redhat.com> wrote:
>
> Hi,
>
> We're seeing issues in autofs and xfstests whereby linux/mount.h (the UAPI
> version) as included indirectly by linux/fs.h is conflicting with
> sys/mount.h (there's a struct and an enum).
>
> Would it be possible to just remove the #include from linux/fs.h (as patch
> below) and rely on those hopefully few things that need mount flags that don't
> use the glibc header for them working around it by configuration?
>
> David
> ---
> uapi: Remove the inclusion of linux/mount.h from uapi/linux/fs.h
>
> Remove the inclusion of <linux/mount.h> from uapi/linux/fs.h as it
> interferes with definitions in sys/mount.h - but linux/fs.h is needed by
> various things where mount flags and structs are not.
>
> Note that this will likely have the side effect of causing some build
> failures.
>
> Reported-by: Ian Kent <raven@themaw.net>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Christian Brauner <christian@brauner.io>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-api@vger.kernel.org

I think that's probably ok. Looking through the results from

https://codesearch.debian.net/search?q=MS_RDONLY
combined with the list of results from
https://codesearch.debian.net/search?q=linux/fs.h

I found 95 packages that mention both /somewhere/ in the code, see
below for a complete list. I did not try an exhaustive search but found
that almost all of these reference the two in different files.

The only counterexample I found is

https://sources.debian.org/src/trinity/1.9+git20200331.4d2343bd18c7b-2/syscalls/mount.c/?hl=13#L13

so this will likely break and have to get fixed to includle <linux/mount.h> or
<sys/mount.h> instead of linux/fs.h, but that is probably acceptable.
There may be others like it, but not a ton of them.

      Arnd

8<---
android-framework-23
android-platform-art
android-platform-frameworks-base
android-platform-system-core
android-platform-system-extras
android-platform-tools
apparmor
audit
avfs
bazel-bootstrap
bcachefs-tools
bpfcc
busybox
cargo
cde
ceph
chromium
criu
cryptmount
docker.io
e2fsprogs
elogind
emscripten
falcosecurity-libs
firefox
firefox-esr
fstransform
gcc-10
gcc-11
gcc-12
gcc-9
gcc-snapshot
gfarm
glibc
glusterfs
gnumach
golang-1.11
golang-1.15
golang-1.16
golang-1.17
golang-1.18
golang-1.19
golang-github-containers-storage
golang-golang-x-sys
golang-inet-netstack
hashrat
hurd
icingadb
kfreebsd-10
klibc
kubernetes
kvmtool
libblockdev
libexplain
librsvg
libvirt
linux
linux-apfs-rw
lxc
manpages-l10n
mergerfs
mozjs91
mtd-utils
network-manager
nilfs-tools
ntfs-3g
ocfs2-tools
ostree
partclone
ploop
qemu
quota
rust-libc
rustc
sash
snapd
strace
stress-ng
suricata
systemd
systemtap
testdisk
thunderbird
tiny-initramfs
tomoyo-tools
toybox
trinity
u-boot
uclibc
umview
util-linux
virtualbox
webhook
zfs-linux
zulucrypt
