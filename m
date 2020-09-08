Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7CA260F47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 12:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgIHKHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgIHKHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:07:06 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B064C061573;
        Tue,  8 Sep 2020 03:07:05 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y13so2266143iow.4;
        Tue, 08 Sep 2020 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjlLwILBDcNJWOs0FbChR/8zA/O+ckKUiqpt3EAQvbA=;
        b=pno9bO8EjHE9wvTWQzmOfM/ydiHJkkKH6QcfjZoIXzwYA5C2DMaPe624kpnCPCyaVv
         3ZNPkV/xFTIawvWpRfzuwMpZwfWfHWFkWPF1Fz8c4ZWHnDRuPfpRn2VzA9I4Ujykbr3P
         lAeRSpoU/5roXAWa5xTE2KpbGzaGcZGQQ7RlwDDAn4NKBNEBp8j1KOPc5HLYiiG2Bs87
         b8CV1iN8a7WpmqVbNeYEru4hl1OLXCTv9pEbcBZpYvFUrxoGCJbNijpPs1TzfXU4dZvU
         312JL/UU2MPwYscfZTW4pMtaX/M7E7M5X/baGFSIjk0pbR053tZpMAhI63ZX7kaYnOvD
         +P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjlLwILBDcNJWOs0FbChR/8zA/O+ckKUiqpt3EAQvbA=;
        b=XKlYNPUl+GSWD8ABeQgSJv03RUFkc/blCASMLqXE/FN/kB30A9WtntRUFtPlM7TGyk
         EM8Pi6ln9ojGkOPTjJ99I2+qcRZlbsnc+BCx+2gcQdD40MtE4M+kQzy3vXXmRkj46ISt
         LawmDHWSxJCuf8L7ojfGcFtho90FcWx9CAdMNcrsxA7n/+pEjNtVrEul1PSpe9SAMxzT
         yswFTEBG5g+6QvkC9hs/EGhV0woHSyaudxWRg610sbTgvzjWiCvCn/+HMyyiZKdF1xto
         IerdQTi7Q9bOS5SfYzz71ByGldQOqYPCe8LesAvmB7HRmwzuP9Bw57kV3pHKXtpwrRNW
         PhLg==
X-Gm-Message-State: AOAM530zpdZ1J3IuqxcXKmsStjWk/gWgGi3exxKlyL0Vy7jCo/QxrEr9
        2+9anQYsNHUmcRoNfPC/JixnVXO0A6Lt10zlogm2p+953r4=
X-Google-Smtp-Source: ABdhPJxJpbndKEUQcNd10oBluKbWCERCXJc5iqqCStpsMOxI6dB8+nTncm2ZX6/TOZJXfhNYow32bmlrHie0vkT+9gE=
X-Received: by 2002:a02:ca12:: with SMTP id i18mr12211474jak.30.1599559624945;
 Tue, 08 Sep 2020 03:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
In-Reply-To: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Sep 2020 13:06:53 +0300
Message-ID: <CAOQ4uxhejJzjKLZCt=b87KAX0sC3RAZ2FHEZbu4188Ar-bkmOg@mail.gmail.com>
Subject: Re: Question: Why is there no notification when a file is opened
 using filp_open()?
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangle6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 8, 2020 at 11:02 AM Xiaoming Ni <nixiaoming@huawei.com> wrote:
>
> The file opening action on the system may be from user-mode sys_open()
> or kernel-mode filp_open().
> Currently, fsnotify_open() is invoked in do_sys_openat2().
> But filp_open() is not notified. Why? Is this an omission?
>
> Do we need to call fsnotify_open() in filp_open() or  do_filp_open() to
> ensure that both user-mode and kernel-mode file opening operations can
> be notified?
>

Do you have a specific use case of kernel filp_open() in mind?

Thanks,
Amir.
