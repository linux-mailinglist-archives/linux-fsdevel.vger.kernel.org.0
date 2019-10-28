Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD9E70B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 12:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfJ1Lqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 07:46:46 -0400
Received: from albireo.enyo.de ([37.24.231.21]:36510 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfJ1Lqq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:46:46 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iP3Tr-0003qb-E9; Mon, 28 Oct 2019 11:46:39 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iP3Tr-0003Ho-Br; Mon, 28 Oct 2019 12:46:39 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH RFC] fs/fcntl: add fcntl F_GET_RSS
References: <157225848971.557.16257813537984792761.stgit@buzz>
Date:   Mon, 28 Oct 2019 12:46:39 +0100
In-Reply-To: <157225848971.557.16257813537984792761.stgit@buzz> (Konstantin
        Khlebnikov's message of "Mon, 28 Oct 2019 13:28:09 +0300")
Message-ID: <87k18p6qjk.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Konstantin Khlebnikov:

> This implements fcntl() for getting amount of resident memory in cache.
> Kernel already maintains counter for each inode, this patch just exposes
> it into userspace. Returned size is in kilobytes like values in procfs.

I think this needs a 32-bit compat implementation which clamps the
returned value to INT_MAX.
