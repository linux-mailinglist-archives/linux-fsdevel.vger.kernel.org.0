Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A9813297B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 16:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgAGPBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 10:01:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51200 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGPBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:01:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so19296583wmd.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u5EDY5pvUvBf06YiHxo45ZYes2oII0h8f9+gxAbrJZo=;
        b=IYAJlu2DjKhEmb4RtjlyGuZOK65HmgFuPo0bR1Ec/+aBv9XH0yRYsQ97L9M9bEQCxm
         HX9KmvLoBiDBBVfznQoFMBHZjJVCQG4h/zoyIE/1m9sSrnyIP+O5vPZ9vtwXcBJH0XEI
         LZOUlgWM5l9bZFcybVgU6aZfOgjcy6GzMOZITTq+8ActPkCU5Ah/ZJZnHNfQJY6Xio99
         aB9FsD8IOxm6W29q2JysthEsTnfoqpTwDNKOr312xpzN9uTXnw2vGvnrvS1IQzvzCObs
         Dt2rOW7QGsvOdXwYG2BOEJF2ZaNNPHiFj7Uz5mulVx5ukeQ7HI/LzhEJKVqAKfhVJL0i
         T6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u5EDY5pvUvBf06YiHxo45ZYes2oII0h8f9+gxAbrJZo=;
        b=VLGKdUpCITp0BI2dmTXx96tsezU5FSHUHy87Z7HK1m3NOBj2Y77AJwbdvVF/6Mdgvt
         Gd/NpEi0JSkLoc1pHS8rqdcXoLWnJN3YQSxRivmNrA+PgJ+UVPqOPFxtQ3QkgN3fA3Pz
         9cYtiSiKYqmhh0pXvQ1XYlVcbbK86oPLn8QD00qAAyq7loapXXwLhgAse65ECWdFfG7t
         T1F0/hKeVj9sr9KcXpF9VZOyNqPMhmt/xhDKzTScAVP/csrOOSSQUCaBliAmpZldHjbT
         mSpzqU0W6VdmEaymidsAtuYK9tx7r18d7wXHlApVcy/atAGfgSDNG5ZsGAYKN6xPAa/V
         9Q5g==
X-Gm-Message-State: APjAAAUnjQDID2CZZGyXK+Yd4fLRrjUDbYKOkoN/jOjldpuPNjUWlEwU
        ygWu7X7BP/5J5LnavAP6Ft8=
X-Google-Smtp-Source: APXvYqyqzyMMquCqLf2Q4XV5qbsvt0xtYYCU9IRW5Sz9GaoWAb01hjb7HUXUNW5hxSzVr1P+xbdV5A==
X-Received: by 2002:a1c:e289:: with SMTP id z131mr38773894wmg.18.1578409304564;
        Tue, 07 Jan 2020 07:01:44 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f12sm27107125wmf.28.2020.01.07.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 07:01:43 -0800 (PST)
Date:   Tue, 7 Jan 2020 16:01:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: udf_count_free() and UDF discs with Metadata partition
Message-ID: <20200107150142.ltujuqgillgqhvx2@pali>
References: <20191226113750.rcfmbs643sfnpixq@pali>
 <20200107144518.GF25547@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107144518.GF25547@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday 07 January 2020 15:45:18 Jan Kara wrote:
> Hello!
> 
> On Thu 26-12-19 12:37:50, Pali Rohár wrote:
> > During testing of udfinfo tool (from udftools project) I found that
> > udfinfo's implementation for calculating free space does not work when
> > UDF filesystem has Metadata partition (according to OSTA UDF 2.50).
> > 
> > Year ago in udfinfo for calculating free space I used same algorithm as
> > is implemented in kernel UDF driver, function udf_count_free(). So I
> > suspect kernel driver could have it incorrectly implemented too, but I'm
> > not sure. So I'm sending this email to let you know about it.
> > 
> > What is the problem? UDF Metadata partition is stored directly on UDF
> > Physical partition and therefore free space calculation needs to be done
> > from Physical one (same applies for Virtual partition). But Metadata
> > partition contains mapping table for logical <--> physical blocks, so
> > reading data needs to be done always from Metadata partition. Also in
> > UDF terminology are two different things: Partition and Partition Map.
> > And "partition number" is a bit misleading as sometimes it refers to
> > "Partition" and sometimes to "Partition Map" what are two different
> > things.
> 
> Thanks for the note! You're right that we probably misreport amount of free
> space in the UDF filesystems with Metadata partition. Luckily the kernel
> driver supports filesystems with Metadata partition or Virtual partition
> only in read-only mode so the bug does not cause any real harm.

For discs with Virtual partition I used in udfinfo different algorithm
for calculating free space: Free are only those blocks which are after
VAT block (therefore unrecorded blocks).

> > Calculation problem in udfinfo I fixed in this commit:
> > https://github.com/pali/udftools/commit/1763c9f899bdbdb68b1a44a8cb5edd5141107043
> 
> Thanks for the link, I'll fixup the kernel code. BTW, how did you test
> this? Do you have any UDF image with Metadata partition?

I have CD, DVD, HD-DVD and BD images with just one file (so they have
lot of empty space) in all variants (plain, Sparing, VAT) and all
possible UDF revisions (1.02 - 2.60) created by some very very ancient
Windows Nero software. Some of them discovered bugs in libblkid UDF
implementation and are therefore included as part of util-linux project
for running util-linux tests. Plain and Sparing UDF 2.50 and 2.60 images
have Metadata partition as required by specification.

If you want I can send you a whole pack of all those images.

-- 
Pali Rohár
pali.rohar@gmail.com
