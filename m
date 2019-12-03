Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A648411057D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 20:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfLCTtb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 14:49:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfLCTtb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:49:31 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381D220803;
        Tue,  3 Dec 2019 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575402570;
        bh=XZYdwxIyyXzrV+GgI6eO+IzRghYU+tO8fxY7E4KpR+4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GBGFpXZ8pmDVTbUWqrO01MKmWInej3wCsbBIxpEFNf77grDTPWjQz5crY7RW0GAUl
         YAx2r1XowsvtsipWC5N7w+JAc3z71BDEHBGfg9CsuDuqPwegHUm6rojrKv9LmC8Al4
         0Mc/VUmeti9VYQhTCOqKTcthgIqrObblIWLiZ5Zk=
Message-ID: <24dc8c6760b3ea2797c13558d8eca124e2c629f1.camel@kernel.org>
Subject: Re: [PATCH v2 3/6] fs: ceph: Delete timespec64_trunc() usage
From:   Jeff Layton <jlayton@kernel.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 03 Dec 2019 14:49:29 -0500
In-Reply-To: <CABeXuvouZTBnugzNhDq2EUt8o9U-frV-xh8vsbxf+Jx6Mm4FEQ@mail.gmail.com>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
         <20191203051945.9440-4-deepa.kernel@gmail.com>
         <aef16571cebc9979c73533c98b6b682618fd64a8.camel@kernel.org>
         <CABeXuvouZTBnugzNhDq2EUt8o9U-frV-xh8vsbxf+Jx6Mm4FEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-12-03 at 11:41 -0800, Deepa Dinamani wrote:
> > Thanks Deepa. We'll plan to take this one in via the ceph tree.
> 
> Actually, deletion of the timespec64_trunc() will depend on this
> patch. Can we merge the series through a common tree? Otherwise,
> whoever takes the [PATCH 6/7] ("fs:
> Delete timespec64_trunc()") would have to depend on your tree. If you
> are ok with the change, can you ack it?
> 
> Thanks,
> Deepa

Sure, no problem if that works better for you.

Acked-by: Jeff Layton <jlayton@kernel.org>

