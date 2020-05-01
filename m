Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3241C177D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgEAOPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728885AbgEAOPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 10:15:12 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7324EC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 07:15:11 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49DDm55ksLzlhP4P;
        Fri,  1 May 2020 16:15:01 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49DDm327wYzlrK12;
        Fri,  1 May 2020 16:14:59 +0200 (CEST)
Subject: Re: [PATCH v3 1/5] fs: Add support for a RESOLVE_MAYEXEC flag on
 openat2(2)
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200428175129.634352-1-mic@digikod.net>
 <20200428175129.634352-2-mic@digikod.net>
 <alpine.LRH.2.21.2005011404420.29679@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <d3555693-d09c-d434-e5a7-33d0c876c783@digikod.net>
Date:   Fri, 1 May 2020 16:14:58 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2005011404420.29679@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 01/05/2020 06:04, James Morris wrote:
> On Tue, 28 Apr 2020, Mickaël Salaün wrote:
> 
>> When the RESOLVE_MAYEXEC flag is passed, openat2(2) may be subject to
>> additional restrictions depending on a security policy managed by the
>> kernel through a sysctl or implemented by an LSM thanks to the
>> inode_permission hook.
> 
> 
> Reviewed-by: James Morris <jamorris@linux.microsoft.com>

As requested, I switched back to O_MAYEXEC yesterday with the v4:
https://lore.kernel.org/lkml/20200430132320.699508-2-mic@digikod.net/
