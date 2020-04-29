Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8751BE309
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 17:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgD2Ppe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 11:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgD2Ppd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:45:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E217C03C1AD
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 08:45:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b24so1455960lfp.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OKvac1bajpItzhuenoL2HhjmxuXDr5Pv3lediBuvToA=;
        b=fj7G1yNMGZ4U9adER/SwvrxROAJuHEUwx5/7bjSlCepoQn+CLaO3UAR5ooi49ffT28
         LH8SJNVZ5+dXaFiRqscVxkwdEeobr6IOxd6iSLZlvIW/jnvDxoa7ro7AK9ByEzf3HWpn
         JJWo8iNIwQK3IlHBvFqAmC7IsgQ8/vfUJxOULOuRgH9PmCsvAzYleoc/ENnjJMODKUaE
         LPb7e4nudKBXnQxAJTrLUMtFgl/TCG026A7jHFR5RCQr45GK6A6KE1JbMoa7VRIjmXlc
         YYDJD1ux+paGDEFfmEdDyxXTuFkysOIGzN1CC2qB69legGjSa9PJSWP01LvxLfme/t+y
         /4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OKvac1bajpItzhuenoL2HhjmxuXDr5Pv3lediBuvToA=;
        b=tGXk6F+gYAjyGu7u3t+hZAUuMvG9gPnEIZOx0ZIM8nuYMf4ur7XEC6NvTj4mRN2Ypj
         oo5HCgKGolP+YxvSwzeBKO275KmE21xQhUbStSM0nJXvrXhI2wYGJYZWX+qyRh+KuCPK
         52Pe3A1YQ9VIdftIEx5uPaw0E37RjFqZIYpIbfuJPIEuUfZcwgZFFNWG8Fjt0RmjIpM/
         wCzSiC7TetUZ7nyC9dDMfm50GWJZHYac2dG1us2MgGdaiVP8Qke9k9JeWXsAsViSIp8k
         X3iHS4w6muBnK1jhl+wat9sakIHEhanydij7mWeo9cWahCdHFjG/8DGqLdFDY959zAFs
         XC1w==
X-Gm-Message-State: AGi0PubNnXKnb9dMLVPpfIxyIsFLiDzhI9JAxAcxIR3ckBLUZyFZxFjY
        FlpWxxSzmswCS76yKoMWaF5uLVFYuwI=
X-Google-Smtp-Source: APiQypIrZoH6DqAujBzByLFpfg9w+AwrbJ28FDDtVgAMbJYdCn0iLRrLohVlWs/WetSSt7iE1U5ggw==
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr23290266lfo.19.1588175131830;
        Wed, 29 Apr 2020 08:45:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r12sm2447765ljc.12.2020.04.29.08.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 08:45:31 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 68BC21021F9; Wed, 29 Apr 2020 18:45:42 +0300 (+03)
Date:   Wed, 29 Apr 2020 18:45:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/25] Large pages in the page cache
Message-ID: <20200429154542.kcqrtu3zrui5r6ah@box>
References: <20200429133657.22632-1-willy@infradead.org>
 <20200429154002.n3mq2ysz37puf73y@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429154002.n3mq2ysz37puf73y@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 06:40:02PM +0300, Kirill A. Shutemov wrote:
> On Wed, Apr 29, 2020 at 06:36:32AM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This patch set does not pass xfstests.  Test at your own risk.  It is
> > based on the readahead rewrite which is in Andrew's tree.  The large
> > pages somehow manage to fall off the LRU, so the test VM quickly runs
> > out of memory and freezes.  To reproduce:
> > 
> > # mkfs.xfs /dev/sdb && mount /dev/sdb /mnt && dd if=/dev/zero bs=1M count=2048 of=/mnt/bigfile && sync && sleep 2 && sync && echo 1 >/proc/sys/vm/drop_caches 
> > # /host/home/willy/kernel/xarray-2/tools/vm/page-types | grep thp
> > 0x0000000000401800	       511        1  ___________Ma_________t____________________	mmap,anonymous,thp
> > 0x0000000000405868	         1        0  ___U_lA____Ma_b_______t____________________	uptodate,lru,active,mmap,anonymous,swapbacked,thp
> > # dd if=/mnt/bigfile of=/dev/null bs=2M count=5
> > # /host/home/willy/kernel/xarray-2/tools/vm/page-types | grep thp
> > 0x0000000000400000	      2516        9  ______________________t____________________	thp
> > 0x0000000000400028	         1        0  ___U_l________________t____________________	uptodate,lru,thp
> > 0x000000000040006c	       106        0  __RU_lA_______________t____________________	referenced,uptodate,lru,active,thp
> 
> Note that you have 107 pages on LRU. It is only head pages. With order-5
> pages it is over 13MiB.
> 
> Looks like everything is fine.

/proc/kpageflags reads page's flag bit directly instead of relying on
PageLRU:

	u |= kpf_copy_bit(k, KPF_LRU,		PG_lru);

Tail pages don't have this bit set. They rely on head page's flag for
PageLRU().

It would be nice to get it fixed, but I guess it is too late. Somebody may
rely on the current behaviour by now.

-- 
 Kirill A. Shutemov
