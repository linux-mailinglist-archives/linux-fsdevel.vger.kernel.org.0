Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC8F23F080
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 18:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGQIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 12:08:47 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:63522 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgHGQIq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:08:46 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2020 12:08:44 EDT
Received: from SRVEX01-MUC.bfs.intern (unknown [10.161.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id 5DC312044F;
        Fri,  7 Aug 2020 17:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1596815929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=as4a5sTv+OirA4HP3Wd1Bplg57ogAEiNOBZxXPaklv4=;
        b=xQtvHB6SURA8NysVioy5AVeXExEompe9z01r9p24W2PR03Hsubv/sf3Ogq8czQUB2OYSMR
        cEOEBRO4mm5KdYusOwj2mFB30EsZ+NRcNXZja1k2Y5DV/yw/X+XkZy7stClF6NaEY4UhNX
        pz0uKpeNBVJhCkyGdxTnULrU64r9DW7bX14YcZ/zsjCX6OPJ+9neG9bzvGRdVF7RCBZFaF
        iP4osP0DIbSxdkI5ylNXvJ+M1fLn3iEJWuixeByPcgwk1EGKrTMu+OJGwTZf55k5pz2j2+
        khbh/gfTuDh+2HD16u3/Xv7n0r1csOHV+cNusgiPp80xw966rHsQehXTtItLtw==
Received: from SRVEX01-MUC.bfs.intern (10.161.90.31) by SRVEX01-MUC.bfs.intern
 (10.161.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Fri, 7 Aug 2020
 17:58:48 +0200
Received: from SRVEX01-MUC.bfs.intern ([fe80::5d64:49:5476:e21f]) by
 SRVEX01-MUC.bfs.intern ([fe80::5d64:49:5476:e21f%4]) with mapi id
 15.01.2044.004; Fri, 7 Aug 2020 17:58:48 +0200
From:   Walter Harms <wharms@bfs.de>
To:     David Howells <dhowells@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH 5/5] Add manpage for fsconfig(2)
Thread-Topic: [PATCH 5/5] Add manpage for fsconfig(2)
Thread-Index: AQHWbMQ0XBZ8wH0Poku30knI5+vNu6kszUyO
Date:   Fri, 7 Aug 2020 15:58:48 +0000
Message-ID: <a2fe568438aa45e9a63a3a7d9d64a73f@bfs.de>
References: <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>,<159680897140.29015.15318866561972877762.stgit@warthog.procyon.org.uk>
In-Reply-To: <159680897140.29015.15318866561972877762.stgit@warthog.procyon.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.40]
x-tm-as-product-ver: SMEX-14.0.0.3031-8.6.1012-25590.000
x-tm-as-result: No-10--4.703800-5.000000
x-tmase-matchedrid: WWTMasqpueHRubRCcrbc5pzEHTUOuMX33dCmvEa6IiHgYNP0+4v1ntnf
        JrUSEbFDek1qkjXpN8Ke6V/Q38YAYGcV4sYfqMYe9u1rQ4BgXPLgt7TT//RoatI0b1xCCWEs6f0
        gaty5G7F4FTWzKCjc1QRWs9urnAvn0KaUpJQo+cKrm7DrUlmNkF+24nCsUSFNjaPj0W1qn0TKay
        T/BQTiGkq2k3whZ8xxvVJAfGcGfeOlvZnjL+42kEbYU3IgrRYpI6QS6h22s/KaQOZk1X5dlPjVg
        cODqhdYucvAmOOZZmqPxfJezaaFzHXUTYbpXgymcCmyZvDwQy2t5ahRvDIGLa2t1VXHehFe6qFM
        gJg4Un8=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--4.703800-5.000000
x-tmase-version: SMEX-14.0.0.3031-8.6.1012-25590.000
x-tm-snts-smtp: 2289D2C892B8C694DF00C263AB61F0F5F41A33377B31D172F20F64C9B603E6272000:9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=1.45
X-Spam-Level: *
Authentication-Results: mx01-sz.bfs.de;
        none
X-Spamd-Result: default: False [1.45 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BAYES_HAM(-0.05)[59.33%];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.996];
         FREEMAIL_TO(0.00)[redhat.com,gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi,
thx for you efford,
maybe it is obvious but i did not see it ..
starting with what kernel version are these features available ?

re,
 wh
________________________________________
Von: linux-man-owner@vger.kernel.org [linux-man-owner@vger.kernel.org] im A=
uftrag von David Howells [dhowells@redhat.com]
Gesendet: Freitag, 7. August 2020 16:02
An: mtk.manpages@gmail.com; viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com; linux-fsdevel@vger.kernel.org; christian.brauner@u=
buntu.com; linux-man@vger.kernel.org; linux-api@vger.kernel.org; linux-kern=
el@vger.kernel.org
Betreff: [PATCH 5/5] Add manpage for fsconfig(2)

Add a manual page to document the fsconfig() system call.

Signed-off-by: David Howells <dhowells@redhat.com>
---



