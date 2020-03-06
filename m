Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EAF17BBDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 12:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFLm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 06:42:26 -0500
Received: from albireo.enyo.de ([37.24.231.21]:57960 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgCFLm0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:42:26 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jABMw-00028i-VZ; Fri, 06 Mar 2020 11:42:18 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jABLL-00050q-TL; Fri, 06 Mar 2020 12:40:39 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     YunQiang Su <syq@debian.org>
Cc:     Laurent Vivier <laurent@vivier.eu>, torvalds@linux-foundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
References: <20200306080905.173466-1-syq@debian.org>
        <87r1y53npd.fsf@mid.deneb.enyo.de>
        <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu>
        <87mu8t3mlw.fsf@mid.deneb.enyo.de>
        <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu>
        <CAKcpw6WEO5Rmsv+WFkOMrkH+0jwtFKKy7b2n3U9xgv-xGC0UUQ@mail.gmail.com>
Date:   Fri, 06 Mar 2020 12:40:39 +0100
In-Reply-To: <CAKcpw6WEO5Rmsv+WFkOMrkH+0jwtFKKy7b2n3U9xgv-xGC0UUQ@mail.gmail.com>
        (YunQiang Su's message of "Fri, 6 Mar 2020 19:29:57 +0800")
Message-ID: <87v9nhzp6w.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* YunQiang Su:

> AT_* only has 32 slot and now. I was afraid that maybe we shouldn't take one.
>    /* AT_* values 18 through 22 are reserved */
>    27,28,29,30 are not used now.
> Which should we use?

Where does this limit of 32 tags come from?  I don't see it from a
userspace perspective.
