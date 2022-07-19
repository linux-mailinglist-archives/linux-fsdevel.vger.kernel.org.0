Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C557A153
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiGSOXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 10:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbiGSOXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:23:37 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3AB4BD26
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 07:07:48 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id n206so6880030oia.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=osSTkxJZgJpQ+PpleR38uqX6sr8qSursZWPy8Gnrp3c=;
        b=5y+y11aL9cS10irNQNHyhFUmcki91yUAvNRnUHVQQjaZI8FJ67zeroCwMy8y0/831o
         3HovzzmXdiTc7Ulu8mCPh4Odn+lqgV9msAQyOaoO2kmchswvnug4cd3y0lfu1Zp4R/mU
         qvPRaU6EZNBZKLUiN1OlNlST0MeNu+R2icr7MP9fzpwsOXq6O++mC26QEAYGSsEAtbEh
         UUQV6fildXbvGSSb1c7MhBetE4IxaiJ7v294jkq8/eEZG7kaDBKwQCyZVF3FeAP5Al7o
         H6Q2EDuVjUSGqUqYNK8n0ElWaMCQeIgc2PYJKXOWJl4x079dKrHLDRzBC8CgnJImfbtv
         Wbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=osSTkxJZgJpQ+PpleR38uqX6sr8qSursZWPy8Gnrp3c=;
        b=KzMOUyT3rKpuItcpl3cI4oFPpCa4O0bVKbdO1R1y8dhoW46brtdMsJmfhl+aIdAOkB
         vv6wTybX+aw1c5Ki/jN8dYAMcMre/+NDEWobTUsJQ1gSg7wFTTRLfqJ6PgaM1DoXAVm0
         F7L7kBOPCjCoriyBjyF9WwoUtmGTcQYfEySBsm9NsKzWwbEiQcJJPwL9NITo8iCoP3nr
         Ny8aOMEB4rEsZ3DV5ViN5PlUXuZE61feI3xyt7z0oD5EPCUOF7yj1yO78xY2E2sEaS6y
         25apSODlaEEUWzOnsGTE5IbwAwT7ysVfyeW9zGrQGj8Rn65AfUBHX/78w7RvTshaEuZ7
         vGLg==
X-Gm-Message-State: AJIora9k5aRnl87NYLqS5NAm3MBS1ru57UXiZSJwcTzKxHpB30FPuB8u
        Oui6+iKGem/n8VUJv4Ck8b+LPg==
X-Google-Smtp-Source: AGRyM1sMdBW91AM42YKUQ50RhFP8uiXcWLPwzdBFpgJSeJRd80Ipgmv7NwiofiIh7CRXqiQVJKOtNg==
X-Received: by 2002:a05:6808:220c:b0:33a:2e51:3cd1 with SMTP id bd12-20020a056808220c00b0033a2e513cd1mr15017715oib.293.1658239668225;
        Tue, 19 Jul 2022 07:07:48 -0700 (PDT)
Received: from [192.168.86.210] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id er10-20020a056870c88a00b0010cbd1baf5esm7625192oab.51.2022.07.19.07.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:07:47 -0700 (PDT)
Message-ID: <3d77db23-51da-be5e-b40d-a92aeb568833@landley.net>
Date:   Tue, 19 Jul 2022 09:14:39 -0500
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
 <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
 <8e6a723874644449be99fcebb0905058@huawei.com>
 <dc86769f-0ac6-d9f3-c003-54d3793ccfec@landley.net>
 <5b8b0bcac01b477eaa777ceb8c109f58@huawei.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <5b8b0bcac01b477eaa777ceb8c109f58@huawei.com>
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

On 7/19/22 07:26, Roberto Sassu wrote:
>> P.P.S. If you want to run a command other than /init out of initramfs or initrd,
>> use the rdinit=/run/this option. Note the root= overmount mechanism is
>> completely different code and uses the init=/run/this argument instead, which
>> means nothing to initramfs. Again, specifying root= says we are NOT staying in
>> initramfs.
> 
> Sorry, it was some time ago. I have to go back and see why we needed
> a separate option.

Did I mention that init/do_mounts.c already has:

__setup("rootfstype=", fs_names_setup);

static char * __initdata root_fs_names;
static int __init fs_names_setup(char *str)
{
        root_fs_names = str;
        return 1;
}

void __init init_rootfs(void)
{
        if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
                (!root_fs_names || strstr(root_fs_names, "tmpfs")))
                is_tmpfs = true;
}

I thought I'd dealt with this back in commit 6e19eded3684? Hmmm, looks like it
might need something like:

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7058e14ad5f7..4b4e1ffa20e1 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -665,7 +665,7 @@ struct file_system_type rootfs_fs_type = {

 void __init init_rootfs(void)
 {
-       if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-               (!root_fs_names || strstr(root_fs_names, "tmpfs")))
+       if (IS_ENABLED(CONFIG_TMPFS) && (!root_fs_names ? !saved_root_name[0] :
+               strstr(root_fs_names, "tmpfs"))
                is_tmpfs = true;
 }


> Maybe omitting root= was impacting on mounting
> the real root filesystem. Will get that information.

I know some old bootloaders hardwire in the command line so people can't
_remove_ the root=.

The reason I didn't just make rootfs always be tmpfs when CONFIG_TMPFS is
enabled is:

A) It uses very slightly more resources, and the common case is overmounting an
empty rootfs. (And then hiding it from /proc/mounts so people don't ask too many
questions.)

B) Some embedded systems use more than 50% of the system's memory for initramfs
contents, which the tmpfs defaults won't allow (fills up at 50%), and I'm not
sure I ever hooked up I don't think I ever hooked up rootflags= ala
root_mount_data to the initramfs mount? (If so, setting size= through that
should work...)

> Intuitively, given that root= is consumed for example by dracut, it seems
> a safer choice to have an option to explicitly choose the desired filesystem.

Sounds like a dracut issue. Have you used dracut in a system running from initramfs?

Lots of systems running from initramfs already DON'T have a root=, so you're
saying dracut being broken when there is no root= is something to work around
rather than fix in dracut, even though it's been easy to create a system without
a root= for a decade and a half already...

> Roberto

Rob
