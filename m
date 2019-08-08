Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC779868BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 20:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfHHS2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 14:28:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42312 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHS2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:28:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so122504140otn.9;
        Thu, 08 Aug 2019 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JP31KWXxB5g0ATua8LYOvPZ42m/v4rF4TStXnIb5Wjo=;
        b=nByiJIjprASucnNzVSdLuIdgXtP4B3tGEGEVsOJKICYYa+Fw0MLan8TTtYsjZBIqGS
         R7ad+Oh3wPEDTxf56rDQ+qLoJr229H524vy3fsjCPnZaGxBuOoDm7f6F9oGhtMwGfWmG
         F1xsKK3h1vXSZRGnSSgMDiGucJqq1uQcJbveOxTF9jQaTV7dl6Dhil/qkUnL+AN/vnzD
         gSXr94oJtAXdJ99rbJNlFOBq2yzvAJEtUTWYb8xcfQ2Da0wet6TfBczRhL4I3LiWNfN3
         kb8TyLMtSkLsxAXeJJi2cIgYrZTyooUBwfONKqhvEjJ7XWUl6jKqc5IBV4ega6w5DH2m
         NPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JP31KWXxB5g0ATua8LYOvPZ42m/v4rF4TStXnIb5Wjo=;
        b=agtmCJNRPlM8GuV3TgF8TmvP/Nm2Djuc21K6YJk1F14icRr3kvawU+ssoFmiX/GLp9
         16lm9w4iemLvjLLND7UPzVZsxNdQ1huwTnaE//XpH1exFPHmHSoKSDUY4KRJGw1Opx+v
         AalF6MXhIFPh7iarGvUVTUSQLiONTLpkCQ8kWp1AlbZQ8JiQp67JxR/LI5nOockIdTve
         nBy/IkKkczfkFtCQTBVL9T9l1sd1a6I1OPHJ/a6LCI4bmOc//KLBsIOOxItWA1pW5mwc
         ulguhfSAVJHutUUtcwpAyuV4CZRnqKX8arD4q+yT96AiTMwPx1Jnu/RMgwpLSC7fVPWS
         6SDg==
X-Gm-Message-State: APjAAAXI8aBfFMyL0w5guMz0pZdOQb520NXbivd2lPZFjQ1LgqkwU9QC
        Y2s49liETmXGi1Ip1AJCvRPmcc8tcEH37CZgv0vHh6jD
X-Google-Smtp-Source: APXvYqxiT1Fy5xeg3rKlce6LGFT5t1JXKK2E1x1kK9KiqPpRIsArdQ/QFfe9Ql8uS++MitNb7fpHSifTnT5SwGyf9Jk=
X-Received: by 2002:a6b:f406:: with SMTP id i6mr16160255iog.110.1565288889403;
 Thu, 08 Aug 2019 11:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-10-deepa.kernel@gmail.com>
 <20190731152609.GB7077@magnolia> <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
 <20190801224344.GC17372@mit.edu> <CAK8P3a3nqmWBXBiFL1kGmJ7yQ_=5S4Kok0YVB3VMFVBuYjFGOQ@mail.gmail.com>
 <20190802154341.GB4308@mit.edu> <CAK8P3a1Z+nuvBA92K2ORpdjQ+i7KrjOXCFud7fFg4n73Fqx_8Q@mail.gmail.com>
 <20190802213944.GE4308@mit.edu> <CAK8P3a2z+ZpyONnC+KE1eDbtQ7m2m3xifDhfWe6JTCPPRB0S=g@mail.gmail.com>
 <20190803160257.GG4308@mit.edu> <CAK8P3a0aTsz4f6FgXf7NSAG+aVpd1rhZvFU_E4v8AY_stvhJtQ@mail.gmail.com>
 <B4818187-623B-4A0C-8958-81E820E8F1E1@dilger.ca>
In-Reply-To: <B4818187-623B-4A0C-8958-81E820E8F1E1@dilger.ca>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu, 8 Aug 2019 11:27:57 -0700
Message-ID: <CABeXuvpzLY5_r3ootFiNAz50nuvyBZcN37nSOMA2kZyW4M1f0Q@mail.gmail.com>
Subject: Re: [PATCH 09/20] ext4: Initialize timestamps limits
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Rather than printing a warning at mount time (which may be confusing
> to users for a problem they may never see), it makes sense to only
> print such a warning in the vanishingly small case that someone actually
> tries to modify the inode timestamp but it doesn't fit, rather than on
> the theoretical case that may never happen.

Arnd and I were discussing and we came to a similar conclusion that we
would not warn at mount. Arnd suggested maybe we include a
pr_warn_ratelimited() when we do write to these special inodes.

In general, there is an agreement to leave the fs granularity to a
higher resolution for such super blocks. And hence, the timestamps for
these special cases will never be clamped in memory.(Assuming we do
not want to make more changes and try to do something like
__ext4_expand_extra_isize() for in memory inode updates)
We could easily try to clamp these timestamps when they get written
out to the disk by modifying the EXT4_INODE_SET_XTIME to include such
a clamp. And, at this point we could also warn.

If this is acceptable, I could post an update.

-Deepa
