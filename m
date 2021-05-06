Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE7375293
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 12:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhEFKqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 06:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhEFKqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 06:46:49 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61238C061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 May 2021 03:45:51 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id F2077C01E; Thu,  6 May 2021 12:45:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620297949; bh=Eltaj5kPUBECH6pcqch9h0zKaBV/rygrZqCSkbQ3rss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJevDN92IQquziUxoSTJFLVXkY7jMwonWwB50L/65vlY4p3Onut63bA6UrRWzPUoV
         Q8tEM29ABRCZb0Qjk8+0MLeIc2WQkN9gibCE4J+n4ZuIJaYvLfvoBvbdqAEVoH7KPc
         d30DPERtKbgjx6IZeJZm7ix/rmeazh/v6dBAMwahYqqDSXq/X/o8A15pKYy2Lxi2LG
         YuPlZoeNRgCLEJ8Rb3WkhVtQ9lknjJ+GhP4DUsK1UZV4sUHVLYGiodzoNmgroaUgF8
         FeNJo5I2INyPzohhTeEl4yuU2AxlnIXUqp5zhW+0qS4owNNAFT+2n1Zpc/FhzAMoY6
         v0wbNVdp//t9Q==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 65A06C009;
        Thu,  6 May 2021 12:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620297949; bh=Eltaj5kPUBECH6pcqch9h0zKaBV/rygrZqCSkbQ3rss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJevDN92IQquziUxoSTJFLVXkY7jMwonWwB50L/65vlY4p3Onut63bA6UrRWzPUoV
         Q8tEM29ABRCZb0Qjk8+0MLeIc2WQkN9gibCE4J+n4ZuIJaYvLfvoBvbdqAEVoH7KPc
         d30DPERtKbgjx6IZeJZm7ix/rmeazh/v6dBAMwahYqqDSXq/X/o8A15pKYy2Lxi2LG
         YuPlZoeNRgCLEJ8Rb3WkhVtQ9lknjJ+GhP4DUsK1UZV4sUHVLYGiodzoNmgroaUgF8
         FeNJo5I2INyPzohhTeEl4yuU2AxlnIXUqp5zhW+0qS4owNNAFT+2n1Zpc/FhzAMoY6
         v0wbNVdp//t9Q==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id b339a217;
        Thu, 6 May 2021 10:45:43 +0000 (UTC)
Date:   Thu, 6 May 2021 19:45:28 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
Message-ID: <YJPIyLZ9ofnPy3F6@codewreck.org>
References: <87czu45gcs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87czu45gcs.fsf@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Luis Henriques wrote on Thu, May 06, 2021 at 11:03:31AM +0100:
> I've been seeing fscache complaining about duplicate cookies in 9p:
> 
>  FS-Cache: Duplicate cookie detected
>  FS-Cache: O-cookie c=00000000ba929e80 [p=000000002e706df1 fl=226 nc=0 na=1]
>  FS-Cache: O-cookie d=0000000000000000 n=0000000000000000
>  FS-Cache: O-key=[8] '0312710100000000'
>  FS-Cache: N-cookie c=00000000274050fe [p=000000002e706df1 fl=2 nc=0 na=1]
>  FS-Cache: N-cookie d=0000000037368b65 n=000000004047ed1f
>  FS-Cache: N-key=[8] '0312710100000000'

> It's quite easy to reproduce in my environment by running xfstests using
> the virtme scripts to boot a test kernel.  A quick look seems to indicate
> the warning comes from the v9fs_vfs_atomic_open_dotl() path:
> 
> [...]
> 
> Is this a know issue?

I normally don't use fscache so never really looked into it, I saw it
again recently when looking at David's fscache/netfs work and it didn't
seem to cause real trouble without a server but I bet it would if there
were to be one, I just never had the time to look further.

From a quick look v9fs uses the 'qid path' of the inode that is
supposed to be a unique identifier; in practice there are various
heuristics to it depending on the server but qemu takes the st_dev of
the underlying filesystem and chops the higher bits of the inode number
to make it up -- see qid_path_suffixmap() in hw/9pfs/9p.c in qemu
sources.

(protocol description can be found here:
https://github.com/chaos/diod/blob/master/protocol.md
)


In this case if there is a cookie collision there are two possibilities
I can see: either a previously hashed inode somehow got cleaned up
without the associated fscache cleanup or qemu dished out the same qid
path for two different files -- old filesystems used to have predictable
inode numbers but that is far from true anymore so it's quite possible
some files would have the same lower bits for their inode number on the
host...
If you have the time to investigate further that would be appreciated, I
have confirmed the fscache rework David suggested did not fix it so the
work will not be lost.


That's going to be very verbose but if you're not scared of digging at
logs a possible way to confirm qid identity would be to mount with -o
debug=5 (P9_DEBUG_9P + ERROR), all qid paths are logged to dmesg, but
that might not be viable if there is a real lot -- it depends on how
fast and reliable your quite easy to reproduce is...


Thanks,
-- 
Dominique
