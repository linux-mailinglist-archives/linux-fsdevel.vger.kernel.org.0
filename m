Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D8243013
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 22:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHLUeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHLUeR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:34:17 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCD8C061383;
        Wed, 12 Aug 2020 13:34:17 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so2583390qtm.10;
        Wed, 12 Aug 2020 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8AbcIfen2Mh3O6xshAeb42qMiceFCwU8VY+DtJghWKc=;
        b=JJYKq7rhGfoskc0IOYL0mQ2UgiV0NUPZnUMJqm0x4+mN+Jnr5eSGxbVsmV3va+QmiF
         wjNsakLNmG8Snq4Ka54NHi+FMZOfkPc/P2UAnRuTKgJxYoDYNvYxnt9ubGhb/1D4XEbF
         R5s86RQJgzcMqdEQLZP6mi/nb4RuLVBQmVI4891ly/7eIdpFM1zpDZkPWag8mXnTxtoy
         vTo5GBX5MwVspiDm8HromEAg+ZMCdOxBmSjbfjM12ucPoyMLi6Jr1WBIZ8qAoOffTuuf
         J8cG90cIOw+EUXScq3d98Z/wlHZasQ2HIKPuWFa0h1c1TvCj5gslLqFBv4AiKd9iNLAP
         uURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8AbcIfen2Mh3O6xshAeb42qMiceFCwU8VY+DtJghWKc=;
        b=tycdZcmC5Nl1nHB6OyuEARPt2aPmVtV8syu96FXmvgNm8dDnxqPJY/gP2HaCtbJpdj
         FwztCMlmPikaHAkgOJahfsHWdsq+g0K0irxJUzyShoQqps0xaIKHAT+9AJIOwSGimPZb
         fhPv6Opa6Ei7Xq0nSywy1SQVPwBia/see4R/WP6F8coMm/LqjTtQSmyIFeoGv1Poqmrp
         JKptOLaJqMyzI3asCsPe5VV1/UYcnQWX7P9/Yx8u4zhjE4GLx3PBMT+4CAuSSGQBaI36
         k6UcC71VXnJsgwqP40S0BXwFNwrpG51zD0fhY9HvsqeINbMgwBV6AtH6x7W8hjEGx4h0
         1RKw==
X-Gm-Message-State: AOAM532URhEC934L5k9ZH+nJXp09bWrVht5gPoC3UCrLMFJmsVbZ5U4D
        4IiSJs0xkUHgkTAczjm8L+nevLHU
X-Google-Smtp-Source: ABdhPJx64TW/NqTIbSDn9AtxCM0KEpE57asspn5bN7J15aOPfo8WvWruSQ6i+zwyQrbngY2hClZEPw==
X-Received: by 2002:ac8:130a:: with SMTP id e10mr1710881qtj.38.1597264456887;
        Wed, 12 Aug 2020 13:34:16 -0700 (PDT)
Received: from eaf ([190.19.79.86])
        by smtp.gmail.com with ESMTPSA id o13sm3651241qko.48.2020.08.12.13.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:34:16 -0700 (PDT)
Date:   Wed, 12 Aug 2020 17:34:10 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] hfs, hfsplus: Fix NULL pointer
 dereference in hfs_find_init()
Message-ID: <20200812203410.GA6168@eaf>
References: <20200812065556.869508-1-yepeilin.cs@gmail.com>
 <20200812070827.GA1304640@kroah.com>
 <20200812071306.GA869606@PWN>
 <20200812085904.GA16441@kadam>
 <20200812202420.GA5873@eaf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812202420.GA5873@eaf>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 05:24:20PM -0300, Ernesto A. Fernández wrote:
> If that's what the reproducer is about, I think just returning an error is
> reasonable.

I guess it would be better to put a check inside hfsplus_inode_read_fork(),
to verify that the first extent is always in the right place and wide
enough.
