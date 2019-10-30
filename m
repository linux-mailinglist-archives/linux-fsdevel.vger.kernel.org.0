Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8DAE9E5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfJ3PHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 11:07:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726967AbfJ3PHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572448071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tAmJCcma8tMfaZZhSnuziMQ0xZCDAhkTYFHnjIDKQN0=;
        b=CtZ2gFwjP7G3Ba8p80wYPBHXtcjZn0CqlAJLrFDpHnKwj8b+PXZse7iH5zOE8zs9wMNOVd
        0swU7Kx/KYYNDSaTh9WTUwhWtHQy85VP15w9uO6J75WN0WjV9XA5lLwekWZfejN6slYfXa
        tdzcaPoYUxZi4iK/dJ4VioLjvZN+Ik4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-j29PkrUkOkOLNNsz2ewIgg-1; Wed, 30 Oct 2019 11:07:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 100C11005500;
        Wed, 30 Oct 2019 15:07:45 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B260600C6;
        Wed, 30 Oct 2019 15:07:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D41862237B5; Wed, 30 Oct 2019 11:07:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     virtualization@lists.linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 0/3] virtiofs: Small Cleanups for 5.5
Date:   Wed, 30 Oct 2019 11:07:16 -0400
Message-Id: <20191030150719.29048-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: j29PkrUkOkOLNNsz2ewIgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

Here are few small cleanups for virtiofs for 5.5. I had received some
comments from Michael Tsirkin on original virtiofs patches and these
cleanups are result of these comments.

Thanks
Vivek

Vivek Goyal (3):
  virtiofs: Use a common function to send forget
  virtiofs: Do not send forget request "struct list_head" element
  virtiofs: Use completions while waiting for queue to be drained

 fs/fuse/virtio_fs.c | 204 ++++++++++++++++++++++----------------------
 1 file changed, 103 insertions(+), 101 deletions(-)

--=20
2.20.1

