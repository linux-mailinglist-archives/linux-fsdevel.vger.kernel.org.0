Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49C6F6059
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2019 17:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfKIQ4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Nov 2019 11:56:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42054 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfKIQ4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Nov 2019 11:56:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id z12so6771284lfj.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Nov 2019 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2juaR4N9HkKYkFj/Me6q1Rmtkh59YUIyKDzT0tJwhA=;
        b=SHWwPuPL46oT9TwssCs5E9HQgkXl78UXPuMPT9c5C1bWX24ruixFw09ayc1bpEFfYB
         Qz8vyyLhUHRS/caCQMeX4nzgDzvp6CgXz3CyvTlXvw6VSIODM46GtlVnJBa9ER3phQHm
         kIoEXR7Y/uMwwhVWg3aWDaLXeIMzl4lzn3kek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2juaR4N9HkKYkFj/Me6q1Rmtkh59YUIyKDzT0tJwhA=;
        b=HMr9IV5cx66FVz/0qZsP/1cdMJ6uTvGRTXE6hQVdIjpE044vPMB4r5dIT2cPYZcpA+
         0UTWU/fhOQVhq9d6Xmz0UAqT6LxAuP4kFLKCB25TTOBWXrmhuReFHjfv5jmW1ZxsVFsG
         4lnviajebiM/OCB5308ciDw2UZD4f0uPggrD1dEbd7vDfA+ou+6KR7RjhBru9yr1XWvy
         mOpHiKExfeSGljTCcWihMikLbvNhIIaWm5/antjzW5t53XgAXASa3dprPttrTEpzA3mT
         uZkZVEuyRA1v/qzRuhX1R9ky35WaebzMMuqkUX8sbwFNQGR1n0vFuQ+45cNTxW44JRNb
         HoSA==
X-Gm-Message-State: APjAAAVWF8e4SW8ilf1YBUFFQ5X/KAWxSJpupAD/Z7QpLiXW7G5sY/22
        JBr8mj4TV4rLPw1CgpVELfvlDWQt1DY=
X-Google-Smtp-Source: APXvYqxmkF8uJK0sB9zQlg1RjLWyA7Py9ypzA2SPAHbnY5pF08kYSYn+X14k2mRZa/TbyKiDf5v6Ww==
X-Received: by 2002:a19:41c8:: with SMTP id o191mr10404544lfa.101.1573318557813;
        Sat, 09 Nov 2019 08:55:57 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id p4sm4944607ljp.103.2019.11.09.08.55.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 08:55:54 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id y23so9388159ljh.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Nov 2019 08:55:54 -0800 (PST)
X-Received: by 2002:a2e:982:: with SMTP id 124mr2080671ljj.48.1573318554230;
 Sat, 09 Nov 2019 08:55:54 -0800 (PST)
MIME-Version: 1.0
References: <20190927044243.18856-1-riteshh@linux.ibm.com> <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com> <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk> <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk> <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk> <20191109031333.GA8566@ZenIV.linux.org.uk>
In-Reply-To: <20191109031333.GA8566@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Nov 2019 08:55:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9e5PDG-y-j6uryc0RCbfZ36yB0a8qBb2hCWNrH4r_3g@mail.gmail.com>
Message-ID: <CAHk-=wg9e5PDG-y-j6uryc0RCbfZ36yB0a8qBb2hCWNrH4r_3g@mail.gmail.com>
Subject: Re: [PATCH][RFC] race in exportfs_decode_fh()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wugyuan@cn.ibm.com, Jeff Layton <jlayton@kernel.org>,
        hsiangkao@aol.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:13 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> We have derived the parent from fhandle, we have a disconnected dentry for child,
> we go look for the name.  We even find it.  Now, we want to look it up.  And
> some bastard goes and unlinks it, just as we are trying to lock the parent.
> We do a lookup, and get a negative dentry.  Then we unlock the parent... and
> some other bastard does e.g. mkdir with the same name.  OK, nresult->d_inode
> is not NULL (anymore).  It has fuck-all to do with the original fhandle
> (different inumber, etc.) but we happily accept it.

No arguments with your patch, although I doubt that this case has
actually ever happened in practice ;)

              Linus
