Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD2465219
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbhLAPzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 10:55:21 -0500
Received: from shark1.inbox.lv ([194.152.32.81]:43022 "EHLO shark1.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239899AbhLAPzU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:55:20 -0500
Received: from shark1.inbox.lv (localhost [127.0.0.1])
        by shark1-out.inbox.lv (Postfix) with ESMTP id 09C7E1118103;
        Wed,  1 Dec 2021 17:51:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638373917; bh=DBfB7y8pPY3KAltewDz2cj6cinq0sN7Zdb2vGSCE1T0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=TxSnwzclMOzIUsHdCvZDhm/tj6BBdjHlUvUBIQnmlCPLPgc5maRCAfm54W9MqL+Tx
         7rovCadWp8iR0OmLRQ1HKAgyAjSlwtCMLsxG7POx9fdPg84GrZ/CPZhQ2D4opLso7J
         DaX3paZC3WfW/eOEBAP7rJpPk3QHkiob1tpLrXH4=
Received: from localhost (localhost [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 028F51118102;
        Wed,  1 Dec 2021 17:51:57 +0200 (EET)
Received: from shark1.inbox.lv ([127.0.0.1])
        by localhost (shark1.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id cCml6AnNr4Wy; Wed,  1 Dec 2021 17:51:56 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id BE9491118100;
        Wed,  1 Dec 2021 17:51:56 +0200 (EET)
Date:   Thu, 2 Dec 2021 00:51:46 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, kernel@xanmod.org,
        aros@gmx.com, iam@valdikss.org.ru, hakavlad@gmail.com
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working
 set
Message-ID: <20211202005146.6ecdfeba@mail.inbox.lv>
In-Reply-To: <11873851.O9o76ZdvQC@natalenko.name>
References: <20211130201652.2218636d@mail.inbox.lv>
        <11873851.O9o76ZdvQC@natalenko.name>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: EZeEAiZdhQo1taLbN+Yf6uLg2rTHW1slvCTzybU26ndFz9PMtNdrcW+QBYXsEBy7cWHD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>Although this is a definitely system-wide knob, wouldn't it make sense to 
>implement this also on a per-cgroup basis?

memory.min and memory.low are alreary exist.

Regarding the protection of file pages, we are primarily interested in
shared libraries. I don't see the point of creating such tunables
for cgroups.
