Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02175797FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 12:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiGSKxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 06:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbiGSKxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:53:16 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B074402DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 03:53:14 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id u13-20020a4aa34d000000b00435ac6c3b52so325840ool.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ra5x2/muxSeeSQ3tlCgpeqbladVRxJnxCPl4bJq3p34=;
        b=2lKKxFzSTFfoAqHkPQJOZzk9NSwhvMVfz9AI6037udC8exCOdgmjJTCzLfGNh8TiZR
         juF5/5iF/lwpY0I4eBxOM7ch26XEY1pzvru00V28d56VKmfDdmUC/dvbNUXfD/GneoTj
         e62bDsHZKQ06qjQfN6BdAPe8q7wMqzTya9y9Oxq/85+9tv+FEcRChm48xzwJ+vVtJutJ
         ocu7WYAHxW+9letk5IuqILyJfJ0omA9TYCGqGI3ZW12BP0J1uMrdUw4g3mf6Dnq9iC2d
         KIoG/xTswyWySLrhFnRZ2Qa4cNrCubzn949cy5pGWP6ba+vFmgIdE/fnF+KPaKPeGBQd
         k/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ra5x2/muxSeeSQ3tlCgpeqbladVRxJnxCPl4bJq3p34=;
        b=kGITl3865ORHRhZt9HiaHV2INky4gI1QpuUDS8wkkdzFHFMPaOw0Cwn4FSsfT1lsW1
         6CC8x8okj4QOhMc84j26jtVIFZM+bwpCneE+QtRZuPpUBf0bsjgqhyosOiovHlXGDage
         FULVPn5hVqJ0ueyi1i9ntXFDt3niexXIOQuxIWlVxIQigPBXMWSOISeBQjDlAdMMA+nM
         4OgfUkdpeFttp4j24+VuqJm1VlTEIuSO9TFTthl1KTuFzu102ZSxB5vvC4hrhq66SMuN
         NL6eJM4rr7w1gvw+yFD0ExMIVcLVYgH+tVIfQdIHhkdKQP5cIapaZ3SpNboAlCMylWAW
         GJNQ==
X-Gm-Message-State: AJIora84Fbkt0Nv0kz1pXZtky3i+8vZwaaZZQdGQub87kgv/c1DMZXYL
        QnNT4/G7PBwtWb4m/9IspS6uug==
X-Google-Smtp-Source: AGRyM1skx4r10nH77MIc8HT+KMfyvuczcqHU0I1yhcm68ijpwQjC9CRg6tXM26btMYm29jvYGotkYg==
X-Received: by 2002:a4a:864b:0:b0:425:71ed:ada7 with SMTP id w11-20020a4a864b000000b0042571edada7mr10923632ooh.92.1658227993382;
        Tue, 19 Jul 2022 03:53:13 -0700 (PDT)
Received: from [192.168.86.210] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id cg4-20020a056830630400b0061c7ac52b75sm5901958otb.26.2022.07.19.03.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 03:53:12 -0700 (PDT)
Message-ID: <99ae4aa6-b55a-55a9-e836-b0b483a358d6@landley.net>
Date:   Tue, 19 Jul 2022 06:00:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jim Baxter <jim_baxter@mentor.com>,
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
From:   Rob Landley <rob@landley.net>
In-Reply-To: <f82d4961986547b28b6de066219ad08b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/18/22 11:49, Roberto Sassu wrote:
> Uhm, I guess this could be solved with:
> 
> https://github.com/openeuler-mirror/kernel/commit/18a502f7e3b1de7b9ba0c70896ce08ee13d052da
> 
> and adding initramtmpfs to the kernel command line.

It's initmpfs. You can argue about whether it should have two t's (I was
consistent naming it in the patch series adding it), but ramfs and tmpfs are two
different things and saying "initramtmpfs" is like saying "mount -t ext4btrfs".

> You are probably using ramfs, which does not have xattr support.

Do not specify root= in your kernel command line. If you specify root= you're
saying "switch off of initramfs to a different root filesystem", so it doesn't
make the overmounted filesystem tmpfs because you told it you wouldn't be using it.

(The decision of what to mount has to be made before it examines the cpio.gz
contents, so root= is used to signal "we are not keeping this initramfs" because
that's literally what root= means. Your root filesystem is not initramfs, it is
instead this thing to be mounted over initramfs.)

You can tell which you're using via /proc/mounts having a line:

rootfs / rootfs rw,size=121832k,nr_inodes=30458 0 0

If it's got the size= then it's tmpfs: ramfs basically doesn't have bounds
checking and "cat /dev/null > filename" on ramfs will lock your system solid due
to unpinnable memory exhaustion.

If you don't have a "rootfs" line at ALL then root= was used to overmount and
part of the gratuitously magic behavior of root= is it hides the rootfs line
from /proc/mounts even though the filesystem is actually still there, which is
not something it does for ANY OTHER OVERMOUNT:

  $ mkdir sub
  $ mount -t proc proc sub
  $ mount -t ramfs sub sub
  $ grep sub /proc/mounts
  proc /sub proc rw,relatime 0 0
  sub /sub ramfs rw,relatime 0 0

I've never understood why they added that gratuitous special case to hide how
the system actually works, but it's a land mine you have to be told about after
you've stepped on it in order to understand what's going on. Part of the reason
people think initramfs is so "magic" when PID 1 isn't, we don't HIDE the fact
that PID 1 is always there but we hide the fact initramfs is...

Rob
