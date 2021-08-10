Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6E3E5303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 07:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbhHJFrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 01:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhHJFrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 01:47:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852DDC0613D3;
        Mon,  9 Aug 2021 22:46:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b6so22779774lff.10;
        Mon, 09 Aug 2021 22:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=luLXleK9slk1U8VxUKke20zIQVfuP0RwNhKdoqv0SQk=;
        b=mbWleJ6exMEgS10Vk821G5eMWNgvV3EdP5bIelbU/MZKm8+ITh+Ufm5galAml3ozAR
         Au0biczwStLePoaWoFTvusHlrJvLjOp3Np7ZzTGz/YaZIzT2GlUxqxJG8G3C0fQwLlvv
         G8VahUsytwvC/KZCrGKhiizuQ9r5E0kYj+0IdrNH+wk7Ko00odboXQIkEjWpXhQ5UG2u
         Lqs6qpgZ9sipiuyH88sSy20xumQnGqhDJs55wIXl7tf2hhWfg88n0+0rDpJbqGPukT/J
         SQL9FnsV5UZ99W8ZvihtZSGdgTF8kwsuI0KqhLxEw4BQej0DQir6hSRYeD/7LodKvm0l
         JdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=luLXleK9slk1U8VxUKke20zIQVfuP0RwNhKdoqv0SQk=;
        b=RhV7PK9nk7opjkP7uw2JITEBng1NwDsuqChvpnVXulNlyi27bG9WXUFqGBMLtpUN8T
         ySG6sXqIbSkncxGSuxGibHI9hODrfSw8NN4b3lOg54pOHLPq5f5AmU4kM/g2tcbaVcOF
         GHCDHuAkQHQuPvNdkbzMmH0LU9uF8+GAmaZ8SmFKye4C9tmV4u+KnUPkWOEmZ/hfsAYt
         nKmHjVujt4CBSESK9l3DqY/A2fICXXF6NtUFXubkELMhVUj6xWniABkVaH2NgthZPjKM
         Yf1irsN3et7V2yuKnnTyXcY39YOLSkMLQ+oqHmxPMjAvjrgqvbyunkJ8eg5U2NkLnl2E
         6xsg==
X-Gm-Message-State: AOAM532cO934xDDwb6EXZIoE5QuSUF85DA7kQ2Iv/wEAZ9xgbD6GyQI9
        Jn0OJJHSalUA/nIP0e71sVGzx39jM0hFxXjE
X-Google-Smtp-Source: ABdhPJzXCTg/JoTQyqBBzfCjmC3wp24bTeOKWy5pPzVdwtwgVchNnVeeAomIGS9JXLGAm10ZwaE2xw==
X-Received: by 2002:ac2:57cd:: with SMTP id k13mr20905646lfo.117.1628574400629;
        Mon, 09 Aug 2021 22:46:40 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id r13sm1941263lfr.7.2021.08.09.22.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 22:46:40 -0700 (PDT)
Date:   Tue, 10 Aug 2021 08:46:37 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH v27 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20210810054637.aap4zuiiparfl2gq@kari-VirtualBox>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 04:49:33PM +0300, Konstantin Komarov wrote:
> This patch adds NTFS Read-Write driver to fs/ntfs3.
> 
> Having decades of expertise in commercial file systems development and huge
> test coverage, we at Paragon Software GmbH want to make our contribution to
> the Open Source Community by providing implementation of NTFS Read-Write
> driver for the Linux Kernel.
> 
> This is fully functional NTFS Read-Write driver. Current version works with
> NTFS(including v3.1) and normal/compressed/sparse files and supports journal replaying.
> 
> We plan to support this version after the codebase once merged, and add new
> features and fix bugs. For example, full journaling support over JBD will be
> added in later updates.

I'm not expert but I have try to review this series best I can and have
not found any major mistakes which prevents merging. Yeah there are
couple bugs but because this is not going to replace NTFS driver just
yet then IMO it is best that merge will happend sooner so development
fot others get easier. I will also try to review future patches (from
Paragon and others), test patches and make contribution at my own for this
driver. So please use

Reviewed by: Kari Argillander <kari.argillander@gmail.com>

