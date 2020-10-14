Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9458E28E6B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 20:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389286AbgJNSwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 14:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389276AbgJNSwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:52:17 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CB5C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 11:52:17 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CBM3H4S3vzlhGlF;
        Wed, 14 Oct 2020 20:52:11 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CBM3F37gyzlh8TJ;
        Wed, 14 Oct 2020 20:52:09 +0200 (CEST)
Subject: Re: [PATCH v21 07/12] landlock: Support filesystem access-control
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201008153103.1155388-1-mic@digikod.net>
 <20201008153103.1155388-8-mic@digikod.net>
 <alpine.LRH.2.21.2010150504360.26012@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <77ea263c-4200-eb74-24b2-9a8155aff9b5@digikod.net>
Date:   Wed, 14 Oct 2020 20:52:08 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2010150504360.26012@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 14/10/2020 20:07, James Morris wrote:
> On Thu, 8 Oct 2020, Mickaël Salaün wrote:
> 
>> +config ARCH_EPHEMERAL_STATES
>> +	def_bool n
>> +	help
>> +	  An arch should select this symbol if it does not keep an internal kernel
>> +	  state for kernel objects such as inodes, but instead relies on something
>> +	  else (e.g. the host kernel for an UML kernel).
>> +
> 
> This is used to disable Landlock for UML, correct?

Yes

> I wonder if it could be 
> more specific: "ephemeral states" is a very broad term.
> 
> How about something like ARCH_OWN_INODES ?

Sounds good. We may need add new ones (e.g. for network socket, UID,
etc.) in the future though.
