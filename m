Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF91936E075
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 22:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbhD1UlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 16:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhD1UlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:41:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5202AC06138A;
        Wed, 28 Apr 2021 13:40:36 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 42906727A; Wed, 28 Apr 2021 16:40:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 42906727A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1619642435;
        bh=N+oITBmKkEW76qibm4RYpln6VObBvQpenPBFkPLgScc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7OLm28cyGPOFFcEVvS7P0NTGkDIi2gK9yzVpGOnBBugiUmFmQbaOx8QiWkmhDupj
         gaQvPwrCBbbiboET6JlfONlAtRVJT4l7gl06GVBqjT3LLyKdVLddpsZ4hSPgRUGyMy
         TyX+aFsW5Gr53j/gJnBZXoXhKtHBj9j/KYoEh14M=
Date:   Wed, 28 Apr 2021 16:40:35 -0400
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
Message-ID: <20210428204035.GD7400@fieldses.org>
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
 <20210422002824.12677-1-namjae.jeon@samsung.com>
 <20210428191829.GB7400@fieldses.org>
 <878s52w49d.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878s52w49d.fsf@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:19:58PM +0200, Aurélien Aptel wrote:
> bfields@fieldses.org (J. Bruce Fields) writes:
> > On Thu, Apr 22, 2021 at 09:28:14AM +0900, Namjae Jeon wrote:
> >> This is the patch series for cifsd(ksmbd) kernel server.
> >
> > Looks like this series probably isn't bisectable.  E.g. while looking at
> > the ACL code I noticed ksmbd_vfs_setxattr is defined in a later patch
> > than it's first used in.
> 
> The Kconfig and Makefile are added in the last patch so it should be ok.

I'm not sure if doing that way is really any better than making it one
big patch.

I'd rather see multiple patches that were actually functional at each
stage: e.g., start with a server that responds to some sort of rpc-level
ping but does nothing else, then add basic file IO, etc.

I don't know if that's practical.

--b.
