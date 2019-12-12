Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4221D11CDED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 14:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfLLNOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 08:14:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47726 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbfLLNOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:14:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifOIT-0004ep-6P; Thu, 12 Dec 2019 13:14:25 +0000
Date:   Thu, 12 Dec 2019 13:14:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: corrupted list in __dentry_kill (2)
Message-ID: <20191212131425.GF4203@ZenIV.linux.org.uk>
References: <20191212104355.24672-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212104355.24672-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 06:43:55PM +0800, Hillf Danton wrote:

> Unpin dentry no more than once as it's pinned only once.

The first time is on the entry into simple_recursive_removal(), by
+       struct dentry *this = dget(dentry);

