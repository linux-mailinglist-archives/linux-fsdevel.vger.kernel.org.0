Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26A95798B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiGSLoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 07:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbiGSLoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:44:00 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD541D0A
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 04:43:58 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10c0052da61so31289536fac.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 04:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Va7Ue4HqT06P0u8ZRW43Z0Px0BXsVi2YgJ23VtJAGE4=;
        b=gmFEGz70M+E8Ceybb/tf91iagosJh4629EfUTFd5g6M7IY/U61Sb1imjd3ZPEpnUcH
         tFZ+VtRXyXJ7QQX6xctuIbayj1Lc/steGSVVSvV1TAQ4OCUC12MSz4qN2+j4eg14M67V
         EtP5cWAAtRhDGBrvIY7TwdwxJTwxjbbQm3DltE5mC5Q1kYv579w4cxu4DN2WTmSPaLn6
         jypi4VkBvW2XIIMDp1WDe1+wEYoxHGfqJRzFeoiyBDT/ABKOfLkFnK0jDxOfD3MUAZcO
         cD8SEDcHGKzsXc1kuCvNGFVTtnjw5FR0nq0aPjBK0FT4VDYg0kANyA0HOQjvQLxMIWFW
         17CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Va7Ue4HqT06P0u8ZRW43Z0Px0BXsVi2YgJ23VtJAGE4=;
        b=AQ40T2RPQcVCLjpKwggt2nLH3w4RmVMDkZAQ29z+OXRB36+FRpKopDh/+z53gKzCVB
         2wEyHh55BrtEHg69C7yQuCI76Z5cTnIJ3cH+E50TaHbDlhH28J/CAaIs4JTkOLH/XhFn
         7uTrfiO08NkXILZ5KDhM7R4+xMX36JnNV0v+XsUtK++JgzfEe+GIvbzoEXsiW+1oiAis
         geiqUBAz4fWTZdZuoCXpMNyJ19XaMDgb6RfaSKMaMJEWGYIg28iL3+nNV6tFyzE0pGVn
         Xw2nCXgWz0O06ynDF2ARoPEVYBxkHjK9hiCy3MRPKlqhtl2BhRTxJUY2OBxPKyU0Mth5
         nZqg==
X-Gm-Message-State: AJIora9Y/ZEt8SKODBa7x1POowH0i2lFz0l/YQ1my8+XJQF+qOZZn8Fh
        QPA+j/d5U+BdN4e4hf+7DaVL6g==
X-Google-Smtp-Source: AGRyM1tzgD1tJvn/z19AqAkZSQddLk7ZVlnucF2n9u/2w0+Sgiu1Jl5hyMwFQvdkiWIk3dxFDn+nJg==
X-Received: by 2002:a05:6870:2216:b0:10c:f8f9:3395 with SMTP id i22-20020a056870221600b0010cf8f93395mr13624058oaf.257.1658231036685;
        Tue, 19 Jul 2022 04:43:56 -0700 (PDT)
Received: from [192.168.86.210] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id i16-20020a4ad390000000b00435a4c8e3c2sm1415890oos.40.2022.07.19.04.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 04:43:56 -0700 (PDT)
Message-ID: <dc86769f-0ac6-d9f3-c003-54d3793ccfec@landley.net>
Date:   Tue, 19 Jul 2022 06:50:48 -0500
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
From:   Rob Landley <rob@landley.net>
In-Reply-To: <8e6a723874644449be99fcebb0905058@huawei.com>
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

On 7/19/22 01:55, Roberto Sassu wrote:
>> Thank you, I have tested that patch but the problem remained. Here is my
>> command line, I wonder if there is something wrong.
>> 
>> Kernel command line: rw rootfstype=initramtmpfs root=/dev/ram0
>> initrd=0x500000000 rootwait
> 
> It is just initramtmpfs, without rootfstype=.

Whoever wrote that patch really doesn't understand how this stuff works. I can
tell from the name.

Technically, initramfs is the loader, I.E. "init ramfs". The filesystem instance
is called "rootfs" (hence the name in /proc/mounts when the insane special case
the kernel added doesn't hide information from people, making all this harder to
understand for no obvious reason).

ramfs and tmpfs are two different filesystems that COULD be used to implement
rootfs. (Last I checked they were the only ram backed filesystems in Linux.)

If a system administrator says they're going to install your server's root
partition using the "reiserxfs" filesystem, I would not be reassured.

> Roberto

Rob

P.S. Note: there IS another boot option, you can have a pipe backed root
filesystem! CONFIG_ROOT_NFS for NFS or CONFIG_CIFS_ROOT for Samba. No, I don't
know why the order isn't consistent.

P.P.S. If you want to run a command other than /init out of initramfs or initrd,
use the rdinit=/run/this option. Note the root= overmount mechanism is
completely different code and uses the init=/run/this argument instead, which
means nothing to initramfs. Again, specifying root= says we are NOT staying in
initramfs.
