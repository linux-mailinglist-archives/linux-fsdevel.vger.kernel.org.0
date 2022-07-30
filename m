Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D795859A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jul 2022 11:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiG3JcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jul 2022 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiG3JcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:32:06 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FA542AE4
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Jul 2022 02:32:05 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10e49d9a59bso8354565fac.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Jul 2022 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VQvaSdst3GlNtIz5gSEbzEWnw6iJp0dnfjX2/uw4Pi0=;
        b=WwZeLQPHVZMv7Tf/yzouYMy/N8ncJHBvNxrLWXHyVtWxdZ1PxHorwX/QP+bQZFNbY1
         rFwGJtpccThotO8bEaWew5690F3KBLjHib7+tV2wpgxvsFLNez3D6LNChyTXqofSjLSL
         3t6mL4NZhitq1h4tRWJkYont7aB4p6WDw3W2nbHcvT//xibau8r6KMdHFoQnG+SQ/3rI
         3j0ybuxX0FIf2CU4lpJxYEwnn2Qs8McUF9hZQ8kDHVp4HHibCyHITaH7wbRaDD6Z8BOI
         nolUx7bNdTsURyp6dA0MSYRIyofqMVotGVXSojpI8bVNj+lPXZDKpcXfE/3CmYrakb10
         Apmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VQvaSdst3GlNtIz5gSEbzEWnw6iJp0dnfjX2/uw4Pi0=;
        b=V4wcO+8lRmoyHhN1PVshM+ycmhlYZPhHDadTd0CTg8xdFOfJda2ZOZ7DNKWy4viLqo
         OECHE03H16KiHuxVxaRzkSaEab1E2WDDIzmnH8QPKa6pF7noo9k1xpgEi00qIIdgB5N6
         eYlyEykk+wq4YU/ugEgoA2Pcm84lm4qCcsGyf61rO3frgdMgZuVrw5LJ/ibME4b8aTDH
         FltW4/tGGbPhgS1nMI4cpO5As6Dl2K5UNi17Nq3f/kwqHTWYcnnjbAJMcPZhDqramYxj
         uoB+zH99R0O6dro0+CA4neypb8i1qT1H6jbgL5veJ60nsaPwaoXuHdu9pUIlSYQHFoTo
         TBZg==
X-Gm-Message-State: AJIora+MDBytPdhB+y+aTrtJYKlNuZhbWJcSTh+onlJjEpS51sqmtzp8
        Rd62YU8QGcg2tDYJh/xw1xZnMw==
X-Google-Smtp-Source: AGRyM1vlzdqQ1oG5qxelDaZGwViNeSWbgs5sytdvECpAolwn1LIlFKm9WBz+/JKkjdUAPx95t1xc6g==
X-Received: by 2002:a05:6870:f2a0:b0:fe:29a0:4b48 with SMTP id u32-20020a056870f2a000b000fe29a04b48mr3309674oap.183.1659173524398;
        Sat, 30 Jul 2022 02:32:04 -0700 (PDT)
Received: from ?IPV6:2607:fb90:c2d4:35df:6680:99ff:fe6f:cb54? ([2607:fb90:c2d4:35df:6680:99ff:fe6f:cb54])
        by smtp.gmail.com with ESMTPSA id q16-20020a05683033d000b0061c29a38b3bsm1633168ott.33.2022.07.30.02.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 02:32:03 -0700 (PDT)
Message-ID: <e850477a-6dd8-0a76-cfa0-bf78951f7281@landley.net>
Date:   Sat, 30 Jul 2022 04:39:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Content-Language: en-US
To:     Jim Baxter <jim_baxter@mentor.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bug-cpio@gnu.org" <bug-cpio@gnu.org>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "takondra@cisco.com" <takondra@cisco.com>,
        "kamensky@cisco.com" <kamensky@cisco.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "james.w.mcmechan@gmail.com" <james.w.mcmechan@gmail.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
