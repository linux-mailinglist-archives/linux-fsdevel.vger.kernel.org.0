Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B57DF4C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfJUSF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 14:05:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44108 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbfJUSF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:05:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so8257552pgd.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qMv7Aq/EKWcqrxVLodIHRmz/ZNgPTOxblOtF0zmUyA=;
        b=mIsrtuZI2pu1seVtPlHpFnpNq+53C91o7GSE9m8ZZybgJznhZYmp7QTkGlNqwNeFSS
         2uhxou+IVzBM5+QFoaY8QhGw4uUKqPHrCzXZz1p7VXVUk/KvNqucynnGFl+YWiQVnA7s
         n92vAF01jaMsePBRl2+TS53rKcJSilmCX+gDbBTE+YFiAh1ylXDHQ0ldqmO5Iadul4DE
         lhinrgTVgse144a3Y1Fo4tILDk+oEe4XKklmBPdSEX+M79ZZ7R6rM5u+Mbv6ikXBoE9j
         M3BhuQ/NSOOEdbgxDNWtbRH8eJGymYBxle2X6yFH3E027XXR/U0SmN79UgFroryXLN/8
         pX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qMv7Aq/EKWcqrxVLodIHRmz/ZNgPTOxblOtF0zmUyA=;
        b=E1ZUKMx5ZtQlMnn0rwinvD0bVh3SXpgMO0R1peNVx5Zvu5TrKZemGVgvLywXp6iKYh
         ckg5/cUIGdoq0dw5SHwexYa0PoVzo/M3PXwmiR81ADhSYpmDdf6BHxfX1OsSffgxj1q2
         t/cq9dpwOtvlgY3lJHeEhO/38MBc8cl2X+mRhmbcDxZpK5h/XP/B5rJxPvRo9+uVpoDj
         xftLyVTmzTLr0EXd11zgnvyIwbvmqYbQnI4oHq0jojZaTfHHR4Wd4YS9npzt1DXYYveX
         DAZi2LgLTdVxhlUqEjSWCtuwvWpWNnEqpKNqoMmYox0efOsa6vP4XWzbXr4Zqi/u4Fov
         W32w==
X-Gm-Message-State: APjAAAU4TvigxFJsgmMGCyoli5keBiraDHIGcIPDuw+5tYQyXyJBM9PF
        FNtn8R1Vf0jlhJa9rTy2rlr04A==
X-Google-Smtp-Source: APXvYqzxVOSpakbgchAj/0P4pwxdp36727zPto9TUN70iw399TJ9wp8rkaQTKKWIbUxovXt9MA4Lrg==
X-Received: by 2002:a65:638a:: with SMTP id h10mr26701649pgv.388.1571681123766;
        Mon, 21 Oct 2019 11:05:23 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:4637])
        by smtp.gmail.com with ESMTPSA id k31sm17586704pjb.14.2019.10.21.11.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 11:05:22 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:05:22 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/5] btrfs: implement RWF_ENCODED writes
Message-ID: <20191021180522.GA81648@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <904de93d9bbe630aff7f725fd587810c6eb48344.1571164762.git.osandov@fb.com>
 <0da91628-7f54-7d24-bf58-6807eb9535a5@suse.com>
 <20191018225513.GD59713@vader>
 <20191021131452.GH3001@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021131452.GH3001@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 03:14:52PM +0200, David Sterba wrote:
> On Fri, Oct 18, 2019 at 03:55:13PM -0700, Omar Sandoval wrote:
> > > > +	nr_pages = (disk_num_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > > 
> > > nit: nr_pages = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE)
> > 
> > disk_num_bytes is a u64, so that would expand to a 64-bit division. The
> > compiler is probably smart enough to optimize it to a shift, but I
> > didn't want to rely on that, because that would cause build failures on
> > 32-bit.
> 
> There are several DIV_ROUND_UP(u64, PAGE_SIZE) in btrfs code, no build
> brekages have been reported so far, you can use it.

Good to know, I'll fix both places I'm doing this, then.
