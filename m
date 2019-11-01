Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE9DEC51D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 15:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfKAOxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 10:53:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38618 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727559AbfKAOxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572620012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4MrbBDQoC+y5mHa+x24tjKMzrIZqDb3nq3UowOz4YuY=;
        b=f1rigfPGvTB/H5OhVEpDcYnjXRTVvHpmdODmqZmpitWDVFrlTfMmbN/5TjtGlIR6AjZ2hA
        skc5QuBqRyut7uUj0laj1LxPrGsM7Se4L/dOcL7zroerH5slpEVz434+jA5/wyEKtF0HuY
        ns0fYH9VIbeKtnAMX0lwLDUcByGLYF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-hHyjRC-_MMioG67u4CEa_w-1; Fri, 01 Nov 2019 10:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BED01800D67;
        Fri,  1 Nov 2019 14:53:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6466F26DEA;
        Fri,  1 Nov 2019 14:53:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOi1vP9GAmy5NXJisrDssspoRcc+UHum+cyBsJTMNTjz_jieoQ@mail.gmail.com>
References: <CAOi1vP9GAmy5NXJisrDssspoRcc+UHum+cyBsJTMNTjz_jieoQ@mail.gmail.com> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk> <CAOi1vP97DMX8zweOLfBDOFstrjC78=6RgxK3PPj_mehCOSeoaw@mail.gmail.com> <4892d186-8eb0-a282-e7e6-e79958431a54@rasmusvillemoes.dk> <16620.1572534687@warthog.procyon.org.uk>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring, not cursor and length [ver #2]
MIME-Version: 1.0
Content-ID: <23657.1572620001.1@warthog.procyon.org.uk>
Date:   Fri, 01 Nov 2019 14:53:21 +0000
Message-ID: <23658.1572620001@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: hHyjRC-_MMioG67u4CEa_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ilya Dryomov <idryomov@gmail.com> wrote:

> >  * This means there isn't a dead spot in the buffer, but the ring
> >  * size has to be a power of two and <=3D 2^31.

I'll go with that, thanks.

David

