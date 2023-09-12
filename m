Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF1E79D8DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjILSnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 14:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjILSnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:43:49 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E9810D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 11:43:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8345A9004A5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 18:34:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a271.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2661C90068A
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 18:34:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694543660; a=rsa-sha256;
        cv=none;
        b=+HEovq5HuvZY4e4d+qGCb+H+MPM/3jEViclkBJ4jfOpEqptdTQtzQS7SaaSVa1uk5P+3Bh
        wvV2KEfXBEwlmiz6Gsa7WDRD/kNK/U456iWdo+U7zDi7AR64OcHIilbBMfdTbPW2kqaOW0
        hHSd0FLW8tI1gxDNh9nqjzqMhVsNFKBLp/YZGrYHtD5z3Hr2/ji3wLQ972s6AXWmDye5EN
        S5ZRPrjuq2bIMVy0jwXfyz/p5hunNpvE5JWQy9dO2BtUGO8opdHj6jWn/LLdjoKMgJnqZL
        x703YUd8A0lchKSuJCKDOKBFmUA37E4ak8pCDCZKSGFBK1ktrlCp4H5PkF1MeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694543660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=M94HvCfXnjbnbpOmpTeiQ/Xkw7NQigJDOR21dmWf1Fg=;
        b=zWCbHAuQHo79LGXD4cTOeQ0nnVKrOGRilzyZpDe2PSPOgOvnhHtjSaal12frMwzro+bKEa
        iPdL1GJ07tdJnJIvFhNMXC7V46WD3gWO82DYiBVHfi6QoyMTxiq4+SnIuzyYQKL5Cv2y8N
        jJyZVOXjsSgZGR9JRWVIx5uGuIhSpiYgXSdDtmNggRB8K0CsQENMG0Cdbo3po8TJ0u7CmI
        TpP17ISyH3LriuV4hRjknOrNXMPLMWRXPn+ylP7pvJusoAVru417Z5WZ2Lvvl56OUagchj
        M/mBjA1DMKPupW3eN4XPRqYHGhClmEMu8p/LyhElVi9kBWyZhNexEh+wdNohFw==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-msbjh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Well-Made-Cure: 5b233f9b75d3403e_1694543660365_1022857927
X-MC-Loop-Signature: 1694543660365:1631178625
X-MC-Ingress-Time: 1694543660364
Received: from pdx1-sub0-mail-a271.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.138.83 (trex/6.9.1);
        Tue, 12 Sep 2023 18:34:20 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a271.dreamhost.com (Postfix) with ESMTPSA id 4RlXL3660JzM7
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 11:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1694543659;
        bh=M94HvCfXnjbnbpOmpTeiQ/Xkw7NQigJDOR21dmWf1Fg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=iHvZt5Cuih5ekrsjPMsRmwNlp5XoJB7SkaC715g7fKeL0KAwezIN64CGhLIDPaTOZ
         W/XxSKS6l772D1XAFi9yXiOM/DyKhw7SiXk7nA4Rg4dF0ttjq3/xWK0vWZetAj9mjA
         C23YeoBbAXX4lweaTtxNLz1BTKv7RHWLgn+5cHRoAmLXQINMpnCew62jpNeZH6TY2k
         QpKuG2I5HpU0o/ehh5t7nBJtbhsUXimB/CosrTLi4Haz9vr28I5ro9GNvmfAzicuPS
         9HmBt8woW2MaqU9vJG100X1hFHvrEjLPRFkXQDfeSX1iihN380jLUSsa4vyEGjKU6J
         JQ2RXP6cHMeVA==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0111
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 12 Sep 2023 11:34:09 -0700
Date:   Tue, 12 Sep 2023 11:34:09 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [PATCH v2 0/2] virtiofs submounts forgotten after client / guest
 memory pressure
Message-ID: <cover.1694541252.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
I recently ran into a situation where a virtiofs client began
encountering EBADF after the client / guest system had an OOM.  After
reproducing the issue and debugging, it appears that the problem is
caused by a virtiofsd submount being forgotten once the dentry
referencing that submount is killed by the shrinker.  In this particular
case, the submount had been bind mounted into a container's mount
namespace.  The reference count on the original dentry was 0, making it
eligible for eviction.  However, because this dentry was also the last
reference the client knew it had, it sent a forget message to the
server.  This caused all future references to the FUSE node-id from
virtiofsd perspective to become invalid.  Subsequent attempts to used
the node-id received an EBADF from the server.

This pair of patches modifies the virtiofs submount code to perform a
lookup on the nodeid that forms the root of the submount.  The patch
before this pulls the revalidate lookup code into a helper function that
can be used both in revalidate and submount superblock fill.

Tested via:

- fstests for virtiofs
- fstests for fuse (against passthrough_ll)
- manual testing to watch how refcounts change between client and server
  in response to filesytem access, umount, and eviction by the shrinker.

Changes since v1:

- Cleanups to pacify test robot

Changes since RFC:

- Modified fuse_fill_super_submount to always fail if dentry cannot be
  revalidated.  (Feedback from Bernd Schubert)
- Fixed up an edge case where looked up but subsequently declared
  invalid dentries were not correctly tracking nlookup.  (Error was
  introduced in my RFC).

Thanks,

-K


Krister Johansen (2):
  fuse: revalidate: move lookup into a separate function
  fuse: ensure that submounts lookup their root

 fs/fuse/dir.c    | 85 +++++++++++++++++++++++++++++++++---------------
 fs/fuse/fuse_i.h |  6 ++++
 fs/fuse/inode.c  | 43 ++++++++++++++++++++----
 3 files changed, 101 insertions(+), 33 deletions(-)

-- 
2.25.1

