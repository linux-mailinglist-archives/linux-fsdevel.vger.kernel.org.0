Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA94914A0BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 10:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgA0J2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 04:28:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40165 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgA0J2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:28:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so10263879wrn.7;
        Mon, 27 Jan 2020 01:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KXG6VZGoAkKQHrL/ylxA7tULnj1W6vTa353gWJTyxzk=;
        b=CsCSCk2ND5UFSKICKQwOORGUz9z7+F97lzzzuo4+kriRQX1p+r59VkgU0YHy2pHbxV
         dvCBD0PYvmlvz2oggWwl+85MLA0TxEkOWwDeDWGs21CYe9oJlA4kUmpTlB0jv7c3VgZt
         xZbaX1o/cUlxZ6JTUZWXDhmqTUx73gnvr2rx96+8V/1DsXlb3I5yDmZ2LMFMgK3/B8ly
         fmnryhJjtPRU9Mm2guIbdouISX6+L92Y5EqKVIWqkO3pCua/Zt0+XCjHa1vRtE5DWpaj
         Pk7ki9bG0ZNXEiu2sg3fP03UwBsnr0tkbJ3aQKtOo20DswK8fDmkTISqEnOcE9cIouE4
         Ja3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KXG6VZGoAkKQHrL/ylxA7tULnj1W6vTa353gWJTyxzk=;
        b=r2G8pQ6RHUuLhFwm1hn8dyWhV1gc8XILKu+xS05R+pq2JlN+8ngPShPEXPqGluCIqs
         7CYCai17/fHOZFgbGLPw/+Xt6xpZMAGT+BiAbyIdqFdk2mpNqOGLkvbhIY1Wve+czZYt
         2mVNXa27i1KQhNe1MbWPbAxd2tPQJg8tZy148BJ2RHxXdoNH8pEloO+pPlR/jO7dGZ/n
         0sSuKdeB6MqgGq5+XpBKeYtL6GGIXRIWDkjITed6NTXuZtetzJ7JqehBxiguxlVYUzLg
         45z6zd43lG1mWLEd4G01F4yaveMAi/0kkM5K70+ROGsCQoWO8Qe+c9Ma0W5WxrYQSv58
         5YNw==
X-Gm-Message-State: APjAAAXO+VO2iEr7Dch1seDCJJJVuBOhBv3cUF6WOVj5NyuND1PbDZq1
        OFu9d7ssnj0NpxYISbZx0HTIoNaM
X-Google-Smtp-Source: APXvYqz5jUY4u90xZBIdhV79gdwz4DRVY0lq3vWbO4GcBy/p7ISsCbOeFGIWDcjdpYhSxeWD6+AEog==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr20105851wrn.212.1580117321742;
        Mon, 27 Jan 2020 01:28:41 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w13sm20377606wru.38.2020.01.27.01.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 01:28:41 -0800 (PST)
Date:   Mon, 27 Jan 2020 10:28:40 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Namjae Jeon <linkinjeon@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        valdis.kletnieks@vt.edu, sj1557.seo@samsung.com, arnd@arndb.de,
        namjae.jeon@samsung.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v13 00/13] add the latest exfat driver
Message-ID: <20200127092840.gogcrq3pozgfayiy@pali>
References: <20200121125727.24260-1-linkinjeon@gmail.com>
 <20200125213228.GA5518@lst.de>
 <20200127090409.vvv7sd2uohmliwk5@pali>
 <20200127092343.GB392535@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200127092343.GB392535@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 27 January 2020 10:23:43 Greg KH wrote:
> On Mon, Jan 27, 2020 at 10:04:09AM +0100, Pali Rohár wrote:
> > On Saturday 25 January 2020 22:32:28 Christoph Hellwig wrote:
> > > The RCU changes looks sensible to me:
> > > 
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > Great! Are there any other issues with this last version?
> > 
> > If not, Greg would you take this patch series?
> 
> Me?  I'm not the vfs/fs maintainer.

You took exfat driver (into staging), so I thought that exfat handled by you.

> And even if I was, it's _just_ too late as anything for 5.6-rc1 would
> have needed to be in linux-next already for usually at least a week.
> 
> thanks,
> 
> greg k-h

-- 
Pali Rohár
pali.rohar@gmail.com
