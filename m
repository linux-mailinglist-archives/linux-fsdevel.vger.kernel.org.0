Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC14463C09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 21:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfGITkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 15:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfGITkE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:40:04 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163062082A;
        Tue,  9 Jul 2019 19:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562701203;
        bh=oS2Acvk9n7QZUDRZRWI2hJ5hiJ/akB4hbMEUJJl1dxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZiTINaQ9y1fuiilmmJ9Rh6nqxxRKORUXIRuK/aFSgM+An/z72pzIkewiHPpJvf6mk
         xRdFANzjWM1VcHeWLYb4nqDRJs5IJptMUTr0YpB7yvPkloiFXIMp19c2yR3CuQMagU
         fTbEKTpx7VevL6WUr105j2nsVo5pIjOjYrX7ofjw=
Date:   Tue, 9 Jul 2019 12:40:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190709194001.GG641@sol.localdomain>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
 <20190701164536.GA202431@gmail.com>
 <20190701182239.GA17978@ZenIV.linux.org.uk>
 <20190702182258.GB110306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702182258.GB110306@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:22:59AM -0700, Eric Biggers wrote:
> 
> Sure, but the new mount syscalls still need tests.  Where are the tests?
> 

Still waiting for an answer to this question.

Did we just release 6 new syscalls with no tests?

I don't understand how that is even remotely acceptable.

- Eric
