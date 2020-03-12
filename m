Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A89183A60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 21:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgCLUKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 16:10:06 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:34157 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbgCLUKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:10:05 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 16:10:05 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1EFBF3CA;
        Thu, 12 Mar 2020 16:10:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 12 Mar 2020 16:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm3; bh=TkJOJLPVp9faa1mlhe8Ka531E
        s7yGnp/Tphg5hzuUU8=; b=T+yUk47hFlOHjRn12B9u9KT0HtJPJLz1E/ckWYq5J
        vAR+/LQBkLjcqMF3677DoeBEwqunJPTuR09mF8ENbyFV2BsF5J8Lxhp8jK3ReqRl
        /KyQltyDjkgVBmBR1EAuqWIs769+xwjl1UPZimmTpKIQr0bAG/hiLnW6YltCp+Z/
        Ei5h/zT3CR3M4ps3FamtB9yoXJwaY2kk7jSlFfxvP9YDUeGD2JQYq2QnWhAaDrYU
        85e60jUSfJ0wlO5ETVgHQfFL1quOSmCI0VQ0pD5TDGvRaeXnHmmxWVPGi7XSlvCR
        UGxPLAGksufrrus1BdmH2F3cgYHx6U5Q+hBAlleaQZcug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TkJOJL
        PVp9faa1mlhe8Ka531Es7yGnp/Tphg5hzuUU8=; b=iJayL43GkTly9KNOWB0gzT
        H8IsVgSNkBk2o9ZrV8MxT3+cjAiifroKAJS0BeT+17ySgqzw8C6NR54jEzWe0Yiq
        42InrLIcfkteTLOCPJRig44nvNlH1IAQEML1aZOf3cW4WdtzS9Oq1oI7drK7MsIa
        ggmar1FXyV6uo48uNagvnvPZ0suA6qEAAw0eUsjLr28kCiELQ4zAts+QsZxb0g9D
        1GDYgq2l9RKOqThE4sQrc1/vOcga61tjdVhvKQEFUyqmbNR3TJsTecyeBMczNhrV
        hsRWKao5SPxuBauArJHGlsxiESggFEpCvXbA0TOvPjt0G2EbqpO41pkwtGfqchbA
        ==
X-ME-Sender: <xms:GpdqXq4T_bbV8T9j849ICt5vpSY5borsc1Z17qtD3Jb1u9rVgUb5gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepgf
    gtjgffuffhvffksehtqhertddttdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeejfedrleefrddvgeejrddufeegnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:GpdqXnXZ_n46KxoJ19WGcW7f6HcejtmgOyy0fEsh0eESFW6i4pwgfg>
    <xmx:GpdqXgd50IarPHpDpSCdS6hs7qf5k5cUrj8jO2xYVpTfMlI_IgOuDQ>
    <xmx:GpdqXkb_sFRZ49lggyzgeSqcv4mWwRzcGR7qp8-ZOBnHhyp568EWkg>
    <xmx:G5dqXhCLDy1rzu9sPcOaiGaKMZT6u2MNd0oH9ObJyQ6Y8m0NP6L5PL1UpPQ>
Received: from localhost (c-73-93-247-134.hsd1.ca.comcast.net [73.93.247.134])
        by mail.messagingengine.com (Postfix) with ESMTPA id ACC633280066;
        Thu, 12 Mar 2020 16:10:00 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20200312200317.31736-1-dxu@dxuuu.xyz>
Date:   Thu, 12 Mar 2020 13:09:25 -0700
Cc:     "Daniel Xu" <dxu@dxuuu.xyz>, <shakeelb@google.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v3 0/4] Support user xattrs in cgroupfs
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Daniel Xu" <dxu@dxuuu.xyz>, <cgroups@vger.kernel.org>,
        <tj@kernel.org>, <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <viro@zeniv.linux.org.uk>
Message-Id: <C194NG2LLD6S.362U6UUAHUZHJ@maharaja>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu Mar 12, 2020 at 6:03 AM PST, Daniel Xu wrote:
> User extended attributes are useful as metadata storage for kernfs
> consumers like cgroups. Especially in the case of cgroups, it is useful
> to have a central metadata store that multiple processes/services can
> use to coordinate actions.
>
> A concrete example is for userspace out of memory killers. We want to
> let delegated cgroup subtree owners (running as non-root) to be able to
> say "please avoid killing this cgroup". This is especially important for
> desktop linux as delegated subtrees owners are less likely to run as
> root.
>
> The first two commits set up some stuff for the third commit which
> intro introduce a new flag, KERNFS_ROOT_SUPPORT_USER_XATTR,
> that lets kernfs consumers enable user xattr support. The final commit
> turns on user xattr support for cgroupfs.
>
> Changes from v2:
> - Rephrased commit message for "kernfs: kvmalloc xattr value instead of
> kmalloc"
>
> Changes from v1:
> - use kvmalloc for xattr values
> - modify simple_xattr_set to return removed size
> - add accounting for total user xattr size per cgroup
>
> Daniel Xu (4):
> kernfs: kvmalloc xattr value instead of kmalloc
> kernfs: Add removed_size out param for simple_xattr_set
> kernfs: Add option to enable user xattrs
> cgroupfs: Support user xattrs
>
> Daniel Xu (4):
> kernfs: kvmalloc xattr value instead of kmalloc
> kernfs: Add removed_size out param for simple_xattr_set
> kernfs: Add option to enable user xattrs
> cgroupfs: Support user xattrs
>
> fs/kernfs/inode.c | 91 ++++++++++++++++++++++++++++++++++++-
> fs/kernfs/kernfs-internal.h | 2 +
> fs/xattr.c | 17 +++++--
> include/linux/kernfs.h | 11 ++++-
> include/linux/xattr.h | 3 +-
> kernel/cgroup/cgroup.c | 3 +-
> mm/shmem.c | 2 +-
> 7 files changed, 119 insertions(+), 10 deletions(-)

Gah, messed up the copy paste. Let me know if you want a resend.