References: <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
 <1561909199.3985.33.camel@linux.ibm.com>
 <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
 <1561991485.4067.14.camel@linux.ibm.com>
 <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
 <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
 <20220609102627.GA3922@lxhi-065>
 <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
 <20220610153336.GA8881@lxhi-065>
 <4bc349a59e4042f7831b1190914851fe@huawei.com>
 <20220615092712.GA4068@lxhi-065>
 <032ade35-6eb8-d698-ac44-aa45d46752dd@mentor.com>
 <f82d4961986547b28b6de066219ad08b@huawei.com>
 <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
 <8e6a723874644449be99fcebb0905058@huawei.com>
 <d6af7f7e-7f8c-a6a7-7a09-84928fd69774@mentor.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <d6af7f7e-7f8c-a6a7-7a09-84928fd69774@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/29/22 05:37, Jim Baxter wrote:
>>>> Uhm, I guess this could be solved with:
>>>>
>>>> https://github.com/openeuler-
>>> mirror/kernel/commit/18a502f7e3b1de7b9ba0c70896ce08ee13d052da
>>>>
>>>> and adding initramtmpfs to the kernel command line. You are
>>>> probably using ramfs, which does not have xattr support.
>>>>

Oh, here's the actual tested version of the patch wiring up rootfstype=tmpfs to
force rootfs to be tmpfs even when you specify root=

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7058e14ad5f7..dedf27fe9044 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -665,7 +665,7 @@ struct file_system_type rootfs_fs_type = {

 void __init init_rootfs(void)
 {
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
+	if (IS_ENABLED(CONFIG_TMPFS) && (!root_fs_names ? !saved_root_name[0] :
+		!!strstr(root_fs_names, "tmpfs")))
 		is_tmpfs = true;
 }

Signed-in-triplicate-by: Rob Landley <rob@landley.net>

No idea why nobody else has fixed that bug in the past 9 years, seems obvious?

Anyway, here's the testing I did using mkroot (ala
https://landley.net/toybox/faq.html#mkroot):

$ (cd root/x86_64; KARGS='quiet root=potato HANDOFF="/bin/head -n 1
/proc/mounts"' ./run-qemu.sh) | tail -n 3
rootfs / rootfs rw 0 0
reboot: Restarting system

$ (cd root/x86_64; KARGS='quiet HANDOFF="/bin/head -n 1 /proc/mounts"'
./run-qemu.sh) | tail -n 3
rootfs / rootfs rw,size=121828k,nr_inodes=30457 0 0
reboot: Restarting system

$ (cd root/x86_64; KARGS='quiet rootfstype=tmpfs root=potato HANDOFF="/bin/head
-n 1 /proc/mounts"' ./run-qemu.sh) | tail -n 3
rootfs / rootfs rw,size=121828k,nr_inodes=30457 0 0
reboot: Restarting system

I.E. rootfstype=tmpfs neutralized the root= so it was still tmpfs despite the
kernel being explicitly told you weren't going to stay on initramfs (which is
still what root= means). With just root= it's still ramfs, with all the "my log
file got too big and the system livelocked" and "querying available space always
returns zero" that entails.

> Can I clarify which filesystem type is supported with this patch series?
> Is it tmpfs or perhaps a ramdisk?

I believe both tmpfs and ramfs support xattrs? (I know tmpfs does, and
fs/ramfs/file-mmu.c plugs simple_getattr() into ramfs_file_operations.setattr so
it looks like that would too? Haven't tried it.)

This isn't a modification to the filesystem code (ramfs/tmpfs), this is a
modification to the boot-time loader (initramfs) that extracts a cpio.gz file
into the filesystem.

Ramdisks have supported xattrs for years: they fake up a block device out of a
chunk of memory and them format it and mount some other filesystem on it,
meaning the driver for the other filesystem handles the xattr support.

But ramdisks don't use initramfs, they load an image of the preformatted
filesystem into the ramdisk block device. Completely separate mechanism, sharing
no code with initramfs, depending on the block layer, etc.

>>> Thank you, I have tested that patch but the problem remained. Here is my
>>> command line, I wonder if there is something wrong.
>>>
>>> Kernel command line: rw rootfstype=initramtmpfs root=/dev/ram0
>>> initrd=0x500000000 rootwait
>> 
>> It is just initramtmpfs, without rootfstype=.

The above patch does not go on top of that patch, it's instead of.

Rob
