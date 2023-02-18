Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9C69B921
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBRJeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 04:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRJeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:34:20 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2112749F;
        Sat, 18 Feb 2023 01:34:19 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id C5B28C01E; Sat, 18 Feb 2023 10:34:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676712881; bh=E884Tz22K/Co/R04bfibdcUOiKaUHRaF1+DKvwAJTQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeSKJObDERH8XBFwBs9fIHaUKAMJj1p9Czs/RlHJ/dIXpjmuW479p8T2xBVIRstEI
         JCguBoY2UmXzSVyRTRCrK4CqAk1vX9vI3t4yV0JyIQdXWxSbygDTWQ7nWRZ+lY4AC2
         GoBxHFg//doGZepK3rNmC1fTBP6daRiD3/zIBr5YhO2Kgk3TLDIAhpmeNmS6Sw14xI
         IaVi2MVaQcT+YrH873SmZ+yWEOjriN4yF6QZgmWO6h7WLm/MF2UfnBJDUnmuytMFDg
         oFaOMBIN6Ly3yw8OqaTjy4jhPk3e2ThHI+u2ulw8o6ajxk8eR8SlyI8S93hM6Gi2JS
         QSK3nxLES0+mQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id F0C4EC009;
        Sat, 18 Feb 2023 10:34:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676712881; bh=E884Tz22K/Co/R04bfibdcUOiKaUHRaF1+DKvwAJTQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeSKJObDERH8XBFwBs9fIHaUKAMJj1p9Czs/RlHJ/dIXpjmuW479p8T2xBVIRstEI
         JCguBoY2UmXzSVyRTRCrK4CqAk1vX9vI3t4yV0JyIQdXWxSbygDTWQ7nWRZ+lY4AC2
         GoBxHFg//doGZepK3rNmC1fTBP6daRiD3/zIBr5YhO2Kgk3TLDIAhpmeNmS6Sw14xI
         IaVi2MVaQcT+YrH873SmZ+yWEOjriN4yF6QZgmWO6h7WLm/MF2UfnBJDUnmuytMFDg
         oFaOMBIN6Ly3yw8OqaTjy4jhPk3e2ThHI+u2ulw8o6ajxk8eR8SlyI8S93hM6Gi2JS
         QSK3nxLES0+mQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 9fb8d6b6;
        Sat, 18 Feb 2023 09:34:12 +0000 (UTC)
Date:   Sat, 18 Feb 2023 18:33:57 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 04/11] fs/9p: Remove unnecessary superblock flags
Message-ID: <Y/CbhQVeO8/pxrBE@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-5-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-5-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:16AM +0000:
> These flags just add unnecessary extra operations.
> When 9p is run without cache, it inherently implements
> these options so we don't need them in the superblock
> (which ends up sending extraneous fsyncs, etc.).  User
> can still request these options on mount, but we don't
> need to set them as default.

Hm, I don't see where they'd add any operations -- if you have time
would you mind pointing me at some?

As far as I can see, it's just about 'sync' or 'dirsync' in /proc/mounts
and the ST_SYNCHRONOUS statvfs flag; that looks harmless to me and it
looks more correct to keep to me.

(Sorry, didn't take the time to actually try taking a trace; I've
checked the flag itself and the IS_SYNC/IS_DIRSYNC -> inode_needs_sync
wrappers and that only seems used by specific filesystems who'd care
about users setting the mount options, not the other way aorund.)

-- 
Dominique
