Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8143137CBC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 19:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbhELQhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 12:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236518AbhELQUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 12:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620836338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eXgmmM3U8BNR0qHLEtVzxEaCYV9vF5/0DUg+7Z1mLsg=;
        b=LeiSu1Gofl6qk6f+Wqgp4Ur0oHfoRlvKrROFAeRtfLXysz5Auk/QL/biMpsUnjSvkVIh3x
        a+f73FNpOnPpmYT3pYQzrIwLdK+rLAN/fFnizztE5GjzVb6uQz+xkLliuAIKYcYEjAyiEv
        zn7KswoGKVgmb4ML8i6VmBmgJiLbdCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-ga1jgivFPei-qFjXhqkaJg-1; Wed, 12 May 2021 12:18:56 -0400
X-MC-Unique: ga1jgivFPei-qFjXhqkaJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64D48801817;
        Wed, 12 May 2021 16:18:55 +0000 (UTC)
Received: from pick.home.annexia.org (ovpn-114-114.ams2.redhat.com [10.36.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99EFB6D8C1;
        Wed, 12 May 2021 16:18:50 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com, synarete@gmail.com
Subject: [PATCH v4] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Date:   Wed, 12 May 2021 17:18:47 +0100
Message-Id: <20210512161848.3513818-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v3 -> v4:

 - Cleans up the commit message.

 - As the patch itself is unchanged from v3, I did not retest it.


