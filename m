Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAB138B243
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhETOyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 10:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhETOyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 10:54:39 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E6DC06175F;
        Thu, 20 May 2021 07:53:15 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4FmCQv2txyzQj8f;
        Thu, 20 May 2021 16:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1621522388; bh=P8MrA8pPpf
        BNVWmYRRfh+GiMlhTG+PweVmx43zpGaHU=; b=Wi9GzXp7kBpjsfj+eBh5xGHv4E
        u1wAZcgP4eEZk8bLvG5JxNBE0XIYCsPGSAH+JIphAB2DRgOGKd1sx6BXxbJZGnTY
        SmBifwoyGIyH93M2FPYEeeVeS33z61wmhI27Pe2yuDzkzB3pB0t8MYUOsxYC1vBh
        sBA4IF3LsZMGbfFhioj8LSHPP0M1wFKGynYFGhk7rldB2ubdinS1modLn4g1CfXa
        +E2XcAw8dYMuLXP0vJ/aBW7AZVS/jEcgyyhTkIpKXE7ix7XirymCaTkK5PfoqEpC
        vWnRJ3L41OuwMHCXhWNS1DoeuXjJYM5EBAak+hS8iUfgf7T+R+D7TcL02z6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1621522389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twfdgMKvq+qZu+1IFRTbYX3i4ggeYR+hsqTGbJOWG9s=;
        b=eEhTc//ZDnXzuSfh7tIVl8HnqNSF1SnIiThtNvXF7xw1kNKSXuMIAqiAlweP2pmBnhn0xt
        J8mTPOzx6m8yEdxyM7pnjS8rElSV0Nz77XU6gQyCDC3gGXHP9tbolUbBTLhmE0YN0Zj7j0
        1nLj/2/91f4uKhqdxAAV06QD+Cm/l3mJlRa6oJUSnYN9azP+L0DdFcveBZho3e8mnJFcf+
        vD4DhjIx37mQDRo3lCh4vlyTzzbxLlQEKLw6XjJmWeLkZ5le3CyXhq4GUrH/d1P8QZ1JoF
        dnpZqZX8jQmbrpZ3VYAqKHsRrMElCwdRq1Jsc3bw6LZVROPxaAeovr6aIaXOoQ==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 1eLjRH_01cFl; Thu, 20 May 2021 16:53:08 +0200 (CEST)
Date:   Thu, 20 May 2021 16:53:07 +0200 (CEST)
From:   torvic9@mailbox.org
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "almaz.alexandrovich@paragon-software.com" 
        <almaz.alexandrovich@paragon-software.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <1291339880.1758.1621522387730@office.mailbox.org>
In-Reply-To: <CAKwvOd=Z1ia4ZufDbRsEUkumwkz15TtSb2V1aBT7SN8w86RKYw@mail.gmail.com>
References: <212218590.13874.1621431781547@office.mailbox.org>
 <CAKwvOd=Z1ia4ZufDbRsEUkumwkz15TtSb2V1aBT7SN8w86RKYw@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs3: make ntfs3 compile with clang-12
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.31 / 15.00 / 15.00
X-Rspamd-Queue-Id: 4A07317FF
X-Rspamd-UID: 58cfba
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Nick Desaulniers <ndesaulniers@google.com> hat am 20.05.2021 01:06 geschrieben:
> 
>  
> On Wed, May 19, 2021 at 6:43 AM <torvic9@mailbox.org> wrote:
> >
> > Some of the ccflags in the fs/ntfs3 Makefile are for gcc only.
> > Replace them with clang alternatives if necessary.
> >
> > Signed-off-by: Tor Vic <torvic9@mailbox.org>
> 
> Thanks for the patch. +clang-built-linux; please make sure to cc the
> lists from ./scripts/get_maintainer.pl <patch file>.  It should
> recommend our mailing list of the words clang or llvm appear anywhere
> in the patch file. This helps spread around the review burden.
> 

Cool, I didn't know about that script, thanks!

> > ---
> >  fs/ntfs3/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/fs/ntfs3/Makefile b/fs/ntfs3/Makefile
> > index b06a06cc0..dae144033 100644
> > --- a/fs/ntfs3/Makefile
> > +++ b/fs/ntfs3/Makefile
> > @@ -4,7 +4,9 @@
> >  #
> >
> >  # to check robot warnings
> > -ccflags-y += -Wunused-but-set-variable -Wold-style-declaration -Wint-to-pointer-cast
> > +ccflags-y += -Wint-to-pointer-cast \
> > +       $(call cc-option,-Wunused-but-set-variable,-Wunused-const-variable) \
> > +       $(call cc-option,-Wold-style-declaration,-Wout-of-line-declaration)
> 
> I think it would be better to leave off the second parameter of both
> of these, which is the fallback.

OK, I will do that.
Thanks for your feedback!

> 
> >
> >  obj-$(CONFIG_NTFS3_FS) += ntfs3.o
> >
> > --
> > 2.31.1
> 
> -- 
> Thanks,
> ~Nick Desaulniers
