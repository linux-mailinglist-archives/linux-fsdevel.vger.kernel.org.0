Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3703C351BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 20:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhDASLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 14:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbhDASDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:03:39 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C98C0045DF;
        Thu,  1 Apr 2021 07:30:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id x17so2416644iog.2;
        Thu, 01 Apr 2021 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBkETlvKVe+ouMdxhkvam6Q/O5hICHuKtI9SBgWhYvo=;
        b=VptLX5o7vbk1tBFjFvKT+/LSulYSPzmQZvCGSBFdgGo7ZSdy39jY5TO3YYz3dToPuZ
         uFnJULdyfkUSp5MK0VXAw5T4D4Ycc6HoH0Etx7fMKtnyTnOrSt9dc2fEGke2GiyNRv3G
         +fH3mbjFH9we26IklRvGfbu53OzurHUfE5sNuTOHGVVP7km/58bwmMB+sufT7p6/dk8C
         4h3w4loIcQC4A/aufl0VSCU3kN/qaUDThxOdyFQHdPbBFMnNd9q59NLXJ5Id8CiJza1l
         ScxYoz0Ywcxt/D8mGjgM7Vclzevln8JmXz3YMi5KX6c+1xNp620Ul111/VWkA5nSohR4
         cH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBkETlvKVe+ouMdxhkvam6Q/O5hICHuKtI9SBgWhYvo=;
        b=lQJV4Yr6oY8mKuo+/4DX8h9/ZS7gJ42+UQAWFiA02+6JiVkiRVK+klfxBkTVi5GwBL
         YVckNXrXjNfEye/uWOEeJmBtTlbspyI8f9mFANvK7DZF6sXS2kK3g14LkWPRpfd/vq9j
         mS3Au+ZwOWA9i7sNWun0xXe+nHCkV62qVxu7oHIti59yqZz2LjUgndjuz3zyIPcjyNFb
         fr2lwhKvWm5z+PnStmLMv3vPt52hPCEej5OcpAD0NSwqbf8JnzCs6Drz51jiAGGCRRlt
         5XJeEjXz5bPu5A9kSBASUmHl5zE0rJCARE/D3yohKZ0aOGBAVlcI7s0XJgqrD2bzJgW+
         NWCQ==
X-Gm-Message-State: AOAM530FViHHRw5ON0Fx0qzVm5X+NJ9wgWRFSnGt0bgKEuToaBMdk/9D
        v1VIc7jOyzPmDJxDLBSWybgKjG0LR8V/m2Qyaos=
X-Google-Smtp-Source: ABdhPJwlusjpi1TKVZtt9iX9yEe2t+fJTLDD431j5l15qWGZ0JdoRPFlN83wccbrXyTJMlSMROpvZWSTWRNlZmgc5BQ=
X-Received: by 2002:a05:6602:2596:: with SMTP id p22mr6836991ioo.186.1617287453057;
 Thu, 01 Apr 2021 07:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegtUOVF-_GWk8Z-zUHUss0=GAd7HOY_qPSNroUx9og_deA@mail.gmail.com>
In-Reply-To: <CAJfpegtUOVF-_GWk8Z-zUHUss0=GAd7HOY_qPSNroUx9og_deA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 1 Apr 2021 17:30:41 +0300
Message-ID: <CAOQ4uxgcO-Wvjwbmjme+OwVz6bZnVz4C87dgJDJQY1u55BWGjw@mail.gmail.com>
Subject: Re: overlayfs: overlapping upperdir path
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 4:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Commit 146d62e5a586 ("ovl: detect overlapping layers") made sure we
> don't have overapping layers, but it also broke the arguably valid use
> case of
>
>  mount -olowerdir=/,upperdir=/subdir,..
>
> where subdir also resides on the root fs.

How is 'ls /merged/subdir' expected to behave in that use case?
Error?

>
> I also see that we check for a trap at lookup time, so the question is
> what does the up-front layer check buy us?
>

I'm not sure. I know it bought us silence from syzbot that started
mutating many overlapping layers repos....
Will the lookup trap have stopped it too? maybe. We did not try.

In general I think that if we can error out to user on mount time
it is preferred, but if we need to make that use case work, I'd try
to relax as minimum as possible from the check.

Thanks,
Amir.
