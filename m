Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFCFDA46E2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 05:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfIADGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 23:06:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48396 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfIADGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 23:06:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i4GB0-0003T3-F3; Sun, 01 Sep 2019 03:05:19 +0000
Date:   Sun, 1 Sep 2019 04:05:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190901030514.GC1131@ZenIV.linux.org.uk>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police>
 <20190831064616.GA13286@infradead.org>
 <295233.1567247121@turing-police>
 <20190901010721.GG7777@dread.disaster.area>
 <20190901013715.GA8243@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901013715.GA8243@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 09:37:19AM +0800, Gao Xiang wrote:

> fs/orangefs/file.c
>  19 static int flush_racache(struct inode *inode)

Just why the hell would _that_ one be a problem?  It's static in
file; it can't pollute the namespace even if linked into the
kernel.

Folks, let's keep at least some degree of sanity - this is sinking
to the level of certain killfile denizens...
