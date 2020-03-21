Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE5318E197
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Mar 2020 14:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCUNjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Mar 2020 09:39:48 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57497 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbgCUNjs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Mar 2020 09:39:48 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 0F7054F5;
        Sat, 21 Mar 2020 09:39:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 21 Mar 2020 09:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=JNxABtUDKau7j2x+5bJNK4DzsK
        yhR0OlFW6pmzpm3l0=; b=ZmU9uD/V2RWGZKMpJTLqVxhDnzRtIwN+Otrg4mRUOU
        tgnn85meppuRQ5Il3UUQ7a2DjxLS+ld4VAAnxQRLKr38vrYcJaeKi0L6Mqx07HdO
        32Wnc+8/dIP+pXy9+0AevJyqs5MRB3hXYj0bFaHEsgfjbqSNgggnzL16NwE0/Zav
        sVMNWY4GcFrAYjVvnc9SqKpK688jVx94Mn8uzis+896ivLVyBRBgNzNGd7idquAd
        JEEHRLvaWDsxegOi32izYYgo1fFluAQMBjebQA1jQTKV/uVo3rW1eKZLbjFTcts1
        XjK/4XUGAJ6lO+H5tTd4sc4po+V0ENaUhdeHYarOeu7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=JNxABt
        UDKau7j2x+5bJNK4DzsKyhR0OlFW6pmzpm3l0=; b=xlNeHAmNCXMrvPb1lPR5HZ
        A/wPOXKSGh3pr6A0nyGYj3ZGCqaj3Q7XEwR3cMUOuggrMNUFxYGlDopITO2Z9epk
        cV79AQPfXQY/WokWPhH4UdCVnCJFhO20Sc4CSr9o8e6X5154xKLpGaD36A2tY1ua
        0oDbeWko2pJ7CujS+DxLrOuO35FeHCZzeQl0L5AHfNUHaflAAWSdT8+zQXZV270I
        vORrtnTrifkpm+ugEZMO6UyoQAYSnV5IQXpojiivkBeu+V5Swu0YNYelvyaLkHOf
        7b7HMPSvtATw5XgKXJJpYC4Sm1fXw43fPQPJawF0QUV/seoLjAbvO8wKOJTZxo5A
        ==
X-ME-Sender: <xms:Ihl2Xt6SZxR-DdRGHW5gjALq-6TRVWyMLbg9lnsxSzNhTRZOeF5R1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegfedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgfgsehtqhdttd
    dtreejnecuhfhrohhmpefpihhkohhlrghushcutfgrthhhuceopfhikhholhgruhhssehr
    rghthhdrohhrgheqnecukfhppedukeehrdefrdelgedrudelgeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhh
    rdhorhhg
X-ME-Proxy: <xmx:Ihl2Xsxkowl0bwcJsp8SWLabJN79VlBma3qvNA7g_5vzx7T47IMFTw>
    <xmx:Ihl2XpFv8cVxcqdWfC0-Y2Hwgcap81O1mHbphhHdq5XTTp2YESFmDg>
    <xmx:Ihl2XkoPHl2uBvp5o6tJPc3u0w6fIezwyE-H7uGKY791hYfwL1eXtA>
    <xmx:Ihl2XpZC4oocUVrck1Zu4kPbqJbfjMY8s6DpPK4Wwb7xtMfRmDQifw>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 391E93280063;
        Sat, 21 Mar 2020 09:39:46 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 8AF9727;
        Sat, 21 Mar 2020 13:39:45 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id EC5F4E0057; Sat, 21 Mar 2020 13:39:37 +0000 (GMT)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: [fuse] Why is readahead=0 limiting read size?
Mail-Copies-To: never
Mail-Followup-To: linux-fsdevel@vger.kernel.org, fuse-devel
        <fuse-devel@lists.sourceforge.net>
Date:   Sat, 21 Mar 2020 13:39:37 +0000
Message-ID: <87r1xlesiu.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

When issuing a 16 kB read request from userspace and the default FUSE
readahead settings, data is read in batches of 32k:

$ example/passthrough_ll -d mnt
FUSE library version: 3.9.1
unique: 1, opcode: INIT (26), nodeid: 0, insize: 56, pid: 0
INIT: 7.27
flags=3D0x003ffffb
max_readahead=3D0x00020000
   INIT: 7.31
   flags=3D0x0000f439
   max_readahead=3D0x00020000
   max_write=3D0x00020000
   max_background=3D0
   congestion_threshold=3D0
   time_gran=3D1
   unique: 1, success, outsize: 80
