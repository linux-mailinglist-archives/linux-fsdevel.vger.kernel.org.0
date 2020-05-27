Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC5B1E4731
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 17:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgE0PVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 11:21:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38644 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727922AbgE0PVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 11:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590592862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGIL+/IPozSdXT6nYYNzdE5I68dd6nQjbL88V5yYabU=;
        b=QSnkODs/glXESpsQPq7M5QzhFkC/wbk80O/ZwinrEeioZIT658K9a8ufzJwHzal0Hewutd
        oJY/54gIncxtHrtoOPRct8PT4+u75ZYCNyCQtkj5NinIyz8YBy7uMWlUSxsjej4WNAdn3Q
        eJ60upIlCFWVEk0mH8E2NA/ojGc0nvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-MHC_BvWZMn-wrLvk_5xWow-1; Wed, 27 May 2020 11:20:58 -0400
X-MC-Unique: MHC_BvWZMn-wrLvk_5xWow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 256551005512;
        Wed, 27 May 2020 15:20:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E3E85C1B0;
        Wed, 27 May 2020 15:20:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <8ac18259-ad47-5617-fa01-fba88349b82d@yandex-team.ru>
References: <8ac18259-ad47-5617-fa01-fba88349b82d@yandex-team.ru> <195849.1590075556@warthog.procyon.org.uk>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     dhowells@redhat.com, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs, afs, ext4: Make the inode hash table RCU searchable
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3735167.1590592854.1@warthog.procyon.org.uk>
Date:   Wed, 27 May 2020 16:20:54 +0100
Message-ID: <3735168.1590592854@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> > Is this something that would be of interest to Ext4?
> 
> For now, I've plugged this issue with try-lock in ext4 lazy time update.
> This solution is much better.

Would I be able to turn that into some sort of review tag?

David

