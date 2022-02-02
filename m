Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C654F4A79E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 22:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347354AbiBBVAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 16:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347368AbiBBVAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:00:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AACC061714;
        Wed,  2 Feb 2022 13:00:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k18so840912wrg.11;
        Wed, 02 Feb 2022 13:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7OLSMx2LWSD7WsWcsdtwVZjsVIo2l+VXQLS4NW/dV3s=;
        b=eFLJLpFYFhHEofxCZUnGM50cphxmqi3TKrpCx+wcfetrsnhrHvhxr4vOJE7lYB9ZmT
         /elrTIKpSpkNXbqzxpdrXO2XLx2iEBrHH6xoHjDn+FbU4BKv6zKwNVN21CO+5xc3Q3Wf
         8JKqHd/l5LZtx1UNv6k/TCXVkNZGL6v3a4kNko+voY2evS+gEb46C0pQ8OzSTtQs7eRe
         TnD0irmM9NqYkKyUvBgrOjQkKwLVCIrCjj2Ic8XUshmvRRkPVspCOJU2ZB0Y+O8xoyCf
         aEzKh+7sGJIbiGcAOtsLd45+WZlD/YL3t9Af/XVy46iejsEd+O6bWOu0HMrzUUxWtaaP
         TRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7OLSMx2LWSD7WsWcsdtwVZjsVIo2l+VXQLS4NW/dV3s=;
        b=5tHP4qXhBSqYZV0QAAEf3J2QVGn/2kGyD/AasRlG/uQClMur1NKvQ179+75mPm9lJ6
         SvjWkiMXi77NlkFXgdpItQHIJYzoKFxCj2DAq39ojLJo0+nXgGgxh7cPWPrdTJzCMhDz
         Dj9knsKOAHKNG6y8Pu65HNvH1/dzltQFuP3zsT1dcH3XBCdUVsxBghLMXMs/1BV6m9dg
         qOc90AnW5YJhvMhc1OAByftpV6BUhSpVIRlXFKLuF+Zi7rqSC9xyB92trWZV20bLwqli
         QAsGrxy4tdoRwIw2yyxQGnRfjMhFlRcMyRGCOhLbMuJH88pbcK4nCFCvgt1ow853AwLn
         5/SA==
X-Gm-Message-State: AOAM533gaI2oGgdc6xQDx8jijjWlmAcprRuuGn+axjuSVj1gkWekJJ53
        77CsZxfMGMgpkSOodskLaw==
X-Google-Smtp-Source: ABdhPJzyLbGClv9WiZEVQXQQzzJST75S7NNTUYTVo82rCjZ58Cit08TatZSRK6vgPtbzGK74oumIzA==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr27085816wrs.626.1643835635248;
        Wed, 02 Feb 2022 13:00:35 -0800 (PST)
Received: from localhost.localdomain ([46.53.252.48])
        by smtp.gmail.com with ESMTPSA id j19sm6464929wmq.17.2022.02.02.13.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:00:34 -0800 (PST)
Date:   Thu, 3 Feb 2022 00:00:32 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: Avoid future NULL argv execve warning
Message-ID: <Yfrw8GREVRgN76tF@localhost.localdomain>
References: <20220201000807.2453486-1-keescook@chromium.org>
 <Yfqfo0rbq/B/l6IP@localhost.localdomain>
 <7af32164-dbdf-26f1-1aaa-b720365f9743@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7af32164-dbdf-26f1-1aaa-b720365f9743@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 02, 2022 at 10:38:57AM -0700, Shuah Khan wrote:
> On 2/2/22 8:13 AM, Alexey Dobriyan wrote:
> > On Mon, Jan 31, 2022 at 04:08:07PM -0800, Kees Cook wrote:
> > > Build actual argv for launching recursion test to avoid future warning
> > > about using an empty argv in execve().
> > 
> > > --- a/tools/testing/selftests/exec/recursion-depth.c
> > > +++ b/tools/testing/selftests/exec/recursion-depth.c
> > > @@ -24,8 +24,14 @@
> > >   #include <sys/mount.h>
> > >   #include <unistd.h>
> > > +#define FILENAME "/tmp/1"
> > > +#define HASHBANG "#!" FILENAME "\n"
> > > +
> > >   int main(void)
> > >   {
> > > +	char * const argv[] = { FILENAME, NULL };
> > > +	int rv;
> > 
> > Can we move out of -Wdeclaration-after-statement mentality in tests at least?
> 
> selftest like the rest of the kernel follows the same coding guidelines.
> It will follow the moving "-Wdeclaration-after-statement mentality" when
> the rest of the kernel does.
> 
> Looks like this topic was discussed in the following:
> https://patchwork.kernel.org/project/linux-kbuild/patch/c6fda26e8d134264b04fadc3386d6c32@gmail.com/

The only real argument is "gcc miscompiles /proc" to which adding -Wdeclaration-after-statement
looks like a too big hammer.

Why can't we have nice things?
