Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A32225F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 16:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgGPOkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 10:40:23 -0400
Received: from smtp-bc08.mail.infomaniak.ch ([45.157.188.8]:49605 "EHLO
        smtp-bc08.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728639AbgGPOkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:40:23 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B6xkF2jzzzlhmrL;
        Thu, 16 Jul 2020 16:40:21 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4B6xk81XMmzlh8TQ;
        Thu, 16 Jul 2020 16:40:16 +0200 (CEST)
Subject: Re: [PATCH v6 7/7] ima: add policy support for the new file open
 MAY_OPENEXEC flag
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
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
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-8-mic@digikod.net> <202007151339.283D7CD@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <8df69733-0088-3e3c-9c3d-2610414cea2b@digikod.net>
Date:   Thu, 16 Jul 2020 16:40:15 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202007151339.283D7CD@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 15/07/2020 22:40, Kees Cook wrote:
> On Tue, Jul 14, 2020 at 08:16:38PM +0200, Mickaël Salaün wrote:
>> From: Mimi Zohar <zohar@linux.ibm.com>
>>
>> The kernel has no way of differentiating between a file containing data
>> or code being opened by an interpreter.  The proposed O_MAYEXEC
>> openat2(2) flag bridges this gap by defining and enabling the
>> MAY_OPENEXEC flag.
>>
>> This patch adds IMA policy support for the new MAY_OPENEXEC flag.
>>
>> Example:
>> measure func=FILE_CHECK mask=^MAY_OPENEXEC
>> appraise func=FILE_CHECK appraise_type=imasig mask=^MAY_OPENEXEC
>>
>> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Acked-by: Mickaël Salaün <mic@digikod.net>
> 
> (Process nit: if you're sending this on behalf of another author, then
> this should be Signed-off-by rather than Acked-by.)

I'm not a co-author of this patch.
