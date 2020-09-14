Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70C26952B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 20:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgINSsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgINSsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:48:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24980C06174A;
        Mon, 14 Sep 2020 11:48:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x123so332028pfc.7;
        Mon, 14 Sep 2020 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TktOLUiCsPv+mpZJL8cK/FeOYzPN9P96m1E+94gvEh4=;
        b=MEswu/bUFTxGJFDPMxldk8hQ0jsmnkfS5qZJ/PBH0aTk64MLfaJYlL9OG+4I34brDK
         hQl6RF7aa4miV3MwCE5eAUeCqRB/ehFWklavfjS9RNwbgeaIsM9srsRhK56lRD2pAwzz
         vknoGJFp1oC0va3WMnpHW3tLlSMI0xJyIWKih6QwhZgrDTWqAi2ih0z4Oj0hg2yOHUAc
         5conJYan1tShbiXA9oXc/fhP9LD/BkA78OwMv7IGt76Ityv01jj2K0xD/sz/qV4Bnu4j
         iRqFEw6gCB9/d3Ss8UEKExF26qaKH+4zK+XLxDKYB9tGDVJIeYv+Db8Nbi3hl74pBsZ8
         VOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TktOLUiCsPv+mpZJL8cK/FeOYzPN9P96m1E+94gvEh4=;
        b=pLmiV1tCygVOfnGeEmLc/uAp5qk4YhtkhTHgtm99ncsMk8EVilQWZBk3qfn3dnsB9U
         VOMc0iRvBH61t4vnE5L2AfOQv7s13fTtM0Sq9Z885b5oyAQjaxhSFhn0Z82VQcecvY9z
         ion2Yc583L0oDLbUR2zKS+maOypu8u8W8ZXNllvvm0G6KctCsXQrB0uCrdBBucnncMHR
         dvMcAJ4FJBnT3gD413+q9sDSW+QiCMbbxOXgmN70SAqSVjMsKAHvs2W4hNbs1B1K6IK1
         t3El+XmpQ1ijx1wEa0h/K8xAMArFutgG51Gs1ED2dqKd5Q0LC2WxzHRttblR8aID8SvL
         tlpw==
X-Gm-Message-State: AOAM532zDi+1HPn3eicKfuXDTaBj5HTGbASU29Yj1CFzLEJ4vXdK6CNZ
        y/GWQI9NlpQ70+kKp4WYlSo=
X-Google-Smtp-Source: ABdhPJzDGgyED+yg+ViGJ8weGRDUe/EqhSNYnMw1HrhqNBhRaDr5S8e73DEl593zJ9Qtz7A6vPCckg==
X-Received: by 2002:a62:7bc7:0:b029:138:9430:544e with SMTP id w190-20020a627bc70000b02901389430544emr14988012pfc.1.1600109282564;
        Mon, 14 Sep 2020 11:48:02 -0700 (PDT)
Received: from Thinkpad ([45.118.167.196])
        by smtp.gmail.com with ESMTPSA id j4sm11674416pfd.101.2020.09.14.11.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:48:01 -0700 (PDT)
Date:   Tue, 15 Sep 2020 00:17:55 +0530
From:   Anmol Karn <anmol.karan123@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com
Subject: Re: [Linux-kernel-mentees] [PATCH] idr: remove WARN_ON_ONCE() when
 trying to check id
Message-ID: <20200914184755.GB213347@Thinkpad>
References: <20200914071724.202365-1-anmol.karan123@gmail.com>
 <20200914110803.GL6583@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914110803.GL6583@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:08:03PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 14, 2020 at 12:47:24PM +0530, Anmol Karn wrote:
> > idr_get_next() gives WARN_ON_ONCE() when it gets (id > INT_MAX) true
> > and this happens when syzbot does fuzzing, and that warning is
> > expected, but WARN_ON_ONCE() is not required here and, cecking
> > the condition and returning NULL value would be suffice.
> > 
> > Reference: commit b9959c7a347 ("filldir[64]: remove WARN_ON_ONCE() for bad directory entries")
> > Reported-and-tested-by: syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=f7204dcf3df4bb4ce42c 
> > Signed-off-by: Anmol Karn <anmol.karan123@gmail.com>
> 
> https://lore.kernel.org/netdev/20200605120037.17427-1-willy@infradead.org/

Hello sir,

I have looked into the patch, and it seems the problem is fixed to the root cause
in this patch, but not yet merged due to some backport issues, so, please ignore 
this patch(sent by me), and please let me know if i can contribute to fixing this 
bug's root cause.

Thanks,
Anmol 
