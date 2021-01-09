Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CA12EFDD8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 05:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbhAIE7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 23:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbhAIE7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 23:59:35 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37301C061573
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 20:58:54 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ky6Ku-008Yki-LS; Sat, 09 Jan 2021 04:58:48 +0000
Date:   Sat, 9 Jan 2021 04:58:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     yangerkun <yangerkun@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] syscalls: add comments show the define file for aio
Message-ID: <20210109045848.GS3579531@ZenIV.linux.org.uk>
References: <20210109031416.1375292-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109031416.1375292-1-yangerkun@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 09, 2021 at 11:14:16AM +0800, yangerkun wrote:
> fs/aio.c define the syscalls for aio.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

That (and the next patch) really ought to go to Arnd - I've very little
to do with the unistd.h machinery.
