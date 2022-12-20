Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42B6527E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 21:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiLTUcf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 15:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiLTUcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:32:01 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2E51F636;
        Tue, 20 Dec 2022 12:31:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1671568268; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=AIc5uaO3ypMUPMx3xjmDnPW1UDmslbJttmZf8L9NU0Rz/6VVWPKkgAEWv3NPmNesImnjkCeRz4KDUa+DVGs6hX5NiU9pG6M/XNvx1Sp6Dq20nRixmbCfF1DoOacIqPdTILOkieMWF63xXt7rL7oIIN2Vz15snr3Z44CWLNIaLiY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1671568268; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=MwpXKEJAPVR+byJdB5oIAwS4ZE/NgA8mrHIQ8L3UdxQ=; 
        b=Ux9m/rWxrQPC7m1Ld/p7XMtM9JMX9vmfduafJjBQ1y9+yey+IvWO/H0lXOAJd8cRzf7LOhJrDyBIKaznzSkMo3zcD6Eybu5vmhb2lmDddSV7v0omfUfPg5wv5u9IZuLNlGYko9CIPEYY6BpvpRknvCNqWxjx6agJ+jwRYHGFyvA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1671568268;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=MwpXKEJAPVR+byJdB5oIAwS4ZE/NgA8mrHIQ8L3UdxQ=;
        b=jTOmAqMexqMX0S9XtrQ0BdGZgCbmPtk17u9NJNA6oiASBgLqsDtF/q2Snd9kWygq
        IuvLnUMDLT2S6mXgiWHyQcxnqOJw6EkFWVTgnGjNenBoA+6PTzw3oo2YuyHnpm+D+lj
        vY839xcFVCpIZFmYCpUOutOOYfLnt10UwKM/ZnVQ=
Received: from [192.168.1.9] (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1671568266792170.31739805186044; Wed, 21 Dec 2022 02:01:06 +0530 (IST)
Message-ID: <9e1390c5-844c-9fa5-693e-da9d10c64e21@siddh.me>
Date:   Wed, 21 Dec 2022 02:01:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Siddh Raman Pant <code@siddh.me>
Subject: Re: [PATCH] selftests: Add missing <sys/syscall.h> to mount_setattr
 test
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftests <linux-kselftest@vger.kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20221201150218.2374366-1-daan.j.demeyer@gmail.com>
Content-Language: en-US, en-GB, hi-IN
In-Reply-To: <20221201150218.2374366-1-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01 2022 at 20:32:18 +0530, Daan De Meyer wrote:
> Including <sys/syscall.h> is required to define __NR_mount_setattr
> and __NR_open_tree which the mount_setattr test relies on.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> index 8c5fea68ae67..da85f8af482c 100644
> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> @@ -11,6 +11,7 @@
>  #include <sys/wait.h>
>  #include <sys/vfs.h>
>  #include <sys/statvfs.h>
> +#include <sys/syscall.h>
>  #include <sys/sysinfo.h>
>  #include <stdlib.h>
>  #include <unistd.h>

Tested-by: Siddh Raman Pant <code@siddh.me>

Though this oversight actually led to gcc detecting another
another error [1], as it entered the #ifndef __NR_mount_setattr
block.

Thanks,
Siddh

[1] https://lore.kernel.org/all/20221211092820.85527-1-code@siddh.me/
