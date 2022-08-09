Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C887F58D95C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbiHIN1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243509AbiHIN1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4919611148
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660051652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QjtptTO8BIFo1xe8OpF/blve76WhiPdfyXUxMj/rAdY=;
        b=bXyM3BoZzfOIUHD6kdL1CnH5/NaBD4ph/1PhUU/ZnVYVb+ZuaXumrNltScr8Zaf4UjoReT
        tHLMuD8G9Vcn5w44iUlQpGO6BO1abMwEvNKg9Uc16wJKp2gyXtwLDEj4QEvGgpcTPfCrhN
        MBq57w4FwcL6TfRn4QjO8Aio9t8w4qk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-sT3UyIsIN9CyC9W9outn-Q-1; Tue, 09 Aug 2022 09:27:27 -0400
X-MC-Unique: sT3UyIsIN9CyC9W9outn-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAF2D8041B5;
        Tue,  9 Aug 2022 13:27:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F20D740CFD0B;
        Tue,  9 Aug 2022 13:27:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <431241.1660051645.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 09 Aug 2022 14:27:25 +0100
Message-ID: <431242.1660051645@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull these two patches please?  The first fixes a cookie access re=
f
leak if a cookie is invalidated a second time before the first invalidatio=
n
is actually processed.  The second adds a tracepoint to log cookie look up
failure.

Thanks,
David

Link: https://listman.redhat.com/archives/linux-cachefs/2022-August/007061=
.html
Link: https://listman.redhat.com/archives/linux-cachefs/2022-August/007062=
.html
---
The following changes since commit 3d7cb6b04c3f3115719235cc6866b10326de34c=
d:

  Linux 5.19 (2022-07-31 14:03:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-fixes-20220809

for you to fetch changes up to 1a1e3aca9d4957e282945cdc2b58e7c560b8e0d2:

  fscache: add tracepoint when failing cookie (2022-08-09 14:13:59 +0100)

----------------------------------------------------------------
fscache fixes

----------------------------------------------------------------
Jeff Layton (2):
      fscache: don't leak cookie access refs if invalidation is in progres=
s or failed
      fscache: add tracepoint when failing cookie

 fs/fscache/cookie.c            | 9 +++++++--
 include/trace/events/fscache.h | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

