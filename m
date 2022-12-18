Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7812064FD2A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 01:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiLRAIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 19:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiLRAIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 19:08:30 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1141AFD2E;
        Sat, 17 Dec 2022 16:08:15 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id E0E3EC01E; Sun, 18 Dec 2022 01:08:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671322104; bh=fpdmOXqM/1kKApXJ+tHnkN+bPDRrjJAPZaqdIQ6rhX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dd0JsioLyY1v4lskIi8f+uw1Ud3R0b+I4kO1xhjMKj0salbZygSWzeUY58cFp6Pyt
         R6O8IS+voDBeFSFjlYkGj8o2utPjz+8a98AFm4jomBHBlH3UQ+0c/Vi/HVWmGyJ+LZ
         8MLCTr8acHTnmSmcyPHHD1ULjOGIp4UZ54C6qxFJVgKJiPoGoPl9bwxCDihW5Ma+TV
         6qZRsr1rJSZHqsg9EoAUly/6yq53bosl5/n0h9D3fCbZqIwRWe+pcDg7krCp919/+c
         mYBmusINURukm+Jk7cgUNtQ0bwjAFdauh3I49sirSabpSfn3BLYX8nBEuae7IikZ7G
         PLOkA8VufHHqQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 091BCC009;
        Sun, 18 Dec 2022 01:08:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671322104; bh=fpdmOXqM/1kKApXJ+tHnkN+bPDRrjJAPZaqdIQ6rhX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dd0JsioLyY1v4lskIi8f+uw1Ud3R0b+I4kO1xhjMKj0salbZygSWzeUY58cFp6Pyt
         R6O8IS+voDBeFSFjlYkGj8o2utPjz+8a98AFm4jomBHBlH3UQ+0c/Vi/HVWmGyJ+LZ
         8MLCTr8acHTnmSmcyPHHD1ULjOGIp4UZ54C6qxFJVgKJiPoGoPl9bwxCDihW5Ma+TV
         6qZRsr1rJSZHqsg9EoAUly/6yq53bosl5/n0h9D3fCbZqIwRWe+pcDg7krCp919/+c
         mYBmusINURukm+Jk7cgUNtQ0bwjAFdauh3I49sirSabpSfn3BLYX8nBEuae7IikZ7G
         PLOkA8VufHHqQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 1d3f7940;
        Sun, 18 Dec 2022 00:08:07 +0000 (UTC)
Date:   Sun, 18 Dec 2022 09:07:52 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <evanhensbergen@icloud.com>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH 2/6] Don't assume UID 0 attach
Message-ID: <Y55Z2DwZgRG+9zW3@codewreck.org>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
 <20221217185210.1431478-3-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221217185210.1431478-3-evanhensbergen@icloud.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Dec 17, 2022 at 06:52:06PM +0000:
> The writeback_fid fallback code assumes a root uid fallback which
> breaks many server configurations (which don't run as root).  This
> patch switches to generic lookup which will follow argument
> guidence on access modes and default ids to use on failure.

Unfortunately this one will break writes to a file created as 400 I
think
That's the main reason we have this writeback fid afaik -- there are
cases where the user should be able to write to the file, but a plain
open/write won't work... I can't think of anything else than open 400
right now though

I'm sure there's an xfs_io command and xfstest for that, but for now:
python3 -c 'import os; f = os.open("testfile", os.O_CREAT + os.O_RDWR, 0o400); os.write(f, b"ok\n")'

iirc ganesha running as non-root just ignores root requests and opens as
current user-- this won't work for this particular case, but might be
good enough for you... With that said:

> There is a deeper underlying problem with writeback_fids in that
> this fallback is too standard and not an exception due to the way
> writeback mode works in the current implementation.  Subsequent
> patches will try to associate writeback fids from the original user
> either by flushing on close or by holding onto fid until writeback
> completes.

If we can address this problem though I agree we should stop using
wrieback fids as much as we do.
Now fids are refcounted, I think we could just use the normal fid as
writeback fid (getting a ref), and the regular close will not clunk it
so delayed IOs will pass.

Worth a try?
-- 
Dominique
