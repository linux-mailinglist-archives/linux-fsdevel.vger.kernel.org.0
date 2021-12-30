Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F5F48202D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 21:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhL3UGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 15:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhL3UGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:06:54 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2F3C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 12:06:54 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n31hK-00G4Sl-9s; Thu, 30 Dec 2021 20:06:50 +0000
Date:   Thu, 30 Dec 2021 20:06:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Hans Montero <hjm2133@columbia.edu>, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>,
        Xijiao Li <xl2950@columbia.edu>,
        OS-TA <cucs4118-tas@googlegroups.com>
Subject: Re: Question about `generic_write_checks()` FIXME comment
Message-ID: <Yc4RWoKfLFjwyG01@zeniv-ca.linux.org.uk>
References: <CAMqPytVSCD+6ER+uXa-SrXQCpY-U-34G1jWmprR1Zgag+wBqTA@mail.gmail.com>
 <Yc4Czk5A+p5p2Y4W@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc4Czk5A+p5p2Y4W@mit.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 30, 2021 at 02:04:46PM -0500, Theodore Ts'o wrote:

>  But as Al Viro pointed out, O_APPEND really can't have any real
>  meaning for a block device.  It would be neat if we could magically
>  make a 10TB HDD to become as 12TB HDD by writing 2TB using
>  O_APPEND, but reality doesn't work that way.  :-)
> 
> It probably makes sense just to remove the FIXME from the current
> kernel sources so that future people don't get confused, asking the
> same questions you have.

*nod*
