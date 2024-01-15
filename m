Return-Path: <linux-fsdevel+bounces-8007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3420482E275
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DD8283AF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1FE1B5A3;
	Mon, 15 Jan 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clisp.org header.i=@clisp.org header.b="NZCYpFMD";
	dkim=permerror (0-bit key) header.d=clisp.org header.i=@clisp.org header.b="MhaKhhVI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D881805A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=clisp.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=clisp.org
ARC-Seal: i=1; a=rsa-sha256; t=1705356352; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FUHe2VhIlo4kMP5ASurjIB7/iwUB2vVOBbcgB5ejxGD4z7z77GRo6RJ++Nb+8SSLJO
    BvtUOErh969YT5dBbGNAsPyf37pYkNnmL6XlVjzVONyU0GDwjdttrzxGcVGz00JF0a1n
    1YygkaLpHIw7VW73BY+K4PPTTO9rUj4LoyEnfulC3d8U2OUKwLMgPiJkX62SerMH4f53
    2WrgqsFfnOzdhaVw/LoL4ypdpabO6T756pD0XVPAFwF/cr7GJvznaaZfApqU+OQ/rb6q
    dBkdbq73nW+8CD4UZzwffkEAFLlphfEaHTuxSc5p8OELofEH0+EnOfyjUSJ7ag8MrCIC
    7nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1705356352;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oBEpysoLPgplhbr837ZWLtjfmcUnCmlsFSmFTGKkHlE=;
    b=allFwTuHzpDivFPN47ivODGO0adJmD6HXrg3djy8NHJRRsDlehstu4yeukT0ZFvvbe
    zrYP4C9TBfXrE6VRHiuPYyb7e3WOx9tGzKja1E8tfWfyKjXHG4krVxW3ueEWTjTe+eOe
    4m16UIXKEFdIovy/XYZ+/mHN6AZ9gLkNUOu23fzLBPBVDtI39KYc1jQBcsJ5v9Wbp4p5
    G96TTeEQ9P0TGptjMytihDb6WrtGeobzkQYsTBA+TTVcUOnCHPnNyxuAxSugDD20if1I
    WQFZYIeO+y8GEA4X1je1DywYdLTB/0taEqQk7EW1laExNhaaq+D4rnK+xSjsYNg+1Fnz
    NQWw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1705356352;
    s=strato-dkim-0002; d=clisp.org;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oBEpysoLPgplhbr837ZWLtjfmcUnCmlsFSmFTGKkHlE=;
    b=NZCYpFMDBOBkRSEXQP7FFy7MICe6Ujzb74c6psdo9hu5c1SuWqmSYDDEi1KMSaT2sx
    WUgd0zLkGc4xnJ74BvIwR1ouIaJSHUzqp7pWbHGdE0axo43zsBwuZTmQ88WwiLK718Be
    Mowg+Jp8xvDXATAFPIkwWcg1P3S57b2lFpt/9tyTCU1iDkafZJHvP84l+QU3mKCS5vUK
    NQ7phT+osAEw/KZiL413Q71DRprY48to1Fge/ZZ0Z9t+fDeGsSqqE4zNlniL/VcKR/va
    dRHrGJXsDaTBYYljXpqFZ6J7hr7T8MrNTnR9oRXzMqJsC0i6ug+D+zVTyfzcNGmKF0iV
    kfsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1705356352;
    s=strato-dkim-0003; d=clisp.org;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oBEpysoLPgplhbr837ZWLtjfmcUnCmlsFSmFTGKkHlE=;
    b=MhaKhhVIusmpfuWj6OKjCqghvQCmPDXx/gOanAjXP0mIdegnPWXCvORGHE+Z8bcber
    IJDKmnLBkIEoUvTA3hAQ==
X-RZG-AUTH: ":Ln4Re0+Ic/6oZXR1YgKryK8brlshOcZlIWs+iCP5vnk6shH0WWb0LN8XZoH94zq68+3cfpOSiKRZGkz7dVdJFqfXgrss7axLYw=="
Received: from nimes.localnet
    by smtp.strato.de (RZmta 49.10.2 AUTH)
    with ESMTPSA id c5619e00FM5pLGV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 15 Jan 2024 23:05:51 +0100 (CET)
From: Bruno Haible <bruno@clisp.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: linux-fsdevel@vger.kernel.org
Subject: ufs filesystem cannot mount NetBSD/arm64 partition
Date: Mon, 15 Jan 2024 23:05:51 +0100
Message-ID: <4014963.3daJWjYHZt@nimes>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

To: Evgeniy Dushistov <dushistov@mail.ru>
CC: linux-fsdevel@vger.kernel.org
Subject: ufs filesystem cannot mount NetBSD/arm64 partition

The disk obtained by

$ wget http://nycdn.netbsd.org/pub/NetBSD-daily/netbsd-9/latest/evbarm-aarch64/binary/gzimg/arm64.img.gz
$ gunzip arm64.img

contains two partitions, as shown by
$ fdisk arm64.img
Device     Boot  Start     End Sectors Size Id Type
arm64.img1 *     32768  196607  163840  80M  c W95 FAT32 (LBA)
arm64.img2      196608 2366335 2169728   1G a9 NetBSD

The second partition is of type ufs, with subtype 44bsd (as all NetBSD UFS
partitions). But Linux cannot mount them.

How to reproduce:
# kpartx -av arm64.img
add map loopXXp1 ...
add map loopXXp2 ...
# mount -r -t ufs -o ufstype=44bsd /dev/mapper/loopXXp2 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/mapper/loopXXp2, missing codepage or helper program, or other error.
       dmesg(1) may have more information after failed mount system call.
# dmesg
...
[  285.212612] ufs: UFSD (fs/ufs/super.c, 797): ufs_fill_super:
[  285.212619] ufs: ENTER
[  285.212622] ufs: UFSD (fs/ufs/super.c, 812): ufs_fill_super:
[  285.212625] ufs: flag 1
[  285.212629] ufs: UFSD (fs/ufs/super.c, 387): ufs_parse_options:
[  285.212632] ufs: ENTER
[  285.212636] ufs: UFSD (fs/ufs/super.c, 852): ufs_fill_super:
[  285.212639] ufs: ufstype=44bsd
[  285.212739] ufs: ufs_fill_super(): fragment size 8192 is too large
[  285.212745] ufs: UFSD (fs/ufs/super.c, 1300): ufs_fill_super:
[  285.212749] ufs: EXIT (FAILED)

Reproduced on Ubuntu 23.10 with a vanilla linux-6.7.0.

Whereas this partition can be mounted fine on FreeBSD, NetBSD, OpenBSD.
FreeBSD 11:
# mount -r -t ufs /dev/ada1s2 /mnt
NetBSD 9.3:
# mount -r -t ffs /dev/wd1a /mnt
OpenBSD 7.4:
# mount -r -t ffs /dev/wd1j /mnt

The source code line which emits the
  ufs: ufs_fill_super(): fragment size 8192 is too large
error is obviously linux/fs/ufs/super.c:1083.

       Bruno




