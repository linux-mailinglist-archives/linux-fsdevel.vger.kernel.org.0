Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D222C23F151
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 18:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHGQfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 12:35:40 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:48349 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgHGQfU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:35:20 -0400
Received: from SRVEX01-MUC.bfs.intern (unknown [10.161.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id CCA1F2010F;
        Fri,  7 Aug 2020 18:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1596818114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6RJesMcKWo7cast7P1LaTWaXeP5IYA97+Mn3n2DTGI=;
        b=Po/0iH4OFAIZnXPir9DzxRmtHxTeZqKL8qY7zh5APXiSgM+Cz3i8Dzmj/hjqZ71vBo98RS
        6hCyumtsmEmrfLabPd1EAI4il0qvd0D4v94AvJRZkPDk1fP3oc0hhH9Luch7p6ncCUEi40
        Tx2793URDUOBxVro9ch+tKB3ilcXHrYKhD5WcwkrqcHOUWI4N3olul9VA5u2UO4eyCxi8U
        vdSwBBnsyu/kgXf406U0PhluGpkQ/jc+xKxd4L6S+Egr5XnfgZPk4cHwsanPeDkC+EsKvD
        cPwUQ7infnjhS+XN7vLS3wrtl+d50ULen+eByEcUuvQcdSh9ah1DAHCvPkb3VA==
Received: from SRVEX01-MUC.bfs.intern (10.161.90.31) by SRVEX01-MUC.bfs.intern
 (10.161.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Fri, 7 Aug 2020
 18:35:14 +0200
Received: from SRVEX01-MUC.bfs.intern ([fe80::5d64:49:5476:e21f]) by
 SRVEX01-MUC.bfs.intern ([fe80::5d64:49:5476:e21f%4]) with mapi id
 15.01.2044.004; Fri, 7 Aug 2020 18:35:14 +0200
From:   Walter Harms <wharms@bfs.de>
To:     David Howells <dhowells@redhat.com>
CC:     "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: AW: [PATCH 5/5] Add manpage for fsconfig(2)
Thread-Topic: AW: [PATCH 5/5] Add manpage for fsconfig(2)
Thread-Index: AQHWbMQ0XBZ8wH0Poku30knI5+vNu6kszUyO///m8wCAACNmbQ==
Date:   Fri, 7 Aug 2020 16:35:14 +0000
Message-ID: <61ef401b229f44ee8cc57ff292a3fc9c@bfs.de>
References: <a2fe568438aa45e9a63a3a7d9d64a73f@bfs.de>
 <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>,<159680897140.29015.15318866561972877762.stgit@warthog.procyon.org.uk>,<45107.1596817654@warthog.procyon.org.uk>
In-Reply-To: <45107.1596817654@warthog.procyon.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.40]
x-tm-as-product-ver: SMEX-14.0.0.3031-8.6.1012-25590.001
x-tm-as-result: No-10--5.127400-5.000000
x-tmase-matchedrid: Zt7FBlK+zO7RubRCcrbc5pzEHTUOuMX33dCmvEa6IiGoLZarzrrPmVwO
        JjUNGcWTvqKlPiBL76d3r1Dr7ZPfTM+9kIneOZlhQ10sagR2+EEA+JHhu0IR5pGhAvBSa2i/IZR
        vYk3GLWrOOomeC9zbqKHdurFnqCT5QLBrHsp/dPMVwr9AY0ZEvXDbaRpvS7UJlwV2iaAfSWeDGx
        /OQ1GV8t0H8LFZNFG73Yq8RVaZivUOMH2CZRwlNdjAzKACs402DiRTr+W0b8T2E7k5i1o8mSC1m
        XJsa75A
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.127400-5.000000
x-tmase-version: SMEX-14.0.0.3031-8.6.1012-25590.001
x-tm-snts-smtp: 8C69108A6CB5A07348DE85815151D065995B2165A6263346249A422E729C119C2000:9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=1.27
X-Spam-Level: *
Authentication-Results: mx01-sz.bfs.de;
        none
X-Spamd-Result: default: False [1.27 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_MATCH_FROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         BAYES_HAM(-0.23)[72.43%];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.911];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ubuntu.com];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

found it,
next i will look for version not varsion


________________________________________
Von: David Howells [dhowells@redhat.com]
Gesendet: Freitag, 7. August 2020 18:27
An: Walter Harms
Cc: dhowells@redhat.com; mtk.manpages@gmail.com; linux-fsdevel@vger.kernel.=
org; christian.brauner@ubuntu.com; linux-man@vger.kernel.org; linux-api@vge=
r.kernel.org; linux-kernel@vger.kernel.org
Betreff: Re: AW: [PATCH 5/5] Add manpage for fsconfig(2)

Walter Harms <wharms@bfs.de> wrote:

> maybe it is obvious but i did not see it ..
> starting with what kernel version are these features available ?

See:

        +.SH VERSIONS
        +.BR fsconfig ()
        +was added to Linux in kernel 5.1.

David

