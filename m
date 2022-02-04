Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038DB4A97B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 11:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbiBDK0T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 4 Feb 2022 05:26:19 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:36420 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBDK0S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:26:18 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3CAE272C905;
        Fri,  4 Feb 2022 13:26:17 +0300 (MSK)
Received: from tower (46-138-221-29.dynamic.spd-mgts.ru [46.138.221.29])
        by imap.altlinux.org (Postfix) with ESMTPSA id 0A8684A46F0;
        Fri,  4 Feb 2022 13:26:17 +0300 (MSK)
Date:   Fri, 4 Feb 2022 13:26:16 +0300
From:   "Anton V. Boyarshinov" <boyarsh@altlinux.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, legion@kernel.org, ldv@altlinux.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add ability to disallow idmapped mounts
Message-ID: <20220204132616.28de9c4a@tower>
In-Reply-To: <20220204094515.6vvxhzcyemvrb2yy@wittgenstein>
References: <20220204065338.251469-1-boyarsh@altlinux.org>
        <20220204094515.6vvxhzcyemvrb2yy@wittgenstein>
Organization: ALT Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-alt-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

В Fri, 4 Feb 2022 10:45:15 +0100
Christian Brauner <brauner@kernel.org> пишет:

> If you want to turn off idmapped mounts you can already do so today via:
> echo 0 > /proc/sys/user/max_user_namespaces

It turns off much more than idmapped mounts only. More fine grained
control seems better for me.

> They can neither
> be created as an unprivileged user nor can they be created inside user
> namespaces.

But actions of fully privileged user can open non-obvious ways to
privilege escalation.
