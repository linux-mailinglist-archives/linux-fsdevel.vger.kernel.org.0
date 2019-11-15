Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7D8FDF16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 14:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKONjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 08:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfKONjo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:39:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CF9220728;
        Fri, 15 Nov 2019 13:39:42 +0000 (UTC)
Date:   Fri, 15 Nov 2019 08:39:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH 1/3] dcache: add a new enum type for
 'dentry_d_lock_class'
Message-ID: <20191115083941.68e52b87@gandalf.local.home>
In-Reply-To: <20191115083813.65f5523c@gandalf.local.home>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
        <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
        <20191115032759.GA795729@kroah.com>
        <20191115041243.GN26530@ZenIV.linux.org.uk>
        <20191115072011.GA1203354@kroah.com>
        <20191115131625.GO26530@ZenIV.linux.org.uk>
        <20191115083813.65f5523c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Nov 2019 08:38:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> My guess is that debugfs was written to be as simple as possible.
> Nothing too complex. And in doing so, may have issues as you are
> pointing out. Just a way to allow communications between user space and
> kernel space (as tracefs started out).

And speaking of tracefs, as it was basically a cut and paste copy of
debugfs, it too has the same issues. Thus, I'm very much interested in
how this should be done.

-- Steve
