Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10178FE726
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 22:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfKOV0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 16:26:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfKOV0N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:26:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B206520733;
        Fri, 15 Nov 2019 21:26:11 +0000 (UTC)
Date:   Fri, 15 Nov 2019 16:26:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [RFC] simple_recursive_removal()
Message-ID: <20191115162609.2d26d498@gandalf.local.home>
In-Reply-To: <20191115211820.GV26530@ZenIV.linux.org.uk>
References: <20191115041243.GN26530@ZenIV.linux.org.uk>
        <20191115072011.GA1203354@kroah.com>
        <20191115131625.GO26530@ZenIV.linux.org.uk>
        <20191115083813.65f5523c@gandalf.local.home>
        <20191115134823.GQ26530@ZenIV.linux.org.uk>
        <20191115085805.008870cb@gandalf.local.home>
        <20191115141754.GR26530@ZenIV.linux.org.uk>
        <20191115175423.GS26530@ZenIV.linux.org.uk>
        <20191115184209.GT26530@ZenIV.linux.org.uk>
        <20191115194138.GU26530@ZenIV.linux.org.uk>
        <20191115211820.GV26530@ZenIV.linux.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Nov 2019 21:18:20 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> OK... debugfs and tracefs definitely convert to that; so do, AFAICS,
> spufs and selinuxfs, and I wouldn't be surprised if it could be
> used in a few more places...  securityfs, almost certainly qibfs,
> gadgetfs looks like it could make use of that.  Maybe subrpc
> as well, but I'll need to look in details.  configfs won't,
> unfortunately...

Thanks Al for looking into this.

I'll try to test it in tracefs, and see if anything breaks. But
probably wont get to it till next week.

-- Steve
