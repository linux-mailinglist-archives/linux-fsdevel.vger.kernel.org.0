Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA935432DD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhJSGK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:10:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33399 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234272AbhJSGKQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:10:16 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 724F65C014D;
        Tue, 19 Oct 2021 02:08:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 19 Oct 2021 02:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=hRkgF8ZZUt/Xog6cwemU0+CcHu
        F63kpq3UXZqXJb3o4=; b=FBXQq6WeG5I6iCMgCXshirHJL4kIBEjxMje0gYWmqk
        axiECcT11JQp0tw4/jV6uKNbA+KhH5ccSJqomwFAELDrv0mmNtOuPjoSrtYkz8u4
        c18XnTvRw/RlECguaxY1BFtPtVXh4s5t3ucJ46Bg5wgwkWTxVPj78m10uQdab+lA
        00Hoxxgy954btfkSZVP5dAHTf7EBo2yvob9GQu4rYoly+wzAAiFepMLe97zvD2yw
        Y0R6nboPruv6q2wsN4PDdJejqMpnFuInkqjm8mVJPX/L59LhN2AM3THPQmeFi6jC
        TLvjVqjtQVjzq6SpaCqWxCH4q1s56YBfMaS35RdFJIIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hRkgF8
        ZZUt/Xog6cwemU0+CcHuF63kpq3UXZqXJb3o4=; b=A+eTYj3bXGuU6EXzOTZI+A
        01l/kDxnDtmXdqZG+jZlGO7gmlA9ozi+KT4PIoeGPkd7lHYr/uGdu27cssG0MhsJ
        rZGX/NaFoQHSXxhZEIYigoAsAuROEGvFzpvC7A9t07mM0qqvyxesrqayp0YX2jkU
        QD7FVHjtcfmJ2nzRnxMeZDXqwi17W+SlB7PUJYtJ1ESN++S8lD4yKaqHOKAn+SfQ
        zR7XGVYNlPAMQtj9+78d7buz/lZaa8sP/wHBjTz3c97OOcQwFtAB5RJrd5hp9Pbd
        lXrORK0jReIr0f4ZRWmWp/7Gh822C0iP3aVnUPhoEgX5SN3x2L2cmPY6d0pY7zjg
        ==
X-ME-Sender: <xms:wGBuYQG_Ejfg0M04c_C7vSsztnGqzFdimK23JmZum3Nlu3B5n4MF_A>
    <xme:wGBuYZVVeIUtgU3V1HM-y0_S8R4i4Urz0dYYbz6-f3CrnSwg8gBdxoIWoGHHmxUmw
    90pca4aytku>
X-ME-Received: <xmr:wGBuYaKm3ANAjOByqfY_T2eraOMkL6UtVV1wIwhv3ZTtCfTRELVz3OQbe2RPYqGK1PqiXM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgtfggggfesthejre
    dttderjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhn
    vghtqeenucggtffrrghtthgvrhhnpedtueehffeukeekuddvtdfffefhveekgfehteevle
    dvieelgeekieevkedtgfelueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:wGBuYSHr40BfumI0p_ZJQBPE7JmCJMXiFUh8j8_1kMXlp5OsGigiPQ>
    <xmx:wGBuYWWH-gJBsFpex75bD-pLFXY_y21iFcfJ9JsLpDrjp3UnU8dc0Q>
    <xmx:wGBuYVMAU0JDv4DR_cO4pXJmTTSd0t3MVEOaBote3EJVkRNoBaQ0xg>
    <xmx:wGBuYfc1p2ait6Q3JA88MKQRBcx9WENGsAe48FhYeH7N7GXrocCCow>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 02:07:58 -0400 (EDT)
Message-ID: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
Subject: [ANNOUNCE] autofs 5.1.8 release
From:   Ian Kent <raven@themaw.net>
To:     autofs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 14:07:55 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

It's time for a release, autofs-5.1.8.

The bulk of the changes in this release are improvements to the
internal hosts map and related code.

The internal hosts map was performing very poorly when there were a
very large number of exports from a server. This was because the
server exports are turned into an autofs map entry with an offset
for each of the exports and the offset handling code was written
with the assumption the number of offsets is small. After doing
as much optimization as possible with the existing code accessing
a server with 30k exports took more than 45 seconds on initial
access and shutting down autofs would take more than a minute (with
all offsets still present), not ok at all.

