Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80B356A32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 15:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfFZNRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 09:17:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44158 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFZNRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:17:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so1848740oib.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2019 06:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqdD5BglIz2bjpJLm9xusDo7QNINbb60fVv8fvyF9fM=;
        b=LhTOUPVPy6E+mLjttE3vPrVzPJInqU0dE83jrs05PRUJ9bGtdG1Df629Xm+75L+/Sb
         kh8/I5lYWotyNuWzYWJyb68V6jy7WJjNBS0JTPt2myNAdxoWBCcgAKyuPvgqAEeod4/H
         zSqRehez3RlD95n90pH1Y2huT5skU8CQh5Ymg5rBQU0vi7ZSjNCTrp70/6LZdwWdZMzk
         Z0Zip6vCixaB8T5KaCoR0T8tsMDpskyOpEGzp8iDckT7TVVkHSSUKO16/xZavPoe/FiQ
         gqXZDuP4bq+pSoZ7sH7qAUAFeu9zNrcAUTyC5AT5b6+s+kjjc9HYFujRoUhwZjrool/V
         oAug==
X-Gm-Message-State: APjAAAU8LKougwfQBRU2rPYkW2t0P6mvBL9JUM522TmgY3E1+h1Lu6yH
        fajg548efJa+z5ywtHihj5YY/eYiNU2wTusmT1K9hg==
X-Google-Smtp-Source: APXvYqy5bRoQuv2KPD9FNgGoEEIj898miACPAEp8kvaWAT78qxVLLGsyqiFSwuc3jqzugKz4zH1MYrfKjHMZGZ9BxOg=
X-Received: by 2002:aca:b58b:: with SMTP id e133mr1722182oif.147.1561555073935;
 Wed, 26 Jun 2019 06:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190626120333.13310-1-agruenba@redhat.com> <20190626125502.GB4744@lst.de>
In-Reply-To: <20190626125502.GB4744@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 26 Jun 2019 15:17:42 +0200
Message-ID: <CAHc6FU5suCE2-TtNMR4mGZ5DHB+3diVL=uUwccKES=eHwSPYkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: don't mark the inode dirty in iomap_write_end
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 26 Jun 2019 at 14:55, Christoph Hellwig <hch@lst.de> wrote:
> Doesn't the series also need a third patch reducing the amount
> of mark_inode_dirty calls as per your initial proposal?

The page dirtying already reduces from once per page to once per
mapping, so that should be good enough.

Thanks,
Andreas
