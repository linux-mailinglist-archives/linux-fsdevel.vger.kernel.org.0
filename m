Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710DC1A4F74
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 12:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDKKvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 06:51:46 -0400
Received: from albireo.enyo.de ([37.24.231.21]:47466 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgDKKvq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 06:51:46 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jNDjf-0005QQ-01; Sat, 11 Apr 2020 10:51:39 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jNDjX-0005Bd-Os; Sat, 11 Apr 2020 12:51:31 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Askar Safin <safinaskar@mail.ru>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: What about adding AT_NO_AUTOMOUNT analogue to openat2?
References: <1586558501.806374941@f476.i.mail.ru>
        <20200411060236.swlgw6ymzikgcqxl@yavin.dot.cyphar.com>
        <20200411064530.GL23230@ZenIV.linux.org.uk>
        <20200411070750.goak63tlej37wkbj@yavin.dot.cyphar.com>
Date:   Sat, 11 Apr 2020 12:51:31 +0200
In-Reply-To: <20200411070750.goak63tlej37wkbj@yavin.dot.cyphar.com> (Aleksa
        Sarai's message of "Sat, 11 Apr 2020 17:07:50 +1000")
Message-ID: <87a73i9txo.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Aleksa Sarai:

> It would just give you -EXDEV (or perhaps -EREMOTE) if you walk into an
> automount (the same logic as with the other RESOLVE_NO_* flags). We
> could make it -ENOENT if you prefer, but that means userspace can't tell
> the difference between it hitting an automount and the target actually
> not existing.

Maybe there's a better way to show the difference to userspace
involving something related to O_PATH?
