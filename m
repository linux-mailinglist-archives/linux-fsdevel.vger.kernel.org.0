Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD613C35A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAONj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:39:57 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34926 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgAONj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:39:57 -0500
Received: by mail-oi1-f194.google.com with SMTP id k4so15401500oik.2;
        Wed, 15 Jan 2020 05:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f6zc5HN4DUXE781/BcWszDvELlf43+ohtINNihx8v/k=;
        b=BOxSa87jpc68noq8HKuBAAeZAGfCPqKsHzJXIh3SEGyU07BD2e+3wC2eYoT8oWBOMZ
         yzQGVZcwxu0VbLwOh8Pt4MfnCmZngfZE8F0S7w4/nbkWlYboDvoDcSuagzktWvBLh4K3
         SOE/sZpn8K2n6mUK/+S4PMyOygKFlG92b8OuLVTFOsCVl9oWs9pVyDjuwMbRZDvzbg6m
         xWDogAPxfEofferYsRQynB03zra/p5ipj7LAM/Muww6QQ81IyjGEo/ADppCu6GUDODI+
         c0Nv1iEbJY2L8xaPZzDwoshkiWWD+02ou5nFPGXbi08K7rq2g/7aFmtzADTngAPZx41d
         iVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f6zc5HN4DUXE781/BcWszDvELlf43+ohtINNihx8v/k=;
        b=HOFs5icTpePxgD0tiJoE/pOcrnw7FtUteY9CSQLfcJ4O0YKaLy+26SbWD3eZbHfo+f
         BiqwBxODr7dMay4xa0+8NCfw+7+AbiLk13fyOhUi0GC3XHJd/Ms7nt1hXA8NKpbOqz1i
         VtwOVWbAmPRvFbSeukp0eaq2pJCZvT/pcgUxxqKXHavvf1VcSH1Ifzys6ZxOiGYWqN5V
         MMbS/Q4nKPf9BW8A3d4apdNXkpRl3Gdz6UuOxugFZLKIDiUJzgad0OsA9JLc4337eILg
         OpYENjOM5eiKyHz1dXkqlJefchmNWDJtFIME167fcrchlaefJYloqf7D3wdajs+lRhhF
         Vjhg==
X-Gm-Message-State: APjAAAUVASsfVA2Ww2F7gRAFWvjaLZa+mzb94fkaWWfcWeRcKB7Ve2P3
        j+7q4lm1KiXNBPHmHEuKuepsEn5NNhhi4UYwaKs=
X-Google-Smtp-Source: APXvYqywQHg+aUBx4eoKOxeLk9t+5Vfp4wvLcqQcGdNAxiM7nHNwcHhBOl8zb5PYutwhtNQgEB3nkivmFuQnTFEZRyw=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr12831720oib.62.1579095596501;
 Wed, 15 Jan 2020 05:39:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Wed, 15 Jan 2020 05:39:56 -0800 (PST)
In-Reply-To: <CAK8P3a3YOsFtuDDw9=d7_EY60Xvmx4Mc=NJmsy3f3Y9L87Ub=g@mail.gmail.com>
References: <CGME20200115082820epcas1p34ebebebaf610fd61c4e9882fca8ddbd5@epcas1p3.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-4-namjae.jeon@samsung.com>
 <CAK8P3a3YOsFtuDDw9=d7_EY60Xvmx4Mc=NJmsy3f3Y9L87Ub=g@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Wed, 15 Jan 2020 22:39:56 +0900
Message-ID: <CAKYAXd-CwLR3vLS_uPKOPzrEzB7v3rcdTCRR6BEhN-imeA_wPQ@mail.gmail.com>
Subject: Re: [PATCH v10 03/14] exfat: add inode operations
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-15 19:25 GMT+09:00, Arnd Bergmann <arnd@arndb.de>:
> On Wed, Jan 15, 2020 at 9:28 AM Namjae Jeon <namjae.jeon@samsung.com>
> wrote:
>
>> +       /* set FILE_INFO structure using the acquired struct exfat_dentry
>> */
>> +       exfat_set_entry_time(sbi, &inode->i_ctime,
>> +                       &ep->dentry.file.create_time,
>> +                       &ep->dentry.file.create_date,
>> +                       &ep->dentry.file.create_tz);
>> +       exfat_set_entry_time(sbi, &inode->i_mtime,
>> +                       &ep->dentry.file.modify_time,
>> +                       &ep->dentry.file.modify_date,
>> +                       &ep->dentry.file.modify_tz);
>> +       exfat_set_entry_time(sbi, &inode->i_atime,
>> +                       &ep->dentry.file.access_time,
>> +                       &ep->dentry.file.access_date,
>> +                       &ep->dentry.file.access_tz);
>
> I wonder if i_ctime should be handled differently. With statx() we finally
> have
> a concept of "file creation time" in "stx_btime". so it would make sense to
> store dentry.file.create_time in there rather than in i_ctime.
Right.
>
> It seems that traditionally most file systems that cannot store ctime
> separately
> just set i_ctime and i_mtime both to what is is modify_time here, though
> fat and hpfs use i_ctime to refer to creation time.
I will check it.

Thanks for your review!
>
>       Arnd
>
