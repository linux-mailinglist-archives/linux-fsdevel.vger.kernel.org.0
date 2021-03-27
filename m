Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EE734B903
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 19:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhC0S4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 14:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhC0Szo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 14:55:44 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEC3C0613B1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Mar 2021 11:55:40 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F77MW1TjMzMptWs;
        Sat, 27 Mar 2021 19:55:35 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F77MV4KsDzlh8T9;
        Sat, 27 Mar 2021 19:55:34 +0100 (CET)
Subject: Re: [PATCH v5 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     Askar Safin <safinaskar@mail.ru>
References: <1616800362.522029786@f737.i.mail.ru>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Message-ID: <7d9c2a08-89da-14ea-6550-527a3f2c9c9e@digikod.net>
Date:   Sat, 27 Mar 2021 19:56:23 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <1616800362.522029786@f737.i.mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 27/03/2021 00:12, Askar Safin wrote:
> Hi. Unprivileged users already can do chroot. He should simply create userns and then call "chroot" inside. As an LWN commenter noted, you can simply run 
> "unshare -r /usr/sbin/chroot some-dir". (I recommend reading all comments: https://lwn.net/Articles/849125/ .)

We know that userns can be use to get the required capability in a new
namespace, but this patch is to not require to use this namespace, as
explained in the commit message. I already added some comments in the
LWN article though.

> 
> Also: if you need chroot for path resolving only, consider openat2 with RESOLVE_IN_ROOT ( https://lwn.net/Articles/796868/ ).

openat2 was also discussed in previous versions of this patch.
