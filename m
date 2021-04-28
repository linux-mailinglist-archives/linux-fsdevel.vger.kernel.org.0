Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D334436E24D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 01:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhD1X5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 19:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhD1X5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:57:49 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4EC06138B;
        Wed, 28 Apr 2021 16:57:03 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C46BF727A; Wed, 28 Apr 2021 19:57:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C46BF727A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1619654222;
        bh=fBRqiq9HasBfGYA8KzoAhMaldfNtLR6I/5Za9CCIh6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hz2fPyGzk1Im35JmUrMcONqUT9ImVx8Nk0r/X0iyoWvMEP/gJIrPAlGG/aNJko8aJ
         ZDyj1uLfhQTmQFlq1hSUHQ9doy0wBo6lxvSY6wyVox0ODXISvSinMT91e5OZmKKinR
         euasbhjzyP02O1wtuOxZz3Ss5rKRn0YWQK0Xmb7I=
Date:   Wed, 28 Apr 2021 19:57:02 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     =?utf-8?B?QXVyw6lsaWVu?= Aptel <aaptel@suse.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org
Subject: Re: [PATCH v2 00/10] cifsd: introduce new SMB3 kernel server
Message-ID: <20210428235702.GE7400@fieldses.org>
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
 <20210422002824.12677-1-namjae.jeon@samsung.com>
 <20210428191829.GB7400@fieldses.org>
 <878s52w49d.fsf@suse.com>
 <20210428204035.GD7400@fieldses.org>
 <875z06vyi6.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875z06vyi6.fsf@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 12:24:17AM +0200, Aurélien Aptel wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> > I'd rather see multiple patches that were actually functional at each
> > stage: e.g., start with a server that responds to some sort of rpc-level
> > ping but does nothing else, then add basic file IO, etc.
> >
> > I don't know if that's practical.
> 
> Although it would certainly be nice I don't think it's realistic to
> expect this kind of retro-logical-rewriting. AFAIK the other new
> fs-related addition (ntfs patchset) is using the same trick of adding
> the Makefile at the end after it was suggested on the mailing list. So
> there's a precedent.

OK, I wondered if that might be the case.

I don't love it, but, fair enough, maybe that's the best compromise.

--b.
