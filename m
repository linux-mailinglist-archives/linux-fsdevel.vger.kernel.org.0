Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6349A14F322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 21:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAaUZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 15:25:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34587 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAaUZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:25:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so3190583plt.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 12:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q5E7ICRfCH/k+vsoYEXnl2y/W56wIiA0Rc0Fphp9Mmg=;
        b=JE4riXF0b8BiEav4xSlP1fadj/zOT5E3uce1OoNRJkditPZhbB96EPo1F9ZEmDejWu
         DAF1VqHGdRIQPmwVve/fFazFtDlnkvtv0cHgAMkgqkQe2mUdQL1xkKOQL63l8TnT5hxI
         7Tx/bwpyNzKTbx24HqEiH67rHRQMf3bEtlfh2Ldvg9B1FcnQuQGD9pQ0z3diCjrDejm3
         EHZdHovYl1YfoEKRC2enwwiAdgDYYoBaBZbXzGHKOImqPDxrTjou+RUBc7ZaUwW1bqHz
         R2Rdy5jTcgOMePNhRgBD9CHEZiykfJF3pq3L+emfWUSrDQBn36k5aWbJZeCnn4njRgxS
         Vy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q5E7ICRfCH/k+vsoYEXnl2y/W56wIiA0Rc0Fphp9Mmg=;
        b=GbbTjXj/8GyoJqZ+G/EjaHdgHLZv3Vy90eDCQPLis3694NnSIojKoO9L/7MWlmuPw8
         M+LXC54OUTHW1VJ6QUbUcTk/THVPQ8Hr1mFSeuhPS50bwitS4U6VxpZ9Bv472PVKTObc
         mneVkqLWGCMY/4QodMyGFUpXiR+OWm0YJmckuMJsO8N2lDM+xgAOs2cU6z3i143GSuZ5
         oh2mOX1tYCCe1JlmOTDX1fxYvIP9mMNv6JZlBdahOkC7PJ7BQNrbxSXP20gZnmNuIz+H
         E5fLxRqhqiVMwREc7y1PQHJN1vNI4cJEfjANdeUnBclRiYrmLOvuC5CdK7heexEKxrhv
         YfpQ==
X-Gm-Message-State: APjAAAWUVUmykce1RNtmpfPrdUjM9EjzQiNgeo6AaVTJppNB3HengJ4Y
        G6ksyKIcP/quFCxYPH8ANPZI/A==
X-Google-Smtp-Source: APXvYqx/rF4SHG+VBC/SpyIUSEV6rkxcTIKcbE+9qgpzFW/cBVySiP8GP2tGaBbjLD4P4fYTsTPuwQ==
X-Received: by 2002:a17:902:ac88:: with SMTP id h8mr11712833plr.131.1580502300885;
        Fri, 31 Jan 2020 12:25:00 -0800 (PST)
Received: from vader ([2620:10d:c090:200::2d88])
        by smtp.gmail.com with ESMTPSA id g72sm9235976pfb.11.2020.01.31.12.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:25:00 -0800 (PST)
Date:   Fri, 31 Jan 2020 12:24:59 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        kernel-team@fb.com, linux-api@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Xi Wang <xi@cs.washington.edu>
Subject: Re: [RFC PATCH v4 1/4] fs: add flags argument to i_op->link()
Message-ID: <20200131202459.GA787405@vader>
References: <5b94d23baef8c2a256384f436650f4c4868915a2.1580251857.git.osandov@fb.com>
 <cover.1580251857.git.osandov@fb.com>
 <134625.1580478522@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134625.1580478522@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 01:48:42PM +0000, David Howells wrote:
> Omar Sandoval <osandov@osandov.com> wrote:
> 
> > -	int (*link) (struct dentry *,struct inode *,struct dentry *);
> > +	int (*link) (struct dentry *,struct inode *,struct dentry *, int);
> 
> Can you make it unsigned int?
> 
> David
> 

For some reason, the linkat() syscall takes an int, but you're right,
might as well make it an unsigned int in the VFS.
