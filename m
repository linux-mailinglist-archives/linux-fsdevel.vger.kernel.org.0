Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3B131656
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 17:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgAFQzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 11:55:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38132 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:55:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so27127171pgm.5;
        Mon, 06 Jan 2020 08:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:in-reply-to:references:mime-version:content-id
         :date:message-id;
        bh=df4YyZUV+IM4Z+keZd+LizEQHBEDhQXQEtITNJle4CQ=;
        b=TJuh/iNi/KJipm6QDUvLTl2Kwonqc0io/2eFiUHK8uQCw2Nj1QW37n3hjBaJy6t22X
         RXrblHvEuy5DLUZabM6m8wFxq49UzcECYaoioVML2RB5kwhzVXEN/+CYDyz/dZmMQvmA
         a5ruOVlyER+7u59xhwa0sYRHc0QPxA0GyioAd8Sj6quzKYtQ5aLJXPJRCNujLBekjWRL
         PLIoWc7PPFH+0wEEtDtSKS8x+Qg0CHc2vF1HuNmwiKJbrOxs5Sv3M8tnKvlr3LHisZ44
         q2vEp4/pZvXr+MOysfMzfG/FSmPhl7brgMlyBbYKlW5w+cWCQAmD5m3B6yhc9k7DoDSU
         0Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:in-reply-to:references
         :mime-version:content-id:date:message-id;
        bh=df4YyZUV+IM4Z+keZd+LizEQHBEDhQXQEtITNJle4CQ=;
        b=bPYvF7N0iGJ+pjUTq/+Y6dCT/oOFlj5nINn9E0eS3QBQvzNqQXa9uCZzRxBUjx+N1i
         iorsRzE8HnhCmEuVenTarJuLdJdfT8HYA8XafvJnrjA6Bphf38931voQ3Ag+MjjYZ5wr
         RSs8CU3LZmn11AsOjMsfvFvip19WFeMiuXS1xxoD9bHHn71LRR3GiWc5C6E+iFGw9iJs
         ybb0nORYoFmgT1eVl+USXQbopuVdgTPmzmQP4FJa87DqgZlah8NFQGUOoNKSb/DgfsL2
         tYd+DQ7Ei3TbFMEcS89+KhmvRYPkB8POEwe0vgqr01iIBJXqiA+NSHb/U8gD2MHc8q9u
         NaOQ==
X-Gm-Message-State: APjAAAWzhGe8XnnPZIFk1mHH2edlhawV0pNfhUyh5rmEu9aLYHmbJDYI
        wL1j/W/98c0P684nsABNbEYWuuER
X-Google-Smtp-Source: APXvYqyRlTWbuwzIqqsoGt251vhrqOnu1djUONsK+NgOJb3LrrW5m1N+igc9ajp1Ht1lEyesBXjYWw==
X-Received: by 2002:aa7:86d4:: with SMTP id h20mr103820168pfo.232.1578329731055;
        Mon, 06 Jan 2020 08:55:31 -0800 (PST)
Received: from jromail.nowhere (h219-110-240-103.catv02.itscom.jp. [219.110.240.103])
        by smtp.gmail.com with ESMTPSA id a19sm24848895pju.11.2020.01.06.08.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 08:55:30 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1ioVf7-0003c8-6A ; Tue, 07 Jan 2020 01:55:29 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH]: nfs acl: bugfix, don't use static nfsd_acl_versions[]
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     trond.myklebust@hammerspace.com, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
In-Reply-To: <20200106162854.GA25029@pick.fieldses.org>
References: <29104.1578242282@jrobl> <20200106162854.GA25029@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13894.1578329729.1@jrobl>
Date:   Tue, 07 Jan 2020 01:55:29 +0900
Message-ID: <13895.1578329729@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"J. Bruce Fields":
> Thanks, but, see 7c149057d044 "nfsd: restore NFSv3 ACL support", in
> 5.5-rc1; looks like you and I both stumbled on the identical fix?--b.

Ah, you already fixed.  I didn't notice since I am still in v5.4.
Sorry for the noise.


J. R. Okajima
