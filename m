Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9DE7039
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfJ1LRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 07:17:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29119 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725776AbfJ1LRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572261472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xvGy8lfSyzYT4HF73ZOXkZjMD3C1Ua03UylbZbwvVfY=;
        b=FXsiZmCZWK3WBNnWPL1qY+zVJTT6D5HZRgKqXxX33/3Makkfqth0a3nzxgNltZ+DETG9VW
        FWD40ZlhPVA/MBZME/Nqq+KcAc7KHjsIiYsRijgGH9uUMhuh+MB7xlRYdI8aWKcODynbXU
        EWiNGrCYN9TuWD+Z8QGBdlHdYz85Es4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-WNphYuquOhybpm7TOvjMvg-1; Mon, 28 Oct 2019 07:17:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF407476;
        Mon, 28 Oct 2019 11:17:47 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-64.ams2.redhat.com [10.36.116.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4844194B2;
        Mon, 28 Oct 2019 11:17:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 0/1] staging: Add VirtualBox guest shared folder (vboxsf) support
Date:   Mon, 28 Oct 2019 12:17:43 +0100
Message-Id: <20191028111744.143863-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WNphYuquOhybpm7TOvjMvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

As discussed previously can you please take vboxsf upstream through
drivers/staging?

It has seen many revisions on the fsdevel list, but it seems that the
fsdevel people are to busy to pick it up.

Previous versions of this patch have been reviewed by Al Viro, David Howell=
s
and Christoph Hellwig (all in the Cc) and I believe that the current
version addresses all their review remarks.

Regards,

Hans