Because of need to handle offset mount trees as subtrees the existing
linear list implementation was complicated and hard to maintain so it
was re-written to leverage the recently added (in autofs-5.1.7) binary
tree implementation. The result is much simpler and cleaner and takes
10-15 seconds on initial access and about the same amount of time to
shutdown autofs for a server with 30k exports. That's not quite good
enough for interactive use but it's pretty close and, after all, there
are a "lot" of exports.

There are also quite a few bug fixes and minor improvements.

autofs
======

The package can be found at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

It is autofs-5.1.8.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.8.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.8.tar.gz

Here are the entries from the CHANGELOG which outline the updates:

- add xdr_exports().
- remove mount.x and rpcgen dependencies.
- dont use realloc in host exports list processing.
- use sprintf() when constructing hosts mapent.
- fix mnts_remove_amdmount() uses wrong list.
- Fix option for master read wait.
- eliminate cache_lookup_offset() usage.
- fix is mounted check on non existent path.
- simplify cache_get_parent().
- set offset parent in update_offset_entry().
- remove redundant variables from mount_autofs_offset().
- remove unused parameter form do_mount_autofs_offset().
- refactor umount_multi_triggers().
- eliminate clean_stale_multi_triggers().
- simplify mount_subtree() mount check.
- fix mnts_get_expire_list() expire list construction.
- fix inconsistent locking in umount_subtree_mounts().
- fix return from umount_subtree_mounts() on offset list delete.
- pass mapent_cache to update_offset_entry().
- fix inconsistent locking in parse_mount().
- remove unused mount offset list lock functions.
- eliminate count_mounts() from expire_proc_indirect().
- eliminate some strlen calls in offset handling.
- don't add offset mounts to mounted mounts table.
- reduce umount EBUSY check delay.
- cleanup cache_delete() a little.
- rename path to m_offset in update_offset_entry().
- don't pass root to do_mount_autofs_offset().
- rename tree implementation functions.
- add some multi-mount macros.
- remove unused functions cache_dump_multi() and cache_dump_cache().
- add a len field to struct autofs_point.
- make tree implementation data independent.
- add mapent tree implementation.
- add tree_mapent_add_node().
- add tree_mapent_delete_offsets().
- add tree_mapent_traverse_subtree().
- fix mount_fullpath().
- add tree_mapent_cleanup_offsets().
- add set_offset_tree_catatonic().
- add mount and umount offsets functions.
- switch to use tree implementation for offsets.
- remove obsolete functions.
- remove redundant local var from sun_mount().
- use mount_fullpath() in one spot in parse_mount().
- pass root length to mount_fullpath().
- remove unused function master_submount_list_empty().
- move amd mounts removal into lib/mounts.c.
- check for offset with no mount location.
- remove mounts_mutex.
- remove unused variable from get_exports().
- add missing free in handle_mounts().
- remove redundant if check.
- fix possible memory leak in master_parse().
- fix possible memory leak in mnts_add_amdmount().
- fix double unlock in parse_mount().
- add length check in umount_subtree_mounts().
- fix flags check in umount_multi().
- dont try umount after stat() ENOENT fail.
- remove redundant assignment in master_add_amd_mount_section_mounts().
- fix dead code in mnts_add_mount().
- fix arg not used in error print.
- fix missing lock release in mount_subtree().
- fix double free in parse_mapent().
- refactor lookup_prune_one_cache() a bit.
- cater for empty mounts list in mnts_get_expire_list().
- add ext_mount_hash_mutex lock helpers.
- fix amd section mounts map reload.
- fix dandling symlink creation if nis support is not available.
- dont use AUTOFS_DEV_IOCTL_CLOSEMOUNT.
- fix lookup_prune_one_cache() refactoring change.
- fix amd hosts mount expire.
- fix offset entries order.
- use mapent tree root for tree_mapent_add_node().
- eliminate redundant cache lookup in tree_mapent_add_node().
- fix hosts map offset order.
- fix direct mount deadlock.
- add missing description of null map option.
- fix nonstrict offset mount fail handling.
- fix concat_options() error handling.
- eliminate some more alloca usage.
- use default stack size for threads.
- fix use of possibly NULL var in lookup_program.c:match_key().
- fix incorrect print format specifiers in get_pkt().
- add mapent path length check in handle_packet_expire_direct().
- add copy length check in umount_autofs_indirect().
- add some buffer length checks to master map parser.
- add buffer length check to rmdir_path().
- eliminate buffer usage from handle_mounts_cleanup().
- add buffer length checks to autofs mount_mount().
- make NFS version check flags consistent.
- refactor get_nfs_info().
- also require TCP_REQUESTED when setting NFS port.

Ian