unique: 2, opcode: LOOKUP (1), nodeid: 1, insize: 44, pid: 20822
lo_lookup(parent=3D1, name=3Dbin)
  1/bin -> 140290677541808
   unique: 2, success, outsize: 144
unique: 3, opcode: LOOKUP (1), nodeid: 140290677541808, insize: 45, pid: 20=
822
lo_lookup(parent=3D140290677541808, name=3Dbash)
  140290677541808/bash -> 140290677542048
   unique: 3, success, outsize: 144
unique: 4, opcode: OPEN (14), nodeid: 140290677542048, insize: 48, pid: 208=
22
lo_open(ino=3D140290677542048, flags=3D32768)
   unique: 4, success, outsize: 32
unique: 5, opcode: FLUSH (25), nodeid: 140290677542048, insize: 64, pid: 20=
822
   unique: 5, success, outsize: 16
unique: 6, opcode: READ (15), nodeid: 140290677542048, insize: 80, pid: 208=
22
lo_read(ino=3D140290677542048, size=3D32768, off=3D0)
   unique: 6, success, outsize: 32784
unique: 7, opcode: FLUSH (25), nodeid: 140290677542048, insize: 64, pid: 20=
822
   unique: 7, success, outsize: 16
unique: 8, opcode: RELEASE (18), nodeid: 140290677542048, insize: 64, pid: 0
   unique: 8, success, outsize: 16


However, when disabling readahead, the read size decreases to 4k:


$ example/passthrough_ll -d mnt
FUSE library version: 3.9.1
unique: 1, opcode: INIT (26), nodeid: 0, insize: 56, pid: 0
INIT: 7.27
flags=3D0x003ffffb
max_readahead=3D0x00020000
   INIT: 7.31
   flags=3D0x0000f439
   max_readahead=3D0x00000000
   max_write=3D0x00020000
   max_background=3D0
   congestion_threshold=3D0
   time_gran=3D1
   unique: 1, success, outsize: 80
unique: 2, opcode: LOOKUP (1), nodeid: 1, insize: 44, pid: 20911
lo_lookup(parent=3D1, name=3Dbin)
  1/bin -> 140509922200528
   unique: 2, success, outsize: 144
unique: 3, opcode: LOOKUP (1), nodeid: 140509922200528, insize: 45, pid: 20=
911
lo_lookup(parent=3D140509922200528, name=3Dbash)
  140509922200528/bash -> 140510056418784
   unique: 3, success, outsize: 144
unique: 4, opcode: OPEN (14), nodeid: 140510056418784, insize: 48, pid: 209=
11
lo_open(ino=3D140510056418784, flags=3D32768)
   unique: 4, success, outsize: 32
unique: 5, opcode: FLUSH (25), nodeid: 140510056418784, insize: 64, pid: 20=
911
   unique: 5, success, outsize: 16
unique: 6, opcode: READ (15), nodeid: 140510056418784, insize: 80, pid: 209=
11
lo_read(ino=3D140510056418784, size=3D4096, off=3D0)
   unique: 6, success, outsize: 4112
unique: 7, opcode: READ (15), nodeid: 140510056418784, insize: 80, pid: 209=
11
lo_read(ino=3D140510056418784, size=3D4096, off=3D4096)
   unique: 7, success, outsize: 4112
unique: 8, opcode: READ (15), nodeid: 140510056418784, insize: 80, pid: 209=
11
lo_read(ino=3D140510056418784, size=3D4096, off=3D8192)
   unique: 8, success, outsize: 4112
unique: 9, opcode: READ (15), nodeid: 140510056418784, insize: 80, pid: 209=
11
lo_read(ino=3D140510056418784, size=3D4096, off=3D12288)
   unique: 9, success, outsize: 4112
unique: 10, opcode: FLUSH (25), nodeid: 140510056418784, insize: 64, pid: 2=
0911
   unique: 10, success, outsize: 16
unique: 11, opcode: RELEASE (18), nodeid: 140510056418784, insize: 64, pid:=
 0
   unique: 11, success, outsize: 16



Is that intentional? If so, why?

Is there any way to get larger read requests without also enabling
readahead?

(I am generating the userspace request with

$ dd if=3D<mountpoint>/bin/bash of=3D/dev/null bs=3D16k count=3D1)


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
