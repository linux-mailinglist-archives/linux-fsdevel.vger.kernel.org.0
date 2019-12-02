Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB710E9D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 12:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfLBLzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 06:55:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42552 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726149AbfLBLzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575287746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuVPluF8Vz2pOHrANYZgmx+snA3qZCVo/pGJeecZlbw=;
        b=N3nWzhuluvE42tr39JRk+DVqPkNIDHE8aR5CMXKx7Zu6O1pbjk29zJrkhiB3qqSXisdV+h
        kiugSywZYzF8s4Nu6XovupNUfDipisJTWRuF+rwYJ+/pBgbajvcdWds6LtY6SduC/d51uQ
        sWRnk2sFv8sjSseOOBE7i8QhGp50k+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-jpiNLMe-MTubom-DUZiv6Q-1; Mon, 02 Dec 2019 06:55:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25219DB20;
        Mon,  2 Dec 2019 11:55:44 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-205-135.brq.redhat.com [10.40.205.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACD3360BFB;
        Mon,  2 Dec 2019 11:55:42 +0000 (UTC)
Date:   Mon, 2 Dec 2019 12:55:40 +0100
From:   Karel Zak <kzak@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [MANPAGE] move_mount.2
Message-ID: <20191202115540.gx2dcimzns7osbra@10.255.255.10>
References: <10805.1570726908@warthog.procyon.org.uk>
 <11098.1570727091@warthog.procyon.org.uk>
MIME-Version: 1.0
In-Reply-To: <11098.1570727091@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jpiNLMe-MTubom-DUZiv6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 10, 2019 at 06:04:51PM +0100, David Howells wrote:
> .B MOVE_MOUNT_F_NO_AUTOMOUNT
> .B MOVE_MOUNT_F_NO_AUTOMOUNT

The mount.h contains:

    #define MOVE_MOUNT_F_AUTOMOUNTS         0x00000002 /* Follow automounts=
 on from path */
    #define MOVE_MOUNT_T_AUTOMOUNTS         0x00000020 /* Follow automounts=
 on to path */

it means the macros are without the "_NO_".

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

