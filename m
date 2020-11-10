Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB3F2AD11A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 09:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgKJIRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 03:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbgKJIRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:17:42 -0500
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A16C0613D4
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 00:17:41 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CVghg2QrmzlhSh0;
        Tue, 10 Nov 2020 09:17:39 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CVghd1jfMzlh8Tf;
        Tue, 10 Nov 2020 09:17:37 +0100 (CET)
Subject: Re: [PATCH v23 00/12] Landlock LSM
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20201103182109.1014179-1-mic@digikod.net>
 <alpine.LRH.2.21.2011101745100.9130@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <421e49f4-d3ec-fd17-be42-7c73448b99a1@digikod.net>
Date:   Tue, 10 Nov 2020 09:16:47 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2011101745100.9130@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/11/2020 07:47, James Morris wrote:
> On Tue, 3 Nov 2020, Mickaël Salaün wrote:
> 
>> Hi,
>>
>> Can you please consider to merge this into the tree?
>>
> 
> I've added this to my tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git landlock_lsm
> 
> and merged into next-testing (which is pulled into linux-next).
> 
> 
> Please make any further changes against the branch in my tree.

Great, thanks!
