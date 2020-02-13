Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA7815B597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 01:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgBMACM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 19:02:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35858 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgBMACJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:02:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so2900577lfh.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 16:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1cKEY5t+7UGLMNY+kX0FLiVY/W040LvYDjzlGdRgdPU=;
        b=RWMKeXpeGH42+rpaTBaY7XsCjlCSDu3yJVkKUXDmdy4hkiakoosIZZ+d6uVCYzDWDO
         5iDnrZGxcIKb+OHP+CZIph9gqmrhIvdOCh83QjoFOz+7B10tPAayX01fsmMvjpokoX0b
         AH5PlkrZr2ScnDuRrZT5ZrELJuBK0rOOsQit0eMG6DfcghkgL8Ve4+nywycY5ATpb5+M
         RAGz01B0puB+TR2LJREbJOM+s0lFCZ+xPZHUVcuAJgdJ5cIfZFz846DWzIe8TbgqLBsY
         xjCVqGIlPd6DqGjVSKCe+3wczgidrU0xrXzv+jjs0MJ23BXdYAAGrVrkYUFxaxA76ALS
         dbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cKEY5t+7UGLMNY+kX0FLiVY/W040LvYDjzlGdRgdPU=;
        b=AshVuiZndUW6HVXn1gGwOk7Tbq9dU4/ySdw0/q3SGGMztezRUWQH9zYbULuyadWnKa
         rGykgUy6D5ta/yEsMjuQqxxw1mNzUhixfmSu8ykHz9WoRTBKZ9+T95MbvPFjknFwJJF9
         lZp01e6YEerwYIrx53RhAtHK/Vkxe73naTLA/f9s3n3L64rnRg66AYj7sQfwi5yWFnG2
         Oq8tfZ+lNuKU5WfSntRh8/FOPog5o+ov3eVc/NPUMH2ltPROK9enDZe0Htlo7lml34IP
         SR4lF5R/br0e56YgGGGL+ilfCIfjBnCRot0cQ/7ZBEi2RZVDXUstjEV6D/j70WJ0Mjow
         4MJg==
X-Gm-Message-State: APjAAAU/CdnnUMrr46G818NAwiXz1CG3qOyDyxg8d1DmMLMnRynUI04o
        pq4ecaxTDYej0mV4p3iC+h0+LTya45JmA8/CH800bg==
X-Google-Smtp-Source: APXvYqx8tFG5jjHLonQJ8VXqCYuU/q3EHBj9Gtz8fRGkf+RG/SmbKainaG6ZMk409GO5DMimCh3Q4tyg2oufzLGpEck=
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr7421997lfs.99.1581552127242;
 Wed, 12 Feb 2020 16:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20200208013552.241832-1-drosen@google.com> <20200212061217.GK870@sol.localdomain>
In-Reply-To: <20200212061217.GK870@sol.localdomain>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 12 Feb 2020 16:01:56 -0800
Message-ID: <CA+PiJmTS2fnCPwFnDimvTxZynaxAB1_mrYeTWySVvpbW_wA-mA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Support fof Casefolding and Encryption
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Feb 07, 2020 at 05:35:44PM -0800, Daniel Rosenberg wrote:
> > Support fof Casefolding and Encryption
>
> You should fix the typo in the subject in the next version.  I assumed you'd
> notice, but both v6 and v7 have this...
>
> - Eric

Yeah, noticed just after I sent v7 :'(
