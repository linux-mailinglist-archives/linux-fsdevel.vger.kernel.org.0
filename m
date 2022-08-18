Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCEC597E69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 08:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbiHRGIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 02:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbiHRGIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAEB45077;
        Wed, 17 Aug 2022 23:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F8E6124A;
        Thu, 18 Aug 2022 06:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D661C433D6;
        Thu, 18 Aug 2022 06:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660802918;
        bh=CRl7JsMqi8BsPMaRF4i1DkotPNeNQzHKAoXFboy6LYY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=MEQR8w97geB0du4JylVtGu3MrUNfIv/SKfi0ahOwCeuEHnhhopTaJFH/MdS0LokOq
         ilPZnksm+2eqoQujGxf70jn+eDjIGmZXZw3EawFnlS/kTHEG5BlcZmK4PxDPMJ28Ie
         yLcEhTbkkh2fTLxMcwNUre5QeZIi9+LFe6JKtCaPknV4JAPpwLBd2AqaTEgI6j3fVD
         exy8qAkI7HP6baoe6rbgysY50ln+qzHmY0u6rTjAQkYJ+B+2SBUql5AN16UWPcPWJ7
         Xlu2loyuMe0hH0bClzVns/2F+F/7YKRIVK3TzCsFzL4KUwEyO8HfDTbpG3E3tViH2r
         M9qqE+Ax2qNAQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11c896b879bso744197fac.3;
        Wed, 17 Aug 2022 23:08:38 -0700 (PDT)
X-Gm-Message-State: ACgBeo07iT8PjBw8vnYtPxIkspTbZVeICsgBODdpc8T94rSB2CbGnJ7N
        +qn9k2holBLnevGeyrNTEoKh9dEouAF9mPKI+Ww=
X-Google-Smtp-Source: AA6agR7w3gs9PXG8qQMcjajj1oVA3xPSKUmtvrpdRJBLq+TYskNiGYgDD7oIqMLRoDHtCXHEUdbF7xU2wSKtSSaX+Rc=
X-Received: by 2002:a05:6870:f69d:b0:10d:81ea:3540 with SMTP id
 el29-20020a056870f69d00b0010d81ea3540mr695380oab.257.1660802917371; Wed, 17
 Aug 2022 23:08:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:27c7:0:0:0:0 with HTTP; Wed, 17 Aug 2022 23:08:36
 -0700 (PDT)
In-Reply-To: <Yv2rCqD7M8fAhq5v@ZenIV>
References: <Yv2qoNQg48rtymGE@ZenIV> <Yv2rCqD7M8fAhq5v@ZenIV>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 18 Aug 2022 15:08:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Xsih1TKTbM0kTGmjQfpkbpp7d3u9E7USuwmiSXLVvBw@mail.gmail.com>
Message-ID: <CAKYAXd-Xsih1TKTbM0kTGmjQfpkbpp7d3u9E7USuwmiSXLVvBw@mail.gmail.com>
Subject: Re: [PATCH 4/5] ksmbd: don't open-code %pf
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-08-18 11:59 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/ksmbd/vfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index 78d01033604c..a0fafba8b5d0 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -1743,11 +1743,11 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work
> *work,
>  	*total_size_written = 0;
>
>  	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
> -		pr_err("no right to read(%pd)\n", src_fp->filp->f_path.dentry);
> +		pr_err("no right to read(%pf)\n", src_fp->filp);
Isn't this probably %pD?

Thanks.
>  		return -EACCES;
>  	}
>  	if (!(dst_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
> -		pr_err("no right to write(%pd)\n", dst_fp->filp->f_path.dentry);
> +		pr_err("no right to write(%pf)\n", dst_fp->filp);
>  		return -EACCES;
>  	}
>
> --
> 2.30.2
>
>
