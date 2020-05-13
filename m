Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210121D111E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbgEMLVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 07:21:01 -0400
Received: from smtp-42aa.mail.infomaniak.ch ([84.16.66.170]:41167 "EHLO
        smtp-42aa.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732597AbgEMLVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 07:21:00 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49MXK92FmnzlhR7q;
        Wed, 13 May 2020 13:20:29 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 49MXK754Mvzlh9Q7;
        Wed, 13 May 2020 13:20:27 +0200 (CEST)
Subject: Re: [PATCH v5 5/6] doc: Add documentation for the
 fs.open_mayexec_enforce sysctl
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
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
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-6-mic@digikod.net> <202005121459.158C3AE75@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <cb487ed9-30a3-635a-04a8-e9038bde87d4@digikod.net>
Date:   Wed, 13 May 2020 13:20:27 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202005121459.158C3AE75@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 13/05/2020 00:00, Kees Cook wrote:
> On Tue, May 05, 2020 at 05:31:55PM +0200, Mickaël Salaün wrote:
>> This sysctl enables to propagate executable permission to userspace
>> thanks to the O_MAYEXEC flag.
>>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Kees Cook <keescook@chromium.org>
> 
> I think this should be folded into the patch that adds the sysctl.

OK, I guess it is fine for the documentation maintainers too?
