Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065881A074F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 08:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDGGbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 02:31:44 -0400
Received: from nautica.notk.org ([91.121.71.147]:47617 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgDGGbo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:31:44 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 4A516C009; Tue,  7 Apr 2020 08:31:42 +0200 (CEST)
Date:   Tue, 7 Apr 2020 08:31:27 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     L29Ah <l29ah@cock.li>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [GIT PULL] 9p update for 5.7
Message-ID: <20200407063127.GA30642@nautica>
References: <20200406110702.GA13469@nautica>
 <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica>
 <20200407021626.cd3wwbg7ayiwt4ry@l29ah-x201.l29ah-x201>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407021626.cd3wwbg7ayiwt4ry@l29ah-x201.l29ah-x201>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

L29Ah wrote on Tue, Apr 07, 2020:
> In fact i would prefer disabling the full reads unconditionally, but
> AFAIR some userspace programs might interpret a short read as EOF (and
> also would need to check the logic that motivated the kernel-side
> looping).

Willy is correct there we can't just do that, way too many applications
would break.

I think O_NONBLOCK on regular files is a good compromise, let's not go
overboard :)

-- 
Dominique
