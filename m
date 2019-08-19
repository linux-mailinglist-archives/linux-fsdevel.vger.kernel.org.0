Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF3994F42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfHSUpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 16:45:15 -0400
Received: from sonic310-21.consmr.mail.gq1.yahoo.com ([98.137.69.147]:41246
        "EHLO sonic310-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727971AbfHSUpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566247513; bh=/FjyeBf66fBZlR8Gaqo2Oupc6SxE7IKBQvqIGSvJQNw=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=iMv/2qUZXCZBDhq8bD3TkgK5G7xiq8jYuD4xJuM0CVldIsTESdO23NRqKZ6P8QwQJ/hTXgML5tcdekiTJrVRuIV1LwbbfTkLFGSh76d+LzZALNd/sjyVcpKUoNCJPawsypqvvaViwP5HlC8Eo9BDyJkT5ZTUUoaklkgzh0qUtzT3b1aIVqEYIJF98Nm8MoSjLm6bLaekitNhRqdw/p1rHLCna6pYKVqLs6k3/s1Z/+PA6lO+uWbASymxyYEvAcn5usVrAd683oh8AtFsZxJGcPLbqOgT7B9b6dsVflHUvJxB3gE4AGbDourmwHzgvPiIiqH8ATi7chRSUwibkvNgvA==
X-YMail-OSG: tqQ4ci4VM1n4wfQKEzqsIBEQfIquIcCUir4PEXZ3SDMJZCBPhJtiyrs1uRQx67t
 p4PjzGg4sYUNobwg5ner2opFh1xd0plGWLbRz6Qq6Qv0LilmB4863tOx1kXM5FnwnQssP6ANKwNS
 bfZQJW05._jlPalhRvnNYk3QYgEoxSeCV5zaAVO5hnMP0KhAHpYEr8gev9w4Lxs92dFXFp.ePcEW
 KHrR3MAIxp.EJC2LsyWF7PgiLEmcOYssgsON_pBFUQU8DuYBpG5QbjuBILOoMiJ3n2it6BwwqsEy
 v5_iuyD1GUpQLhH9k_dBGh4K7ZHPcsk0TeaRLpt46.4RA6VzLJIaQtrqwXC3ZapZ3K06Au7bILsB
 nD3eqmb5YOhkf3O51nZHPG_ByYXSOp4cKpkag9EflPAaqXDj5m8TLs03qd0PzfqrKE9INxAMG9Vg
 lEa0Jz.3g55seeIMxiAhfZzsGCa83ssFbPcIRl7qF4wkQrDzjYoBNxZzKuZ2FR95qN0RqsjprlsC
 BvyGErjN.jJGKZ2zteWT0tNV0Dm1FaLFLve7XaJNsTOfx4RV4flbq4l1Ddu_K5pTCLKDmgSfkR_m
 0ZDLrgw.Y58lyH5VPwOfd7a4GkS3TZITQkF2gVN1n1if5s8fjMa2y4Fr3gpBAjRnCobXLNJ5pnZh
 PIjqluAKUdxOdxcu2rh2BN3jWejala18QxQoQ59C0PHTX7GfH9hGEqtYAkpF9fKKt.QaeoAdF_Z5
 aKC_RlWxtggq__y2.7_3YztAGMAmGupB9stVmfL.FBr5ri6HBBy7jYg92wJDNj3hPTJG14LkGpDH
 HwKWzYbBXj9YpARUsbrpxoDYagTk0LCoLMvXJxqSxIl6KrSzRZa4WTAGCWq4K.E9osQgFqP.Fvdm
 HYbwPbZQDvCyykJN4EGyL6CsBuZnoif0SBJbxu4cHSa1lFM0OxvuqXzs9iSFIrOtDacTskJiO126
 KoXZZKCjH2AW3Vqwm7vUoVDAx.YMJcQCFO8zrJUCrW3NbiS4M7lRXCk1eDVtOgMO2lprg_GkE0T9
 kKzMwNgS0R0E818h_gvx60LaCRyiFnmJKWCC.iRA0FHbveGLL02xNsNToezK_1OrN9jUPg3TtqfH
 IjBW_m.B9_FFE8NKAXNffEWHkbd2hb9FPPQOJhcrCJEmz0YyQ1WP6_vN7VXC97laT9lYGlL2QiQM
 hfJKsli7.MTTYQ76DEs2VRhRQpRbOJjKgE9r7axRCOb7pV19B3m0s4pRSk21gJB.PP8dh4_AfQh1
 6I9QYgXkTO71tlERe.dY4bg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Mon, 19 Aug 2019 20:45:13 +0000
Received: by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d4e306b9ca70839f217535bade4a91d7;
          Mon, 19 Aug 2019 20:45:12 +0000 (UTC)
Date:   Tue, 20 Aug 2019 04:45:08 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: erofs: Question on unused fields in on-disk structs
Message-ID: <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard,

On Mon, Aug 19, 2019 at 07:10:33PM +0200, Richard Weinberger wrote:
> Hi!
> 
> struct erofs_super_block has "checksum" and "features" fields,
> but they are not used in the source.
> What is the plan for these?

Yes, both will be used laterly (features is used for compatible
features, we already have some incompatible features in 5.3).

> 
> Same for i_checksum in erofs_inode_v1 and erofs_inode_v2.

checksum field apart from super_block has been reserved again
for linux-next. checksum in the super_block still exists and
will be used sooner.

The reason I discussed with Chao is
since EROFS is a read-only filesystem, we will develop block-based
checksum and integrity check to EROFS in the future version. It's
more effectively than adding such fields to all metadata (some metadata
is too large, we cannot calculate a checksum for the whole metadata
and compare at runtime, but we can do block-based metadata chksum
since EROFS is a read-only fs).

> 
> At least the "features" field in the super block is something I'd
> expect to be used.
> ...such that you can have new filesystem features in future.

Of course, "features" is for compatible features, "requirements" is
for incompatible features. Both will be used in the future.

Thanks,
Gao Xiang

> 
> Thanks,
> //richard
