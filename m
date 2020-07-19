Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769782252F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 19:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgGSRLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:11:03 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472FBC0619D2;
        Sun, 19 Jul 2020 10:11:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxCpy-00G1OK-JZ; Sun, 19 Jul 2020 17:10:54 +0000
Date:   Sun, 19 Jul 2020 18:10:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH 0/4] fs: add mount_setattr()
Message-ID: <20200719171054.GK2786714@ZenIV.linux.org.uk>
References: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 06:14:11PM +0200, Christian Brauner wrote:

> mount_setattr() can be expected to grow over time and is designed with
> extensibility in mind. It follows the extensible syscall pattern we have
> used with other syscalls such as openat2(), clone3(),
> sched_{set,get}attr(), and others.

I.e. it's a likely crap insertion vector; any patches around that thing
will require the same level of review as addition of a brand new syscall.
And they will be harder to spot - consider the likely subjects for such
patches and compare to open addition of a new syscall...
