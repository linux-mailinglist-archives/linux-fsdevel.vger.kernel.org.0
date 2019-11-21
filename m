Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6272810561E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 16:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKUPz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 10:55:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57818 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727040AbfKUPz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574351756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lWsgKVybaH+JezO0Xvxir4xXLVYM64AtUYc2fCA9+9I=;
        b=XH5DWmJE6muJQ5rdIP0NpL3HOfUBS2BJJit3Lawff3/5GHjUH2f3sSoIujyNx8Dzvo4J03
        6t4I+/xAmdj2pCC/Q0LCifIENWOdLVRS/9G8vkg4F+wUPY6M6vgHg2docw8zM23TnthXd1
        IctN5ZmRF2BU5R+lgi4hfigM5wruY/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-XW1zfSQvObO2k-13Np5W9Q-1; Thu, 21 Nov 2019 10:55:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09526593A1;
        Thu, 21 Nov 2019 15:55:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5ABF60F8B;
        Thu, 21 Nov 2019 15:55:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <157435064653.9583.16369826233033888377.stgit@warthog.procyon.org.uk>
References: <157435064653.9583.16369826233033888377.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix large file support
MIME-Version: 1.0
Content-ID: <11835.1574351749.1@warthog.procyon.org.uk>
Date:   Thu, 21 Nov 2019 15:55:49 +0000
Message-ID: <11836.1574351749@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: XW1zfSQvObO2k-13Np5W9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

> By default s_maxbytes is set to MAX_NON_LFS, which limits the usable
> file size to 2GB, enforced by the vfs.

Note that this isn't fixing a critical failure, so you might want to punt i=
t
to the next cycle.

David

