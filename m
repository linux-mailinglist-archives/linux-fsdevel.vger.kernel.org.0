Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60D9195965
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgC0O7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 10:59:18 -0400
Received: from smtp-42a8.mail.infomaniak.ch ([84.16.66.168]:34621 "EHLO
        smtp-42a8.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727263AbgC0O7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:59:18 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 48plPH759QzljC1w;
        Fri, 27 Mar 2020 15:59:15 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48plPD42s4zln3X2;
        Fri, 27 Mar 2020 15:59:12 +0100 (CET)
Subject: Re: [PATCH v15 09/10] samples/landlock: Add a sandbox manager example
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20200326202731.693608-1-mic@digikod.net>
 <20200326202731.693608-10-mic@digikod.net>
 <11634607-2fdb-1868-03d0-94096763766f@infradead.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <4285db52-e7ce-6a0f-3791-fd39c892489e@digikod.net>
Date:   Fri, 27 Mar 2020 15:59:00 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <11634607-2fdb-1868-03d0-94096763766f@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 27/03/2020 00:54, Randy Dunlap wrote:
> Hi,
> 
> On 3/26/20 1:27 PM, Mickaël Salaün wrote:
>> diff --git a/samples/Kconfig b/samples/Kconfig
>> index 9d236c346de5..b54408c5bd86 100644
>> --- a/samples/Kconfig
>> +++ b/samples/Kconfig
>> @@ -120,6 +120,13 @@ config SAMPLE_HIDRAW
>>  	bool "hidraw sample"
>>  	depends on HEADERS_INSTALL
>>  
>> +config SAMPLE_LANDLOCK
>> +	bool "Build Landlock sample code"
>> +	select HEADERS_INSTALL
> 
> I think that this should be like all of the other users of HEADERS_INSTALL
> and depend on that instead of select-ing it.

Ok, I though it made sense to select it automatically, but I'll get back
the "depends on".

Thanks.

> 
>> +	help
>> +	  Build a simple Landlock sandbox manager able to launch a process
>> +	  restricted by a user-defined filesystem access-control security policy.
>> +
>>  config SAMPLE_PIDFD
>>  	bool "pidfd sample"
>>  	depends on HEADERS_INSTALL
> 
> thanks.
> 
