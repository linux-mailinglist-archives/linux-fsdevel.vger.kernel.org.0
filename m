Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC45F4DC795
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 14:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiCQNbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 09:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiCQNbs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BF31D12F1;
        Thu, 17 Mar 2022 06:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC9F761724;
        Thu, 17 Mar 2022 13:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426AEC340ED;
        Thu, 17 Mar 2022 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647523831;
        bh=Uu5CkIWWF14coD7DKlpKDiTH2dlwQPEA+Tj8rqU+Das=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Um87riZEnp0qBiWxCGgY+6FtjuLBQnEteOBZ+h0vTsv27Tc3sCUz5sAmLOJ1B6exr
         fuC3mUakoRAnjTThvm7hMbZKzjRf6QCDRNCvN3W1FODaJXqsYtk7SBhwj0Mr8gX+eB
         JHDdxyqB2rEBiUjYktnrx381RzEqS/gdE9xLTjD8QlbFQiGLwRK40C8ANrtTmAQBJm
         UzGZMZP7tf+6ZoQMAgK9c18py2Apb5bq7PbwiE/w6uF5w2pnS8sxoLKzBh9HW9WmLY
         YU3TNzYb27T3jQnq8MRbCw3VFCFytpX587CvMGAOZopP44P6c7XAg4mvFjT5/21i7g
         tCzpQReSegN+g==
Received: by mail-wm1-f52.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so4937580wme.5;
        Thu, 17 Mar 2022 06:30:31 -0700 (PDT)
X-Gm-Message-State: AOAM5308HrDfZ9m5JICtUErNutJqoKUcsvUwGMO9ZoZ9RVV/jEuAGEWU
        ecgf2oKZdC5KwLtZ5AQ3dpCO4NqRrdhZIEOKR9w=
X-Google-Smtp-Source: ABdhPJwVuy7loI1z2F93M+YreKFlFZjfVu/54lxs2OuCDCACUdi6A8oExsog4SWwtjwNNJM0CtQpWoPzSqBomBiqMsI=
X-Received: by 2002:a7b:ce0f:0:b0:389:a4eb:2520 with SMTP id
 m15-20020a7bce0f000000b00389a4eb2520mr11883578wmc.9.1647523829545; Thu, 17
 Mar 2022 06:30:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:1d93:0:0:0:0 with HTTP; Thu, 17 Mar 2022 06:30:28
 -0700 (PDT)
In-Reply-To: <20220317095047.11992-2-vkarasulli@suse.de>
References: <20220317095047.11992-1-vkarasulli@suse.de> <20220317095047.11992-2-vkarasulli@suse.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 17 Mar 2022 22:30:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-BZgy-gVAPhLhGNc31q-+8t18A=ho_Q6STmEBoGCoW0w@mail.gmail.com>
Message-ID: <CAKYAXd-BZgy-gVAPhLhGNc31q-+8t18A=ho_Q6STmEBoGCoW0w@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] exfat: allow access to paths with trailing dots
To:     Vasant Karasulli <vkarasulli@suse.de>
Cc:     David Disseldorp <ddiss@suse.de>, linux-fsdevel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-03-17 18:50 GMT+09:00, Vasant Karasulli <vkarasulli@suse.de>:
>  The Linux kernel exfat driver currently unconditionally strips
>  trailing periods '.' from path components. This isdone intentionally,
>  loosely following Windows behaviour and specifications
>  which state:
>
>   #exFAT
>   The concatenated file name has the same set of illegal characters as
>   other FAT-based file systems (see Table 31).
>
>   #FAT
>   ...
>   Leading and trailing spaces in a long name are ignored.
>   Leading and embedded periods are allowed in a name and are stored in
>   the long name. Trailing periods are ignored.
>
> Note: Leading and trailing space ' ' characters are currently retained
> by Linux kernel exfat, in conflict with the above specification.
> On Windows 10, trailing and leading space ' ' characters are stripped
> from the filenames.
> Some implementations, such as fuse-exfat, don't perform path trailer
> removal. When mounting images which contain trailing-dot paths, these
> paths are unreachable, e.g.:
>
>   + mount.exfat-fuse /dev/zram0 /mnt/test/
>   FUSE exfat 1.3.0
>   + cd /mnt/test/
>   + touch fuse_created_dots... '  fuse_created_spaces  '
>   + ls -l
>   total 0
>   -rwxrwxrwx 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
>   -rwxrwxrwx 1 root 0 0 Aug 18 09:45  fuse_created_dots...
>   + cd /
>   + umount /mnt/test/
>   + mount -t exfat /dev/zram0 /mnt/test
>   + cd /mnt/test
>   + ls -l
>   ls: cannot access 'fuse_created_dots...': No such file or directory
>   total 0
>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
>   -????????? ? ?    ? ?            ?  fuse_created_dots...
>   + touch kexfat_created_dots... '  kexfat_created_spaces  '
>   + ls -l
>   ls: cannot access 'fuse_created_dots...': No such file or directory
>   total 0
>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  kexfat_created_spaces  '
>   -????????? ? ?    ? ?            ?  fuse_created_dots...
>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45  kexfat_created_dots
>   + cd /
>   + umount /mnt/test/
>
> This commit adds "keep_last_dots" mount option that controls whether or
> not trailing periods '.' are stripped
> from path components during file lookup or file creation.
> This mount option can be used to access
> paths with trailing periods and disallow creating files with names with
> trailing periods. E.g. continuing from the previous example:
>
>   + mount -t exfat -o keep_last_dots /dev/zram0 /mnt/test
>   + cd /mnt/test
>   + ls -l
>   total 0
>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32 '  fuse_created_spaces  '
>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32 '  kexfat_created_spaces  '
>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32  fuse_created_dots...
>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32  kexfat_created_dots
>
>   + echo > kexfat_created_dots_again...
>   sh: kexfat_created_dots_again...: Invalid argument
>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1188964
> Link: https://lore.kernel.org/linux-fsdevel/003b01d755e4$31fb0d80$95f12880$
> @samsung.com/
> Link:
> https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
> Co-developed-by: David Disseldorp <ddiss@suse.de>
> Signed-off-by: David Disseldorp <ddiss@suse.de>
Applied, Thanks for your patch!
